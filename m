From: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon, 25 Jan 2021 14:17:46 +0100
Subject: [LTP] [PATCH] memcg/functional: Convert to newlib
Message-ID: <20210125131746.74630-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>

This is an intermediate step, to allow further improvements to tests in
memcg/functional. The next steps are
 - fixing synchronization between shell and memcg_process: At the moment
   signals may get lost (especially in warmup), because the memcg_process
   is signaled twice without any time in between. If the process is not
   fast enough, the second signal can get lost. I am already working on
   something for a better synchronization.
 - Some tests fail always (at least for me). This can be due to the fact,
   that memory.use_hierarchy cannot be disabled easily on systems using
   systemd, because it enables it and ads lots of subgroups.
   (Disableing is only possible, if there are no subgroups).
   I added TCONF for some tests, that obviously failed because of that,
   but I am not sure for the remaining errors
   The second reason for failed tests is the fact, that the value in
   memory.limit_in_bytes is not exact. The kernel documentation does not
   say how this actually works, but I guess it is baed on per_cpu_counters.
   The checks will propably require an epsilon, but that needs some
   investigation in the kernel code.

In addtion to converting the tests to the new library:
 - Moved non-shared code from memcg_lib to the respective test files
 - Removed unused test_hugepage from memcg_lib

But even in this state, I think it should be merged, because it will simplify
review for upcomming changes.

BTW: This was the last shell-user of TST_CHECKPOINT. In theory it could
be removed from test.sh, if we want to gradually strip down unused code,
until the whole file is gone.

J?rg

---
 .../memcg/functional/memcg_failcnt.sh         |  79 +--
 .../memcg/functional/memcg_force_empty.sh     |  64 +-
 .../controllers/memcg/functional/memcg_lib.sh | 559 ++++++------------
 .../memcg/functional/memcg_limit_in_bytes.sh  | 106 ++--
 .../memcg_max_usage_in_bytes_test.sh          | 111 ++--
 .../memcg_memsw_limit_in_bytes_test.sh        |  85 +--
 .../memcg_move_charge_at_immigrate_test.sh    | 101 ++--
 .../memcg/functional/memcg_stat_rss.sh        |  66 +--
 .../memcg/functional/memcg_stat_test.sh       |  93 ++-
 .../memcg/functional/memcg_subgroup_charge.sh |  79 +--
 .../functional/memcg_usage_in_bytes_test.sh   |  66 +--
 .../functional/memcg_use_hierarchy_test.sh    |  59 +-
 12 files changed, 561 insertions(+), 907 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh b/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh
index d5034a514..774e69d04 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh
@@ -1,58 +1,39 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2009 FUJITSU LIMITED
+# Copyright (c) 2018-2019 ARM Ltd. All Rights Reserved.
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+#
+# Author: Li Zefan <lizf@cn.fujitsu.com>
+# Restructure for LTP: Shi Weihua <shiwh@cn.fujitsu.com>
+# Added memcg enable/disable functionality: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
 
-################################################################################
-##                                                                            ##
-## Copyright (c) 2009 FUJITSU LIMITED                                         ##
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
-## along with this program;  if not, write to the Free Software Foundation,   ##
-## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
-##                                                                            ##
-## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
-## Restructure for LTP: Shi Weihua <shiwh@cn.fujitsu.com>                     ##
-## Added memcg enable/disable functinality: Rishikesh K Rajak		      ##
-##						<risrajak@linux.vnet.ibm.com  ##
-##                                                                            ##
-################################################################################
-
-TCID="memcg_failcnt"
-TST_TOTAL=3
-
+MEMCG_TESTFUNC=test
+MEMCG_SHMMAX=1
+TST_TEST_DATA="--mmap-anon --mmap-file --shm"
 . memcg_lib.sh
 
-# Test memory.failcnt
-testcase_1()
-{
-	echo $PAGESIZE > memory.limit_in_bytes
-	malloc_free_memory "--mmap-anon" $(($PAGESIZE*2))
-	test_failcnt "memory.failcnt"
-}
+MEMORY_LIMIT=$PAGESIZE
+MEMORY_TO_ALLOCATE=$((MEMORY_LIMIT * 2))
 
-testcase_2()
+test()
 {
-	echo $PAGESIZE > memory.limit_in_bytes
-	malloc_free_memory "--mmap-file" $(($PAGESIZE*2))
-	test_failcnt "memory.failcnt"
-}
+	echo $MEMORY_LIMIT > memory.limit_in_bytes
 
-testcase_3()
-{
-	echo $PAGESIZE > memory.limit_in_bytes
-	malloc_free_memory "--shm" $(($PAGESIZE*2))
-	test_failcnt "memory.failcnt"
+	start_memcg_process $2 -s ${MEMORY_TO_ALLOCATE}
+	echo $MEMCG_PROCESS_PID > tasks
+
+	signal_memcg_process ${MEMORY_TO_ALLOCATE}
+	signal_memcg_process ${MEMORY_TO_ALLOCATE}
+
+	stop_memcg_process
+
+	failcnt=$(cat memory.failcnt)
+	if [ $failcnt -gt 0 ]; then
+		tst_res TPASS "memory.failcnt is $failcnt, > 0 as expected"
+	else
+		tst_res TFAIL "memory.failcnt is $failcnt, <= 0 expected"
+	fi
 }
 
-shmmax_setup
-LOCAL_CLEANUP=shmmax_cleanup
-run_tests
-tst_exit
+tst_run
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_force_empty.sh b/testcases/kernel/controllers/memcg/functional/memcg_force_empty.sh
index cb475acff..ce692baf3 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_force_empty.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_force_empty.sh
@@ -1,44 +1,25 @@
 #!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) 2009 FUJITSU LIMITED                                         ##
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
-## along with this program;  if not, write to the Free Software Foundation,   ##
-## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
-##                                                                            ##
-## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
-## Restructure for LTP: Shi Weihua <shiwh@cn.fujitsu.com>                     ##
-## Added memcg enable/disable functinality: Rishikesh K Rajak		      ##
-##						<risrajak@linux.vnet.ibm.com  ##
-##                                                                            ##
-################################################################################
-
-TCID="memcg_force_empty"
-TST_TOTAL=6
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2009 FUJITSU LIMITED
+# Copyright (c) 2018-2019 ARM Ltd. All Rights Reserved.
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+#
+# Author: Li Zefan <lizf@cn.fujitsu.com>
+# Restructure for LTP: Shi Weihua <shiwh@cn.fujitsu.com>
+# Added memcg enable/disable functionality: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
+
+MEMCG_TESTFUNC=test
+TST_CNT=6
 
 . memcg_lib.sh
 
 # Test memory.force_empty
-testcase_1()
+test1()
 {
-	memcg_process --mmap-anon -s $PAGESIZE &
-	pid=$!
-	TST_CHECKPOINT_WAIT 0
-	echo $pid > tasks
-	signal_memcg_process $pid $PAGESIZE
-	echo $pid > ../tasks
+	start_memcg_process --mmap-anon -s $PAGESIZE
+	echo $MEMCG_PROCESS_PID > tasks
+	signal_memcg_process $PAGESIZE
+	echo $MEMCG_PROCESS_PID > ../tasks
 
 	# This expects that there is swap configured
 	EXPECT_PASS echo 1 \> memory.force_empty
@@ -46,32 +27,31 @@ testcase_1()
 	stop_memcg_process $pid
 }
 
-testcase_2()
+test2()
 {
 	EXPECT_PASS echo 0 \> memory.force_empty
 }
 
-testcase_3()
+test3()
 {
 	EXPECT_PASS echo 1.0 \> memory.force_empty
 }
 
-testcase_4()
+test4()
 {
 	EXPECT_PASS echo 1xx \> memory.force_empty
 }
 
-testcase_5()
+test5()
 {
 	EXPECT_PASS echo xx \> memory.force_empty
 }
 
-testcase_6()
+test6()
 {
 	# writing to non-empty top mem cgroup's force_empty
 	# should return failure
 	EXPECT_FAIL echo 1 \> /dev/memcg/memory.force_empty
 }
 
-run_tests
-tst_exit
+tst_run
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index 22ef4f5e2..fcae07b40 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -1,100 +1,140 @@
 #! /bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) 2012 FUJITSU LIMITED                                         ##
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
-## Author: Peng Haitao <penght@cn.fujitsu.com>                                ##
-##                                                                            ##
-################################################################################
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2012 FUJITSU LIMITED
+# Copyright (c) 2018-2019 ARM Ltd. All Rights Reserved.
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+#
+# Author: Peng Haitao <penght@cn.fujitsu.com>
 
 TST_NEEDS_CHECKPOINTS=1
-. test.sh
+TST_NEEDS_ROOT=1
+TST_NEEDS_TMPDIR=1
+TST_NEEDS_CMDS="killall find kill"
+TST_CLEANUP=memcg_cleanup
+TST_SETUP=memcg_setup
+TST_TESTFUNC=memcg_testfunc
 
-if [ "x$(grep -w memory /proc/cgroups | cut -f4)" != "x1" ]; then
-	tst_brkm TCONF "Kernel does not support the memory resource controller"
-fi
+MEMCG_SHMMAX=${MEMCG_SHMMAX:-0}
+MEMCG_TESTFUNC=${MEMCG_TESTFUNC:-memcg_no_testfunc}
+
+. cgroup_lib.sh
 
 PAGESIZE=$(tst_getconf PAGESIZE)
 if [ $? -ne 0 ]; then
-	tst_brkm TBROK "tst_getconf PAGESIZE failed"
+	tst_brk TBROK "tst_getconf PAGESIZE failed"
 fi
 
-# Check for dependencies
-tst_require_cmds killall
-
 # Post 4.16 kernel updates stat in batch (> 32 pages) every time
 PAGESIZES=$(( $PAGESIZE * 33 ))
 
 HUGEPAGESIZE=$(awk '/Hugepagesize/ {print $2}' /proc/meminfo)
 [ -z $HUGEPAGESIZE ] && HUGEPAGESIZE=0
 HUGEPAGESIZE=$(( $HUGEPAGESIZE * 1024 ))
-orig_memory_use_hierarchy=""
 
-MEMSW_USAGE_FLAG=0
-MEMSW_LIMIT_FLAG=0
+orig_memory_use_hierarchy=
+orig_shmmax=
 
-tst_tmpdir
-TMP_DIR="$PWD"
+memcg_require_memsw()
+{
+	if ! [ -e /dev/memcg/memory.limit_in_bytes ]; then
+		tst_brk TBROK "/dev/memcg must be mounted before calling memcg_require_memsw"
+	fi
+	if ! [ -e /dev/memcg/memory.memsw.limit_in_bytes ]; then
+		tst_brk TCONF "mem+swap is not enabled"
+	fi
+}
 
-cleanup()
+memcg_require_hierarchy_disabled()
 {
-	if [ -n "$LOCAL_CLEANUP" ]; then
-		$LOCAL_CLEANUP
+	if [ ! -e "/dev/memcg/memory.use_hierarchy" ]; then
+		tst_brk TBROK "/dev/memcg must be mounted before calling memcg_require_hierarchy_disabled"
+	fi
+	if [ $(cat /dev/memcg/memory.use_hierarchy) -eq 1 ]; then
+		tst_brk TCONF "Test requires root cgroup memory.use_hierarchy=0"
 	fi
+}
 
-	killall -9 memcg_process 2> /dev/null
-	wait
+memcg_setup()
+{
+	if ! is_cgroup_subsystem_available_and_enabled "memory"; then
+		tst_brk TCONF "Either kernel does not support Memory Resource Controller or feature not enabled"
+	fi
 
-	cd "$TMP_DIR"
+	# Setup IPC
+	LTP_IPC_PATH="/dev/shm/ltp_${TCID}_$$"
+	LTP_IPC_SIZE=$PAGESIZE
+	ROD_SILENT dd if=/dev/zero of="$LTP_IPC_PATH" bs="$LTP_IPC_SIZE" count=1
+	ROD_SILENT chmod 600 "$LTP_IPC_PATH"
+	export LTP_IPC_PATH
+	# Setup IPC end
 
-	if [ -n "$TEST_ID" -a -d "/dev/memcg/$TEST_ID" ]; then
-		for i in "/dev/memcg/$TEST_ID/"*; do
-			if [ -d "$i" ]; then
-				rmdir "$i"
-			fi
-		done
+	ROD mkdir /dev/memcg
+	ROD mount -t cgroup -omemory memcg /dev/memcg
 
-		rmdir "/dev/memcg/$TEST_ID"
+	# The default value for memory.use_hierarchy is 0 and some of tests
+	# (memcg_stat_test.sh and memcg_use_hierarchy_test.sh) expect it so
+	# while there are distributions (RHEL7U0Beta for example) that sets
+	# it to 1.
+	# Note: If there are already subgroups created it is not possible,
+	# to set this back to 0.
+	# This seems to be the default for all systems using systemd.
+	orig_memory_use_hierarchy=$(cat /dev/memcg/memory.use_hierarchy)
+	if [ -z "$orig_memory_use_hierarchy" ];then
+		tst_res TINFO "cat /dev/memcg/ failed"
+	elif [ "$orig_memory_use_hierarchy" = "0" ];then
+		orig_memory_use_hierarchy=""
+	else
+		echo 0 > /dev/memcg/memory.use_hierarchy 2>/dev/null
+		if [ $? -ne 0 ];then
+			tst_res TINFO "set /dev/memcg/memory.use_hierarchy to 0 failed"
+		fi
+	fi
+
+	[ "$MEMCG_SHMMAX" = "1" ] && shmmax_setup
+}
+
+memcg_cleanup()
+{
+	kill -9 $MEMCG_PROCESS_PID 2> /dev/null
+
+	cd $TST_TMPDIR
+	# In order to remove all subgroups, we have to remove them recursively
+	if [ -e /dev/memcg/ltp_$$ ]; then
+	 	ROD find /dev/memcg/ltp_$$ -depth -type d -delete
 	fi
 
-	if [ -d "/dev/memcg" ]; then
+	if [ -n "$orig_memory_use_hierarchy" ];then
+		echo $orig_memory_use_hierarchy > /dev/memcg/memory.use_hierarchy
+		if [ $? -ne 0 ];then
+			tst_res TINFO "restore /dev/memcg/memory.use_hierarchy failed"
+		fi
+		orig_memory_use_hierarchy=""
+	fi
+
+	if [ -e "/dev/memcg" ]; then
 		umount /dev/memcg
 		rmdir /dev/memcg
 	fi
 
-	tst_rmdir
+	[ "$MEMCG_SHMMAX" = "1" ] && shmmax_cleanup
 }
-TST_CLEANUP=cleanup
 
 shmmax_setup()
 {
 	tst_require_cmds bc
 
-	shmmax=`cat /proc/sys/kernel/shmmax`
-	if [ $(echo "$shmmax < $HUGEPAGESIZE" |bc) -eq 1 ]; then
+	tst_res TINFO "Setting shmmax"
+
+	orig_shmmax=$(cat /proc/sys/kernel/shmmax)
+	if [ $(echo "$orig_shmmax < $HUGEPAGESIZE" | bc) -eq 1 ]; then
 		ROD echo "$HUGEPAGESIZE" \> /proc/sys/kernel/shmmax
 	fi
 }
 
 shmmax_cleanup()
 {
-	if [ -n "$shmmax" ]; then
-		echo "$shmmax" > /proc/sys/kernel/shmmax
+	if [ -n "$orig_shmmax" ]; then
+		echo "$orig_shmmax" > /proc/sys/kernel/shmmax
 	fi
 }
 
@@ -103,27 +143,36 @@ shmmax_cleanup()
 # $2 - Expected size
 check_mem_stat()
 {
+	local item_size
+
 	if [ -e $1 ]; then
-		item_size=`cat $1`
+		item_size=$(cat $1)
 	else
-		item_size=`grep -w $1 memory.stat | cut -d " " -f 2`
+		item_size=$(grep -w $1 memory.stat | cut -d " " -f 2)
 	fi
 
 	if [ "$2" = "$item_size" ]; then
-		tst_resm TPASS "$1 is $2 as expected"
+		tst_res TPASS "$1 is $2 as expected"
 	else
-		tst_resm TFAIL "$1 is $item_size, $2 expected"
+		tst_res TFAIL "$1 is $item_size, $2 expected"
 	fi
 }
 
+start_memcg_process()
+{
+	tst_res TINFO "Running memcg_process $@"
+	memcg_process "$@" &
+	MEMCG_PROCESS_PID=$!
+	ROD tst_checkpoint wait 10000 0
+}
+
 signal_memcg_process()
 {
-	local pid=$1
-	local size=$2
-	local path=$3
+	local size=$1
+	local path=$2
 	local usage_start=$(cat ${path}memory.usage_in_bytes)
 
-	kill -s USR1 $pid 2> /dev/null
+	kill -s USR1 $MEMCG_PROCESS_PID 2> /dev/null
 
 	if [ -z "$size" ]; then
 		return
@@ -131,7 +180,7 @@ signal_memcg_process()
 
 	local loops=100
 
-	while kill -0 $pid 2> /dev/null; do
+	while kill -0 $MEMCG_PROCESS_PID 2> /dev/null; do
 		local usage=$(cat ${path}memory.usage_in_bytes)
 		local diff_a=$((usage_start - usage))
 		local diff_b=$((usage - usage_start))
@@ -144,34 +193,32 @@ signal_memcg_process()
 
 		loops=$((loops - 1))
 		if [ $loops -le 0 ]; then
-			tst_brkm TBROK "timeouted on memory.usage_in_bytes"
+			tst_brk TBROK "timed out on memory.usage_in_bytes"
 		fi
 	done
 }
 
 stop_memcg_process()
 {
-	local pid=$1
-	kill -s INT $pid 2> /dev/null
-	wait $pid
+	[ -z "$MEMCG_PROCESS_PID" ] && return
+	kill -s INT $MEMCG_PROCESS_PID 2> /dev/null
+	wait $MEMCG_PROCESS_PID
+	MEMCG_PROCESS_PID=
 }
 
 warmup()
 {
-	local pid=$1
-
-	tst_resm TINFO "Warming up pid: $pid"
-	signal_memcg_process $pid
-	signal_memcg_process $pid
+	tst_res TINFO "Warming up pid: $MEMCG_PROCESS_PID"
+	signal_memcg_process
+	signal_memcg_process
 	sleep 1
 
-	kill -0 $pid
-	if [ $? -ne 0 ]; then
-		wait $pid
-		tst_resm TFAIL "Process $pid exited with $? after warm up"
+	if ! kill -0 $MEMCG_PROCESS_PID; then
+		wait $MEMCG_PROCESS_PID
+		tst_res TFAIL "Process $MEMCG_PROCESS_PID exited with $? after warm up"
 		return 1
 	else
-		tst_resm TINFO "Process is still here after warm up: $pid"
+		tst_res TINFO "Process is still here after warm up: $MEMCG_PROCESS_PID"
 	fi
 
 	return 0
@@ -188,86 +235,23 @@ test_mem_stat()
 	local exp_stat_size=$5
 	local check_after_free=$6
 
-	tst_resm TINFO "Running memcg_process $memtypes -s $size"
-	memcg_process $memtypes -s $size &
-	TST_CHECKPOINT_WAIT 0
+	start_memcg_process $memtypes -s $size
 
-	warmup $!
-	if [ $? -ne 0 ]; then
+	if ! warmup; then
 		return
 	fi
 
-	echo $! > tasks
-	signal_memcg_process $! $size
+	echo $MEMCG_PROCESS_PID > tasks
+	signal_memcg_process $size
 
 	check_mem_stat $stat_name $exp_stat_size
 
-	signal_memcg_process $! $size
+	signal_memcg_process $size
 	if $check_after_free; then
 		check_mem_stat $stat_name 0
 	fi
 
-	stop_memcg_process $!
-}
-
-# Run test cases which checks memory.max_usage_in_bytes after make
-# some memory allocation
-# $1 - the parameters of 'process', such as --shm
-# $2 - the -s parameter of 'process', such as 4096
-# $3 - item name
-# $4 - the expected size
-# $5 - check after free ?
-test_max_usage_in_bytes()
-{
-	tst_resm TINFO "Running memcg_process $1 -s $2"
-	memcg_process $1 -s $2 &
-	TST_CHECKPOINT_WAIT 0
-
-	warmup $!
-	if [ $? -ne 0 ]; then
-		return
-	fi
-
-	echo $! > tasks
-	signal_memcg_process $! $2
-	signal_memcg_process $! $2
-
-	check_mem_stat $3 $4
-
-	if [ $5 -eq 1 ]; then
-		echo 0 > $3
-		check_mem_stat $3 0
-	fi
-
-	stop_memcg_process $!
-}
-
-# make some memory allocation
-# $1 - the parameters of 'process', such as --shm
-# $2 - the -s parameter of 'process', such as 4096
-malloc_free_memory()
-{
-	tst_resm TINFO "Running memcg_process $1 -s $2"
-	memcg_process $1 -s $2 &
-	TST_CHECKPOINT_WAIT 0
-
-	echo $! > tasks
-	signal_memcg_process $! $2
-	signal_memcg_process $! $2
-
-	stop_memcg_process $!
-}
-
-# Test if failcnt > 0, which means page reclamation occured
-# $1 - item name in memcg
-test_failcnt()
-{
-	failcnt=`cat $1`
-	if [ $failcnt -gt 0 ]; then
-		tst_resm TPASS "$1 is $failcnt, > 0 as expected"
-	else
-		tst_resm TFAIL "$1 is $failcnt, <= 0 expected"
-	fi
+	stop_memcg_process
 }
 
 # Test process will be killed due to exceed memory limit
@@ -277,27 +261,27 @@ test_failcnt()
 # $4 - use mem+swap limitation
 test_proc_kill()
 {
-	echo $1 > memory.limit_in_bytes
-	if [ $4 -eq 1 ]; then
-		if [ -e memory.memsw.limit_in_bytes ]; then
-			echo $1 > memory.memsw.limit_in_bytes
-		else
-			tst_resm TCONF "mem+swap is not enabled"
-			return
-		fi
+	local limit=$1
+	local memtypes="$2"
+	local size=$3
+	local use_memsw=$4
+	local tpk_iter
+
+	echo $limit > memory.limit_in_bytes
+	if [ $use_memsw -eq 1 ]; then
+		memcg_require_memsw
+		echo $limit > memory.memsw.limit_in_bytes
 	fi
 
-	memcg_process $2 -s $3 &
-	pid=$!
-	TST_CHECKPOINT_WAIT 0
-	echo $pid > tasks
+	start_memcg_process $memtypes -s $size
+	echo $MEMCG_PROCESS_PID > tasks
 
-	signal_memcg_process $pid $3
+	signal_memcg_process $size
 
-	tpk_pid_exists=1
+	local tpk_pid_exists=1
 	for tpk_iter in $(seq 20); do
-		if [ ! -d "/proc/$pid" ] ||
-			grep -q 'Z (zombie)' "/proc/$pid/status"; then
+		if [ ! -d "/proc/$MEMCG_PROCESS_PID" ] ||
+			grep -q 'Z (zombie)' "/proc/$MEMCG_PROCESS_PID/status"; then
 			tpk_pid_exists=0
 			break
 		fi
@@ -306,18 +290,18 @@ test_proc_kill()
 	done
 
 	if [ $tpk_pid_exists -eq 0 ]; then
-		wait $pid
+		wait $MEMCG_PROCESS_PID
 		ret=$?
 		if [ $ret -eq 1 ]; then
-			tst_resm TFAIL "process $pid is killed by error"
+			tst_res TFAIL "process $MEMCG_PROCESS_PID is killed by error"
 		elif [ $ret -eq 2 ]; then
-			tst_resm TPASS "Failed to lock memory"
+			tst_res TPASS "Failed to lock memory"
 		else
-			tst_resm TPASS "process $pid is killed"
+			tst_res TPASS "process $MEMCG_PROCESS_PID is killed"
 		fi
 	else
-		stop_memcg_process $!
-		tst_resm TFAIL "process $pid is not killed"
+		stop_memcg_process
+		tst_res TFAIL "process $MEMCG_PROCESS_PID is not killed"
 	fi
 }
 
@@ -326,229 +310,46 @@ test_proc_kill()
 # $2 - use mem+swap limitation
 test_limit_in_bytes()
 {
-	echo $1 > memory.limit_in_bytes
-	if [ $2 -eq 1 ]; then
-		if [ -e memory.memsw.limit_in_bytes ]; then
-			echo $1 > memory.memsw.limit_in_bytes
-			limit=`cat memory.memsw.limit_in_bytes`
-		else
-			tst_resm TCONF "mem+swap is not enabled"
-			return
-		fi
+	local limit=$1
+	local use_memsw=$2
+	local elimit
+
+	echo $limit > memory.limit_in_bytes
+	if [ $use_memsw -eq 1 ]; then
+		memcg_require_memsw
+		echo $limit > memory.memsw.limit_in_bytes
+		elimit=$(cat memory.memsw.limit_in_bytes)
 	else
-		limit=`cat memory.limit_in_bytes`
+		elimit=$(cat memory.limit_in_bytes)
 	fi
 
-	# Kernels prior to 3.19 were rounding up but newer kernels
-	# are rounding down
-	if [ \( $(($PAGESIZE*($1/$PAGESIZE))) -eq $limit \) \
-	    -o \( $(($PAGESIZE*(($1+$PAGESIZE-1)/$PAGESIZE))) -eq $limit \) ]; then
-		tst_resm TPASS "input=$1, limit_in_bytes=$limit"
+	# Kernels prior to 3.19 were rounding up,
+	# but newer kernels are rounding down
+	local limit_up=$(( PAGESIZE * (limit / PAGESIZE) ))
+	local limit_down=$(( PAGESIZE * ((limit + PAGESIZE - 1) / PAGESIZE) ))
+	if [ $limit_up -eq $elimit ] || [ $limit_down -eq $elimit ]; then
+		tst_res TPASS "input=$limit, limit_in_bytes=$elimit"
 	else
-		tst_resm TFAIL "input=$1, limit_in_bytes=$limit"
+		tst_res TFAIL "input=$limit, limit_in_bytes=$elimit"
 	fi
 }
 
-# Never used, so untested
-#
-# Test memory controller doesn't charge hugepage
-# $1 - the value of /proc/sys/vm/nr_hugepages
-# $2 - the parameters of 'process', --mmap-file or --shm
-# $3 - the -s parameter of 'process', such as $HUGEPAGESIZE
-# $4 - 0: expected failure, 1: expected success
-test_hugepage()
-{
-	TMP_FILE="$TMP_DIR/tmp"
-	nr_hugepages=`cat /proc/sys/vm/nr_hugepages`
-
-	mkdir /hugetlb
-	mount -t hugetlbfs none /hugetlb
-
-	echo $1 > /proc/sys/vm/nr_hugepages
-
-	memcg_process $2 --hugepage -s $3 > $TMP_FILE 2>&1 &
-	TST_CHECKPOINT_WAIT 0
-
-	signal_memcg_process $! $3
-
-	check_mem_stat "rss" 0
-
-	echo "TMP_FILE:"
-	cat $TMP_FILE
-
-	if [ $4 -eq 0 ]; then
-		test -s $TMP_FILE
-		if [ $? -eq 0 ]; then
-			tst_resm TPASS "allocate hugepage failed as expected"
-		else
-			signal_memcg_process $! $3
-			stop_memcg_process $!
-			tst_resm TFAIL "allocate hugepage should fail"
-		fi
-	else
-		test ! -s $TMP_FILE
-		if [ $? -eq 0 ]; then
-			signal_memcg_process $! $3
-			stop_memcg_process $!
-			tst_resm TPASS "allocate hugepage succeeded"
-		else
-			tst_resm TFAIL "allocate hugepage failed"
-		fi
-	fi
-
-	sleep 1
-	rm -rf $TMP_FILE
-	umount /hugetlb
-	rmdir /hugetlb
-	echo $nr_hugepages > /proc/sys/vm/nr_hugepages
-}
-
-# Test the memory charge won't move to subgroup
-# $1 - memory.limit_in_bytes in parent group
-# $2 - memory.limit_in_bytes in sub group
-test_subgroup()
-{
-	mkdir subgroup
-	echo $1 > memory.limit_in_bytes
-	echo $2 > subgroup/memory.limit_in_bytes
-
-	tst_resm TINFO "Running memcg_process --mmap-anon -s $PAGESIZES"
-	memcg_process --mmap-anon -s $PAGESIZES &
-	TST_CHECKPOINT_WAIT 0
-
-	warmup $! $PAGESIZES
-	if [ $? -ne 0 ]; then
-		return
-	fi
-
-	echo $! > tasks
-	signal_memcg_process $! $PAGESIZES
-	check_mem_stat "rss" $PAGESIZES
-
-	cd subgroup
-	echo $! > tasks
-	check_mem_stat "rss" 0
-
-	# cleanup
-	cd ..
-	echo $! > tasks
-	stop_memcg_process $!
-	rmdir subgroup
-}
-
-# Run test cases which test memory.move_charge_at_immigrate
-test_move_charge()
-{
-	local memtypes="$1"
-	local size=$2
-	local total_size=$3
-	local move_charge_mask=$4
-	local b_rss=$5
-	local b_cache=$6
-	local a_rss=$7
-	local a_cache=$8
-
-	mkdir subgroup_a
-
-	tst_resm TINFO "Running memcg_process $memtypes -s $size"
-	memcg_process $memtypes -s $size &
-	TST_CHECKPOINT_WAIT 0
-	warmup $!
-	if [ $? -ne 0 ]; then
-		rmdir subgroup_a
-		return
-	fi
-
-	echo $! > subgroup_a/tasks
-	signal_memcg_process $! $total_size "subgroup_a/"
-
-	mkdir subgroup_b
-	echo $move_charge_mask > subgroup_b/memory.move_charge_at_immigrate
-	echo $! > subgroup_b/tasks
-
-	cd subgroup_b
-	check_mem_stat "rss" $b_rss
-	check_mem_stat "cache" $b_cache
-	cd ../subgroup_a
-	check_mem_stat "rss" $a_rss
-	check_mem_stat "cache" $a_cache
-	cd ..
-	stop_memcg_process $!
-	rmdir subgroup_a subgroup_b
-}
-
-cleanup_test()
-{
-	TEST_ID="$1"
-
-	if [ -n "$orig_memory_use_hierarchy" ];then
-		echo $orig_memory_use_hierarchy > \
-		     /dev/memcg/memory.use_hierarchy
-		if [ $? -ne 0 ];then
-			tst_resm TINFO "restore "\
-				 "/dev/memcg/memory.use_hierarchy failed"
-		fi
-		orig_memory_use_hierarchy=""
-	fi
-
-	killall -9 memcg_process 2>/dev/null
-	wait
-
-	ROD cd "$TMP_DIR"
-
-	ROD rmdir "/dev/memcg/$TEST_ID"
-	TEST_ID=""
-	ROD umount /dev/memcg
-	ROD rmdir /dev/memcg
-}
-
-setup_test()
+memcg_testfunc()
 {
-	TEST_ID="$1"
+	ROD mkdir /dev/memcg/ltp_$$
+	cd /dev/memcg/ltp_$$
 
-	ROD mkdir /dev/memcg
-	ROD mount -t cgroup -omemory memcg /dev/memcg
-
-	# The default value for memory.use_hierarchy is 0 and some of tests
-	# (memcg_stat_test.sh and memcg_use_hierarchy_test.sh) expect it so
-	# while there are distributions (RHEL7U0Beta for example) that sets
-	# it to 1.
-	orig_memory_use_hierarchy=$(cat /dev/memcg/memory.use_hierarchy)
-	if [ -z "$orig_memory_use_hierarchy" ];then
-		tst_resm TINFO "cat /dev/memcg/memory.use_hierarchy failed"
-	elif [ "$orig_memory_use_hierarchy" = "0" ];then
-		orig_memory_use_hierarchy=""
+	if type ${MEMCG_TESTFUNC}1 > /dev/null 2>&1; then
+		${MEMCG_TESTFUNC}$1 $1 "$2"
 	else
-		echo 0 > /dev/memcg/memory.use_hierarchy
-		if [ $? -ne 0 ];then
-			tst_resm TINFO "set /dev/memcg/memory.use_hierarchy" \
-				"to 0 failed"
-		fi
+		${MEMCG_TESTFUNC} $1 "$2"
 	fi
 
-	ROD mkdir "/dev/memcg/$TEST_ID"
-	ROD cd "/dev/memcg/$TEST_ID"
+	cd $TST_TMPDIR
+	ROD rmdir /dev/memcg/ltp_$$
 }
 
-# Run all the test cases
-run_tests()
+memcg_no_testfunc()
 {
-	for i in $(seq 1 $TST_TOTAL); do
-
-		tst_resm TINFO "Starting test $i"
-
-		setup_test $i
-
-		if [ -e memory.memsw.limit_in_bytes ]; then
-			MEMSW_LIMIT_FLAG=1
-		fi
-
-		if [ -e memory.memsw.max_usage_in_bytes ]; then
-			MEMSW_USAGE_FLAG=1
-		fi
-
-		testcase_$i
-
-		cleanup_test $i
-	done
+	tst_brk TBROK "No testfunc specified, set MEMCG_TESTFUNC"
 }
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_limit_in_bytes.sh b/testcases/kernel/controllers/memcg/functional/memcg_limit_in_bytes.sh
index fc7c6f2eb..8cf33bca5 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_limit_in_bytes.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_limit_in_bytes.sh
@@ -1,103 +1,94 @@
 #!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) 2009 FUJITSU LIMITED                                         ##
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
-## along with this program;  if not, write to the Free Software Foundation,   ##
-## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
-##                                                                            ##
-## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
-## Restructure for LTP: Shi Weihua <shiwh@cn.fujitsu.com>                     ##
-## Added memcg enable/disable functinality: Rishikesh K Rajak		      ##
-##						<risrajak@linux.vnet.ibm.com  ##
-##                                                                            ##
-################################################################################
-
-TCID="memcg_limit_in_bytes"
-TST_TOTAL=15
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2009 FUJITSU LIMITED
+# Copyright (c) 2018-2019 ARM Ltd. All Rights Reserved.
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+#
+# Author: Li Zefan <lizf@cn.fujitsu.com>
+# Restructure for LTP: Shi Weihua <shiwh@cn.fujitsu.com>
+# Added memcg enable/disable functionality: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
+
+MEMCG_TESTFUNC=test
+MEMCG_SHMMAX=1
+TST_CNT=15
 
 . memcg_lib.sh
+TST_CLEANUP=cleanup
+
+cleanup()
+{
+	memcg_cleanup
+	swapon -a
+}
 
-# Test mmap(locked) + alloc_mem > limit_in_bytes
-testcase_1()
+test1()
 {
-	test_proc_kill $PAGESIZE "--mmap-lock1" $((PAGESIZE*2)) 0
+	tst_res TINFO "Test mmap(locked) + alloc_mem > limit_in_bytes"
+	test_proc_kill $PAGESIZE "--mmap-lock1" $((PAGESIZE * 2)) 0
 }
 
-testcase_2()
+test2()
 {
-	test_proc_kill $PAGESIZE "--mmap-lock2" $((PAGESIZE*2)) 0
+	test_proc_kill $PAGESIZE "--mmap-lock2" $((PAGESIZE * 2)) 0
 }
 
-# Test swapoff + alloc_mem > limit_in_bytes
-testcase_3()
+test3()
 {
+	tst_res TINFO "Test swapoff + alloc_mem > limit_in_bytes"
 	swapoff -a
-	test_proc_kill $PAGESIZE "--mmap-anon" $((PAGESIZE*2)) 0
+	test_proc_kill $PAGESIZE "--mmap-anon" $((PAGESIZE * 2)) 0
 	swapon -a
 }
 
-testcase_4()
+test4()
 {
 	swapoff -a
-	test_proc_kill $PAGESIZE "--mmap-file" $((PAGESIZE*2)) 0
+	test_proc_kill $PAGESIZE "--mmap-file" $((PAGESIZE * 2)) 0
 	swapon -a
 }
 
-testcase_5()
+test5()
 {
 	swapoff -a
-	test_proc_kill $PAGESIZE "--shm -k 18" $((PAGESIZE*2)) 0
+	test_proc_kill $PAGESIZE "--shm -k 18" $((PAGESIZE * 2)) 0
 	swapon -a
 }
 
-# Test limit_in_bytes == 0
-testcase_6()
+test6()
 {
+	tst_res TINFO "Test limit_in_bytes == 0"
 	test_proc_kill 0 "--mmap-anon" $PAGESIZE 0
 }
 
-testcase_7()
+test7()
 {
 	test_proc_kill 0 "--mmap-file" $PAGESIZE 0
 }
 
-testcase_8()
+test8()
 {
 	test_proc_kill 0 "--shm -k 21" $PAGESIZE 0
 }
 
-# Test limit_in_bytes will be aligned to PAGESIZE
-testcase_9()
+test9()
 {
-	test_limit_in_bytes $((PAGESIZE-1)) 0
+	tst_res TINFO "Test limit_in_bytes will be aligned to PAGESIZE"
+	test_limit_in_bytes $((PAGESIZE - 1)) 0
 }
 
-testcase_10()
+test10()
 {
-	test_limit_in_bytes $((PAGESIZE+1)) 0
+	test_limit_in_bytes $((PAGESIZE + 1)) 0
 }
 
-testcase_11()
+test11()
 {
 	test_limit_in_bytes 1 0
 }
 
-# Test invalid memory.limit_in_bytes
-testcase_12()
+test12()
 {
+	tst_res TINFO "Test invalid memory.limit_in_bytes"
 	if tst_kvcmp -lt "2.6.31"; then
 		EXPECT_FAIL echo -1 \> memory.limit_in_bytes
 	else
@@ -105,22 +96,19 @@ testcase_12()
 	fi
 }
 
-testcase_13()
+test13()
 {
 	EXPECT_FAIL echo 1.0 \> memory.limit_in_bytes
 }
 
-testcase_14()
+test14()
 {
 	EXPECT_FAIL echo 1xx \> memory.limit_in_bytes
 }
 
-testcase_15()
+test15()
 {
 	EXPECT_FAIL echo xx \> memory.limit_in_bytes
 }
 
-shmmax_setup
-LOCAL_CLEANUP=shmmax_cleanup
-run_tests
-tst_exit
+tst_run
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_max_usage_in_bytes_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_max_usage_in_bytes_test.sh
index 91112be20..82e4a3e84 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_max_usage_in_bytes_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_max_usage_in_bytes_test.sh
@@ -1,79 +1,76 @@
 #! /bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) 2012 FUJITSU LIMITED                                         ##
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
-# File :        memcg_max_usage_in_bytes_test.sh
-# Description:  Tests memory.max_usage_in_bytes.
-# Author:       Peng Haitao <penght@cn.fujitsu.com>
-# History:      2012/01/17 - Created.
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2012 FUJITSU LIMITED
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
 #
+# Author: Peng Haitao <penght@cn.fujitsu.com>
 
-TCID="memcg_max_usage_in_bytes_test"
-TST_TOTAL=4
+MEMCG_TESTFUNC=test
+TST_CNT=4
 
 . memcg_lib.sh
 
-# Test memory.max_usage_in_bytes
-testcase_1()
-{
-	test_max_usage_in_bytes "--mmap-anon" $((PAGESIZE*1024)) \
-		"memory.max_usage_in_bytes" $((PAGESIZE*1024)) 0
-}
+MEM_TO_ALLOC=$((PAGESIZE * 1024))
+MEM_LIMIT=$((MEM_TO_ALLOC * 2))
 
-# Test memory.memsw.max_usage_in_bytes
-testcase_2()
+# Run test cases which checks memory.[memsw.]max_usage_in_bytes after make
+# some memory allocation
+test_max_usage_in_bytes()
 {
-	if [ "$MEMSW_USAGE_FLAG" -eq 0 ]; then
-		tst_resm TCONF "mem+swap is not enabled"
+	local item="memory.max_usage_in_bytes"
+	[ $1 -eq 1 ] && item="memory.memsw.max_usage_in_bytes"
+	local check_after_reset=$2
+	start_memcg_process --mmap-anon -s $MEM_TO_ALLOC
+
+	warmup
+	if [ $? -ne 0 ]; then
 		return
 	fi
 
-	echo $((PAGESIZE*2048)) > memory.limit_in_bytes
-	echo $((PAGESIZE*2048)) > memory.memsw.limit_in_bytes
-	test_max_usage_in_bytes "--mmap-anon" $((PAGESIZE*1024)) \
-		"memory.memsw.max_usage_in_bytes" $((PAGESIZE*1024)) 0
+	echo $MEMCG_PROCESS_PID > tasks
+	signal_memcg_process $MEM_TO_ALLOC
+	signal_memcg_process $MEM_TO_ALLOC
+
+	check_mem_stat $item $MEM_TO_ALLOC
+
+	if [ $check_after_reset -eq 1 ]; then
+		echo 0 > $item
+		check_mem_stat $item 0
+	fi
+
+	stop_memcg_process
 }
 
-# Test reset memory.max_usage_in_bytes
-testcase_3()
+test1()
 {
-	test_max_usage_in_bytes "--mmap-anon" $((PAGESIZE*1024)) \
-		"memory.max_usage_in_bytes" $((PAGESIZE*1024)) 1
+	tst_res TINFO "Test memory.max_usage_in_bytes"
+	test_max_usage_in_bytes 0 0
 }
 
-# Test reset memory.memsw.max_usage_in_bytes
-testcase_4()
+test2()
 {
-	if [ "$MEMSW_USAGE_FLAG" -eq 0 ]; then
-		tst_resm TCONF "mem+swap is not enabled"
-		return
-	fi
+	tst_res TINFO "Test memory.memsw.max_usage_in_bytes"
+	memcg_require_memsw
+
+	echo $MEM_LIMIT > memory.limit_in_bytes
+	echo $MEM_LIMIT > memory.memsw.limit_in_bytes
+	test_max_usage_in_bytes 1 0
+}
 
-	echo $((PAGESIZE*2048)) > memory.limit_in_bytes
-	echo $((PAGESIZE*2048)) > memory.memsw.limit_in_bytes
-	test_max_usage_in_bytes "--mmap-anon" $((PAGESIZE*1024)) \
-		"memory.memsw.max_usage_in_bytes" $((PAGESIZE*1024)) 1
+test3()
+{
+	tst_res TINFO "Test reset memory.max_usage_in_bytes"
+	test_max_usage_in_bytes 0 1
 }
 
-run_tests
+test4()
+{
+	tst_res TINFO "Test reset memory.memsw.max_usage_in_bytes"
+	memcg_require_memsw
 
-tst_exit
+	echo $MEM_LIMIT > memory.limit_in_bytes
+	echo $MEM_LIMIT > memory.memsw.limit_in_bytes
+	test_max_usage_in_bytes 1 1
+}
 
+tst_run
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_memsw_limit_in_bytes_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_memsw_limit_in_bytes_test.sh
index ab3f8c845..5ef9b56a6 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_memsw_limit_in_bytes_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_memsw_limit_in_bytes_test.sh
@@ -1,82 +1,58 @@
 #! /bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) 2012 FUJITSU LIMITED                                         ##
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
-# File :        memcg_memsw_limit_in_bytes_test.sh
-# Description:  Tests memory.memsw.limit_in_bytes.
-# Author:       Peng Haitao <penght@cn.fujitsu.com>
-# History:      2012/01/3 - Created.
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2012 FUJITSU LIMITED
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
 #
+# Author: Peng Haitao <penght@cn.fujitsu.com>
 
-TCID="memcg_memsw_limit_in_bytes_test"
-TST_TOTAL=12
+MEMCG_TESTFUNC=test
+TST_CNT=12
 
 . memcg_lib.sh
 
-testcase_1()
+test1()
 {
 	test_proc_kill $PAGESIZE "--mmap-lock1" $((PAGESIZE*2)) 1
 }
 
-testcase_2()
+test2()
 {
 	test_proc_kill $PAGESIZE "--mmap-lock2" $((PAGESIZE*2)) 1
 }
 
-testcase_3()
+test3()
 {
 	test_proc_kill 0 "--mmap-anon" $PAGESIZE 1
 }
 
-testcase_4()
+test4()
 {
 	test_proc_kill 0 "--mmap-file" $PAGESIZE 1
 }
 
-testcase_5()
+test5()
 {
 	test_proc_kill 0 "--shm -k 21" $PAGESIZE 1
 }
 
-testcase_6()
+test6()
 {
-	test_limit_in_bytes $((PAGESIZE-1)) 1
+	test_limit_in_bytes $((PAGESIZE - 1)) 1
 }
 
-testcase_7()
+test7()
 {
-	test_limit_in_bytes $((PAGESIZE+1)) 1
+	test_limit_in_bytes $((PAGESIZE + 1)) 1
 }
 
-testcase_8()
+test8()
 {
 	test_limit_in_bytes 1 1
 }
 
-testcase_9()
+test9()
 {
-	if [ "$MEMSW_LIMIT_FLAG" -eq 0 ]; then
-		tst_resm TCONF "mem+swap is not enabled"
-		return
-	fi
+	memcg_require_memsw
 
 	echo 10M > memory.limit_in_bytes
 
@@ -87,39 +63,28 @@ testcase_9()
 	fi
 }
 
-testcase_10()
+test10()
 {
-	if [ "$MEMSW_LIMIT_FLAG" -eq 0 ]; then
-		tst_resm TCONF "mem+swap is not enabled"
-		return
-	fi
+	memcg_require_memsw
 
 	echo 10M > memory.limit_in_bytes
 	EXPECT_FAIL echo 1.0 \> memory.memsw.limit_in_bytes
 }
 
-testcase_11()
+test11()
 {
-	if [ "$MEMSW_LIMIT_FLAG" -eq 0 ]; then
-		tst_resm TCONF "mem+swap is not enabled"
-		return
-	fi
+	memcg_require_memsw
 
 	echo 10M > memory.limit_in_bytes
 	EXPECT_FAIL echo 1xx \> memory.memsw.limit_in_bytes
 }
 
-testcase_12()
+test12()
 {
-	if [ "$MEMSW_LIMIT_FLAG" -eq 0 ]; then
-		tst_resm TCONF "mem+swap is not enabled"
-		return
-	fi
+	memcg_require_memsw
 
 	echo 10M > memory.limit_in_bytes
 	EXPECT_FAIL echo xx \> memory.memsw.limit_in_bytes
 }
 
-run_tests
-
-tst_exit
+tst_run
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_move_charge_at_immigrate_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_move_charge_at_immigrate_test.sh
index 18c08644a..15f5f4c03 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_move_charge_at_immigrate_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_move_charge_at_immigrate_test.sh
@@ -1,63 +1,82 @@
 #! /bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) 2012 FUJITSU LIMITED                                         ##
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
-# File :        memcg_move_charge_at_immigrate_test.sh
-# Description:  Tests memory.move_charge_at_immigrate.
-# Author:       Peng Haitao <penght@cn.fujitsu.com>
-# History:      2012/01/16 - Created.
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2012 FUJITSU LIMITED
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
 #
+# Author: Peng Haitao <penght@cn.fujitsu.com>
 
-TCID="memcg_move_charge_at_immigrate_test"
-TST_TOTAL=4
+MEMCG_TESTFUNC=test
+TST_CNT=4
 
 . memcg_lib.sh
 
-# Test disable moving charges
-testcase_1()
+
+# Run test cases which test memory.move_charge_at_immigrate
+test_move_charge()
 {
+	local memtypes="$1"
+	local size=$2
+	local total_size=$3
+	local move_charge_mask=$4
+	local b_rss=$5
+	local b_cache=$6
+	local a_rss=$7
+	local a_cache=$8
+
+	mkdir subgroup_a
+
+	start_memcg_process $memtypes -s $size
+	
+	warmup
+	if [ $? -ne 0 ]; then
+		rmdir subgroup_a
+		return
+	fi
+
+	echo $MEMCG_PROCESS_PID > subgroup_a/tasks
+	signal_memcg_process $total_size "subgroup_a/"
+
+	mkdir subgroup_b
+	echo $move_charge_mask > subgroup_b/memory.move_charge_at_immigrate
+	echo $MEMCG_PROCESS_PID > subgroup_b/tasks
+
+	cd subgroup_b
+	check_mem_stat "rss" $b_rss
+	check_mem_stat "cache" $b_cache
+	cd ../subgroup_a
+	check_mem_stat "rss" $a_rss
+	check_mem_stat "cache" $a_cache
+	cd ..
+	stop_memcg_process
+	rmdir subgroup_a subgroup_b
+}
+
+
+test1()
+{
+	tst_res TINFO "Test disable moving charges"
 	test_move_charge "--mmap-anon" $PAGESIZES $PAGESIZES 0 0 0 $PAGESIZES 0
 }
 
-# Test move anon
-testcase_2()
+test2()
 {
+	tst_res TINFO "Test move anon"
 	test_move_charge "--mmap-anon --shm --mmap-file" $PAGESIZES \
-		$((PAGESIZES*3)) 1 $PAGESIZES 0 0 $((PAGESIZES*2))
+		$((PAGESIZES * 3)) 1 $PAGESIZES 0 0 $((PAGESIZES * 2))
 }
 
-# Test move file
-testcase_3()
+test3()
 {
+	tst_res TINFO "Test move file"
 	test_move_charge "--mmap-anon --shm --mmap-file" $PAGESIZES \
-		$((PAGESIZES*3)) 2 0 $((PAGESIZES*2)) $PAGESIZES 0
+		$((PAGESIZES * 3)) 2 0 $((PAGESIZES * 2)) $PAGESIZES 0
 }
 
-# Test move anon and file
-testcase_4()
+test4()
 {
+	tst_res TINFO "Test move anon and file"
 	test_move_charge "--mmap-anon --shm" $PAGESIZES \
-		$((PAGESIZES*2)) 3 $PAGESIZES $PAGESIZES 0 0
+		$((PAGESIZES * 2)) 3 $PAGESIZES $PAGESIZES 0 0
 }
 
-run_tests
-
-tst_exit
+tst_run
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_stat_rss.sh b/testcases/kernel/controllers/memcg/functional/memcg_stat_rss.sh
index f6090edfd..526174315 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_stat_rss.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_stat_rss.sh
@@ -1,89 +1,69 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2009 FUJITSU LIMITED
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+#
+# Author: Li Zefan <lizf@cn.fujitsu.com>
+# Restructure for LTP: Shi Weihua <shiwh@cn.fujitsu.com>
+# Added memcg enable/disable functinality: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com
 
-################################################################################
-##                                                                            ##
-## Copyright (c) 2009 FUJITSU LIMITED                                         ##
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
-## along with this program;  if not, write to the Free Software Foundation,   ##
-## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
-##                                                                            ##
-## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
-## Restructure for LTP: Shi Weihua <shiwh@cn.fujitsu.com>                     ##
-## Added memcg enable/disable functinality: Rishikesh K Rajak		      ##
-##						<risrajak@linux.vnet.ibm.com  ##
-##                                                                            ##
-################################################################################
-
-TCID="memcg_stat_rss"
-TST_TOTAL=10
+MEMCG_TESTFUNC=test
+MEMCG_SHMMAX=1
+TST_CNT=10
 
 . memcg_lib.sh
 
 # Test the management and counting of memory
-testcase_1()
+test1()
 {
 	test_mem_stat "--mmap-anon" $PAGESIZES $PAGESIZES "rss" $PAGESIZES false
 }
 
-testcase_2()
+test2()
 {
 	test_mem_stat "--mmap-file" $PAGESIZE $PAGESIZE "rss" 0 false
 }
 
-testcase_3()
+test3()
 {
 	test_mem_stat "--shm -k 3" $PAGESIZE $PAGESIZE "rss" 0 false
 }
 
-testcase_4()
+test4()
 {
 	test_mem_stat "--mmap-anon --mmap-file --shm" \
-		$PAGESIZES $((PAGESIZES*3)) "rss" $PAGESIZES false
+		$PAGESIZES $((PAGESIZES * 3)) "rss" $PAGESIZES false
 }
 
-testcase_5()
+test5()
 {
 	test_mem_stat "--mmap-lock1" $PAGESIZES $PAGESIZES "rss" $PAGESIZES false
 }
 
-testcase_6()
+test6()
 {
 	test_mem_stat "--mmap-anon" $PAGESIZES $PAGESIZES "rss" $PAGESIZES true
 }
 
-testcase_7()
+test7()
 {
 	test_mem_stat "--mmap-file" $PAGESIZE $PAGESIZE "rss" 0 true
 }
 
-testcase_8()
+test8()
 {
 	test_mem_stat "--shm -k 8" $PAGESIZE $PAGESIZE "rss" 0 true
 }
 
-testcase_9()
+test9()
 {
 	test_mem_stat "--mmap-anon --mmap-file --shm" \
-		$PAGESIZES $((PAGESIZES*3)) "rss" $PAGESIZES true
+		$PAGESIZES $((PAGESIZES * 3)) "rss" $PAGESIZES true
 }
 
-testcase_10()
+test10()
 {
 	test_mem_stat "--mmap-lock1" $PAGESIZES $PAGESIZES "rss" $PAGESIZES true
 }
 
-shmmax_setup
-LOCAL_CLEANUP=shmmax_cleanup
-run_tests
-tst_exit
+tst_run
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh
index 09ee8bd8d..d5f7d19db 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh
@@ -1,66 +1,45 @@
 #! /bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) 2012 FUJITSU LIMITED                                         ##
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
-# File :        memcg_stat_test.sh
-# Description:  Tests memory.stat.
-# Author:       Peng Haitao <penght@cn.fujitsu.com>
-# History:      2012/01/16 - Created.
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2012 FUJITSU LIMITED
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
 #
+# Author: Peng Haitao <penght@cn.fujitsu.com>
 
-TCID="memcg_stat_test"
-TST_TOTAL=8
+MEMCG_TESTFUNC=test
+TST_CNT=8
 
 . memcg_lib.sh
 
-# Test cache
-testcase_1()
+test1()
 {
+	tst_res TINFO "Test cache"
 	test_mem_stat "--shm -k 3" $PAGESIZES $PAGESIZES "cache" $PAGESIZES false
 }
 
-# Test mapped_file
-testcase_2()
+test2()
 {
+	tst_res TINFO "Test mapped_file"
 	test_mem_stat "--mmap-file" $PAGESIZES $PAGESIZES \
 		"mapped_file" $PAGESIZES false
 }
 
-# Test unevictable with MAP_LOCKED
-testcase_3()
+test3()
 {
+	tst_res TINFO "Test unevictable with MAP_LOCKED"
 	test_mem_stat "--mmap-lock1" $PAGESIZE $PAGESIZE \
 		"unevictable" $PAGESIZE false
 }
 
-# Test unevictable with mlock
-testcase_4()
+test4()
 {
+	tst_res TINFO "Test unevictable with mlock"
 	test_mem_stat "--mmap-lock2" $PAGESIZE $PAGESIZE \
 		"unevictable" $PAGESIZE false
 }
 
-# Test hierarchical_memory_limit with enabling hierarchical accounting
-testcase_5()
+test5()
 {
+	tst_res TINFO "Test hierarchical_memory_limit with enabling hierarchical accounting"
 	echo 1 > memory.use_hierarchy
 
 	mkdir subgroup
@@ -74,31 +53,30 @@ testcase_5()
 	rmdir subgroup
 }
 
-# Test hierarchical_memory_limit with disabling hierarchical accounting
-testcase_6()
+test6()
 {
+	tst_res TINFO "Test hierarchical_memory_limit with disabling hierarchical accounting"
+	memcg_require_hierarchy_disabled
+
 	echo 0 > memory.use_hierarchy
 
 	mkdir subgroup
 	echo $PAGESIZE > memory.limit_in_bytes
-	echo $((PAGESIZE*2)) > subgroup/memory.limit_in_bytes
+	echo $((PAGESIZE * 2)) > subgroup/memory.limit_in_bytes
 
 	cd subgroup
-	check_mem_stat "hierarchical_memory_limit" $((PAGESIZE*2))
+	check_mem_stat "hierarchical_memory_limit" $((PAGESIZE * 2))
 
 	cd ..
 	rmdir subgroup
 }
 
-# Test hierarchical_memsw_limit with enabling hierarchical accounting
-testcase_7()
+test7()
 {
-	if [ "$MEMSW_LIMIT_FLAG" -eq 0 ]; then
-		tst_resm TCONF "mem+swap is not enabled"
-		return
-	fi
+	tst_res TINFO "Test hierarchical_memsw_limit with enabling hierarchical accounting"
+	memcg_require_memsw
 
-	echo 1 > memory.use_hierarchy
+	ROD echo 1 \> memory.use_hierarchy
 
 	mkdir subgroup
 	echo $PAGESIZE > memory.limit_in_bytes
@@ -113,15 +91,13 @@ testcase_7()
 	rmdir subgroup
 }
 
-# Test hierarchical_memsw_limit with disabling hierarchical accounting
-testcase_8()
+test8()
 {
-	if [ "$MEMSW_LIMIT_FLAG" -eq 0 ]; then
-		tst_resm TCONF "mem+swap is not enabled"
-		return
-	fi
+	tst_res TINFO "Test hierarchical_memsw_limit with disabling hierarchical accounting"
+	memcg_require_memsw
+	memcg_require_hierarchy_disabled
 
-	echo 0 > memory.use_hierarchy
+	ROD echo 0 \> memory.use_hierarchy
 
 	mkdir subgroup
 	echo $PAGESIZE > memory.limit_in_bytes
@@ -132,11 +108,8 @@ testcase_8()
 	cd subgroup
 	check_mem_stat "hierarchical_memsw_limit" $((PAGESIZE*2))
 
-	cd ..
+	cd .
 	rmdir subgroup
 }
 
-run_tests
-
-tst_exit
-
+tst_run
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh b/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
index 9b11f7b58..6dd3a25b0 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
@@ -1,50 +1,61 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2009 FUJITSU LIMITED
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+#
+# Author: Li Zefan <lizf@cn.fujitsu.com>
+# Restructure for LTP: Shi Weihua <shiwh@cn.fujitsu.com>
+# Added memcg enable/disable functinality: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com
 
-################################################################################
-##                                                                            ##
-## Copyright (c) 2009 FUJITSU LIMITED                                         ##
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
-## along with this program;  if not, write to the Free Software Foundation,   ##
-## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
-##                                                                            ##
-## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
-## Restructure for LTP: Shi Weihua <shiwh@cn.fujitsu.com>                     ##
-## Added memcg enable/disable functinality: Rishikesh K Rajak		      ##
-##						<risrajak@linux.vnet.ibm.com  ##
-##                                                                            ##
-################################################################################
-
-TCID="memcg_subgroup_charge"
-TST_TOTAL=3
+MEMCG_TESTFUNC=test
+TST_CNT=3
 
 . memcg_lib.sh
 
-# Test that group and subgroup have no relationship
-testcase_1()
+# Test the memory charge won't move to subgroup
+# $1 - memory.limit_in_bytes in parent group
+# $2 - memory.limit_in_bytes in sub group
+test_subgroup()
 {
-	test_subgroup $PAGESIZES $((2*PAGESIZES))
+	mkdir subgroup
+	echo $1 > memory.limit_in_bytes
+	echo $2 > subgroup/memory.limit_in_bytes
+
+	start_memcg_process --mmap-anon -s $PAGESIZES
+
+	warmup
+	if [ $? -ne 0 ]; then
+		return
+	fi
+
+	echo $MEMCG_PROCESS_PID > tasks
+	signal_memcg_process $PAGESIZES
+	check_mem_stat "rss" $PAGESIZES
+
+	cd subgroup
+	echo $MEMCG_PROCESS_PID > tasks
+	check_mem_stat "rss" 0
+
+	# cleanup
+	cd ..
+	stop_memcg_process
+	rmdir subgroup
+}
+
+test1()
+{
+	tst_res TINFO "Test that group and subgroup have no relationship"
+	test_subgroup $PAGESIZES $((2 * PAGESIZES))
 }
 
-testcase_2()
+test2()
 {
 	test_subgroup $PAGESIZES $PAGESIZES
 }
 
-testcase_3()
+test3()
 {
 	test_subgroup $PAGESIZES 0
 }
 
-run_tests
-tst_exit
+tst_run
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_usage_in_bytes_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_usage_in_bytes_test.sh
index 8e2e628dc..29dff5055 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_usage_in_bytes_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_usage_in_bytes_test.sh
@@ -1,58 +1,34 @@
 #! /bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) 2012 FUJITSU LIMITED                                         ##
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
-# File :        memcg_usage_in_bytes_test.sh
-# Description:  Tests memory.max_usage_in_bytes.
-# Author:       Peng Haitao <penght@cn.fujitsu.com>
-# History:      2012/01/16 - Created.
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2012 FUJITSU LIMITED
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
 #
+# Author: Peng Haitao <penght@cn.fujitsu.com>
 
-TCID="memcg_usage_in_bytes_test"
-TST_TOTAL=2
+MEMCG_TESTFUNC=test
+TST_CNT=2
 
 . memcg_lib.sh
 
-# Test memory.usage_in_bytes
-testcase_1()
+MEM_TO_ALLOC=$((PAGESIZE * 1024))
+MEM_LIMIT=$((MEM_TO_ALLOC * 2))
+
+test1()
 {
-	test_mem_stat "--mmap-anon" $((PAGESIZE*1024)) $((PAGESIZE*1024)) \
-		"memory.usage_in_bytes" $((PAGESIZE*1024)) false
+	tst_res TINFO "Test memory.usage_in_bytes"
+	test_mem_stat "--mmap-anon" $MEM_TO_ALLOC $MEM_TO_ALLOC \
+		"memory.usage_in_bytes" $MEM_TO_ALLOC false
 }
 
-# Test memory.memsw.usage_in_bytes
-testcase_2()
+test2()
 {
-	if [ "$MEMSW_USAGE_FLAG" -eq 0 ]; then
-		tst_resm TCONF "mem+swap is not enabled"
-		return
-	fi
+	tst_res TINFO "Test memory.memsw.usage_in_bytes"
+	memcg_require_memsw
 
-	echo $((PAGESIZE*2048)) > memory.limit_in_bytes
-	echo $((PAGESIZE*2048)) > memory.memsw.limit_in_bytes
-	test_mem_stat "--mmap-anon" $((PAGESIZE*1024)) $((PAGESIZE*1024)) \
-		"memory.memsw.usage_in_bytes" $((PAGESIZE*1024)) false
+	echo $MEM_LIMIT > memory.limit_in_bytes
+	echo $MEM_LIMIT > memory.memsw.limit_in_bytes
+	test_mem_stat "--mmap-anon" $MEM_TO_ALLOC $MEM_TO_ALLOC \
+		"memory.memsw.usage_in_bytes" $MEM_TO_ALLOC false
 }
 
-run_tests
-
-tst_exit
-
+tst_run
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_use_hierarchy_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_use_hierarchy_test.sh
index 4cf6b9fc2..37be4e0fb 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_use_hierarchy_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_use_hierarchy_test.sh
@@ -1,62 +1,48 @@
 #! /bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) 2012 FUJITSU LIMITED                                         ##
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
-# File :        memcg_use_hierarchy_test.sh
-# Description:  Tests memory.use_hierarchy.
-# Author:       Peng Haitao <penght@cn.fujitsu.com>
-# History:      2012/01/14 - Created.
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2012 FUJITSU LIMITED
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
 #
+# Author: Peng Haitao <penght@cn.fujitsu.com>
 
-TCID="memcg_use_hierarchy_test"
-TST_TOTAL=3
+MEMCG_TESTFUNC=test
+TST_CNT=3
 
 . memcg_lib.sh
 
-# test if one of the ancestors goes over its limit, the proces will be killed
-testcase_1()
+test1()
 {
+	tst_res TINFO "test if one of the ancestors goes over its limit, the proces will be killed"
+
 	echo 1 > memory.use_hierarchy
 	echo $PAGESIZE > memory.limit_in_bytes
 
 	mkdir subgroup
 	cd subgroup
-	test_proc_kill $((PAGESIZE*3)) "--mmap-lock1" $((PAGESIZE*2)) 0
+	test_proc_kill $((PAGESIZE * 3)) "--mmap-lock1" $((PAGESIZE * 2)) 0
 
 	cd ..
 	rmdir subgroup
 }
 
-# test Enabling will fail if the cgroup already has other cgroups
-testcase_2()
+test2()
 {
+	tst_res TINFO "test Enabling will fail if the cgroup already has other cgroups"
+
+	memcg_require_hierarchy_disabled
+
 	mkdir subgroup
 	EXPECT_FAIL echo 1 \> memory.use_hierarchy
 
 	rmdir subgroup
 }
 
-# test disabling will fail if the parent cgroup has enabled hierarchy.
-testcase_3()
+test3()
 {
+	tst_res TINFO "test disabling will fail if the parent cgroup has enabled hierarchy"
+
+	memcg_require_hierarchy_disabled
+
 	echo 1 > memory.use_hierarchy
 	mkdir subgroup
 	EXPECT_FAIL echo 0 \> subgroup/memory.use_hierarchy
@@ -64,7 +50,4 @@ testcase_3()
 	rmdir subgroup
 }
 
-run_tests
-
-tst_exit
-
+tst_run
-- 
2.25.1

