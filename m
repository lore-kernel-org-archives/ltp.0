From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 19 Mar 2018 18:23:03 +0300
Subject: [LTP] [PATCH] ksm: perform cleanup actions only when they are
	actually required
Message-ID: <1521472983-7383-1-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This one is similar to commit 8ae3916674fa
("mem/oom, tunable: perform cleanup actions only when they are actually required")
i.e. we are making sure that ksm tests do not revert any not yet performed
actions.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/mem/ksm/ksm01.c |    6 +++++-
 testcases/kernel/mem/ksm/ksm02.c |   11 +++++++++--
 testcases/kernel/mem/ksm/ksm03.c |   11 +++++++++--
 testcases/kernel/mem/ksm/ksm04.c |   16 +++++++++++++---
 testcases/kernel/mem/ksm/ksm06.c |    5 ++++-
 5 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/mem/ksm/ksm01.c b/testcases/kernel/mem/ksm/ksm01.c
index ce96983..0961927 100644
--- a/testcases/kernel/mem/ksm/ksm01.c
+++ b/testcases/kernel/mem/ksm/ksm01.c
@@ -59,6 +59,8 @@
 #include "mem.h"
 #include "ksm_common.h"
 
+static int max_page_sharing_saved;
+
 static void verify_ksm(void)
 {
 	create_same_memory(size, num, unit);
@@ -70,6 +72,7 @@ static void setup(void)
 		tst_brk(TCONF, "KSM configuration is not enabled");
 
 	save_max_page_sharing();
+	max_page_sharing_saved = 1;
 
 	parse_ksm_options(opt_sizestr, &size, opt_numstr, &num, opt_unitstr, &unit);
 
@@ -93,7 +96,8 @@ static void cleanup(void)
 		FILE_PRINTF(PATH_KSM "merge_across_nodes",
 				 "%d", merge_across_nodes);
 
-	restore_max_page_sharing();
+	if (max_page_sharing_saved)
+		restore_max_page_sharing();
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index 03b44c0..014ac1c 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -59,6 +59,9 @@
 #ifdef HAVE_NUMA_V2
 #include <numaif.h>
 
+static int max_page_sharing_saved;
+static int cpuset_mounted;
+
 static void verify_ksm(void)
 {
 	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
@@ -86,9 +89,11 @@ static void cleanup(void)
 		FILE_PRINTF(PATH_KSM "merge_across_nodes",
 				 "%d", merge_across_nodes);
 
-	restore_max_page_sharing();
+	if (max_page_sharing_saved)
+		restore_max_page_sharing();
 
-	umount_mem(CPATH, CPATH_NEW);
+	if (cpuset_mounted)
+		umount_mem(CPATH, CPATH_NEW);
 }
 
 static void setup(void)
@@ -96,6 +101,7 @@ static void setup(void)
 	if (access(PATH_KSM, F_OK) == -1)
 		tst_brk(TCONF, "KSM configuration is not enabled");
 	save_max_page_sharing();
+	max_page_sharing_saved = 1;
 
 	parse_ksm_options(opt_sizestr, &size, opt_numstr, &num, opt_unitstr, &unit);
 
@@ -106,6 +112,7 @@ static void setup(void)
 	}
 
 	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
+	cpuset_mounted = 1;
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/ksm/ksm03.c b/testcases/kernel/mem/ksm/ksm03.c
index 51cc923..79a8f87 100644
--- a/testcases/kernel/mem/ksm/ksm03.c
+++ b/testcases/kernel/mem/ksm/ksm03.c
@@ -59,6 +59,9 @@
 #include "mem.h"
 #include "ksm_common.h"
 
+static int max_page_sharing_saved;
+static int memcg_mounted;
+
 static void verify_ksm(void)
 {
 	write_memcg();
@@ -77,8 +80,10 @@ static void setup(void)
 	}
 
 	save_max_page_sharing();
+	max_page_sharing_saved = 1;
 	parse_ksm_options(opt_sizestr, &size, opt_numstr, &num, opt_unitstr, &unit);
 	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
+	memcg_mounted = 1;
 }
 
 static void cleanup(void)
@@ -87,9 +92,11 @@ static void cleanup(void)
 		FILE_PRINTF(PATH_KSM "merge_across_nodes",
 				 "%d", merge_across_nodes);
 
-	restore_max_page_sharing();
+	if (max_page_sharing_saved)
+		restore_max_page_sharing();
 
-	umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
+	if (memcg_mounted)
+		umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index 835222f..a79e649 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -59,6 +59,10 @@
 #ifdef HAVE_NUMA_V2
 #include <numaif.h>
 
+static int max_page_sharing_saved;
+static int cpuset_mounted;
+static int memcg_mounted;
+
 static void verify_ksm(void)
 {
 	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
@@ -88,10 +92,13 @@ static void cleanup(void)
 		FILE_PRINTF(PATH_KSM "merge_across_nodes",
 				 "%d", merge_across_nodes);
 
-	restore_max_page_sharing();
+	if (max_page_sharing_saved)
+		restore_max_page_sharing();
 
-	umount_mem(CPATH, CPATH_NEW);
-	umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
+	if (cpuset_mounted)
+		umount_mem(CPATH, CPATH_NEW);
+	if (memcg_mounted)
+		umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
 }
 
 static void setup(void)
@@ -106,10 +113,13 @@ static void setup(void)
 	}
 
 	save_max_page_sharing();
+	max_page_sharing_saved = 1;
 	parse_ksm_options(opt_sizestr, &size, opt_numstr, &num, opt_unitstr, &unit);
 
 	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
+	cpuset_mounted = 1;
 	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
+	memcg_mounted = 1;
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/ksm/ksm06.c b/testcases/kernel/mem/ksm/ksm06.c
index 53d532c..92a36c1 100644
--- a/testcases/kernel/mem/ksm/ksm06.c
+++ b/testcases/kernel/mem/ksm/ksm06.c
@@ -42,6 +42,7 @@
 static int run = -1;
 static int sleep_millisecs = -1;
 static int merge_across_nodes = -1;
+static int max_page_sharing_saved;
 static unsigned long nr_pages;
 
 static char *n_opt;
@@ -66,6 +67,7 @@ static void setup(void)
 		tst_brk(TCONF, "no merge_across_nodes sysfs knob");
 
 	save_max_page_sharing();
+	max_page_sharing_saved = 1;
 
 	if (!is_numa(NULL, NH_MEMS, 2))
 		tst_brk(TCONF, "The case needs a NUMA system.");
@@ -91,7 +93,8 @@ static void cleanup(void)
 	if (run != -1)
 		FILE_PRINTF(PATH_KSM "run", "%d", run);
 
-	restore_max_page_sharing();
+	if (max_page_sharing_saved)
+		restore_max_page_sharing();
 }
 
 static struct tst_test test = {
-- 
1.7.1

