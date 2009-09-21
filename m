Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1MpdH4-0001Fr-PM
	for ltp-list@lists.sourceforge.net; Mon, 21 Sep 2009 07:25:26 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MpdH1-0003cL-Fs
	for ltp-list@lists.sourceforge.net; Mon, 21 Sep 2009 07:25:26 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e39.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8L7JmSn012219
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Sep 2009 01:19:48 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8L7PFg1153880
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Sep 2009 01:25:15 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8L7PFDf027360
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Sep 2009 01:25:15 -0600
From: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Date: Mon, 21 Sep 2009 12:55:11 +0530
Message-Id: <20090921072511.7307.49358.sendpatchset@localhost.localdomain>
In-Reply-To: <20090921072444.7307.84825.sendpatchset@localhost.localdomain>
References: <20090921072444.7307.84825.sendpatchset@localhost.localdomain>
Subject: [LTP] [Patch 4/6] To include Additional 5 new test cases
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
To: ltp-list@lists.sourceforge.net, arun@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com, ego@in.ibm.com

Additional 5 new testcases to test cpu consolidation resets when sched_smt &(/)
sched_mc is reset to zero.

Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

diff -uprN ltp-full-20090831/testcases/kernel/power_management/runpwtests.sh ltp-full-20090831_patched/testcases/kernel/power_management/runpwtests.sh
--- ltp-full-20090831/testcases/kernel/power_management/runpwtests.sh	2009-08-31 10:45:45.000000000 +0530
+++ ltp-full-20090831_patched/testcases/kernel/power_management/runpwtests.sh	2009-09-21 12:28:07.766970834 +0530
@@ -170,6 +170,7 @@ if [ $? -ne 0 ] ; then
 test cannot run"
 else
 	get_sched_values sched_mc; max_sched_mc=$?
+    echo "max sched mc $max_sched_mc"
 	for sched_mc in `seq 0 $max_sched_mc`; do
 		: $(( TST_COUNT+=1))
 		sched_domain.py -c $sched_mc; RC=$?
@@ -187,15 +188,17 @@ else
 fi
 
 : $(( TST_COUNT+=1))
+check_kv_arch "timer_migration"; supp=$?
 if [ -f /proc/sys/kernel/timer_migration ]; then
-	if test_timer_migration.sh; then
-        tst_resm TPASS "Timer Migration interface test"
-    else
-        RC=$?
-        tst_resm TFAIL "Timer migration interface test"
-    fi
+	if [ $supp -eq $YES ]; then
+		if test_timer_migration.sh; then
+        	tst_resm TPASS "Timer Migration interface test"
+    	else
+        	RC=$?
+        	tst_resm TFAIL "Timer migration interface test"
+		fi
+	fi
 else
-	check_kv_arch "timer_migration"; supp=$? 
 	if [ $supp -eq $YES ]; then
 		RC=$?
 		tst_resm TFAIL "Timer migration interface missing"
@@ -204,52 +207,45 @@ else
 	fi
 fi
 
-: $(( TST_COUNT+=1))	
-if check_cpufreq_sysfs_files.sh; then
-        tst_resm TPASS "CPUFREQ sysfs tests"
-    else
-        RC=$?
-        tst_resm TFAIL "CPUFREQ sysfs tests "
-    fi
-
 if [ $# -gt 0 -a "$1" = "-exclusive" ]; then 
 	# Test CPU consolidation 
 	if [ $multi_socket -eq $YES -a $multi_core -eq $YES ]; then
-		work_loads_list="ebizzy kernbench"
 		for sched_mc in `seq 0 $max_sched_mc`; do
-			for work_load in ${work_loads_list}
-           	do
-				: $(( TST_COUNT += 1 ))
-				sched_mc_pass_cnt=0
-				for repeat_test in `seq 1  10`; do
-					#Testcase to validate CPU consolidation for sched_mc
-					if cpu_consolidation.py -c $sched_mc -w $work_load ; then
-						: $(( sched_mc_pass_cnt += 1 ))
-					fi
-				done
-				analyze_package_consolidation_result $sched_mc $work_load $sched_mc_pass_cnt	
-			done	
+			: $(( TST_COUNT += 1 ))
+			sched_mc_pass_cnt=0
+			if [ $sched_mc -eq 2 ]; then
+				work_load="kernbench"
+			else
+				work_load="ebizzy"
+			fi
+			for repeat_test in `seq 1  10`; do
+				#Testcase to validate CPU consolidation for sched_mc
+				if cpu_consolidation.py -c $sched_mc -w $work_load ; then
+					: $(( sched_mc_pass_cnt += 1 ))
+				fi
+			done
+			analyze_package_consolidation_result $sched_mc $sched_mc_pass_cnt	
+			
 			if [ $hyper_threaded -eq $YES ]; then
 				for sched_smt in `seq 0 $max_sched_smt`; do
-					for work_load in ${work_loads_list}; do
-                   				: $(( TST_COUNT += 1 ))
-						sched_mc_smt_pass_cnt=0
-						for repeat_test in `seq 1  10`; do
-							# Testcase to validate CPU consolidation for
-							# for sched_mc & sched_smt with stress=50%
-							if cpu_consolidation.py -c $sched_mc -t $sched_smt -w $work_load; then
-								: $(( sched_mc_smt_pass_cnt += 1 ))
-							fi
-							echo "sched_mc_smt_pass_cnt = $sched_mc_smt_pass_cnt"
-						done
-						analyze_package_consolidation_result $sched_mc $work_load $sched_mc_smt_pass_cnt $sched_smt
+					: $(( TST_COUNT += 1 ))
+					sched_mc_smt_pass_cnt=0
+					for repeat_test in `seq 1  10`; do
+						# Testcase to validate CPU consolidation for
+						# for sched_mc & sched_smt with stress=50%
+						if cpu_consolidation.py -c $sched_mc -t $sched_smt -w $work_load; then
+							: $(( sched_mc_smt_pass_cnt += 1 ))
+						fi
 					done
+					analyze_package_consolidation_result $sched_mc $sched_mc_smt_pass_cnt $sched_smt
 				done
 			fi
 		done
+
 	fi
-	if [ $hyper_threaded -eq $YES ]; then
+	if [ $hyper_threaded -eq $YES -a $multi_socket -eq $YES ]; then
 		#Testcase to validate consolidation at core level
+		work_load="ebizzy"
 		sched_smt_pass_cnt=0
 		: $(( TST_COUNT += 1 ))
 		stress="thread"
@@ -259,61 +255,104 @@ if [ $# -gt 0 -a "$1" = "-exclusive" ]; 
 			fi
 		done
 		analyze_core_consolidation_result $sched_smt $work_load $sched_smt_pass_cnt
+
+		# Vary only sched_smt from 1 to 0 when workload is running and ensure that
+		# tasks do not consolidate to single core when sched_smt is set to 0
+		: $(( TST_COUNT += 1 ))
+		if cpu_consolidation.py -vt; then
+			tst_resm TPASS "CPU consolidation test by varying sched_smt"
+		else
+			tst_resm TFAIL "CPU consolidation test by varying sched_smt"
+		fi
 	fi
-        # Verify ILB runs in same package as workload
-        if [ $multi_socket -eq $YES -a $multi_core -eq $YES ]; then
-		work_loads_list="ebizzy kernbench"	
+
+	# Verify threads consolidation stops when sched_mc &(/) sched_smt is disabled
+    if [ $multi_socket -eq $YES -a $multi_core -eq $YES ]; then
+		: $(( TST_COUNT += 1 ))
+		# Vary sched_mc from 1 to 0 when workload is running and ensure that
+		# tasks do not consolidate to single package when sched_mc is set to 0
+		if cpu_consolidation.py -v -c 1; then
+            tst_resm TPASS "CPU consolidation test by varying sched_mc 1 to 0"
+        else
+            tst_resm TFAIL "CPU consolidation test by varying sched_mc 1 to 0"
+        fi
+
+		# Vary sched_mc from 2 to 0 when workload is running and ensure that
+        # tasks do not consolidate to single package when sched_mc is set to 0
+		: $(( TST_COUNT += 1 ))
+		if cpu_consolidation.py -v -c 2; then
+			tst_resm TPASS "CPU consolidation test by varying sched_mc 2 to 0"
+		else
+			tst_resm TFAIL "CPU consolidation test by varying sched_mc 2 to 0"
+		fi
+
+		if [ $hyper_threaded -eq $YES ]; then
+			# Vary sched_mc & sched_smt from 1 to 0 & 2 to 0 when workload is running and ensure that
+            # tasks do not consolidate to single package when sched_mc is set to 0
+            : $(( TST_COUNT += 1 ))
+			if cpu_consolidation.py -v -c 1 -t 1; then
+				tst_resm TPASS "CPU consolidation test by varying sched_mc \
+& sched_smt from 1 to 0"
+			else
+				tst_resm TFAIL "CPU consolidation test by varying sched_mc \
+& sched_smt from 1 to 0"
+			fi
+
+			: $(( TST_COUNT += 1 ))
+			if cpu_consolidation.py -v -c 2 -t 2; then
+				tst_resm TPASS "CPU consolidation test by varying sched_mc \
+ & sched_smt from 2 to 0"
+			else
+				tst_resm TFAIL "CPU consolidation test by varying sched_mc \
+ & sched_smt from 2 to 0"
+			fi
+		fi
+	fi
+
+    # Verify threads consolidation stops when is disabled in HT systems
+	if [ $hyper_threaded -eq $YES -a $multi_socket -eq $YES ]; then
+		# Vary only sched_smt from 1 to 0 when workload is running and ensure that
+		# tasks do not consolidate to single core when sched_smt is set to 0
+		: $(( TST_COUNT += 1 ))
+		if cpu_consolidation.py -v -t 1; then
+			tst_resm TPASS "CPU consolidation test by varying sched_smt 1 to 0"
+		else
+			tst_resm TFAIL "CPU consolidation test by varying sched_smt 1 to 0"
+		fi
+	fi
+
+	# Verify ILB runs in same package as workload
+    if [ $multi_socket -eq $YES -a $multi_core -eq $YES ]; then
 		for sched_mc in `seq 0 $max_sched_mc`; do
-			for work_load in ${work_loads_list}
-			do
-				: $(( TST_COUNT += 1 ))
-                                ilb_test.py -c $sched_mc -w $work_load; RC=$?
-				if [ $RC -eq 0 ]; then
-					tst_resm TPASS "ILB & workload in same package for sched_mc=$sched_mc"
+			: $(( TST_COUNT += 1 ))
+            ilb_test.py -c $sched_mc; RC=$?
+			if [ $RC -eq 0 ]; then
+				tst_resm TPASS "ILB & workload in same package for sched_mc=$sched_mc"
+			else
+				if [ $sched_mc -eq 0 ]; then
+					tst_resm TPASS "ILB & workload is not in same package when sched_mc=0"
 				else
-					if [ $sched_mc -eq 0 ]; then
-						tst_resm TPASS "ILB & workload is not in same package when sched_mc=0"
-					else
-						tst_resm TFAIL "ILB did not run in same package"
-					fi
+					tst_resm TFAIL "ILB did not run in same package"
 				fi
-			done
+			fi
 			if [ $hyper_threaded -eq $YES ]; then
 				for sched_smt in `seq 0 $max_sched_smt`; do
-					for work_load in ${work_loads_list}; do
-						: $(( TST_COUNT += 1 ))
-						ilb_test.py -c $sched_mc -t sched_smt -w $work_load; RC=$?
- 						if [ $RC -eq 0 ]; then
-							tst_resm TPASS "ILB & workload in same package for sched_mc=$sched_mc"
+					: $(( TST_COUNT += 1 ))
+					ilb_test.py -c $sched_mc -t sched_smt; RC=$?
+ 					if [ $RC -eq 0 ]; then
+						tst_resm TPASS "ILB & workload in same package for sched_mc=$sched_mc"
+					else
+						if [ $sched_mc -eq 0 -a $sched_smt -eq 0 ]; then
+							tst_resm TPASS "ILB & workload is not in same package when\
+sched_mc & sched_smt is 0"
 						else
-							if [ $sched_mc -eq 0 ]; then
-								tst_resm TPASS "ILB & workload is not in same package when sched_mc=0"
-							else
-								tst_resm TFAIL "ILB did not run in same package"    
-							fi
+							tst_resm TFAIL "ILB did not run in same package"    
 						fi
-					done
+					fi
 				done
 			fi
 		done
 	fi
-	if [ $multi_socket -eq $YES -a $hyper_threaded -eq $YES -a $multi_core -eq $YES ]; then
-		for sched_smt in `seq 0 $max_sched_smt`; do
-			for work_load in ${work_loads_list}; do
-				: $(( TST_COUNT += 1 ))
-				ilb_test.py -t $sched_smt -w $work_load; RC=$?
-				if [ $RC -eq 0 ]; then
-					tst_resm TPASS "ILB & workload not load not in same package for sched_smt=$sched_smt"
-				else
-					if [ $sched_smt -eq 0 ]; then
-						tst_resm TPASS "Its oky if ILB is not in same package when sched_smt=0"
-					else
-						tst_resm TFAIL "ILB did not run in same package"
-					fi
-				fi
-			done
-		done
-	fi
 fi
 
 exit $RC

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
