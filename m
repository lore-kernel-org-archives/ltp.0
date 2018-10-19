From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 19 Oct 2018 16:44:20 +0800
Subject: [LTP] [PATCH] mem/overcommit_memory.c: Fix "CommitLimit <
	Committed_AS" error in some situations
Message-ID: <1539938660-18786-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

By default, system with overcommit_memory=2 will ensure "CommitLimit >=
Committed_AS" when setting overcommit_ratio.  But we change overcommit_ratio
to a random value forcely, so it's possible to decrease CommitLimit less
than current Committed_AS when setting overcommit_ratio to a quite small
value(e.g. 0).

For example, there are 5G physical memory, 4G swap and 5G allocated memory
(i.e. Committed_AS) on system, and then running overcommit_memory02(i.e.
overcommit_memory -R 0) always triggers the "CommitLimit < Committed_AS"
error:
----------------------------------------------------------------------
mem.c:839: INFO: set overcommit_ratio to 0
mem.c:839: INFO: set overcommit_memory to 2
overcommit_memory.c:235: INFO: CommitLimit is 4194300, Committed_AS is 5405908
overcommit_memory.c:237: BROK: Unexpected error: CommitLimit < Committed_AS
----------------------------------------------------------------------

We try to skip test if setting a small value of overcommit_ratio results in
"CommitLimit < Committed_AS".

Fix: #215

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 .../kernel/mem/tunable/overcommit_memory.c    | 30 ++++++++++++-------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/mem/tunable/overcommit_memory.c b/testcases/kernel/mem/tunable/overcommit_memory.c
index 82ceac5f6..b92232b8d 100644
--- a/testcases/kernel/mem/tunable/overcommit_memory.c
+++ b/testcases/kernel/mem/tunable/overcommit_memory.c
@@ -92,6 +92,7 @@ static long commit_left;
 static int heavy_malloc(long size);
 static void alloc_and_check(long size, int expect_result);
 static void update_mem(void);
+static void update_mem_commit(void);
 
 static void setup(void)
 {
@@ -151,10 +152,10 @@ static void overcommit_memory_test(void)
 	/* start to test overcommit_memory=2 */
 	set_sys_tune("overcommit_memory", 2, 1);
 
-	update_mem();
+	update_mem_commit();
 	alloc_and_check(commit_left * 2, EXPECT_FAIL);
 	alloc_and_check(commit_limit, EXPECT_FAIL);
-	update_mem();
+	update_mem_commit();
 	alloc_and_check(commit_left / 2, EXPECT_PASS);
 
 	/* start to test overcommit_memory=0 */
@@ -219,23 +220,32 @@ static void alloc_and_check(long size, int expect_result)
 static void update_mem(void)
 {
 	long mem_free, swap_free;
-	long committed;
 
 	mem_free = SAFE_READ_MEMINFO("MemFree:");
 	swap_free = SAFE_READ_MEMINFO("SwapFree:");
 	free_total = mem_free + swap_free;
+}
+
+static void update_mem_commit(void)
+{
+	long committed;
+
 	commit_limit = SAFE_READ_MEMINFO("CommitLimit:");
+	committed = SAFE_READ_MEMINFO("Committed_AS:");
+	commit_left = commit_limit - committed;
 
-	if (get_sys_tune("overcommit_memory") == 2) {
-		committed = SAFE_READ_MEMINFO("Committed_AS:");
-		commit_left = commit_limit - committed;
+	if (commit_left < 0) {
+		tst_res(TINFO, "CommitLimit is %ld, Committed_AS is %ld",
+			commit_limit, committed);
 
-		if (commit_left < 0) {
-			tst_res(TINFO, "CommitLimit is %ld, Committed_AS"
-				 " is %ld", commit_limit, committed);
+		if (overcommit_ratio > old_overcommit_ratio) {
 			tst_brk(TBROK, "Unexpected error: "
-				 "CommitLimit < Committed_AS");
+				"CommitLimit < Committed_AS");
 		}
+
+		tst_brk(TCONF, "Specified overcommit_ratio %ld < default %ld, "
+			"so it's possible for CommitLimit < Committed_AS and "
+			"skip test", overcommit_ratio, old_overcommit_ratio);
 	}
 }
 
-- 
2.17.0



