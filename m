From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Tue, 13 Jul 2021 11:22:10 +0200
Subject: [LTP] [PATCH v4 5/5] controllers/memcg: offset kernel memory
In-Reply-To: <20210713092210.17141-1-krzysztof.kozlowski@canonical.com>
References: <20210713092210.17141-1-krzysztof.kozlowski@canonical.com>
Message-ID: <20210713092210.17141-6-krzysztof.kozlowski@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The memory allocated by kernel with __GFP_ACCOUNT is counted as well in
memory group usage limits.  Add it to fix failures like:

    memcg_max_usage_in_bytes_test 1 TINFO: Running memcg_process --mmap-anon -s 4194304
    memcg_max_usage_in_bytes_test 1 TINFO: Warming up pid: 925811
    memcg_max_usage_in_bytes_test 1 TINFO: Process is still here after warm up: 925811
    memcg_max_usage_in_bytes_test 1 TFAIL: memory.max_usage_in_bytes is 4333568, 4194304-4325376 expected

    (where memory.kmem.max_usage_in_bytes:8192)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../controllers/memcg/functional/memcg_lib.sh     | 10 ++++++++++
 .../functional/memcg_max_usage_in_bytes_test.sh   | 15 ++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index 9634eb7e9f42..dad66c798e19 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -251,6 +251,7 @@ test_mem_stat()
 	local exp_stat_size_low=$5
 	local exp_stat_size_up=$6
 	local check_after_free=$7
+	local kmem_stat_name="${stat_name##*.}"
 
 	start_memcg_process $memtypes -s $size
 
@@ -261,6 +262,15 @@ test_mem_stat()
 	echo $MEMCG_PROCESS_PID > tasks
 	signal_memcg_process $size
 
+	if [ "$kmem_stat_name" = "max_usage_in_bytes" ] ||
+	   [ "$kmem_stat_name" = "usage_in_bytes" ]; then
+		local kmem=$(cat "memory.kmem.${kmem_stat_name}")
+		if [ $? -eq 0 ]; then
+			exp_stat_size_low=$((exp_stat_size_low + kmem))
+			exp_stat_size_up=$((exp_stat_size_up + kmem))
+		fi
+	fi
+
 	if [ "$exp_stat_size_low" = "$exp_stat_size_up" ]; then
 		check_mem_stat $stat_name $exp_stat_size_low
 	else
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_max_usage_in_bytes_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_max_usage_in_bytes_test.sh
index 2d494ac3a78f..24e9d115c19e 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_max_usage_in_bytes_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_max_usage_in_bytes_test.sh
@@ -22,6 +22,10 @@ test_max_usage_in_bytes()
 	local item="memory.max_usage_in_bytes"
 	[ $1 -eq 1 ] && item="memory.memsw.max_usage_in_bytes"
 	local check_after_reset=$2
+	local exp_stat_size_low=$MEM_TO_ALLOC
+	local exp_stat_size_up=$MEM_EXPECTED_UPPER
+	local kmem_stat_name="${item##*.}"
+
 	start_memcg_process --mmap-anon -s $MEM_TO_ALLOC
 
 	warmup
@@ -33,7 +37,16 @@ test_max_usage_in_bytes()
 	signal_memcg_process $MEM_TO_ALLOC
 	signal_memcg_process $MEM_TO_ALLOC
 
-	check_mem_stat $item $MEM_TO_ALLOC $MEM_EXPECTED_UPPER
+	if [ "$kmem_stat_name" = "max_usage_in_bytes" ] ||
+	   [ "$kmem_stat_name" = "usage_in_bytes" ]; then
+		local kmem=$(cat "memory.kmem.${kmem_stat_name}")
+		if [ $? -eq 0 ]; then
+			exp_stat_size_low=$((exp_stat_size_low + kmem))
+			exp_stat_size_up=$((exp_stat_size_up + kmem))
+		fi
+	fi
+
+	check_mem_stat $item $exp_stat_size_low $exp_stat_size_up
 
 	if [ $check_after_reset -eq 1 ]; then
 		echo 0 > $item
-- 
2.27.0

