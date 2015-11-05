From: Cedric Hnyda <chnyda@suse.com>
Date: Thu,  5 Nov 2015 16:27:40 +0100
Subject: [LTP]  [PATCH] runtest/controllers: cgroup_fj tests
Message-ID: <1446737260-23183-1-git-send-email-chnyda@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Removed irrelevant testcases
1) Removed testcases with "all", it is irrelevant to mount all
cgroups when some are already mounted and it is not possible to
mount them several times in newer kernel.
2) Removed "none" testcases. Cannot find what -onone is supposed
to do when cgroups are mounted. Maybe the author confused with
	"mount -t cgroup none /cgroups"

Signed-off-by: Cedric Hnyda <chnyda@suse.com>
---
 runtest/controllers | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/runtest/controllers b/runtest/controllers
index a163cd2..6d9daf4 100644
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
-- 
2.1.4

