From: Leo Liang <ycliang@andestech.com>
Date: Tue, 27 Jul 2021 14:00:44 +0800
Subject: [LTP] [PATCH v5,
 2/2] cgroup/cgroup_regression_test: Fix umount failure
Message-ID: <20210727060029.GA16474@atcfdc88>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The test sequence
	mount -t cgroup -o <controllers> <path>
	mkdir <path>/<dir>
	rmdir <path>/<dir>
	umount <path>
	mount -t cgroup -o <controllers> <path>
would easily fail at the last mount with -EBUSY on certain platform.

The reason is that this test sequence would have the chance of
missing a release code path when doing rmdir and umount.

Adding a little delay between "rmdir" and "umount" could fix the problem,
so use tst_umount API instead of umount in "rmdir, umount" sequence.

Fixes: #839

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 .../controllers/cgroup/cgroup_regression_test.sh       | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
index 1f7f3820e..bc4dbe151 100755
--- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
+++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
@@ -145,7 +145,7 @@ test2()
 	fi
 
 	rmdir cgroup/0 cgroup/1
-	umount cgroup/
+	tst_umount cgroup/	# Avoid possible EBUSY error
 }
 
 #---------------------------------------------------------------------------
@@ -193,7 +193,7 @@ test3()
 	wait $pid2 2>/dev/null
 
 	rmdir $cpu_subsys_path/0 2> /dev/null
-	umount cgroup/ 2> /dev/null
+	tst_umount cgroup/		# Avoid possible EBUSY error
 	check_kernel_bug
 }
 
@@ -222,7 +222,7 @@ test4()
 	mount -t cgroup -o none,name=foo cgroup cgroup/
 	mkdir cgroup/0
 	rmdir cgroup/0
-	umount cgroup/
+	tst_umount cgroup/		# Avoid possible EBUSY error
 
 	if dmesg | grep -q "MAX_LOCKDEP_SUBCLASSES too low"; then
 		tst_res TFAIL "lockdep BUG was found"
@@ -254,7 +254,7 @@ test5()
 	mount -t cgroup none cgroup 2> /dev/null
 	mkdir cgroup/0
 	rmdir cgroup/0
-	umount cgroup/ 2> /dev/null
+	tst_umount cgroup/		# Avoid possible EBUSY error
 	check_kernel_bug
 }
 
@@ -290,7 +290,7 @@ test6()
 
 	mount -t cgroup -o ns xxx cgroup/ > /dev/null 2>&1
 	rmdir cgroup/[1-9]* > /dev/null 2>&1
-	umount cgroup/
+	tst_umount cgroup/		# Avoid possible EBUSY error
 	check_kernel_bug
 }
 
-- 
2.17.0
