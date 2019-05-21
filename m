From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 21 May 2019 10:25:18 +0200
Subject: [LTP] [PATCH] overcommit_memory: update for "mm: fix false-positive
	OVERCOMMIT_GUESS failures"
Message-ID: <dc7300409a949189aa4ce9ef555405e36bdb50ab.1558426636.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

commit 8c7829b04c52 ("mm: fix false-positive OVERCOMMIT_GUESS failures")
changes logic of __vm_enough_memory(), simplifying it to:
    When in GUESS mode, catch wild allocations by comparing their request
    size to total amount of ram and swap in the system.

Testcase currently allocates mem_total + swap_total, which doesn't trigger
new condition. Make it more extreme, but assuming free_total / 2 will PASS,
and sum_total * 2 will FAIL.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/mem/tunable/overcommit_memory.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/mem/tunable/overcommit_memory.c b/testcases/kernel/mem/tunable/overcommit_memory.c
index 555298fbfd85..345764dfe427 100644
--- a/testcases/kernel/mem/tunable/overcommit_memory.c
+++ b/testcases/kernel/mem/tunable/overcommit_memory.c
@@ -36,11 +36,10 @@
  *
  * The program is designed to test the two tunables:
  *
- * When overcommit_memory = 0, allocatable memory can't overextends
- * the amount of free memory. I choose the three cases:
+ * When overcommit_memory = 0, allocatable memory can't overextend
+ * the amount of total memory:
  * a. less than free_total:    free_total / 2, alloc should pass.
- * b. greater than free_total: free_total * 2, alloc should fail.
- * c. equal to sum_total:      sum_tatal,      alloc should fail
+ * b. greater than sum_total:   sum_total * 2, alloc should fail.
  *
  * When overcommit_memory = 1, it can alloc enough much memory, I
  * choose the three cases:
@@ -164,9 +163,7 @@ static void overcommit_memory_test(void)
 
 	update_mem();
 	alloc_and_check(free_total / 2, EXPECT_PASS);
-	update_mem();
-	alloc_and_check(free_total * 2, EXPECT_FAIL);
-	alloc_and_check(sum_total, EXPECT_FAIL);
+	alloc_and_check(sum_total * 2, EXPECT_FAIL);
 
 	/* start to test overcommit_memory=1 */
 	set_sys_tune("overcommit_memory", 1, 1);
-- 
1.8.3.1

