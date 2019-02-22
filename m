From: Xu Yu <xuyu@linux.alibaba.com>
Date: Fri, 22 Feb 2019 14:10:32 +0800
Subject: [LTP] [PATCH] controllers/cgroup_regression_test.sh: mitigate
	potential mount error
Message-ID: <9b3247beedd55b5a2c2ef638b26416d175775c77.1550815364.git.xuyu@linux.alibaba.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Immediately `umount cgroup/` after `rmdir cgroup/0` is very likely to
make the corresponding num_cgroups not decrease, and causes the
following mount operation with overlapping subsys to fail.

A demo test script can be:
mount -t cgroup -o hugetlb,pids xxx cgroup/
mkdir cgroup/0
rmdir cgroup/0
umount cgroup/
mount -t cgroup -o pids xxx cgroup/  <-- FAIL

The root cause is that `rmdir cgroup/0` is asynchronous in the kernel
implementation, causing `umount cgroup/` to enter `cgroup_put` path,
instead of `percpu_ref_kill` path.

There is no good kernel solution yet[1]. Therefore, we temporarily add
`sleep` in the test script to ensure `umount cgroup/` is executed
after `rmdir cgroup/0` is completed. Note that we only add `sleep` in
the clean up phase of each test in the cgroup_regression_test.sh.
No `sleep` is added in the cgroup_regression_6_1.sh and
cgroup_regression_10_1.sh for the sake of pressure test.

[1] https://marc.info/?t=155021167400005&r=1&w=2

Signed-off-by: Xu Yu <xuyu@linux.alibaba.com>
---
 testcases/kernel/controllers/cgroup/cgroup_regression_test.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
index 6868609..f78d80a 100755
--- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
+++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
@@ -145,6 +145,7 @@ test2()
 	fi
 
 	rmdir cgroup/0 cgroup/1
+	sleep 1
 	umount cgroup/
 }
 
@@ -193,6 +194,7 @@ test3()
 	wait $pid2 2>/dev/null
 
 	rmdir $cpu_subsys_path/0 2> /dev/null
+	sleep 1
 	umount cgroup/ 2> /dev/null
 	check_kernel_bug
 }
@@ -222,6 +224,7 @@ test4()
 	mount -t cgroup -o none,name=foo cgroup cgroup/
 	mkdir cgroup/0
 	rmdir cgroup/0
+	sleep 1
 	umount cgroup/
 
 	if dmesg | grep -q "MAX_LOCKDEP_SUBCLASSES too low"; then
@@ -302,6 +305,7 @@ test5()
 	kill -TERM $! > /dev/null
 	wait $! 2>/dev/null
 	rmdir $mntpoint/0
+	sleep 1
 	# Do NOT unmount pre-existent mountpoints...
 	[ -z "$mounted" ] && umount $mntpoint/
 	check_kernel_bug
@@ -339,6 +343,7 @@ test6()
 
 	mount -t cgroup -o ns xxx cgroup/ > /dev/null 2>&1
 	rmdir cgroup/[1-9]* > /dev/null 2>&1
+	sleep 1
 	umount cgroup/
 	check_kernel_bug
 }
@@ -373,6 +378,7 @@ test_7_1()
 	mkdir $subsys_path/0
 	sleep 100 < $subsys_path/0 &	# add refcnt to this dir
 	rmdir $subsys_path/0
+	sleep 1
 
 	# remount with new subsystems added
 	# since 2.6.28, this remount will fail
@@ -398,6 +404,7 @@ test_7_2()
 	mkdir cgroup/0
 	sleep 100 < cgroup/0 &	# add refcnt to this dir
 	rmdir cgroup/0
+	sleep 1
 
 	# remount with some subsystems removed
 	# since 2.6.28, this remount will fail
@@ -510,6 +517,7 @@ test10()
 	mount -t cgroup none cgroup 2> /dev/null
 	mkdir cgroup/0
 	rmdir cgroup/0
+	sleep 1
 	umount cgroup/ 2> /dev/null
 	check_kernel_bug
 }
-- 
1.8.3.1

