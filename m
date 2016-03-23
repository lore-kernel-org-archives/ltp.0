From: Li Wang <liwang@redhat.com>
Date: Wed, 23 Mar 2016 12:25:56 +0800
Subject: [LTP] [PATCH V2 2/3] mm/ksm: extend 'max_page_sharing' before ksm
	testing
In-Reply-To: <1458707157-31233-1-git-send-email-liwang@redhat.com>
References: <1458707157-31233-1-git-send-email-liwang@redhat.com>
Message-ID: <1458707157-31233-2-git-send-email-liwang@redhat.com>
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

This patch is intened to extend the 'max_page_sharing' value dynamically to
make tests pass.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/include/mem.h |  3 +++
 testcases/kernel/mem/ksm/ksm01.c   |  4 ++++
 testcases/kernel/mem/ksm/ksm02.c   |  3 +++
 testcases/kernel/mem/ksm/ksm03.c   |  4 ++++
 testcases/kernel/mem/ksm/ksm04.c   |  4 ++++
 testcases/kernel/mem/ksm/ksm06.c   |  4 ++++
 testcases/kernel/mem/lib/mem.c     | 22 +++++++++++++++++++++-
 7 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index 43988fe..69d08dd 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -43,7 +43,10 @@ void testoom(int mempolicy, int lite, int retcode, int allow_sigkill);
 /* KSM */
 
 #define PATH_KSM		"/sys/kernel/mm/ksm/"
+int max_page_sharing;
 
+void save_max_page_sharing(void);
+void restore_max_page_sharing(void);
 void test_ksm_merge_across_nodes(unsigned long nr_pages);
 
 /* THP */
diff --git a/testcases/kernel/mem/ksm/ksm01.c b/testcases/kernel/mem/ksm/ksm01.c
index b62df06..824881c 100644
--- a/testcases/kernel/mem/ksm/ksm01.c
+++ b/testcases/kernel/mem/ksm/ksm01.c
@@ -106,6 +106,8 @@ void setup(void)
 	if (access(PATH_KSM, F_OK) == -1)
 		tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
 
+	save_max_page_sharing();
+
 	/*
 	 * kernel commit 90bd6fd introduced a new KSM sysfs knob
 	 * /sys/kernel/mm/ksm/merge_across_nodes, setting it to '0'
@@ -128,4 +130,6 @@ void cleanup(void)
 	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0)
 		FILE_PRINTF(PATH_KSM "merge_across_nodes",
 				 "%d", merge_across_nodes);
+
+	restore_max_page_sharing();
 }
diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index 537ec01..6274f8a 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -125,6 +125,8 @@ void cleanup(void)
 		FILE_PRINTF(PATH_KSM "merge_across_nodes",
 				 "%d", merge_across_nodes);
 
+	restore_max_page_sharing();
+
 	umount_mem(CPATH, CPATH_NEW);
 }
 
@@ -136,6 +138,7 @@ void setup(void)
 		tst_brkm(TCONF, NULL, "2.6.32 or greater kernel required");
 	if (access(PATH_KSM, F_OK) == -1)
 		tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
+	save_max_page_sharing();
 
 	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0) {
 		SAFE_FILE_SCANF(NULL, PATH_KSM "merge_across_nodes",
diff --git a/testcases/kernel/mem/ksm/ksm03.c b/testcases/kernel/mem/ksm/ksm03.c
index b73e023..979222a 100644
--- a/testcases/kernel/mem/ksm/ksm03.c
+++ b/testcases/kernel/mem/ksm/ksm03.c
@@ -113,6 +113,8 @@ void setup(void)
 		SAFE_FILE_PRINTF(NULL, PATH_KSM "merge_across_nodes", "1");
 	}
 
+	save_max_page_sharing();
+
 	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
 	tst_sig(FORK, DEF_HANDLER, NULL);
 	TEST_PAUSE;
@@ -124,5 +126,7 @@ void cleanup(void)
 		FILE_PRINTF(PATH_KSM "merge_across_nodes",
 				 "%d", merge_across_nodes);
 
+	restore_max_page_sharing();
+
 	umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
 }
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index 0c1d4e0..4beeed6 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -127,6 +127,8 @@ void cleanup(void)
 		FILE_PRINTF(PATH_KSM "merge_across_nodes",
 				 "%d", merge_across_nodes);
 
+	restore_max_page_sharing();
+
 	umount_mem(CPATH, CPATH_NEW);
 	umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
 }
@@ -146,6 +148,8 @@ void setup(void)
 		SAFE_FILE_PRINTF(NULL, PATH_KSM "merge_across_nodes", "1");
 	}
 
+	save_max_page_sharing();
+
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
 	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
diff --git a/testcases/kernel/mem/ksm/ksm06.c b/testcases/kernel/mem/ksm/ksm06.c
index 02d304f..2092746 100644
--- a/testcases/kernel/mem/ksm/ksm06.c
+++ b/testcases/kernel/mem/ksm/ksm06.c
@@ -105,6 +105,8 @@ void setup(void)
 	SAFE_FILE_SCANF(NULL, PATH_KSM "sleep_millisecs",
 			"%d", &sleep_millisecs);
 
+	save_max_page_sharing();
+
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
 }
@@ -116,6 +118,8 @@ void cleanup(void)
 	FILE_PRINTF(PATH_KSM "sleep_millisecs",
 			 "%d", sleep_millisecs);
 	FILE_PRINTF(PATH_KSM "run", "%d", run);
+
+	restore_max_page_sharing();
 }
 
 static void usage(void)
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 7b5bb35..084e5a4 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -230,6 +230,20 @@ void testoom(int mempolicy, int lite, int retcode, int allow_sigkill)
 
 /* KSM */
 
+void save_max_page_sharing(void)
+{
+	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
+	        SAFE_FILE_SCANF(NULL, PATH_KSM "max_page_sharing",
+	                        "%d", &max_page_sharing);
+}
+
+void restore_max_page_sharing(void)
+{
+	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
+	        FILE_PRINTF(PATH_KSM "max_page_sharing",
+	                         "%d", max_page_sharing);
+}
+
 static void check(char *path, long int value)
 {
 	char fullpath[BUFSIZ];
@@ -502,9 +516,12 @@ void create_same_memory(int size, int num, int unit)
 	stop_ksm_children(child, num);
 
 	tst_resm(TINFO, "KSM merging...");
+	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
+		SAFE_FILE_PRINTF(cleanup, PATH_KSM "max_page_sharing",
+				"%ld", size * pages * num);
 	SAFE_FILE_PRINTF(cleanup, PATH_KSM "run", "1");
 	SAFE_FILE_PRINTF(cleanup, PATH_KSM "pages_to_scan", "%ld",
-			 size * pages *num);
+			 size * pages * num);
 	SAFE_FILE_PRINTF(cleanup, PATH_KSM "sleep_millisecs", "0");
 
 	resume_ksm_children(child, num);
@@ -595,6 +612,9 @@ void test_ksm_merge_across_nodes(unsigned long nr_pages)
 	SAFE_FILE_PRINTF(cleanup, PATH_KSM "sleep_millisecs", "0");
 	SAFE_FILE_PRINTF(cleanup, PATH_KSM "pages_to_scan", "%ld",
 			 nr_pages * num_nodes);
+	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
+		SAFE_FILE_PRINTF(cleanup, PATH_KSM "max_page_sharing",
+			"%ld", nr_pages * num_nodes);
 	/*
 	 * merge_across_nodes setting can be changed only when there
 	 * are no ksm shared pages in system, so set run 2 to unmerge
-- 
1.8.3.1

