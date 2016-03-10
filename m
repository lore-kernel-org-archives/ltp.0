From: Li Wang <liwang@redhat.com>
Date: Thu, 10 Mar 2016 17:34:26 +0800
Subject: [LTP] [PATCH 2/4] mm/ksm: extend 'max_page_sharing' before ksm
	testing
In-Reply-To: <1457602468-24268-1-git-send-email-liwang@redhat.com>
References: <1457602468-24268-1-git-send-email-liwang@redhat.com>
Message-ID: <1457602468-24268-2-git-send-email-liwang@redhat.com>
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
 testcases/kernel/mem/include/mem.h | 1 +
 testcases/kernel/mem/ksm/ksm01.c   | 7 +++++++
 testcases/kernel/mem/ksm/ksm02.c   | 7 +++++++
 testcases/kernel/mem/ksm/ksm03.c   | 8 ++++++++
 testcases/kernel/mem/ksm/ksm04.c   | 8 ++++++++
 testcases/kernel/mem/ksm/ksm06.c   | 7 +++++++
 testcases/kernel/mem/lib/mem.c     | 8 +++++++-
 7 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index 43988fe..fbb11b2 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -43,6 +43,7 @@ void testoom(int mempolicy, int lite, int retcode, int allow_sigkill);
 /* KSM */
 
 #define PATH_KSM		"/sys/kernel/mm/ksm/"
+int max_page_sharing;
 
 void test_ksm_merge_across_nodes(unsigned long nr_pages);
 
diff --git a/testcases/kernel/mem/ksm/ksm01.c b/testcases/kernel/mem/ksm/ksm01.c
index b62df06..a352abd 100644
--- a/testcases/kernel/mem/ksm/ksm01.c
+++ b/testcases/kernel/mem/ksm/ksm01.c
@@ -105,6 +105,9 @@ void setup(void)
 		tst_brkm(TCONF, NULL, "2.6.32 or greater kernel required");
 	if (access(PATH_KSM, F_OK) == -1)
 		tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
+	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
+		SAFE_FILE_SCANF(NULL, PATH_KSM "max_page_sharing",
+				"%d", &max_page_sharing);
 
 	/*
 	 * kernel commit 90bd6fd introduced a new KSM sysfs knob
@@ -128,4 +131,8 @@ void cleanup(void)
 	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0)
 		FILE_PRINTF(PATH_KSM "merge_across_nodes",
 				 "%d", merge_across_nodes);
+
+	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
+		FILE_PRINTF(PATH_KSM "max_page_sharing",
+				 "%d", max_page_sharing);
 }
diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index 537ec01..7b004b4 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -125,6 +125,10 @@ void cleanup(void)
 		FILE_PRINTF(PATH_KSM "merge_across_nodes",
 				 "%d", merge_across_nodes);
 
+	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
+		FILE_PRINTF(PATH_KSM "max_page_sharing",
+				"%d", max_page_sharing);
+
 	umount_mem(CPATH, CPATH_NEW);
 }
 
@@ -136,6 +140,9 @@ void setup(void)
 		tst_brkm(TCONF, NULL, "2.6.32 or greater kernel required");
 	if (access(PATH_KSM, F_OK) == -1)
 		tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
+	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
+		SAFE_FILE_SCANF(NULL, PATH_KSM "max_page_sharing",
+				"%d", &max_page_sharing);
 
 	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0) {
 		SAFE_FILE_SCANF(NULL, PATH_KSM "merge_across_nodes",
diff --git a/testcases/kernel/mem/ksm/ksm03.c b/testcases/kernel/mem/ksm/ksm03.c
index b73e023..f909294 100644
--- a/testcases/kernel/mem/ksm/ksm03.c
+++ b/testcases/kernel/mem/ksm/ksm03.c
@@ -113,6 +113,10 @@ void setup(void)
 		SAFE_FILE_PRINTF(NULL, PATH_KSM "merge_across_nodes", "1");
 	}
 
+	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
+		SAFE_FILE_SCANF(NULL, PATH_KSM "max_page_sharing",
+				"%d", &max_page_sharing);
+
 	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
 	tst_sig(FORK, DEF_HANDLER, NULL);
 	TEST_PAUSE;
@@ -124,5 +128,9 @@ void cleanup(void)
 		FILE_PRINTF(PATH_KSM "merge_across_nodes",
 				 "%d", merge_across_nodes);
 
+	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
+		FILE_PRINTF(PATH_KSM "max_page_sharing",
+				"%d", max_page_sharing);
+
 	umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
 }
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index 0c1d4e0..fe8c640 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -127,6 +127,10 @@ void cleanup(void)
 		FILE_PRINTF(PATH_KSM "merge_across_nodes",
 				 "%d", merge_across_nodes);
 
+	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
+		FILE_PRINTF(PATH_KSM "max_page_sharing",
+				"%d", max_page_sharing);
+
 	umount_mem(CPATH, CPATH_NEW);
 	umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
 }
@@ -146,6 +150,10 @@ void setup(void)
 		SAFE_FILE_PRINTF(NULL, PATH_KSM "merge_across_nodes", "1");
 	}
 
+	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
+		SAFE_FILE_SCANF(NULL, PATH_KSM "max_page_sharing",
+				"%d", &max_page_sharing);
+
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
 	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
diff --git a/testcases/kernel/mem/ksm/ksm06.c b/testcases/kernel/mem/ksm/ksm06.c
index 02d304f..1efb613 100644
--- a/testcases/kernel/mem/ksm/ksm06.c
+++ b/testcases/kernel/mem/ksm/ksm06.c
@@ -104,6 +104,9 @@ void setup(void)
 			"%d", &merge_across_nodes);
 	SAFE_FILE_SCANF(NULL, PATH_KSM "sleep_millisecs",
 			"%d", &sleep_millisecs);
+	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
+		SAFE_FILE_SCANF(NULL, PATH_KSM "max_page_sharing",
+				"%d", &max_page_sharing);
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
@@ -116,6 +119,10 @@ void cleanup(void)
 	FILE_PRINTF(PATH_KSM "sleep_millisecs",
 			 "%d", sleep_millisecs);
 	FILE_PRINTF(PATH_KSM "run", "%d", run);
+
+	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
+		FILE_PRINTF(PATH_KSM "max_page_sharing",
+				"%d", max_page_sharing);
 }
 
 static void usage(void)
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 7b5bb35..d37d6a4 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -502,9 +502,12 @@ void create_same_memory(int size, int num, int unit)
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
@@ -595,6 +598,9 @@ void test_ksm_merge_across_nodes(unsigned long nr_pages)
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

