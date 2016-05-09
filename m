From: Chunyu Hu <chuhu@redhat.com>
Date: Mon,  9 May 2016 19:03:38 +0800
Subject: [LTP] [PATCH v3 9/9] ftrace_stress: cleanup and use ltp API
In-Reply-To: <1462791818-4184-9-git-send-email-chuhu@redhat.com>
References: <1462791818-4184-1-git-send-email-chuhu@redhat.com>
 <1462791818-4184-2-git-send-email-chuhu@redhat.com>
 <1462791818-4184-3-git-send-email-chuhu@redhat.com>
 <1462791818-4184-4-git-send-email-chuhu@redhat.com>
 <1462791818-4184-5-git-send-email-chuhu@redhat.com>
 <1462791818-4184-6-git-send-email-chuhu@redhat.com>
 <1462791818-4184-7-git-send-email-chuhu@redhat.com>
 <1462791818-4184-8-git-send-email-chuhu@redhat.com>
 <1462791818-4184-9-git-send-email-chuhu@redhat.com>
Message-ID: <1462791818-4184-10-git-send-email-chuhu@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

V2:
    1. fix the bashism code style.
    2. Use ltp API.

V3:
    1. Remove all the tail ';' in 'i=0;' and 'j=0;'
    2. ftrace_buffer_size_kb.sh
           remove the '. test.sh' in tests that don't use it.
    3. ftrace_trace_clock.sh
	   remove the TRACING_PATH var.
    4. ftrace_trace_pipe.sh
           remove '. test.sh'.
	   remove the ftrace_sleep, use tst_sleep instead.
    5. ftrace_trace_stat.sh
	    use tst_random directly.

Signed-off-by: Chunyu Hu <chuhu@redhat.com>
---
 .../ftrace_stress/ftrace_buffer_size_kb.sh         | 20 +++++++-------
 .../ftrace_stress/ftrace_current_tracer.sh         | 14 +++++-----
 .../ftrace_stress/ftrace_ftrace_enabled.sh         | 13 +++++----
 .../ftrace_function_profile_enabled.sh             | 24 +++++------------
 .../ftrace_test/ftrace_stress/ftrace_set_event.sh  | 25 +++++++++--------
 .../ftrace_stress/ftrace_set_ftrace_pid.sh         | 21 +++++++--------
 .../ftrace_stress/ftrace_stack_max_size.sh         | 13 +++++----
 .../ftrace_stress/ftrace_stack_trace.sh            | 19 ++++++-------
 .../ftrace_test/ftrace_stress/ftrace_trace.sh      | 14 +++++-----
 .../ftrace_stress/ftrace_trace_clock.sh            | 22 +++++++--------
 .../ftrace_stress/ftrace_trace_options.sh          |  2 +-
 .../ftrace_test/ftrace_stress/ftrace_trace_pipe.sh | 31 +++++++++-------------
 .../ftrace_test/ftrace_stress/ftrace_trace_stat.sh | 18 ++++++-------
 .../ftrace_stress/ftrace_tracing_enabled.sh        | 13 +++++----
 .../ftrace_stress/ftrace_tracing_max_latency.sh    | 13 ++++-----
 .../ftrace_test/ftrace_stress/ftrace_tracing_on.sh | 13 +++++----
 16 files changed, 124 insertions(+), 151 deletions(-)

diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_buffer_size_kb.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_buffer_size_kb.sh
index bd7dcc4..6652914 100755
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_buffer_size_kb.sh
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_buffer_size_kb.sh
@@ -26,20 +26,20 @@ if [ $step -eq 0 ]; then
 	LOOP=50
 fi
 
-for ((; ;))
-{
+while true; do
 	new_size=1
-	for ((i = 0; i < $LOOP; i++))
-	{
+	i=0
+	while [ $i -lt $LOOP ]; do
 		echo $new_size > "$TRACING_PATH"/buffer_size_kb
 		new_size=$(( $new_size + $step ))
-	}
+		i=$((i + 1))
+	done
 
-	for ((i = 0; i < $LOOP; i++))
-	{
+	i=0
+	while [ $i -lt $LOOP ]; do
 		new_size=$(( $new_size - $step ))
 		echo $new_size > "$TRACING_PATH"/buffer_size_kb
-	}
-
+		i=$((i + 1))
+	done
 	sleep 1
-}
+done
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_current_tracer.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_current_tracer.sh
index 88d576f..104b577 100755
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_current_tracer.sh
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_current_tracer.sh
@@ -15,10 +15,9 @@
 
 LOOP=200
 
-for ((; ;))
-{
-	for ((i = 0; i < $LOOP; i++))
-	{
+while true; do
+	i=0
+	while [ $i -lt $LOOP ]; do
 		for tracer in `cat "$TRACING_PATH"/available_tracers`
 		do
 			if [ "$tracer" = mmiotrace ]; then
@@ -27,8 +26,7 @@ for ((; ;))
 
 			echo $tracer > "$TRACING_PATH"/current_tracer 2> /dev/null
 		done
-	}
-
+		i=$((i + 1))
+	done
 	sleep 1
-}
-
+done
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_ftrace_enabled.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_ftrace_enabled.sh
index 20bb234..c6f8b48 100755
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_ftrace_enabled.sh
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_ftrace_enabled.sh
@@ -16,15 +16,14 @@
 MAX_LOOP=1500
 count=0
 
-for ((; ;))
-{
+while true; do
 	count=$(( $count + 1 ))
-
-	for ((i = 0; i < $MAX_LOOP; i++))
-	{
+	i=0
+	while [ $i -lt $MAX_LOOP ]; do
 		echo 0 > /proc/sys/kernel/ftrace_enabled
 		echo 1 > /proc/sys/kernel/ftrace_enabled
-	}
+		i=$((i + 1))
+	done
 
 	enable=$(( $count % 3 ))
 
@@ -35,5 +34,5 @@ for ((; ;))
 	fi
 
 	sleep 1
-}
+done
 
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_function_profile_enabled.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_function_profile_enabled.sh
index 9c6162a..7687420 100755
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_function_profile_enabled.sh
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_function_profile_enabled.sh
@@ -16,26 +16,15 @@
 MAX_LOOP=1500
 count=0
 
-if [ ! -e "$TRACING_PATH"/function_profile_enabled ]; then
-	should_skip=1
-else
-	should_skip=0
-fi
-
-for ((; ;))
-{
-	if [ $should_skip -eq 1 ]; then
-		sleep 2
-		continue
-	fi
 
+while true; do
 	count=$(( $count + 1 ))
-
-	for ((i = 0; i < $MAX_LOOP; i++))
-	{
+	i=0
+	while [ $i -lt $MAX_LOOP ]; do
 		echo 0 > "$TRACING_PATH"/function_profile_enabled 2> /dev/null
 		echo 1 > "$TRACING_PATH"/function_profile_enabled 2> /dev/null
-	}
+		i=$((i + 1))
+	done
 
 	enable=$(( $count % 3 ))
 
@@ -46,5 +35,4 @@ for ((; ;))
 	fi
 
 	sleep 1
-}
-
+done
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_event.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_event.sh
index e8fd5ea..9a79b42 100755
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_event.sh
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_event.sh
@@ -13,29 +13,28 @@
 #                                                                             #
 ###############################################################################
 
-for ((; ;))
-{
-	for ((i = 0; i < 100; i++))
-	{
+while true; do
+	i=0
+	while [ $i -lt 100 ]; do
 		echo 1 > "$TRACING_PATH"/events/enable
 		echo 0 > "$TRACING_PATH"/events/enable
-	}
+		i=$((i + 1))
+	done
 
-	for dir in `ls $TRACING_PATH/events/`
-	do
+	for dir in `ls $TRACING_PATH/events/`; do
 		if [ ! -d $dir -o "$dir" = ftrace ]; then
 			continue;
 		fi
 
-		for ((i = 0; i < 20; i++))
-		{
+		i=0
+		while [ $i -lt 20 ]; do
 			echo 1 > "$TRACING_PATH"/events/$dir/enable
 			echo 0 > "$TRACING_PATH"/events/$dir/enable
-		}
+			i=$((i + 1))
+		done
 	done
 
-	for event in `cat $TRACING_PATH/available_events`;
-	do
+	for event in `cat $TRACING_PATH/available_events`; do
 		# ftrace event sys is special, skip it
 		if echo "$event" | grep "ftrace:*"; then
 			continue
@@ -44,4 +43,4 @@ for ((; ;))
 	done
 
 	sleep 1
-}
+done
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_ftrace_pid.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_ftrace_pid.sh
index 3eaf017..fd42de4 100755
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_ftrace_pid.sh
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_ftrace_pid.sh
@@ -15,16 +15,15 @@
 
 LOOP=300
 
-
-for ((; ; ))
-{
-	for ((j = 0; j < $LOOP; j++))
-	{
-		for ((k = 1; k <= NR_PIDS; k++))
-		{
+while true; do
+	j=0
+	while [ $j -lt $LOOP ]; do
+		k=1
+		while [ $k -le $NR_PIDS ]; do
 			str="\$pid$k"
 			eval echo $str >> "$TRACING_PATH"/set_ftrace_pid
-		}
+			k=$((k + 1))
+		done
 
 		if ! echo > "$TRACING_PATH"/set_ftrace_pid >/dev/null 2>&1; then
 			if ! echo -1 > "$TRACING_PATH"/set_ftrace_pid >/dev/null 2>&1; then
@@ -32,7 +31,7 @@ for ((; ; ))
 				exit 1
 			fi
 		fi
-	}
-
+		j=$((j + 1))
+	done
 	sleep 1
-}
+done
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_max_size.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_max_size.sh
index 34d506b..0842929 100755
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_max_size.sh
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_max_size.sh
@@ -15,14 +15,13 @@
 
 MAX_STACK_SIZE=8192
 
-for ((; ;))
-{
-	for ((i = 0; i < $MAX_STACK_SIZE; i += 70))
-	{
+while true; do
+	i=0
+	while [ $i -lt $MAX_STACK_SIZE ]; do
 		echo $i > "$TRACING_PATH"/stack_max_size
 		cat "$TRACING_PATH"/stack_max_size > /dev/null
-	}
-
+		i=$((i + 1))
+	done
 	sleep 1
-}
+done
 
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_trace.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_trace.sh
index 1850c26..4c16a0a 100755
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_trace.sh
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_trace.sh
@@ -15,20 +15,21 @@
 
 LOOP=400
 
-for ((; ;))
-{
-	for ((i = 0; i < $LOOP; i++))
-	{
+while true; do
+	i=0
+	while [ $i -lt $LOOP ]; do
 		cat "$TRACING_PATH"/stack_trace > /dev/null
-	}
+		i=$((i + 1))
+	done
 
 	sleep 1
 
-	for ((i = 0; i < $LOOP; i++))
-	{
+	i=0
+	while [ $i -lt $LOOP ]; do
 		echo 0 > /proc/sys/kernel/stack_tracer_enabled
 		echo 1 > /proc/sys/kernel/stack_tracer_enabled
-	}
+		i=$((i + 1))
+	done
 
 	sleep 1
-}
+done
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace.sh
index e36712b..7c45f50 100755
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace.sh
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace.sh
@@ -15,13 +15,11 @@
 
 LOOP=200
 
-for ((; ;))
-{
-	for ((i = 0; i < $LOOP; i++))
-	{
+i=0;
+while true; do
+	while [ $i -lt $LOOP ]; do
 		cat "$TRACING_PATH"/trace > /dev/null
-	}
-
+		i=$((i + 1))
+	done
 	sleep 1
-}
-
+done
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_clock.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_clock.sh
index de6bbea..ca51117 100755
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_clock.sh
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_clock.sh
@@ -24,23 +24,23 @@ else
         old_kernel=0
 fi
 
-for ((; ;))
-{
-	if [ $old_kernel -eq 1 ];
-	then
-		for ((i = 0; i < $LOOP; i++))
-		{
+while true; do
+	i=0
+	if [ $old_kernel -eq 1 ]; then
+		while [ $i -lt $LOOP ]; do
 			echo 1 > "$TRACING_PATH"/options/global-clock
 			echo 0 > "$TRACING_PATH"/options/global-clock
-		}
+			i=$((i + 1))
+		done
 	else
-		for ((i = 0; i < $LOOP; i++))
-		{
+		while [ $i -lt $LOOP ]; do
 			echo local > "$TRACING_PATH"/trace_clock
 			echo global > "$TRACING_PATH"/trace_clock
-		}
+			i=$((i + 1))
+		done
+
 	fi
 
 	sleep 1
-}
+done
 
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_options.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_options.sh
index 253568c..95da3f6 100755
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_options.sh
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_options.sh
@@ -18,7 +18,7 @@
 LOOP=200
 
 while true; do
-	j=0;
+	j=0
 	while [ $j -lt $LOOP ]; do
 		trace_options="$(ls $TRACING_PATH/options/)"
 		# enable the nop_test_refuse can cause an
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_pipe.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_pipe.sh
index 47d42bc..e6bf717 100755
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_pipe.sh
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_pipe.sh
@@ -13,15 +13,6 @@
 #                                                                             #
 ###############################################################################
 
-ftrace_sleep()
-{
-	# usleep is not a standard command?
-	usleep 200000 2> /dev/null
-	if [ $? -ne 0 ]; then
-		sleep 1
-	fi
-}
-
 kill_this_pid()
 {
 	/bin/kill -SIGKILL $this_pid
@@ -33,20 +24,22 @@ trap kill_this_pid SIGUSR1
 
 LOOP=20
 
-for ((; ;))
-{
-	for ((i = 0; i < $LOOP; i++))
-	{
+while true; do
+	i=0
+	while [ $i -lt $LOOP ]; do
 		cat "$TRACING_PATH"/trace_pipe > /dev/null &
-
 		this_pid=$!
-		ftrace_sleep
+
+		tst_sleep 200000us
+
 		/bin/kill -SIGINT $this_pid
 		wait $this_pid
+
 		this_pid=0
-		ftrace_sleep
-	}
 
-	sleep 2
-}
+		tst_sleep 200000us
 
+		i=$((i + 1))
+	done
+	sleep 2
+done
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_stat.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_stat.sh
index d7e6fd3..f854e83 100755
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_stat.sh
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_stat.sh
@@ -16,6 +16,7 @@
 LOOP=200
 
 should_skip=0
+nr_cpus=`tst_ncpus`
 
 if [ ! -e "$TRACING_PATH"/function_profile_enabled ]; then
         should_skip=1
@@ -28,18 +29,17 @@ if [ $? -eq 0 ]; then
 	should_skip=1
 fi
 
-for ((; ;))
-{
+while true; do
 	if [ $should_skip -eq 1 ]; then
 		sleep 2
 		continue
 	fi
-
-	for ((i = 0; i < $LOOP; i++))
-	{
-		cat "$TRACING_PATH"/trace_stat/function0 > /dev/null 2>&1
-	}
+	cpu=$(tst_random 0 $((nr_cpus - 1)))
+	i=0;
+	while [ $i -lt $LOOP ]; do
+		cat "$TRACING_PATH"/trace_stat/function${cpu} > /dev/null 2>&1
+		i=$((i + 1))
+	done
 
 	sleep 1
-}
-
+done
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_enabled.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_enabled.sh
index 69f2ae6..9e0f5a7 100755
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_enabled.sh
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_enabled.sh
@@ -16,15 +16,14 @@
 MAX_LOOP=1500
 count=0
 
-for ((; ;))
-{
+while true; do
 	count=$(( $count + 1 ))
-
-	for ((i = 0; i < $MAX_LOOP; i++))
-	{
+	i=0
+	while [ $i -lt $MAX_LOOP ]; do
 		echo 0 > "$TRACING_PATH"/tracing_enabled
 		echo 1 > "$TRACING_PATH"/tracing_enabled
-	}
+		i=$((i + 1))
+	done
 
 	enable=$(( $count % 3 ))
 
@@ -35,5 +34,5 @@ for ((; ;))
 	fi
 
 	sleep 1
-}
+done
 
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_max_latency.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_max_latency.sh
index fbaceb8..4ad8891 100755
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_max_latency.sh
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_max_latency.sh
@@ -15,12 +15,13 @@
 
 MAX_LATENCY=100000
 
-for ((; ;))
-{
-	for ((i = 0; i < $MAX_LATENCY; i += 400))
-	{
+while true; do
+	i=0
+	while [ $i -lt $MAX_LATENCY ]; do
 		echo $i > "$TRACING_PATH"/tracing_max_latency
-	}
+		i=$((i + 400))
+	done
 
 	sleep 1
-}
+
+done
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_on.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_on.sh
index 672c223..5ae9d76 100755
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_on.sh
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_on.sh
@@ -16,15 +16,14 @@
 MAX_LOOP=1500
 count=0
 
-for ((; ;))
-{
+while true; do
 	count=$(( $count + 1 ))
-
-	for ((i = 0; i < $MAX_LOOP; i++))
-	{
+	i=0
+	while [ $i -lt $MAX_LOOP ]; do
 		echo 0 > "$TRACING_PATH"/tracing_on
 		echo 1 > "$TRACING_PATH"/tracing_on
-	}
+		i=$((i + 1))
+	done
 
 	enable=$(( $count % 3 ))
 
@@ -35,5 +34,5 @@ for ((; ;))
 	fi
 
 	sleep 1
-}
+done
 
-- 
1.8.3.1

