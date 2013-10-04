Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VS2K8-0004uN-83
	for ltp-list@lists.sourceforge.net; Fri, 04 Oct 2013 10:09:28 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VS2K6-00023Q-TQ
	for ltp-list@lists.sourceforge.net; Fri, 04 Oct 2013 10:09:28 +0000
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri,  4 Oct 2013 14:08:59 +0400
Message-Id: <1380881342-13025-3-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1380881342-13025-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1380881342-13025-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 2/5] controllers/cpuset: removed './' next to binaries
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
Cc: vasily.isaenko@oracle.com, miaox@cn.fujitsu.com

In the testcases removed './' next to binaries.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../cpuset_hotplug_test/cpuset_hotplug_test.sh     |    6 ++--
 .../cpuset_load_balance_test.sh                    |    4 +-
 .../cpuset_sched_domains_test.sh                   |    6 ++--
 .../cpuset_memory_pressure_testset.sh              |   10 +++---
 .../cpuset_memory_spread_testset.sh                |    4 +-
 .../cpuset_memory_test/cpuset_memory_testset.sh    |   36 ++++++++++----------
 .../cpuset_syscall_test/cpuset_syscall_testset.sh  |    6 ++--
 7 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
index 1a8eb98..611ea62 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
@@ -36,7 +36,7 @@ nr_cpus=$NR_CPUS
 nr_mems=$N_NODES
 
 cpus_all="$(seq -s, 0 $((nr_cpus-1)))"
-cpus_all="`./cpuset_list_compute $cpus_all`"
+cpus_all="`cpuset_list_compute $cpus_all`"
 mems_all="$(seq -s, 0 $((nr_mems-1)))"
 
 # check_result <result> <expect>
@@ -224,7 +224,7 @@ base_test()
 # Test Case 1-2
 test_root_cpu_hotplug()
 {
-	local tmp_cpus="`./cpuset_list_compute -s $cpus_all $HOTPLUG_CPU`"
+	local tmp_cpus="`cpuset_list_compute -s $cpus_all $HOTPLUG_CPU`"
 
 	test_function="root_cpu_hotplug_test"
 	while read hotplug cpus_expect task_expect
@@ -240,7 +240,7 @@ test_root_cpu_hotplug()
 # Test Case 3-6
 test_general_cpu_hotplug()
 {
-	local tmp_cpus="`./cpuset_list_compute -s $cpus_all $HOTPLUG_CPU`"
+	local tmp_cpus="`cpuset_list_compute -s $cpus_all $HOTPLUG_CPU`"
 
 	test_function="general_cpu_hotplug_test"
 	while read hotplug cpus cpus_expect task_expect
diff --git a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_load_balance_test.sh b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_load_balance_test.sh
index 0c9e5c6..8ba7222 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_load_balance_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_load_balance_test.sh
@@ -84,7 +84,7 @@ general_load_balance_test1()
 		return 1
 	fi
 
-	./cpuset_cpu_hog 2> $CPUSET_TMP/cpu-hog_stderr &
+	cpuset_cpu_hog 2> $CPUSET_TMP/cpu-hog_stderr &
 	pid=$!
 
 	read fifo < ./myfifo
@@ -209,7 +209,7 @@ general_load_balance_test2()
 		return 1
 	fi
 
-	./cpuset_cpu_hog 2> $CPUSET_TMP/cpu-hog_stderr &
+	cpuset_cpu_hog 2> $CPUSET_TMP/cpu-hog_stderr &
 	pid=$!
 
 	# wait for the parent to do prepare
diff --git a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_test.sh b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_test.sh
index 27d8266..53675ec 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_test.sh
@@ -76,7 +76,7 @@ root_load_balance_test()
 
 	# check sched domains of every CPU
 	sleep 1
-	./cpuset_sched_domains_check 2> $CPUSET_TMP/stderr
+	cpuset_sched_domains_check 2> $CPUSET_TMP/stderr
 	ret=$?
 	if [ $ret -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
@@ -119,7 +119,7 @@ general_load_balance_test1()
 
 	# check sched domains of every CPU
 	sleep 1
-	./cpuset_sched_domains_check 2> $CPUSET_TMP/stderr
+	cpuset_sched_domains_check 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
 		tst_resm TFAIL "partition sched domains failed."
@@ -195,7 +195,7 @@ general_load_balance_test2()
 
 	# check sched domains of every CPU
 	sleep 1
-	./cpuset_sched_domains_check > $CPUSET_TMP/stdout
+	cpuset_sched_domains_check > $CPUSET_TMP/stdout
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stdout
 		tst_resm TFAIL "partition sched domains failed."
diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/cpuset_memory_pressure_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/cpuset_memory_pressure_testset.sh
index 889398f..fcf00d4 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/cpuset_memory_pressure_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/cpuset_memory_pressure_testset.sh
@@ -69,7 +69,7 @@ test2()
 		return 1
 	fi
 
-	./cpuset_memory_pressure $usemem
+	cpuset_memory_pressure $usemem
 
 	local i
 	for i in $(seq 0 9)
@@ -135,7 +135,7 @@ test4()
 		return 1
 	fi
 
-	./cpuset_memory_pressure $usemem
+	cpuset_memory_pressure $usemem
 
 	echo $$ > "$CPUSET/tasks" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
@@ -174,7 +174,7 @@ test5()
 		return 1
 	fi
 
-	./cpuset_memory_pressure $usemem
+	cpuset_memory_pressure $usemem
 	local i
 	for i in $(seq 0 9)
 	do
@@ -211,7 +211,7 @@ test6()
 		tst_resm TFAIL "attaching self to sub group failed"
 		return 1
 	fi
-	./cpuset_memory_pressure $usemem
+	cpuset_memory_pressure $usemem
 
 	echo $$ > "$CPUSET/tasks" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
@@ -220,7 +220,7 @@ test6()
 		return 1
 	fi
 
-	./cpuset_memory_pressure $usemem
+	cpuset_memory_pressure $usemem
 	local i
 	for i in $(seq 0 9)
 	do
diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
index f3f3b09..b8a434f 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
@@ -256,7 +256,7 @@ base_test()
 	if [ $? -ne 0 ]; then
 		exit_status=1
 	else
-		./cpuset_mem_hog &
+		cpuset_mem_hog &
 		pid=$!
 		general_memory_spread_test "$@" "$pid"
 		result_num=$?
@@ -303,7 +303,7 @@ test_spread_page2()
 	if [ $? -ne 0 ]; then
 		exit_status=1
 	else
-		./cpuset_mem_hog &
+		cpuset_mem_hog &
 		pid=$!
 		general_memory_spread_test "1" "$cpus_all" "0" "0" "$pid"
 		result_num=$?
diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
index bc4ff1c..315f759 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
@@ -71,7 +71,7 @@ test1()
 		return 1
 	fi
 
-	./cpuset_memory_test --mmap-anon >"$MEMORY_RESULT" &
+	cpuset_memory_test --mmap-anon >"$MEMORY_RESULT" &
 	simple_getresult $! "$CPUSET/0"
 	if [ "$node" != "0" ]; then
 		tst_resm TFAIL "allocate memory on the Node#$node(Expect: Node#0)."
@@ -88,7 +88,7 @@ test2()
 		return 1
 	fi
 
-	./cpuset_memory_test --mmap-file >"$MEMORY_RESULT" &
+	cpuset_memory_test --mmap-file >"$MEMORY_RESULT" &
 	simple_getresult $! "$CPUSET/0"
 	if [ "$node" != "0" ]; then
 		tst_resm TFAIL "allocate memory on the Node#$node(Expect: Node#0)."
@@ -105,7 +105,7 @@ test3()
 		return 1
 	fi
 
-	./cpuset_memory_test --shm >"$MEMORY_RESULT" &
+	cpuset_memory_test --shm >"$MEMORY_RESULT" &
 	simple_getresult $! "$CPUSET/0"
 	if [ "$node" != "0" ]; then
 		tst_resm TFAIL "allocate memory on the Node#$node(Expect: Node#0)."
@@ -122,7 +122,7 @@ test4()
 		return 1
 	fi
 
-	./cpuset_memory_test --mmap-lock1 >"$MEMORY_RESULT" &
+	cpuset_memory_test --mmap-lock1 >"$MEMORY_RESULT" &
 	simple_getresult $! "$CPUSET/0"
 	if [ "$node" != "0" ]; then
 		tst_resm TFAIL "allocate memory on the Node#$node(Expect: Node#0)."
@@ -139,7 +139,7 @@ test5()
 		return 1
 	fi
 
-	./cpuset_memory_test --mmap-lock2 >"$MEMORY_RESULT" &
+	cpuset_memory_test --mmap-lock2 >"$MEMORY_RESULT" &
 	simple_getresult $! "$CPUSET/0"
 	if [ "$node" != "0" ]; then
 		tst_resm TFAIL "allocate memory on the Node#$node(Expect: Node#0)."
@@ -182,7 +182,7 @@ test6()
 	save_nr_hugepages=$(cat /proc/sys/vm/nr_hugepages)
 	echo $((2*$nr_mems)) > /proc/sys/vm/nr_hugepages
 
-	./cpuset_memory_test --mmap-file --hugepage -s $HUGEPAGESIZE >"$MEMORY_RESULT" &
+	cpuset_memory_test --mmap-file --hugepage -s $HUGEPAGESIZE >"$MEMORY_RESULT" &
 	simple_getresult $! "$CPUSET/0"
 
 	umount /hugetlb
@@ -221,7 +221,7 @@ test7()
 	save_nr_hugepages=$(cat /proc/sys/vm/nr_hugepages)
 	echo $((2*$nr_mems)) > /proc/sys/vm/nr_hugepages
 
-	./cpuset_memory_test --shm --hugepage -s $HUGEPAGESIZE --key=7 >"$MEMORY_RESULT" &
+	cpuset_memory_test --shm --hugepage -s $HUGEPAGESIZE --key=7 >"$MEMORY_RESULT" &
 	simple_getresult $! "$CPUSET/0"
 
 	umount /hugetlb
@@ -248,7 +248,7 @@ test8()
 		return 1
 	fi
 
-	./cpuset_memory_test --mmap-anon >"$MEMORY_RESULT" &
+	cpuset_memory_test --mmap-anon >"$MEMORY_RESULT" &
 	simple_getresult $! "$CPUSET/0"
 	if [ "$node" != "0" ]; then
 		tst_resm TFAIL "allocate memory on the Node#$node(Expect: Node#0)."
@@ -265,7 +265,7 @@ test9()
 		return 1
 	fi
 
-	./cpuset_memory_test --mmap-anon >"$MEMORY_RESULT" &
+	cpuset_memory_test --mmap-anon >"$MEMORY_RESULT" &
 	simple_getresult $! "$CPUSET/0"
 	if [ "$node" != "1" ]; then
 		tst_resm TFAIL "allocate memory on the Node#$node(Expect: Node#1)."
@@ -308,7 +308,7 @@ test10()
 		return 1
 	fi
 
-	./cpuset_memory_test --mmap-anon --check >"$MEMORY_RESULT" &
+	cpuset_memory_test --mmap-anon --check >"$MEMORY_RESULT" &
 	talk2memory_test_for_case_10_11 $! "$CPUSET/1" "$CPUSET/2"
 	{
 		read node0
@@ -353,7 +353,7 @@ test11()
 		return 1
 	fi
 
-	./cpuset_memory_test --mmap-anon --check >"$MEMORY_RESULT" &
+	cpuset_memory_test --mmap-anon --check >"$MEMORY_RESULT" &
 	talk2memory_test_for_case_10_11 $! "$CPUSET/1" "$CPUSET/2"
 	{
 		read node0
@@ -405,7 +405,7 @@ test12()
 		return 1
 	fi
 
-	./cpuset_memory_test --mmap-anon >"$MEMORY_RESULT" &
+	cpuset_memory_test --mmap-anon >"$MEMORY_RESULT" &
 	talk2memory_test_for_case_12_13 $! "$CPUSET/0"
 
 	{
@@ -441,7 +441,7 @@ test13()
 	fi
 
 
-	./cpuset_memory_test --mmap-anon --check >"$MEMORY_RESULT" &
+	cpuset_memory_test --mmap-anon --check >"$MEMORY_RESULT" &
 	talk2memory_test_for_case_12_13 $! "$CPUSET/0"
 
 	{
@@ -496,7 +496,7 @@ test14()
 		return 1
 	fi
 
-	./cpuset_memory_test --thread --mmap-anon >"$MEMORY_RESULT" &
+	cpuset_memory_test --thread --mmap-anon >"$MEMORY_RESULT" &
 	{
 		local testpid=$!
 		sleep 1
@@ -552,7 +552,7 @@ test15()
 	fi
 
 
-	./cpuset_memory_test --thread --mmap-anon >"$MEMORY_RESULT" &
+	cpuset_memory_test --thread --mmap-anon >"$MEMORY_RESULT" &
 	{
 		local testpid=$!
 		sleep 1
@@ -608,7 +608,7 @@ test16()
 	fi
 
 
-	./cpuset_memory_test --thread --mmap-anon >"$MEMORY_RESULT" &
+	cpuset_memory_test --thread --mmap-anon >"$MEMORY_RESULT" &
 	{
 		local testpid=$!
 		sleep 1
@@ -674,7 +674,7 @@ test17()
 		return 1
 	fi
 
-	./cpuset_memory_test --thread --mmap-anon >"$MEMORY_RESULT" &
+	cpuset_memory_test --thread --mmap-anon >"$MEMORY_RESULT" &
 	{
 		local testpid=$!
 		sleep 1
@@ -756,7 +756,7 @@ test18()
 		return 1
 	fi
 
-	./cpuset_memory_test --thread --mmap-anon >"$MEMORY_RESULT" &
+	cpuset_memory_test --thread --mmap-anon >"$MEMORY_RESULT" &
 	{
 		local testpid=$!
 		sleep 1
diff --git a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
index b6ac7a7..95196b7 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
@@ -37,10 +37,10 @@ TEST_OUTPUT="$CPUSET_TMP/result"
 TEST_PROCSTATUS="$CPUSET_TMP/status"
 TEST_PROCNUMA="$CPUSET_TMP/numa_maps"
 
-# do_syscall_test - call ./syscall_test
+# do_syscall_test - call syscall_test
 # $1 - cpus
 # $2 - mems
-# $3 - ./syscall_test's args
+# $3 - syscall_test's args
 # $4 - expect return value of test task
 
 do_syscall_test()
@@ -63,7 +63,7 @@ do_syscall_test()
 		tst_resm TFAIL "set $TEST_CPUSET/mems as $2 fail."
 		return 1
 	fi
-	./cpuset_syscall_test $3 >"$TEST_OUTPUT" &
+	cpuset_syscall_test $3 >"$TEST_OUTPUT" &
 	testpid=$!
 	echo $testpid > "$TEST_CPUSET/tasks"
 	if [ $? -ne 0 ]; then
-- 
1.7.1


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134791&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
