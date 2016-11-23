From: Li Wang <liwang@redhat.com>
Date: Wed, 23 Nov 2016 19:09:06 +0800
Subject: [LTP] [PATCH] cgroup: fix mount errors on cgroup subsys
Message-ID: <1479899346-4261-1-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch is on target to fix tiny errors:

mount: xxx is already mounted or /opt/ltp/testcases/bin/cgroup busy
cgroup_regression_test    3  TFAIL  :  ltpapicmd.c:190: Failed to mount cpu subsys
cgroup_regression_test    4  TCONF  :  ltpapicmd.c:190: CONFIG_LOCKDEP is not enabled
mount: xxx is already mounted or /opt/ltp/testcases/bin/cgroup busy
cgroup_regression_test    5  TFAIL  :  ltpapicmd.c:190: mount net_prio and pids failed
cgroup_regression_test    6  TCONF  :  ltpapicmd.c:190: CONFIG_CGROUP_NS
mount: xxx is already mounted or /opt/ltp/testcases/bin/cgroup busy
cgroup_regression_test    7  TFAIL  :  ltpapicmd.c:190: failed to mount net_prio

Test Environment: 23G RAM, 24 CPUS, x86_64, RHEL7.3GA

Signed-off-by: Li Wang <liwang@redhat.com>
---
 .../controllers/cgroup/cgroup_regression_test.sh   | 46 +++++++++++++++++++++-
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
index 30d0dbf..971243f 100755
--- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
+++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
@@ -181,10 +181,17 @@ test_3()
 		return
 	fi
 
+	local cpu=cpu
+
+	# For rhel7.3 or later, cpu is always binding with cpuacct subsys
+	if grep -w cpu /proc/mounts ; then
+		cpu=$(basename $(grep -w cpu /proc/mounts | cut -d ' ' -f 2))
+	fi
+
 	# Run the test for 30 secs
-	mount -t cgroup -o cpu xxx cgroup/
+	mount -t cgroup -o $cpu xxx cgroup/
 	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "Failed to mount cpu subsys"
+		tst_resm TFAIL "Failed to mount $cpu subsys"
 		failed=1
 		return
 	fi
@@ -262,6 +269,20 @@ test_5()
 	subsys1=`tail -n 1 /proc/cgroups | awk '{ print $1 }'`
 	subsys2=`tail -n 2 /proc/cgroups | head -1 | awk '{ print $1 }'`
 
+	# On rhel7.3, cgroup subsystem is mounted automatically
+	# Here just unmout these two target temporarily for test
+	if grep -w $subsys1 /proc/mounts ; then
+		subsys1_orig=$(basename $(grep -w $subsys1 /proc/mounts | cut -d ' ' -f 2))
+		subsys1_path=$(grep -w $subsys1 /proc/mounts | cut -d ' ' -f 2)
+		umount $subsys1_path
+	fi
+
+	if grep -w $subsys2 /proc/mounts ; then
+		subsys2_orig=$(basename $(grep -w $subsys2 /proc/mounts | cut -d ' ' -f 2))
+		subsys2_path=$(grep -w $subsys2 /proc/mounts | cut -d ' ' -f 2)
+		umount $subsys2_path
+	fi
+
 	mount -t cgroup -o $subsys1,$subsys2 xxx cgroup/
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "mount $subsys1 and $subsys2 failed"
@@ -298,6 +319,17 @@ test_5()
 	wait $!
 	rmdir cgroup/0
 	umount cgroup/
+
+	# waiting for cgroup/ unmout successfuly
+	tst_sleep 100ms
+
+	if [ -n "$subsys1_path" ]; then
+		mount -t cgroup -o $subsys1_orig cgroup $subsys1_path
+	fi
+
+	if [ -n "$subsys2_path" ]; then
+		mount -t cgroup -o $subsys2_orig cgroup $subsys2_path
+	fi
 }
 
 #---------------------------------------------------------------------------
@@ -411,6 +443,12 @@ test_7()
 
 	subsys=`tail -n 1 /proc/cgroups | awk '{ print $1 }'`
 
+	if grep -w $subsys /proc/mounts ; then
+		subsys_orig=$(basename $(grep -w $subsys /proc/mounts | cut -d ' ' -f 2))
+		subsys_path=$(grep -w $subsys /proc/mounts | cut -d ' ' -f 2)
+		umount $subsys_path
+	fi
+
 	# remount to add new subsystems to the hierarchy
 	i=1
 	while [ $i -le 2 ] ; do
@@ -426,6 +464,10 @@ test_7()
 		: $(( i += 1 ))
 	done
 
+	if [ -n "$subsys_path" ]; then
+		mount -t cgroup -o $subsys_orig cgroup $subsys_path
+	fi
+
 	tst_resm TPASS "no kernel bug was found"
 }
 
-- 
1.8.3.1

