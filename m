From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Fri,  2 Jul 2021 14:53:34 +0200
Subject: [LTP] [PATCH v3 1/5] controllers/memcg: accept range of
 max_usage_in_bytes
In-Reply-To: <20210702125338.43248-1-krzysztof.kozlowski@canonical.com>
References: <20210702125338.43248-1-krzysztof.kozlowski@canonical.com>
Message-ID: <20210702125338.43248-2-krzysztof.kozlowski@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Several Linux kernel versions report higher max_usage_in_bytes than
expected size of 1024 pages. For example v5.4, v5.8, v5.10
and 5.13.0-rc5:

    memcg_max_usage_in_bytes_test 1 TINFO: Test memory.max_usage_in_bytes
    memcg_max_usage_in_bytes_test 1 TINFO: Running memcg_process --mmap-anon -s 4194304
    memcg_max_usage_in_bytes_test 1 TINFO: Warming up pid: 1393215
    memcg_max_usage_in_bytes_test 1 TINFO: Process is still here after warm up: 1393215
    memcg_max_usage_in_bytes_test 1 TFAIL: memory.max_usage_in_bytes is 4325376, 4194304 expected

It seems that recent Linux kernel caches the statistics more
aggressively (especially on multi-CPU systems) and the batch updates of
32 pages are visible in usage_in_bytes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../controllers/memcg/functional/memcg_lib.sh | 20 +++++++++++++++++--
 .../memcg_max_usage_in_bytes_test.sh          |  3 ++-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index d9bb6d94324d..4c47e63745ff 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -27,6 +27,15 @@ fi
 # Post 4.16 kernel updates stat in batch (> 32 pages) every time
 PAGESIZES=$(($PAGESIZE * 33))
 
+# On recent Linux kernels (at least v5.4) updating stats happens in batches
+# (PAGESIZES) and also might depend on workload and number of CPUs.  The kernel
+# caches the data and does not prioritize stats precision.  This is especially
+# visible for max_usage_in_bytes where it usually exceeds
+# actual memory allocation.
+# When checking for usage_in_bytes and max_usage_in_bytes accept also higher values
+# from given range:
+MEM_USAGE_RANGE=$((PAGESIZES))
+
 HUGEPAGESIZE=$(awk '/Hugepagesize/ {print $2}' /proc/meminfo)
 [ -z $HUGEPAGESIZE ] && HUGEPAGESIZE=0
 HUGEPAGESIZE=$(($HUGEPAGESIZE * 1024))
@@ -140,7 +149,8 @@ shmmax_cleanup()
 
 # Check size in memcg
 # $1 - Item name
-# $2 - Expected size
+# $2 - Expected size lower bound
+# $3 - Expected size upper bound (optional)
 check_mem_stat()
 {
 	local item_size
@@ -151,7 +161,13 @@ check_mem_stat()
 		item_size=$(grep -w $1 memory.stat | cut -d " " -f 2)
 	fi
 
-	if [ "$2" = "$item_size" ]; then
+	if [ "$3" ]; then
+		if [ $item_size -ge $2 ] && [ $item_size -le $3 ]; then
+			tst_res TPASS "$1 is ${2}-${3} as expected"
+		else
+			tst_res TFAIL "$1 is $item_size, ${2}-${3} expected"
+		fi
+	elif [ "$2" = "$item_size" ]; then
 		tst_res TPASS "$1 is $2 as expected"
 	else
 		tst_res TFAIL "$1 is $item_size, $2 expected"
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_max_usage_in_bytes_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_max_usage_in_bytes_test.sh
index 14daa4651798..8831f1937070 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_max_usage_in_bytes_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_max_usage_in_bytes_test.sh
@@ -12,6 +12,7 @@ TST_CNT=4
 . memcg_lib.sh
 
 MEM_TO_ALLOC=$((PAGESIZE * 1024))
+MEM_EXPECTED_UPPER=$((MEM_TO_ALLOC + MEM_USAGE_RANGE))
 MEM_LIMIT=$((MEM_TO_ALLOC * 2))
 
 # Run test cases which checks memory.[memsw.]max_usage_in_bytes after make
@@ -32,7 +33,7 @@ test_max_usage_in_bytes()
 	signal_memcg_process $MEM_TO_ALLOC
 	signal_memcg_process $MEM_TO_ALLOC
 
-	check_mem_stat $item $MEM_TO_ALLOC
+	check_mem_stat $item $MEM_TO_ALLOC $MEM_EXPECTED_UPPER
 
 	if [ $check_after_reset -eq 1 ]; then
 		echo 0 > $item
-- 
2.27.0

