From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Fri,  2 Jul 2021 14:53:35 +0200
Subject: [LTP] [PATCH v3 2/5] controllers/memcg: accept range of
 usage_in_bytes
In-Reply-To: <20210702125338.43248-1-krzysztof.kozlowski@canonical.com>
References: <20210702125338.43248-1-krzysztof.kozlowski@canonical.com>
Message-ID: <20210702125338.43248-3-krzysztof.kozlowski@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Several Linux kernel versions report higher usage_in_bytes than
expected size of 1024 pages. For example v5.4, v5.8, v5.10
and 5.13.0-rc5:

    memcg_usage_in_bytes_test 1 TINFO: Test memory.usage_in_bytes
    memcg_usage_in_bytes_test 1 TINFO: Running memcg_process --mmap-anon -s 4194304
    memcg_usage_in_bytes_test 1 TINFO: Warming up pid: 1160
    memcg_usage_in_bytes_test 1 TINFO: Process is still here after warm up: 1160
    memcg_usage_in_bytes_test 1 TFAIL: memory.usage_in_bytes is 4325376, 4194304 expected

It seems that recent Linux kernel caches the statistics more
aggressively (especially on multi-CPU systems) and the batch updates of
32 pages are visible in usage_in_bytes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../controllers/memcg/functional/memcg_lib.sh | 11 +++++++---
 .../memcg/functional/memcg_stat_rss.sh        | 20 +++++++++----------
 .../memcg/functional/memcg_stat_test.sh       |  8 ++++----
 .../functional/memcg_usage_in_bytes_test.sh   |  7 +++++--
 4 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index 4c47e63745ff..9634eb7e9f42 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -248,8 +248,9 @@ test_mem_stat()
 	local size=$2
 	local total_size=$3
 	local stat_name=$4
-	local exp_stat_size=$5
-	local check_after_free=$6
+	local exp_stat_size_low=$5
+	local exp_stat_size_up=$6
+	local check_after_free=$7
 
 	start_memcg_process $memtypes -s $size
 
@@ -260,7 +261,11 @@ test_mem_stat()
 	echo $MEMCG_PROCESS_PID > tasks
 	signal_memcg_process $size
 
-	check_mem_stat $stat_name $exp_stat_size
+	if [ "$exp_stat_size_low" = "$exp_stat_size_up" ]; then
+		check_mem_stat $stat_name $exp_stat_size_low
+	else
+		check_mem_stat $stat_name $exp_stat_size_low $exp_stat_size_up
+	fi
 
 	signal_memcg_process $size
 	if $check_after_free; then
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_stat_rss.sh b/testcases/kernel/controllers/memcg/functional/memcg_stat_rss.sh
index 1a6128a6dba8..d9b4ec287b5f 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_stat_rss.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_stat_rss.sh
@@ -18,54 +18,54 @@ TST_CNT=10
 # Test the management and counting of memory
 test1()
 {
-	test_mem_stat "--mmap-anon" $PAGESIZES $PAGESIZES "rss" $PAGESIZES false
+	test_mem_stat "--mmap-anon" $PAGESIZES $PAGESIZES "rss" $PAGESIZES $PAGESIZES false
 }
 
 test2()
 {
-	test_mem_stat "--mmap-file" $PAGESIZE $PAGESIZE "rss" 0 false
+	test_mem_stat "--mmap-file" $PAGESIZE $PAGESIZE "rss" 0 0 false
 }
 
 test3()
 {
-	test_mem_stat "--shm -k 3" $PAGESIZE $PAGESIZE "rss" 0 false
+	test_mem_stat "--shm -k 3" $PAGESIZE $PAGESIZE "rss" 0 0 false
 }
 
 test4()
 {
 	test_mem_stat "--mmap-anon --mmap-file --shm" \
-		$PAGESIZES $((PAGESIZES * 3)) "rss" $PAGESIZES false
+		$PAGESIZES $((PAGESIZES * 3)) "rss" $PAGESIZES $PAGESIZES false
 }
 
 test5()
 {
-	test_mem_stat "--mmap-lock1" $PAGESIZES $PAGESIZES "rss" $PAGESIZES false
+	test_mem_stat "--mmap-lock1" $PAGESIZES $PAGESIZES "rss" $PAGESIZES $PAGESIZES false
 }
 
 test6()
 {
-	test_mem_stat "--mmap-anon" $PAGESIZES $PAGESIZES "rss" $PAGESIZES true
+	test_mem_stat "--mmap-anon" $PAGESIZES $PAGESIZES "rss" $PAGESIZES $PAGESIZES true
 }
 
 test7()
 {
-	test_mem_stat "--mmap-file" $PAGESIZE $PAGESIZE "rss" 0 true
+	test_mem_stat "--mmap-file" $PAGESIZE $PAGESIZE "rss" 0 0 true
 }
 
 test8()
 {
-	test_mem_stat "--shm -k 8" $PAGESIZE $PAGESIZE "rss" 0 true
+	test_mem_stat "--shm -k 8" $PAGESIZE $PAGESIZE "rss" 0 0 true
 }
 
 test9()
 {
 	test_mem_stat "--mmap-anon --mmap-file --shm" \
-		$PAGESIZES $((PAGESIZES * 3)) "rss" $PAGESIZES true
+		$PAGESIZES $((PAGESIZES * 3)) "rss" $PAGESIZES $PAGESIZES true
 }
 
 test10()
 {
-	test_mem_stat "--mmap-lock1" $PAGESIZES $PAGESIZES "rss" $PAGESIZES true
+	test_mem_stat "--mmap-lock1" $PAGESIZES $PAGESIZES "rss" $PAGESIZES $PAGESIZES true
 }
 
 tst_run
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh
index 925c4ecf87bc..e5eb7e5d0001 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh
@@ -14,28 +14,28 @@ TST_CNT=8
 test1()
 {
 	tst_res TINFO "Test cache"
-	test_mem_stat "--shm -k 3" $PAGESIZES $PAGESIZES "cache" $PAGESIZES false
+	test_mem_stat "--shm -k 3" $PAGESIZES $PAGESIZES "cache" $PAGESIZES $PAGESIZES false
 }
 
 test2()
 {
 	tst_res TINFO "Test mapped_file"
 	test_mem_stat "--mmap-file" $PAGESIZES $PAGESIZES \
-		"mapped_file" $PAGESIZES false
+		"mapped_file" $PAGESIZES $PAGESIZES false
 }
 
 test3()
 {
 	tst_res TINFO "Test unevictable with MAP_LOCKED"
 	test_mem_stat "--mmap-lock1" $PAGESIZES $PAGESIZES \
-		"unevictable" $PAGESIZES false
+		"unevictable" $PAGESIZES $PAGESIZES false
 }
 
 test4()
 {
 	tst_res TINFO "Test unevictable with mlock"
 	test_mem_stat "--mmap-lock2" $PAGESIZES $PAGESIZES \
-		"unevictable" $PAGESIZES false
+		"unevictable" $PAGESIZES $PAGESIZES false
 }
 
 test5()
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_usage_in_bytes_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_usage_in_bytes_test.sh
index e77d6bf2ef23..9140fd9d1fd7 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_usage_in_bytes_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_usage_in_bytes_test.sh
@@ -12,13 +12,15 @@ TST_CNT=2
 . memcg_lib.sh
 
 MEM_TO_ALLOC=$((PAGESIZE * 1024))
+MEM_EXPECTED_UPPER=$((MEM_TO_ALLOC + MEM_USAGE_RANGE))
 MEM_LIMIT=$((MEM_TO_ALLOC * 2))
 
 test1()
 {
 	tst_res TINFO "Test memory.usage_in_bytes"
 	test_mem_stat "--mmap-anon" $MEM_TO_ALLOC $MEM_TO_ALLOC \
-		"memory.usage_in_bytes" $MEM_TO_ALLOC false
+		"memory.usage_in_bytes" $MEM_TO_ALLOC \
+		$MEM_EXPECTED_UPPER false
 }
 
 test2()
@@ -29,7 +31,8 @@ test2()
 	echo $MEM_LIMIT > memory.limit_in_bytes
 	echo $MEM_LIMIT > memory.memsw.limit_in_bytes
 	test_mem_stat "--mmap-anon" $MEM_TO_ALLOC $MEM_TO_ALLOC \
-		"memory.memsw.usage_in_bytes" $MEM_TO_ALLOC false
+		"memory.memsw.usage_in_bytes" $MEM_TO_ALLOC \
+		$MEM_EXPECTED_UPPER false
 }
 
 tst_run
-- 
2.27.0

