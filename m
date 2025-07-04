Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052CEC83F03
	for <ltp@archiver.kernel.org>; Fri,  4 Jul 2025 20:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751659944; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=3nibm+w3PFQsczUNDhc8O8SoHzGEHq2hkRfCRD8dnkc=;
 b=bqARh7Oy2FKu8f1NONJynUbPYSGSBJwP+5SfegiLbS27gaq/tjxUGIS+1Yy14BjvxCaZB
 n6pH7yzwA43vh1FcbBOSw8MVMUfCHeHBIX9WIOo8UhhXDu+cefrn59uxxmI58kWlXvGSt4l
 9Lxy+1RBWla+uvz10+euggGyOcx6GTo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8DA773C9DE4
	for <ltp@archiver.kernel.org>; Fri,  4 Jul 2025 22:12:24 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 324603C7564
 for <ltp@lists.linux.it>; Fri,  4 Jul 2025 22:12:03 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 51CFA60010D
 for <ltp@lists.linux.it>; Fri,  4 Jul 2025 22:12:02 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-450cfb79177so7187215e9.0
 for <ltp@lists.linux.it>; Fri, 04 Jul 2025 13:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751659922; x=1752264722; darn=lists.linux.it;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4L5GsAPUW2nzR3/Q1aA5wb7zIoE+G9pJqOkbIGbIubo=;
 b=BEY0eh90KdqKZSNofUu76pBEKgcdfH+kUMtLR/DnG10BJmP4DrxH1ZLctcrNimk3Da
 9HbH0MBGW/GtJNFC214HFtiYHs78Ajh79vG7+wWqeSJkxeoBOlnwgUcfT8PC/afV5yhr
 Eh6ncivj8S6n0p1uNiZqDIEsWhqzqWKUghTIT5/qXSlz5zqZS857qWUmXccnjfkG29Gu
 CMcIlv8XImUvBqs6ZtFuP5TpyAyMQoCQtVYs/CzmZfrtuQv/Lw4qM3+EIC9F4QTzMD6R
 TjRLossp7cp09YLqaZzpy4+w4QFdHbgIoXkgfGHVNcZ6fr7SXX5zH2pgU85J3lE4pJGD
 FjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751659922; x=1752264722;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4L5GsAPUW2nzR3/Q1aA5wb7zIoE+G9pJqOkbIGbIubo=;
 b=Xhqk6r9lAI6sWgrVFzaek/xcvxrDbmF1DgfOQfvjwvwDQRRpWsjU14S5C28EihjjrI
 2h+Sc9hxdnw4RCJI971A140e5d4+uwqAVeUVihpllkdD0jlLTTZlAtHLaOwRI2sPJ58z
 WFAro5qXBrylb+5nh22bghEeWhKdfXdcNm8AGrHakbWKfWPX0wEzKDYYHvcNh5FqMoDy
 6ASLSYtO6AOALpKq0E1gSjSd1gIbdF2DlLSNxh5w8MoGsZdtLG43Ysazo9J+dP521F7C
 jksO+qxi1ACN0/A3rN3YvvxUqyXUR1QZS64S8fuWR3wGXZGMOv+gLcOi3yokKIyreyTn
 hurQ==
X-Gm-Message-State: AOJu0Yw5NhrG9ML1DcTapTU6kiCf0i1rC+zq8LRObNoXvUXPxEmg+VHi
 dzUEsgFslehIudS91I/j3Rs5jtA++ghtvwXJ2gicdmUjXKkktVsMnZbRpiMKkCWO5LRiJajiGE6
 vmadO
X-Gm-Gg: ASbGncsOU+NI3u+rtcq99dpLP8syM1p+d0RU2psmdJB+kDbWrVuxuPsFhvLGBLWOsac
 aPM+c2b8s2h1xyBKtFHVD9qdKl7dm3RcIOK7GHld3WofwiUPzCztEtKvOWt+9uop7X/dDtKgz+6
 /C2daGO6MmiWgvmx+kHHNubsZnI7EhlL8vRW6rszSmYM1gBYVuxLragPeAsDENKPbzsHPHBpbWr
 NDhQi1FE7NU4Cz5U2J1GmQpW9cWOYT8pSimvPNyeKIQVMTasXnYbogmQWB30/uGoZoYF3D294JG
 0OQNo+rVGKJEZatUS2tT1fc0CcbcjhRzjtq6SgUBD9jMDm09TJrr+tSoECja
X-Google-Smtp-Source: AGHT+IEQ6tn2CkHhYON9kXLWnII6i8JWEoBf+RSjO/WxQx5krHxu8MdJc0Zs+0NIxA5UkzUvpZ3ABQ==
X-Received: by 2002:a05:6000:1ac6:b0:3a4:f55a:4ae2 with SMTP id
 ffacd0b85a97d-3b4964e3e17mr3122524f8f.50.1751659921578; 
 Fri, 04 Jul 2025 13:12:01 -0700 (PDT)
Received: from localhost ([177.45.162.214])
 by smtp.gmail.com with UTF8SMTPSA id
 6a1803df08f44-702c4d5aebfsm17764006d6.93.2025.07.04.13.11.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 13:12:00 -0700 (PDT)
Date: Fri, 04 Jul 2025 17:11:55 -0300
MIME-Version: 1.0
Message-Id: <20250704-new-munmap04-v2-1-436c80df9646@suse.com>
X-B4-Tracking: v=1; b=H4sIAIo1aGgC/3WNQQ6CMBBFr0Jmbc20Coor72FYDHWQLlpIB6qGc
 HcLe5cvef/9BYSjY4FbsUDk5MQNIYM5FGB7Ci9W7pkZDJoSL3hWgd/Kz8HTmIHK2pJBYkQLeTJ
 G7txnzz2azC0JqzZSsP0W8SQTx03snUxD/O63SW/6n4eklVYVd3WlT9cWa3OXWfhoBw/Nuq4/A
 eTqxcAAAAA=
X-Change-ID: 20250704-new-munmap04-a59ca20ae00c
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3935; i=rbm@suse.com;
 h=from:subject:message-id; bh=9c1QVRe2W69dYGb1p3dGUdEPpPSCwz7icaL5++ELvEo=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoaDWOedPOjOQYgrD2cRDAB6qM0sS8sr0vXf8A5
 YJ+AcY5anqJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaGg1jgAKCRDJC4p8Y4ZY
 puriD/9K9ElejPFUhaFlMAGNE/1qUfserWSPxy3LVlpkA12HCOTk9c0JuE8HQi1m+7gEs3uWNwy
 XNFTVTFJp1vi9Kd6ll2I3KxtL3VXlT1R2ejQsz1H0+9L9R3fVPZIMndWZFoCu8XOTsnuKMrfVGu
 xmDxQFYtMqiIGqYOA50W3QBhFaAT7Ib9HxylLW8qq32CVeqPDady+gtV3CXNcpQbWfFB3QscpON
 t2CFPfVTf0xfSWBP5Rj5QNEagQENaW3d7Y57BPnUQvzh4YLaFnRifLqDD8xV/k2T/uOEks8e7Oo
 0j0OsrCfIkYeeYq0u7hi7pQgUZNcwrIYwCUIU8BSqOhZtgwoYYKWPWth1E4vr8xR5fdymMTHuP9
 TpRbkwExxIY9BA/uhoFYgr6lL06nEElerE0ceRn1PMl6tEn4EX9pwMVUOShgMYZDOq3ikKa2WZd
 81+oM7XnyStZcTw3nUCFuOLZyJiz/2k3KGK7ya5xHQomf81wpC1hKEBTSc+hKBp19NYVC+PlBj2
 fUg87JO1dNUdbGs5KGg6Vjis0Pcjl3h26wkPdaNajmrWWmF3bQ7ykXaKBO8T5Ovtovp5z9b2QSh
 cMp2KMfPWbXfHNHcW9iiO5sUDM3/gJhDkU1q4nAdXAEFyfOVhTLF/0gMJUfB2aYzzDE9RfQbl34
 E1wTQtxUT3Ucr/A==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls: munmap: Add munmap04 to check ENOMEM
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
b24gaW4gdGhlCm1pZGRsZSBvZiBhbiBleGlzdGluZyBtYXBwaW5nLCBzaW5jZSB0aGlzIHJlc3Vs
dHMgaW4gdHdvIHNtYWxsZXIgbWFwcGluZ3MKb24gZWl0aGVyIHNpZGUgb2YgdGhlIHJlZ2lvbiBi
ZWluZyB1bm1hcHBlZC4KCkFkZCBhIG5ldyB0ZXN0IG11bm1hcDA0IHRvIGFkZHJlc3MgdGhpcyBz
Y2VuYXJpby4KClNpZ25lZC1vZmYtYnk6IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5j
b20+Ci0tLQpDaGFuZ2VzIGluIHYyOgotIENvcnJlY3RlZCB0aGUgY29tbWl0IG1lc3NhZ2UKLSBM
aW5rIHRvIHYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUwNzA0LW5ldy1tdW5tYXAw
NC12MS0xLTZlZjk2MTM4YjA5MkBzdXNlLmNvbQotLS0KIHJ1bnRlc3Qvc3lzY2FsbHMgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgMSArCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL211
bm1hcC8uZ2l0aWdub3JlIHwgIDEgKwogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tdW5tYXAv
bXVubWFwMDQuYyB8IDc1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAzIGZpbGVzIGNo
YW5nZWQsIDc3IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9ydW50ZXN0L3N5c2NhbGxzIGIv
cnVudGVzdC9zeXNjYWxscwppbmRleCA1ODI0MjJhYzljYThjY2FlNTk4YzYyNmExMWNmNmVlN2Mz
MGYwZTNhLi5kOTE4OTYzYjdhZDYxNmNlNTkzMTQ3NmQwODA0ZDJjYjU2Njk0MmMwIDEwMDY0NAot
LS0gYS9ydW50ZXN0L3N5c2NhbGxzCisrKyBiL3J1bnRlc3Qvc3lzY2FsbHMKQEAgLTk1MSw2ICs5
NTEsNyBAQCBtdW5sb2NrYWxsMDEgbXVubG9ja2FsbDAxCiBtdW5tYXAwMSBtdW5tYXAwMQogbXVu
bWFwMDIgbXVubWFwMDIKIG11bm1hcDAzIG11bm1hcDAzCittdW5tYXAwNCBtdW5tYXAwNAogCiBu
YW5vc2xlZXAwMSBuYW5vc2xlZXAwMQogbmFub3NsZWVwMDIgbmFub3NsZWVwMDIKZGlmZiAtLWdp
dCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbXVubWFwLy5naXRpZ25vcmUgYi90ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL211bm1hcC8uZ2l0aWdub3JlCmluZGV4IDk0ZDhjMTBhMjRjYWU0
N2M2ODA1NTQ2YmZmNDFhODRhMmEyZTgxNzMuLmQ0MThkYzQ1MTJhYmU2ZGZmY2IyNzlmZGRiZGJk
ZTI1YTRmNDQyMzAgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbXVubWFw
Ly5naXRpZ25vcmUKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tdW5tYXAvLmdpdGln
bm9yZQpAQCAtMSwzICsxLDQgQEAKIC9tdW5tYXAwMQogL211bm1hcDAyCiAvbXVubWFwMDMKKy9t
dW5tYXAwNApkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tdW5tYXAvbXVu
bWFwMDQuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbXVubWFwL211bm1hcDA0LmMKbmV3
IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMC4uYzQzOWEzYmQxYmIzZWM1YzI0YzBhZDU5NzliNjUyZmYzNzg5ZWJkMwotLS0gL2Rl
di9udWxsCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbXVubWFwL211bm1hcDA0LmMK
QEAgLTAsMCArMSw3NSBAQAorLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3It
bGF0ZXIKKy8qCisgKiBDb3B5cmlnaHQgKGMpIDIwMjUgU1VTRSBMTEMgUmljYXJkbyBCLiBNYXJs
acOocmUgPHJibUBzdXNlLmNvbT4KKyAqLworCisvKlwKKyAqIFZlcmlmeSB0aGF0IG11bm1hcCgp
IGZhaWxzIHdpdGggRU5PTUVNIGFmdGVyIHBhcnRpYWxseSB1bm1hcHBpbmcgYW4KKyAqIGV4aXN0
aW5nIG1hcCwgd2hpbGUgaGF2aW5nIHRoZSBtYXhpbXVtIGFtb3VudCBvZiBtYXBzIGFscmVhZHkg
YWxsb2NhdGVkLgorICovCisKKyNpbmNsdWRlICJ0c3RfdGVzdC5oIgorCisjZGVmaW5lIFBBRCAy
IC8vIGF2b2lkIGFkamFjZW50IG1hcHBpbmcgbWVyZ2VzCisjZGVmaW5lIFBBR0VTIDMKKyNkZWZp
bmUgTUFYX01BUF9DT1VOVF9GSUxFICIvcHJvYy9zeXMvdm0vbWF4X21hcF9jb3VudCIKKworc3Rh
dGljIHVpbnRwdHJfdCBiYXNlID0gMHgxMDAwMDAwMDBVTDsKK3N0YXRpYyB2b2lkICphZGRyOwor
c3RhdGljIHNpemVfdCBwYWdlX3N6Oworc3RhdGljIHVuc2lnbmVkIGxvbmcgdm1hX3NpemU7Citz
dGF0aWMgdW5zaWduZWQgbG9uZyBtYXhfbWFwX2NvdW50Oworc3RhdGljIGludCBtYXBfY291bnQ7
CisKK3N0YXRpYyB2b2lkIHJ1bih2b2lkKQoreworCVRTVF9FWFBfRkFJTChtdW5tYXAoYWRkciAr
IHBhZ2Vfc3osIHBhZ2Vfc3opLCBFTk9NRU0pOworfQorCitzdGF0aWMgdm9pZCBzZXRfbWF4X21h
cF9jb3VudChzaXplX3QgbWF4KQoreworCXRzdF9yZXMoVElORk8sICJzZXR0aW5nIG1heF9tYXBf
Y291bnQgPSAlenUiLCBtYXgpOworCVNBRkVfRklMRV9QUklOVEYoTUFYX01BUF9DT1VOVF9GSUxF
LCAiJXp1IiwgbWF4KTsKK30KKworc3RhdGljIHZvaWQgc2V0dXAodm9pZCkKK3sKKwlwYWdlX3N6
ID0gU0FGRV9TWVNDT05GKF9TQ19QQUdFU0laRSk7CisJdm1hX3NpemUgPSBQQUdFUyAqIHBhZ2Vf
c3o7CisKKwlTQUZFX0ZJTEVfU0NBTkYoTUFYX01BUF9DT1VOVF9GSUxFLCAiJWx1IiwgJm1heF9t
YXBfY291bnQpOworCXRzdF9yZXMoVElORk8sICJvcmlnaW5hbCBtYXhfbWFwX2NvdW50ID0gJWx1
IiwgbWF4X21hcF9jb3VudCk7CisJc2V0X21heF9tYXBfY291bnQoNTAwKTsKKworCWFkZHIgPSBT
QUZFX01NQVAoTlVMTCwgdm1hX3NpemUsIFBST1RfUkVBRCB8IFBST1RfV1JJVEUsCisJCQkgTUFQ
X1BSSVZBVEUgfCBNQVBfQU5PTllNT1VTLCAtMSwgMCk7CisKKwl3aGlsZSAoMSkgeworCQl2b2lk
ICpwID0KKwkJCW1tYXAoKHZvaWQgKikoYmFzZSArIFBBRCAqIHZtYV9zaXplICogbWFwX2NvdW50
KSwKKwkJCSAgICAgdm1hX3NpemUsIFBST1RfTk9ORSwKKwkJCSAgICAgTUFQX1BSSVZBVEUgfCBN
QVBfQU5PTllNT1VTIHwgTUFQX0ZJWEVEX05PUkVQTEFDRSwKKwkJCSAgICAgLTEsIDApOworCQlp
ZiAocCA9PSBNQVBfRkFJTEVEKQorCQkJYnJlYWs7CisJCW1hcF9jb3VudCsrOworCX0KKworCXRz
dF9yZXMoVElORk8sICJtYXBwZWQgJWQgcmVnaW9ucyIsIG1hcF9jb3VudCk7Cit9CisKK3N0YXRp
YyB2b2lkIGNsZWFudXAodm9pZCkKK3sKKwlzZXRfbWF4X21hcF9jb3VudChtYXhfbWFwX2NvdW50
KTsKKwlpZiAoYWRkcikKKwkJU0FGRV9NVU5NQVAoYWRkciwgdm1hX3NpemUpOworCWZvciAoaW50
IGkgPSAwOyBpIDwgbWFwX2NvdW50OyBpKyspCisJCVNBRkVfTVVOTUFQKCh2b2lkICopKGJhc2Ug
KyBQQUQgKiB2bWFfc2l6ZSAqIGkpLCB2bWFfc2l6ZSk7Cit9CisKK3N0YXRpYyBzdHJ1Y3QgdHN0
X3Rlc3QgdGVzdCA9IHsKKwkudGVzdF9hbGwgPSBydW4sCisJLnNldHVwID0gc2V0dXAsCisJLmNs
ZWFudXAgPSBjbGVhbnVwLAorCS5uZWVkc19yb290ID0gMSwKK307CgotLS0KYmFzZS1jb21taXQ6
IGY2Yjc2ZmUzNzNkMTkzMmNlMWQyMjQ4ZTgzZmYyODQwODUxNDU3OTcKY2hhbmdlLWlkOiAyMDI1
MDcwNC1uZXctbXVubWFwMDQtYTU5Y2EyMGFlMDBjCgpCZXN0IHJlZ2FyZHMsCi0tIApSaWNhcmRv
IEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
