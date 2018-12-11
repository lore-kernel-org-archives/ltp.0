From: Cristian Marussi <cristian.marussi@arm.com>
Date: Tue, 11 Dec 2018 12:40:38 +0000
Subject: [LTP] [PATCH v3]  cgroup_regression_test.sh: fixed test_5
Message-ID: <20181211124038.50226-1-cristian.marussi@arm.com>
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
 .../cgroup/cgroup_regression_test.sh          | 55 ++++++++++++++-----
 1 file changed, 40 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
index 30d0dbfbc..295d07097 100755
--- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
+++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
@@ -253,6 +253,10 @@ test_4()
 #---------------------------------------------------------------------------
 test_5()
 {
+	local mounted
+	local failing
+	local mntpoint
+
 	lines=`cat /proc/cgroups | wc -l`
 	if [ $lines -le 2 ]; then
 		tst_resm TCONF "require at least 2 cgroup subsystems"
@@ -262,31 +266,51 @@ test_5()
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
+	# fail anyway) and properly re-organize the $mntpoint and
+	# $failing params to be used in the following expected-to-fail
+	# mount action. Note that the subsysN name itself will be listed
+	# amongst mounts options.
+	cat /proc/mounts | grep cgroup | grep -q $subsys1 && mounted=$subsys1
+	[ -z "$mounted" ] && cat /proc/mounts | grep cgroup | grep -q $subsys2 && mounted=$subsys2
+	if [ -z "$mounted" ]; then
+		mntpoint=cgroup
+		failing=$subsys1
+		mount -t cgroup -o $subsys1,$subsys2 xxx $mntpoint/
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "mount $subsys1 and $subsys2 failed"
+			failed=1
+			return
+		fi
+	else
+		# Use the pre-esistent mountpoint as $mntpoint and use a
+		# co-mount with $failing: this way the 2nd mount will
+		# also fail (as expected) in this 'mirrored' configuration.
+		mntpoint=$(cat /proc/mounts | grep cgroup | grep $mounted | awk '{ print $2 }')
+		failing=$subsys1,$subsys2
 	fi
 
-	# This 2nd mount should fail
-	mount -t cgroup -o $subsys1 xxx cgroup/ 2> /dev/null
+	# This 2nd mount has been properly configured to fail
+	mount -t cgroup -o $failing xxx $mntpoint/ 2> /dev/null
 	if [ $? -eq 0 ]; then
-		tst_resm TFAIL "mount $subsys1 should fail"
-		umount cgroup/
+		tst_resm TFAIL "mount $failing should fail"
+		# Do NOT unmount pre-existent mountpoints...
+		[ -z "$mounted" ] && umount $mntpoint
 		failed=1
 		return
 	fi
 
-	mkdir cgroup/0
+	mkdir $mntpoint/0
 	# Otherwise we can't attach task
 	if [ "$subsys1" = cpuset -o "$subsys2" = cpuset ]; then
-		echo 0 > cgroup/0/cpuset.cpus 2> /dev/null
-		echo 0 > cgroup/0/cpuset.mems 2> /dev/null
+		echo 0 > $mntpoint/0/cpuset.cpus 2> /dev/null
+		echo 0 > $mntpoint/0/cpuset.mems 2> /dev/null
 	fi
 
 	sleep 100 &
-	echo $! > cgroup/0/tasks
+	echo $! > $mntpoint/0/tasks
 
 	check_kernel_bug
 	if [ $? -eq 1 ]; then
@@ -296,8 +320,9 @@ test_5()
 	# clean up
 	/bin/kill -SIGTERM $! > /dev/null
 	wait $!
-	rmdir cgroup/0
-	umount cgroup/
+	rmdir $mntpoint/0
+	# Do NOT unmount pre-existent mountpoints...
+	[ -z "$mounted" ] && umount $mntpoint
 }
 
 #---------------------------------------------------------------------------
-- 
2.17.1

