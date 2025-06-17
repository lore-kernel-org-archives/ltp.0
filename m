Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9C4C71136
	for <ltp@archiver.kernel.org>; Tue, 17 Jun 2025 21:16:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 545353C0FD3
	for <ltp@archiver.kernel.org>; Tue, 17 Jun 2025 23:16:50 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC2E33C0FD3
 for <ltp@lists.linux.it>; Tue, 17 Jun 2025 23:16:31 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 130456006E5
 for <ltp@lists.linux.it>; Tue, 17 Jun 2025 23:16:31 +0200 (CEST)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-acbb85ce788so1070898966b.3
 for <ltp@lists.linux.it>; Tue, 17 Jun 2025 14:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750194990; x=1750799790; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oT4f3XR3LrP+wA7bs+kmEcSWH7p6CrluZN0uYVztHcQ=;
 b=EqAl0HS8g9aosLEP9qcEQjmyLHpS9XLI3WyBgbtFMlqzyIc849Okcey4iv01uxlaIT
 mh4aXdq/Jar1o+HTOK1pqIhnJh3y2qCBxT78TT37VBZi4J9FYd3PDFxVwFfHKcWowtZb
 YWb/+cc4Mr2Pxs+grUv9yRAnZGjGY/z8qN0xv0jy3JjuB+RidgelZs7Ndj8DO/G4VZS7
 Fxeq1mv147ZXmnjCT8aiG+Y5vxv9z6n9QrfDC1kVDo8q69i9VIXOe64sJ9M4SESZxIZ8
 4OrZcKFTQtKgevA0GFSd2f5asF8MdnL/1vleuC466AsSCN6oI2iZglHeFsWZQzY+XAGZ
 qXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750194990; x=1750799790;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oT4f3XR3LrP+wA7bs+kmEcSWH7p6CrluZN0uYVztHcQ=;
 b=mToRdjEArMPDPnj7DiugzlVJj/+s1DFyCKJilaXFZAJmndTMJ4FUsRPiyKyW6hgK8E
 iFTt1PBAzv8jhkJ9ifQ2rW73V+KwlCBpHgoSsXcfN0SN6/ayl8AHPQHusgFwe6xFJV0f
 1G4NBUPQSaihz+/x9sxg+kkAvs0nRCp1FBYq70C/t3VY1uTFupZJZKUi4fGIQX0hGDyL
 feIAIo6NhqG4EA8gCvsxbdEXNfDhcsKl0jHyFoeCyKWc9IIvo5JSpMd/WQT165UxVMKC
 57zPeqWEBZqUlzjX/MXSnObpSEYakloopQETrkG3gs8EnYC63jUwvYFZ5Dcv5zVZqjV2
 Jy9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXX0x6Jk68MZnZlXEJpH2bwjVIsJwLVh4T68kk+Q3c11RsAN95/q+0CgQnrknKnSjoaOJ8=@lists.linux.it
X-Gm-Message-State: AOJu0Yxn7oLYEf03pZvvhSKKRaNuWn+a5t7O2S1nyyIbBe7DLJyKv0I5
 tHxttWm7g+dy/Mp9JvwQIKPk6ZFF06kAaT2T6sXhB28Q8J7jQsM4qI5gj5z72rYI7+40C71lPPq
 F5oky54FjF0sTPCmGPO9IVBSEM9hO9BW/HExb
X-Gm-Gg: ASbGncvOqod3UzL5fjjHK3pcLxhN3A6xWrWCw3lwvWfEuMB4bDDrVoOiyJ4v/uv5n5H
 ElgZc5947vN1g2kJAzzsQBjJDOj3IUp0ny/6hJbERMRDi4+NUVvbZIfoCd2mrz3Ypj8yKbHNTl7
 t5w3z9NbtDWlfvRmDCVW5WPHUQpLqlYDTy/HBqVO4up6Y=
X-Google-Smtp-Source: AGHT+IE6nHoOPQysaeedYDtdOYoK0g+pdHWISMOFMs8a/exYPbMIeRKWCttyWYY3OnXjASp2w63cxraZxmiD7fEK15s=
X-Received: by 2002:a17:907:1c10:b0:aca:c507:a4e8 with SMTP id
 a640c23a62f3a-adfad3c54d2mr1431945966b.21.1750194990255; Tue, 17 Jun 2025
 14:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250617210956.146158-1-amir73il@gmail.com>
In-Reply-To: <20250617210956.146158-1-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 17 Jun 2025 23:16:18 +0200
X-Gm-Features: Ac12FXyTJ_3DeOo24fQH6gjKoW0ZlMtGZTjz-3VkC1fGO0jzKybqXX4QlLqLw4Y
Message-ID: <CAOQ4uxh3BaH_R-29uox_qASshtauYAO1135Jqp7EmJQSLTfJ4w@mail.gmail.com>
To: Jan Kara <jack@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5.15 0/2] fix LTP regression in fanotify22
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
Cc: Sasha Levin <sashal@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 linux-ext4@vger.kernel.org, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

W0NDIHRvIHRoZSBjb3JyZWN0IExUUCBsaXN0IGFkZHJlc3NdCgpPbiBUdWUsIEp1biAxNywgMjAy
NSBhdCAxMToxMOKAr1BNIEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+IHdyb3Rl
Ogo+Cj4gSmFuLAo+Cj4gSSBub3RpY2VkIHRoYXQgZmFub3RpZnkyMiwgdGhlIEZBTl9GU19FUlJP
UiB0ZXN0IGhhcyByZWdyZXNzZWQgaW4gdGhlCj4gNS4xNS55IHN0YWJsZSB0cmVlLgo+Cj4gVGhp
cyBpcyBiZWNhdXNlIGNvbW1pdCBkMzQ3NmYzZGFkNGEgKCJleHQ0OiBkb24ndCBzZXQgU0JfUkRP
TkxZIGFmdGVyCj4gZmlsZXN5c3RlbSBlcnJvcnMiKSB3YXMgYmFja3BvcnRlZCB0byA1LjE1Lnkg
YW5kIHRoZSBsYXRlciBGaXhlcwo+IGNvbW1pdCBjb3VsZCBub3QgYmUgY2xlYW5seSBhcHBsaWVk
IHRvIDUuMTUueSBvdmVyIHRoZSBuZXcgbW91bnQgYXBpCj4gcmUtZmFjdG9yaW5nLgo+Cj4gSSBh
bSBub3Qgc3VyZSBpdCBpcyBjcml0aWNhbCB0byBmaXggdGhpcyByZWdyZXNzaW9uLCBiZWNhdXNl
IGl0IGlzCj4gbW9zdGx5IGEgcmVncmVzc2lvbiBpbiBhIHRlc3QgZmVhdHVyZSwgYnV0IEkgdGhp
bmsgdGhlIGJhY2twb3J0IGlzCj4gcHJldHR5IHNpbXBsZSwgYWx0aG91Z2ggSSBjb3VsZCBiZSBt
aXNzaW5nIHNvbWV0aGluZy4KPgo+IFBsZWFzZSBBQ0sgaWYgeW91IGFncmVlIHRoYXQgdGhpcyBi
YWNrcG9ydCBzaG91bGQgYmUgYXBwbGllZCB0byA1LjE1LnkuCj4KPiBUaGFua3MsCj4gQW1pci4K
Pgo+IEFtaXIgR29sZHN0ZWluICgyKToKPiAgIGV4dDQ6IG1ha2UgJ2Fib3J0JyBtb3VudCBvcHRp
b24gaGFuZGxpbmcgc3RhbmRhcmQKPiAgIGV4dDQ6IGF2b2lkIHJlbW91bnQgZXJyb3JzIHdpdGgg
J2Fib3J0JyBtb3VudCBvcHRpb24KPgo+ICBmcy9leHQ0L2V4dDQuaCAgfCAgMSArCj4gIGZzL2V4
dDQvc3VwZXIuYyB8IDE1ICsrKysrKysrKy0tLS0tLQo+ICAyIGZpbGVzIGNoYW5nZWQsIDEwIGlu
c2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCj4KPiAtLQo+IDIuNDcuMQo+CgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
