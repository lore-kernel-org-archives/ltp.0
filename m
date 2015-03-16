Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1YXR1w-0005i5-1g
	for ltp-list@lists.sourceforge.net; Mon, 16 Mar 2015 09:09:48 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YXR1q-0001ZW-I1
	for ltp-list@lists.sourceforge.net; Mon, 16 Mar 2015 09:09:48 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t2G98d10000911
	for <ltp-list@lists.sourceforge.net>; Mon, 16 Mar 2015 17:08:39 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Mon, 16 Mar 2015 17:05:04 +0800
Message-ID: <1426496710-11712-3-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1426496710-11712-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1426496710-11712-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v4 3/9] power_management: split runpwtests.sh into
	separate testcases
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Split runpwtests.sh into separate testcases, eg. runpwtests01.sh.

Modification of pm_include.sh:
    * Add check_kervel_arch() to check kernel version and architecture.
    * Echo the result instead of using return from the is_multi_core etc.
    * Use "tst_brkm TCONF" instead of "echo", when the current system
      configuration doesn't support the test.
    * In order to match the count of TPASS/TFAIL with the TST_COUNT
      in each case, eg. runpwtests_exclusive01.sh, change "tst_resm
      TPASS/TFAIL" to "echo" in analyze_package_consolidation_result
      function etc.
    * Change format.

Modification of power_management_tests/power_management_tests_exclusive
in runtest:
    * Change runpwtests.sh to new testcases.
    * Since I don't have suitable machines and can't test some cases'
      correctness, eg runpwtests05.sh, currently these cases are
      disabled.

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 runtest/power_management_tests                     |   8 +-
 runtest/power_management_tests_exclusive           |  13 +-
 testcases/kernel/power_management/pm_include.sh    | 154 ++++++---
 testcases/kernel/power_management/runpwtests.sh    | 380 ---------------------
 testcases/kernel/power_management/runpwtests01.sh  |  49 +++
 testcases/kernel/power_management/runpwtests02.sh  |  47 +++
 testcases/kernel/power_management/runpwtests03.sh  |  64 ++++
 testcases/kernel/power_management/runpwtests04.sh  |  37 ++
 testcases/kernel/power_management/runpwtests05.sh  |  82 +++++
 testcases/kernel/power_management/runpwtests06.sh  |  51 +++
 .../power_management/runpwtests_exclusive01.sh     | 103 ++++++
 .../power_management/runpwtests_exclusive02.sh     |  73 ++++
 .../power_management/runpwtests_exclusive03.sh     | 101 ++++++
 .../power_management/runpwtests_exclusive04.sh     |  58 ++++
 .../power_management/runpwtests_exclusive05.sh     | 103 ++++++
 15 files changed, 889 insertions(+), 434 deletions(-)
 delete mode 100755 testcases/kernel/power_management/runpwtests.sh
 create mode 100755 testcases/kernel/power_management/runpwtests01.sh
 create mode 100755 testcases/kernel/power_management/runpwtests02.sh
 create mode 100755 testcases/kernel/power_management/runpwtests03.sh
 create mode 100755 testcases/kernel/power_management/runpwtests04.sh
 create mode 100755 testcases/kernel/power_management/runpwtests05.sh
 create mode 100755 testcases/kernel/power_management/runpwtests06.sh
 create mode 100755 testcases/kernel/power_management/runpwtests_exclusive01.sh
 create mode 100755 testcases/kernel/power_management/runpwtests_exclusive02.sh
 create mode 100755 testcases/kernel/power_management/runpwtests_exclusive03.sh
 create mode 100755 testcases/kernel/power_management/runpwtests_exclusive04.sh
 create mode 100755 testcases/kernel/power_management/runpwtests_exclusive05.sh

diff --git a/runtest/power_management_tests b/runtest/power_management_tests
index 5aa18bf..884e615 100644
--- a/runtest/power_management_tests
+++ b/runtest/power_management_tests
@@ -1 +1,7 @@
-POWER_MANAGEMENT runpwtests.sh
+#POWER_MANAGEMENT
+runpwtests01 runpwtests01.sh
+runpwtests02 runpwtests02.sh
+runpwtests03 runpwtests03.sh
+runpwtests04 runpwtests04.sh
+#runpwtests05 runpwtests05.sh
+runpwtests06 runpwtests06.sh
diff --git a/runtest/power_management_tests_exclusive b/runtest/power_management_tests_exclusive
index a1692df..26176e2 100644
--- a/runtest/power_management_tests_exclusive
+++ b/runtest/power_management_tests_exclusive
@@ -1 +1,12 @@
-POWER_MANAGEMENT runpwtests.sh -exclusive
+#POWER_MANAGEMENT exclusive
+runpwtests01 runpwtests01.sh
+runpwtests02 runpwtests02.sh
+runpwtests03 runpwtests03.sh
+runpwtests04 runpwtests04.sh
+#runpwtests05 runpwtests05.sh
+runpwtests06 runpwtests06.sh
+#runpwtests_exclusive01 runpwtests_exclusive01.sh
+#runpwtests_exclusive02 runpwtests_exclusive02.sh
+#runpwtests_exclusive03 runpwtests_exclusive03.sh
+#runpwtests_exclusive04 runpwtests_exclusive04.sh
+#runpwtests_exclusive05 runpwtests_exclusive05.sh
diff --git a/testcases/kernel/power_management/pm_include.sh b/testcases/kernel/power_management/pm_include.sh
index b1867e6..366c914 100755
--- a/testcases/kernel/power_management/pm_include.sh
+++ b/testcases/kernel/power_management/pm_include.sh
@@ -15,9 +15,27 @@ cleanup() {
 	fi
 }
 
+check_kervel_arch() {
+	# Checking required kernel version and architecture
+	tst_kvercmp 2 6 21; rc=$?
+	if [ $rc -ne 1 -a $rc -ne 2 ] ; then
+		tst_brkm TCONF "Kernel version not supported; not " \
+			"running testcases"
+	else
+		case "$(uname -m)" in
+		i[4-6]86|x86_64)
+			;;
+		*)
+			tst_brkm TCONF "Arch not supported; not running " \
+				"testcases"
+			;;
+		esac
+	fi
+}
+
 check_config_options() {
 	if ( ! ${3} "${1}" ${2} | grep -v "#" > /dev/null ) ; then
-		echo "NOSUPPORT: current system dosen't support ${1}"
+		tst_brkm TCONF "NOSUPPORT: current system dosen't support ${1}"
 	fi
 }
 
@@ -30,7 +48,8 @@ get_topology() {
 	for cpu in $(seq 0 "${total_cpus}" )
 	do
 		cpus[$cpu]=cpu${cpu}
-		phyid[$cpu]=$(cat /sys/devices/system/cpu/cpu${cpu}/topology/physical_package_id)
+		phyid[$cpu]=$(cat \
+		/sys/devices/system/cpu/cpu${cpu}/topology/physical_package_id)
 	done
 	j=0
 	while [ "${j}" -lt "${total_cpus}" ]
@@ -50,24 +69,27 @@ check_cpufreq() {
 	for cpu in $(seq 0 "${total_cpus}" )
 	do
 		if [ ! -d /sys/devices/system/cpu/cpu${cpu}/cpufreq ] ; then
-			echo "NOSUPPORT: cpufreq support not found please check Kernel configuration or BIOS settings"
-			exit $NOSUPPORT
+			tst_brkm TCONF "NOSUPPORT: cpufreq support not " \
+				"found please check Kernel configuration " \
+				"or BIOS settings"
 		fi
 	done
 }
 
 get_supporting_freq() {
-	cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_available_frequencies | uniq
+	cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_available_frequencies \
+		| uniq
 }
 
 get_supporting_govr() {
-	cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_available_governors | uniq
+	cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_available_governors \
+		| uniq
 }
 
 is_hyper_threaded() {
 	siblings=`cat /proc/cpuinfo | grep siblings | uniq | cut -f2 -d':'`
 	cpu_cores=`cat /proc/cpuinfo | grep "cpu cores" | uniq | cut -f2 -d':'`
-	[ $siblings -gt $cpu_cores ]; return $?
+	[ $siblings -gt $cpu_cores ]; echo $?
 }
 
 check_input() {
@@ -102,35 +124,39 @@ check_input() {
 }
 
 is_multi_socket() {
-	no_of_sockets=`cat /sys/devices/system/cpu/cpu?/topology/physical_package_id | uniq | wc -l`
-	[ $no_of_sockets -gt 1 ] ; return $?
+	no_of_sockets=`cat \
+		/sys/devices/system/cpu/cpu?/topology/physical_package_id \
+		| uniq | wc -l`
+	[ $no_of_sockets -gt 1 ] ; echo $?
 }
 
 is_multi_core() {
 	siblings=`cat /proc/cpuinfo | grep siblings | uniq | cut -f2 -d':'`
 	cpu_cores=`cat /proc/cpuinfo | grep "cpu cores" | uniq | cut -f2 -d':'`
 	if [ $siblings -eq $cpu_cores ]; then
-		[ $cpu_cores -gt 1 ]; return $?
+		[ $cpu_cores -gt 1 ]; echo $?
 	else
 		: $(( num_of_cpus = siblings / cpu_cores ))
-		[ $num_of_cpus -gt 1 ]; return $?
+		[ $num_of_cpus -gt 1 ]; echo $?
 	fi
 }
 
 is_dual_core() {
 	siblings=`cat /proc/cpuinfo | grep siblings | uniq | cut -f2 -d':'`
-        cpu_cores=`cat /proc/cpuinfo | grep "cpu cores" | uniq | cut -f2 -d':'`
+        cpu_cores=`cat /proc/cpuinfo | grep "cpu cores" | uniq \
+			| cut -f2 -d':'`
         if [ $siblings -eq $cpu_cores ]; then
-                [ $cpu_cores -eq 2 ]; return $?
+                [ $cpu_cores -eq 2 ]; echo $?
         else
                 : $(( num_of_cpus = siblings / cpu_cores ))
-                [ $num_of_cpus -eq 2 ]; return $?
+                [ $num_of_cpus -eq 2 ]; echo $?
         fi
 }
 
 get_kernel_version() {
 	# Get kernel minor version
-	export kernel_version=`uname -r | awk -F. '{print $1"."$2"."$3}' | cut -f1 -d'-'`
+	export kernel_version=`uname -r | awk -F. '{print $1"."$2"."$3}' \
+		| cut -f1 -d'-'`
 }
 
 get_valid_input() {
@@ -146,42 +172,46 @@ analyze_result_hyperthreaded() {
 	sched_mc=$1
     pass_count=$2
     sched_smt=$3
+	PASS="Test PASS"
+	FAIL="Test FAIL"
 
+	RC=0
 	case "$sched_mc" in
 	0)
 		case "$sched_smt" in
 		0)
 			if [ $pass_count -lt 5 ]; then
-				tst_resm TPASS "cpu consolidation failed for sched_mc=\
-$sched_mc & sched_smt=$sched_smt"
+				echo "${PASS}: cpu consolidation failed for" \
+					"sched_mc=$sched_mc & sched_smt=$sched_smt"
 			else
 				RC=1
-				tst_resm TFAIL "cpu consolidation passed for sched_mc=\
-$sched_mc & sched_smt=$sched_smt"
+				echo "${FAIL}: cpu consolidation passed for" \
+					"sched_mc=$sched_mc & sched_smt=$sched_smt"
 			fi
 			;;
 		*)
 			if [ $pass_count -lt 5 ]; then
-               	tst_resm TFAIL "cpu consolidation for sched_mc=\
-$sched_mc & sched_smt=$sched_smt"
-           	else
 				RC=1
-				tst_resm TPASS "cpu consolidation for sched_mc=\
-$sched_mc & sched_smt=$sched_smt"
+				echo "${FAIL}: cpu consolidation for" \
+					"sched_mc=$sched_mc & sched_smt=$sched_smt"
+			else
+				echo "${PASS}: cpu consolidation for" \
+					"sched_mc=$sched_mc & sched_smt=$sched_smt"
 			fi
 			;;
 		esac ;;
 	*)
 		if [ $pass_count -lt 5 ]; then
-			tst_resm TFAIL "cpu consolidation for sched_mc=\
-$sched_mc & sched_smt=$sched_smt"
-		else
 			RC=1
-			tst_resm TPASS "cpu consolidation for sched_mc=\
-$sched_mc & sched_smt=$sched_smt"
+			echo "${FAIL}: cpu consolidation for" \
+				"sched_mc=$sched_mc & sched_smt=$sched_smt"
+		else
+			echo "${PASS}: cpu consolidation for" \
+				"sched_mc=$sched_mc & sched_smt=$sched_smt"
 		fi
 		;;
 	esac
+	return $RC
 }
 
 analyze_package_consolidation_result() {
@@ -195,84 +225,104 @@ analyze_package_consolidation_result() {
 		sched_smt=-1
 	fi
 
+	PASS="Test PASS"
+	FAIL="Test FAIL"
+
+	RC=0
 	if [ $hyper_threaded -eq $YES -a $sched_smt -gt -1 ]; then
 		analyze_result_hyperthreaded $sched_mc $pass_count $sched_smt
 	else
 		case "$sched_mc" in
 	    0)
     	    if [ $pass_count -lt 5 ]; then
-        	    tst_resm TPASS "cpu consolidation failed for sched_mc=\
-$sched_mc"
+				echo "${PASS}: cpu consolidation failed for" \
+					"sched_mc=$sched_mc"
         	else
 				RC=1
-            	tst_resm TFAIL "cpu consolidation passed for sched_mc=\
-$sched_mc"
-        	fi ;;
+				echo "${FAIL}: cpu consolidation passed for" \
+					"sched_mc=$sched_mc"
+			fi
+			;;
     	*)
 			if [ $pass_count -lt 5 ]; then
-				tst_resm TFAIL "Consolidation at package level failed for \
-sched_mc=$sched_mc"
+				RC=1
+				echo "${FAIL}: consolidation at package level" \
+					"failed for sched_mc=$sched_mc"
 			else
-				tst_resm TPASS "Consolidation at package level passed for \
-sched_mc=$sched_mc"
+				echo "${PASS}: consolidation at package level" \
+					"passed for sched_mc=$sched_mc"
 			fi
         	;;
     	esac
 	fi
+	return $RC
 }
 
 analyze_core_consolidation_result() {
 	sched_smt=$1
 	pass_count=$2
+	PASS="Test PASS"
+	FAIL="Test FAIL"
 
+	RC=0
 	case "$sched_smt" in
 	0)
 		if [ $pass_count -lt 5 ]; then
-			tst_resm TPASS "Consolidation at core level failed \
-when sched_smt=$sched_smt"
+			echo "${PASS}: consolidation at core level failed" \
+				"when sched_smt=$sched_smt"
 		else
-			tst_resm TFAIL "Consolidation at core level passed for \
-sched_smt=$sched_smt"
+			RC=1
+			echo "${FAIL}: consolidation at core level passed for" \
+				"sched_smt=$sched_smt"
 		fi ;;
 	*)
 		if [ $pass_count -lt 5 ]; then
 			RC=1
-			tst_resm TFAIL "Consolidation at core level failed for \
-sched_smt=$sched_smt"
+			echo "${FAIL}: consolidation at core level failed for" \
+				"sched_smt=$sched_smt"
 		else
-			tst_resm TPASS "Consolidation at core level passed for \
-sched_smt=$sched_smt"
+			echo "${PASS}: consolidation at core level passed for" \
+				"sched_smt=$sched_smt"
 		fi ;;
 	esac
+	return $RC
 }
 
 analyze_sched_domain_result(){
 	sched_mc=$1
 	result=$2
 	sched_smt=$3
+	PASS="Test PASS"
+	FAIL="Test FAIL"
 
+	RC=0
 	if [ $hyper_threaded -eq $YES ]; then
 		if [ $sched_smt ]; then
 			if [ "$result" = 0 ];then
-				tst_resm TPASS "sched domain test for sched_mc=$sched_mc & sched_smt=$sched_smt"
+				echo "${PASS}: sched domain test for" \
+					"sched_mc=$sched_mc & sched_smt=$sched_smt"
 			else
 				RC=1
-				tst_resm TFAIL "sched domain test sched_mc=$sched_mc & sched_smt=$sched_smt"
+				echo "${FAIL}: sched domain test for" \
+					"sched_mc=$sched_mc & sched_smt=$sched_smt"
 			fi
 		else
 			if [ "$result" = 0 ];then
-				tst_resm TPASS "sched domain test for sched_mc=$sched_mc"
+				echo "${PASS}: sched domain test for" \
+					"sched_mc=$sched_mc"
 			else
 				RC=1
-				tst_resm TFAIL "sched domain test for sched_mc=$sched_mc"
+				echo "${FAIL}: sched domain test for" \
+					"sched_mc=$sched_mc"
 			fi
 		fi
 	else
 		if [ "$result" = 0 ];then
-			tst_resm TPASS "sched domain test for sched_mc=$sched_mc"
+			echo "${PASS}: sched domain test for sched_mc=$sched_mc"
 		else
 			RC=1
-			tst_resm TFAIL "sched domain test sched_mc=$sched_mc"
+			echo "${FAIL}: sched domain test for sched_mc=$sched_mc"
 		fi
 	fi
+	return $RC
 }
diff --git a/testcases/kernel/power_management/runpwtests.sh b/testcases/kernel/power_management/runpwtests.sh
deleted file mode 100755
index 9055964..0000000
--- a/testcases/kernel/power_management/runpwtests.sh
+++ /dev/null
@@ -1,380 +0,0 @@
-#! /bin/sh
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2001                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-################################################################################
-#
-# File :        runpwtests.sh
-#
-# Description:
-#
-# Author:       Nageswara R Sastry <nasastry@in.ibm.com>
-#
-# History:      26 Aug 2008 - Created this file
-# 03 Nov 2008 - Added CPUIDLE sysfs testcase
-#
-
-# Exporting Required variables
-export TST_TOTAL=1
-#LTPTMP=${TMP}
-export PATH=${PATH}:.
-export TCID="Power_Management"
-export TST_COUNT=0
-export contacts="mpnayak@linux.vnet.ibm.com"
-export analysis="/proctstat"
-
-YES=0
-NO=1
-#List of reusable functions defined in pm_include.sh
-. pm_include.sh
-
-# Function:     main
-#
-# Description:  - Execute all tests, exit with test status.
-#
-# Exit:         - zero on success
-#               - non-zero on failure.
-#
-RC=0		#Return status
-
-# Checking required kernel version and architecture
-tst_kvercmp 2 6 21; rc=$?
-if [ $rc -ne 1 -a $rc -ne 2 ] ; then
-	tst_resm TCONF "Kernel version not supported; not running testcases"
-	exit 0
-else
-	case "$(uname -m)" in
-	i[4-6]86|x86_64)
-		;;
-	*)
-		tst_resm TCONF "Arch not supported; not running testcases"
-		exit 0
-		;;
-	esac
-fi
-
-tst_kvercmp 2 6 29; rc=$?
-if [ $rc -eq 2 ] ; then
-	max_sched_mc=2
-	max_sched_smt=2
-else
-	max_sched_mc=1
-	max_sched_smt=1
-fi
-
-tst_kvercmp 2 6 31; rc=$?
-if [ $rc -eq 1 -o $rc -eq 2 ] ; then
-	timer_migr_support_compatible=1
-else
-	timer_migr_support_compatible=0
-fi
-
-is_hyper_threaded; hyper_threaded=$?
-is_multi_socket; multi_socket=$?
-is_multi_core; multi_core=$?
-is_dual_core; dual_core=$?
-
-#Checking sched_mc sysfs interface
-#check_config.sh config_sched_mc || RC=$?
-TST_COUNT=1
-if [ $multi_socket -eq $YES -a $multi_core -eq $YES ] ; then
-	if [ -f /sys/devices/system/cpu/sched_mc_power_savings ] ; then
-		if test_sched_mc.sh ; then
-			tst_resm TPASS "SCHED_MC sysfs tests"
-		else
-			RC=$?
-			tst_resm TFAIL "SCHED_MC sysfs tests"
-		fi
-	else
-    	tst_resm TCONF "Required kernel configuration for SCHED_MC NOT set"
-	fi
-else
-	if [ -f /sys/devices/system/cpu/sched_mc_power_savings ] ; then
-		tst_resm TFAIL "sched_mc_power_savings interface in system which is not a multi socket &(/) multi core"
-	else
-		tst_resm TCONF "Not a suitable architecture for SCHED_MC test"
-	fi
-fi
-
-# Test sched_smt_power_savings interface on HT machines
-: $(( TST_COUNT += 1 ))
-if [ $hyper_threaded -eq $YES ]; then
-	if [ -f /sys/devices/system/cpu/sched_smt_power_savings ] ; then
-    	if test_sched_smt.sh; then
-			tst_resm TPASS "SCHED_SMT sysfs test"
-		else
-			RC=$?
-        	tst_resm TFAIL "SCHED_SMT sysfs test"
-    	fi
-	else
-		RC=$?
-		tst_resm TFAIL "Required kernel configuration for SCHED_SMT NOT set"
-	fi
-else
-	if [ -f /sys/devices/system/cpu/sched_smt_power_savings ] ; then
-		RC=$?
-        tst_resm TFAIL "sched_smt_power_saving interface in system not hyper-threaded"
-    else
-        tst_resm TCONF "Required Hyper Threading support for SCHED_SMT test"
-    fi
-fi
-
-# Checking cpufreq sysfs interface files
-#check_config.sh config_cpu_freq || RC=$?
-: $(( TST_COUNT += 1 ))
-if [ -d /sys/devices/system/cpu/cpu0/cpufreq ] ; then
-    if check_cpufreq_sysfs_files.sh; then
-		tst_resm TPASS "CPUFREQ sysfs tests"
-	else
-		RC=$?
-		tst_resm TFAIL "CPUFREQ sysfs tests "
-	fi
-
-    # Changing governors
-	: $(( TST_COUNT += 1 ))
-	if change_govr.sh; then
-		tst_resm TPASS "Changing governors "
-	else
-		RC=$?
-		tst_resm TFAIL "Changing governors "
-	fi
-
-    # Changing frequencies
-	: $(( TST_COUNT += 1 ))
-    if change_freq.sh ; then
-		tst_resm TPASS "Changing frequncies "
-	else
-		RC=$?
-        tst_resm TFAIL "Changing frequncies "
-    fi
-
-    # Loading and Unloading governor related kernel modules
-	: $(( TST_COUNT += 1 ))
-    if pwkm_load_unload.sh ; then
-		tst_resm TPASS "Loading and Unloading of governor kernel \
-modules"
-	else
-		RC=$?
-        tst_resm TFAIL "Loading and Unloading of governor kernel \
-        modules got failed"
-    fi
-else
-    tst_resm TCONF "Required kernel configuration for CPU_FREQ NOT set"
-fi
-
-# Checking cpuidle sysfs interface files
-: $(( TST_COUNT+=1))
-if check_cpuidle_sysfs_files.sh ; then
-	tst_resm TPASS "CPUIDLE sysfs tests passed"
-else
-	RC=$?
-    tst_resm TFAIL "CPUIDLE sysfs tests failed"
-fi
-
-# sched_domain test
-if ! type python > /dev/null ; then
-	tst_resm TCONF "Python is not installed, CPU Consolidation\
-test cannot run"
-elif ! grep sched_debug -qw /proc/cmdline ; then
-	tst_resm TCONF "Kernel cmdline parameter 'sched_debug' needed,\
-CPU Consolidation test cannot run"
-else
-	if [ -f /sys/devices/system/cpu/sched_mc_power_savings ] ; then
-    		echo "max sched mc $max_sched_mc"
-		for sched_mc in `seq 0 $max_sched_mc`; do
-			: $(( TST_COUNT+=1))
-			sched_domain.py -c $sched_mc; RC=$?
-			analyze_sched_domain_result $sched_mc $RC
-			if [ $hyper_threaded -eq $YES -a -f /sys/devices/system/cpu/sched_smt_power_savings ]; then
-				get_sched_values sched_smt; max_sched_smt=$?
-				for sched_smt in `seq 0 $max_sched_smt`; do
-					# Testcase to validate sched_domain tree
-					: $(( TST_COUNT+=1))
-					sched_domain.py -c $sched_mc -t $sched_smt; RC=$?
-					analyze_sched_domain_result $sched_mc $RC $sched_smt ;
-				done
-			fi
-		done
-	fi
-fi
-
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
-if [ $# -gt 0 -a "$1" = "-exclusive" ]; then
-	# Test CPU consolidation
-	if [ $multi_socket -eq $YES -a $multi_core -eq $YES ]; then
-		for sched_mc in `seq 0  $max_sched_mc`; do
-			: $(( TST_COUNT += 1 ))
-			sched_mc_pass_cnt=0
-			if [ $sched_mc -eq 2 ]; then
-				work_load="kernbench"
-			else
-				work_load="ebizzy"
-			fi
-			for repeat_test in `seq 1  10`; do
-				#Testcase to validate CPU consolidation for sched_mc
-				if cpu_consolidation.py -c $sched_mc -w $work_load ; then
-					: $(( sched_mc_pass_cnt += 1 ))
-				fi
-			done
-			analyze_package_consolidation_result $sched_mc $sched_mc_pass_cnt
-
-			if [ $hyper_threaded -eq $YES ]; then
-				for sched_smt in `seq 0 $max_sched_smt`; do
-					: $(( TST_COUNT += 1 ))
-					sched_mc_smt_pass_cnt=0
-					for repeat_test in `seq 1  10`; do
-						# Testcase to validate CPU consolidation for
-						# for sched_mc & sched_smt with stress=50%
-						if cpu_consolidation.py -c $sched_mc -t $sched_smt -w $work_load; then
-							: $(( sched_mc_smt_pass_cnt += 1 ))
-						fi
-					done
-					analyze_package_consolidation_result $sched_mc $sched_mc_smt_pass_cnt $sched_smt
-				done
-			fi
-		done
-
-	fi
-
-	if [ $hyper_threaded -eq $YES -a $multi_socket -eq $YES -a $multi_core -eq $NO ]; then
-			#Testcase to validate consolidation at core level
-			for sched_smt in `seq 0 $max_sched_smt`; do
-				if [ $sched_smt -eq 2 ]; then
-				 	work_load="kernbench"
-				else
-					work_load="ebizzy"
-				fi
-				sched_smt_pass_cnt=0
-				: $(( TST_COUNT += 1 ))
-				stress="thread"
-				for repeat_test in `seq 1  10`; do
-					if cpu_consolidation.py -t $sched_smt -w $work_load -s $stress; then
-						: $(( sched_smt_pass_cnt += 1 ))
-					fi
-				done
-				analyze_core_consolidation_result $sched_smt $sched_smt_pass_cnt
-			done
-	fi
-
-	# Verify threads consolidation stops when sched_mc &(/) sched_smt is disabled
-    if [ $multi_socket -eq $YES -a $multi_core -eq $YES ]; then
-        for sched_mc in `seq 1  $max_sched_mc`; do
-			: $(( TST_COUNT += 1 ))
-
-			# Vary sched_mc from 1/2 to 0 when workload is running and ensure that
-			# tasks do not consolidate to single package when sched_mc is set to 0
-			if cpu_consolidation.py -v -c $sched_mc; then
-            	tst_resm TPASS "CPU consolidation test by varying sched_mc $sched_mc to 0"
-        	else
-            	tst_resm TFAIL "CPU consolidation test by varying sched_mc $sched_mc to 0"
-        	fi
-
-			if [ $hyper_threaded -eq $YES ]; then
-				for sched_smt in `seq 1  $max_sched_smt`; do
-					if [ $sched_smt -eq $sched_mc ]; then
-						# Vary sched_mc & sched_smt from 1 to 0 & 2 to 0 when workload is running and ensure that
-            			# tasks do not consolidate to single package when sched_mc is set to 0
-            			: $(( TST_COUNT += 1 ))
-						if cpu_consolidation.py -v -c $sched_mc -t $sched_smt; then
-							tst_resm TPASS "CPU consolidation test by varying sched_mc \
-& sched_smt from $sched_mc to 0"
-						else
-							tst_resm TFAIL "CPU consolidation test by varying sched_mc \
-& sched_smt from $sched_mc to 0"
-						fi
-					fi
-				done
-			fi
-		done
-	fi
-
-    # Verify threads consolidation stops when sched_smt is disabled in HT systems
-	if [ $hyper_threaded -eq $YES -a $multi_socket -eq $YES ]; then
-		# Vary only sched_smt from 1 to 0 when workload is running and ensure that
-		# tasks do not consolidate to single core when sched_smt is set to 0
-		: $(( TST_COUNT += 1 ))
-		if cpu_consolidation.py -v -t 1; then
-			tst_resm TPASS "CPU consolidation test by varying sched_smt from 1 to 0"
-		else
-			tst_resm TFAIL "CPU consolidation test by varying sched_smt from 1 to 0"
-		fi
-
-        # Vary only sched_smt from 2 to 0 when workload is running and ensure that
-        # tasks do not consolidate to single core when sched_smt is set to 0
-        : $(( TST_COUNT += 1 ))
-        if cpu_consolidation.py -v -t 2; then
-            tst_resm TPASS "CPU consolidation test by varying sched_smt 2 to 0"
-        else
-            tst_resm TFAIL "CPU consolidation test by varying sched_smt 2 to 0"
-        fi
-
-	fi
-
-	# Verify ILB runs in same package as workload
-    if [ $multi_socket -eq $YES -a $multi_core -eq $YES ]; then
-		for sched_mc in `seq 1 $max_sched_mc`; do
-			: $(( TST_COUNT += 1 ))
-            if [ $sched_mc -eq 2 ]; then
-                work_load="kernbench"
-            else
-                work_load="ebizzy"
-            fi
-
-            ilb_test.py -c $sched_mc -w $work_load; RC=$?
-			if [ $RC -eq 0 ]; then
-				tst_resm TPASS "ILB & workload in same package for sched_mc=$sched_mc"
-			else
-				tst_resm TFAIL "ILB & workload did not run in same package for sched_mc=$sched_mc\
-. Ensure CONFIG_NO_HZ is set"
-			fi
-			if [ $hyper_threaded -eq $YES ]; then
-				for sched_smt in `seq 1 $max_sched_smt`; do
-					: $(( TST_COUNT += 1 ))
-					ilb_test.py -c $sched_mc -t sched_smt -w $work_load; RC=$?
- 					if [ $RC -eq 0 ]; then
-						tst_resm TPASS "ILB & workload in same package for sched_mc=$sched_mc \
-& sched_smt=$sched_smt"
-					else
-						tst_resm TFAIL "ILB & workload did not execute in same package for \
-sched_mc=$sched_mc & sched_smt=$sched_smt. Ensure CONFIG_NO_HZ is set"
-					fi
-				done
-			fi
-		done
-	fi
-fi
-
-exit $RC
diff --git a/testcases/kernel/power_management/runpwtests01.sh b/testcases/kernel/power_management/runpwtests01.sh
new file mode 100755
index 0000000..7dc164c
--- /dev/null
+++ b/testcases/kernel/power_management/runpwtests01.sh
@@ -0,0 +1,49 @@
+#! /bin/sh
+#
+# Copyright (c) International Business Machines  Corp., 2001
+# Author: Nageswara R Sastry <nasastry@in.ibm.com>
+#
+# This program is free software;  you can redistribute it and#or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful, but
+# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+# for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program;  if not, write to the Free Software Foundation,
+# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+#
+
+export TCID="Power_Management01"
+export TST_TOTAL=1
+
+. test.sh
+. pm_include.sh
+
+# Checking test environment
+check_kervel_arch
+
+# Checking sched_mc sysfs interface
+multi_socket=$(is_multi_socket)
+multi_core=$(is_multi_core)
+if [ ! -f /sys/devices/system/cpu/sched_mc_power_savings ] ; then
+	tst_brkm TCONF "Required kernel configuration for SCHED_MC" \
+		"NOT set"
+else
+	if [ $multi_socket -ne 0 -a $multi_core -ne 0 ] ; then
+		tst_brkm TCONF "sched_mc_power_savings interface in system" \
+			"which is not a multi socket &(/) multi core"
+	fi
+fi
+
+if test_sched_mc.sh ; then
+	tst_resm TPASS "SCHED_MC sysfs tests"
+else
+	tst_resm TFAIL "SCHED_MC sysfs tests"
+fi
+
+tst_exit
diff --git a/testcases/kernel/power_management/runpwtests02.sh b/testcases/kernel/power_management/runpwtests02.sh
new file mode 100755
index 0000000..067569e
--- /dev/null
+++ b/testcases/kernel/power_management/runpwtests02.sh
@@ -0,0 +1,47 @@
+#! /bin/sh
+#
+# Copyright (c) International Business Machines  Corp., 2001
+# Author: Nageswara R Sastry <nasastry@in.ibm.com>
+#
+# This program is free software;  you can redistribute it and#or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful, but
+# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+# for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program;  if not, write to the Free Software Foundation,
+# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+#
+
+export TCID="Power_Management02"
+export TST_TOTAL=1
+
+. test.sh
+. pm_include.sh
+
+# Checking test environment
+check_kervel_arch
+
+# Check sched_smt_power_savings interface on HT machines
+hyper_threaded=$(is_hyper_threaded)
+if [ ! -f /sys/devices/system/cpu/sched_smt_power_savings ] ; then
+	tst_brkm TCONF "Required kernel configuration for SCHED_SMT NOT set"
+else
+	if [ $hyper_threaded -ne 0 ]; then
+		tst_brkm TCONF "sched_smt_power_saving interface in system" \
+			"not hyper-threaded"
+	fi
+fi
+
+if test_sched_smt.sh ; then
+	tst_resm TPASS "SCHED_SMT sysfs test"
+else
+	tst_resm TFAIL "SCHED_SMT sysfs test"
+fi
+
+tst_exit
diff --git a/testcases/kernel/power_management/runpwtests03.sh b/testcases/kernel/power_management/runpwtests03.sh
new file mode 100755
index 0000000..34fb1a4
--- /dev/null
+++ b/testcases/kernel/power_management/runpwtests03.sh
@@ -0,0 +1,64 @@
+#! /bin/sh
+#
+# Copyright (c) International Business Machines  Corp., 2001
+# Author: Nageswara R Sastry <nasastry@in.ibm.com>
+#
+# This program is free software;  you can redistribute it and#or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful, but
+# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+# for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program;  if not, write to the Free Software Foundation,
+# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+#
+
+export TCID="Power_Management03"
+export TST_TOTAL=4
+
+. test.sh
+. pm_include.sh
+
+# Checking test environment
+check_kervel_arch
+
+# Checking cpufreq sysfs interface files
+if [ ! -d /sys/devices/system/cpu/cpu0/cpufreq ] ; then
+	tst_brkm TCONF "Required kernel configuration for CPU_FREQ NOT set"
+fi
+
+if check_cpufreq_sysfs_files.sh ; then
+	tst_resm TPASS "CPUFREQ sysfs tests"
+else
+	tst_resm TFAIL "CPUFREQ sysfs tests"
+fi
+
+# Changing governors
+if change_govr.sh ; then
+	tst_resm TPASS "Changing governors"
+else
+	tst_resm TFAIL "Changing governors"
+fi
+
+# Changing frequencies
+if change_freq.sh ; then
+	tst_resm TPASS "Changing frequncies"
+else
+    tst_resm TFAIL "Changing frequncies"
+fi
+
+# Loading and Unloading governor related kernel modules
+if pwkm_load_unload.sh ; then
+	tst_resm TPASS "Loading and Unloading of governor kernel" \
+		"modules"
+else
+	tst_resm TFAIL "Loading and Unloading of governor kernel" \
+		"modules got failed"
+fi
+
+tst_exit
diff --git a/testcases/kernel/power_management/runpwtests04.sh b/testcases/kernel/power_management/runpwtests04.sh
new file mode 100755
index 0000000..eeb4b22
--- /dev/null
+++ b/testcases/kernel/power_management/runpwtests04.sh
@@ -0,0 +1,37 @@
+#! /bin/sh
+#
+# Copyright (c) International Business Machines  Corp., 2001
+# Author: Nageswara R Sastry <nasastry@in.ibm.com>
+#
+# This program is free software;  you can redistribute it and#or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful, but
+# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+# for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program;  if not, write to the Free Software Foundation,
+# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+#
+
+export TCID="Power_Management04"
+export TST_TOTAL=1
+
+. test.sh
+. pm_include.sh
+
+# Checking test environment
+check_kervel_arch
+
+# Checking cpuidle sysfs interface files
+if check_cpuidle_sysfs_files.sh ; then
+	tst_resm TPASS "CPUIDLE sysfs tests passed"
+else
+    tst_resm TFAIL "CPUIDLE sysfs tests failed"
+fi
+
+tst_exit
diff --git a/testcases/kernel/power_management/runpwtests05.sh b/testcases/kernel/power_management/runpwtests05.sh
new file mode 100755
index 0000000..c086e3c
--- /dev/null
+++ b/testcases/kernel/power_management/runpwtests05.sh
@@ -0,0 +1,82 @@
+#! /bin/sh
+#
+# Copyright (c) International Business Machines  Corp., 2001
+# Author: Nageswara R Sastry <nasastry@in.ibm.com>
+#
+# This program is free software;  you can redistribute it and#or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful, but
+# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+# for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program;  if not, write to the Free Software Foundation,
+# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+#
+
+export TCID="Power_Management05"
+export TST_TOTAL=2
+
+. test.sh
+. pm_include.sh
+
+# Checking test environment
+check_kervel_arch
+
+tst_kvercmp 2 6 29; rc=$?
+if [ $rc -eq 2 ] ; then
+	max_sched_mc=2
+	max_sched_smt=2
+else
+	max_sched_mc=1
+	max_sched_smt=1
+fi
+
+tst_check_cmds python
+
+if ! grep sched_debug -qw /proc/cmdline ; then
+	tst_brkm TCONF "Kernel cmdline parameter 'sched_debug' needed," \
+		"CPU Consolidation test cannot run"
+fi
+
+hyper_threaded=$(is_hyper_threaded)
+if [ ! -f /sys/devices/system/cpu/sched_mc_power_savings \
+	-o $hyper_threaded -ne 0 ] ; then
+	tst_brkm TCONF "Required kernel configuration for SCHED_MC" \
+		"NOT set, or sched_mc_power_savings interface in system" \
+		"which is not hyper-threaded"
+fi
+
+# sched_domain test
+echo "max sched mc $max_sched_mc"
+RC=0
+for sched_mc in `seq 0 $max_sched_mc`; do
+	sched_domain.py -c $sched_mc; ret=$?
+	analyze_sched_domain_result $sched_mc $ret; RC=$?
+done
+if [ $RC -eq 0 ]; then
+	tst_resm TPASS "Sched_domain test for sched_mc"
+else
+	tst_resm TFAIL "Sched_domain test for sched_mc"
+fi
+
+# Testcase to validate sched_domain tree
+RC=0
+for sched_mc in `seq 0 $max_sched_mc`; do
+	get_sched_values sched_smt; max_sched_smt=$?
+	for sched_smt in `seq 0 $max_sched_smt`; do
+		sched_domain.py -c $sched_mc -t $sched_smt; ret=$?
+		analyze_sched_domain_result $sched_mc $ret $sched_smt; RC=$?
+	done
+done
+if [ $RC -eq 0 ]; then
+	tst_resm TPASS "Sched_domain test for sched_mc & sched_smt"
+else
+	tst_resm TFAIL "Sched_domain test for sched_mc & sched_smt"
+fi
+
+tst_exit
diff --git a/testcases/kernel/power_management/runpwtests06.sh b/testcases/kernel/power_management/runpwtests06.sh
new file mode 100755
index 0000000..ab5d7de
--- /dev/null
+++ b/testcases/kernel/power_management/runpwtests06.sh
@@ -0,0 +1,51 @@
+#! /bin/sh
+#
+# Copyright (c) International Business Machines  Corp., 2001
+# Author: Nageswara R Sastry <nasastry@in.ibm.com>
+#
+# This program is free software;  you can redistribute it and#or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful, but
+# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+# for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program;  if not, write to the Free Software Foundation,
+# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+#
+
+export TCID="Power_Management06"
+export TST_TOTAL=1
+
+. test.sh
+. pm_include.sh
+
+# Checking test environment
+check_kervel_arch
+
+tst_kvercmp 2 6 31; rc=$?
+if [ $rc -eq 1 -o $rc -eq 2 ] ; then
+	timer_migr_support_compatible=0
+else
+	timer_migr_support_compatible=1
+fi
+
+if [ $timer_migr_support_compatible -eq 1 ]; then
+	tst_brkm TCONF "Kernel version does not support Timer migration"
+else
+	if [ ! -f /proc/sys/kernel/timer_migration ]; then
+		tst_brkm TBROK "Timer migration interface missing"
+	fi
+fi
+
+if test_timer_migration.sh; then
+	tst_resm TPASS "Timer Migration interface test"
+else
+	tst_resm TFAIL "Timer migration interface test"
+fi
+
+tst_exit
diff --git a/testcases/kernel/power_management/runpwtests_exclusive01.sh b/testcases/kernel/power_management/runpwtests_exclusive01.sh
new file mode 100755
index 0000000..27876bf
--- /dev/null
+++ b/testcases/kernel/power_management/runpwtests_exclusive01.sh
@@ -0,0 +1,103 @@
+#! /bin/sh
+#
+# Copyright (c) International Business Machines  Corp., 2001
+# Author: Nageswara R Sastry <nasastry@in.ibm.com>
+#
+# This program is free software;  you can redistribute it and#or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful, but
+# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+# for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program;  if not, write to the Free Software Foundation,
+# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+#
+
+export TCID="Power_Management_exclusive01"
+export TST_TOTAL=2
+
+. test.sh
+. pm_include.sh
+
+# Checking test environment
+check_kervel_arch
+
+tst_kvercmp 2 6 29; rc=$?
+if [ $rc -eq 2 ] ; then
+	max_sched_mc=2
+	max_sched_smt=2
+else
+	max_sched_mc=1
+	max_sched_smt=1
+fi
+
+tst_check_cmds python
+
+hyper_threaded=$(is_hyper_threaded)
+multi_socket=$(is_multi_socket)
+multi_core=$(is_multi_core)
+if [ $multi_socket -ne 0 -o $multi_core -ne 0 -o \
+	$hyper_threaded -ne 0 ]; then
+	tst_brkm TCONF "System is not a multi socket & multi core" \
+		"& hyper-threaded"
+fi
+
+# Test CPU consolidation
+RC=0
+for sched_mc in `seq 0  $max_sched_mc`; do
+	sched_mc_pass_cnt=0
+	if [ $sched_mc -eq 2 ]; then
+		work_load="kernbench"
+	else
+		work_load="ebizzy"
+	fi
+	for repeat_test in `seq 1  10`; do
+		#Testcase to validate CPU consolidation for sched_mc
+		if cpu_consolidation.py -c $sched_mc -w $work_load ; then
+		: $(( sched_mc_pass_cnt += 1 ))
+		fi
+	done
+	analyze_package_consolidation_result $sched_mc \
+		$sched_mc_pass_cnt; RC=$?
+done
+if [ $RC -eq 0 ]; then
+	tst_resm TPASS "CPU consolidation test for sched_mc"
+else
+	tst_resm TFAIL "CPU consolidation test for sched_mc"
+fi
+
+RC=0
+for sched_mc in `seq 0  $max_sched_mc`; do
+	if [ $sched_mc -eq 2 ]; then
+		work_load="kernbench"
+	else
+		work_load="ebizzy"
+	fi
+	for sched_smt in `seq 0 $max_sched_smt`; do
+		sched_mc_smt_pass_cnt=0
+		for repeat_test in `seq 1  10`; do
+			# Testcase to validate CPU consolidation for
+			# for sched_mc & sched_smt with stress=50%
+			if cpu_consolidation.py -c $sched_mc -t $sched_smt \
+				-w $work_load ; then
+				: $(( sched_mc_smt_pass_cnt += 1 ))
+			fi
+		done
+		analyze_package_consolidation_result $sched_mc \
+			$sched_mc_smt_pass_cnt $sched_smt; RC=$?
+	done
+done
+if [ $RC -eq 0 ]; then
+	tst_resm TPASS "CPU consolidation test for sched_mc &" \
+		"sched_smt with stress=50%"
+else
+	tst_resm TFAIL "CPU consolidation test for sched_mc &" \
+		"sched_smt with stress=50%"
+fi
+
+tst_exit
diff --git a/testcases/kernel/power_management/runpwtests_exclusive02.sh b/testcases/kernel/power_management/runpwtests_exclusive02.sh
new file mode 100755
index 0000000..7d12662
--- /dev/null
+++ b/testcases/kernel/power_management/runpwtests_exclusive02.sh
@@ -0,0 +1,73 @@
+#! /bin/sh
+#
+# Copyright (c) International Business Machines  Corp., 2001
+# Author: Nageswara R Sastry <nasastry@in.ibm.com>
+#
+# This program is free software;  you can redistribute it and#or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful, but
+# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+# for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program;  if not, write to the Free Software Foundation,
+# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+#
+
+export TCID="Power_Management_exclusive02"
+export TST_TOTAL=1
+
+. test.sh
+. pm_include.sh
+
+# Checking test environment
+check_kervel_arch
+
+tst_kvercmp 2 6 29; rc=$?
+if [ $rc -eq 2 ] ; then
+	max_sched_smt=2
+else
+	max_sched_smt=1
+fi
+
+tst_check_cmds python
+
+hyper_threaded=$(is_hyper_threaded)
+multi_socket=$(is_multi_socket)
+multi_core=$(is_multi_core)
+if [ $hyper_threaded -ne 0 -o $multi_socket -ne 0 \
+	-o $multi_core -eq 0 ]; then
+	tst_brkm TCONF "System is a multi core but not multi" \
+		"socket & hyper-threaded"
+fi
+
+#Testcase to validate consolidation at core level
+RC=0
+for sched_smt in `seq 0 $max_sched_smt`; do
+	if [ $sched_smt -eq 2 ]; then
+		work_load="kernbench"
+	else
+		work_load="ebizzy"
+	fi
+	sched_smt_pass_cnt=0
+	stress="thread"
+	for repeat_test in `seq 1  10`; do
+		if cpu_consolidation.py -t $sched_smt -w $work_load \
+			-s $stress; then
+			: $(( sched_smt_pass_cnt += 1 ))
+		fi
+	done
+	analyze_core_consolidation_result $sched_smt \
+		$sched_smt_pass_cnt; RC=$?
+done
+if [ $RC -eq 0 ]; then
+    tst_resm TPASS "Consolidation test at core level for sched_smt"
+else
+    tst_resm TFAIL "Consolidation test at core level for sched_smt"
+fi
+
+tst_exit
diff --git a/testcases/kernel/power_management/runpwtests_exclusive03.sh b/testcases/kernel/power_management/runpwtests_exclusive03.sh
new file mode 100755
index 0000000..99c1391
--- /dev/null
+++ b/testcases/kernel/power_management/runpwtests_exclusive03.sh
@@ -0,0 +1,101 @@
+#! /bin/sh
+#
+# Copyright (c) International Business Machines  Corp., 2001
+# Author: Nageswara R Sastry <nasastry@in.ibm.com>
+#
+# This program is free software;  you can redistribute it and#or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful, but
+# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+# for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program;  if not, write to the Free Software Foundation,
+# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+#
+
+export TCID="Power_Management_exclusive03"
+export TST_TOTAL=2
+
+. test.sh
+. pm_include.sh
+
+# Checking test environment
+check_kervel_arch
+
+tst_kvercmp 2 6 29; rc=$?
+if [ $rc -eq 2 ] ; then
+	max_sched_mc=2
+	max_sched_smt=2
+else
+	max_sched_mc=1
+	max_sched_smt=1
+fi
+
+tst_check_cmds python
+
+hyper_threaded=$(is_hyper_threaded)
+multi_socket=$(is_multi_socket)
+multi_core=$(is_multi_core)
+if [ $multi_socket -ne 0 -o $multi_core -ne 0 -o \
+	$hyper_threaded -ne 0 ]; then
+	tst_brkm TCONF "System is not a multi socket & multi core" \
+		"& hyper-threaded"
+fi
+
+# Verify threads consolidation stops when sched_mc &(/) sched_smt
+# is disabled.
+# Vary sched_mc from 1/2 to 0 when workload is running and
+# ensure that tasks do not consolidate to single package when
+# sched_mc is set to 0.
+RC=0
+for sched_mc in `seq 1  $max_sched_mc`; do
+	if cpu_consolidation.py -v -c $sched_mc; then
+		echo "Test PASS: CPU consolidation test by varying" \
+			"sched_mc $sched_mc to 0"
+	else
+		RC=1
+		echo "Test FAIL: CPU consolidation test by varying" \
+			"sched_mc $sched_mc to 0"
+	fi
+done
+if [ $RC -eq 0 ]; then
+	tst_resm TPASS "CPU consolidation test by varying sched_mc"
+else
+	tst_resm TFAIL "CPU consolidation test by varying sched_mc"
+fi
+
+# Vary sched_mc & sched_smt from 1 to 0 & 2 to 0 when workload
+# is running and ensure that tasks do not consolidate to single
+# package when sched_mc is set to 0.
+RC=0
+for sched_mc in `seq 1  $max_sched_mc`; do
+	for sched_smt in `seq 1  $max_sched_smt`; do
+		if [ $sched_smt -eq $sched_mc ]; then
+			if cpu_consolidation.py -v -c $sched_mc \
+				-t $sched_smt; then
+				echo "Test PASS: CPU consolidation test by" \
+					"varying sched_mc & sched_smt from" \
+					"$sched_mc to 0"
+			else
+				RC=1
+				echo "Test FAIL: CPU consolidation test by" \
+					"varying sched_mc & sched_smt from" \
+					"$sched_mc to 0"
+			fi
+		fi
+	done
+done
+if [ $RC -eq 0 ]; then
+	tst_resm TPASS "CPU consolidation test by varying" \
+		"sched_mc & sched_smt"
+else
+	tst_resm TFAIL "CPU consolidation test by varying" \
+		"sched_mc & sched_smt"
+fi
+
+tst_exit
diff --git a/testcases/kernel/power_management/runpwtests_exclusive04.sh b/testcases/kernel/power_management/runpwtests_exclusive04.sh
new file mode 100755
index 0000000..094bb22
--- /dev/null
+++ b/testcases/kernel/power_management/runpwtests_exclusive04.sh
@@ -0,0 +1,58 @@
+#! /bin/sh
+#
+# Copyright (c) International Business Machines  Corp., 2001
+# Author: Nageswara R Sastry <nasastry@in.ibm.com>
+#
+# This program is free software;  you can redistribute it and#or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful, but
+# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+# for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program;  if not, write to the Free Software Foundation,
+# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+#
+
+export TCID="Power_Management_exclusive04"
+export TST_TOTAL=2
+
+. test.sh
+. pm_include.sh
+
+# Checking test environment
+check_kervel_arch
+
+tst_check_cmds python
+
+hyper_threaded=$(is_hyper_threaded)
+multi_socket=$(is_multi_socket)
+if [ $hyper_threaded -ne 0 -o $multi_socket -ne 0 ]; then
+	tst_brkm TCONF "System is not a multi socket & hyper-threaded"
+fi
+
+# Verify threads consolidation stops when sched_smt is
+# disabled in HT systems.
+# Vary only sched_smt from 1 to 0 when workload is running
+# and ensure that tasks do not consolidate to single core
+# when sched_smt is set to 0.
+if cpu_consolidation.py -v -t 1; then
+	tst_resm TPASS "CPU consolidation test by varying sched_smt from 1 to 0"
+else
+	tst_resm TFAIL "CPU consolidation test by varying sched_smt from 1 to 0"
+fi
+
+# Vary only sched_smt from 2 to 0 when workload is running
+# and ensure that tasks do not consolidate to single core
+# when sched_smt is set to 0.
+if cpu_consolidation.py -v -t 2; then
+	tst_resm TPASS "CPU consolidation test by varying sched_smt from 2 to 0"
+else
+	tst_resm TFAIL "CPU consolidation test by varying sched_smt from 2 to 0"
+fi
+
+tst_exit
diff --git a/testcases/kernel/power_management/runpwtests_exclusive05.sh b/testcases/kernel/power_management/runpwtests_exclusive05.sh
new file mode 100755
index 0000000..1f40dc6
--- /dev/null
+++ b/testcases/kernel/power_management/runpwtests_exclusive05.sh
@@ -0,0 +1,103 @@
+#! /bin/sh
+#
+# Copyright (c) International Business Machines  Corp., 2001
+# Author: Nageswara R Sastry <nasastry@in.ibm.com>
+#
+# This program is free software;  you can redistribute it and#or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful, but
+# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+# for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program;  if not, write to the Free Software Foundation,
+# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+#
+
+export TCID="Power_Management_exclusive05"
+export TST_TOTAL=2
+
+. test.sh
+. pm_include.sh
+
+# Checking test environment
+check_kervel_arch
+
+tst_kvercmp 2 6 29; rc=$?
+if [ $rc -eq 2 ] ; then
+	max_sched_mc=2
+	max_sched_smt=2
+else
+	max_sched_mc=1
+	max_sched_smt=1
+fi
+
+tst_check_cmds python
+
+hyper_threaded=$(is_hyper_threaded)
+multi_socket=$(is_multi_socket)
+multi_core=$(is_multi_core)
+if [ $multi_socket -ne 0 -o $multi_core -ne 0 -o \
+	$hyper_threaded -ne 0 ]; then
+	tst_brkm TCONF "System is not a multi socket & multi core" \
+		"& hyper-threaded"
+fi
+
+# Verify ILB runs in same package as workload.
+RC=0
+for sched_mc in `seq 1 $max_sched_mc`; do
+	if [ $sched_mc -eq 2 ]; then
+		work_load="kernbench"
+	else
+		work_load="ebizzy"
+	fi
+
+	ilb_test.py -c $sched_mc -w $work_load
+	if [ $? -eq 0 ]; then
+		echo "Test PASS: ILB & workload in same package for" \
+			"sched_mc=$sched_mc"
+	else
+		RC=1
+		echo "Test FAIL: ILB & workload did not run in same package" \
+			"for sched_mc=$sched_mc. Ensure CONFIG_NO_HZ is set"
+	fi
+done
+if [ $RC -eq 0 ]; then
+	tst_resm TPASS "ILB & workload test in same package for sched_mc"
+else
+	tst_resm TFAIL "ILB & workload test in same package for sched_mc"
+fi
+
+RC=0
+for sched_mc in `seq 1 $max_sched_mc`; do
+	if [ $sched_mc -eq 2 ]; then
+		work_load="kernbench"
+	else
+		work_load="ebizzy"
+	fi
+	for sched_smt in `seq 1 $max_sched_smt`; do
+		ilb_test.py -c $sched_mc -t sched_smt -w $work_load
+		if [ $? -eq 0 ]; then
+			echo "Test PASS: ILB & workload in same package for" \
+				"sched_mc=$sched_mc & sched_smt=$sched_smt"
+		else
+			RC=1
+			echo "Test FAIL: ILB & workload did not execute in" \
+				"same package for sched_mc=$sched_mc &" \
+				"sched_smt=$sched_smt. Ensure CONFIG_NO_HZ is set"
+		fi
+	done
+done
+if [ $RC -eq 0 ]; then
+	tst_resm TPASS "ILB & workload test in same package for" \
+		"sched_mc & sched_smt"
+else
+	tst_resm TFAIL "ILB & workload test in same package for" \
+		"sched_mc & sched_smt"
+fi
+
+tst_exit
-- 
1.9.3


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
