Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E28CCD193
	for <ltp@archiver.kernel.org>; Wed, 15 Oct 2025 10:15:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 571573CECFA
	for <ltp@archiver.kernel.org>; Wed, 15 Oct 2025 12:15:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D52B63CE95C
 for <ltp@lists.linux.it>; Wed, 15 Oct 2025 12:15:37 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 10ECE100093B
 for <ltp@lists.linux.it>; Wed, 15 Oct 2025 12:15:37 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-426f1574a14so846158f8f.3
 for <ltp@lists.linux.it>; Wed, 15 Oct 2025 03:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760523336; x=1761128136; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G92yyFKKLMqMe0FDbUx86gfMGVeygutugXOd20Apfe8=;
 b=C7ltTURyw7zG9J/tcNB3DvNeY40yNtpm42L5oy5vi76cP2aQOH7J/tadzrbs6W1Q+d
 Erq667SvkNDdBj39UtLLA+QdYcAyM4xVoJv+sD66JOgl2A1kQm4mBMARehCV1oI/3FKV
 dll935VmnBms3HxC7vBSMuIueHElKNVMF8YMiueJiFpcLg1Ir5KMBM/mhGMdHV0kMAH1
 LYcwiKW7mARm13y4Ct17rvsQCwfiHWwuRQwqUDu8yeegBgQK+bTW81If7l+ptX3miPkV
 rYNhJFvspxO1w5ZD1y13DiVWpOIbluus2sYuZuyFGrUuZUHxbapSFLt5K2IGMdOJB4J7
 Ts2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760523336; x=1761128136;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G92yyFKKLMqMe0FDbUx86gfMGVeygutugXOd20Apfe8=;
 b=dkYDxbxrSjVQjBSUwj1Gz6wSsxdLKghp7EfsUNiYsp78f7HSbzWLkIEd50NCg9OlJM
 VDiLgWdapmNp+WfRdkCnan2PsvaWuDQ620uYpswXVcC27vHEqCV6DIS/rp6Ay/bqME5u
 NtzaZ9dc6mJPz43y2l/6nc1LXIHuejmlIECXosR6EgVW+D/i0oKAskoD+lIHitSbpT3e
 NJS1ESS4tgr0i0xyRb/4whxGOFbu9dpErMs9F2QwFuQ+TBkr497jR9Q8KBhtFs7iOqYn
 pf31yxtBZo2vC3VrZqse6py7xNl0cR7HiM85DtO3t1bUUwPTdz+yfihBzmFVpxEFb5L2
 34lg==
X-Gm-Message-State: AOJu0YxMAlrsVRWdnWfKHq6c1XjQBM6nNv12V8+YLHX4OasVNnm2EU1T
 MrZ+bLHLVfJdCQwAl2b7Rjf/YRZEUJr5Ly1vMRIpuJHa1ABfV4FxccS3U5/MmPhoffAo2B9nyhP
 SdLvkzw==
X-Gm-Gg: ASbGnctS6+y/rtYQo0IGAG8mHlLgzrXW6U5dAktmMopR23F6LDKfCIfUVBQOnMFKeLB
 QUGix36Svy4hwfpM+FUDMpqQ7KkdHn8W3lYBdxQXH77PNFsu++sfmyAyLML1DNkR+pQC8IBgQWQ
 atSBCCJxmoICO8Lk802lyH4ZsiDnNb/7MolUZmbKsCIr3mgoKHDABWEpcOvhPkdyxXl5PVYtoK5
 GumpEIrmbg14iqFLilXQ3RwjRXSxHn28LWeoZ8FY1ELRxel7mMspanpNTzwjRY+X5MGaOlGRDa3
 8hjIJKH2l1Y/ubIdWrbKSG4EAOpiFTmHsDt4GKOEQAccc1zL3F8KbsmdXPbTp4cXJHocuF8U51k
 TX2EZ1KEDdijG3SLcyZWJBHom8/rhTkP0rI9zQijkqPa3EA9uLLdtimhV3AWbgQ==
X-Google-Smtp-Source: AGHT+IGmU7f1YhZiXeJwOT59+24j0NZUYBF8+0rL3Zc4TPLj+JrzW21RqlwQh8E9JHY3r4gcS/dKpg==
X-Received: by 2002:a05:6000:41d1:b0:403:6f7d:ac5d with SMTP id
 ffacd0b85a97d-4266e7dfaf4mr16627300f8f.34.1760523336154; 
 Wed, 15 Oct 2025 03:15:36 -0700 (PDT)
Received: from pickles.copeland.me.uk ([149.40.2.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5d0061sm28316910f8f.30.2025.10.15.03.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 03:15:35 -0700 (PDT)
From: Ben Copeland <ben.copeland@linaro.org>
To: ltp@lists.linux.it
Date: Wed, 15 Oct 2025 11:15:33 +0100
Message-ID: <20251015101533.30220-1-ben.copeland@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] overcommit_memory: Fix integer overflow and 32-bit
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
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/mem/tunable/overcommit_memory.c    | 33 +++++++++++++++----
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/mem/tunable/overcommit_memory.c b/testcases/kernel/mem/tunable/overcommit_memory.c
index 9b2cb479d..7ff5a98d0 100644
--- a/testcases/kernel/mem/tunable/overcommit_memory.c
+++ b/testcases/kernel/mem/tunable/overcommit_memory.c
@@ -131,24 +131,45 @@ static void overcommit_memory_test(void)
 	TST_SYS_CONF_LONG_SET(OVERCOMMIT_MEMORY, 2, 1);
 
 	update_mem_commit();
-	alloc_and_check(commit_left * 2, EXPECT_FAIL);
-	alloc_and_check(commit_limit + total_batch_size, EXPECT_FAIL);
+	/* Skip tests that would overflow or exceed 32-bit address space */
+	if (tst_kernel_bits() == 64 || (unsigned long)commit_left <= TST_GB / TST_KB) {
+		alloc_and_check(commit_left * 2, EXPECT_FAIL);
+		alloc_and_check(commit_limit + total_batch_size, EXPECT_FAIL);
+	} else {
+		tst_res(TCONF, "Skipping large allocation tests due to address space limits");
+	}
 	update_mem_commit();
-	alloc_and_check(commit_left / 2, EXPECT_PASS);
+	if (tst_kernel_bits() == 64 || (unsigned long)commit_left <= TST_GB / TST_KB) {
+		alloc_and_check(commit_left / 2, EXPECT_PASS);
+	} else {
+		tst_res(TCONF, "Skipping commit_left/2 allocation test due to address space limits");
+	}
 
 	/* start to test overcommit_memory=0 */
 	TST_SYS_CONF_LONG_SET(OVERCOMMIT_MEMORY, 0, 1);
 
 	update_mem();
 	alloc_and_check(free_total / 2, EXPECT_PASS);
-	alloc_and_check(sum_total * 2, EXPECT_FAIL);
+	/* Skip if sum_total * 2 would exceed address space.
+	 * On 32-bit, skip when sum_total > ULONG_MAX/4 (~1GB).
+	 * Most 32-bit systems with <=1GB RAM can map 2x that in 3GB vaddr space.
+	 * Systems with 2GB+ RAM likely cannot fit allocations in vaddr space. */
+	if (tst_kernel_bits() == 64 || (unsigned long)sum_total <= TST_GB / TST_KB) {
+		alloc_and_check(sum_total * 2, EXPECT_FAIL);
+	} else {
+		tst_res(TCONF, "Skipping large allocation test due to address space limits");
+	}
 
 	/* start to test overcommit_memory=1 */
 	TST_SYS_CONF_LONG_SET(OVERCOMMIT_MEMORY, 1, 1);
 
 	alloc_and_check(sum_total / 2, EXPECT_PASS);
-	alloc_and_check(sum_total, EXPECT_PASS);
-	alloc_and_check(sum_total * 2, EXPECT_PASS);
+	if (tst_kernel_bits() == 64 || (unsigned long)sum_total <= TST_GB / TST_KB) {
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
