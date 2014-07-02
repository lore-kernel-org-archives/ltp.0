Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1X2GR3-00084v-Fx
	for ltp-list@lists.sourceforge.net; Wed, 02 Jul 2014 09:02:37 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X2GQz-0005jK-4V
	for ltp-list@lists.sourceforge.net; Wed, 02 Jul 2014 09:02:37 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s6292ORJ008643
	for <ltp-list@lists.sourceforge.net>; Wed, 2 Jul 2014 17:02:25 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Wed, 2 Jul 2014 17:01:07 +0800
Message-ID: <1404291667-13198-2-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1404291667-13198-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1400502716-8969-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1404291667-13198-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v3 2/2] hotplug/cpu_hotplug: add it to run default and
	cleanup
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

Add cpu_hotplug tests to scenario_groups/default.

Modify Makefile.

Some cleanup of cpuhotplug0*.sh:
  Obtain some variables' value from parameters.
  Use functions in test.sh, eg. tst_brkm.
  Use 'TST_CLEANUP' shell variable.

Fix error in the procedure of offline/online cpu.

Modify 'sar' command in cpuhotplug06.sh.

Currently cpuhotplug01.sh is disabled, because some irqs'
smp_affinity can't be set.

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 runtest/cpuhotplug                                 |  14 +--
 scenario_groups/default                            |   1 +
 testcases/kernel/hotplug/cpu_hotplug/Makefile      |  10 +-
 .../kernel/hotplug/cpu_hotplug/functional/Makefile |  25 ++++
 .../hotplug/cpu_hotplug/functional/cpuhotplug01.sh | 138 +++++++++++----------
 .../hotplug/cpu_hotplug/functional/cpuhotplug02.sh |  84 ++++++++-----
 .../hotplug/cpu_hotplug/functional/cpuhotplug03.sh | 113 ++++++++++-------
 .../hotplug/cpu_hotplug/functional/cpuhotplug04.sh |  99 +++++++++------
 .../hotplug/cpu_hotplug/functional/cpuhotplug05.sh | 118 +++++++++++-------
 .../hotplug/cpu_hotplug/functional/cpuhotplug06.sh |  85 ++++++++-----
 .../hotplug/cpu_hotplug/functional/cpuhotplug07.sh |  90 +++++++++-----
 .../kernel/hotplug/cpu_hotplug/include/Makefile    |  25 ++++
 .../kernel/hotplug/cpu_hotplug/tools/Makefile      |  26 ++++
 13 files changed, 528 insertions(+), 300 deletions(-)
 create mode 100644 testcases/kernel/hotplug/cpu_hotplug/functional/Makefile
 create mode 100644 testcases/kernel/hotplug/cpu_hotplug/include/Makefile
 create mode 100644 testcases/kernel/hotplug/cpu_hotplug/tools/Makefile

diff --git a/runtest/cpuhotplug b/runtest/cpuhotplug
index 274e9bf..ec7f11e 100644
--- a/runtest/cpuhotplug
+++ b/runtest/cpuhotplug
@@ -1,9 +1,9 @@
 ## Run the CPUHOTPLUG tests here
 
-cpuhotplug01 export CPU_TO_TEST=1; $LTPROOT/testcases/bin/cpu_hotplug/functional/cpuhotplug01.sh
-cpuhotplug02 export CPU_TO_TEST=1; $LTPROOT/testcases/bin/cpu_hotplug/functional/cpuhotplug02.sh
-cpuhotplug03 export CPU_TO_TEST=1; $LTPROOT/testcases/bin/cpu_hotplug/functional/cpuhotplug03.sh
-cpuhotplug04 export CPU_TO_TEST=1; $LTPROOT/testcases/bin/cpu_hotplug/functional/cpuhotplug04.sh
-cpuhotplug05 export CPU_TO_TEST=1; $LTPROOT/testcases/bin/cpu_hotplug/functional/cpuhotplug05.sh
-cpuhotplug06 export CPU_TO_TEST=1; $LTPROOT/testcases/bin/cpu_hotplug/functional/cpuhotplug06.sh
-cpuhotplug07 export CPU_TO_TEST=1; $LTPROOT/testcases/bin/cpu_hotplug/functional/cpuhotplug07.sh
+#cpuhotplug01 cpuhotplug01.sh -c 1 -l 1 -n 1 -f 1 -e 6
+cpuhotplug02 cpuhotplug02.sh -c 1 -l 1
+cpuhotplug03 cpuhotplug03.sh -c 1 -l 1
+cpuhotplug04 cpuhotplug04.sh -l 1
+cpuhotplug05 cpuhotplug05.sh -c 1 -l 1 -d /tmp
+cpuhotplug06 cpuhotplug06.sh -c 1 -l 1
+cpuhotplug07 cpuhotplug07.sh -c 1 -l 1 -d /usr/src/linux
diff --git a/scenario_groups/default b/scenario_groups/default
index 71b3646..30d7168 100644
--- a/scenario_groups/default
+++ b/scenario_groups/default
@@ -30,3 +30,4 @@ fs_ext4
 pipes
 dma_thread_diotest
 cpuacct
+cpuhotplug
diff --git a/testcases/kernel/hotplug/cpu_hotplug/Makefile b/testcases/kernel/hotplug/cpu_hotplug/Makefile
index 7a0d200..cdf9b62 100644
--- a/testcases/kernel/hotplug/cpu_hotplug/Makefile
+++ b/testcases/kernel/hotplug/cpu_hotplug/Makefile
@@ -1,5 +1,6 @@
 #
 #    kernel/hotplug/cpu_hotplug test suite Makefile.
+#    Maxin B. John, March 2010
 #
 #    This program is free software; you can redistribute it and/or modify
 #    it under the terms of the GNU General Public License as published by
@@ -15,17 +16,10 @@
 #    with this program; if not, write to the Free Software Foundation, Inc.,
 #    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 #
-# Maxin B. John, March 2010
 
 top_srcdir                      ?= ../../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-# Avoid namespace collisions because the installation filenames are pretty
-# generic.
-INSTALL_DIR			:= testcases/bin/cpu_hotplug
-
-INSTALL_TARGETS                 := runtests.sh functional/* include/* tools/*
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
 
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/Makefile b/testcases/kernel/hotplug/cpu_hotplug/functional/Makefile
new file mode 100644
index 0000000..8d5ee0c
--- /dev/null
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (c) 2014 Fujitsu Ltd.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir                      ?= ../../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_TARGETS		:= *.sh
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
index 9e05cce..e1a1855 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
@@ -5,21 +5,13 @@
 # Based on script by Ashok Raj <ashok.raj@intel.com>
 # Modified by Mark D and Bryce, Aug '05.
 
-HOTPLUG01_LOOPS=${HOTPLUG01_LOOPS:-${LOOPS}}
 export TCID="cpuhotplug01"
-export TST_COUNT=1
-export TST_TOTAL=${HOTPLUG01_LOOPS:-1}
-
-CPU_TO_TEST=${CPU_TO_TEST:-1}
-if [ -z "${CPU_TO_TEST}" ]; then
-	echo "usage: ${0##*/} <CPU to online>"
-	exit 1
-fi
+export TST_TOTAL=1
 
 # Includes:
-LHCS_PATH=${LHCS_PATH:-$LTPROOT/testcases/bin/cpu_hotplug}
-. $LHCS_PATH/include/cpuhotplug_testsuite.sh
-. $LHCS_PATH/include/cpuhotplug_hotplug.sh
+. test.sh
+. cpuhotplug_testsuite.sh
+. cpuhotplug_hotplug.sh
 
 cat <<EOF
 Name:   $TCID
@@ -28,40 +20,21 @@ Desc:   What happens to disk controller interrupts when offlining CPUs?
 
 EOF
 
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
-	tst_brk TCONF "analysis script - cpuhotplug_report_proc_interrupts - \
-					requires perl"
-	exit 1
-fi
+usage()
+{
+	cat << EOF
+	usage: $0 -c cpu -l loop -n timeon -f timeoff -e timed
 
-if ! get_all_cpus >/dev/null 2>&1; then
-	tst_brkm TCONF "system doesn't have required CPU hotplug support"
-	exit 1
-fi
+	OPTIONS
+		-c  cpu which is specified for testing
+		-l  number of cycle test
+		-n	time delay after an online of cpu
+		-f	time delay after offline of cpu
+		-e	time delay before start of entire new cycle
 
-# Validate the specified CPU exists
-if ! cpu_is_valid "${CPU_TO_TEST}" ; then
-	tst_resm TFAIL "cpu${CPU_TO_TEST} not found"
+EOF
 	exit 1
-fi
-
-CPU_COUNT=0
-
-if ! cpu_is_online "${CPU_TO_TEST}" ; then
-	if ! online_cpu ${CPU_TO_TEST} ; then
-		tst_resm TFAIL "Could not online cpu $CPU_TO_TEST"
-		exit_clean 1
-	fi
-fi
+}
 
 # do_clean()
 #
@@ -73,12 +46,11 @@ do_clean()
 	kill_pid ${WRL_ID}
 
 	# Turns off the cpus that were off before the test start
-	tst_resm TINFO "Return to previous state. CPU count = ${CPU_COUNT}"
 	until [ $CPU_COUNT -eq 0 ]; do
 		offline_cpu=$(eval "echo \$OFFLINE_CPU_${CPU_COUNT}")
 		tst_resm TINFO "CPU = $CPU_COUNT @on = $offline_cpu"
 		offline_cpu $offline_cpu
-		: $(( CPU_COUNT -= 1 ))
+		CPU_COUNT=$((CPU_COUNT-1))
 	done
 }
 
@@ -96,7 +68,7 @@ do_offline()
 	offline_cpu ${CPU}
 	if [ $? -ne 0 ]; then
 		if [ "$CPU" -ne 0 ]; then
-			: $(( CPU_COUNT += 1 ))
+			CPU_COUNT=$((CPU_COUNT+1))
 			eval "OFFLINE_CPU_${CPU_COUNT}=$1"
 		fi
 		return 1
@@ -123,12 +95,55 @@ do_online()
 	fi
 }
 
+while getopts c:l:n:f:e: OPTION; do
+	case $OPTION in
+	c)
+		CPU_TO_TEST=$OPTARG;;
+	l)
+		HOTPLUG01_LOOPS=$OPTARG;;
+	n)
+		TM_ONLINE=$OPTARG;;
+	f)
+		TM_OFFLINE=$OPTARG;;
+	e)
+		TM_DLY=$OPTARG;;
+	?)
+		usage;;
+	esac
+done
+
+LOOP_COUNT=1
+
+tst_check_cmds perl
+
+if ! get_all_cpus >/dev/null 2>&1; then
+	tst_brkm TCONF "system doesn't have required CPU hotplug support"
+fi
+
+if [ -z "${CPU_TO_TEST}" ]; then
+	tst_brkm TBROK "usage: ${0##*/} <CPU to online>"
+fi
+
+# Validate the specified CPU exists
+if ! cpu_is_valid "${CPU_TO_TEST}" ; then
+	tst_brkm TBROK "cpu${CPU_TO_TEST} not found"
+fi
+
+if ! cpu_is_online "${CPU_TO_TEST}" ; then
+	if ! online_cpu ${CPU_TO_TEST} ; then
+		tst_brkm TBROK "Could not online cpu $CPU_TO_TEST"
+	fi
+fi
+
+TST_CLEANUP=do_clean
+
+CPU_COUNT=0
+
 # Start up a process that writes to disk; keep track of its PID
-$LHCS_PATH/tools/cpuhotplug_do_disk_write_loop > /dev/null 2>&1 &
+cpuhotplug_do_disk_write_loop > /dev/null 2>&1 &
 WRL_ID=$!
 
-RC=0
-until [ $TST_COUNT -gt $TST_TOTAL -o $RC -ne 0 ]
+until [ $LOOP_COUNT -gt $HOTPLUG01_LOOPS ]
 do
 
 	tst_resm TINFO "Starting loop"
@@ -142,16 +157,13 @@ do
 		do_offline $cpu
 		err=$?
 		if [ $err -ne 0 ]; then
-			tst_resm TBROK "offlining $cpu failed: $err"
-			RC=2
+			tst_brkm TBROK "offlining $cpu failed: $err"
 		else
 			tst_resm TINFO "offlining $cpu was ok"
 		fi
 		sleep $TM_OFFLINE
 	done
 
-	#IRQ_MID=`cat /proc/interrupts`
-
 	# Attempt to online all CPUs
 	for cpu in $( get_all_cpus ); do
 		if [ "$cpu" = "cpu0" ]; then
@@ -160,8 +172,7 @@ do
 		do_online $cpu
 		err=$?
 		if [ $err -ne 0 ]; then
-			tst_resm TBROK "onlining $cpu failed: $err"
-			RC=2
+			tst_brkm TBROK "onlining $cpu failed: $err"
 		else
 			tst_resm TINFO "onlining $cpu was ok"
 		fi
@@ -173,21 +184,14 @@ do
 	# Print out a report showing the changes in IRQs
 	echo
 	echo
-	$LHCS_PATH/tools/cpuhotplug_report_proc_interrupts "$IRQ_START" \
-		"$IRQ_END"
+	cpuhotplug_report_proc_interrupts "$IRQ_START" "$IRQ_END"
 	echo
 
-	if [ $RC -eq 0 ] ; then
-
-		sleep $TM_DLY
-		: $(( TST_COUNT += 1 ))
-
-	fi
+	sleep $TM_DLY
+	LOOP_COUNT=$((LOOP_COUNT+1))
 
 done
 
-if [ "$RC" -eq 0 ];then
-        tst_resm TPASS "online and offline cpu${CPU} when writing disk"
-fi
+tst_resm TPASS "online and offline cpu${CPU} when writing disk"
 
-exit_clean $RC
+tst_exit
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh
index 56eead9..edfdd35 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh
@@ -3,21 +3,13 @@
 # Test Case 2
 #
 
-HOTPLUG02_LOOPS=${HOTPLUG02_LOOPS:-${LOOPS}}
 export TCID="cpuhotplug02"
-export TST_COUNT=1
-export TST_TOTAL=${HOTPLUG02_LOOPS:-1}
-
-CPU_TO_TEST=${CPU_TO_TEST:-1}
-if [ -z "$CPU_TO_TEST" ]; then
-	echo "usage: ${0##*} <CPU to online>"
-	exit 1
-fi
+export TST_TOTAL=1
 
 # Includes:
-LHCS_PATH=${LHCS_PATH:-$LTPROOT/testcases/bin/cpu_hotplug}
-. $LHCS_PATH/include/cpuhotplug_testsuite.sh
-. $LHCS_PATH/include/cpuhotplug_hotplug.sh
+. test.sh
+. cpuhotplug_testsuite.sh
+. cpuhotplug_hotplug.sh
 
 cat <<EOF
 Name:   $TCID
@@ -26,15 +18,18 @@ Desc:   What happens to a process when its CPU is offlined?
 
 EOF
 
-# Start up a process that just uses CPU cycles
-$LHCS_PATH/tools/cpuhotplug_do_spin_loop > /dev/null&
-SPIN_LOOP_PID=$!
+usage()
+{
+	cat << EOF
+	usage: $0 -c cpu -l loop
 
-# Validate the specified CPU exists
-if ! cpu_is_valid "${CPU_TO_TEST}" ; then
-	tst_resm TBROK "cpu${CPU_TO_TEST} not found"
-	exit_clean 1
-fi
+	OPTIONS
+		-c  cpu which is specified for testing
+		-l  number of cycle test
+
+EOF
+	exit 1
+}
 
 # do_clean()
 #
@@ -46,16 +41,43 @@ do_clean()
 	kill_pid ${SPIN_LOOP_PID}
 }
 
+while getopts c:l: OPTION; do
+	case $OPTION in
+	c)
+		CPU_TO_TEST=$OPTARG;;
+	l)
+		HOTPLUG02_LOOPS=$OPTARG;;
+	?)
+		usage;;
+	esac
+done
+
+LOOP_COUNT=1
+
+if [ -z "${CPU_TO_TEST}" ]; then
+	tst_brkm TBROK "usage: ${0##*/} <CPU to online>"
+fi
+
+# Validate the specified CPU exists
+if ! cpu_is_valid "${CPU_TO_TEST}" ; then
+	tst_brkm TBROK "cpu${CPU_TO_TEST} not found"
+fi
+
 # Validate the specified CPU is online; if not, online it
 if ! cpu_is_online "${CPU_TO_TEST}" ; then
 	if ! online_cpu ${CPU_TO_TEST}; then
-		tst_resm TBROK "CPU${CPU_TO_TEST} cannot be onlined"
-		exit_clean 1
+		tst_brkm TBROK "CPU${CPU_TO_TEST} cannot be onlined"
 	fi
 fi
 
+TST_CLEANUP=do_clean
+
+# Start up a process that just uses CPU cycles
+cpuhotplug_do_spin_loop > /dev/null&
+SPIN_LOOP_PID=$!
+
 sleep 5
-until [ $TST_COUNT -gt $TST_TOTAL ]; do
+until [ $LOOP_COUNT -gt $HOTPLUG02_LOOPS ]; do
 	# Move spin_loop.sh to the CPU to offline.
 	set_affinity ${SPIN_LOOP_PID} ${CPU_TO_TEST}
 
@@ -63,19 +85,21 @@ until [ $TST_COUNT -gt $TST_TOTAL ]; do
 	offline_cpu ${CPU_TO_TEST}
 	NEW_CPU=`ps --pid=${SPIN_LOOP_PID} -o psr --no-headers`
 	if [ -z "${NEW_CPU}" ]; then
-		tst_resm TBROK "PID ${SPIN_LOOP_PID} no longer running"
-		exit_clean 1
-	elif [ ${CPU_TO_TEST} = ${NEW_CPU} ]; then
+		tst_brkm TBROK "PID ${SPIN_LOOP_PID} no longer running"
+	fi
+	if [ ${CPU_TO_TEST} = ${NEW_CPU} ]; then
 		tst_resm TFAIL "process did not change from CPU ${NEW_CPU}"
-		exit_clean 1
+		tst_exit
 	fi
-	tst_resm TPASS "turned off CPU ${CPU_TO_TEST}, process migrated to CPU ${NEW_CPU}"
 
 	# Turn the CPU back online just to see what happens.
 	online_cpu ${CPU_TO_TEST}
-	: $(( TST_COUNT += 1 ))
+	LOOP_COUNT=$((LOOP_COUNT+1))
 done
 
+tst_resm TPASS "turned off CPU ${CPU_TO_TEST}, process migrated to \
+	CPU ${NEW_CPU}"
+
 sleep 2
 
-exit_clean
+tst_exit
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
index 60343d5..61c7ba5 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
@@ -3,21 +3,13 @@
 # Test Case 3
 #
 
-HOTPLUG03_LOOPS=${HOTPLUG03_LOOPS:-${LOOPS}}
-export TST_COUNT=1
-export TST_TOTAL=${HOTPLUG03_LOOPS:-1}
 export TCID="cpuhotplug03"
-
-CPU_TO_TEST=${CPU_TO_TEST:-1}
-if [ -z $CPU_TO_TEST ]; then
-	echo "usage: ${0##*} <CPU to online>"
-	exit 1
-fi
+export TST_TOTAL=1
 
 # Includes:
-LHCS_PATH=${LHCS_PATH:-${LTPROOT:+$LTPROOT/testcases/bin/cpu_hotplug}}
-. $LHCS_PATH/include/cpuhotplug_testsuite.sh
-. $LHCS_PATH/include/cpuhotplug_hotplug.sh
+. test.sh
+. cpuhotplug_testsuite.sh
+. cpuhotplug_hotplug.sh
 
 cat <<EOF
 Name:   $TCID
@@ -26,11 +18,18 @@ Desc:   Do tasks get scheduled to a newly on-lined CPU?
 
 EOF
 
-# Verify the specified CPU exists
-if ! cpu_is_valid "${CPU_TO_TEST}" ; then
-	tst_resm TCONF "CPU${CPU_TO_TEST} not found"
-	exit_clean 1
-fi
+usage()
+{
+	cat << EOF
+	usage: $0 -c cpu -l loop
+
+	OPTIONS
+		-c  cpu which is specified for testing
+		-l  number of cycle test
+
+EOF
+	exit 1
+}
 
 # do_clean()
 #
@@ -50,11 +49,35 @@ do_clean()
 	# Turn off the CPUs that were off before the test start
 	until [ $cpu -eq 0 ];do
 		offline_cpu $(eval "echo \$on_${cpu}")
-		: $(( cpu -= 1 ))
+		cpu=$((cpu-1))
 	done
 }
 
-until [ $TST_COUNT -gt $TST_TOTAL ]; do
+while getopts c:l: OPTION; do
+case $OPTION in
+	c)
+		CPU_TO_TEST=$OPTARG;;
+	l)
+		HOTPLUG03_LOOPS=$OPTARG;;
+	?)
+		usage;;
+	esac
+done
+
+LOOP_COUNT=1
+
+if [ -z $CPU_TO_TEST ]; then
+	tst_brkm TBROK "usage: ${0##*} <CPU to online>"
+fi
+
+# Verify the specified CPU exists
+if ! cpu_is_valid "${CPU_TO_TEST}" ; then
+	tst_brkm TBROK "CPU${CPU_TO_TEST} not found"
+fi
+
+TST_CLEANUP=do_clean
+
+until [ $LOOP_COUNT -gt $HOTPLUG03_LOOPS ]; do
 	cpu=0
 	number_of_cpus=0
 
@@ -64,30 +87,28 @@ until [ $TST_COUNT -gt $TST_TOTAL ]; do
                 continue
             fi
             if ! cpu_is_online $i; then
-		if ! online_cpu $i; then
-                    tst_resm TFAIL "Could not online cpu $i"
-                    exit_clean 1
+				if ! online_cpu $i; then
+                    tst_brkm TBROK "Could not online cpu $i"
                 fi
-                : $(( cpu += 1 ))
+				cpu=$((cpu+1))
                 eval "on_${cpu}=$i"
             fi
-		: $(( number_of_cpus += 1 ))
+		number_of_cpus=$((number_of_cpus+1))
 	done
 
 	if ! offline_cpu ${CPU_TO_TEST} ; then
-		tst_resm TFAIL "CPU${CPU_TO_TEST} cannot be offlined"
-		exit_clean 1
+		tst_resm TBROK "CPU${CPU_TO_TEST} cannot be offlined"
 	fi
 
 	# Start up a number of processes equal to twice the number of
 	# CPUs we have.  This is to help ensure we've got enough processes
 	# that at least one will migrate to the new CPU.  Store the PIDs
 	# so we can kill them later.
-	: $(( number_of_cpus *= 2 ))
+	number_of_cpus=$((number_of_cpus*2))
 	until [ $number_of_cpus -eq 0 ]; do
-		$LHCS_PATH/tools/cpuhotplug_do_spin_loop > /dev/null 2>&1 &
+		cpuhotplug_do_spin_loop > /dev/null 2>&1 &
 		echo $! >> /var/run/hotplug4_$$.pid
-		: $(( number_of_cpus -= 1 ))
+		number_of_cpus=$((number_of_cpus-1))
 	done
 
 	ps aux | head -n 1
@@ -95,35 +116,33 @@ until [ $TST_COUNT -gt $TST_TOTAL ]; do
 
 	# Online the CPU
 	tst_resm TINFO "Onlining CPU ${CPU_TO_TEST}"
-	online_cpu ${CPU_TO_TEST}
-	RC=$?
-	if [ $RC -ne 0 ]; then
-		tst_resm TFAIL "CPU${CPU_TO_TEST} cannot be onlined"
-		exit_clean 1
+	if ! online_cpu ${CPU_TO_TEST}; then
+		tst_brkm TBROK "CPU${CPU_TO_TEST} cannot be onlined"
 	fi
 
 	sleep 1
 
 	# Verify at least one process has migrated to the new CPU
 	ps -o psr -o command --no-headers -C cpuhotplug_do_spin_loop
-	RC=$?
-	NUM=`ps -o psr -o command --no-headers -C cpuhotplug_do_spin_loop | \
-		sed -e "s/^ *//" | cut -d' ' -f 1 | grep "^${CPU_TO_TEST}$" | \
-		wc -l`
-	if [ $RC -ne 0 ]; then
-		tst_resm TBROK "No cpuhotplug_do_spin_loop processes found on \
-			any processor"
-	elif [ $NUM -lt 1 ]; then
+	if [ $? -ne 0 ]; then
+		tst_brkm TBROK "No cpuhotplug_do_spin_loop processes \
+			found on any processor"
+	fi
+	NUM=`ps -o psr -o command --no-headers -C cpuhotplug_do_spin_loop \
+		| sed -e "s/^ *//" | cut -d' ' -f 1 | grep "^${CPU_TO_TEST}$" \
+		| wc -l`
+	if [ $NUM -lt 1 ]; then
 		tst_resm TFAIL "No cpuhotplug_do_spin_loop processes found on \
 			CPU${CPU_TO_TEST}"
-	else
-		tst_resm TPASS "$NUM cpuhotplug_do_spin_loop processes found \
-			on CPU${CPU_TO_TEST}"
+		tst_exit
 	fi
 
 	do_clean
 
-	: $(( TST_COUNT +=1 ))
+	LOOP_COUNT=$((LOOP_COUNT+1))
 done
 
-exit_clean
+tst_resm TPASS "$NUM cpuhotplug_do_spin_loop processes found on \
+	CPU${CPU_TO_TEST}"
+
+tst_exit
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
index 0204d66..0e3d5f4 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
@@ -3,15 +3,13 @@
 # Test Case 4
 #
 
-HOTPLUG04_LOOPS=${HOTPLUG04_LOOPS:-${LOOPS}}
 export TCID="cpuhotplug04"
-export TST_COUNT=1
-export TST_TOTAL=${HOTPLUG04_LOOPS:-1}
+export TST_TOTAL=1
 
 # Includes:
-LHCS_PATH=${LHCS_PATH:-${LTPROOT:+$LTPROOT/testcases/bin/cpu_hotplug}}
-. $LHCS_PATH/include/cpuhotplug_testsuite.sh
-. $LHCS_PATH/include/cpuhotplug_hotplug.sh
+. test.sh
+. cpuhotplug_testsuite.sh
+. cpuhotplug_hotplug.sh
 
 cat <<EOF
 Name:   $TCID
@@ -20,52 +18,83 @@ Desc:   Does it prevent us from offlining the last CPU?
 
 EOF
 
-cpu=0
-until [ $TST_COUNT -gt $TST_TOTAL ]; do
+usage()
+{
+	cat << EOF
+	usage: $0 -l loop
+
+	OPTIONS
+		-l  number of cycle test
+
+EOF
+	exit 1
+}
+
+do_clean()
+{
+	# Online the ones that were on initially
+	until [ $cpu -eq 0 ]; do
+		online_cpu $(eval "echo \$on_${cpu}")
+		cpu=$((cpu-1))
+	done
+
+	# Return CPU 0 to its initial state
+	if [ $cpustate = 1 ]; then
+		online_cpu 0
+	else
+		offline_cpu 0
+	fi
+}
+
+while getopts l: OPTION; do
+	case $OPTION in
+	l)
+		HOTPLUG04_LOOPS=$OPTARG;;
+	?)
+		usage;;
+	esac
+done
+
+LOOP_COUNT=1
+
+TST_CLEANUP=do_clean
+
+until [ $LOOP_COUNT -gt $HOTPLUG04_LOOPS ]; do
+	cpu=0
 	cpustate=1
 
 	# Online all the CPUs' keep track of which were already on
 	for i in $(get_all_cpus); do
-		online_cpu $i
-		RC=$?
-		if [ $RC -ne 0 ]; then
-			: $(( cpu += 1 ))
+		if [ "$i" != "cpu0" ]; then
+			if ! cpu_is_online $i; then
+				if ! online_cpu $i; then
+					tst_brkm TBROK "$i cannot be onlined"
+				fi
+			fi
+			cpu=$((cpu+1))
 			eval "on_${cpu}=$i"
 			echo $i
-		fi
-		if [ $RC -eq 0 -a "$i" = "cpu0" ]; then
-			cpustate=0
+		else
+			if online_cpu $i; then
+				cpustate=0
+			fi
 		fi
 	done
 
 	# Now offline all the CPUs
 	for i in $(get_all_cpus); do
-		offline_cpu $i
-		RC=$?
-		if [ $RC -eq 1 ]; then
+		if ! offline_cpu $i; then
 			if [ "x$i" != "xcpu0" ]; then
 				tst_resm TFAIL "Did not offline first CPU (offlined $i instead)"
-			else
-				tst_resm TPASS "Successfully offlined first CPU, $i"
+				tst_exit
 			fi
 		fi
 	done
 
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
+	LOOP_COUNT=$((LOOP_COUNT+1))
 
 done
 
-exit_clean
+tst_resm TPASS "Successfully offlined first CPU, $i"
+
+tst_exit
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
index 9b1cdbc..34b160a 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
@@ -1,24 +1,15 @@
 #!/bin/sh
 #
-# Test Case 6 - sar
+# Test Case 5 - sar
 #
 
-TST_TOTAL=${HOTPLUG06_LOOPS:-${LOOPS}}
 export TCID="cpuhotplug05"
-export TMP=${TMP:=/tmp}
-export TST_COUNT=1
-export TST_TOTAL=${HOTPLUG06_LOOPS:-1}
-
-CPU_TO_TEST=${CPU_TO_TEST:-1}
-if [ -z "$CPU_TO_TEST" ]; then
-	echo "usage: ${0##*} <CPU to offline>"
-	exit 1
-fi
+export TST_TOTAL=1
 
 # Includes:
-LHCS_PATH=${LHCS_PATH:-${LTPROOT:+$LTPROOT/testcases/bin/cpu_hotplug}}
-. $LHCS_PATH/include/cpuhotplug_testsuite.sh
-. $LHCS_PATH/include/cpuhotplug_hotplug.sh
+. test.sh
+. cpuhotplug_testsuite.sh
+. cpuhotplug_hotplug.sh
 
 cat <<EOF
 Name:   $TCID
@@ -27,55 +18,91 @@ Desc:   Does sar behave properly during CPU hotplug events?
 
 EOF
 
-which sar > /dev/null 2>&1 || {
-        tst_resm TCONF "sar does not exist"
-        exit_clean 1
+usage()
+{
+	cat << EOF
+	usage: $0 -c cpu -l loop -d directory
+
+	OPTIONS
+		-c  cpu which is specified for testing
+		-l  number of cycle test
+		-d  directory used to lay file
+
+EOF
+	exit 1
+}
+
+do_clean()
+{
+	pid_is_valid ${SAR_PID} && kill_pid ${SAR_PID}
 }
 
+while getopts c:l:d: OPTION; do
+	case $OPTION in
+	c)
+		CPU_TO_TEST=$OPTARG;;
+	l)
+		HOTPLUG05_LOOPS=$OPTARG;;
+	d)
+		TMP=$OPTARG;;
+	?)
+		usage;;
+	esac
+done
+
+LOOP_COUNT=1
+
+tst_check_cmds sar
+
+if [ -z "$CPU_TO_TEST" ]; then
+	tst_brkm TBROK "usage: ${0##*} <CPU to offline>"
+fi
+
 # Verify the specified CPU is available
 if ! cpu_is_valid "${CPU_TO_TEST}" ; then
-	tst_resm TBROK"CPU${CPU_TO_TEST} not found"
-	exit_clean 1
+	tst_brkm TBROK "CPU${CPU_TO_TEST} not found"
 fi
 
 # Check that the specified CPU is offline; if not, offline it
 if cpu_is_online "${CPU_TO_TEST}" ; then
 	if ! offline_cpu ${CPU_TO_TEST} ; then
-		tst_resm TBROK "CPU${CPU_TO_TEST} cannot be offlined"
-		exit_clean 1
+		tst_brkm TBROK "CPU${CPU_TO_TEST} cannot be offlined"
 	fi
 fi
 
-do_clean()
-{
-	kill_pid ${SAR_PID}
-}
+TST_CLEANUP=do_clean
+
+until [ $LOOP_COUNT -gt $HOTPLUG05_LOOPS ]; do
 
-until [ $TST_COUNT -gt $TST_TOTAL ]; do
 	# Start up SAR and give it a couple cycles to run
-	sar -P ALL 1 0 > $TMP/log_$$ &
+	sar 1 0 &>/dev/null &
+	sleep 2
+	if ps -C sar &>/dev/null; then
+		pkill sar
+		sar -P ALL 1 0 > $TMP/log_$$ &
+	else
+		sar -P ALL 1 > $TMP/log_$$ &
+	fi
 	sleep 2
 	SAR_PID=$!
 
-	# Verify that SAR has correctly listed the missing CPU as 'nan'
-	while ! grep -iq nan $TMP/log_$$; do
-		tst_resm TFAIL "CPU${CPU_TO_TEST} Not Found on SAR!"
-		exit_clean 1
+	# Verify that SAR has correctly listed the missing CPU
+	while ! awk '{print $9}' $TMP/log_$$ | grep -i "^0.00"; do
+		tst_brkm TBROK "CPU${CPU_TO_TEST} Not Found on SAR!"
 	done
 	time=`date +%X`
 	sleep .5
 
 	# Verify that at least some of the CPUs are offline
-	NUMBER_CPU_OFF=$(grep "$time" $TMP/log_$$ | grep -i nan | wc -l)
+	NUMBER_CPU_OFF=$(grep "$time" $TMP/log_$$ | awk '{print $9}' \
+		|grep -i "^0.00" | wc -l)
 	if [ ${NUMBER_CPU_OFF} -eq 0 ]; then
-		tst_resm TBROK "no CPUs found offline"
-		exit_clean 1
+		tst_brkm TBROK "no CPUs found offline"
 	fi
 
 	# Online the CPU
 	if ! online_cpu ${CPU_TO_TEST}; then
-		tst_resm TFAIL "CPU${CPU_TO_TEST} cannot be onlined line"
-		exit_clean 1
+		tst_brkm TBROK "CPU${CPU_TO_TEST} cannot be onlined line"
 	fi
 
 	sleep 1
@@ -83,16 +110,21 @@ until [ $TST_COUNT -gt $TST_TOTAL ]; do
 	sleep .5
 
 	# Check that SAR registered the change in CPU online/offline states
-	NEW_NUMBER_CPU_OFF=$(grep "$time" $TMP/log_$$ | grep -i nan | wc -l)
-	: $(( NUMBER_CPU_OFF -= 1 ))
-	if [ "$NUMBER_CPU_OFF" = "$NEW_NUMBER_CPU_OFF" ]; then
-		tst_resm TPASS "CPU was found after turned on."
-	else
+	NEW_NUMBER_CPU_OFF=$(grep "$time" $TMP/log_$$|awk '{print $9}' \
+		| grep -i "^0.00"| wc -l)
+	NUMBER_CPU_OFF=$((NUMBER_CPU_OFF-1))
+	if [ "$NUMBER_CPU_OFF" != "$NEW_NUMBER_CPU_OFF" ]; then
 		tst_resm TFAIL "no change in number of offline CPUs was found."
+		tst_exit
 	fi
 
-	: $(( TST_COUNT += 1 ))
+	offline_cpu ${CPU_TO_TEST}
+	kill_pid ${SAR_PID}
+
+	LOOP_COUNT=$((LOOP_COUNT+1))
 
 done
 
-exit_clean
+tst_resm TPASS "CPU was found after turned on."
+
+tst_exit
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
index bb80746..d382fc8 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
@@ -3,21 +3,13 @@
 # Test Case 6 - top
 #
 
-TST_TOTAL=${HOTPLUG06_LOOPS:-${LOOPS}}
 export TCID="cpuhotplug06"
-export TST_COUNT=1
-export TST_TOTAL=${HOTPLUG06_LOOPS:-1}
-
-CPU_TO_TEST=${CPU_TO_TEST:-1}
-if [ -z "$CPU_TO_TEST" ]; then
-	echo "Usage: ${0##*/} <CPU to offline>"
-	exit_clean 1
-fi
+export TST_TOTAL=1
 
 # Includes:
-LHCS_PATH=${LHCS_PATH:-${LTPROOT:+$LTPROOT/testcases/bin/cpu_hotplug}}
-. $LHCS_PATH/include/cpuhotplug_testsuite.sh
-. $LHCS_PATH/include/cpuhotplug_hotplug.sh
+. test.sh
+. cpuhotplug_testsuite.sh
+. cpuhotplug_hotplug.sh
 
 cat <<EOF
 Name:   $TCID
@@ -26,27 +18,56 @@ Desc:   Does top work properly when CPU hotplug events occur?
 
 EOF
 
+usage()
+{
+	cat << EOF
+	usage: $0 -c cpu -l loop
+
+	OPTIONS
+		-c  cpu which is specified for testing
+		-l  number of cycle test
+
+EOF
+	exit 1
+}
+
+do_clean()
+{
+	pid_is_valid ${TOP_PID} && kill_pid ${TOP_PID}
+}
+
+while getopts c:l: OPTION; do
+	case $OPTION in
+	c)
+		CPU_TO_TEST=$OPTARG;;
+	l)
+		HOTPLUG06_LOOPS=$OPTARG;;
+	?)
+		usage;;
+	esac
+done
+
+LOOP_COUNT=1
+
+if [ -z "$CPU_TO_TEST" ]; then
+	tst_brkm TBROK "Usage: ${0##*/} <CPU to offline>"
+fi
+
 # Verify that the specified CPU is available
 if ! cpu_is_valid "${CPU_TO_TEST}" ; then
-	tst_resm TBROK "CPU${CPU_TO_TEST} not found"
-	exit_clean 1
+	tst_brkm TBROK "CPU${CPU_TO_TEST} not found"
 fi
 
 # Check that the specified CPU is online; if not, online it
 if ! cpu_is_online "${CPU_TO_TEST}" ; then
 	if ! online_cpu ${CPU_TO_TEST}; then
-		tst_resm TFAIL "CPU${CPU_TO_TEST} cannot be onlined"
-		exit_clean 1
+		tst_brkm TBROK "CPU${CPU_TO_TEST} cannot be onlined"
 	fi
 fi
 
-do_clean()
-{
-	pid_is_valid ${TOP_PID} && kill_pid ${TOP_PID}
-	online_cpu ${CPU_TO_TEST}
-}
+TST_CLEANUP=do_clean
 
-until [ $TST_COUNT -gt $TST_TOTAL ]; do
+until [ $LOOP_COUNT -gt $HOTPLUG06_LOOPS ]; do
 	# Start up top and give it a little time to run
 	top -b -d 00.10 > /dev/null 2>&1 &
 	TOP_PID=$!
@@ -54,25 +75,25 @@ until [ $TST_COUNT -gt $TST_TOTAL ]; do
 
 	# Now offline the CPU
 	if ! offline_cpu ${CPU_TO_TEST} ; then
-		tst_resm TBROK "CPU${CPU_TO_TEST} cannot be onlined"
-		exit_clean 1
+		tst_brkm TBROK "CPU${CPU_TO_TEST} cannot be offlined"
 	fi
 
 	# Wait a little time for top to notice the CPU is gone
 	sleep 1
 
 	# Check that top hasn't crashed
-	if pid_is_valid ${TOP_PID} ; then
-		tst_resm TPASS "PID ${TOP_PID} still running."
-		online_cpu ${CPU_TO_TEST}
-		kill_pid ${TOP_PID}
-	else
+	if ! pid_is_valid ${TOP_PID} ; then
 		tst_resm TFAIL "PID ${TOP_PID} no longer running"
-		exit_clean 1
+		tst_exit
 	fi
 
-	: $(( TST_COUNT += 1 ))
+	online_cpu ${CPU_TO_TEST}
+	kill_pid ${TOP_PID}
+
+	LOOP_COUNT=$((LOOP_COUNT+1))
 
 done
 
-exit_clean
+tst_resm TPASS "PID ${TOP_PID} still running."
+
+tst_exit
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh
index c77ccfb..32bbf1c 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh
@@ -5,15 +5,13 @@
 # Runs continuous offline/online of CPUs along with
 # a kernel compilation load.
 
-TST_TOTAL=${HOTPLUG07_LOOPS:-${LOOPS}}
 export TCID="cpuhotplug07"
-export TST_COUNT=1
-export TST_TOTAL=${HOTPLUG07_LOOPS:-1}
+export TST_TOTAL=1
 
 # Includes:
-LHCS_PATH=${LHCS_PATH:-${LTPROOT:+$LTPROOT/testcases/bin/cpu_hotplug}}
-. $LHCS_PATH/include/cpuhotplug_testsuite.sh
-. $LHCS_PATH/include/cpuhotplug_hotplug.sh
+. test.sh
+. cpuhotplug_testsuite.sh
+. cpuhotplug_hotplug.sh
 
 cat <<EOF
 Name:   $TCID
@@ -23,37 +21,66 @@ Issue:  Hotplug bugs have been found during kernel compiles
 
 EOF
 
-CPU_TO_TEST=${CPU_TO_TEST:-1}
-KERNEL_DIR=${2:-/usr/src/linux}
-if [ -z "${CPU_TO_TEST}" ]; then
-	echo "usage: ${0##*/} <CPU to offline> <Kernel source code directory>"
-	exit_clean 1
-fi
-if [ ! -d "${KERNEL_DIR}" ]; then
-	tst_resm TCONF "kernel directory - $KERNEL_DIR - does not exist"
-	exit_clean 1
-fi
+usage()
+{
+	cat << EOF
+	usage: $0 -c cpu -l loop -d directory
+
+	OPTIONS
+		-c	cpu which is specified for testing
+		-l	number of cycle test
+		-d	kernel directory where run this test
+
+EOF
+	exit 1
+}
 
 do_clean()
 {
 	kill_pid ${KCOMPILE_LOOP_PID}
 }
 
-$LHCS_PATH/tools/cpuhotplug_do_kcompile_loop $KERNEL_DIR > /dev/null 2>&1 &
-KCOMPILE_LOOP_PID=$!
+while getopts c:l:d: OPTION; do
+	case $OPTION in
+	c)
+		CPU_TO_TEST=$OPTARG;;
+	l)
+		HOTPLUG07_LOOPS=$OPTARG;;
+	d)
+		KERNEL_DIR=$OPTARG;;
+	?)
+		usage;;
+	esac
+done
+
+LOOP_COUNT=1
 
-tst_resm TINFO "initial CPU affinity for kernel compile is: $(get_affinity_mask ${KCOMPILE_LOOP_PID})"
+if [ ! -d "${KERNEL_DIR}" ]; then
+	tst_brkm TCONF "kernel directory - $KERNEL_DIR - does not exist"
+fi
+
+if [ -z "${CPU_TO_TEST}" ]; then
+	tst_brkm TBROK "usage: ${0##*/} <CPU to offline> <Kernel \
+		source code directory>"
+fi
 
 if ! cpu_is_online ${CPU_TO_TEST}; then
 	if ! online_cpu ${CPU_TO_TEST}; then
-		tst_resm TBROK "CPU${CPU_TO_TEST} cannot be onlined"
-		exit_clean 1
+		tst_brkm TBROK "CPU${CPU_TO_TEST} cannot be onlined"
 	fi
 fi
 
+TST_CLEANUP=do_clean
+
+cpuhotplug_do_kcompile_loop $KERNEL_DIR > /dev/null 2>&1 &
+KCOMPILE_LOOP_PID=$!
+
+tst_resm TINFO "initial CPU affinity for kernel compile is: \
+	$(get_affinity_mask ${KCOMPILE_LOOP_PID})"
+
 sleep 2
 
-until [ $TST_COUNT -gt $TST_TOTAL ]; do
+until [ $LOOP_COUNT -gt $HOTPLUG07_LOOPS ]; do
 
 	tst_resm TINFO "Starting loop"
 
@@ -66,23 +93,24 @@ until [ $TST_COUNT -gt $TST_TOTAL ]; do
 
 	NEW_CPU=`ps --pid=${KCOMPILE_LOOP_PID} -o psr --no-headers`
 	if [ -z "${NEW_CPU}" ]; then
-		tst_resm TBROK "PID ${KCOMPILE_LOOP_PID} no longer running"
-		exit_clean 1
-	elif [ "${CPU_TO_TEST}" = "${NEW_CPU}" ]; then
+		tst_brkm TBROK "PID ${KCOMPILE_LOOP_PID} no longer running"
+	fi
+	if [ "${CPU_TO_TEST}" = "${NEW_CPU}" ]; then
 		tst_resm TFAIL "process did not change from CPU ${NEW_CPU}"
-	else
-		tst_resm TPASS "turned off CPU ${CPU_TO_TEST}, process migrated to CPU ${NEW_CPU}"
+		tst_exit
 	fi
 
 	online_cpu ${CPU_TO_TEST}
 	RC=$?
+	echo "Onlining cpu${CPU_TO_TEST}: Return Code = ${RC}"
 
-	tst_resm TINFO "Onlining cpu${CPU_TO_TEST}: Return Code = ${RC}"
-
-	: $(( TST_COUNT += 1 ))
+	LOOP_COUNT=$((LOOP_COUNT+1))
 
 done
 
+tst_resm TPASS "turned off CPU ${CPU_TO_TEST}, process migrated to \
+	CPU ${NEW_CPU}"
+
 sleep 2
 
-exit_clean
+tst_exit
diff --git a/testcases/kernel/hotplug/cpu_hotplug/include/Makefile b/testcases/kernel/hotplug/cpu_hotplug/include/Makefile
new file mode 100644
index 0000000..8d5ee0c
--- /dev/null
+++ b/testcases/kernel/hotplug/cpu_hotplug/include/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (c) 2014 Fujitsu Ltd.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir                      ?= ../../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_TARGETS		:= *.sh
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/hotplug/cpu_hotplug/tools/Makefile b/testcases/kernel/hotplug/cpu_hotplug/tools/Makefile
new file mode 100644
index 0000000..071d568
--- /dev/null
+++ b/testcases/kernel/hotplug/cpu_hotplug/tools/Makefile
@@ -0,0 +1,26 @@
+#
+#    Copyright (c) 2014 Fujitsu Ltd.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir                      ?= ../../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_TARGETS		:= cpuhotplug_do_disk_write_loop cpuhotplug_do_spin_loop \
+					   cpuhotplug_do_kcompile_loop cpuhotplug_report_proc_interrupts
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
1.9.3


------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

