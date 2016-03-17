From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 17 Mar 2016 18:07:01 +0100
Subject: [LTP] [PATCH RFC 6/9] ftrace_stress: skip unsupported tests
In-Reply-To: <1457079898-9449-7-git-send-email-liwang@redhat.com>
References: <1457079898-9449-1-git-send-email-liwang@redhat.com>
 <1457079898-9449-2-git-send-email-liwang@redhat.com>
 <1457079898-9449-3-git-send-email-liwang@redhat.com>
 <1457079898-9449-4-git-send-email-liwang@redhat.com>
 <1457079898-9449-5-git-send-email-liwang@redhat.com>
 <1457079898-9449-6-git-send-email-liwang@redhat.com>
 <1457079898-9449-7-git-send-email-liwang@redhat.com>
Message-ID: <20160317170701.GG31815@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  	if [ -e stack_max_size ]; then
>  		old_stack_tracer_enabled=`cat /proc/sys/kernel/stack_tracer_enabled`
>  	fi
> @@ -86,7 +89,10 @@ restore_old_setting()
>  
>  	echo $old_buffer_size > buffer_size_kb
>  	echo $old_tracing_on > tracing_on
> -	echo $old_tracing_enabled > tracing_enabled
> +
> +	if [ -e tracing_enabled ];then
                                  ^
				  missing space here
> +		echo $old_tracing_enabled > tracing_enabled
> +	fi
>  
>  	for option in $old_trace_options
>  	do
> diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_event.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_event.sh
> index d7efdd4..d1a6bd3 100755
> --- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_event.sh
> +++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_event.sh
> @@ -36,6 +36,8 @@ for ((; ;))
>  
>  	for event in `cat $TRACING_PATH/available_events`;
>  	do
> +		# ftrace event sys is special, skip it
> +		[[ $event =~ ftrace:* ]] && continue

This is bashism.

>  		echo $event >> "$TRACING_PATH"/set_event
>  	done
>  
> diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_ftrace_pid.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_ftrace_pid.sh
> index 7bc76d9..3eaf017 100755
> --- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_ftrace_pid.sh
> +++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_ftrace_pid.sh
> @@ -15,19 +15,9 @@
>  
>  LOOP=300
>  
> -if [ ! -e "$TRACING_PATH"/set_ftrace_pid ]; then
> -	should_skip=1
> -else
> -	should_skip=0
> -fi
>  
>  for ((; ; ))
>  {
> -	if [ $should_skip -eq 1 ]; then
> -		sleep 2
> -		continue
> -	fi
> -
>  	for ((j = 0; j < $LOOP; j++))
>  	{
>  		for ((k = 1; k <= NR_PIDS; k++))
> @@ -46,4 +36,3 @@ for ((; ; ))
>  
>  	sleep 1
>  }
> -
> diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_max_size.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_max_size.sh
> index 682d05e..34d506b 100755
> --- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_max_size.sh
> +++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_max_size.sh
> @@ -15,19 +15,8 @@
>  
>  MAX_STACK_SIZE=8192
>  
> -if [ ! -e /proc/sys/kernel/stack_tracer_enabled ]; then
> -	should_skip=1
> -else
> -	should_skip=0
> -fi
> -
>  for ((; ;))
>  {
> -	if [ $should_skip -eq 1 ]; then
> -		sleep 2
> -		continue
> -	fi
> -
>  	for ((i = 0; i < $MAX_STACK_SIZE; i += 70))
>  	{
>  		echo $i > "$TRACING_PATH"/stack_max_size
> diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_trace.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_trace.sh
> index a406c51..1850c26 100755
> --- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_trace.sh
> +++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_trace.sh
> @@ -15,19 +15,8 @@
>  
>  LOOP=400
>  
> -if [ ! -e /proc/sys/kernel/stack_tracer_enabled ]; then
> -	should_skip=1
> -else
> -	should_skip=0
> -fi
> -
>  for ((; ;))
>  {
> -	if [ $should_skip -eq 1 ]; then
> -		sleep 2
> -		continue
> -	fi
> -
>  	for ((i = 0; i < $LOOP; i++))
>  	{
>  		cat "$TRACING_PATH"/stack_trace > /dev/null
> @@ -43,4 +32,3 @@ for ((; ;))
>  
>  	sleep 1
>  }
> -
> diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_max_latency.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_max_latency.sh
> index f19d734..fbaceb8 100755
> --- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_max_latency.sh
> +++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_max_latency.sh
> @@ -15,19 +15,8 @@
>  
>  MAX_LATENCY=100000
>  
> -if [ ! -e "$TRACING_PATH"/tracing_max_latency ]; then
> -        should_skip=1
> -else
> -        should_skip=0
> -fi
> -
>  for ((; ;))
>  {
> -        if [ $should_skip -eq 1 ]; then
> -                sleep 2
> -                continue
> -        fi
> -
>  	for ((i = 0; i < $MAX_LATENCY; i += 400))
>  	{
>  		echo $i > "$TRACING_PATH"/tracing_max_latency
> @@ -35,4 +24,3 @@ for ((; ;))
>  
>  	sleep 1
>  }
> -
> diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
> index beced43..d1be49a 100755
> --- a/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
> +++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
> @@ -21,82 +21,77 @@
>  ##                                                                       ##
>  ###########################################################################
>  
> -
>  export TCID="ftrace-stress-test"
>  export TST_TOTAL=1
>  export TST_COUNT=1
>  
>  . ftrace_lib.sh
>  
> -export_pids()
> -{
> -	export pid1 pid2 pid3 pid4 pid5 pid6 pid7 pid8 pid9 pid10 pid11 pid12 \
> -		pid13 pid14 pid15 pid16
> +test_targets=" \
> +trace_pipe current_tracer ftrace_enabled function_profile_enabled \
> +set_event set_ftrace_pid stack_max_size stack_trace trace trace_clock \
> +trace_options trace_stat tracing_enabled tracing_max_latency \
> +tracing_on function_profile_enabled buffer_size_kb"
>  
> -	export NR_PIDS=16
> +get_skip_targets()
> +{
> +	for target in ${test_targets}; do
> +		if [ ! -e $TRACING_PATH/$target ] &&
> +			[ ! -e /proc/sys/kernel/$target ]; then
> +			eval skip_$target=1
> +			echo "$target is not supported. Skip it."
> +		else
> +			eval skip_$target=0
> +		fi
> +	done
>  }
>  
> -test_stress()
> +should_skip_target()
>  {
> -	export_pids
> -
> -	$SPATH/ftrace_trace_clock.sh &
> -	pid1=$!
> -	$SPATH/ftrace_current_tracer.sh &
> -	pid2=$!
> -	$SPATH/ftrace_trace_options.sh &
> -	pid3=$!
> -	$SPATH/ftrace_tracing_max_latency.sh &
> -	pid4=$!
> -	$SPATH/ftrace_stack_trace.sh &
> -	pid5=$!
> -	$SPATH/ftrace_stack_max_size.sh &
> -	pid6=$!
> -	$SPATH/ftrace_tracing_on.sh &
> -	pid7=$!
> -	$SPATH/ftrace_tracing_enabled.sh &
> -	pid8=$!
> -	$SPATH/ftrace_set_event.sh &
> -	pid9=$!
> -	$SPATH/ftrace_buffer_size.sh &
> -	pid10=$!
> -	$SPATH/ftrace_trace.sh &
> -	pid11=$!
> -	$SPATH/ftrace_trace_pipe.sh &
> -	pid12=$!
> -	$SPATH/ftrace_ftrace_enabled.sh &
> -	pid13=$!
> -	$SPATH/ftrace_set_ftrace_pid.sh &
> -	pid14=$!
> -	$SPATH/ftrace_profile_enabled.sh &
> -	pid15=$!
> -	$SPATH/ftrace_trace_stat.sh &
> -	pid16=$!
> +	local var=skip_$1
> +	local val=${!var}
> +	[ "$val" = 1 ]
>  }
>  
>  test_kill()
>  {
> -	kill -KILL $pid1 || test_success=false
> -	kill -KILL $pid2 || test_success=false
> -	kill -KILL $pid3 || test_success=false
> -	kill -KILL $pid4 || test_success=false
> -	kill -KILL $pid5 || test_success=false
> -	kill -KILL $pid6 || test_success=false
> -	kill -KILL $pid7 || test_success=false
> -	kill -KILL $pid8 || test_success=false
> -	kill -KILL $pid9 || test_success=false
> -	kill -KILL $pid10 || test_success=false
> -	kill -KILL $pid11 || test_success=false
> -	kill -USR1 $pid12 || test_success=false
> -	kill -KILL $pid13 || test_success=false
> -	kill -KILL $pid14 || test_success=false
> -	kill -KILL $pid15 || test_success=false
> -	kill -KILL $pid16 || test_success=false
> +	kill -USR1 ${pid0} || test_success=false
> +
> +	for ((p=1; p<NR_PIDS; p++))
> +	{
> +		local kill_pid=pid${p}
> +		kill -KILL ${!kill_pid} || test_success=false
> +	}

Again this is bashism loop over $(seq NR_PIDS).

>  	sleep 2

We should wait on the pids here instead of the sleep, which would
guarantee tha the processes have really finished.

>  	clean_up
>  }
>  
> +test_stress()
> +{
> +	NR_PIDS=0
> +	echo "Test targets: ${test_targets}"
> +	get_skip_targets
> +	for target in ${test_targets}; do
> +		if should_skip_target $target; then
> +			continue
> +		fi
> +		$SPATH/ftrace_${target}.sh &

The path to test binaries must be in $PATH before testcases are executed
so you should just do ftrace_${target}.sh & instead.

> +		eval pid${NR_PIDS}=$!
> +		echo "Start pid${NR_PIDS}=$! $SPATH/ftrace_${target}.sh"
> +		((NR_PIDS++))

Bashism. Portable way is a=$((a+1))

> +	done
> +	export_pids
> +}
> +
> +export_pids()
> +{
> +	for ((i=0; i<NR_PIDS; i++))
> +	{
> +		export pid${i}
> +	}

Bashism again.

> +	export NR_PIDS
> +}
>  
>  # ----------------------------
>  echo "Ftrace Stress Test Begin"
> @@ -111,11 +106,11 @@ test_wait
>  
>  test_kill
>  
> -echo "Ftrace Stress Test End"
> -
>  if $test_success; then
>  	tst_resm TPASS "finished running the test. Run dmesg to double-check for bugs"
>  else
>  	tst_resm TFAIL "please check log message."
>  	exit 1
>  fi

Again the test should be really converted to test.sh library. That way
we would exit with correct exit status at tst_exit instead of calling
exit manually depending on some flag.

> +echo "Ftrace Stress Test End"

And ideally bashism should be fixed in the substests called from this
tests. So that the test can run with dash or bussy box as well.

-- 
Cyril Hrubis
chrubis@suse.cz
