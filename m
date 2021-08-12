From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Thu, 12 Aug 2021 10:02:42 +0200
Subject: [LTP] [PATCH v2 4/4] controllers/memcg: check status of commands
 using interface
In-Reply-To: <20210812080242.16972-1-krzysztof.kozlowski@canonical.com>
References: <20210812080242.16972-1-krzysztof.kozlowski@canonical.com>
Message-ID: <20210812080242.16972-5-krzysztof.kozlowski@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Most of the cgroups interface returns some valid and meaningful error
code (e.g. ENOMEM if creating subgroup failed).  Check these to be sure
that all errors are caught, like in this example:

    memcg_subgroup_charge 1 TINFO: set /dev/memcg/memory.use_hierarchy to 0 failed
    memcg_subgroup_charge 1 TINFO: Test that group and subgroup have no relationship
    /home/ubuntu/ltp-install/testcases/bin/memcg_subgroup_charge.sh: 36: echo: echo: I/O error
    memcg_subgroup_charge 1 TINFO: Running memcg_process --mmap-anon -s 270336
    memcg_subgroup_charge 1 TINFO: Warming up pid: 13496
    memcg_subgroup_charge 1 TINFO: Process is still here after warm up: 13496

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../controllers/memcg/functional/memcg_lib.sh |  2 +-
 .../memcg_max_usage_in_bytes_test.sh          |  8 +++----
 .../memcg/functional/memcg_stat_test.sh       | 24 +++++++++----------
 .../memcg/functional/memcg_subgroup_charge.sh |  4 ++--
 .../functional/memcg_usage_in_bytes_test.sh   |  4 ++--
 5 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index c8b5df2b45f7..ee14a29fae81 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -380,7 +380,7 @@ test_limit_in_bytes()
 	local use_memsw=$2
 	local elimit
 
-	echo $limit > memory.limit_in_bytes
+	EXPECT_PASS echo $limit \> memory.limit_in_bytes
 	if [ $use_memsw -eq 1 ]; then
 		memcg_require_memsw
 		echo $limit > memory.memsw.limit_in_bytes
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_max_usage_in_bytes_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_max_usage_in_bytes_test.sh
index a0c4dd17f0f3..6a2607c4333b 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_max_usage_in_bytes_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_max_usage_in_bytes_test.sh
@@ -67,8 +67,8 @@ test2()
 	tst_res TINFO "Test memory.memsw.max_usage_in_bytes"
 	memcg_require_memsw
 
-	echo $MEM_LIMIT > memory.limit_in_bytes
-	echo $MEM_LIMIT > memory.memsw.limit_in_bytes
+	EXPECT_PASS echo $MEM_LIMIT \> memory.limit_in_bytes
+	EXPECT_PASS echo $MEM_LIMIT \> memory.memsw.limit_in_bytes
 	test_max_usage_in_bytes 1 0
 }
 
@@ -83,8 +83,8 @@ test4()
 	tst_res TINFO "Test reset memory.memsw.max_usage_in_bytes"
 	memcg_require_memsw
 
-	echo $MEM_LIMIT > memory.limit_in_bytes
-	echo $MEM_LIMIT > memory.memsw.limit_in_bytes
+	EXPECT_PASS echo $MEM_LIMIT \> memory.limit_in_bytes
+	EXPECT_PASS echo $MEM_LIMIT \> memory.memsw.limit_in_bytes
 	test_max_usage_in_bytes 1 1
 }
 
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh
index c9034f7d4b41..0308b40bab53 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh
@@ -46,8 +46,8 @@ test5()
 	local limit=$(memcg_adjust_limit_for_kmem $PAGESIZES)
 
 	ROD mkdir subgroup
-	echo $limit > memory.limit_in_bytes
-	echo $((limit + PAGESIZES * 2)) > subgroup/memory.limit_in_bytes
+	EXPECT_PASS echo $limit \> memory.limit_in_bytes
+	EXPECT_PASS echo $((limit + PAGESIZES * 2)) \> subgroup/memory.limit_in_bytes
 
 	cd subgroup
 	check_mem_stat "hierarchical_memory_limit" $limit
@@ -64,8 +64,8 @@ test6()
 	ROD echo 0 \> memory.use_hierarchy
 
 	ROD mkdir subgroup
-	echo $PAGESIZES > memory.limit_in_bytes
-	echo $((PAGESIZES * 2)) > subgroup/memory.limit_in_bytes
+	EXPECT_PASS echo $PAGESIZES \> memory.limit_in_bytes
+	EXPECT_PASS echo $((PAGESIZES * 2)) \> subgroup/memory.limit_in_bytes
 
 	cd subgroup
 	check_mem_stat "hierarchical_memory_limit" $((PAGESIZES * 2))
@@ -82,10 +82,10 @@ test7()
 	ROD echo 1 \> memory.use_hierarchy
 
 	ROD mkdir subgroup
-	echo $PAGESIZES > memory.limit_in_bytes
-	echo $PAGESIZES > memory.memsw.limit_in_bytes
-	echo $((PAGESIZES * 2)) > subgroup/memory.limit_in_bytes
-	echo $((PAGESIZES * 2)) > subgroup/memory.memsw.limit_in_bytes
+	EXPECT_PASS echo $PAGESIZES \> memory.limit_in_bytes
+	EXPECT_PASS echo $PAGESIZES \> memory.memsw.limit_in_bytes
+	EXPECT_PASS echo $((PAGESIZES * 2)) \> subgroup/memory.limit_in_bytes
+	EXPECT_PASS echo $((PAGESIZES * 2)) \> subgroup/memory.memsw.limit_in_bytes
 
 	cd subgroup
 	check_mem_stat "hierarchical_memsw_limit" $PAGESIZES
@@ -103,10 +103,10 @@ test8()
 	ROD echo 0 \> memory.use_hierarchy
 
 	ROD mkdir subgroup
-	echo $PAGESIZES > memory.limit_in_bytes
-	echo $PAGESIZES > memory.memsw.limit_in_bytes
-	echo $((PAGESIZES * 2)) > subgroup/memory.limit_in_bytes
-	echo $((PAGESIZES * 2)) > subgroup/memory.memsw.limit_in_bytes
+	EXPECT_PASS echo $PAGESIZES \> memory.limit_in_bytes
+	EXPECT_PASS echo $PAGESIZES \> memory.memsw.limit_in_bytes
+	EXPECT_PASS echo $((PAGESIZES * 2)) \> subgroup/memory.limit_in_bytes
+	EXPECT_PASS echo $((PAGESIZES * 2)) \> subgroup/memory.memsw.limit_in_bytes
 
 	cd subgroup
 	check_mem_stat "hierarchical_memsw_limit" $((PAGESIZES * 2))
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh b/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
index c28c39cf4387..3fa016102151 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
@@ -33,8 +33,8 @@ test_subgroup()
 	fi
 
 	ROD mkdir subgroup
-	echo $limit_parent > memory.limit_in_bytes
-	echo $limit_subgroup > subgroup/memory.limit_in_bytes
+	EXPECT_PASS echo $limit_parent \> memory.limit_in_bytes
+	EXPECT_PASS echo $limit_subgroup \> subgroup/memory.limit_in_bytes
 
 	start_memcg_process --mmap-anon -s $MEM_TO_ALLOC
 
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_usage_in_bytes_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_usage_in_bytes_test.sh
index 9140fd9d1fd7..6c1b365057f8 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_usage_in_bytes_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_usage_in_bytes_test.sh
@@ -28,8 +28,8 @@ test2()
 	tst_res TINFO "Test memory.memsw.usage_in_bytes"
 	memcg_require_memsw
 
-	echo $MEM_LIMIT > memory.limit_in_bytes
-	echo $MEM_LIMIT > memory.memsw.limit_in_bytes
+	EXPECT_PASS echo $MEM_LIMIT \> memory.limit_in_bytes
+	EXPECT_PASS echo $MEM_LIMIT \> memory.memsw.limit_in_bytes
 	test_mem_stat "--mmap-anon" $MEM_TO_ALLOC $MEM_TO_ALLOC \
 		"memory.memsw.usage_in_bytes" $MEM_TO_ALLOC \
 		$MEM_EXPECTED_UPPER false
-- 
2.30.2

