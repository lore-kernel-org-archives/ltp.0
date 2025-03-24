Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26727C36002
	for <ltp@archiver.kernel.org>; Mon, 24 Mar 2025 20:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742849166; h=date :
 message-id : mime-version : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=tykVxE0e1BAwwRNpAAPT4Rou3S7TNFTv59GiTDHyfWk=;
 b=Ss1dXuik6CYFAH04oRNrLMWET3lfuKHspAb4YxgSXIMozSh0snbJHWyibEDuuNXPxpCBx
 +9PpSoSg6Ej9mgN8n6nF+MIElWi7zacJOdljhEff7wzyAv5BBe7GoHyJHPVVna5iLMQaHPi
 sDuhPxYYQhEUIDnemED1Fb5x0Xw64kA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 214003C934C
	for <ltp@archiver.kernel.org>; Mon, 24 Mar 2025 21:46:06 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 368873C19FD
 for <ltp@lists.linux.it>; Mon, 24 Mar 2025 21:45:43 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5332514044CF
 for <ltp@lists.linux.it>; Mon, 24 Mar 2025 21:45:43 +0100 (CET)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-39130ee05b0so4526406f8f.3
 for <ltp@lists.linux.it>; Mon, 24 Mar 2025 13:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1742849142; x=1743453942; darn=lists.linux.it;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4i2ORPRSsoh9tWCuICZXWC1P4pb7FvhUlAcczjeitTQ=;
 b=FN5btr4AGuF65xUCVYdvJAaJyC0xTSiZczVbYP/4XYXJarlB2DRwzQzbzT0iMMtd4J
 CMEy1GurfQqdYMiYCG4dFkJqw2jju7N+C4oLOLD/RergmVlt9+qhKzENckUq9LaXFANY
 D8RVJ04Tae0pxyfwFnuVDF0+sJMx6y5QSef/tYVTqPd+6OBQneXENTBF6P2XRAovYK0J
 NLzF8fnGJ970V1a2zUYicRT7+JWdbUQTzEpHNT+lVj4uY/SiiVYh4nyT5fjwqYGzwgyq
 fA1blTWStK2huVCNYrL1befUDfJinNylBHopOEjGmkKFB2IydYmkUrWKAIaESD6HKBnG
 NvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742849142; x=1743453942;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4i2ORPRSsoh9tWCuICZXWC1P4pb7FvhUlAcczjeitTQ=;
 b=XCY40RIieTKJ+dI2y7aIOKVACpebVEnFpPYkJgIJT7Jkacij5e/2dathAmTHb9eutR
 C40jQZ3t2wPyYVAGc2pL+xz7uSVI/QYL4Avlm+7XU2x+zWlOjuMDX+4tjMZ2TSMhpRIX
 9VsOeR2sI3bHdGU85cFPe5mftKDknsydvdm8kddvCSCMDiDJ5OHXmVghAhJxdrFlSqUg
 +oLiaafiWzOqvgSdTzglDR8wL24swj6UpMZBe+2bjmcOJbxpgjYrztcIGHEbTavOrC0s
 9jDtTpz9aAyj9Jua4DwrwV/2nlwyJGQqmWQnTCEyBTQp7th1YfpMgx8zAS5uosNHygRO
 V7mg==
X-Gm-Message-State: AOJu0YxSJk5kTHMDUXeewoCrHlKPpHxPQqpCPEovKRfPkxGZbbbnG0qW
 0E8tmQmVDUf5zjXrB9V0N0liqV0fWQYmqGn+x6AdLsv3bNVRUdQYqHSXM5dPKrncOtnpj4yGKIl
 F
X-Gm-Gg: ASbGncsGndykUjIltPU4KNdnKZQLYmbvDbfNzHjIjzOl/k14lV6IuBgrGPMpsXYOZm1
 /gQlpveaiZj8ZQDBh4dolpdJBBHAt2YHNi6TqukIyxNklRHtFO6ZQDHmSw+S63T9sKfB2m9T6pU
 uenjHqrre9OX0Kv7RUfFtHMN6hFiaFVZLad1BZ7wtLzzXhjI74bPy7wM6ZaGUQ62kC2tbgzo1Hm
 K1qJESP8Z0/1vK2srA7L/pwYRRmrY2TOZBiPEZmatIe2lPYA8/lFAZsaNNoN2wTIfeRmAAMCJ6l
 yVwnjSaB75Pb5UyINfdrZb6UtNmqSIR7MA==
X-Google-Smtp-Source: AGHT+IHBh1phpiAjFAmXSRvADSwnSj3mxtrJgVPSudRUzLyQizEyb2EvFl14lQJhPweNoYVJa6Rcpw==
X-Received: by 2002:a5d:6da1:0:b0:391:456b:6ab7 with SMTP id
 ffacd0b85a97d-3997f937d82mr11221098f8f.34.1742849141860; 
 Mon, 24 Mar 2025 13:45:41 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-7390618c2ebsm8490249b3a.166.2025.03.24.13.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 13:45:41 -0700 (PDT)
Date: Mon, 24 Mar 2025 17:45:32 -0300
Message-Id: <20250324-conversions-modify_ldt-v1-0-8d6d82f10768@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGzE4WcC/x3M0QrCMAyF4VcZuTawpTrUVxGRrk1dwLWSjKGMv
 budlx+c869grMIG12YF5UVMSq7oDg2E0ecno8RqoJZOraMjhpIX1n1mOJUo6ft4xRnPXe/oQuR
 Sz1DPb+Ukn3/4dq8evDEO6nMY99zkbWaFbfsBIpYFZ4EAAAA=
X-Change-ID: 20250324-conversions-modify_ldt-816329223f6e
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1849; i=rbm@suse.com;
 h=from:subject:message-id; bh=gxR/MoBLg3z9YOFTNVD2bQG2s9eBPld5NDcQF+/UkfQ=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBn4cRxszTdDuM1sRQkwlcCQ0skn1nOSD+otI3J7
 wqvDmV1Ug+JAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ+HEcQAKCRDJC4p8Y4ZY
 puOfEACyc8tzZD53J8E7dCoCb4WPDjJyKh+9iREHsvohdqDSbwqnK8IP37PWCMK2e1XHOW8MIB2
 iEVvRtYXR8JAHOXBLnPOG+7aZhn1BWu+auB9hrXHvYspF4BzI+iFzVTLPnHCjIxRibfwpzIsX2v
 SCvCWOneQntGWNTPhWqavuKC8dojj53n+2EHRlirnNJ0vAkWVn8pawNSZPR66JQxejyfJGdwtmn
 XmEHVFOPv5hEgTjFnrE7rpHbkCzliIqZUpvWY1zyx0pAy1MHIZ+4ovO2PPylYKucfTy2OEocSuF
 xagy+dzzUClc82MM1WHEh1kSHBJSiTNwjc4oefc8HGCisKevQUga0zfCGtsrCiqbnLab1c+QXTa
 HjRd4NgWwUz1h+Txg9IVI6309TJUYYfrD+Nbz4uljdl5zMHgvLuoou0pM0EWEE4vNgU2INBGcfG
 rwNVnRXrRcHXC9/HlycY7EN/6YXyf7V7AsbNNrate9SmUSC89T/7OybcTDjSHJY2Aktku3ig3J6
 g0jaoqlT/yKt5mkD7wunwliESqeTPdIa0PZDGU1utKhQ2ILuT04S2cBUW9R2d4quMs+YLaEYPaf
 5Uov65GDI7O8rBMWbMEEnKjwJ4qIvjOGrGi5YIGhPQZhRNCj/4uKo7hOGjsQvSuoU2s/LA2hQOl
 /V3ZHkIidULGsnw==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/4] syscalls/modify_ldt: Refactor into new API
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
From: "Ricardo B. Marliere via ltp" <ltp@lists.linux.it>
Reply-To: rbm@suse.com
Cc: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8gZm9sa3MsCgpIZXJlJ3MgbXkgdGFrZSBvbiB3aGF0IHNob3VsZCBiZSB0aGUgbW9kaWZ5
X2xkdCBzeXNjYWxsIHJlZmFjdG9yLiBGb3IgdGhhdApJIGRlY2lkZWQgdG8gYWRkIHRoZSBpbmNs
dWRlL2xhcGkvbGR0LmggZmlsZSBtb3N0bHkgYmVjYXVzZSB0aGF0IHNjaGVtZSBoYXMKYmVlbiBp
bnRyaWd1aW5nIG1lIGZvciBhIHdoaWxlIG5vdyBhbmQgSSB3YW50ZWQgdG8gaGF2ZSBhIGJldHRl
ciBncmFzcCBvZgpob3cgaXQgd29ya3MuIEkgaG9wZSBJIGRpZCBpdCBjb3JyZWN0bHkuCgpJIHRy
aWVkIHRvIGVuYWJsZSBpdCBmb3IgeDg2XzY0IGJ1dCBhbHRob3VnaCB0aGUgc3lzY2FsbCBpcyBh
dmFpbGFibGUgdGhlCnRlc3RzIHdlcmUgdGhlbiBicm9rZW4sIHNvIEkgZHJvcHBlZCBpdC4KClBs
ZWFzZSBjb25zaWRlciByZXZpZXdpbmcsCi0JUmljYXJkby4KClNpZ25lZC1vZmYtYnk6IFJpY2Fy
ZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Ci0tLQpSaWNhcmRvIEIuIE1hcmxpw6hyZSAo
NCk6CiAgICAgIG1vZGlmeV9sZHQ6IEFkZCBsYXBpL2xkdC5oCiAgICAgIHN5c2NhbGxzL21vZGlm
eV9sZHQ6IFJlZmFjdG9yIG1vZGlmeV9sZHQwMyBpbnRvIG5ldyBBUEkKICAgICAgc3lzY2FsbHMv
bW9kaWZ5X2xkdDogUmVmYWN0b3IgbW9kaWZ5X2xkdDAyIGludG8gbmV3IEFQSQogICAgICBzeXNj
YWxscy9tb2RpZnlfbGR0OiBSZWZhY3RvciBtb2RpZnlfbGR0MDEgaW50byBuZXcgQVBJCgogaW5j
bHVkZS9sYXBpL2xkdC5oICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNTMgKysr
KysKIHRlc3RjYXNlcy9jdmUvY3ZlLTIwMTUtMzI5MC5jICAgICAgICAgICAgICAgICAgICAgIHwg
IDE1ICstCiB0ZXN0Y2FzZXMvY3ZlL2N2ZS0yMDE3LTE3MDUzLmMgICAgICAgICAgICAgICAgICAg
ICB8ICAxMCArLQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mb3JrL2ZvcmswNS5jICAgICAg
ICAgICAgfCAgIDQgKy0KIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW9kaWZ5X2xkdC8uZ2l0
aWdub3JlICAgIHwgICA4ICstCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21vZGlmeV9sZHQv
Y29tbW9uLmggICAgICB8ICAzMCArKysKIC4uLi9rZXJuZWwvc3lzY2FsbHMvbW9kaWZ5X2xkdC9t
b2RpZnlfbGR0MDEuYyAgICAgIHwgMjM0ICsrLS0tLS0tLS0tLS0tLS0tLS0tLQogLi4uL2tlcm5l
bC9zeXNjYWxscy9tb2RpZnlfbGR0L21vZGlmeV9sZHQwMi5jICAgICAgfCAyMjUgKysrKystLS0t
LS0tLS0tLS0tLS0KIC4uLi9rZXJuZWwvc3lzY2FsbHMvbW9kaWZ5X2xkdC9tb2RpZnlfbGR0MDMu
YyAgICAgIHwgMTE0ICsrLS0tLS0tLS0KIC4uLi9rZXJuZWwvc3lzY2FsbHMvbW9kaWZ5X2xkdC9t
b2RpZnlfbGR0MDQuYyAgICAgIHwgIDMyICsrKwogLi4uL2tlcm5lbC9zeXNjYWxscy9tb2RpZnlf
bGR0L21vZGlmeV9sZHQwNS5jICAgICAgfCAgMzcgKysrKwogLi4uL3N5c2NhbGxzL3NldF90aHJl
YWRfYXJlYS9zZXRfdGhyZWFkX2FyZWEuaCAgICAgfCAgMzEgLS0tCiAuLi4vc3lzY2FsbHMvc2V0
X3RocmVhZF9hcmVhL3NldF90aHJlYWRfYXJlYTAxLmMgICB8ICAxNCArLQogMTMgZmlsZXMgY2hh
bmdlZCwgMjY2IGluc2VydGlvbnMoKyksIDU0MSBkZWxldGlvbnMoLSkKLS0tCmJhc2UtY29tbWl0
OiBhNzkwZmFkZWEzNWU2NWI0NjAzMGY2MGUzODlkZWVlN2E2MTE4YzJiCmNoYW5nZS1pZDogMjAy
NTAzMjQtY29udmVyc2lvbnMtbW9kaWZ5X2xkdC04MTYzMjkyMjNmNmUKCkJlc3QgcmVnYXJkcywK
LS0gClJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+CgoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
