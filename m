From: Andrea Arcangeli <aarcange@redhat.com>
Date: Thu, 24 Aug 2017 19:54:50 +0200
Subject: [LTP] [PATCH 1/2] mem: ksm: fix volatile page false positive
In-Reply-To: <20170824175451.13225-1-aarcange@redhat.com>
References: <20170824175451.13225-1-aarcange@redhat.com>
Message-ID: <20170824175451.13225-2-aarcange@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To guarantee all volatile rmap_items are collected, the full scan must
run at least once. The other pages_* value not changing doesn't mean
all volatile rmap_items have been taken down.

To guarantee merging we need to wait two full scans as the first scan
will only build the unstable tree.

So waiting at least two KSM scans is going to satisfy both above
requirements.

After setting run to "2" all KSM pages have been taken down already so
no need to wait any further.

Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
---
 testcases/kernel/mem/lib/mem.c | 79 ++++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 37 deletions(-)

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 9df3b17b6..6d8945081 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -266,46 +266,38 @@ static void check(char *path, long int value)
 		tst_res(TPASS, "%s is %ld.", path, actual_val);
 }
 
-static void wait_ksmd_done(void)
+static void wait_ksmd_full_scan(void)
 {
-	long pages_shared, pages_sharing, pages_volatile, pages_unshared;
-	long old_pages_shared = 0, old_pages_sharing = 0;
-	long old_pages_volatile = 0, old_pages_unshared = 0;
-	int changing = 1, count = 0;
+	unsigned long full_scans, at_least_one_full_scan;
+	int count = 0;
 
-	while (changing) {
-		sleep(10);
+	SAFE_FILE_SCANF(PATH_KSM "full_scans", "%lu", &full_scans);
+	/*
+	 * The current scan is already in progress so we wouldn't
+	 * guarantee to call get_user_pages() on every existing
+	 * rmap_item if we only waited the remaining part of the
+	 * current scan.
+	 *
+	 * The actual merging happens after the unstable tree has been
+	 * built so we need to wait at least two full scans to
+	 * guarantee merging, so wait full_scans to increment by 3 so
+	 * at least two full scans will run.
+	 */
+	at_least_one_full_scan = full_scans + 3;
+	while (full_scans < at_least_one_full_scan) {
+		sleep(1);
 		count++;
-
-		SAFE_FILE_SCANF(PATH_KSM "pages_shared", "%ld", &pages_shared);
-		SAFE_FILE_SCANF(PATH_KSM "pages_sharing", "%ld", &pages_sharing);
-		SAFE_FILE_SCANF(PATH_KSM "pages_volatile", "%ld", &pages_volatile);
-		SAFE_FILE_SCANF(PATH_KSM "pages_unshared", "%ld", &pages_unshared);
-
-		if (pages_shared != old_pages_shared ||
-		    pages_sharing != old_pages_sharing ||
-		    pages_volatile != old_pages_volatile ||
-		    pages_unshared != old_pages_unshared) {
-			old_pages_shared = pages_shared;
-			old_pages_sharing = pages_sharing;
-			old_pages_volatile = pages_volatile;
-			old_pages_unshared = pages_unshared;
-		} else {
-			changing = 0;
-		}
+		SAFE_FILE_SCANF(PATH_KSM "full_scans", "%lu", &full_scans);
 	}
 
-	tst_res(TINFO, "ksm daemon takes %ds to scan all mergeable pages",
-		 count * 10);
+	tst_res(TINFO, "ksm daemon takes %ds to run two full scans",
+		count);
 }
 
-static void group_check(int run, int pages_shared, int pages_sharing,
-			 int pages_volatile, int pages_unshared,
-			 int sleep_millisecs, int pages_to_scan)
+static void final_group_check(int run, int pages_shared, int pages_sharing,
+			  int pages_volatile, int pages_unshared,
+			  int sleep_millisecs, int pages_to_scan)
 {
-	/* wait for ksm daemon to scan all mergeable pages. */
-	wait_ksmd_done();
-
 	tst_res(TINFO, "check!");
 	check("run", run);
 	check("pages_shared", pages_shared);
@@ -316,6 +308,22 @@ static void group_check(int run, int pages_shared, int pages_sharing,
 	check("pages_to_scan", pages_to_scan);
 }
 
+static void group_check(int run, int pages_shared, int pages_sharing,
+			int pages_volatile, int pages_unshared,
+			int sleep_millisecs, int pages_to_scan)
+{
+	if (run != 1) {
+		tst_res(TFAIL, "group_check run is not 1, %d.", run);
+	} else {
+		/* wait for ksm daemon to scan all mergeable pages. */
+		wait_ksmd_full_scan();
+	}
+
+	final_group_check(run, pages_shared, pages_sharing,
+			  pages_volatile, pages_unshared,
+			  sleep_millisecs, pages_to_scan);
+}
+
 static void verify(char **memory, char value, int proc,
 		    int start, int end, int start2, int end2)
 {
@@ -535,11 +543,11 @@ void create_same_memory(int size, int num, int unit)
 	SAFE_FILE_PRINTF(PATH_KSM "run", "2");
 
 	resume_ksm_children(child, num);
-	group_check(2, 0, 0, 0, 0, 0, size * pages * num);
+	final_group_check(2, 0, 0, 0, 0, 0, size * pages * num);
 
 	tst_res(TINFO, "stop KSM.");
 	SAFE_FILE_PRINTF(PATH_KSM "run", "0");
-	group_check(0, 0, 0, 0, 0, 0, size * pages * num);
+	final_group_check(0, 0, 0, 0, 0, 0, size * pages * num);
 
 	while (waitpid(-1, &status, WUNTRACED | WCONTINUED) > 0)
 		if (WEXITSTATUS(status) != 0)
@@ -610,7 +618,6 @@ void test_ksm_merge_across_nodes(unsigned long nr_pages)
 	 * to remerge according to the new setting.
 	 */
 	SAFE_FILE_PRINTF(PATH_KSM "run", "2");
-	wait_ksmd_done();
 	tst_res(TINFO, "Start to test KSM with merge_across_nodes=1");
 	SAFE_FILE_PRINTF(PATH_KSM "merge_across_nodes", "1");
 	SAFE_FILE_PRINTF(PATH_KSM "run", "1");
@@ -618,7 +625,6 @@ void test_ksm_merge_across_nodes(unsigned long nr_pages)
 		    nr_pages * num_nodes);
 
 	SAFE_FILE_PRINTF(PATH_KSM "run", "2");
-	wait_ksmd_done();
 	tst_res(TINFO, "Start to test KSM with merge_across_nodes=0");
 	SAFE_FILE_PRINTF(PATH_KSM "merge_across_nodes", "0");
 	SAFE_FILE_PRINTF(PATH_KSM "run", "1");
@@ -626,7 +632,6 @@ void test_ksm_merge_across_nodes(unsigned long nr_pages)
 		    0, 0, 0, nr_pages * num_nodes);
 
 	SAFE_FILE_PRINTF(PATH_KSM "run", "2");
-	wait_ksmd_done();
 }
 
 /* THP */
