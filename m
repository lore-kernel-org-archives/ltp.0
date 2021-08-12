From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Thu, 12 Aug 2021 10:02:41 +0200
Subject: [LTP] [PATCH v2 3/4] controllers/memcg: fail early to avoid
 possible false-positives
In-Reply-To: <20210812080242.16972-1-krzysztof.kozlowski@canonical.com>
References: <20210812080242.16972-1-krzysztof.kozlowski@canonical.com>
Message-ID: <20210812080242.16972-4-krzysztof.kozlowski@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Tests require certain prerequisites. If these fail, there is no point to
continue with the test.  Trying to continue might lead to false
positives, as seen on memcg_subgroup_charge which failed to set proper
limit and did not catch actual failure:

    memcg_subgroup_charge 1 TINFO: set /dev/memcg/memory.use_hierarchy to 0 failed
    memcg_subgroup_charge 1 TINFO: Test that group and subgroup have no relationship
    /home/ubuntu/ltp-install/testcases/bin/memcg_subgroup_charge.sh: 36: echo: echo: I/O error
    memcg_subgroup_charge 1 TINFO: Running memcg_process --mmap-anon -s 270336
    memcg_subgroup_charge 1 TINFO: Warming up pid: 13496
    memcg_subgroup_charge 1 TINFO: Process is still here after warm up: 13496

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../controllers/memcg/functional/memcg_failcnt.sh      |  4 ++--
 .../memcg/functional/memcg_max_usage_in_bytes_test.sh  |  2 +-
 .../functional/memcg_memsw_limit_in_bytes_test.sh      |  8 ++++----
 .../functional/memcg_move_charge_at_immigrate_test.sh  |  4 ++--
 .../controllers/memcg/functional/memcg_stat_test.sh    | 10 +++++-----
 .../memcg/functional/memcg_subgroup_charge.sh          |  2 +-
 .../memcg/functional/memcg_use_hierarchy_test.sh       | 10 +++++-----
 7 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh b/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh
index ce0885b73fe7..65ad82e0a2a0 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh
@@ -18,10 +18,10 @@ MEMORY_TO_ALLOCATE=$((MEMORY_LIMIT * 2))
 
 test()
 {
-	echo $MEMORY_LIMIT > memory.limit_in_bytes
+	ROD echo $MEMORY_LIMIT \> memory.limit_in_bytes
 
 	start_memcg_process $2 -s ${MEMORY_TO_ALLOCATE}
-	echo $MEMCG_PROCESS_PID > tasks
+	ROD echo $MEMCG_PROCESS_PID \> tasks
 
 	signal_memcg_process ${MEMORY_TO_ALLOCATE}
 	signal_memcg_process ${MEMORY_TO_ALLOCATE}
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_max_usage_in_bytes_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_max_usage_in_bytes_test.sh
index 24e9d115c19e..a0c4dd17f0f3 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_max_usage_in_bytes_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_max_usage_in_bytes_test.sh
@@ -33,7 +33,7 @@ test_max_usage_in_bytes()
 		return
 	fi
 
-	echo $MEMCG_PROCESS_PID > tasks
+	ROD echo $MEMCG_PROCESS_PID \> tasks
 	signal_memcg_process $MEM_TO_ALLOC
 	signal_memcg_process $MEM_TO_ALLOC
 
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_memsw_limit_in_bytes_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_memsw_limit_in_bytes_test.sh
index e9950a0df322..ab26cb3d1768 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_memsw_limit_in_bytes_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_memsw_limit_in_bytes_test.sh
@@ -55,7 +55,7 @@ test9()
 {
 	memcg_require_memsw
 
-	echo 10M > memory.limit_in_bytes
+	ROD echo 10M \> memory.limit_in_bytes
 
 	if tst_kvcmp -lt "2.6.31"; then
 		EXPECT_FAIL echo -1 \> memory.memsw.limit_in_bytes
@@ -68,7 +68,7 @@ test10()
 {
 	memcg_require_memsw
 
-	echo 10M > memory.limit_in_bytes
+	ROD echo 10M \> memory.limit_in_bytes
 	EXPECT_FAIL echo 1.0 \> memory.memsw.limit_in_bytes
 }
 
@@ -76,7 +76,7 @@ test11()
 {
 	memcg_require_memsw
 
-	echo 10M > memory.limit_in_bytes
+	ROD echo 10M \> memory.limit_in_bytes
 	EXPECT_FAIL echo 1xx \> memory.memsw.limit_in_bytes
 }
 
@@ -84,7 +84,7 @@ test12()
 {
 	memcg_require_memsw
 
-	echo 10M > memory.limit_in_bytes
+	ROD echo 10M \> memory.limit_in_bytes
 	EXPECT_FAIL echo xx \> memory.memsw.limit_in_bytes
 }
 
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_move_charge_at_immigrate_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_move_charge_at_immigrate_test.sh
index 272d7779770d..3c1b3394bd71 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_move_charge_at_immigrate_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_move_charge_at_immigrate_test.sh
@@ -34,10 +34,10 @@ test_move_charge()
 		return
 	fi
 
-	echo $MEMCG_PROCESS_PID > subgroup_a/tasks
+	ROD echo $MEMCG_PROCESS_PID \> subgroup_a/tasks
 	signal_memcg_process $total_size "subgroup_a/"
 
-	mkdir subgroup_b
+	ROD mkdir subgroup_b
 	echo $move_charge_mask > subgroup_b/memory.move_charge_at_immigrate
 	echo $MEMCG_PROCESS_PID > subgroup_b/tasks
 
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh
index 94eaa45ce0d8..c9034f7d4b41 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh
@@ -45,7 +45,7 @@ test5()
 
 	local limit=$(memcg_adjust_limit_for_kmem $PAGESIZES)
 
-	mkdir subgroup
+	ROD mkdir subgroup
 	echo $limit > memory.limit_in_bytes
 	echo $((limit + PAGESIZES * 2)) > subgroup/memory.limit_in_bytes
 
@@ -61,9 +61,9 @@ test6()
 	tst_res TINFO "Test hierarchical_memory_limit with disabling hierarchical accounting"
 	memcg_require_hierarchy_disabled
 
-	echo 0 > memory.use_hierarchy
+	ROD echo 0 \> memory.use_hierarchy
 
-	mkdir subgroup
+	ROD mkdir subgroup
 	echo $PAGESIZES > memory.limit_in_bytes
 	echo $((PAGESIZES * 2)) > subgroup/memory.limit_in_bytes
 
@@ -81,7 +81,7 @@ test7()
 
 	ROD echo 1 \> memory.use_hierarchy
 
-	mkdir subgroup
+	ROD mkdir subgroup
 	echo $PAGESIZES > memory.limit_in_bytes
 	echo $PAGESIZES > memory.memsw.limit_in_bytes
 	echo $((PAGESIZES * 2)) > subgroup/memory.limit_in_bytes
@@ -102,7 +102,7 @@ test8()
 
 	ROD echo 0 \> memory.use_hierarchy
 
-	mkdir subgroup
+	ROD mkdir subgroup
 	echo $PAGESIZES > memory.limit_in_bytes
 	echo $PAGESIZES > memory.memsw.limit_in_bytes
 	echo $((PAGESIZES * 2)) > subgroup/memory.limit_in_bytes
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh b/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
index 44fc7370eeff..c28c39cf4387 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
@@ -32,7 +32,7 @@ test_subgroup()
 		limit_subgroup=$(memcg_adjust_limit_for_kmem $limit_subgroup)
 	fi
 
-	mkdir subgroup
+	ROD mkdir subgroup
 	echo $limit_parent > memory.limit_in_bytes
 	echo $limit_subgroup > subgroup/memory.limit_in_bytes
 
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_use_hierarchy_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_use_hierarchy_test.sh
index 129f91b14c0a..e219823841a5 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_use_hierarchy_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_use_hierarchy_test.sh
@@ -17,10 +17,10 @@ test1()
 
 	local limit=$(memcg_adjust_limit_for_kmem $PAGESIZE)
 
-	echo 1 > memory.use_hierarchy
-	echo $limit > memory.limit_in_bytes
+	ROD echo 1 \> memory.use_hierarchy
+	ROD echo $limit \> memory.limit_in_bytes
 
-	mkdir subgroup
+	ROD mkdir subgroup
 	cd subgroup
 	test_proc_kill $((limit + PAGESIZE * 3)) "--mmap-lock1" $((limit + PAGESIZE * 2)) 0
 
@@ -34,7 +34,7 @@ test2()
 
 	memcg_require_hierarchy_disabled
 
-	mkdir subgroup
+	ROD mkdir subgroup
 	EXPECT_FAIL echo 1 \> memory.use_hierarchy
 
 	rmdir subgroup
@@ -46,7 +46,7 @@ test3()
 
 	memcg_require_hierarchy_disabled
 
-	echo 1 > memory.use_hierarchy
+	ROD echo 1 > memory.use_hierarchy
 	mkdir subgroup
 	EXPECT_FAIL echo 0 \> subgroup/memory.use_hierarchy
 
-- 
2.30.2

