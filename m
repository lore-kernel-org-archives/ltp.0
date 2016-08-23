From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 23 Aug 2016 14:25:52 +0300
Subject: [LTP] [PATCH V2 1/4] memcg/functional: rewrite
Message-ID: <1471951555-4230-1-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Use the LTP API for shell tests
* Remove memcg_getpagesize binary, since its functionality
  can be provided by 'getconf PAGESIZE'
* Move common code to memcg_lib.sh

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
Changes since V1:
 * Substituted the result() function with tst_resm and EXPECT_*
 * Added a message for the situation when a pid dies after warm up

 testcases/kernel/controllers/memcg/.gitignore      |    1 -
 .../memcg/functional/memcg_function_test.sh        |  100 ++++---------
 .../memcg/functional/memcg_getpagesize.c           |   30 ----
 .../controllers/memcg/functional/memcg_lib.sh      |  168 ++++++++++++--------
 .../functional/memcg_max_usage_in_bytes_test.sh    |   49 +-----
 .../functional/memcg_memsw_limit_in_bytes_test.sh  |   70 ++-------
 .../memcg_move_charge_at_immigrate_test.sh         |   40 +----
 .../memcg/functional/memcg_stat_test.sh            |   49 +-----
 .../memcg/functional/memcg_usage_in_bytes_test.sh  |   47 +-----
 .../memcg/functional/memcg_use_hierarchy_test.sh   |   45 +-----
 10 files changed, 178 insertions(+), 421 deletions(-)
 delete mode 100644 testcases/kernel/controllers/memcg/functional/memcg_getpagesize.c

diff --git a/testcases/kernel/controllers/memcg/.gitignore b/testcases/kernel/controllers/memcg/.gitignore
index 6f62034..8730251 100644
--- a/testcases/kernel/controllers/memcg/.gitignore
+++ b/testcases/kernel/controllers/memcg/.gitignore
@@ -1,5 +1,4 @@
 /control/mem_process
-/functional/memcg_getpagesize
 /functional/memcg_process
 /regression/memcg_test_1
 /regression/memcg_test_2
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
index 2c2f32a..24d02ae 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
@@ -25,11 +25,18 @@
 ##                                                                            ##
 ################################################################################
 
-export TCID="memcg_function_test"
-export TST_TOTAL=38
-export TST_COUNT=0
+TCID="memcg_function_test"
+TST_TOTAL=38
 
-. memcg_lib.sh || exit 1
+shmmax_cleanup()
+{
+	if [ -n "$shmmax" ]; then
+		echo "$shmmax" > /proc/sys/kernel/shmmax
+	fi
+}
+LOCAL_CLEANUP=shmmax_cleanup
+
+. memcg_lib.sh
 
 # Case 1 - 10: Test the management and counting of memory
 testcase_1()
@@ -174,38 +181,33 @@ testcase_24()
 # Case 25 - 28: Test invaild memory.limit_in_bytes
 testcase_25()
 {
-	echo -1 > memory.limit_in_bytes 2> /dev/null
-	ret=$?
 	tst_kvercmp 2 6 31
 	if [ $? -eq 0 ]; then
-		result $(( !($ret != 0) ))  "return value is $ret"
+		EXPECT_FAIL echo -1 \> memory.limit_in_bytes
 	else
-		result $(( !($ret == 0) ))  "return value is $ret"
+		EXPECT_PASS echo -1 \> memory.limit_in_bytes
 	fi
 }
 
 testcase_26()
 {
-	echo 1.0 > memory.limit_in_bytes 2> /dev/null
-	result $(( !($? != 0) )) "return value is $?"
+	EXPECT_FAIL echo 1.0 \> memory.limit_in_bytes
 }
 
 testcase_27()
 {
-	echo 1xx > memory.limit_in_bytes 2> /dev/null
-	result $(( !($? != 0) )) "return value is $?"
+	EXPECT_FAIL echo 1xx \> memory.limit_in_bytes
 }
 
 testcase_28()
 {
-	echo xx > memory.limit_in_bytes 2> /dev/null
-	result $(( !($? != 0) )) "return value is $?"
+	EXPECT_FAIL echo xx \> memory.limit_in_bytes
 }
 
 # Case 29 - 35: Test memory.force_empty
 testcase_29()
 {
-	$TEST_PATH/memcg_process --mmap-anon -s $PAGESIZE &
+	memcg_process --mmap-anon -s $PAGESIZE &
 	pid=$!
 	sleep 1
 	echo $pid > tasks
@@ -214,65 +216,50 @@ testcase_29()
 	echo $pid > ../tasks
 
 	# This expects that there is swap configured
-	echo 1 > memory.force_empty
-	if [ $? -eq 0 ]; then
-		result $PASS "force memory succeeded"
-	else
-		result $FAIL "force memory failed"
-	fi
+	EXPECT_PASS echo 1 \> memory.force_empty
 
 	kill -s INT $pid 2> /dev/null
 }
 
 testcase_30()
 {
-	$TEST_PATH/memcg_process --mmap-lock2 -s $PAGESIZE &
+	memcg_process --mmap-lock2 -s $PAGESIZE &
 	pid=$!
 	sleep 1
 	echo $pid > tasks
 	kill -s USR1 $pid 2> /dev/null
 	sleep 1
 
-	echo 1 > memory.force_empty 2> /dev/null
-	if [ $? -ne 0 ]; then
-		result $PASS "force memory failed as expected"
-	else
-		result $FAIL "force memory should fail"
-	fi
+	EXPECT_FAIL echo 1 \> memory.force_empty
 
 	kill -s INT $pid 2> /dev/null
 }
 
 testcase_31()
 {
-	echo 0 > memory.force_empty 2> /dev/null
-	result $? "return value is $?"
+	EXPECT_PASS echo 0 \> memory.force_empty
 }
 
 testcase_32()
 {
-	echo 1.0 > memory.force_empty 2> /dev/null
-	result $? "return value is $?"
+	EXPECT_PASS echo 1.0 \> memory.force_empty
 }
 
 testcase_33()
 {
-	echo 1xx > memory.force_empty 2> /dev/null
-	result $? "return value is $?"
+	EXPECT_PASS echo 1xx \> memory.force_empty
 }
 
 testcase_34()
 {
-	echo xx > memory.force_empty 2> /dev/null
-	result $? "return value is $?"
+	EXPECT_PASS echo xx \> memory.force_empty
 }
 
 testcase_35()
 {
 	# writing to non-empty top mem cgroup's force_empty
 	# should return failure
-	echo 1 > /dev/memcg/memory.force_empty 2> /dev/null
-	result $(( !$? )) "return value is $?"
+	EXPECT_FAIL echo 1 \> /dev/memcg/memory.force_empty
 }
 
 # Case 36 - 38: Test that group and subgroup have no relationship
@@ -293,40 +280,9 @@ testcase_38()
 
 shmmax=`cat /proc/sys/kernel/shmmax`
 if [ $shmmax -lt $HUGEPAGESIZE ]; then
-	echo $(($HUGEPAGESIZE)) > /proc/sys/kernel/shmmax
+	ROD "$HUGEPAGESIZE" \> /proc/sys/kernel/shmmax
 fi
 
-# Run all the test cases
-for i in $(seq 1 $TST_TOTAL)
-do
-	export TST_COUNT=$(( $TST_COUNT + 1 ))
-	cur_id=$i
+run_tests
 
-	do_mount
-	if [ $? -ne 0 ]; then
-		echo "Cannot create memcg"
-		exit 1
-	fi
-
-	# prepare
-	mkdir /dev/memcg/$i 2> /dev/null
-	cd /dev/memcg/$i
-
-	# run the case
-	testcase_$i
-
-	# clean up
-	sleep 1
-	cd $TEST_PATH
-	rmdir /dev/memcg/$i
-
-	cleanup
-done
-
-echo $shmmax > /proc/sys/kernel/shmmax
-
-if [ $failed -ne 0 ]; then
-	exit $failed
-else
-	exit 0
-fi
+tst_exit
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_getpagesize.c b/testcases/kernel/controllers/memcg/functional/memcg_getpagesize.c
deleted file mode 100644
index 557b540..0000000
--- a/testcases/kernel/controllers/memcg/functional/memcg_getpagesize.c
+++ /dev/null
@@ -1,30 +0,0 @@
-/******************************************************************************/
-/*                                                                            */
-/* Copyright (c) 2009 FUJITSU LIMITED                                         */
-/*                                                                            */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/* Author: Li Zefan <lizf@cn.fujitsu.com>                                     */
-/*                                                                            */
-/******************************************************************************/
-
-#include <unistd.h>
-#include <stdio.h>
-
-int main(void)
-{
-	printf("%d\n", getpagesize());
-	return 0;
-}
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index c90d0a2..46e6c7f 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -22,42 +22,51 @@
 ##                                                                            ##
 ################################################################################
 
+. test.sh
+
 if [ "x$(grep -w memory /proc/cgroups | cut -f4)" != "x1" ]; then
-	echo "WARNING:";
-	echo "Either Kernel does not support for memory resource controller or feature not enabled";
-	echo "Skipping all memcgroup testcases....";
-	exit 0
+	tst_brkm TCONF "Kernel does not support the memory resource controller"
 fi
 
-cd $LTPROOT/testcases/bin
+PAGESIZE=$(getconf PAGESIZE)
+if [ $? -ne 0 ]; then
+	tst_brkm TBROK "getconf PAGESIZE failed"
+fi
 
-TEST_PATH=$PWD
-PAGESIZE=`./memcg_getpagesize`
-HUGEPAGESIZE=`grep Hugepagesize /proc/meminfo | awk '{ print $2 }'`
+HUGEPAGESIZE=$(awk '/Hugepagesize/ {print $2}' /proc/meminfo)
 [ -z $HUGEPAGESIZE ] && HUGEPAGESIZE=0
 HUGEPAGESIZE=$(( $HUGEPAGESIZE * 1024 ))
-PASS=0
-FAIL=1
 orig_memory_use_hierarchy=""
 
-cur_id=0
-failed=0
+MEMSW_USAGE_FLAG=0
+MEMSW_LIMIT_FLAG=0
 
-# Record the test result of a test case
-# $1 - The result of the test case, $PASS or $FAIL
-# $2 - The output information
-result()
+tst_tmpdir
+TMP_DIR="$PWD"
+
+cleanup()
 {
-	local pass=$1
-	local info="$2"
+	if [ -n "$LOCAL_CLEANUP" ]; then
+		$LOCAL_CLEANUP
+	fi
 
-	if [ $pass -eq $PASS ]; then
-		tst_resm TPASS "$info"
-	else
-		tst_resm TFAIL "$info"
-		: $(( failed += 1 ))
+	killall -9 memcg_process 2> /dev/null
+	wait
+
+	cd "$TMP_DIR"
+
+	if [ -n "$TEST_ID" -a -d "/dev/memcg/$TEST_ID" ]; then
+		rmdir "/dev/memcg/$TEST_ID"
 	fi
+
+	if [ -d "/dev/memcg" ]; then
+		umount /dev/memcg
+		rmdir /dev/memcg
+	fi
+
+	tst_rmdir
 }
+TST_CLEANUP=cleanup
 
 # Check size in memcg
 # $1 - Item name
@@ -71,19 +80,17 @@ check_mem_stat()
 	fi
 
 	if [ "$2" = "$item_size" ]; then
-		pass=$PASS
+		tst_resm TPASS "$1 is $2 as expected"
 	else
-		pass=$FAIL
+		tst_resm TFAIL "$1 is $item_size, $2 expected"
 	fi
-
-	result $pass "$1=$item_size/$2"
 }
 
 warmup()
 {
 	pid=$1
 
-	echo "Warming up for test: $cur_id, pid: $pid"
+	tst_resm TINFO "Warming up pid: $pid"
 	kill -s USR1 $pid 2> /dev/null
 	sleep 1
 	kill -s USR1 $pid 2> /dev/null
@@ -91,10 +98,11 @@ warmup()
 
 	kill -0 $pid
 	if [ $? -ne 0 ]; then
-		result $FAIL "cur_id=$cur_id"
+		wait $pid
+		tst_resm TFAIL "Process $pid exited with $? after warm up"
 		return 1
 	else
-		echo "Process is still here after warm up: $pid"
+		tst_resm TINFO "Process is still here after warm up: $pid"
 	fi
 
 	return 0
@@ -109,8 +117,8 @@ warmup()
 # $5 - check after free ?
 test_mem_stat()
 {
-	echo "Running $TEST_PATH/memcg_process $1 -s $2"
-	$TEST_PATH/memcg_process $1 -s $2 &
+	tst_resm TINFO "Running memcg_process $1 -s $2"
+	memcg_process $1 -s $2 &
 	sleep 1
 
 	warmup $!
@@ -142,8 +150,8 @@ test_mem_stat()
 # $5 - check after free ?
 test_max_usage_in_bytes()
 {
-	echo "Running $TEST_PATH/memcg_process $1 -s $2"
-	$TEST_PATH/memcg_process $1 -s $2 &
+	tst_resm TINFO "Running memcg_process $1 -s $2"
+	memcg_process $1 -s $2 &
 	sleep 1
 
 	warmup $!
@@ -173,8 +181,8 @@ test_max_usage_in_bytes()
 # $2 - the -s parameter of 'process', such as 4096
 malloc_free_memory()
 {
-	echo "Running $TEST_PATH/memcg_process $1 -s $2"
-	$TEST_PATH/memcg_process $1 -s $2 &
+	tst_resm TINFO "Running memcg_process $1 -s $2"
+	memcg_process $1 -s $2 &
 	sleep 1
 
 	echo $! > tasks
@@ -193,12 +201,10 @@ test_failcnt()
 {
 	failcnt=`cat $1`
 	if [ $failcnt -gt 0 ]; then
-		pass=$PASS
+		tst_resm TPASS "$1 is $failcnt, > 0 as expected"
 	else
-		pass=$FAIL
+		tst_resm TFAIL "$1 is $failcnt, <= 0 expected"
 	fi
-
-	result $pass "$1=$failcnt"
 }
 
 # Test process will be killed due to exceed memory limit
@@ -218,7 +224,7 @@ test_proc_kill()
 		fi
 	fi
 
-	$TEST_PATH/memcg_process $2 -s $3 &
+	memcg_process $2 -s $3 &
 	pid=$!
 	sleep 1
 	echo $pid > tasks
@@ -231,15 +237,15 @@ test_proc_kill()
 		wait $pid
 		ret=$?
 		if [ $ret -eq 1 ]; then
-			result $FAIL "process $pid is killed by error"
+			tst_resm TFAIL "process $pid is killed by error"
 		elif [ $ret -eq 2 ]; then
-			result $PASS "Failed to lock memory"
+			tst_resm TFAIL "Failed to lock memory"
 		else
-			result $PASS "process $pid is killed"
+			tst_resm TPASS "process $pid is killed"
 		fi
 	else
 		kill -s INT $pid 2> /dev/null
-		result $FAIL "process $pid is not killed"
+		tst_resm TFAIL "process $pid is not killed"
 	fi
 }
 
@@ -265,12 +271,14 @@ test_limit_in_bytes()
 	# are rounding down
 	if [ \( $(($PAGESIZE*($1/$PAGESIZE))) -eq $limit \) \
 	    -o \( $(($PAGESIZE*(($1+$PAGESIZE-1)/$PAGESIZE))) -eq $limit \) ]; then
-		result $PASS "input=$1, limit_in_bytes=$limit"
+		tst_resm TPASS "input=$1, limit_in_bytes=$limit"
 	else
-		result $FAIL "input=$1, limit_in_bytes=$limit"
+		tst_resm TFAIL "input=$1, limit_in_bytes=$limit"
 	fi
 }
 
+# Never used, so untested
+#
 # Test memory controller doesn't charge hugepage
 # $1 - the value of /proc/sys/vm/nr_hugepages
 # $2 - the parameters of 'process', --mmap-file or --shm
@@ -278,7 +286,7 @@ test_limit_in_bytes()
 # $4 - 0: expected failure, 1: expected success
 test_hugepage()
 {
-	TMP_FILE=$TEST_PATH/tmp
+	TMP_FILE="$TMP_DIR/tmp"
 	nr_hugepages=`cat /proc/sys/vm/nr_hugepages`
 
 	mkdir /hugetlb
@@ -286,7 +294,7 @@ test_hugepage()
 
 	echo $1 > /proc/sys/vm/nr_hugepages
 
-	$TEST_PATH/memcg_process $2 --hugepage -s $3 > $TMP_FILE 2>&1 &
+	memcg_process $2 --hugepage -s $3 > $TMP_FILE 2>&1 &
 	sleep 1
 
 	kill -s USR1 $! 2> /dev/null
@@ -300,20 +308,20 @@ test_hugepage()
 	if [ $4 -eq 0 ]; then
 		test -s $TMP_FILE
 		if [ $? -eq 0 ]; then
-			result $PASS "allocate hugepage failed as expected"
+			tst_resm TPASS "allocate hugepage failed as expected"
 		else
 			kill -s USR1 $! 2> /dev/null
 			kill -s INT $! 2> /dev/null
-			result $FAIL "allocate hugepage shoud fail"
+			tst_resm TFAIL "allocate hugepage should fail"
 		fi
 	else
 		test ! -s $TMP_FILE
 		if [ $? -eq 0 ]; then
 			kill -s USR1 $! 2> /dev/null
 			kill -s INT $! 2> /dev/null
-			result $PASS "allocate hugepage succeeded"
+			tst_resm TPASS "allocate hugepage succeeded"
 		else
-			result $FAIL "allocate hugepage failed"
+			tst_resm TFAIL "allocate hugepage failed"
 		fi
 	fi
 
@@ -333,8 +341,8 @@ test_subgroup()
 	echo $1 > memory.limit_in_bytes
 	echo $2 > subgroup/memory.limit_in_bytes
 
-	echo "Running $TEST_PATH/memcg_process --mmap-anon -s $PAGESIZE"
-	$TEST_PATH/memcg_process --mmap-anon -s $PAGESIZE &
+	tst_resm TINFO "Running memcg_process --mmap-anon -s $PAGESIZE"
+	memcg_process --mmap-anon -s $PAGESIZE &
 	sleep 1
 
 	warmup $!
@@ -369,7 +377,8 @@ test_move_charge()
 {
 	mkdir subgroup_a
 
-	$TEST_PATH/memcg_process $1 -s $2 &
+	tst_resm TINFO "Running memcg_process $1 -s $2"
+	memcg_process $1 -s $2 &
 	sleep 1
 	warmup $!
 	if [ $? -ne 0 ]; then
@@ -400,8 +409,10 @@ test_move_charge()
 	rmdir subgroup_a subgroup_b
 }
 
-cleanup()
+cleanup_test()
 {
+	TEST_ID="$1"
+
 	if [ -n "$orig_memory_use_hierarchy" ];then
 		echo $orig_memory_use_hierarchy > \
 		     /dev/memcg/memory.use_hierarchy
@@ -413,18 +424,22 @@ cleanup()
 	fi
 
 	killall -9 memcg_process 2>/dev/null
-	if [ -e /dev/memcg ]; then
-		umount /dev/memcg 2>/dev/null
-		rmdir /dev/memcg 2>/dev/null
-	fi
+	wait
+
+	ROD cd "$TMP_DIR"
+
+	ROD rmdir "/dev/memcg/$TEST_ID"
+	TEST_ID=""
+	ROD umount /dev/memcg
+	ROD rmdir /dev/memcg
 }
 
-do_mount()
+setup_test()
 {
-	cleanup
+	TEST_ID="$1"
 
-	mkdir /dev/memcg 2> /dev/null
-	mount -t cgroup -omemory memcg /dev/memcg
+	ROD mkdir /dev/memcg
+	ROD mount -t cgroup -omemory memcg /dev/memcg
 
 	# The default value for memory.use_hierarchy is 0 and some of tests
 	# (memcg_stat_test.sh and memcg_use_hierarchy_test.sh) expect it so
@@ -442,4 +457,27 @@ do_mount()
 				"to 0 failed"
 		fi
 	fi
+
+	ROD mkdir "/dev/memcg/$TEST_ID"
+	ROD cd "/dev/memcg/$TEST_ID"
+}
+
+# Run all the test cases
+run_tests()
+{
+	for i in $(seq 1 $TST_TOTAL); do
+		setup_test $i
+
+		if [ -e memory.memsw.limit_in_bytes ]; then
+			MEMSW_LIMIT_FLAG=1
+		fi
+
+		if [ -e memory.memsw.max_usage_in_bytes ]; then
+			MEMSW_USAGE_FLAG=1
+		fi
+
+		testcase_$i
+
+		cleanup_test $i
+	done
 }
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_max_usage_in_bytes_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_max_usage_in_bytes_test.sh
index 9e286f5..91112be 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_max_usage_in_bytes_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_max_usage_in_bytes_test.sh
@@ -26,13 +26,10 @@
 # History:      2012/01/17 - Created.
 #
 
-export TCID="memcg_max_usage_in_bytes_test"
-export TST_TOTAL=4
-export TST_COUNT=0
+TCID="memcg_max_usage_in_bytes_test"
+TST_TOTAL=4
 
-. memcg_lib.sh || exit 1
-
-MEM_SWAP_FLAG=0
+. memcg_lib.sh
 
 # Test memory.max_usage_in_bytes
 testcase_1()
@@ -44,7 +41,7 @@ testcase_1()
 # Test memory.memsw.max_usage_in_bytes
 testcase_2()
 {
-	if [ $MEM_SWAP_FLAG -eq 0 ]; then
+	if [ "$MEMSW_USAGE_FLAG" -eq 0 ]; then
 		tst_resm TCONF "mem+swap is not enabled"
 		return
 	fi
@@ -65,7 +62,7 @@ testcase_3()
 # Test reset memory.memsw.max_usage_in_bytes
 testcase_4()
 {
-	if [ $MEM_SWAP_FLAG -eq 0 ]; then
+	if [ "$MEMSW_USAGE_FLAG" -eq 0 ]; then
 		tst_resm TCONF "mem+swap is not enabled"
 		return
 	fi
@@ -76,39 +73,7 @@ testcase_4()
 		"memory.memsw.max_usage_in_bytes" $((PAGESIZE*1024)) 1
 }
 
-# Run all the test cases
-for i in $(seq 1 $TST_TOTAL)
-do
-	export TST_COUNT=$(( $TST_COUNT + 1 ))
-	cur_id=$i
-
-	do_mount
-	if [ $? -ne 0 ]; then
-		echo "Cannot create memcg"
-		exit 1
-	fi
-
-	# prepare
-	mkdir /dev/memcg/$i 2> /dev/null
-	cd /dev/memcg/$i
-
-	if [ -e memory.memsw.max_usage_in_bytes ]; then
-		MEM_SWAP_FLAG=1
-	fi
-
-	# run the case
-	testcase_$i
-
-	# clean up
-	sleep 1
-	cd $TEST_PATH
-	rmdir /dev/memcg/$i
+run_tests
 
-	cleanup
-done
+tst_exit
 
-if [ $failed -ne 0 ]; then
-	exit $failed
-else
-	exit 0
-fi
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_memsw_limit_in_bytes_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_memsw_limit_in_bytes_test.sh
index f49508c..6a459f7 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_memsw_limit_in_bytes_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_memsw_limit_in_bytes_test.sh
@@ -26,13 +26,10 @@
 # History:      2012/01/3 - Created.
 #
 
-export TCID="memcg_memsw_limit_in_bytes_test"
-export TST_TOTAL=12
-export TST_COUNT=0
+TCID="memcg_memsw_limit_in_bytes_test"
+TST_TOTAL=12
 
-. memcg_lib.sh || exit 1
-
-MEM_SWAP_FLAG=0
+. memcg_lib.sh
 
 testcase_1()
 {
@@ -76,91 +73,54 @@ testcase_8()
 
 testcase_9()
 {
-	if [ $MEM_SWAP_FLAG -eq 0 ]; then
+	if [ "$MEMSW_LIMIT_FLAG" -eq 0 ]; then
 		tst_resm TCONF "mem+swap is not enabled"
 		return
 	fi
 
 	echo 10M > memory.limit_in_bytes
-	echo -1 > memory.memsw.limit_in_bytes 2> /dev/null
-	ret=$?
+
 	tst_kvercmp 2 6 31
 	if [ $? -eq 0 ]; then
-		result $(( !($ret != 0) ))  "return value is $ret"
+		EXPECT_FAIL echo -1 \> memory.memsw.limit_in_bytes
 	else
-		result $(( !($ret == 0) ))  "return value is $ret"
+		EXPECT_PASS echo -1 \> memory.memsw.limit_in_bytes
 	fi
 }
 
 testcase_10()
 {
-	if [ $MEM_SWAP_FLAG -eq 0 ]; then
+	if [ "$MEMSW_LIMIT_FLAG" -eq 0 ]; then
 		tst_resm TCONF "mem+swap is not enabled"
 		return
 	fi
 
 	echo 10M > memory.limit_in_bytes
-	echo 1.0 > memory.memsw.limit_in_bytes 2> /dev/null
-	result $(( !($? != 0) )) "return value is $?"
+	EXPECT_FAIL echo 1.0 \> memory.memsw.limit_in_bytes
 }
 
 testcase_11()
 {
-	if [ $MEM_SWAP_FLAG -eq 0 ]; then
+	if [ "$MEMSW_LIMIT_FLAG" -eq 0 ]; then
 		tst_resm TCONF "mem+swap is not enabled"
 		return
 	fi
 
 	echo 10M > memory.limit_in_bytes
-	echo 1xx > memory.memsw.limit_in_bytes 2> /dev/null
-	result $(( !($? != 0) )) "return value is $?"
+	EXPECT_FAIL echo 1xx \> memory.memsw.limit_in_bytes
 }
 
 testcase_12()
 {
-	if [ $MEM_SWAP_FLAG -eq 0 ]; then
+	if [ "$MEMSW_LIMIT_FLAG" -eq 0 ]; then
 		tst_resm TCONF "mem+swap is not enabled"
 		return
 	fi
 
 	echo 10M > memory.limit_in_bytes
-	echo xx > memory.memsw.limit_in_bytes 2> /dev/null
-	result $(( !($? != 0) )) "return value is $?"
+	EXPECT_FAIL echo xx \> memory.memsw.limit_in_bytes
 }
 
-# Run all the test cases
-for i in $(seq 1 $TST_TOTAL)
-do
-	export TST_COUNT=$(( $TST_COUNT + 1 ))
-	cur_id=$i
-
-	do_mount
-	if [ $? -ne 0 ]; then
-		echo "Cannot create memcg"
-		exit 1
-	fi
-
-	# prepare
-	mkdir /dev/memcg/$i 2> /dev/null
-	cd /dev/memcg/$i
-
-	if [ -e memory.memsw.limit_in_bytes ]; then
-		MEM_SWAP_FLAG=1
-	fi
-
-	# run the case
-	testcase_$i
-
-	# clean up
-	sleep 1
-	cd $TEST_PATH
-	rmdir /dev/memcg/$i
-
-	cleanup
-done
+run_tests
 
-if [ $failed -ne 0 ]; then
-	exit $failed
-else
-	exit 0
-fi
+tst_exit
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_move_charge_at_immigrate_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_move_charge_at_immigrate_test.sh
index 406bd07..aeb7d0f 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_move_charge_at_immigrate_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_move_charge_at_immigrate_test.sh
@@ -26,11 +26,10 @@
 # History:      2012/01/16 - Created.
 #
 
-export TCID="memcg_move_charge_at_immigrate_test"
-export TST_TOTAL=4
-export TST_COUNT=0
+TCID="memcg_move_charge_at_immigrate_test"
+TST_TOTAL=4
 
-. memcg_lib.sh || exit 1
+. memcg_lib.sh
 
 # Test disable moving charges
 testcase_1()
@@ -58,35 +57,6 @@ testcase_4()
 	test_move_charge "--mmap-anon --shm" $PAGESIZE 3 $PAGESIZE $PAGESIZE 0 0
 }
 
-# Run all the test cases
-for i in $(seq 1 $TST_TOTAL)
-do
-	export TST_COUNT=$(( $TST_COUNT + 1 ))
-	cur_id=$i
+run_tests
 
-	do_mount
-	if [ $? -ne 0 ]; then
-		echo "Cannot create memcg"
-		exit 1
-	fi
-
-	# prepare
-	mkdir /dev/memcg/$i 2> /dev/null
-	cd /dev/memcg/$i
-
-	# run the case
-	testcase_$i
-
-	# clean up
-	sleep 1
-	cd $TEST_PATH
-	rmdir /dev/memcg/$i
-
-	cleanup
-done
-
-if [ $failed -ne 0 ]; then
-	exit $failed
-else
-	exit 0
-fi
+tst_exit
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh
index 0151f85..1f28aa4 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh
@@ -26,13 +26,10 @@
 # History:      2012/01/16 - Created.
 #
 
-export TCID="memcg_stat_test"
-export TST_TOTAL=8
-export TST_COUNT=0
+TCID="memcg_stat_test"
+TST_TOTAL=8
 
-. memcg_lib.sh || exit 1
-
-MEM_SWAP_FLAG=0
+. memcg_lib.sh
 
 # Test cache
 testcase_1()
@@ -93,7 +90,7 @@ testcase_6()
 # Test hierarchical_memsw_limit with enabling hierarchical accounting
 testcase_7()
 {
-	if [ $MEM_SWAP_FLAG -eq 0 ]; then
+	if [ "$MEMSW_LIMIT_FLAG" -eq 0 ]; then
 		tst_resm TCONF "mem+swap is not enabled"
 		return
 	fi
@@ -116,7 +113,7 @@ testcase_7()
 # Test hierarchical_memsw_limit with disabling hierarchical accounting
 testcase_8()
 {
-	if [ $MEM_SWAP_FLAG -eq 0 ]; then
+	if [ "$MEMSW_LIMIT_FLAG" -eq 0 ]; then
 		tst_resm TCONF "mem+swap is not enabled"
 		return
 	fi
@@ -136,39 +133,7 @@ testcase_8()
 	rmdir subgroup
 }
 
-# Run all the test cases
-for i in $(seq 1 $TST_TOTAL)
-do
-	export TST_COUNT=$(( $TST_COUNT + 1 ))
-	cur_id=$i
-
-	do_mount
-	if [ $? -ne 0 ]; then
-		echo "Cannot create memcg"
-		exit 1
-	fi
-
-	# prepare
-	mkdir /dev/memcg/$i 2> /dev/null
-	cd /dev/memcg/$i
-
-	if [ -e memory.memsw.limit_in_bytes ]; then
-		MEM_SWAP_FLAG=1
-	fi
-
-	# run the case
-	testcase_$i
-
-	# clean up
-	sleep 1
-	cd $TEST_PATH
-	rmdir /dev/memcg/$i
+run_tests
 
-	cleanup
-done
+tst_exit
 
-if [ $failed -ne 0 ]; then
-	exit $failed
-else
-	exit 0
-fi
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_usage_in_bytes_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_usage_in_bytes_test.sh
index a4d0542..ab86318 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_usage_in_bytes_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_usage_in_bytes_test.sh
@@ -26,13 +26,10 @@
 # History:      2012/01/16 - Created.
 #
 
-export TCID="memcg_usage_in_bytes_test"
-export TST_TOTAL=2
-export TST_COUNT=0
+TCID="memcg_usage_in_bytes_test"
+TST_TOTAL=2
 
-. memcg_lib.sh || exit 1
-
-MEM_SWAP_FLAG=0
+. memcg_lib.sh
 
 # Test memory.usage_in_bytes
 testcase_1()
@@ -44,7 +41,7 @@ testcase_1()
 # Test memory.memsw.usage_in_bytes
 testcase_2()
 {
-	if [ $MEM_SWAP_FLAG -eq 0 ]; then
+	if [ "$MEMSW_USAGE_FLAG" -eq 0 ]; then
 		tst_resm TCONF "mem+swap is not enabled"
 		return
 	fi
@@ -55,39 +52,7 @@ testcase_2()
 		"memory.memsw.usage_in_bytes" $((PAGESIZE*1024)) 0
 }
 
-# Run all the test cases
-for i in $(seq 1 $TST_TOTAL)
-do
-	export TST_COUNT=$(( $TST_COUNT + 1 ))
-	cur_id=$i
-
-	do_mount
-	if [ $? -ne 0 ]; then
-		echo "Cannot create memcg"
-		exit 1
-	fi
-
-	# prepare
-	mkdir /dev/memcg/$i 2> /dev/null
-	cd /dev/memcg/$i
-
-	if [ -e memory.memsw.usage_in_bytes ]; then
-		MEM_SWAP_FLAG=1
-	fi
-
-	# run the case
-	testcase_$i
-
-	# clean up
-	sleep 1
-	cd $TEST_PATH
-	rmdir /dev/memcg/$i
+run_tests
 
-	cleanup
-done
+tst_exit
 
-if [ $failed -ne 0 ]; then
-	exit $failed
-else
-	exit 0
-fi
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_use_hierarchy_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_use_hierarchy_test.sh
index f48c50a..4cf6b9f 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_use_hierarchy_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_use_hierarchy_test.sh
@@ -26,11 +26,10 @@
 # History:      2012/01/14 - Created.
 #
 
-export TCID="memcg_use_hierarchy_test"
-export TST_TOTAL=3
-export TST_COUNT=0
+TCID="memcg_use_hierarchy_test"
+TST_TOTAL=3
 
-. memcg_lib.sh || exit 1
+. memcg_lib.sh
 
 # test if one of the ancestors goes over its limit, the proces will be killed
 testcase_1()
@@ -50,8 +49,7 @@ testcase_1()
 testcase_2()
 {
 	mkdir subgroup
-	echo 1 > memory.use_hierarchy 2> /dev/null
-	result $(( !($? != 0) )) "return value is $?"
+	EXPECT_FAIL echo 1 \> memory.use_hierarchy
 
 	rmdir subgroup
 }
@@ -61,41 +59,12 @@ testcase_3()
 {
 	echo 1 > memory.use_hierarchy
 	mkdir subgroup
-	echo 0 > subgroup/memory.use_hierarchy 2> /dev/null
-	result $(( !($? != 0) )) "return value is $?"
+	EXPECT_FAIL echo 0 \> subgroup/memory.use_hierarchy
 
 	rmdir subgroup
 }
 
-# Run all the test cases
-for i in $(seq 1 $TST_TOTAL)
-do
-	export TST_COUNT=$(( $TST_COUNT + 1 ))
-	cur_id=$i
+run_tests
 
-	do_mount
-	if [ $? -ne 0 ]; then
-		echo "Cannot create memcg"
-		exit 1
-	fi
+tst_exit
 
-	# prepare
-	mkdir /dev/memcg/$i 2> /dev/null
-	cd /dev/memcg/$i
-
-	# run the case
-	testcase_$i
-
-	# clean up
-	sleep 1
-	cd $TEST_PATH
-	rmdir /dev/memcg/$i
-
-	cleanup
-done
-
-if [ $failed -ne 0 ]; then
-	exit $failed
-else
-	exit 0
-fi
-- 
1.7.1

