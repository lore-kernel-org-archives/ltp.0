From: Petr Vorel <petr.vorel@gmail.com>
Date: Thu,  2 Jul 2020 01:31:33 +0200
Subject: [LTP] [PATCH 1/1] numa01.sh: Handle computation error
Message-ID: <20200701233133.122801-1-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

when numastat -p did not give a value, the resulting bc calculation was
empty string instead of 0, thus shell -eq comparison lacked the first
operator:

Mem_curr=$(echo "$(extract_numastat_p $pid $node) * $MB" |bc)
if [ $(echo "$Mem_curr < $MB" |bc ) -eq 1 ]; then

(standard_in) 1: syntax error
(standard_in) 1: syntax error
/root/ltp-install/testcases/bin/numa01.sh: line 93: [: -eq: unary operator expected

Also fix style (use local and lowercase local function variables).

Fixes: 702

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
Hi,

Simple fix for https://github.com/linux-test-project/ltp/issues/702,
I guess there should be more checks. Not tested.
BTW I thought numa01.sh was intended to be replaced with C (@Cyril: am I
correct?), thus I didn't bother to split syntax fix into 2 commits.


Kind regards,
Petr

 testcases/kernel/numa/numa01.sh | 95 ++++++++++++++++++---------------
 1 file changed, 51 insertions(+), 44 deletions(-)

diff --git a/testcases/kernel/numa/numa01.sh b/testcases/kernel/numa/numa01.sh
index 1d626327d..a217db033 100755
--- a/testcases/kernel/numa/numa01.sh
+++ b/testcases/kernel/numa/numa01.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) International Business Machines Corp., 2007
-# Copyright (c) Linux Test Project, 2016
+# Copyright (c) Linux Test Project, 2016-2020
 # Author: Sivakumar Chinnaiah <Sivakumar.C@in.ibm.com>
 #
 # Test Basic functionality of numactl command.
@@ -12,9 +12,9 @@
 # Test #5: Verifies localalloc
 # Test #6: Verifies memhog
 # Test #7: Verifies numa_node_size api
-# Test #8:Verifies Migratepages
-# Test #9:Verifies hugepage alloacted on specified node
-# Test #10:Verifies THP memory allocated on preferred node
+# Test #8: Verifies Migratepages
+# Test #9: Verifies hugepage alloacted on specified node
+# Test #10: Verifies THP memory allocated on preferred node
 
 TST_CNT=10
 TST_SETUP=setup
@@ -25,15 +25,24 @@ TST_NEEDS_CMDS="awk bc numactl numastat"
 
 . tst_test.sh
 
-# Extracts the value of given numa node from the `numastat -p` output.
-# $1 - Pid number.
-# $2 - Node number.
-extract_numastat_p()
+# Convert the value of given numa node from the `numastat -p` output,
+# multiply by size.
+# $1 - Pid number
+# $2 - Node number
+# $3 - Size for multiplication (e.g. 1024, $MB)
+get_mem_cur()
 {
 	local pid=$1
 	local node=$(($2 + 2))
+	local size=$3
+	local numstat=$(numastat -p $pid |awk '/^Total/ {print $'$node'}')
 
-	echo $(numastat -p $pid |awk '/^Total/ {print $'$node'}')
+	if [ -z "$numstat" ]; then
+		echo 0
+		return
+	fi
+
+	echo $(echo "$numstat * $size" | bc)
 }
 
 check_for_support_numa()
@@ -72,7 +81,7 @@ setup()
 # Verification of memory allocated on a node
 test1()
 {
-	Mem_curr=0
+	local mem_curr
 
 	for node in $nodes_list; do
 		numactl --cpunodebind=$node --membind=$node support_numa alloc_1MB &
@@ -80,8 +89,8 @@ test1()
 
 		TST_RETRY_FUNC "check_for_support_numa $pid" 0
 
-		Mem_curr=$(echo "$(extract_numastat_p $pid $node) * $MB" |bc)
-		if [ $(echo "$Mem_curr < $MB" | bc) -eq 1 ]; then
+		mem_curr=$(get_mem_cur $pid $node $MB)
+		if [ $(echo "$mem_curr < $MB" | bc) -eq 1 ]; then
 			tst_res TFAIL \
 				"NUMA memory allocated in node$node is less than expected"
 			kill -CONT $pid >/dev/null 2>&1
@@ -97,16 +106,16 @@ test1()
 # Verification of memory allocated on preferred node
 test2()
 {
-	Mem_curr=0
+	local mem_curr
+	local cnt=1
 
-	COUNTER=1
 	for node in $nodes_list; do
 
-		if [ $COUNTER -eq $total_nodes ]; then   #wrap up for last node
+		if [ $cnt -eq $total_nodes ]; then   #wrap up for last node
 			Preferred_node=$(echo $nodes_list | cut -d ' ' -f 1)
 		else
 			# always next node is preferred node
-			Preferred_node=$(echo $nodes_list | cut -d ' ' -f $((COUNTER+1)))
+			Preferred_node=$(echo $nodes_list | cut -d ' ' -f $((cnt+1)))
 		fi
 
 		numactl --cpunodebind=$node --preferred=$Preferred_node support_numa alloc_1MB &
@@ -114,15 +123,15 @@ test2()
 
 		TST_RETRY_FUNC "check_for_support_numa $pid" 0
 
-		Mem_curr=$(echo "$(extract_numastat_p $pid $Preferred_node) * $MB" |bc)
-		if [ $(echo "$Mem_curr < $MB" |bc ) -eq 1 ]; then
+		mem_curr=$(get_mem_cur $pid $Preferred_node $MB)
+		if [ $(echo "$mem_curr < $MB" |bc ) -eq 1 ]; then
 			tst_res TFAIL \
 				"NUMA memory allocated in node$Preferred_node is less than expected"
 			kill -CONT $pid >/dev/null 2>&1
 			return
 		fi
 
-		COUNTER=$((COUNTER+1))
+		cnt=$((cnt+1))
 		kill -CONT $pid >/dev/null 2>&1
 	done
 
@@ -132,7 +141,7 @@ test2()
 # Verification of memory interleaved on all nodes
 test3()
 {
-	Mem_curr=0
+	local mem_curr
 	# Memory will be allocated using round robin on nodes.
 	Exp_incr=$(echo "$MB / $total_nodes" |bc)
 
@@ -142,9 +151,9 @@ test3()
 	TST_RETRY_FUNC "check_for_support_numa $pid" 0
 
 	for node in $nodes_list; do
-		Mem_curr=$(echo "$(extract_numastat_p $pid $node) * $MB" |bc)
+		mem_curr=$(get_mem_cur $pid $node $MB)
 
-		if [ $(echo "$Mem_curr < $Exp_incr" |bc ) -eq 1 ]; then
+		if [ $(echo "$mem_curr < $Exp_incr" |bc ) -eq 1 ]; then
 			tst_res TFAIL \
 				"NUMA interleave memory allocated in node$node is less than expected"
 			kill -CONT $pid >/dev/null 2>&1
@@ -191,7 +200,7 @@ test4()
 # Verification of local node allocation
 test5()
 {
-	Mem_curr=0
+	local mem_curr
 
 	for node in $nodes_list; do
 		numactl --cpunodebind=$node --localalloc support_numa alloc_1MB &
@@ -199,8 +208,8 @@ test5()
 
 		TST_RETRY_FUNC "check_for_support_numa $pid" 0
 
-		Mem_curr=$(echo "$(extract_numastat_p $pid $node) * $MB" |bc)
-		if [ $(echo "$Mem_curr < $MB" |bc ) -eq 1 ]; then
+		mem_curr=$(get_mem_cur $pid $node $MB)
+		if [ $(echo "$mem_curr < $MB" |bc ) -eq 1 ]; then
 			tst_res TFAIL \
 				"NUMA localnode memory allocated in node$node is less than expected"
 			kill -CONT $pid >/dev/null 2>&1
@@ -221,7 +230,7 @@ check_ltp_numa_test8_log()
 # Verification of memhog with interleave policy
 test6()
 {
-	Mem_curr=0
+	local mem_curr
 	# Memory will be allocated using round robin on nodes.
 	Exp_incr=$(echo "$MB / $total_nodes" |bc)
 
@@ -231,9 +240,9 @@ test6()
 	TST_RETRY_FUNC "check_ltp_numa_test8_log" 0
 
 	for node in $nodes_list; do
-		Mem_curr=$(echo "$(extract_numastat_p $pid $node) * $MB" |bc)
+		mem_curr=$(get_mem_cur $pid $node $MB)
 
-		if [ $(echo "$Mem_curr < $Exp_incr" |bc ) -eq 1 ]; then
+		if [ $(echo "$mem_curr < $Exp_incr" |bc ) -eq 1 ]; then
 			tst_res TFAIL \
 				"NUMA interleave memhog in node$node is less than expected"
 			kill -KILL $pid >/dev/null 2>&1
@@ -283,15 +292,14 @@ test7()
 # Verification of migratepages
 test8()
 {
-	Mem_curr=0
-	COUNTER=1
+	local mem_curr
+	local cnt=1
 
 	for node in $nodes_list; do
-
-		if [ $COUNTER -eq $total_nodes ]; then
+		if [ $cnt -eq $total_nodes ]; then
 			Preferred_node=$(echo $nodes_list | cut -d ' ' -f 1)
 		else
-			Preferred_node=$(echo $nodes_list | cut -d ' ' -f $((COUNTER+1)))
+			Preferred_node=$(echo $nodes_list | cut -d ' ' -f $((cnt+1)))
 		fi
 
 		numactl --preferred=$node support_numa alloc_1MB &
@@ -301,15 +309,15 @@ test8()
 
 		migratepages $pid $node $Preferred_node
 
-		Mem_curr=$(echo "$(extract_numastat_p $pid $Preferred_node) * $MB" |bc)
-		if [ $(echo "$Mem_curr < $MB" |bc ) -eq 1 ]; then
+		mem_curr=$(get_mem_cur $pid $Preferred_node $MB)
+		if [ $(echo "$mem_curr < $MB" |bc ) -eq 1 ]; then
 			tst_res TFAIL \
 				"NUMA migratepages is not working fine"
 			kill -CONT $pid >/dev/null 2>&1
 			return
 		fi
 
-		COUNTER=$((COUNTER+1))
+		cnt=$((cnt+1))
 		kill -CONT $pid >/dev/null 2>&1
 	done
 
@@ -363,21 +371,20 @@ test9()
 # Verification of THP memory allocated on preferred node
 test10()
 {
-	Mem_curr=0
+	local mem_curr
+	local cnt=1
 
 	if ! grep -q '\[always\]' /sys/kernel/mm/transparent_hugepage/enabled; then
 		tst_res TCONF "THP is not supported/enabled"
 		return
 	fi
 
-	COUNTER=1
 	for node in $nodes_list; do
-
-		if [ $COUNTER -eq $total_nodes ]; then   #wrap up for last node
+		if [ $cnt -eq $total_nodes ]; then   #wrap up for last node
 			Preferred_node=$(echo $nodes_list | cut -d ' ' -f 1)
 		else
 			# always next node is preferred node
-			Preferred_node=$(echo $nodes_list | cut -d ' ' -f $((COUNTER+1)))
+			Preferred_node=$(echo $nodes_list | cut -d ' ' -f $((cnt+1)))
 		fi
 
 		numactl --cpunodebind=$node --preferred=$Preferred_node support_numa alloc_2HPSZ_THP &
@@ -385,15 +392,15 @@ test10()
 
 		TST_RETRY_FUNC "check_for_support_numa $pid" 0
 
-		Mem_curr=$(echo "$(extract_numastat_p $pid $Preferred_node) * 1024" |bc)
-		if [ $(echo "$Mem_curr < $HPAGE_SIZE * 2" |bc ) -eq 1 ]; then
+		mem_curr=$(get_mem_cur $pid $Preferred_node 1024)
+		if [ $(echo "$mem_curr < $HPAGE_SIZE * 2" |bc ) -eq 1 ]; then
 			tst_res TFAIL \
 				"NUMA memory allocated in node$Preferred_node is less than expected"
 			kill -CONT $pid >/dev/null 2>&1
 			return
 		fi
 
-		COUNTER=$((COUNTER+1))
+		cnt=$((cnt+1))
 		kill -CONT $pid >/dev/null 2>&1
 	done
 
-- 
2.27.0.rc0

