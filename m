From: Li Wang <liwang@redhat.com>
Date: Thu, 17 May 2018 14:29:43 +0800
Subject: [LTP] [PATCH] ltp: replace the retry loops by new exponential
	backoff macro
Message-ID: <20180517062943.13178-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Petr Vorel <pvorel@suse.cz>
Cc: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/commands/mkswap/mkswap01.sh | 17 ++++------
 testcases/kernel/numa/numa01.sh       | 58 +++++++++++++++--------------------
 2 files changed, 31 insertions(+), 44 deletions(-)

diff --git a/testcases/commands/mkswap/mkswap01.sh b/testcases/commands/mkswap/mkswap01.sh
index 1c01c86..fc07933 100755
--- a/testcases/commands/mkswap/mkswap01.sh
+++ b/testcases/commands/mkswap/mkswap01.sh
@@ -37,25 +37,20 @@ setup()
 	DEVICE_SIZE=$((($real_size/$PAGE_SIZE * $PAGE_SIZE)/1024))
 }
 
-wait_for_file()
+check_for_file()
 {
 	local path="$1"
-	local retries=10
 
 	if [ -z "$path" ]; then
 		return
 	fi
 
-	while [ $retries -gt 0 ]; do
-		if [ -e "$path" ]; then
-			return
-		fi
-		tst_res TINFO "Waiting for $path to appear"
-		retries=$((retries - 1))
-		tst_sleep 10ms
-	done
+	if [ -e "$path" ]; then
+		return 0
+	fi
 
 	tst_res TINFO "The file $path haven't appeared"
+	return 1
 }
 
 mkswap_verify()
@@ -75,7 +70,7 @@ mkswap_verify()
 		local pagesize=$PAGE_SIZE
 	fi
 
-	wait_for_file "$dev_file"
+	TST_RETRY_FUNC "check_for_file "$dev_file"" 0
 
 	swapon $swapfile 2>/dev/null
 
diff --git a/testcases/kernel/numa/numa01.sh b/testcases/kernel/numa/numa01.sh
index 27a2f2f..f8d8f30 100755
--- a/testcases/kernel/numa/numa01.sh
+++ b/testcases/kernel/numa/numa01.sh
@@ -59,25 +59,17 @@ extract_numastat_p()
 	echo $(numastat -p $pid |awk '/^Total/ {print $'$node'}')
 }
 
-wait_for_support_numa()
+check_for_support_numa()
 {
 	local pid=$1
-	local retries=20
 
-	while [ $retries -gt 0 ]; do
-		local state=$(awk '{print $3}' /proc/$pid/stat)
+	local state=$(awk '{print $3}' /proc/$pid/stat)
 
-		if [ $state = 'T' ]; then
-			break
-		fi
-
-		retries=$((retries-1))
-		tst_sleep 50ms
-	done
-
-	if [ $retries -le 0 ]; then
-		tst_brk TBROK "Timeouted while waiting for support_numa ($pid)"
+	if [ $state = 'T' ]; then
+		return 0
 	fi
+
+	return 1
 }
 
 setup()
@@ -109,7 +101,7 @@ test1()
 		numactl --cpunodebind=$node --membind=$node support_numa alloc_1MB &
 		pid=$!
 
-		wait_for_support_numa $pid
+		TST_RETRY_FUNC "check_for_support_numa $pid" 0
 
 		Mem_curr=$(echo "$(extract_numastat_p $pid $node) * $MB" |bc)
 		if [ $(echo "$Mem_curr < $MB" | bc) -eq 1 ]; then
@@ -143,7 +135,7 @@ test2()
 		numactl --cpunodebind=$node --preferred=$Preferred_node support_numa alloc_1MB &
 		pid=$!
 
-		wait_for_support_numa $pid
+		TST_RETRY_FUNC "check_for_support_numa $pid" 0
 
 		Mem_curr=$(echo "$(extract_numastat_p $pid $Preferred_node) * $MB" |bc)
 		if [ $(echo "$Mem_curr < $MB" |bc ) -eq 1 ]; then
@@ -179,7 +171,7 @@ test3()
 		numactl --cpunodebind=$node --preferred=$Preferred_node support_numa alloc_1MB_shared &
 		pid=$!
 
-		wait_for_support_numa $pid
+		TST_RETRY_FUNC "check_for_support_numa $pid" 0
 
 		Mem_curr=$(echo "$(extract_numastat_p $pid $Preferred_node) * $MB" |bc)
 		if [ $(echo "$Mem_curr < $MB" |bc ) -eq 1 ]; then
@@ -206,7 +198,7 @@ test4()
 	numactl --interleave=all support_numa alloc_1MB &
 	pid=$!
 
-	wait_for_support_numa $pid
+	TST_RETRY_FUNC "check_for_support_numa $pid" 0
 
 	for node in $nodes_list; do
 		Mem_curr=$(echo "$(extract_numastat_p $pid $node) * $MB" |bc)
@@ -233,7 +225,7 @@ test5()
 	numactl --interleave=all support_numa alloc_1MB_shared &
 	pid=$!
 
-	wait_for_support_numa $pid
+	TST_RETRY_FUNC "check_for_support_numa $pid" 0
 
 	for node in $nodes_list; do
 		Mem_curr=$(echo "$(extract_numastat_p $pid $node) * $MB" |bc)
@@ -292,7 +284,7 @@ test7()
 		numactl --cpunodebind=$node --localalloc support_numa alloc_1MB &
 		pid=$!
 
-		wait_for_support_numa $pid
+		TST_RETRY_FUNC "check_for_support_numa $pid" 0
 
 		Mem_curr=$(echo "$(extract_numastat_p $pid $node) * $MB" |bc)
 		if [ $(echo "$Mem_curr < $MB" |bc ) -eq 1 ]; then
@@ -308,6 +300,15 @@ test7()
 	tst_res TPASS "NUMA local node allocation"
 }
 
+check_ltp_numa_test8_log()
+{
+	if grep -m1 -q '.' ltp_numa_test8.log; then
+		return 0
+	fi
+
+	return 1
+}
+
 # Verification of memhog with interleave policy
 test8()
 {
@@ -318,16 +319,7 @@ test8()
 	numactl --interleave=all memhog -r1000000 1MB >ltp_numa_test8.log 2>&1 &
 	pid=$!
 
-	local retries=20
-	while [ $retries -gt 0 ]; do
-
-		if grep -m1 -q '.' ltp_numa_test8.log; then
-			break
-		fi
-
-		retries=$((retries-1))
-		tst_sleep 50ms
-	done
+	TST_RETRY_FUNC "check_ltp_numa_test8_log" 0
 
 	for node in $nodes_list; do
 		Mem_curr=$(echo "$(extract_numastat_p $pid $node) * $MB" |bc)
@@ -396,7 +388,7 @@ test10()
 		numactl --preferred=$node support_numa alloc_1MB &
 		pid=$!
 
-		wait_for_support_numa $pid
+		TST_RETRY_FUNC "check_for_support_numa $pid" 0
 
 		migratepages $pid $node $Preferred_node
 
@@ -439,7 +431,7 @@ test11()
 
 		numactl --cpunodebind=$node --membind=$node support_numa alloc_1huge_page &
 		pid=$!
-		wait_for_support_numa $pid
+		TST_RETRY_FUNC "check_for_support_numa $pid" 0
 
 		Mem_huge=$(echo $(numastat -p $pid |awk '/^Huge/ {print $'$((node+2))'}'))
 		Mem_huge=$((${Mem_huge%.*} * 1024))
@@ -482,7 +474,7 @@ test12()
 		numactl --cpunodebind=$node --preferred=$Preferred_node support_numa alloc_2HPSZ_THP &
 		pid=$!
 
-		wait_for_support_numa $pid
+		TST_RETRY_FUNC "check_for_support_numa $pid" 0
 
 		Mem_curr=$(echo "$(extract_numastat_p $pid $Preferred_node) * 1024" |bc)
 		if [ $(echo "$Mem_curr < $HPAGE_SIZE * 2" |bc ) -eq 1 ]; then
-- 
2.9.5

