Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chnyda@suse.com>) id 1ZZG0A-0000Y6-7m
	for ltp-list@lists.sourceforge.net; Tue, 08 Sep 2015 10:19:46 +0000
Received: from smtp.nue.novell.com ([195.135.221.5])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZZG07-0000Rn-9V
	for ltp-list@lists.sourceforge.net; Tue, 08 Sep 2015 10:19:46 +0000
From: Cedric Hnyda <chnyda@suse.com>
Date: Tue,  8 Sep 2015 12:18:19 +0200
Message-Id: <1441707499-25852-1-git-send-email-chnyda@suse.com>
Subject: [LTP] [PATCH] cgroup_fj: splited the tests to run them separately
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

Signed-off-by: Cedric Hnyda <chnyda@suse.com>
---
 runtest/controllers                                | 197 ++++++++++++++++++++-
 .../controllers/cgroup_fj/cgroup_fj_testcases.sh   | 194 --------------------
 .../controllers/cgroup_fj/run_cgroup_test_fj.sh    |  80 +++++----
 3 files changed, 240 insertions(+), 231 deletions(-)
 delete mode 100644 testcases/kernel/controllers/cgroup_fj/cgroup_fj_testcases.sh

diff --git a/runtest/controllers b/runtest/controllers
index 7ec8ab2..6a819a1 100644
--- a/runtest/controllers
+++ b/runtest/controllers
@@ -10,7 +10,202 @@ memcg_use_hierarchy	memcg_use_hierarchy_test.sh
 memcg_usage_in_bytes	memcg_usage_in_bytes_test.sh
 memcg_stress		memcg_stress_test.sh
 memcg_control		PAGESIZE=$(mem_process -p);memcg_control_test.sh $PAGESIZE $PAGESIZE $((PAGESIZE * 2))
-cgroup_fj	run_cgroup_test_fj.sh
+
+function_debug_yes_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function debug yes yes 1 yes 2 3 2 1
+function_debug_no_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function debug no yes 1 yes 2 3 2 1
+function_debug_yes_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function debug yes yes 2 yes 2 3 2 1
+function_debug_yes_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 2 1
+function_debug_yes_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function debug yes yes 4 yes 2 3 2 1
+function_debug_yes_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function debug yes yes 5 yes 2 3 2 1
+function_debug_yes_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function debug yes yes 6 yes 2 3 2 1
+function_debug_yes_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function debug yes yes 7 yes 2 3 2 1
+function_debug_yes_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function debug yes yes 8 yes 2 3 2 1
+function_cpuset_yes_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuset yes yes 1 yes 2 3 2 1
+function_cpuset_no_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuset no yes 1 yes 2 3 2 1
+function_cpuset_yes_no_1_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuset yes no 1 yes 2 3 2 1
+function_cpuset_yes_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuset yes yes 2 yes 2 3 2 1
+function_cpuset_yes_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuset yes yes 3 yes 2 3 2 1
+function_cpuset_yes_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuset yes yes 4 yes 2 3 2 1
+function_cpuset_yes_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuset yes yes 5 yes 2 3 2 1
+function_cpuset_yes_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuset yes yes 6 yes 2 3 2 1
+function_cpuset_yes_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuset yes yes 7 yes 2 3 2 1
+function_cpuset_yes_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuset yes yes 8 yes 2 3 2 1
+function_ns_yes_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function ns yes yes 1 yes 2 3 2 1
+function_ns_no_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function ns no yes 1 yes 2 3 2 1
+function_ns_yes_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function ns yes yes 2 yes 2 3 2 1
+function_ns_yes_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function ns yes yes 3 yes 2 3 2 1
+function_ns_yes_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function ns yes yes 4 yes 2 3 2 1
+function_ns_yes_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function ns yes yes 5 yes 2 3 2 1
+function_ns_yes_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function ns yes yes 6 yes 2 3 2 1
+function_ns_yes_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function ns yes yes 7 yes 2 3 2 1
+function_ns_yes_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function ns yes yes 8 yes 2 3 2 1
+function_cpu_yes_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function cpu yes yes 1 yes 2 3 2 1
+function_cpu_no_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function cpu no yes 1 yes 2 3 2 1
+function_cpu_yes_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function cpu yes yes 2 yes 2 3 2 1
+function_cpu_yes_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function cpu yes yes 3 yes 2 3 2 1
+function_cpu_yes_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function cpu yes yes 4 yes 2 3 2 1
+function_cpu_yes_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function cpu yes yes 5 yes 2 3 2 1
+function_cpu_yes_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function cpu yes yes 6 yes 2 3 2 1
+function_cpu_yes_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function cpu yes yes 7 yes 2 3 2 1
+function_cpu_yes_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function cpu yes yes 8 yes 2 3 2 1
+function_cpuacct_yes_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuacct yes yes 1 yes 2 3 2 1
+function_cpuacct_no_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuacct no yes 1 yes 2 3 2 1
+function_cpuacct_yes_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuacct yes yes 2 yes 2 3 2 1
+function_cpuacct_yes_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuacct yes yes 3 yes 2 3 2 1
+function_cpuacct_yes_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuacct yes yes 4 yes 2 3 2 1
+function_cpuacct_yes_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuacct yes yes 5 yes 2 3 2 1
+function_cpuacct_yes_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuacct yes yes 6 yes 2 3 2 1
+function_cpuacct_yes_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuacct yes yes 7 yes 2 3 2 1
+function_cpuacct_yes_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function cpuacct yes yes 8 yes 2 3 2 1
+function_memory_yes_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function memory yes yes 1 yes 2 3 2 1
+function_memory_no_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function memory no yes 1 yes 2 3 2 1
+function_memory_yes_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function memory yes yes 2 yes 2 3 2 1
+function_memory_yes_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function memory yes yes 3 yes 2 3 2 1
+function_memory_yes_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function memory yes yes 4 yes 2 3 2 1
+function_memory_yes_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function memory yes yes 5 yes 2 3 2 1
+function_memory_yes_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function memory yes yes 6 yes 2 3 2 1
+function_memory_yes_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function memory yes yes 7 yes 2 3 2 1
+function_memory_yes_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function memory yes yes 8 yes 2 3 2 1
+function_all_yes_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function all yes yes 1 yes 2 3 2 1
+function_all_no_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function all no yes 1 yes 2 3 2 1
+function_all_yes_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function all yes yes 2 yes 2 3 2 1
+function_all_yes_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function all yes yes 3 yes 2 3 2 1
+function_all_yes_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function all yes yes 4 yes 2 3 2 1
+function_all_yes_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function all yes yes 5 yes 2 3 2 1
+function_all_yes_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function all yes yes 6 yes 2 3 2 1
+function_all_yes_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function all yes yes 7 yes 2 3 2 1
+function_all_yes_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function all yes yes 8 yes 2 3 2 1
+function_none_yes_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function none yes yes 1 yes 2 3 2 1
+function_debug,debug_yes_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function debug,debug yes yes 1 yes 2 3 2 1
+function_debug,debug_no_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function debug,debug no yes 1 yes 2 3 2 1
+function_debug,debug_yes_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function debug,debug yes yes 2 yes 2 3 2 1
+function_debug,debug_yes_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function debug,debug yes yes 3 yes 2 3 2 1
+function_debug,debug_yes_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function debug,debug yes yes 4 yes 2 3 2 1
+function_debug,debug_yes_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function debug,debug yes yes 5 yes 2 3 2 1
+function_debug,debug_yes_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function debug,debug yes yes 6 yes 2 3 2 1
+function_debug,debug_yes_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function debug,debug yes yes 7 yes 2 3 2 1
+function_debug,debug_yes_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function debug,debug yes yes 8 yes 2 3 2 1
+function_nonexistent_yes_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function nonexistent yes yes 1 yes 2 3 2 1
+function_freezer_yes_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function freezer yes yes 1 yes 2 3 2 1
+function_freezer_no_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function freezer no yes 1 yes 2 3 2 1
+function_freezer_yes_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function freezer yes yes 2 yes 2 3 2 1
+function_freezer_yes_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function freezer yes yes 3 yes 2 3 2 1
+function_freezer_yes_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function freezer yes yes 4 yes 2 3 2 1
+function_freezer_yes_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function freezer yes yes 5 yes 2 3 2 1
+function_freezer_yes_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function freezer yes yes 6 yes 2 3 2 1
+function_freezer_yes_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function freezer yes yes 7 yes 2 3 2 1
+function_freezer_yes_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function freezer yes yes 8 yes 2 3 2 1
+function_devices_yes_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function devices yes yes 1 yes 2 3 2 1
+function_devices_no_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function devices no yes 1 yes 2 3 2 1
+function_devices_yes_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function devices yes yes 2 yes 2 3 2 1
+function_devices_yes_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function devices yes yes 3 yes 2 3 2 1
+function_devices_yes_yes_4_yes_2_3_2_1 run_cgroup_test_fj.sh function devices yes yes 4 yes 2 3 2 1
+function_devices_yes_yes_5_yes_2_3_2_1 run_cgroup_test_fj.sh function devices yes yes 5 yes 2 3 2 1
+function_devices_yes_yes_6_yes_2_3_2_1 run_cgroup_test_fj.sh function devices yes yes 6 yes 2 3 2 1
+function_devices_yes_yes_7_yes_2_3_2_1 run_cgroup_test_fj.sh function devices yes yes 7 yes 2 3 2 1
+function_devices_yes_yes_8_yes_2_3_2_1 run_cgroup_test_fj.sh function devices yes yes 8 yes 2 3 2 1
+function_debug_yes_yes_1_yes_1_2_1_1 run_cgroup_test_fj.sh function debug yes yes 1 yes 1 2 1 1
+function_debug_yes_yes_1_yes_2_2_1_1 run_cgroup_test_fj.sh function debug yes yes 1 yes 2 2 1 1
+function_debug_yes_yes_1_yes_2_3_1_1 run_cgroup_test_fj.sh function debug yes yes 1 yes 2 3 1 1
+function_debug_yes_yes_1_yes_2_5_1_1 run_cgroup_test_fj.sh function debug yes yes 1 yes 2 5 1 1
+function_debug_yes_yes_1_yes_3_1_1_1 run_cgroup_test_fj.sh function debug yes yes 1 yes 3 1 1 1
+function_debug_yes_yes_1_yes_3_2_1_1 run_cgroup_test_fj.sh function debug yes yes 1 yes 3 2 1 1
+function_debug_yes_yes_1_yes_3_4_1_1 run_cgroup_test_fj.sh function debug yes yes 1 yes 3 4 1 1
+function_debug_yes_yes_1_yes_4_3_1_1 run_cgroup_test_fj.sh function debug yes yes 1 yes 4 3 1 1
+function_debug_yes_yes_1_yes_4_5_1_1 run_cgroup_test_fj.sh function debug yes yes 1 yes 4 5 1 1
+function_debug_yes_yes_1_no_1_1_1_1 run_cgroup_test_fj.sh function debug yes yes 1 no 1 1 1 1
+function_debug_yes_yes_1_yes_1_1_1_1 run_cgroup_test_fj.sh function debug yes yes 1 yes 1 1 1 1
+function_debug_yes_yes_1_yes_1_3_2_1 run_cgroup_test_fj.sh function debug yes yes 1 yes 1 3 2 1
+function_debug_yes_yes_1_yes_2_3_2_2 run_cgroup_test_fj.sh function debug yes yes 1 yes 2 3 2 2
+function_debug_yes_yes_1_yes_2_3_2_3 run_cgroup_test_fj.sh function debug yes yes 1 yes 2 3 2 3
+function_debug_yes_yes_1_yes_2_3_2_4 run_cgroup_test_fj.sh function debug yes yes 1 yes 2 3 2 4
+function_debug_yes_yes_1_yes_2_3_2_5 run_cgroup_test_fj.sh function debug yes yes 1 yes 2 3 2 5
+function_debug_yes_yes_1_yes_2_3_2_6 run_cgroup_test_fj.sh function debug yes yes 1 yes 2 3 2 6
+function_debug_yes_yes_1_yes_2_3_2_7 run_cgroup_test_fj.sh function debug yes yes 1 yes 2 3 2 7
+function_debug_yes_yes_1_yes_2_3_3_2 run_cgroup_test_fj.sh function debug yes yes 1 yes 2 3 3 2
+function_debug_yes_yes_1_yes_2_3_4_2 run_cgroup_test_fj.sh function debug yes yes 1 yes 2 3 4 2
+function_debug_yes_yes_1_yes_2_3_5_2 run_cgroup_test_fj.sh function debug yes yes 1 yes 2 3 5 2
+function_debug_yes_yes_1_yes_2_3_6_2 run_cgroup_test_fj.sh function debug yes yes 1 yes 2 3 6 2
+function_debug_yes_yes_1_yes_2_3_7_2 run_cgroup_test_fj.sh function debug yes yes 1 yes 2 3 7 2
+function_debug_yes_yes_2_yes_2_3_2_2 run_cgroup_test_fj.sh function debug yes yes 2 yes 2 3 2 2
+function_debug_yes_yes_3_yes_2_3_1_1 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 1 1
+function_debug_yes_yes_3_yes_2_3_1_2 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 1 2
+function_debug_yes_yes_3_yes_2_3_1_3 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 1 3
+function_debug_yes_yes_3_yes_2_3_2_1 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 2 1
+function_debug_yes_yes_3_yes_2_3_2_2 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 2 2
+function_debug_yes_yes_3_yes_2_3_2_3 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 2 3
+function_debug_yes_yes_3_yes_2_3_2_4 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 2 4
+function_debug_yes_yes_3_yes_2_3_2_5 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 2 5
+function_debug_yes_yes_3_yes_2_3_2_6 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 2 6
+function_debug_yes_yes_3_yes_2_3_2_7 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 2 7
+function_debug_yes_yes_3_yes_2_3_3_1 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 3 1
+function_debug_yes_yes_3_yes_2_3_3_2 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 3 2
+function_debug_yes_yes_3_yes_2_3_3_3 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 3 3
+function_debug_yes_yes_3_yes_2_3_4_2 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 4 2
+function_debug_yes_yes_3_yes_2_3_5_2 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 5 2
+function_debug_yes_yes_3_yes_2_3_6_2 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 6 2
+function_debug_yes_yes_3_yes_2_3_7_2 run_cgroup_test_fj.sh function debug yes yes 3 yes 2 3 7 2
+function2_1 run_cgroup_test_fj.sh function2 1
+function2_2 run_cgroup_test_fj.sh function2 2
+function2_3 run_cgroup_test_fj.sh function2 3
+function2_4 run_cgroup_test_fj.sh function2 4
+function2_5 run_cgroup_test_fj.sh function2 5
+function2_6 run_cgroup_test_fj.sh function2 6
+function2_7 run_cgroup_test_fj.sh function2 7
+function2_8 run_cgroup_test_fj.sh function2 8
+function2_9 run_cgroup_test_fj.sh function2 9
+function2_10 run_cgroup_test_fj.sh function2 10
+function2_11 run_cgroup_test_fj.sh function2 11
+function2_12 run_cgroup_test_fj.sh function2 12
+function2_13 run_cgroup_test_fj.sh function2 13
+stress_debug_100_1_1_1 run_cgroup_test_fj.sh stress debug 100 1 1 1
+stress_cpuset_100_1_1_1 run_cgroup_test_fj.sh stress cpuset 100 1 1 1
+stress_ns_100_1_1_1 run_cgroup_test_fj.sh stress ns 100 1 1 1
+stress_cpu_100_1_1_1 run_cgroup_test_fj.sh stress cpu 100 1 1 1
+stress_cpuacct_100_1_1_1 run_cgroup_test_fj.sh stress cpuacct 100 1 1 1
+stress_memory_100_1_1_1 run_cgroup_test_fj.sh stress memory 100 1 1 1
+stress_all_100_1_1_1 run_cgroup_test_fj.sh stress all 100 1 1 1
+stress_debug_1_1_1_2 run_cgroup_test_fj.sh stress debug 1 1 1 2
+stress_debug_1_1_100_1 run_cgroup_test_fj.sh stress debug 1 1 100 1
+stress_debug_1_1_100_2 run_cgroup_test_fj.sh stress debug 1 1 100 2
+stress_debug_1_1_100_3 run_cgroup_test_fj.sh stress debug 1 1 100 3
+stress_debug_1_100_1_1 run_cgroup_test_fj.sh stress debug 1 100 1 1
+stress_debug_1_100_1_2 run_cgroup_test_fj.sh stress debug 1 100 1 2
+stress_debug_1_100_1_3 run_cgroup_test_fj.sh stress debug 1 100 1 3
+stress_debug_1_100_100_1 run_cgroup_test_fj.sh stress debug 1 100 100 1
+stress_debug_1_100_100_2 run_cgroup_test_fj.sh stress debug 1 100 100 2
+stress_cpuset_1_1_1_2 run_cgroup_test_fj.sh stress cpuset 1 1 1 2
+stress_cpuset_1_1_100_1 run_cgroup_test_fj.sh stress cpuset 1 1 100 1
+stress_cpuset_1_1_100_2 run_cgroup_test_fj.sh stress cpuset 1 1 100 2
+stress_cpuset_1_1_100_3 run_cgroup_test_fj.sh stress cpuset 1 1 100 3
+stress_cpuset_1_100_1_1 run_cgroup_test_fj.sh stress cpuset 1 100 1 1
+stress_cpuset_1_100_1_2 run_cgroup_test_fj.sh stress cpuset 1 100 1 2
+stress_cpuset_1_100_1_3 run_cgroup_test_fj.sh stress cpuset 1 100 1 3
+stress_cpuset_1_100_100_1 run_cgroup_test_fj.sh stress cpuset 1 100 100 1
+stress_cpuset_1_100_100_2 run_cgroup_test_fj.sh stress cpuset 1 100 100 2
+stress_cpu_1_1_1_2 run_cgroup_test_fj.sh stress cpu 1 1 1 2
+stress_cpu_1_100_1_1 run_cgroup_test_fj.sh stress cpu 1 100 1 1
+stress_cpu_1_100_1_2 run_cgroup_test_fj.sh stress cpu 1 100 1 2
+stress_cpu_1_100_1_3 run_cgroup_test_fj.sh stress cpu 1 100 1 3
+stress_cpuacct_1_1_1_2 run_cgroup_test_fj.sh stress cpuacct 1 1 1 2
+stress_cpuacct_1_1_100_1 run_cgroup_test_fj.sh stress cpuacct 1 1 100 1
+stress_cpuacct_1_1_100_2 run_cgroup_test_fj.sh stress cpuacct 1 1 100 2
+stress_cpuacct_1_1_100_3 run_cgroup_test_fj.sh stress cpuacct 1 1 100 3
+stress_cpuacct_1_100_1_1 run_cgroup_test_fj.sh stress cpuacct 1 100 1 1
+stress_cpuacct_1_100_1_2 run_cgroup_test_fj.sh stress cpuacct 1 100 1 2
+stress_cpuacct_1_100_1_3 run_cgroup_test_fj.sh stress cpuacct 1 100 1 3
+stress_cpuacct_1_100_100_1 run_cgroup_test_fj.sh stress cpuacct 1 100 100 1
+stress_cpuacct_1_100_100_2 run_cgroup_test_fj.sh stress cpuacct 1 100 100 2
+stress_memory_1_1_1_2 run_cgroup_test_fj.sh stress memory 1 1 1 2
+stress_memory_1_1_100_1 run_cgroup_test_fj.sh stress memory 1 1 100 1
+stress_memory_1_1_100_2 run_cgroup_test_fj.sh stress memory 1 1 100 2
+stress_memory_1_1_100_3 run_cgroup_test_fj.sh stress memory 1 1 100 3
+stress_memory_1_100_1_1 run_cgroup_test_fj.sh stress memory 1 100 1 1
+stress_memory_1_100_1_2 run_cgroup_test_fj.sh stress memory 1 100 1 2
+stress_memory_1_100_1_3 run_cgroup_test_fj.sh stress memory 1 100 1 3
+stress_memory_1_100_100_1 run_cgroup_test_fj.sh stress memory 1 100 100 1
+stress_memory_1_100_100_2 run_cgroup_test_fj.sh stress memory 1 100 100 2
+
 controllers	test_controllers.sh
 
 cpuset_base_ops	cpuset_base_ops_testset.sh
diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_testcases.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_testcases.sh
deleted file mode 100644
index a03918a..0000000
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_testcases.sh
+++ /dev/null
@@ -1,194 +0,0 @@
-function	debug yes yes 1 yes 2 3 2 1
-function	debug no yes 1 yes 2 3 2 1
-function	debug yes yes 2 yes 2 3 2 1
-function	debug yes yes 3 yes 2 3 2 1
-function	debug yes yes 4 yes 2 3 2 1
-function	debug yes yes 5 yes 2 3 2 1
-function	debug yes yes 6 yes 2 3 2 1
-function	debug yes yes 7 yes 2 3 2 1
-function	debug yes yes 8 yes 2 3 2 1
-function	cpuset yes yes 1 yes 2 3 2 1
-function	cpuset no yes 1 yes 2 3 2 1
-function	cpuset yes no 1 yes 2 3 2 1
-function	cpuset yes yes 2 yes 2 3 2 1
-function	cpuset yes yes 3 yes 2 3 2 1
-function	cpuset yes yes 4 yes 2 3 2 1
-function	cpuset yes yes 5 yes 2 3 2 1
-function	cpuset yes yes 6 yes 2 3 2 1
-function	cpuset yes yes 7 yes 2 3 2 1
-function	cpuset yes yes 8 yes 2 3 2 1
-function	ns yes yes 1 yes 2 3 2 1
-function	ns no yes 1 yes 2 3 2 1
-function	ns yes yes 2 yes 2 3 2 1
-function	ns yes yes 3 yes 2 3 2 1
-function	ns yes yes 4 yes 2 3 2 1
-function	ns yes yes 5 yes 2 3 2 1
-function	ns yes yes 6 yes 2 3 2 1
-function	ns yes yes 7 yes 2 3 2 1
-function	ns yes yes 8 yes 2 3 2 1
-function	cpu yes yes 1 yes 2 3 2 1
-function	cpu no yes 1 yes 2 3 2 1
-function	cpu yes yes 2 yes 2 3 2 1
-function	cpu yes yes 3 yes 2 3 2 1
-function	cpu yes yes 4 yes 2 3 2 1
-function	cpu yes yes 5 yes 2 3 2 1
-function	cpu yes yes 6 yes 2 3 2 1
-function	cpu yes yes 7 yes 2 3 2 1
-function	cpu yes yes 8 yes 2 3 2 1
-function	cpuacct yes yes 1 yes 2 3 2 1
-function	cpuacct no yes 1 yes 2 3 2 1
-function	cpuacct yes yes 2 yes 2 3 2 1
-function	cpuacct yes yes 3 yes 2 3 2 1
-function	cpuacct yes yes 4 yes 2 3 2 1
-function	cpuacct yes yes 5 yes 2 3 2 1
-function	cpuacct yes yes 6 yes 2 3 2 1
-function	cpuacct yes yes 7 yes 2 3 2 1
-function	cpuacct yes yes 8 yes 2 3 2 1
-function	memory yes yes 1 yes 2 3 2 1
-function	memory no yes 1 yes 2 3 2 1
-function	memory yes yes 2 yes 2 3 2 1
-function	memory yes yes 3 yes 2 3 2 1
-function	memory yes yes 4 yes 2 3 2 1
-function	memory yes yes 5 yes 2 3 2 1
-function	memory yes yes 6 yes 2 3 2 1
-function	memory yes yes 7 yes 2 3 2 1
-function	memory yes yes 8 yes 2 3 2 1
-function	all yes yes 1 yes 2 3 2 1
-function	all no yes 1 yes 2 3 2 1
-function	all yes yes 2 yes 2 3 2 1
-function	all yes yes 3 yes 2 3 2 1
-function	all yes yes 4 yes 2 3 2 1
-function	all yes yes 5 yes 2 3 2 1
-function	all yes yes 6 yes 2 3 2 1
-function	all yes yes 7 yes 2 3 2 1
-function	all yes yes 8 yes 2 3 2 1
-function	none yes yes 1 yes 2 3 2 1
-function	debug,debug yes yes 1 yes 2 3 2 1
-function	debug,debug no yes 1 yes 2 3 2 1
-function	debug,debug yes yes 2 yes 2 3 2 1
-function	debug,debug yes yes 3 yes 2 3 2 1
-function	debug,debug yes yes 4 yes 2 3 2 1
-function	debug,debug yes yes 5 yes 2 3 2 1
-function	debug,debug yes yes 6 yes 2 3 2 1
-function	debug,debug yes yes 7 yes 2 3 2 1
-function	debug,debug yes yes 8 yes 2 3 2 1
-function	nonexistent yes yes 1 yes 2 3 2 1
-function	freezer yes yes 1 yes 2 3 2 1
-function	freezer no yes 1 yes 2 3 2 1
-function	freezer yes yes 2 yes 2 3 2 1
-function	freezer yes yes 3 yes 2 3 2 1
-function	freezer yes yes 4 yes 2 3 2 1
-function	freezer yes yes 5 yes 2 3 2 1
-function	freezer yes yes 6 yes 2 3 2 1
-function	freezer yes yes 7 yes 2 3 2 1
-function	freezer yes yes 8 yes 2 3 2 1
-function	devices yes yes 1 yes 2 3 2 1
-function	devices no yes 1 yes 2 3 2 1
-function	devices yes yes 2 yes 2 3 2 1
-function	devices yes yes 3 yes 2 3 2 1
-function	devices yes yes 4 yes 2 3 2 1
-function	devices yes yes 5 yes 2 3 2 1
-function	devices yes yes 6 yes 2 3 2 1
-function	devices yes yes 7 yes 2 3 2 1
-function	devices yes yes 8 yes 2 3 2 1
-function	debug yes yes 1 yes 1 2 1 1
-function	debug yes yes 1 yes 2 2 1 1
-function	debug yes yes 1 yes 2 3 1 1
-function	debug yes yes 1 yes 2 5 1 1
-function	debug yes yes 1 yes 3 1 1 1
-function	debug yes yes 1 yes 3 2 1 1
-function	debug yes yes 1 yes 3 4 1 1
-function	debug yes yes 1 yes 4 3 1 1
-function	debug yes yes 1 yes 4 5 1 1
-function	debug yes yes 1 no 1 1 1 1
-function	debug yes yes 1 yes 1 1 1 1
-function	debug yes yes 1 yes 1 3 2 1
-function	debug yes yes 1 yes 2 3 2 2
-function	debug yes yes 1 yes 2 3 2 3
-function	debug yes yes 1 yes 2 3 2 4
-function	debug yes yes 1 yes 2 3 2 5
-function	debug yes yes 1 yes 2 3 2 6
-function	debug yes yes 1 yes 2 3 2 7
-function	debug yes yes 1 yes 2 3 3 2
-function	debug yes yes 1 yes 2 3 4 2
-function	debug yes yes 1 yes 2 3 5 2
-function	debug yes yes 1 yes 2 3 6 2
-function	debug yes yes 1 yes 2 3 7 2
-function	debug yes yes 2 yes 2 3 2 2
-function	debug yes yes 3 yes 2 3 1 1
-function	debug yes yes 3 yes 2 3 1 2
-function	debug yes yes 3 yes 2 3 1 3
-function	debug yes yes 3 yes 2 3 2 1
-function	debug yes yes 3 yes 2 3 2 2
-function	debug yes yes 3 yes 2 3 2 3
-function	debug yes yes 3 yes 2 3 2 4
-function	debug yes yes 3 yes 2 3 2 5
-function	debug yes yes 3 yes 2 3 2 6
-function	debug yes yes 3 yes 2 3 2 7
-function	debug yes yes 3 yes 2 3 3 1
-function	debug yes yes 3 yes 2 3 3 2
-function	debug yes yes 3 yes 2 3 3 3
-function	debug yes yes 3 yes 2 3 4 2
-function	debug yes yes 3 yes 2 3 5 2
-function	debug yes yes 3 yes 2 3 6 2
-function	debug yes yes 3 yes 2 3 7 2
-function2	1
-function2	2
-function2	3
-function2	4
-function2	5
-function2	6
-function2	7
-function2	8
-function2	9
-function2	10
-function2	11
-function2	12
-function2	13
-stress	debug 100 1 1 1
-stress	cpuset 100 1 1 1
-stress	ns 100 1 1 1
-stress	cpu 100 1 1 1
-stress	cpuacct 100 1 1 1
-stress	memory 100 1 1 1
-stress	all 100 1 1 1
-stress	debug 1 1 1 2
-stress	debug 1 1 100 1
-stress	debug 1 1 100 2
-stress	debug 1 1 100 3
-stress	debug 1 100 1 1
-stress	debug 1 100 1 2
-stress	debug 1 100 1 3
-stress	debug 1 100 100 1
-stress	debug 1 100 100 2
-stress	cpuset 1 1 1 2
-stress	cpuset 1 1 100 1
-stress	cpuset 1 1 100 2
-stress	cpuset 1 1 100 3
-stress	cpuset 1 100 1 1
-stress	cpuset 1 100 1 2
-stress	cpuset 1 100 1 3
-stress	cpuset 1 100 100 1
-stress	cpuset 1 100 100 2
-stress	cpu 1 1 1 2
-stress	cpu 1 100 1 1
-stress	cpu 1 100 1 2
-stress	cpu 1 100 1 3
-stress	cpuacct 1 1 1 2
-stress	cpuacct 1 1 100 1
-stress	cpuacct 1 1 100 2
-stress	cpuacct 1 1 100 3
-stress	cpuacct 1 100 1 1
-stress	cpuacct 1 100 1 2
-stress	cpuacct 1 100 1 3
-stress	cpuacct 1 100 100 1
-stress	cpuacct 1 100 100 2
-stress	memory 1 1 1 2
-stress	memory 1 1 100 1
-stress	memory 1 1 100 2
-stress	memory 1 1 100 3
-stress	memory 1 100 1 1
-stress	memory 1 100 1 2
-stress	memory 1 100 1 3
-stress	memory 1 100 100 1
-stress	memory 1 100 100 2
\ No newline at end of file
diff --git a/testcases/kernel/controllers/cgroup_fj/run_cgroup_test_fj.sh b/testcases/kernel/controllers/cgroup_fj/run_cgroup_test_fj.sh
index f0b43b8..ed21dc0 100755
--- a/testcases/kernel/controllers/cgroup_fj/run_cgroup_test_fj.sh
+++ b/testcases/kernel/controllers/cgroup_fj/run_cgroup_test_fj.sh
@@ -23,8 +23,18 @@
 ################################################################################
 cd $LTPROOT/testcases/bin
 
-export TCID="cgroup_test_fj"
-export TST_TOTAL=194
+
+cnt=1
+for arg; do
+	if [ $cnt -gt 1 ]; then
+		NAME+="_"
+		NAME+=$arg
+	fi
+	cnt=$(( $cnt + 1 ))
+done
+
+export TCID=$1$NAME
+export TST_TOTAL=1
 export TST_COUNT=1
 
 export TESTROOT=`pwd`
@@ -86,47 +96,45 @@ if [ "$SYBSYSCOMPILED" = "" ];then	# Warning and exit if all cgroup subsystem ar
 	exit -2;
 fi
 
-echo "Now, we start the test for cgroup...";
-
 rm -f $LOGFILE 2>/dev/null
 echo `date` > $LOGFILE
 echo `uname -a` >> $LOGFILE
 
 echo "" >> $LOGFILE
-echo "Now, we start the test for basic function of cgroup..." >> $LOGFILE
-
-nlines=`cat cgroup_fj_testcases.sh | wc -l`
-for i in `seq 1 $nlines`
-do
-	CASETYPE=`sed -n "$i""p" cgroup_fj_testcases.sh | cut -f1`
-	CASECMD=`sed -n "$i""p" cgroup_fj_testcases.sh | cut -f2`
-	echo $CASETYPE | grep "#"
-	if [ $? -ne 0 ]; then
-		case $CASETYPE in
-		"function" )
-			: $(( CASENO1 += 1 ))
-			export CASENO1=$CASENO1
-			$TESTROOT/cgroup_fj_function.sh $CASECMD
-			;;
-		"function2" )
-			: $(( CASENO1 += 1 ))
-			export CASENO1=$CASENO1
-			$TESTROOT/cgroup_fj_function2.sh $CASECMD
-			;;
-		"stress" )
-			: $(( CASENO2 += 1 ))
-			export CASENO2=$CASENO2
-			$TESTROOT/cgroup_fj_stress.sh $CASECMD
-			;;
-		esac
 
-		ret=$?
-		if [ $ret -eq 0 ]; then
-			tst_resm TPASS "case$i(`sed -n "$i""p" cgroup_fj_testcases.sh`)    PASS"
-		elif [ $ret -ne 9 ]; then
-			tst_resm TFAIL "case$i(`sed -n "$i""p" cgroup_fj_testcases.sh`)    FAIL"
-		fi
+CASETYPE=$1
+CASECMD=""
+cnt=1
+for arg; do
+	if [ $cnt -gt 1 ]; then
+		CASECMD+=" "
+		CASECMD+=$arg
 	fi
+	cnt=$(( $cnt + 1 ))
 done
+case $CASETYPE in
+"function" )
+	: $(( CASENO1 += 1 ))
+	export CASENO1=$CASENO1
+	$TESTROOT/cgroup_fj_function.sh $CASECMD
+	;;
+"function2" )
+	: $(( CASENO1 += 1 ))
+	export CASENO1=$CASENO1
+	$TESTROOT/cgroup_fj_function2.sh $CASECMD
+	;;
+"stress" )
+	: $(( CASENO2 += 1 ))
+	export CASENO2=$CASENO2
+	$TESTROOT/cgroup_fj_stress.sh $CASECMD
+	;;
+esac
+
+ret=$?
+if [ $ret -eq 0 ]; then
+	tst_resm TPASS "case$i($CASETYPE$CASECMD)    PASS"
+elif [ $ret -ne 9 ]; then
+	tst_resm TFAIL "case$i($CASETYPE$CASECMD)    FAIL"
+fi
 
 exit $ret;
-- 
2.1.4


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
