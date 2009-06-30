Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1MLen9-0005Dz-NC
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 14:58:39 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLen4-000301-Kz
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 14:58:39 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5UErERF015907
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 10:53:14 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5UEwTSI191632
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 10:58:29 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5UEu3MH026641
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 10:56:03 -0400
From: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Date: Tue, 30 Jun 2009 20:28:24 +0530
Message-Id: <20090630145824.11163.54300.sendpatchset@localhost.localdomain>
In-Reply-To: <20090630145706.11163.54040.sendpatchset@localhost.localdomain>
References: <20090630145706.11163.54040.sendpatchset@localhost.localdomain>
Subject: [LTP] [Patch 9/10]Master script modified to cover additional test
	scenarios
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
To: ltp-list@lists.sourceforge.net

[Patch 9/10]Master script modified to cover additional test scenarios

Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

diff -uprN ltp_orig/testcases/kernel/power_management/runpwtests.sh ltp_patched/testcases/kernel/power_management/runpwtests.sh
--- ltp_orig/testcases/kernel/power_management/runpwtests.sh	2009-06-30 15:04:19.000000000 +0530
+++ ltp_patched/testcases/kernel/power_management/runpwtests.sh	2009-06-30 16:15:18.000000000 +0530
@@ -30,15 +30,18 @@
 #
 
 # Exporting Required variables
-
+echo Are we really executing this ?
 export TST_TOTAL=1
-LTPTMP=${TMP}
+#LTPTMP=${TMP}
 export PATH=${PATH}:.
-export TCID="Power Management"
+export TCID="Power_Management"
 export TST_COUNT=0
+export contacts="mpnayak@linux.vnet.ibm.com"
+export analysis="/proctstat"
 
+YES=0
 #List of reusable functions defined in pm_include.sh
-. pm_include.sh
+. ./pm_include.sh
 
 # Function:     main
 #
@@ -50,158 +53,172 @@ export TST_COUNT=0
 RC=0		#Return status
 
 # Checking required kernel version and architecture
-check_kv_arch; RC=$?
+check_kv_arch
+RC=$?
 if [ $RC -eq 1 ] ; then
-	tst_resm TCONF "Kernel version or Architecture not supported:\
-Not running testcases"
+	tst_resm TCONF "Kernel version or Architecture not supported: Not running testcases"
 	exit 0
 fi
 
-# Checking sched_mc sysfs interface
+is_hyper_threaded; hyper_threaded=$?
+
+#Checking sched_mc sysfs interface
 #check_config.sh config_sched_mc || RC=$?
+TST_COUNT=1
 if [ -f /sys/devices/system/cpu/sched_mc_power_savings ] ; then
 	if test_sched_mc.sh ; then
-		tst_resm TPASS "SCHED_MC sysfs tests passed"
+		tst_resm TPASS "SCHED_MC sysfs tests"
 	else
 		RC=$?
-		tst_resm TFAIL "SCHED_MC sysfs tests failed"
+		tst_resm TFAIL "SCHED_MC sysfs tests"
 	fi
-	# Test CPU consolidation for corresponding sched_mc
-	which python > /dev/null
-	if [ $? -ne 0 ] ; then
-		tst_resm TCONF "Python is not installed, CPU Consoldation\
-		 test not run"
-	else
-		# Test CPU consolidation on hyper-threaded system
-		hyper_threaded=$(is_hyper_threaded)
-		if [ $hyper_threaded -eq 1 ]; then
-			for sched_mc in `seq 0 2`; do
-				for sched_smt in `seq 0 1`; do
-					if [ $sched_smt -eq 0 -a $sched_mc -eq 0 ]; then 
-						continue
-					fi
-					if cpu_consolidation.py -c $sched_mc -t $sched_smt ; then
-						tst_resm TPASS "cpu consolidation sched_mc=$sched_mc,\
- sched_smt=$sched_smt"
-					else
-						RC=$?
-						tst_resm TFAIL "cpu consolidation \
- sched_mc=$sched_mc, sched_smt=$sched_smt"
-					fi
-				done
-			done
-		else
-			# Test CPU consolidation for sched_mc=1 & 2
-			for sched_mc in `seq 1 2`; do
-				if cpu_consolidation.py -c $sched_mc ; then
-					tst_resm TPASS "cpu consolidation test for \
-sched_mc_power set to $sched_mc"
-				else
-					RC=$?
-					tst_resm TFAIL "cpu consolidation test\
- sched_mc_power set to $sched_mc"
-				fi
-			done
-		fi
+else
+    tst_resm TCONF "Required kernel configuration for SCHED_MC NOT set"
+fi
 
-		# Testcase to validate sched_domain tree
-		if [ $hyper_threaded -eq 1 ]; then
-			for sched_mc in `seq 0 2`; do
-                for sched_smt in `seq 0 1`; do
-					if [ $sched_smt -eq 0 -a $sched_mc -eq 0 ]; then
-                        continue
-                    fi
-
-					if sched_domain.py -c $sched_mc -t $sched_smt; then
-						tst_resm TPASS "sched domain test sched_mc=$sched_mc,\
-sched_smt=$sched_smt "
-					else
-						RC=$?
-						tst_resm TFAIL "sched domain test sched_mc=$sched_mc,\
-sched_smt=$sched_smt "
-					fi
-				done
-			done
-		else
-			# Validate CPU level sched domain topology validation
-			for sched_mc in `seq 1 2`; do
-				if sched_domain.py -c $sched_mc ; then
-					tst_resm TPASS "sched domain test for sched_mc=$sched_mc "
-				else
-					RC=$?
-					tst_resm TFAIL "sched domain test for sched_mc=$sched_mc "
-				fi
-			done
-			
-		fi
-	fi
+# Test sched_smt_power_savings interface on HT machines
+((TST_COUNT= $TST_COUNT + 1))
+if [ -f /sys/devices/system/cpu/sched_smt_power_savings ] ; then
+    if test_sched_smt.sh; then
+		tst_resm TPASS "SCHED_SMT sysfs test"
+	else
+		RC=$?
+        tst_resm TFAIL "SCHED_SMT sysfs test"
+    fi
 else
-	tst_resm TCONF "Required kernel configuration for SCHED_MC NOT set"
+    if [ $hyper_threaded -eq $YES ]; then
+		RC=$?
+        tst_resm TFAIL "Required kernel configuration for SCHED_SMT NOT set"
+    else
+        tst_resm TCONF "Required Hyper Threading support for SCHED_SMT test"
+    fi
 fi
+
 # Checking cpufreq sysfs interface files
 #check_config.sh config_cpu_freq || RC=$?
+((TST_COUNT= $TST_COUNT + 1))
 if [ -d /sys/devices/system/cpu/cpu0/cpufreq ] ; then
-	if check_cpufreq_sysfs_files.sh ; then
-		tst_resm TPASS "CPUFREQ sysfs tests "
+    if check_cpufreq_sysfs_files.sh; then
+		tst_resm TPASS "CPUFREQ sysfs tests"
 	else
 		RC=$?
 		tst_resm TFAIL "CPUFREQ sysfs tests "
 	fi
 
-	# Changing governors
-	if change_govr.sh ; then
+    # Changing governors
+	((TST_COUNT= $TST_COUNT + 1))
+	if change_govr.sh; then
 		tst_resm TPASS "Changing governors "
 	else
 		RC=$?
 		tst_resm TFAIL "Changing governors "
 	fi
 
-	# Changing frequencies
-	if change_freq.sh ; then
+    # Changing frequencies
+	((TST_COUNT= $TST_COUNT + 1))
+    if change_freq.sh ; then
 		tst_resm TPASS "Changing frequncies "
 	else
 		RC=$?
-		tst_resm TFAIL "Changing frequncies "
-	fi
+        tst_resm TFAIL "Changing frequncies "
+    fi
 
-	# Loading and Unloading governor related kernel modules
-	if pwkm_load_unload.sh ; then
+    # Loading and Unloading governor related kernel modules
+	((TST_COUNT= $TST_COUNT + 1))
+    if pwkm_load_unload.sh ; then
 		tst_resm TPASS "Loading and Unloading of governor kernel \
-		modules got failed"
+modules"
 	else
 		RC=$?
-		tst_resm TFAIL "Loading and Unloading of governor kernel \
-		modules got failed"
-	fi
+        tst_resm TFAIL "Loading and Unloading of governor kernel \
+        modules got failed"
+    fi
 else
-	tst_resm TCONF "Required kernel configuration for CPU_FREQ NOT set"
+    tst_resm TCONF "Required kernel configuration for CPU_FREQ NOT set"
 fi
 
 # Checking cpuidle sysfs interface files
+(( TST_COUNT= $TST_COUNT +1))
 if check_cpuidle_sysfs_files.sh ; then
-	tst_resm TPASS "CPUIDLE sysfs tests failed"
+	tst_resm TPASS "CPUIDLE sysfs tests passed"
 else
 	RC=$?
-	tst_resm TFAIL "CPUIDLE sysfs tests failed"
+    tst_resm TFAIL "CPUIDLE sysfs tests failed"
 fi
 
-# Test sched_smt_power_savings interface on HT machines
-if [ -f /sys/devices/system/cpu/sched_smt_power_savings ] ; then
-	if test_sched_smt.sh ; then
-		tst_resm TPASS "SCHED_MC sysfs tests failed"
-	else
-		RC=$?
-		tst_resm TFAIL "SCHED_MC sysfs tests failed"
-	fi
+# sched_domain test
+which python > /dev/null
+if [ $? -ne 0 ] ; then
+	tst_resm TCONF "Python is not installed, CPU Consoldation\
+test cannot run"
 else
-	hyper_threaded=$(is_hyper_threaded)
-	if [ $hyper_threaded -eq 1 ]; then
-		tst_resm TFAIL "Required kernel configuration for SCHED_SMT NOT set"
-		RC=1
+	get_max_sched_mc; max_sched_mc=$?
+	for sched_mc in `seq 0 $max_sched_mc`; do
+		(( TST_COUNT= $TST_COUNT +1))
+		sched_domain.py -c $sched_mc; RC=$?
+		analyze_sched_domain_result $sched_mc $RC 
+		if [ $hyper_threaded -eq $YES ]; then
+			get_max_sched_smt ; max_sched_smt=$?
+			for sched_smt in `seq 0 $max_sched_smt`; do
+				# Testcase to validate sched_domain tree
+				(( TST_COUNT= $TST_COUNT +1))
+				sched_domain.py -c $sched_mc -t $sched_smt; RC=$?
+				analyze_sched_domain_result $sched_mc $RC $sched_smt ;
+			done
+		fi
+	done
+fi
+if [ $# -gt 0 -a $1 == "-exclusive" ]; then 
+	# Test CPU consolidation 
+	which python > /dev/null
+	if [ $? -ne 0 ] ; then
+		tst_resm TCONF "Python is not installed, CPU Consoldation\
+ test not run"
 	else
-		tst_resm TCONF "Required Hyper Threading support in the\
-system under test"
+		sched_mc_smt_pass_cnt=0
+		work_loads_list="ebizzy kernbench"
+		for sched_mc in `seq 0 $max_sched_mc`; do
+			for work_load in ${work_loads_list}
+            do
+				((TST_COUNT= $TST_COUNT + 1))
+				sched_mc_pass_cnt=0
+				for repeat_test in `seq 1  10`; do
+					 #Testcase to validate CPU consolidation for sched_mc
+					if cpu_consolidation.py -c $sched_mc -w $work_load ; then
+						((sched_mc_pass_cnt= $sched_mc_pass_cnt +1))
+					fi
+				done
+				analyze_consolidation_result $sched_mc $work_load $sched_mc_pass_cnt	
+			done	
+			if [ $hyper_threaded -eq $YES ]; then
+				for sched_smt in `seq 0 $max_sched_smt`; do
+					for work_load in ${work_loads_list}; do
+                    	((TST_COUNT= $TST_COUNT + 1))
+						sched_mc_smt_pass_cnt=0
+						for repeat_test in `seq 1  10`; do
+							# Testcase to validate CPU consolidation for
+							# for sched_mc & sched_smt with stress=50%
+							if cpu_consolidation.py -c $sched_mc -t $sched_smt -w $work_load; then
+								((sched_mc_smt_pass_cnt= $sched_mc_smt_pass_cnt +1))
+							fi
+						done
+						analyze_consolidation_result $sched_mc $work_load $sched_mc_smt_pass_cnt $sched_smt
+
+						#Testcase to validate consolidation at core level
+						sched_mc_smt_pass_cnt=0
+						stress="thread"
+						((TST_COUNT= $TST_COUNT + 1))
+						for repeat_test in `seq 1  10`; do
+							if cpu_consolidation.py -c $sched_mc -t $sched_smt -w $work_load -s $stress; then
+								((sched_mc_smt_pass_cnt= $sched_mc_smt_pass_cnt +1))
+							fi
+						done
+						analyze_consolidation_result $sched_mc $work_load $sched_mc_smt_pass_cnt $sched_smt $stress
+					done
+				done
+			fi
+		done
 	fi
 fi
 
-exit $RC
\ No newline at end of file
+exit $RC

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
