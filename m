From: Cedric Hnyda <chnyda@suse.com>
Date: Thu, 12 Nov 2015 16:26:36 +0100
Subject: [LTP]  [PATCH v3] cgroup_fj: testcases
Message-ID: <1447341996-26923-1-git-send-email-chnyda@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Removed irrelevant testcases and the code handling them
1) Removed testcases with "all", it is irrelevant to mount all
cgroups when some are already mounted and it is not possible to
mount them several times in newer kernel.
2) Removed "none" testcases. Cannot find what -onone is supposed
to do when cgroups are mounted. Maybe the author confused with
	"mount -t cgroup none /cgroups"

Signed-off-by: Cedric Hnyda <chnyda@suse.com>
---
 runtest/controllers                                  | 11 -----------
 .../controllers/cgroup_fj/cgroup_fj_function.sh      |  6 ++----
 .../kernel/controllers/cgroup_fj/cgroup_fj_stress.sh | 20 +++++++-------------
 .../controllers/cgroup_fj/cgroup_fj_utility.sh       |  5 -----
 4 files changed, 9 insertions(+), 33 deletions(-)

diff --git a/runtest/controllers b/runtest/controllers
index 52f2457..4043caa 100644
--- a/runtest/controllers
+++ b/runtest/controllers
@@ -66,16 +66,6 @@ cgroup_fj_function_memory_yes_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function m
 cgroup_fj_function_memory_yes_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function memory yes yes 6 yes 2 3 2 1
 cgroup_fj_function_memory_yes_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function memory yes yes 7 yes 2 3 2 1
 cgroup_fj_function_memory_yes_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function memory yes yes 8 yes 2 3 2 1
-cgroup_fj_function_all_yes_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function all yes yes 1 yes 2 3 2 1
-cgroup_fj_function_all_no_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function all no yes 1 yes 2 3 2 1
-cgroup_fj_function_all_yes_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function all yes yes 2 yes 2 3 2 1
-cgroup_fj_function_all_yes_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function all yes yes 3 yes 2 3 2 1
-cgroup_fj_function_all_yes_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function all yes yes 4 yes 2 3 2 1
-cgroup_fj_function_all_yes_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function all yes yes 5 yes 2 3 2 1
-cgroup_fj_function_all_yes_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function all yes yes 6 yes 2 3 2 1
-cgroup_fj_function_all_yes_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function all yes yes 7 yes 2 3 2 1
-cgroup_fj_function_all_yes_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function all yes yes 8 yes 2 3 2 1
-cgroup_fj_function_none_yes_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function none yes yes 1 yes 2 3 2 1
 cgroup_fj_function_debug,debug_yes_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function debug,debug yes yes 1 yes 2 3 2 1
 cgroup_fj_function_debug,debug_no_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function debug,debug no yes 1 yes 2 3 2 1
 cgroup_fj_function_debug,debug_yes_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function debug,debug yes yes 2 yes 2 3 2 1
@@ -164,7 +154,6 @@ cgroup_fj_stress_ns_100_1_1_1 run_cgroup_test_fj.sh stress ns 100 1 1 1
 cgroup_fj_stress_cpu_100_1_1_1 run_cgroup_test_fj.sh stress cpu 100 1 1 1
 cgroup_fj_stress_cpuacct_100_1_1_1 run_cgroup_test_fj.sh stress cpuacct 100 1 1 1
 cgroup_fj_stress_memory_100_1_1_1 run_cgroup_test_fj.sh stress memory 100 1 1 1
-cgroup_fj_stress_all_100_1_1_1 run_cgroup_test_fj.sh stress all 100 1 1 1
 cgroup_fj_stress_debug_1_1_1_2 run_cgroup_test_fj.sh stress debug 1 1 1 2
 cgroup_fj_stress_debug_1_1_100_1 run_cgroup_test_fj.sh stress debug 1 1 100 1
 cgroup_fj_stress_debug_1_1_100_2 run_cgroup_test_fj.sh stress debug 1 1 100 2
diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
index 7c4c997..76b8ad6 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
@@ -61,8 +61,6 @@ usage()
 	echo "      cpu"
 	echo "      cpuacct"
 	echo "      memory"
-	echo "      all"
-	echo "      none: (none)"
 	echo "      debug,debug: debug,debug"
 	echo "      nonexistent: (nonexistent subsystem), e.g. abc"
 	echo "      freezer: freezer"
@@ -147,7 +145,7 @@ mkdir_subgroup;
 
 # cpuset.cpus and cpuset.mems should be specified with suitable value
 # before attaching operation if subsystem is cpuset
-if [ "$subsystem" == "cpuset" ] || [ "$subsystem" == "all" ] || [ "$subsystem" == "none" ] ; then
+if [ "$subsystem" == "cpuset" ]; then
 	exist=`grep -w cpuset /proc/cgroups | cut -f1`;
 	if [ "$exist" != "" ]; then
 		if [ "$noprefix_use" == "no" ]; then
@@ -224,7 +222,7 @@ sleep 1
 
 # pid could not be echoed from subgroup if subsystem is ( or include ) ns,
 # so we kill them here
-if [ "$subsystem" == "ns" ] || [ "$subsystem" == "all" ] || [ "$subsystem" == "none" ] ; then
+if [ "$subsystem" == "ns" ]; then
 	do_kill 1 1 9 $pid
 	do_kill 1 1 9 $pid2
 # removing operation
diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
index 2650cb4..04c4e2a 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
@@ -28,7 +28,6 @@ subsystem=$1			# 1: debug
 				# 4: cpu
 				# 5: cpuacct
 				# 6: memory
-				# 7: all
 mount_times=$2			#1: execute once
 				#2: execute 100 times
 subgroup_num=$3			#subgroup number in the same hierarchy
@@ -53,7 +52,6 @@ usage()
 	echo "      cpu"
 	echo "      cpuacct"
 	echo "      memory"
-	echo "      all"
 	echo "    mount_times's usable number"
 	echo "      1: execute once"
 	echo "      100: execute 100 times"
@@ -146,11 +144,7 @@ case $subgroup_hiers in
 esac
 
 ##########################  main   #######################
-
-if ! [ "$subsystem" == "all" ] && ! [ "$subsystem" == "none" ] ; then
-	exist_subsystem;
-fi
-
+exist_subsystem;
 setup;
 
 $TESTROOT/cgroup_fj_proc &
@@ -160,7 +154,7 @@ cpus=0
 mems=0
 exist_cpuset=0
 exist_cpuset=`grep -w cpuset /proc/cgroups | cut -f1`;
-if [ "$subsystem" == "cpuset" ] || [ "$subsystem" == "all" ] ; then
+if [ "$subsystem" == "cpuset" ]; then
 	if [ "$exist_cpuset" != "" ]; then
 		cpus=`cat $mount_point/cpuset.cpus`
 		mems=`cat $mount_point/cpuset.mems`
@@ -171,7 +165,7 @@ mkdir_subgroup;
 
 # cpuset.cpus and cpuset.mems should be specified with suitable value
 # before attachint operation if subsystem is cpuset
-if [ "$subsystem" == "cpuset" ] || [ "$subsystem" == "all" ] ; then
+if [ "$subsystem" == "cpuset" ]; then
 	if [ "$exist_cpuset" != "" ]; then
 		do_echo 1 1 "$cpus" $mount_point/ltp_subgroup_1/cpuset.cpus;
 		do_echo 1 1 "$mems" $mount_point/ltp_subgroup_1/cpuset.mems;
@@ -183,7 +177,7 @@ if [ $mount_times -ne 1 ]; then
 	for i in `seq 1 $mount_times`
 	do
 		do_echo 1 1 $pid $mount_point/ltp_subgroup_1/tasks
-		if [ "$subsystem" == "ns" ] || [ "$subsystem" == "all" ] ; then
+		if [ "$subsystem" == "ns" ]; then
 			do_kill 1 1 9 $pid
 			$TESTROOT/cgroup_fj_proc &
 			pid=$!
@@ -197,7 +191,7 @@ if [ $mount_times -ne 1 ]; then
 			mount_cgroup;
 		fi
 		mkdir_subgroup;
-		if [ "$subsystem" == "cpuset" ] || [ "$subsystem" == "all" ] ; then
+		if [ "$subsystem" == "cpuset" ]; then
 			if [ "$exist_cpuset" != "" ]; then
 				do_echo 1 1 "$cpus" $mount_point/ltp_subgroup_1/cpuset.cpus;
 				do_echo 1 1 "$mems" $mount_point/ltp_subgroup_1/cpuset.mems;
@@ -215,7 +209,7 @@ else
 	do
 		get_subgroup_path1 $i
 		do_mkdir 1 1 $cur_subgroup_path1
-		if [ "$subsystem" == "cpuset" ] || [ "$subsystem" == "all" ] ; then
+		if [ "$subsystem" == "cpuset" ]; then
 			if [ "$exist_cpuset" != "" ]; then
 				do_echo 1 1 "$cpus" "$cur_subgroup_path1""cpuset.cpus";
 				do_echo 1 1 "$mems" "$cur_subgroup_path1""cpuset.mems";
@@ -227,7 +221,7 @@ else
 		do
 			get_subgroup_path2 $j
 			do_mkdir 1 1 "$cur_subgroup_path1""$cur_subgroup_path2" 1
-			if [ "$subsystem" == "cpuset" ] || [ "$subsystem" == "all" ] ; then
+			if [ "$subsystem" == "cpuset" ]; then
 				if [ "$exist_cpuset" != "" ]; then
 					do_echo 1 1 "$cpus" "$cur_subgroup_path1""$cur_subgroup_path2""cpuset.cpus";
 					do_echo 1 1 "$mems" "$cur_subgroup_path1""$cur_subgroup_path2""cpuset.mems";
diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
index b4e747c..2ec376d 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
@@ -77,11 +77,6 @@ get_subsystem()
 	"memory" )
 		exist_subsystem;
 		;;
-	"all" )
-		;;
-	"none" )
-		subsystem=""
-		;;
 	"debug,debug" )
 		exist_subsystem "debug";
 		;;
-- 
2.1.4

