Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276B5C531F9
	for <ltp@archiver.kernel.org>; Mon, 27 Jul 2026 02:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785119179; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=KSh8tG29kBgq5l78Y8lBS2yzSSebZRXBmOL6QhzRLAQ=;
 b=Ak3oAERP7ua7tdvI2fYRObEacU2vw173E1oOQIqNjjQP0ml5aR31W7rt9jokmYcV6Lt2q
 37h8LGdXkdn1eVWqAZPJJXPb3f8dUkGFIVZivDFfj49aWUOPvICfP13sXqJLE4RUtP3N08n
 0SJoUcpAvnEgRZ+MTQt6DaVp6nI16eM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 972E33D96E6
	for <ltp@archiver.kernel.org>; Mon, 27 Jul 2026 04:26:19 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EEBF33C2A5A
 for <ltp@lists.linux.it>; Mon, 27 Jul 2026 04:25:58 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1C6D01400335
 for <ltp@lists.linux.it>; Mon, 27 Jul 2026 04:25:57 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4956869750eso15882925e9.2
 for <ltp@lists.linux.it>; Sun, 26 Jul 2026 19:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785119157; x=1785723957; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g61hC8ypVzP6Js7Z3OV4q7bxMHMYBWexJJf9ppHXrRY=;
 b=RPjCv78+vI/J9Tx10XiqK080+/6RElQIYw8xSILS8ZtRarzvZj95M+aogPNRNB0z07
 IPbttaEbTBHwJu2TC7y6Vz/BhWABptI1XY9t14i3oPKsvvlXordSAHZwsnlONyOvbUR9
 SCdCSyppS1WeGdelCXh0gcqvMbvYFPoGJ5o7IZPB35XsUxMbdzHnzK0nYvAlME2vNUiS
 kMmhkfncUbd1707sH2NwF/rEkyh1TnxeA6AxJyYRHJdhQMMTWMDOO2D46OsH3YEiNpjh
 WJWs41X0HljSfsly5Ctkn7CYCn8v9OEJjjh6L+ZmHzoMGVsl1b7Zycvxo7A16/sDK7Y8
 +nrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785119157; x=1785723957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=g61hC8ypVzP6Js7Z3OV4q7bxMHMYBWexJJf9ppHXrRY=;
 b=Z4slXTGraHqL2tYfHV1h2G2vt2dKq/a+QhsrqYRiuIqSM9K6STV4OVSsLQG6g7FgXr
 gQ4YzPOc1He7tCTh7a0JOhnyNXHp6cHkjZXo872B6X1qrU6xJSndXBnmiosja4HRAPPi
 x48qd9gLKz6XZMIRyJA1tmYpy0sYQg2T3Hdiz3+lHPSiOYOu+SJ9d2X9STZnvPvnnNtc
 nXww53gDcR+KX2eGsilJgTk6ZWAUS4Pp7I8mPZtEVx1371wkmPqXUxvLEQO/92gp7wnO
 TrOEsptRQFLGY9FmNO3Taxf5/Gv47Dss+hm1SZr3Mi1fb34TIco+lm6OZd+FEUDBA2qk
 ngPQ==
X-Gm-Message-State: AOJu0Yxt8DlfHk2h5i9hRjENv078FSaIdiNdDsqmyyURydN/XeuniGBh
 2yMpdT30yiFHKm80ugfL7FNE+HKuS2DobdAIDkEGQGha6lYl2H5B/L7RDNE0smQq01EJA1MdpwC
 ev+c=
X-Gm-Gg: AR+sD13gtGzu55cadLfsHI7HTCWpM3hVoRLUaPxV4KBzYFpmDH3f1mkDtuIBas9N985
 YXN8uP8k7TcDOECz8tKy8VSi9RkDkkdYDVgM494pXOsWkkQKIOReTny+ps6CmwapwH70XepA/DT
 L24+DW7W847sSbTAormvK0AKmZwfvkWaMhHF0h7F7q4RlF3ywj0bS3z1+ZSIBeQJGDcIDmsq8eh
 OKGibXtYWo6canuLXcaYX0n/iBsCVvRYL4YKnS//US8Oqavj/5+HET4n45mMTShSSIzZBkbm1N8
 vJbJErKNMy4R6Eu+Lb2uGd+a8wS2A7f5xF+UgHkN5ZCq6jxSHM7qrZy5wnF5+gU8rD5+k8ACLN9
 mZuokCAVHXMkpviFnX1A8YuukBwj2qww9vrkGUYz1W2fkKxvHtvLuAqbGFRyrFbZkeA==
X-Received: by 2002:a05:600c:35d5:b0:490:e5c1:b8bf with SMTP id
 5b1f17b1804b1-496b56f385dmr86215895e9.13.1785119157373; 
 Sun, 26 Jul 2026 19:25:57 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-496b499c473sm180606855e9.11.2026.07.26.19.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 19:25:56 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 27 Jul 2026 02:25:43 +0000
Message-ID: <20260727022554.7966-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723094647.5051-1-wegao@suse.com>
References: <20260723094647.5051-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] madvise09: Scale cgroup memory/swap limits
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
system page size at runtime, and update the swap pre-check and doc
comments to match.

Signed-off-by: Wei Gao <wegao@suse.com>
---
v2->v3:
- Remove .min_swap_avail

 testcases/kernel/syscalls/madvise/madvise09.c | 27 ++++++++++++-------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise09.c b/testcases/kernel/syscalls/madvise/madvise09.c
index 5453f9411..2fc1da581 100644
--- a/testcases/kernel/syscalls/madvise/madvise09.c
+++ b/testcases/kernel/syscalls/madvise/madvise09.c
@@ -17,11 +17,11 @@
  * o Write to some of the madvised pages again, these must not be freed
  *
  * o Set memory limits
- *   - memory.max = 8MB
- *   - memory.swap.max = 16MB
+ *   - memory.max = 16 * PAGES * page_size (8MB on 4KB page size)
+ *   - memory.swap.max = 2 * memory.max (16MB on 4KB page size)
  *
  *   The reason for doubling the memory.max is to have safe margin
- *   for forking the memory hungy child etc. And the reason to setting
+ *   for forking the memory hungry child etc. And the reason to setting
  *   memory.swap.max to twice of that is to give the system chance
  *   to try to free some memory before cgroup OOM kicks in and kills
  *   the memory hungry child.
@@ -54,8 +54,8 @@ static int swap_accounting_enabled;
 #define TOUCHED_PAGE1 0
 #define TOUCHED_PAGE2 10
 
-#define MEM_LIMIT (8 * 1024 * 1024)
-#define SWAP_LIMIT (2 * MEM_LIMIT)
+static long long mem_limit;
+static long long swap_limit;
 
 static void memory_pressure_child(void)
 {
@@ -176,12 +176,12 @@ static void child(void)
 	ptr[TOUCHED_PAGE1 * page_size] = 'b';
 	ptr[TOUCHED_PAGE2 * page_size] = 'b';
 
-	SAFE_CG_PRINTF(tst_cg, "memory.max", "%d", MEM_LIMIT);
-	tst_res(TINFO, "Setting memory.max to %d bytes", MEM_LIMIT);
+	SAFE_CG_PRINTF(tst_cg, "memory.max", "%lld", mem_limit);
+	tst_res(TINFO, "Setting memory.max to %lld bytes", mem_limit);
 
 	if (swap_accounting_enabled) {
-		SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%d", SWAP_LIMIT);
-		tst_res(TINFO, "Setting memory.swap.max to %d bytes", SWAP_LIMIT);
+		SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%lld", swap_limit);
+		tst_res(TINFO, "Setting memory.swap.max to %lld bytes", swap_limit);
 	} else {
 		tst_res(TINFO, "memory.swap.max is unavailable, running without SWAP_LIMIT");
 	}
@@ -284,6 +284,14 @@ static void setup(void)
 		tst_res(TINFO, "Swap accounting is disabled");
 
 	page_size = getpagesize();
+
+	mem_limit = 16 * PAGES * page_size;
+	swap_limit = 2 * mem_limit;
+
+	if (tst_available_swap() < swap_limit / 1024) {
+		tst_brk(TCONF, "System needs at least %lldMB free swap to run this test",
+			swap_limit / TST_MB);
+	}
 }
 
 static struct tst_test test = {
@@ -291,6 +299,5 @@ static struct tst_test test = {
 	.test_all = run,
 	.needs_root = 1,
 	.forks_child = 1,
-	.min_swap_avail = SWAP_LIMIT / TST_MB,
 	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
 };
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
