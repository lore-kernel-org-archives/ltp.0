From: Li Wang <liwang@redhat.com>
Date: Wed, 22 Nov 2017 15:38:48 +0800
Subject: [LTP] [PATCH 2/2] cgroup: fix mount errors in cgroup subsys
In-Reply-To: <20171122073848.6172-1-liwang@redhat.com>
References: <20171122073848.6172-1-liwang@redhat.com>
Message-ID: <20171122073848.6172-2-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It is very easy to get failures when running these cgroup regression
tests on the newer kernel. Maybe the cases should be rewriten in LTP
new API someday, but currently this fix just as a workaround for it.

Errors:
  cgroup_regression_test    3  TFAIL  :  ltpapicmd.c:190: Failed to mount cpu subsys
  cgroup_regression_test    5  TFAIL  :  ltpapicmd.c:190: mount net_prio and pids failed
  cgroup_regression_test    7  TFAIL  :  ltpapicmd.c:190: failed to mount net_prio

Signed-off-by: Li Wang <liwang@redhat.com>
---
 .../controllers/cgroup/cgroup_regression_test.sh   | 63 ++++++++++++++--------
 testcases/kernel/controllers/cgroup/test_3_1.sh    |  8 +--
 2 files changed, 46 insertions(+), 25 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
index 30d0dbf..d333d73 100755
--- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
+++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
@@ -175,21 +175,25 @@ test_3()
 		return
 	fi
 
-	grep -q -w "cpu" /proc/cgroups
-	if [ $? -ne 0 ]; then
+	if grep -q -w "cpu" /proc/cgroups ; then
+		cpu_subsys_path=$(grep -w cpu /proc/mounts | cut -d ' ' -f 2)
+	else
 		tst_resm TCONF "CONFIG_CGROUP_SCHED is not enabled"
 		return
 	fi
 
 	# Run the test for 30 secs
-	mount -t cgroup -o cpu xxx cgroup/
-	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "Failed to mount cpu subsys"
-		failed=1
-		return
+	if [ -z "$cpu_subsys_path" ]; then
+		mount -t cgroup -o cpu xxx cgroup/
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "Failed to mount cpu subsys"
+			failed=1
+			return
+		fi
+		cpu_subsys_path=cgroup
 	fi
 
-	./test_3_1.sh &
+	./test_3_1.sh $cpu_subsys_path &
 	pid1=$!
 	./test_3_2.sh &
 	pid2=$!
@@ -204,8 +208,9 @@ test_3()
 		tst_resm TPASS "no kernel bug was found"
 	fi
 
-	rmdir cgroup/* 2> /dev/null
-	umount cgroup/
+	rmdir $cpu_subsys_path/* 2> /dev/null
+
+	umount cgroup/ 2> /dev/null
 }
 
 #---------------------------------------------------------------------------
@@ -260,7 +265,14 @@ test_5()
 	fi
 
 	subsys1=`tail -n 1 /proc/cgroups | awk '{ print $1 }'`
+	subsys1_mount=$(basename $(grep -w $subsys1 /proc/mounts | cut -d ' ' -f 2))
 	subsys2=`tail -n 2 /proc/cgroups | head -1 | awk '{ print $1 }'`
+	subsys2_mount=$(basename $(grep -w $subsys2 /proc/mounts | cut -d ' ' -f 2))
+
+	if [ -n "$subsys1_mount" ] || [ -n "$subsys2_mount" ]; then
+		tst_resm TCONF "$subsys1 or $subsys2 has been mounted, skip"
+		return
+	fi
 
 	mount -t cgroup -o $subsys1,$subsys2 xxx cgroup/
 	if [ $? -ne 0 ]; then
@@ -347,23 +359,30 @@ test_6()
 #---------------------------------------------------------------------------
 test_7_1()
 {
-	mount -t cgroup -o $subsys xxx cgroup/
-	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "failed to mount $subsys"
-		failed=1
-		return
+	subsys_path=$(grep -w $subsys /proc/mounts | cut -d ' ' -f 2)
+	if [ -z "$subsys_path" ]; then
+		mount -t cgroup -o $subsys xxx cgroup/
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "failed to mount $subsys"
+			failed=1
+			return
+		fi
+		subsys_path=cgroup
 	fi
 
-	mkdir cgroup/0
-	sleep 100 < cgroup/0 &	# add refcnt to this dir
-	rmdir cgroup/0
+	mkdir $subsys_path/0
+	sleep 100 < $subsys_path/0 &	# add refcnt to this dir
+	rmdir $subsys_path/0
 
 	# remount with new subsystems added
 	# since 2.6.28, this remount will fail
-	mount -t cgroup -o remount xxx cgroup/ 2> /dev/null
-	/bin/kill -SIGTERM $!
-	wait $!
-	umount cgroup/
+
+	if [ "$subsys_path" == "cgroup" ]; then
+		mount -t cgroup -o remount xxx cgroup/ 2> /dev/null
+		/bin/kill -SIGTERM $!
+		wait $!
+		umount cgroup/
+	fi
 }
 
 test_7_2()
diff --git a/testcases/kernel/controllers/cgroup/test_3_1.sh b/testcases/kernel/controllers/cgroup/test_3_1.sh
index a1a4943..dcc78a6 100755
--- a/testcases/kernel/controllers/cgroup/test_3_1.sh
+++ b/testcases/kernel/controllers/cgroup/test_3_1.sh
@@ -23,9 +23,11 @@
 ################################################################################
 
 trap exit SIGUSR1
+
+path=$1
+
 for ((; ;))
 {
-	mkdir cgroup/0
-	rmdir cgroup/0
+	mkdir $path/0
+	rmdir $path/0
 }
-
-- 
2.9.3

