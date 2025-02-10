Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 565A8C02198
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 17:06:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A1B63C98C1
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 18:06:53 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E32423C98BB
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 18:06:36 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 15BBB6002C4
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 18:06:36 +0100 (CET)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5de4c7720bcso5160164a12.0
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 09:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739207195; x=1739811995; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J9981izAoPWs+fFuah7g1qzzz0Gz6CzYyfbhSHd4+mc=;
 b=j1Kkxah8WxvHoZxZ1gszzopJmB2T+iKZbya+rq27sJD3EUxiyxmpA43v/zrDPrrm+e
 GIsz8aEXmZfnSOEA2i1HDJcUlJuXDQ1m98xtEQQW0jy3Q6ADXhyJCg0+EYan60EGA4k6
 7/FgklPXSekEPCbKxNPOklLe5SdcpFVkZSSJDRWz5krhT+8Y/hFtPhV1DsY5r94Ey52S
 k6NiXhmkvu9W2NcvB5BjBtM/wRUnvd0YkhBtlAKS9FEQqHd8CJGJLu2DvNPFMlmIUIGZ
 jdSDzQSnkI1nX4GgBHHfOoigT2CIqJ2YFQUrvkqFxQRYzoNIKkrAQ/DjZIBMTv/3pVsh
 4GdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739207195; x=1739811995;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J9981izAoPWs+fFuah7g1qzzz0Gz6CzYyfbhSHd4+mc=;
 b=b6Hr/PUIBftJDi3gGzrN+LriLZF9AmPJvehd34ASHI8QFp0J0ETNVhcy9JTmglqa/Y
 XyGFxkUIvDhgSFET3P5sxTzjHstiLMq80zAfgFe8xKBoWObbyc8ykHUcuOB6hsSkU/YB
 6Y7bx7UtydrQsr/cjmMGnbyEpK4bY7wpHtydUnaiXCvqF+TkrvyVHXlGqkYB+Wm+/wgx
 xxtKm0V70fhYcWxzPtg58KiWWmgCPbLiL7kHC87Ff6utmKqmNBrZ1xezR2BktxLWX5+V
 UH7UU019XRL7rmllFkcswDs7lTZSidQDGR56Z1GMPp/A7HGUnx3K+ZpGskOZP4nsiRhj
 To3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGIK7DrMft4Vn2B37RvWVvXvjq2wS5Bqzk6pXreMGbnievcPh3nTVi4ADcWfDUdW3RjLI=@lists.linux.it
X-Gm-Message-State: AOJu0YzesXvAkKRccTEtjWNdbGfyg7F6xingrmZN0kXQUYU1fHwKwT2B
 onie2C0CmXnu79/qBQnbzwAfT5po/FD0fy67GuRoPCGJYbQjR79Whl/ybOzkbzucBauEWFs6GN3
 jwsIyTvSw8pdWOO2tIr8fgrTrmuAyhMD9eik=
X-Gm-Gg: ASbGncs+NUr120xcFeM8mQ6yyEQbARGZ+gzMKB3grUAwb4mLyD2tKKS+quVtEGi+eKq
 /W+tQYRPjkos6mXRD7mwjZB8tOMWGNKiT804CJXWm4JPtZ80Whx8DrHKXrd46Bz+J3REtF+ep
X-Google-Smtp-Source: AGHT+IEChwcZhKwCuM65RGeP5BHN5y9Qi3TTkJqsCH9UBNGN/KuqoR4lOeA+iwwmV60f3ioB9FjAUYW/lB1lfdF1ncw=
X-Received: by 2002:a05:6402:321d:b0:5dc:1ec6:12bc with SMTP id
 4fb4d7f45d1cf-5de45087800mr17817121a12.28.1739207194870; Mon, 10 Feb 2025
 09:06:34 -0800 (PST)
MIME-Version: 1.0
References: <20250210151316.246079-1-amir73il@gmail.com>
 <20250210151316.246079-4-amir73il@gmail.com>
 <yvpm5aiigldl2ftkatepoddjitxs64r6n2igcatetyukpbp3re@35yc3muudqdf>
In-Reply-To: <yvpm5aiigldl2ftkatepoddjitxs64r6n2igcatetyukpbp3re@35yc3muudqdf>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 10 Feb 2025 18:06:23 +0100
X-Gm-Features: AWEUYZlwKQlF9VYaxqFiRIkvBpyc3UK7a8AxLRMpxqImd_6P2YHFGXTN2S53VUg
Message-ID: <CAOQ4uxhex0Dz+c-DM9emgqhsYMar08NC4JSuc9TkiDujmN7h6A@mail.gmail.com>
To: Jan Kara <jack@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/4] fanotify24: Add test for FAN_PRE_ACCESS and
 FAN_DENY_ERRNO
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBGZWIgMTAsIDIwMjUgYXQgNDo0M+KAr1BNIEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+
IHdyb3RlOgo+Cj4gT24gTW9uIDEwLTAyLTI1IDE2OjEzOjE1LCBBbWlyIEdvbGRzdGVpbiB3cm90
ZToKPiA+IEZvcmsgdGhlIHRlc3QgZmFub3RpZnkyNCBmcm9tIHRlc3QgZmFub3RpZnkwMywgcmVw
bGFjaW5nIHRoZQo+ID4gcGVybWlzc2lvbiBldmVudCBGQU5fQUNDRVNTX1BFUk0gd2l0aCB0aGUg
bmV3IHByZS1jb250ZW50IGV2ZW50Cj4gPiBGQU5fUFJFX0FDQ0VTUy4KPiA+Cj4gPiBUaGUgdGVz
dCBpcyBjaGFuZ2VkIHRvIHVzZSBjbGFzcyBGQU5fQ0xBU1NfUFJFX0NPTlRFTlQsIHdoaWNoIGlz
Cj4gPiByZXF1aXJlZCBmb3IgRkFOX1BSRV9BQ0NFU1MgYW5kIHRoaXMgY2xhc3MgYWxzbyBlbmFi
bGVkIHRoZSByZXNwb25zZQo+ID4gd2l0aCBjdXRvbWVyIGVycm9yIGNvZGUgRkFOX0RFTllfRVJS
Tk8uCj4gPgo+ID4gVW5saWtlIEZBTl9BQ0NFU1NfUEVSTSwgRkFOX1BSRV9BQ0NFU1MgaXMgYWxz
byBjcmVhdGVkIG9uIHdyaXRlKCkKPiA+IHN5c3RlbSBjYWxsLiAgVGhlIHRlc3QgY2FzZSBleHBl
Y3RlZCByZXN1bHRzIGFyZSBhZGp1c3RlZCB0bwo+ID4gcmVzcG9uZCB3aXRoIHRoZSBkZWZhdWx0
IGVycm9yIChFUEVSTSkgdG8gb3BlbigpIGFuZCB3cml0ZSgpIGFuZAo+ID4gdG8gcmVzcG9uZCB3
aXRoIGN1c3RvbSBlcnJvcnMgKEVJTywgRUJVU1kpIHRvIHJlYWQoKSBhbmQgZXhlY3ZlKCkuCj4g
Pgo+ID4gTm90IGFsbCBmcyBzdXBwb3J0IHByZS1jb250ZW50IGV2ZW50cywgc28gcnVuIG9uIGFs
bCBmaWxlc3lzdGVtcwo+ID4gdG8gZXhjZXJjaXNlIEZBTl9QUkVfQUNDRVNTIG9uIGFsbCBzdXBw
b3J0ZWQgZmlsZXN5c3RlbXMuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogQW1pciBHb2xkc3RlaW4g
PGFtaXI3M2lsQGdtYWlsLmNvbT4KPgo+IExvb2tzIGdvb2QgdG8gbWUuIEkgd2FzIGp1c3Qgd29u
ZGVyaW5nIHdoZXRoZXIgc29tZSBiaXRzIGxpa2UKPiBnZW5lcmF0ZV9ldmVudHMoKSwgbWFyayBz
ZXR1cCwgY2hpbGQgc2V0dXAsIG1haW4gdGVzdCBsb29wIGNvdWxkIG5vdCBiZQo+IGZhY3RvcmVk
IG91dCBpbnRvIGEgaGVscGVyIGZ1bmN0aW9ucyB1c2VkIGJ5IGJvdGggb2xkIGFuZCBuZXcgdGVz
dHM/CgpZZXMsIEkgYWdyZWUgdGhhdCBmb3JraW5nIHRoZSB0ZXN0cyBpcyBiYWQgYW5kIHRoYXQg
d2UgbmVlZCBtdWNoCm1vcmUgY29tbW9uIGhlbHBlcnMuCgpJSVVDLCBMVFAgZGV2ZWxvcGVycyBh
cmUgZ29pbmcgdG8gdHJ5IHRvIGNvbWUgdXAgd2l0aCBzb21lIHByb3Bvc2Fscwpmb3IgcmVmYWN0
b3JpbmcgaGVscGVycyB0byBzcGxpdCBzb21lIGxhcmdlIGZhbm90aWZ5IHRlc3RzIFsxXVsyXS4K
Ck15IG9waW5pb24gaXMgdGhhdCBmYWN0b3Jpbmcgb3V0IGhlbHBlcnMgdGhhdCBhcmUgdXNlZnVs
IG9ubHkgZm9yCmZhbm90aWZ5MDMsZmFub3RpZnkyNCBpcyBzdWJvcHRpbWFsIGFuZCB3ZSBuZWVk
IHRvIHNlZSBpZiB3ZSBjYW4KY3JlYXRlIG11Y2ggbW9yZSBnZW5lcmljIGhlbHBlcnMgdGhhdCBj
b3VsZCBiZSBzaGFyZWQgYnkgbW9yZSB0ZXN0cy4KCkJUVywgaWYgeW91IGxvb2sgY2xvc2VyLCB5
b3Ugd2lsbCBzZWUgdGhhdCBnZW5lcmF0ZV9ldmVudHMoKSBpcyBxdWl0ZQpkaWZmZXJlbnQgYmV0
d2VlbiBmYW5vdGlmeTAzIGFuZCBmYW5vdGlmeTI0LCBhbHRob3VnaCBpdCBpcyB0cnVlIHRoYXQK
ZmFub3RpZnkyNCBoYXMgYSBtb3JlIGdlbmVyYWxpemVkIHZlcnNpb24gdGhhdCBmb2xsb3dzIHRo
ZSBleHBlY3RlZApldmVudHMgbW9yZSBjbG9zZWx5LgoKSSBkaWQgc3RhcnQgd2l0aCBleHRlbmRp
bmcgZmFub3RpZnkwMyBiZWZvcmUgSSBmb3JrZWQgaXQgYW5kIGJlZm9yZSB0aGUKZm9yayBnZW5l
cmF0ZV9ldmVudHMoKSB3YXMgZXZlbiBtb3JlIGhhcmQgdG8gZm9sbG93IGJlY2F1c2Ugb2YKdGhl
IGRpZmZlcmVuY2UgaW4gZXhwZWN0ZWQgZXZlbnRzIGZvciB3cml0ZSgpIGJldHdlZW4gcGVybWlz
c2lvbgphbmQgcHJlLWNvbnRlbnQgZXZlbnRzLgoKVGhhbmtzLApBbWlyLgoKWzFdIGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2x0cC83MWQ0NDE0Yi04MDJmLTQwMTktODUyNy1lODg4NmUyZDFhZWJA
c3VzZS5jei8KWzJdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2x0cC8yMDI1MDEzMTE2NDIxNy5H
QTExMzU2OTRAcGV2aWsvCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
