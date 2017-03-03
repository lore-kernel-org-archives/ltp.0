From: Li Wang <liwang@redhat.com>
Date: Fri,  3 Mar 2017 15:34:50 +0800
Subject: [LTP] [PATCH 2/2] ltp/numa: Kill the support_numa if FAILED
In-Reply-To: <1488526490-22120-1-git-send-email-liwang@redhat.com>
References: <1488526490-22120-1-git-send-email-liwang@redhat.com>
Message-ID: <1488526490-22120-2-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/numa/numa01.sh | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/numa/numa01.sh b/testcases/kernel/numa/numa01.sh
index 69e5357..93d74cc 100755
--- a/testcases/kernel/numa/numa01.sh
+++ b/testcases/kernel/numa/numa01.sh
@@ -56,7 +56,7 @@ extract_numastat_p()
 	local pid=$1
 	local node=$(($2 + 2))
 
-	echo $(numastat -p $pid |grep '^Total' |awk '{print $'$node'}')
+	echo $(numastat -p $pid |awk '/^Total/ {print $'$node'}')
 }
 
 wait_for_support_numa()
@@ -121,6 +121,7 @@ test1()
 		if [ $(echo "$Mem_curr < $MB" | bc) -eq 1 ]; then
 			tst_res TFAIL \
 				"NUMA memory allocated in node$node is less than expected"
+			kill -CONT $pid >/dev/null 2>&1
 			return
 		fi
 
@@ -154,6 +155,7 @@ test2()
 		if [ $(echo "$Mem_curr < $MB" |bc ) -eq 1 ]; then
 			tst_res TFAIL \
 				"NUMA memory allocated in node$Preferred_node is less than expected"
+			kill -CONT $pid >/dev/null 2>&1
 			return
 		fi
 
@@ -189,6 +191,7 @@ test3()
 		if [ $(echo "$Mem_curr < $MB" |bc ) -eq 1 ]; then
 			tst_res TFAIL \
 				"NUMA share memory allocated in node$Preferred_node is less than expected"
+			kill -CONT $pid >/dev/null 2>&1
 			return
 		fi
 
@@ -217,6 +220,7 @@ test4()
 		if [ $(echo "$Mem_curr < $Exp_incr" |bc ) -eq 1 ]; then
 			tst_res TFAIL \
 				"NUMA interleave memory allocated in node$node is less than expected"
+			kill -CONT $pid >/dev/null 2>&1
 			return
 		fi
 	done
@@ -243,6 +247,7 @@ test5()
 		if [ $(echo "$Mem_curr < $Exp_incr" |bc ) -eq 1 ]; then
 			tst_res TFAIL \
 				"NUMA interleave share memory allocated in node$node is less than expected"
+			kill -CONT $pid >/dev/null 2>&1
 			return
 		fi
 	done
@@ -299,6 +304,7 @@ test7()
 		if [ $(echo "$Mem_curr < $MB" |bc ) -eq 1 ]; then
 			tst_res TFAIL \
 				"NUMA localnode memory allocated in node$node is less than expected"
+			kill -CONT $pid >/dev/null 2>&1
 			return
 		fi
 
@@ -324,11 +330,12 @@ test8()
 		if [ $(echo "$Mem_curr < $Exp_incr" |bc ) -eq 1 ]; then
 			tst_res TFAIL \
 				"NUMA interleave memhog in node$node is less than expected"
+			kill -KILL $pid >/dev/null 2>&1
 			return
 		fi
 	done
 
-	kill -9 $pid >/dev/null 2>&1
+	kill -KILL $pid >/dev/null 2>&1
 	tst_res TPASS "NUMA MEMHOG policy"
 }
 
@@ -392,6 +399,7 @@ test10()
 		if [ $(echo "$Mem_curr < $MB" |bc ) -eq 1 ]; then
 			tst_res TFAIL \
 				"NUMA migratepages is not working fine"
+			kill -CONT $pid >/dev/null 2>&1
 			return
 		fi
 
@@ -428,7 +436,7 @@ test11()
 		pid=$!
 		wait_for_support_numa $pid
 
-		Mem_huge=$(echo $(numastat -p $pid |awk '/Huge/ {print $'$((node+2))'}'))
+		Mem_huge=$(echo $(numastat -p $pid |awk '/^Huge/ {print $'$((node+2))'}'))
 		Mem_huge=$((${Mem_huge%.*} * 1024))
 
 		if [ "$Mem_huge" -lt "$HPAGE_SIZE" ]; then
-- 
1.8.3.1

