From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue,  4 May 2021 14:41:00 +0100
Subject: [LTP] [PATCH v6 7/7] madvise06: Convert to new CGroups API
In-Reply-To: <20210504134100.20666-1-rpalethorpe@suse.com>
References: <20210504134100.20666-1-rpalethorpe@suse.com>
Message-ID: <20210504134100.20666-8-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/madvise/madvise06.c | 129 ++++++++----------
 1 file changed, 60 insertions(+), 69 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise06.c b/testcases/kernel/syscalls/madvise/madvise06.c
index 56e0700d6..63d8d5452 100644
--- a/testcases/kernel/syscalls/madvise/madvise06.c
+++ b/testcases/kernel/syscalls/madvise/madvise06.c
@@ -3,39 +3,38 @@
  * Copyright (c) 2016 Red Hat, Inc.
  */
 
-/*
- * DESCRIPTION
- *
- *   Page fault occurs in spite that madvise(WILLNEED) system call is called
- *   to prefetch the page. This issue is reproduced by running a program
- *   which sequentially accesses to a shared memory and calls madvise(WILLNEED)
- *   to the next page on a page fault.
+/*\
+ * [Description]
  *
- *   This bug is present in all RHEL7 versions. It looks like this was fixed in
- *   mainline kernel > v3.15 by the following patch:
+ * Page fault occurs in spite that madvise(WILLNEED) system call is called
+ * to prefetch the page. This issue is reproduced by running a program
+ * which sequentially accesses to a shared memory and calls madvise(WILLNEED)
+ * to the next page on a page fault.
  *
- *   commit 55231e5c898c5c03c14194001e349f40f59bd300
- *   Author: Johannes Weiner <hannes@cmpxchg.org>
- *   Date:   Thu May 22 11:54:17 2014 -0700
+ * This bug is present in all RHEL7 versions. It looks like this was fixed in
+ * mainline kernel > v3.15 by the following patch:
  *
- *       mm: madvise: fix MADV_WILLNEED on shmem swapouts
+ *  commit 55231e5c898c5c03c14194001e349f40f59bd300
+ *  Author: Johannes Weiner <hannes@cmpxchg.org>
+ *  Date:   Thu May 22 11:54:17 2014 -0700
  *
- *   Two checks are performed, the first looks at how SwapCache
- *   changes during madvise. When the pages are dirtied, about half
- *   will be accounted for under Cached and the other half will be
- *   moved into Swap. When madvise is run it will cause the pages
- *   under Cached to also be moved to Swap while rotating the pages
- *   already in Swap into SwapCached. So we expect that SwapCached has
- *   roughly MEM_LIMIT bytes added to it, but for reliability the
- *   PASS_THRESHOLD is much lower than that.
+ *     mm: madvise: fix MADV_WILLNEED on shmem swapouts
  *
- *   Secondly we run madvise again, but only on the first
- *   PASS_THRESHOLD bytes to ensure these are entirely in RAM. Then we
- *   dirty these pages and check there were (almost) no page
- *   faults. Two faults are allowed incase some tasklet or something
- *   else unexpected, but irrelevant procedure, registers a fault to
- *   our process.
+ * Two checks are performed, the first looks at how SwapCache
+ * changes during madvise. When the pages are dirtied, about half
+ * will be accounted for under Cached and the other half will be
+ * moved into Swap. When madvise is run it will cause the pages
+ * under Cached to also be moved to Swap while rotating the pages
+ * already in Swap into SwapCached. So we expect that SwapCached has
+ * roughly MEM_LIMIT bytes added to it, but for reliability the
+ * PASS_THRESHOLD is much lower than that.
  *
+ * Secondly we run madvise again, but only on the first
+ * PASS_THRESHOLD bytes to ensure these are entirely in RAM. Then we
+ * dirty these pages and check there were (almost) no page
+ * faults. Two faults are allowed incase some tasklet or something
+ * else unexpected, but irrelevant procedure, registers a fault to
+ * our process.
  */
 
 #include <errno.h>
@@ -43,6 +42,7 @@
 #include <sys/mount.h>
 #include <sys/sysinfo.h>
 #include "tst_test.h"
+#include "tst_cgroup.h"
 
 #define CHUNK_SZ (400*1024*1024L)
 #define MEM_LIMIT (CHUNK_SZ / 2)
@@ -50,8 +50,7 @@
 #define PASS_THRESHOLD (CHUNK_SZ / 4)
 #define PASS_THRESHOLD_KB (PASS_THRESHOLD / 1024)
 
-#define MNT_NAME "memory"
-#define GROUP_NAME "madvise06"
+static const struct tst_cgroup_group *cg;
 
 static const char drop_caches_fname[] = "/proc/sys/vm/drop_caches";
 static int pg_sz, stat_refresh_sup;
@@ -64,17 +63,19 @@ static void check_path(const char *path)
 		tst_brk(TCONF, "file needed: %s", path);
 }
 
-#define READ_CGMEM(item)						\
-	({long tst_rval = 0;						\
-	  const char *cgpath = MNT_NAME"/"GROUP_NAME"/memory."item;	\
-	  if (!access(cgpath, R_OK))					\
-		  SAFE_FILE_LINES_SCANF(cgpath, "%ld", &tst_rval);	\
-	  tst_rval;})
+static void print_cgmem(const char *name)
+{
+	long ret;
+
+	if (!SAFE_CGROUP_HAS(cg, name))
+		return;
+
+	SAFE_CGROUP_SCANF(cg, name, "%ld", &ret);
+	tst_res(TINFO, "\t%s: %ld Kb", name, ret / 1024);
+}
 
 static void meminfo_diag(const char *point)
 {
-	long rval;
-
 	if (stat_refresh_sup)
 		SAFE_FILE_PRINTF("/proc/sys/vm/stat_refresh", "1");
 
@@ -85,16 +86,10 @@ static void meminfo_diag(const char *point)
 		SAFE_READ_MEMINFO("SwapCached:") - init_swap_cached);
 	tst_res(TINFO, "\tCached: %ld Kb",
 		SAFE_READ_MEMINFO("Cached:") - init_cached);
-	tst_res(TINFO, "\tcgmem.usage_in_bytes: %ld Kb",
-		READ_CGMEM("usage_in_bytes") / 1024);
-
-	rval = READ_CGMEM("memsw.usage_in_bytes") / 1024;
-	if (rval)
-		tst_res(TINFO, "\tcgmem.memsw.usage_in_bytes: %ld Kb", rval);
 
-	rval = READ_CGMEM("kmem.usage_in_bytes") / 1024;
-	if (rval)
-		tst_res(TINFO, "\tcgmem.kmem.usage_in_bytes: %ld Kb", rval);
+	print_cgmem("memory.current");
+	print_cgmem("memory.swap.current");
+	print_cgmem("memory.kmem.usage_in_bytes");
 }
 
 static void setup(void)
@@ -117,28 +112,24 @@ static void setup(void)
 			2 * CHUNK_SZ);
 	}
 
-	SAFE_MKDIR(MNT_NAME, 0700);
-	if (mount("memory", MNT_NAME, "cgroup", 0, "memory") == -1) {
-		if (errno == ENODEV || errno == ENOENT)
-			tst_brk(TCONF, "memory cgroup needed");
-	}
-	SAFE_MKDIR(MNT_NAME"/"GROUP_NAME, 0700);
-
 	check_path("/proc/self/oom_score_adj");
-	check_path(MNT_NAME"/"GROUP_NAME"/memory.limit_in_bytes");
-	check_path(MNT_NAME"/"GROUP_NAME"/memory.swappiness");
-	check_path(MNT_NAME"/"GROUP_NAME"/tasks");
-
 	SAFE_FILE_PRINTF("/proc/self/oom_score_adj", "%d", -1000);
-	SAFE_FILE_PRINTF(MNT_NAME"/"GROUP_NAME"/memory.limit_in_bytes", "%ld\n",
-			 MEM_LIMIT);
 
-	if (!access(MNT_NAME"/"GROUP_NAME"/memory.memsw.limit_in_bytes", W_OK)) {
-		SAFE_FILE_PRINTF(MNT_NAME"/"GROUP_NAME"/memory.memsw.limit_in_bytes",
-				 "%ld\n", MEMSW_LIMIT);
+	tst_cgroup_require("memory", NULL);
+	cg = tst_cgroup_get_test_group();
+
+	SAFE_CGROUP_PRINTF(cg, "memory.max", "%ld", MEM_LIMIT);
+	if (SAFE_CGROUP_HAS(cg, "memory.swap.max"))
+		SAFE_CGROUP_PRINTF(cg, "memory.swap.max", "%ld", MEMSW_LIMIT);
+
+	if (SAFE_CGROUP_HAS(cg, "memory.swappiness")) {
+		SAFE_CGROUP_PRINT(cg, "memory.swappiness", "60");
+	} else {
+		check_path("/proc/sys/vm/swappiness");
+		SAFE_FILE_PRINTF("/proc/sys/vm/swappiness", "%d", 60);
 	}
-	SAFE_FILE_PRINTF(MNT_NAME"/"GROUP_NAME"/memory.swappiness", "60");
-	SAFE_FILE_PRINTF(MNT_NAME"/"GROUP_NAME"/tasks", "%d\n", getpid());
+
+	SAFE_CGROUP_PRINTF(cg, "cgroup.procs", "%d", getpid());
 
 	meminfo_diag("Initial meminfo, later values are relative to this (except memcg)");
 	init_swap = SAFE_READ_MEMINFO("SwapTotal:") - SAFE_READ_MEMINFO("SwapFree:");
@@ -154,11 +145,7 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	if (!access(MNT_NAME"/tasks", F_OK)) {
-		SAFE_FILE_PRINTF(MNT_NAME"/tasks", "%d\n", getpid());
-		SAFE_RMDIR(MNT_NAME"/"GROUP_NAME);
-		SAFE_UMOUNT(MNT_NAME);
-	}
+	tst_cgroup_cleanup();
 }
 
 static void dirty_pages(char *ptr, long size)
@@ -248,6 +235,10 @@ static struct tst_test test = {
 	.min_kver = "3.10.0",
 	.needs_tmpdir = 1,
 	.needs_root = 1,
+	.save_restore = (const char * const[]) {
+		"?/proc/sys/vm/swappiness",
+		NULL
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "55231e5c898c"},
 		{"linux-git", "8de15e920dc8"},
-- 
2.31.1

