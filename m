From: Chunyu Hu <chuhu@redhat.com>
Date: Wed, 11 May 2016 19:36:26 +0800
Subject: [LTP] [PATCH V3-2 4/9] ftrace_stress: skip unsupported tests and
	early cleanup
In-Reply-To: <1462966591-3895-4-git-send-email-chuhu@redhat.com>
References: <1462966591-3895-1-git-send-email-chuhu@redhat.com>
 <1462966591-3895-2-git-send-email-chuhu@redhat.com>
 <1462966591-3895-3-git-send-email-chuhu@redhat.com>
 <1462966591-3895-4-git-send-email-chuhu@redhat.com>
Message-ID: <1462966591-3895-5-git-send-email-chuhu@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Checking if it's supported before lanuching a test script. This action is
through verifying the matched file in ftrace tracing direcrotry.

At the same time, transform the hard coded pids to the test_targets string and
make it easier to be controlled.

With this modification, the outdated tracing_enabled issue can be skiped on
newer kernels.

V2:
    fix the bashism code style.
    use ltp lib.

V3:
    1 fix white space issue in test_kill.
    2 fix another ${!var} bashism.
    3 remove the unneened sleep 2.
    4 move clean_up() out from test_kill.
    5 Also an early cleanup ftrace_lib.sh after the reorg,
      add a ftrace_test_init in ftrace_lib.sh, and move
      the save_old_setting in it, which will be called at
      test bebin.

Signed-off-by: Chunyu Hu <chuhu@redhat.com>
---
 testcases/kernel/tracing/ftrace_test/ftrace_lib.sh | 108 ++++++++--------
 .../tracing/ftrace_test/ftrace_regression01.sh     |   5 +-
 .../tracing/ftrace_test/ftrace_regression02.sh     |   5 +-
 .../ftrace_test/ftrace_stress/ftrace_set_event.sh  |   5 +-
 .../ftrace_stress/ftrace_set_ftrace_pid.sh         |  11 --
 .../ftrace_stress/ftrace_stack_max_size.sh         |  11 --
 .../ftrace_stress/ftrace_stack_trace.sh            |  12 --
 .../ftrace_stress/ftrace_tracing_max_latency.sh    |  12 --
 .../tracing/ftrace_test/ftrace_stress_test.sh      | 136 ++++++++++-----------
 9 files changed, 134 insertions(+), 171 deletions(-)

diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh b/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh
index ea082dc..c131827 100755
--- a/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh
@@ -1,4 +1,4 @@
-#! /bin/sh
+#!/bin/sh
 
 ###########################################################################
 ##                                                                       ##
@@ -21,16 +21,38 @@
 ##                                                                       ##
 ###########################################################################
 
-cd $LTPROOT/testcases/bin
+. test.sh
 
-export TPATH="$PWD"
-export DEBUGFS_PATH="$PWD/debugfs"
-export TRACING_PATH="$PWD/debugfs/tracing"
-export FPATH="$TPATH/ftrace_function"
-export RPATH="$TPATH/ftrace_regression"
-export SPATH="$TPATH/ftrace_stress"
+ftrace_test_init()
+{
+	export TPATH="$PWD"
+	export SPATH="$TPATH/ftrace_stress"
+
+	if grep -q debugfs /proc/mounts; then
+		export DEBUGFS_PATH=/sys/kernel/debug/
+		export TRACING_PATH="$DEBUGFS_PATH/tracing"
+		debugfs_def_mounted=1
+	else
+		tst_tmpdir
+		export DEBUGFS_PATH="$PWD/debugfs"
+		export TRACING_PATH="$PWD/debugfs/tracing"
+		mkdir $DEBUGFS_PATH
+		mount -t debugfs xxx $DEBUGFS_PATH
+	fi
 
-. test.sh
+	TST_CLEANUP=clean_up
+
+	trap clean_up_exit INT
+
+	tst_require_root
+
+	# Check to see tracing feature is supported or not
+	if [ ! -d $TRACING_PATH ]; then
+		tst_brkm TCONF "Tracing is not supported. Skip the test..."
+	fi
+
+	save_old_setting
+}
 
 test_interval=$1
 
@@ -40,9 +62,12 @@ save_old_setting()
 
 	old_trace_options=( `cat trace_options` )
 	old_tracing_on=`cat tracing_on`
-	old_tracing_enabled=`cat tracing_enabled`
 	old_buffer_size=`cat buffer_size_kb`
 
+	if [ -e tracing_enabled ]; then
+		old_tracing_enabled=`cat tracing_enabled`
+	fi
+
 	if [ -e stack_max_size ]; then
 		old_stack_tracer_enabled=`cat /proc/sys/kernel/stack_tracer_enabled`
 	fi
@@ -55,11 +80,17 @@ save_old_setting()
 		old_profile_enabled=`cat function_profile_enabled`
 	fi
 
+	setting_saved=1
+
 	cd - > /dev/null
 }
 
 restore_old_setting()
 {
+	if [ ! "$setting_saved" = 1 ]; then
+		return
+	fi
+
 	cd $TRACING_PATH
 
 	echo nop > current_tracer
@@ -85,7 +116,10 @@ restore_old_setting()
 
 	echo $old_buffer_size > buffer_size_kb
 	echo $old_tracing_on > tracing_on
-	echo $old_tracing_enabled > tracing_enabled
+
+	if [ -e tracing_enabled ];then
+		echo $old_tracing_enabled > tracing_enabled
+	fi
 
 	for option in $old_trace_options
 	do
@@ -97,20 +131,28 @@ restore_old_setting()
 	cd - > /dev/null
 }
 
+clean_up_mount()
+{
+	if [ ! "$debugfs_def_mounted" = "1" ]; then
+		umount $DEBUGFS_PATH
+		rmdir $DEBUGFS_PATH
+	fi
+}
+
 clean_up()
 {
 	restore_old_setting
-
-	umount $DEBUGFS_PATH
-	rmdir $DEBUGFS_PATH
+	clean_up_mount
 }
 
 clean_up_exit()
 {
-	clean_up
+	restore_old_setting
+	clean_up_mount
 	exit 1
 }
 
+
 test_begin()
 {
 	start_time=`date +%s`
@@ -118,39 +160,9 @@ test_begin()
 
 test_wait()
 {
-	for ((; ;))
-	{
-		sleep 2
-
-		cur_time=`date +%s`
-		elapsed=$(( $cur_time - $start_time ))
-
-		# run the test for $test_interval secs
-		if [ $elapsed -ge $test_interval ]; then
-			break
-		fi
-	}
+	# run the test for $test_interval secs
+	tst_sleep ${test_interval}s
 }
 
-trap clean_up_exit INT
-
-tst_require_root
-
-# Don't run the test on kernels older than 2.6.34, otherwise
-# it can crash the system if the kernel is not latest-stable
-tst_kvercmp 2 6 34
-if [ $? -eq 0 ]; then
-	tst_brkm TCONF ignored "The test should be run in kernels >= 2.6.34. Skip the test..."
-	exit 0
-fi
-
-mkdir $DEBUGFS_PATH
-mount -t debugfs xxx $DEBUGFS_PATH
+ftrace_test_init
 
-# Check to see tracing feature is supported or not
-if [ ! -d $TRACING_PATH ]; then
-	tst_brkm TCONF ignored "Tracing is not supported. Skip the test..."
-	umount $DEBUGFS_PATH
-	rmdir $DEBUGFS_PATH
-	exit 0
-fi
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression01.sh b/testcases/kernel/tracing/ftrace_test/ftrace_regression01.sh
index b25111a..a14b9d5 100755
--- a/testcases/kernel/tracing/ftrace_test/ftrace_regression01.sh
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_regression01.sh
@@ -79,8 +79,7 @@ ftrace_userstacktrace_test()
 }
 
 #--------Test Start--------------
-save_old_setting
-
 ftrace_userstacktrace_test
 
-clean_up
+tst_exit
+
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh b/testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh
index 6704749..1bf9d11 100755
--- a/testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh
@@ -60,8 +60,7 @@ if [ $? -eq 0 ]; then
 	tst_brkm TCONF "The test should be run in kernels >= 3.2.0 Skip the test..."
 fi
 
-save_old_setting
-
 ftrace_signal_test
 
-clean_up
+tst_exit
+
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_event.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_event.sh
index d7efdd4..e8fd5ea 100755
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_event.sh
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_event.sh
@@ -36,9 +36,12 @@ for ((; ;))
 
 	for event in `cat $TRACING_PATH/available_events`;
 	do
+		# ftrace event sys is special, skip it
+		if echo "$event" | grep "ftrace:*"; then
+			continue
+		fi
 		echo $event >> "$TRACING_PATH"/set_event
 	done
 
 	sleep 1
 }
-
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_ftrace_pid.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_ftrace_pid.sh
index 7bc76d9..3eaf017 100755
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_ftrace_pid.sh
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_ftrace_pid.sh
@@ -15,19 +15,9 @@
 
 LOOP=300
 
-if [ ! -e "$TRACING_PATH"/set_ftrace_pid ]; then
-	should_skip=1
-else
-	should_skip=0
-fi
 
 for ((; ; ))
 {
-	if [ $should_skip -eq 1 ]; then
-		sleep 2
-		continue
-	fi
-
 	for ((j = 0; j < $LOOP; j++))
 	{
 		for ((k = 1; k <= NR_PIDS; k++))
@@ -46,4 +36,3 @@ for ((; ; ))
 
 	sleep 1
 }
-
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_max_size.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_max_size.sh
index 682d05e..34d506b 100755
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_max_size.sh
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_max_size.sh
@@ -15,19 +15,8 @@
 
 MAX_STACK_SIZE=8192
 
-if [ ! -e /proc/sys/kernel/stack_tracer_enabled ]; then
-	should_skip=1
-else
-	should_skip=0
-fi
-
 for ((; ;))
 {
-	if [ $should_skip -eq 1 ]; then
-		sleep 2
-		continue
-	fi
-
 	for ((i = 0; i < $MAX_STACK_SIZE; i += 70))
 	{
 		echo $i > "$TRACING_PATH"/stack_max_size
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_trace.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_trace.sh
index a406c51..1850c26 100755
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_trace.sh
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_trace.sh
@@ -15,19 +15,8 @@
 
 LOOP=400
 
-if [ ! -e /proc/sys/kernel/stack_tracer_enabled ]; then
-	should_skip=1
-else
-	should_skip=0
-fi
-
 for ((; ;))
 {
-	if [ $should_skip -eq 1 ]; then
-		sleep 2
-		continue
-	fi
-
 	for ((i = 0; i < $LOOP; i++))
 	{
 		cat "$TRACING_PATH"/stack_trace > /dev/null
@@ -43,4 +32,3 @@ for ((; ;))
 
 	sleep 1
 }
-
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_max_latency.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_max_latency.sh
index f19d734..fbaceb8 100755
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_max_latency.sh
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_max_latency.sh
@@ -15,19 +15,8 @@
 
 MAX_LATENCY=100000
 
-if [ ! -e "$TRACING_PATH"/tracing_max_latency ]; then
-        should_skip=1
-else
-        should_skip=0
-fi
-
 for ((; ;))
 {
-        if [ $should_skip -eq 1 ]; then
-                sleep 2
-                continue
-        fi
-
 	for ((i = 0; i < $MAX_LATENCY; i += 400))
 	{
 		echo $i > "$TRACING_PATH"/tracing_max_latency
@@ -35,4 +24,3 @@ for ((; ;))
 
 	sleep 1
 }
-
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
index d9f7f8b..514f566 100755
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
@@ -21,89 +21,89 @@
 ##                                                                       ##
 ###########################################################################
 
-
 export TCID="ftrace-stress-test"
 export TST_TOTAL=1
 export TST_COUNT=1
 
 . ftrace_lib.sh
 
-test_success=true
+test_targets=" \
+trace_pipe current_tracer ftrace_enabled function_profile_enabled \
+set_event set_ftrace_pid stack_max_size stack_trace trace trace_clock \
+trace_options trace_stat tracing_enabled tracing_max_latency \
+tracing_on function_profile_enabled buffer_size_kb"
 
-export_pids()
+get_skip_targets()
 {
-	export pid1 pid2 pid3 pid4 pid5 pid6 pid7 pid8 pid9 pid10 pid11 pid12 \
-		pid13 pid14 pid15 pid16
+	NR_PIDS=0
+	for target in ${test_targets}; do
+		if [ ! -e $TRACING_PATH/$target ] &&
+			[ ! -e /proc/sys/kernel/$target ]; then
+			eval skip_$target=1
+			tst_resm TINFO "$target is not supported. Skip it."
+		else
+			eval skip_$target=0
+			NR_PIDS=$((NR_PIDS + 1))
+		fi
+	done
+	# Export it before sub case is lanuched.
+	export NR_PIDS
+}
 
-	export NR_PIDS=16
+should_skip_target()
+{
+	local skip_var=skip_$1
+	eval local skip_val=\$${skip_var}
+	[ "$skip_val" = 1 ]
+}
+
+test_kill()
+{
+	tst_resm TINFO "killing ${pid0}"
+	kill -USR1 ${pid0}
+	wait ${pid0}
+
+	local p=1;
+	while [ $p -lt $NR_PIDS ]; do
+		local pid_var=pid${p}
+		eval local kill_pid=\$${pid_var}
+		tst_resm TINFO "killing ${kill_pid}"
+		kill -KILL $kill_pid
+		wait ${kill_pid}
+		p=$((p + 1))
+	done
 }
 
 test_stress()
 {
+	local index=0;
+
+	tst_resm TINFO "Test targets: ${test_targets}"
+
+	get_skip_targets
+	for target in ${test_targets}; do
+		if should_skip_target $target; then
+			continue
+		fi
+		./ftrace_stress/ftrace_${target}.sh &
+		eval pid${index}=$!
+		tst_resm TINFO "Start pid${index}=$! $SPATH/ftrace_${target}.sh"
+		index=$((index + 1))
+	done
 	export_pids
-
-	$SPATH/ftrace_trace_clock.sh &
-	pid1=$!
-	$SPATH/ftrace_current_tracer.sh &
-	pid2=$!
-	$SPATH/ftrace_trace_options.sh &
-	pid3=$!
-	$SPATH/ftrace_tracing_max_latency.sh &
-	pid4=$!
-	$SPATH/ftrace_stack_trace.sh &
-	pid5=$!
-	$SPATH/ftrace_stack_max_size.sh &
-	pid6=$!
-	$SPATH/ftrace_tracing_on.sh &
-	pid7=$!
-	$SPATH/ftrace_tracing_enabled.sh &
-	pid8=$!
-	$SPATH/ftrace_set_event.sh &
-	pid9=$!
-	$SPATH/ftrace_buffer_size.sh &
-	pid10=$!
-	$SPATH/ftrace_trace.sh &
-	pid11=$!
-	$SPATH/ftrace_trace_pipe.sh &
-	pid12=$!
-	$SPATH/ftrace_ftrace_enabled.sh &
-	pid13=$!
-	$SPATH/ftrace_set_ftrace_pid.sh &
-	pid14=$!
-	$SPATH/ftrace_profile_enabled.sh &
-	pid15=$!
-	$SPATH/ftrace_trace_stat.sh &
-	pid16=$!
 }
 
-test_kill()
+export_pids()
 {
-	kill -KILL $pid1 || test_success=false
-	kill -KILL $pid2 || test_success=false
-	kill -KILL $pid3 || test_success=false
-	kill -KILL $pid4 || test_success=false
-	kill -KILL $pid5 || test_success=false
-	kill -KILL $pid6 || test_success=false
-	kill -KILL $pid7 || test_success=false
-	kill -KILL $pid8 || test_success=false
-	kill -KILL $pid9 || test_success=false
-	kill -KILL $pid10 || test_success=false
-	kill -KILL $pid11 || test_success=false
-	kill -USR1 $pid12 || test_success=false
-	kill -KILL $pid13 || test_success=false
-	kill -KILL $pid14 || test_success=false
-	kill -KILL $pid15 || test_success=false
-	kill -KILL $pid16 || test_success=false
-
-	sleep 2
-	clean_up
+	local p=0
+	while [ $p -lt $NR_PIDS ]; do
+		export pid${p}
+		p=$((p + 1))
+	done
 }
 
-
 # ----------------------------
-echo "Ftrace Stress Test Begin"
-
-save_old_setting
+tst_resm TINFO "Ftrace Stress Test Begin"
 
 test_begin
 
@@ -113,11 +113,7 @@ test_wait
 
 test_kill
 
-echo "Ftrace Stress Test End"
+tst_resm TINFO "Finished running the test. Run dmesg to double-check for bugs"
+
+tst_exit
 
-if $test_success; then
-	tst_resm TPASS "finished running the test. Run dmesg to double-check for bugs"
-else
-	tst_resm TFAIL "please check log message."
-	exit 1
-fi
-- 
1.8.3.1

