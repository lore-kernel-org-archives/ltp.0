From: Cedric Hnyda <chnyda@suse.com>
Date: Mon, 14 Dec 2015 11:22:30 +0100
Subject: [LTP]  [PATCH] controllers/cgroup_fj: fix failure
Message-ID: <1450088550-19792-1-git-send-email-chnyda@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Remove stress testcases which mounted cgroups several times.
It was possible to do it with older kernel but not anymore.
Remove option mount_times in cgroup_fj_stress.sh

Signed-off-by: Cedric Hnyda <chnyda@suse.com>
---
 runtest/controllers                                | 198 ++++++++++---------
 .../controllers/cgroup_fj/cgroup_fj_stress.sh      | 211 ++++++++-------------
 2 files changed, 180 insertions(+), 229 deletions(-)

diff --git a/runtest/controllers b/runtest/controllers
index 86414e8..78352a0 100644
--- a/runtest/controllers
+++ b/runtest/controllers
@@ -240,108 +240,102 @@ cgroup_fj_function2_9_cpuacct run_cgroup_test_fj.sh function2 9 cpuacct
 cgroup_fj_function2_9_memory run_cgroup_test_fj.sh function2 9 memory
 cgroup_fj_function2_9_freezer run_cgroup_test_fj.sh function2 9 freezer
 cgroup_fj_function2_9_devices run_cgroup_test_fj.sh function2 9 devices
-cgroup_fj_stress_debug_100_1_1_1 run_cgroup_test_fj.sh stress debug 100 1 1 1
-cgroup_fj_stress_cpuset_100_1_1_1 run_cgroup_test_fj.sh stress cpuset 100 1 1 1
-cgroup_fj_stress_ns_100_1_1_1 run_cgroup_test_fj.sh stress ns 100 1 1 1
-cgroup_fj_stress_cpu_100_1_1_1 run_cgroup_test_fj.sh stress cpu 100 1 1 1
-cgroup_fj_stress_cpuacct_100_1_1_1 run_cgroup_test_fj.sh stress cpuacct 100 1 1 1
-cgroup_fj_stress_memory_100_1_1_1 run_cgroup_test_fj.sh stress memory 100 1 1 1
-cgroup_fj_stress_debug_1_1_1_2 run_cgroup_test_fj.sh stress debug 1 1 1 2
-cgroup_fj_stress_debug_1_1_100_1 run_cgroup_test_fj.sh stress debug 1 1 100 1
-cgroup_fj_stress_debug_1_1_100_2 run_cgroup_test_fj.sh stress debug 1 1 100 2
-cgroup_fj_stress_debug_1_1_100_3 run_cgroup_test_fj.sh stress debug 1 1 100 3
-cgroup_fj_stress_debug_1_100_1_1 run_cgroup_test_fj.sh stress debug 1 100 1 1
-cgroup_fj_stress_debug_1_100_1_2 run_cgroup_test_fj.sh stress debug 1 100 1 2
-cgroup_fj_stress_debug_1_100_1_3 run_cgroup_test_fj.sh stress debug 1 100 1 3
-cgroup_fj_stress_debug_1_100_100_1 run_cgroup_test_fj.sh stress debug 1 100 100 1
-cgroup_fj_stress_debug_1_100_100_2 run_cgroup_test_fj.sh stress debug 1 100 100 2
-cgroup_fj_stress_cpuset_1_1_1_2 run_cgroup_test_fj.sh stress cpuset 1 1 1 2
-cgroup_fj_stress_cpuset_1_1_100_1 run_cgroup_test_fj.sh stress cpuset 1 1 100 1
-cgroup_fj_stress_cpuset_1_1_100_2 run_cgroup_test_fj.sh stress cpuset 1 1 100 2
-cgroup_fj_stress_cpuset_1_1_100_3 run_cgroup_test_fj.sh stress cpuset 1 1 100 3
-cgroup_fj_stress_cpuset_1_100_1_1 run_cgroup_test_fj.sh stress cpuset 1 100 1 1
-cgroup_fj_stress_cpuset_1_100_1_2 run_cgroup_test_fj.sh stress cpuset 1 100 1 2
-cgroup_fj_stress_cpuset_1_100_1_3 run_cgroup_test_fj.sh stress cpuset 1 100 1 3
-cgroup_fj_stress_cpuset_1_100_100_1 run_cgroup_test_fj.sh stress cpuset 1 100 100 1
-cgroup_fj_stress_cpuset_1_100_100_2 run_cgroup_test_fj.sh stress cpuset 1 100 100 2
-cgroup_fj_stress_cpu_1_1_1_2 run_cgroup_test_fj.sh stress cpu 1 1 1 2
-cgroup_fj_stress_cpu_1_100_1_1 run_cgroup_test_fj.sh stress cpu 1 100 1 1
-cgroup_fj_stress_cpu_1_100_1_2 run_cgroup_test_fj.sh stress cpu 1 100 1 2
-cgroup_fj_stress_cpu_1_100_1_3 run_cgroup_test_fj.sh stress cpu 1 100 1 3
-cgroup_fj_stress_cpuacct_1_1_1_2 run_cgroup_test_fj.sh stress cpuacct 1 1 1 2
-cgroup_fj_stress_cpuacct_1_1_100_1 run_cgroup_test_fj.sh stress cpuacct 1 1 100 1
-cgroup_fj_stress_cpuacct_1_1_100_2 run_cgroup_test_fj.sh stress cpuacct 1 1 100 2
-cgroup_fj_stress_cpuacct_1_1_100_3 run_cgroup_test_fj.sh stress cpuacct 1 1 100 3
-cgroup_fj_stress_cpuacct_1_100_1_1 run_cgroup_test_fj.sh stress cpuacct 1 100 1 1
-cgroup_fj_stress_cpuacct_1_100_1_2 run_cgroup_test_fj.sh stress cpuacct 1 100 1 2
-cgroup_fj_stress_cpuacct_1_100_1_3 run_cgroup_test_fj.sh stress cpuacct 1 100 1 3
-cgroup_fj_stress_cpuacct_1_100_100_1 run_cgroup_test_fj.sh stress cpuacct 1 100 100 1
-cgroup_fj_stress_cpuacct_1_100_100_2 run_cgroup_test_fj.sh stress cpuacct 1 100 100 2
-cgroup_fj_stress_memory_1_1_1_2 run_cgroup_test_fj.sh stress memory 1 1 1 2
-cgroup_fj_stress_memory_1_1_100_1 run_cgroup_test_fj.sh stress memory 1 1 100 1
-cgroup_fj_stress_memory_1_1_100_2 run_cgroup_test_fj.sh stress memory 1 1 100 2
-cgroup_fj_stress_memory_1_1_100_3 run_cgroup_test_fj.sh stress memory 1 1 100 3
-cgroup_fj_stress_memory_1_100_1_1 run_cgroup_test_fj.sh stress memory 1 100 1 1
-cgroup_fj_stress_memory_1_100_1_2 run_cgroup_test_fj.sh stress memory 1 100 1 2
-cgroup_fj_stress_memory_1_100_1_3 run_cgroup_test_fj.sh stress memory 1 100 1 3
-cgroup_fj_stress_memory_1_100_100_1 run_cgroup_test_fj.sh stress memory 1 100 100 1
-cgroup_fj_stress_memory_1_100_100_2 run_cgroup_test_fj.sh stress memory 1 100 100 2
-cgroup_fj_stress_blkio_1_1_100_1 run_cgroup_test_fj.sh stress blkio 1 1 100 1
-cgroup_fj_stress_blkio_1_1_100_2 run_cgroup_test_fj.sh stress blkio 1 1 100 2
-cgroup_fj_stress_blkio_1_1_100_3 run_cgroup_test_fj.sh stress blkio 1 1 100 3
-cgroup_fj_stress_blkio_1_100_1_1 run_cgroup_test_fj.sh stress blkio 1 100 1 1
-cgroup_fj_stress_blkio_1_100_1_2 run_cgroup_test_fj.sh stress blkio 1 100 1 2
-cgroup_fj_stress_blkio_1_100_1_3 run_cgroup_test_fj.sh stress blkio 1 100 1 3
-cgroup_fj_stress_blkio_1_100_100_1 run_cgroup_test_fj.sh stress blkio 1 100 100 1
-cgroup_fj_stress_blkio_1_100_100_2 run_cgroup_test_fj.sh stress blkio 1 100 100 2
-cgroup_fj_stress_hugetlb_1_1_100_1 run_cgroup_test_fj.sh stress hugetlb 1 1 100 1
-cgroup_fj_stress_hugetlb_1_1_100_2 run_cgroup_test_fj.sh stress hugetlb 1 1 100 2
-cgroup_fj_stress_hugetlb_1_1_100_3 run_cgroup_test_fj.sh stress hugetlb 1 1 100 3
-cgroup_fj_stress_hugetlb_1_100_1_1 run_cgroup_test_fj.sh stress hugetlb 1 100 1 1
-cgroup_fj_stress_hugetlb_1_100_1_2 run_cgroup_test_fj.sh stress hugetlb 1 100 1 2
-cgroup_fj_stress_hugetlb_1_100_1_3 run_cgroup_test_fj.sh stress hugetlb 1 100 1 3
-cgroup_fj_stress_hugetlb_1_100_100_1 run_cgroup_test_fj.sh stress hugetlb 1 100 100 1
-cgroup_fj_stress_hugetlb_1_100_100_2 run_cgroup_test_fj.sh stress hugetlb 1 100 100 2
-cgroup_fj_stress_net_cls_1_1_100_1 run_cgroup_test_fj.sh stress net_cls 1 1 100 1
-cgroup_fj_stress_net_cls_1_1_100_2 run_cgroup_test_fj.sh stress net_cls 1 1 100 2
-cgroup_fj_stress_net_cls_1_1_100_3 run_cgroup_test_fj.sh stress net_cls 1 1 100 3
-cgroup_fj_stress_net_cls_1_100_1_1 run_cgroup_test_fj.sh stress net_cls 1 100 1 1
-cgroup_fj_stress_net_cls_1_100_1_2 run_cgroup_test_fj.sh stress net_cls 1 100 1 2
-cgroup_fj_stress_net_cls_1_100_1_3 run_cgroup_test_fj.sh stress net_cls 1 100 1 3
-cgroup_fj_stress_net_cls_1_100_100_1 run_cgroup_test_fj.sh stress net_cls 1 100 100 1
-cgroup_fj_stress_net_cls_1_100_100_2 run_cgroup_test_fj.sh stress net_cls 1 100 100 2
-cgroup_fj_stress_net_prio_1_1_100_1 run_cgroup_test_fj.sh stress net_prio 1 1 100 1
-cgroup_fj_stress_net_prio_1_1_100_2 run_cgroup_test_fj.sh stress net_prio 1 1 100 2
-cgroup_fj_stress_net_prio_1_1_100_3 run_cgroup_test_fj.sh stress net_prio 1 1 100 3
-cgroup_fj_stress_net_prio_1_100_1_1 run_cgroup_test_fj.sh stress net_prio 1 100 1 1
-cgroup_fj_stress_net_prio_1_100_1_2 run_cgroup_test_fj.sh stress net_prio 1 100 1 2
-cgroup_fj_stress_net_prio_1_100_1_3 run_cgroup_test_fj.sh stress net_prio 1 100 1 3
-cgroup_fj_stress_net_prio_1_100_100_1 run_cgroup_test_fj.sh stress net_prio 1 100 100 1
-cgroup_fj_stress_net_prio_1_100_100_2 run_cgroup_test_fj.sh stress net_prio 1 100 100 2
-cgroup_fj_stress_pids_1_1_100_1 run_cgroup_test_fj.sh stress pids 1 1 100 1
-cgroup_fj_stress_pids_1_1_100_2 run_cgroup_test_fj.sh stress pids 1 1 100 2
-cgroup_fj_stress_pids_1_1_100_3 run_cgroup_test_fj.sh stress pids 1 1 100 3
-cgroup_fj_stress_pids_1_100_1_1 run_cgroup_test_fj.sh stress pids 1 100 1 1
-cgroup_fj_stress_pids_1_100_1_2 run_cgroup_test_fj.sh stress pids 1 100 1 2
-cgroup_fj_stress_pids_1_100_1_3 run_cgroup_test_fj.sh stress pids 1 100 1 3
-cgroup_fj_stress_pids_1_100_100_1 run_cgroup_test_fj.sh stress pids 1 100 100 1
-cgroup_fj_stress_pids_1_100_100_2 run_cgroup_test_fj.sh stress pids 1 100 100 2
-cgroup_fj_stress_freezer_1_1_100_1 run_cgroup_test_fj.sh stress freezer 1 1 100 1
-cgroup_fj_stress_freezer_1_1_100_2 run_cgroup_test_fj.sh stress freezer 1 1 100 2
-cgroup_fj_stress_freezer_1_1_100_3 run_cgroup_test_fj.sh stress freezer 1 1 100 3
-cgroup_fj_stress_freezer_1_100_1_1 run_cgroup_test_fj.sh stress freezer 1 100 1 1
-cgroup_fj_stress_freezer_1_100_1_2 run_cgroup_test_fj.sh stress freezer 1 100 1 2
-cgroup_fj_stress_freezer_1_100_1_3 run_cgroup_test_fj.sh stress freezer 1 100 1 3
-cgroup_fj_stress_freezer_1_100_100_1 run_cgroup_test_fj.sh stress freezer 1 100 100 1
-cgroup_fj_stress_freezer_1_100_100_2 run_cgroup_test_fj.sh stress freezer 1 100 100 2
-cgroup_fj_stress_devices_1_1_100_1 run_cgroup_test_fj.sh stress devices 1 1 100 1
-cgroup_fj_stress_devices_1_1_100_2 run_cgroup_test_fj.sh stress devices 1 1 100 2
-cgroup_fj_stress_devices_1_1_100_3 run_cgroup_test_fj.sh stress devices 1 1 100 3
-cgroup_fj_stress_devices_1_100_1_1 run_cgroup_test_fj.sh stress devices 1 100 1 1
-cgroup_fj_stress_devices_1_100_1_2 run_cgroup_test_fj.sh stress devices 1 100 1 2
-cgroup_fj_stress_devices_1_100_1_3 run_cgroup_test_fj.sh stress devices 1 100 1 3
-cgroup_fj_stress_devices_1_100_100_1 run_cgroup_test_fj.sh stress devices 1 100 100 1
-cgroup_fj_stress_devices_1_100_100_2 run_cgroup_test_fj.sh stress devices 1 100 100 2
+cgroup_fj_stress_debug_1_1_1_2 run_cgroup_test_fj.sh stress debug 1 1 2
+cgroup_fj_stress_debug_1_1_100_1 run_cgroup_test_fj.sh stress debug 1 100 1
+cgroup_fj_stress_debug_1_1_100_2 run_cgroup_test_fj.sh stress debug 1 100 2
+cgroup_fj_stress_debug_1_1_100_3 run_cgroup_test_fj.sh stress debug 1 100 3
+cgroup_fj_stress_debug_1_100_1_1 run_cgroup_test_fj.sh stress debug 100 1 1
+cgroup_fj_stress_debug_1_100_1_2 run_cgroup_test_fj.sh stress debug 100 1 2
+cgroup_fj_stress_debug_1_100_1_3 run_cgroup_test_fj.sh stress debug 100 1 3
+cgroup_fj_stress_debug_1_100_100_1 run_cgroup_test_fj.sh stress debug 100 100 1
+cgroup_fj_stress_debug_1_100_100_2 run_cgroup_test_fj.sh stress debug 100 100 2
+cgroup_fj_stress_cpuset_1_1_1_2 run_cgroup_test_fj.sh stress cpuset 1 1 2
+cgroup_fj_stress_cpuset_1_1_100_1 run_cgroup_test_fj.sh stress cpuset 1 100 1
+cgroup_fj_stress_cpuset_1_1_100_2 run_cgroup_test_fj.sh stress cpuset 1 100 2
+cgroup_fj_stress_cpuset_1_1_100_3 run_cgroup_test_fj.sh stress cpuset 1 100 3
+cgroup_fj_stress_cpuset_1_100_1_1 run_cgroup_test_fj.sh stress cpuset 100 1 1
+cgroup_fj_stress_cpuset_1_100_1_2 run_cgroup_test_fj.sh stress cpuset 100 1 2
+cgroup_fj_stress_cpuset_1_100_1_3 run_cgroup_test_fj.sh stress cpuset 100 1 3
+cgroup_fj_stress_cpuset_1_100_100_1 run_cgroup_test_fj.sh stress cpuset 100 100 1
+cgroup_fj_stress_cpuset_1_100_100_2 run_cgroup_test_fj.sh stress cpuset 100 100 2
+cgroup_fj_stress_cpu_1_1_1_2 run_cgroup_test_fj.sh stress cpu 1 1 2
+cgroup_fj_stress_cpu_1_100_1_1 run_cgroup_test_fj.sh stress cpu 100 1 1
+cgroup_fj_stress_cpu_1_100_1_2 run_cgroup_test_fj.sh stress cpu 100 1 2
+cgroup_fj_stress_cpu_1_100_1_3 run_cgroup_test_fj.sh stress cpu 100 1 3
+cgroup_fj_stress_cpuacct_1_1_1_2 run_cgroup_test_fj.sh stress cpuacct 1 1 2
+cgroup_fj_stress_cpuacct_1_1_100_1 run_cgroup_test_fj.sh stress cpuacct 1 100 1
+cgroup_fj_stress_cpuacct_1_1_100_2 run_cgroup_test_fj.sh stress cpuacct 1 100 2
+cgroup_fj_stress_cpuacct_1_1_100_3 run_cgroup_test_fj.sh stress cpuacct 1 100 3
+cgroup_fj_stress_cpuacct_1_100_1_1 run_cgroup_test_fj.sh stress cpuacct 100 1 1
+cgroup_fj_stress_cpuacct_1_100_1_2 run_cgroup_test_fj.sh stress cpuacct 100 1 2
+cgroup_fj_stress_cpuacct_1_100_1_3 run_cgroup_test_fj.sh stress cpuacct 100 1 3
+cgroup_fj_stress_cpuacct_1_100_100_1 run_cgroup_test_fj.sh stress cpuacct 100 100 1
+cgroup_fj_stress_cpuacct_1_100_100_2 run_cgroup_test_fj.sh stress cpuacct 100 100 2
+cgroup_fj_stress_memory_1_1_1_2 run_cgroup_test_fj.sh stress memory 1 1 2
+cgroup_fj_stress_memory_1_1_100_1 run_cgroup_test_fj.sh stress memory 1 100 1
+cgroup_fj_stress_memory_1_1_100_2 run_cgroup_test_fj.sh stress memory 1 100 2
+cgroup_fj_stress_memory_1_1_100_3 run_cgroup_test_fj.sh stress memory 1 100 3
+cgroup_fj_stress_memory_1_100_1_1 run_cgroup_test_fj.sh stress memory 100 1 1
+cgroup_fj_stress_memory_1_100_1_2 run_cgroup_test_fj.sh stress memory 100 1 2
+cgroup_fj_stress_memory_1_100_1_3 run_cgroup_test_fj.sh stress memory 100 1 3
+cgroup_fj_stress_memory_1_100_100_1 run_cgroup_test_fj.sh stress memory 100 100 1
+cgroup_fj_stress_memory_1_100_100_2 run_cgroup_test_fj.sh stress memory 100 100 2
+cgroup_fj_stress_blkio_1_1_100_1 run_cgroup_test_fj.sh stress blkio 1 100 1
+cgroup_fj_stress_blkio_1_1_100_2 run_cgroup_test_fj.sh stress blkio 1 100 2
+cgroup_fj_stress_blkio_1_1_100_3 run_cgroup_test_fj.sh stress blkio 1 100 3
+cgroup_fj_stress_blkio_1_100_1_1 run_cgroup_test_fj.sh stress blkio 100 1 1
+cgroup_fj_stress_blkio_1_100_1_2 run_cgroup_test_fj.sh stress blkio 100 1 2
+cgroup_fj_stress_blkio_1_100_1_3 run_cgroup_test_fj.sh stress blkio 100 1 3
+cgroup_fj_stress_blkio_1_100_100_1 run_cgroup_test_fj.sh stress blkio 100 100 1
+cgroup_fj_stress_blkio_1_100_100_2 run_cgroup_test_fj.sh stress blkio 100 100 2
+cgroup_fj_stress_hugetlb_1_1_100_1 run_cgroup_test_fj.sh stress hugetlb 1 100 1
+cgroup_fj_stress_hugetlb_1_1_100_2 run_cgroup_test_fj.sh stress hugetlb 1 100 2
+cgroup_fj_stress_hugetlb_1_1_100_3 run_cgroup_test_fj.sh stress hugetlb 1 100 3
+cgroup_fj_stress_hugetlb_1_100_1_1 run_cgroup_test_fj.sh stress hugetlb 100 1 1
+cgroup_fj_stress_hugetlb_1_100_1_2 run_cgroup_test_fj.sh stress hugetlb 100 1 2
+cgroup_fj_stress_hugetlb_1_100_1_3 run_cgroup_test_fj.sh stress hugetlb 100 1 3
+cgroup_fj_stress_hugetlb_1_100_100_1 run_cgroup_test_fj.sh stress hugetlb 100 100 1
+cgroup_fj_stress_hugetlb_1_100_100_2 run_cgroup_test_fj.sh stress hugetlb 100 100 2
+cgroup_fj_stress_net_cls_1_1_100_1 run_cgroup_test_fj.sh stress net_cls 1 100 1
+cgroup_fj_stress_net_cls_1_1_100_2 run_cgroup_test_fj.sh stress net_cls 1 100 2
+cgroup_fj_stress_net_cls_1_1_100_3 run_cgroup_test_fj.sh stress net_cls 1 100 3
+cgroup_fj_stress_net_cls_1_100_1_1 run_cgroup_test_fj.sh stress net_cls 100 1 1
+cgroup_fj_stress_net_cls_1_100_1_2 run_cgroup_test_fj.sh stress net_cls 100 1 2
+cgroup_fj_stress_net_cls_1_100_1_3 run_cgroup_test_fj.sh stress net_cls 100 1 3
+cgroup_fj_stress_net_cls_1_100_100_1 run_cgroup_test_fj.sh stress net_cls 100 100 1
+cgroup_fj_stress_net_cls_1_100_100_2 run_cgroup_test_fj.sh stress net_cls 100 100 2
+cgroup_fj_stress_net_prio_1_1_100_1 run_cgroup_test_fj.sh stress net_prio 1 100 1
+cgroup_fj_stress_net_prio_1_1_100_2 run_cgroup_test_fj.sh stress net_prio 1 100 2
+cgroup_fj_stress_net_prio_1_1_100_3 run_cgroup_test_fj.sh stress net_prio 1 100 3
+cgroup_fj_stress_net_prio_1_100_1_1 run_cgroup_test_fj.sh stress net_prio 100 1 1
+cgroup_fj_stress_net_prio_1_100_1_2 run_cgroup_test_fj.sh stress net_prio 100 1 2
+cgroup_fj_stress_net_prio_1_100_1_3 run_cgroup_test_fj.sh stress net_prio 100 1 3
+cgroup_fj_stress_net_prio_1_100_100_1 run_cgroup_test_fj.sh stress net_prio 100 100 1
+cgroup_fj_stress_net_prio_1_100_100_2 run_cgroup_test_fj.sh stress net_prio 100 100 2
+cgroup_fj_stress_pids_1_1_100_1 run_cgroup_test_fj.sh stress pids 1 100 1
+cgroup_fj_stress_pids_1_1_100_2 run_cgroup_test_fj.sh stress pids 1 100 2
+cgroup_fj_stress_pids_1_1_100_3 run_cgroup_test_fj.sh stress pids 1 100 3
+cgroup_fj_stress_pids_1_100_1_1 run_cgroup_test_fj.sh stress pids 100 1 1
+cgroup_fj_stress_pids_1_100_1_2 run_cgroup_test_fj.sh stress pids 100 1 2
+cgroup_fj_stress_pids_1_100_1_3 run_cgroup_test_fj.sh stress pids 100 1 3
+cgroup_fj_stress_pids_1_100_100_1 run_cgroup_test_fj.sh stress pids 100 100 1
+cgroup_fj_stress_pids_1_100_100_2 run_cgroup_test_fj.sh stress pids 100 100 2
+cgroup_fj_stress_freezer_1_1_100_1 run_cgroup_test_fj.sh stress freezer 1 100 1
+cgroup_fj_stress_freezer_1_1_100_2 run_cgroup_test_fj.sh stress freezer 1 100 2
+cgroup_fj_stress_freezer_1_1_100_3 run_cgroup_test_fj.sh stress freezer 1 100 3
+cgroup_fj_stress_freezer_1_100_1_1 run_cgroup_test_fj.sh stress freezer 100 1 1
+cgroup_fj_stress_freezer_1_100_1_2 run_cgroup_test_fj.sh stress freezer 100 1 2
+cgroup_fj_stress_freezer_1_100_1_3 run_cgroup_test_fj.sh stress freezer 100 1 3
+cgroup_fj_stress_freezer_1_100_100_1 run_cgroup_test_fj.sh stress freezer 100 100 1
+cgroup_fj_stress_freezer_1_100_100_2 run_cgroup_test_fj.sh stress freezer 100 100 2
+cgroup_fj_stress_devices_1_1_100_1 run_cgroup_test_fj.sh stress devices 1 100 1
+cgroup_fj_stress_devices_1_1_100_2 run_cgroup_test_fj.sh stress devices 1 100 2
+cgroup_fj_stress_devices_1_1_100_3 run_cgroup_test_fj.sh stress devices 1 100 3
+cgroup_fj_stress_devices_1_100_1_1 run_cgroup_test_fj.sh stress devices 100 1 1
+cgroup_fj_stress_devices_1_100_1_2 run_cgroup_test_fj.sh stress devices 100 1 2
+cgroup_fj_stress_devices_1_100_1_3 run_cgroup_test_fj.sh stress devices 100 1 3
+cgroup_fj_stress_devices_1_100_100_1 run_cgroup_test_fj.sh stress devices 100 100 1
+cgroup_fj_stress_devices_1_100_100_2 run_cgroup_test_fj.sh stress devices 100 100 2
 
 controllers	test_controllers.sh
 
diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
index 88cf735..b5b87c6 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
@@ -28,15 +28,13 @@ subsystem=$1			# 1: debug
 				# 4: cpu
 				# 5: cpuacct
 				# 6: memory
-mount_times=$2			#1: execute once
-				#2: execute 100 times
-subgroup_num=$3			#subgroup number in the same hierarchy
+subgroup_num=$2			#subgroup number in the same hierarchy
 				#1: 1
 				#2: 100
-subgroup_hiers=$4		#number of subgroup's hierarchy
+subgroup_hiers=$3		#number of subgroup's hierarchy
 				#1: 1
 				#2: 100
-attach_operation=$5		# 1: attach one process to every subcgroup
+attach_operation=$4		# 1: attach one process to every subcgroup
 				# 2: attach all processes in root group to one subcgroup
 				# 3: attach all processes in root group to every subcgroup
 mounted=1
@@ -44,7 +42,7 @@ mounted=1
 usage()
 {
 	echo "usage of cgroup_fj_stress.sh: "
-	echo "  ./cgroup_fj_stress.sh -subsystem -mount_times -subgroup_num -subgroup_hiers -attach_operation"
+	echo "  ./cgroup_fj_stress.sh -subsystem -subgroup_num -subgroup_hiers -attach_operation"
 	echo "    subsystem's usable number"
 	echo "      debug"
 	echo "      cpuset"
@@ -59,9 +57,6 @@ usage()
 	echo "      net_cls"
 	echo "      net_prio"
 	echo "      pids"
-	echo "    mount_times's usable number"
-	echo "      1: execute once"
-	echo "      100: execute 100 times"
 	echo "    subgroup_num's usable number"
 	echo "      (subgroup number in the same hierarchy)"
 	echo "      1"
@@ -94,7 +89,7 @@ pid=0;
 release_agent_para=1;
 release_agent_echo=1;
 subsystem_str=$subsystem;
-if [ "$?" -ne "0" ] || [ "$#" -ne "5" ]; then
+if [ "$?" -ne "0" ] || [ "$#" -ne "4" ]; then
 	usage;
 	exit_parameter;
 fi
@@ -129,13 +124,6 @@ get_subgroup_path2()
 	done
 }
 
-case $mount_times in
-''|*[!0-9]*)
-	usage
-	exit_parameter;;
-    *) ;;
-esac
-
 case $subgroup_num in
 ''|*[!0-9]*)
 	usage
@@ -179,133 +167,102 @@ if [ "$subsystem" == "cpuset" ]; then
 	fi
 fi
 
-if [ $mount_times -ne 1 ]; then
-	count=0
-	for i in `seq 1 $mount_times`
-	do
-		do_echo 1 1 $pid $mount_point/ltp_subgroup_1/tasks
-		if [ "$subsystem" == "ns" ]; then
-			do_kill 1 1 9 $pid
-			$TESTROOT/cgroup_fj_proc &
-			pid=$!
-		else
-			do_echo 1 1 $pid $mount_point/tasks
+get_subgroup_path2 $subgroup_hiers
+count=0
+pathes[1]=""
+for i in `seq 1 $subgroup_num`
+do
+	get_subgroup_path1 $i
+	do_mkdir 1 1 $cur_subgroup_path1
+	if [ "$subsystem" == "cpuset" ]; then
+		if [ "$exist_cpuset" != "" ]; then
+			do_echo 1 1 "$cpus" "$cur_subgroup_path1""cpuset.cpus";
+			do_echo 1 1 "$mems" "$cur_subgroup_path1""cpuset.mems";
 		fi
-		setup;
-		$TESTROOT/cgroup_fj_proc &
-		pid=$!
-		if [ $mounted -ne 1 ]; then
-			mount_cgroup;
-		fi
-		mkdir_subgroup;
-		if [ "$subsystem" == "cpuset" ]; then
-			if [ "$exist_cpuset" != "" ]; then
-				do_echo 1 1 "$cpus" $mount_point/ltp_subgroup_1/cpuset.cpus;
-				do_echo 1 1 "$mems" $mount_point/ltp_subgroup_1/cpuset.mems;
-			fi
-		fi
-		let "count = $count + 1"
-		echo "$count .. OK"
-	done
-	echo "...executed $count times"
-else
-	get_subgroup_path2 $subgroup_hiers
-	count=0
-	pathes[1]=""
-	for i in `seq 1 $subgroup_num`
+	fi
+	let "count = $count + 1"
+	pathes[$count]="$cur_subgroup_path1"
+	for j in `seq 2 $subgroup_hiers`
 	do
-		get_subgroup_path1 $i
-		do_mkdir 1 1 $cur_subgroup_path1
+		get_subgroup_path2 $j
+		do_mkdir 1 1 "$cur_subgroup_path1""$cur_subgroup_path2" 1
 		if [ "$subsystem" == "cpuset" ]; then
 			if [ "$exist_cpuset" != "" ]; then
-				do_echo 1 1 "$cpus" "$cur_subgroup_path1""cpuset.cpus";
-				do_echo 1 1 "$mems" "$cur_subgroup_path1""cpuset.mems";
+				do_echo 1 1 "$cpus" "$cur_subgroup_path1""$cur_subgroup_path2""cpuset.cpus";
+				do_echo 1 1 "$mems" "$cur_subgroup_path1""$cur_subgroup_path2""cpuset.mems";
 			fi
 		fi
 		let "count = $count + 1"
-		pathes[$count]="$cur_subgroup_path1"
-		for j in `seq 2 $subgroup_hiers`
-		do
-			get_subgroup_path2 $j
-			do_mkdir 1 1 "$cur_subgroup_path1""$cur_subgroup_path2" 1
-			if [ "$subsystem" == "cpuset" ]; then
-				if [ "$exist_cpuset" != "" ]; then
-					do_echo 1 1 "$cpus" "$cur_subgroup_path1""$cur_subgroup_path2""cpuset.cpus";
-					do_echo 1 1 "$mems" "$cur_subgroup_path1""$cur_subgroup_path2""cpuset.mems";
-				fi
-			fi
-			let "count = $count + 1"
-			pathes[$count]="$cur_subgroup_path1""$cur_subgroup_path2"
-		done
+		pathes[$count]="$cur_subgroup_path1""$cur_subgroup_path2"
 	done
-	echo "...mkdired $count times"
+done
+echo "...mkdired $count times"
 
-	sleep 1
+sleep 1
 
-	case $attach_operation in
-	"1" )
-		for i in `seq 1 $count`
-		do
-			do_echo 1 1 $pid "${pathes[$i]}""tasks"
-		done
-		do_echo 1 1 $pid $mount_point/tasks
-		;;
-	"2" )
-		pathes2[0]="$mount_point"
-		pathes2[1]="${pathes[$count]}"
-		pathes2[3]="$mount_point/"
-		for i in `seq 1 $nlines`
+case $attach_operation in
+"1" )
+	for i in `seq 1 $count`
+	do
+		do_echo 1 1 $pid "${pathes[$i]}""tasks"
+	done
+	do_echo 1 1 $pid $mount_point/tasks
+	;;
+"2" )
+	pathes2[0]="$mount_point"
+	pathes2[1]="${pathes[$count]}"
+	pathes2[3]="$mount_point/"
+	for i in `seq 1 $nlines`
+	do
+		j=$i
+		let "j = $j + 1"
+		cat "${pathes2[$i]}tasks" > $TMPFILE
+		nlines=`cat "$TMPFILE" | wc -l`
+		if [ $no_debug -ne 1 ]; then
+			echo "DEBUG: move $nlines processes from "$i"th path to "$j"th"
+		fi
+		for k in `seq 1 $nlines`
 		do
-			j=$i
-			let "j = $j + 1"
-			cat "${pathes2[$i]}tasks" > $TMPFILE
-			nlines=`cat "$TMPFILE" | wc -l`
-			if [ $no_debug -ne 1 ]; then
-				echo "DEBUG: move $nlines processes from "$i"th path to "$j"th"
+			cur_pid=`sed -n "$k""p" $TMPFILE`
+			if [ -e /proc/$cur_pid/ ];then
+				do_echo 0 1 "$cur_pid" "${pathes[$j]}tasks"
 			fi
-			for k in `seq 1 $nlines`
-			do
-				cur_pid=`sed -n "$k""p" $TMPFILE`
-				if [ -e /proc/$cur_pid/ ];then
-					do_echo 0 1 "$cur_pid" "${pathes[$j]}tasks"
-				fi
-			done
 		done
-		;;
-	"3" )
-		count2=$count
-		let "count2 = $count2 + 1"
-		pathes[0]="$mount_point/"
-		pathes[$count2]="$mount_point/"
-		for i in `seq 0 $count`
+	done
+	;;
+"3" )
+	count2=$count
+	let "count2 = $count2 + 1"
+	pathes[0]="$mount_point/"
+	pathes[$count2]="$mount_point/"
+	for i in `seq 0 $count`
+	do
+		j=$i
+		let "j = $j + 1"
+		cat "${pathes[$i]}tasks" > $TMPFILE
+		nlines=`cat "$TMPFILE" | wc -l`
+		if [ $no_debug -ne 1 ]; then
+			echo "DEBUG: move $nlines processes from "$i"th path to "$j"th"
+		fi
+		for k in `seq 1 $nlines`
 		do
-			j=$i
-			let "j = $j + 1"
-			cat "${pathes[$i]}tasks" > $TMPFILE
-			nlines=`cat "$TMPFILE" | wc -l`
-			if [ $no_debug -ne 1 ]; then
-				echo "DEBUG: move $nlines processes from "$i"th path to "$j"th"
+			cur_pid=`sed -n "$k""p" $TMPFILE`
+			if [ -e /proc/$cur_pid/ ];then
+				do_echo 0 1 "$cur_pid" "${pathes[$j]}tasks"
 			fi
-			for k in `seq 1 $nlines`
-			do
-				cur_pid=`sed -n "$k""p" $TMPFILE`
-				if [ -e /proc/$cur_pid/ ];then
-					do_echo 0 1 "$cur_pid" "${pathes[$j]}tasks"
-				fi
-			done
 		done
-		;;
-	*  )
-		;;
-	esac
-	reclaim_foundling;
-	for i in `seq 1 $count`
-	do
-		j=i
-		let "j = $count - $j + 1"
-		do_rmdir 1 1 ${pathes[$j]}
 	done
-fi
+	;;
+*  )
+	;;
+esac
+reclaim_foundling;
+for i in `seq 1 $count`
+do
+	j=i
+	let "j = $count - $j + 1"
+	do_rmdir 1 1 ${pathes[$j]}
+done
 
 do_rmdir 0 1 $mount_point/ltp_subgroup_*
 
-- 
2.1.4

