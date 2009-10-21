Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1N0dFi-0001ff-CU
	for ltp-list@lists.sourceforge.net; Wed, 21 Oct 2009 15:37:30 +0000
Received: from fmmailgate02.web.de ([217.72.192.227])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N0dFe-000434-9B
	for ltp-list@lists.sourceforge.net; Wed, 21 Oct 2009 15:37:30 +0000
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 1EA0A1360E525
	for <ltp-list@lists.sourceforge.net>;
	Wed, 21 Oct 2009 17:34:31 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian)
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314) id 1N0dCo-000416-00
	for ltp-list@lists.sourceforge.net; Wed, 21 Oct 2009 17:34:30 +0200
Date: Wed, 21 Oct 2009 02:19:58 +0200
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.u15pksj3cfnueu@debian>
Subject: [LTP] [PATCH] Fix some bashisms
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
Sender: ltp-list-bounces@lists.sourceforge.net
Errors-To: ltp-list-bounces@lists.sourceforge.net
Cc: ltp-list@lists.sourceforge.net
Message-ID: <20091021001958.A-fqiTtxnyZ1yevsxDWy6paFJ5r2hMN_uY4wx46bjEk@z>

Hello,

this is another patch fixing bashisms in LTP tests (the fixes are more or less the same as in the previous patches, except for a few exceptions). Note that the patch is not complete, in the sense that there may remain further bashisms in the source even after applying the patch (like use of arrays, which is visible even from this patch).

Regards
    Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 .../controllers/cgroup_fj/cgroup_fj_utility.sh     |    2 +-
 .../controllers/cgroup_fj/run_cgroup_test_fj.sh    |    8 ++--
 .../controllers/cpuctl_fj/run_cpuctl_test_fj.sh    |   51 ++++++++++----------
 .../memcg/functional/memcg_function_test.sh        |    6 +-
 .../controllers/memcg/stress/memcg_stress_test.sh  |   18 ++++----
 testcases/kernel/fs/acls/acl_test01                |   12 ++--
 testcases/kernel/fs/fs-bench/modaltr.sh            |    2 +-
 testcases/kernel/fs/fs_di/fs_di                    |    4 +-
 testcases/kernel/fs/mongo/test.sh                  |    8 +--
 .../hotplug/cpu_hotplug/functional/hotplug02.sh    |    6 +-
 .../hotplug/cpu_hotplug/functional/hotplug03.sh    |   16 +++---
 .../hotplug/cpu_hotplug/functional/hotplug04.sh    |   10 ++--
 .../cpu_hotplug/functional/hotplug06.sar.sh        |    6 +-
 .../cpu_hotplug/functional/hotplug06.top.sh        |    6 +-
 .../hotplug/cpu_hotplug/functional/hotplug07.sh    |    6 +-
 .../network/can/filter-tests/run_ltp-can_tests.sh  |    2 +-
 testcases/network/tcp_cmds/netstat/netstat01       |    2 +-
 17 files changed, 82 insertions(+), 83 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
index 4ba15d6..ed161fa 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
@@ -547,7 +547,7 @@ reclaim_foundling()
 		if [ -e /proc/$cur_pid/ ];then
 			echo "ERROR: pid $cur_pid reclaimed"
 			do_echo 0 1 "$cur_pid" "/dev/cgroup/tasks"
-			let "foundlings = $foundlings + 1"
+			: $((foundlings += 1))
 		fi
 	done
 
diff --git a/testcases/kernel/controllers/cgroup_fj/run_cgroup_test_fj.sh b/testcases/kernel/controllers/cgroup_fj/run_cgroup_test_fj.sh
index 70e4078..eb2d1db 100755
--- a/testcases/kernel/controllers/cgroup_fj/run_cgroup_test_fj.sh
+++ b/testcases/kernel/controllers/cgroup_fj/run_cgroup_test_fj.sh
@@ -33,7 +33,7 @@ export TMPFILE=$TESTROOT/tmp_tasks
 export CASENO1=0
 export CASENO2=0
 
-if [ "$UID" -ne 0 ]; then
+if [ "$(id -ru)" -ne 0 ]; then
 	echo "***error***:you must use root to test"
 	exit -1
 fi
@@ -107,17 +107,17 @@ do
 	if [ $? -ne 0 ]; then
 		case $CASETYPE in
 		"function" )
-			let "CASENO1 = $CASENO1 + 1"
+			: $(( CASENO1 += 1 ))
 			export CASENO1=$CASENO1
 			$TESTROOT/cgroup_fj_function.sh $CASECMD
 			;;
 		"function2" )
-			let "CASENO1 = $CASENO1 + 1"
+			: $(( CASENO1 += 1 ))
 			export CASENO1=$CASENO1
 			$TESTROOT/cgroup_fj_function2.sh $CASECMD
 			;;
 		"stress" )
-			let "CASENO2 = $CASENO2 + 1"
+			: $(( CASENO2 += 1 ))
 			export CASENO2=$CASENO2
 			$TESTROOT/cgroup_fj_stress.sh $CASECMD
 			;;
diff --git a/testcases/kernel/controllers/cpuctl_fj/run_cpuctl_test_fj.sh b/testcases/kernel/controllers/cpuctl_fj/run_cpuctl_test_fj.sh
index 6ab0f65..f02f59a 100755
--- a/testcases/kernel/controllers/cpuctl_fj/run_cpuctl_test_fj.sh
+++ b/testcases/kernel/controllers/cpuctl_fj/run_cpuctl_test_fj.sh
@@ -58,8 +58,8 @@ setup()
 # Write the cleanup function
 cleanup()
 {
-	mount | grep "$CPUCTL" &> /dev/null || {
-		rm -rf "$CPUCTL" &> /dev/null
+	mount | grep "$CPUCTL" > /dev/null 2>&1 || {
+		rm -rf "$CPUCTL" > /dev/null 2>&1
 		return 0
 	}
 
@@ -73,22 +73,19 @@ cleanup()
 	done
 
 	umount $CPUCTL || return 1
-	rmdir $CPUCTL &> /dev/null
+	rmdir $CPUCTL > /dev/null 2>&1
 }
 
 creat_process()
 {
 	cat /dev/zero > /dev/null 2>/dev/null &
-	taskset -p 1 $! &>/dev/null
+	taskset -p 1 $! >/dev/null 2>&1
 	echo $!
 }
 
 get_cpu_usage()
 {
-	top=($(top -b -n 1 -p $1 | tail -2 | head -1))
-	top=${top[8]}
-	top=`echo $top | awk -F "." '{print $1}'`
-	echo "$top"
+	top -b -n 1 -p $1 | tail -2 | head -1 | awk 'print $9' | awk -F "." '{print $1}'
 }
 
 kill_all_pid()
@@ -424,7 +421,7 @@ case12 ()
 	wait $pid
 }
 
-max_shares=$((2**18))
+max_shares=$((1 << 18))
 
 # echo MAX_SHARES into shares
 case13 ()
@@ -589,7 +586,7 @@ case19()
 	echo "pid $pid cpu_usage $cpu_usage"
 
 	kill -9 $pid $pid_other
-	expr 96 \< "$cpu_usage" \& "$cpu_usage" \< 103 &> /dev/null || return 1
+	expr 96 \< "$cpu_usage" \& "$cpu_usage" \< 103 > /dev/null 2>&1 || return 1
 	return 0
 }
 
@@ -605,7 +602,7 @@ case20()
 	echo "pid $pid cpu_usage $cpu_usage"
 
 	kill -9 $pid $pid_other
-	expr 96 \< "$cpu_usage" \& "$cpu_usage" \< 103 &> /dev/null || return 1
+	expr 96 \< "$cpu_usage" \& "$cpu_usage" \< 103 > /dev/null 2>&1 || return 1
 	return 0
 }
 
@@ -615,7 +612,7 @@ case21()
 	pid=$(creat_process)
 	echo $pid > "$CPUCTL/1/tasks"
 
-	while ((1))
+	while true
 	do
 		creat_process > "$CPUCTL/1/2/tasks"
 		sleep 1
@@ -625,18 +622,20 @@ case21()
 	sleep 10
 	ret=0
 
-	for ((top_times=0; top_times<10 && ret==0; top_times++))
+	top_times=0
+	while [ "$top_times" -lt 10 -a "$ret" = 0 ]
 	do
 		cpu_usage=$(get_cpu_usage $pid)
 		echo "pid $pid cpu_usage $cpu_usage"
-		expr 44 \< "$cpu_usage" \& "$cpu_usage" \< 56 &> /dev/null
+		expr 44 \< "$cpu_usage" \& "$cpu_usage" \< 56 > /dev/null 2>&1
 		ret=$?
+		: $(( top_times+=1 ))
 	done
 
-	kill -9 $pid $loop_pid &> /dev/null
-	wait $pid $loop_pid &>/dev/null
+	kill -9 $pid $loop_pid > /dev/null 2>&1
+	wait $pid $loop_pid >/dev/null 2>&1
 	sleep 2
-	kill_all_pid < "$CPUCTL/1/2/tasks" &>/dev/null
+	kill_all_pid < "$CPUCTL/1/2/tasks"  >/dev/null 2>&1
 	sleep 2
 	return $ret
 }
@@ -645,7 +644,7 @@ case22()
 {
 	mkdir "$CPUCTL/1" "$CPUCTL/1/2"
 	pid=$(creat_process)
-	while ((1))
+	while true
 	do
 		echo $pid > "$CPUCTL/1/tasks"
 		echo $pid > "$CPUCTL/1/2/tasks"
@@ -656,26 +655,28 @@ case22()
 	sleep 10
 	ret=0
 
-	for ((top_times=0; top_times<10 && ret==0; top_times++))
+	top_times=0
+	while [ "$top_times" -lt 10 -a "$ret" = 0 ]
 	do
 		cpu_usage=$(get_cpu_usage $pid)
 		echo "pid $pid cpu_usage $cpu_usage"
-		expr 94 \< "$cpu_usage" \& "$cpu_usage" \< 106 &> /dev/null
+		expr 94 \< "$cpu_usage" \& "$cpu_usage" \< 106 > /dev/null 2>&1
 		ret=$?
+		: $(( top_times+=1 ))
 	done
 	
-	kill -9 $pid $loop_pid &> /dev/null
-	wait $pid $loop_pid &>/dev/null
+	kill -s KILL $pid $loop_pid > /dev/null 2>&1
+	wait $pid $loop_pid >/dev/null 2>&1
 	return $ret
 }
 
-rm -rf "$CPUCTL_TMP" &>/dev/null || exit 1
+rm -rf "$CPUCTL_TMP" >/dev/null 2>&1 || exit 1
 mkdir -p "$CPUCTL_TMP" || exit 1
 
 # test
 do_test ()
 {
-	for (( i=1; i<=$TST_TOTAL; i++ ))
+	for i in $(seq 1 $TST_TOTAL)
 	do
 		setup || {
 			tst_resm TFAIL "case$i    FAIL"
@@ -698,5 +699,5 @@ do_test ()
 
 do_test
 
-rm -rf "$CPUCTL_TMP" &>/dev/null
+rm -rf "$CPUCTL_TMP" >/dev/null 2>&1
 
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
index 0f11835..003af1c 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
@@ -536,8 +536,8 @@ do_mount()
 }
 
 # Run all the test cases
-for ((i = 1; i <= $TST_TOTAL; i++))
-{
+for i in $(seq 1 $TST_TOTAL)
+do
 	export TST_COUNT=$(( $TST_COUNT + 1 ))
 	cur_id=$i
 
@@ -556,7 +556,7 @@ for ((i = 1; i <= $TST_TOTAL; i++))
 	rmdir /dev/memcg/$i
 
 	cleanup;
-}
+done
 
 echo $shmmax > /proc/sys/kernel/shmmax
 
diff --git a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
index 86b8cb9..6c9cd75 100755
--- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
+++ b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
@@ -66,29 +66,29 @@ run_stress()
 {
 	do_mount;
 
-	for ((i = 0; i < $1; i++))
-	{
+	for i in $(seq 0 $(($1-1)))
+	do
 		mkdir /dev/memcg/$i 2> /dev/null
 		./memcg_process_stress $2 $3 &
 		pid[$i]=$!
 
 		echo ${pid[$i]} > /dev/memcg/$i/tasks
-	}
+	done
 
-	for ((i = 0; i < $1; i++))
-	{
+	for i in $(seq 0 $(($1-1)))
+	do
 		/bin/kill -s SIGUSR1 ${pid[$i]} 2> /dev/null
-	}
+	done
 
 	sleep $4
 
-	for ((i = 0; i < $1; i++))
-	{
+	for i in $(seq 0 $(($1-1)))
+	do
 		/bin/kill -s SIGINT ${pid[$i]} 2> /dev/null
 		wait ${pid[$i]}
 
 		rmdir /dev/memcg/$i 2> /dev/null
-	}
+	done
 
 	cleanup;
 }
diff --git a/testcases/kernel/fs/acls/acl_test01 b/testcases/kernel/fs/acls/acl_test01
index c892b0e..20cd1ac 100755
--- a/testcases/kernel/fs/acls/acl_test01
+++ b/testcases/kernel/fs/acls/acl_test01
@@ -51,7 +51,7 @@ if [ "z$iam" = "z$TEST_USER1" ]
 then
 	echo ""
 else
-if [ $UID != 0 ]
+if [ $(id -ru) != 0 ]
 then
         echo "FAILED: Must have root access to execute this script"
         exit 1
@@ -76,7 +76,7 @@ if [ $? != 0 ]
 then
         echo ""
         echo "FAILED:  [ losetup ] Must have loop device support by kernel"
-        echo -e "\t to execute this script"
+        printf "\t to execute this script\n"
         exit 1
 fi
 
@@ -90,8 +90,8 @@ then
         then
                 echo ""
                 echo "FAILED: [ mount ] Make sure that ACL (Access Control List)"
-                echo -e "\t and Extended Attribute are built into the kernel"
-                echo -e "\t Can not mount ext3 file system with acl and user_xattr options"
+                printf "\t and Extended Attribute are built into the kernel\n"
+                printf "\t Can not mount ext3 file system with acl and user_xattr options\n"
                 exit 1
         fi
 else
@@ -102,8 +102,8 @@ else
         then
                 echo ""
                 echo "FAILED: [ mount ] Make sure that ACL (Access Control List)"
-                echo -e "\t and Extended Attribute are built into the kernel"
-                echo -e "\t Can not mount ext2 file system with acl and user_xattr options"
+                printf "\t and Extended Attribute are built into the kernel\n"
+                printf "\t Can not mount ext2 file system with acl and user_xattr options\n"
                 exit 1
         fi
 fi
diff --git a/testcases/kernel/fs/fs-bench/modaltr.sh b/testcases/kernel/fs/fs-bench/modaltr.sh
index 85d2c30..36e6f0c 100755
--- a/testcases/kernel/fs/fs-bench/modaltr.sh
+++ b/testcases/kernel/fs/fs-bench/modaltr.sh
@@ -43,7 +43,7 @@ LOG_DIR1=/tmp/log1
 HOME_DIR=/home
 BLOCK_DIR=/dev/mtdblock
 export PATH=$PATH:/sbin
-	if [ $UID -ne 0 ]; 
+	if [ $(id -ru) -ne 0 ]; 
 then 
 	echo "must be root to run this"
 	exit
diff --git a/testcases/kernel/fs/fs_di/fs_di b/testcases/kernel/fs/fs_di/fs_di
index 54dd8b4..c6447ef 100755
--- a/testcases/kernel/fs/fs_di/fs_di
+++ b/testcases/kernel/fs/fs_di/fs_di
@@ -201,10 +201,10 @@ $trace_logic
 		end_testcase "Could not create testfile of size ${SIZE}Mb"
 	  fi
 	RANDOM_DEPTH=$RANDOM
-	let "RANDOM_DEPTH %= 500"
+	: $(( RANDOM_DEPTH %= 500 ))
 
 	RANDOM_LENGTH=$RANDOM
-	let "RANDOM_LENGTH %= 500"
+	: $(( RANDOM_LENGTH %= 500 ))
 	RANDOM_LENGTH=$(( $RANDOM_LENGTH / 10 ))
 
 	NameCount=0
diff --git a/testcases/kernel/fs/mongo/test.sh b/testcases/kernel/fs/mongo/test.sh
index fe75664..eccb079 100755
--- a/testcases/kernel/fs/mongo/test.sh
+++ b/testcases/kernel/fs/mongo/test.sh
@@ -26,7 +26,7 @@ TEST_DIR=testdir
 
 
    		#should be root  to execute this script .
-	if [ $UID -ne 0 ]; then
+	if [ $(id -ru) -ne 0 ]; then
 		echo "This script must be run as root"
 		exit
 	fi
@@ -52,8 +52,7 @@ modprobe loop
 	fi
 
 	#run the mongo test on reiserfs file system type 
-function reiserfs
-
+reiserfs()
 {
 cat > fs.sh <<EOF
 echo "performing mongo on reiserfs"
@@ -71,8 +70,7 @@ EOF
 	
 
 #To run on jfs file system type 
-function  JFS
-
+JFS()
 {
 cat >> fs.sh <<EOF
 echo "performing mongo on jfs file system"
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug02.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug02.sh
index 08e9301..7f1c5b1 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug02.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug02.sh
@@ -15,8 +15,8 @@ fi
 
 # Includes:
 LHCS_PATH=${LHCS_PATH:-".."}
-source $LHCS_PATH/include/testsuite.fns
-source $LHCS_PATH/include/hotplug.fns
+. $LHCS_PATH/include/testsuite.fns
+. $LHCS_PATH/include/hotplug.fns
 
 echo "Name:   $CASE"
 echo "Date:   `date`"
@@ -73,7 +73,7 @@ until [ $loop = 0 ]; do
     
     # Turn the CPU back online just to see what happens.
     online_cpu ${CPU_TO_TEST}
-    let "loop = loop - 1"
+    : $(( loop -= 1 ))
 done
 
 sleep 2
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug03.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug03.sh
index c550890..97d5205 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug03.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug03.sh
@@ -15,8 +15,8 @@ fi
 
 # Includes:
 LHCS_PATH=${LHCS_PATH:-".."}
-source $LHCS_PATH/include/testsuite.fns
-source $LHCS_PATH/include/hotplug.fns
+. $LHCS_PATH/include/testsuite.fns
+. $LHCS_PATH/include/hotplug.fns
 
 echo "Name:   $CASE"
 echo "Date:   `date`"
@@ -48,7 +48,7 @@ do_clean()
     # Turn off the CPUs that were off before the test start
     until [ $cpu = 0 ];do
         offline_cpu ${on[${cpu}]}
-        let "cpu = cpu - 1"
+        : $(( cpu -= 1 ))
     done
 }
 
@@ -60,10 +60,10 @@ until [ $loop = 0 ]; do
     for i in $( get_all_cpus ); do 
         online_cpu $1
         if [ $? = 0 ]; then
-            let "cpu = cpu + 1"
+            : $(( cpu += 1 ))
             on[${cpu}]=$i
         fi
-        let "number_of_cpus = number_of_cpus + 1"
+        : $(( number_of_cpus += 1 ))
     done
 
     offline_cpu ${CPU_TO_TEST}
@@ -76,11 +76,11 @@ until [ $loop = 0 ]; do
     # CPUs we have.  This is to help ensure we've got enough processes
     # that at least one will migrate to the new CPU.  Store the PIDs 
     # so we can kill them later.
-    let "number_of_cpus = number_of_cpus * 2"
+    : $(( number_of_cpus *= 2 ))
     until [ $number_of_cpus = 0 ]; do
         $LHCS_PATH/tools/do_spin_loop > /dev/null 2>&1 &
         echo $! >> /var/run/hotplug4_$$.pid
-        let "number_of_cpus = number_of_cpus - 1"
+        : $(( number_of_cpus -= 1 ))
     done
 
     ps aux | head -n 1
@@ -111,7 +111,7 @@ until [ $loop = 0 ]; do
 
     do_clean
 
-    let "loop = loop -1"
+    : $(( loop -=1 ))
 done
 
 exit_clean
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug04.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug04.sh
index b147286..00a634b 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug04.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug04.sh
@@ -9,8 +9,8 @@ loop=${HOTPLUG04_LOOPS:-1}
 
 # Includes:
 LHCS_PATH=${LHCS_PATH:-".."}
-source $LHCS_PATH/include/testsuite.fns
-source $LHCS_PATH/include/hotplug.fns
+. $LHCS_PATH/include/testsuite.fns
+. $LHCS_PATH/include/hotplug.fns
 
 echo "Name:   $CASE"
 echo "Date:   `date`"
@@ -26,7 +26,7 @@ until [ $loop = 0 ]; do
         online_cpu $i
         RC=$?
         if [ $RC != 0 ]; then
-            let "cpu = cpu + 1"
+            : $(( cpu += 1 ))
             on[${cpu}]=$i
             echo "${on[${cpu}]}"
         fi
@@ -51,7 +51,7 @@ until [ $loop = 0 ]; do
     # Online the ones that were on initially
     until [ $cpu = 0 ]; do
         online_cpu ${on[${cpu}]}
-        let "cpu = cpu - 1"
+        : $(( cpu -= 1 ))
     done
 
     # Return CPU 0 to its initial state
@@ -61,7 +61,7 @@ until [ $loop = 0 ]; do
         offline_cpu 0
     fi
 
-    let "loop = loop -1"
+    : $(( loop -=1 ))
 done
 
 exit_clean
\ No newline at end of file
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug06.sar.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug06.sar.sh
index d6f4601..aba658a 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug06.sar.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug06.sar.sh
@@ -15,8 +15,8 @@ fi
 
 # Includes:
 LHCS_PATH=${LHCS_PATH:-".."}
-source $LHCS_PATH/include/testsuite.fns
-source $LHCS_PATH/include/hotplug.fns
+. $LHCS_PATH/include/testsuite.fns
+. $LHCS_PATH/include/hotplug.fns
 
 echo "Name:   $CASE"
 echo "Date:   `date`"
@@ -81,7 +81,7 @@ until [ $loop = 0 ]; do
 
     # Check that SAR registered the change in CPU online/offline states
     NEW_NUMBER_CPU_OFF=`cat /tmp/log_$$ | grep ${time} | grep -i nan | wc -l`
-    let "NUMBER_CPU_OFF = NUMBER_CPU_OFF - 1"
+    : $(( NUMBER_CPU_OFF -= 1 ))
     if [ $NUMBER_CPU_OFF = $NEW_NUMBER_CPU_OFF ]; then
         echo "$CASE     PASS: CPU was found after turned on."
     else
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug06.top.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug06.top.sh
index a9bf17e..f9efe2a 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug06.top.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug06.top.sh
@@ -15,8 +15,8 @@ fi
 
 # Includes:
 LHCS_PATH=${LHCS_PATH:-".."}
-source $LHCS_PATH/include/testsuite.fns
-source $LHCS_PATH/include/hotplug.fns
+. $LHCS_PATH/include/testsuite.fns
+. $LHCS_PATH/include/hotplug.fns
 
 echo "Name:   $CASE"
 echo "Date:   `date`"
@@ -76,7 +76,7 @@ until [ $loop = 0 ]; do
         exit_clean -1
     fi
 
-    let "loop = loop - 1"
+    : $(( loop -= 1 ))
 
 done
 
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug07.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug07.sh
index d57c561..8f5ca44 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug07.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/hotplug07.sh
@@ -11,8 +11,8 @@ loop_one=${HOTPLUG07_LOOPS:-1}
 
 # Includes:
 LHCS_PATH=${LHCS_PATH:-".."}
-source $LHCS_PATH/include/testsuite.fns
-source $LHCS_PATH/include/hotplug.fns
+. $LHCS_PATH/include/testsuite.fns
+. $LHCS_PATH/include/hotplug.fns
 
 echo "Name:   HotPlug Test - Test Case 7"
 echo "Date:   `date`"
@@ -89,7 +89,7 @@ do
   RC=$?
   echo "Onlining cpu${CPU_TO_TEST}: Return Code = ${RC}"
 
-  let "loop_one = loop_one - 1"
+  : $(( loop_one -= 1 ))
 
 done
 
diff --git a/testcases/network/can/filter-tests/run_ltp-can_tests.sh b/testcases/network/can/filter-tests/run_ltp-can_tests.sh
index aefcbe1..6d7aafc 100644
--- a/testcases/network/can/filter-tests/run_ltp-can_tests.sh
+++ b/testcases/network/can/filter-tests/run_ltp-can_tests.sh
@@ -19,7 +19,7 @@
 ##                                                                            ##
 ################################################################################
 
-if [ $UID -ne 0 ]; then
+if [ $(id -ru) -ne 0 ]; then
      echo You need to be root to execute these tests
      exit 1
 fi
diff --git a/testcases/network/tcp_cmds/netstat/netstat01 b/testcases/network/tcp_cmds/netstat/netstat01
index 1cf0d9d..f0b2462 100755
--- a/testcases/network/tcp_cmds/netstat/netstat01
+++ b/testcases/network/tcp_cmds/netstat/netstat01
@@ -77,7 +77,7 @@ do_test() {
    do
       for COMMAND in "netstat -s" "netstat -rn" "netstat -i" "netstat -gn" "netstat -apn"
       do
-         $COMMAND 2>&1 1>/dev/null
+         $COMMAND 1>/dev/null 2>&1
          [ $? -eq 0 ] || end_testcase "$COMMAND failed" 
       done
 
-- 
1.6.4.3




------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
