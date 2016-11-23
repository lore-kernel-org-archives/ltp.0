From: Li Wang <liwang@redhat.com>
Date: Wed, 23 Nov 2016 11:36:42 +0800
Subject: [LTP] [PATCH 1/3] ltp/numa: waiting for numastat refresh
Message-ID: <1479872202-29920-1-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

These cases occasionally failed on RHEL platform:

numa02      2  TFAIL  :  ltpapicmd.c:200: Test #2: NUMA hit and othernode increase in node0 is less than expected
numa03      3  TFAIL  :  ltpapicmd.c:200: Test #3: NUMA interleave hit in node0 is less than expected
numa08      8  TFAIL  :  ltpapicmd.c:200: Test #8: NUMA interleave hit in node0 is less than expected

From git log (commit e439df0ea74231), it says "In RHEL collection of
istics take more time", and add sleep 2s in the case. I looked
into the detail and found that's reasonable, numastat growing slowly on
RHEL system, therefore tests failed with numastate update uncompleted.
(my sight is limited, if you have a different opinion, please comment)

Despite all that, sleeping 2 sec still working bad during my test.

In this patch, I replace 'sleep 2s' by detecting the numastat every 10ms,
if the threshold values keep changing in 2 sec, we consider that numastat
is on refreshing road, do loop again util 5 times.

The improved case running better than previous, but not perfect(100% PASS) everytime:

numa01 1 TINFO : The system contains 2 nodes:  0 1
numa01 1 TINFO : INIT: Numa tests will start now !!
numa01 1 TPASS : NUMA local node and memory affinity -TEST01 PASSED !!
numa01 2 TPASS : NUMA preferred node policy -TEST02 PASSED !!
numa01 3 TPASS : NUMA interleave policy -TEST03 PASSED !!
numa01 4 TPASS : NUMA phycpubind policy -TEST04 PASSED !!
numa01 5 TPASS : NUMA local node allocation -TEST05 PASSED !!
numa01 6 TPASS : NUMA interleave policy on shared memory -TEST06 PASSED !!
numa01 7 TPASS : NUMADEMO policies  -TEST07 PASSED !!
numa01 8 TPASS : NUMA MEMHOG policy -TEST08 PASSED !!
numa01 9 TPASS : NUMA policy on lib NUMA_NODE_SIZE API -TEST09 PASSED !!
numa01 10 TPASS : NUMA MIGRATEPAGES policy -TEST10 PASSED !!
numa01 11 TINFO : CLEAN: removing /tmp/ltp-ZJmMGHXeRw/tst_numa.1820

Test Environment: 15G RAM, 2 numa nodes, RHEL7.3GA, x86_64.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/numa/numa01.sh | 53 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 48 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/numa/numa01.sh b/testcases/kernel/numa/numa01.sh
index 9c5f49a..60dbae5 100755
--- a/testcases/kernel/numa/numa01.sh
+++ b/testcases/kernel/numa/numa01.sh
@@ -104,7 +104,35 @@ extract_numastat()
     return 0
 }
 
+# Function:     wait_for_update
+#
+# Input:        - $1 - node number.
+#               - $2 - numastat content.
+#
+# Description:  - waiting for numastat update
+#
+wait_for_update()
+{
+    NUMASTAT_PATH="/sys/devices/system/node/node$1/numastat"
+    local loop=0
 
+    while [ $loop -lt 5 ]; do
+        sum_value=0
+
+        for i in $(seq 200); do
+            det_value=$(grep $2 ${NUMASTAT_PATH} | cut -d ' ' -f 2)
+            sum_value=$((sum_value + det_value))
+
+            sync && tst_sleep 10ms
+        done
+
+        if [ $((sum_value/200)) -eq $det_value ]; then
+            return
+        fi
+
+        loop=$((loop+1))
+    done
+}
 
 # Function:     comparelog
 #
@@ -309,7 +337,10 @@ test02()
         extract_numastat other_node $other_node $col || return 1
         Prev_value=$RC
         numactl --cpunodebind=$node --preferred=$Preferred_node support_numa $ALLOC_1MB
-	sleep 2s	#In RHEL collection of statistics takes more time.
+
+        # In RHEL collection of statistics takes more time
+        wait_for_update $Preferred_node other_node
+
         numastat > $LTPTMP/numalog
         extract_numastat other_node $other_node $col || return 1
         Curr_value=$RC
@@ -363,7 +394,10 @@ test03()
     done
 
     numactl --interleave=all support_numa $ALLOC_1MB
-    sleep 2s        #In RHEL collection of statistics takes more time.
+
+    for node in `echo $nodes_list`; do
+        wait_for_update $node interleave_hit
+    done
 
     numastat > $LTPTMP/numalog
     COUNTER=1
@@ -514,7 +548,10 @@ test06()
     done
 
     numactl --length=1M --file /dev/shm/numa_shm --interleave=all --touch
-    sleep 2s        #In RHEL collection of statistics takes more time.
+
+    for node in `echo $nodes_list`; do
+        wait_for_update $node numa_hit
+    done
 
     numastat > $LTPTMP/numalog
     COUNTER=1
@@ -578,7 +615,10 @@ test07()
     done
 
     numademo -c ${msize}k > $LTPTMP/demolog
-    sleep 2s        #In RHEL collection of statistics takes more time.
+
+    for node in `echo $nodes_list`; do
+        wait_for_update $node interleave_hit
+    done
 
     numastat > $LTPTMP/numalog
     COUNTER=1
@@ -641,7 +681,10 @@ test08()
         COUNTER=$[$COUNTER+1]
     done
     numactl --interleave=all memhog 1MB
-    sleep 2s        #In RHEL collection of statistics takes more time.
+
+    for node in `echo $nodes_list`; do
+        wait_for_update $node interleave_hit
+    done
 
     numastat > $LTPTMP/numalog
     COUNTER=1
-- 
1.8.3.1

