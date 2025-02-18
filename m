Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452F1C021AA
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 18:08:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 77A173C1AC0
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 19:08:07 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A69683C06D0
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 19:07:49 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C2CEE63DFC8
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 19:07:48 +0100 (CET)
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2fc20e0f0ceso7526002a91.3
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 10:07:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739902066; x=1740506866;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:dkim-signature:from:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=sasDHuXcNFlqxmwodrztntJv11wXTUY/fLlLS4gXmcE=;
 b=oIrHToO+xqu2gX/rK1lLFx5Qn1if1JdAJw5+p2Ic/olqVJ5To69Xua9s5cmWsyFpUQ
 Vz02lF+J/x1DOkiNhckYalZ/Q/j2qn5O06u9Z3umhmt++8scbocyOHYSb0GE0/Y0k+cR
 XbZwS1AHKMIiNAEoK6cEbt6u3IYpCD8DIq7yirs8Obh5zJN6JGs3Z7D1rbLvFShCV/Sf
 KHGxkgMgFHOWhQI8WoRE/76FQDk1Wz5zNc/D5TayApqPkes0yXv8K9Gf8iG2WEPIEwJX
 OmUyYuRfWv2CooLIBs05vsP9wgoUUJorMw/9x5vq5/VXSpxL1rf1rWKg+lAHfwpvyVZN
 ysZQ==
X-Gm-Message-State: AOJu0YxQcEtvCUcOXGGWAWCNDxZISD9kFpMQ6o4yky8jjjrfPVz2CPwt
 spaswo1RXYboonMCukd22cTqLHK6ULvI7IF0KskXHrmr1inMJgPgX5ETwQquFC8=
X-Gm-Gg: ASbGncsB2ooPYi/aRNaw4CW/netFAclL5n5tF6hnnuURQl0ky6pl3wCHx9aJQAQK5o2
 lE6Gip58oTWl8KBoC45xSEttuBhc4d9RycdT5i6a0b5VYRnRulVIEh7Ic690926fGpWipJQbpSM
 j+kq0LS0Jgn8D3Bj17x623cmTEbtGGpCDkLA/iWWbB2GpPwS83iet7Y7TnsnKoTnB8Ftp1xze7P
 sNZ3UIgEJU2zEPuHPYoWbINXLFGNMhTa0Tns5cdJ4Y1mAP2TO41R1DDGMMf5ttvKbYJ6UhOFxRq
 szZQEpPgBw==
X-Google-Smtp-Source: AGHT+IHLdY95LvDme+seq7TehLAJpcDpcukz46DUUoUlwTANsPZazjC2biJK5FJsAkk4+RoEplAsDg==
X-Received: by 2002:a17:90b:1a88:b0:2ee:741c:e9f4 with SMTP id
 98e67ed59e1d1-2fcb5a1aa11mr590945a91.11.1739902066264; 
 Tue, 18 Feb 2025 10:07:46 -0800 (PST)
Received: from mail.marliere.net ([2604:a880:4:1d0::7f5:6000])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ab103dsm10430121a91.6.2025.02.18.10.07.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 10:07:45 -0800 (PST)
From: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
 s=2025; t=1739902063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sasDHuXcNFlqxmwodrztntJv11wXTUY/fLlLS4gXmcE=;
 b=lj5yrA7IqRp3pFjnmyV+btli+uzOzcKataq1HH7jim9MN+2qBpP0a+sBffYCumulK8VQyr
 Zv4fTOTjec4MEQ0Yqi/zdOIGIirbNbk1N95VwHr020VYV/AsX50GmtcEAn0Qcr21VdsnjW
 BZhf1jsQ5hDxsH0qqpFjPVU5LMqEXEeEEmyUr1sE/x7XrVjnHIsO1IfMLQO9rd0aehLESI
 MtzUMceSw2oYZ3wKmSlpQzPCQ5jPO+6gSvLgajYdwDqhJAAPxPxDWiGG3u41q5NhdhNlvj
 NOHXlBHp3f0O4FHaw8g8j1Iu2ohSXnuXusCvidkyuPHJuIgXumMjIoboM8HMMg==
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 18 Feb 2025 15:07:16 -0300
Message-Id: <20250218-conversions-pause-v2-0-8c72960fe1ec@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFTMtGcC/32NQQ6CMBBFr0K6tobWIsjKexgWnTJIEylkBhsN4
 e62HMDlS95/fxOM5JFFW2yCMHr2c0igT4Vwow1PlL5PLHSpq1KrWro5RKSssVzsm1EauPUG8DI
 09VWk3UI4+M/RfHSJwSYJyAY35tJkeUXK4uh5nel7fEeV9X83UclSAjaARjlQlblPll4eCc8BV
 9Ht+/4DIYPDm84AAAA=
X-Change-ID: 20250217-conversions-pause-4b9d4be3f876
To: Linux Test Project <ltp@lists.linux.it>
X-Developer-Signature: v=1; a=openpgp-sha256; l=973; i=rbm@suse.com;
 h=from:subject:message-id; bh=nc39+8cNoIVGVfuezuZtFIEsX4XFIGPB8LUPvDdwtZ0=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBntMxrxP4+EcQeoIuET9jIVxXfZcY/TQTj1xoGA
 PObrb4b+bqJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ7TMawAKCRDJC4p8Y4ZY
 ppthD/9hTsjW31bEnVDZTJIjT9jfSLcUkocXduQSf3+W4QjbQGngHWTvsI6fYIlcpyoGIXAjU8R
 uP4fjScycZ2rxk2c4zFaqVYup0d1+ApfqtfQzp3mLv9ZlEYdgaWuAz00YspUZtdX3SYpBbXyipY
 g8oPliighzmLxluz2QXUIRqoZC0cI6XXhE4Pc2j3CBCqeETa59vdf9WJz/CUVAe3MUueTshRkfI
 W4yUMF7F+o3FrjbZ27tIl7mvIpWsR+UJqGovS5lAK2plIrrgDVMKzVepx8paIauNoXltZdNmK9U
 KNq8FwY+HysBoB99RlbBXQUkDs/ZKHqYj9dN2LSDZEN1x32M44R06JGRPPKi8/TJc1MOHlwoN5+
 /PRJYiW7AJAqbd/is0RIdTCsUTX478qm/K9MWBZ5b/+H59ko1nVdggUtx9C3F9LpIFZcAE2UFoY
 wImVqHHYuI2WJs7N4hFx8hK/8G24b4z1W/17P1rTq7m1klpFLjylYglu7ozdvloRmZdiFSWWmVc
 +AanDxiNBCESdIljSCGqecRxPtEf4EoblC7ubkYpu3L8vVoKxcyHpB5p21FrxSo4b8dMvlN1B3y
 y/GeUuzXZkuukYyQSRSNO/hEyqmYfcAZ3ccHrBEmG23QscZsxAlvrNUQmBGnMG9xFXk0MpJhGDi
 k4DsnasoteEXQ+A==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/3] syscalls/pause: Refactor tests
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
Cc: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

U2lnbmVkLW9mZi1ieTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJpY2FyZG9AbWFybGllcmUubmV0
PgotLS0KQ2hhbmdlcyBpbiB2MjoKLSBBZGRlZCBhIGNsZWFudXAgY29tbWl0IGZvciBwYXVzZTAx
Ci0gTWFkZSB1c2Ugb2YgTFRQX0FUVFJJQlVURV9VTlVTRUQsIFRTVF9FWFBfRkFJTCwgVFNUX0VY
UF9FWFBSLCBTQUZFX0tJTEwKICBhcyBzdWdnZXN0ZWQgYnkgQW5kcmVhLgotIEZpeGVkIHRlc3Qg
ZGVzY3JpcHRpb25zCi0gQWRkZWQgMjAyNSBjb3B5cmlnaHQKLSBMaW5rIHRvIHYxOiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9yLzIwMjUwMjE3LWNvbnZlcnNpb25zLXBhdXNlLXYxLTAtYmU4YmU0
MWNiMTU0QG1hcmxpZXJlLm5ldAoKLS0tClJpY2FyZG8gQi4gTWFybGnDqHJlICgzKToKICAgICAg
c3lzY2FsbHMvcGF1c2UwMTogQ2xlYW4gdXAKICAgICAgc3lzY2FsbHMvcGF1c2UwMjogUmVmYWN0
b3IgaW50byBuZXcgQVBJCiAgICAgIHN5c2NhbGxzL3BhdXNlMDM6IFJlZmFjdG9yIGludG8gbmV3
IEFQSQoKIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcGF1c2UvcGF1c2UwMS5jIHwgIDM0ICsr
Ky0tLS0KIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcGF1c2UvcGF1c2UwMi5jIHwgMTUwICsr
KysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9w
YXVzZS9wYXVzZTAzLmMgfCAxMTUgKysrKystLS0tLS0tLS0tLS0tLS0tLS0KIDMgZmlsZXMgY2hh
bmdlZCwgNjYgaW5zZXJ0aW9ucygrKSwgMjMzIGRlbGV0aW9ucygtKQotLS0KYmFzZS1jb21taXQ6
IDQ1OWIzY2RmMTU3ZjlkNmJlNTFmM2E2MTBkZmYzODU1ZjVlOWZmMzYKY2hhbmdlLWlkOiAyMDI1
MDIxNy1jb252ZXJzaW9ucy1wYXVzZS00YjlkNGJlM2Y4NzYKCkJlc3QgcmVnYXJkcywKLS0gClJp
Y2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
