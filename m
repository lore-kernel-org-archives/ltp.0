Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D424CD5BD1
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 16:04:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F2EC3E7250
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 18:04:20 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 378193D0E3F
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 18:04:04 +0200 (CEST)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AED571400BE6
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 18:04:03 +0200 (CEST)
Received: by mail-ot1-x341.google.com with SMTP id
 46e09a7af769-7e62b6163c8so2920743a34.2
 for <ltp@lists.linux.it>; Mon, 01 Jun 2026 09:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780329842; x=1780934642; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aZhoU+MvMTKbFgbL22C62vARVU0UQrJFEY3TofPwTj4=;
 b=B6QA5G1EYDeggQ5pXPELVFCrwzZn7+Rm6rhBAx8vaBXBt60R6rutoPDE+GseYyw4lR
 YPrEyQoyvkaKzwVoXyJFHnOPejftWrgRoFha9MdNtEy9729aY64Kzg/Jr/iiDmfQce3M
 q0XQIVaoo5J3p3DqUAIesFuM0CpHmtdsx5IEzJ/+yKVMAvHUuJF+Qt9OyxmJgbhrU/sQ
 wpgz7LeEyj9WDhKHg4HbOsMfoEco786owebJT7bffSvZWx467j2XPsbN4/7AfuWwMKJR
 qopkKS++PdDz+UIJvy9wLJSbGCaQ7RKMowW3XjK2IUxAkKZca8SgnkpgUA2COpk1SGvb
 tAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780329842; x=1780934642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aZhoU+MvMTKbFgbL22C62vARVU0UQrJFEY3TofPwTj4=;
 b=WAEaVnNFgnynw0KLyy4msAM+5hz9HwyXKiTRekfVNTSe0xcw/CwDl4DaXTOC2EVr3S
 Fykh9zMrr2RqqS5VgrDhDC4nGAFoUpH7oJEd8dorLQHhZxlTurHm7GvkoKMkagvPmNh7
 m51be22eg2qLQ/WWnTEZRj8IMYB9nXu9A1oEww3BNzHvxKtuyp8RTTAzyfswlbcjwuHh
 v26fJKSd6dtPEX0e75CglZg8hA5Rg/dmwxlEv7oRVAPryvbM7gPiz0iecKhSKjM5z5vn
 kSRQSUNqGnep5I2d2oP9qIMh38ylVjFTyA875kwBYBIaHXLZdRj8kgh/OD9DtR+XZRuV
 nH5Q==
X-Gm-Message-State: AOJu0YwlaRnEF+AAH9i+hGu5v+cpo7NyCz6VofKji8vsDrNVy6Cd6FJx
 VDdBL6DP6qlLppiiDtkTFNsMHkSlyDp5MjZoUldxw4LnyW+zhi4tlABn
X-Gm-Gg: Acq92OESpYQ/ONkm5e3KJKQBJqIgCrZKqamixsXckliiPdV2RN8Kfio6FKg0CvWlBu2
 6MNZCxhjdNeHEIm/S/Jr0zs+DRMF1VYcr1tBdoiTV9Sz2laAHqyD1zzqQkOpntmI6pkUPbqpb84
 csUztOjdWz29K6K1tTsyW95OyiGS5XjQQjfv/7ZLdapD4j1fbtrVR76K3dqpYhcatDBMtSOm0nQ
 nGV4jcbKRSHXrnVTCf2XMyWi+P6nt2mQK4nbigTLlhpBgoeCivuuponDUrLxjZ/YkWX4ueYZAOc
 ch8G+64qLAp5WUmLWIu8gA/k5DAoHnLL9dn74dI/ePrqLVcC5bNYAqEemski8YW0J64H1avwBI3
 2XmoYOl8wX/Eu/7E2zUWNi1pYZ5CsPTiKm1ngdew4cDI3Bu/OICiezQUyRDUH3cpdOKic07apjf
 TE1uVFbO/UEfz5BkdkC5yIkZkrHOAeAgf3nwczsyn/ahgBYdCjH1lS/V6wSlEdJXpjxdBwd3unF
 AvhvW8XJXAAIPzEpCCx0PNZUcA88uOTkC9jcdHRpYw0y8EmxQ==
X-Received: by 2002:a05:6830:7198:b0:7e3:f225:9658 with SMTP id
 46e09a7af769-7e6a1cb7bf5mr7514836a34.7.1780329842241; 
 Mon, 01 Jun 2026 09:04:02 -0700 (PDT)
Received: from
 runnervm3jyl0.tmrcckyg3riehbbdw0tjeliahb.cx.internal.cloudapp.net
 ([20.161.30.201]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e695d6b1d4sm8057652a34.21.2026.06.01.09.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 09:04:01 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Darren Chang <chihsheng@google.com>
Date: Mon,  1 Jun 2026 16:03:59 +0000
Message-ID: <20260601160400.4003-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601151400.4024541-1-chihsheng@google.com>
References: <20260601151400.4024541-1-chihsheng@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/xattr: Add runtime probe for socket xattr
 backports
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

SGkgRGFycmVuLAoKVGhhbmsgeW91IGZvciB0aGlzIHBhdGNoLiBUaGUgb3ZlcmFsbCBhcHByb2Fj
aCDigJQgdXNpbmcgYSBydW50aW1lIHByb2JlIHRvCmRldGVjdCBiYWNrcG9ydGVkIHNvY2tldCB4
YXR0ciBzdXBwb3J0IHJhdGhlciB0aGFuIHJlbHlpbmcgc29sZWx5IG9uIHRoZQp2ZXJzaW9uIGNo
ZWNrIOKAlCBpcyBjb3JyZWN0IGFuZCB1c2VmdWwgZm9yIEFuZHJvaWQgZG93bnN0cmVhbSBrZXJu
ZWxzLgoKQSBjb3VwbGUgb2YgaXNzdWVzIHRvIGZpeCBiZWZvcmUgbWVyZ2luZzoKCi0tLQoKW0NP
TU1JVCBNRVNTQUdFXQoKPiB3YXMgbWVyZ2VkIGluIHY3LjEuMAoKPiBzdHJpY3RseSBleHBlY3Qg
RVBFUk0gZm9yIHNvY2tldHMgb24ga2VybmVscyA8IDcuMS4wLgoKS2VybmVsIG1haW5saW5lIHJl
bGVhc2VzIGFyZSB0YWdnZWQgYXMgInY3LjEiLCBub3QgInY3LjEuMCIuIFRoZSBzdWJsZXZlbAoi
LjAiIGlzIG5vdCBwYXJ0IG9mIHRoZSByZWxlYXNlIHRhZy4gUGxlYXNlIHJlcGxhY2UgInY3LjEu
MCIg4oaSICJ2Ny4xIiBhbmQKIjcuMS4wIiDihpIgIjcuMSIgdGhyb3VnaG91dCB0aGUgY29tbWl0
IG1lc3NhZ2UuCgotLS0KClt0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZzZXR4YXR0ci9mc2V0
eGF0dHIwMi5jXQoKPiArCQlpZiAoc29ja2V0X2lkeCAhPSAtMSkgewo+ICsJCQlpZiAoZnNldHhh
dHRyKHRjW3NvY2tldF9pZHhdLmZkLCB0Y1tzb2NrZXRfaWR4XS5rZXksCj4gKwkJCQkgICAgICB0
Y1tzb2NrZXRfaWR4XS52YWx1ZSwgdGNbc29ja2V0X2lkeF0uc2l6ZSwKPiArCQkJCSAgICAgIHRj
W3NvY2tldF9pZHhdLmZsYWdzKSA9PSAwKSB7Cj4gKwo+ICsJCQkJdHN0X3JlcyhUSU5GTywgIlNv
Y2tldCB4YXR0ciBzdXBwb3J0IGRldGVjdGVkIChiYWNrcG9ydCkiKTsKCkJsYW5rIGxpbmUgYmV0
d2VlbiB0aGUgb3BlbmluZyBicmFjZSBhbmQgdGhlIGZpcnN0IHN0YXRlbWVudC4gTGludXgga2Vy
bmVsCmNvZGluZyBzdHlsZSBkb2VzIG5vdCBwZXJtaXQgYmxhbmsgbGluZXMgaW1tZWRpYXRlbHkg
YWZ0ZXIgYW4gb3BlbmluZyAneycuClBsZWFzZSByZW1vdmUgdGhlIGJsYW5rIGxpbmUuCgpBbHNv
LCB0aGUgaW5saW5lIGNvZGUgY29tbWVudCAobGluZSBqdXN0IGFkZGVkIGluIHNldHVwKCkpIHJl
YWRzOgoKPiArCSAqIG1lcmdlZCBpbiA3LjEuMCBtYWlubGluZSwgYnV0IG1pZ2h0IGJlIGJhY2tw
b3J0ZWQuCgpTYW1lIHZlcnNpb24gbm90YXRpb24gaXNzdWU6ICI3LjEuMCIg4oaSICI3LjEiLgoK
LS0tCgpbdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zZXR4YXR0ci9zZXR4YXR0cjAyLmNdCgo+
ICsJCWlmIChzZXR4YXR0cihTT0NLLCBYQVRUUl9URVNUX0tFWSwgWEFUVFJfVEVTVF9WQUxVRSwK
PiArCQkJICAgICBYQVRUUl9URVNUX1ZBTFVFX1NJWkUsIFhBVFRSX0NSRUFURSkgPT0gMCkgewo+
ICsKPiArCQkJdHN0X3JlcyhUSU5GTywgIlNvY2tldCB4YXR0ciBzdXBwb3J0IGRldGVjdGVkIChi
YWNrcG9ydCkiKTsKClNhbWUgYmxhbmstbGluZS1hZnRlci1icmFjZSBpc3N1ZSBhcyBpbiBmc2V0
eGF0dHIwMi5jLiBSZW1vdmUgdGhlIGJsYW5rCmxpbmUuCgpBbHNvOgoKPiArCSAqIG1lcmdlZCBp
biA3LjEuMCBtYWlubGluZSwgYnV0IG1pZ2h0IGJlIGJhY2twb3J0ZWQuCgoiNy4xLjAiIOKGkiAi
Ny4xIi4KCi0tLQoKVmVyZGljdDogTmVlZHMgcmV2aXNpb24KClJlZ2FyZHMsCkxUUCBBSSBSZXZp
ZXdlcgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
