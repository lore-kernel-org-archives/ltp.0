Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C65C28B30
	for <ltp@archiver.kernel.org>; Thu, 20 Mar 2025 17:42:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B9ED3CAE62
	for <ltp@archiver.kernel.org>; Thu, 20 Mar 2025 18:42:50 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC17F3CAE41
 for <ltp@lists.linux.it>; Thu, 20 Mar 2025 18:42:33 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2A2B71A008BC
 for <ltp@lists.linux.it>; Thu, 20 Mar 2025 18:42:33 +0100 (CET)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5e61375c108so1469438a12.1
 for <ltp@lists.linux.it>; Thu, 20 Mar 2025 10:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742492552; x=1743097352; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eOJeL89yggNKuDyfxdqtDlWbPMC7c0fc3bJCMTQ/BB8=;
 b=T4A3CyHgZOZpN1FeVYJVbEtFOKmpHRBXmCBfBYh+kv7eup/uqN67Zp4I4TzTSSvUNd
 FjjkzbLPmpyhovOk42yiC8+P+d4b5ocRAI8DenLr6p+zcxfBglDzlWGO+zyexSvk2Wjm
 um5pB01DA98pi0Lb6h5lbHwzZM87SXbjcxb0Rer/Xel54kSC2gzOb+VvoR+dwl02eeLq
 +mvuq2D6hkAG6WUVX7ixKXhUiirv4cxfXeojZ1S6AgkaO8T5ehN7bUnQCKlrDbizKvVG
 i3iaqLfC+ZcWewKk6F5CdBKaCygxyyT8TnGQne8nTsi7GCnyDSHa5Zp4cBMgN996ZX+S
 PJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742492552; x=1743097352;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eOJeL89yggNKuDyfxdqtDlWbPMC7c0fc3bJCMTQ/BB8=;
 b=WOxFmIHQxbmj4gVrJQ3tRbyuZa4pViAFwzldZ/QABvaFU4dq59xUYEo+t3d8EPRPN6
 Nr0d/4qW8w5mO1CKsYTfCNFwbakrjrsX2vJwfdynT1mdPaw6PDMNdvjWMWmyTCsGFa3h
 Nq2KzN+9EMt8mGTyg67Pb13Qy57GttqDmUJAwgDW0VdtJIXdLLGxbZfPD7rpi+uns3/5
 C27dYhao9RN7al1M6VAb7Ww8JqDV+2DGrHYV1yyfVJRxskdVZ+TByFn9EAQynFvauBVo
 2YnAtcS4NOYJoOxIk18w8UKnFxUq82pfrlzdV2iUdZh+gHZySvFUL5DOlkeK+9UwK+gE
 yZgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8xqxboUU2ucb2b/o6cEFOGklqHkIKiP4ATQLz9D37LpUKeaX3xqL9d1d9VHAkqnWB/BM=@lists.linux.it
X-Gm-Message-State: AOJu0Yz4vCN6sdH/k2esn6a6MOiKIdXrUqXSLR3Snax3MxCBzMWj+z4L
 wKGwo3NNrMtNGLerRzlrajEGkLCGIEUh5pM//Fy2tgQ5zXSBpz9I781LmOUROKt2QkJ/QnYm5in
 UNxj8fQ1p7h45+6gCf5/b5MHHG71OowgcvVs=
X-Gm-Gg: ASbGnctFYKwhIDMk9yZC4dUql1fVWpVt5YVX4YlgUelz6ZCcigbwP2wNvILoThbx2Rw
 kNW3yW0AiP3frydT4oveccQA6rMYzO4cenzUIDycjIbzBgUF/ab5Qm8YTocgQdOMEZ563/EU2xO
 1+fu8pNeAnaBRBi1r9lldW7ulWzQHacVQ6/Nwm
X-Google-Smtp-Source: AGHT+IHvNI9IU8BpgFmfzPATqrOCEHeY0Uiv2Q4W1G2gcIQ/KDBwO49Aw8DYOAsxm6ZeOQPYZCR9Xx3CgeXQL0mIL1Q=
X-Received: by 2002:a05:6402:2753:b0:5e6:ddab:736c with SMTP id
 4fb4d7f45d1cf-5ebcd467f5fmr193539a12.17.1742492552126; Thu, 20 Mar 2025
 10:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250319192742.999506-1-amir73il@gmail.com>
 <20250319192742.999506-4-amir73il@gmail.com>
 <20250320170039.GA113087@pevik>
In-Reply-To: <20250320170039.GA113087@pevik>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 20 Mar 2025 18:42:20 +0100
X-Gm-Features: AQ5f1JqnR6bpIT5LOm6PfoVIhrcsGz61IvEDuECA41dwzcsAp9fCgVvrFMHBBXY
Message-ID: <CAOQ4uxj2SJyo4CLF4YeK=aiAL2H+oTXzbnYCzGyF8K1Ns74HOA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] fanotify24: add mmap() and user page fault to
 test
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBNYXIgMjAsIDIwMjUgYXQgNjowMOKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIEFtaXIsCj4KPiA+IENvbW1pdCAwNjZlMDUzZmUyMDhhICgiZnNu
b3RpZnk6IGFkZCBwcmUtY29udGVudCBob29rcyBvbiBtbWFwKCkiKQo+ID4gaW4gNi4xNC1yYzcg
YWRkZWQgYSBwcmUtY29udGVudCBob29oIGluIG1tYXAoKSBiZWZvcmUgdGhlIGZpbmFsIHJlbGVh
c2UKPiA+IG9mIHRoZSBmc25vdGlmeSBwcmUtY29udGVudCBldmVudCBmZWF0dXJlLgo+Cj4gPiBU
byB0ZXN0IHByZS1jb250ZW50IGhvb2sgb24gbW1hcCgpLCBpbmNyZWFzZSB0aGUgc2l6ZSBvZiB0
aGUgdGVzdCBmaWxlCj4gPiB0byAxMDEgcGFnZXMgdXNlIG1tYXAoKSB0byBzZXR1cCBhIGJ1ZmZl
ciBmcm9tIHRoZSBlbmQgb2YgdGhlIHRlc3QgZmlsZS4KPgo+ID4gQ2hhbmdlIHNvbWUgb2YgdGhl
IHRlc3QgY2FzZXMgdG8gYWxsb3cgdGhlIHdyaXRlKCkgYW5kIHVzZSB0aGlzIGJ1ZmZlcgo+ID4g
YXMgdGhlIGlucHV0IGJ1ZmZlciB0byB3cml0ZSgpLCB3aGljaCB0ZXN0cyBkZWFkbG9jayBhdm9p
ZGFuY2UgYnkKPiA+IHN1cHByZXNpbmcgcHJlLWNvbnRlbnQgaG9vayBvbiB1c2VyIHBhZ2UgZmF1
bHRzLgo+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwu
Y29tPgo+ID4gLS0tCj4gPiAgLi4uL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTI0
LmMgICAgIHwgNDEgKysrKysrKysrKysrKysrKy0tLQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzNSBp
bnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQo+Cj4gPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTI0LmMgYi90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MjQuYwo+ID4gaW5kZXggMmQyNDc5YjM5Li4zYTc2
ZjJjMWIgMTAwNjQ0Cj4gPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5
L2Zhbm90aWZ5MjQuYwo+ID4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlm
eS9mYW5vdGlmeTI0LmMKPiA+IEBAIC00Niw2ICs0Niw3IEBACj4gPiAgc3RhdGljIGNoYXIgZm5h
bWVbQlVGX1NJWkVdOwo+ID4gIHN0YXRpYyBjaGFyIGJ1ZltCVUZfU0laRV07Cj4gPiAgc3RhdGlj
IHZvbGF0aWxlIGludCBmZF9ub3RpZnk7Cj4gPiArc3RhdGljIHNpemVfdCBwYWdlX3N6Owo+Cj4g
PiAgc3RhdGljIHBpZF90IGNoaWxkX3BpZDsKPgo+ID4gQEAgLTY4LDcgKzY5LDggQEAgc3RhdGlj
IHN0cnVjdCB0Y2FzZSB7Cj4gPiAgICAgICAgICAgICAgIEZBTl9PUEVOX1BFUk0gfCBGQU5fUFJF
X0FDQ0VTUywKPiA+ICAgICAgICAgICAgICAgewo+ID4gICAgICAgICAgICAgICAgICAgICAgIHtG
QU5fT1BFTl9QRVJNLCBGQU5fQUxMT1d9LAo+ID4gLSAgICAgICAgICAgICAgICAgICAgIHtGQU5f
UFJFX0FDQ0VTUywgRkFOX0RFTll9LAo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHtGQU5fUFJF
X0FDQ0VTUywgRkFOX0FMTE9XfSwKPiA+ICsgICAgICAgICAgICAgICAgICAgICB7RkFOX1BSRV9B
Q0NFU1MsIEZBTl9BTExPV30sCj4KPiBJZiBJIHVuZGVyc3RhbmQgY29ycmVjdGx5LCB0aGVzZSBk
b3VibGVkIEZBTl9QUkVfQUNDRVNTLCBGQU5fQUxMT1cgYXJlIGZvcgo+IHJldXNpbmcgdGhlIHdy
aXRlIGJ1ZmZlciwgcmlnaHQ/IE9idmlvdXNseSBpdCdzIG5lZWRlZCBidXQgb24gdGhlIGZpcnN0
IGxvb2sgaXQKPiBsb29rcyBsaWtlIGVycm9yLgoKU29ycnksIHRoaXMgd2Fzbid0IHByb3Blcmx5
IGV4cGxhaW5lZC4KClRoaXMgY2hhbmdlIGFkZHMgYSB0ZXN0IGZvciBwcmUtbW1hcCBldmVudHMu
CgpGaXJzdCBvZiBhbGwsIHdlIGFkZGVkIGFuIG1tYXAoKSBjYWxsIGJlZm9yZSB0aGUgd3JpdGUo
KSwKc28gd2UgbmVlZCB0byBhZGQgYW5vdGhlciBleHBlY3RlZCBGQU5fUFJFX0FDQ0VTUwpmb3Ig
dGhlIG1tYXAoKSBhbmQgd2UgYWxsb3cgdGhlIG1tYXAgZm9yIGFsbCB0ZXN0IGNhc2VzLgoKU2Vj
b25kbHksIHdlIENoYW5nZSBzb21lIG9mIHRoZSB0ZXN0IGNhc2VzIHRvIGFsbG93IHRoZSB3cml0
ZSgpCmFuZCB1c2UgdGhlIG1tYXBlZCBidWZmZXIgYXMgdGhlIGlucHV0IGJ1ZmZlci4KClRoZSBy
ZWFzb24gdGhhdCB3ZSBhbGxvdyB0aGUgd3JpdGUoKSBpcyB0byB2ZXJpZnkgdGhhdCB3ZSBkbyBu
b3QKZ2V0IGFub3RoZXIgRkFOX1BSRV9BQ0NFU1MgZXZlbnQgZnJvbSByZWFkaW5nIGZyb20gdGhl
Cm1tYXBlZCBpbnB1dCBidWZmZXIuCgpUaGFua3MsCkFtaXIuCgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
