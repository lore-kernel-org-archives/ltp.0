From: Li Wang <liwang@redhat.com>
Date: Wed, 14 Dec 2016 18:09:03 +0800
Subject: [LTP] [PATCH v2 3/4] ltp/numa: reconstruct these testcases
Message-ID: <1481710143-18400-1-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

These case occasionally failed on RHEL platform:

 numa02      2  TFAIL  :  ltpapicmd.c:200: Test #2: NUMA hit and othernode increase in node0 is less than expected
 numa03      3  TFAIL  :  ltpapicmd.c:200: Test #3: NUMA interleave hit in node0 is less than expected
 numa08      8  TFAIL  :  ltpapicmd.c:200: Test #8: NUMA interleave hit in node0 is less than expected

From git log (commit e439df0ea74231), it says "In RHEL collection of
istics take more time", and add sleep 2s in the case. I looked
into the detail and found that's reasonable, numastat growing slowly on
RHEL system, therefore tests failed with numastate update uncompleted.
Despite all that, sleeping 2 sec still working bad during my test.

In this patch, reconstruct the whole tests in a new method which detect
numa statistics more precisely by command 'numastat -p $pid'.

The worth to say, I take use of Cyril's proposal to add a few lines of
code to the numa helper so that it can test the share memory just like
the command blow does:

 `numactl --length=1M --file /dev/shm/numa_shm --interleave=all --touch`

And, the orignal test7() has been removed, replaced by a new test for share
memory allocated on preferred numa node(see: test3).

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/numa/README         |  17 +-
 testcases/kernel/numa/numa01.sh      | 450 ++++++++++++-----------------------
 testcases/kernel/numa/support_numa.c |  51 +++-
 3 files changed, 210 insertions(+), 308 deletions(-)

diff --git a/testcases/kernel/numa/README b/testcases/kernel/numa/README
index 6f04f0c..57b12f7 100644
--- a/testcases/kernel/numa/README
+++ b/testcases/kernel/numa/README
@@ -26,24 +26,23 @@ Verifies the preferred node memory policy which will allocate memory from the no
 testcase will use the support_numa process for the verfication.
 
 TestCase3:
-Verifies the memory interleaving policy which will distribute the memory evenly among all nodes. This
+Verifies the preferred node memory policy which will allocate shared memory from the node we specify. This
 testcase will use the support_numa process for the verfication.
 
 TestCase4:
-Verifies the physical cpu affinity which runs the process support_numa on the specified physical cpu number.
+Verifies the memory interleaving policy which will distribute the memory evenly among all nodes. This
+testcase will use the support_numa process for the verfication.
 
 TestCase5:
-Verifies the local allocation policy which always allocates memory from the local node. This testcase
-will use the support_numa process for the verfication.
+Verifies the memory interleaving policy which will distribute the memory evenly among all nodes. This
+testcase will use the support_numa process for the verfication.
 
 TestCase6:
-Verifies the memory interleaving policy on the shared memory which will interleave the shared memory on
-all nodes equally. Here, the testcase use touch command instead of running a seperate process to verify
-the policy applied.
+Verifies the physical cpu affinity which runs the process support_numa on the specified physical cpu number.
 
 TestCase7:
-Verifies the memory interleaving policy which will distribute the memory evenly among all nodes. This
-testcase will use the numademo for the verfication.
+Verifies the local allocation policy which always allocates memory from the local node. This testcase
+will use the support_numa process for the verfication.
 
 TestCase8:
 Verifies the memory interleaving policy which will distribute the memory evenly among all nodes. This
diff --git a/testcases/kernel/numa/numa01.sh b/testcases/kernel/numa/numa01.sh
index bbfaded..39f3af5 100755
--- a/testcases/kernel/numa/numa01.sh
+++ b/testcases/kernel/numa/numa01.sh
@@ -23,11 +23,11 @@
 # Description:  Test Basic functionality of numactl command.                 #
 #               Test #1: Verifies cpunodebind and membind                    #
 #               Test #2: Verifies preferred node bind for memory allocation  #
-#               Test #3: Verifies memory interleave on all nodes             #
-#               Test #4: Verifies physcpubind                                #
-#               Test #5: Verifies localalloc                                 #
-#               Test #6: Verifies memory policies on shared memory           #
-#               Test #7: Verifies numademo                                   #
+#               Test #3: Verifies share memory allocation on preferred node  #
+#               Test #4: Verifies memory interleave on all nodes             #
+#               Test #5: Verifies share memory interleave on all nodes       #
+#               Test #6: Verifies physcpubind                                #
+#               Test #7: Verifies localalloc                                 #
 #               Test #8: Verifies memhog                                     #
 #               Test #9: Verifies numa_node_size api                         #
 #               Test #10:Verifies Migratepages                               #
@@ -44,85 +44,34 @@ TST_NEEDS_CMDS="numactl numastat awk"
 
 . tst_test.sh
 
-# Function:     extract_numastat
+# Function:     extract_numastat_p
 #
-# Description:  - extract the value of given row, column from the numastat output.
+# Description:  - extract the value of given numa node from the `numastat -p` output.
 #
-# Input:        - $1 - row number.
-#               - $2 - column number.
+# Input:        - $1 - Pid number.
+#               - $2 - Node number.
 #
-extract_numastat()
+extract_numastat_p()
 {
-	RC=0
-
-	# check whether numastat output is changed
-
-	numastat > numalog
-
-	RC=$(awk '
-	{ if ( NR == '$2' ){
-		print $1;
-		}
-	}
-	' numalog)
-	if [ $RC != $1 ]
-	then
-		tst_brk TBROK "numastat o/p seems to be changed, $1 expected to be in the row $2"
-	fi
-
-	RC=$(awk '
-	{ if ( NR == '$2' ){
-		print $'$3';
-		}
-	}
-	' numalog)
+	local 	pid=$1
+	local 	node=$(($2 + 2))
 
-	rm -f numalog
-
-	echo $RC
-}
-
-# Function:     comparelog
-#
-# Description:  - return the difference of input arguments if they are in
-#                 increasing order.
-#
-# Input:        - $1 - original value.
-#               - $2 - changed value.
-#
-# Return:       - difference of arguments on success.
-comparelog()
-{
-	if [ $2 -gt $1 ]; then
-		RC=$(($2-$1))
-	else
-		RC=0
-	fi
-
-	echo $RC
+	echo $(numastat -p $pid |grep '^Total' |awk '{print $'$node'}')
 }
 
 # Function: setup
 #
-# Description:  - Check if command required for this test exits.
-#               - Initialize global variables.
+# Description:  - Initialize global variables.
 #
 setup()
 {
 	export MB=$((1024*1024))
 	export PAGE_SIZE=$(getconf PAGE_SIZE)
 
-	# row definitions, pls see at the top of this file
-	numa_hit=2
-	numa_miss=3
-	numa_foreign=4
-	interleave_hit=5
-	local_node=6
-	other_node=7
-
 	# arguments to memory exercise program support_numa.c
 	ALLOC_1MB=1
-	PAUSE=2
+	SHARE_1MB=2
+	PAUSE=3
 
 	total_nodes=0       # total no. of numa nodes
 	# all availiable nodes id list
@@ -130,43 +79,37 @@ setup()
 	for node in $nodes_list; do
 		total_nodes=$((total_nodes+1))
 	done
+
 	tst_res TINFO "The system contains $total_nodes nodes: $nodes_list"
 	if [ $total_nodes -le 1 ]; then
-		tst_res TCONF "your machine does not support numa policy
+		tst_brk TCONF "your machine does not support numa policy
 		or your machine is not a NUMA machine"
-		exit 0
 	fi
 }
 
 # Function:     test1
 #
-# Description:  - Verification of local node and memory affinity
+# Description:  - Verification of memory allocated on a node
 #
 test1()
 {
-	RC=0                # Return value from commands.
-	Prev_value=0        # extracted from the numastat o/p
-	Curr_value=0        # Current value extracted from numastat o/p
-	Exp_incr=0          # 1 MB/ PAGESIZE
-	col=0
+	Mem_curr=0
 
-	# Increase in numastat o/p is interms of pages
-	Exp_incr=$((MB/PAGE_SIZE))
-
-	COUNTER=1
 	for node in $nodes_list; do
-		col=$((COUNTER+1))		# Node number in numastat o/p
-		Prev_value=$(extract_numastat local_node $local_node $col)
-		numactl --cpunodebind=$node --membind=$node support_numa $ALLOC_1MB
-		Curr_value=$(extract_numastat local_node $local_node $col)
+		numactl --cpunodebind=$node --membind=$node support_numa $ALLOC_1MB &
+		pid=$!
+
+		# Wait a little msec for memory allocating in background
+		tst_sleep 100ms
 
-		RC=$(comparelog $Prev_value $Curr_value)
-		if [ $RC -lt $Exp_incr ]; then
+		Mem_curr=$(echo "$(extract_numastat_p $pid $node) * $MB" |bc)
+		if [ $(echo "$Mem_curr < $MB" | bc) -eq 1 ]; then
 			tst_res TFAIL \
-				"NUMA hit and localnode increase in node$node is less than expected"
+				"NUMA memory allocated in node$node is less than expected"
 			return
 		fi
-		COUNTER=$((COUNTER+1))
+
+		kill -18 $pid 2>&1 >/dev/null
 	done
 
 	tst_res TPASS "NUMA local node and memory affinity -TEST01 PASSED !!"
@@ -174,43 +117,35 @@ test1()
 
 # Function:     test2
 #
-# Description:  - Verification of memory allocated from preferred node
+# Description:  - Verification of memory allocated on preferred node
 #
 test2()
 {
-	RC=0                # Return value from commands.
-	Prev_value=0        # extracted from the numastat o/p
-	Curr_value=0        # Current value extracted from numastat o/p
-	Exp_incr=0          # 1 MB/ PAGESIZE
-	col=0
-
-	# Increase in numastat o/p is interms of pages
-	Exp_incr=$((MB/PAGE_SIZE))
+	Mem_curr=0
 
 	COUNTER=1
 	for node in $nodes_list; do
 
-		if [ $COUNTER -eq $total_nodes ]   #wrap up for last node
-		then
+		if [ $COUNTER -eq $total_nodes ]; then   #wrap up for last node
 			Preferred_node=$(echo $nodes_list | cut -d ' ' -f 1)
-			col=2			   #column represents node0 in numastat o/p
 		else
 			# always next node is preferred node
 			Preferred_node=$(echo $nodes_list | cut -d ' ' -f $((COUNTER+1)))
-			col=$((COUNTER+2))         #Preferred Node number in numastat o/p
 		fi
 
-		Prev_value=$(extract_numastat other_node $other_node $col)
-		numactl --cpunodebind=$node --preferred=$Preferred_node support_numa $ALLOC_1MB
+		numactl --cpunodebind=$node --preferred=$Preferred_node support_numa $ALLOC_1MB &
+		pid=$!
+		tst_sleep 100ms
 
-		Curr_value=$(extract_numastat other_node $other_node $col)
-		RC=$(comparelog $Prev_value $Curr_value)
-		if [ $RC -lt $Exp_incr ]; then
+		Mem_curr=$(echo "$(extract_numastat_p $pid $Preferred_node) * $MB" |bc)
+		if [ $(echo "$Mem_curr < $MB" |bc ) -eq 1 ]; then
 			tst_res TFAIL \
-				"NUMA hit and othernode increase in node$node is less than expected"
+				"NUMA memory allocated in node$Preferred_node is less than expected"
 			return
 		fi
+
 		COUNTER=$((COUNTER+1))
+		kill -18 $pid 2>&1 >/dev/null
 	done
 
 	tst_res TPASS "NUMA preferred node policy -TEST02 PASSED !!"
@@ -218,53 +153,103 @@ test2()
 
 # Function:     test3
 #
-# Description:  - Verification of memory interleaved on all nodes
+# Description:  - Verification of share memory allocated on preferred node
 #
 test3()
 {
-	RC=0                # Return value from commands.
-	Prev_value=0        # extracted from the numastat o/p
-	Pstr_value=""       # string contains previous value of all nodes
-	Curr_value=0        # Current value extracted from numastat o/p
-	Exp_incr=0          # 1 MB/ (PAGESIZE*num_of_nodes)
-	col=0
-
-	# Increase in numastat o/p is interms of pages
-	Exp_incr=$((MB/PAGE_SIZE))
-	# Pages will be allocated using round robin on nodes.
-	Exp_incr=$((Exp_incr/total_nodes))
-
-	# Check whether the pages are equally distributed among available nodes
+	Mem_curr=0
 	COUNTER=1
+
 	for node in $nodes_list; do
-		col=$((COUNTER+1))              #Node number in numastat o/p
-		Prev_value=$(extract_numastat interleave_hit $interleave_hit $col)
-		Pstr_value+="$Prev_value "
+
+		if [ $COUNTER -eq $total_nodes ]   #wrap up for last node
+		then
+			Preferred_node=$(echo $nodes_list | cut -d ' ' -f 1)
+		else
+			# always next node is preferred node
+			Preferred_node=$(echo $nodes_list | cut -d ' ' -f $((COUNTER+1)))
+		fi
+
+		numactl --cpunodebind=$node --preferred=$Preferred_node support_numa $SHARE_1MB &
+		pid=$!
+		tst_sleep 100ms
+
+		Mem_curr=$(echo "$(extract_numastat_p $pid $Preferred_node) * $MB" |bc)
+		if [ $(echo "$Mem_curr < $MB" |bc ) -eq 1 ]; then
+			tst_res TFAIL \
+				"NUMA share memory allocated in node$Preferred_node is less than expected"
+			return
+		fi
+
 		COUNTER=$((COUNTER+1))
+		kill -18 $pid 2>&1 >/dev/null
 	done
 
-	numactl --interleave=all support_numa $ALLOC_1MB
+	tst_res TPASS "NUMA share memory allocated in preferred node -TEST03 PASSED !!"
+}
+
+# Function:     test4
+#
+# Description:  - Verification of memory interleaved on all nodes
+#
+test4()
+{
+	Mem_curr=0
+	# Memory will be allocated using round robin on nodes.
+	Exp_incr=$(echo "$MB / $total_nodes" |bc)
+
+	numactl --interleave=all support_numa $ALLOC_1MB &
+	pid=$!
+	tst_sleep 100ms
 
-	COUNTER=1
 	for node in $nodes_list; do
-		col=$((COUNTER+1))             #Node number in numastat o/p
-		Curr_value=$(extract_numastat interleave_hit $interleave_hit $col)
-		RC=$(comparelog $(echo $Pstr_value | cut -d ' ' -f $COUNTER) $Curr_value)
-		if [ $RC -lt $Exp_incr ]; then
+		Mem_curr=$(echo "$(extract_numastat_p $pid $node) * $MB" |bc)
+
+		if [ $(echo "$Mem_curr < $Exp_incr" |bc ) -eq 1 ]; then
 			tst_res TFAIL \
-				"NUMA interleave hit in node$node is less than expected"
+				"NUMA interleave memory allocated in node$node is less than expected"
 			return
 		fi
-		COUNTER=$((COUNTER+1))
 	done
-	tst_res TPASS "NUMA interleave policy -TEST03 PASSED !!"
+
+	kill -18 $pid 2>&1 >/dev/null
+	tst_res TPASS "NUMA interleave policy -TEST04 PASSED !!"
 }
 
-# Function:     test4
+# Function:     test5
+#
+# Description:  - Verification of shared memory interleaved on all nodes
+#
+test5()
+{
+	Mem_curr=0
+	# Memory will be allocated using round robin on nodes.
+	Exp_incr=$(echo "$MB / $total_nodes" |bc)
+
+	numactl --interleave=all support_numa $SHARE_1MB &
+	pid=$!
+	tst_sleep 100ms
+
+	for node in $nodes_list; do
+		Mem_curr=$(echo "$(extract_numastat_p $pid $node) * $MB" |bc)
+
+		if [ $(echo "$Mem_curr < $Exp_incr" |bc ) -eq 1 ]; then
+			tst_res TFAIL \
+				"NUMA interleave share memory allocated in node$node is less than expected"
+			return
+		fi
+	done
+
+	kill -18 $pid 2>&1 >/dev/null
+
+	tst_res TPASS "NUMA interleave policy on shared memory -TEST05 PASSED !!"
+}
+
+# Function:     test6
 #
 # Description:  - Verification of physical cpu bind
 #
-test4()
+test6()
 {
 	no_of_cpus=0	#no. of cpu's exist
 	run_on_cpu=0
@@ -294,181 +279,61 @@ test4()
 		tst_brk TBROK "Kill on process $pid fails"
 	fi
 
-	tst_res TPASS "NUMA phycpubind policy -TEST04 PASSED !!"
+	tst_res TPASS "NUMA phycpubind policy -TEST06 PASSED !!"
 }
 
-# Function:     test5
+# Function:     test7
 #
 # Description:  - Verification of local node allocation
 #
-test5()
+test7()
 {
-	RC=0                # Return value from commands.
-	Prev_value=0        # extracted from the numastat o/p
-	Curr_value=0        # Current value extracted from numastat o/p
-	Exp_incr=0          # 1 MB/ PAGESIZE
-	col=0
+	Mem_curr=0
 
-	# Increase in numastat o/p is interms of pages
-	Exp_incr=$((MB/PAGE_SIZE))
-
-	COUNTER=1
 	for node in $nodes_list; do
-		col=$((COUNTER+1))               #Node number in numastat o/p
-		Prev_value=$(extract_numastat local_node $local_node $col)
-		numactl --cpunodebind=$node --localalloc support_numa $ALLOC_1MB
-		Curr_value=$(extract_numastat local_node $local_node $col)
-		RC=$(comparelog $Prev_value $Curr_value)
-		if [ $RC -lt $Exp_incr ]; then
-			tst_res TFAIL \
-				"NUMA hit and localnode increase in node$node is less than expected"
-			return
-		fi
-		COUNTER=$((COUNTER+1))
-	done
-
-	tst_res TPASS "NUMA local node allocation -TEST05 PASSED !!"
-}
-
-# Function:     test6
-#
-# Description:  - Verification of shared memory interleaved on all nodes
-#
-test6()
-{
-	RC=0                # Return value from commands.
-	Prev_value=0        # extracted from the numastat o/p
-	Pstr_value=""       # string contains previous value of all nodes
-	Curr_value=0        # Current value extracted from numastat o/p
-	Exp_incr=0          # 1 MB/ (PAGESIZE*num_of_nodes)
-	col=0
-
-	# Increase in numastat o/p is interms of pages
-	Exp_incr=$((MB/PAGE_SIZE))
-	# Pages will be allocated using round robin on nodes.
-	Exp_incr=$((Exp_incr/total_nodes))
-
-	# Check whether the pages are equally distributed among available nodes
-	COUNTER=1
-	for node in $nodes_list; do
-		col=$((COUNTER+1))              #Node number in numastat o/p
-		Prev_value=$(extract_numastat numa_hit $numa_hit $col)
-		Pstr_value+="$Prev_value "
-		COUNTER=$((COUNTER+1))
-	done
-
-	numactl --length=1M --file /dev/shm/ltp_numa_shm --interleave=all --touch
+		numactl --cpunodebind=$node --localalloc support_numa $ALLOC_1MB &
+		pid=$!
+		tst_sleep 100ms
 
-	COUNTER=1
-	for node in $nodes_list; do
-		col=$((COUNTER+1))              #Node number in numastat o/p
-		Curr_value=$(extract_numastat numa_hit $numa_hit $col)
-		RC=$(comparelog $(echo $Pstr_value | cut -d ' ' -f $COUNTER) $Curr_value)
-		if [ $RC -lt $Exp_incr ]; then
+		Mem_curr=$(echo "$(extract_numastat_p $pid $node) * $MB" |bc)
+		if [ $(echo "$Mem_curr < $MB" |bc ) -eq 1 ]; then
 			tst_res TFAIL \
-				"NUMA numa_hit for shm file ltp_numa_shm in node$node is less than expected"
+				"NUMA localnode memory allocated in node$node is less than expected"
 			return
 		fi
-		COUNTER=$((COUNTER+1))
-	done
-
-	tst_res TPASS "NUMA interleave policy on shared memory -TEST06 PASSED !!"
-	RC=0
-	rm -r /dev/shm/ltp_numa_shm || RC=$?
-	if [ $RC -ne 0 ]; then
-		tst_res TFAIL "Failed removing shared memory file ltp_numa_shm"
-	fi
-}
 
-# Function:     test7
-#
-# Description:  - Verification of numademo
-#
-test7()
-{
-	RC=0                # Return value from commands.
-	Prev_value=0        # extracted from the numastat o/p
-	Pstr_value=""       # string contains previous value of all nodes
-	Curr_value=0        # Current value extracted from numastat o/p
-	Exp_incr=0          # 1 MB/ (PAGESIZE*num_of_nodes)
-	col=0
-	msize=1000
-	KB=1024
-	# Increase in numastat o/p is interms of pages
-	Exp_incr=$(($((KB * msize))/PAGE_SIZE))
-	# Pages will be allocated using round robin on nodes.
-	Exp_incr=$((Exp_incr/total_nodes))
-
-	# Check whether the pages are equally distributed among available nodes
-	COUNTER=1
-	for node in $nodes_list; do
-		col=$((COUNTER+1))              #Node number in numastat o/p
-		Prev_value=$(extract_numastat interleave_hit $interleave_hit $col)
-		Pstr_value+="$Prev_value "
-		COUNTER=$((COUNTER+1))
+		kill -18 $pid 2>&1 >/dev/null
 	done
 
-	numademo -c ${msize}k > gdemolog
-
-	COUNTER=1
-	x=0
-	for node in $nodes_list; do
-		col=$((COUNTER+1))              #Node number in numastat o/p
-		Curr_value=$(extract_numastat interleave_hit $interleave_hit $col)
-		RC=$(comparelog $(echo $Pstr_value | cut -d ' ' -f $COUNTER) $Curr_value)
-		if [ $RC -le $Exp_incr ]; then
-			x=1
-			break;
-		fi
-		COUNTER=$((COUNTER+1))
-	done
-	if [ $x -eq 0 ]; then
-		tst_res TPASS "NUMADEMO policies  -TEST07 PASSED !!"
-	else
-		tst_res TFAIL "NUMA interleave hit is less than expected"
-	fi
+	tst_res TPASS "NUMA local node allocation -TEST07 PASSED !!"
 }
 
+
 # Function:     test8
 #
 # Description:  - Verification of memhog with interleave policy
 #
 test8()
 {
-	RC=0                # Return value from commands.
-	Prev_value=0        # extracted from the numastat o/p
-	Pstr_value=""       # string contains previous value of all nodes
-	Curr_value=0        # Current value extracted from numastat o/p
-	Exp_incr=0          # 1 MB/ (PAGESIZE*num_of_nodes)
-	col=0
-
-	# Increase in numastat o/p is interms of pages
-	Exp_incr=$((MB/$PAGE_SIZE))
-	# Pages will be allocated using round robin on nodes.
-	Exp_incr=$((Exp_incr/total_nodes))
-
-	# Check whether the pages are equally distributed among available nodes
-	COUNTER=1
-	for node in $nodes_list; do
-		col=$((COUNTER+1))              #Node number in numastat o/p
-		Prev_value=$(extract_numastat interleave_hit $interleave_hit $col)
-		Pstr_value+="$Prev_value "
-		COUNTER=$((COUNTER+1))
-	done
-	numactl --interleave=all memhog 1MB
+	Mem_curr=0
+	# Memory will be allocated using round robin on nodes.
+	Exp_incr=$(echo "$MB / $total_nodes" |bc)
+
+	numactl --interleave=all memhog -r1000000 1MB 2>&1 >/dev/null  &
+	pid=$!
+	tst_sleep 100ms
 
-	COUNTER=1
 	for node in $nodes_list; do
-		col=$((COUNTER+1))              #Node number in numastat o/p
-		Curr_value=$(extract_numastat interleave_hit $interleave_hit $col)
-		RC=$(comparelog $(echo $Pstr_value | cut -d ' ' -f $COUNTER) $Curr_value)
-		if [ $RC -lt $Exp_incr ]; then
+		Mem_curr=$(echo "$(extract_numastat_p $pid $node) * $MB" |bc)
+
+		if [ $(echo "$Mem_curr < $Exp_incr" |bc ) -eq 1 ]; then
 			tst_res TFAIL \
-				"NUMA interleave hit in node$node is less than expected"
+				"NUMA interleave memhog in node$node is less than expected"
 			return
 		fi
-		COUNTER=$((COUNTER+1))
 	done
+
+	kill -9 $pid 2>&1 >/dev/null
 	tst_res TPASS "NUMA MEMHOG policy -TEST08 PASSED !!"
 }
 
@@ -513,33 +378,32 @@ test9()
 #
 test10()
 {
-	RC=0
-	Prev_value=0
-	Curr_value=0
-
+	Mem_curr=0
 	COUNTER=1
+
 	for node in $nodes_list; do
 
 		if [ $COUNTER -eq $total_nodes ]; then
-			Preferred_node=`echo $nodes_list | cut -d ' ' -f 1`
-			col=2
+			Preferred_node=$(echo $nodes_list | cut -d ' ' -f 1)
 		else
-			Preferred_node=`echo $nodes_list | cut -d ' ' -f $[$COUNTER+1]`
-			col=$((COUNTER+2))
+			Preferred_node=$(echo $nodes_list | cut -d ' ' -f $((COUNTER+1)))
 		fi
 
-		Prev_value=$(extract_numastat other_node $other_node $col)
-		numactl --preferred=$node support_numa $PAUSE &
+		numactl --preferred=$node support_numa $ALLOC_1MB &
 		pid=$!
+		tst_sleep 100ms
+
 		migratepages $pid $node $Preferred_node
-		Curr_value=$(extract_numastat other_node $other_node $col)
-		kill -9 $pid
-		if [ $Curr_value -lt $Prev_value ]; then
+
+		Mem_curr=$(echo "$(extract_numastat_p $pid $Preferred_node) * $MB" |bc)
+		if [ $(echo "$Mem_curr < $MB" |bc ) -eq 1 ]; then
 			tst_res TFAIL \
 				"NUMA migratepages is not working fine"
 			return
 		fi
+
 		COUNTER=$((COUNTER+1))
+		kill -18 $pid 2>&1 >/dev/null
 	done
 
 	tst_res TPASS "NUMA MIGRATEPAGES policy -TEST10 PASSED !!"
diff --git a/testcases/kernel/numa/support_numa.c b/testcases/kernel/numa/support_numa.c
index c8064e2..82c9353 100644
--- a/testcases/kernel/numa/support_numa.c
+++ b/testcases/kernel/numa/support_numa.c
@@ -35,21 +35,27 @@
 #include <signal.h>
 #include <limits.h>
 #include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <fcntl.h>
 
 /* Global Variables */
 #define MB (1<<20)
 #define PAGE_SIZE getpagesize()
 #define barrier() __asm__ __volatile__("": : :"memory")
+#define TEST_SFILE "ltp_numa_testfile"
+#define STR "abcdefghijklmnopqrstuvwxyz12345\n"
 
 void sigfunc(__attribute__ ((unused)) int sig)
 {
 }
 
-void help()
+void help(void)
 {
 	printf("Input:	Describe input arguments to this program\n");
-	printf("	argv[1] == 1 then print pagesize\n");
-	printf("	argv[1] == 2 then allocate 1MB of memory\n");
+	printf("	argv[1] == 1 then allocate 1MB of memory\n");
+	printf("	argv[1] == 2 then allocate 1MB of share memory\n");
 	printf("	argv[1] == 3 then pause the program to catch sigint\n");
 	printf("Exit:	On failure - Exits with non-zero value\n");
 	printf("	On success - exits with 0 exit value\n");
@@ -59,8 +65,9 @@ void help()
 
 int main(int argc, char *argv[])
 {
-	int i;
+	int i, fd, rc;
 	char *buf = NULL;
+	struct stat sb;
 	struct sigaction sa;
 
 	if (argc != 2) {
@@ -79,9 +86,39 @@ int main(int argc, char *argv[])
 			buf[i] = 'a';
 			barrier();
 		}
+
+		raise(SIGSTOP);
+
 		free(buf);
-		return 0;
+		break;
 	case 2:
+		fd = open(TEST_SFILE, O_RDWR | O_CREAT, 0666);
+		/* Writing 1MB of random data into this file [32 * 32768 = 1024 * 1024] */
+		for (i = 0; i < 32768; i++){
+			rc = write(fd, STR, strlen(STR));
+			if (rc == -1 || ((size_t)rc != strlen(STR)))
+				fprintf(stderr, "write failed\n");
+		}
+
+		if ((fstat(fd, &sb)) == -1)
+			fprintf(stderr, "fstat failed\n");
+
+		buf = mmap(NULL, sb.st_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+		if (buf == MAP_FAILED){
+			fprintf(stderr, "mmap failed\n");
+			close(fd);
+			exit(1);
+		}
+
+		memset(buf, 'a', sb.st_size);
+
+		raise(SIGSTOP);
+
+		munmap(buf, sb.st_size);
+		close(fd);
+		remove(TEST_SFILE);
+		break;
+	case 3:
 		/* Trap SIGINT */
 		sa.sa_handler = sigfunc;
 		sa.sa_flags = SA_RESTART;
@@ -92,8 +129,10 @@ int main(int argc, char *argv[])
 		}
 		/* wait for signat Int */
 		pause();
-		return 0;
+		break;
 	default:
 		help();
 	}
+
+	return 0;
 }
-- 
1.8.3.1

