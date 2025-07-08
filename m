Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E464BC83F09
	for <ltp@archiver.kernel.org>; Tue,  8 Jul 2025 20:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752005544; h=date :
 message-id : mime-version : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=pU9ka10qlT+egVL77qYplLaY+hHaMEKHsk3u3blYg8k=;
 b=hQYmkhbzQzE0MosQdApZm0t7ZGcZT/AdqVyjWUk/O9vBzxKMdOcU2i9NWAajNhXQt06+x
 mQzGN/1rtr/9tVSCJ85V7B2hkUeNdaW6NQCPNXKoxi2/u+fn84BJKe1rn8MR4dXYUr8+hrP
 JpZlUNvWzOmzkqPj1j0yIPdeiQf88kM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E7BEB3CA4EA
	for <ltp@archiver.kernel.org>; Tue,  8 Jul 2025 22:12:24 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 042A33C2565
 for <ltp@lists.linux.it>; Tue,  8 Jul 2025 22:12:02 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4C2E31A00782
 for <ltp@lists.linux.it>; Tue,  8 Jul 2025 22:12:02 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a4e742dc97so167096f8f.0
 for <ltp@lists.linux.it>; Tue, 08 Jul 2025 13:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752005521; x=1752610321; darn=lists.linux.it;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Qp9pbXfo3RqyKOZsHVUc7Vk8JK8hboxDBigaUzvvFZ0=;
 b=LNz0ZueHARzeJgGKckyAVK2EFnF67rK3i8EqMC1/NBYQ53tv7LHFDDU/n1J80sPYZV
 ZBtRzFaxKZl/XMXzZFNdeHaVrjxY2dLBEjWCMNmOqR/y0NetFP1pO3VmTLU+0U1jZrUj
 orrhx/pe/9FSVJs7YRpzyRSnrG5pDcdATNsI2F7hxaGGJ1cBwqEfQC4cwu631lC8yktd
 9YEiyT2Tp/HxjR7+3W8rwT7e3KKMPnfPoz1hpYE55yYqe4hpZYF1AwtS4gMEI/tjnuVr
 ZXrWkBV9OXaInpq11zVf3dcazQW9NVnimAqgA7iKg8Nw49LPv3oAaEdGO0Y1S5MDubbL
 BDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752005521; x=1752610321;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qp9pbXfo3RqyKOZsHVUc7Vk8JK8hboxDBigaUzvvFZ0=;
 b=qoga3L3md/f4tSrpbyCFHTcw1Xhb7rTC+EFVBEL4PD/CRYbynH/563i8e0etYUaa0V
 Y3DN25OgDOHOY1sio8yTsVNc7GD0Gu6HzOXbvGkvDl2b4du3NkkNDQhzo25xYGTv9cQq
 X7aL5C76LDG4E+0IXQGVIEmUnxlPENTwLG3TfYPvIgUztHw8+TgOfCKN3JP6wH6gyRcs
 PSWx1MV05HWU7zYkX3zh3HJJaoHbQwXxjgvPDI+IpNaFHJjsacS0mORv1e5/mBG4UBDn
 UMM8RrSoutfvOJi5sBxxoIcaKBm8h0RfxLXbetVLbhkZbFtK9IF1oxwkL99ydiBU2tww
 0RfA==
X-Gm-Message-State: AOJu0YwJQCvrCuygX7cxLNHRrVC9xkBdsKSqpf9Cba9zK+gWpZ2q11JK
 HirkkLtQswpiEf95dls4WzfDfZwehc/W0thsMPezvUnQUB4rLCrhS8zkFi/F61naWmMCg/QmQfy
 ItT6F
X-Gm-Gg: ASbGncsN6Ngpaqwd3ADmrtkJ3ceiVBYWCJ1BWYHCQG8Ymw/WWVDXzMxtLk2A6GgVWf8
 Px7lhzqZXyHfVZsJ66EOv59pOIi2M/XA2DGCRlYcaTzv8Ou86Ad3sYXbu0vpr7eWBvrB//1Z2/H
 3ERbi6Khjfnp+mBGQaOwwbbsWFohwa5D4EKv+ttEbbhWX927txAgHXKGYiTtRhfQ+CmUPQz0NJ+
 RO5c0zjrZrwE2GIA77fZHXMxJ2vjJICkB9uUT9fZvPtACRhWWuk5Ye9E2lrrxNPzIly9dwmUtZx
 kkXqef+m64XqmGE1g0lVJBWFiIAFprHbfPdGVqSezFvDl3stNw==
X-Google-Smtp-Source: AGHT+IEiGJXDFqqb32cRkTGcZSOBAaHuXSzMRjg9c9vRVFtOTGsVrTDRVYnnkdZXkFfceE8AAzaZPQ==
X-Received: by 2002:a05:6000:2f85:b0:3b3:9c46:de96 with SMTP id
 ffacd0b85a97d-3b5de020564mr3941767f8f.21.1752005521261; 
 Tue, 08 Jul 2025 13:12:01 -0700 (PDT)
Received: from localhost ([177.45.162.214])
 by smtp.gmail.com with UTF8SMTPSA id
 af79cd13be357-7d5dbdbd646sm826649785a.41.2025.07.08.13.11.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 13:12:00 -0700 (PDT)
Date: Tue, 08 Jul 2025 17:11:54 -0300
Message-Id: <20250708-conversions-mremap-v1-0-aa043b0182fc@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIp7bWgC/x3MQQqDQAyF4atI1g3EQWn1KtJFHGPNYkZJRAri3
 Tt2+cF7/wkupuLQVyeYHOq65oL6UUFcOH8EdSqGQKGlJ70wrvkQu2eOySTxhk3dBpojhW5qoBw
 3k1m//+jwLh7ZBUfjHJc7ldh3MbiuH4MOJqt9AAAA
X-Change-ID: 20250708-conversions-mremap-41520fc029d4
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1249; i=rbm@suse.com;
 h=from:subject:message-id; bh=IVKJNtkLPGexgqgSPRCpaDTN1DffG6B1GQxFeu8AU6k=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBobXuL4zKypzZXGP8MzQYDvluoVSI+4s9EhyqnH
 q+3fbuMGzqJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaG17iwAKCRDJC4p8Y4ZY
 pqd3D/sGbFqpH+r/PeA98zyXAYKMGG3Wa1+APV3iessc92p6N6IcEJqKB744riFtWCxfguEZXTE
 43r8ajYdtkdycRk/osnrf6ri0gPUT1t8MWCqlmmtHH6QHpI10le7tVUqZif6OCgG5zqmI7UDeeN
 LacfsI7OLnhVM1N77WLtlgZIxbGOmSjp8qOPLcZ5Xfu1NEvR0svyxUYvF82rdEZCPLBSi+1TvfM
 ZX7HUqeIXktJyEqaz1j39h02R/z8y87t578mrXeXne8HbUu/fuleRcAoubGW2XPuY15BWyY2hJt
 LCIWERkVxkoLQju041tPyhQgolhzcta1OGLYTBrxNX39aDsjh2AxMtUZ+s60L0aQTDad02Z4QLj
 BqWgK4CwrKX9GsqvMYk3BswFT8Xb7ND2/0kzR5sCQeMrlIARUG/2tu3IswWV4gi1pfh3V5HIX8C
 VjhD3o2Daj7HvRKUkC1Er2NbK392yppYZgNEAGE64p5CY1uQz8HruK1Z/xaQncZYzbknQRtOwCS
 BoKLtLUAVwz7MVOJ8v7xvaSoduQpT5qWH76N9zHBakSkmRF0ypaCbRrqDq1SNTVOe8GcK/rl9zc
 YXPV1ocRbN7piE/PeUgIbPyIjjWidDtY4TwI5nimX51MbIuV92tJ5n2+WX08na6rbExJkZPqEH0
 8I2VYGs2E3425ag==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/7] syscalls: mremap: Convert to new API
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

U2lnbmVkLW9mZi1ieTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KLS0tClJp
Y2FyZG8gQi4gTWFybGnDqHJlICg3KToKICAgICAgbGliOiBzYWZlX21hY3JvczogRml4IG1lbWFs
aWduKCkgZmFpbHVyZSBlcnJvciBmb3JtYXQKICAgICAgbGliOiBzYWZlX21hY3JvczogQWRkIFNB
RkVfTVJFTUFQCiAgICAgIHN5c2NhbGxzOiBtcmVtYXAwMTogQ29udmVydCB0byBuZXcgQVBJCiAg
ICAgIHN5c2NhbGxzOiBtcmVtYXAwMjogQ29udmVydCB0byBuZXcgQVBJCiAgICAgIHN5c2NhbGxz
OiBtcmVtYXAwMzogQ29udmVydCB0byBuZXcgQVBJCiAgICAgIHN5c2NhbGxzOiBtcmVtYXAwNDog
Q29udmVydCB0byBuZXcgQVBJCiAgICAgIHN5c2NhbGxzOiBtcmVtYXAwNTogQ29udmVydCB0byBu
ZXcgQVBJCgogaW5jbHVkZS9zYWZlX21hY3Jvc19mbi5oICAgICAgICAgICAgICAgICAgICB8ICAg
MiArCiBpbmNsdWRlL3RzdF9zYWZlX21hY3Jvcy5oICAgICAgICAgICAgICAgICAgIHwgICA0ICsK
IGxpYi9zYWZlX21hY3Jvcy5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTggKy0KIHRl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbXJlbWFwL01ha2VmaWxlICAgfCAgIDQgKy0KIHRlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvbXJlbWFwL21yZW1hcDAxLmMgfCAyNTggKysrKystLS0tLS0t
LS0tLS0tLS0tLS0tLS0KIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbXJlbWFwL21yZW1hcDAy
LmMgfCAxOTIgKysrLS0tLS0tLS0tLS0tLS0tLS0KIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
bXJlbWFwL21yZW1hcDAzLmMgfCAxOTYgKysrLS0tLS0tLS0tLS0tLS0tLS0KIHRlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvbXJlbWFwL21yZW1hcDA0LmMgfCAyNjUgKysrKystLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21yZW1hcC9tcmVtYXAwNS5jIHwg
MjcwICsrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0KIDkgZmlsZXMgY2hhbmdlZCwgMjgzIGlu
c2VydGlvbnMoKyksIDkyNiBkZWxldGlvbnMoLSkKLS0tCmJhc2UtY29tbWl0OiBlNTMyNGQyZWZk
M2JkYjhlMGQxNTFhZDA4NDAyMjJhN2E1ZWYxZGQ4CmNoYW5nZS1pZDogMjAyNTA3MDgtY29udmVy
c2lvbnMtbXJlbWFwLTQxNTIwZmMwMjlkNAoKQmVzdCByZWdhcmRzLAotLSAKUmljYXJkbyBCLiBN
YXJsacOocmUgPHJibUBzdXNlLmNvbT4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
