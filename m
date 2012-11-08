Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Jin.Li@windriver.com>) id 1TWMVe-0004N8-3c
	for ltp-list@lists.sourceforge.net; Thu, 08 Nov 2012 07:26:42 +0000
Received: from mail1.windriver.com ([147.11.146.13])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1TWMVc-0001Hv-24
	for ltp-list@lists.sourceforge.net; Thu, 08 Nov 2012 07:26:42 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id qA87QYpn004708
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Wed, 7 Nov 2012 23:26:34 -0800 (PST)
From: <jin.li@windriver.com>
Date: Thu, 8 Nov 2012 15:26:22 +0800
Message-ID: <1352359582-7832-2-git-send-email-jin.li@windriver.com>
In-Reply-To: <1352359582-7832-1-git-send-email-jin.li@windriver.com>
References: <1352359582-7832-1-git-send-email-jin.li@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] Clean up cpuhotplug test cases
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
To: jin.li@windriver.com, ltp-list@lists.sourceforge.net

From: Jin Li <jin.li@windriver.com>

1. split cpuhotplug test to seven cases
2. change scenario group file cpuhotplug

Signed-off-by: Jin Li <jin.li@windriver.com>
---
 runtest/cpuhotplug                                 |   8 +-
 .../hotplug/cpu_hotplug/functional/cpuhotplug01.sh | 194 +++++++++++++++++++++
 .../hotplug/cpu_hotplug/functional/cpuhotplug02.sh |  81 +++++++++
 .../hotplug/cpu_hotplug/functional/cpuhotplug03.sh | 117 +++++++++++++
 .../hotplug/cpu_hotplug/functional/cpuhotplug04.sh |  71 ++++++++
 .../hotplug/cpu_hotplug/functional/cpuhotplug05.sh |  93 ++++++++++
 .../hotplug/cpu_hotplug/functional/cpuhotplug06.sh |  78 +++++++++
 .../hotplug/cpu_hotplug/functional/cpuhotplug07.sh |  88 ++++++++++
 .../hotplug/cpu_hotplug/functional/hotplug01.sh    | 194 ---------------------
 .../hotplug/cpu_hotplug/functional/hotplug02.sh    |  81 ---------
 .../hotplug/cpu_hotplug/functional/hotplug03.sh    | 117 -------------
 .../hotplug/cpu_hotplug/functional/hotplug04.sh    |  71 --------
 .../cpu_hotplug/functional/hotplug06.sar.sh        |  93 ----------
 .../hotplug/cpu_hotplug/functional/hotplug06.sh    |  33 ----
 .../cpu_hotplug/functional/hotplug06.top.sh        |  78 ---------
 .../hotplug/cpu_hotplug/functional/hotplug07.sh    |  88 ----------
 testcases/kernel/hotplug/cpu_hotplug/runtests.sh   |  16 --
 17 files changed, 729 insertions(+), 772 deletions(-)
 create mode 100755 testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
 create mode 100755 testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh
 create mode 100755 testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
 create mode 100755 testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
 create mode 100755 testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
 create mode 100755 testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
 create mode 100755 testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh
 delete mode 100755 testcases/kernel/hotplug/cpu_hotplug/functional/hotplug01.sh
 delete mode 100755 testcases/kernel/hotplug/cpu_hotplug/functional/hotplug02.sh
 delete mode 100755 testcases/kernel/hotplug/cpu_hotplug/functional/hotplug03.sh
 delete mode 100755 testcases/kernel/hotplug/cpu_hotplug/functional/hotplug04.sh
 delete mode 100755 testcases/kernel/hotplug/cpu_hotplug/functional/hotplug06.sar.sh
 delete mode 100755 testcases/kernel/hotplug/cpu_hotplug/functional/hotplug06.sh
 delete mode 100755 testcases/kernel/hotplug/cpu_hotplug/functional/hotplug06.top.sh
 delete mode 100755 testcases/kernel/hotplug/cpu_hotplug/functional/hotplug07.sh
 delete mode 100755 testcases/kernel/hotplug/cpu_hotplug/runtests.sh

diff --git a/runtest/cpuhotplug b/runtest/cpuhotplug
index af7dde5..274e9bf 100644
--- a/runtest/cpuhotplug
+++ b/runtest/cpuhotplug
@@ -1,3 +1,9 @@
 ## Run the CPUHOTPLUG tests here
 
-CPUHOTPLUG $LTPROOT/testcases/bin/cpu_hotplug/runtests.sh
+cpuhotplug01 export CPU_TO_TEST=1; $LTPROOT/testcases/bin/cpu_hotplug/functional/cpuhotplug01.sh
+cpuhotplug02 export CPU_TO_TEST=1; $LTPROOT/testcases/bin/cpu_hotplug/functional/cpuhotplug02.sh
+cpuhotplug03 export CPU_TO_TEST=1; $LTPROOT/testcases/bin/cpu_hotplug/functional/cpuhotplug03.sh
+cpuhotplug04 export CPU_TO_TEST=1; $LTPROOT/testcases/bin/cpu_hotplug/functional/cpuhotplug04.sh
+cpuhotplug05 export CPU_TO_TEST=1; $LTPROOT/testcases/bin/cpu_hotplug/functional/cpuhotplug05.sh
+cpuhotplug06 export CPU_TO_TEST=1; $LTPROOT/testcases/bin/cpu_hotplug/functional/cpuhotplug06.sh
+cpuhotplug07 export CPU_TO_TEST=1; $LTPROOT/testcases/bin/cpu_hotplug/functional/cpuhotplug07.sh
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
new file mode 100755
index 0000000..acf7df1
--- /dev/null
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
@@ -0,0 +1,194 @@
+#!/bin/sh
+#
+# Test Case 1
+#
+# Based on script by Ashok Raj <ashok.raj@intel.com>
+# Modified by Mark D and Bryce, Aug '05.
+
+HOTPLUG01_LOOPS=${HOTPLUG01_LOOPS:-${LOOPS}}
+export TCID="cpuhotplug01"
+export TST_COUNT=1
+export TST_TOTAL=${HOTPLUG01_LOOPS:-1}
+
+CPU_TO_TEST=${CPU_TO_TEST:-1}
+if [ -z "${CPU_TO_TEST}" ]; then
+	echo "usage: ${0##*/} <CPU to online>"
+	exit 1
+fi
+
+# Includes:
+LHCS_PATH=${LHCS_PATH:-$LTPROOT/testcases/bin/cpu_hotplug}
+. $LHCS_PATH/include/testsuite.fns
+. $LHCS_PATH/include/hotplug.fns
+
+cat <<EOF
+Name:   $TCID
+Date:   `date`
+Desc:   What happens to disk controller interrupts when offlining CPUs?
+
+EOF
+
+# Time delay after an online of cpu
+TM_ONLINE=${HOTPLUG01_TM_ONLINE:-1}
+
+# Time delay after offline of cpu
+TM_OFFLINE=${HOTPLUG01_TM_OFFLINE:-1}
+
+# Time delay before start of entire new cycle.
+TM_DLY=${HOTPLUG01_TM_DLY:-6}
+
+if ! type -P perl > /dev/null; then
+	tst_brk TCONF "analysis script - report_proc_interrupts - requires perl"
+	exit 1
+fi
+
+if ! get_all_cpus >/dev/null 2>&1; then
+	tst_brkm TCONF "system doesn't have required CPU hotplug support"
+	exit 1
+fi
+
+# Validate the specified CPU exists
+if ! cpu_is_valid "${CPU_TO_TEST}" ; then
+	tst_resm TFAIL "cpu${CPU_TO_TEST} not found"
+	exit 1
+fi
+
+CPU_COUNT=0
+cpustate=1
+
+if ! cpu_is_online "${CPU_TO_TEST}" ; then
+	if ! online_cpu ${CPU_TO_TEST} ; then
+		tst_resm TFAIL "Could not online cpu $CPU_TO_TEST"
+		exit_clean 1
+	fi
+	cpustate=0
+fi
+
+# do_clean()
+#
+#  Callback to be executed when script exits from a user interrupt
+#  or regular program termination
+#
+do_clean()
+{
+	kill_pid ${WRL_ID}
+
+	# Turns off the cpus that were off before the test start
+	tst_resm TINFO "Return to previous state. CPU count = ${CPU_COUNT}"
+	until [ $CPU_COUNT -eq 0 ]; do
+		offline_cpu=$(eval "echo \$OFFLINE_CPU_${CPU_COUNT}")
+		tst_resm TINFO "CPU = $CPU_COUNT @on = $offline_cpu"
+		offline_cpu $offline_cpu
+		: $(( CPU_COUNT -= 1 ))
+	done
+	if [ "x${cpustate}" = x1 ]; then
+		online_cpu ${CPU_TO_TEST}
+	else
+		offline_cpu ${CPU_TO_TEST}
+	fi
+}
+
+
+# do_offline(CPU)
+#
+#  Migrates some irq's onto the CPU, then offlines it
+#
+do_offline()
+{
+	CPU=${1#cpu}
+	# Migrate some irq's this way first.
+	IRQS=`get_all_irqs`
+	migrate_irq ${CPU} ${IRQS}
+	offline_cpu ${CPU}
+	if [ $? -ne 0 ]; then
+		if [ "$CPU" -ne 0 ]; then
+			: $(( CPU_COUNT += 1 ))
+			eval "OFFLINE_CPU_${CPU_COUNT}=$1"
+		fi
+		return 1
+	fi
+	return 0
+}
+
+
+# do_online(CPU)
+#
+#  Onlines the CPU and then sets the smp_affinity of all IRQs to
+#  this CPU.
+#
+do_online()
+{
+	CPU=${1#cpu}
+	online_cpu ${CPU}
+	if [ $? -ne 0 ]; then
+		return 1
+	fi
+	migrate_irq ${CPU}
+	if [ $? -ne 0 ]; then
+		return 1
+	fi
+}
+
+# Start up a process that writes to disk; keep track of its PID
+$LHCS_PATH/tools/do_disk_write_loop > /dev/null 2>&1 &
+WRL_ID=$!
+
+RC=0
+until [ $TST_COUNT -gt $TST_TOTAL -o $RC -ne 0 ]
+do
+
+	tst_resm TINFO "Starting loop"
+	IRQ_START=$(cat /proc/interrupts)
+
+	# Attempt to offline all CPUs
+	for cpu in $( get_all_cpus ); do
+		if [ "$cpu" = "cpu0" ]; then
+			continue
+		fi
+		do_offline $cpu
+		err=$?
+		if [ $err -ne 0 ]; then
+			tst_resm TBROK "offlining $cpu failed: $err"
+			RC=2
+		else
+			tst_resm TINFO "offlining $cpu was ok"
+		fi
+		sleep $TM_OFFLINE
+	done
+
+	#IRQ_MID=`cat /proc/interrupts`
+
+	# Attempt to online all CPUs
+	for cpu in $( get_all_cpus ); do
+		if [ "$cpu" = "cpu0" ]; then
+			continue
+		fi
+		do_online $cpu
+		err=$?
+		if [ $err -ne 0 ]; then
+			tst_resm TBROK "onlining $cpu failed: $err"
+			RC=2
+		else
+			tst_resm TINFO "onlining $cpu was ok"
+		fi
+		sleep $TM_ONLINE
+	done
+
+	IRQ_END=`cat /proc/interrupts`
+
+	# Print out a report showing the changes in IRQs
+	echo
+	echo
+	$LHCS_PATH/tools/report_proc_interrupts "$IRQ_START" "$IRQ_END"
+	echo
+
+	if [ $RC -eq 0 ] ; then
+
+		sleep $TM_DLY
+		: $(( TST_COUNT += 1 ))
+
+	fi
+
+done
+
+exit_clean $RC
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh
new file mode 100755
index 0000000..3f9400b
--- /dev/null
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh
@@ -0,0 +1,81 @@
+#!/bin/sh
+#
+# Test Case 2
+#
+
+HOTPLUG02_LOOPS=${HOTPLUG02_LOOPS:-${LOOPS}}
+export TCID="cpuhotplug02"
+export TST_COUNT=1
+export TST_TOTAL=${HOTPLUG02_LOOPS:-1}
+
+CPU_TO_TEST=${CPU_TO_TEST:-1}
+if [ -z "$CPU_TO_TEST" ]; then
+	echo "usage: ${0##*} <CPU to online>"
+	exit 1
+fi
+
+# Includes:
+LHCS_PATH=${LHCS_PATH:-$LTPROOT/testcases/bin/cpu_hotplug}
+. $LHCS_PATH/include/testsuite.fns
+. $LHCS_PATH/include/hotplug.fns
+
+cat <<EOF
+Name:   $TCID
+Date:   `date`
+Desc:   What happens to a process when its CPU is offlined?
+
+EOF
+
+# Start up a process that just uses CPU cycles
+$LHCS_PATH/tools/do_spin_loop > /dev/null&
+SPIN_LOOP_PID=$!
+
+# Validate the specified CPU exists
+if ! cpu_is_valid "${CPU_TO_TEST}" ; then
+	tst_resm TBROK "cpu${CPU_TO_TEST} not found"
+	exit_clean 1
+fi
+
+# do_clean()
+#
+#  Callback to be executed when script exits from a user interrupt
+#  or regular program termination.
+#
+do_clean()
+{
+	kill_pid ${SPIN_LOOP_PID}
+}
+
+# Validate the specified CPU is online; if not, online it
+if ! cpu_is_online "${CPU_TO_TEST}" ; then
+	if ! online_cpu ${CPU_TO_TEST}; then
+		tst_resm TBROK "CPU${CPU_TO_TEST} cannot be onlined"
+		exit_clean 1
+	fi
+fi
+
+sleep 5
+until [ $TST_COUNT -gt $TST_TOTAL ]; do
+	# Move spin_loop.sh to the CPU to offline.
+	set_affinity ${SPIN_LOOP_PID} ${CPU_TO_TEST}
+
+	# Verify the process migrated to the CPU we intended it to go to
+	offline_cpu ${CPU_TO_TEST}
+	NEW_CPU=`ps --pid=${SPIN_LOOP_PID} -o psr --no-headers`
+	if [ -z "${NEW_CPU}" ]; then
+		tst_resm TBROK "PID ${SPIN_LOOP_PID} no longer running"
+		exit_clean 1
+	elif [ ${CPU_TO_TEST} = ${NEW_CPU} ]; then
+		tst_resm TFAIL "process did not change from CPU ${NEW_CPU}"
+		exit_clean 1
+	fi
+	tst_resm TPASS "turned off CPU ${CPU_TO_TEST}, process migrated to CPU ${NEW_CPU}"
+
+	# Turn the CPU back online just to see what happens.
+	online_cpu ${CPU_TO_TEST}
+	: $(( TST_COUNT += 1 ))
+done
+
+sleep 2
+
+exit_clean
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
new file mode 100755
index 0000000..ca636d1
--- /dev/null
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
@@ -0,0 +1,117 @@
+#!/bin/sh
+#
+# Test Case 3
+#
+
+HOTPLUG03_LOOPS=${HOTPLUG03_LOOPS:-${LOOPS}}
+export TST_COUNT=1
+export TST_TOTAL=${HOTPLUG03_LOOPS:-1}
+export TCID="cpuhotplug03"
+
+CPU_TO_TEST=${CPU_TO_TEST:-1}
+if [ -z $CPU_TO_TEST ]; then
+	echo "usage: ${0##*} <CPU to online>"
+	exit 1
+fi
+
+# Includes:
+LHCS_PATH=${LHCS_PATH:-${LTPROOT:+$LTPROOT/testcases/bin/cpu_hotplug}}
+. $LHCS_PATH/include/testsuite.fns
+. $LHCS_PATH/include/hotplug.fns
+
+cat <<EOF
+Name:   $TCID
+Date:   `date`
+Desc:   Do tasks get scheduled to a newly on-lined CPU?
+
+EOF
+
+# Verify the specified CPU exists
+if ! cpu_is_valid "${CPU_TO_TEST}" ; then
+	tst_resm TCONF "CPU${CPU_TO_TEST} not found"
+	exit_clean 1
+fi
+
+# do_clean()
+#
+#  Callback to be executed when script exits from a user interrupt
+#  or regular program termination
+#
+do_clean()
+{
+	# Kill all the processes we started up and get rid of their pid files
+	if [ -e "/var/run/hotplug4_$$.pid" ]; then
+		for i in `cat /var/run/hotplug4_$$.pid`; do
+			kill_pid $i
+		done
+		rm /var/run/hotplug4_$$.pid
+	fi
+
+	# Turn off the CPUs that were off before the test start
+	until [ $cpu -eq 0 ];do
+		offline_cpu $(eval "echo \$on_${cpu}")
+		: $(( cpu -= 1 ))
+	done
+}
+
+until [ $TST_COUNT -gt $TST_TOTAL ]; do
+	cpu=0
+	number_of_cpus=0
+
+	# Turns on all CPUs and saves their states
+	for i in $( get_all_cpus ); do
+		if ! online_cpu $1; then
+			: $(( cpu += 1 ))
+			eval "on_${cpu}=$i"
+		fi
+		: $(( number_of_cpus += 1 ))
+	done
+
+	if ! offline_cpu ${CPU_TO_TEST} ; then
+		tst_resm TBAIL "CPU${CPU_TO_TEST} cannot be offlined"
+		exit_clean 1
+	fi
+
+	# Start up a number of processes equal to twice the number of
+	# CPUs we have.  This is to help ensure we've got enough processes
+	# that at least one will migrate to the new CPU.  Store the PIDs
+	# so we can kill them later.
+	: $(( number_of_cpus *= 2 ))
+	until [ $number_of_cpus -eq 0 ]; do
+		$LHCS_PATH/tools/do_spin_loop > /dev/null 2>&1 &
+		echo $! >> /var/run/hotplug4_$$.pid
+		: $(( number_of_cpus -= 1 ))
+	done
+
+	ps aux | head -n 1
+	ps aux | grep do_spin_loop
+
+	# Online the CPU
+	tst_resm TINFO "Onlining CPU ${CPU_TO_TEST}"
+	online_cpu ${CPU_TO_TEST}
+	RC=$?
+	if [ $RC -eq 0 ]; then
+		tst_resm TFAIL "CPU${CPU_TO_TEST} cannot be onlined"
+		exit_clean 1
+	fi
+
+	sleep 1
+
+	# Verify at least one process has migrated to the new CPU
+	ps -o psr -o command --no-headers -C do_spin_loop
+	RC=$?
+	NUM=`ps -o psr -o command --no-headers -C do_spin_loop | sed -e "s/^ *//" | cut -d' ' -f 1 | grep "^${CPU_TO_TEST}$" | wc -l`
+	if [ $RC -eq 0 ]; then
+		tst_resm TBROK "No do_spin_loop processes found on any processor"
+	elif [ $NUM -lt 1 ]; then
+		tst_resm TFAIL "No do_spin_loop processes found on CPU${CPU_TO_TEST}"
+	else
+		tst_resm TPASS "$NUM do_spin_loop processes found on CPU${CPU_TO_TEST}"
+	fi
+
+	do_clean
+
+	: $(( TST_COUNT +=1 ))
+done
+
+exit_clean
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
new file mode 100755
index 0000000..3e84354
--- /dev/null
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
@@ -0,0 +1,71 @@
+#!/bin/sh
+#
+# Test Case 4
+#
+
+HOTPLUG04_LOOPS=${HOTPLUG04_LOOPS:-${LOOPS}}
+export TCID="cpuhotplug04"
+export TST_COUNT=1
+export TST_TOTAL=${HOTPLUG04_LOOPS:-1}
+
+# Includes:
+LHCS_PATH=${LHCS_PATH:-${LTPROOT:+$LTPROOT/testcases/bin/cpu_hotplug}}
+. $LHCS_PATH/include/testsuite.fns
+. $LHCS_PATH/include/hotplug.fns
+
+cat <<EOF
+Name:   $TCID
+Date:   `date`
+Desc:   Does it prevent us from offlining the last CPU?
+
+EOF
+
+cpu=0
+until [ $TST_COUNT -gt $TST_TOTAL ]; do
+	cpustate=1
+
+	# Online all the CPUs' keep track of which were already on
+	for i in $(get_all_cpus); do
+		online_cpu $i
+		RC=$?
+		if [ $RC -ne 0 ]; then
+			: $(( cpu += 1 ))
+			eval "on_${cpu}=$i"
+			echo $i
+		fi
+		if [ $RC -eq 0 -a "$i" = "cpu0" ]; then
+			cpustate=0
+		fi
+	done
+
+	# Now offline all the CPUs
+	for i in $(get_all_cpus); do
+		offline_cpu $i
+		RC=$?
+		if [ $RC -eq 1 ]; then
+			if [ "x$i" != "xcpu0" ]; then
+				tst_resm TFAIL "Did not offline first CPU (offlined $i instead)"
+			else
+				tst_resm TPASS "Successfully offlined first CPU, $i"
+			fi
+		fi
+	done
+
+	# Online the ones that were on initially
+	until [ $cpu -eq 0 ]; do
+		online_cpu $(eval "echo \$on_${cpu}")
+		: $(( cpu -= 1 ))
+	done
+
+	# Return CPU 0 to its initial state
+	if [ $cpustate = 1 ]; then
+		online_cpu 0
+	else
+		offline_cpu 0
+	fi
+
+	: $(( TST_COUNT += 1 ))
+
+done
+
+exit_clean
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
new file mode 100755
index 0000000..ad57efe
--- /dev/null
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
@@ -0,0 +1,93 @@
+#!/bin/sh
+#
+# Test Case 6 - sar
+#
+
+TST_TOTAL=${HOTPLUG06_LOOPS:-${LOOPS}}
+export TCID="cpuhotplug05"
+export TMP=${TMP:=/tmp}
+export TST_COUNT=1
+export TST_TOTAL=${HOTPLUG06_LOOPS:-1}
+
+CPU_TO_TEST=${CPU_TO_TEST:-1}
+if [ -z "$CPU_TO_TEST" ]; then
+	echo "usage: ${0##*} <CPU to offline>"
+	exit 1
+fi
+
+# Includes:
+LHCS_PATH=${LHCS_PATH:-${LTPROOT:+$LTPROOT/testcases/bin/cpu_hotplug}}
+. $LHCS_PATH/include/testsuite.fns
+. $LHCS_PATH/include/hotplug.fns
+
+cat <<EOF
+Name:   $TCID
+Date:   `date`
+Desc:   Does sar behave properly during CPU hotplug events?
+
+EOF
+
+# Verify the specified CPU is available
+if ! cpu_is_valid "${CPU_TO_TEST}" ; then
+	tst_resm TBROK"CPU${CPU_TO_TEST} not found"
+	exit_clean 1
+fi
+
+# Check that the specified CPU is offline; if not, offline it
+if cpu_is_online "${CPU_TO_TEST}" ; then
+	if ! offline_cpu ${CPU_TO_TEST} ; then
+		tst_resm TBROK "CPU${CPU_TO_TEST} cannot be offlined"
+		exit_clean 1
+	fi
+fi
+
+do_clean()
+{
+	kill_pid ${SAR_PID}
+}
+
+until [ $TST_COUNT -gt $TST_TOTAL ]; do
+	# Start up SAR and give it a couple cycles to run
+	sar -P ALL 1 0 > $TMP/log_$$ &
+	sleep 2
+	SAR_PID=$!
+
+	# Verify that SAR has correctly listed the missing CPU as 'nan'
+	while ! grep -iq nan $TMP/log_$$; do
+		tst_resm TFAIL "CPU${CPU_TO_TEST} Not Found on SAR!"
+		exit_clean 1
+	done
+	time=`date +%X`
+	sleep .5
+
+	# Verify that at least some of the CPUs are offline
+	NUMBER_CPU_OFF=$(grep "$time" $TMP/log_$$ | grep -i nan | wc -l)
+	if [ ${NUMBER_CPU_OFF} -eq 0 ]; then
+		tst_resm TBROK "no CPUs found offline"
+		exit_clean 1
+	fi
+
+	# Online the CPU
+	if ! online_cpu ${CPU_TO_TEST}; then
+		tst_resm TFAIL "CPU${CPU_TO_TEST} cannot be onlined line"
+		exit_clean 1
+	fi
+
+	sleep 1
+	time=$(date +%T)
+	sleep .5
+
+	# Check that SAR registered the change in CPU online/offline states
+	NEW_NUMBER_CPU_OFF=$(grep "$time" $TMP/log_$$ | grep -i nan | wc -l)
+	: $(( NUMBER_CPU_OFF -= 1 ))
+	if [ "$NUMBER_CPU_OFF" = "$NEW_NUMBER_CPU_OFF" ]; then
+		tst_resm TPASS "CPU was found after turned on."
+	else
+		tst_resm TFAIL "no change in number of offline CPUs was found."
+	fi
+
+	: $(( TST_COUNT += 1 ))
+
+done
+
+exit_clean
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
new file mode 100755
index 0000000..0778fa0
--- /dev/null
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
@@ -0,0 +1,78 @@
+#!/bin/sh
+#
+# Test Case 6 - top
+#
+
+TST_TOTAL=${HOTPLUG06_LOOPS:-${LOOPS}}
+export TCID="cpuhotplug06"
+export TST_COUNT=1
+export TST_TOTAL=${HOTPLUG06_LOOPS:-1}
+
+CPU_TO_TEST=${CPU_TO_TEST:-1}
+if [ -z "$CPU_TO_TEST" ]; then
+	echo "Usage: ${0##*/} <CPU to offline>"
+	exit_clean 1
+fi
+
+# Includes:
+LHCS_PATH=${LHCS_PATH:-${LTPROOT:+$LTPROOT/testcases/bin/cpu_hotplug}}
+. $LHCS_PATH/include/testsuite.fns
+. $LHCS_PATH/include/hotplug.fns
+
+cat <<EOF
+Name:   $TCID
+Date:   `date`
+Desc:   Does top work properly when CPU hotplug events occur?
+
+EOF
+
+# Verify that the specified CPU is available
+if ! cpu_is_valid "${CPU_TO_TEST}" ; then
+	tst_resm TBROK "CPU${CPU_TO_TEST} not found"
+	exit_clean 1
+fi
+
+# Check that the specified CPU is online; if not, online it
+if ! cpu_is_online "${CPU_TO_TEST}" ; then
+	if ! online_cpu ${CPU_TO_TEST}; then
+		tst_resm TFAIL "CPU${CPU_TO_TEST} cannot be onlined"
+		exit_clean 1
+	fi
+fi
+
+do_clean()
+{
+	pid_is_valid ${TOP_PID} && kill_pid ${TOP_PID}
+	online_cpu ${CPU_TO_TEST}
+}
+
+until [ $TST_COUNT -gt $TST_TOTAL ]; do
+	# Start up top and give it a little time to run
+	top -b -d 00.10 > /dev/null 2>&1 &
+	TOP_PID=$!
+	sleep 1
+
+	# Now offline the CPU
+	if ! offline_cpu ${CPU_TO_TEST} ; then
+		tst_resm TBROK "CPU${CPU_TO_TEST} cannot be onlined"
+		exit_clean 1
+	fi
+
+	# Wait a little time for top to notice the CPU is gone
+	sleep 1
+
+	# Check that top hasn't crashed
+	if pid_is_valid ${TOP_PID} ; then
+		tst_resm TPASS "PID ${TOP_PID} still running."
+		online_cpu ${CPU_TO_TEST}
+		kill_pid ${TOP_PID}
+	else
+		tst_resm TFAIL "PID ${TOP_PID} no longer running"
+		exit_clean 1
+	fi
+
+	: $(( TST_COUNT += 1 ))
+
+done
+
+exit_clean
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh
new file mode 100755
index 0000000..cd45677
--- /dev/null
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh
@@ -0,0 +1,88 @@
+#!/bin/sh
+#
+# Test Case 7
+#
+# Runs continuous offline/online of CPUs along with
+# a kernel compilation load.
+
+TST_TOTAL=${HOTPLUG07_LOOPS:-${LOOPS}}
+export TCID="cpuhotplug07"
+export TST_COUNT=1
+export TST_TOTAL=${HOTPLUG07_LOOPS:-1}
+
+# Includes:
+LHCS_PATH=${LHCS_PATH:-${LTPROOT:+$LTPROOT/testcases/bin/cpu_hotplug}}
+. $LHCS_PATH/include/testsuite.fns
+. $LHCS_PATH/include/hotplug.fns
+
+cat <<EOF
+Name:   $TCID
+Date:   `date`
+Desc:   What happens when hotplugging during a heavy workload?
+Issue:  Hotplug bugs have been found during kernel compiles
+
+EOF
+
+CPU_TO_TEST=${CPU_TO_TEST:-1}
+KERNEL_DIR=${2:-/usr/src/linux}
+if [ -z "${CPU_TO_TEST}" ]; then
+	echo "usage: ${0##*/} <CPU to offline> <Kernel source code directory>"
+	exit_clean 1
+fi
+if [ ! -d "${KERNEL_DIR}" ]; then
+	tst_resm TCONF "kernel directory - $KERNEL_DIR - does not exist"
+	exit_clean 1
+fi
+
+do_clean()
+{
+	kill_pid ${KCOMPILE_LOOP_PID}
+}
+
+$LHCS_PATH/tools/do_kcompile_loop $KERNEL_DIR > /dev/null 2>&1 &
+KCOMPILE_LOOP_PID=$!
+
+tst_resm TINFO "initial CPU affinity for kernel compile is: $(get_affinity_mask ${KCOMPILE_LOOP_PID})"
+
+if ! cpu_is_online ${CPU_TO_TEST}; then
+	if ! online_cpu ${CPU_TO_TEST}; then
+		tst_resm TBROK "CPU${CPU_TO_TEST} cannot be onlined"
+		exit_clean 1
+	fi
+fi
+
+sleep 2
+
+until [ $TST_COUNT -gt $TST_TOTAL ]; do
+
+	tst_resm TINFO "Starting loop"
+
+	# Move spin_loop.sh to the CPU to offline.
+	set_affinity ${KCOMPILE_LOOP_PID} ${CPU_TO_TEST}
+
+	offline_cpu ${CPU_TO_TEST}
+	RC=$?
+	echo "Offlining cpu${CPU_TO_TEST}: Return Code = ${RC}"
+
+	NEW_CPU=`ps --pid=${KCOMPILE_LOOP_PID} -o psr --no-headers`
+	if [ -z "${NEW_CPU}" ]; then
+		tst_resm TBROK "PID ${KCOMPILE_LOOP_PID} no longer running"
+		exit_clean 1
+	elif [ "${CPU_TO_TEST}" = "${NEW_CPU}" ]; then
+		tst_resm TFAIL "process did not change from CPU ${NEW_CPU}"
+	else
+		tst_resm TPASS "turned off CPU ${CPU_TO_TEST}, process migrated to CPU ${NEW_CPU}"
+	fi
+
+	online_cpu ${CPU_TO_TEST}
+	RC=$?
+
+	tst_resm TINFO "Onlining cpu${CPU_TO_TEST}: Return Code = ${RC}"
+
+	: $(( TST_COUNT += 1 ))
+
+done
+
+sleep 2
+
+exit_clean
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug01.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug01.sh
deleted file mode 100755
index 3c3cced..0000000
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug01.sh
+++ /dev/null
@@ -1,194 +0,0 @@
-#!/bin/sh
-#
-# Test Case 1
-#
-# Based on script by Ashok Raj <ashok.raj@intel.com>
-# Modified by Mark D and Bryce, Aug '05.
-
-HOTPLUG01_LOOPS=${HOTPLUG01_LOOPS:-${LOOPS}}
-export TCID="hotplug01"
-export TST_COUNT=1
-export TST_TOTAL=${HOTPLUG01_LOOPS:-1}
-
-CPU_TO_TEST=${1#cpu}
-if [ -z "${CPU_TO_TEST}" ]; then
-	echo "usage: ${0##*/} <CPU to online>"
-	exit 1
-fi
-
-# Includes:
-LHCS_PATH=${LHCS_PATH:-$LTPROOT/testcases/bin/cpu_hotplug}
-. $LHCS_PATH/include/testsuite.fns
-. $LHCS_PATH/include/hotplug.fns
-
-cat <<EOF
-Name:   $TCID
-Date:   `date`
-Desc:   What happens to disk controller interrupts when offlining CPUs?
-
-EOF
-
-# Time delay after an online of cpu
-TM_ONLINE=${HOTPLUG01_TM_ONLINE:-1}
-
-# Time delay after offline of cpu
-TM_OFFLINE=${HOTPLUG01_TM_OFFLINE:-1}
-
-# Time delay before start of entire new cycle.
-TM_DLY=${HOTPLUG01_TM_DLY:-6}
-
-if ! type -P perl > /dev/null; then
-	tst_brk TCONF "analysis script - report_proc_interrupts - requires perl"
-	exit 1
-fi
-
-if ! get_all_cpus >/dev/null 2>&1; then
-	tst_brkm TCONF "system doesn't have required CPU hotplug support"
-	exit 1
-fi
-
-# Validate the specified CPU exists
-if ! cpu_is_valid "${CPU_TO_TEST}" ; then
-	tst_resm TFAIL "cpu${CPU_TO_TEST} not found"
-	exit 1
-fi
-
-CPU_COUNT=0
-cpustate=1
-
-if ! cpu_is_online "${CPU_TO_TEST}" ; then
-	if ! online_cpu ${CPU_TO_TEST} ; then
-		tst_resm TFAIL "Could not online cpu $CPU_TO_TEST"
-		exit_clean 1
-	fi
-	cpustate=0
-fi
-
-# do_clean()
-#
-#  Callback to be executed when script exits from a user interrupt
-#  or regular program termination
-#
-do_clean()
-{
-	kill_pid ${WRL_ID}
-
-	# Turns off the cpus that were off before the test start
-	tst_resm TINFO "Return to previous state. CPU count = ${CPU_COUNT}"
-	until [ $CPU_COUNT -eq 0 ]; do
-		offline_cpu=$(eval "echo \$OFFLINE_CPU_${CPU_COUNT}")
-		tst_resm TINFO "CPU = $CPU_COUNT @on = $offline_cpu"
-		offline_cpu $offline_cpu
-		: $(( CPU_COUNT -= 1 ))
-	done
-	if [ "x${cpustate}" = x1 ]; then
-		online_cpu ${CPU_TO_TEST}
-	else
-		offline_cpu ${CPU_TO_TEST}
-	fi
-}
-
-
-# do_offline(CPU)
-#
-#  Migrates some irq's onto the CPU, then offlines it
-#
-do_offline()
-{
-	CPU=${1#cpu}
-	# Migrate some irq's this way first.
-	IRQS=`get_all_irqs`
-	migrate_irq ${CPU} ${IRQS}
-	offline_cpu ${CPU}
-	if [ $? -ne 0 ]; then
-		if [ "$CPU" -ne 0 ]; then
-			: $(( CPU_COUNT += 1 ))
-			eval "OFFLINE_CPU_${CPU_COUNT}=$1"
-		fi
-		return 1
-	fi
-	return 0
-}
-
-
-# do_online(CPU)
-#
-#  Onlines the CPU and then sets the smp_affinity of all IRQs to
-#  this CPU.
-#
-do_online()
-{
-	CPU=${1#cpu}
-	online_cpu ${CPU}
-	if [ $? -ne 0 ]; then
-		return 1
-	fi
-	migrate_irq ${CPU}
-	if [ $? -ne 0 ]; then
-		return 1
-	fi
-}
-
-# Start up a process that writes to disk; keep track of its PID
-$LHCS_PATH/tools/do_disk_write_loop > /dev/null 2>&1 &
-WRL_ID=$!
-
-RC=0
-until [ $TST_COUNT -gt $TST_TOTAL -o $RC -ne 0 ]
-do
-
-	tst_resm TINFO "Starting loop"
-	IRQ_START=$(cat /proc/interrupts)
-
-	# Attempt to offline all CPUs
-	for cpu in $( get_all_cpus ); do
-		if [ "$cpu" = "cpu0" ]; then
-			continue
-		fi
-		do_offline $cpu
-		err=$?
-		if [ $err -ne 0 ]; then
-			tst_resm TBROK "offlining $cpu failed: $err"
-			RC=2
-		else
-			tst_resm TINFO "offlining $cpu was ok"
-		fi
-		sleep $TM_OFFLINE
-	done
-
-	#IRQ_MID=`cat /proc/interrupts`
-
-	# Attempt to online all CPUs
-	for cpu in $( get_all_cpus ); do
-		if [ "$cpu" = "cpu0" ]; then
-			continue
-		fi
-		do_online $cpu
-		err=$?
-		if [ $err -ne 0 ]; then
-			tst_resm TBROK "onlining $cpu failed: $err"
-			RC=2
-		else
-			tst_resm TINFO "onlining $cpu was ok"
-		fi
-		sleep $TM_ONLINE
-	done
-
-	IRQ_END=`cat /proc/interrupts`
-
-	# Print out a report showing the changes in IRQs
-	echo
-	echo
-	$LHCS_PATH/tools/report_proc_interrupts "$IRQ_START" "$IRQ_END"
-	echo
-
-	if [ $RC -eq 0 ] ; then
-
-		sleep $TM_DLY
-		: $(( TST_COUNT += 1 ))
-
-	fi
-
-done
-
-exit_clean $RC
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug02.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug02.sh
deleted file mode 100755
index f636117..0000000
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug02.sh
+++ /dev/null
@@ -1,81 +0,0 @@
-#!/bin/sh
-#
-# Test Case 2
-#
-
-HOTPLUG02_LOOPS=${HOTPLUG02_LOOPS:-${LOOPS}}
-export TCID="hotplug02"
-export TST_COUNT=1
-export TST_TOTAL=${HOTPLUG02_LOOPS:-1}
-
-CPU_TO_TEST=$1
-if [ -z "$CPU_TO_TEST" ]; then
-	echo "usage: ${0##*} <CPU to online>"
-	exit 1
-fi
-
-# Includes:
-LHCS_PATH=${LHCS_PATH:-$LTPROOT/testcases/bin/cpu_hotplug}
-. $LHCS_PATH/include/testsuite.fns
-. $LHCS_PATH/include/hotplug.fns
-
-cat <<EOF
-Name:   $TCID
-Date:   `date`
-Desc:   What happens to a process when its CPU is offlined?
-
-EOF
-
-# Start up a process that just uses CPU cycles
-$LHCS_PATH/tools/do_spin_loop > /dev/null&
-SPIN_LOOP_PID=$!
-
-# Validate the specified CPU exists
-if ! cpu_is_valid "${CPU_TO_TEST}" ; then
-	tst_resm TBROK "cpu${CPU_TO_TEST} not found"
-	exit_clean 1
-fi
-
-# do_clean()
-#
-#  Callback to be executed when script exits from a user interrupt
-#  or regular program termination.
-#
-do_clean()
-{
-	kill_pid ${SPIN_LOOP_PID}
-}
-
-# Validate the specified CPU is online; if not, online it
-if ! cpu_is_online "${CPU_TO_TEST}" ; then
-	if ! online_cpu ${CPU_TO_TEST}; then
-		tst_resm TBROK "CPU${CPU_TO_TEST} cannot be onlined"
-		exit_clean 1
-	fi
-fi
-
-sleep 5
-until [ $TST_COUNT -gt $TST_TOTAL ]; do
-	# Move spin_loop.sh to the CPU to offline.
-	set_affinity ${SPIN_LOOP_PID} ${CPU_TO_TEST}
-
-	# Verify the process migrated to the CPU we intended it to go to
-	offline_cpu ${CPU_TO_TEST}
-	NEW_CPU=`ps --pid=${SPIN_LOOP_PID} -o psr --no-headers`
-	if [ -z "${NEW_CPU}" ]; then
-		tst_resm TBROK "PID ${SPIN_LOOP_PID} no longer running"
-		exit_clean 1
-	elif [ ${CPU_TO_TEST} = ${NEW_CPU} ]; then
-		tst_resm TFAIL "process did not change from CPU ${NEW_CPU}"
-		exit_clean 1
-	fi
-	tst_resm TPASS "turned off CPU ${CPU_TO_TEST}, process migrated to CPU ${NEW_CPU}"
-
-	# Turn the CPU back online just to see what happens.
-	online_cpu ${CPU_TO_TEST}
-	: $(( TST_COUNT += 1 ))
-done
-
-sleep 2
-
-exit_clean
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug03.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug03.sh
deleted file mode 100755
index 6923756..0000000
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug03.sh
+++ /dev/null
@@ -1,117 +0,0 @@
-#!/bin/sh
-#
-# Test Case 3
-#
-
-HOTPLUG03_LOOPS=${HOTPLUG03_LOOPS:-${LOOPS}}
-export TST_COUNT=1
-export TST_TOTAL=${HOTPLUG03_LOOPS:-1}
-export TCID="hotplug03"
-
-CPU_TO_TEST=${1#cpu}
-if [ -z $CPU_TO_TEST ]; then
-	echo "usage: ${0##*} <CPU to online>"
-	exit 1
-fi
-
-# Includes:
-LHCS_PATH=${LHCS_PATH:-${LTPROOT:+$LTPROOT/testcases/bin/cpu_hotplug}}
-. $LHCS_PATH/include/testsuite.fns
-. $LHCS_PATH/include/hotplug.fns
-
-cat <<EOF
-Name:   $TCID
-Date:   `date`
-Desc:   Do tasks get scheduled to a newly on-lined CPU?
-
-EOF
-
-# Verify the specified CPU exists
-if ! cpu_is_valid "${CPU_TO_TEST}" ; then
-	tst_resm TCONF "CPU${CPU_TO_TEST} not found"
-	exit_clean 1
-fi
-
-# do_clean()
-#
-#  Callback to be executed when script exits from a user interrupt
-#  or regular program termination
-#
-do_clean()
-{
-	# Kill all the processes we started up and get rid of their pid files
-	if [ -e "/var/run/hotplug4_$$.pid" ]; then
-		for i in `cat /var/run/hotplug4_$$.pid`; do
-			kill_pid $i
-		done
-		rm /var/run/hotplug4_$$.pid
-	fi
-
-	# Turn off the CPUs that were off before the test start
-	until [ $cpu -eq 0 ];do
-		offline_cpu $(eval "echo \$on_${cpu}")
-		: $(( cpu -= 1 ))
-	done
-}
-
-until [ $TST_COUNT -gt $TST_TOTAL ]; do
-	cpu=0
-	number_of_cpus=0
-
-	# Turns on all CPUs and saves their states
-	for i in $( get_all_cpus ); do
-		if ! online_cpu $1; then
-			: $(( cpu += 1 ))
-			eval "on_${cpu}=$i"
-		fi
-		: $(( number_of_cpus += 1 ))
-	done
-
-	if ! offline_cpu ${CPU_TO_TEST} ; then
-		tst_resm TBAIL "CPU${CPU_TO_TEST} cannot be offlined"
-		exit_clean 1
-	fi
-
-	# Start up a number of processes equal to twice the number of
-	# CPUs we have.  This is to help ensure we've got enough processes
-	# that at least one will migrate to the new CPU.  Store the PIDs
-	# so we can kill them later.
-	: $(( number_of_cpus *= 2 ))
-	until [ $number_of_cpus -eq 0 ]; do
-		$LHCS_PATH/tools/do_spin_loop > /dev/null 2>&1 &
-		echo $! >> /var/run/hotplug4_$$.pid
-		: $(( number_of_cpus -= 1 ))
-	done
-
-	ps aux | head -n 1
-	ps aux | grep do_spin_loop
-
-	# Online the CPU
-	tst_resm TINFO "Onlining CPU ${CPU_TO_TEST}"
-	online_cpu ${CPU_TO_TEST}
-	RC=$?
-	if [ $RC -eq 0 ]; then
-		tst_resm TFAIL "CPU${CPU_TO_TEST} cannot be onlined"
-		exit_clean 1
-	fi
-
-	sleep 1
-
-	# Verify at least one process has migrated to the new CPU
-	ps -o psr -o command --no-headers -C do_spin_loop
-	RC=$?
-	NUM=`ps -o psr -o command --no-headers -C do_spin_loop | sed -e "s/^ *//" | cut -d' ' -f 1 | grep "^${CPU_TO_TEST}$" | wc -l`
-	if [ $RC -eq 0 ]; then
-		tst_resm TBROK "No do_spin_loop processes found on any processor"
-	elif [ $NUM -lt 1 ]; then
-		tst_resm TFAIL "No do_spin_loop processes found on CPU${CPU_TO_TEST}"
-	else
-		tst_resm TPASS "$NUM do_spin_loop processes found on CPU${CPU_TO_TEST}"
-	fi
-
-	do_clean
-
-	: $(( TST_COUNT +=1 ))
-done
-
-exit_clean
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug04.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug04.sh
deleted file mode 100755
index 8dce89d..0000000
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug04.sh
+++ /dev/null
@@ -1,71 +0,0 @@
-#!/bin/sh
-#
-# Test Case 4
-#
-
-HOTPLUG04_LOOPS=${HOTPLUG04_LOOPS:-${LOOPS}}
-export TCID="hotplug04"
-export TST_COUNT=1
-export TST_TOTAL=${HOTPLUG04_LOOPS:-1}
-
-# Includes:
-LHCS_PATH=${LHCS_PATH:-${LTPROOT:+$LTPROOT/testcases/bin/cpu_hotplug}}
-. $LHCS_PATH/include/testsuite.fns
-. $LHCS_PATH/include/hotplug.fns
-
-cat <<EOF
-Name:   $TCID
-Date:   `date`
-Desc:   Does it prevent us from offlining the last CPU?
-
-EOF
-
-cpu=0
-until [ $TST_COUNT -gt $TST_TOTAL ]; do
-	cpustate=1
-
-	# Online all the CPUs' keep track of which were already on
-	for i in $(get_all_cpus); do
-		online_cpu $i
-		RC=$?
-		if [ $RC -ne 0 ]; then
-			: $(( cpu += 1 ))
-			eval "on_${cpu}=$i"
-			echo $i
-		fi
-		if [ $RC -eq 0 -a "$i" = "cpu0" ]; then
-			cpustate=0
-		fi
-	done
-
-	# Now offline all the CPUs
-	for i in $(get_all_cpus); do
-		offline_cpu $i
-		RC=$?
-		if [ $RC -eq 1 ]; then
-			if [ "x$i" != "xcpu0" ]; then
-				tst_resm TFAIL "Did not offline first CPU (offlined $i instead)"
-			else
-				tst_resm TPASS "Successfully offlined first CPU, $i"
-			fi
-		fi
-	done
-
-	# Online the ones that were on initially
-	until [ $cpu -eq 0 ]; do
-		online_cpu $(eval "echo \$on_${cpu}")
-		: $(( cpu -= 1 ))
-	done
-
-	# Return CPU 0 to its initial state
-	if [ $cpustate = 1 ]; then
-		online_cpu 0
-	else
-		offline_cpu 0
-	fi
-
-	: $(( TST_COUNT += 1 ))
-
-done
-
-exit_clean
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug06.sar.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug06.sar.sh
deleted file mode 100755
index 745b4ae..0000000
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug06.sar.sh
+++ /dev/null
@@ -1,93 +0,0 @@
-#!/bin/sh
-#
-# Test Case 6 - sar
-#
-
-TST_TOTAL=${HOTPLUG06_LOOPS:-${LOOPS}}
-export TCID="hotplug06.sar"
-export TMP=${TMP:=/tmp}
-export TST_COUNT=1
-export TST_TOTAL=${HOTPLUG06_LOOPS:-1}
-
-CPU_TO_TEST=$1
-if [ -z "$CPU_TO_TEST" ]; then
-	echo "usage: ${0##*} <CPU to offline>"
-	exit 1
-fi
-
-# Includes:
-LHCS_PATH=${LHCS_PATH:-${LTPROOT:+$LTPROOT/testcases/bin/cpu_hotplug}}
-. $LHCS_PATH/include/testsuite.fns
-. $LHCS_PATH/include/hotplug.fns
-
-cat <<EOF
-Name:   $TCID
-Date:   `date`
-Desc:   Does sar behave properly during CPU hotplug events?
-
-EOF
-
-# Verify the specified CPU is available
-if ! cpu_is_valid "${CPU_TO_TEST}" ; then
-	tst_resm TBROK"CPU${CPU_TO_TEST} not found"
-	exit_clean 1
-fi
-
-# Check that the specified CPU is offline; if not, offline it
-if cpu_is_online "${CPU_TO_TEST}" ; then
-	if ! offline_cpu ${CPU_TO_TEST} ; then
-		tst_resm TBROK "CPU${CPU_TO_TEST} cannot be offlined"
-		exit_clean 1
-	fi
-fi
-
-do_clean()
-{
-	kill_pid ${SAR_PID}
-}
-
-until [ $TST_COUNT -gt $TST_TOTAL ]; do
-	# Start up SAR and give it a couple cycles to run
-	sar -P ALL 1 0 > $TMP/log_$$ &
-	sleep 2
-	SAR_PID=$!
-
-	# Verify that SAR has correctly listed the missing CPU as 'nan'
-	while ! grep -iq nan $TMP/log_$$; do
-		tst_resm TFAIL "CPU${CPU_TO_TEST} Not Found on SAR!"
-		exit_clean 1
-	done
-	time=`date +%X`
-	sleep .5
-
-	# Verify that at least some of the CPUs are offline
-	NUMBER_CPU_OFF=$(grep "$time" $TMP/log_$$ | grep -i nan | wc -l)
-	if [ ${NUMBER_CPU_OFF} -eq 0 ]; then
-		tst_resm TBROK "no CPUs found offline"
-		exit_clean 1
-	fi
-
-	# Online the CPU
-	if ! online_cpu ${CPU_TO_TEST}; then
-		tst_resm TFAIL "CPU${CPU_TO_TEST} cannot be onlined line"
-		exit_clean 1
-	fi
-
-	sleep 1
-	time=$(date +%T)
-	sleep .5
-
-	# Check that SAR registered the change in CPU online/offline states
-	NEW_NUMBER_CPU_OFF=$(grep "$time" $TMP/log_$$ | grep -i nan | wc -l)
-	: $(( NUMBER_CPU_OFF -= 1 ))
-	if [ "$NUMBER_CPU_OFF" = "$NEW_NUMBER_CPU_OFF" ]; then
-		tst_resm TPASS "CPU was found after turned on."
-	else
-		tst_resm TFAIL "no change in number of offline CPUs was found."
-	fi
-
-	: $(( TST_COUNT += 1 ))
-
-done
-
-exit_clean
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug06.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug06.sh
deleted file mode 100755
index b0c79e0..0000000
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug06.sh
+++ /dev/null
@@ -1,33 +0,0 @@
-#!/bin/sh
-#
-# Test Case 6
-#
-
-CPU_TO_TEST=${1#cpu}
-TCID=hotplug06
-
-if [ -z "$CPU_TO_TEST" ]; then
-	echo "usage: ${0##*/} <CPU to offline>"
-	exit 1
-fi
-
-# Includes:
-LHCS_PATH=${LHCS_PATH:-${LTPROOT:+$LTPROOT/testcases/bin/cpu_hotplug}}
-. $LHCS_PATH/include/testsuite.fns
-. $LHCS_PATH/include/hotplug.fns
-
-cat <<EOF
-Name:   $TCID
-Date:   `date`
-Desc:   Verify user tools can handle adding and removing CPUs.
-
-EOF
-
-$LHCS_PATH/functional/hotplug06.top.sh ${CPU_TO_TEST}
-
-echo
-echo
-
-$LHCS_PATH/functional/hotplug06.sar.sh ${CPU_TO_TEST}
-
-echo
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug06.top.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug06.top.sh
deleted file mode 100755
index 16c88c6..0000000
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug06.top.sh
+++ /dev/null
@@ -1,78 +0,0 @@
-#!/bin/sh
-#
-# Test Case 6 - top
-#
-
-TST_TOTAL=${HOTPLUG06_LOOPS:-${LOOPS}}
-export TCID="hotplug06.top"
-export TST_COUNT=1
-export TST_TOTAL=${HOTPLUG06_LOOPS:-1}
-
-CPU_TO_TEST=$1
-if [ -z "$CPU_TO_TEST" ]; then
-	echo "Usage: ${0##*/} <CPU to offline>"
-	exit_clean 1
-fi
-
-# Includes:
-LHCS_PATH=${LHCS_PATH:-${LTPROOT:+$LTPROOT/testcases/bin/cpu_hotplug}}
-. $LHCS_PATH/include/testsuite.fns
-. $LHCS_PATH/include/hotplug.fns
-
-cat <<EOF
-Name:   $TCID
-Date:   `date`
-Desc:   Does top work properly when CPU hotplug events occur?
-
-EOF
-
-# Verify that the specified CPU is available
-if ! cpu_is_valid "${CPU_TO_TEST}" ; then
-	tst_resm TBROK "CPU${CPU_TO_TEST} not found"
-	exit_clean 1
-fi
-
-# Check that the specified CPU is online; if not, online it
-if ! cpu_is_online "${CPU_TO_TEST}" ; then
-	if ! online_cpu ${CPU_TO_TEST}; then
-		tst_resm TFAIL "CPU${CPU_TO_TEST} cannot be onlined"
-		exit_clean 1
-	fi
-fi
-
-do_clean()
-{
-	pid_is_valid ${TOP_PID} && kill_pid ${TOP_PID}
-	online_cpu ${CPU_TO_TEST}
-}
-
-until [ $TST_COUNT -gt $TST_TOTAL ]; do
-	# Start up top and give it a little time to run
-	top -b -d 00.10 > /dev/null 2>&1 &
-	TOP_PID=$!
-	sleep 1
-
-	# Now offline the CPU
-	if ! offline_cpu ${CPU_TO_TEST} ; then
-		tst_resm TBROK "CPU${CPU_TO_TEST} cannot be onlined"
-		exit_clean 1
-	fi
-
-	# Wait a little time for top to notice the CPU is gone
-	sleep 1
-
-	# Check that top hasn't crashed
-	if pid_is_valid ${TOP_PID} ; then
-		tst_resm TPASS "PID ${TOP_PID} still running."
-		online_cpu ${CPU_TO_TEST}
-		kill_pid ${TOP_PID}
-	else
-		tst_resm TFAIL "PID ${TOP_PID} no longer running"
-		exit_clean 1
-	fi
-
-	: $(( TST_COUNT += 1 ))
-
-done
-
-exit_clean
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug07.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug07.sh
deleted file mode 100755
index 3ae1ccb..0000000
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug07.sh
+++ /dev/null
@@ -1,88 +0,0 @@
-#!/bin/sh
-#
-# Test Case 7
-#
-# Runs continuous offline/online of CPUs along with
-# a kernel compilation load.
-
-TST_TOTAL=${HOTPLUG07_LOOPS:-${LOOPS}}
-export TCID="hotplug07"
-export TST_COUNT=1
-export TST_TOTAL=${HOTPLUG07_LOOPS:-1}
-
-# Includes:
-LHCS_PATH=${LHCS_PATH:-${LTPROOT:+$LTPROOT/testcases/bin/cpu_hotplug}}
-. $LHCS_PATH/include/testsuite.fns
-. $LHCS_PATH/include/hotplug.fns
-
-cat <<EOF
-Name:   $TCID
-Date:   `date`
-Desc:   What happens when hotplugging during a heavy workload?
-Issue:  Hotplug bugs have been found during kernel compiles
-
-EOF
-
-CPU_TO_TEST=${1#cpu}
-KERNEL_DIR=${2:-/usr/src/linux}
-if [ -z "${CPU_TO_TEST}" ]; then
-	echo "usage: ${0##*/} <CPU to offline> <Kernel source code directory>"
-	exit_clean 1
-fi
-if [ ! -d "${KERNEL_DIR}" ]; then
-	tst_resm TCONF "kernel directory - $KERNEL_DIR - does not exist"
-	exit_clean 1
-fi
-
-do_clean()
-{
-	kill_pid ${KCOMPILE_LOOP_PID}
-}
-
-$LHCS_PATH/tools/do_kcompile_loop $KERNEL_DIR > /dev/null 2>&1 &
-KCOMPILE_LOOP_PID=$!
-
-tst_resm TINFO "initial CPU affinity for kernel compile is: $(get_affinity_mask ${KCOMPILE_LOOP_PID})"
-
-if ! cpu_is_online ${CPU_TO_TEST}; then
-	if ! online_cpu ${CPU_TO_TEST}; then
-		tst_resm TBROK "CPU${CPU_TO_TEST} cannot be onlined"
-		exit_clean 1
-	fi
-fi
-
-sleep 2
-
-until [ $TST_COUNT -gt $TST_TOTAL ]; do
-
-	tst_resm TINFO "Starting loop"
-
-	# Move spin_loop.sh to the CPU to offline.
-	set_affinity ${KCOMPILE_LOOP_PID} ${CPU_TO_TEST}
-
-	offline_cpu ${CPU_TO_TEST}
-	RC=$?
-	echo "Offlining cpu${CPU_TO_TEST}: Return Code = ${RC}"
-
-	NEW_CPU=`ps --pid=${KCOMPILE_LOOP_PID} -o psr --no-headers`
-	if [ -z "${NEW_CPU}" ]; then
-		tst_resm TBROK "PID ${KCOMPILE_LOOP_PID} no longer running"
-		exit_clean 1
-	elif [ "${CPU_TO_TEST}" = "${NEW_CPU}" ]; then
-		tst_resm TFAIL "process did not change from CPU ${NEW_CPU}"
-	else
-		tst_resm TPASS "turned off CPU ${CPU_TO_TEST}, process migrated to CPU ${NEW_CPU}"
-	fi
-
-	online_cpu ${CPU_TO_TEST}
-	RC=$?
-
-	tst_resm TINFO "Onlining cpu${CPU_TO_TEST}: Return Code = ${RC}"
-
-	: $(( TST_COUNT += 1 ))
-
-done
-
-sleep 2
-
-exit_clean
diff --git a/testcases/kernel/hotplug/cpu_hotplug/runtests.sh b/testcases/kernel/hotplug/cpu_hotplug/runtests.sh
deleted file mode 100755
index 1943f83..0000000
--- a/testcases/kernel/hotplug/cpu_hotplug/runtests.sh
+++ /dev/null
@@ -1,16 +0,0 @@
-#!/bin/sh
-
-
-CPU_TO_TEST=${CPU_TO_TEST:=1}
-LOOPS=${LOOPS:=1}
-export LHCS_PATH=${LHCS_PATH:-$LTPROOT/testcases/bin/cpu_hotplug}
-
-
-echo "CPU:        $CPU_TO_TEST"
-echo "LOOPS:      $LOOPS"
-echo "LHCS_PATH:  $LHCS_PATH"
-
-
-for case in $LHCS_PATH/functional/hotplug??.sh; do
-	$case $CPU_TO_TEST
-done
-- 
1.7.11


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_nov
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
