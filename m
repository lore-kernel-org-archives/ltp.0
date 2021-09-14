From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 14 Sep 2021 09:34:43 +0100
Subject: [LTP] [PATCH] memcg_subgroup_charge: Remove limiting of parent
In-Reply-To: <a47ecbd7-ba4a-ff2c-ead9-e731040cb845@jv-coder.de>
References: <a47ecbd7-ba4a-ff2c-ead9-e731040cb845@jv-coder.de>
Message-ID: <20210914083444.23848-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It is not important how much memory is assigned to the parent
group. The stated purpose of the test is to check no memory is
assigned to the child group.

Also add the usage stats for the memcg_process because it appears
the test will fail because the starting memory counter already
includes some buffer/cache on linux-next. I'm not sure this
is exactly what happens, but displaying the stats might help.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Suggested-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
Cc: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 .../controllers/memcg/functional/memcg_lib.sh    |  2 +-
 .../memcg/functional/memcg_subgroup_charge.sh    | 16 +++++-----------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index ac9ad8268..1b76b6597 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -240,7 +240,7 @@ signal_memcg_process()
 
 		loops=$((loops - 1))
 		if [ $loops -le 0 ]; then
-			tst_brk TBROK "timed out on memory.usage_in_bytes"
+			tst_brk TBROK "timed out on memory.usage_in_bytes" $usage $usage_start $size
 		fi
 	done
 }
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh b/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
index 3fa016102..cda624923 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
@@ -18,22 +18,16 @@ TST_CNT=3
 MEM_TO_ALLOC=$((PAGESIZES * 2))
 
 # Test the memory charge won't move to subgroup
-# $1 - memory.limit_in_bytes in parent group
-# $2 - memory.limit_in_bytes in sub group
+# $1 - memory.limit_in_bytes in sub group
 test_subgroup()
 {
-	local limit_parent=$1
-	local limit_subgroup=$2
+	local limit_subgroup=$1
 
-	if [ $limit_parent -ne 0 ]; then
-		limit_parent=$(memcg_adjust_limit_for_kmem $limit_parent)
-	fi
 	if [ $limit_subgroup -ne 0 ]; then
 		limit_subgroup=$(memcg_adjust_limit_for_kmem $limit_subgroup)
 	fi
 
 	ROD mkdir subgroup
-	EXPECT_PASS echo $limit_parent \> memory.limit_in_bytes
 	EXPECT_PASS echo $limit_subgroup \> subgroup/memory.limit_in_bytes
 
 	start_memcg_process --mmap-anon -s $MEM_TO_ALLOC
@@ -60,17 +54,17 @@ test_subgroup()
 test1()
 {
 	tst_res TINFO "Test that group and subgroup have no relationship"
-	test_subgroup $MEM_TO_ALLOC $((2 * MEM_TO_ALLOC))
+	test_subgroup $((2 * MEM_TO_ALLOC))
 }
 
 test2()
 {
-	test_subgroup $MEM_TO_ALLOC $MEM_TO_ALLOC
+	test_subgroup $MEM_TO_ALLOC
 }
 
 test3()
 {
-	test_subgroup $MEM_TO_ALLOC 0
+	test_subgroup 0
 }
 
 tst_run
-- 
2.31.1

