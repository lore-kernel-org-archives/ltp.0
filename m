Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A72C4167B
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 11:15:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E5CB3CDA86
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 12:15:15 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 127D93CD98B
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 12:15:05 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DE79E1A04334
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 12:14:12 +0100 (CET)
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-da077db5145so4837573276.0
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 03:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701170051; x=1701774851; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MNoZnrsPdKxOqSeO/et/TRWLSf6NZZrzrS2Y0ZvabEI=;
 b=QnNBCd9wMFI00le90oydjlRMD6Jc3SNunzpTC6N0B1X63zhFyqc5tB0S1DRb3V1aqz
 XsyOwW4wA/CUV/2dIhQV9kNPrvcdoCLFaQolXjt7sq1KsjYryz6nIHndiTRaGAx/2e6p
 nwSAOpeOuABi/uBmpDKeGoKsbD8c9P3Ao8NJIsX9uneSHKsZTjAG9kXfOb764yEMLtOb
 CBk6eAmterJKWSoVGsbA6ZUCT0T5Qy4sMpYTBaUwwICr1EhzNOLJ6edNAzRSLCFIhLeU
 A0+wlRmvIN8aX/A275ZI10ss00bB6VVGosZErl/NzFzZtvRCSAc+PQhQXdoI7UcYwdd5
 uojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701170051; x=1701774851;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MNoZnrsPdKxOqSeO/et/TRWLSf6NZZrzrS2Y0ZvabEI=;
 b=wUpthig3R1jkBpX4MWrhERQtvMhAYdTetEQmOJz5vkjUerCCxGLPJmdxbXLYJYYA3C
 2ijR3q42ZafqaoO/kivgebfWJfGft6xMhwXSxun0g5Y80AIK2zYcXoRYf391GFXcRFQ2
 x0odhwAC56+h+oVZMzBNZn9w3i0EYTKZsJB0xZhOq5OOAuxjsC4AIYy+mz2nwEqvuNKg
 L0N/G3dO3pZ59OVFO/kKCveL6kcx4QA1o4ocOR9I9FTC3ibQiI5/dWYLzfaA7C45zz8m
 ZeToGC8BVtR+8R2vlp0khIDGl/hpGbNPQx4C4gGWMOggMQm6vohB2FqfM2WzTnq1q4we
 NJGw==
X-Gm-Message-State: AOJu0YyAhM6414OhXJRw4Y2qTny+qFBoxDXJUcbp5ewgSjVtScJSs7uy
 1RonD12t+A/Mb24xMvMuEHCDMjKR98JRUjlYU3U=
X-Google-Smtp-Source: AGHT+IEcc3iDl0sIyBGYl/Mw9y4SmINp6zQA5bfrdy8+9aQmGIXW9cQmibzNS+tr0YzQoSWCnh5qHX1JkslQyck9J4I=
X-Received: by 2002:a25:db83:0:b0:d9a:d894:7b51 with SMTP id
 g125-20020a25db83000000b00d9ad8947b51mr14022809ybf.57.1701170051632; Tue, 28
 Nov 2023 03:14:11 -0800 (PST)
MIME-Version: 1.0
References: <20231127154013.2625-1-jack@suse.cz>
 <CAOQ4uxhtz2rCn70roeof0Bt8CbAi0vK4CMNiuoFq9M85FUpgGQ@mail.gmail.com>
 <20231127182602.p5tx5hvinsobw3xb@quack3> <20231127220713.GA292630@pevik>
In-Reply-To: <20231127220713.GA292630@pevik>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 28 Nov 2023 13:14:00 +0200
Message-ID: <CAOQ4uxgbHEpLz+pNONOMun5KFUrKnGZX=KbHPkx7LjN3Z4RuRg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify: Fix broken tests due to
 fanotify_events_supported_by_kernel()
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

T24gVHVlLCBOb3YgMjgsIDIwMjMgYXQgMTI6MDfigK9BTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cj4KPiBIaSBKYW4sIEFtaXIsCj4KPiA+IE9uIE1vbiAyNy0xMS0yMyAxOTo0
MDoxNCwgQW1pciBHb2xkc3RlaW4gd3JvdGU6Cj4gPiA+IE9uIE1vbiwgTm92IDI3LCAyMDIzIGF0
IDU6NDDigK9QTSBKYW4gS2FyYSA8amFja0BzdXNlLmN6PiB3cm90ZToKPgo+ID4gPiA+IFdoZW4g
TFRQIHRlc3QgaXMgcnVuIHdpdGggQ1dEIGluIGJ0cmZzIHN1YnZvbHVtZSwgdGVzdHMgbGlrZSBm
YW5vdGlmeTE2Cj4gPiA+ID4gZmFpbCB3aXRoOgo+Cj4gPiA+ID4gZmFub3RpZnkuaDoxNjk6IFRC
Uk9LOiBmYW5vdGlmeV9tYXJrICgzLCBGQU5fTUFSS19BREQsIC4uLiwgQVRfRkRDV0QsICIuIikg
ZmFpbGVkOiBFWERFViAoMTgpCj4KPiA+ID4gPiBUaGlzIGlzIGJlY2F1c2UgZmFub3RpZnlfZXZl
bnRzX3N1cHBvcnRlZF9ieV9rZXJuZWwoKSB0cnkgdG8gcGxhY2UgYQo+ID4gPiA+IG1hcmsgb250
byBDV0QgYW5kIHRoYXQgaXMgZm9yYmlkZGVuIGZvciBidHJmcyBzdWJ2b2x1bWVzLiBDaGFuZ2UK
PiA+ID4gPiBmYW5vdGlmeV9ldmVudHNfc3VwcG9ydGVkX2J5X2tlcm5lbCgpIHRvIHVzZSAiLyIg
aW5zdGVhZCBvZiAiLiIgd2hpY2gKPiA+ID4gPiBoYXMgaGlnaGVyIGNoYW5jZXMgb2Ygd29ya2lu
ZyBmb3IgYnRyZnMuCj4KPgo+ID4gPiBGV0lXLCAiLiIgaW4gc2V0dXAoKSBpcyB1c3VhbGx5IGEg
dGVtcGRpciAodW5kZXIgTFRQIHRlbXAgcm9vdCkKPiA+ID4gU28gSSdtIG5vdCBzdXJlIHRoYXQg
Ii8iIGlzIGEgYmV0dGVyIGNob2ljZSB0aGFuICIuIi4KPiA+ID4gQXQgbGVhc3QgdGhlIExUUCB0
ZW1wIGRpciBpcyBjb25maWd1cmFibGUuCj4gPiA+IGFuZCBubyByZWFzb24gdGhhdCAiLyIgaXMg
bm90IGEgYnRyZnMgc3Vidm9sIGluc2lkZSBhIGNvbnRhaW5lci4uLgo+Cj4gPiBZZWFoLCB0aGF0
J3MgYSBnb29kIHBvaW50LiBJIHdhcyB0aGlua2luZyBpdCBuZWVkIG5vdCBiZSBzbyBzaW1wbGUg
YnV0Cj4gPiB3YW50ZWQgc29tZXRoaW5nIHRvIHN0YXJ0IGEgZGlzY3Vzc2lvbiA6KQo+Cj4gVGhl
IHZhcmlhYmxlIGlzIFRNUERJUiAoYWxsIHZhcmlhYmxlcyBhcmUgcHJpbnRlZCB3aXRoIC1oLCBl
LmcuIC4vZmFub3RpZnkwMSAtaCkuCj4gSSB3YXMgZXhwZWN0aW5nIHRoaXMgd291bGQgYmUgYSBw
cm9ibGVtLCBidXQgaW5zdGVhZCB0aGUgdGVzdCB3YXMgYnJva2VuIG9uCj4gVHVtYmxld2VlZCB3
aXRoIHRoZSBkZWZhdWx0IFRNUERJUiB2YWx1ZSAvdG1wLgo+Cj4gPiA+IEZZSSwgaW4gdGhpcyBi
cmFuY2g6Cj4gPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS9hbWlyNzNpbC9sdHAvY29tbWl0cy9mYW5v
dGlmeV9mc2lkCj4KPiBGWUkgdGhlIGZpcnN0IGNvbW1pdCBicmVha3MgYXQgbGVhc3QgdmZhdCBv
biBmYW5vdGlmeTEzCj4gIyBMVFBfU0lOR0xFX0ZTX1RZUEU9dmZhdCAuL2Zhbm90aWZ5MTMKPiAu
Li4KPiB0c3RfdGVzdC5jOjE2NTA6IFRJTkZPOiA9PT0gVGVzdGluZyBvbiB2ZmF0ID09PQo+IHRz
dF90ZXN0LmM6MTEwNTogVElORk86IEZvcm1hdHRpbmcgL2Rldi9sb29wMSB3aXRoIHZmYXQgb3B0
cz0nJyBleHRyYSBvcHRzPScnCj4gdHN0X3Rlc3QuYzoxMTE5OiBUSU5GTzogTW91bnRpbmcgL2Rl
di9sb29wMSB0byAvdG1wL0xUUF9mYW5NOXdMb20vbW50cG9pbnQgZnN0eXA9dmZhdCBmbGFncz0w
Cj4gZmFub3RpZnkxMy5jOjE1MjogVElORk86IFRlc3QgIzAuMTogRkFOX1JFUE9SVF9GSUQgd2l0
aCBtYXJrIGZsYWc6IEZBTl9NQVJLX0lOT0RFCj4gZmFub3RpZnkxMy5jOjE1NzogVENPTkY6IG92
ZXJsYXlmcyBub3Qgc3VwcG9ydGVkIG9uIHZmYXQKPiBmYW5vdGlmeTEzLmM6MTUyOiBUSU5GTzog
VGVzdCAjMS4xOiBGQU5fUkVQT1JUX0ZJRCB3aXRoIG1hcmsgZmxhZzogRkFOX01BUktfSU5PREUK
PiBmYW5vdGlmeTEzLmM6MTU3OiBUQ09ORjogb3ZlcmxheWZzIG5vdCBzdXBwb3J0ZWQgb24gdmZh
dAo+IGZhbm90aWZ5MTMuYzoxNTI6IFRJTkZPOiBUZXN0ICMyLjE6IEZBTl9SRVBPUlRfRklEIHdp
dGggbWFyayBmbGFnOiBGQU5fTUFSS19NT1VOVAo+IGZhbm90aWZ5MTMuYzoxNTc6IFRDT05GOiBv
dmVybGF5ZnMgbm90IHN1cHBvcnRlZCBvbiB2ZmF0Cj4gZmFub3RpZnkxMy5jOjE1MjogVElORk86
IFRlc3QgIzMuMTogRkFOX1JFUE9SVF9GSUQgd2l0aCBtYXJrIGZsYWc6IEZBTl9NQVJLX01PVU5U
Cj4gZmFub3RpZnkxMy5jOjE1NzogVENPTkY6IG92ZXJsYXlmcyBub3Qgc3VwcG9ydGVkIG9uIHZm
YXQKPiBmYW5vdGlmeTEzLmM6MTUyOiBUSU5GTzogVGVzdCAjNC4xOiBGQU5fUkVQT1JUX0ZJRCB3
aXRoIG1hcmsgZmxhZzogRkFOX01BUktfRklMRVNZU1RFTQo+IGZhbm90aWZ5MTMuYzoxNTc6IFRD
T05GOiBvdmVybGF5ZnMgbm90IHN1cHBvcnRlZCBvbiB2ZmF0Cj4gZmFub3RpZnkxMy5jOjE1Mjog
VElORk86IFRlc3QgIzUuMTogRkFOX1JFUE9SVF9GSUQgd2l0aCBtYXJrIGZsYWc6IEZBTl9NQVJL
X0ZJTEVTWVNURU0KPiBmYW5vdGlmeTEzLmM6MTU3OiBUQ09ORjogb3ZlcmxheWZzIG5vdCBzdXBw
b3J0ZWQgb24gdmZhdAo+IHRzdF9kZXZpY2UuYzo0MDg6IFRJTkZPOiB1bW91bnQoJ21udHBvaW50
JykgZmFpbGVkIHdpdGggRUJVU1ksIHRyeSAgMS4uLgo+IHRzdF9kZXZpY2UuYzo0MTI6IFRJTkZP
OiBMaWtlbHkgZ3Zmc2QtdHJhc2ggaXMgcHJvYmluZyBuZXdseSBtb3VudGVkIGZzLCBraWxsIGl0
IHRvIHNwZWVkIHVwIHRlc3RzLgo+IHRzdF9kZXZpY2UuYzo0MDg6IFRJTkZPOiB1bW91bnQoJ21u
dHBvaW50JykgZmFpbGVkIHdpdGggRUJVU1ksIHRyeSAgMi4uLgo+IHRzdF9kZXZpY2UuYzo0MDg6
IFRJTkZPOiB1bW91bnQoJ21udHBvaW50JykgZmFpbGVkIHdpdGggRUJVU1ksIHRyeSAgMy4uLgo+
IC4uLgo+IHRzdF9kZXZpY2UuYzo0MDg6IFRJTkZPOiB1bW91bnQoJ21udHBvaW50JykgZmFpbGVk
IHdpdGggRUJVU1ksIHRyeSA1MC4uLgo+IHRzdF9kZXZpY2UuYzo0MTk6IFRXQVJOOiBGYWlsZWQg
dG8gdW1vdW50KCdtbnRwb2ludCcpIGFmdGVyIDUwIHJldHJpZXMKPiB0c3RfdGVzdC5jOjE2NTA6
IFRJTkZPOiA9PT0gVGVzdGluZyBvbiBleGZhdCA9PT0KPiB0c3RfdGVzdC5jOjExMDU6IFRJTkZP
OiBGb3JtYXR0aW5nIC9kZXYvbG9vcDEgd2l0aCBleGZhdCBvcHRzPScnIGV4dHJhIG9wdHM9JycK
PiB0c3RfdGVzdC5jOjExMTk6IFRJTkZPOiBNb3VudGluZyAvZGV2L2xvb3AxIHRvIC90bXAvTFRQ
X2Zhbk05d0xvbS9tbnRwb2ludCBmc3R5cD1leGZhdCBmbGFncz0wCj4gdHN0X3Rlc3QuYzoxMTE5
OiBUSU5GTzogVHJ5aW5nIEZVU0UuLi4KPiBGVVNFIGV4ZmF0IDEuNC4wIChsaWJmdXNlMikKPiBm
dXNlOiBtb3VudCBmYWlsZWQ6IERldmljZSBvciByZXNvdXJjZSBidXN5Cj4gdHN0X3Rlc3QuYzox
MTE5OiBUQlJPSzogbW91bnQuZXhmYXQgZmFpbGVkIHdpdGggMjU2Cj4KCkkgYmVsaWV2ZSB0aGlz
IGJyZWFrYWdlIGlzIGEgcmVncmVzc2lvbiBkdWUgdG8gb3ZlcmxheWZzIGJ1ZyBpbiB2Ni43LXJj
MQp0aGF0IHdhcyBmaXhlZCBieSBjb21taXQKMzdmMzJmNTI2NDM4ICgib3ZsOiBmaXggbWVtb3J5
IGxlYWsgaW4gb3ZsX3BhcnNlX3BhcmFtKCkiKSBpbiB2Ni43LXJjMi4KClRoYW5rcywKQW1pci4K
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
