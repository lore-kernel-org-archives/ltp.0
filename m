From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Sep 2017 17:50:21 +0200
Subject: [LTP] [PATCH v2] controllers/cpuset:check for cpuset mount status
	and prefix
Message-ID: <20170927155021.7598-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Shuang Qiu <shuang.qiu@oracle.com>

* Update to handle the env that cpuset subsystem is already mounted

* Similar with commit 6ce94db5bbff0be40813f3fdfe61a55b3186c49a,need to check for cpuset prefix

[ I've updated the patch so that it applies cleany and did a few minor fixes. It
  fixes the main problem for me i.e. permission errors. Some of the tests fail
  though. But still these tests works better with the patch. ]

Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../cpuset_base_ops_testset.sh                     |  28 +-
 .../cpuset_exclusive_test/cpuset_exclusive_test.sh | 168 ++++-----
 .../kernel/controllers/cpuset/cpuset_funcs.sh      |  37 +-
 .../cpuset_hierarchy_test/cpuset_hierarchy_test.sh | 416 ++++++++++-----------
 .../cpuset_hotplug_test/cpuset_hotplug_test.sh     |   4 +-
 .../cpuset_inherit_test/cpuset_inherit_testset.sh  |  12 +-
 .../cpuset_memory_pressure_testset.sh              |  32 +-
 .../cpuset_memory_spread_testset.sh                |   2 +-
 .../cpuset_memory_test/cpuset_memory_testset.sh    |  22 +-
 .../cpuset_syscall_test/cpuset_syscall_testset.sh  |   8 +-
 10 files changed, 368 insertions(+), 361 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
index 70e7203f6..a6e7f9a03 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
@@ -105,7 +105,7 @@ test_cpus()
 	cfile_name="cpus"
 	while read cpus result
 	do
-		base_op_test "$CPUSET/1/cpus" "$cpus" "$result"
+		base_op_test "$CPUSET/1/${PREFIX}cpus" "$cpus" "$result"
 	done <<- EOF
 		NULL					EMPTY
 		0					0
@@ -124,14 +124,14 @@ test_cpus()
 	# while read cpus result
 
 	if [ $nr_cpus -ge 3 ]; then
-		base_op_test "$CPUSET/1/cpus" "0,1-$((nr_cpus-2)),$((nr_cpus-1))" "0-$((nr_cpus-1))"
-		base_op_test "$CPUSET/1/cpus" "0,1-$((nr_cpus-2))," "0-$((nr_cpus-2))"
+		base_op_test "$CPUSET/1/${PREFIX}cpus" "0,1-$((nr_cpus-2)),$((nr_cpus-1))" "0-$((nr_cpus-1))"
+		base_op_test "$CPUSET/1/${PREFIX}cpus" "0,1-$((nr_cpus-2))," "0-$((nr_cpus-2))"
 	fi
 
 	if tst_kvcmp -lt "3.0 RHEL6:2.6.32"; then
-		base_op_test "$CPUSET/1/cpus" "0-" "WRITE_ERROR"
+		base_op_test "$CPUSET/1/${PREFIX}cpus" "0-" "WRITE_ERROR"
 	else
-		base_op_test "$CPUSET/1/cpus" "0-" "0"
+		base_op_test "$CPUSET/1/${PREFIX}cpus" "0-" "0"
 	fi
 }
 
@@ -140,7 +140,7 @@ test_mems()
 	cfile_name="mems"
 	while read mems result
 	do
-		base_op_test "$CPUSET/1/mems" "$mems" "$result"
+		base_op_test "$CPUSET/1/${PREFIX}mems" "$mems" "$result"
 	done <<- EOF
 		NULL					EMPTY
 		0					0
@@ -159,14 +159,14 @@ test_mems()
 	# while read mems result
 
 	if [ $nr_mems -ge 3 ]; then
-		base_op_test "$CPUSET/1/mems" "0,1-$((nr_mems-2)),$((nr_mems-1))" "0-$((nr_mems-1))"
-		base_op_test "$CPUSET/1/mems" "0,1-$((nr_mems-2))," "0-$((nr_mems-2))"
+		base_op_test "$CPUSET/1/${PREFIX}mems" "0,1-$((nr_mems-2)),$((nr_mems-1))" "0-$((nr_mems-1))"
+		base_op_test "$CPUSET/1/${PREFIX}mems" "0,1-$((nr_mems-2))," "0-$((nr_mems-2))"
 	fi
 
 	if tst_kvcmp -lt "3.0 RHEL6:2.6.32"; then
-		base_op_test "$CPUSET/1/mems" "0-" "WRITE_ERROR"
+		base_op_test "$CPUSET/1/${PREFIX}mems" "0-" "WRITE_ERROR"
 	else
-		base_op_test "$CPUSET/1/mems" "0-" "0"
+		base_op_test "$CPUSET/1/${PREFIX}mems" "0-" "0"
 	fi
 }
 
@@ -179,7 +179,7 @@ test_flags()
 		cfile_name="$filename"
 		while read flags result
 		do
-			base_op_test "$CPUSET/$filename" "$flags" "$result"
+			base_op_test "$CPUSET/${PREFIX}$filename" "$flags" "$result"
 		done <<- EOF
 			0	0
 			1	1
@@ -219,10 +219,10 @@ attach_task_test()
 	fi
 
 	if [ "$cpus" != "NULL" ]; then
-		echo $cpus > "$CPUSET/sub_cpuset/cpus"
+		echo $cpus > "$CPUSET/sub_cpuset/${PREFIX}cpus"
 	fi
 	if [ "$mems" != "NULL" ]; then
-		echo $mems > "$CPUSET/sub_cpuset/mems"
+		echo $mems > "$CPUSET/sub_cpuset/${PREFIX}mems"
 	fi
 
 	cat /dev/zero > /dev/null &
@@ -265,7 +265,7 @@ test_readonly_cfiles()
 	for filename in cpus mems memory_pressure
 	do
 		cfile_name="$filename(READONLY)"
-		base_op_test "$CPUSET/$filename" "0" "WRITE_ERROR"
+		base_op_test "$CPUSET/${PREFIX}$filename" "0" "WRITE_ERROR"
 	done # for filename in readonly cfiles
 }
 
diff --git a/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/cpuset_exclusive_test.sh b/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/cpuset_exclusive_test.sh
index 2188ab6ae..17e1791fa 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/cpuset_exclusive_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/cpuset_exclusive_test.sh
@@ -35,186 +35,186 @@ exit_status=0
 # Case 1-9 test cpus
 test1()
 {
-	echo 0 > "$CPUSET/father/cpu_exclusive" || return 1
-	echo 0 > "$CPUSET/father/child/cpu_exclusive" || return 1
+	echo 0 > "$CPUSET/father/${PREFIX}cpu_exclusive" || return 1
+	echo 0 > "$CPUSET/father/child/${PREFIX}cpu_exclusive" || return 1
 
-	test 0 = $(cat "$CPUSET/father/child/cpu_exclusive") || return 1
+	test 0 = $(cat "$CPUSET/father/child/${PREFIX}cpu_exclusive") || return 1
 }
 
 test2()
 {
-	echo 1 > "$CPUSET/father/cpu_exclusive" || return 1
-	echo 0 > "$CPUSET/father/child/cpu_exclusive" || return 1
+	echo 1 > "$CPUSET/father/${PREFIX}cpu_exclusive" || return 1
+	echo 0 > "$CPUSET/father/child/${PREFIX}cpu_exclusive" || return 1
 
-	test 0 = $(cat "$CPUSET/father/child/cpu_exclusive") || return 1
+	test 0 = $(cat "$CPUSET/father/child/${PREFIX}cpu_exclusive") || return 1
 }
 
 test3()
 {
-	echo 1 > "$CPUSET/father/cpu_exclusive" || return 1
-	echo 1 > "$CPUSET/father/child/cpu_exclusive" || return 1
+	echo 1 > "$CPUSET/father/${PREFIX}cpu_exclusive" || return 1
+	echo 1 > "$CPUSET/father/child/${PREFIX}cpu_exclusive" || return 1
 
-	test 1 = $(cat "$CPUSET/father/child/cpu_exclusive") || return 1
+	test 1 = $(cat "$CPUSET/father/child/${PREFIX}cpu_exclusive") || return 1
 }
 
 test4()
 {
-	echo 0 > "$CPUSET/father/cpu_exclusive" || return 1
-	echo 1 > "$CPUSET/father/child/cpu_exclusive" 2> /dev/null && return 1
+	echo 0 > "$CPUSET/father/${PREFIX}cpu_exclusive" || return 1
+	echo 1 > "$CPUSET/father/child/${PREFIX}cpu_exclusive" 2> /dev/null && return 1
 
-	test 0 = $(cat "$CPUSET/father/child/cpu_exclusive") || return 1
+	test 0 = $(cat "$CPUSET/father/child/${PREFIX}cpu_exclusive") || return 1
 }
 
 test5()
 {
-	echo 1 > "$CPUSET/father/cpu_exclusive" || return 1
-	echo 1 > "$CPUSET/father/child/cpu_exclusive" || return 1
-	echo 0 > "$CPUSET/father/cpu_exclusive" 2> /dev/null && return 1
+	echo 1 > "$CPUSET/father/${PREFIX}cpu_exclusive" || return 1
+	echo 1 > "$CPUSET/father/child/${PREFIX}cpu_exclusive" || return 1
+	echo 0 > "$CPUSET/father/${PREFIX}cpu_exclusive" 2> /dev/null && return 1
 
-	test 1 = $(cat "$CPUSET/father/cpu_exclusive") || return 1
+	test 1 = $(cat "$CPUSET/father/${PREFIX}cpu_exclusive") || return 1
 }
 
 test6()
 {
-	echo 1 > "$CPUSET/father/cpu_exclusive" || return 1
-	echo 1 > "$CPUSET/father/child/cpu_exclusive" || return 1
-	echo "0-1" > "$CPUSET/father/cpus" || return 1
-	echo 0 > "$CPUSET/father/child/cpus" || return 1
+	echo 1 > "$CPUSET/father/${PREFIX}cpu_exclusive" || return 1
+	echo 1 > "$CPUSET/father/child/${PREFIX}cpu_exclusive" || return 1
+	echo "0-1" > "$CPUSET/father/${PREFIX}cpus" || return 1
+	echo 0 > "$CPUSET/father/child/${PREFIX}cpus" || return 1
 	mkdir "$CPUSET/father/other" || return 1
-	echo 1 > "$CPUSET/father/other/cpus" || return 1
+	echo 1 > "$CPUSET/father/other/${PREFIX}cpus" || return 1
 
-	test 0 = $(cat "$CPUSET/father/child/cpus") || return 1
-	test 1 = $(cat "$CPUSET/father/other/cpus") || return 1
+	test 0 = $(cat "$CPUSET/father/child/${PREFIX}cpus") || return 1
+	test 1 = $(cat "$CPUSET/father/other/${PREFIX}cpus") || return 1
 }
 
 test7()
 {
-	echo 1 > "$CPUSET/father/cpu_exclusive" || return 1
-	echo 1 > "$CPUSET/father/child/cpu_exclusive" || return 1
-	echo "0-1" > "$CPUSET/father/cpus" || return 1
-	echo 0 > "$CPUSET/father/child/cpus" || return 1
+	echo 1 > "$CPUSET/father/${PREFIX}cpu_exclusive" || return 1
+	echo 1 > "$CPUSET/father/child/${PREFIX}cpu_exclusive" || return 1
+	echo "0-1" > "$CPUSET/father/${PREFIX}cpus" || return 1
+	echo 0 > "$CPUSET/father/child/${PREFIX}cpus" || return 1
 	mkdir "$CPUSET/father/other" || return 1
-	echo "0-1" > "$CPUSET/father/other/cpus" 2> /dev/null && return 1
+	echo "0-1" > "$CPUSET/father/other/${PREFIX}cpus" 2> /dev/null && return 1
 
-	test 0 = $(cat "$CPUSET/father/child/cpus") || return 1
-	test -z $(cat "$CPUSET/father/other/cpus") || return 1
+	test 0 = $(cat "$CPUSET/father/child/${PREFIX}cpus") || return 1
+	test -z $(cat "$CPUSET/father/other/${PREFIX}cpus") || return 1
 }
 
 test8()
 {
-	echo 1 > "$CPUSET/father/cpu_exclusive" || return 1
-	echo "0-1" > "$CPUSET/father/cpus" || return 1
-	echo 0 > "$CPUSET/father/child/cpus" || return 1
+	echo 1 > "$CPUSET/father/${PREFIX}cpu_exclusive" || return 1
+	echo "0-1" > "$CPUSET/father/${PREFIX}cpus" || return 1
+	echo 0 > "$CPUSET/father/child/${PREFIX}cpus" || return 1
 	mkdir "$CPUSET/father/other" || return 1
-	echo 1 > "$CPUSET/father/other/cpus" || return 1
-	echo 1 > "$CPUSET/father/child/cpu_exclusive" || return 1
+	echo 1 > "$CPUSET/father/other/${PREFIX}cpus" || return 1
+	echo 1 > "$CPUSET/father/child/${PREFIX}cpu_exclusive" || return 1
 
-	test 1 = $(cat "$CPUSET/father/child/cpu_exclusive") || return 1
+	test 1 = $(cat "$CPUSET/father/child/${PREFIX}cpu_exclusive") || return 1
 }
 
 test9()
 {
-	echo 1 > "$CPUSET/father/cpu_exclusive" || return 1
-	echo "0-1" > "$CPUSET/father/cpus" || return 1
-	echo 0 > "$CPUSET/father/child/cpus" || return 1
+	echo 1 > "$CPUSET/father/${PREFIX}cpu_exclusive" || return 1
+	echo "0-1" > "$CPUSET/father/${PREFIX}cpus" || return 1
+	echo 0 > "$CPUSET/father/child/${PREFIX}cpus" || return 1
 	mkdir "$CPUSET/father/other" || return 1
-	echo "0-1" > "$CPUSET/father/other/cpus" || return 1
-	echo 1 > "$CPUSET/father/child/cpu_exclusive" 2> /dev/null && return 1
+	echo "0-1" > "$CPUSET/father/other/${PREFIX}cpus" || return 1
+	echo 1 > "$CPUSET/father/child/${PREFIX}cpu_exclusive" 2> /dev/null && return 1
 
-	test 0 = $(cat "$CPUSET/father/child/cpu_exclusive") || return 1
+	test 0 = $(cat "$CPUSET/father/child/${PREFIX}cpu_exclusive") || return 1
 }
 
 # The following cases test mems
 
 test10()
 {
-	echo 0 > "$CPUSET/father/mem_exclusive" || return 1
-	echo 0 > "$CPUSET/father/child/mem_exclusive" || return 1
+	echo 0 > "$CPUSET/father/${PREFIX}mem_exclusive" || return 1
+	echo 0 > "$CPUSET/father/child/${PREFIX}mem_exclusive" || return 1
 
-	test 0 = $(cat "$CPUSET/father/child/mem_exclusive") || return 1
+	test 0 = $(cat "$CPUSET/father/child/${PREFIX}mem_exclusive") || return 1
 }
 
 test11()
 {
-	echo 1 > "$CPUSET/father/mem_exclusive" || return 1
-	echo 0 > "$CPUSET/father/child/mem_exclusive" || return 1
+	echo 1 > "$CPUSET/father/${PREFIX}mem_exclusive" || return 1
+	echo 0 > "$CPUSET/father/child/${PREFIX}mem_exclusive" || return 1
 
-	test 0 = $(cat "$CPUSET/father/child/mem_exclusive") || return 1
+	test 0 = $(cat "$CPUSET/father/child/${PREFIX}mem_exclusive") || return 1
 }
 
 test12()
 {
-	echo 1 > "$CPUSET/father/mem_exclusive" || return 1
-	echo 1 > "$CPUSET/father/child/mem_exclusive" || return 1
+	echo 1 > "$CPUSET/father/${PREFIX}mem_exclusive" || return 1
+	echo 1 > "$CPUSET/father/child/${PREFIX}mem_exclusive" || return 1
 
-	test 1 = $(cat "$CPUSET/father/child/mem_exclusive") || return 1
+	test 1 = $(cat "$CPUSET/father/child/${PREFIX}mem_exclusive") || return 1
 }
 
 test13()
 {
-	echo 0 > "$CPUSET/father/mem_exclusive" || return 1
-	echo 1 > "$CPUSET/father/child/mem_exclusive" 2> /dev/null && return 1
+	echo 0 > "$CPUSET/father/${PREFIX}mem_exclusive" || return 1
+	echo 1 > "$CPUSET/father/child/${PREFIX}mem_exclusive" 2> /dev/null && return 1
 
-	test 0 = $(cat "$CPUSET/father/child/mem_exclusive") || return 1
+	test 0 = $(cat "$CPUSET/father/child/${PREFIX}mem_exclusive") || return 1
 }
 
 test14()
 {
-	echo 1 > "$CPUSET/father/mem_exclusive" || return 1
-	echo 1 > "$CPUSET/father/child/mem_exclusive" || return 1
-	echo 0 > "$CPUSET/father/mem_exclusive" 2> /dev/null && return 1
+	echo 1 > "$CPUSET/father/${PREFIX}mem_exclusive" || return 1
+	echo 1 > "$CPUSET/father/child/${PREFIX}mem_exclusive" || return 1
+	echo 0 > "$CPUSET/father/${PREFIX}mem_exclusive" 2> /dev/null && return 1
 
-	test 1 = $(cat "$CPUSET/father/mem_exclusive") || return 1
+	test 1 = $(cat "$CPUSET/father/${PREFIX}mem_exclusive") || return 1
 }
 
 test15()
 {
-	echo 1 > "$CPUSET/father/mem_exclusive" || return 1
-	echo 1 > "$CPUSET/father/child/mem_exclusive" || return 1
-	echo "0-1" > "$CPUSET/father/mems" || return 1
-	echo 0 > "$CPUSET/father/child/mems" || return 1
+	echo 1 > "$CPUSET/father/${PREFIX}mem_exclusive" || return 1
+	echo 1 > "$CPUSET/father/child/${PREFIX}mem_exclusive" || return 1
+	echo "0-1" > "$CPUSET/father/${PREFIX}mems" || return 1
+	echo 0 > "$CPUSET/father/child/${PREFIX}mems" || return 1
 	mkdir "$CPUSET/father/other" || return 1
-	echo 1 > "$CPUSET/father/other/mems" || return 1
+	echo 1 > "$CPUSET/father/other/${PREFIX}mems" || return 1
 
-	test 0 = $(cat "$CPUSET/father/child/mems") || return 1
-	test 1 = $(cat "$CPUSET/father/other/mems") || return 1
+	test 0 = $(cat "$CPUSET/father/child/${PREFIX}mems") || return 1
+	test 1 = $(cat "$CPUSET/father/other/${PREFIX}mems") || return 1
 }
 
 test16()
 {
-	echo 1 > "$CPUSET/father/mem_exclusive" || return 1
-	echo 1 > "$CPUSET/father/child/mem_exclusive" || return 1
-	echo "0-1" > "$CPUSET/father/mems" || return 1
-	echo 0 > "$CPUSET/father/child/mems" || return 1
+	echo 1 > "$CPUSET/father/${PREFIX}mem_exclusive" || return 1
+	echo 1 > "$CPUSET/father/child/${PREFIX}mem_exclusive" || return 1
+	echo "0-1" > "$CPUSET/father/${PREFIX}mems" || return 1
+	echo 0 > "$CPUSET/father/child/${PREFIX}mems" || return 1
 	mkdir "$CPUSET/father/other" || return 1
-	echo "0-1" > "$CPUSET/father/other/mems" 2> /dev/null && return 1
+	echo "0-1" > "$CPUSET/father/other/${PREFIX}mems" 2> /dev/null && return 1
 
-	test 0 = $(cat "$CPUSET/father/child/mems") || return 1
-	test -z $(cat "$CPUSET/father/other/mems") || return 1
+	test 0 = $(cat "$CPUSET/father/child/${PREFIX}mems") || return 1
+	test -z $(cat "$CPUSET/father/other/${PREFIX}mems") || return 1
 }
 
 test17()
 {
-	echo 1 > "$CPUSET/father/mem_exclusive" || return 1
-	echo "0-1" > "$CPUSET/father/mems" || return 1
-	echo 0 > "$CPUSET/father/child/mems" || return 1
+	echo 1 > "$CPUSET/father/${PREFIX}mem_exclusive" || return 1
+	echo "0-1" > "$CPUSET/father/${PREFIX}mems" || return 1
+	echo 0 > "$CPUSET/father/child/${PREFIX}mems" || return 1
 	mkdir "$CPUSET/father/other" || return 1
-	echo 1 > "$CPUSET/father/other/mems" || return 1
-	echo 1 > "$CPUSET/father/child/mem_exclusive" || return 1
+	echo 1 > "$CPUSET/father/other/${PREFIX}mems" || return 1
+	echo 1 > "$CPUSET/father/child/${PREFIX}mem_exclusive" || return 1
 
-	test 1 = $(cat "$CPUSET/father/child/mem_exclusive") || return 1
+	test 1 = $(cat "$CPUSET/father/child/${PREFIX}mem_exclusive") || return 1
 }
 
 test18()
 {
-	echo 1 > "$CPUSET/father/mem_exclusive" || return 1
-	echo "0-1" > "$CPUSET/father/mems" || return 1
-	echo 0 > "$CPUSET/father/child/mems" || return 1
+	echo 1 > "$CPUSET/father/${PREFIX}mem_exclusive" || return 1
+	echo "0-1" > "$CPUSET/father/${PREFIX}mems" || return 1
+	echo 0 > "$CPUSET/father/child/${PREFIX}mems" || return 1
 	mkdir "$CPUSET/father/other" || return 1
-	echo "0-1" > "$CPUSET/father/other/mems" || return 1
-	echo 1 > "$CPUSET/father/child/mem_exclusive" 2> /dev/null && return 1
+	echo "0-1" > "$CPUSET/father/other/${PREFIX}mems" || return 1
+	echo 1 > "$CPUSET/father/child/${PREFIX}mem_exclusive" 2> /dev/null && return 1
 
-	test 0 = $(cat "$CPUSET/father/child/mem_exclusive") || return 1
+	test 0 = $(cat "$CPUSET/father/child/${PREFIX}mem_exclusive") || return 1
 }
 
 for i in $(seq 1 $TST_TOTAL)
diff --git a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
index 2be13294f..c7430e074 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
@@ -35,7 +35,8 @@ fi
 N_NODES=${N_NODES#*-*}
 N_NODES=$(($N_NODES + 1))
 
-CPUSET="/dev/cpuset"
+CPUSET=$(awk '/cpuset/ {print $2}' /proc/mounts)
+[ -z "$CPUSET" ] || CPUSET="/dev/cpuset"
 CPUSET_TMP="/tmp/cpuset_tmp"
 
 HOTPLUG_CPU="1"
@@ -120,20 +121,25 @@ check()
 # clean any group created eralier (if any)
 setup()
 {
-	if [ -e "$CPUSET" ]
-	then
-		tst_resm TWARN "$CPUSET already exist.. overwriting"
-		cleanup || tst_brkm TFAIL "Can't cleanup... Exiting"
-	fi
+	mounted=0
+	if [ "$CPUSET" = "/dev/cpuset" ]; then
+		if [ -e "$CPUSET" ];then
+			tst_resm TWARN "$CPUSET already exist.. overwriting"
+			cleanup || tst_brkm TFAIL "Can't cleanup... Exiting"
+		fi
 
-	mkdir -p "$CPUSET_TMP"
-	mkdir "$CPUSET"
-	mount -t cpuset cpuset "$CPUSET" 2> /dev/null
-	if [ $? -ne 0 ]; then
-		cleanup
-		tst_brkm TFAIL "Could not mount cgroup filesystem with"\
+		mkdir -p "$CPUSET_TMP"
+		mkdir "$CPUSET"
+		mount -t cpuset cpuset "$CPUSET" 2> /dev/null
+		if [ $? -ne 0 ]; then
+			cleanup
+			tst_brkm TFAIL "Could not mount cgroup filesystem with"\
 					" cpuset on $CPUSET..Exiting test"
+		else
+			mounted=1
+		fi
 	fi
+	[ -e "$CPUSET/cpuset.cpus" ] && PREFIX="cpuset."
 }
 
 # Write the cleanup function
@@ -161,6 +167,7 @@ cleanup()
 		fi
 	done
 
+	[ "$mounted" -ne 1 ] && return
 	umount "$CPUSET"
 	if [ $? -ne 0 ]; then
 		tst_brkm TFAIL "Couldn't umount cgroup filesystem with"\
@@ -186,19 +193,19 @@ cpuset_set()
 
 	if [ "$path" != "$CPUSET" ]; then
 		if [ "$cpus" != "-" ]; then
-			/bin/echo $cpus > $path/cpus
+			/bin/echo $cpus > $path/${PREFIX}cpus
 			if [ $? -ne 0 ]; then
 				return 1
 			fi
 		fi
 
-		/bin/echo $mems > $path/mems
+		/bin/echo $mems > $path/${PREFIX}mems
 		if [ $? -ne 0 ]; then
 			return 1
 		fi
 	fi
 
-	/bin/echo $load_balance > $path/sched_load_balance
+	/bin/echo $load_balance > $path/${PREFIX}sched_load_balance
 	if [ $? -ne 0 ]; then
 		return 1
 	fi
diff --git a/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/cpuset_hierarchy_test.sh b/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/cpuset_hierarchy_test.sh
index 61f58fc1d..5cee5709e 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/cpuset_hierarchy_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/cpuset_hierarchy_test.sh
@@ -42,404 +42,404 @@ exit_status=0
 
 test1()
 {
-	echo > "$CPUSET/father/cpus" || return 1
-	echo > "$CPUSET/father/child/cpus" || return 1
+	echo > "$CPUSET/father/${PREFIX}cpus" || return 1
+	echo > "$CPUSET/father/child/${PREFIX}cpus" || return 1
 
-	cpuset_log "father cpus $(cat "$CPUSET/father/cpus")"
-	cpuset_log "child cpus $(cat "$CPUSET/father/child/cpus")"
+	cpuset_log "father cpus $(cat "$CPUSET/father/${PREFIX}cpus")"
+	cpuset_log "child cpus $(cat "$CPUSET/father/child/${PREFIX}cpus")"
 
-	test -z "$(cat "$CPUSET/father/cpus")" || return 1
-	test -z "$(cat "$CPUSET/father/child/cpus")" || return 1
+	test -z "$(cat "$CPUSET/father/${PREFIX}cpus")" || return 1
+	test -z "$(cat "$CPUSET/father/child/${PREFIX}cpus")" || return 1
 }
 
 test2()
 {
-	echo > "$CPUSET/father/cpus" || return 1
-	echo 0 > "$CPUSET/father/child/cpus" 2> /dev/null && return 1
+	echo > "$CPUSET/father/${PREFIX}cpus" || return 1
+	echo 0 > "$CPUSET/father/child/${PREFIX}cpus" 2> /dev/null && return 1
 
-	cpuset_log "father cpus $(cat "$CPUSET/father/cpus")"
-	cpuset_log "child cpus $(cat "$CPUSET/father/child/cpus")"
+	cpuset_log "father cpus $(cat "$CPUSET/father/${PREFIX}cpus")"
+	cpuset_log "child cpus $(cat "$CPUSET/father/child/${PREFIX}cpus")"
 
-	test -z "$(cat "$CPUSET/father/cpus")" || return 1
-	test -z "$(cat "$CPUSET/father/child/cpus")" || return 1
+	test -z "$(cat "$CPUSET/father/${PREFIX}cpus")" || return 1
+	test -z "$(cat "$CPUSET/father/child/${PREFIX}cpus")" || return 1
 }
 
 test3()
 {
-	echo 0 > "$CPUSET/father/cpus" || return 1
-	echo > "$CPUSET/father/child/cpus" || return 1
+	echo 0 > "$CPUSET/father/${PREFIX}cpus" || return 1
+	echo > "$CPUSET/father/child/${PREFIX}cpus" || return 1
 
-	cpuset_log "father cpus $(cat "$CPUSET/father/cpus")"
-	cpuset_log "child cpus $(cat "$CPUSET/father/child/cpus")"
+	cpuset_log "father cpus $(cat "$CPUSET/father/${PREFIX}cpus")"
+	cpuset_log "child cpus $(cat "$CPUSET/father/child/${PREFIX}cpus")"
 
-	test 0 = "$(cat "$CPUSET/father/cpus")" || return 1
-	test -z "$(cat "$CPUSET/father/child/cpus")" || return 1
+	test 0 = "$(cat "$CPUSET/father/${PREFIX}cpus")" || return 1
+	test -z "$(cat "$CPUSET/father/child/${PREFIX}cpus")" || return 1
 }
 
 test4()
 {
-	echo 0 > "$CPUSET/father/cpus" || return 1
-	echo 0 > "$CPUSET/father/child/cpus" || return 1
+	echo 0 > "$CPUSET/father/${PREFIX}cpus" || return 1
+	echo 0 > "$CPUSET/father/child/${PREFIX}cpus" || return 1
 
-	cpuset_log "father cpus $(cat "$CPUSET/father/cpus")"
-	cpuset_log "child cpus $(cat "$CPUSET/father/child/cpus")"
+	cpuset_log "father cpus $(cat "$CPUSET/father/${PREFIX}cpus")"
+	cpuset_log "child cpus $(cat "$CPUSET/father/child/${PREFIX}cpus")"
 
-	test 0 = "$(cat "$CPUSET/father/cpus")" || return 1
-	test 0 = "$(cat "$CPUSET/father/child/cpus")" || return 1
+	test 0 = "$(cat "$CPUSET/father/${PREFIX}cpus")" || return 1
+	test 0 = "$(cat "$CPUSET/father/child/${PREFIX}cpus")" || return 1
 }
 
 test5()
 {
-	echo 0 > "$CPUSET/father/cpus" || return 1
-	echo 1 > "$CPUSET/father/child/cpus" 2> /dev/null && return 1
+	echo 0 > "$CPUSET/father/${PREFIX}cpus" || return 1
+	echo 1 > "$CPUSET/father/child/${PREFIX}cpus" 2> /dev/null && return 1
 
-	cpuset_log "father cpus $(cat "$CPUSET/father/cpus")"
-	cpuset_log "child cpus $(cat "$CPUSET/father/child/cpus")"
+	cpuset_log "father cpus $(cat "$CPUSET/father/${PREFIX}cpus")"
+	cpuset_log "child cpus $(cat "$CPUSET/father/child/${PREFIX}cpus")"
 
-	test 0 = "$(cat "$CPUSET/father/cpus")" || return 1
-	test -z "$(cat "$CPUSET/father/child/cpus")" || return 1
+	test 0 = "$(cat "$CPUSET/father/${PREFIX}cpus")" || return 1
+	test -z "$(cat "$CPUSET/father/child/${PREFIX}cpus")" || return 1
 }
 
 test6()
 {
-	echo 0 > "$CPUSET/father/cpus" || return 1
-	echo 0,1 > "$CPUSET/father/child/cpus" 2> /dev/null && return 1
+	echo 0 > "$CPUSET/father/${PREFIX}cpus" || return 1
+	echo 0,1 > "$CPUSET/father/child/${PREFIX}cpus" 2> /dev/null && return 1
 
-	cpuset_log "father cpus $(cat "$CPUSET/father/cpus")"
-	cpuset_log "child cpus $(cat "$CPUSET/father/child/cpus")"
+	cpuset_log "father cpus $(cat "$CPUSET/father/${PREFIX}cpus")"
+	cpuset_log "child cpus $(cat "$CPUSET/father/child/${PREFIX}cpus")"
 
-	test 0 = "$(cat "$CPUSET/father/cpus")" || return 1
-	test -z "$(cat "$CPUSET/father/child/cpus")" || return 1
+	test 0 = "$(cat "$CPUSET/father/${PREFIX}cpus")" || return 1
+	test -z "$(cat "$CPUSET/father/child/${PREFIX}cpus")" || return 1
 }
 
 test7()
 {
-	echo "0,1" > "$CPUSET/father/cpus" || return 1
-	echo 0 > "$CPUSET/father/child/cpus" || return 1
+	echo "0,1" > "$CPUSET/father/${PREFIX}cpus" || return 1
+	echo 0 > "$CPUSET/father/child/${PREFIX}cpus" || return 1
 
-	cpuset_log "father cpus $(cat "$CPUSET/father/cpus")"
-	cpuset_log "child cpus $(cat "$CPUSET/father/child/cpus")"
+	cpuset_log "father cpus $(cat "$CPUSET/father/${PREFIX}cpus")"
+	cpuset_log "child cpus $(cat "$CPUSET/father/child/${PREFIX}cpus")"
 
-	test "0-1" = "$(cat "$CPUSET/father/cpus")" || return 1
-	test 0 = "$(cat "$CPUSET/father/child/cpus")" || return 1
+	test "0-1" = "$(cat "$CPUSET/father/${PREFIX}cpus")" || return 1
+	test 0 = "$(cat "$CPUSET/father/child/${PREFIX}cpus")" || return 1
 }
 
 test8()
 {
-	echo "0,1" > "$CPUSET/father/cpus" || return 1
-	echo 0 > "$CPUSET/father/child/cpus" || return 1
+	echo "0,1" > "$CPUSET/father/${PREFIX}cpus" || return 1
+	echo 0 > "$CPUSET/father/child/${PREFIX}cpus" || return 1
 
-	cpuset_log "father cpus $(cat "$CPUSET/father/cpus")"
-	cpuset_log "child cpus $(cat "$CPUSET/father/child/cpus")"
+	cpuset_log "father cpus $(cat "$CPUSET/father/${PREFIX}cpus")"
+	cpuset_log "child cpus $(cat "$CPUSET/father/child/${PREFIX}cpus")"
 
-	test "0-1" = "$(cat "$CPUSET/father/cpus")" || return 1
-	test 0 = "$(cat "$CPUSET/father/child/cpus")" || return 1
+	test "0-1" = "$(cat "$CPUSET/father/${PREFIX}cpus")" || return 1
+	test 0 = "$(cat "$CPUSET/father/child/${PREFIX}cpus")" || return 1
 }
 
 test9()
 {
-	echo "$cpus_all" > "$CPUSET/father/cpus" || return 1
-	echo > "$CPUSET/father/child/cpus" || return 1
-	echo > "$CPUSET/father/cpus" || return 1
+	echo "$cpus_all" > "$CPUSET/father/${PREFIX}cpus" || return 1
+	echo > "$CPUSET/father/child/${PREFIX}cpus" || return 1
+	echo > "$CPUSET/father/${PREFIX}cpus" || return 1
 
-	cpuset_log "father cpus $(cat "$CPUSET/father/cpus")"
-	cpuset_log "child cpus $(cat "$CPUSET/father/child/cpus")"
+	cpuset_log "father cpus $(cat "$CPUSET/father/${PREFIX}cpus")"
+	cpuset_log "child cpus $(cat "$CPUSET/father/child/${PREFIX}cpus")"
 
-	test -z "$(cat "$CPUSET/father/cpus")" || return 1
-	test -z "$(cat "$CPUSET/father/child/cpus")" || return 1
+	test -z "$(cat "$CPUSET/father/${PREFIX}cpus")" || return 1
+	test -z "$(cat "$CPUSET/father/child/${PREFIX}cpus")" || return 1
 }
 
 test10()
 {
-	echo "$cpus_all" > "$CPUSET/father/cpus" || return 1
-	echo 0 > "$CPUSET/father/child/cpus" || return 1
-	echo > "$CPUSET/father/cpus" 2> /dev/null && return 1
+	echo "$cpus_all" > "$CPUSET/father/${PREFIX}cpus" || return 1
+	echo 0 > "$CPUSET/father/child/${PREFIX}cpus" || return 1
+	echo > "$CPUSET/father/${PREFIX}cpus" 2> /dev/null && return 1
 
-	cpuset_log "father cpus $(cat "$CPUSET/father/cpus")"
-	cpuset_log "child cpus $(cat "$CPUSET/father/child/cpus")"
+	cpuset_log "father cpus $(cat "$CPUSET/father/${PREFIX}cpus")"
+	cpuset_log "child cpus $(cat "$CPUSET/father/child/${PREFIX}cpus")"
 
-	test "0-$((nr_cpus-1))" = "$(cat "$CPUSET/father/cpus")" || return 1
-	test 0 = "$(cat "$CPUSET/father/child/cpus")" || return 1
+	test "0-$((nr_cpus-1))" = "$(cat "$CPUSET/father/${PREFIX}cpus")" || return 1
+	test 0 = "$(cat "$CPUSET/father/child/${PREFIX}cpus")" || return 1
 }
 
 test11()
 {
-	echo "$cpus_all" > "$CPUSET/father/cpus" || return 1
-	echo > "$CPUSET/father/child/cpus" || return 1
-	echo 0 > "$CPUSET/father/cpus" || return 1
+	echo "$cpus_all" > "$CPUSET/father/${PREFIX}cpus" || return 1
+	echo > "$CPUSET/father/child/${PREFIX}cpus" || return 1
+	echo 0 > "$CPUSET/father/${PREFIX}cpus" || return 1
 
-	cpuset_log "father cpus $(cat "$CPUSET/father/cpus")"
-	cpuset_log "child cpus $(cat "$CPUSET/father/child/cpus")"
+	cpuset_log "father cpus $(cat "$CPUSET/father/${PREFIX}cpus")"
+	cpuset_log "child cpus $(cat "$CPUSET/father/child/${PREFIX}cpus")"
 
-	test 0 = "$(cat "$CPUSET/father/cpus")" || return 1
-	test -z "$(cat "$CPUSET/father/child/cpus")" || return 1
+	test 0 = "$(cat "$CPUSET/father/${PREFIX}cpus")" || return 1
+	test -z "$(cat "$CPUSET/father/child/${PREFIX}cpus")" || return 1
 }
 
 test12()
 {
-	echo "$cpus_all" > "$CPUSET/father/cpus" || return 1
-	echo 0 > "$CPUSET/father/child/cpus" || return 1
-	echo 0 > "$CPUSET/father/cpus" || return 1
+	echo "$cpus_all" > "$CPUSET/father/${PREFIX}cpus" || return 1
+	echo 0 > "$CPUSET/father/child/${PREFIX}cpus" || return 1
+	echo 0 > "$CPUSET/father/${PREFIX}cpus" || return 1
 
-	cpuset_log "father cpus $(cat "$CPUSET/father/cpus")"
-	cpuset_log "child cpus $(cat "$CPUSET/father/child/cpus")"
+	cpuset_log "father cpus $(cat "$CPUSET/father/${PREFIX}cpus")"
+	cpuset_log "child cpus $(cat "$CPUSET/father/child/${PREFIX}cpus")"
 
-	test 0 = "$(cat "$CPUSET/father/cpus")" || return 1
-	test 0 = "$(cat "$CPUSET/father/child/cpus")" || return 1
+	test 0 = "$(cat "$CPUSET/father/${PREFIX}cpus")" || return 1
+	test 0 = "$(cat "$CPUSET/father/child/${PREFIX}cpus")" || return 1
 }
 
 test13()
 {
-	echo "$cpus_all" > "$CPUSET/father/cpus" || return 1
-	echo 1 > "$CPUSET/father/child/cpus" || return 1
-	echo 0 > "$CPUSET/father/cpus" 2> /dev/null && return 1
+	echo "$cpus_all" > "$CPUSET/father/${PREFIX}cpus" || return 1
+	echo 1 > "$CPUSET/father/child/${PREFIX}cpus" || return 1
+	echo 0 > "$CPUSET/father/${PREFIX}cpus" 2> /dev/null && return 1
 
-	cpuset_log "father cpus $(cat "$CPUSET/father/cpus")"
-	cpuset_log "child cpus $(cat "$CPUSET/father/child/cpus")"
+	cpuset_log "father cpus $(cat "$CPUSET/father/${PREFIX}cpus")"
+	cpuset_log "child cpus $(cat "$CPUSET/father/child/${PREFIX}cpus")"
 
-	test "0-$((nr_cpus-1))" = "$(cat "$CPUSET/father/cpus")" || return 1
-	test 1 = "$(cat "$CPUSET/father/child/cpus")" || return 1
+	test "0-$((nr_cpus-1))" = "$(cat "$CPUSET/father/${PREFIX}cpus")" || return 1
+	test 1 = "$(cat "$CPUSET/father/child/${PREFIX}cpus")" || return 1
 }
 
 test14()
 {
-	echo "$cpus_all" > "$CPUSET/father/cpus" || return 1
-	echo 0,1 > "$CPUSET/father/child/cpus" || return 1
-	echo 0 > "$CPUSET/father/cpus" 2> /dev/null && return 1
+	echo "$cpus_all" > "$CPUSET/father/${PREFIX}cpus" || return 1
+	echo 0,1 > "$CPUSET/father/child/${PREFIX}cpus" || return 1
+	echo 0 > "$CPUSET/father/${PREFIX}cpus" 2> /dev/null && return 1
 
-	cpuset_log "father cpus $(cat "$CPUSET/father/cpus")"
-	cpuset_log "child cpus $(cat "$CPUSET/father/child/cpus")"
+	cpuset_log "father cpus $(cat "$CPUSET/father/${PREFIX}cpus")"
+	cpuset_log "child cpus $(cat "$CPUSET/father/child/${PREFIX}cpus")"
 
-	test "0-$((nr_cpus-1))" = "$(cat "$CPUSET/father/cpus")" || return 1
-	test "0-1" = "$(cat "$CPUSET/father/child/cpus")" || return 1
+	test "0-$((nr_cpus-1))" = "$(cat "$CPUSET/father/${PREFIX}cpus")" || return 1
+	test "0-1" = "$(cat "$CPUSET/father/child/${PREFIX}cpus")" || return 1
 }
 
 test15()
 {
-	echo "$cpus_all" > "$CPUSET/father/cpus" || return 1
-	echo 0 > "$CPUSET/father/child/cpus" || return 1
-	echo "0,1" > "$CPUSET/father/cpus" || return 1
+	echo "$cpus_all" > "$CPUSET/father/${PREFIX}cpus" || return 1
+	echo 0 > "$CPUSET/father/child/${PREFIX}cpus" || return 1
+	echo "0,1" > "$CPUSET/father/${PREFIX}cpus" || return 1
 
-	cpuset_log "father cpus $(cat "$CPUSET/father/cpus")"
-	cpuset_log "child cpus $(cat "$CPUSET/father/child/cpus")"
+	cpuset_log "father cpus $(cat "$CPUSET/father/${PREFIX}cpus")"
+	cpuset_log "child cpus $(cat "$CPUSET/father/child/${PREFIX}cpus")"
 
-	test "0-1" = "$(cat "$CPUSET/father/cpus")" || return 1
-	test 0 = "$(cat "$CPUSET/father/child/cpus")" || return 1
+	test "0-1" = "$(cat "$CPUSET/father/${PREFIX}cpus")" || return 1
+	test 0 = "$(cat "$CPUSET/father/child/${PREFIX}cpus")" || return 1
 }
 
 test16()
 {
-	echo "$cpus_all" > "$CPUSET/father/cpus" || return 1
-	echo 0 > "$CPUSET/father/child/cpus" || return 1
-	echo "0,1" > "$CPUSET/father/cpus" || return 1
+	echo "$cpus_all" > "$CPUSET/father/${PREFIX}cpus" || return 1
+	echo 0 > "$CPUSET/father/child/${PREFIX}cpus" || return 1
+	echo "0,1" > "$CPUSET/father/${PREFIX}cpus" || return 1
 
-	cpuset_log "father cpus $(cat "$CPUSET/father/cpus")"
-	cpuset_log "child cpus $(cat "$CPUSET/father/child/cpus")"
+	cpuset_log "father cpus $(cat "$CPUSET/father/${PREFIX}cpus")"
+	cpuset_log "child cpus $(cat "$CPUSET/father/child/${PREFIX}cpus")"
 
-	test "0-1" = "$(cat "$CPUSET/father/cpus")" || return 1
-	test 0 = "$(cat "$CPUSET/father/child/cpus")" || return 1
+	test "0-1" = "$(cat "$CPUSET/father/${PREFIX}cpus")" || return 1
+	test 0 = "$(cat "$CPUSET/father/child/${PREFIX}cpus")" || return 1
 }
 
 ## test mems
 
 test17()
 {
-	echo > "$CPUSET/father/mems" || return 1
-	echo > "$CPUSET/father/child/mems" || return 1
+	echo > "$CPUSET/father/${PREFIX}mems" || return 1
+	echo > "$CPUSET/father/child/${PREFIX}mems" || return 1
 
-	cpuset_log "father mems $(cat "$CPUSET/father/mems")"
-	cpuset_log "child mems $(cat "$CPUSET/father/child/mems")"
+	cpuset_log "father mems $(cat "$CPUSET/father/${PREFIX}mems")"
+	cpuset_log "child mems $(cat "$CPUSET/father/child/${PREFIX}mems")"
 
-	test -z "$(cat "$CPUSET/father/mems")" || return 1
-	test -z "$(cat "$CPUSET/father/child/mems")" || return 1
+	test -z "$(cat "$CPUSET/father/${PREFIX}mems")" || return 1
+	test -z "$(cat "$CPUSET/father/child/${PREFIX}mems")" || return 1
 }
 
 test18()
 {
-	echo > "$CPUSET/father/mems" || return 1
-	echo 0 > "$CPUSET/father/child/mems" 2> /dev/null && return 1
+	echo > "$CPUSET/father/${PREFIX}mems" || return 1
+	echo 0 > "$CPUSET/father/child/${PREFIX}mems" 2> /dev/null && return 1
 
-	cpuset_log "father mems $(cat "$CPUSET/father/mems")"
-	cpuset_log "child mems $(cat "$CPUSET/father/child/mems")"
+	cpuset_log "father mems $(cat "$CPUSET/father/${PREFIX}mems")"
+	cpuset_log "child mems $(cat "$CPUSET/father/child/${PREFIX}mems")"
 
-	test -z "$(cat "$CPUSET/father/mems")" || return 1
-	test -z "$(cat "$CPUSET/father/child/mems")" || return 1
+	test -z "$(cat "$CPUSET/father/${PREFIX}mems")" || return 1
+	test -z "$(cat "$CPUSET/father/child/${PREFIX}mems")" || return 1
 }
 
 test19()
 {
-	echo 0 > "$CPUSET/father/mems" || return 1
-	echo > "$CPUSET/father/child/mems" || return 1
+	echo 0 > "$CPUSET/father/${PREFIX}mems" || return 1
+	echo > "$CPUSET/father/child/${PREFIX}mems" || return 1
 
-	cpuset_log "father mems $(cat "$CPUSET/father/mems")"
-	cpuset_log "child mems $(cat "$CPUSET/father/child/mems")"
+	cpuset_log "father mems $(cat "$CPUSET/father/${PREFIX}mems")"
+	cpuset_log "child mems $(cat "$CPUSET/father/child/${PREFIX}mems")"
 
-	test 0 = "$(cat "$CPUSET/father/mems")" || return 1
-	test -z "$(cat "$CPUSET/father/child/mems")" || return 1
+	test 0 = "$(cat "$CPUSET/father/${PREFIX}mems")" || return 1
+	test -z "$(cat "$CPUSET/father/child/${PREFIX}mems")" || return 1
 }
 
 test20()
 {
-	echo 0 > "$CPUSET/father/mems" || return 1
-	echo 0 > "$CPUSET/father/child/mems" || return 1
+	echo 0 > "$CPUSET/father/${PREFIX}mems" || return 1
+	echo 0 > "$CPUSET/father/child/${PREFIX}mems" || return 1
 
-	cpuset_log "father mems $(cat "$CPUSET/father/mems")"
-	cpuset_log "child mems $(cat "$CPUSET/father/child/mems")"
+	cpuset_log "father mems $(cat "$CPUSET/father/${PREFIX}mems")"
+	cpuset_log "child mems $(cat "$CPUSET/father/child/${PREFIX}mems")"
 
-	test 0 = "$(cat "$CPUSET/father/mems")" || return 1
-	test 0 = "$(cat "$CPUSET/father/child/mems")" || return 1
+	test 0 = "$(cat "$CPUSET/father/${PREFIX}mems")" || return 1
+	test 0 = "$(cat "$CPUSET/father/child/${PREFIX}mems")" || return 1
 }
 
 test21()
 {
-	echo 0 > "$CPUSET/father/mems" || return 1
-	echo 1 > "$CPUSET/father/child/mems" 2> /dev/null && return 1
+	echo 0 > "$CPUSET/father/${PREFIX}mems" || return 1
+	echo 1 > "$CPUSET/father/child/${PREFIX}mems" 2> /dev/null && return 1
 
-	cpuset_log "father mems $(cat "$CPUSET/father/mems")"
-	cpuset_log "child mems $(cat "$CPUSET/father/child/mems")"
+	cpuset_log "father mems $(cat "$CPUSET/father/${PREFIX}mems")"
+	cpuset_log "child mems $(cat "$CPUSET/father/child/${PREFIX}mems")"
 
-	test 0 = "$(cat "$CPUSET/father/mems")" || return 1
-	test -z "$(cat "$CPUSET/father/child/mems")" || return 1
+	test 0 = "$(cat "$CPUSET/father/${PREFIX}mems")" || return 1
+	test -z "$(cat "$CPUSET/father/child/${PREFIX}mems")" || return 1
 }
 
 test22()
 {
-	echo 0 > "$CPUSET/father/mems" || return 1
-	echo 0,1 > "$CPUSET/father/child/mems" 2> /dev/null && return 1
+	echo 0 > "$CPUSET/father/${PREFIX}mems" || return 1
+	echo 0,1 > "$CPUSET/father/child/${PREFIX}mems" 2> /dev/null && return 1
 
-	cpuset_log "father mems $(cat "$CPUSET/father/mems")"
-	cpuset_log "child mems $(cat "$CPUSET/father/child/mems")"
+	cpuset_log "father mems $(cat "$CPUSET/father/${PREFIX}mems")"
+	cpuset_log "child mems $(cat "$CPUSET/father/child/${PREFIX}mems")"
 
-	test 0 = "$(cat "$CPUSET/father/mems")" || return 1
-	test -z "$(cat "$CPUSET/father/child/mems")" || return 1
+	test 0 = "$(cat "$CPUSET/father/${PREFIX}mems")" || return 1
+	test -z "$(cat "$CPUSET/father/child/${PREFIX}mems")" || return 1
 }
 
 test23()
 {
-	echo "0,1" > "$CPUSET/father/mems" || return 1
-	echo 0 > "$CPUSET/father/child/mems" || return 1
+	echo "0,1" > "$CPUSET/father/${PREFIX}mems" || return 1
+	echo 0 > "$CPUSET/father/child/${PREFIX}mems" || return 1
 
-	cpuset_log "father mems $(cat "$CPUSET/father/mems")"
-	cpuset_log "child mems $(cat "$CPUSET/father/child/mems")"
+	cpuset_log "father mems $(cat "$CPUSET/father/${PREFIX}mems")"
+	cpuset_log "child mems $(cat "$CPUSET/father/child/${PREFIX}mems")"
 
-	test "0-1" = "$(cat "$CPUSET/father/mems")" || return 1
-	test 0 = "$(cat "$CPUSET/father/child/mems")" || return 1
+	test "0-1" = "$(cat "$CPUSET/father/${PREFIX}mems")" || return 1
+	test 0 = "$(cat "$CPUSET/father/child/${PREFIX}mems")" || return 1
 }
 
 test24()
 {
-	echo "0,1" > "$CPUSET/father/mems" || return 1
-	echo 0 > "$CPUSET/father/child/mems" || return 1
+	echo "0,1" > "$CPUSET/father/${PREFIX}mems" || return 1
+	echo 0 > "$CPUSET/father/child/${PREFIX}mems" || return 1
 
-	cpuset_log "father mems $(cat "$CPUSET/father/mems")"
-	cpuset_log "child mems $(cat "$CPUSET/father/child/mems")"
+	cpuset_log "father mems $(cat "$CPUSET/father/${PREFIX}mems")"
+	cpuset_log "child mems $(cat "$CPUSET/father/child/${PREFIX}mems")"
 
-	test "0-1" = "$(cat "$CPUSET/father/mems")" || return 1
-	test 0 = "$(cat "$CPUSET/father/child/mems")" || return 1
+	test "0-1" = "$(cat "$CPUSET/father/${PREFIX}mems")" || return 1
+	test 0 = "$(cat "$CPUSET/father/child/${PREFIX}mems")" || return 1
 }
 
 test25()
 {
-	echo "$mems_all" > "$CPUSET/father/mems" || return 1
-	echo > "$CPUSET/father/child/mems" || return 1
-	echo > "$CPUSET/father/mems" || return 1
+	echo "$mems_all" > "$CPUSET/father/${PREFIX}mems" || return 1
+	echo > "$CPUSET/father/child/${PREFIX}mems" || return 1
+	echo > "$CPUSET/father/${PREFIX}mems" || return 1
 
-	cpuset_log "father mems $(cat "$CPUSET/father/mems")"
-	cpuset_log "child mems $(cat "$CPUSET/father/child/mems")"
+	cpuset_log "father mems $(cat "$CPUSET/father/${PREFIX}mems")"
+	cpuset_log "child mems $(cat "$CPUSET/father/child/${PREFIX}mems")"
 
-	test -z "$(cat "$CPUSET/father/mems")" || return 1
-	test -z "$(cat "$CPUSET/father/child/mems")" || return 1
+	test -z "$(cat "$CPUSET/father/${PREFIX}mems")" || return 1
+	test -z "$(cat "$CPUSET/father/child/${PREFIX}mems")" || return 1
 }
 
 test26()
 {
-	echo "$mems_all" > "$CPUSET/father/mems" || return 1
-	echo 0 > "$CPUSET/father/child/mems" || return 1
-	echo > "$CPUSET/father/mems" 2> /dev/null && return 1
+	echo "$mems_all" > "$CPUSET/father/${PREFIX}mems" || return 1
+	echo 0 > "$CPUSET/father/child/${PREFIX}mems" || return 1
+	echo > "$CPUSET/father/${PREFIX}mems" 2> /dev/null && return 1
 
-	cpuset_log "father mems $(cat "$CPUSET/father/mems")"
-	cpuset_log "child mems $(cat "$CPUSET/father/child/mems")"
+	cpuset_log "father mems $(cat "$CPUSET/father/${PREFIX}mems")"
+	cpuset_log "child mems $(cat "$CPUSET/father/child/${PREFIX}mems")"
 
-	test "0-$((nr_mems-1))" = "$(cat "$CPUSET/father/mems")" || return 1
-	test 0 = "$(cat "$CPUSET/father/child/mems")" || return 1
+	test "0-$((nr_mems-1))" = "$(cat "$CPUSET/father/${PREFIX}mems")" || return 1
+	test 0 = "$(cat "$CPUSET/father/child/${PREFIX}mems")" || return 1
 }
 
 test27()
 {
-	echo "$mems_all" > "$CPUSET/father/mems" || return 1
-	echo > "$CPUSET/father/child/mems" || return 1
-	echo 0 > "$CPUSET/father/mems" || return 1
+	echo "$mems_all" > "$CPUSET/father/${PREFIX}mems" || return 1
+	echo > "$CPUSET/father/child/${PREFIX}mems" || return 1
+	echo 0 > "$CPUSET/father/${PREFIX}mems" || return 1
 
-	cpuset_log "father mems $(cat "$CPUSET/father/mems")"
-	cpuset_log "child mems $(cat "$CPUSET/father/child/mems")"
+	cpuset_log "father mems $(cat "$CPUSET/father/${PREFIX}mems")"
+	cpuset_log "child mems $(cat "$CPUSET/father/child/${PREFIX}mems")"
 
-	test 0 = "$(cat "$CPUSET/father/mems")" || return 1
-	test -z "$(cat "$CPUSET/father/child/mems")" || return 1
+	test 0 = "$(cat "$CPUSET/father/${PREFIX}mems")" || return 1
+	test -z "$(cat "$CPUSET/father/child/${PREFIX}mems")" || return 1
 }
 
 test28()
 {
-	echo "$mems_all" > "$CPUSET/father/mems" || return 1
-	echo 0 > "$CPUSET/father/child/mems" || return 1
-	echo 0 > "$CPUSET/father/mems" || return 1
+	echo "$mems_all" > "$CPUSET/father/${PREFIX}mems" || return 1
+	echo 0 > "$CPUSET/father/child/${PREFIX}mems" || return 1
+	echo 0 > "$CPUSET/father/${PREFIX}mems" || return 1
 
-	cpuset_log "father mems $(cat "$CPUSET/father/mems")"
-	cpuset_log "child mems $(cat "$CPUSET/father/child/mems")"
+	cpuset_log "father mems $(cat "$CPUSET/father/${PREFIX}mems")"
+	cpuset_log "child mems $(cat "$CPUSET/father/child/${PREFIX}mems")"
 
-	test 0 = "$(cat "$CPUSET/father/mems")" || return 1
-	test 0 = "$(cat "$CPUSET/father/child/mems")" || return 1
+	test 0 = "$(cat "$CPUSET/father/${PREFIX}mems")" || return 1
+	test 0 = "$(cat "$CPUSET/father/child/${PREFIX}mems")" || return 1
 }
 
 test29()
 {
-	echo "$mems_all" > "$CPUSET/father/mems" || return 1
-	echo 1 > "$CPUSET/father/child/mems" || return 1
-	echo 0 > "$CPUSET/father/mems" 2> /dev/null && return 1
+	echo "$mems_all" > "$CPUSET/father/${PREFIX}mems" || return 1
+	echo 1 > "$CPUSET/father/child/${PREFIX}mems" || return 1
+	echo 0 > "$CPUSET/father/${PREFIX}mems" 2> /dev/null && return 1
 
-	cpuset_log "father mems $(cat "$CPUSET/father/mems")"
-	cpuset_log "child mems $(cat "$CPUSET/father/child/mems")"
+	cpuset_log "father mems $(cat "$CPUSET/father/${PREFIX}mems")"
+	cpuset_log "child mems $(cat "$CPUSET/father/child/${PREFIX}mems")"
 
-	test "0-$((nr_mems-1))" = "$(cat "$CPUSET/father/mems")" || return 1
-	test 1 = "$(cat "$CPUSET/father/child/mems")" || return 1
+	test "0-$((nr_mems-1))" = "$(cat "$CPUSET/father/${PREFIX}mems")" || return 1
+	test 1 = "$(cat "$CPUSET/father/child/${PREFIX}mems")" || return 1
 }
 
 test30()
 {
-	echo "$mems_all" > "$CPUSET/father/mems" || return 1
-	echo 0,1 > "$CPUSET/father/child/mems" || return 1
-	echo 0 > "$CPUSET/father/mems" 2> /dev/null && return 1
+	echo "$mems_all" > "$CPUSET/father/${PREFIX}mems" || return 1
+	echo 0,1 > "$CPUSET/father/child/${PREFIX}mems" || return 1
+	echo 0 > "$CPUSET/father/${PREFIX}mems" 2> /dev/null && return 1
 
-	cpuset_log "father mems $(cat "$CPUSET/father/mems")"
-	cpuset_log "child mems $(cat "$CPUSET/father/child/mems")"
+	cpuset_log "father mems $(cat "$CPUSET/father/${PREFIX}mems")"
+	cpuset_log "child mems $(cat "$CPUSET/father/child/${PREFIX}mems")"
 
-	test "0-$((nr_mems-1))" = "$(cat "$CPUSET/father/mems")" || return 1
-	test "0-1" = "$(cat "$CPUSET/father/child/mems")" || return 1
+	test "0-$((nr_mems-1))" = "$(cat "$CPUSET/father/${PREFIX}mems")" || return 1
+	test "0-1" = "$(cat "$CPUSET/father/child/${PREFIX}mems")" || return 1
 }
 
 test31()
 {
-	echo "$mems_all" > "$CPUSET/father/mems" || return 1
-	echo 0 > "$CPUSET/father/child/mems" || return 1
-	echo "0,1" > "$CPUSET/father/mems" || return 1
+	echo "$mems_all" > "$CPUSET/father/${PREFIX}mems" || return 1
+	echo 0 > "$CPUSET/father/child/${PREFIX}mems" || return 1
+	echo "0,1" > "$CPUSET/father/${PREFIX}mems" || return 1
 
-	cpuset_log "father mems $(cat "$CPUSET/father/mems")"
-	cpuset_log "child mems $(cat "$CPUSET/father/child/mems")"
+	cpuset_log "father mems $(cat "$CPUSET/father/${PREFIX}mems")"
+	cpuset_log "child mems $(cat "$CPUSET/father/child/${PREFIX}mems")"
 
-	test "0-1" = "$(cat "$CPUSET/father/mems")" || return 1
-	test 0 = "$(cat "$CPUSET/father/child/mems")" || return 1
+	test "0-1" = "$(cat "$CPUSET/father/${PREFIX}mems")" || return 1
+	test 0 = "$(cat "$CPUSET/father/child/${PREFIX}mems")" || return 1
 }
 
 test32()
 {
-	echo "$mems_all" > "$CPUSET/father/mems" || return 1
-	echo 0 > "$CPUSET/father/child/mems" || return 1
-	echo "0,1" > "$CPUSET/father/mems" || return 1
+	echo "$mems_all" > "$CPUSET/father/${PREFIX}mems" || return 1
+	echo 0 > "$CPUSET/father/child/${PREFIX}mems" || return 1
+	echo "0,1" > "$CPUSET/father/${PREFIX}mems" || return 1
 
-	cpuset_log "father mems $(cat "$CPUSET/father/mems")"
-	cpuset_log "child mems $(cat "$CPUSET/father/child/mems")"
+	cpuset_log "father mems $(cat "$CPUSET/father/${PREFIX}mems")"
+	cpuset_log "child mems $(cat "$CPUSET/father/child/${PREFIX}mems")"
 
-	test "0-1" = "$(cat "$CPUSET/father/mems")" || return 1
-	test 0 = "$(cat "$CPUSET/father/child/mems")" || return 1
+	test "0-1" = "$(cat "$CPUSET/father/${PREFIX}mems")" || return 1
+	test 0 = "$(cat "$CPUSET/father/child/${PREFIX}mems")" || return 1
 }
 
 for i in $(seq 1 $TST_TOTAL)
diff --git a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
index 05a9ea6fc..936dc14f2 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
@@ -86,7 +86,7 @@ root_cpu_hotplug_test()
 		return 1
 	fi
 
-	root_cpus="`cat $CPUSET/cpus`"
+	root_cpus="`cat $CPUSET/${PREFIX}cpus`"
 
 	task_cpus="`cat /proc/$tst_pid/status | grep Cpus_allowed_list`"
 	task_cpus="`echo $task_cpus | sed -e 's/Cpus_allowed_list: //'`"
@@ -155,7 +155,7 @@ general_cpu_hotplug_test()
 		return 1
 	fi
 
-	cpus="`cat $path/cpus`"
+	cpus="`cat $path/${PREFIX}cpus`"
 
 	task_cpus="`cat /proc/$tst_pid/status | grep Cpus_allowed_list`"
 	task_cpus="`echo $task_cpus | sed -e 's/Cpus_allowed_list: //'`"
diff --git a/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh
index f9d524e69..a90e109f5 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh
@@ -105,7 +105,7 @@ test_cpus()
 	cfile_name="cpus"
 	while read cpus result
 	do
-		inherit_test "$CPUSET/1/cpus" "$cpus" "$result"
+		inherit_test "$CPUSET/1/${PREFIX}cpus" "$cpus" "$result"
 	done <<- EOF
 		NULL					EMPTY
 		0					EMPTY
@@ -119,7 +119,7 @@ test_mems()
 	cfile_name="mems"
 	while read mems result
 	do
-		inherit_test "$CPUSET/1/mems" "$mems" "$result"
+		inherit_test "$CPUSET/1/${PREFIX}mems" "$mems" "$result"
 	done <<- EOF
 		NULL					EMPTY
 		0					EMPTY
@@ -137,7 +137,7 @@ test_three_result_similar_flags()
 		cfile_name="$filename"
 		while read flags result
 		do
-			inherit_test "$CPUSET/1/$filename" "$flags" "$result"
+			inherit_test "$CPUSET/1/${PREFIX}$filename" "$flags" "$result"
 		done <<- EOF
 			0	0
 			1	0
@@ -154,7 +154,7 @@ test_spread_flags()
 		cfile_name="$filename"
 		while read flags result
 		do
-			inherit_test "$CPUSET/1/$filename" "$flags" "$result"
+			inherit_test "$CPUSET/1/${PREFIX}$filename" "$flags" "$result"
 		done <<- EOF
 			0	0
 			1	1
@@ -168,7 +168,7 @@ test_sched_load_balance_flag()
 	cfile_name="sched_load_balance"
 	while read flag result
 	do
-		inherit_test "$CPUSET/1/sched_load_balance" "$flag" "$result"
+		inherit_test "$CPUSET/1/${PREFIX}sched_load_balance" "$flag" "$result"
 	done <<- EOF
 		0	1
 		1	1
@@ -181,7 +181,7 @@ test_domain()
 	cfile_name="sched_relax_domain_level"
 	while read domain_level result
 	do
-		inherit_test "$CPUSET/1/sched_relax_domain_level" "$domain_level" "$result"
+		inherit_test "$CPUSET/1/${PREFIX}sched_relax_domain_level" "$domain_level" "$result"
 	done <<- EOF
 		-1	-1
 		0	-1
diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/cpuset_memory_pressure_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/cpuset_memory_pressure_testset.sh
index fcf00d4cb..775ac2d5f 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/cpuset_memory_pressure_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/cpuset_memory_pressure_testset.sh
@@ -43,7 +43,7 @@ usemem=$((py_mem - 20))
 
 test1()
 {
-	echo 0 > "$CPUSET/memory_pressure_enabled" 2> $CPUSET_TMP/stderr
+	echo 0 > "$CPUSET/${PREFIX}memory_pressure_enabled" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
 		tst_resm TFAIL "Closing memory_pressure_enabled failed."
@@ -53,7 +53,7 @@ test1()
 	local i
 	for i in $(seq 0 9)
 	do
-		if [ $(cat "$CPUSET/memory_pressure") -ne 0 ]; then
+		if [ $(cat "$CPUSET/${PREFIX}memory_pressure") -ne 0 ]; then
 			tst_resm TFAIL "Memory_pressure had memory pressure rate."
 			return 1
 		fi
@@ -62,7 +62,7 @@ test1()
 
 test2()
 {
-	echo 0 > "$CPUSET/memory_pressure_enabled" 2> $CPUSET_TMP/stderr
+	echo 0 > "$CPUSET/${PREFIX}memory_pressure_enabled" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
 		tst_resm TFAIL "Closing memory_pressure_enabled failed."
@@ -74,7 +74,7 @@ test2()
 	local i
 	for i in $(seq 0 9)
 	do
-		if [ $(cat "$CPUSET/memory_pressure") -ne 0 ]; then
+		if [ $(cat "$CPUSET/${PREFIX}memory_pressure") -ne 0 ]; then
 			tst_resm TFAIL "Memory_pressure had memory pressure rate."
 			return 1
 		fi
@@ -83,7 +83,7 @@ test2()
 
 test3()
 {
-	echo 1 > "$CPUSET/memory_pressure_enabled" 2> $CPUSET_TMP/stderr
+	echo 1 > "$CPUSET/${PREFIX}memory_pressure_enabled" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
 		tst_resm TFAIL "Opening memory_pressure_enabled failed."
@@ -100,11 +100,11 @@ test3()
 	local i
 	for i in $(seq 0 9)
 	do
-		if [ $(cat "$CPUSET/memory_pressure") -ne 0 ]; then
+		if [ $(cat "$CPUSET/${PREFIX}memory_pressure") -ne 0 ]; then
 			tst_resm TFAIL "root group's memory_pressure had memory pressure rate."
 			return 1
 		fi
-		if [ $(cat "$CPUSET/sub_cpuset/memory_pressure") -ne 0 ]; then
+		if [ $(cat "$CPUSET/sub_cpuset/${PREFIX}memory_pressure") -ne 0 ]; then
 			tst_resm TFAIL "sub group's memory_pressure had memory pressure rate."
 			return 1
 		fi
@@ -114,7 +114,7 @@ test3()
 
 test4()
 {
-	echo 1 > "$CPUSET/memory_pressure_enabled" 2> $CPUSET_TMP/stderr
+	echo 1 > "$CPUSET/${PREFIX}memory_pressure_enabled" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
 		tst_resm TFAIL "Opening memory_pressure_enabled failed."
@@ -147,11 +147,11 @@ test4()
 	local i
 	for i in $(seq 0 9)
 	do
-		if [ $(cat "$CPUSET/memory_pressure") -ne 0 ]; then
+		if [ $(cat "$CPUSET/${PREFIX}memory_pressure") -ne 0 ]; then
 			tst_resm TFAIL "root group's memory_pressure had memory pressure rate."
 			return 1
 		fi
-		if [ $(cat "$CPUSET/sub_cpuset/memory_pressure") -eq 0 ]; then
+		if [ $(cat "$CPUSET/sub_cpuset/${PREFIX}memory_pressure") -eq 0 ]; then
 			tst_resm TFAIL "sub group's memory_pressure didn't have memory pressure rate."
 			return 1
 		fi
@@ -160,7 +160,7 @@ test4()
 
 test5()
 {
-	echo 1 > "$CPUSET/memory_pressure_enabled" 2> $CPUSET_TMP/stderr
+	echo 1 > "$CPUSET/${PREFIX}memory_pressure_enabled" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
 		tst_resm TFAIL "Opening memory_pressure_enabled failed."
@@ -178,11 +178,11 @@ test5()
 	local i
 	for i in $(seq 0 9)
 	do
-		if [ $(cat "$CPUSET/memory_pressure") -eq 0 ]; then
+		if [ $(cat "$CPUSET/${PREFIX}memory_pressure") -eq 0 ]; then
 			tst_resm TFAIL "root group's memory_pressure didn't have memory pressure rate."
 			return 1
 		fi
-		if [ $(cat "$CPUSET/sub_cpuset/memory_pressure") -ne 0 ]; then
+		if [ $(cat "$CPUSET/sub_cpuset/${PREFIX}memory_pressure") -ne 0 ]; then
 			tst_resm TFAIL "sub group's memory_pressure had memory pressure rate."
 			return 1
 		fi
@@ -191,7 +191,7 @@ test5()
 
 test6()
 {
-	echo 1 > "$CPUSET/memory_pressure_enabled" 2> $CPUSET_TMP/stderr
+	echo 1 > "$CPUSET/${PREFIX}memory_pressure_enabled" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
 		tst_resm TFAIL "Opening memory_pressure_enabled failed."
@@ -224,11 +224,11 @@ test6()
 	local i
 	for i in $(seq 0 9)
 	do
-		if [ $(cat "$CPUSET/memory_pressure") -eq 0 ]; then
+		if [ $(cat "$CPUSET/${PREFIX}memory_pressure") -eq 0 ]; then
 			tst_resm TFAIL "root group's memory_pressure didn't have memory pressure rate."
 			return 1
 		fi
-		if [ $(cat "$CPUSET/sub_cpuset/memory_pressure") -eq 0 ]; then
+		if [ $(cat "$CPUSET/sub_cpuset/${PREFIX}memory_pressure") -eq 0 ]; then
 			tst_resm TFAIL "sub group's memory_pressure didn't have memory pressure rate."
 			return 1
 		fi
diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
index f7d4d63ee..439e07c54 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
@@ -207,7 +207,7 @@ general_memory_spread_test()
 		return 1
 	fi
 
-	/bin/echo "$is_spread" > "$cpusetpath/memory_spread_page" 2> $CPUSET_TMP/stderr
+	/bin/echo "$is_spread" > "$cpusetpath/${PREFIX}memory_spread_page" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
 		tst_resm TFAIL "set spread value failed."
diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
index e8ef6bfd3..536004795 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
@@ -345,7 +345,7 @@ test11()
 		return 1
 	fi
 
-	echo 1 > "$CPUSET/2/memory_migrate" 2> $CPUSET_TMP/stderr
+	echo 1 > "$CPUSET/2/${PREFIX}memory_migrate" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
 		tst_resm TFAIL "set general group2's memory_migrate failed."
@@ -384,7 +384,7 @@ talk2memory_test_for_case_12_13()
 	echo $1 > "$2/tasks"
 	/bin/kill -s SIGUSR1 $1
 
-	echo 0 > "$2/mems" || return 1
+	echo 0 > "$2/${PREFIX}mems" || return 1
 	sleep 1
 	/bin/kill -s SIGUSR1 $1
 	sleep 1
@@ -432,7 +432,7 @@ test13()
 		return 1
 	fi
 
-	echo 1 > "$CPUSET/0/memory_migrate" 2> $CPUSET_TMP/stderr
+	echo 1 > "$CPUSET/0/${PREFIX}memory_migrate" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
 		tst_resm TFAIL "set general group's memory_migrate failed."
@@ -543,7 +543,7 @@ test15()
 		return 1
 	fi
 
-	echo 1 > "$CPUSET/2/memory_migrate" 2> $CPUSET_TMP/stderr
+	echo 1 > "$CPUSET/2/${PREFIX}memory_migrate" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
 		tst_resm TFAIL "set general group2's memory_migrate failed."
@@ -599,7 +599,7 @@ test16()
 		return 1
 	fi
 
-	echo 1 > "$CPUSET/2/memory_migrate" 2> $CPUSET_TMP/stderr
+	echo 1 > "$CPUSET/2/${PREFIX}memory_migrate" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
 		tst_resm TFAIL "set general group2's memory_migrate failed."
@@ -618,7 +618,7 @@ test16()
 
 		echo $testtid > "$CPUSET/2/tasks"
 		sleep 1
-		echo 1 > "$CPUSET/1/memory_migrate"
+		echo 1 > "$CPUSET/1/${PREFIX}memory_migrate"
 		sleep 1
 		/bin/kill -s SIGUSR2 $testpid
 		sleep 1
@@ -666,7 +666,7 @@ test17()
 		return 1
 	fi
 
-	echo 1 > "$CPUSET/2/memory_migrate" 2> $CPUSET_TMP/stderr
+	echo 1 > "$CPUSET/2/${PREFIX}memory_migrate" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
 		tst_resm TFAIL "set general group2's memory_migrate failed."
@@ -684,7 +684,7 @@ test17()
 
 		echo $testtid > "$CPUSET/2/tasks"
 		sleep 1
-		echo 0 > "$CPUSET/1/mems"
+		echo 0 > "$CPUSET/1/${PREFIX}mems"
 		sleep 1
 		/bin/kill -s SIGUSR2 $testpid
 		sleep 1
@@ -734,7 +734,7 @@ test18()
 		return 1
 	fi
 
-	echo 1 > "$CPUSET/1/memory_migrate" 2> $CPUSET_TMP/stderr
+	echo 1 > "$CPUSET/1/${PREFIX}memory_migrate" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
 		tst_resm TFAIL "set general group1's memory_migrate failed."
@@ -748,7 +748,7 @@ test18()
 		return 1
 	fi
 
-	echo 1 > "$CPUSET/2/memory_migrate" 2> $CPUSET_TMP/stderr
+	echo 1 > "$CPUSET/2/${PREFIX}memory_migrate" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
 		tst_resm TFAIL "set general group2's memory_migrate failed."
@@ -766,7 +766,7 @@ test18()
 
 		echo $testtid > "$CPUSET/2/tasks"
 		sleep 1
-		echo 0 > "$CPUSET/1/mems"
+		echo 0 > "$CPUSET/1/${PREFIX}mems"
 		sleep 1
 		/bin/kill -s SIGUSR2 $testpid
 		sleep 1
diff --git a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
index 94b882479..faba2309c 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
@@ -57,14 +57,14 @@ do_syscall_test()
 		tst_resm TFAIL "mkdir -p $TEST_CPUSET fail."
 		return 1
 	fi
-	echo "$1" > "$TEST_CPUSET/cpus"
+	echo "$1" > "$TEST_CPUSET/${PREFIX}cpus"
 	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "set $TEST_CPUSET/cpus as $1 fail."
+		tst_resm TFAIL "set $TEST_CPUSET/${PREFIX}cpus as $1 fail."
 		return 1
 	fi
-	echo "$2" > "$TEST_CPUSET/mems"
+	echo "$2" > "$TEST_CPUSET/${PREFIX}mems"
 	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "set $TEST_CPUSET/mems as $2 fail."
+		tst_resm TFAIL "set $TEST_CPUSET/${PREFIX}mems as $2 fail."
 		return 1
 	fi
 	cpuset_syscall_test $3 >"$TEST_OUTPUT" &
-- 
2.13.5

