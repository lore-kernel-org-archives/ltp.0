Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1Mxc3e-0000Fr-8D
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 07:44:34 +0000
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mxc3Y-00024U-5z
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 07:44:34 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9D7gHAB008069
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 01:42:17 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9D7iID5256664
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 01:44:18 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n9D7iHmB004493
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 01:44:18 -0600
From: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Date: Tue, 13 Oct 2009 13:14:14 +0530
Message-Id: <20091013074414.22414.46233.sendpatchset@localhost.localdomain>
In-Reply-To: <20091013074337.22414.20968.sendpatchset@localhost.localdomain>
References: <20091013074337.22414.20968.sendpatchset@localhost.localdomain>
Subject: [LTP] [Patch 5/6] Modified master script to pass appropriate
	arguments
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
To: ltp-list@lists.sourceforge.net, svaidy@linux.vnet.ibm.com, ego@in.ibm.com, arun@linux.vnet.ibm.com

Modified master script to pass appropriate arguments for cpu consolidation
test cases. 

Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

diff -uprN ltp-full-20090930/testcases/kernel/power_management/runpwtests.sh ltp-full-20090930_patched/testcases/kernel/power_management/runpwtests.sh
--- ltp-full-20090930/testcases/kernel/power_management/runpwtests.sh	2009-10-05 02:10:56.000000000 -0400
+++ ltp-full-20090930_patched/testcases/kernel/power_management/runpwtests.sh	2009-10-12 22:43:46.000000000 -0400
@@ -210,7 +210,7 @@ fi
 if [ $# -gt 0 -a "$1" = "-exclusive" ]; then 
 	# Test CPU consolidation 
 	if [ $multi_socket -eq $YES -a $multi_core -eq $YES ]; then
-		for sched_mc in `seq 0 $max_sched_mc`; do
+		for sched_mc in `seq 0  $max_sched_mc`; do
 			: $(( TST_COUNT += 1 ))
 			sched_mc_pass_cnt=0
 			if [ $sched_mc -eq 2 ]; then
@@ -243,111 +243,108 @@ if [ $# -gt 0 -a "$1" = "-exclusive" ]; 
 		done
 
 	fi
-	if [ $hyper_threaded -eq $YES -a $multi_socket -eq $YES ]; then
-		#Testcase to validate consolidation at core level
-		work_load="ebizzy"
-		sched_smt_pass_cnt=0
-		: $(( TST_COUNT += 1 ))
-		stress="thread"
-		for repeat_test in `seq 1  10`; do
-			if cpu_consolidation.py -c $sched_mc -t $sched_smt -w $work_load -s $stress; then
-				: $(( sched_smt_pass_cnt += 1 ))
-			fi
-		done
-		analyze_core_consolidation_result $sched_smt $work_load $sched_smt_pass_cnt
 
-		# Vary only sched_smt from 1 to 0 when workload is running and ensure that
-		# tasks do not consolidate to single core when sched_smt is set to 0
-		: $(( TST_COUNT += 1 ))
-		if cpu_consolidation.py -vt; then
-			tst_resm TPASS "CPU consolidation test by varying sched_smt"
-		else
-			tst_resm TFAIL "CPU consolidation test by varying sched_smt"
-		fi
+	if [ $hyper_threaded -eq $YES -a $multi_socket -eq $YES -a $multi_core -eq $NO ]; then
+			#Testcase to validate consolidation at core level
+			for sched_smt in `seq 0 $max_sched_smt`; do
+				if [ $sched_smt -eq 2 ]; then
+				 	work_load="kernbench"
+				else	
+					work_load="ebizzy"
+				fi
+				sched_smt_pass_cnt=0
+				: $(( TST_COUNT += 1 ))
+				stress="thread"
+				for repeat_test in `seq 1  10`; do
+					if cpu_consolidation.py -t $sched_smt -w $work_load -s $stress; then
+						: $(( sched_smt_pass_cnt += 1 ))
+					fi
+				done
+				analyze_core_consolidation_result $sched_smt $sched_smt_pass_cnt
+			done
 	fi
 
 	# Verify threads consolidation stops when sched_mc &(/) sched_smt is disabled
     if [ $multi_socket -eq $YES -a $multi_core -eq $YES ]; then
-		: $(( TST_COUNT += 1 ))
-		# Vary sched_mc from 1 to 0 when workload is running and ensure that
-		# tasks do not consolidate to single package when sched_mc is set to 0
-		if cpu_consolidation.py -v -c 1; then
-            tst_resm TPASS "CPU consolidation test by varying sched_mc 1 to 0"
-        else
-            tst_resm TFAIL "CPU consolidation test by varying sched_mc 1 to 0"
-        fi
-
-		# Vary sched_mc from 2 to 0 when workload is running and ensure that
-        # tasks do not consolidate to single package when sched_mc is set to 0
-		: $(( TST_COUNT += 1 ))
-		if cpu_consolidation.py -v -c 2; then
-			tst_resm TPASS "CPU consolidation test by varying sched_mc 2 to 0"
-		else
-			tst_resm TFAIL "CPU consolidation test by varying sched_mc 2 to 0"
-		fi
-
-		if [ $hyper_threaded -eq $YES ]; then
-			# Vary sched_mc & sched_smt from 1 to 0 & 2 to 0 when workload is running and ensure that
-            # tasks do not consolidate to single package when sched_mc is set to 0
-            : $(( TST_COUNT += 1 ))
-			if cpu_consolidation.py -v -c 1 -t 1; then
-				tst_resm TPASS "CPU consolidation test by varying sched_mc \
-& sched_smt from 1 to 0"
-			else
-				tst_resm TFAIL "CPU consolidation test by varying sched_mc \
-& sched_smt from 1 to 0"
-			fi
-
+        for sched_mc in `seq 1  $max_sched_mc`; do
 			: $(( TST_COUNT += 1 ))
-			if cpu_consolidation.py -v -c 2 -t 2; then
-				tst_resm TPASS "CPU consolidation test by varying sched_mc \
- & sched_smt from 2 to 0"
-			else
-				tst_resm TFAIL "CPU consolidation test by varying sched_mc \
- & sched_smt from 2 to 0"
+		
+			# Vary sched_mc from 1/2 to 0 when workload is running and ensure that
+			# tasks do not consolidate to single package when sched_mc is set to 0
+			if cpu_consolidation.py -v -c $sched_mc; then
+            	tst_resm TPASS "CPU consolidation test by varying sched_mc $sched_mc to 0"
+        	else
+            	tst_resm TFAIL "CPU consolidation test by varying sched_mc $sched_mc to 0"
+        	fi
+
+			if [ $hyper_threaded -eq $YES ]; then
+				for sched_smt in `seq 1  $max_sched_smt`; do		
+					if [ $sched_smt -eq $sched_mc ]; then
+						# Vary sched_mc & sched_smt from 1 to 0 & 2 to 0 when workload is running and ensure that
+            			# tasks do not consolidate to single package when sched_mc is set to 0
+            			: $(( TST_COUNT += 1 ))
+						if cpu_consolidation.py -v -c $sched_mc -t $sched_smt; then
+							tst_resm TPASS "CPU consolidation test by varying sched_mc \
+& sched_smt from $sched_mc to 0"
+						else
+							tst_resm TFAIL "CPU consolidation test by varying sched_mc \
+& sched_smt from $sched_mc to 0"
+						fi
+					fi
+				done
 			fi
-		fi
+		done
 	fi
 
-    # Verify threads consolidation stops when is disabled in HT systems
+    # Verify threads consolidation stops when sched_smt is disabled in HT systems
 	if [ $hyper_threaded -eq $YES -a $multi_socket -eq $YES ]; then
 		# Vary only sched_smt from 1 to 0 when workload is running and ensure that
 		# tasks do not consolidate to single core when sched_smt is set to 0
 		: $(( TST_COUNT += 1 ))
 		if cpu_consolidation.py -v -t 1; then
-			tst_resm TPASS "CPU consolidation test by varying sched_smt 1 to 0"
+			tst_resm TPASS "CPU consolidation test by varying sched_smt from 1 to 0"
 		else
-			tst_resm TFAIL "CPU consolidation test by varying sched_smt 1 to 0"
+			tst_resm TFAIL "CPU consolidation test by varying sched_smt from 1 to 0"
 		fi
+        
+        # Vary only sched_smt from 2 to 0 when workload is running and ensure that
+        # tasks do not consolidate to single core when sched_smt is set to 0
+        : $(( TST_COUNT += 1 )) 
+        if cpu_consolidation.py -v -t 2; then 
+            tst_resm TPASS "CPU consolidation test by varying sched_smt 2 to 0"
+        else
+            tst_resm TFAIL "CPU consolidation test by varying sched_smt 2 to 0"
+        fi
+
 	fi
 
 	# Verify ILB runs in same package as workload
     if [ $multi_socket -eq $YES -a $multi_core -eq $YES ]; then
-		for sched_mc in `seq 0 $max_sched_mc`; do
+		for sched_mc in `seq 1 $max_sched_mc`; do
 			: $(( TST_COUNT += 1 ))
-            ilb_test.py -c $sched_mc; RC=$?
+            if [ $sched_mc -eq 2 ]; then
+                work_load="kernbench"
+            else
+                work_load="ebizzy"
+            fi
+
+            ilb_test.py -c $sched_mc -w $work_load; RC=$?
 			if [ $RC -eq 0 ]; then
 				tst_resm TPASS "ILB & workload in same package for sched_mc=$sched_mc"
 			else
-				if [ $sched_mc -eq 0 ]; then
-					tst_resm TPASS "ILB & workload is not in same package when sched_mc=0"
-				else
-					tst_resm TFAIL "ILB did not run in same package"
-				fi
+				tst_resm TFAIL "ILB & workload did not run in same package for sched_mc=$sched_mc\
+. Ensure CONFIG_NO_HZ is set"
 			fi
 			if [ $hyper_threaded -eq $YES ]; then
-				for sched_smt in `seq 0 $max_sched_smt`; do
+				for sched_smt in `seq 1 $max_sched_smt`; do
 					: $(( TST_COUNT += 1 ))
-					ilb_test.py -c $sched_mc -t sched_smt; RC=$?
+					ilb_test.py -c $sched_mc -t sched_smt -w $work_load; RC=$?
  					if [ $RC -eq 0 ]; then
-						tst_resm TPASS "ILB & workload in same package for sched_mc=$sched_mc"
+						tst_resm TPASS "ILB & workload in same package for sched_mc=$sched_mc \
+& sched_smt=$sched_smt"
 					else
-						if [ $sched_mc -eq 0 -a $sched_smt -eq 0 ]; then
-							tst_resm TPASS "ILB & workload is not in same package when\
-sched_mc & sched_smt is 0"
-						else
-							tst_resm TFAIL "ILB did not run in same package"    
-						fi
+						tst_resm TFAIL "ILB & workload did not execute in same package for \
+sched_mc=$sched_mc & sched_smt=$sched_smt. Ensure CONFIG_NO_HZ is set"    
 					fi
 				done
 			fi

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
