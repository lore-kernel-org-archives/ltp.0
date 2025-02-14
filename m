Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 689B6C021A4
	for <ltp@archiver.kernel.org>; Fri, 14 Feb 2025 09:32:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 772843C9AE3
	for <ltp@archiver.kernel.org>; Fri, 14 Feb 2025 10:32:50 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 63DDB3C99CC
 for <ltp@lists.linux.it>; Fri, 14 Feb 2025 10:32:34 +0100 (CET)
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com
 [IPv6:2607:f8b0:4864:20::931])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 805E36216A1
 for <ltp@lists.linux.it>; Fri, 14 Feb 2025 10:32:33 +0100 (CET)
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-86714f41f5bso546559241.3
 for <ltp@lists.linux.it>; Fri, 14 Feb 2025 01:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739525552; x=1740130352; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W/MYUw0dt5nY2CSyWRrpwNTOm8GaZPoGe7XEPX9husA=;
 b=YA6ESzlZTWNiZHuo0mYAkYCW5ay2I7n/mXj02AoI3BnCIjXD/Qmhjdb/a7qHskMmNI
 R6t9KWJHE52k824kErEqGOZ2oiqU43yBEsrjWnByXupFHn/hn9OcQ/6Fue8W8I9LL4rT
 lJhad+EApmenoIMSEhxI6Pqd/dqyod6/foyVuVPlmi+NQAzeJ/aBNCOViQJ+OdRkVGmI
 6u4Wu4SSwu1J31Tge0m6XD7Id5abWEUUJxpWgZpwuO+yi6tmDgAZLWwJsjxGcHlhjwdn
 d4ZSK7L2q1dqRZr9GWFMoEIF+fOD5ihRmO0WYYGE6kN7NOWahSPeKwSaK99EBljzXv2U
 tuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739525552; x=1740130352;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W/MYUw0dt5nY2CSyWRrpwNTOm8GaZPoGe7XEPX9husA=;
 b=i89LGFCbWHVO5gSaIS2MqGN0h4J7ZHZi0oXtjUUGcSAOj1DtUNjlQOQEDLyeAxPoQJ
 Eig4P10vLl5CSQR2ejHojkJ+fBoAkU6bhIABL1E/HJwwbBY2AhSIc7yivJOMjepVgrhW
 ViN5JNkVUIv9R3po4lL+Rjgkd3Ns7TXo3r9HR7FEf8rjHMLK3SmRuBpIoAJ/gr+DkqqD
 qda/UVIP7YPbCJlFuPckpJ1vKcyo0nPPGNtnlQkg7vnRmGbd60J7grYEt48pQJjoWGS8
 q5V+zqqC2w23nvfZZloMz09G67yA580E2GRG/5rW6LEJbFX5P09B6RlOFN5QDRFr+NFJ
 lU3A==
X-Gm-Message-State: AOJu0Yz6Kdnl9q/uX11+X83vRnw81B2k5J9rVggxt0N0X1y7zHluoB2d
 Q3AteaZP5gvHWaOY0V7OC4xOKRg+Jrd8nD1AxNLcw+WL9cKsU/KTLSUjFsJcWd9dyCFAmYSU1E1
 wlGE7kIHG6fquzIwZBxZ9Z/wleUxx+8/EksW+fA==
X-Gm-Gg: ASbGncsG9McGWn7R263gcr45Zh3b6fDalZ04WR/rK5Jc4OQDkV3LNw38Yv5gWW0l9GL
 0qiHcWXSVUqJMXhOZOOa0+kbc23Si0IEpwaKJU9B0REXG+UpLi4TTRh7yECZfMNqqwRXXcGVbNA
 ==
X-Google-Smtp-Source: AGHT+IFkxw7wvPWnxo6eaOEh7gBoNwK0JFLXjfuHZNKZIsJQraE8DEQqhANJZg48jnHtVIxwSDp/BmmPhEf+xmWrEuk=
X-Received: by 2002:a05:6102:4bc1:b0:4bb:d7f0:6e7d with SMTP id
 ada2fe7eead31-4bbf235327fmr9667456137.25.1739525551863; Fri, 14 Feb 2025
 01:32:31 -0800 (PST)
MIME-Version: 1.0
References: <6b486134-632b-42d7-bc01-b8f6905ee7ca.jinguojie.jgj@alibaba-inc.com>
In-Reply-To: <6b486134-632b-42d7-bc01-b8f6905ee7ca.jinguojie.jgj@alibaba-inc.com>
From: Jin Guojie <guojie.jin@gmail.com>
Date: Fri, 14 Feb 2025 17:32:19 +0800
X-Gm-Features: AWEUYZmN3gZ8cBXeCGMz-iLcaMl7yA0j63N6Ii5_qs8Td3okfRkwi8yg86nH7EQ
Message-ID: <CA+B+MYQd1_URO66whTCnVd7Kd7EwNPvBrnE-eQQEvTqTLXGYTg@mail.gmail.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] memcg/memcontrol04: Fix judgment for
 recursive_protection
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
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

V2hlbiByZWN1cnNpdmVfcHJvdGVjdGlvbiBpcyBlbmFibGVkLCBza2lwIHRoZSBjaGVjayBmb3Ig
bG93IGV2ZW50cyBvZiBncm91cCBGLgoKU2lnbmVkLW9mZi1ieTogSmluIEd1b2ppZSA8Z3Vvamll
LmppbkBnbWFpbC5jb20+ClN1Z2dlc3RlZC1ieTogUmljaGFyZCBQYWxldGhvcnBlIDxycGFsZXRo
b3JwZUBzdXNlLmNvbT4KU3VnZ2VzdGVkLWJ5OiBNaWNoYWwgS291dG7DvSA8bWtvdXRueUBzdXNl
LmNvbT4KU3VnZ2VzdGVkLWJ5OiBXZWkgR2FvIDx3ZWdhb0BzdXNlLmNvbT4KU3VnZ2VzdGVkLWJ5
OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KLS0tCiBpbmNsdWRlL3RzdF9jZ3JvdXAuaCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKysKIGxpYi90c3RfY2dyb3VwLmMgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxNCArKysrKysrKysrKysrLQogdGVzdGNh
c2VzL2tlcm5lbC9jb250cm9sbGVycy9tZW1jZy9tZW1jb250cm9sMDQuYyB8ICA2ICsrKysrLQog
MyBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2luY2x1ZGUvdHN0X2Nncm91cC5oIGIvaW5jbHVkZS90c3RfY2dyb3VwLmgKaW5kZXgg
ZDIzYThlNjUyLi4wNjhmZjgzMDYgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvdHN0X2Nncm91cC5oCisr
KyBiL2luY2x1ZGUvdHN0X2Nncm91cC5oCkBAIC0yNTYsNCArMjU2LDYgQEAgaW50IHNhZmVfY2df
b2NjdXJzaW4oY29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50IGxpbmVubywKICAgICAgICAgICAg
ICAgICAgICAgICAgIGNvbnN0IGNoYXIgKmNvbnN0IGZpbGVfbmFtZSwKICAgICAgICAgICAgICAg
ICAgICAgICAgIGNvbnN0IGNoYXIgKmNvbnN0IG5lZWRsZSk7CgoraW50IHRzdF9jZ19tZW1vcnlf
cmVjdXJzaXZlcHJvdChzdHJ1Y3QgdHN0X2NnX2dyb3VwICpjZyk7CisKICNlbmRpZiAvKiBUU1Rf
Q0dST1VQX0ggKi8KZGlmZiAtLWdpdCBhL2xpYi90c3RfY2dyb3VwLmMgYi9saWIvdHN0X2Nncm91
cC5jCmluZGV4IGFhMTNhYzhlYy4uNjFlZTNkYTQ4IDEwMDY0NAotLS0gYS9saWIvdHN0X2Nncm91
cC5jCisrKyBiL2xpYi90c3RfY2dyb3VwLmMKQEAgLTc2LDYgKzc2LDcgQEAgc3RydWN0IGNncm91
cF9yb290IHsKICAgICAgICB1bnNpZ25lZCBpbnQgd2VfbW91bnRlZF9pdDoxOwogICAgICAgIC8q
IGNwdXNldCBpcyBpbiBjb21wYXRhYmlsaXR5IG1vZGUgKi8KICAgICAgICB1bnNpZ25lZCBpbnQg
bm9fY3B1c2V0X3ByZWZpeDoxOworICAgICAgIHVuc2lnbmVkIGludCBtZW1vcnlfcmVjdXJzaXZl
cHJvdDoxOwogfTsKCiAvKiBDb250cm9sbGVyIHN1Yi1zeXN0ZW1zICovCkBAIC01NzUsNyArNTc2
LDggQEAgc3RhdGljIHZvaWQgY2dyb3VwX3Jvb3Rfc2Nhbihjb25zdCBjaGFyICpjb25zdCBtbnRf
dHlwZSwKICAgICAgICBzdHJ1Y3QgY2dyb3VwX2N0cmwgKmN0cmw7CiAgICAgICAgdWludDMyX3Qg
Y3RybF9maWVsZCA9IDA7CiAgICAgICAgaW50IG5vX3ByZWZpeCA9IDA7Ci0gICAgICAgaW50IG5z
ZGVsZWdhdGUgPSAwOworICAgICAgIHVuc2lnbmVkIGludCBuc2RlbGVnYXRlID0gMDsKKyAgICAg
ICB1bnNpZ25lZCBpbnQgbWVtb3J5X3JlY3Vyc2l2ZXByb3QgPSAwOwogICAgICAgIGNoYXIgYnVm
W0JVRlNJWl07CiAgICAgICAgY2hhciAqdG9rOwogICAgICAgIGNvbnN0IGludCBtbnRfZGZkID0g
U0FGRV9PUEVOKG1udF9kaXIsIE9fUEFUSCB8IE9fRElSRUNUT1JZKTsKQEAgLTU5Miw2ICs1OTQs
NyBAQCBzdGF0aWMgdm9pZCBjZ3JvdXBfcm9vdF9zY2FuKGNvbnN0IGNoYXIgKmNvbnN0IG1udF90
eXBlLAogICAgICAgIH0KICAgICAgICBmb3IgKHRvayA9IHN0cnRvayhtbnRfb3B0cywgIiwiKTsg
dG9rOyB0b2sgPSBzdHJ0b2soTlVMTCwgIiwiKSkgewogICAgICAgICAgICAgICAgbnNkZWxlZ2F0
ZSB8PSAhc3RyY21wKCJuc2RlbGVnYXRlIiwgdG9rKTsKKyAgICAgICAgICAgICAgIG1lbW9yeV9y
ZWN1cnNpdmVwcm90IHw9ICFzdHJjbXAoIm1lbW9yeV9yZWN1cnNpdmVwcm90IiwgdG9rKTsKICAg
ICAgICB9CgogICAgICAgIGlmIChyb290LT52ZXIgJiYgY3RybF9maWVsZCA9PSByb290LT5jdHJs
X2ZpZWxkKQpAQCAtNjQ0LDYgKzY0Nyw3IEBAIGJhY2tyZWY6CiAgICAgICAgcm9vdC0+Y3RybF9m
aWVsZCA9IGN0cmxfZmllbGQ7CiAgICAgICAgcm9vdC0+bm9fY3B1c2V0X3ByZWZpeCA9IG5vX3By
ZWZpeDsKICAgICAgICByb290LT5uc2RlbGVnYXRlID0gbnNkZWxlZ2F0ZTsKKyAgICAgICByb290
LT5tZW1vcnlfcmVjdXJzaXZlcHJvdCA9IG1lbW9yeV9yZWN1cnNpdmVwcm90OwoKICAgICAgICBm
b3JfZWFjaF9jdHJsKGN0cmwpIHsKICAgICAgICAgICAgICAgIGlmIChoYXNfY3RybChyb290LT5j
dHJsX2ZpZWxkLCBjdHJsKSkKQEAgLTE1MDksMyArMTUxMywxMSBAQCBpbnQgc2FmZV9jZ19vY2N1
cnNpbihjb25zdCBjaGFyICpjb25zdCBmaWxlLApjb25zdCBpbnQgbGluZW5vLAoKICAgICAgICBy
ZXR1cm4gISFzdHJzdHIoYnVmLCBuZWVkbGUpOwogfQorCitpbnQgdHN0X2NnX21lbW9yeV9yZWN1
cnNpdmVwcm90KHN0cnVjdCB0c3RfY2dfZ3JvdXAgKmNnKQoreworICAgICAgIGlmIChjZyAmJiBj
Zy0+ZGlyc19ieV9jdHJsWzBdLT5kaXJfcm9vdCkKKyAgICAgICAgICAgICAgIHJldHVybiBjZy0+
ZGlyc19ieV9jdHJsWzBdLT5kaXJfcm9vdC0+bWVtb3J5X3JlY3Vyc2l2ZXByb3Q7CisgICAgICAg
cmV0dXJuIDA7Cit9CisKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMv
bWVtY2cvbWVtY29udHJvbDA0LmMKYi90ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xsZXJzL21lbWNn
L21lbWNvbnRyb2wwNC5jCmluZGV4IDFiOGQxMTVmOC4uNzA1YmYyZWJiIDEwMDY0NAotLS0gYS90
ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xsZXJzL21lbWNnL21lbWNvbnRyb2wwNC5jCisrKyBiL3Rl
c3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvbWVtY2cvbWVtY29udHJvbDA0LmMKQEAgLTIxMCw3
ICsyMTAsMTEgQEAgc3RhdGljIHZvaWQgdGVzdF9tZW1jZ19sb3codm9pZCkKICAgICAgICAgICAg
ICAgIGlmIChpIDwgRSkgewogICAgICAgICAgICAgICAgICAgICAgICBUU1RfRVhQX0VYUFIobG93
ID4gMCwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICIoJWMgbG93IGV2ZW50
cz0lbGQpID4gMCIsIGlkLCBsb3cpOwotICAgICAgICAgICAgICAgfSBlbHNlIHsKKyAgICAgICAg
ICAgICAgIH0gZWxzZSBpZiAoaSA9PSBFKSB7CisgICAgICAgICAgICAgICAgICAgICAgIFRTVF9F
WFBfRVhQUihsb3cgPT0gMCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICIo
JWMgbG93IGV2ZW50cz0lbGQpID09IDAiLCBpZCwgbG93KTsKKyAgICAgICAgICAgICAgIH0gZWxz
ZSBpZiAoIXRzdF9jZ19tZW1vcnlfcmVjdXJzaXZlcHJvdChsZWFmX2NnW0ZdKSkgeworICAgICAg
ICAgICAgICAgICAgICAgICAvKiBkb250IG5vdCBjaGVjayBGIHdoZW4gcmVjdXJzaXZlX3Byb3Rl
Y3Rpb24gZW5hYmxlZCAqLwogICAgICAgICAgICAgICAgICAgICAgICBUU1RfRVhQX0VYUFIobG93
ID09IDAsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiKCVjIGxvdyBldmVu
dHM9JWxkKSA9PSAwIiwgaWQsIGxvdyk7CiAgICAgICAgICAgICAgICB9Ci0tCjIuMzQuMQoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
