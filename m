Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1MeABK-0004ma-AX
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2009 16:08:06 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MeABJ-0004DW-Bp
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2009 16:08:06 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7KG7cio010228
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Aug 2009 12:07:38 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7KG7xIm225614
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Aug 2009 12:07:59 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7KG7wiH027254
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Aug 2009 12:07:59 -0400
From: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Date: Thu, 20 Aug 2009 21:37:50 +0530
Message-Id: <20090820160750.30926.34693.sendpatchset@localhost.localdomain>
In-Reply-To: <20090820160655.30926.34854.sendpatchset@localhost.localdomain>
References: <20090820160655.30926.34854.sendpatchset@localhost.localdomain>
Subject: [LTP] Patch for PM Master script to integrate new testcases
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
To: vaidy <svaidy@linux.vnet.ibm.com>, ltp-list@lists.sourceforge.net, gautham <ego@in.ibm.com>, arun@linux.vnet.ibm.com

Modified Master script of power management testcases to include new test case
and to increase test coverage on system which is not multi core but hyper threaded.

Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

diff -uprN ltp-full-20090731_orig/testcases/kernel/power_management/runpwtests.sh ltp-full-20090731/testcases/kernel/power_management/runpwtests.sh
--- ltp-full-20090731_orig/testcases/kernel/power_management/runpwtests.sh	2009-08-20 19:59:11.000000000 +0530
+++ ltp-full-20090731/testcases/kernel/power_management/runpwtests.sh	2009-08-20 20:41:02.000000000 +0530
@@ -40,6 +40,7 @@ export contacts="mpnayak@linux.vnet.ibm.
 export analysis="/proctstat"
 
 YES=0
+NO=1
 #List of reusable functions defined in pm_include.sh
 . ./pm_include.sh
 
@@ -61,34 +62,50 @@ if [ $RC -eq 1 ] ; then
 fi
 
 is_hyper_threaded; hyper_threaded=$?
+is_multi_socket; multi_socket=$?
+is_multi_core; multi_core=$?
+is_dual_core; dual_core=$?
 
 #Checking sched_mc sysfs interface
 #check_config.sh config_sched_mc || RC=$?
 TST_COUNT=1
-if [ -f /sys/devices/system/cpu/sched_mc_power_savings ] ; then
-	if test_sched_mc.sh ; then
-		tst_resm TPASS "SCHED_MC sysfs tests"
+if [ $multi_socket -eq $YES -a $dual_core -eq $YES ] ; then
+	if [ -f /sys/devices/system/cpu/sched_mc_power_savings ] ; then
+		if test_sched_mc.sh ; then
+			tst_resm TPASS "SCHED_MC sysfs tests"
+		else
+			RC=$?
+			tst_resm TFAIL "SCHED_MC sysfs tests"
+		fi
 	else
-		RC=$?
-		tst_resm TFAIL "SCHED_MC sysfs tests"
+    	tst_resm TCONF "Required kernel configuration for SCHED_MC NOT set"
 	fi
 else
-    tst_resm TCONF "Required kernel configuration for SCHED_MC NOT set"
+	if [ -f /sys/devices/system/cpu/sched_mc_power_savings ] ; then
+		tst_resm TFAIL "sched_mc_power_savings interface in system which is not a multi socket &(/) multi core"
+	else
+		tst_resm TCONF "Not a suitable architecture for SCHED_MC test"
+	fi
 fi
 
 # Test sched_smt_power_savings interface on HT machines
 : $(( TST_COUNT += 1 ))
-if [ -f /sys/devices/system/cpu/sched_smt_power_savings ] ; then
-    if test_sched_smt.sh; then
-		tst_resm TPASS "SCHED_SMT sysfs test"
+if [ $hyper_threaded -eq $YES ]; then
+	if [ -f /sys/devices/system/cpu/sched_smt_power_savings ] ; then
+    	if test_sched_smt.sh; then
+			tst_resm TPASS "SCHED_SMT sysfs test"
+		else
+			RC=$?
+        	tst_resm TFAIL "SCHED_SMT sysfs test"
+    	fi
 	else
 		RC=$?
-        tst_resm TFAIL "SCHED_SMT sysfs test"
-    fi
+		tst_resm TFAIL "Required kernel configuration for SCHED_SMT NOT set"
+	fi
 else
-    if [ $hyper_threaded -eq $YES ]; then
+	if [ -f /sys/devices/system/cpu/sched_smt_power_savings ] ; then
 		RC=$?
-        tst_resm TFAIL "Required kernel configuration for SCHED_SMT NOT set"
+        tst_resm TFAIL "sched_smt_power_saving interface in system not hyper-threaded"
     else
         tst_resm TCONF "Required Hyper Threading support for SCHED_SMT test"
     fi
@@ -152,13 +169,13 @@ if [ $? -ne 0 ] ; then
 	tst_resm TCONF "Python is not installed, CPU Consoldation\
 test cannot run"
 else
-	get_max_sched_mc; max_sched_mc=$?
+	get_sched_values sched_mc; max_sched_mc=$?
 	for sched_mc in `seq 0 $max_sched_mc`; do
 		: $(( TST_COUNT+=1))
 		sched_domain.py -c $sched_mc; RC=$?
 		analyze_sched_domain_result $sched_mc $RC 
 		if [ $hyper_threaded -eq $YES ]; then
-			get_max_sched_smt ; max_sched_smt=$?
+			get_sched_values sched_smt; max_sched_smt=$?
 			for sched_smt in `seq 0 $max_sched_smt`; do
 				# Testcase to validate sched_domain tree
 				: $(( TST_COUNT+=1))
@@ -168,32 +185,54 @@ else
 		fi
 	done
 fi
+
+: $(( TST_COUNT+=1))
+if [ -f /proc/sys/kernel/timer_migration ]; then
+	if test_timer_migration.sh; then
+        tst_resm TPASS "Timer Migration interface test"
+    else
+        RC=$?
+        tst_resm TFAIL "Timer migration interface test"
+    fi
+else
+	check_kv_arch "timer_migration"; supp=$? 
+	if [ $supp -eq $YES ]; then
+		RC=$?
+		tst_resm TFAIL "Timer migration interface missing"
+	else
+		tst_resm TCONF "Kernel version does not support Timer migration"
+	fi
+fi
+
+: $(( TST_COUNT+=1))	
+if check_cpufreq_sysfs_files.sh; then
+        tst_resm TPASS "CPUFREQ sysfs tests"
+    else
+        RC=$?
+        tst_resm TFAIL "CPUFREQ sysfs tests "
+    fi
+
 if [ $# -gt 0 -a "$1" = "-exclusive" ]; then 
 	# Test CPU consolidation 
-	which python > /dev/null
-	if [ $? -ne 0 ] ; then
-		tst_resm TCONF "Python is not installed, CPU Consoldation\
- test not run"
-	else
-		sched_mc_smt_pass_cnt=0
+	if [ $multi_socket -eq $YES -a $multi_core -eq $YES ]; then
 		work_loads_list="ebizzy kernbench"
 		for sched_mc in `seq 0 $max_sched_mc`; do
 			for work_load in ${work_loads_list}
-            do
+           	do
 				: $(( TST_COUNT += 1 ))
 				sched_mc_pass_cnt=0
 				for repeat_test in `seq 1  10`; do
-					 #Testcase to validate CPU consolidation for sched_mc
+					#Testcase to validate CPU consolidation for sched_mc
 					if cpu_consolidation.py -c $sched_mc -w $work_load ; then
 						: $(( sched_mc_pass_cnt += 1 ))
 					fi
 				done
-				analyze_consolidation_result $sched_mc $work_load $sched_mc_pass_cnt	
+				analyze_package_consolidation_result $sched_mc $work_load $sched_mc_pass_cnt	
 			done	
 			if [ $hyper_threaded -eq $YES ]; then
 				for sched_smt in `seq 0 $max_sched_smt`; do
 					for work_load in ${work_loads_list}; do
-                    	: $(( TST_COUNT += 1 ))
+                   		: $(( TST_COUNT += 1 ))
 						sched_mc_smt_pass_cnt=0
 						for repeat_test in `seq 1  10`; do
 							# Testcase to validate CPU consolidation for
@@ -201,24 +240,26 @@ if [ $# -gt 0 -a "$1" = "-exclusive" ]; 
 							if cpu_consolidation.py -c $sched_mc -t $sched_smt -w $work_load; then
 								: $(( sched_mc_smt_pass_cnt += 1 ))
 							fi
+							echo "sched_mc_smt_pass_cnt = $sched_mc_smt_pass_cnt"
 						done
-						analyze_consolidation_result $sched_mc $work_load $sched_mc_smt_pass_cnt $sched_smt
-
-						#Testcase to validate consolidation at core level
-						sched_mc_smt_pass_cnt=0
-						stress="thread"
-						: $(( TST_COUNT += 1 ))
-						for repeat_test in `seq 1  10`; do
-							if cpu_consolidation.py -c $sched_mc -t $sched_smt -w $work_load -s $stress; then
-								: $(( sched_mc_smt_pass_cnt += 1 ))
-							fi
-						done
-						analyze_consolidation_result $sched_mc $work_load $sched_mc_smt_pass_cnt $sched_smt $stress
+						analyze_package_consolidation_result $sched_mc $work_load $sched_mc_smt_pass_cnt $sched_smt
 					done
 				done
 			fi
 		done
 	fi
+	if [ $hyper_threaded -eq $YES ]; then
+		#Testcase to validate consolidation at core level
+		sched_smt_pass_cnt=0
+		: $(( TST_COUNT += 1 ))
+		stress="thread"
+		for repeat_test in `seq 1  10`; do
+			if cpu_consolidation.py -c $sched_mc -t $sched_smt -w $work_load -s $stress; then
+				: $(( sched_smt_pass_cnt += 1 ))
+			fi
+		done
+		analyze_core_consolidation_result $sched_smt $work_load $sched_smt_pass_cnt
+	fi
 fi
 
 exit $RC

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
