Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1YlU1G-00017g-Ht
	for ltp-list@lists.sourceforge.net; Fri, 24 Apr 2015 03:11:10 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YlU1D-0004ar-Af
	for ltp-list@lists.sourceforge.net; Fri, 24 Apr 2015 03:11:10 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t3O39nwK031049
	for <ltp-list@lists.sourceforge.net>; Fri, 24 Apr 2015 11:09:50 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Fri, 24 Apr 2015 11:06:05 +0800
Message-ID: <1429844769-7113-4-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1429844769-7113-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1429844769-7113-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v5 4/8] power_management: call the function eg.
	test_sched_mc instead of script test_sched_mc.sh
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

Many scripts eg. test_sched_mc.sh is called only from
one test eg. runpwtests01.sh. Remove the script code
into the corresponding test case.

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 testcases/kernel/power_management/change_freq.sh   |  36 ------
 testcases/kernel/power_management/change_govr.sh   |  24 ----
 .../power_management/check_cpufreq_sysfs_files.sh  |  24 ----
 .../power_management/check_cpuidle_sysfs_files.sh  |  19 ---
 .../kernel/power_management/pwkm_load_unload.sh    |  30 -----
 testcases/kernel/power_management/runpwtests01.sh  |  24 +++-
 testcases/kernel/power_management/runpwtests02.sh  |  23 +++-
 testcases/kernel/power_management/runpwtests03.sh  | 131 ++++++++++++++++++++-
 testcases/kernel/power_management/runpwtests04.sh  |  23 +++-
 testcases/kernel/power_management/runpwtests06.sh  |  22 +++-
 testcases/kernel/power_management/test_sched_mc.sh |  24 ----
 .../kernel/power_management/test_sched_smt.sh      |  23 ----
 .../power_management/test_timer_migration.sh       |  22 ----
 13 files changed, 215 insertions(+), 210 deletions(-)
 delete mode 100755 testcases/kernel/power_management/change_freq.sh
 delete mode 100755 testcases/kernel/power_management/change_govr.sh
 delete mode 100755 testcases/kernel/power_management/check_cpufreq_sysfs_files.sh
 delete mode 100755 testcases/kernel/power_management/check_cpuidle_sysfs_files.sh
 delete mode 100755 testcases/kernel/power_management/pwkm_load_unload.sh
 delete mode 100755 testcases/kernel/power_management/test_sched_mc.sh
 delete mode 100755 testcases/kernel/power_management/test_sched_smt.sh
 delete mode 100755 testcases/kernel/power_management/test_timer_migration.sh

diff --git a/testcases/kernel/power_management/change_freq.sh b/testcases/kernel/power_management/change_freq.sh
deleted file mode 100755
index 3a971d2..0000000
--- a/testcases/kernel/power_management/change_freq.sh
+++ /dev/null
@@ -1,36 +0,0 @@
-#!/bin/bash
-
-. pm_include.sh
-available_freq=$(get_supporting_freq)
-available_govr=$(get_supporting_govr)
-RC=0
-
-total_cpus=$(tst_ncpus)
-(( total_cpus-=1 ))
-
-if ( echo ${available_govr} | grep -i "userspace" 2>&1 >/dev/null ) ; then
-	for cpu in $(seq 0 "${total_cpus}" )
-	do
-		echo userspace > /sys/devices/system/cpu/cpu${cpu}/cpufreq/scaling_governor
-		if [ $? -ne 0 ] ; then
-			RC=1
-		fi
-	done
-	if [ ${RC} -ne 1 ] ; then
-		for cpu in $(seq 0 "${total_cpus}" )
-		do
-			for freq in ${available_freq}
-			do
-				echo ${freq} > /sys/devices/system/cpu/cpu${cpu}/cpufreq/scaling_setspeed
-				if [ "$?" -ne "0" ] ; then
-					echo "${0}: FAIL: Unable to set frequency -- ${freq} for cpu${cpu}"
-					RC=1
-				fi
-			done
-		done
-	fi
-fi
-if [ ${RC} -eq 0 ] ; then
-	echo "${0}: PASS: Changing cpu frequencies"
-fi
-exit $RC
diff --git a/testcases/kernel/power_management/change_govr.sh b/testcases/kernel/power_management/change_govr.sh
deleted file mode 100755
index bfe6c5b..0000000
--- a/testcases/kernel/power_management/change_govr.sh
+++ /dev/null
@@ -1,24 +0,0 @@
-#!/bin/bash
-
-. pm_include.sh
-available_govr=$(get_supporting_govr)
-
-total_cpus=$(tst_ncpus)
-(( total_cpus-=1 ))
-RC=0
-
-for cpu in $(seq 0 "${total_cpus}" )
-do
-	for govr in ${available_govr}
-	do
-		echo ${govr} > /sys/devices/system/cpu/cpu${cpu}/cpufreq/scaling_governor
-		if [ "$?" -ne "0" ] ; then
-			echo "${0}: FAIL: Unable to set governor -- ${govr} for cpu${cpu}"
-			RC=1
-		fi
-	done
-done
-if [ ${RC} -eq 0 ] ; then
-	echo "${0}: PASS: Changing cpu governors"
-fi
-exit $RC
diff --git a/testcases/kernel/power_management/check_cpufreq_sysfs_files.sh b/testcases/kernel/power_management/check_cpufreq_sysfs_files.sh
deleted file mode 100755
index dcf8a1d..0000000
--- a/testcases/kernel/power_management/check_cpufreq_sysfs_files.sh
+++ /dev/null
@@ -1,24 +0,0 @@
-#!/bin/bash
-
-. pm_include.sh
-
-total_cpus=$(tst_ncpus)
-(( total_cpus-=1 ))
-RC=0
-
-for cpu in $(seq 0 "${total_cpus}" )
-do
-	cpufiles=$(find /sys/devices/system/cpu/cpu"${cpu}"/cpufreq/ -name "*" -type f)
-	for files in ${cpufiles}
-	do
-		cat ${files} 2>&1 >/dev/null
-		if [ $? -ne 0 ] ; then
-			echo "${0}: FAIL: cat ${files}"
-			RC=1
-		fi
-	done
-done
-if [ ${RC} -eq 0 ] ; then
-	echo "${0}: PASS: Checking cpu freq sysfs files"
-fi
-exit $RC
diff --git a/testcases/kernel/power_management/check_cpuidle_sysfs_files.sh b/testcases/kernel/power_management/check_cpuidle_sysfs_files.sh
deleted file mode 100755
index 4ed4d5b..0000000
--- a/testcases/kernel/power_management/check_cpuidle_sysfs_files.sh
+++ /dev/null
@@ -1,19 +0,0 @@
-#!/bin/bash
-
-RC=0
-if [ -d /sys/devices/system/cpu/cpuidle ] ; then
-	for files in current_governor_ro current_driver
-	do
-		cat /sys/devices/system/cpu/cpuidle/${files} >/dev/null 2>&1
-		if [ $? -ne 0 ] ; then
-			echo "${0}: FAIL: cat ${files}"
-			RC=1
-		fi
-	done
-fi
-if [ ${RC} -eq 0 ] ; then
-	echo "${0}: PASS: Checking cpu idle sysfs files"
-else
-	echo "${0}: FAIL: Checking cpu idle sysfs files"
-fi
-exit $RC
diff --git a/testcases/kernel/power_management/pwkm_load_unload.sh b/testcases/kernel/power_management/pwkm_load_unload.sh
deleted file mode 100755
index 9bcbd56..0000000
--- a/testcases/kernel/power_management/pwkm_load_unload.sh
+++ /dev/null
@@ -1,30 +0,0 @@
-#!/bin/bash
-
-#Loading modules
-RC=0
-loaded_governor=`cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor`
-for module in `modprobe -l | grep cpufreq_ | cut -f8 -d"/" | cut -f1 -d"."`
-do
-	#echo -n "Loading $module ... "
-    if [ $module != "cpufreq_$loaded_governor" ];
-    then
-		modprobe $module >/dev/null
-		if [ $? -ne 0 ] ; then
-			echo "${0}: FAIL: Loading of module $module or check whether you compiled as module or not"
-			RC=1
-		fi
-	fi
-done
-for module in `modprobe -l | grep cpufreq_ | cut -f8 -d"/" | cut -f1 -d"."`
-do
-	#echo -n "Unloading $module ... "
-    if [ $module != "cpufreq_$loaded_governor" ];
-    then
-		modprobe -r $module >/dev/null
-		if [ $? -ne 0 ] ; then
-			echo "${0}: FAIL: Loading of module $module or check whether you compiled as module or not"
-			RC=1
-		fi
-	fi
-done
-exit $RC
diff --git a/testcases/kernel/power_management/runpwtests01.sh b/testcases/kernel/power_management/runpwtests01.sh
index 7dc164c..d470d11 100755
--- a/testcases/kernel/power_management/runpwtests01.sh
+++ b/testcases/kernel/power_management/runpwtests01.sh
@@ -24,6 +24,28 @@ export TST_TOTAL=1
 . test.sh
 . pm_include.sh
 
+test_sched_mc() {
+	get_kernel_version
+	get_valid_input $kernel_version
+
+	invalid_input="3 4 5 6 7 8 a abcefg x1999 xffff -1 -00000
+	2000000000000000000000000000000000000000000000000000000000000000000
+	ox324 -0xfffffffffffffffffffff"
+	test_file="/sys/devices/system/cpu/sched_mc_power_savings"
+	if [ ! -f ${test_file} ] ; then
+		tst_brkm TBROK "MISSING_FILE: missing file ${test_file}"
+	fi
+
+	RC=0
+	echo "${0}: ---Valid test cases---"
+	check_input "${valid_input}" valid $test_file
+	RC=$?
+	echo "${0}: ---Invalid test cases---"
+	check_input "${invalid_input}" invalid $test_file
+	RC=$(( RC | $? ))
+	return $RC
+}
+
 # Checking test environment
 check_kervel_arch
 
@@ -40,7 +62,7 @@ else
 	fi
 fi
 
-if test_sched_mc.sh ; then
+if test_sched_mc ; then
 	tst_resm TPASS "SCHED_MC sysfs tests"
 else
 	tst_resm TFAIL "SCHED_MC sysfs tests"
diff --git a/testcases/kernel/power_management/runpwtests02.sh b/testcases/kernel/power_management/runpwtests02.sh
index 067569e..8c7936f 100755
--- a/testcases/kernel/power_management/runpwtests02.sh
+++ b/testcases/kernel/power_management/runpwtests02.sh
@@ -24,6 +24,27 @@ export TST_TOTAL=1
 . test.sh
 . pm_include.sh
 
+test_sched_smt() {
+	get_kernel_version
+	get_valid_input $kernel_version
+
+	invalid_input="3 4 5 6 7 8 a abcefg x1999 xffff -1 -00000
+	2000000000000000000000000000000000000000000000000000000000000000000000
+	ox324 -0xfffffffffffffffffffff"
+	test_file="/sys/devices/system/cpu/sched_smt_power_savings"
+	if [ ! -f ${test_file} ] ; then
+		tst_brkm TBROK "MISSING_FILE: missing file ${test_file}"
+	fi
+
+	echo "${0}: ---Valid test cases---"
+	check_input "${valid_input}" valid $test_file
+	RC=$?
+	echo "${0}: ---Invalid test cases---"
+	check_input "${invalid_input}" invalid $test_file
+	RC=$(( RC | $? ))
+	return $RC
+}
+
 # Checking test environment
 check_kervel_arch
 
@@ -38,7 +59,7 @@ else
 	fi
 fi
 
-if test_sched_smt.sh ; then
+if test_sched_smt ; then
 	tst_resm TPASS "SCHED_SMT sysfs test"
 else
 	tst_resm TFAIL "SCHED_SMT sysfs test"
diff --git a/testcases/kernel/power_management/runpwtests03.sh b/testcases/kernel/power_management/runpwtests03.sh
index 34fb1a4..7e9ac4b 100755
--- a/testcases/kernel/power_management/runpwtests03.sh
+++ b/testcases/kernel/power_management/runpwtests03.sh
@@ -24,6 +24,129 @@ export TST_TOTAL=4
 . test.sh
 . pm_include.sh
 
+check_cpufreq_sysfs_files() {
+	total_cpus=$(tst_ncpus)
+	(( total_cpus-=1 ))
+	RC=0
+
+	for cpu in $(seq 0 "${total_cpus}" )
+	do
+		cpufiles=$(find /sys/devices/system/cpu/cpu"${cpu}"/cpufreq/ \
+			-name "*" -type f)
+		for files in ${cpufiles}
+		do
+			cat ${files} 2>&1 >/dev/null
+			if [ $? -ne 0 ] ; then
+				echo "${0}: FAIL: cat ${files}"
+				RC=1
+			fi
+		done
+	done
+	if [ ${RC} -eq 0 ] ; then
+		echo "${0}: PASS: Checking cpu freq sysfs files"
+	fi
+	return $RC
+}
+
+change_govr() {
+	available_govr=$(get_supporting_govr)
+
+	total_cpus=$(tst_ncpus)
+	(( total_cpus-=1 ))
+	RC=0
+
+	for cpu in $(seq 0 "${total_cpus}" )
+	do
+		for govr in ${available_govr}
+		do
+			echo ${govr} > \
+	/sys/devices/system/cpu/cpu${cpu}/cpufreq/scaling_governor
+			if [ "$?" -ne "0" ] ; then
+				echo "${0}: FAIL: Unable to set" \
+					"governor -- ${govr} for cpu${cpu}"
+				RC=1
+			fi
+		done
+	done
+	if [ ${RC} -eq 0 ] ; then
+		echo "${0}: PASS: Changing cpu governors"
+	fi
+	return $RC
+}
+
+change_freq() {
+	available_freq=$(get_supporting_freq)
+	available_govr=$(get_supporting_govr)
+	RC=0
+
+	total_cpus=$(tst_ncpus)
+	(( total_cpus-=1 ))
+
+	if ( echo ${available_govr} | grep -i "userspace" \
+		2>&1 >/dev/null ); then
+		for cpu in $(seq 0 "${total_cpus}" )
+		do
+			echo userspace > \
+	/sys/devices/system/cpu/cpu${cpu}/cpufreq/scaling_governor
+			if [ $? -ne 0 ] ; then
+				RC=1
+			fi
+		done
+		if [ ${RC} -ne 1 ] ; then
+			for cpu in $(seq 0 "${total_cpus}" )
+			do
+				for freq in ${available_freq}
+				do
+					echo ${freq} > \
+	/sys/devices/system/cpu/cpu${cpu}/cpufreq/scaling_setspeed
+					if [ "$?" -ne "0" ] ; then
+						echo "${0}: FAIL: Unable" \
+							"to set frequency -- ${freq} for cpu${cpu}"
+						RC=1
+					fi
+				done
+			done
+		fi
+	fi
+	if [ ${RC} -eq 0 ] ; then
+		echo "${0}: PASS: Changing cpu frequencies"
+	fi
+	return $RC
+}
+
+pwkm_load_unload() {
+	RC=0
+	loaded_governor=`cat \
+		/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor`
+	for module in `modprobe -l | grep cpufreq_ | \
+		cut -f8 -d"/" | cut -f1 -d"."`
+	do
+		#echo -n "Loading $module ... "
+		if [ $module != "cpufreq_$loaded_governor" ]; then
+			modprobe $module >/dev/null
+			if [ $? -ne 0 ] ; then
+				echo "${0}: FAIL: Loading of module $module" \
+					"or check whether you compiled as module or not"
+				RC=1
+			fi
+		fi
+	done
+	for module in `modprobe -l | grep cpufreq_ | \
+		cut -f8 -d"/" | cut -f1 -d"."`
+		do
+		#echo -n "Unloading $module ... "
+		if [ $module != "cpufreq_$loaded_governor" ]; then
+			modprobe -r $module >/dev/null
+			if [ $? -ne 0 ] ; then
+				echo "${0}: FAIL: Loading of module $module" \
+					"or check whether you compiled as module or not"
+				RC=1
+			fi
+		fi
+	done
+	return $RC
+}
+
 # Checking test environment
 check_kervel_arch
 
@@ -32,28 +155,28 @@ if [ ! -d /sys/devices/system/cpu/cpu0/cpufreq ] ; then
 	tst_brkm TCONF "Required kernel configuration for CPU_FREQ NOT set"
 fi
 
-if check_cpufreq_sysfs_files.sh ; then
+if check_cpufreq_sysfs_files ; then
 	tst_resm TPASS "CPUFREQ sysfs tests"
 else
 	tst_resm TFAIL "CPUFREQ sysfs tests"
 fi
 
 # Changing governors
-if change_govr.sh ; then
+if change_govr ; then
 	tst_resm TPASS "Changing governors"
 else
 	tst_resm TFAIL "Changing governors"
 fi
 
 # Changing frequencies
-if change_freq.sh ; then
+if change_freq ; then
 	tst_resm TPASS "Changing frequncies"
 else
     tst_resm TFAIL "Changing frequncies"
 fi
 
 # Loading and Unloading governor related kernel modules
-if pwkm_load_unload.sh ; then
+if pwkm_load_unload ; then
 	tst_resm TPASS "Loading and Unloading of governor kernel" \
 		"modules"
 else
diff --git a/testcases/kernel/power_management/runpwtests04.sh b/testcases/kernel/power_management/runpwtests04.sh
index eeb4b22..4b727a5 100755
--- a/testcases/kernel/power_management/runpwtests04.sh
+++ b/testcases/kernel/power_management/runpwtests04.sh
@@ -24,11 +24,32 @@ export TST_TOTAL=1
 . test.sh
 . pm_include.sh
 
+check_cpuidle_sysfs_files() {
+	RC=0
+	if [ -d /sys/devices/system/cpu/cpuidle ] ; then
+		for files in current_governor_ro current_driver
+		do
+			cat /sys/devices/system/cpu/cpuidle/${files} \
+				>/dev/null 2>&1
+			if [ $? -ne 0 ] ; then
+				echo "${0}: FAIL: cat ${files}"
+				RC=1
+			fi
+		done
+	fi
+	if [ ${RC} -eq 0 ] ; then
+		echo "${0}: PASS: Checking cpu idle sysfs files"
+	else
+		echo "${0}: FAIL: Checking cpu idle sysfs files"
+	fi
+	return $RC
+}
+
 # Checking test environment
 check_kervel_arch
 
 # Checking cpuidle sysfs interface files
-if check_cpuidle_sysfs_files.sh ; then
+if check_cpuidle_sysfs_files ; then
 	tst_resm TPASS "CPUIDLE sysfs tests passed"
 else
     tst_resm TFAIL "CPUIDLE sysfs tests failed"
diff --git a/testcases/kernel/power_management/runpwtests06.sh b/testcases/kernel/power_management/runpwtests06.sh
index ab5d7de..7888a39 100755
--- a/testcases/kernel/power_management/runpwtests06.sh
+++ b/testcases/kernel/power_management/runpwtests06.sh
@@ -24,6 +24,26 @@ export TST_TOTAL=1
 . test.sh
 . pm_include.sh
 
+test_timer_migration() {
+	valid_input="0 1"
+	invalid_input="3 4 5 6 7 8 a abcefg x1999 xffff -1 -00000
+	2000000000000000000000000000000000000000000000000000000000000000000000
+	ox324 -0xfffffffffffffffffffff"
+	test_file="/proc/sys/kernel/timer_migration"
+	if [ ! -f ${test_file} ] ; then
+		tst_brkm TBROK "MISSING_FILE: missing file ${test_file}"
+	fi
+
+	RC=0
+	echo "${0}: ---Valid test cases---"
+	check_input "${valid_input}" valid $test_file
+	RC=$?
+	echo "${0}: ---Invalid test cases---"
+	check_input "${invalid_input}" invalid $test_file
+	RC=$(( RC | $? ))
+	return $RC
+}
+
 # Checking test environment
 check_kervel_arch
 
@@ -42,7 +62,7 @@ else
 	fi
 fi
 
-if test_timer_migration.sh; then
+if test_timer_migration ; then
 	tst_resm TPASS "Timer Migration interface test"
 else
 	tst_resm TFAIL "Timer migration interface test"
diff --git a/testcases/kernel/power_management/test_sched_mc.sh b/testcases/kernel/power_management/test_sched_mc.sh
deleted file mode 100755
index c695798..0000000
--- a/testcases/kernel/power_management/test_sched_mc.sh
+++ /dev/null
@@ -1,24 +0,0 @@
-#!/bin/bash
-
-. pm_include.sh
-
-get_kernel_version
-get_valid_input $kernel_version
-
-invalid_input="3 4 5 6 7 8 a abcefg x1999 xffff -1 -00000
-200000000000000000000000000000000000000000000000000000000000000000000000000000
-ox324 -0xfffffffffffffffffffff"
-test_file="/sys/devices/system/cpu/sched_mc_power_savings"
-if [ ! -f ${test_file} ] ; then
-	echo "MISSING_FILE: missing file ${test_file}"
-	exit $MISSING_FILE
-fi
-
-RC=0
-echo "${0}: ---Valid test cases---"
-check_input "${valid_input}" valid $test_file
-RC=$?
-echo "${0}: ---Invalid test cases---"
-check_input "${invalid_input}" invalid $test_file
-RC=$(( RC | $? ))
-exit $RC
diff --git a/testcases/kernel/power_management/test_sched_smt.sh b/testcases/kernel/power_management/test_sched_smt.sh
deleted file mode 100755
index 6cde834..0000000
--- a/testcases/kernel/power_management/test_sched_smt.sh
+++ /dev/null
@@ -1,23 +0,0 @@
-#!/bin/bash
-
-. pm_include.sh
-
-get_kernel_version
-get_valid_input $kernel_version
-
-invalid_input="3 4 5 6 7 8 a abcefg x1999 xffff -1 -00000
-200000000000000000000000000000000000000000000000000000000000000000000000000000
-ox324 -0xfffffffffffffffffffff"
-test_file="/sys/devices/system/cpu/sched_smt_power_savings"
-if [ ! -f ${test_file} ] ; then
-       echo "MISSING_FILE: missing file ${test_file}"
-       exit $MISSING_FILE
-fi
-
-echo "${0}: ---Valid test cases---"
-check_input "${valid_input}" valid $test_file
-RC=$?
-echo "${0}: ---Invalid test cases---"
-check_input "${invalid_input}" invalid $test_file
-RC=$(( RC | $? ))
-exit $RC
diff --git a/testcases/kernel/power_management/test_timer_migration.sh b/testcases/kernel/power_management/test_timer_migration.sh
deleted file mode 100755
index e2d3296..0000000
--- a/testcases/kernel/power_management/test_timer_migration.sh
+++ /dev/null
@@ -1,22 +0,0 @@
-#!/bin/bash
-
-. pm_include.sh
-
-valid_input="0 1"
-invalid_input="3 4 5 6 7 8 a abcefg x1999 xffff -1 -00000
-200000000000000000000000000000000000000000000000000000000000000000000000000000
-ox324 -0xfffffffffffffffffffff"
-test_file="/proc/sys/kernel/timer_migration"
-if [ ! -f ${test_file} ] ; then
-	echo "MISSING_FILE: missing file ${test_file}"
-	exit $MISSING_FILE
-fi
-
-RC=0
-echo "${0}: ---Valid test cases---"
-check_input "${valid_input}" valid $test_file
-RC=$?
-echo "${0}: ---Invalid test cases---"
-check_input "${invalid_input}" invalid $test_file
-RC=$(( RC | $? ))
-exit $RC
-- 
1.9.3


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
