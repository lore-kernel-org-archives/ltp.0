Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1WxvAF-0001vO-Fd
	for ltp-list@lists.sourceforge.net; Fri, 20 Jun 2014 09:31:19 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WxvA9-0002j6-HO
	for ltp-list@lists.sourceforge.net; Fri, 20 Jun 2014 09:31:19 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s5K9V5ev012733
	for <ltp-list@lists.sourceforge.net>; Fri, 20 Jun 2014 17:31:05 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Fri, 20 Jun 2014 17:30:01 +0800
Message-ID: <1403256601-14345-1-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1400502716-8969-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1400502716-8969-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2] hotplug/cpu_hotplug: add it to run default and
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

Rename files in include and tools directories.

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
 runtest/cpuhotplug                                 |  14 +-
 scenario_groups/default                            |   1 +
 testcases/kernel/hotplug/cpu_hotplug/ChangeLog     |   6 +-
 testcases/kernel/hotplug/cpu_hotplug/Makefile      |  10 +-
 testcases/kernel/hotplug/cpu_hotplug/README        |   4 +-
 .../kernel/hotplug/cpu_hotplug/functional/Makefile |  25 +++
 .../hotplug/cpu_hotplug/functional/cpuhotplug01.sh | 136 +++++++-------
 .../hotplug/cpu_hotplug/functional/cpuhotplug02.sh |  84 ++++++---
 .../hotplug/cpu_hotplug/functional/cpuhotplug03.sh | 116 +++++++-----
 .../hotplug/cpu_hotplug/functional/cpuhotplug04.sh |  99 ++++++----
 .../hotplug/cpu_hotplug/functional/cpuhotplug05.sh | 118 +++++++-----
 .../hotplug/cpu_hotplug/functional/cpuhotplug06.sh |  85 +++++----
 .../hotplug/cpu_hotplug/functional/cpuhotplug07.sh |  90 +++++----
 .../kernel/hotplug/cpu_hotplug/include/Makefile    |  25 +++
 .../kernel/hotplug/cpu_hotplug/include/hotplug.fns | 202 --------------------
 .../kernel/hotplug/cpu_hotplug/include/hotplug.sh  | 203 +++++++++++++++++++++
 .../hotplug/cpu_hotplug/include/testsuite.fns      | 170 -----------------
 .../hotplug/cpu_hotplug/include/testsuite.sh       | 171 +++++++++++++++++
 .../kernel/hotplug/cpu_hotplug/tools/Makefile      |  26 +++
 .../tools/cpuhotplug_do_disk_write_loop            |  19 ++
 .../cpu_hotplug/tools/cpuhotplug_do_kcompile_loop  |  21 +++
 .../cpu_hotplug/tools/cpuhotplug_do_spin_loop      |   8 +
 .../tools/cpuhotplug_report_proc_interrupts        |  53 ++++++
 .../hotplug/cpu_hotplug/tools/do_disk_write_loop   |  19 --
 .../hotplug/cpu_hotplug/tools/do_kcompile_loop     |  21 ---
 .../kernel/hotplug/cpu_hotplug/tools/do_spin_loop  |   8 -
 .../cpu_hotplug/tools/report_proc_interrupts       |  53 ------
 27 files changed, 1012 insertions(+), 775 deletions(-)
 create mode 100644 testcases/kernel/hotplug/cpu_hotplug/functional/Makefile
 create mode 100644 testcases/kernel/hotplug/cpu_hotplug/include/Makefile
 delete mode 100644 testcases/kernel/hotplug/cpu_hotplug/include/hotplug.fns
 create mode 100644 testcases/kernel/hotplug/cpu_hotplug/include/hotplug.sh
 delete mode 100644 testcases/kernel/hotplug/cpu_hotplug/include/testsuite.fns
 create mode 100644 testcases/kernel/hotplug/cpu_hotplug/include/testsuite.sh
 create mode 100644 testcases/kernel/hotplug/cpu_hotplug/tools/Makefile
 create mode 100755 testcases/kernel/hotplug/cpu_hotplug/tools/cpuhotplug_do_disk_write_loop
 create mode 100755 testcases/kernel/hotplug/cpu_hotplug/tools/cpuhotplug_do_kcompile_loop
 create mode 100755 testcases/kernel/hotplug/cpu_hotplug/tools/cpuhotplug_do_spin_loop
 create mode 100755 testcases/kernel/hotplug/cpu_hotplug/tools/cpuhotplug_report_proc_interrupts
 delete mode 100755 testcases/kernel/hotplug/cpu_hotplug/tools/do_disk_write_loop
 delete mode 100755 testcases/kernel/hotplug/cpu_hotplug/tools/do_kcompile_loop
 delete mode 100755 testcases/kernel/hotplug/cpu_hotplug/tools/do_spin_loop
 delete mode 100755 testcases/kernel/hotplug/cpu_hotplug/tools/report_proc_interrupts

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
diff --git a/testcases/kernel/hotplug/cpu_hotplug/ChangeLog b/testcases/kernel/hotplug/cpu_hotplug/ChangeLog
index 5e6b9df..868ae7d 100644
--- a/testcases/kernel/hotplug/cpu_hotplug/ChangeLog
+++ b/testcases/kernel/hotplug/cpu_hotplug/ChangeLog
@@ -1,15 +1,15 @@
 2006-09-14  Bryce Harrington  <bryce@osdl.org>
 	* hotplug03.sh:  Fixing bug in return value of psr command, that
 	  was getting lost due to a subsequent command
-	* hotplug07.sh:  Fixing path issue for do_kcompile_loop
+	* hotplug07.sh:  Fixing path issue for cpuhotplug_do_kcompile_loop
 	* hotplug07.sh:  Automatic kernel source tree detection
 	* hotplug07.sh:  Reordering statements to suppress a warning
-	* do_kcompile_loop:  Adding support for chdir to kernel dir
+	* cpuhotplug_do_kcompile_loop:  Adding support for chdir to kernel dir
 
 2006-07-06  Bryce Harrington  <bryce@osdl.org>
 	* hotplug07.sh:  Fixing permissions
 	* hotplug07.sh:  Updating includes
-	* include/hotplug.fns:  Fixing error where files in
+	* include/hotplug.sh:  Fixing error where files in
 	  /sys/devices/system/cpu were detected as (invalid) cpus.
 
 2006-03-09  Bryce Harrington  <bryce@osdl.org>
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
 
diff --git a/testcases/kernel/hotplug/cpu_hotplug/README b/testcases/kernel/hotplug/cpu_hotplug/README
index 0199a36..88f1a5d 100644
--- a/testcases/kernel/hotplug/cpu_hotplug/README
+++ b/testcases/kernel/hotplug/cpu_hotplug/README
@@ -23,7 +23,7 @@ can be run in place using the above script.
 About Hotplug CPU
 =================
 The logic used to operate the hotplug features in Linux are implemented
-in the file includes/hotplug.fns.  These include functions for onlining
+in the file includes/hotplug.sh.  These include functions for onlining
 and offlining CPUs, determining if a given CPU is valid and/or online,
 getting lists of CPUs that are available, online, and offline, and
 managing IRQ's and affinities as they relate to CPUs.
@@ -31,7 +31,7 @@ managing IRQ's and affinities as they relate to CPUs.
 
 About the Test Suite
 ====================
-See includes/testsuite.fns for some general purpose routines for
+See includes/testsuite.sh for some general purpose routines for
 implementing a test suite.  These include process management, timing,
 and interupt handling and cleanup.
 
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
index 07379dc..bcc45fa 100755
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
-. $LHCS_PATH/include/testsuite.fns
-. $LHCS_PATH/include/hotplug.fns
+. test.sh
+. testsuite.sh
+. hotplug.sh
 
 cat <<EOF
 Name:   $TCID
@@ -28,39 +20,21 @@ Desc:   What happens to disk controller interrupts when offlining CPUs?
 
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
-	tst_brk TCONF "analysis script - report_proc_interrupts - requires perl"
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
@@ -72,12 +46,11 @@ do_clean()
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
 
@@ -95,7 +68,7 @@ do_offline()
 	offline_cpu ${CPU}
 	if [ $? -ne 0 ]; then
 		if [ "$CPU" -ne 0 ]; then
-			: $(( CPU_COUNT += 1 ))
+			CPU_COUNT=$((CPU_COUNT+1))
 			eval "OFFLINE_CPU_${CPU_COUNT}=$1"
 		fi
 		return 1
@@ -122,12 +95,55 @@ do_online()
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
-$LHCS_PATH/tools/do_disk_write_loop > /dev/null 2>&1 &
+cpuhotplug_do_disk_write_loop > /dev/null 2>&1 &
 WRL_ID=$!
 
-RC=0
-until [ $TST_COUNT -gt $TST_TOTAL -o $RC -ne 0 ]
+until [ $LOOP_COUNT -gt $HOTPLUG01_LOOPS ]
 do
 
 	tst_resm TINFO "Starting loop"
@@ -141,16 +157,13 @@ do
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
@@ -159,8 +172,7 @@ do
 		do_online $cpu
 		err=$?
 		if [ $err -ne 0 ]; then
-			tst_resm TBROK "onlining $cpu failed: $err"
-			RC=2
+			tst_brkm TBROK "onlining $cpu failed: $err"
 		else
 			tst_resm TINFO "onlining $cpu was ok"
 		fi
@@ -172,20 +184,14 @@ do
 	# Print out a report showing the changes in IRQs
 	echo
 	echo
-	$LHCS_PATH/tools/report_proc_interrupts "$IRQ_START" "$IRQ_END"
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
index 3f9400b..a1ed7df 100755
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
-. $LHCS_PATH/include/testsuite.fns
-. $LHCS_PATH/include/hotplug.fns
+. test.sh
+. testsuite.sh
+. hotplug.sh
 
 cat <<EOF
 Name:   $TCID
@@ -26,15 +18,18 @@ Desc:   What happens to a process when its CPU is offlined?
 
 EOF
 
-# Start up a process that just uses CPU cycles
-$LHCS_PATH/tools/do_spin_loop > /dev/null&
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
index 516a21f..74629f2 100755
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
-. $LHCS_PATH/include/testsuite.fns
-. $LHCS_PATH/include/hotplug.fns
+. test.sh
+. testsuite.sh
+. hotplug.sh
 
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
 
@@ -64,61 +87,62 @@ until [ $TST_COUNT -gt $TST_TOTAL ]; do
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
-		$LHCS_PATH/tools/do_spin_loop > /dev/null 2>&1 &
+		cpuhotplug_do_spin_loop > /dev/null 2>&1 &
 		echo $! >> /var/run/hotplug4_$$.pid
-		: $(( number_of_cpus -= 1 ))
+		number_of_cpus=$((number_of_cpus-1))
 	done
 
 	ps aux | head -n 1
-	ps aux | grep do_spin_loop
+	ps aux | grep cpuhotplug_do_spin_loop
 
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
-	ps -o psr -o command --no-headers -C do_spin_loop
-	RC=$?
-	NUM=`ps -o psr -o command --no-headers -C do_spin_loop | sed -e "s/^ *//" | cut -d' ' -f 1 | grep "^${CPU_TO_TEST}$" | wc -l`
-	if [ $RC -ne 0 ]; then
-		tst_resm TBROK "No do_spin_loop processes found on any processor"
-	elif [ $NUM -lt 1 ]; then
-		tst_resm TFAIL "No do_spin_loop processes found on CPU${CPU_TO_TEST}"
-	else
-		tst_resm TPASS "$NUM do_spin_loop processes found on CPU${CPU_TO_TEST}"
+	ps -o psr -o command --no-headers -C cpuhotplug_do_spin_loop
+	if [ $? -ne 0 ]; then
+		tst_brkm TBROK "No cpuhotplug_do_spin_loop processes \
+			found on any processor"
+	fi
+	NUM=`ps -o psr -o command --no-headers -C cpuhotplug_do_spin_loop \
+		| sed -e "s/^ *//" | cut -d' ' -f 1 | grep "^${CPU_TO_TEST}$" \
+		| wc -l`
+	if [ $NUM -lt 1 ]; then
+		tst_resm TFAIL "No cpuhotplug_do_spin_loop processes found on \
+			CPU${CPU_TO_TEST}"
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
index 3e84354..dc2f5f5 100755
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
-. $LHCS_PATH/include/testsuite.fns
-. $LHCS_PATH/include/hotplug.fns
+. test.sh
+. testsuite.sh
+. hotplug.sh
 
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
index e64b91c..adb386b 100755
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
-. $LHCS_PATH/include/testsuite.fns
-. $LHCS_PATH/include/hotplug.fns
+. test.sh
+. testsuite.sh
+. hotplug.sh
 
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
index 0778fa0..4bf3699 100755
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
-. $LHCS_PATH/include/testsuite.fns
-. $LHCS_PATH/include/hotplug.fns
+. test.sh
+. testsuite.sh
+. hotplug.sh
 
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
index cd45677..4bc4e38 100755
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
-. $LHCS_PATH/include/testsuite.fns
-. $LHCS_PATH/include/hotplug.fns
+. test.sh
+. testsuite.sh
+. hotplug.sh
 
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
 
-$LHCS_PATH/tools/do_kcompile_loop $KERNEL_DIR > /dev/null 2>&1 &
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
diff --git a/testcases/kernel/hotplug/cpu_hotplug/include/hotplug.fns b/testcases/kernel/hotplug/cpu_hotplug/include/hotplug.fns
deleted file mode 100644
index 6b3c933..0000000
--- a/testcases/kernel/hotplug/cpu_hotplug/include/hotplug.fns
+++ /dev/null
@@ -1,202 +0,0 @@
-#!/bin/sh
-
-# hotplug.fns - Collection of functions for hotplugging
-# operations.
-
-# Routines in this library are set up to allow timing to be done
-# by defining $TIME to a timing command.
-TIME=${TIME:-""}
-
-# get_all_irqs()
-#
-#  Gets list of all available IRQs in the system
-#
-get_all_irqs()
-{
-    echo `egrep [0-9]+: /proc/interrupts | cut -d ':' -f 1`
-    return
-}
-
-# migrate_irq(CPU, IRQS)
-#
-#  Sets the smp_affinity for the list of $IRQS to the given
-#  CPU number
-#
-migrate_irq()
-{
-    CPU=${1#cpu}
-    MASK=$((1<<${CPU}))
-    IRQS=$2
-    for irq in ${IRQS}
-      do
-      echo $MASK > /proc/irq/${irq}/smp_affinity || \
-        tst_resm TINFO "It is NOT permitted to change the IRQ $irq smp_affinity"
-    done
-}
-
-
-# get_affinity(PID)
-#
-#  Echos the CPU affinity for the given process ID to stdout
-#
-get_affinity_mask()
-{
-    AFFINITY=`taskset -p ${1}`
-    echo ${AFFINITY}
-    return
-}
-
-# set_affinity(PID, CPU)
-#
-#  Sets the affinity for the given PID to the specified CPU.
-#
-set_affinity()
-{
-    PID="$1"
-    CPU="$2"
-    MASK=$((1<<${CPU_TO_TEST}))
-    `taskset -p ${MASK} ${PID} > /dev/null 2>&1`
-    return $?
-}
-
-# online_cpu(CPU)
-#
-#  Onlines the given CPU.  Returns a true value if it was able
-#  to perform the online operation successfully, false otherwise.
-#
-#  $CPU should either be a specific number like 4, or the cpu name,
-#  as in 'cpu4'.
-#
-online_cpu()
-{
-    CPU=${1#cpu}
-    if [ ! -w /sys/devices/system/cpu/cpu${CPU}/online ]; then
-        return 1
-    fi
-    $TIME echo 1 > /sys/devices/system/cpu/cpu${CPU}/online
-    RC=$?
-    report_timing "Online cpu ${CPU}"
-    return $RC
-}
-
-
-# offline_cpu(CPU)
-#
-#  Offlines the given CPU.  Returns a true value if it was able
-#  to perform the offline operation successfully, false otherwise.
-#
-offline_cpu()
-{
-    CPU=${1#cpu}
-    if [ ! -w /sys/devices/system/cpu/cpu${CPU}/online ]; then
-        return 1
-    fi
-    $TIME echo 0 > /sys/devices/system/cpu/cpu${CPU}/online
-    RC=$?
-    report_timing "Offline cpu ${CPU}"
-    return $RC
-}
-
-
-# get_all_cpus()
-#
-#  Prints a list of all available CPUs, regardless of whether they're
-#  currently online or offline.
-#
-#  This routine will work even if the CPUs are not hotpluggable, however
-#  it requires you have sysfs enabled in the kernel.
-#
-get_all_cpus()
-{
-    [ -d /sys/devices/system/cpu/cpu0 ] || return 1
-    ls -dr /sys/devices/system/cpu/cpu[0-9]* | \
-        sed "s/\/sys\/devices\/system\/cpu\///g" || return 2
-}
-
-
-# get_all_cpu_states()
-#
-#  Collects the current online/offline state of CPUs in the
-#  system, printing it in a format that can be passed to
-#  set_all_cpu_states() later.
-#
-get_all_cpu_states()
-{
-    echo `cd /sys/devices/system/cpu/ && grep '' */online | sed -e 's/\/online//'`
-    return
-}
-
-# set_all_cpu_states(STATES)
-#
-#  Sets all of the CPU states according to $STATE, which must be
-#  of the form "cpuX:Y", where X is the CPU number and Y its state.
-#  Each must be on a separate line.
-#
-set_all_cpu_states()
-{
-    for cpu_state in $STATE; do
-        cpu=`echo $c | cut -d: -f 1`
-        state=`echo $c | cut -d: -f 1`
-        if [ $state = 1 ]; then
-            echo "# Re-onlining $cpu"
-            online_cpu $cpu
-        else
-            echo "# Re-offlining $cpu"
-            offline_cpu $cpu
-        fi
-    done
-}
-
-
-# get_online_cpus()
-#
-#  Prints a list of all CPUs currently online.  This function only
-#  works if the system's CPUs have hotplug capabilities
-#
-get_online_cpus()
-{
-    echo `cd /sys/devices/system/cpu/ && grep 1 */online | cut -d '/' -f 1`
-    return
-}
-
-
-# get_offline_cpus()
-#
-#  Prints a list of all CPUs currently offline.  This function only
-#  works if the system's CPUs have hotplug capabilities
-#
-get_offline_cpus()
-{
-    echo `cd /sys/devices/system/cpu/ && grep 0 */online | cut -d '/' -f 1`
-    return
-}
-
-# cpu_is_valid(CPU)
-#
-#  Checks to see if the given CPU number is available for hotplugging
-#  in the system.  Returns 0 if the CPU is available, 1 otherwise.
-#
-cpu_is_valid()
-{
-    CPU=${1#cpu}
-    echo "CPU is $CPU"
-    cat /sys/devices/system/cpu/cpu${CPU}/online > /dev/null 2>&1
-    return $?
-}
-
-
-# cpu_is_online(CPU)
-#
-#  Returns a 0 value if the given CPU number is currently online,
-#  1 otherwise.  This function requires the system's CPUs have
-#  hotplug capabilities.
-#
-cpu_is_online()
-{
-    CPU=${1#cpu}
-    if [ `cat /sys/devices/system/cpu/cpu${CPU}/online` = "1" ]; then
-        return 0
-    else
-        return 1
-    fi
-}
diff --git a/testcases/kernel/hotplug/cpu_hotplug/include/hotplug.sh b/testcases/kernel/hotplug/cpu_hotplug/include/hotplug.sh
new file mode 100644
index 0000000..8922c24
--- /dev/null
+++ b/testcases/kernel/hotplug/cpu_hotplug/include/hotplug.sh
@@ -0,0 +1,203 @@
+#!/bin/sh
+
+# hotplug.sh - Collection of functions for hotplugging
+# operations.
+
+# Routines in this library are set up to allow timing to be done
+# by defining $TIME to a timing command.
+TIME=${TIME:-""}
+
+# get_all_irqs()
+#
+#  Gets list of all available IRQs in the system
+#
+get_all_irqs()
+{
+    echo `egrep [0-9]+: /proc/interrupts | cut -d ':' -f 1`
+    return
+}
+
+# migrate_irq(CPU, IRQS)
+#
+#  Sets the smp_affinity for the list of $IRQS to the given
+#  CPU number
+#
+migrate_irq()
+{
+    CPU=${1#cpu}
+    MASK=$((1<<${CPU}))
+    IRQS=$2
+    for irq in ${IRQS}
+      do
+      echo $MASK > /proc/irq/${irq}/smp_affinity || \
+        tst_resm TINFO "It is NOT permitted to change the IRQ $irq smp_affinity"
+    done
+}
+
+
+# get_affinity(PID)
+#
+#  Echos the CPU affinity for the given process ID to stdout
+#
+get_affinity_mask()
+{
+    AFFINITY=`taskset -p ${1}`
+    echo ${AFFINITY}
+    return
+}
+
+# set_affinity(PID, CPU)
+#
+#  Sets the affinity for the given PID to the specified CPU.
+#
+set_affinity()
+{
+    PID="$1"
+    CPU="$2"
+    MASK=$((1<<${CPU_TO_TEST}))
+    `taskset -p ${MASK} ${PID} > /dev/null 2>&1`
+    return $?
+}
+
+# online_cpu(CPU)
+#
+#  Onlines the given CPU.  Returns a true value if it was able
+#  to perform the online operation successfully, false otherwise.
+#
+#  $CPU should either be a specific number like 4, or the cpu name,
+#  as in 'cpu4'.
+#
+online_cpu()
+{
+    CPU=${1#cpu}
+    if [ ! -w /sys/devices/system/cpu/cpu${CPU}/online ]; then
+        return 1
+    fi
+    $TIME echo 1 > /sys/devices/system/cpu/cpu${CPU}/online
+    RC=$?
+    report_timing "Online cpu ${CPU}"
+    return $RC
+}
+
+
+# offline_cpu(CPU)
+#
+#  Offlines the given CPU.  Returns a true value if it was able
+#  to perform the offline operation successfully, false otherwise.
+#
+offline_cpu()
+{
+    CPU=${1#cpu}
+    if [ ! -w /sys/devices/system/cpu/cpu${CPU}/online ]; then
+        return 1
+    fi
+    $TIME echo 0 > /sys/devices/system/cpu/cpu${CPU}/online
+    RC=$?
+    report_timing "Offline cpu ${CPU}"
+    return $RC
+}
+
+
+# get_all_cpus()
+#
+#  Prints a list of all available CPUs, regardless of whether they're
+#  currently online or offline.
+#
+#  This routine will work even if the CPUs are not hotpluggable, however
+#  it requires you have sysfs enabled in the kernel.
+#
+get_all_cpus()
+{
+    [ -d /sys/devices/system/cpu/cpu0 ] || return 1
+    ls -dr /sys/devices/system/cpu/cpu[0-9]* | \
+        sed "s/\/sys\/devices\/system\/cpu\///g" || return 2
+}
+
+
+# get_all_cpu_states()
+#
+#  Collects the current online/offline state of CPUs in the
+#  system, printing it in a format that can be passed to
+#  set_all_cpu_states() later.
+#
+get_all_cpu_states()
+{
+    echo `cd /sys/devices/system/cpu/ && grep '' */online | sed \
+		-e 's/\/online//'`
+    return
+}
+
+# set_all_cpu_states(STATES)
+#
+#  Sets all of the CPU states according to $STATE, which must be
+#  of the form "cpuX:Y", where X is the CPU number and Y its state.
+#  Each must be on a separate line.
+#
+set_all_cpu_states()
+{
+    for cpu_state in $STATE; do
+        cpu=`echo $c | cut -d: -f 1`
+        state=`echo $c | cut -d: -f 1`
+        if [ $state = 1 ]; then
+            echo "# Re-onlining $cpu"
+            online_cpu $cpu
+        else
+            echo "# Re-offlining $cpu"
+            offline_cpu $cpu
+        fi
+    done
+}
+
+
+# get_online_cpus()
+#
+#  Prints a list of all CPUs currently online.  This function only
+#  works if the system's CPUs have hotplug capabilities
+#
+get_online_cpus()
+{
+    echo `cd /sys/devices/system/cpu/ && grep 1 */online | cut -d '/' -f 1`
+    return
+}
+
+
+# get_offline_cpus()
+#
+#  Prints a list of all CPUs currently offline.  This function only
+#  works if the system's CPUs have hotplug capabilities
+#
+get_offline_cpus()
+{
+    echo `cd /sys/devices/system/cpu/ && grep 0 */online | cut -d '/' -f 1`
+    return
+}
+
+# cpu_is_valid(CPU)
+#
+#  Checks to see if the given CPU number is available for hotplugging
+#  in the system.  Returns 0 if the CPU is available, 1 otherwise.
+#
+cpu_is_valid()
+{
+    CPU=${1#cpu}
+    echo "CPU is $CPU"
+    cat /sys/devices/system/cpu/cpu${CPU}/online > /dev/null 2>&1
+    return $?
+}
+
+
+# cpu_is_online(CPU)
+#
+#  Returns a 0 value if the given CPU number is currently online,
+#  1 otherwise.  This function requires the system's CPUs have
+#  hotplug capabilities.
+#
+cpu_is_online()
+{
+    CPU=${1#cpu}
+    if [ `cat /sys/devices/system/cpu/cpu${CPU}/online` = "1" ]; then
+        return 0
+    else
+        return 1
+    fi
+}
diff --git a/testcases/kernel/hotplug/cpu_hotplug/include/testsuite.fns b/testcases/kernel/hotplug/cpu_hotplug/include/testsuite.fns
deleted file mode 100644
index 59103c2..0000000
--- a/testcases/kernel/hotplug/cpu_hotplug/include/testsuite.fns
+++ /dev/null
@@ -1,170 +0,0 @@
-############################################################
-## Convenience functions for reporting, asserting, etc.   ##
-############################################################
-
-# warn(TEXT)
-#
-#  Issues a warning message to stderr
-#
-warn()
-{
-    echo $1 1>&2
-}
-
-# assert()
-#
-#  Basic assertion support.  Use it like this:
-#
-#   a=5
-#   b=4
-#   condition="$a -lt $b"     # Error message and exit from script.
-#                             #  Try setting "condition" to something else,
-#                             #+ and see what happens.
-#
-#   assert "$condition" $LINENO
-#
-# Note that $LINENO is a built-in
-#
-assert ()                 #  If condition false,
-{                         #+ exit from script with error message.
-  E_PARAM_ERR=98
-  E_ASSERT_FAILED=99
-
-
-  if [ -z "$2" ]          # Not enough parameters passed.
-  then
-    return $E_PARAM_ERR   # No damage done.
-  fi
-
-  lineno=$2
-
-  if [ ! $1 ]
-  then
-    echo "Assertion failed:  \"$1\""
-    echo "File \"$0\", line $lineno"
-    exit $E_ASSERT_FAILED
-  # else
-  #   return
-  #   and continue executing script.
-  fi
-}
-
-############################################################
-## Process management                                     ##
-############################################################
-
-# pid_is_valid(PID)
-#
-#  Checks if the given $PID is still running.  Returns a true value if
-#  it is, false otherwise.
-#
-pid_is_valid()
-{
-    PID=$1
-    ps --pid ${PID} --no-header | grep ${PID}
-    return $?
-}
-
-# kill_pid(PID)
-#
-#  Forcibly kills the process ID and prevents it from
-#  displaying any messages (to stdout, stderr, or otherwise)
-#
-kill_pid()
-{
-    PID=$1
-    disown $PID
-    kill -9 $PID > /dev/null 2>&1
-}
-
-############################################################
-## Timing                                                 ##
-############################################################
-
-# Routines in this library are set up to allow timing to be done
-# by defining $TIME to a timing command.  You can define your
-# own handler by defining $TIME before or after including this
-# library.
-TIME=${TIME:-""}
-
-# Allows overriding the filename to use for storing time
-# measurements.  Required in order to
-TIME_TMP_FILE=${TIME_TMP_FILE:-"${TMP:-/tmp}/cpu_$$"}
-
-# perform_timings()
-#
-#  This turns on timings for operations that support timing
-#  via the $TIME variable.  It does this by setting $TIME to
-#  a general purpose time command.
-set_timing_on()
-{
-    TIME="/usr/bin/time -o $TIME_TMP_FILE -f \"%e\""
-}
-
-report_timing()
-{
-    MSG=${1:-"perform operation"}
-    if [ ! -z "${TIME}" ]; then
-        TM=`cat $TIME_TMP_FILE`
-        echo "Time to ${MSG} : $TM"
-    fi
-}
-
-############################################################
-## Interrupt handling and cleanup                         ##
-############################################################
-
-# do_clean()
-#
-#  Virtual function called by do_intr().  Override this to
-#  provide custom cleanup handling.
-#
-do_clean()
-{
-    return 0
-}
-
-# do_testsuite_clean()
-#
-#  Internal routine to do cleanup specific to other routines
-#  in this testsuite.  You may override this routine if you
-#  do not want this behavior.
-#
-do_testsuite_clean()
-{
-    /bin/rm -rf $TIME_TMP_FILE
-}
-
-# exit_clean(EXIT_CODE)
-#
-#  Replacement for exit command.  Prints the date, then calls do_clean
-#  and exits with the given $EXIT_CODE, or 0 if none specified.
-#
-exit_clean()
-{
-    EXIT_CODE=${1:-0}
-    date
-    do_clean
-    exit $EXIT_CODE
-}
-
-# do_intr()
-#
-#  Handler for trapped interrupts (i.e., signals 1 2 15).
-#
-#  This will result in a call do do_clean() when the user
-#  interrupts the test, allowing you to do whatever final
-#  cleanup work is needed (removing tmp files, restoring
-#  resources to initial states, etc.)  This routine will
-#  exit with error code 1 when done.
-#
-do_intr()
-{
-    echo "## Cleaning up... user interrupt"
-    do_testsuite_clean
-    do_clean
-    exit 1
-}
-
-trap "do_intr" 1 2 15
-
diff --git a/testcases/kernel/hotplug/cpu_hotplug/include/testsuite.sh b/testcases/kernel/hotplug/cpu_hotplug/include/testsuite.sh
new file mode 100644
index 0000000..2d0166c
--- /dev/null
+++ b/testcases/kernel/hotplug/cpu_hotplug/include/testsuite.sh
@@ -0,0 +1,171 @@
+#!/bin/sh
+############################################################
+## Convenience functions for reporting, asserting, etc.   ##
+############################################################
+
+# warn(TEXT)
+#
+#  Issues a warning message to stderr
+#
+warn()
+{
+    echo $1 1>&2
+}
+
+# assert()
+#
+#  Basic assertion support.  Use it like this:
+#
+#   a=5
+#   b=4
+#   condition="$a -lt $b"     # Error message and exit from script.
+#                             #  Try setting "condition" to something else,
+#                             #+ and see what happens.
+#
+#   assert "$condition" $LINENO
+#
+# Note that $LINENO is a built-in
+#
+assert ()                 #  If condition false,
+{                         #+ exit from script with error message.
+  E_PARAM_ERR=98
+  E_ASSERT_FAILED=99
+
+
+  if [ -z "$2" ]          # Not enough parameters passed.
+  then
+    return $E_PARAM_ERR   # No damage done.
+  fi
+
+  lineno=$2
+
+  if [ ! $1 ]
+  then
+    echo "Assertion failed:  \"$1\""
+    echo "File \"$0\", line $lineno"
+    exit $E_ASSERT_FAILED
+  # else
+  #   return
+  #   and continue executing script.
+  fi
+}
+
+############################################################
+## Process management                                     ##
+############################################################
+
+# pid_is_valid(PID)
+#
+#  Checks if the given $PID is still running.  Returns a true value if
+#  it is, false otherwise.
+#
+pid_is_valid()
+{
+    PID=$1
+    ps --pid ${PID} --no-header | grep ${PID}
+    return $?
+}
+
+# kill_pid(PID)
+#
+#  Forcibly kills the process ID and prevents it from
+#  displaying any messages (to stdout, stderr, or otherwise)
+#
+kill_pid()
+{
+    PID=$1
+    disown $PID
+    kill -9 $PID > /dev/null 2>&1
+}
+
+############################################################
+## Timing                                                 ##
+############################################################
+
+# Routines in this library are set up to allow timing to be done
+# by defining $TIME to a timing command.  You can define your
+# own handler by defining $TIME before or after including this
+# library.
+TIME=${TIME:-""}
+
+# Allows overriding the filename to use for storing time
+# measurements.  Required in order to
+TIME_TMP_FILE=${TIME_TMP_FILE:-"${TMP:-/tmp}/cpu_$$"}
+
+# perform_timings()
+#
+#  This turns on timings for operations that support timing
+#  via the $TIME variable.  It does this by setting $TIME to
+#  a general purpose time command.
+set_timing_on()
+{
+    TIME="/usr/bin/time -o $TIME_TMP_FILE -f \"%e\""
+}
+
+report_timing()
+{
+    MSG=${1:-"perform operation"}
+    if [ ! -z "${TIME}" ]; then
+        TM=`cat $TIME_TMP_FILE`
+        echo "Time to ${MSG} : $TM"
+    fi
+}
+
+############################################################
+## Interrupt handling and cleanup                         ##
+############################################################
+
+# do_clean()
+#
+#  Virtual function called by do_intr().  Override this to
+#  provide custom cleanup handling.
+#
+do_clean()
+{
+    return 0
+}
+
+# do_testsuite_clean()
+#
+#  Internal routine to do cleanup specific to other routines
+#  in this testsuite.  You may override this routine if you
+#  do not want this behavior.
+#
+do_testsuite_clean()
+{
+    /bin/rm -rf $TIME_TMP_FILE
+}
+
+# exit_clean(EXIT_CODE)
+#
+#  Replacement for exit command.  Prints the date, then calls do_clean
+#  and exits with the given $EXIT_CODE, or 0 if none specified.
+#
+exit_clean()
+{
+    EXIT_CODE=${1:-0}
+    date
+    do_clean
+    exit $EXIT_CODE
+}
+
+# do_intr()
+#
+#  Handler for trapped interrupts (i.e., signals 1 2 15).
+#
+#  This will result in a call do do_clean() when the user
+#  interrupts the test, allowing you to do whatever final
+#  cleanup work is needed (removing tmp files, restoring
+#  resources to initial states, etc.)  This routine will
+#  exit with error code 1 when done.
+#
+do_intr()
+{
+    echo "## Cleaning up... user interrupt"
+    do_testsuite_clean
+    do_clean
+    exit 1
+}
+
+trap "do_intr" 1 2 15
+
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
diff --git a/testcases/kernel/hotplug/cpu_hotplug/tools/cpuhotplug_do_disk_write_loop b/testcases/kernel/hotplug/cpu_hotplug/tools/cpuhotplug_do_disk_write_loop
new file mode 100755
index 0000000..9e28591
--- /dev/null
+++ b/testcases/kernel/hotplug/cpu_hotplug/tools/cpuhotplug_do_disk_write_loop
@@ -0,0 +1,19 @@
+#!/bin/sh
+
+TMP_FILE=${TMP:-/tmp}/cpu_$$
+TM_DLY=1    # Time delay before start of entire new cycle.
+
+
+CNT=0
+while :
+do
+
+	: $(( CNT += 1 ))
+	echo "Loop Count $CNT"
+
+	echo 1 > $TMP_FILE
+	# TODO:  Verify writes are complete and correct
+
+	sleep $TM_DLY
+
+done
diff --git a/testcases/kernel/hotplug/cpu_hotplug/tools/cpuhotplug_do_kcompile_loop b/testcases/kernel/hotplug/cpu_hotplug/tools/cpuhotplug_do_kcompile_loop
new file mode 100755
index 0000000..d4b32c2
--- /dev/null
+++ b/testcases/kernel/hotplug/cpu_hotplug/tools/cpuhotplug_do_kcompile_loop
@@ -0,0 +1,21 @@
+#!/bin/sh
+
+# Must be run from a kernel source code directory
+
+echo $$
+
+KERNEL_DIR=${1:-/usr/src/linux}
+
+if [ ! -d $KERNEL_DIR ]; then
+	echo "${0##*/}: ERROR: kernel directory - $KERNEL_DIR - does not exist"
+	exit 1
+fi
+
+cd $KERNEL_DIR || exit $?
+
+while :
+do
+	make mrproper
+	make defconfig
+	make -j20 bzImage
+done
diff --git a/testcases/kernel/hotplug/cpu_hotplug/tools/cpuhotplug_do_spin_loop b/testcases/kernel/hotplug/cpu_hotplug/tools/cpuhotplug_do_spin_loop
new file mode 100755
index 0000000..a5c05cb
--- /dev/null
+++ b/testcases/kernel/hotplug/cpu_hotplug/tools/cpuhotplug_do_spin_loop
@@ -0,0 +1,8 @@
+#!/bin/sh
+
+echo $$
+
+while :
+do
+	NOOP=1
+done
diff --git a/testcases/kernel/hotplug/cpu_hotplug/tools/cpuhotplug_report_proc_interrupts b/testcases/kernel/hotplug/cpu_hotplug/tools/cpuhotplug_report_proc_interrupts
new file mode 100755
index 0000000..59a6bbd
--- /dev/null
+++ b/testcases/kernel/hotplug/cpu_hotplug/tools/cpuhotplug_report_proc_interrupts
@@ -0,0 +1,53 @@
+#!/usr/bin/perl
+
+use strict;
+
+sub compare_proc_interrupts {
+    my ($run1, $run2) = @_;
+
+    my $printed_header;
+    foreach my $irq (sort keys %{$run1}) {
+        if (! $printed_header) {
+            printf "%-8s ", "IRQ";
+            foreach my $cpu (sort keys %{$run1->{$irq}}) {
+                printf "%-5s ", $cpu;
+            }
+            print "\n";
+            $printed_header = 1;
+        }
+        printf "%-8s ", $irq;
+        foreach my $cpu (sort keys %{$run1->{$irq}}) {
+            printf "%-5s ", $run2->{$irq}->{$cpu} - $run1->{$irq}->{$cpu};
+        }
+        print "\n";
+    }
+}
+
+
+sub parse_proc_interrupts {
+    my $content = shift;
+    my @cpus;
+    my %run;
+
+    foreach my $line (split /\n/, $content) {
+        $line =~ s/^\s+//;
+        $line =~ s/\s+$//;
+
+        if (! @cpus) {
+            @cpus = split /\s+/, $line;
+        } else {
+            my @items = split /\s+/, $line;
+            my $irq = shift @items;
+            $irq =~ s/:$//;
+            foreach my $cpu (@cpus) {
+                $run{"IRQ$irq"}->{"$cpu"} = shift @items;
+            }
+        }
+    }
+    return \%run;
+}
+
+my $run1 = parse_proc_interrupts(shift @ARGV);
+my $run2 = parse_proc_interrupts(shift @ARGV);
+
+compare_proc_interrupts($run1, $run2);
diff --git a/testcases/kernel/hotplug/cpu_hotplug/tools/do_disk_write_loop b/testcases/kernel/hotplug/cpu_hotplug/tools/do_disk_write_loop
deleted file mode 100755
index 9e28591..0000000
--- a/testcases/kernel/hotplug/cpu_hotplug/tools/do_disk_write_loop
+++ /dev/null
@@ -1,19 +0,0 @@
-#!/bin/sh
-
-TMP_FILE=${TMP:-/tmp}/cpu_$$
-TM_DLY=1    # Time delay before start of entire new cycle.
-
-
-CNT=0
-while :
-do
-
-	: $(( CNT += 1 ))
-	echo "Loop Count $CNT"
-
-	echo 1 > $TMP_FILE
-	# TODO:  Verify writes are complete and correct
-
-	sleep $TM_DLY
-
-done
diff --git a/testcases/kernel/hotplug/cpu_hotplug/tools/do_kcompile_loop b/testcases/kernel/hotplug/cpu_hotplug/tools/do_kcompile_loop
deleted file mode 100755
index d4b32c2..0000000
--- a/testcases/kernel/hotplug/cpu_hotplug/tools/do_kcompile_loop
+++ /dev/null
@@ -1,21 +0,0 @@
-#!/bin/sh
-
-# Must be run from a kernel source code directory
-
-echo $$
-
-KERNEL_DIR=${1:-/usr/src/linux}
-
-if [ ! -d $KERNEL_DIR ]; then
-	echo "${0##*/}: ERROR: kernel directory - $KERNEL_DIR - does not exist"
-	exit 1
-fi
-
-cd $KERNEL_DIR || exit $?
-
-while :
-do
-	make mrproper
-	make defconfig
-	make -j20 bzImage
-done
diff --git a/testcases/kernel/hotplug/cpu_hotplug/tools/do_spin_loop b/testcases/kernel/hotplug/cpu_hotplug/tools/do_spin_loop
deleted file mode 100755
index a5c05cb..0000000
--- a/testcases/kernel/hotplug/cpu_hotplug/tools/do_spin_loop
+++ /dev/null
@@ -1,8 +0,0 @@
-#!/bin/sh
-
-echo $$
-
-while :
-do
-	NOOP=1
-done
diff --git a/testcases/kernel/hotplug/cpu_hotplug/tools/report_proc_interrupts b/testcases/kernel/hotplug/cpu_hotplug/tools/report_proc_interrupts
deleted file mode 100755
index 59a6bbd..0000000
--- a/testcases/kernel/hotplug/cpu_hotplug/tools/report_proc_interrupts
+++ /dev/null
@@ -1,53 +0,0 @@
-#!/usr/bin/perl
-
-use strict;
-
-sub compare_proc_interrupts {
-    my ($run1, $run2) = @_;
-
-    my $printed_header;
-    foreach my $irq (sort keys %{$run1}) {
-        if (! $printed_header) {
-            printf "%-8s ", "IRQ";
-            foreach my $cpu (sort keys %{$run1->{$irq}}) {
-                printf "%-5s ", $cpu;
-            }
-            print "\n";
-            $printed_header = 1;
-        }
-        printf "%-8s ", $irq;
-        foreach my $cpu (sort keys %{$run1->{$irq}}) {
-            printf "%-5s ", $run2->{$irq}->{$cpu} - $run1->{$irq}->{$cpu};
-        }
-        print "\n";
-    }
-}
-
-
-sub parse_proc_interrupts {
-    my $content = shift;
-    my @cpus;
-    my %run;
-
-    foreach my $line (split /\n/, $content) {
-        $line =~ s/^\s+//;
-        $line =~ s/\s+$//;
-
-        if (! @cpus) {
-            @cpus = split /\s+/, $line;
-        } else {
-            my @items = split /\s+/, $line;
-            my $irq = shift @items;
-            $irq =~ s/:$//;
-            foreach my $cpu (@cpus) {
-                $run{"IRQ$irq"}->{"$cpu"} = shift @items;
-            }
-        }
-    }
-    return \%run;
-}
-
-my $run1 = parse_proc_interrupts(shift @ARGV);
-my $run2 = parse_proc_interrupts(shift @ARGV);
-
-compare_proc_interrupts($run1, $run2);
-- 
1.9.3


------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
