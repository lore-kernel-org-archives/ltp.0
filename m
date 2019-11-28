From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 28 Nov 2019 17:31:47 +0100
Subject: [LTP] [PATCH] Unshare KSM pages before setting max_page_sharing
Message-ID: <20191128163147.4377-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Setting max_page_sharing is possible only when there are no KSM shared pages
in the system. Otherwise writing to max_page_sharing SysFS file will fail
with EBUSY.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/mem/lib/mem.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index a0c1b9b00..456259792 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -482,8 +482,11 @@ void create_same_memory(int size, int num, int unit)
 	stop_ksm_children(child, num);
 
 	tst_res(TINFO, "KSM merging...");
-	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
+	if (access(PATH_KSM "max_page_sharing", F_OK) == 0) {
+		SAFE_FILE_PRINTF(PATH_KSM "run", "2");
 		SAFE_FILE_PRINTF(PATH_KSM "max_page_sharing", "%ld", size * pages * num);
+	}
+
 	SAFE_FILE_PRINTF(PATH_KSM "run", "1");
 	SAFE_FILE_PRINTF(PATH_KSM "pages_to_scan", "%ld", size * pages * num);
 	SAFE_FILE_PRINTF(PATH_KSM "sleep_millisecs", "0");
@@ -571,16 +574,16 @@ void test_ksm_merge_across_nodes(unsigned long nr_pages)
 	SAFE_FILE_PRINTF(PATH_KSM "sleep_millisecs", "0");
 	SAFE_FILE_PRINTF(PATH_KSM "pages_to_scan", "%ld",
 			 nr_pages * num_nodes);
-	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
-		SAFE_FILE_PRINTF(PATH_KSM "max_page_sharing",
-			"%ld", nr_pages * num_nodes);
 	/*
-	 * merge_across_nodes setting can be changed only when there
-	 * are no ksm shared pages in system, so set run 2 to unmerge
-	 * pages first, then to 1 after changing merge_across_nodes,
+	 * merge_across_nodes and max_page_sharing setting can be changed
+	 * only when there are no ksm shared pages in system, so set run 2
+	 * to unmerge pages first, then to 1 after changing merge_across_nodes,
 	 * to remerge according to the new setting.
 	 */
 	SAFE_FILE_PRINTF(PATH_KSM "run", "2");
+	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
+		SAFE_FILE_PRINTF(PATH_KSM "max_page_sharing",
+			"%ld", nr_pages * num_nodes);
 	tst_res(TINFO, "Start to test KSM with merge_across_nodes=1");
 	SAFE_FILE_PRINTF(PATH_KSM "merge_across_nodes", "1");
 	SAFE_FILE_PRINTF(PATH_KSM "run", "1");
-- 
2.24.0

