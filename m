From: Cristian Marussi <cristian.marussi@arm.com>
Date: Wed, 21 Nov 2018 13:40:21 +0000
Subject: [LTP] [PATCH]  cgroup_regression_test.sh: fixed test_5
Message-ID: <20181121134021.52225-1-cristian.marussi@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

test_5 checked for possible regressions using a pair of cgroups mounts
operations designed to expose a kernel crash; the trigger being the
attempt to co-mount and mount the same cgroup subsystem onto two
distinct fs hierarchies: the expected failure in the second mount
attempt was not properly handled in 2.6.29-rc2 and lead to a kernel
crash.
Unfortunately the test assumed that the randomly chosen subsystems
were NOT already mounted somewhere when attempting the first co-mount:
this assumption is falsified when userspace is configured to mount all
available subsystems at /sysfs on boot (systemd).
So the test was failing straight away during the setup phase:

cgroup_regression_test    5  TFAIL  :  ltpapicmd.c:188: mount pids and hugetlb failed

Being not trivial to forcibly release and unmount the populated
/sysfs cgroups once booted, the script has been reviewed to detect
this condition upfront and cope with it dynamically:

 - if not already mounted: co-mount + failing mount (as before)
 - already mounted: use existing mntpoint + failing co-mount

Since the original fix was on a 2.6.29 kernel the surrounding cgroup
code has changed a lot and so the patch was no more trivially 'revertable'
for testing purposes: as such this reviewed test script has been verified
using a QEMU x86_64 instance running a Kernel 2.6.39 with and without
the known fix as detailed in test_5 comments.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 .../cgroup/cgroup_regression_test.sh          | 51 +++++++++++++------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
index 30d0dbfbc..4212c0640 100755
--- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
+++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
@@ -262,31 +262,51 @@ test_5()
 	subsys1=`tail -n 1 /proc/cgroups | awk '{ print $1 }'`
 	subsys2=`tail -n 2 /proc/cgroups | head -1 | awk '{ print $1 }'`
 
-	mount -t cgroup -o $subsys1,$subsys2 xxx cgroup/
-	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "mount $subsys1 and $subsys2 failed"
-		failed=1
-		return
+	# Accounting here for the fact that the chosen subsystems could
+	# have been already previously mounted at boot time: in such a
+	# case we must skip the initial co-mount step (which would
+	# fail anyway) and properly re-organize the $tst_mntpoint and
+	# $failing_subsys params to be used in the following expected-to-fail
+	# mount action.
+	already_mounted_subsys=none
+	mount | grep cgroup | grep -q $subsys1 && already_mounted_subsys=$subsys1
+	mount | grep cgroup | grep -q $subsys2 && already_mounted_subsys=$subsys2
+        if [ "x$already_mounted_subsys" == "xnone" ]; then
+		tst_mntpoint=cgroup
+		failing_subsys=$subsys1
+		mount -t cgroup -o $subsys1,$subsys2 xxx $tst_mntpoint/
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "mount $subsys1 and $subsys2 failed"
+			failed=1
+			return
+		fi
+	else
+		# Use the pre-esistent mountpoint as $tst_mntpoint and use a
+		# co-mount with $failing_subsys: this way the 2nd mount will
+		# also fail (as expected) in this 'mirrored' configuration.
+		tst_mntpoint=$(mount | grep cgroup | grep $already_mounted_subsys | cut -d ' ' -f 3)
+		failing_subsys=$subsys1,$subsys2
 	fi
 
-	# This 2nd mount should fail
-	mount -t cgroup -o $subsys1 xxx cgroup/ 2> /dev/null
+	# This 2nd mount has been properly configured to fail
+	mount -t cgroup -o $failing_subsys xxx $tst_mntpoint/ 2> /dev/null
 	if [ $? -eq 0 ]; then
-		tst_resm TFAIL "mount $subsys1 should fail"
-		umount cgroup/
+		tst_resm TFAIL "mount $failing_subsys should fail"
+		# Do NOT unmount pre-existent mountpoints...
+	        [[ "x$already_mounted_subsys" == "xnone" ]] && umount $tst_mntpoint
 		failed=1
 		return
 	fi
 
-	mkdir cgroup/0
+	mkdir $tst_mntpoint/0
 	# Otherwise we can't attach task
 	if [ "$subsys1" = cpuset -o "$subsys2" = cpuset ]; then
-		echo 0 > cgroup/0/cpuset.cpus 2> /dev/null
-		echo 0 > cgroup/0/cpuset.mems 2> /dev/null
+		echo 0 > $tst_mntpoint/0/cpuset.cpus 2> /dev/null
+		echo 0 > $tst_mntpoint/0/cpuset.mems 2> /dev/null
 	fi
 
 	sleep 100 &
-	echo $! > cgroup/0/tasks
+	echo $! > $tst_mntpoint/0/tasks
 
 	check_kernel_bug
 	if [ $? -eq 1 ]; then
@@ -296,8 +316,9 @@ test_5()
 	# clean up
 	/bin/kill -SIGTERM $! > /dev/null
 	wait $!
-	rmdir cgroup/0
-	umount cgroup/
+	rmdir $tst_mntpoint/0
+	# Do NOT unmount pre-existent mountpoints...
+	[[ "x$already_mounted_subsys" == "xnone" ]] && umount $tst_mntpoint
 }
 
 #---------------------------------------------------------------------------
-- 
2.17.1

