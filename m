From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 4 May 2016 16:56:30 +0200
Subject: [LTP] [PATCH V2 9/9] ftrace_stress: cleanup and use ltp API
In-Reply-To: <1460966656-28328-10-git-send-email-chuhu@redhat.com>
References: <1460966656-28328-1-git-send-email-chuhu@redhat.com>
 <1460966656-28328-2-git-send-email-chuhu@redhat.com>
 <1460966656-28328-3-git-send-email-chuhu@redhat.com>
 <1460966656-28328-4-git-send-email-chuhu@redhat.com>
 <1460966656-28328-5-git-send-email-chuhu@redhat.com>
 <1460966656-28328-6-git-send-email-chuhu@redhat.com>
 <1460966656-28328-7-git-send-email-chuhu@redhat.com>
 <1460966656-28328-8-git-send-email-chuhu@redhat.com>
 <1460966656-28328-9-git-send-email-chuhu@redhat.com>
 <1460966656-28328-10-git-send-email-chuhu@redhat.com>
Message-ID: <20160504145630.GE12244@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> --- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_buffer_size_kb.sh
> +++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_buffer_size_kb.sh
> @@ -26,20 +26,20 @@ if [ $step -eq 0 ]; then
>  	LOOP=50
>  fi
>  
> -for ((; ;))
> -{
> +while true; do
>  	new_size=1
> -	for ((i = 0; i < $LOOP; i++))
> -	{
> +	i=0;

The semicolon after i=0 is useless (and in all i=0; lines in this
patch).

...

> diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_clock.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_clock.sh
> index de6bbea..70135c1 100755
> --- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_clock.sh
> +++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_clock.sh
> @@ -13,6 +13,9 @@
>  #                                                                             #
>  ###############################################################################
>  
> +. test.sh

No need to source test.sh for the tst_kvercmp which is a separate
binary.

> +TRACING_PATH=/sys/kernel/debug/tracing/

Shouldn't this be propagated from the main script? What's the point of
redefining it here?

>  LOOP=400
>  
>  # In kernel which is older than 2.6.32, we set global clock
> @@ -24,23 +27,23 @@ else
>          old_kernel=0
>  fi
>  
> -for ((; ;))
> -{
> -	if [ $old_kernel -eq 1 ];
> -	then
> -		for ((i = 0; i < $LOOP; i++))
> -		{
> +while true; do
> +	i=0;
> +	if [ $old_kernel -eq 1 ]; then
> +		while [ $i -lt $LOOP ]; do
>  			echo 1 > "$TRACING_PATH"/options/global-clock
>  			echo 0 > "$TRACING_PATH"/options/global-clock
> -		}
> +			i=$((i + 1))
> +		done
>  	else
> -		for ((i = 0; i < $LOOP; i++))
> -		{
> +		while [ $i -lt $LOOP ]; do
>  			echo local > "$TRACING_PATH"/trace_clock
>  			echo global > "$TRACING_PATH"/trace_clock
> -		}
> +			i=$((i + 1))
> +		done
> +
>  	fi
>  
>  	sleep 1
> -}
> +done
>  
> diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_pipe.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_pipe.sh
> index 47d42bc..a24008a 100755
> --- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_pipe.sh
> +++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_pipe.sh
> @@ -13,10 +13,11 @@
>  #                                                                             #
>  ###############################################################################
>  
> +. test.sh

You don't have to add test.sh for tst_sleep.

>  ftrace_sleep()
>  {
> -	# usleep is not a standard command?
> -	usleep 200000 2> /dev/null
> +	tst_sleep 200000us
>  	if [ $? -ne 0 ]; then
>  		sleep 1
>  	fi

You should remove the fallback to sleep 1 if the usleep wasn't found.
Ideally the whole function ftrace_sleep should be removed and you should
just call tst_sleep from the main loop.

> @@ -33,10 +34,9 @@ trap kill_this_pid SIGUSR1
>  
>  LOOP=20
>  
> -for ((; ;))
> -{
> -	for ((i = 0; i < $LOOP; i++))
> -	{
> +while true; do
> +	i=0;
> +	while [ $i -lt $LOOP ]; do
>  		cat "$TRACING_PATH"/trace_pipe > /dev/null &
>  
>  		this_pid=$!
> @@ -45,8 +45,7 @@ for ((; ;))
>  		wait $this_pid
>  		this_pid=0
>  		ftrace_sleep
> -	}
> -
> +		i=$((i + 1))
> +	done
>  	sleep 2
> -}
> -
> +done

And you should also fix the kill called by the full path in this script.
It should really be just kill not /bin/kill.

> diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_stat.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_stat.sh
> index d7e6fd3..2691991 100755
> --- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_stat.sh
> +++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_stat.sh
> @@ -16,6 +16,8 @@
>  LOOP=200
>  
>  should_skip=0
> +rand_gen=tst_random

What's the point of assigning tst_random into a variable instead of
using it directly?

> +nr_cpus=`tst_ncpus`
>  
>  if [ ! -e "$TRACING_PATH"/function_profile_enabled ]; then
>          should_skip=1
> @@ -28,18 +30,17 @@ if [ $? -eq 0 ]; then
>  	should_skip=1
>  fi
>  
> -for ((; ;))
> -{
> +while true; do
>  	if [ $should_skip -eq 1 ]; then
>  		sleep 2
>  		continue
>  	fi
> -
> -	for ((i = 0; i < $LOOP; i++))
> -	{
> -		cat "$TRACING_PATH"/trace_stat/function0 > /dev/null 2>&1
> -	}
> +	cpu=$($rand_gen 0 $((nr_cpus - 1)))
> +	i=0;
> +	while [ $i -lt $LOOP ]; do
> +		cat "$TRACING_PATH"/trace_stat/function${cpu} > /dev/null 2>&1
> +		i=$((i + 1))
> +	done
>  
>  	sleep 1
> -}
> -
> +done

...

> diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_max_latency.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_max_latency.sh
> index fbaceb8..6090a91 100755
> --- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_max_latency.sh
> +++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_max_latency.sh
> @@ -15,12 +15,13 @@
>  
>  MAX_LATENCY=100000
>  
> -for ((; ;))
> -{
> -	for ((i = 0; i < $MAX_LATENCY; i += 400))
> -	{
> +while true; do
> +	i=0;
> +	while [ $i -lt $MAX_LATENCY ]; do
>  		echo $i > "$TRACING_PATH"/tracing_max_latency
> -	}
> +		i=$((i + 400))
> +	done
>  
>  	sleep 1
> -}
> +
> +Vdone
   ^
   Typo?

-- 
Cyril Hrubis
chrubis@suse.cz
