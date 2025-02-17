Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A7AC021AA
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 12:49:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 420353C9BF5
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 13:49:00 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 109BE3C0722
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 13:48:39 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=dbassey@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3B0187C33DD
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 13:48:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739796517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4ZhlTnOjaZj1wqfZ7trlXzYqJZPPlR0UIPX1SmRv9fU=;
 b=c3612xVEV2noX7pmzIL9Vta5yV3v/RU3lTpdOE9v5DLwql7cKX7ysFXJ1/hClLUXXtQlmM
 tvX9DikjuDsRCTr0jHecXu1HhpN9WSJqt4y08+j9JJ0Ps0lSvl/PGVYitjmBRenqYz3n20
 OWQ8Uk13XYk7wwNH70x37nYgK+smhVA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-p-TGjKvROHmTFrbpAOfXEA-1; Mon, 17 Feb 2025 07:48:35 -0500
X-MC-Unique: p-TGjKvROHmTFrbpAOfXEA-1
X-Mimecast-MFC-AGG-ID: p-TGjKvROHmTFrbpAOfXEA_1739796514
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38f443b4949so404734f8f.3
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 04:48:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739796514; x=1740401314;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4ZhlTnOjaZj1wqfZ7trlXzYqJZPPlR0UIPX1SmRv9fU=;
 b=F658rRza7vnQfVckOEBxR3vSYMh06c6DwDsr1TCqBu766reC64JB+yHVksJpnD9/Rv
 t/5OI3Sk6INQUV/Y6BJ4UT8dzczHjgKeL6O+HQiNJ/BZKY/lvK/Xdgm0CB4/gHvgW1tZ
 VB+pc5hPrILz8JawKJ7o0SLCwcv42hhFYF/kybzJBNgRjGpwelYfLYaWxH9FLx6wRC10
 cvKViDoPnt/vfKjpp1Z94EcGyHqmKDyzkf0ggRV+mt5YLH4rkUYL7MPMXD3XCprT1Cbb
 7J8sGbPesFjl2mRK0MYSJ7t7gvaOcvyCjV53I8SnZF0KlZ1EHV4YvzJHVMm3nwsXAeZZ
 ZRwg==
X-Gm-Message-State: AOJu0YzCGgl/j/Pa8LSDSgE92dAVry3n2a6YMNB0yVQp/AUjGTqmaJHf
 AGURpqmP50nanMVDoqrpho8/RAAHgIqbs1ed/I2vZO3GZuDuuPZCHm+T59uQsEwxj7H+Bpt2fx7
 467vjMbG1i6i7FIAOFoXK/AQYmEGNdP4l77RuPREORO4X7ihfT4I9QZZyBMnEENIuOU/CWX31iN
 nj5d1um9fg/lY3IEBuGRu51xKlEpuE44e+4w==
X-Gm-Gg: ASbGncvqefoj4arZkXo1DIqetdXN27bZA6BKlHFBN39vCfqHT4hLA8NEp6FBsLUaHt2
 oXRAlXayeDnHhu4MtGTYpX7ZY6s4Elg11r0TOtzc+3I9nsDboelvxD6K79HIMRbPEYCPzO7jD6e
 fQsjG2Y2dXSQtpFTMvoZ9UBn5LNH+3lRJCdZMGbMtoOUeiLgIwF+E6ICfVW6G1zs/jmCrCg2y6F
 AfnNXX4lDVHRqNWsnVN75Ynlwxpst+f0cfKEeppOIP7NrCkw8JIRb+/jbxImnpMRUxfDsYKhWSd
 CwJoiywVJ8WLwE7Mcm1NdzH9uKPVoI3LwmLtvOzEHS0=
X-Received: by 2002:a05:6000:2a2:b0:38f:4531:397a with SMTP id
 ffacd0b85a97d-38f45313c4fmr3146118f8f.3.1739796513980; 
 Mon, 17 Feb 2025 04:48:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyPcCNCE44eQa6XGILiWXlqlE5MG5NAovw62kO3OmPQ67TipMBU2yM3ntCrl6lRNWXF7mHJQ==
X-Received: by 2002:a05:6000:2a2:b0:38f:4531:397a with SMTP id
 ffacd0b85a97d-38f45313c4fmr3146088f8f.3.1739796513633; 
 Mon, 17 Feb 2025 04:48:33 -0800 (PST)
Received: from 2624797214.wifi.kn.vutbr.com (nat-kn.net.vutbr.cz.
 [147.229.117.40]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258cccdesm12171686f8f.26.2025.02.17.04.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 04:48:33 -0800 (PST)
From: Dorinda Bassey <dbassey@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 17 Feb 2025 13:43:48 +0100
Message-ID: <20250217124804.143890-2-dbassey@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3s5l4PVVtKaEtxCAur6-T_BwgF3VxTjUam_256B1rzY_1739796514
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] kcmp03: Add check for KCMP_SYSVSEM before running
 test
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
Cc: sbertram@redhat.com, javierm@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This commit introduces a new function
`is_kcmp_supported()` to check if the kernel supports the
`KCMP_SYSVSEM` operation. In the `verify_kcmp()` function,
we add logic to detect when the kernel does not support
`KCMP_SYSVSEM` and skip the test for that case with a TCONF
result. This ensures that the test does not fail when the
Kconfig that supports `KCMP_SYSVSEM` is unavailable.

Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
---
v2 changes
fix coding style
use `kcmp()` instead of `syscall()`
do `is_kcmp_supported()` check in the setup and
cache result
use `tst_res` instead of `tst_brk`

 testcases/kernel/syscalls/kcmp/kcmp03.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/testcases/kernel/syscalls/kcmp/kcmp03.c b/testcases/kernel/syscalls/kcmp/kcmp03.c
index 37d5118d5..8610cea46 100644
--- a/testcases/kernel/syscalls/kcmp/kcmp03.c
+++ b/testcases/kernel/syscalls/kcmp/kcmp03.c
@@ -42,9 +42,19 @@ static struct tcase {
 	{ARGS(CLONE_SYSVSEM, KCMP_SYSVSEM)}
 };
 
+static int is_kcmp_supported_flag = -1;
+
+static int is_kcmp_supported(void)
+{
+	return kcmp(getpid(), getpid(), KCMP_SYSVSEM, 0, 0) == 0;
+}
+
 static void setup(void)
 {
 	stack = SAFE_MALLOC(STACK_SIZE);
+
+	if (is_kcmp_supported_flag == -1)
+		is_kcmp_supported_flag = is_kcmp_supported();
 }
 
 static void cleanup(void)
@@ -64,6 +74,14 @@ static void verify_kcmp(unsigned int n)
 	int res;
 	struct tcase *tc = &tcases[n];
 
+    // Handle the case for KCMP_SYSVSEM specifically
+	if (tc->kcmp_type == KCMP_SYSVSEM) {
+		if (is_kcmp_supported_flag == 0) {
+			tst_res(TCONF, "Kernel does not support KCMP_SYSVSEM, skipping test.");
+			return;
+		}
+	}
+
 	pid1 = getpid();
 	tst_res(TINFO, "Testing %s", tc->desc);
 
-- 
2.48.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
