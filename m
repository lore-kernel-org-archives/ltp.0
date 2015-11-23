From: Cedric Hnyda <chnyda@suse.com>
Date: Mon, 23 Nov 2015 11:52:16 +0100
Subject: [LTP]  [PATCH] controllers/cgroup_fj: add tests
Message-ID: <1448275936-24828-1-git-send-email-chnyda@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add tests for controllers which were not tested:
 - blkio, hugetlb, pids, net_cls, net_prio, devices and freezer
Modify cgroup_fj_utility.sh to test more controllers.
Update the description of cgroup_fj_function.sh and
cgroup_fj_stress.sh

Signed-off-by: Cedric Hnyda <chnyda@suse.com>
---
 runtest/controllers                                | 101 +++++++++++++++++++++
 .../controllers/cgroup_fj/cgroup_fj_function.sh    |   9 +-
 .../controllers/cgroup_fj/cgroup_fj_stress.sh      |   7 ++
 .../controllers/cgroup_fj/cgroup_fj_utility.sh     |  26 +-----
 4 files changed, 116 insertions(+), 27 deletions(-)

diff --git a/runtest/controllers b/runtest/controllers
index 4043caa..96b5a95 100644
--- a/runtest/controllers
+++ b/runtest/controllers
@@ -94,6 +94,51 @@ cgroup_fj_function_devices_yes_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function
 cgroup_fj_function_devices_yes_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function devices yes yes 6 yes 2 3 2 1
 cgroup_fj_function_devices_yes_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function devices yes yes 7 yes 2 3 2 1
 cgroup_fj_function_devices_yes_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function devices yes yes 8 yes 2 3 2 1
+cgroup_fj_function_blkio_yes_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function blkio yes yes 1 yes 2 3 2 1
+cgroup_fj_function_blkio_no_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function blkio no yes 1 yes 2 3 2 1
+cgroup_fj_function_blkio_yes_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function blkio yes yes 2 yes 2 3 2 1
+cgroup_fj_function_blkio_yes_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function blkio yes yes 3 yes 2 3 2 1
+cgroup_fj_function_blkio_yes_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function blkio yes yes 4 yes 2 3 2 1
+cgroup_fj_function_blkio_yes_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function blkio yes yes 5 yes 2 3 2 1
+cgroup_fj_function_blkio_yes_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function blkio yes yes 6 yes 2 3 2 1
+cgroup_fj_function_blkio_yes_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function blkio yes yes 7 yes 2 3 2 1
+cgroup_fj_function_blkio_yes_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function blkio yes yes 8 yes 2 3 2 1
+cgroup_fj_function_hugetlb_yes_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function hugetlb yes yes 1 yes 2 3 2 1
+cgroup_fj_function_hugetlb_no_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function hugetlb no yes 1 yes 2 3 2 1
+cgroup_fj_function_hugetlb_yes_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function hugetlb yes yes 2 yes 2 3 2 1
+cgroup_fj_function_hugetlb_yes_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function hugetlb yes yes 3 yes 2 3 2 1
+cgroup_fj_function_hugetlb_yes_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function hugetlb yes yes 4 yes 2 3 2 1
+cgroup_fj_function_hugetlb_yes_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function hugetlb yes yes 5 yes 2 3 2 1
+cgroup_fj_function_hugetlb_yes_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function hugetlb yes yes 6 yes 2 3 2 1
+cgroup_fj_function_hugetlb_yes_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function hugetlb yes yes 7 yes 2 3 2 1
+cgroup_fj_function_hugetlb_yes_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function hugetlb yes yes 8 yes 2 3 2 1
+cgroup_fj_function_net_cls_yes_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function net_cls yes yes 1 yes 2 3 2 1
+cgroup_fj_function_net_cls_no_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function net_cls no yes 1 yes 2 3 2 1
+cgroup_fj_function_net_cls_yes_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function net_cls yes yes 2 yes 2 3 2 1
+cgroup_fj_function_net_cls_yes_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function net_cls yes yes 3 yes 2 3 2 1
+cgroup_fj_function_net_cls_yes_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function net_cls yes yes 4 yes 2 3 2 1
+cgroup_fj_function_net_cls_yes_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function net_cls yes yes 5 yes 2 3 2 1
+cgroup_fj_function_net_cls_yes_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function net_cls yes yes 6 yes 2 3 2 1
+cgroup_fj_function_net_cls_yes_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function net_cls yes yes 7 yes 2 3 2 1
+cgroup_fj_function_net_cls_yes_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function net_cls yes yes 8 yes 2 3 2 1
+cgroup_fj_function_net_prio_yes_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function net_prio yes yes 1 yes 2 3 2 1
+cgroup_fj_function_net_prio_no_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function net_prio no yes 1 yes 2 3 2 1
+cgroup_fj_function_net_prio_yes_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function net_prio yes yes 2 yes 2 3 2 1
+cgroup_fj_function_net_prio_yes_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function net_prio yes yes 3 yes 2 3 2 1
+cgroup_fj_function_net_prio_yes_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function net_prio yes yes 4 yes 2 3 2 1
+cgroup_fj_function_net_prio_yes_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function net_prio yes yes 5 yes 2 3 2 1
+cgroup_fj_function_net_prio_yes_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function net_prio yes yes 6 yes 2 3 2 1
+cgroup_fj_function_net_prio_yes_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function net_prio yes yes 7 yes 2 3 2 1
+cgroup_fj_function_net_prio_yes_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function net_prio yes yes 8 yes 2 3 2 1
+cgroup_fj_function_pids_yes_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function pids yes yes 1 yes 2 3 2 1
+cgroup_fj_function_pids_no_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function pids no yes 1 yes 2 3 2 1
+cgroup_fj_function_pids_yes_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function pids yes yes 2 yes 2 3 2 1
+cgroup_fj_function_pids_yes_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function pids yes yes 3 yes 2 3 2 1
+cgroup_fj_function_pids_yes_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function pids yes yes 4 yes 2 3 2 1
+cgroup_fj_function_pids_yes_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function pids yes yes 5 yes 2 3 2 1
+cgroup_fj_function_pids_yes_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function pids yes yes 6 yes 2 3 2 1
+cgroup_fj_function_pids_yes_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function pids yes yes 7 yes 2 3 2 1
+cgroup_fj_function_pids_yes_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function pids yes yes 8 yes 2 3 2 1
 cgroup_fj_function_debug_yes_yes_1_yes_1_2_1_1 run_cgroup_test_fj.sh function debug yes yes 1 yes 1 2 1 1
 cgroup_fj_function_debug_yes_yes_1_yes_2_2_1_1 run_cgroup_test_fj.sh function debug yes yes 1 yes 2 2 1 1
 cgroup_fj_function_debug_yes_yes_1_yes_2_3_1_1 run_cgroup_test_fj.sh function debug yes yes 1 yes 2 3 1 1
@@ -194,6 +239,62 @@ cgroup_fj_stress_memory_1_100_1_2 run_cgroup_test_fj.sh stress memory 1 100 1 2
 cgroup_fj_stress_memory_1_100_1_3 run_cgroup_test_fj.sh stress memory 1 100 1 3
 cgroup_fj_stress_memory_1_100_100_1 run_cgroup_test_fj.sh stress memory 1 100 100 1
 cgroup_fj_stress_memory_1_100_100_2 run_cgroup_test_fj.sh stress memory 1 100 100 2
+cgroup_fj_stress_blkio_1_1_100_1 run_cgroup_test_fj.sh stress blkio 1 1 100 1
+cgroup_fj_stress_blkio_1_1_100_2 run_cgroup_test_fj.sh stress blkio 1 1 100 2
+cgroup_fj_stress_blkio_1_1_100_3 run_cgroup_test_fj.sh stress blkio 1 1 100 3
+cgroup_fj_stress_blkio_1_100_1_1 run_cgroup_test_fj.sh stress blkio 1 100 1 1
+cgroup_fj_stress_blkio_1_100_1_2 run_cgroup_test_fj.sh stress blkio 1 100 1 2
+cgroup_fj_stress_blkio_1_100_1_3 run_cgroup_test_fj.sh stress blkio 1 100 1 3
+cgroup_fj_stress_blkio_1_100_100_1 run_cgroup_test_fj.sh stress blkio 1 100 100 1
+cgroup_fj_stress_blkio_1_100_100_2 run_cgroup_test_fj.sh stress blkio 1 100 100 2
+cgroup_fj_stress_hugetlb_1_1_100_1 run_cgroup_test_fj.sh stress hugetlb 1 1 100 1
+cgroup_fj_stress_hugetlb_1_1_100_2 run_cgroup_test_fj.sh stress hugetlb 1 1 100 2
+cgroup_fj_stress_hugetlb_1_1_100_3 run_cgroup_test_fj.sh stress hugetlb 1 1 100 3
+cgroup_fj_stress_hugetlb_1_100_1_1 run_cgroup_test_fj.sh stress hugetlb 1 100 1 1
+cgroup_fj_stress_hugetlb_1_100_1_2 run_cgroup_test_fj.sh stress hugetlb 1 100 1 2
+cgroup_fj_stress_hugetlb_1_100_1_3 run_cgroup_test_fj.sh stress hugetlb 1 100 1 3
+cgroup_fj_stress_hugetlb_1_100_100_1 run_cgroup_test_fj.sh stress hugetlb 1 100 100 1
+cgroup_fj_stress_hugetlb_1_100_100_2 run_cgroup_test_fj.sh stress hugetlb 1 100 100 2
+cgroup_fj_stress_net_cls_1_1_100_1 run_cgroup_test_fj.sh stress net_cls 1 1 100 1
+cgroup_fj_stress_net_cls_1_1_100_2 run_cgroup_test_fj.sh stress net_cls 1 1 100 2
+cgroup_fj_stress_net_cls_1_1_100_3 run_cgroup_test_fj.sh stress net_cls 1 1 100 3
+cgroup_fj_stress_net_cls_1_100_1_1 run_cgroup_test_fj.sh stress net_cls 1 100 1 1
+cgroup_fj_stress_net_cls_1_100_1_2 run_cgroup_test_fj.sh stress net_cls 1 100 1 2
+cgroup_fj_stress_net_cls_1_100_1_3 run_cgroup_test_fj.sh stress net_cls 1 100 1 3
+cgroup_fj_stress_net_cls_1_100_100_1 run_cgroup_test_fj.sh stress net_cls 1 100 100 1
+cgroup_fj_stress_net_cls_1_100_100_2 run_cgroup_test_fj.sh stress net_cls 1 100 100 2
+cgroup_fj_stress_net_prio_1_1_100_1 run_cgroup_test_fj.sh stress net_prio 1 1 100 1
+cgroup_fj_stress_net_prio_1_1_100_2 run_cgroup_test_fj.sh stress net_prio 1 1 100 2
+cgroup_fj_stress_net_prio_1_1_100_3 run_cgroup_test_fj.sh stress net_prio 1 1 100 3
+cgroup_fj_stress_net_prio_1_100_1_1 run_cgroup_test_fj.sh stress net_prio 1 100 1 1
+cgroup_fj_stress_net_prio_1_100_1_2 run_cgroup_test_fj.sh stress net_prio 1 100 1 2
+cgroup_fj_stress_net_prio_1_100_1_3 run_cgroup_test_fj.sh stress net_prio 1 100 1 3
+cgroup_fj_stress_net_prio_1_100_100_1 run_cgroup_test_fj.sh stress net_prio 1 100 100 1
+cgroup_fj_stress_net_prio_1_100_100_2 run_cgroup_test_fj.sh stress net_prio 1 100 100 2
+cgroup_fj_stress_pids_1_1_100_1 run_cgroup_test_fj.sh stress pids 1 1 100 1
+cgroup_fj_stress_pids_1_1_100_2 run_cgroup_test_fj.sh stress pids 1 1 100 2
+cgroup_fj_stress_pids_1_1_100_3 run_cgroup_test_fj.sh stress pids 1 1 100 3
+cgroup_fj_stress_pids_1_100_1_1 run_cgroup_test_fj.sh stress pids 1 100 1 1
+cgroup_fj_stress_pids_1_100_1_2 run_cgroup_test_fj.sh stress pids 1 100 1 2
+cgroup_fj_stress_pids_1_100_1_3 run_cgroup_test_fj.sh stress pids 1 100 1 3
+cgroup_fj_stress_pids_1_100_100_1 run_cgroup_test_fj.sh stress pids 1 100 100 1
+cgroup_fj_stress_pids_1_100_100_2 run_cgroup_test_fj.sh stress pids 1 100 100 2
+cgroup_fj_stress_freezer_1_1_100_1 run_cgroup_test_fj.sh stress freezer 1 1 100 1
+cgroup_fj_stress_freezer_1_1_100_2 run_cgroup_test_fj.sh stress freezer 1 1 100 2
+cgroup_fj_stress_freezer_1_1_100_3 run_cgroup_test_fj.sh stress freezer 1 1 100 3
+cgroup_fj_stress_freezer_1_100_1_1 run_cgroup_test_fj.sh stress freezer 1 100 1 1
+cgroup_fj_stress_freezer_1_100_1_2 run_cgroup_test_fj.sh stress freezer 1 100 1 2
+cgroup_fj_stress_freezer_1_100_1_3 run_cgroup_test_fj.sh stress freezer 1 100 1 3
+cgroup_fj_stress_freezer_1_100_100_1 run_cgroup_test_fj.sh stress freezer 1 100 100 1
+cgroup_fj_stress_freezer_1_100_100_2 run_cgroup_test_fj.sh stress freezer 1 100 100 2
+cgroup_fj_stress_devices_1_1_100_1 run_cgroup_test_fj.sh stress devices 1 1 100 1
+cgroup_fj_stress_devices_1_1_100_2 run_cgroup_test_fj.sh stress devices 1 1 100 2
+cgroup_fj_stress_devices_1_1_100_3 run_cgroup_test_fj.sh stress devices 1 1 100 3
+cgroup_fj_stress_devices_1_100_1_1 run_cgroup_test_fj.sh stress devices 1 100 1 1
+cgroup_fj_stress_devices_1_100_1_2 run_cgroup_test_fj.sh stress devices 1 100 1 2
+cgroup_fj_stress_devices_1_100_1_3 run_cgroup_test_fj.sh stress devices 1 100 1 3
+cgroup_fj_stress_devices_1_100_100_1 run_cgroup_test_fj.sh stress devices 1 100 100 1
+cgroup_fj_stress_devices_1_100_100_2 run_cgroup_test_fj.sh stress devices 1 100 100 2
 
 controllers	test_controllers.sh
 
diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
index 76b8ad6..9cecc2b 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
@@ -63,8 +63,13 @@ usage()
 	echo "      memory"
 	echo "      debug,debug: debug,debug"
 	echo "      nonexistent: (nonexistent subsystem), e.g. abc"
-	echo "      freezer: freezer"
-	echo "      devices: devices"
+	echo "      freezer"
+	echo "      devices"
+	echo "      blkio"
+	echo "      hugetlb"
+	echo "      net_cls"
+	echo "      net_prio"
+	echo "      pids"
 	echo "    remount_use's usable number"
 	echo "      yes: do not use remount in "-o"'s parameter"
 	echo "      no: use it"
diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
index 04c4e2a..88cf735 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
@@ -52,6 +52,13 @@ usage()
 	echo "      cpu"
 	echo "      cpuacct"
 	echo "      memory"
+	echo "      freezer"
+	echo "      devices"
+	echo "      blkio"
+	echo "      hugetlb"
+	echo "      net_cls"
+	echo "      net_prio"
+	echo "      pids"
 	echo "    mount_times's usable number"
 	echo "      1: execute once"
 	echo "      100: execute 100 times"
diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
index 2ec376d..c035498 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
@@ -59,38 +59,14 @@ get_mount_point()
 get_subsystem()
 {
 	case $subsystem in
-	"debug" )
-		exist_subsystem;
-		;;
-	"cpuset" )
-		exist_subsystem;
-		;;
-	"ns" )
-		exist_subsystem;
-		;;
-	"cpu" )
-		exist_subsystem;
-		;;
-	"cpuacct" )
-		exist_subsystem;
-		;;
-	"memory" )
-		exist_subsystem;
-		;;
 	"debug,debug" )
 		exist_subsystem "debug";
 		;;
 	"nonexistent" )
 		subsystem="abc";
 		;;
-	"freezer" )
-		exist_subsystem;
-		;;
-	"devices" )
-		exist_subsystem;
-		;;
 	 *  )
-		return -1
+		exist_subsystem;
 		;;
 	esac
 }
-- 
2.1.4

