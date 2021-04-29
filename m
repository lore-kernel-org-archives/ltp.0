From: Wang Xin <wangxin410@huawei.com>
Date: Thu, 29 Apr 2021 16:24:54 +0800
Subject: [LTP] [PATCH v2] controllers/cpuset: Restore the value of
 cpuset.sched_load_balance
Message-ID: <1619684694-116827-1-git-send-email-wangxin410@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When we run the cpuhotplug03 test case on the arm64 machine,
we conclude that no error occurs when the cpuhotplug03 case is executed alone,
but once the cpuset_sched_domains case is executed first,
After cpuhotplug03 is executed, the error "cpuhotplug03 1 TFAIL: No cpuhotplug_do_spin_loop processes found on" occurs.
The cpuset_sched_domains test case changes the value of cpuset.sched_load_balance in the cpuset cgroup subsystem,
but does not restore the value at the end of the test.
Modify the cpuset_funcs.sh file. The test result shows that the problem is solved successfully.

Signed-off-by: Wang Xin <wangxin410@huawei.com>
---
 v1 -> v2: modified the format

 testcases/kernel/controllers/cpuset/cpuset_funcs.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
index 00aad0e..f3ba1d5 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
@@ -60,6 +60,8 @@ CPUSET_TMP="/tmp/cpuset_tmp"
 CLONE_CHILDREN="/dev/cpuset/cgroup.clone_children"
 CHILDREN_VALUE="0"
 HOTPLUG_CPU="1"
+SCHED_LB="/dev/cpuset/cpuset.sched_load_balance"
+SCHED_LB_VALUE="0"

 cpuset_log()
 {
@@ -169,6 +171,7 @@ setup()
 	fi

 	CHILDREN_VALUE="`cat $CLONE_CHILDREN`"
+	SCHED_LB_VALUE="`cat $SCHED_LB`"
 }

 # Write the cleanup function
@@ -180,6 +183,7 @@ cleanup()
 	}

 	echo $CHILDREN_VALUE > $CLONE_CHILDREN
+	echo $SCHED_LB_VALUE > $SCHED_LB

 	find "$CPUSET" -type d | sort | sed -n '2,$p' | tac | while read subdir
 	do
--
2.6.2

