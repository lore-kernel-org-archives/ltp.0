From: wangxin (CQ) <wangxin410@huawei.com>
Date: Thu, 29 Apr 2021 08:32:15 +0000
Subject: [LTP] =?gb2312?b?tPC4tDogW1BBVENIXSBjb250cm9sbGVycy9jcHVzZXQ6?=
 =?gb2312?b?IFJlc3RvcmUgdGhlIHZhbHVlIG9mIGNwdXNldC5zY2hlZF9sb2FkX2JhbGFu?=
 =?gb2312?b?Y2U=?=
In-Reply-To: <1619079641-30553-1-git-send-email-wangxin410@huawei.com>
References: <1619079641-30553-1-git-send-email-wangxin410@huawei.com>
Message-ID: <c6f0d000f05943a1bb1cac3c1bbd8867@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

	Please ignore this patch. When I was making this patch,
	I used an incorrect method to fix my formatting problem. 
	Now I've remade a new patch, please check out the v2 version.

Kind regards,
Wang Xin


-----????-----
???: wangxin (CQ) 
????: 2021?4?22? 16:21
???: ltp@lists.linux.it
??: wangxin (CQ) <wangxin410@huawei.com>
??: [PATCH] controllers/cpuset: Restore the value of cpuset.sched_load_balance

When we run the cpuhotplug03 test case on the arm64 machine, we conclude that no error occurs when the cpuhotplug03 case is executed alone, but once the cpuset_sched_domains case is executed first, After cpuhotplug03 is executed, the error "cpuhotplug03 1 TFAIL: No cpuhotplug_do_spin_loop processes found on" occurs.
The cpuset_sched_domains test case changes the value of cpuset.sched_load_balance in the cpuset cgroup subsystem, but does not restore the value at the end of the test.
Modify the cpuset_funcs.sh file. The test result shows that the problem is solved successfully.

Signed-off-by: Wang Xin <wangxin410@huawei.com>
---
 testcases/kernel/controllers/cpuset/cpuset_funcs.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
index 00aad0e..820de33 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
@@ -59,6 +59,8 @@ CPUSET="/dev/cpuset"
 CPUSET_TMP="/tmp/cpuset_tmp"
 CLONE_CHILDREN="/dev/cpuset/cgroup.clone_children"
 CHILDREN_VALUE="0"
+SCHED_LB="/dev/cpuset/cpuset.sched_load_balance"
+SCHED_LB_VALUE="0"
 HOTPLUG_CPU="1"
 cpuset_log()
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
2.6.2

