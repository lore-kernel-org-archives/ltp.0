Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chnyda@suse.com>) id 1ZZg7R-0003Zd-7A
	for ltp-list@lists.sourceforge.net; Wed, 09 Sep 2015 14:13:01 +0000
Received: from smtp.nue.novell.com ([195.135.221.5])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZZg7N-0004ou-N9
	for ltp-list@lists.sourceforge.net; Wed, 09 Sep 2015 14:13:01 +0000
From: Cedric Hnyda <chnyda@suse.com>
Date: Wed,  9 Sep 2015 16:11:40 +0200
Message-Id: <1441807900-5570-1-git-send-email-chnyda@suse.com>
Subject: [LTP] [PATCH V2] cgroup_fj: split the tests to run them separately
	and removed the LOGFILE
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
 .../controllers/cgroup_fj/cgroup_fj_function.sh    |  14 +-
 .../controllers/cgroup_fj/cgroup_fj_function2.sh   |  15 +-
 .../controllers/cgroup_fj/cgroup_fj_stress.sh      |  19 +-
 .../controllers/cgroup_fj/cgroup_fj_testcases.sh   | 194 --------------------
 .../controllers/cgroup_fj/cgroup_fj_utility.sh     |  76 ++++----
 .../controllers/cgroup_fj/run_cgroup_test_fj.sh    |  82 ++++-----
 7 files changed, 295 insertions(+), 302 deletions(-)
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
diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
index 673a942..2202708 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
@@ -120,23 +120,21 @@ usage()
 }
 
 export TESTROOT=`pwd`
-if [ "$LOGFILE" = "" ]; then
-	LOGFILE="/dev/stdout"
-fi
+
 export TMPFILE=$TESTROOT/tmp_tasks
 
 . $TESTROOT/cgroup_fj_utility.sh
 
 ##########################  main   #######################
 if [ "$#" -ne "9" ]; then
-	echo "ERROR: Wrong inputed parameter..Exiting test" >> $LOGFILE;
+	echo "ERROR: Wrong inputed parameter..Exiting test";
 	usage;
 	exit -1;
 fi
 
-echo "-------------------------------------------------------------------------" >> $LOGFILE
-echo "case no : $CASENO1" >> $LOGFILE
-echo `date` >> $LOGFILE
+echo "-------------------------------------------------------------------------"
+echo "case no : $CASENO1"
+echo `date`
 
 check_para;
 if [ $? -ne 0 ]; then
@@ -145,7 +143,7 @@ if [ $? -ne 0 ]; then
 fi
 setup;
 
-echo "INFO: now we begin to test no $CASENO1 ..." >> $LOGFILE
+echo "INFO: now we begin to test no $CASENO1 ..."
 
 mount_cgroup;
 
diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function2.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function2.sh
index 2b47df1..57d131d 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function2.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function2.sh
@@ -10,7 +10,7 @@
 ## (at your option) any later version.                                        ##
 ##                                                                            ##
 ## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+## WITHOUT ANY WARRANTY; without evsen the implied warranty of MERCHANTABILITY ##
 ## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
 ## for more details.                                                          ##
 ##                                                                            ##
@@ -45,14 +45,11 @@ usage()
 
 exit_parameter()
 {
-	echo "ERROR: Wrong inputed parameter..Exiting test" >> $LOGFILE
+	echo "ERROR: Wrong inputed parameter..Exiting test"
 	exit -1;
 }
 
 export TESTROOT=`pwd`
-if [ "$LOGFILE" = "" ]; then
-	LOGFILE="/dev/stdout"
-fi
 export TMPFILE=$TESTROOT/tmp_tasks
 
 . $TESTROOT/cgroup_fj_utility.sh
@@ -303,14 +300,14 @@ if [ "$#" -ne "1" ] || [ $caseno -lt 1 ] || [ $caseno -gt 13 ]; then
 	exit_parameter;
 fi
 
-echo "-------------------------------------------------------------------------" >> $LOGFILE
-echo "case no : $CASENO1" >> $LOGFILE
-echo `date` >> $LOGFILE
+echo "-------------------------------------------------------------------------"
+echo "case no : $CASENO1"
+echo `date`
 
 exist_subsystem "debug"
 setup;
 
-echo "INFO: now we begin to test no $CASENO1 ..." >> $LOGFILE
+echo "INFO: now we begin to test no $CASENO1 ..."
 
 if [ $caseno -lt 3 ] || [ $caseno -gt 6 ]; then
 	mount_cgroup;
diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
index 972a717..fd9fa2a 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
@@ -76,14 +76,11 @@ usage()
 
 exit_parameter()
 {
-	echo "ERROR: Wrong inputed parameter..Exiting test" >> $LOGFILE
+	echo "ERROR: Wrong inputed parameter..Exiting test"
 	exit -1;
 }
 
 export TESTROOT=`pwd`
-if [ "$LOGFILE" = "" ]; then
-	LOGFILE="/dev/stdout"
-fi
 export TMPFILE=$TESTROOT/tmp_tasks
 
 . $TESTROOT/cgroup_fj_utility.sh
@@ -150,13 +147,13 @@ case $subgroup_hiers in
 esac
 
 ##########################  main   #######################
-echo "-------------------------------------------------------------------------" >> $LOGFILE
-echo "case no : $CASENO2" >> $LOGFILE
-echo `date` >> $LOGFILE
+echo "-------------------------------------------------------------------------"
+echo "case no : $CASENO2"
+echo `date`
 
 setup;
 
-echo "INFO: now we begin to stress test no $CASENO2 ..." >> $LOGFILE
+echo "INFO: now we begin to stress test no $CASENO2 ..."
 
 mount_cgroup;
 
@@ -209,9 +206,9 @@ if [ $mount_times -ne 1 ]; then
 			fi
 		fi
 		let "count = $count + 1"
-		echo "$count .. OK" >> $LOGFILE
+		echo "$count .. OK"
 	done
-	echo "...executed $count times" >> $LOGFILE
+	echo "...executed $count times"
 else
 	get_subgroup_path2 $subgroup_hiers
 	count=0
@@ -242,7 +239,7 @@ else
 			pathes[$count]="$cur_subgroup_path1""$cur_subgroup_path2"
 		done
 	done
-	echo "...mkdired $count times" >> $LOGFILE
+	echo "...mkdired $count times"
 
 	sleep 1
 
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
diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
index 1e2e521..75c0dcb 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
@@ -228,7 +228,7 @@ get_release_agent()
 do_exit()
 {
 	if [ "$#" -ne "3" ]; then
-		echo "ERROR: exit failed,your parameter is wrong..Exiting test" >> $LOGFILE
+		echo "ERROR: exit failed,your parameter is wrong..Exiting test"
 		exit -1
 	fi
 
@@ -238,7 +238,7 @@ do_exit()
 
 	if [ $exit_status -eq 0 ] ;then
 		if [ $expectted -lt 1 ]; then
-			echo "								against with expectted" >> $LOGFILE
+			echo "								against with expectted"
 			if [ $exit_here -ge 1 ]; then
 				cleanup;
 				exit -1
@@ -246,7 +246,7 @@ do_exit()
 		fi
 	else
 		if [ $expectted -ge 1 ]; then
-			echo "								against with expectted" >> $LOGFILE
+			echo "								against with expectted"
 			if [ $exit_here -ge 1 ]; then
 				cleanup;
 				exit -1
@@ -263,7 +263,7 @@ do_exit()
 do_echo()
 {
 	if [ "$#" -ne "4" ]; then
-		echo "ERROR: echo failed,your parameter is wrong..Exiting test" >> $LOGFILE
+		echo "ERROR: echo failed,your parameter is wrong..Exiting test"
 		exit -1
 	fi
 
@@ -274,20 +274,20 @@ do_echo()
 
 	if [ $no_debug -ne 1 ]; then
 		if [ $expectted -ge 1 ]; then
-			echo "\"echo $value > $target\" (expectted: success)" >> $LOGFILE
+			echo "\"echo $value > $target\" (expectted: success)"
 		else
-			echo "\"echo $value > $target\" (expectted: fail)" >> $LOGFILE
+			echo "\"echo $value > $target\" (expectted: fail)"
 		fi
 	fi
 
-	`echo $value > $target` >> $LOGFILE 2>&1
+	`echo $value > $target`
 	do_exit $exit_here $expectted $?;
 }
 
 do_mkdir()
 {
 	if [ "$#" -ne "3" ] && [ "$#" -ne "4" ]; then
-		echo "ERROR: mkdir failed,your parameter is wrong..Exiting test" >> $LOGFILE
+		echo "ERROR: mkdir failed,your parameter is wrong..Exiting test"
 		exit -1
 	fi
 
@@ -301,9 +301,9 @@ do_mkdir()
 
 	if [ $no_debug -ne 1 ]; then
 		if [ $expectted -ge 1 ]; then
-			echo "\"mkdir $target\" (expectted: success)" >> $LOGFILE
+			echo "\"mkdir $target\" (expectted: success)"
 		else
-			echo "\"mkdir $target\" (expectted: fail)" >> $LOGFILE
+			echo "\"mkdir $target\" (expectted: fail)"
 		fi
 	fi
 
@@ -312,9 +312,9 @@ do_mkdir()
 	fi
 
 	if [ $parents -ne "1" ]; then
-		mkdir $target >> $LOGFILE 2>&1
+		mkdir $target
 	else
-		mkdir -p $target >> $LOGFILE 2>&1
+		mkdir -p $target
 	fi
 	do_exit $exit_here $expectted $?;
 }
@@ -322,7 +322,7 @@ do_mkdir()
 do_rmdir()
 {
 	if [ "$#" -lt "3" ]; then
-		echo "ERROR: rmdir failed,your parameter is wrong..Exiting test" >> $LOGFILE
+		echo "ERROR: rmdir failed,your parameter is wrong..Exiting test"
 		exit -1
 	fi
 
@@ -331,26 +331,26 @@ do_rmdir()
 	target=$3
 
 	if ! [ -e $target ]; then
-		echo "INFO: $target is not exist" >> $LOGFILE
+		echo "INFO: $target is not exist"
 		return
 	fi
 
 	if [ $no_debug -ne 1 ]; then
 		if [ $expectted -ge 1 ]; then
-			echo "\"rmdir $target\" (expectted: success)" >> $LOGFILE
+			echo "\"rmdir $target\" (expectted: success)"
 		else
-			echo "\"rmdir $target\" (expectted: fail)" >> $LOGFILE
+			echo "\"rmdir $target\" (expectted: fail)"
 		fi
 	fi
 
-	rmdir $3 $4 $5 >> $LOGFILE 2>&1
+	rmdir $3 $4 $5
 	do_exit $exit_here $expectted $?;
 }
 
 do_mount()
 {
 	if [ "$#" -ne "4" ] && [ "$#" -ne "5" ] ; then
-		echo "ERROR: mount failed,your parameter is wrong..Exiting test" >> $LOGFILE
+		echo "ERROR: mount failed,your parameter is wrong..Exiting test"
 		exit -1
 	fi
 
@@ -365,20 +365,20 @@ do_mount()
 
 	if [ $no_debug -ne 1 ]; then
 		if [ $expectted -ge 1 ]; then
-			echo "\"mount -t cgroup $para_o $something $target\" (expectted: success)" >> $LOGFILE
+			echo "\"mount -t cgroup $para_o $something $target\" (expectted: success)"
 		else
-			echo "\"mount -t cgroup $para_o $something $target\" (expectted: fail)" >> $LOGFILE
+			echo "\"mount -t cgroup $para_o $something $target\" (expectted: fail)"
 		fi
 	fi
 
-	mount -t cgroup $para_o $something $target >> $LOGFILE 2>&1
+	mount -t cgroup $para_o $something $target
 	do_exit $exit_here $expectted $?;
 }
 
 do_umount()
 {
 	if [ "$#" -ne "3" ]; then
-		echo "ERROR: umount failed,your parameter is wrong..Exiting test" >> $LOGFILE
+		echo "ERROR: umount failed,your parameter is wrong..Exiting test"
 		exit -1
 	fi
 
@@ -388,20 +388,20 @@ do_umount()
 
 	if [ $no_debug -ne 1 ]; then
 		if [ $expectted -ge 1 ]; then
-			echo "\"umount $target\" (expectted: success)" >> $LOGFILE
+			echo "\"umount $target\" (expectted: success)"
 		else
-			echo "\"umount $target\" (expectted: fail)" >> $LOGFILE
+			echo "\"umount $target\" (expectted: fail)"
 		fi
 	fi
 
-	umount $target >> $LOGFILE 2>&1
+	umount $target
 	do_exit $exit_here $expectted $?;
 }
 
 do_mv()
 {
 	if [ "$#" -ne "4" ]; then
-		echo "ERROR: mv failed,your parameter is wrong..Exiting test" >> $LOGFILE
+		echo "ERROR: mv failed,your parameter is wrong..Exiting test"
 		exit -1
 	fi
 
@@ -412,20 +412,20 @@ do_mv()
 
 	if [ $no_debug -ne 1 ]; then
 		if [ $expectted -ge 1 ]; then
-			echo "\"mv $source $target\" (expectted: success)" >> $LOGFILE
+			echo "\"mv $source $target\" (expectted: success)"
 		else
-			echo "\"mv $source $target\" (expectted: fail)" >> $LOGFILE
+			echo "\"mv $source $target\" (expectted: fail)"
 		fi
 	fi
 
-	mv $source $target >> $LOGFILE 2>&1
+	mv $source $target
 	do_exit $exit_here $expectted $?;
 }
 
 do_kill()
 {
 	if [ "$#" -ne "4" ]; then
-		echo "ERROR: kill failed,your parameter is wrong..Exiting test" >> $LOGFILE
+		echo "ERROR: kill failed,your parameter is wrong..Exiting test"
 		exit -1
 	fi
 
@@ -440,13 +440,13 @@ do_kill()
 
 	if [ $no_debug -ne 1 ]; then
 		if [ $expectted -ge 1 ]; then
-			echo "\"kill -$signo $pid\" (expectted: success)" >> $LOGFILE
+			echo "\"kill -$signo $pid\" (expectted: success)"
 		else
-			echo "\"kill -$signo $pid\" (expectted: fail)" >> $LOGFILE
+			echo "\"kill -$signo $pid\" (expectted: fail)"
 		fi
 	fi
 
-	kill -s $signo $pid >> $LOGFILE 2>&1
+	kill -s $signo $pid
 	do_exit $exit_here $expectted $?;
 }
 
@@ -464,7 +464,7 @@ setup()
 		cp -f $TESTROOT/cgroup_fj_release_agent /root
 		chmod a+x /root/cgroup_fj_release_agent
 	else
-		echo "ERROR: $TESTROOT/cgroup_fj_release_agent isn't exist..Exiting test" >> $LOGFILE
+		echo "ERROR: $TESTROOT/cgroup_fj_release_agent isn't exist..Exiting test"
 		exit -1;
 	fi
 
@@ -476,7 +476,7 @@ setup()
 	then
 		chmod a+x $TESTROOT/cgroup_fj_proc
 	else
-		echo "ERROR: $TESTROOT/cgroup_fj_proc isn't exist..Exiting test" >> $LOGFILE
+		echo "ERROR: $TESTROOT/cgroup_fj_proc isn't exist..Exiting test"
 		exit -1;
 	fi
 }
@@ -484,7 +484,7 @@ setup()
 cleanup()
 {
 	if [ $no_debug -ne 1 ]; then
-		echo "INFO: we now cleanup ..." >> $LOGFILE
+		echo "INFO: we now cleanup ..."
 	fi
 
 	export LANG=en_US.UTF-8
@@ -547,7 +547,7 @@ reclaim_foundling()
 mkdir_subgroup()
 {
 	if ! [ -e /dev/cgroup ]; then
-		echo "ERROR: /dev/cgroup isn't exist..Exiting test" >> $LOGFILE
+		echo "ERROR: /dev/cgroup isn't exist..Exiting test"
 		exit -1;
 	fi
 
@@ -613,7 +613,7 @@ check_para()
 
 	if [ $ret1 -ne 0 ] || [ $ret2 -ne 0 ] || [ $ret3 -ne 0 ] || [ $ret4 -ne 0 ] || [ $ret5 -ne 0 ] || [ $ret6 -ne 0 ]
 	then
-		echo "ERROR: Wrong inputed parameter..Exiting test" >> $LOGFILE
+		echo "ERROR: Wrong inputed parameter..Exiting test"
 		return -1
 	fi
 
diff --git a/testcases/kernel/controllers/cgroup_fj/run_cgroup_test_fj.sh b/testcases/kernel/controllers/cgroup_fj/run_cgroup_test_fj.sh
index f0b43b8..c8e698b 100755
--- a/testcases/kernel/controllers/cgroup_fj/run_cgroup_test_fj.sh
+++ b/testcases/kernel/controllers/cgroup_fj/run_cgroup_test_fj.sh
@@ -23,12 +23,21 @@
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
-export LOGFILE=$LTPROOT/output/cgroup_fj_log_`date +%F`.txt
 export TMPFILE=$TESTROOT/tmp_tasks
 export CASENO1=0
 export CASENO2=0
@@ -86,47 +95,38 @@ if [ "$SYBSYSCOMPILED" = "" ];then	# Warning and exit if all cgroup subsystem ar
 	exit -2;
 fi
 
-echo "Now, we start the test for cgroup...";
+echo `date`
+echo `uname -a`
 
-rm -f $LOGFILE 2>/dev/null
-echo `date` > $LOGFILE
-echo `uname -a` >> $LOGFILE
+echo ""
 
-echo "" >> $LOGFILE
-echo "Now, we start the test for basic function of cgroup..." >> $LOGFILE
+CASETYPE=$1
+shift
+CASECMD=$@
 
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
 
-		ret=$?
-		if [ $ret -eq 0 ]; then
-			tst_resm TPASS "case$i(`sed -n "$i""p" cgroup_fj_testcases.sh`)    PASS"
-		elif [ $ret -ne 9 ]; then
-			tst_resm TFAIL "case$i(`sed -n "$i""p" cgroup_fj_testcases.sh`)    FAIL"
-		fi
-	fi
-done
+ret=$?
+if [ $ret -eq 0 ]; then
+	tst_resm TPASS "case$i($CASETYPE$CASECMD)    PASS"
+elif [ $ret -ne 9 ]; then
+	tst_resm TFAIL "case$i($CASETYPE $CASECMD)    FAIL"
+fi
 
 exit $ret;
-- 
2.1.4


------------------------------------------------------------------------------
Monitor Your Dynamic Infrastructure at Any Scale With Datadog!
Get real-time metrics from all of your servers, apps and tools
in one place.
SourceForge users - Click here to start your Free Trial of Datadog now!
http://pubads.g.doubleclick.net/gampad/clk?id=241902991&iu=/4140
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

