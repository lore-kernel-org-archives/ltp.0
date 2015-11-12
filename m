From: Cedric Hnyda <chnyda@suse.com>
Date: Thu, 12 Nov 2015 09:30:43 +0100
Subject: [LTP]  [PATCH V2] cgroup_fj: function2
Message-ID: <1447317043-13997-1-git-send-email-chnyda@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Check if the cgroup exists. The cgroup
will be mounted (and umounted) only if it doesn't exist at
the start of the test.
Removed testcases 3-6 because they tested a no longer supported
feature.
Renamed testcases 6-13 to 3-9 (ie: testcase 3 = former testcase 7)
Add tests for every subsystem instead of only debug except for
testcases 1 & 2 which are specific for debug and cpuset.

Signed-off-by: Cedric Hnyda <chnyda@suse.com>
---
 runtest/controllers                                |  73 ++++++--
 .../controllers/cgroup_fj/cgroup_fj_function2.sh   | 204 +++++----------------
 2 files changed, 104 insertions(+), 173 deletions(-)

diff --git a/runtest/controllers b/runtest/controllers
index 52f2457..c62bcce 100644
--- a/runtest/controllers
+++ b/runtest/controllers
@@ -145,19 +145,66 @@ cgroup_fj_function_debug_yes_yes_3_yes_2_3_4_2 run_cgroup_test_fj.sh function de
 cgroup_fj_function_debug_yes_yes_3_yes_2_3_5_2 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 5 2
 cgroup_fj_function_debug_yes_yes_3_yes_2_3_6_2 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 6 2
 cgroup_fj_function_debug_yes_yes_3_yes_2_3_7_2 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 7 2
-cgroup_fj_function2_1 run_cgroup_test_fj.sh function2 1
-cgroup_fj_function2_2 run_cgroup_test_fj.sh function2 2
-cgroup_fj_function2_3 run_cgroup_test_fj.sh function2 3
-cgroup_fj_function2_4 run_cgroup_test_fj.sh function2 4
-cgroup_fj_function2_5 run_cgroup_test_fj.sh function2 5
-cgroup_fj_function2_6 run_cgroup_test_fj.sh function2 6
-cgroup_fj_function2_7 run_cgroup_test_fj.sh function2 7
-cgroup_fj_function2_8 run_cgroup_test_fj.sh function2 8
-cgroup_fj_function2_9 run_cgroup_test_fj.sh function2 9
-cgroup_fj_function2_10 run_cgroup_test_fj.sh function2 10
-cgroup_fj_function2_11 run_cgroup_test_fj.sh function2 11
-cgroup_fj_function2_12 run_cgroup_test_fj.sh function2 12
-cgroup_fj_function2_13 run_cgroup_test_fj.sh function2 13
+cgroup_fj_function2_1_debug run_cgroup_test_fj.sh function2 1 debug
+cgroup_fj_function2_1_cpuset run_cgroup_test_fj.sh function2 1 cpuset
+cgroup_fj_function2_2_debug run_cgroup_test_fj.sh function2 2 debug
+cgroup_fj_function2_2_cpuset run_cgroup_test_fj.sh function2 2 cpuset
+cgroup_fj_function2_3_debug run_cgroup_test_fj.sh function2 3 debug
+cgroup_fj_function2_3_cpuset run_cgroup_test_fj.sh function2 3 cpuset
+cgroup_fj_function2_3_ns run_cgroup_test_fj.sh function2 3 ns
+cgroup_fj_function2_3_cpu run_cgroup_test_fj.sh function2 3 cpu
+cgroup_fj_function2_3_cpuacct run_cgroup_test_fj.sh function2 3 cpuacct
+cgroup_fj_function2_3_memory run_cgroup_test_fj.sh function2 3 memory
+cgroup_fj_function2_3_freezer run_cgroup_test_fj.sh function2 3 freezer
+cgroup_fj_function2_3_devices run_cgroup_test_fj.sh function2 3 devices
+cgroup_fj_function2_4_debug run_cgroup_test_fj.sh function2 4 debug
+cgroup_fj_function2_4_cpuset run_cgroup_test_fj.sh function2 4 cpuset
+cgroup_fj_function2_4_ns run_cgroup_test_fj.sh function2 4 ns
+cgroup_fj_function2_4_cpu run_cgroup_test_fj.sh function2 4 cpu
+cgroup_fj_function2_4_cpuacct run_cgroup_test_fj.sh function2 4 cpuacct
+cgroup_fj_function2_4_memory run_cgroup_test_fj.sh function2 4 memory
+cgroup_fj_function2_4_freezer run_cgroup_test_fj.sh function2 4 freezer
+cgroup_fj_function2_4_devices run_cgroup_test_fj.sh function2 4 devices
+cgroup_fj_function2_5_debug run_cgroup_test_fj.sh function2 5 debug
+cgroup_fj_function2_5_cpuset run_cgroup_test_fj.sh function2 5 cpuset
+cgroup_fj_function2_5_ns run_cgroup_test_fj.sh function2 5 ns
+cgroup_fj_function2_5_cpu run_cgroup_test_fj.sh function2 5 cpu
+cgroup_fj_function2_5_cpuacct run_cgroup_test_fj.sh function2 5 cpuacct
+cgroup_fj_function2_5_memory run_cgroup_test_fj.sh function2 5 memory
+cgroup_fj_function2_5_freezer run_cgroup_test_fj.sh function2 5 freezer
+cgroup_fj_function2_5_devices run_cgroup_test_fj.sh function2 5 devices
+cgroup_fj_function2_6_debug run_cgroup_test_fj.sh function2 6 debug
+cgroup_fj_function2_6_cpuset run_cgroup_test_fj.sh function2 6 cpuset
+cgroup_fj_function2_6_ns run_cgroup_test_fj.sh function2 6 ns
+cgroup_fj_function2_6_cpu run_cgroup_test_fj.sh function2 6 cpu
+cgroup_fj_function2_6_cpuacct run_cgroup_test_fj.sh function2 6 cpuacct
+cgroup_fj_function2_6_memory run_cgroup_test_fj.sh function2 6 memory
+cgroup_fj_function2_6_freezer run_cgroup_test_fj.sh function2 6 freezer
+cgroup_fj_function2_6_devices run_cgroup_test_fj.sh function2 6 devices
+cgroup_fj_function2_7_debug run_cgroup_test_fj.sh function2 7 debug
+cgroup_fj_function2_7_cpuset run_cgroup_test_fj.sh function2 7 cpuset
+cgroup_fj_function2_7_ns run_cgroup_test_fj.sh function2 7 ns
+cgroup_fj_function2_7_cpu run_cgroup_test_fj.sh function2 7 cpu
+cgroup_fj_function2_7_cpuacct run_cgroup_test_fj.sh function2 7 cpuacct
+cgroup_fj_function2_7_memory run_cgroup_test_fj.sh function2 7 memory
+cgroup_fj_function2_7_freezer run_cgroup_test_fj.sh function2 7 freezer
+cgroup_fj_function2_7_devices run_cgroup_test_fj.sh function2 7 devices
+cgroup_fj_function2_8_debug run_cgroup_test_fj.sh function2 8 debug
+cgroup_fj_function2_8_cpuset run_cgroup_test_fj.sh function2 8 cpuset
+cgroup_fj_function2_8_ns run_cgroup_test_fj.sh function2 8 ns
+cgroup_fj_function2_8_cpu run_cgroup_test_fj.sh function2 8 cpu
+cgroup_fj_function2_8_cpuacct run_cgroup_test_fj.sh function2 8 cpuacct
+cgroup_fj_function2_8_memory run_cgroup_test_fj.sh function2 8 memory
+cgroup_fj_function2_8_freezer run_cgroup_test_fj.sh function2 8 freezer
+cgroup_fj_function2_8_devices run_cgroup_test_fj.sh function2 8 devices
+cgroup_fj_function2_9_debug run_cgroup_test_fj.sh function2 9 debug
+cgroup_fj_function2_9_cpuset run_cgroup_test_fj.sh function2 9 cpuset
+cgroup_fj_function2_9_ns run_cgroup_test_fj.sh function2 9 ns
+cgroup_fj_function2_9_cpu run_cgroup_test_fj.sh function2 9 cpu
+cgroup_fj_function2_9_cpuacct run_cgroup_test_fj.sh function2 9 cpuacct
+cgroup_fj_function2_9_memory run_cgroup_test_fj.sh function2 9 memory
+cgroup_fj_function2_9_freezer run_cgroup_test_fj.sh function2 9 freezer
+cgroup_fj_function2_9_devices run_cgroup_test_fj.sh function2 9 devices
 cgroup_fj_stress_debug_100_1_1_1 run_cgroup_test_fj.sh stress debug 100 1 1 1
 cgroup_fj_stress_cpuset_100_1_1_1 run_cgroup_test_fj.sh stress cpuset 100 1 1 1
 cgroup_fj_stress_ns_100_1_1_1 run_cgroup_test_fj.sh stress ns 100 1 1 1
diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function2.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function2.sh
index 68d290b..5b8f7d8 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function2.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function2.sh
@@ -15,22 +15,23 @@
 ## for more details.                                                          ##
 ##                                                                            ##
 ## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
+## along with this program;  if not, write to the Free Software Foundation,   ##
+## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
 ##                                                                            ##
 ## Author: Shi Weihua <shiwh@cn.fujitsu.com>                                  ##
 ##                                                                            ##
 ################################################################################
 
 caseno=$1
+subsystem=$2
 pid=0;
-subsystem=1;
 release_agent_para=1;
 release_agent_echo=1;
 subsystem_str="debug";
 remount_use_str="";
 noprefix_use_str="";
 release_agent_para_str="";
+mounted=1
 
 # not output debug info when stress test
 no_debug=0
@@ -38,9 +39,9 @@ no_debug=0
 usage()
 {
 	echo "usage of cgroup_fj_function2.sh: "
-	echo "  ./cgroup_fj_function2.sh -case number[1-13]"
-	echo "example: ./cgroup_fj_function2.sh 1"
-	echo "  will test the 1st case"
+	echo "  ./cgroup_fj_function2.sh -case number[1-13] -subsystem"
+	echo "example: ./cgroup_fj_function2.sh 1 cpuset"
+	echo "  will test the 1st case with cpuset"
 }
 
 exit_parameter()
@@ -56,122 +57,74 @@ export TMPFILE=$TESTROOT/tmp_tasks
 
 case1()
 {
-	do_mkdir 1 1 /dev/cgroup/subgroup_2
+	do_mkdir 1 1 $mount_point/ltp_subgroup_2
 
-	do_echo 1 0 $pid /dev/cgroup/subgroup_1/tasks
+	do_echo 1 0 $pid $mount_point/ltp_subgroup_1/tasks
 	sleep 1
-	do_echo 1 0 $pid /dev/cgroup/subgroup_2/tasks
+	do_echo 1 0 $pid $mount_point/ltp_subgroup_2/tasks
 	sleep 1
-	do_echo 1 1 $pid /dev/cgroup/tasks
+	do_echo 1 1 $pid $mount_point/tasks
 }
 
 case2()
 {
-	do_mkdir 1 1 /dev/cgroup/subgroup_2
+	do_mkdir 1 1 $mount_point/ltp_subgroup_2
 
 	$TESTROOT/cgroup_fj_proc &
 	pid2=$!
 	sleep 1
 
-	cat /dev/cgroup/tasks > $TMPFILE
+	cat $mount_point/tasks > $TMPFILE
 	nlines=`cat $TMPFILE | wc -l`
 	for i in `seq 1 $nlines`
 	do
 		cur_pid=`sed -n "$i""p" $TMPFILE`
 		if [ -e /proc/$cur_pid/ ];then
-			do_echo 1 0 "$cur_pid" /dev/cgroup/subgroup_1/tasks
+			do_echo 1 0 "$cur_pid" $mount_point/ltp_subgroup_1/tasks
 		fi
 	done
 
 	sleep 1
 
-	cat /dev/cgroup/subgroup_1/tasks > $TMPFILE
+	cat $mount_point/ltp_subgroup_1/tasks > $TMPFILE
 	nlines=`cat $TMPFILE | wc -l`
 	for i in `seq 1 $nlines`
 	do
 		cur_pid=`sed -n "$i""p" $TMPFILE`
 		if [ -e /proc/$cur_pid/ ];then
-			do_echo 1 0 "$cur_pid" /dev/cgroup/subgroup_2/tasks
+			do_echo 1 0 "$cur_pid" $mount_point/ltp_subgroup_2/tasks
 		fi
 	done
 
 	sleep 1
 
-	cat /dev/cgroup/subgroup_2/tasks > $TMPFILE
+	cat $mount_point/ltp_subgroup_2/tasks > $TMPFILE
 	nlines=`cat $TMPFILE | wc -l`
 	for i in `seq 1 $nlines`
 	do
 		cur_pid=`sed -n "$i""p" $TMPFILE`
 		if [ -e /proc/$cur_pid/ ];then
-			do_echo 1 1 "$cur_pid" /dev/cgroup/tasks
+			do_echo 1 1 "$cur_pid" $mount_point/tasks
 		fi
 	done
 }
 
 case3()
 {
-	exist_subsystem "cpuset"
-	exist_subsystem "ns"
-	do_mount 1 1 "-odebug,cpuset,ns" /dev/cgroup cgroup1
+	do_mkdir 0 1 $mount_point/ltp_subgroup_2
 
-	mount_str="`mount -l | grep /dev/cgroup2`"
-	if [ "$mount_str" != "" ]; then
-		do_umount 0 1 /dev/cgroup2
-	fi
-
-	if [ -e /dev/cgroup2 ]; then
-		do_rmdir 1 1 /dev/cgroup2
-	fi
-
-	do_mkdir 1 1 /dev/cgroup2
-
-	exist_subsystem "cpu"
-	exist_subsystem "cpuacct"
-	exist_subsystem "memory"
-	do_mount 1 1 "-ocpu,cpuacct,memory" /dev/cgroup2 cgroup2
-
-	sleep 1
-
-	do_umount 0 1 /dev/cgroup
-	do_rmdir 0 1 /dev/cgroup
-	do_umount 0 1 /dev/cgroup2
-	do_rmdir 0 1 /dev/cgroup2
+	do_mv 0 1 $mount_point/ltp_subgroup_1 $mount_point/ltp_subgroup_3
 }
 
 case4()
 {
-	exist_subsystem "cpuset"
-	exist_subsystem "ns"
-	do_mount 1 1 "-odebug,cpuset,ns" /dev/cgroup cgroup1
-
-	mount_str="`mount -l | grep /dev/cgroup2`"
-	if [ "$mount_str" != "" ]; then
-		do_umount 1 1 /dev/cgroup2
-	fi
-
-	if [ -e /dev/cgroup2 ]; then
-		do_rmdir 0 1 /dev/cgroup2
-	fi
+	do_mkdir 0 1 $mount_point/ltp_subgroup_2
 
-	do_mkdir 0 1 /dev/cgroup2
-
-	do_mount 1 1 "-odebug,cpuset,ns" /dev/cgroup2 cgroup2
-
-	sleep 1
-
-	do_umount 0 1 /dev/cgroup
-	do_rmdir 0 1 /dev/cgroup
-	do_umount 0 1 /dev/cgroup2
-	do_rmdir 0 1 /dev/cgroup2
+	do_mv 0 0 $mount_point/ltp_subgroup_1 $mount_point/ltp_subgroup_2
 }
 
 case5()
 {
-	exist_subsystem "cpuset"
-	exist_subsystem "ns"
-	exist_subsystem "memory"
-	do_mount 1 1 "-odebug,cpuset,ns" /dev/cgroup cgroup1
-
 	mount_str="`mount -l | grep /dev/cgroup2`"
 	if [ "$mount_str" != "" ]; then
 		do_umount 1 1 /dev/cgroup2
@@ -183,138 +136,69 @@ case5()
 
 	do_mkdir 0 1 /dev/cgroup2
 
-	do_mount 0 1 "-odebug,cpuset,memory" /dev/cgroup2 cgroup2
+	do_mkdir 0 1 /dev/cgroup2/ltp_subgroup_2
+
+	do_mv 0 1 $mount_point/ltp_subgroup_1 $mount_point/ltp_subgroup_2
 
 	sleep 1
 
-	do_umount 0 1 /dev/cgroup
-	do_rmdir 0 1 /dev/cgroup
-	do_umount 0 1 /dev/cgroup2
+	do_rmdir 0 1 /dev/cgroup2/ltp_subgroup_2
 	do_rmdir 0 1 /dev/cgroup2
 }
 
 case6()
 {
-	exist_subsystem "debug"
-	exist_subsystem "cpuset"
-	exist_subsystem "ns"
-	do_mount 1 1 "-odebug,cpuset,ns" /dev/cgroup cgroup1
+	do_mkdir 0 1 $mount_point/ltp_subgroup_2
 
-	mount_str="`mount -l | grep /dev/cgroup2`"
-	if [ "$mount_str" != "" ]; then
-		do_umount 1 1 /dev/cgroup2
-	fi
-
-	if [ -e /dev/cgroup2 ]; then
-		do_rmdir 0 1 /dev/cgroup2
-	fi
-
-	do_mkdir 0 1 /dev/cgroup2
-
-	do_mount 0 1 "-oall" /dev/cgroup2 cgroup2
-
-	sleep 1
-
-	do_umount 0 1 /dev/cgroup
-	do_rmdir 0 1 /dev/cgroup
-	do_umount 0 1 /dev/cgroup2
-	do_rmdir 0 1 /dev/cgroup2
+	do_mv 0 0 $mount_point/ltp_subgroup_1 $mount_point/tasks
 }
 
 case7()
 {
-	do_mkdir 0 1 /dev/cgroup/subgroup_2
-
-	do_mv 0 1 /dev/cgroup/subgroup_1 /dev/cgroup/subgroup_3
-}
-
-case8()
-{
-	do_mkdir 0 1 /dev/cgroup/subgroup_2
-
-	do_mv 0 0 /dev/cgroup/subgroup_1 /dev/cgroup/subgroup_2
-}
-
-case9()
-{
-	mount_str="`mount -l | grep /dev/cgroup2`"
-	if [ "$mount_str" != "" ]; then
-		do_umount 1 1 /dev/cgroup2
-	fi
-
-	if [ -e /dev/cgroup2 ]; then
-		do_rmdir 0 1 /dev/cgroup2
-	fi
-
-	do_mkdir 0 1 /dev/cgroup2
-
-	do_mkdir 0 1 /dev/cgroup2/subgroup_2
-
-	do_mv 0 1 /dev/cgroup/subgroup_1 /dev/cgroup/subgroup_2
-
-	sleep 1
-
-	do_rmdir 0 1 /dev/cgroup2/subgroup_2
-	do_rmdir 0 1 /dev/cgroup2
-}
-
-case10()
-{
-	do_mkdir 0 1 /dev/cgroup/subgroup_2
-
-	do_mv 0 0 /dev/cgroup/subgroup_1 /dev/cgroup/tasks
-}
-
-case11()
-{
-	do_echo 0 1 $pid /dev/cgroup/subgroup_1/tasks
+	do_echo 0 1 $pid $mount_point/ltp_subgroup_1/tasks
 
 	sleep 1
 
-	do_rmdir 0 0 /dev/cgroup/subgroup_1
+	do_rmdir 0 0 $mount_point/ltp_subgroup_1
 
 	sleep 1
 
-	do_echo 1 1 $pid /dev/cgroup/tasks
+	do_echo 1 1 $pid $mount_point/tasks
 }
 
-case12()
+case8()
 {
-	do_mkdir 0 1 /dev/cgroup/subgroup_1/subgroup_1_1
+	do_mkdir 0 1 $mount_point/ltp_subgroup_1/ltp_subgroup_1_1
 
 	sleep 1
 
-	do_rmdir 0 0 /dev/cgroup/subgroup_1
+	do_rmdir 0 0 $mount_point/ltp_subgroup_1
 
-	do_rmdir 1 1 /dev/cgroup/subgroup_1/subgroup_1_1
+	do_rmdir 1 1 $mount_point/ltp_subgroup_1/ltp_subgroup_1_1
 }
 
-case13()
+case9()
 {
-	do_rmdir 0 1 /dev/cgroup/subgroup_1
+	do_rmdir 0 1 $mount_point/ltp_subgroup_1
 }
 
 ##########################  main   #######################
-if [ "$#" -ne "1" ] || [ $caseno -lt 1 ] || [ $caseno -gt 13 ]; then
+if [ "$#" -ne "2" ] || [ $caseno -lt 1 ] || [ $caseno -gt 9 ]; then
 	usage;
 	exit_parameter;
 fi
 
-exist_subsystem "debug"
+exist_subsystem $subsystem
+
 setup;
 
-if [ $caseno -lt 3 ] || [ $caseno -gt 6 ]; then
-	mount_cgroup;
-	$TESTROOT/cgroup_fj_proc &
-	pid=$!
-	mkdir_subgroup;
-fi
+$TESTROOT/cgroup_fj_proc &
+pid=$!
+mkdir_subgroup;
 
 case$caseno
 
 cleanup;
-if [ $caseno -lt 3 ] || [ $caseno -gt 6 ]; then
-	do_kill 1 1 9 $pid
-fi
+do_kill 1 1 9 $pid
 sleep 1
 exit 0;
-- 
2.1.4

