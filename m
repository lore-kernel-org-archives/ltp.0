From: Li Wang <liwang@redhat.com>
Date: Tue,  6 Nov 2018 20:56:17 +0800
Subject: [LTP] [PATCH] ksm: take use of .save_restore filed in ksm cases
Message-ID: <20181106125617.16602-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/include/mem.h    |  2 --
 testcases/kernel/mem/ksm/ksm01.c      |  5 +----
 testcases/kernel/mem/ksm/ksm02.c      |  4 +---
 testcases/kernel/mem/ksm/ksm03.c      |  4 +---
 testcases/kernel/mem/ksm/ksm04.c      |  4 +---
 testcases/kernel/mem/ksm/ksm06.c      | 10 ++++++----
 testcases/kernel/mem/ksm/ksm_common.h |  5 +++++
 testcases/kernel/mem/lib/mem.c        | 25 -------------------------
 8 files changed, 15 insertions(+), 44 deletions(-)

diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index f7682f9..a12c223 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -44,8 +44,6 @@ void testoom(int mempolicy, int lite, int retcode, int allow_sigkill);
 /* KSM */
 
 void create_same_memory(int size, int num, int unit);
-void save_max_page_sharing(void);
-void restore_max_page_sharing(void);
 void test_ksm_merge_across_nodes(unsigned long nr_pages);
 
 /* THP */
diff --git a/testcases/kernel/mem/ksm/ksm01.c b/testcases/kernel/mem/ksm/ksm01.c
index ce96983..e78d3ee 100644
--- a/testcases/kernel/mem/ksm/ksm01.c
+++ b/testcases/kernel/mem/ksm/ksm01.c
@@ -69,8 +69,6 @@ static void setup(void)
 	if (access(PATH_KSM, F_OK) == -1)
 		tst_brk(TCONF, "KSM configuration is not enabled");
 
-	save_max_page_sharing();
-
 	parse_ksm_options(opt_sizestr, &size, opt_numstr, &num, opt_unitstr, &unit);
 
 	/*
@@ -92,8 +90,6 @@ static void cleanup(void)
 	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0)
 		FILE_PRINTF(PATH_KSM "merge_across_nodes",
 				 "%d", merge_across_nodes);
-
-	restore_max_page_sharing();
 }
 
 static struct tst_test test = {
@@ -102,6 +98,7 @@ static struct tst_test test = {
 	.options = ksm_options,
 	.setup = setup,
 	.cleanup = cleanup,
+	.save_restore = save_restore,
 	.test_all = verify_ksm,
 	.min_kver = "2.6.32",
 };
diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index 22c78cb..3d4c19d 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -88,8 +88,6 @@ static void cleanup(void)
 		FILE_PRINTF(PATH_KSM "merge_across_nodes",
 				 "%d", merge_across_nodes);
 
-	restore_max_page_sharing();
-
 	if (cpuset_mounted)
 		umount_mem(CPATH, CPATH_NEW);
 }
@@ -98,7 +96,6 @@ static void setup(void)
 {
 	if (access(PATH_KSM, F_OK) == -1)
 		tst_brk(TCONF, "KSM configuration is not enabled");
-	save_max_page_sharing();
 
 	parse_ksm_options(opt_sizestr, &size, opt_numstr, &num, opt_unitstr, &unit);
 
@@ -118,6 +115,7 @@ static struct tst_test test = {
 	.options = ksm_options,
 	.setup = setup,
 	.cleanup = cleanup,
+	.save_restore = save_restore,
 	.test_all = verify_ksm,
 	.min_kver = "2.6.32",
 };
diff --git a/testcases/kernel/mem/ksm/ksm03.c b/testcases/kernel/mem/ksm/ksm03.c
index 284f4ec..0e51316 100644
--- a/testcases/kernel/mem/ksm/ksm03.c
+++ b/testcases/kernel/mem/ksm/ksm03.c
@@ -78,7 +78,6 @@ static void setup(void)
 		SAFE_FILE_PRINTF(PATH_KSM "merge_across_nodes", "1");
 	}
 
-	save_max_page_sharing();
 	parse_ksm_options(opt_sizestr, &size, opt_numstr, &num, opt_unitstr, &unit);
 	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
 	memcg_mounted = 1;
@@ -90,8 +89,6 @@ static void cleanup(void)
 		FILE_PRINTF(PATH_KSM "merge_across_nodes",
 				 "%d", merge_across_nodes);
 
-	restore_max_page_sharing();
-
 	if (memcg_mounted)
 		umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
 }
@@ -102,6 +99,7 @@ static struct tst_test test = {
 	.options = ksm_options,
 	.setup = setup,
 	.cleanup = cleanup,
+	.save_restore = save_restore,
 	.test_all = verify_ksm,
 	.min_kver = "2.6.32",
 };
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index 9ffef4d..e393dbd 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -91,8 +91,6 @@ static void cleanup(void)
 		FILE_PRINTF(PATH_KSM "merge_across_nodes",
 				 "%d", merge_across_nodes);
 
-	restore_max_page_sharing();
-
 	if (cpuset_mounted)
 		umount_mem(CPATH, CPATH_NEW);
 	if (memcg_mounted)
@@ -110,7 +108,6 @@ static void setup(void)
 		SAFE_FILE_PRINTF(PATH_KSM "merge_across_nodes", "1");
 	}
 
-	save_max_page_sharing();
 	parse_ksm_options(opt_sizestr, &size, opt_numstr, &num, opt_unitstr, &unit);
 
 	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
@@ -125,6 +122,7 @@ static struct tst_test test = {
 	.options = ksm_options,
 	.setup = setup,
 	.cleanup = cleanup,
+	.save_restore = save_restore,
 	.test_all = verify_ksm,
 	.min_kver = "2.6.32",
 };
diff --git a/testcases/kernel/mem/ksm/ksm06.c b/testcases/kernel/mem/ksm/ksm06.c
index 53d532c..7f2f3c4 100644
--- a/testcases/kernel/mem/ksm/ksm06.c
+++ b/testcases/kernel/mem/ksm/ksm06.c
@@ -50,6 +50,11 @@ static struct tst_option ksm_options[] = {
 	{NULL, NULL, NULL}
 };
 
+static const char * const save_restore[] = {
+	"?/sys/kernel/mm/ksm/max_page_sharing",
+	NULL,
+};
+
 static void test_ksm(void)
 {
 	if (n_opt)
@@ -65,8 +70,6 @@ static void setup(void)
 	if (access(PATH_KSM "merge_across_nodes", F_OK) == -1)
 		tst_brk(TCONF, "no merge_across_nodes sysfs knob");
 
-	save_max_page_sharing();
-
 	if (!is_numa(NULL, NH_MEMS, 2))
 		tst_brk(TCONF, "The case needs a NUMA system.");
 
@@ -90,8 +93,6 @@ static void cleanup(void)
 
 	if (run != -1)
 		FILE_PRINTF(PATH_KSM "run", "%d", run);
-
-	restore_max_page_sharing();
 }
 
 static struct tst_test test = {
@@ -99,6 +100,7 @@ static struct tst_test test = {
 	.options = ksm_options,
 	.setup = setup,
 	.cleanup = cleanup,
+	.save_restore = save_restore,
 	.test_all = test_ksm,
 };
 
diff --git a/testcases/kernel/mem/ksm/ksm_common.h b/testcases/kernel/mem/ksm/ksm_common.h
index 6a682d0..a6e0747 100644
--- a/testcases/kernel/mem/ksm/ksm_common.h
+++ b/testcases/kernel/mem/ksm/ksm_common.h
@@ -46,3 +46,8 @@ static inline void parse_ksm_options(char *str_size, int *size,
 				"the remainder of division of size by unit is "
 				"not zero.");
 }
+
+static const char * const save_restore[] = {
+	"?/sys/kernel/mm/ksm/max_page_sharing",
+	NULL,
+};
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index ce21bc7..ec17920 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -239,31 +239,6 @@ void testoom(int mempolicy, int lite, int retcode, int allow_sigkill)
 
 /* KSM */
 
-static int max_page_sharing;
-
-void save_max_page_sharing(void)
-{
-	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
-		SAFE_FILE_SCANF(PATH_KSM "max_page_sharing",
-				"%d", &max_page_sharing);
-}
-
-void restore_max_page_sharing(void)
-{
-	/*
-	 * Documentation/vm/ksm.txt states that the minimum
-	 * value for max_page_sharing is 2, so on
-	 * max_page_sharing != 0 after save_max_page_sharing()
-	 * returns.
-	 */
-	if (!max_page_sharing)
-		return;
-
-	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
-	        FILE_PRINTF(PATH_KSM "max_page_sharing",
-	                         "%d", max_page_sharing);
-}
-
 static void check(char *path, long int value)
 {
 	char fullpath[BUFSIZ];
-- 
2.9.5

