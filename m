From: Chunyu Hu <chuhu@redhat.com>
Date: Mon, 18 Apr 2016 16:04:11 +0800
Subject: [LTP] [PATCH V2 4/9] ftrace_stress: skip unsupported tests
In-Reply-To: <1460966656-28328-4-git-send-email-chuhu@redhat.com>
References: <1460966656-28328-1-git-send-email-chuhu@redhat.com>
 <1460966656-28328-2-git-send-email-chuhu@redhat.com>
 <1460966656-28328-3-git-send-email-chuhu@redhat.com>
 <1460966656-28328-4-git-send-email-chuhu@redhat.com>
Message-ID: <1460966656-28328-5-git-send-email-chuhu@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Checking if it's supported before lanuching a test script. This action is
through verifing the matched file in ftrace tracing direcrotry.

At the same time, transform the hard coded pids to the test_targets string and
make it easier to be controlled.

With this modification, the outdated tracing_enabled issue can be skiped on
newer kernels.

V2:
    fix the bashism code style.
    use ltp lib.

Signed-off-by: Chunyu Hu <chuhu@redhat.com>
---
 testcases/kernel/tracing/ftrace_test/ftrace_lib.sh |  10 +-
 .../ftrace_test/ftrace_stress/ftrace_set_event.sh  |   5 +-
 .../ftrace_stress/ftrace_set_ftrace_pid.sh         |  11 --
 .../ftrace_stress/ftrace_stack_max_size.sh         |  11 --
 .../ftrace_stress/ftrace_stack_trace.sh            |  12 --
 .../ftrace_stress/ftrace_tracing_max_latency.sh    |  12 --
 .../tracing/ftrace_test/ftrace_stress_test.sh      | 132 ++++++++++-----------
 7 files changed, 78 insertions(+), 115 deletions(-)

diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh b/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh
index ea082dc..b7aef34 100755
--- a/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh
@@ -40,9 +40,12 @@ save_old_setting()
 
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
@@ -85,7 +88,10 @@ restore_old_setting()
 
 	echo $old_buffer_size > buffer_size_kb
 	echo $old_tracing_on > tracing_on
-	echo $old_tracing_enabled > tracing_enabled
+
+	if [ -e tracing_enabled ];then
+		echo $old_tracing_enabled > tracing_enabled
+	fi
 
 	for option in $old_trace_options
 	do
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
index d9f7f8b..80c914c 100755
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
@@ -21,87 +21,92 @@
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
-
-	export NR_PIDS=16
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
 }
 
-test_stress()
+should_skip_target()
 {
-	export_pids
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
+	local var=skip_$1
+	local val=${!var}
+	[ "$val" = 1 ]
 }
 
 test_kill()
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
+	tst_resm TINFO "killing ${pid0}"
+	kill -USR1 ${pid0}
+	wait ${pid0}
+
+	local p=1;
+	while [ $p -lt $NR_PIDS ]; do
+                local kill_pid=pid${p}
+                kill -KILL ${!kill_pid}
+		tst_resm TINFO "killing ${!kill_pid}"
+                wait ${!kill_pid}
+                p=$((p + 1))
+        done
 
 	sleep 2
 	clean_up
 }
 
+test_stress()
+{
+	local index=0;
+
+	tst_resm TINFO "Test targets: ${test_targets}"
+
+	get_skip_targets
+	for target in ${test_targets}; do
+		if should_skip_target $target; then
+			continue
+		fi
+		sh ftrace_${target}.sh &
+		eval pid${index}=$!
+		tst_resm TINFO "Start pid${index}=$! $SPATH/ftrace_${target}.sh"
+		index=$((index + 1))
+	done
+	export_pids
+}
+
+export_pids()
+{
+	local p=0
+	while [ $p -lt $NR_PIDS ]; do
+		export pid${p}
+		p=$((p + 1))
+	done
+}
 
+cd ftrace_stress/
 # ----------------------------
-echo "Ftrace Stress Test Begin"
+tst_resm TINFO "Ftrace Stress Test Begin"
 
 save_old_setting
 
@@ -113,11 +118,6 @@ test_wait
 
 test_kill
 
-echo "Ftrace Stress Test End"
+tst_resm TINFO "Finished running the test. Run dmesg to double-check for bugs"
 
-if $test_success; then
-	tst_resm TPASS "finished running the test. Run dmesg to double-check for bugs"
-else
-	tst_resm TFAIL "please check log message."
-	exit 1
-fi
+tst_exit
-- 
1.8.3.1

