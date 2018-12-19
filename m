From: Cristian Marussi <cristian.marussi@arm.com>
Date: Wed, 19 Dec 2018 18:03:16 +0000
Subject: [LTP] [PATCH]  cgroup_regression_test.sh ported to newlib
Message-ID: <20181219180316.21831-1-cristian.marussi@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In the context of newlib porting, this patch takes care to:
  + remove bashism
    - giving 'kill' bash-builtin needs different sigspec strings
  + remove absolute/relative command invocations
  + remove most global vars
  + introduce a common helper to search for cgroup mountpoints
    in proc/mounts

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 .../cgroup/cgroup_regression_test.sh          | 283 ++++++++++--------
 1 file changed, 159 insertions(+), 124 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
index 6cfc63866..fe28ab5f0 100755
--- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
+++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
@@ -1,4 +1,4 @@
-#! /bin/bash
+#! /bin/sh
 
 ################################################################################
 ##                                                                            ##
@@ -22,71 +22,109 @@
 ##                                                                            ##
 ################################################################################
 
-cd $LTPROOT/testcases/bin
+TST_TESTFUNC=do_test
+TST_SETUP=do_setup
+TST_CLEANUP=do_cleanup
+TST_CNT=10
+TST_NEEDS_ROOT=1
+TST_NEEDS_CMDS="dmesg mountpoint mount umount cat kill find mkdir rmdir grep"
+
+. tst_test.sh
+
+# Helper to parse /proc/mounts to find the mountpoints (if any)
+# associated with the cgroup subsystem passed as param.
+#
+# It expects as single argument the cgroup subsytem for
+# which to search in /proc/mounts the mountpoint (if any).
+#
+# - returns true|false depending if any mountpoint has been found.
+# - echos back the mountpoint itself if any found
+get_cgroup_mountpoint()
+{
+	local mntpoint
+	local line
+	local ret=1
+	local subsystem=$1
+
+	# fail straight away with no args
+	[ $# -eq 0 ] && return $ret
+
+	line=$(grep cgroup /proc/mounts | grep -w $subsystem)
+	ret=$?
+	# extract mountpoint if any exist
+	[ $ret = 0 ] && mntpoint=$(echo $line | awk '{ print $2 }') && echo $mntpoint
+
+	return $ret
+}
+
+do_setup()
+{
+	cd $LTPROOT/testcases/bin
 
-export TCID="cgroup_regression_test"
-export TST_TOTAL=10
-export TST_COUNT=1
+	mkdir cgroup/
 
-failed=0
+	if tst_kvcmp -lt "2.6.29"; then
+		tst_brk TCONF ignored "test must be run with kernel 2.6.29 or newer"
+	fi
 
-if tst_kvcmp -lt "2.6.29"; then
-	tst_brkm TCONF ignored "test must be run with kernel 2.6.29 or newer"
-	exit 32
-fi
+	if [ ! -f /proc/cgroups ]; then
+		tst_brk TCONF ignored "Kernel does not support for control groups; skipping testcases";
+	fi
 
-if [ ! -f /proc/cgroups ]; then
-	tst_brkm TCONF ignored "Kernel does not support for control groups; skipping testcases";
-	exit 32
-fi
+	dmesg -c > /dev/null
+	NR_BUG=`dmesg | grep -c "kernel BUG"`
+	NR_NULL=`dmesg | grep -c "kernel NULL pointer dereference"`
+	NR_WARNING=`dmesg | grep -c "^WARNING"`
+	NR_LOCKDEP=`dmesg | grep -c "possible recursive locking detected"`
+}
 
-if [ "x$(id -ru)" != x0 ]; then
-	tst_brkm TCONF ignored "Test must be run as root"
-	exit 32
-fi
+do_cleanup()
+{
+	cd $LTPROOT/testcases/bin
 
-dmesg -c > /dev/null
-nr_bug=`dmesg | grep -c "kernel BUG"`
-nr_null=`dmesg | grep -c "kernel NULL pointer dereference"`
-nr_warning=`dmesg | grep -c "^WARNING"`
-nr_lockdep=`dmesg | grep -c "possible recursive locking detected"`
+	if mountpoint -q cgroup/
+	then
+		find cgroup/ -maxdepth 1 -depth -exec rmdir {} +
+		umount cgroup/
+		rmdir cgroup/
+	fi
+}
 
 # check_kernel_bug - check if some kind of kernel bug happened
 check_kernel_bug()
 {
-	new_bug=`dmesg | grep -c "kernel BUG"`
-	new_null=`dmesg | grep -c "kernel NULL pointer dereference"`
-	new_warning=`dmesg | grep -c "^WARNING"`
-	new_lockdep=`dmesg | grep -c "possible recursive locking detected"`
+	local new_bug=`dmesg | grep -c "kernel BUG"`
+	local new_null=`dmesg | grep -c "kernel NULL pointer dereference"`
+	local new_warning=`dmesg | grep -c "^WARNING"`
+	local new_lockdep=`dmesg | grep -c "possible recursive locking detected"`
 
 	# no kernel bug is detected
-	if [ $new_bug -eq $nr_bug -a $new_warning -eq $nr_warning -a \
-	     $new_null -eq $nr_null -a $new_lockdep -eq $nr_lockdep ]; then
+	if [ $new_bug -eq $NR_BUG -a $new_warning -eq $NR_WARNING -a \
+	     $new_null -eq $NR_NULL -a $new_lockdep -eq $NR_LOCKDEP ]; then
 		return 1
 	fi
 
 	# some kernel bug is detected
-	if [ $new_bug -gt $nr_bug ]; then
-		tst_resm TFAIL "kernel BUG was detected!"
+	if [ $new_bug -gt $NR_BUG ]; then
+		tst_res TFAIL "kernel BUG was detected!"
 	fi
-	if [ $new_warning -gt $nr_warning ]; then
-		tst_resm TFAIL "kernel WARNING was detected!"
+	if [ $new_warning -gt $NR_WARNING ]; then
+		tst_res TFAIL "kernel WARNING was detected!"
 	fi
-	if [ $new_null -gt $nr_null ]; then
-		tst_resm TFAIL "kernel NULL pointer dereference!"
+	if [ $new_null -gt $NR_NULL ]; then
+		tst_res TFAIL "kernel NULL pointer dereference!"
 	fi
-	if [ $new_lockdep -gt $nr_lockdep ]; then
-		tst_resm TFAIL "kernel lockdep warning was detected!"
+	if [ $new_lockdep -gt $NR_LOCKDEP ]; then
+		tst_res TFAIL "kernel lockdep warning was detected!"
 	fi
 
-	nr_bug=$new_bug
-	nr_null=$new_null
-	nr_warning=$new_warning
-	nr_lockdep=$new_lockdep
+	NR_BUG=$new_bug
+	NR_NULL=$new_null
+	NR_WARNING=$new_warning
+	NR_LOCKDEP=$new_lockdep
 
 	echo "check_kernel_bug found something!"
 	dmesg
-	failed=1
 	return 0
 }
 
@@ -102,24 +140,23 @@ check_kernel_bug()
 #---------------------------------------------------------------------------
 test_1()
 {
-	./fork_processes &
+	fork_processes &
 	sleep 1
 
 	mount -t cgroup -o none,name=foo cgroup cgroup/
 	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "failed to mount cgroup filesystem"
-		failed=1
-		/bin/kill -SIGTERM $!
+		tst_res TFAIL "failed to mount cgroup filesystem"
+		kill -TERM $!
 		return
 	fi
 	cat cgroup/tasks > /dev/null
 
 	check_kernel_bug
 	if [ $? -eq 1 ]; then
-		tst_resm TPASS "no kernel bug was found"
+		tst_res TPASS "no kernel bug was found"
 	fi
 
-	/bin/kill -SIGTERM $!
+	kill -TERM $!
 	wait $!
 	umount cgroup/
 }
@@ -132,11 +169,13 @@ test_1()
 #---------------------------------------------------------------------------
 test_2()
 {
+	local val1
+	local val2
+
 	mount -t cgroup -o none,name=foo cgroup cgroup/
 	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "Failed to mount cgroup filesystem"
-		failed=1
-		return 1
+		tst_res TFAIL "Failed to mount cgroup filesystem"
+		return
 	fi
 
 	echo 0 > cgroup/notify_on_release
@@ -148,16 +187,15 @@ test_2()
 	val2=`cat cgroup/1/notify_on_release`
 
 	if [ $val1 -ne 0 -o $val2 -ne 1 ]; then
-		tst_resm TFAIL "wrong notify_on_release value"
-		failed=1
+		tst_res TFAIL "wrong notify_on_release value"
 	else
-		tst_resm TPASS "notify_on_release is inherited"
+		tst_res TPASS "notify_on_release is inherited"
 	fi
 
 	rmdir cgroup/0 cgroup/1
 	umount cgroup/
 
-	return $failed
+	return
 }
 
 #---------------------------------------------------------------------------
@@ -173,14 +211,14 @@ test_3()
 	local cpu_subsys_path
 
 	if [ ! -e /proc/sched_debug ]; then
-		tst_resm TCONF "CONFIG_SCHED_DEBUG is not enabled"
+		tst_res TCONF "CONFIG_SCHED_DEBUG is not enabled"
 		return
 	fi
 
 	if grep -q -w "cpu" /proc/cgroups ; then
-		cpu_subsys_path=$(grep -w cpu /proc/mounts | awk '{ print $2 }')
+		cpu_subsys_path=$(get_cgroup_mountpoint "cpu")
 	else
-		tst_resm TCONF "CONFIG_CGROUP_SCHED is not enabled"
+		tst_res TCONF "CONFIG_CGROUP_SCHED is not enabled"
 		return
 	fi
 
@@ -188,8 +226,7 @@ test_3()
 	if [ -z "$cpu_subsys_path" ]; then
 		mount -t cgroup -o cpu xxx cgroup/
 		if [ $? -ne 0 ]; then
-			tst_resm TFAIL "Failed to mount cpu subsys"
-			failed=1
+			tst_res TFAIL "Failed to mount cpu subsys"
 			return
 		fi
 		cpu_subsys_path=cgroup
@@ -201,13 +238,13 @@ test_3()
 	pid2=$!
 
 	sleep 30
-	/bin/kill -SIGUSR1 $pid1 $pid2
+	kill -USR1 $pid1 $pid2
 	wait $pid1
 	wait $pid2
 
 	check_kernel_bug
 	if [ $? -eq 1 ]; then
-		tst_resm TPASS "no kernel bug was found"
+		tst_res TPASS "no kernel bug was found"
 	fi
 
 	rmdir $cpu_subsys_path/* 2> /dev/null
@@ -223,15 +260,17 @@ test_3()
 #---------------------------------------------------------------------------
 test_4()
 {
+	local lines
+
 	if [ ! -e /proc/lockdep ]; then
-		tst_resm TCONF "CONFIG_LOCKDEP is not enabled"
+		tst_res TCONF "CONFIG_LOCKDEP is not enabled"
 		return
 	fi
 
 	# MAX_LOCKDEP_SUBCLASSES is 8, so number of subsys should be > 8
 	lines=`cat /proc/cgroups | wc -l`
 	if [ $lines -le 9 ]; then
-		tst_resm TCONF "require more than 8 cgroup subsystems"
+		tst_res TCONF "require more than 8 cgroup subsystems"
 		return
 	fi
 
@@ -242,11 +281,10 @@ test_4()
 
 	dmesg | grep -q "MAX_LOCKDEP_SUBCLASSES too low"
 	if [ $? -eq 0 ]; then
-		tst_resm TFAIL "lockdep BUG was found"
-		failed=1
+		tst_res TFAIL "lockdep BUG was found"
 		return
 	else
-		tst_resm TPASS "no lockdep BUG was found"
+		tst_res TPASS "no lockdep BUG was found"
 	fi
 }
 
@@ -264,14 +302,14 @@ test_5()
 	local failing
 	local mntpoint
 
-	lines=`cat /proc/cgroups | wc -l`
+	local lines=`cat /proc/cgroups | wc -l`
 	if [ $lines -le 2 ]; then
-		tst_resm TCONF "require at least 2 cgroup subsystems"
+		tst_res TCONF "require at least 2 cgroup subsystems"
 		return
 	fi
 
-	subsys1=`tail -n 1 /proc/cgroups | awk '{ print $1 }'`
-	subsys2=`tail -n 2 /proc/cgroups | head -1 | awk '{ print $1 }'`
+	local subsys1=`tail -n 1 /proc/cgroups | awk '{ print $1 }'`
+	local subsys2=`tail -n 2 /proc/cgroups | head -1 | awk '{ print $1 }'`
 
 	# Accounting here for the fact that the chosen subsystems could
 	# have been already previously mounted at boot time: in such a
@@ -280,32 +318,30 @@ test_5()
 	# $failing params to be used in the following expected-to-fail
 	# mount action. Note that the subsysN name itself will be listed
 	# amongst mounts options.
-	cat /proc/mounts | grep cgroup | grep -q $subsys1 && mounted=$subsys1
-	[ -z "$mounted" ] && cat /proc/mounts | grep cgroup | grep -q $subsys2 && mounted=$subsys2
+	get_cgroup_mountpoint $subsys1 >/dev/null && mounted=$subsys1
+	[ -z "$mounted" ] && get_cgroup_mountpoint $subsys2 >/dev/null && mounted=$subsys2
 	if [ -z "$mounted" ]; then
 		mntpoint=cgroup
 		failing=$subsys1
 		mount -t cgroup -o $subsys1,$subsys2 xxx $mntpoint/
 		if [ $? -ne 0 ]; then
-			tst_resm TFAIL "mount $subsys1 and $subsys2 failed"
-			failed=1
+			tst_res TFAIL "mount $subsys1 and $subsys2 failed"
 			return
 		fi
 	else
 		# Use the pre-esistent mountpoint as $mntpoint and use a
 		# co-mount with $failing: this way the 2nd mount will
 		# also fail (as expected) in this 'mirrored' configuration.
-		mntpoint=$(cat /proc/mounts | grep cgroup | grep $mounted | awk '{ print $2 }')
+		mntpoint=$(get_cgroup_mountpoint $mounted)
 		failing=$subsys1,$subsys2
 	fi
 
 	# This 2nd mount has been properly configured to fail
 	mount -t cgroup -o $failing xxx $mntpoint/ 2> /dev/null
 	if [ $? -eq 0 ]; then
-		tst_resm TFAIL "mount $failing should fail"
+		tst_res TFAIL "mount $failing should fail"
 		# Do NOT unmount pre-existent mountpoints...
-		[ -z "$mounted" ] && umount $mntpoint
-		failed=1
+		[ -z "$mounted" ] && umount $mntpoint/
 		return
 	fi
 
@@ -321,15 +357,15 @@ test_5()
 
 	check_kernel_bug
 	if [ $? -eq 1 ]; then
-		tst_resm TPASS "no kernel bug was found"
+		tst_res TPASS "no kernel bug was found"
 	fi
 
 	# clean up
-	/bin/kill -SIGTERM $! > /dev/null
+	kill -TERM $! > /dev/null
 	wait $!
 	rmdir $mntpoint/0
 	# Do NOT unmount pre-existent mountpoints...
-	[ -z "$mounted" ] && umount $mntpoint
+	[ -z "$mounted" ] && umount $mntpoint/
 }
 
 #---------------------------------------------------------------------------
@@ -342,25 +378,25 @@ test_6()
 {
 	grep -q -w "ns" /proc/cgroups
 	if [ $? -ne 0 ]; then
-		tst_resm TCONF "CONFIG_CGROUP_NS"
+		tst_res TCONF "CONFIG_CGROUP_NS"
 		return
 	fi
 
 	# run the test for 30 secs
 	./test_6_1.sh &
-	pid1=$!
+	local pid1=$!
 	./test_6_2 &
-	pid2=$!
+	local pid2=$!
 
 	sleep 30
-	/bin/kill -SIGUSR1 $pid1
-	/bin/kill -SIGTERM $pid2
+	kill -USR1 $pid1
+	kill -TERM $pid2
 	wait $pid1
 	wait $pid2
 
 	check_kernel_bug
 	if [ $? -eq 1 ]; then
-		tst_resm TPASS "no kernel bug was found"
+		tst_res TPASS "no kernel bug was found"
 	fi
 
 	# clean up
@@ -379,12 +415,18 @@ test_6()
 #---------------------------------------------------------------------------
 test_7_1()
 {
-	subsys_path=$(grep -w $subsys /proc/mounts | cut -d ' ' -f 2)
+	local subsys=$1
+	# we should be careful to select a $subsys_path which is related to
+	# cgroup only: if cgroup debugging is enabled a 'debug' $subsys
+	# could be passed here as params and this will lead to ambiguity and
+	# errors when grepping simply for 'debug' in /proc/mounts since we'll
+	# find also /sys/kernel/debug. Helper takes care of this.
+	local subsys_path=$(get_cgroup_mountpoint $subsys)
+
 	if [ -z "$subsys_path" ]; then
 		mount -t cgroup -o $subsys xxx cgroup/
 		if [ $? -ne 0 ]; then
-			tst_resm TFAIL "failed to mount $subsys"
-			failed=1
+			tst_res TFAIL "failed to mount $subsys"
 			return
 		fi
 		subsys_path=cgroup
@@ -399,7 +441,7 @@ test_7_1()
 
 	if [ "$subsys_path" = "cgroup" ]; then
 		mount -t cgroup -o remount xxx cgroup/ 2> /dev/null
-		/bin/kill -SIGTERM $!
+		kill -TERM $!
 		wait $!
 		umount cgroup/
 	fi
@@ -407,10 +449,11 @@ test_7_1()
 
 test_7_2()
 {
+	local subsys=$1
+
 	mount -t cgroup -o none,name=foo cgroup cgroup/
 	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "failed to mount cgroup"
-		failed=1
+		tst_res TFAIL "failed to mount cgroup"
 		return
 	fi
 
@@ -421,7 +464,7 @@ test_7_2()
 	# remount with some subsystems removed
 	# since 2.6.28, this remount will fail
 	mount -t cgroup -o remount,$subsys xxx cgroup/ 2> /dev/null
-	/bin/kill -SIGTERM $!
+	kill -TERM $!
 	wait $!
 	umount cgroup/
 
@@ -441,19 +484,19 @@ test_7_2()
 
 test_7()
 {
-	lines=`cat /proc/cgroups | wc -l`
+	local lines=`cat /proc/cgroups | wc -l`
 	if [ $lines -le 2 ]; then
-		tst_resm TCONF "require at least 2 cgroup subsystems"
+		tst_res TCONF "require at least 2 cgroup subsystems"
 		slt_result $SLT_Untested
 		return
 	fi
 
-	subsys=`tail -n 1 /proc/cgroups | awk '{ print $1 }'`
+	local subsys=`tail -n 1 /proc/cgroups | awk '{ print $1 }'`
 
 	# remount to add new subsystems to the hierarchy
-	i=1
+	local i=1
 	while [ $i -le 2 ] ; do
-		test_7_$i
+		test_7_$i $subsys
 		if [ $? -ne 0 ]; then
 			return
 		fi
@@ -465,7 +508,7 @@ test_7()
 		: $(( i += 1 ))
 	done
 
-	tst_resm TPASS "no kernel bug was found"
+	tst_res TPASS "no kernel bug was found"
 }
 
 #---------------------------------------------------------------------------
@@ -478,22 +521,20 @@ test_8()
 {
 	mount -t cgroup -o none,name=foo cgroup cgroup/
 	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "failed to mount cgroup filesystem"
-		failed=1
+		tst_res TFAIL "failed to mount cgroup filesystem"
 		return
 	fi
 
-	./getdelays -C cgroup/tasks > /dev/null 2>&1
+	getdelays -C cgroup/tasks > /dev/null 2>&1
 	if [ $? -eq 0 ]; then
-		tst_resm TFAIL "should have failed to get cgroupstat of tasks file"
+		tst_res TFAIL "should have failed to get cgroupstat of tasks file"
 		umount cgroup/
-		failed=1
 		return
 	fi
 
 	check_kernel_bug
 	if [ $? -eq 1 ]; then
-		tst_resm TPASS "no kernel bug was found"
+		tst_res TPASS "no kernel bug was found"
 	fi
 
 	umount cgroup/
@@ -510,12 +551,12 @@ test_8()
 test_9()
 {
 	./test_9_1.sh &
-	pid1=$!
+	local pid1=$!
 	./test_9_2.sh &
-	pid2=$!
+	local pid2=$!
 
 	sleep 30
-	/bin/kill -SIGUSR1 $pid1 $pid2
+	kill -USR1 $pid1 $pid2
 	wait $pid1
 	wait $pid2
 
@@ -523,7 +564,7 @@ test_9()
 
 	check_kernel_bug
 	if [ $? -eq 1 ]; then
-		tst_resm TPASS "no kernel warning was found"
+		tst_res TPASS "no kernel warning was found"
 	fi
 }
 
@@ -537,12 +578,12 @@ test_9()
 test_10()
 {
 	./test_10_1.sh &
-	pid1=$!
+	local pid1=$!
 	./test_10_2.sh &
-	pid2=$!
+	local pid2=$!
 
 	sleep 30
-	/bin/kill -SIGUSR1 $pid1 $pid2
+	kill -USR1 $pid1 $pid2
 	wait $pid1
 	wait $pid2
 
@@ -552,21 +593,15 @@ test_10()
 
 	check_kernel_bug
 	if [ $? -eq 1 ]; then
-		tst_resm TPASS "no kernel warning was found"
+		tst_res TPASS "no kernel warning was found"
 	fi
 }
 
-# main
-
-mkdir cgroup/
-
-for ((cur = 1; cur <= $TST_TOTAL; cur++))
+do_test()
 {
-	export TST_COUNT=$cur
+	local cur=$1
 
 	test_$cur
 }
 
-find cgroup/ -maxdepth 1 -depth -exec rmdir {} +
-
-exit $failed
+tst_run
-- 
2.17.1

