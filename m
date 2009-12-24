Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1NNsEN-0000yz-8R
	for ltp-list@lists.sourceforge.net; Thu, 24 Dec 2009 18:16:11 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NNsEG-0006gO-KF
	for ltp-list@lists.sourceforge.net; Thu, 24 Dec 2009 18:16:11 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nBOI88qI002036
	for <ltp-list@lists.sourceforge.net>; Thu, 24 Dec 2009 11:08:08 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	nBOIFek4084612
	for <ltp-list@lists.sourceforge.net>; Thu, 24 Dec 2009 11:15:45 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nBOIFaWA010664
	for <ltp-list@lists.sourceforge.net>; Thu, 24 Dec 2009 11:15:37 -0700
From: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Date: Thu, 24 Dec 2009 23:45:32 +0530
Message-Id: <20091224181532.12571.74576.sendpatchset@localhost.localdomain>
Subject: [LTP] [Patch 1/4]Master script modified to enable testcases to run
	on Power
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

Patch to enable Power management testcases in LTP to run on Power platform

Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

diff -uprN ltp-intermediate-20091209.orig/testcases/kernel/power_management/runpwtests.sh ltp-intermediate-20091209.fixes/testcases/kernel/power_management/runpwtests.sh
--- ltp-intermediate-20091209.orig/testcases/kernel/power_management/runpwtests.sh	2009-12-09 13:18:25.000000000 +0530
+++ ltp-intermediate-20091209.fixes/testcases/kernel/power_management/runpwtests.sh	2009-12-24 23:16:39.859044825 +0530
@@ -28,10 +28,21 @@
 # History:      26 Aug 2008 - Created this file
 # 03 Nov 2008 - Added CPUIDLE sysfs testcase
 #
+# Function:     main
+#
+# Description:  - Execute all tests, exit with test status.
+#
+# Exit:         - zero on success
+#               - non-zero on failure.
+#
+
+#List of reusable functions defined in pm_include.sh
+. ./pm_include.sh
+
+RC=0            #Return status
 
 # Exporting Required variables
 export TST_TOTAL=1
-#LTPTMP=${TMP}
 export PATH=${PATH}:.
 export TCID="Power_Management"
 export TST_COUNT=0
@@ -40,48 +51,39 @@ export analysis="/proctstat"
 
 YES=0
 NO=1
-#List of reusable functions defined in pm_include.sh
-. ./pm_include.sh
-
-# Function:     main
-#
-# Description:  - Execute all tests, exit with test status.
-#
-# Exit:         - zero on success
-#               - non-zero on failure.
-#
-RC=0		#Return status
 
 # Checking required kernel version and architecture
 tst_kvercmp 2 6 21; rc=$?
 if [ $rc -ne 1 -a $rc -ne 2 ] ; then
-	tst_resm TCONF "Kernel version not supported; not running testcases"
-	exit 0
+        tst_resm TCONF "Kernel version not supported; not running testcases"
+        exit 0
 else
-	case "$(uname -m)" in
-	i[4-6]86|x86_64)
+        case "$(uname -m)" in
+        i[4-6]86|x86_64)
+                ;;
+        powerpc|ppc|powerpc64|ppc64)
 		;;
-	*)
-		tst_resm TCONF "Arch not supported; not running testcases"
-		exit 0
-		;;
-	esac
+        *)
+                tst_resm TCONF "Arch not supported; not running testcases"
+                exit 0
+                ;;
+        esac
 fi
 
 tst_kvercmp 2 6 29; rc=$?
 if [ $rc -eq 2 ] ; then
-	max_sched_mc=2
-	max_sched_smt=2
+        max_sched_mc=2
+        max_sched_smt=2
 else
-	max_sched_mc=1
-	max_sched_smt=1
+        max_sched_mc=1
+        max_sched_smt=1
 fi
 
 tst_kvercmp 2 6 31; rc=$?
 if [ $rc -eq 1 -o $rc -eq 2 ] ; then
-	timer_migr_support_compatible=1
+        timer_migr_support_compatible=0
 else
-	timer_migr_support_compatible=0
+        timer_migr_support_compatible=1
 fi
 
 is_hyper_threaded; hyper_threaded=$?
@@ -90,7 +92,6 @@ is_multi_core; multi_core=$?
 is_dual_core; dual_core=$?
 
 #Checking sched_mc sysfs interface
-#check_config.sh config_sched_mc || RC=$?
 TST_COUNT=1
 if [ $multi_socket -eq $YES -a $multi_core -eq $YES ] ; then
 	if [ -f /sys/devices/system/cpu/sched_mc_power_savings ] ; then
@@ -103,6 +104,25 @@ if [ $multi_socket -eq $YES -a $multi_co
 	else
     	tst_resm TCONF "Required kernel configuration for SCHED_MC NOT set"
 	fi
+
+	: $(( TST_COUNT+=1))
+	if [ -f /proc/sys/kernel/timer_migration ]; then
+    	if [ $timer_migr_support_compatible -eq $YES ]; then
+        	if test_timer_migration.sh; then
+            	tst_resm TPASS "Timer Migration interface test"
+        	else
+            	RC=$?
+            	tst_resm TFAIL "Timer migration interface test"
+        	fi
+    	fi
+	else
+    	if [ $supp -eq $YES ]; then
+        	RC=$?
+        	tst_resm TFAIL "Timer migration interface missing"
+		else
+        	tst_resm TCONF "Kernel version does not support Timer migration"
+		fi
+	fi
 else
 	if [ -f /sys/devices/system/cpu/sched_mc_power_savings ] ; then
 		tst_resm TFAIL "sched_mc_power_savings interface in system which is not a multi socket &(/) multi core"
@@ -135,7 +155,6 @@ else
 fi
 
 # Checking cpufreq sysfs interface files
-#check_config.sh config_cpu_freq || RC=$?
 : $(( TST_COUNT += 1 ))
 if [ -d /sys/devices/system/cpu/cpu0/cpufreq ] ; then
     if check_cpufreq_sysfs_files.sh; then
@@ -187,12 +206,13 @@ else
 fi
 
 # sched_domain test
-if ! type python > /dev/null ; then
+which python > /dev/null
+if [ $? -ne 0 ] ; then
 	tst_resm TCONF "Python is not installed, CPU Consoldation\
 test cannot run"
 else
 	if [ -f /sys/devices/system/cpu/sched_mc_power_savings ] ; then
-    		echo "max sched mc $max_sched_mc"
+		get_sched_values sched_mc; max_sched_mc=$?
 		for sched_mc in `seq 0 $max_sched_mc`; do
 			: $(( TST_COUNT+=1))
 			sched_domain.py -c $sched_mc; RC=$?
@@ -210,25 +230,6 @@ else
 	fi
 fi
 
-: $(( TST_COUNT+=1))
-if [ -f /proc/sys/kernel/timer_migration ]; then
-	if [ $timer_migr_support_compatible -eq $YES ]; then
-		if test_timer_migration.sh; then
-        	tst_resm TPASS "Timer Migration interface test"
-    	else
-        	RC=$?
-        	tst_resm TFAIL "Timer migration interface test"
-		fi
-	fi
-else
-	if [ $timer_migr_support_compatible -eq $YES ]; then
-		RC=$?
-		tst_resm TFAIL "Timer migration interface missing"
-	else
-		tst_resm TCONF "Kernel version does not support Timer migration"
-	fi
-fi
-
 if [ $# -gt 0 -a "$1" = "-exclusive" ]; then 
 	# Test CPU consolidation 
 	if [ $multi_socket -eq $YES -a $multi_core -eq $YES ]; then
@@ -266,7 +267,7 @@ if [ $# -gt 0 -a "$1" = "-exclusive" ]; 
 
 	fi
 
-	if [ $hyper_threaded -eq $YES -a $multi_socket -eq $YES -a $multi_core -eq $NO ]; then
+	if [ $hyper_threaded -eq $YES ]; then
 			#Testcase to validate consolidation at core level
 			for sched_smt in `seq 0 $max_sched_smt`; do
 				if [ $sched_smt -eq 2 ]; then
@@ -319,7 +320,7 @@ if [ $# -gt 0 -a "$1" = "-exclusive" ]; 
 	fi
 
     # Verify threads consolidation stops when sched_smt is disabled in HT systems
-	if [ $hyper_threaded -eq $YES -a $multi_socket -eq $YES ]; then
+	if [ $hyper_threaded -eq $YES ]; then
 		# Vary only sched_smt from 1 to 0 when workload is running and ensure that
 		# tasks do not consolidate to single core when sched_smt is set to 0
 		: $(( TST_COUNT += 1 ))

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
