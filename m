From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed,  6 Nov 2019 07:18:08 +0100
Subject: [LTP] [PATCH] memcg_subgroup_charge: Remove memory limitation
Message-ID: <20191106061808.67330-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

The test is supposed to verify, that memory used by a task
is not migrated to a subgroup, when the task is migrated.
In order to test this, it is not required, to limit
the memory at all, because accounting is done anyway and
the test checks the memory statistics.

Therefore all memory limiting is removed. This also gets
rid of a faulty assumption when writing the test:
The test allocates 33 pages using mmap. It is expected,
that it does not need more than 33 * pagesize of memory.
But sometimes the kernel has to allocate new page tables.
This is accounted as kmem AND user memory.
(See kernel doc cgroup-v1/memory.txt section 2.7)
If this happend, the test failed, if the system has no swap,
because the oom killer kills the process.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 .../kernel/controllers/memcg/functional/memcg_lib.sh |  4 ----
 .../memcg/functional/memcg_subgroup_charge.sh        | 12 +-----------
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index aadaae4d2..aec8a00ab 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -404,13 +404,9 @@ test_hugepage()
 }
 
 # Test the memory charge won't move to subgroup
-# $1 - memory.limit_in_bytes in parent group
-# $2 - memory.limit_in_bytes in sub group
 test_subgroup()
 {
 	mkdir subgroup
-	echo $1 > memory.limit_in_bytes
-	echo $2 > subgroup/memory.limit_in_bytes
 
 	tst_resm TINFO "Running memcg_process --mmap-anon -s $PAGESIZES"
 	memcg_process --mmap-anon -s $PAGESIZES &
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh b/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
index 9b11f7b58..98e5ad68d 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
@@ -26,7 +26,7 @@
 ################################################################################
 
 TCID="memcg_subgroup_charge"
-TST_TOTAL=3
+TST_TOTAL=1
 
 . memcg_lib.sh
 
@@ -36,15 +36,5 @@ testcase_1()
 	test_subgroup $PAGESIZES $((2*PAGESIZES))
 }
 
-testcase_2()
-{
-	test_subgroup $PAGESIZES $PAGESIZES
-}
-
-testcase_3()
-{
-	test_subgroup $PAGESIZES 0
-}
-
 run_tests
 tst_exit
-- 
2.20.1

