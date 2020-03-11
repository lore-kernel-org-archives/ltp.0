From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 11 Mar 2020 18:15:10 +0800
Subject: [LTP] [PATCH 1/3] lib/tst_hugepage: Use uniform data type
Message-ID: <1583921712-9008-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From man-page[1] and kernel code[2], HugePages_Total and free are
both "unsigned long". I guess there is no reason for not using it
even though we don't have so larger memory to support it.

[1]https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/man5/proc.5#n3696
[2]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/hugetlb.c#n3055

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 include/tst_hugepage.h    |  4 ++--
 include/tst_test.h        |  2 +-
 lib/newlib_tests/test20.c | 12 ++++++------
 lib/tst_hugepage.c        | 19 +++++++++----------
 4 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/include/tst_hugepage.h b/include/tst_hugepage.h
index 10e0eaf47..8600b3adb 100644
--- a/include/tst_hugepage.h
+++ b/include/tst_hugepage.h
@@ -15,7 +15,7 @@
  *
  * Note: this depend on the status of system memory fragmentation.
  */
-int tst_request_hugepages(int hpages);
+unsigned long tst_request_hugepages(unsigned long hpages);
 
 /*
  * This variable is used for recording the number of hugepages which system can
@@ -24,6 +24,6 @@ int tst_request_hugepages(int hpages);
  *
  * If system does not support hugetlb, then it will be set to 0.
  */
-extern unsigned int tst_hugepages;
+extern unsigned long tst_hugepages;
 
 #endif /* TST_HUGEPAGE_H */
diff --git a/include/tst_test.h b/include/tst_test.h
index 8508c2e38..84b6a940f 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -163,7 +163,7 @@ struct tst_test {
 	 *
 	 * Also, we do cleanup and restore work for the hpages resetting automatically.
 	 */
-	unsigned int request_hugepages;
+	unsigned long request_hugepages;
 
 	/*
 	 * If set non-zero denotes number of test variant, the test is executed
diff --git a/lib/newlib_tests/test20.c b/lib/newlib_tests/test20.c
index 92e230976..53317b669 100644
--- a/lib/newlib_tests/test20.c
+++ b/lib/newlib_tests/test20.c
@@ -18,22 +18,22 @@ static const char * const save_restore[] = {
 
 static void do_test(void) {
 
-	int val, hpages;
+	unsigned long val, hpages;
 
-	tst_res(TINFO, "tst_hugepages = %u", tst_hugepages);
+	tst_res(TINFO, "tst_hugepages = %lu", tst_hugepages);
 	SAFE_FILE_PRINTF("/proc/sys/kernel/numa_balancing", "1");
 
 	hpages = test.request_hugepages;
-	SAFE_FILE_SCANF(PATH_NR_HPAGES, "%d", &val);
+	SAFE_FILE_SCANF(PATH_NR_HPAGES, "%lu", &val);
 	if (val != hpages)
-		tst_brk(TBROK, "nr_hugepages = %d, but expect %d", val, hpages);
+		tst_brk(TBROK, "nr_hugepages = %lu, but expect %lu", val, hpages);
 	else
 		tst_res(TPASS, "test .needs_hugepges");
 
 	hpages = tst_request_hugepages(3);
-	SAFE_FILE_SCANF(PATH_NR_HPAGES, "%d", &val);
+	SAFE_FILE_SCANF(PATH_NR_HPAGES, "%lu", &val);
 	if (val != hpages)
-		tst_brk(TBROK, "nr_hugepages = %d, but expect %d", val, hpages);
+		tst_brk(TBROK, "nr_hugepages = %lu, but expect %lu", val, hpages);
 	else
 		tst_res(TPASS, "tst_request_hugepages");
 }
diff --git a/lib/tst_hugepage.c b/lib/tst_hugepage.c
index 3f20a9ede..c75fb264d 100644
--- a/lib/tst_hugepage.c
+++ b/lib/tst_hugepage.c
@@ -8,12 +8,11 @@
 #include "tst_test.h"
 #include "tst_hugepage.h"
 
-unsigned int tst_hugepages;
+unsigned long tst_hugepages;
 
-int tst_request_hugepages(int hpages)
+unsigned long tst_request_hugepages(unsigned long hpages)
 {
-	int val;
-	long max_hpages;
+	unsigned long val, max_hpages;
 
 	if (access(PATH_HUGEPAGES, F_OK)) {
 		tst_hugepages = 0;
@@ -25,8 +24,8 @@ int tst_request_hugepages(int hpages)
 	max_hpages = SAFE_READ_MEMINFO("MemFree:") / SAFE_READ_MEMINFO("Hugepagesize:");
 
 	if (hpages > max_hpages) {
-		tst_res(TINFO, "Requested number(%d) of hugepages is too large, "
-				"limiting to 80%% of the max hugepage count %ld",
+		tst_res(TINFO, "Requested number(%lu) of hugepages is too large, "
+				"limiting to 80%% of the max hugepage count %lu",
 				hpages, max_hpages);
 		tst_hugepages = max_hpages * 0.8;
 
@@ -35,12 +34,12 @@ int tst_request_hugepages(int hpages)
 	}
 
 	tst_sys_conf_save("?/proc/sys/vm/nr_hugepages");
-	SAFE_FILE_PRINTF(PATH_NR_HPAGES, "%d", tst_hugepages);
-	SAFE_FILE_SCANF(PATH_NR_HPAGES, "%d", &val);
+	SAFE_FILE_PRINTF(PATH_NR_HPAGES, "%lu", tst_hugepages);
+	SAFE_FILE_SCANF(PATH_NR_HPAGES, "%lu", &val);
 	if (val != tst_hugepages)
-		tst_brk(TBROK, "nr_hugepages = %d, but expect %d", val, tst_hugepages);
+		tst_brk(TBROK, "nr_hugepages = %lu, but expect %lu", val, tst_hugepages);
 
-	tst_res(TINFO, "%d hugepage(s) reserved", tst_hugepages);
+	tst_res(TINFO, "%lu hugepage(s) reserved", tst_hugepages);
 out:
 	return tst_hugepages;
 }
-- 
2.18.0



