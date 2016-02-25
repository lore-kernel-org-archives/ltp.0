From: Li Wang <liwang@redhat.com>
Date: Thu, 25 Feb 2016 16:48:12 +0800
Subject: [LTP] [PATCH] mm/ksm: extend 'max_page_sharing' before ksm testing
Message-ID: <1456390092-1428-1-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This kernel commit (de39e60a6, ksm: introduce ksm_max_page_sharing per page...)
introduced a new KSM sysfs knob '/sys/kernel/mm/ksm/max_page_sharing' in linux-next.

The runtime value of 'max_page_sharing' will affect pages_shared/pages_sharing,
because this enforces a deduplication limit to avoid the virtual memory rmap lists
to grow too large.

ltp/ksm0* tests can easily get failures on that kernel like:
-----
ksm01       0  TINFO  :  wait for all children to stop.
ksm01       0  TINFO  :  KSM merging...
ksm01       0  TINFO  :  resume all children.
ksm01       0  TINFO  :  child 2 stops.
...
ksm01       0  TINFO  :  run is 1.
ksm01       0  TINFO  :  pages_shared is 384.
ksm01       1  TFAIL  :  mem.c:238: pages_shared is not 2.
ksm01       0  TINFO  :  pages_sharing is 97920.
ksm01       2  TFAIL  :  mem.c:238: pages_sharing is not 98302.
ksm01       0  TINFO  :  pages_volatile is 0.
ksm01       0  TINFO  :  pages_unshared is 0.
ksm01       0  TINFO  :  sleep_millisecs is 0.
ksm01       0  TINFO  :  pages_to_scan is 98304.

So, I composed this patch to extend the 'max_page_sharing' value to make tests pass.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/ksm/ksm01.c | 10 ++++++++++
 testcases/kernel/mem/ksm/ksm02.c | 10 ++++++++++
 testcases/kernel/mem/ksm/ksm03.c | 11 +++++++++++
 testcases/kernel/mem/ksm/ksm04.c | 11 +++++++++++
 testcases/kernel/mem/ksm/ksm06.c | 10 ++++++++++
 5 files changed, 52 insertions(+)

diff --git a/testcases/kernel/mem/ksm/ksm01.c b/testcases/kernel/mem/ksm/ksm01.c
index b62df06..fccae1c 100644
--- a/testcases/kernel/mem/ksm/ksm01.c
+++ b/testcases/kernel/mem/ksm/ksm01.c
@@ -73,6 +73,7 @@ char *TCID = "ksm01";
 int TST_TOTAL = 1;
 
 static int merge_across_nodes;
+static int max_page_sharing;
 
 option_t ksm_options[] = {
 	{"n:", &opt_num, &opt_numstr},
@@ -105,6 +106,11 @@ void setup(void)
 		tst_brkm(TCONF, NULL, "2.6.32 or greater kernel required");
 	if (access(PATH_KSM, F_OK) == -1)
 		tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
+	if (access(PATH_KSM "max_page_sharing", F_OK) == 0) {
+		SAFE_FILE_SCANF(NULL, PATH_KSM "max_page_sharing",
+				"%d", &max_page_sharing);
+		SAFE_FILE_PRINTF(NULL, PATH_KSM "max_page_sharing", "100000");
+	}
 
 	/*
 	 * kernel commit 90bd6fd introduced a new KSM sysfs knob
@@ -128,4 +134,8 @@ void cleanup(void)
 	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0)
 		FILE_PRINTF(PATH_KSM "merge_across_nodes",
 				 "%d", merge_across_nodes);
+
+	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
+		FILE_PRINTF(PATH_KSM "max_page_sharing",
+				 "%d", max_page_sharing);
 }
diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index 537ec01..8ca397a 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -73,6 +73,7 @@ char *TCID = "ksm02";
 int TST_TOTAL = 1;
 
 static int merge_across_nodes;
+static int max_page_sharing;
 
 #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
@@ -125,6 +126,10 @@ void cleanup(void)
 		FILE_PRINTF(PATH_KSM "merge_across_nodes",
 				 "%d", merge_across_nodes);
 
+	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
+		FILE_PRINTF(PATH_KSM "max_page_sharing",
+				"%d", max_page_sharing);
+
 	umount_mem(CPATH, CPATH_NEW);
 }
 
@@ -136,6 +141,11 @@ void setup(void)
 		tst_brkm(TCONF, NULL, "2.6.32 or greater kernel required");
 	if (access(PATH_KSM, F_OK) == -1)
 		tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
+	if (access(PATH_KSM "max_page_sharing", F_OK) == 0) {
+		SAFE_FILE_SCANF(NULL, PATH_KSM "max_page_sharing",
+				"%d", &max_page_sharing);
+		SAFE_FILE_PRINTF(NULL, PATH_KSM "max_page_sharing", "100000");
+	}
 
 	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0) {
 		SAFE_FILE_SCANF(NULL, PATH_KSM "merge_across_nodes",
diff --git a/testcases/kernel/mem/ksm/ksm03.c b/testcases/kernel/mem/ksm/ksm03.c
index b73e023..8670ed8 100644
--- a/testcases/kernel/mem/ksm/ksm03.c
+++ b/testcases/kernel/mem/ksm/ksm03.c
@@ -73,6 +73,7 @@ char *TCID = "ksm03";
 int TST_TOTAL = 1;
 
 static int merge_across_nodes;
+static int max_page_sharing;
 
 option_t ksm_options[] = {
 	{"n:", &opt_num, &opt_numstr},
@@ -113,6 +114,12 @@ void setup(void)
 		SAFE_FILE_PRINTF(NULL, PATH_KSM "merge_across_nodes", "1");
 	}
 
+	if (access(PATH_KSM "max_page_sharing", F_OK) == 0) {
+		SAFE_FILE_SCANF(NULL, PATH_KSM "max_page_sharing",
+				"%d", &max_page_sharing);
+		SAFE_FILE_PRINTF(NULL, PATH_KSM "max_page_sharing", "100000");
+	}
+
 	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
 	tst_sig(FORK, DEF_HANDLER, NULL);
 	TEST_PAUSE;
@@ -124,5 +131,9 @@ void cleanup(void)
 		FILE_PRINTF(PATH_KSM "merge_across_nodes",
 				 "%d", merge_across_nodes);
 
+	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
+		FILE_PRINTF(PATH_KSM "max_page_sharing",
+				"%d", max_page_sharing);
+
 	umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
 }
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index 0c1d4e0..15988f7 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -73,6 +73,7 @@ char *TCID = "ksm04";
 int TST_TOTAL = 1;
 
 static int merge_across_nodes;
+static int max_page_sharing;
 
 #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
@@ -127,6 +128,10 @@ void cleanup(void)
 		FILE_PRINTF(PATH_KSM "merge_across_nodes",
 				 "%d", merge_across_nodes);
 
+	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
+		FILE_PRINTF(PATH_KSM "max_page_sharing",
+				"%d", max_page_sharing);
+
 	umount_mem(CPATH, CPATH_NEW);
 	umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
 }
@@ -146,6 +151,12 @@ void setup(void)
 		SAFE_FILE_PRINTF(NULL, PATH_KSM "merge_across_nodes", "1");
 	}
 
+	if (access(PATH_KSM "max_page_sharing", F_OK) == 0) {
+		SAFE_FILE_SCANF(NULL, PATH_KSM "max_page_sharing",
+				"%d", &max_page_sharing);
+		SAFE_FILE_PRINTF(NULL, PATH_KSM "max_page_sharing", "100000");
+	}
+
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
 	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
diff --git a/testcases/kernel/mem/ksm/ksm06.c b/testcases/kernel/mem/ksm/ksm06.c
index 1cda01f..3d12419 100644
--- a/testcases/kernel/mem/ksm/ksm06.c
+++ b/testcases/kernel/mem/ksm/ksm06.c
@@ -57,6 +57,7 @@ int TST_TOTAL = 1;
 static int run;
 static int sleep_millisecs;
 static int merge_across_nodes;
+static int max_page_sharing;
 static int n_flag;
 static unsigned long nr_pages;
 
@@ -104,6 +105,11 @@ void setup(void)
 			"%d", &merge_across_nodes);
 	SAFE_FILE_SCANF(NULL, PATH_KSM "sleep_millisecs",
 			"%d", &sleep_millisecs);
+	if (access(PATH_KSM "max_page_sharing", F_OK) == 0) {
+		SAFE_FILE_SCANF(NULL, PATH_KSM "max_page_sharing",
+				"%d", &max_page_sharing);
+		SAFE_FILE_PRINTF(NULL, PATH_KSM "max_page_sharing", "100000");
+	}
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
@@ -116,6 +122,10 @@ void cleanup(void)
 	FILE_PRINTF(PATH_KSM "sleep_millisecs",
 			 "%d", sleep_millisecs);
 	FILE_PRINTF(PATH_KSM "run", "%d", run);
+
+	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
+		FILE_PRINTF(PATH_KSM "max_page_sharing",
+				"%d", max_page_sharing);
 }
 
 static void usage(void)
-- 
1.8.3.1

