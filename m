From: Cedric Hnyda <cedric@hnyda.net>
Date: Fri, 25 Dec 2015 11:44:13 +0100
Subject: [LTP]  [PATCH] controllers/cgroup_fj: remove broken testcase
Message-ID: <1451040253-2430-1-git-send-email-cedric@hnyda.net>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

cgroup_fj_function_cpuset_yes_no_1_yes_2_3_2_1 seems to have never worked.
It tried to write in the file cpus but there is no such file,
cpuset.cpus should be used in all cases.
The test was removed from runtest/controllers.
The option noprefix was removed for all function testcases since it was only
used for that testcase.

Signed-off-by: Cedric Hnyda <cedric@hnyda.net>
---
 runtest/controllers                                | 337 ++++++++++-----------
 .../controllers/cgroup_fj/cgroup_fj_function.sh    |  34 +--
 .../controllers/cgroup_fj/cgroup_fj_utility.sh     |  29 +-
 3 files changed, 181 insertions(+), 219 deletions(-)

diff --git a/runtest/controllers b/runtest/controllers
index 86414e8..230649b 100644
--- a/runtest/controllers
+++ b/runtest/controllers
@@ -11,175 +11,174 @@ memcg_usage_in_bytes	memcg_usage_in_bytes_test.sh
 memcg_stress		memcg_stress_test.sh
 memcg_control		PAGESIZE=$(mem_process -p);memcg_control_test.sh $PAGESIZE $PAGESIZE $((PAGESIZE * 2))
 
-cgroup_fj_function_debug_yes_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function debug yes yes 1 yes 2 3 2 1
-cgroup_fj_function_debug_no_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function debug no yes 1 yes 2 3 2 1
-cgroup_fj_function_debug_yes_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function debug yes yes 2 yes 2 3 2 1
-cgroup_fj_function_debug_yes_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 2 1
-cgroup_fj_function_debug_yes_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function debug yes yes 4 yes 2 3 2 1
-cgroup_fj_function_debug_yes_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function debug yes yes 5 yes 2 3 2 1
-cgroup_fj_function_debug_yes_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function debug yes yes 6 yes 2 3 2 1
-cgroup_fj_function_debug_yes_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function debug yes yes 7 yes 2 3 2 1
-cgroup_fj_function_debug_yes_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function debug yes yes 8 yes 2 3 2 1
-cgroup_fj_function_cpuset_yes_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuset yes yes 1 yes 2 3 2 1
-cgroup_fj_function_cpuset_no_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuset no yes 1 yes 2 3 2 1
-cgroup_fj_function_cpuset_yes_no_1_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuset yes no 1 yes 2 3 2 1
-cgroup_fj_function_cpuset_yes_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuset yes yes 2 yes 2 3 2 1
-cgroup_fj_function_cpuset_yes_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuset yes yes 3 yes 2 3 2 1
-cgroup_fj_function_cpuset_yes_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuset yes yes 4 yes 2 3 2 1
-cgroup_fj_function_cpuset_yes_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuset yes yes 5 yes 2 3 2 1
-cgroup_fj_function_cpuset_yes_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuset yes yes 6 yes 2 3 2 1
-cgroup_fj_function_cpuset_yes_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuset yes yes 7 yes 2 3 2 1
-cgroup_fj_function_cpuset_yes_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuset yes yes 8 yes 2 3 2 1
-cgroup_fj_function_ns_yes_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function ns yes yes 1 yes 2 3 2 1
-cgroup_fj_function_ns_no_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function ns no yes 1 yes 2 3 2 1
-cgroup_fj_function_ns_yes_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function ns yes yes 2 yes 2 3 2 1
-cgroup_fj_function_ns_yes_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function ns yes yes 3 yes 2 3 2 1
-cgroup_fj_function_ns_yes_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function ns yes yes 4 yes 2 3 2 1
-cgroup_fj_function_ns_yes_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function ns yes yes 5 yes 2 3 2 1
-cgroup_fj_function_ns_yes_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function ns yes yes 6 yes 2 3 2 1
-cgroup_fj_function_ns_yes_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function ns yes yes 7 yes 2 3 2 1
-cgroup_fj_function_ns_yes_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function ns yes yes 8 yes 2 3 2 1
-cgroup_fj_function_cpu_yes_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function cpu yes yes 1 yes 2 3 2 1
-cgroup_fj_function_cpu_no_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function cpu no yes 1 yes 2 3 2 1
-cgroup_fj_function_cpu_yes_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function cpu yes yes 2 yes 2 3 2 1
-cgroup_fj_function_cpu_yes_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function cpu yes yes 3 yes 2 3 2 1
-cgroup_fj_function_cpu_yes_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function cpu yes yes 4 yes 2 3 2 1
-cgroup_fj_function_cpu_yes_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function cpu yes yes 5 yes 2 3 2 1
-cgroup_fj_function_cpu_yes_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function cpu yes yes 6 yes 2 3 2 1
-cgroup_fj_function_cpu_yes_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function cpu yes yes 7 yes 2 3 2 1
-cgroup_fj_function_cpu_yes_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function cpu yes yes 8 yes 2 3 2 1
-cgroup_fj_function_cpuacct_yes_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuacct yes yes 1 yes 2 3 2 1
-cgroup_fj_function_cpuacct_no_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuacct no yes 1 yes 2 3 2 1
-cgroup_fj_function_cpuacct_yes_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuacct yes yes 2 yes 2 3 2 1
-cgroup_fj_function_cpuacct_yes_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuacct yes yes 3 yes 2 3 2 1
-cgroup_fj_function_cpuacct_yes_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuacct yes yes 4 yes 2 3 2 1
-cgroup_fj_function_cpuacct_yes_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuacct yes yes 5 yes 2 3 2 1
-cgroup_fj_function_cpuacct_yes_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuacct yes yes 6 yes 2 3 2 1
-cgroup_fj_function_cpuacct_yes_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuacct yes yes 7 yes 2 3 2 1
-cgroup_fj_function_cpuacct_yes_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuacct yes yes 8 yes 2 3 2 1
-cgroup_fj_function_memory_yes_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function memory yes yes 1 yes 2 3 2 1
-cgroup_fj_function_memory_no_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function memory no yes 1 yes 2 3 2 1
-cgroup_fj_function_memory_yes_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function memory yes yes 2 yes 2 3 2 1
-cgroup_fj_function_memory_yes_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function memory yes yes 3 yes 2 3 2 1
-cgroup_fj_function_memory_yes_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function memory yes yes 4 yes 2 3 2 1
-cgroup_fj_function_memory_yes_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function memory yes yes 5 yes 2 3 2 1
-cgroup_fj_function_memory_yes_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function memory yes yes 6 yes 2 3 2 1
-cgroup_fj_function_memory_yes_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function memory yes yes 7 yes 2 3 2 1
-cgroup_fj_function_memory_yes_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function memory yes yes 8 yes 2 3 2 1
-cgroup_fj_function_debug,debug_yes_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function debug,debug yes yes 1 yes 2 3 2 1
-cgroup_fj_function_debug,debug_no_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function debug,debug no yes 1 yes 2 3 2 1
-cgroup_fj_function_debug,debug_yes_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function debug,debug yes yes 2 yes 2 3 2 1
-cgroup_fj_function_debug,debug_yes_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function debug,debug yes yes 3 yes 2 3 2 1
-cgroup_fj_function_debug,debug_yes_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function debug,debug yes yes 4 yes 2 3 2 1
-cgroup_fj_function_debug,debug_yes_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function debug,debug yes yes 5 yes 2 3 2 1
-cgroup_fj_function_debug,debug_yes_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function debug,debug yes yes 6 yes 2 3 2 1
-cgroup_fj_function_debug,debug_yes_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function debug,debug yes yes 7 yes 2 3 2 1
-cgroup_fj_function_debug,debug_yes_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function debug,debug yes yes 8 yes 2 3 2 1
-cgroup_fj_function_nonexistent_yes_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function nonexistent yes yes 1 yes 2 3 2 1
-cgroup_fj_function_freezer_yes_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function freezer yes yes 1 yes 2 3 2 1
-cgroup_fj_function_freezer_no_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function freezer no yes 1 yes 2 3 2 1
-cgroup_fj_function_freezer_yes_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function freezer yes yes 2 yes 2 3 2 1
-cgroup_fj_function_freezer_yes_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function freezer yes yes 3 yes 2 3 2 1
-cgroup_fj_function_freezer_yes_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function freezer yes yes 4 yes 2 3 2 1
-cgroup_fj_function_freezer_yes_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function freezer yes yes 5 yes 2 3 2 1
-cgroup_fj_function_freezer_yes_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function freezer yes yes 6 yes 2 3 2 1
-cgroup_fj_function_freezer_yes_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function freezer yes yes 7 yes 2 3 2 1
-cgroup_fj_function_freezer_yes_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function freezer yes yes 8 yes 2 3 2 1
-cgroup_fj_function_devices_yes_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function devices yes yes 1 yes 2 3 2 1
-cgroup_fj_function_devices_no_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function devices no yes 1 yes 2 3 2 1
-cgroup_fj_function_devices_yes_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function devices yes yes 2 yes 2 3 2 1
-cgroup_fj_function_devices_yes_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function devices yes yes 3 yes 2 3 2 1
-cgroup_fj_function_devices_yes_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function devices yes yes 4 yes 2 3 2 1
-cgroup_fj_function_devices_yes_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function devices yes yes 5 yes 2 3 2 1
-cgroup_fj_function_devices_yes_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function devices yes yes 6 yes 2 3 2 1
-cgroup_fj_function_devices_yes_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function devices yes yes 7 yes 2 3 2 1
-cgroup_fj_function_devices_yes_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function devices yes yes 8 yes 2 3 2 1
-cgroup_fj_function_blkio_yes_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function blkio yes yes 1 yes 2 3 2 1
-cgroup_fj_function_blkio_no_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function blkio no yes 1 yes 2 3 2 1
-cgroup_fj_function_blkio_yes_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function blkio yes yes 2 yes 2 3 2 1
-cgroup_fj_function_blkio_yes_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function blkio yes yes 3 yes 2 3 2 1
-cgroup_fj_function_blkio_yes_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function blkio yes yes 4 yes 2 3 2 1
-cgroup_fj_function_blkio_yes_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function blkio yes yes 5 yes 2 3 2 1
-cgroup_fj_function_blkio_yes_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function blkio yes yes 6 yes 2 3 2 1
-cgroup_fj_function_blkio_yes_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function blkio yes yes 7 yes 2 3 2 1
-cgroup_fj_function_blkio_yes_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function blkio yes yes 8 yes 2 3 2 1
-cgroup_fj_function_hugetlb_yes_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function hugetlb yes yes 1 yes 2 3 2 1
-cgroup_fj_function_hugetlb_no_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function hugetlb no yes 1 yes 2 3 2 1
-cgroup_fj_function_hugetlb_yes_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function hugetlb yes yes 2 yes 2 3 2 1
-cgroup_fj_function_hugetlb_yes_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function hugetlb yes yes 3 yes 2 3 2 1
-cgroup_fj_function_hugetlb_yes_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function hugetlb yes yes 4 yes 2 3 2 1
-cgroup_fj_function_hugetlb_yes_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function hugetlb yes yes 5 yes 2 3 2 1
-cgroup_fj_function_hugetlb_yes_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function hugetlb yes yes 6 yes 2 3 2 1
-cgroup_fj_function_hugetlb_yes_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function hugetlb yes yes 7 yes 2 3 2 1
-cgroup_fj_function_hugetlb_yes_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function hugetlb yes yes 8 yes 2 3 2 1
-cgroup_fj_function_net_cls_yes_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function net_cls yes yes 1 yes 2 3 2 1
-cgroup_fj_function_net_cls_no_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function net_cls no yes 1 yes 2 3 2 1
-cgroup_fj_function_net_cls_yes_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function net_cls yes yes 2 yes 2 3 2 1
-cgroup_fj_function_net_cls_yes_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function net_cls yes yes 3 yes 2 3 2 1
-cgroup_fj_function_net_cls_yes_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function net_cls yes yes 4 yes 2 3 2 1
-cgroup_fj_function_net_cls_yes_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function net_cls yes yes 5 yes 2 3 2 1
-cgroup_fj_function_net_cls_yes_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function net_cls yes yes 6 yes 2 3 2 1
-cgroup_fj_function_net_cls_yes_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function net_cls yes yes 7 yes 2 3 2 1
-cgroup_fj_function_net_cls_yes_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function net_cls yes yes 8 yes 2 3 2 1
-cgroup_fj_function_net_prio_yes_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function net_prio yes yes 1 yes 2 3 2 1
-cgroup_fj_function_net_prio_no_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function net_prio no yes 1 yes 2 3 2 1
-cgroup_fj_function_net_prio_yes_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function net_prio yes yes 2 yes 2 3 2 1
-cgroup_fj_function_net_prio_yes_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function net_prio yes yes 3 yes 2 3 2 1
-cgroup_fj_function_net_prio_yes_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function net_prio yes yes 4 yes 2 3 2 1
-cgroup_fj_function_net_prio_yes_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function net_prio yes yes 5 yes 2 3 2 1
-cgroup_fj_function_net_prio_yes_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function net_prio yes yes 6 yes 2 3 2 1
-cgroup_fj_function_net_prio_yes_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function net_prio yes yes 7 yes 2 3 2 1
-cgroup_fj_function_net_prio_yes_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function net_prio yes yes 8 yes 2 3 2 1
-cgroup_fj_function_pids_yes_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function pids yes yes 1 yes 2 3 2 1
-cgroup_fj_function_pids_no_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function pids no yes 1 yes 2 3 2 1
-cgroup_fj_function_pids_yes_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function pids yes yes 2 yes 2 3 2 1
-cgroup_fj_function_pids_yes_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function pids yes yes 3 yes 2 3 2 1
-cgroup_fj_function_pids_yes_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function pids yes yes 4 yes 2 3 2 1
-cgroup_fj_function_pids_yes_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function pids yes yes 5 yes 2 3 2 1
-cgroup_fj_function_pids_yes_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function pids yes yes 6 yes 2 3 2 1
-cgroup_fj_function_pids_yes_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function pids yes yes 7 yes 2 3 2 1
-cgroup_fj_function_pids_yes_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function pids yes yes 8 yes 2 3 2 1
-cgroup_fj_function_debug_yes_yes_1_yes_1_2_1_1 run_cgroup_test_fj.sh function debug yes yes 1 yes 1 2 1 1
-cgroup_fj_function_debug_yes_yes_1_yes_2_2_1_1 run_cgroup_test_fj.sh function debug yes yes 1 yes 2 2 1 1
-cgroup_fj_function_debug_yes_yes_1_yes_2_3_1_1 run_cgroup_test_fj.sh function debug yes yes 1 yes 2 3 1 1
-cgroup_fj_function_debug_yes_yes_1_yes_2_5_1_1 run_cgroup_test_fj.sh function debug yes yes 1 yes 2 5 1 1
-cgroup_fj_function_debug_yes_yes_1_yes_3_1_1_1 run_cgroup_test_fj.sh function debug yes yes 1 yes 3 1 1 1
-cgroup_fj_function_debug_yes_yes_1_yes_3_2_1_1 run_cgroup_test_fj.sh function debug yes yes 1 yes 3 2 1 1
-cgroup_fj_function_debug_yes_yes_1_yes_3_4_1_1 run_cgroup_test_fj.sh function debug yes yes 1 yes 3 4 1 1
-cgroup_fj_function_debug_yes_yes_1_yes_4_3_1_1 run_cgroup_test_fj.sh function debug yes yes 1 yes 4 3 1 1
-cgroup_fj_function_debug_yes_yes_1_yes_4_5_1_1 run_cgroup_test_fj.sh function debug yes yes 1 yes 4 5 1 1
-cgroup_fj_function_debug_yes_yes_1_no_1_1_1_1 run_cgroup_test_fj.sh function debug yes yes 1 no 1 1 1 1
-cgroup_fj_function_debug_yes_yes_1_yes_1_1_1_1 run_cgroup_test_fj.sh function debug yes yes 1 yes 1 1 1 1
-cgroup_fj_function_debug_yes_yes_1_yes_1_3_2_1 run_cgroup_test_fj.sh function debug yes yes 1 yes 1 3 2 1
-cgroup_fj_function_debug_yes_yes_1_yes_2_3_2_2 run_cgroup_test_fj.sh function debug yes yes 1 yes 2 3 2 2
-cgroup_fj_function_debug_yes_yes_1_yes_2_3_2_3 run_cgroup_test_fj.sh function debug yes yes 1 yes 2 3 2 3
-cgroup_fj_function_debug_yes_yes_1_yes_2_3_2_4 run_cgroup_test_fj.sh function debug yes yes 1 yes 2 3 2 4
-cgroup_fj_function_debug_yes_yes_1_yes_2_3_2_5 run_cgroup_test_fj.sh function debug yes yes 1 yes 2 3 2 5
-cgroup_fj_function_debug_yes_yes_1_yes_2_3_2_6 run_cgroup_test_fj.sh function debug yes yes 1 yes 2 3 2 6
-cgroup_fj_function_debug_yes_yes_1_yes_2_3_2_7 run_cgroup_test_fj.sh function debug yes yes 1 yes 2 3 2 7
-cgroup_fj_function_debug_yes_yes_1_yes_2_3_3_2 run_cgroup_test_fj.sh function debug yes yes 1 yes 2 3 3 2
-cgroup_fj_function_debug_yes_yes_1_yes_2_3_4_2 run_cgroup_test_fj.sh function debug yes yes 1 yes 2 3 4 2
-cgroup_fj_function_debug_yes_yes_1_yes_2_3_5_2 run_cgroup_test_fj.sh function debug yes yes 1 yes 2 3 5 2
-cgroup_fj_function_debug_yes_yes_1_yes_2_3_6_2 run_cgroup_test_fj.sh function debug yes yes 1 yes 2 3 6 2
-cgroup_fj_function_debug_yes_yes_1_yes_2_3_7_2 run_cgroup_test_fj.sh function debug yes yes 1 yes 2 3 7 2
-cgroup_fj_function_debug_yes_yes_2_yes_2_3_2_2 run_cgroup_test_fj.sh function debug yes yes 2 yes 2 3 2 2
-cgroup_fj_function_debug_yes_yes_3_yes_2_3_1_1 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 1 1
-cgroup_fj_function_debug_yes_yes_3_yes_2_3_1_2 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 1 2
-cgroup_fj_function_debug_yes_yes_3_yes_2_3_1_3 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 1 3
-cgroup_fj_function_debug_yes_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 2 1
-cgroup_fj_function_debug_yes_yes_3_yes_2_3_2_2 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 2 2
-cgroup_fj_function_debug_yes_yes_3_yes_2_3_2_3 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 2 3
-cgroup_fj_function_debug_yes_yes_3_yes_2_3_2_4 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 2 4
-cgroup_fj_function_debug_yes_yes_3_yes_2_3_2_5 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 2 5
-cgroup_fj_function_debug_yes_yes_3_yes_2_3_2_6 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 2 6
-cgroup_fj_function_debug_yes_yes_3_yes_2_3_2_7 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 2 7
-cgroup_fj_function_debug_yes_yes_3_yes_2_3_3_1 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 3 1
-cgroup_fj_function_debug_yes_yes_3_yes_2_3_3_2 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 3 2
-cgroup_fj_function_debug_yes_yes_3_yes_2_3_3_3 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 3 3
-cgroup_fj_function_debug_yes_yes_3_yes_2_3_4_2 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 4 2
-cgroup_fj_function_debug_yes_yes_3_yes_2_3_5_2 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 5 2
-cgroup_fj_function_debug_yes_yes_3_yes_2_3_6_2 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 6 2
-cgroup_fj_function_debug_yes_yes_3_yes_2_3_7_2 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 7 2
+cgroup_fj_function_debug_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function debug yes 1 yes 2 3 2 1
+cgroup_fj_function_debug_no_1_yes_2_3_2_1 run_cgroup_test_fj.sh function debug no 1 yes 2 3 2 1
+cgroup_fj_function_debug_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function debug yes 2 yes 2 3 2 1
+cgroup_fj_function_debug_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function debug yes 3 yes 2 3 2 1
+cgroup_fj_function_debug_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function debug yes 4 yes 2 3 2 1
+cgroup_fj_function_debug_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function debug yes 5 yes 2 3 2 1
+cgroup_fj_function_debug_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function debug yes 6 yes 2 3 2 1
+cgroup_fj_function_debug_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function debug yes 7 yes 2 3 2 1
+cgroup_fj_function_debug_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function debug yes 8 yes 2 3 2 1
+cgroup_fj_function_cpuset_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuset yes 1 yes 2 3 2 1
+cgroup_fj_function_cpuset_no_1_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuset no 1 yes 2 3 2 1
+cgroup_fj_function_cpuset_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuset yes 2 yes 2 3 2 1
+cgroup_fj_function_cpuset_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuset yes 3 yes 2 3 2 1
+cgroup_fj_function_cpuset_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuset yes 4 yes 2 3 2 1
+cgroup_fj_function_cpuset_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuset yes 5 yes 2 3 2 1
+cgroup_fj_function_cpuset_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuset yes 6 yes 2 3 2 1
+cgroup_fj_function_cpuset_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuset yes 7 yes 2 3 2 1
+cgroup_fj_function_cpuset_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuset yes 8 yes 2 3 2 1
+cgroup_fj_function_ns_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function ns yes 1 yes 2 3 2 1
+cgroup_fj_function_ns_no_1_yes_2_3_2_1 run_cgroup_test_fj.sh function ns no 1 yes 2 3 2 1
+cgroup_fj_function_ns_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function ns yes 2 yes 2 3 2 1
+cgroup_fj_function_ns_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function ns yes 3 yes 2 3 2 1
+cgroup_fj_function_ns_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function ns yes 4 yes 2 3 2 1
+cgroup_fj_function_ns_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function ns yes 5 yes 2 3 2 1
+cgroup_fj_function_ns_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function ns yes 6 yes 2 3 2 1
+cgroup_fj_function_ns_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function ns yes 7 yes 2 3 2 1
+cgroup_fj_function_ns_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function ns yes 8 yes 2 3 2 1
+cgroup_fj_function_cpu_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function cpu yes 1 yes 2 3 2 1
+cgroup_fj_function_cpu_no_1_yes_2_3_2_1 run_cgroup_test_fj.sh function cpu no 1 yes 2 3 2 1
+cgroup_fj_function_cpu_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function cpu yes 2 yes 2 3 2 1
+cgroup_fj_function_cpu_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function cpu yes 3 yes 2 3 2 1
+cgroup_fj_function_cpu_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function cpu yes 4 yes 2 3 2 1
+cgroup_fj_function_cpu_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function cpu yes 5 yes 2 3 2 1
+cgroup_fj_function_cpu_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function cpu yes 6 yes 2 3 2 1
+cgroup_fj_function_cpu_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function cpu yes 7 yes 2 3 2 1
+cgroup_fj_function_cpu_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function cpu yes 8 yes 2 3 2 1
+cgroup_fj_function_cpuacct_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuacct yes 1 yes 2 3 2 1
+cgroup_fj_function_cpuacct_no_1_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuacct no 1 yes 2 3 2 1
+cgroup_fj_function_cpuacct_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuacct yes 2 yes 2 3 2 1
+cgroup_fj_function_cpuacct_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuacct yes 3 yes 2 3 2 1
+cgroup_fj_function_cpuacct_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuacct yes 4 yes 2 3 2 1
+cgroup_fj_function_cpuacct_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuacct yes 5 yes 2 3 2 1
+cgroup_fj_function_cpuacct_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuacct yes 6 yes 2 3 2 1
+cgroup_fj_function_cpuacct_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuacct yes 7 yes 2 3 2 1
+cgroup_fj_function_cpuacct_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuacct yes 8 yes 2 3 2 1
+cgroup_fj_function_memory_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function memory yes 1 yes 2 3 2 1
+cgroup_fj_function_memory_no_1_yes_2_3_2_1 run_cgroup_test_fj.sh function memory no 1 yes 2 3 2 1
+cgroup_fj_function_memory_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function memory yes 2 yes 2 3 2 1
+cgroup_fj_function_memory_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function memory yes 3 yes 2 3 2 1
+cgroup_fj_function_memory_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function memory yes 4 yes 2 3 2 1
+cgroup_fj_function_memory_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function memory yes 5 yes 2 3 2 1
+cgroup_fj_function_memory_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function memory yes 6 yes 2 3 2 1
+cgroup_fj_function_memory_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function memory yes 7 yes 2 3 2 1
+cgroup_fj_function_memory_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function memory yes 8 yes 2 3 2 1
+cgroup_fj_function_debug,debug_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function debug,debug yes 1 yes 2 3 2 1
+cgroup_fj_function_debug,debug_no_1_yes_2_3_2_1 run_cgroup_test_fj.sh function debug,debug no 1 yes 2 3 2 1
+cgroup_fj_function_debug,debug_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function debug,debug yes 2 yes 2 3 2 1
+cgroup_fj_function_debug,debug_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function debug,debug yes 3 yes 2 3 2 1
+cgroup_fj_function_debug,debug_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function debug,debug yes 4 yes 2 3 2 1
+cgroup_fj_function_debug,debug_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function debug,debug yes 5 yes 2 3 2 1
+cgroup_fj_function_debug,debug_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function debug,debug yes 6 yes 2 3 2 1
+cgroup_fj_function_debug,debug_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function debug,debug yes 7 yes 2 3 2 1
+cgroup_fj_function_debug,debug_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function debug,debug yes 8 yes 2 3 2 1
+cgroup_fj_function_nonexistent_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function nonexistent yes 1 yes 2 3 2 1
+cgroup_fj_function_freezer_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function freezer yes 1 yes 2 3 2 1
+cgroup_fj_function_freezer_no_1_yes_2_3_2_1 run_cgroup_test_fj.sh function freezer no 1 yes 2 3 2 1
+cgroup_fj_function_freezer_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function freezer yes 2 yes 2 3 2 1
+cgroup_fj_function_freezer_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function freezer yes 3 yes 2 3 2 1
+cgroup_fj_function_freezer_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function freezer yes 4 yes 2 3 2 1
+cgroup_fj_function_freezer_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function freezer yes 5 yes 2 3 2 1
+cgroup_fj_function_freezer_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function freezer yes 6 yes 2 3 2 1
+cgroup_fj_function_freezer_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function freezer yes 7 yes 2 3 2 1
+cgroup_fj_function_freezer_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function freezer yes 8 yes 2 3 2 1
+cgroup_fj_function_devices_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function devices yes 1 yes 2 3 2 1
+cgroup_fj_function_devices_no_1_yes_2_3_2_1 run_cgroup_test_fj.sh function devices no 1 yes 2 3 2 1
+cgroup_fj_function_devices_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function devices yes 2 yes 2 3 2 1
+cgroup_fj_function_devices_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function devices yes 3 yes 2 3 2 1
+cgroup_fj_function_devices_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function devices yes 4 yes 2 3 2 1
+cgroup_fj_function_devices_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function devices yes 5 yes 2 3 2 1
+cgroup_fj_function_devices_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function devices yes 6 yes 2 3 2 1
+cgroup_fj_function_devices_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function devices yes 7 yes 2 3 2 1
+cgroup_fj_function_devices_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function devices yes 8 yes 2 3 2 1
+cgroup_fj_function_blkio_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function blkio yes 1 yes 2 3 2 1
+cgroup_fj_function_blkio_no_1_yes_2_3_2_1 run_cgroup_test_fj.sh function blkio no 1 yes 2 3 2 1
+cgroup_fj_function_blkio_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function blkio yes 2 yes 2 3 2 1
+cgroup_fj_function_blkio_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function blkio yes 3 yes 2 3 2 1
+cgroup_fj_function_blkio_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function blkio yes 4 yes 2 3 2 1
+cgroup_fj_function_blkio_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function blkio yes 5 yes 2 3 2 1
+cgroup_fj_function_blkio_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function blkio yes 6 yes 2 3 2 1
+cgroup_fj_function_blkio_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function blkio yes 7 yes 2 3 2 1
+cgroup_fj_function_blkio_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function blkio yes 8 yes 2 3 2 1
+cgroup_fj_function_hugetlb_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function hugetlb yes 1 yes 2 3 2 1
+cgroup_fj_function_hugetlb_no_1_yes_2_3_2_1 run_cgroup_test_fj.sh function hugetlb no 1 yes 2 3 2 1
+cgroup_fj_function_hugetlb_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function hugetlb yes 2 yes 2 3 2 1
+cgroup_fj_function_hugetlb_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function hugetlb yes 3 yes 2 3 2 1
+cgroup_fj_function_hugetlb_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function hugetlb yes 4 yes 2 3 2 1
+cgroup_fj_function_hugetlb_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function hugetlb yes 5 yes 2 3 2 1
+cgroup_fj_function_hugetlb_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function hugetlb yes 6 yes 2 3 2 1
+cgroup_fj_function_hugetlb_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function hugetlb yes 7 yes 2 3 2 1
+cgroup_fj_function_hugetlb_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function hugetlb yes 8 yes 2 3 2 1
+cgroup_fj_function_net_cls_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function net_cls yes 1 yes 2 3 2 1
+cgroup_fj_function_net_cls_no_1_yes_2_3_2_1 run_cgroup_test_fj.sh function net_cls no 1 yes 2 3 2 1
+cgroup_fj_function_net_cls_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function net_cls yes 2 yes 2 3 2 1
+cgroup_fj_function_net_cls_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function net_cls yes 3 yes 2 3 2 1
+cgroup_fj_function_net_cls_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function net_cls yes 4 yes 2 3 2 1
+cgroup_fj_function_net_cls_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function net_cls yes 5 yes 2 3 2 1
+cgroup_fj_function_net_cls_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function net_cls yes 6 yes 2 3 2 1
+cgroup_fj_function_net_cls_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function net_cls yes 7 yes 2 3 2 1
+cgroup_fj_function_net_cls_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function net_cls yes 8 yes 2 3 2 1
+cgroup_fj_function_net_prio_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function net_prio yes 1 yes 2 3 2 1
+cgroup_fj_function_net_prio_no_1_yes_2_3_2_1 run_cgroup_test_fj.sh function net_prio no 1 yes 2 3 2 1
+cgroup_fj_function_net_prio_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function net_prio yes 2 yes 2 3 2 1
+cgroup_fj_function_net_prio_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function net_prio yes 3 yes 2 3 2 1
+cgroup_fj_function_net_prio_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function net_prio yes 4 yes 2 3 2 1
+cgroup_fj_function_net_prio_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function net_prio yes 5 yes 2 3 2 1
+cgroup_fj_function_net_prio_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function net_prio yes 6 yes 2 3 2 1
+cgroup_fj_function_net_prio_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function net_prio yes 7 yes 2 3 2 1
+cgroup_fj_function_net_prio_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function net_prio yes 8 yes 2 3 2 1
+cgroup_fj_function_pids_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function pids yes 1 yes 2 3 2 1
+cgroup_fj_function_pids_no_1_yes_2_3_2_1 run_cgroup_test_fj.sh function pids no 1 yes 2 3 2 1
+cgroup_fj_function_pids_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function pids yes 2 yes 2 3 2 1
+cgroup_fj_function_pids_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function pids yes 3 yes 2 3 2 1
+cgroup_fj_function_pids_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function pids yes 4 yes 2 3 2 1
+cgroup_fj_function_pids_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function pids yes 5 yes 2 3 2 1
+cgroup_fj_function_pids_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function pids yes 6 yes 2 3 2 1
+cgroup_fj_function_pids_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function pids yes 7 yes 2 3 2 1
+cgroup_fj_function_pids_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function pids yes 8 yes 2 3 2 1
+cgroup_fj_function_debug_yes_1_yes_1_2_1_1 run_cgroup_test_fj.sh function debug yes 1 yes 1 2 1 1
+cgroup_fj_function_debug_yes_1_yes_2_2_1_1 run_cgroup_test_fj.sh function debug yes 1 yes 2 2 1 1
+cgroup_fj_function_debug_yes_1_yes_2_3_1_1 run_cgroup_test_fj.sh function debug yes 1 yes 2 3 1 1
+cgroup_fj_function_debug_yes_1_yes_2_5_1_1 run_cgroup_test_fj.sh function debug yes 1 yes 2 5 1 1
+cgroup_fj_function_debug_yes_1_yes_3_1_1_1 run_cgroup_test_fj.sh function debug yes 1 yes 3 1 1 1
+cgroup_fj_function_debug_yes_1_yes_3_2_1_1 run_cgroup_test_fj.sh function debug yes 1 yes 3 2 1 1
+cgroup_fj_function_debug_yes_1_yes_3_4_1_1 run_cgroup_test_fj.sh function debug yes 1 yes 3 4 1 1
+cgroup_fj_function_debug_yes_1_yes_4_3_1_1 run_cgroup_test_fj.sh function debug yes 1 yes 4 3 1 1
+cgroup_fj_function_debug_yes_1_yes_4_5_1_1 run_cgroup_test_fj.sh function debug yes 1 yes 4 5 1 1
+cgroup_fj_function_debug_yes_1_no_1_1_1_1 run_cgroup_test_fj.sh function debug yes 1 no 1 1 1 1
+cgroup_fj_function_debug_yes_1_yes_1_1_1_1 run_cgroup_test_fj.sh function debug yes 1 yes 1 1 1 1
+cgroup_fj_function_debug_yes_1_yes_1_3_2_1 run_cgroup_test_fj.sh function debug yes 1 yes 1 3 2 1
+cgroup_fj_function_debug_yes_1_yes_2_3_2_2 run_cgroup_test_fj.sh function debug yes 1 yes 2 3 2 2
+cgroup_fj_function_debug_yes_1_yes_2_3_2_3 run_cgroup_test_fj.sh function debug yes 1 yes 2 3 2 3
+cgroup_fj_function_debug_yes_1_yes_2_3_2_4 run_cgroup_test_fj.sh function debug yes 1 yes 2 3 2 4
+cgroup_fj_function_debug_yes_1_yes_2_3_2_5 run_cgroup_test_fj.sh function debug yes 1 yes 2 3 2 5
+cgroup_fj_function_debug_yes_1_yes_2_3_2_6 run_cgroup_test_fj.sh function debug yes 1 yes 2 3 2 6
+cgroup_fj_function_debug_yes_1_yes_2_3_2_7 run_cgroup_test_fj.sh function debug yes 1 yes 2 3 2 7
+cgroup_fj_function_debug_yes_1_yes_2_3_3_2 run_cgroup_test_fj.sh function debug yes 1 yes 2 3 3 2
+cgroup_fj_function_debug_yes_1_yes_2_3_4_2 run_cgroup_test_fj.sh function debug yes 1 yes 2 3 4 2
+cgroup_fj_function_debug_yes_1_yes_2_3_5_2 run_cgroup_test_fj.sh function debug yes 1 yes 2 3 5 2
+cgroup_fj_function_debug_yes_1_yes_2_3_6_2 run_cgroup_test_fj.sh function debug yes 1 yes 2 3 6 2
+cgroup_fj_function_debug_yes_1_yes_2_3_7_2 run_cgroup_test_fj.sh function debug yes 1 yes 2 3 7 2
+cgroup_fj_function_debug_yes_2_yes_2_3_2_2 run_cgroup_test_fj.sh function debug yes 2 yes 2 3 2 2
+cgroup_fj_function_debug_yes_3_yes_2_3_1_1 run_cgroup_test_fj.sh function debug yes 3 yes 2 3 1 1
+cgroup_fj_function_debug_yes_3_yes_2_3_1_2 run_cgroup_test_fj.sh function debug yes 3 yes 2 3 1 2
+cgroup_fj_function_debug_yes_3_yes_2_3_1_3 run_cgroup_test_fj.sh function debug yes 3 yes 2 3 1 3
+cgroup_fj_function_debug_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function debug yes 3 yes 2 3 2 1
+cgroup_fj_function_debug_yes_3_yes_2_3_2_2 run_cgroup_test_fj.sh function debug yes 3 yes 2 3 2 2
+cgroup_fj_function_debug_yes_3_yes_2_3_2_3 run_cgroup_test_fj.sh function debug yes 3 yes 2 3 2 3
+cgroup_fj_function_debug_yes_3_yes_2_3_2_4 run_cgroup_test_fj.sh function debug yes 3 yes 2 3 2 4
+cgroup_fj_function_debug_yes_3_yes_2_3_2_5 run_cgroup_test_fj.sh function debug yes 3 yes 2 3 2 5
+cgroup_fj_function_debug_yes_3_yes_2_3_2_6 run_cgroup_test_fj.sh function debug yes 3 yes 2 3 2 6
+cgroup_fj_function_debug_yes_3_yes_2_3_2_7 run_cgroup_test_fj.sh function debug yes 3 yes 2 3 2 7
+cgroup_fj_function_debug_yes_3_yes_2_3_3_1 run_cgroup_test_fj.sh function debug yes 3 yes 2 3 3 1
+cgroup_fj_function_debug_yes_3_yes_2_3_3_2 run_cgroup_test_fj.sh function debug yes 3 yes 2 3 3 2
+cgroup_fj_function_debug_yes_3_yes_2_3_3_3 run_cgroup_test_fj.sh function debug yes 3 yes 2 3 3 3
+cgroup_fj_function_debug_yes_3_yes_2_3_4_2 run_cgroup_test_fj.sh function debug yes 3 yes 2 3 4 2
+cgroup_fj_function_debug_yes_3_yes_2_3_5_2 run_cgroup_test_fj.sh function debug yes 3 yes 2 3 5 2
+cgroup_fj_function_debug_yes_3_yes_2_3_6_2 run_cgroup_test_fj.sh function debug yes 3 yes 2 3 6 2
+cgroup_fj_function_debug_yes_3_yes_2_3_7_2 run_cgroup_test_fj.sh function debug yes 3 yes 2 3 7 2
 cgroup_fj_function2_1_debug run_cgroup_test_fj.sh function2 1 debug
 cgroup_fj_function2_1_cpuset run_cgroup_test_fj.sh function2 1 cpuset
 cgroup_fj_function2_2_debug run_cgroup_test_fj.sh function2 2 debug
diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
index 9cecc2b..0eb478b 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
@@ -24,16 +24,14 @@
 
 subsystem=$1
 remount_use=$2
-noprefix_use=$3
-release_agent_para=$4
-subgroup_exist=$5
-attach_operation=$6
-remove_operation=$7
-notify_on_release=$8
-release_agent_echo=$9
+release_agent_para=$3
+subgroup_exist=$4
+attach_operation=$5
+remove_operation=$6
+notify_on_release=$7
+release_agent_echo=$8
 
 remount_use_str="";
-noprefix_use_str="";
 release_agent_para_str="";
 notify_on_release_str="";
 release_agent_str="";
@@ -51,7 +49,7 @@ no_debug=0
 usage()
 {
 	echo "usage of cgroup_fj_function.sh: "
-	echo "  ./cgroup_fj_function.sh -subsystem -remount_use -noprefix_use -release_agent_para"
+	echo "  ./cgroup_fj_function.sh -subsystem -remount_use -release_agent_para"
 	echo "                          -subgroup_exist -attach_operation -remove_operation"
 	echo "                          -notify_on_release -release_agent_echo"
 	echo "    subsystem's usable number"
@@ -73,9 +71,6 @@ usage()
 	echo "    remount_use's usable number"
 	echo "      yes: do not use remount in "-o"'s parameter"
 	echo "      no: use it"
-	echo "    noprefix_use's usable number"
-	echo "      yes: do not use noprefix in "-o"'s parameter"
-	echo "      no: use it. only cpuset available"
 	echo "    release_agent_para's usable number"
 	echo "      1: don't use release_agent_para= in "-o"'s parameter"
 	echo "      2: empty after "=""
@@ -117,8 +112,8 @@ usage()
 	echo "      5: command in other directory"
 	echo "      6: nonexistent command"
 	echo "      7: no-permission command"
-	echo "example: ./cgroup_fj_function.sh debug yes yes 1 yes 1 1 1 1"
-	echo "  will use "debug" to test, will not use option "remount","noprefix","release_agent""
+	echo "example: ./cgroup_fj_function.sh debug yes 1 yes 1 1 1 1"
+	echo "  will use "debug" to test, will not use option "remount","release_agent""
 	echo "  in in "-o"'s parameter, will create some subgroup, will not attach/remove any process"
 	echo "  will echo 0 to notify_on_release and will not echo anything to release_agent"
 }
@@ -130,7 +125,7 @@ export TMPFILE=$TESTROOT/tmp_tasks
 . $TESTROOT/cgroup_fj_utility.sh
 
 ##########################  main   #######################
-if [ "$#" -ne "9" ]; then
+if [ "$#" -ne "8" ]; then
 	echo "ERROR: Wrong input parameters... Exiting test";
 	usage;
 	exit -1;
@@ -153,13 +148,8 @@ mkdir_subgroup;
 if [ "$subsystem" == "cpuset" ]; then
 	exist=`grep -w cpuset /proc/cgroups | cut -f1`;
 	if [ "$exist" != "" ]; then
-		if [ "$noprefix_use" == "no" ]; then
-			do_echo 1 1 `cat $mount_point/cpus` $mount_point/ltp_subgroup_1/cpus;
-			do_echo 1 1 `cat $mount_point/mems` $mount_point/ltp_subgroup_1/mems;
-		else
-			do_echo 1 1 `cat $mount_point/cpuset.cpus` $mount_point/ltp_subgroup_1/cpuset.cpus;
-			do_echo 1 1 `cat $mount_point/cpuset.mems` $mount_point/ltp_subgroup_1/cpuset.mems;
-		fi
+		do_echo 1 1 `cat $mount_point/cpuset.cpus` $mount_point/ltp_subgroup_1/cpuset.cpus;
+		do_echo 1 1 `cat $mount_point/cpuset.mems` $mount_point/ltp_subgroup_1/cpuset.mems;
 	fi
 fi
 
diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
index c035498..a6e7852 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
@@ -86,24 +86,6 @@ get_remount_use()
 	esac
 }
 
-get_noprefix_use()
-{
-	case $noprefix_use in
-	"yes" )
-		noprefix_use_str="";
-		;;
-	"no" )
-		if [ $subsystem != "cpuset" ]; then
-			return -1
-		fi
-		noprefix_use_str="noprefix";
-		;;
-	 *  )
-		return -1
-		;;
-	esac
-}
-
 get_release_agent_para()
 {
 	case $release_agent_para in
@@ -552,13 +534,6 @@ mount_cgroup ()
 	if [ "$subsystem" != "" ]; then
 		PARAMETER_O="$subsystem"
 	fi
-	if [ "$noprefix_use_str" != "" ]; then
-		if [ "$PARAMETER_O" != "" ]; then
-			PARAMETER_O="$PARAMETER_O"",""$noprefix_use_str"
-		else
-			PARAMETER_O="$noprefix_use_str"
-		fi
-	fi
 	if [ "$release_agent_para_str" != "" ]; then
 		if [ "$PARAMETER_O" != "" ]; then
 			PARAMETER_O="$PARAMETER_O"",release_agent=""$release_agent_para_str"
@@ -590,8 +565,6 @@ check_para()
 	ret1=$?
 	get_remount_use;
 	ret2=$?
-	get_noprefix_use;
-	ret3=$?
 	get_release_agent_para;
 	ret4=$?
 	get_notify_on_release;
@@ -599,7 +572,7 @@ check_para()
 	get_release_agent;
 	ret6=$?
 
-	if [ $ret1 -ne 0 ] || [ $ret2 -ne 0 ] || [ $ret3 -ne 0 ] || [ $ret4 -ne 0 ] || [ $ret5 -ne 0 ] || [ $ret6 -ne 0 ]
+	if [ $ret1 -ne 0 ] || [ $ret2 -ne 0 ] || [ $ret4 -ne 0 ] || [ $ret5 -ne 0 ] || [ $ret6 -ne 0 ]
 	then
 		echo "ERROR: Wrong input parameters..Exiting test"
 		return -1
-- 
2.1.4

