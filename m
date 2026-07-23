Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86C6C44524
	for <ltp@archiver.kernel.org>; Thu, 23 Jul 2026 07:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784793226; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=8CG3C2ieqx5JyYam6ia5lXh4YUP9HixVT7n9iTzpz+A=;
 b=aZD7EeiGaWxRMXMwrC8nwHTuvYU3zjhQRuEx4Vo+ASRwpT4lRuaiAl0g9CZvZ1f6P9Blx
 uQNryYB4HzQcrXwFY6wDoh1yUofj0ceairVa8pUI2RGUNRIad/rynRxJLGI2phz9U9iFsPp
 I6BgHfm2FQJZH7TsaG/NzIPLiqwu5PI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B5DB3E2448
	for <ltp@archiver.kernel.org>; Thu, 23 Jul 2026 09:53:46 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4AF253C9179
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 09:53:22 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E393D10008FD
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 09:53:21 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-47362928f65so277608f8f.2
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 00:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784793201; x=1785398001; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xmeANYyeHgHUDKZiizE3/Kl+0MEyR/6VLZbl+woNAi4=;
 b=YLVM6p5NQgvPEgAOPlPeRzlVo8s4FtgEd/Yeuq3f5EhFcdgzk/bBX9WhEZh9vKG9tz
 o1KvoLi/kCz10vh+MO1iXvr41yyaYrsBd2BQ0mjVIOk935lKxkUGZzjZ1Q7A7dnAiUIk
 J/hg5+1F328/HgpbTPd023VRwTPB1dx62TKuvUe4ge2TmGpSNHVB0bhKB1S+LkApV8X1
 ONdy0QEndnxIvCJvQqnQu2xLSR3DbyRj9USyx9N3iJK4Sxuv3fB7VztujT1h3PhrPSWg
 51pNKf4ju7v8GrdEGTxGNTO2cnbFbSMLrMx912qf20QkMnVHcFeHmGeVx5sJh/jJhHoD
 qz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784793201; x=1785398001;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xmeANYyeHgHUDKZiizE3/Kl+0MEyR/6VLZbl+woNAi4=;
 b=ZKhjT5L1SMUozTIJxgKjeVuXLfMZOUq5ELO3xAi5nMoU9Xr5m3verbBslj29Wtq+fU
 WW8OW2ZBd+Y4tb1/ceGyITvXkP/6a8f1Wj05ENm4BaFayovRoEW63vH+onr/p+CmGwHX
 MhfN2VJd+AMrfHLT94r8N9CaPadNr4AEEZXIKGQGCcMyPdxAgbo3H7TA1QVSL3/dUChS
 pR/o1Lfqb8fCMqpINTDGPF8Cj70ZwdmT8Cn+nCy8RCoslfjjYSfvKH7qT+32n/Memelx
 xqoUVjKvIDbXIDrpKVXhpqg78TJmpBnNPU6gr9ajcwYEk+vH2uHcHLFk9X7uiUEIK6EL
 blSA==
X-Gm-Message-State: AOJu0YzL0Q6WAGyflHc7alM4ZlUOsNaln9jVITUl5F6CAc6HcOI/n6kV
 d/BKbo7B2zbje2nwQHtkgypjbAtOZVTc1bG6I2kmYlgb9/SJStGAkoLvROnhna5fxrdAJrRtDYz
 ngzU=
X-Gm-Gg: AR+sD1243gCSPEgJfwfKelTiHBKMTvO15m+D74aSwrN1q0KiTNMgM6DEHygOKZHe0Ok
 fyRDhN830gQpj8IywMDzJcLBdw5wz7muf96Q6582E0xbymrpveMZgnUzL75G/dLMum5hoEIK2m0
 6KPxocwX5DP0UTGvdUoIcKgyx6/r8I/5iL+N3L0tII4R5RLEaVGgLcAYyISHLlJEuSoKZh3XS8x
 eFDfWw1Txwgb0KbQrpF5X25i/+gyBAnL6v3XIZwrMHi36Sv39CnX8r84cWzm1OuYEVftnh55TyA
 KcU+2Mqcmatn/8Ssn71d50uzxpmYN+HVmKCBzWed7CKywgIlRdmX39XPvMvvdoUFnSFebwQXfMd
 NmT0ZlG295zXu0GuLTaHkfMXiBTUCAV6kiFSsxiM5Q8x9uBxzQj8iziJq6GIlSgo6DQ==
X-Received: by 2002:a05:6000:98b:b0:475:f0d1:eb63 with SMTP id
 ffacd0b85a97d-47f8d76dc78mr2352596f8f.48.1784793201332; 
 Thu, 23 Jul 2026 00:53:21 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-47f85b9a659sm13843644f8f.6.2026.07.23.00.53.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 00:53:21 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 23 Jul 2026 07:53:15 +0000
Message-ID: <20260723075319.4920-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] madvise09: Scale cgroup memory/swap limits
 dynamically with page size
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On systems with 64KB page size (such as ppc64le), the mapped footprint
of PAGES (128) is 128 * 64KB = 8MB. Since the cgroup MEM_LIMIT was
hardcoded to 8MB, there was zero headroom left for the parent's process
overhead, resulting in OOM when trying to fork the memory pressure
process.

This caused the test to enter an infinite "Both children killed,
retrying..." loop.

Fix this by scaling mem_limit and swap_limit dynamically based on the
system page size at runtime. Also add a dynamic swap availability check
in setup() using tst_available_swap() to skip gracefully on machines
lacking sufficient swap space, and define BASE_SWAP_LIMIT for the static
.min_swap_avail check.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/madvise/madvise09.c | 24 +++++++++++++------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise09.c b/testcases/kernel/syscalls/madvise/madvise09.c
index 5453f9411..567782896 100644
--- a/testcases/kernel/syscalls/madvise/madvise09.c
+++ b/testcases/kernel/syscalls/madvise/madvise09.c
@@ -54,8 +54,10 @@ static int swap_accounting_enabled;
 #define TOUCHED_PAGE1 0
 #define TOUCHED_PAGE2 10
 
-#define MEM_LIMIT (8 * 1024 * 1024)
-#define SWAP_LIMIT (2 * MEM_LIMIT)
+#define BASE_SWAP_LIMIT (16 * 1024 * 1024)
+
+static long mem_limit;
+static long swap_limit;
 
 static void memory_pressure_child(void)
 {
@@ -176,12 +178,12 @@ static void child(void)
 	ptr[TOUCHED_PAGE1 * page_size] = 'b';
 	ptr[TOUCHED_PAGE2 * page_size] = 'b';
 
-	SAFE_CG_PRINTF(tst_cg, "memory.max", "%d", MEM_LIMIT);
-	tst_res(TINFO, "Setting memory.max to %d bytes", MEM_LIMIT);
+	SAFE_CG_PRINTF(tst_cg, "memory.max", "%ld", mem_limit);
+	tst_res(TINFO, "Setting memory.max to %ld bytes", mem_limit);
 
 	if (swap_accounting_enabled) {
-		SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%d", SWAP_LIMIT);
-		tst_res(TINFO, "Setting memory.swap.max to %d bytes", SWAP_LIMIT);
+		SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%ld", swap_limit);
+		tst_res(TINFO, "Setting memory.swap.max to %ld bytes", swap_limit);
 	} else {
 		tst_res(TINFO, "memory.swap.max is unavailable, running without SWAP_LIMIT");
 	}
@@ -284,6 +286,14 @@ static void setup(void)
 		tst_res(TINFO, "Swap accounting is disabled");
 
 	page_size = getpagesize();
+
+	mem_limit = 16 * PAGES * page_size;
+	swap_limit = 2 * mem_limit;
+
+	if (tst_available_swap() < swap_limit / 1024) {
+		tst_brk(TCONF, "System needs at least %ldMB free swap to run this test",
+			swap_limit / TST_MB);
+	}
 }
 
 static struct tst_test test = {
@@ -291,6 +301,6 @@ static struct tst_test test = {
 	.test_all = run,
 	.needs_root = 1,
 	.forks_child = 1,
-	.min_swap_avail = SWAP_LIMIT / TST_MB,
+	.min_swap_avail = BASE_SWAP_LIMIT / TST_MB,
 	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
 };
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
