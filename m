From: Li Wang <liwang@redhat.com>
Date: Wed,  8 May 2019 13:23:17 +0800
Subject: [LTP] [PATCH 1/2] numa: fix numa test error with non-continuous
	nodes
Message-ID: <20190508052318.9020-2-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Numa test failed on such machine which has non-continuous numa nodes,
it gets wrong data because of the below syntax rule is not applicable
to that special situation.
  ` numastat -p $pid |awk '/^Total/ {print $'$((node+2))'}'
In this patch, we fix that to print the last column replacing by '$NF'
in awk.
  ` numastat -p $pid |awk '/^Total/ {print $NF}'

  # numactl -H
  available: 2 nodes (0,8)
  node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18
               19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34
               35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50
               51 52 53 54 55 56 57 58 59 60 61 62 63
  node 0 size: 257741 MB
  node 0 free: 253158 MB
  node 8 cpus: 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79
               80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95
               96 97 98 99 100 101 102 103 104 105 106 107 108
               109 110 111 112 113 114 115 116 117 118 119 120
               121 122 123 124 125 126 127
  node 8 size: 261752 MB
  node 8 free: 240933 MB
  node distances:
  node   0   8
    0:  10  40
    8:  40  10

  # numastat -p $pid
  Per-node process memory usage (in MBs) for PID 34168 (support_numa)
                             Node 0          Node 8           Total
                    --------------- --------------- ---------------
  Huge                         0.00            0.00            0.00
  Heap                         0.00            0.12            0.12
  Stack                        0.00            0.06            0.06
  Private                      1.62            1.50            3.12
  ----------------  --------------- --------------- ---------------
  Total                        1.62            1.69            3.31

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/numa/numa01.sh | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/numa/numa01.sh b/testcases/kernel/numa/numa01.sh
index 33393ac8d..84ba757be 100755
--- a/testcases/kernel/numa/numa01.sh
+++ b/testcases/kernel/numa/numa01.sh
@@ -52,9 +52,8 @@ TST_NEEDS_CMDS="awk bc numactl numastat"
 extract_numastat_p()
 {
 	local pid=$1
-	local node=$(($2 + 2))
 
-	echo $(numastat -p $pid |awk '/^Total/ {print $'$node'}')
+	echo $(numastat -p $pid |awk '/^Total/ {print $NF}')
 }
 
 check_for_support_numa()
@@ -101,7 +100,7 @@ test1()
 
 		TST_RETRY_FUNC "check_for_support_numa $pid" 0
 
-		Mem_curr=$(echo "$(extract_numastat_p $pid $node) * $MB" |bc)
+		Mem_curr=$(echo "$(extract_numastat_p $pid) * $MB" |bc)
 		if [ $(echo "$Mem_curr < $MB" | bc) -eq 1 ]; then
 			tst_res TFAIL \
 				"NUMA memory allocated in node$node is less than expected"
@@ -135,7 +134,7 @@ test2()
 
 		TST_RETRY_FUNC "check_for_support_numa $pid" 0
 
-		Mem_curr=$(echo "$(extract_numastat_p $pid $Preferred_node) * $MB" |bc)
+		Mem_curr=$(echo "$(extract_numastat_p $pid) * $MB" |bc)
 		if [ $(echo "$Mem_curr < $MB" |bc ) -eq 1 ]; then
 			tst_res TFAIL \
 				"NUMA memory allocated in node$Preferred_node is less than expected"
@@ -163,7 +162,7 @@ test3()
 	TST_RETRY_FUNC "check_for_support_numa $pid" 0
 
 	for node in $nodes_list; do
-		Mem_curr=$(echo "$(extract_numastat_p $pid $node) * $MB" |bc)
+		Mem_curr=$(echo "$(extract_numastat_p $pid) * $MB" |bc)
 
 		if [ $(echo "$Mem_curr < $Exp_incr" |bc ) -eq 1 ]; then
 			tst_res TFAIL \
@@ -220,7 +219,7 @@ test5()
 
 		TST_RETRY_FUNC "check_for_support_numa $pid" 0
 
-		Mem_curr=$(echo "$(extract_numastat_p $pid $node) * $MB" |bc)
+		Mem_curr=$(echo "$(extract_numastat_p $pid) * $MB" |bc)
 		if [ $(echo "$Mem_curr < $MB" |bc ) -eq 1 ]; then
 			tst_res TFAIL \
 				"NUMA localnode memory allocated in node$node is less than expected"
@@ -252,7 +251,7 @@ test6()
 	TST_RETRY_FUNC "check_ltp_numa_test8_log" 0
 
 	for node in $nodes_list; do
-		Mem_curr=$(echo "$(extract_numastat_p $pid $node) * $MB" |bc)
+		Mem_curr=$(echo "$(extract_numastat_p $pid) * $MB" |bc)
 
 		if [ $(echo "$Mem_curr < $Exp_incr" |bc ) -eq 1 ]; then
 			tst_res TFAIL \
@@ -322,7 +321,7 @@ test8()
 
 		migratepages $pid $node $Preferred_node
 
-		Mem_curr=$(echo "$(extract_numastat_p $pid $Preferred_node) * $MB" |bc)
+		Mem_curr=$(echo "$(extract_numastat_p $pid) * $MB" |bc)
 		if [ $(echo "$Mem_curr < $MB" |bc ) -eq 1 ]; then
 			tst_res TFAIL \
 				"NUMA migratepages is not working fine"
@@ -363,7 +362,7 @@ test9()
 		pid=$!
 		TST_RETRY_FUNC "check_for_support_numa $pid" 0
 
-		Mem_huge=$(echo $(numastat -p $pid |awk '/^Huge/ {print $'$((node+2))'}'))
+		Mem_huge=$(echo $(numastat -p $pid |awk '/^Huge/ {print $NF}'))
 		Mem_huge=$((${Mem_huge%.*} * 1024))
 
 		if [ "$Mem_huge" -lt "$HPAGE_SIZE" ]; then
@@ -406,7 +405,7 @@ test10()
 
 		TST_RETRY_FUNC "check_for_support_numa $pid" 0
 
-		Mem_curr=$(echo "$(extract_numastat_p $pid $Preferred_node) * 1024" |bc)
+		Mem_curr=$(echo "$(extract_numastat_p $pid) * 1024" |bc)
 		if [ $(echo "$Mem_curr < $HPAGE_SIZE * 2" |bc ) -eq 1 ]; then
 			tst_res TFAIL \
 				"NUMA memory allocated in node$Preferred_node is less than expected"
-- 
2.20.1

