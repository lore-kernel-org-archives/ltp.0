Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024CDCCA476
	for <ltp@archiver.kernel.org>; Fri, 10 Oct 2025 09:05:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A84C3CE991
	for <ltp@archiver.kernel.org>; Fri, 10 Oct 2025 11:05:43 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 728EF3C0F15
 for <ltp@lists.linux.it>; Fri, 10 Oct 2025 11:05:26 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8911F1A00E11
 for <ltp@lists.linux.it>; Fri, 10 Oct 2025 11:05:25 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e6c8bc46eso10759675e9.3
 for <ltp@lists.linux.it>; Fri, 10 Oct 2025 02:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760087125; x=1760691925; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=COYHfHkhGLYZFN06OB2xqecwn8KB5RXwctoYC22olVw=;
 b=wxhodONyhlSgP6KypVUr8kHSnx7WhbJKtWHABGDXPN4y3wq2vFWYNnMtsNT04yaYLT
 kTSY03r9Z99HDMHTtRdn7/ThDKxiqlUaQHoIo/aIByw2B96nJGs0bexYhvcJMBZU3ogM
 jTsG/QSzx2YkpqYeuU0Oq/OeawEuvoZUEiY31W8W7XZi/QqV9eEGVVRddeXDD3PqJ0Ow
 dkgujBnTP8M8BPqvjpH6vs7DOaPs3ahZJddef2jGUKWSniig02iKt7FScwZwDxu1jbI2
 NtWZtbD9TKbWimI8KxUf4OLumh9iuK/3QVqulfvS2MOoPgDKERK4DQf0Y5SXAXf+Hg0r
 LPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760087125; x=1760691925;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=COYHfHkhGLYZFN06OB2xqecwn8KB5RXwctoYC22olVw=;
 b=hfUhBZW7ZTAfj7nVYwjdYnBCFmI68gJCgBVIyPQHVrSJuP/stuoxXnsNVgcf0hifPM
 RXuG5Pf8FkMh6VepNpKcHzH1TVHguErozpObKHPq9l/2VqIFgA/l0rS/FvMn62PeIL/R
 YzlW1ciPP3PJuIyJIqDlSF0SkqZivZAMdjpzw684pHVLEwXskJgBwudnfZf22pQyObkf
 +XdrEpWP5jY/Y1FsGUR+KBSQHHOCmYnXWfNy0xb3my6u1MFAgoAqK1HOftM4Lw+SKxoR
 hDuBhVo3RORWZsmYnW4HORpdi74uU0wf8WMkrcapM6DufFg3ATBAPIEV4GebB1Q2t3Qt
 tquw==
X-Gm-Message-State: AOJu0YzXvElmL+ApXVllmTl8xexsS7bxsQMzyc3Mfz4wN8bJzIBo4WXX
 xgc/JUqaaNQdjc/B4/RpupAAkTHUAheFvq6aFlZzde1d9Vh7QLU0+Uz4IPfuT7hcXmhPh39IaAf
 WwDY=
X-Gm-Gg: ASbGncsoAGMswnVsiVCFDEqAxaFpzUfZ5jnWdmlRM5dln309VOj0yJkRkWUKNlxvzjo
 VPMnCXKos+ovnBi0nD05yNMujUULTl/H2ja45gK2tfMYQ0/ywePO4fKOYL+l6pTJ4BDaVOsj/4R
 zyx8iU04cVG0Of6v1saFVo7QAn/6Z8u+JDW17hEyj16irdv3ypMA/z+dHgIp+m5/k5JTYRtOpku
 rtYWEH3mOmLBmFzuaRPUiTFHty2XmmiRp1Gzmxx4wZ/0CHgYLR/EVCQ1QJxnI2lH/9eyKYnDKO7
 KJV2/U80vrKvdp1feutQdbEIUJbe2+2F0ysQPA8W6i6nG6r6XJxfKXL1GhgH3p0E43uD5hkPX4Q
 ZFYNkc6qVjtJzryC1jZukovmKIfWzbX6HCBHivhoCkShYm3/hqQJIyGaSRCzr9TsvKtUpDmcX
X-Google-Smtp-Source: AGHT+IFcrExRqrxC+8qLw+7KNK/axJJCfglCXbU7n7j702Qsu4qXGRtfWytkmqVKBu5FPfAWsEERTA==
X-Received: by 2002:a05:600c:4584:b0:46f:b42e:e367 with SMTP id
 5b1f17b1804b1-46fb42ee40cmr24219375e9.41.1760087124582; 
 Fri, 10 Oct 2025 02:05:24 -0700 (PDT)
Received: from pickles.copeland.me.uk ([149.40.2.133])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab3d2d65sm54585825e9.2.2025.10.10.02.05.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 02:05:24 -0700 (PDT)
From: Ben Copeland <ben.copeland@linaro.org>
To: ltp@lists.linux.it
Date: Fri, 10 Oct 2025 10:04:26 +0100
Message-ID: <20251010090426.2243464-1-ben.copeland@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] overcommit_memory: Fix integer overflow and 32-bit
 limits
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
Cc: arnd@arndb.de, lkft-triage@lists.linaro.org, dan.carpenter@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The overcommit test uses sum_total, the sum (memory and swap) to test
the overcommit settings.

This fixes two problems on 32-bit systems. The first is seen with a
integer overflow can occur when calculating sum_total * 2, if the
sum_total is larger than 2GB. The second is limited virtual address
space (2-3GB) means the test can fail from address space exhaustion
before overcommit has been tested.

Now the test runs correctly on low-memory 32-bit systems while avoiding
both the overflow bug and virtual address space issues.

Signed-off-by: Ben Copeland <ben.copeland@linaro.org>
---
 .../kernel/mem/tunable/overcommit_memory.c    | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/mem/tunable/overcommit_memory.c b/testcases/kernel/mem/tunable/overcommit_memory.c
index 9b2cb479d..f9f60ebc3 100644
--- a/testcases/kernel/mem/tunable/overcommit_memory.c
+++ b/testcases/kernel/mem/tunable/overcommit_memory.c
@@ -68,6 +68,7 @@
 #define DEFAULT_OVER_RATIO	50L
 #define EXPECT_PASS		0
 #define EXPECT_FAIL		1
+#define ONE_GB			(1024 * 1024 * TST_KB)
 
 #define OVERCOMMIT_MEMORY "/proc/sys/vm/overcommit_memory"
 #define OVERCOMMIT_RATIO "/proc/sys/vm/overcommit_ratio"
@@ -141,14 +142,26 @@ static void overcommit_memory_test(void)
 
 	update_mem();
 	alloc_and_check(free_total / 2, EXPECT_PASS);
-	alloc_and_check(sum_total * 2, EXPECT_FAIL);
+	/* Skip if sum_total * 2 would exceed address space.
+	 * On 32-bit, skip when sum_total > ULONG_MAX/4 (~1GB).
+	 * Most 32-bit systems with <=1GB RAM can map 2x that in 3GB vaddr space.
+	 * Systems with 2GB+ RAM likely cannot fit allocations in vaddr space. */
+	if (tst_kernel_bits() == 64 || (unsigned long)sum_total <= ONE_GB) {
+		alloc_and_check(sum_total * 2, EXPECT_FAIL);
+	} else {
+		tst_res(TCONF, "Skipping large allocation test due to address space limits");
+	}
 
 	/* start to test overcommit_memory=1 */
 	TST_SYS_CONF_LONG_SET(OVERCOMMIT_MEMORY, 1, 1);
 
 	alloc_and_check(sum_total / 2, EXPECT_PASS);
-	alloc_and_check(sum_total, EXPECT_PASS);
-	alloc_and_check(sum_total * 2, EXPECT_PASS);
+	if (tst_kernel_bits() == 64 || (unsigned long)sum_total <= ONE_GB) {
+		alloc_and_check(sum_total, EXPECT_PASS);
+		alloc_and_check(sum_total * 2, EXPECT_PASS);
+	} else {
+		tst_res(TCONF, "Skipping large allocation tests due to address space limits");
+	}
 
 }
 
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
