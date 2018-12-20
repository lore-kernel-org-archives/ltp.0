From: Cristian Marussi <cristian.marussi@arm.com>
Date: Thu, 20 Dec 2018 18:21:47 +0000
Subject: [LTP] [PATCH v2 2/4]  cgroup_regression_test.sh cleanup
In-Reply-To: <20181220182149.48326-1-cristian.marussi@arm.com>
References: <20181220182149.48326-1-cristian.marussi@arm.com>
Message-ID: <20181220182149.48326-3-cristian.marussi@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cleanups:
 - removed absolute/relative commands invocations
 - avoid bashism
  + removed bash shebang
  + giving up 'kill' bash-builtin: this needs redefining
    used sigspec strings

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 .../cgroup/cgroup_regression_test.sh          | 26 +++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
index 1b4dfb45e..4e702f2f9 100755
--- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
+++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
@@ -1,4 +1,4 @@
-#! /bin/bash
+#! /bin/sh
 
 ################################################################################
 ##                                                                            ##
@@ -114,13 +114,13 @@ check_kernel_bug()
 #---------------------------------------------------------------------------
 test_1()
 {
-	./fork_processes &
+	fork_processes &
 	sleep 1
 
 	mount -t cgroup -o none,name=foo cgroup cgroup/
 	if [ $? -ne 0 ]; then
 		tst_res TFAIL "failed to mount cgroup filesystem"
-		/bin/kill -SIGTERM $!
+		kill -TERM $!
 		return
 	fi
 	cat cgroup/tasks > /dev/null
@@ -130,7 +130,7 @@ test_1()
 		tst_res TPASS "no kernel bug was found"
 	fi
 
-	/bin/kill -SIGTERM $!
+	kill -TERM $!
 	wait $!
 	umount cgroup/
 }
@@ -212,7 +212,7 @@ test_3()
 	pid2=$!
 
 	sleep 30
-	/bin/kill -SIGUSR1 $pid1 $pid2
+	kill -USR1 $pid1 $pid2
 	wait $pid1
 	wait $pid2
 
@@ -335,7 +335,7 @@ test_5()
 	fi
 
 	# clean up
-	/bin/kill -SIGTERM $! > /dev/null
+	kill -TERM $! > /dev/null
 	wait $!
 	rmdir $mntpoint/0
 	# Do NOT unmount pre-existent mountpoints...
@@ -363,8 +363,8 @@ test_6()
 	local pid2=$!
 
 	sleep 30
-	/bin/kill -SIGUSR1 $pid1
-	/bin/kill -SIGTERM $pid2
+	kill -USR1 $pid1
+	kill -TERM $pid2
 	wait $pid1
 	wait $pid2
 
@@ -409,7 +409,7 @@ test_7_1()
 
 	if [ "$subsys_path" = "cgroup" ]; then
 		mount -t cgroup -o remount xxx cgroup/ 2> /dev/null
-		/bin/kill -SIGTERM $!
+		kill -TERM $!
 		wait $!
 		umount cgroup/
 	fi
@@ -432,7 +432,7 @@ test_7_2()
 	# remount with some subsystems removed
 	# since 2.6.28, this remount will fail
 	mount -t cgroup -o remount,$subsys xxx cgroup/ 2> /dev/null
-	/bin/kill -SIGTERM $!
+	kill -TERM $!
 	wait $!
 	umount cgroup/
 
@@ -493,7 +493,7 @@ test_8()
 		return
 	fi
 
-	./getdelays -C cgroup/tasks > /dev/null 2>&1
+	getdelays -C cgroup/tasks > /dev/null 2>&1
 	if [ $? -eq 0 ]; then
 		tst_res TFAIL "should have failed to get cgroupstat of tasks file"
 		umount cgroup/
@@ -524,7 +524,7 @@ test_9()
 	local pid2=$!
 
 	sleep 30
-	/bin/kill -SIGUSR1 $pid1 $pid2
+	kill -USR1 $pid1 $pid2
 	wait $pid1
 	wait $pid2
 
@@ -551,7 +551,7 @@ test_10()
 	local pid2=$!
 
 	sleep 30
-	/bin/kill -SIGUSR1 $pid1 $pid2
+	kill -USR1 $pid1 $pid2
 	wait $pid1
 	wait $pid2
 
-- 
2.17.1

