Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE076C77B7A
	for <ltp@archiver.kernel.org>; Thu,  1 Jun 2023 10:51:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A09353CEA41
	for <ltp@archiver.kernel.org>; Thu,  1 Jun 2023 12:51:47 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 476953CBCFB
 for <ltp@lists.linux.it>; Thu,  1 Jun 2023 12:51:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D60AD200C2D
 for <ltp@lists.linux.it>; Thu,  1 Jun 2023 12:51:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685616692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SPmjad0oZi3z4POnlJdxLqKisF0qUWwIb15l3sRcrTI=;
 b=YSE8oXr+KNX2+/sIUsoKc0BWr6ePBEa/n31QTs6RqwLnaxkZoSDlX/zuyBOi06rR7fbm3n
 PT8f+KS0jlcGkS9QJvMlW7cUqx2PICl0DRfsxmcLXu9piXVA2vHT5lRFHLW/huIHBE2SYy
 4GsnlGGlInP9V46X4JwLR3TJ0c9VitU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-502-ncpI5oWoPR6MgUBBQlbrxQ-1; Thu, 01 Jun 2023 06:51:30 -0400
X-MC-Unique: ncpI5oWoPR6MgUBBQlbrxQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C0F53C025A2
 for <ltp@lists.linux.it>; Thu,  1 Jun 2023 10:51:30 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 52EEB40C6EC4
 for <ltp@lists.linux.it>; Thu,  1 Jun 2023 10:51:29 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu,  1 Jun 2023 18:51:27 +0800
Message-Id: <20230601105127.55155-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] mem: make use of save_restore to simplify code
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/include/mem.h            |  1 -
 testcases/kernel/mem/lib/mem.c                |  2 --
 testcases/kernel/mem/oom/oom01.c              | 17 ++++------------
 testcases/kernel/mem/oom/oom02.c              | 14 ++++---------
 testcases/kernel/mem/oom/oom03.c              | 14 ++++---------
 testcases/kernel/mem/oom/oom04.c              | 14 ++++---------
 testcases/kernel/mem/oom/oom05.c              | 14 ++++---------
 testcases/kernel/mem/tunable/max_map_count.c  |  9 ++++-----
 .../kernel/mem/tunable/min_free_kbytes.c      |  8 ++++----
 .../kernel/mem/tunable/overcommit_memory.c    | 20 +++++--------------
 10 files changed, 33 insertions(+), 80 deletions(-)

diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index 776809113..cdc3ca146 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -42,7 +42,6 @@ static inline void clean_node(unsigned long *array)
 #define MLOCK			2
 #define KSM			3
 
-extern long overcommit;
 void oom(int testcase, int lite, int retcode, int allow_sigkill);
 void testoom(int mempolicy, int lite, int retcode, int allow_sigkill);
 
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 8ddd7adf7..fbfeef026 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -27,8 +27,6 @@
 
 /* OOM */
 
-long overcommit = -1;
-
 static int alloc_mem(long int length, int testcase)
 {
 	char *s;
diff --git a/testcases/kernel/mem/oom/oom01.c b/testcases/kernel/mem/oom/oom01.c
index 9f7d76587..b13699898 100644
--- a/testcases/kernel/mem/oom/oom01.c
+++ b/testcases/kernel/mem/oom/oom01.c
@@ -49,22 +49,13 @@ static void verify_oom(void)
 	testoom(0, 0, ENOMEM, 1);
 }
 
-static void setup(void)
-{
-	overcommit = get_sys_tune("overcommit_memory");
-}
-
-static void cleanup(void)
-{
-	if (overcommit != -1)
-		set_sys_tune("overcommit_memory", overcommit, 0);
-}
-
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
 	.max_runtime = TST_UNLIMITED_RUNTIME,
-	.setup = setup,
-	.cleanup = cleanup,
 	.test_all = verify_oom,
+	.save_restore = (const struct tst_path_val[]) {
+		{"/proc/sys/vm/overcommit_memory", NULL, TST_SR_TBROK},
+		{}
+	},
 };
diff --git a/testcases/kernel/mem/oom/oom02.c b/testcases/kernel/mem/oom/oom02.c
index b3719f723..8d565d12a 100644
--- a/testcases/kernel/mem/oom/oom02.c
+++ b/testcases/kernel/mem/oom/oom02.c
@@ -56,15 +56,6 @@ static void setup(void)
 {
 	if (!is_numa(NULL, NH_MEMS, 2))
 		tst_brk(TCONF, "The case need a NUMA system.");
-
-	overcommit = get_sys_tune("overcommit_memory");
-	set_sys_tune("overcommit_memory", 1, 1);
-}
-
-static void cleanup(void)
-{
-	if (overcommit != -1)
-		set_sys_tune("overcommit_memory", overcommit, 0);
 }
 
 static struct tst_test test = {
@@ -72,8 +63,11 @@ static struct tst_test test = {
 	.forks_child = 1,
         .max_runtime = TST_UNLIMITED_RUNTIME,
 	.setup = setup,
-	.cleanup = cleanup,
 	.test_all = verify_oom,
+	.save_restore = (const struct tst_path_val[]) {
+		{"/proc/sys/vm/overcommit_memory", "1", TST_SR_TBROK},
+		{}
+	},
 };
 
 #else
diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
index 0882c9bbe..778055d03 100644
--- a/testcases/kernel/mem/oom/oom03.c
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -79,27 +79,21 @@ static void verify_oom(void)
 
 static void setup(void)
 {
-	overcommit = get_sys_tune("overcommit_memory");
-	set_sys_tune("overcommit_memory", 1, 1);
-
 	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
 	SAFE_CG_PRINTF(tst_cg, "memory.max", "%lu", TESTMEM);
 }
 
-static void cleanup(void)
-{
-	if (overcommit != -1)
-		set_sys_tune("overcommit_memory", overcommit, 0);
-}
-
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
 	.max_runtime = TST_UNLIMITED_RUNTIME,
 	.setup = setup,
-	.cleanup = cleanup,
 	.test_all = verify_oom,
 	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
+	.save_restore = (const struct tst_path_val[]) {
+		{"/proc/sys/vm/overcommit_memory", "1", TST_SR_TBROK},
+		{}
+	},
 };
 
 #else
diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index ad39f7e77..d27d9d9e7 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -65,9 +65,6 @@ static void setup(void)
 	if (!is_numa(NULL, NH_MEMS, 1))
 		tst_brk(TCONF, "requires NUMA with at least 1 node");
 
-	overcommit = get_sys_tune("overcommit_memory");
-	set_sys_tune("overcommit_memory", 1, 1);
-
 	/*
 	 * Some nodes do not contain memory, so use
 	 * get_allowed_nodes(NH_MEMS) to get a memory
@@ -82,20 +79,17 @@ static void setup(void)
 	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
 }
 
-static void cleanup(void)
-{
-	if (overcommit != -1)
-		set_sys_tune("overcommit_memory", overcommit, 0);
-}
-
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
 	.max_runtime = TST_UNLIMITED_RUNTIME,
 	.setup = setup,
-	.cleanup = cleanup,
 	.test_all = verify_oom,
 	.needs_cgroup_ctrls = (const char *const []){ "cpuset", NULL },
+	.save_restore = (const struct tst_path_val[]) {
+		{"/proc/sys/vm/overcommit_memory", "1", TST_SR_TBROK},
+		{}
+	},
 };
 
 #else
diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
index e31146e7a..eb1a64267 100644
--- a/testcases/kernel/mem/oom/oom05.c
+++ b/testcases/kernel/mem/oom/oom05.c
@@ -85,9 +85,6 @@ void setup(void)
 	if (!is_numa(NULL, NH_MEMS, 1))
 		tst_brk(TCONF, "requires NUMA with at least 1 node");
 
-	overcommit = get_sys_tune("overcommit_memory");
-	set_sys_tune("overcommit_memory", 1, 1);
-
 	/*
 	 * Some nodes do not contain memory, so use
 	 * get_allowed_nodes(NH_MEMS) to get a memory
@@ -104,22 +101,19 @@ void setup(void)
 	SAFE_CG_PRINTF(tst_cg, "memory.max", "%lu", TESTMEM);
 }
 
-void cleanup(void)
-{
-	if (overcommit != -1)
-		set_sys_tune("overcommit_memory", overcommit, 0);
-}
-
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
 	.max_runtime = TST_UNLIMITED_RUNTIME,
 	.setup = setup,
-	.cleanup = cleanup,
 	.test_all = verify_oom,
 	.needs_cgroup_ctrls = (const char *const []){
 		"memory", "cpuset", NULL
 	},
+	.save_restore = (const struct tst_path_val[]) {
+		{"/proc/sys/vm/overcommit_memory", "1", TST_SR_TBROK},
+		{}
+	},
 };
 
 #else
diff --git a/testcases/kernel/mem/tunable/max_map_count.c b/testcases/kernel/mem/tunable/max_map_count.c
index caf8972e0..82a69a61e 100644
--- a/testcases/kernel/mem/tunable/max_map_count.c
+++ b/testcases/kernel/mem/tunable/max_map_count.c
@@ -54,21 +54,16 @@
 #define MAX_MAP_COUNT		65536L
 
 static long old_max_map_count = -1;
-static long old_overcommit = -1;
 
 static void setup(void)
 {
 	SAFE_ACCESS(PATH_SYSVM "max_map_count", F_OK);
 
 	old_max_map_count = get_sys_tune("max_map_count");
-	old_overcommit = get_sys_tune("overcommit_memory");
-	set_sys_tune("overcommit_memory", 0, 1);
 }
 
 static void cleanup(void)
 {
-	if (old_overcommit != -1)
-		set_sys_tune("overcommit_memory", old_overcommit, 0);
 	if (old_max_map_count != -1)
 		set_sys_tune("max_map_count", old_max_map_count, 0);
 }
@@ -213,4 +208,8 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = max_map_count_test,
+	.save_restore = (const struct tst_path_val[]) {
+		{"/proc/sys/vm/overcommit_memory", "0", TST_SR_TBROK},
+		{}
+	},
 };
diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
index eab6c8b2e..dd07a0323 100644
--- a/testcases/kernel/mem/tunable/min_free_kbytes.c
+++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
@@ -41,7 +41,6 @@
 
 volatile int end;
 static long default_tune = -1;
-static long orig_overcommit = -1;
 static unsigned long total_mem;
 
 static void test_tune(unsigned long overcommit_policy);
@@ -217,15 +216,12 @@ static void setup(void)
 	total_mem = SAFE_READ_MEMINFO("MemTotal:") + SAFE_READ_MEMINFO("SwapTotal:");
 
 	default_tune = get_sys_tune("min_free_kbytes");
-	orig_overcommit = get_sys_tune("overcommit_memory");
 }
 
 static void cleanup(void)
 {
 	if (default_tune != -1)
 		set_sys_tune("min_free_kbytes", default_tune, 0);
-	if (orig_overcommit != -1)
-		set_sys_tune("overcommit_memory", orig_overcommit, 0);
 }
 
 static struct tst_test test = {
@@ -235,4 +231,8 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = min_free_kbytes_test,
+	.save_restore = (const struct tst_path_val[]) {
+		{"/proc/sys/vm/overcommit_memory", NULL, TST_SR_TBROK},
+		{}
+	},
 };
diff --git a/testcases/kernel/mem/tunable/overcommit_memory.c b/testcases/kernel/mem/tunable/overcommit_memory.c
index 7fe8fe14c..ffb7a6d9d 100644
--- a/testcases/kernel/mem/tunable/overcommit_memory.c
+++ b/testcases/kernel/mem/tunable/overcommit_memory.c
@@ -70,7 +70,6 @@
 #define EXPECT_FAIL		1
 
 static char *R_opt;
-static long old_overcommit_memory = -1;
 static long old_overcommit_ratio = -1;
 static long overcommit_ratio;
 static long sum_total;
@@ -90,16 +89,11 @@ static void setup(void)
 	long mem_total, swap_total;
 	struct rlimit lim;
 
-	if (access(PATH_SYSVM "overcommit_memory", F_OK) == -1 ||
-	    access(PATH_SYSVM "overcommit_ratio", F_OK) == -1)
-		tst_brk(TCONF, "system doesn't support overcommit_memory");
-
 	if (R_opt)
 		overcommit_ratio = SAFE_STRTOL(R_opt, 0, LONG_MAX);
 	else
 		overcommit_ratio = DEFAULT_OVER_RATIO;
 
-	old_overcommit_memory = get_sys_tune("overcommit_memory");
 	old_overcommit_ratio = get_sys_tune("overcommit_ratio");
 
 	mem_total = SAFE_READ_MEMINFO("MemTotal:");
@@ -128,14 +122,6 @@ static void setup(void)
 	tst_res(TINFO, "TotalBatchSize is %ld kB", total_batch_size);
 }
 
-static void cleanup(void)
-{
-	if (old_overcommit_memory != -1)
-		set_sys_tune("overcommit_memory", old_overcommit_memory, 0);
-	if (old_overcommit_ratio != -1)
-		set_sys_tune("overcommit_ratio", old_overcommit_ratio, 0);
-}
-
 static void overcommit_memory_test(void)
 {
 
@@ -269,6 +255,10 @@ static struct tst_test test = {
 		{}
 	},
 	.setup = setup,
-	.cleanup = cleanup,
 	.test_all = overcommit_memory_test,
+	.save_restore = (const struct tst_path_val[]) {
+		{"/proc/sys/vm/overcommit_memory", NULL, TST_SR_TBROK},
+		{"/proc/sys/vm/overcommit_ratio", NULL, TST_SR_TBROK},
+		{}
+	},
 };
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
