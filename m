Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C165EC8303D
	for <ltp@archiver.kernel.org>; Fri,  4 Jul 2025 20:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751659810; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=BxeNeVSyTz/nslAQdTpsLRpS0xC/ckqfOjUX3axMF7A=;
 b=WZiM6OQhWDJ+sSN73E4TCSwbLKkkKvhx7jEsQqh5ZDomTkNnLzW2O9VuETJG4j7nGxe6l
 y2xTbVMwN3MriKMMNDQ74MvCX2NeU/P9yxJp6mjTEgXs3A4BPRhOK+bGDRnV8NiUpRIt0Ht
 bbqmlJ0dqyqtAuuet+d2P5DR0aEvjXk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA1C03C924D
	for <ltp@archiver.kernel.org>; Fri,  4 Jul 2025 22:10:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A01233C7564
 for <ltp@lists.linux.it>; Fri,  4 Jul 2025 22:09:50 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D404F20034F
 for <ltp@lists.linux.it>; Fri,  4 Jul 2025 22:09:48 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a582e09144so717820f8f.1
 for <ltp@lists.linux.it>; Fri, 04 Jul 2025 13:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751659787; x=1752264587; darn=lists.linux.it;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=My3WEgFCCtNH9QApzAkxLQQYPBX667aothNl4HnRrtE=;
 b=QDP6HLKtvONGnf2N6Mv0yQDnxTEi0Qx/qXRPE+W5Eyot0QjF1FdL7Lg07zFnCjEptL
 AkCr2egZ8xjn/xjzP2LD8mPYsUj7Scbg6Jrh7lccGADDm/3spcwuOggyQiBznX8wjxpt
 v4eeON/oTkuWsNt4kP/7GYHY9/Oqj1NknsmpmivtSHs2Ac6xIF5rDmU5sXqZHzuKDIx8
 xLkEQgaZbk8/k+PlB4/PECXKahiu6trRFux7r7Hr9aOrPcOyykuiJ2iIaxVC1UqX4iwL
 oNYHfpuukhc4RUG/N7eQ7GDuCcdd5J0t+1qv1zv8FQfMtxBFopxpKBZSW2ozpGqnNuk2
 4AlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751659787; x=1752264587;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=My3WEgFCCtNH9QApzAkxLQQYPBX667aothNl4HnRrtE=;
 b=FtiIPvrGUllpue+WzL15yNos1PIpgHGRYrDuaqQ//GoGUDfSGU8IQZmYzFg0sBhhG8
 MbvDUlUimWmySBNYcZu2f62N8vR+3o338ccJls19iHez7KCjJ2yYgoV9C1gdPaNMgwYp
 TQ4SQwZm5OAJTWG3gW0Pnw3YGnwzv6uJwqA6zNdr3dBfiIVQpx6MWG91DpEu365Ka0jY
 pb4ULxVSBI5DIXpZenTPy/Sl1wzOkZLnWtM7jK/ncY6J5zD190kayyL49WF4vtndR8hI
 3nJ5zrpfxmUGT2DK+Sqv0WihfM2ZCIvrdjvZ4Jv9TYf0/Xlcue316g9ItFZ19T5E6xKA
 ti9A==
X-Gm-Message-State: AOJu0YzGLoojxKD7dqBRNv1EpPvOcQz5IAD1J1gs4oHQbVLHr6ePvSuZ
 5ApmJfPp2ZXtPSELE0cWhXv8cREHs86vZTBxjsYPfYtCdRNfNjBk6v8+NDpHA4esWT+5Zq1Y/CN
 8hQRS
X-Gm-Gg: ASbGnctw+IIRKD4GKwt/lBI/iGMnbcvheFqGCGv7dxTEgobIxY6j6vQ/YoumXWxEh9d
 5+Z9Q0HPFJOI1mvEcH/OBrKyEqjY0u6xRu+24W0ncBe/INe2ZhABFLHU8x9+kWk00ZmkxuMOBo3
 dQde8Zj0wZOZLDy8MyQkQ8apNAy9KeVk9MSV4zEy1RaThe9R4QYiAtlgUMmJZuf10QIcda4tgYc
 mTt3jRJuzGyXEgbZi50bUzoDOeqbYnvoQEEkm2gbzN9xLgWW6iondCMXSkA0fudA355l/ZbTl/W
 Fip7gK2pmSQ/o0V/RM7F5kkeNht7O7HgWndQi0AGhQKN+WK9nA==
X-Google-Smtp-Source: AGHT+IFPV8NnrkdIr6IO1KjqhvozPTA2KpSgLJ7e1K1+o0yOO7eSU6QwnGoGTz/KDvHXk/0OpDv2aw==
X-Received: by 2002:a05:6000:2509:b0:3a4:f786:4fa1 with SMTP id
 ffacd0b85a97d-3b4970118aemr3002756f8f.2.1751659787130; 
 Fri, 04 Jul 2025 13:09:47 -0700 (PDT)
Received: from localhost ([177.45.162.214])
 by smtp.gmail.com with UTF8SMTPSA id
 6a1803df08f44-702c4ccd328sm17694666d6.45.2025.07.04.13.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 13:09:46 -0700 (PDT)
Date: Fri, 04 Jul 2025 17:09:42 -0300
MIME-Version: 1.0
Message-Id: <20250704-new-munmap04-v1-1-6ef96138b092@suse.com>
X-B4-Tracking: v=1; b=H4sIAAU1aGgC/x3MTQrCQAxA4auUrB2Ig0X0KsVFZhptFpOWxD8ov
 Xujy2/x3grOJuxw7VYwfovLrIHjoYM6kT44yRiGjLnHM56S8ie1lzZaAtRfKmUkRqwQyWJ8l+9
 /N9zChZxTMdI6/SaN/MkG27YDezHmEncAAAA=
X-Change-ID: 20250704-new-munmap04-a59ca20ae00c
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3799; i=rbm@suse.com;
 h=from:subject:message-id; bh=UHgz5dtqsenpp2rp7tNpveYdXWAEHC88CMbXzhiUIe0=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoaDUHzfowcP8KyXZe0eRFTg8kswTvY4gNuJR/c
 PWXUnj7MWGJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaGg1BwAKCRDJC4p8Y4ZY
 ptwmEACSelARioQkr3LMLXcNoVA4IU2chSjK6N+4bYVsNbeULwY8n1eTlTbgJ8S7aDDRMS60K22
 LKy1SorArbnpan9HFdmTBlCt96IuNzONR/dkMF17GeNh5f6eJWar/yN7AKTLH4Bj5Qf9koQ8AF6
 I783Rt6liaL4SfcZxOopd4hTrjtLlP+hRPf84WmjKHTkQCvCXSCjTnKDBLSOUmZU1IHCkXs5szL
 MizASYEdVhlHlSskm5kAfjkzG4v0fQ2rgIz2kdNr3iHeMPyHTYGulFnhPmMed2DK4t+4BZH5qV7
 57rmEGaymBEt3vuuEoEWuyHA8hSnxOPqR3NwAvYmv9ORz1QCmhaSJKm0FpmiaWpKnBWgHuxHKJ+
 bco4EYnKE19w2BXZfn5UAy77synhnOQQW2vwnTv11VZCZdEGqqFHGd7BNQsbnCggxlYhYoXWwwm
 NZVuq+PWNs2oT0886emHKypulDHhGfqtgepJE/7Cu0Q3Vj9XyDtnrCy5voFNEk52zk99YsitHba
 lyLX7jafTo8oFW/TI9HFo3wfPvUdGQ0Leus3k7S7mcVrf5fPptENYyWZ2rnueWt773wnEykbT2b
 5kiZOqm0Bl2uZmImoKX7PqsOTeNm+WWtTYZO+V1Y3h+0pjN0amdikLPfcD2lyP48ssr8mc+iF/A
 7Y5AKTZDTSmZdxQ==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls: munmap: Add munmap04 to check ENOMEM
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KClRoZSBFUlJPUlMgc2Vj
dGlvbiBvZiB0aGUgbW1hcCgyKSBtYW5wYWdlIHNheXM6CgpFTk9NRU06IFRoZSBwcm9jZXNzJ3Mg
bWF4aW11bSBudW1iZXIgb2YgbWFwcGluZ3Mgd291bGQgaGF2ZSBiZWVuIGV4Y2VlZGVkLgpUaGlz
IGVycm9yIGNhbiBhbHNvIG9jY3VyIGZvciBtdW5tYXAoKSwgd2hlbiB1bm1hcHBpbmcgYSByZWdp
b24gaW4gdGhlCm1pZGRsZSBvZiBhbiBleGlzdGluZyBtYXBwaW5nLCAgc2luY2UgIHRoaXMgIHJl
4oCQIHN1bHRzIGluIHR3byBzbWFsbGVyCm1hcHBpbmdzIG9uIGVpdGhlciBzaWRlIG9mIHRoZSBy
ZWdpb24gYmVpbmcgdW5tYXBwZWQuCgpBZGQgYSBuZXcgdGVzdCBtdW5tYXAwNCB0byBhZGRyZXNz
IHRoaXMgc2NlbmFyaW8uCgpTaWduZWQtb2ZmLWJ5OiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJt
QHN1c2UuY29tPgotLS0KIHJ1bnRlc3Qvc3lzY2FsbHMgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgMSArCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL211bm1hcC8uZ2l0aWdub3JlIHwg
IDEgKwogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tdW5tYXAvbXVubWFwMDQuYyB8IDc1ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDc3IGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS9ydW50ZXN0L3N5c2NhbGxzIGIvcnVudGVzdC9zeXNjYWxscwpp
bmRleCA1ODI0MjJhYzljYThjY2FlNTk4YzYyNmExMWNmNmVlN2MzMGYwZTNhLi5kOTE4OTYzYjdh
ZDYxNmNlNTkzMTQ3NmQwODA0ZDJjYjU2Njk0MmMwIDEwMDY0NAotLS0gYS9ydW50ZXN0L3N5c2Nh
bGxzCisrKyBiL3J1bnRlc3Qvc3lzY2FsbHMKQEAgLTk1MSw2ICs5NTEsNyBAQCBtdW5sb2NrYWxs
MDEgbXVubG9ja2FsbDAxCiBtdW5tYXAwMSBtdW5tYXAwMQogbXVubWFwMDIgbXVubWFwMDIKIG11
bm1hcDAzIG11bm1hcDAzCittdW5tYXAwNCBtdW5tYXAwNAogCiBuYW5vc2xlZXAwMSBuYW5vc2xl
ZXAwMQogbmFub3NsZWVwMDIgbmFub3NsZWVwMDIKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvbXVubWFwLy5naXRpZ25vcmUgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L211bm1hcC8uZ2l0aWdub3JlCmluZGV4IDk0ZDhjMTBhMjRjYWU0N2M2ODA1NTQ2YmZmNDFhODRh
MmEyZTgxNzMuLmQ0MThkYzQ1MTJhYmU2ZGZmY2IyNzlmZGRiZGJkZTI1YTRmNDQyMzAgMTAwNjQ0
Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbXVubWFwLy5naXRpZ25vcmUKKysrIGIv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tdW5tYXAvLmdpdGlnbm9yZQpAQCAtMSwzICsxLDQg
QEAKIC9tdW5tYXAwMQogL211bm1hcDAyCiAvbXVubWFwMDMKKy9tdW5tYXAwNApkaWZmIC0tZ2l0
IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tdW5tYXAvbXVubWFwMDQuYyBiL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvbXVubWFwL211bm1hcDA0LmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQK
aW5kZXggMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMC4uYzQzOWEzYmQx
YmIzZWM1YzI0YzBhZDU5NzliNjUyZmYzNzg5ZWJkMwotLS0gL2Rldi9udWxsCisrKyBiL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvbXVubWFwL211bm1hcDA0LmMKQEAgLTAsMCArMSw3NSBAQAor
Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKKy8qCisgKiBDb3B5
cmlnaHQgKGMpIDIwMjUgU1VTRSBMTEMgUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNv
bT4KKyAqLworCisvKlwKKyAqIFZlcmlmeSB0aGF0IG11bm1hcCgpIGZhaWxzIHdpdGggRU5PTUVN
IGFmdGVyIHBhcnRpYWxseSB1bm1hcHBpbmcgYW4KKyAqIGV4aXN0aW5nIG1hcCwgd2hpbGUgaGF2
aW5nIHRoZSBtYXhpbXVtIGFtb3VudCBvZiBtYXBzIGFscmVhZHkgYWxsb2NhdGVkLgorICovCisK
KyNpbmNsdWRlICJ0c3RfdGVzdC5oIgorCisjZGVmaW5lIFBBRCAyIC8vIGF2b2lkIGFkamFjZW50
IG1hcHBpbmcgbWVyZ2VzCisjZGVmaW5lIFBBR0VTIDMKKyNkZWZpbmUgTUFYX01BUF9DT1VOVF9G
SUxFICIvcHJvYy9zeXMvdm0vbWF4X21hcF9jb3VudCIKKworc3RhdGljIHVpbnRwdHJfdCBiYXNl
ID0gMHgxMDAwMDAwMDBVTDsKK3N0YXRpYyB2b2lkICphZGRyOworc3RhdGljIHNpemVfdCBwYWdl
X3N6Oworc3RhdGljIHVuc2lnbmVkIGxvbmcgdm1hX3NpemU7CitzdGF0aWMgdW5zaWduZWQgbG9u
ZyBtYXhfbWFwX2NvdW50Oworc3RhdGljIGludCBtYXBfY291bnQ7CisKK3N0YXRpYyB2b2lkIHJ1
bih2b2lkKQoreworCVRTVF9FWFBfRkFJTChtdW5tYXAoYWRkciArIHBhZ2Vfc3osIHBhZ2Vfc3op
LCBFTk9NRU0pOworfQorCitzdGF0aWMgdm9pZCBzZXRfbWF4X21hcF9jb3VudChzaXplX3QgbWF4
KQoreworCXRzdF9yZXMoVElORk8sICJzZXR0aW5nIG1heF9tYXBfY291bnQgPSAlenUiLCBtYXgp
OworCVNBRkVfRklMRV9QUklOVEYoTUFYX01BUF9DT1VOVF9GSUxFLCAiJXp1IiwgbWF4KTsKK30K
Kworc3RhdGljIHZvaWQgc2V0dXAodm9pZCkKK3sKKwlwYWdlX3N6ID0gU0FGRV9TWVNDT05GKF9T
Q19QQUdFU0laRSk7CisJdm1hX3NpemUgPSBQQUdFUyAqIHBhZ2Vfc3o7CisKKwlTQUZFX0ZJTEVf
U0NBTkYoTUFYX01BUF9DT1VOVF9GSUxFLCAiJWx1IiwgJm1heF9tYXBfY291bnQpOworCXRzdF9y
ZXMoVElORk8sICJvcmlnaW5hbCBtYXhfbWFwX2NvdW50ID0gJWx1IiwgbWF4X21hcF9jb3VudCk7
CisJc2V0X21heF9tYXBfY291bnQoNTAwKTsKKworCWFkZHIgPSBTQUZFX01NQVAoTlVMTCwgdm1h
X3NpemUsIFBST1RfUkVBRCB8IFBST1RfV1JJVEUsCisJCQkgTUFQX1BSSVZBVEUgfCBNQVBfQU5P
TllNT1VTLCAtMSwgMCk7CisKKwl3aGlsZSAoMSkgeworCQl2b2lkICpwID0KKwkJCW1tYXAoKHZv
aWQgKikoYmFzZSArIFBBRCAqIHZtYV9zaXplICogbWFwX2NvdW50KSwKKwkJCSAgICAgdm1hX3Np
emUsIFBST1RfTk9ORSwKKwkJCSAgICAgTUFQX1BSSVZBVEUgfCBNQVBfQU5PTllNT1VTIHwgTUFQ
X0ZJWEVEX05PUkVQTEFDRSwKKwkJCSAgICAgLTEsIDApOworCQlpZiAocCA9PSBNQVBfRkFJTEVE
KQorCQkJYnJlYWs7CisJCW1hcF9jb3VudCsrOworCX0KKworCXRzdF9yZXMoVElORk8sICJtYXBw
ZWQgJWQgcmVnaW9ucyIsIG1hcF9jb3VudCk7Cit9CisKK3N0YXRpYyB2b2lkIGNsZWFudXAodm9p
ZCkKK3sKKwlzZXRfbWF4X21hcF9jb3VudChtYXhfbWFwX2NvdW50KTsKKwlpZiAoYWRkcikKKwkJ
U0FGRV9NVU5NQVAoYWRkciwgdm1hX3NpemUpOworCWZvciAoaW50IGkgPSAwOyBpIDwgbWFwX2Nv
dW50OyBpKyspCisJCVNBRkVfTVVOTUFQKCh2b2lkICopKGJhc2UgKyBQQUQgKiB2bWFfc2l6ZSAq
IGkpLCB2bWFfc2l6ZSk7Cit9CisKK3N0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKKwku
dGVzdF9hbGwgPSBydW4sCisJLnNldHVwID0gc2V0dXAsCisJLmNsZWFudXAgPSBjbGVhbnVwLAor
CS5uZWVkc19yb290ID0gMSwKK307CgotLS0KYmFzZS1jb21taXQ6IGY2Yjc2ZmUzNzNkMTkzMmNl
MWQyMjQ4ZTgzZmYyODQwODUxNDU3OTcKY2hhbmdlLWlkOiAyMDI1MDcwNC1uZXctbXVubWFwMDQt
YTU5Y2EyMGFlMDBjCgpCZXN0IHJlZ2FyZHMsCi0tIApSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJt
QHN1c2UuY29tPgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
