Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1TsuK8-0003T6-GB
	for ltp-list@lists.sourceforge.net; Wed, 09 Jan 2013 12:00:00 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TsuK6-0001mb-BT
	for ltp-list@lists.sourceforge.net; Wed, 09 Jan 2013 12:00:00 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r09BxqE2017851
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 9 Jan 2013 06:59:52 -0500
From: Zhouping Liu <zliu@redhat.com>
Date: Wed,  9 Jan 2013 19:58:23 +0800
Message-Id: <d586a4f2cfdf91b3e480c8e275f53fae34a00705.1357732655.git.zliu@redhat.com>
Subject: [LTP] [PATCH] numa/numa01.sh: fixed errors under noncontinuous numa
	nodes list
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP List <ltp-list@lists.sourceforge.net>

The previous code numa01.sh thought all NUMA system had continuous
numa nodes list, and node id started from 0, but in fact it does not.

There are lots of system contains noncontinuous numa nodes list
 e.g:
 # numactl --hardware
 available: 4 nodes (0,2,4,7)
 node 0 cpus: 0 4 8 12 16 20 24 28
 node 0 size: 4061 MB
 node 0 free: 3756 MB
 node 2 cpus: 1 5 9 13 17 21 25 29
 node 2 size: 4096 MB
 node 2 free: 3196 MB
 node 4 cpus: 2 6 10 14 18 22 26 30
 node 4 size: 4096 MB
 node 4 free: 3885 MB
 node 7 cpus: 3 7 11 15 19 23 27 31
 node 7 size: 4095 MB
 node 7 free: 3947 MB
 node distances:
 node   0   2   4   7
   0:  10  20  20  20
   2:  20  10  20  20
   4:  20  20  10  20
   7:  20  20  20  10

in such discontinuous nodes system, numa01.sh would fail with
such error log:
 libnuma: Warning: node argument 1 is out of range

The patch fixed it, and removed some useless/redundancy val/func,
such as 'max_node' val and 'getmax' func, also make some cleanup.

Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 testcases/kernel/numa/numa01.sh | 179 ++++++++++++++--------------------------
 1 file changed, 61 insertions(+), 118 deletions(-)
 mode change 100644 => 100755 testcases/kernel/numa/numa01.sh

diff --git a/testcases/kernel/numa/numa01.sh b/testcases/kernel/numa/numa01.sh
old mode 100644
new mode 100755
index 6ad8b11..19a8f71
--- a/testcases/kernel/numa/numa01.sh
+++ b/testcases/kernel/numa/numa01.sh
@@ -68,49 +68,6 @@ chk_ifexists()
     return $RC
 }
 
-
-
-# Function:     getmax
-#
-# Description:  - Returns the maximum available nodes if success.
-#
-# Input:        - o/p of numactl --hardware command which is expected in the format
-#                 shown below
-#               available: 2 nodes (0-1)
-#               node 0 size: 7808 MB
-#               node 0 free: 7457 MB
-#               node 1 size: 5807 MB
-#               node 1 free: 5731 MB
-#               node distances:
-#               node   0   1
-#                 0:  10  20
-#                 1:  20  10
-#
-# Return:       - zero on success.
-#               - non-zero on failure.
-getmax()
-{
-    numactl --hardware > $LTPTMP/avail_nodes
-
-    RC=$(awk '{ if ( NR == 1 ) {print $1;} }' $LTPTMP/avail_nodes)
-    if [ $RC = "available:" ]
-    then
-        RC=$(awk '{ if ( NR == 1 ) {print $3;} }' $LTPTMP/avail_nodes)
-        if [ $RC = "nodes" ]
-        then
-            RC=$(awk '{ if ( NR == 1 ) {print $2;} }' $LTPTMP/avail_nodes)
-            return 0;
-        else
-            tst_brkm TBROK NULL "the field nodes in the o/p of numactl --hardware seems to be different"
-        fi
-    else
-        tst_brkm TBROK NULL "the field available in the o/p of numactl --hardware seems to be different"
-    fi
-    return 1;
-}
-
-
-
 # Function:     extract_numastat
 #
 # Description:  - extract the value of given row,column from the numastat output .
@@ -187,9 +144,6 @@ init()
     export TCID="Initnuma"
     export TST_COUNT=0
 
-    # Max. no. of Nodes
-    max_node=0
-
     # Page Size
     page_size=0
 
@@ -233,18 +187,6 @@ init()
     chk_ifexists INIT kill       || return $RC
 
     RC=0
-    # set max_node
-    getmax || return 1
-    max_node=$RC
-
-    if [ $max_node -eq 1 ]
-    then
-        tst_resm TCONF "non-NUMA aware kernel is running or your machine does not support numa policy or
-                        your machine is not a NUMA machine"
-    exit 0
-    fi
-
-    RC=0
     #Set pagesize
     support_numa $PRT_PG_SIZE > $LTPTMP/numaarg || RC=$?
     if [ $RC -ne 0 ]
@@ -292,7 +234,6 @@ test01()
     Prev_value=0        # extracted from the numastat o/p
     Curr_value=0	# Current value extracted from numastat o/p
     Exp_incr=0          # 1 MB/ PAGESIZE
-    Node_num=0
     col=0
     MB=$[1024*1024]
 
@@ -300,13 +241,12 @@ test01()
     Exp_incr=$[$MB/$page_size]
 
     COUNTER=1
-    while [  $COUNTER -le $max_node ]; do
-        Node_num=$[$COUNTER-1]		#Node numbers start from 0
+    for node in `echo $nodes_list`; do
         col=$[$COUNTER+1]		#Node number in numastat o/p
         numastat > $LTPTMP/numalog
         extract_numastat local_node $local_node $col || return 1
         Prev_value=$RC
-        numactl --cpunodebind=$Node_num --membind=$Node_num support_numa $ALLOC_1MB
+        numactl --cpunodebind=$node --membind=$node support_numa $ALLOC_1MB
         numastat > $LTPTMP/numalog
         extract_numastat local_node $local_node $col || return 1
         Curr_value=$RC
@@ -314,7 +254,7 @@ test01()
         if [ $RC -lt $Exp_incr ]
         then
              tst_resm TFAIL \
-                 "Test #1: NUMA hit and localnode increase in node$Node_num is less than expected"
+                 "Test #1: NUMA hit and localnode increase in node$node is less than expected"
             return 1
         fi
         COUNTER=$[$COUNTER+1]
@@ -340,7 +280,6 @@ test02()
     Prev_value=0        # extracted from the numastat o/p
     Curr_value=0        # Current value extracted from numastat o/p
     Exp_incr=0          # 1 MB/ PAGESIZE
-    Node_num=0
     col=0
     MB=$[1024*1024]
 
@@ -348,29 +287,28 @@ test02()
     Exp_incr=$[$MB/$page_size]
 
     COUNTER=1
-    while [  $COUNTER -le $max_node ]; do
+    for node in `echo $nodes_list`; do
 
-	if [ $max_node -eq 1 ]
+	if [ $total_nodes -eq 1 ]
         then
             tst_brkm TBROK NULL "Preferred policy cant be applied for a single node machine"
 	    return 1
 	fi
 
-        Node_num=$[$COUNTER-1]         #Node numbers start from 0
-
-        if [ $COUNTER -eq $max_node ]   #wrap up for last node
+        if [ $COUNTER -eq $total_nodes ]   #wrap up for last node
  	then
-	    Preferred_node=0
+	    Preferred_node=`echo $nodes_list | cut -d ' ' -f 1`
 	    col=2			#column represents node0 in numastat o/p
 	else
-            Preferred_node=$[$Node_num+1]  #always next node is preferred node
+	    # always next node is preferred node
+	    Preferred_node=`echo $nodes_list | cut -d ' ' -f $[COUNTER+1]`
 	    col=$[$COUNTER+2]              #Preferred Node number in numastat o/p
 	fi
 
         numastat > $LTPTMP/numalog
         extract_numastat other_node $other_node $col || return 1
         Prev_value=$RC
-        numactl --cpunodebind=$Node_num --preferred=$Preferred_node support_numa $ALLOC_1MB
+        numactl --cpunodebind=$node --preferred=$Preferred_node support_numa $ALLOC_1MB
 	sleep 2s	#In RHEL collection of statistics takes more time.
         numastat > $LTPTMP/numalog
         extract_numastat other_node $other_node $col || return 1
@@ -379,7 +317,7 @@ test02()
         if [ $RC -lt $Exp_incr ]
         then
              tst_resm TFAIL \
-                 "Test #2: NUMA hit and othernode increase in node$Node_num is less than expected"
+                 "Test #2: NUMA hit and othernode increase in node$node is less than expected"
             return 1
         fi
         COUNTER=$[$COUNTER+1]
@@ -405,19 +343,18 @@ test03()
     declare -a parray   # array contains previous value of all nodes
     Curr_value=0        # Current value extracted from numastat o/p
     Exp_incr=0          # 1 MB/ (PAGESIZE*num_of_nodes)
-    Node_num=0
     col=0
     MB=$[1024*1024]
 
     # Increase in numastat o/p is interms of pages
     Exp_incr=$[$MB/$page_size]
     # Pages will be allocated using round robin on nodes.
-    Exp_incr=$[$Exp_incr/$max_node]
+    Exp_incr=$[$Exp_incr/$total_nodes]
 
     # Check whether the pages are equally distributed among available nodes
     numastat > $LTPTMP/numalog
     COUNTER=1
-    while [  $COUNTER -le $max_node ]; do
+    for node in `echo $nodes_list`; do
         col=$[$COUNTER+1]              #Node number in numastat o/p
         extract_numastat interleave_hit $interleave_hit $col || return 1
         Prev_value=$RC
@@ -430,16 +367,15 @@ test03()
 
     numastat > $LTPTMP/numalog
     COUNTER=1
-    while [  $COUNTER -le $max_node ]; do
+    for node in `echo $nodes_list`; do
         col=$[$COUNTER+1]              #Node number in numastat o/p
-	Node_num=$[$COUNTER-1]         #Node numbers start from 0
         extract_numastat interleave_hit $interleave_hit $col || return 1
         Curr_value=$RC
         comparelog ${parray[$COUNTER]} $Curr_value
         if [ $RC -lt $Exp_incr ]
         then
              tst_resm TFAIL \
-                 "Test #3: NUMA interleave hit in node$Node_num is less than expected"
+                 "Test #3: NUMA interleave hit in node$node is less than expected"
             return 1
         fi
         COUNTER=$[$COUNTER+1]
@@ -511,7 +447,6 @@ test05()
     Prev_value=0        # extracted from the numastat o/p
     Curr_value=0        # Current value extracted from numastat o/p
     Exp_incr=0          # 1 MB/ PAGESIZE
-    Node_num=0
     col=0
     MB=$[1024*1024]
 
@@ -519,13 +454,12 @@ test05()
     Exp_incr=$[$MB/$page_size]
 
     COUNTER=1
-    while [  $COUNTER -le $max_node ]; do
-        Node_num=$[$COUNTER-1]          #Node numbers start from 0
+    for node in `echo $nodes_list`; do
         col=$[$COUNTER+1]               #Node number in numastat o/p
         numastat > $LTPTMP/numalog
         extract_numastat local_node $local_node $col || return 1
         Prev_value=$RC
-        numactl --cpunodebind=$Node_num --localalloc support_numa $ALLOC_1MB
+        numactl --cpunodebind=$node --localalloc support_numa $ALLOC_1MB
         numastat > $LTPTMP/numalog
         extract_numastat local_node $local_node $col || return 1
         Curr_value=$RC
@@ -533,7 +467,7 @@ test05()
         if [ $RC -lt $Exp_incr ]
         then
              tst_resm TFAIL \
-                 "Test #5: NUMA hit and localnode increase in node$Node_num is less than expected"
+                 "Test #5: NUMA hit and localnode increase in node$node is less than expected"
             return 1
         fi
         COUNTER=$[$COUNTER+1]
@@ -560,19 +494,18 @@ test06()
     declare -a parray   # array contains previous value of all nodes
     Curr_value=0        # Current value extracted from numastat o/p
     Exp_incr=0          # 1 MB/ (PAGESIZE*num_of_nodes)
-    Node_num=0
     col=0
     MB=$[1024*1024]
 
     # Increase in numastat o/p is interms of pages
     Exp_incr=$[$MB/$page_size]
     # Pages will be allocated using round robin on nodes.
-    Exp_incr=$[$Exp_incr/$max_node]
+    Exp_incr=$[$Exp_incr/$total_nodes]
 
     # Check whether the pages are equally distributed among available nodes
     numastat > $LTPTMP/numalog
     COUNTER=1
-    while [  $COUNTER -le $max_node ]; do
+    for node in `echo $nodes_list`; do
         col=$[$COUNTER+1]              #Node number in numastat o/p
         extract_numastat numa_hit $numa_hit $col || return 1
         Prev_value=$RC
@@ -585,16 +518,15 @@ test06()
 
     numastat > $LTPTMP/numalog
     COUNTER=1
-    while [  $COUNTER -le $max_node ]; do
+    for node in `echo $nodes_list`; do
         col=$[$COUNTER+1]              #Node number in numastat o/p
-        Node_num=$[$COUNTER-1]         #Node numbers start from 0
         extract_numastat numa_hit $numa_hit $col || return 1
         Curr_value=$RC
         comparelog ${parray[$COUNTER]} $Curr_value
         if [ $RC -lt $Exp_incr ]
         then
              tst_resm TFAIL \
-                 "Test #6: NUMA numa_hit for shm file numa_shm in node$Node_num is less than expected"
+                 "Test #6: NUMA numa_hit for shm file numa_shm in node$node is less than expected"
             return 1
         fi
         COUNTER=$[$COUNTER+1]
@@ -626,19 +558,18 @@ test07()
     declare -a parray   # array contains previous value of all nodes
     Curr_value=0        # Current value extracted from numastat o/p
     Exp_incr=0          # 1 MB/ (PAGESIZE*num_of_nodes)
-    Node_num=0
     col=0
     msize=1000
     KB=1024
     # Increase in numastat o/p is interms of pages
      Exp_incr=$[($KB * $msize)/$page_size]
     # Pages will be allocated using round robin on nodes.
-    Exp_incr=$[$Exp_incr/$max_node]
+    Exp_incr=$[$Exp_incr/$total_nodes]
 
     # Check whether the pages are equally distributed among available nodes
     numastat > $LTPTMP/numalog
     COUNTER=1
-    while [  $COUNTER -lt $max_node ]; do
+    for node in `echo $nodes_list`; do
         col=$[$COUNTER+1]              #Node number in numastat o/p
         extract_numastat interleave_hit $interleave_hit $col || return 1
         Prev_value=$RC
@@ -646,16 +577,14 @@ test07()
         COUNTER=$[$COUNTER+1]
     done
 
-
     numademo -c msize > $LTPTMP/demolog
     sleep 2s        #In RHEL collection of statistics takes more time.
 
     numastat > $LTPTMP/numalog
     COUNTER=1
     x=0
-    while [  $COUNTER -le $max_node ]; do
+    for node in `echo $nodes_list`; do
         col=$[$COUNTER+1]              #Node number in numastat o/p
-        Node_num=$[$COUNTER-1]         #Node numbers start from 0
         extract_numastat interleave_hit $interleave_hit $col || return 1
         Curr_value=$RC
          comparelog ${parray[$COUNTER]} $Curr_value
@@ -693,19 +622,18 @@ test08()
     declare -a parray   # array contains previous value of all nodes
     Curr_value=0        # Current value extracted from numastat o/p
     Exp_incr=0          # 1 MB/ (PAGESIZE*num_of_nodes)
-    Node_num=0
     col=0
     MB=$[1024*1024]
 
     # Increase in numastat o/p is interms of pages
     Exp_incr=$[$MB/$page_size]
     # Pages will be allocated using round robin on nodes.
-    Exp_incr=$[$Exp_incr/$max_node]
+    Exp_incr=$[$Exp_incr/$total_nodes]
 
     # Check whether the pages are equally distributed among available nodes
     numastat > $LTPTMP/numalog
     COUNTER=1
-    while [  $COUNTER -le $max_node ]; do
+    for node in `echo $nodes_list`; do
         col=$[$COUNTER+1]              #Node number in numastat o/p
         extract_numastat interleave_hit $interleave_hit $col || return 1
         Prev_value=$RC
@@ -717,16 +645,15 @@ test08()
 
     numastat > $LTPTMP/numalog
     COUNTER=1
-    while [  $COUNTER -le $max_node ]; do
+    for node in `echo #nodes_list`; do
         col=$[$COUNTER+1]              #Node number in numastat o/p
-        Node_num=$[$COUNTER-1]         #Node numbers start from 0
         extract_numastat interleave_hit $interleave_hit $col || return 1
         Curr_value=$RC
         comparelog ${parray[$COUNTER]} $Curr_value
         if [ $RC -lt $Exp_incr ]
         then
              tst_resm TFAIL \
-                 "Test #8: NUMA interleave hit in node$Node_num is less than expected"
+                 "Test #8: NUMA interleave hit in node$node is less than expected"
             return 1
         fi
         COUNTER=$[$COUNTER+1]
@@ -763,13 +690,12 @@ test09()
     Prev_value=0        # extracted from the numastat o/p
     Curr_value=0        # Current value extracted from numastat o/p
     Exp_incr=0          # 1 MB/ PAGESIZE
-    Node_num=0
     col=0
     MB=$[1024*1024]
     # Increase in numastat o/p is interms of pages
     Exp_incr=$[$MB/$page_size]
 
-        numactl --hardware > $LTPTMP/avail_nodes
+    numactl --hardware > $LTPTMP/avail_nodes
     RC=$(awk '{ if ( NR == 1 ) {print $1;} }' $LTPTMP/avail_nodes)
     if [ $RC = "available:" ]
     then
@@ -797,34 +723,38 @@ test010()
 {
     TCID=numa10
     TST_COUNT=10
+    RC=0
+    Prev_value=0
+    Curr_value=0
 
-    while [  $COUNTER -le $max_node ]; do
+    COUNTER=1
+    for node in `echo $nodes_list`; do
 
-       if [ $max_node -eq 1 ]
-       then
+        if [ $total_nodes -eq 1 ]
+        then
             tst_brkm TBROK NULL "Preferred policy cant be applied for a single node machine"
             return 1
         fi
 
-            col=2                       #column represents node0 in numastat o/p
-        numnodes=$(ls /sys/devices/system/node | grep -Ec "node[0-9]*")
-        Preferred_node=$[$[$numnodes/2]-1]
-        col=$[$Preferred_node+2]
+        if [ $COUNTER -eq $total_nodes ]; then
+            Preferred_node=`echo $nodes_list | cut -d ' ' -f 1`
+            col=2
+        else
+            Preferred_node=`echo $nodes_list | cut -d ' ' -f $[$COUNTER+1]`
+            col=$[$COUNTER+2]
+        fi
+
         numastat > $LTPTMP/numalog
         extract_numastat other_node $other_node $col || return 1
         Prev_value=$RC
-        #echo $Preferred_node
-        #numactl --cpunodebind=$Preferred_node --localalloc support_numa $ALLOC_1MB
-        #numactl --preferred=$Preferred_node support_numa $ALLOC_1MB
-        numactl --preferred=$Preferred_node support_numa $PAUSE &
+        numactl --preferred=$node support_numa $PAUSE &
         pid=$!
-        migratepages $pid $Preferred_node $[$Preferred_node + 1]
+        migratepages $pid $node $Preferred_node
         numastat > $LTPTMP/numalog
         extract_numastat other_node $other_node $col || return 1
         Curr_value=$RC
         kill -INT $pid
-        if [ $RC -lt $Prev_value ]
-         then
+        if [ $RC -lt $Prev_value ]; then
              tst_resm TFAIL \
                  "Test #10: NUMA migratepages is not working fine"
             return 1
@@ -855,6 +785,19 @@ test010()
         exit $RC
     fi
 
+    total_nodes=0       # total no. of numa nodes
+    # all availiable nodes id list
+    nodes_list=`numactl --show | grep nodebind | cut -d ':' -f 2`
+    for node in `echo $nodes_list`; do
+        total_nodes=$[$total_nodes+1]
+    done
+    tst_resm TINFO "The system contains $total_nodes nodes: $nodes_list"
+    if [ $total_nodes -le 1 ]; then
+        tst_resm TCONF "your machine does not support numa policy or
+                        your machine is not a NUMA machine"
+        exit 0
+    fi
+
     # call each testcases sequentially
     COUNT=1
     while [  $COUNT -le $no_of_test ]; do
-- 
1.7.11.7


------------------------------------------------------------------------------
Master Java SE, Java EE, Eclipse, Spring, Hibernate, JavaScript, jQuery
and much more. Keep your Java skills current with LearnJavaNow -
200+ hours of step-by-step video tutorials by Java experts.
SALE $49.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122612 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
