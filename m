From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 17 Mar 2016 19:08:33 +0100
Subject: [LTP] [PATCH RFC 9/9] ftrace_stress: add two new tests
In-Reply-To: <1457079898-9449-10-git-send-email-liwang@redhat.com>
References: <1457079898-9449-1-git-send-email-liwang@redhat.com>
 <1457079898-9449-2-git-send-email-liwang@redhat.com>
 <1457079898-9449-3-git-send-email-liwang@redhat.com>
 <1457079898-9449-4-git-send-email-liwang@redhat.com>
 <1457079898-9449-5-git-send-email-liwang@redhat.com>
 <1457079898-9449-6-git-send-email-liwang@redhat.com>
 <1457079898-9449-7-git-send-email-liwang@redhat.com>
 <1457079898-9449-8-git-send-email-liwang@redhat.com>
 <1457079898-9449-9-git-send-email-liwang@redhat.com>
 <1457079898-9449-10-git-send-email-liwang@redhat.com>
Message-ID: <20160317180833.GJ31815@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +###########################################################################
> +##                                                                       ##
> +## Copyright (c) 2015, Red Hat Inc.                                      ##
> +##                                                                       ##
> +## This program is free software: you can redistribute it and/or modify  ##
> +## it under the terms of the GNU General Public License as published by  ##
> +## the Free Software Foundation, either version 3 of the License, or     ##
> +## (at your option) any later version.                                   ##
> +##                                                                       ##
> +## This program is distributed in the hope that it will be useful,       ##
> +## but WITHOUT ANY WARRANTY; without even the implied warranty of        ##
> +## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the          ##
> +## GNU General Public License for more details.                          ##
> +##                                                                       ##
> +## You should have received a copy of the GNU General Public License     ##
> +## along with this program. If not, see <http://www.gnu.org/licenses/>.  ##
> +##                                                                       ##
> +## Author: Chunyu Hu <chuhu@redhat.com>                                  ##
> +##                                                                       ##
> +###########################################################################
> +
> +triggers=( traceon traceoff enable_event disable_event snapshot\
> +	 dump cpudump stacktrace module function )
> +n_triggers=${#triggers}

Bashism again.

> +module_pick()
> +{
> +	nr_module=$(lsmod | wc -l)
> +	pick_one=$(( (RANDOM % nr_module) +1 ))
> +	picked_module=$(lsmod | sed -n ''$pick_one'p')

Unfortunately there is no portable way to get random numbers in shell.

So the best we can do is to write a small helper tst_random to take a
range and produce random number in that range. I would have just added a
simple C program to testcases/lib/ the same way we did for portable
sleep shorted than 1s in tst_sleep.c.

> +}
> +
> +nr_functions=$(cat $TRACING_PATH/available_filter_functions|wc -l)

You can do just 'wc -l $TRACING_PATH/available_filter_functions'

> +function_pick()
> +{
	local AVAILABLE_FUNCTIONS="$TRACING_PATH/available_filter_functions"
> +	if [ -f $TRACING_PATH/available_filter_functions ]; then
> +		local pick_one=$(( (RANDOM % nr_functions) + 1 ))
> +		picked_function=$(cat $TRACING_PATH/available_filter_functions |\
> +				 sed -n ''$pick_one'p'|awk '{print $1}')
> +		echo $picked_function

You can just do:

		awk "{if (NR==$pick_one) {print \$1}}" $AVAILABLE_FUNCTIONS

instead of cat, sed and echo.

> +	else
> +		echo "\*sched\*"
> +	fi
> +}
> +
> +event_pick()
> +{
> +	if [ -f $TRACING_PATH/available_events ]; then
> +		nr_events=$(cat $TRACING_PATH/available_events | wc -l)
> +		local pick_one=$(( (RANDOM % nr_events) + 1 ))
> +		picked_event=$(cat $TRACING_PATH/available_events | sed -n ''$pick_one'p')
> +
> +		echo "$picked_event"

Here as well no need to use echo and cat:

sed -n ''$pick_one'p' $AVAILABLE_EVENTS

> +	else
> +		echo "sched:sched_switch"
> +	fi
> +}
> +
> +filter_formatter()
> +{
> +	local count=$(( (RANDOM % 5) + 1 ))
> +	function_name=$(function_pick)
> +	case $1 in
> +	traceon|traceoff|snapshot|dump|cpudump|stacktrace|module|function)
> +		format=$1
> +		;;
> +	enable_event|disable_event)
> +		event_sys_name=$(event_pick)
> +		format=$1:$event_sys_name
> +		;;
> +	module)
> +		module_pick
> +		echo "$picked_module:\*"
> +		return
> +		;;
> +	function)
> +		echo "$picked_function"
> +		return
> +		;;
> +	*)
> +		format=$1
> +		;;
> +	esac
> +	((count)) && format=$format:$count

Bahsism. Also the count is non-zero since it's RANDOM % 5 + 1.

> +	echo $function_name:$format
> +}
> +
> +for ((; ;))
> +{

Bash style loop. Use while true; do ... done

> +	cat $TRACING_PATH/set_ftrace_filter > /dev/null

Why do we cat the file to /dev/null?

> +	trigger_index=$((RANDOM % n_triggers))
> +	trigger_name=${triggers[$trigger_index]}
> +	filter_format=$(filter_formatter $trigger_name)
> +
> +	echo "$filter_format" > $TRACING_PATH/set_ftrace_filter
> +	[ $? -ne 0 ] && echo "setup filter <$filter_format> failed"

Shouldn't we report a failure here?

> +	sleep 1
> +
> +	echo "!$filter_format" > $TRACING_PATH/set_ftrace_filter
> +	[ $? -ne 0 ] && echo "remove filter <$filter_format> failed"

Here as well.

> +}
> diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_cpumask.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_cpumask.sh
> new file mode 100755
> index 0000000..28bbc27
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_cpumask.sh
> @@ -0,0 +1,51 @@
> +#! /bin/sh
> +
> +###########################################################################
> +##                                                                       ##
> +## Copyright (c) 2015, Red Hat Inc.                                      ##
> +##                                                                       ##
> +## This program is free software: you can redistribute it and/or modify  ##
> +## it under the terms of the GNU General Public License as published by  ##
> +## the Free Software Foundation, either version 3 of the License, or     ##
> +## (at your option) any later version.                                   ##
> +##                                                                       ##
> +## This program is distributed in the hope that it will be useful,       ##
> +## but WITHOUT ANY WARRANTY; without even the implied warranty of        ##
> +## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the          ##
> +## GNU General Public License for more details.                          ##
> +##                                                                       ##
> +## You should have received a copy of the GNU General Public License     ##
> +## along with this program. If not, see <http://www.gnu.org/licenses/>.  ##
> +##                                                                       ##
> +## Author: Chunyu Hu <chuhu@redhat.com>                                  ##
> +##                                                                       ##
> +###########################################################################
> +
> +nr_cpus=`tst_ncpus`
> +
> +get_random_value()
> +{
> +	local max=$1
> +	local min=${2:-0}
> +	local random=${RANDOM:-$(date +%N)}
> +	echo $(( random % max  ))
> +}

Well looks like you have implemented portable random function after all
although the range does not work at all.

it should really be:

echo $((min + (random % (max - min + 1))))

Which would cover range [min, max] including both min and max.

And the function should be in a library used by all the testcases.

> +get_test_cpumask()
> +{
> +	local random=${RANDOM:-$(date +%N)}

Unused variable.

> +	local set_cnt=$(get_random_value $nr_cpus);
> +	mask=0
> +	for ((c=0; c<set_cnt; c++));do

Bashism.

> +		local cpuid=$(get_random_value $nr_cpus)
> +		mask=$(( mask| (1<<$cpuid) ))
> +	done
> +	mask=`echo $mask | awk '{printf "%x",$0}'`

Why can't we echo the mask here and do:

get_test_cpumask > $TRACING_PATH/tracing_cpumask

in the main loop?

> +}
> +
> +for ((; ;))
> +{

Bashism.

> +	get_test_cpumask
> +	echo $mask > $TRACING_PATH/tracing_cpumask
> +	sleep 5

Why sleep 5?

> +}
> diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
> index d1be49a..49cae86 100755
> --- a/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
> +++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
> @@ -31,7 +31,8 @@ test_targets=" \
>  trace_pipe current_tracer ftrace_enabled function_profile_enabled \
>  set_event set_ftrace_pid stack_max_size stack_trace trace trace_clock \
>  trace_options trace_stat tracing_enabled tracing_max_latency \
> -tracing_on function_profile_enabled buffer_size_kb"
> +tracing_on function_profile_enabled buffer_size_kb tracing_cpumask \
> +set_ftrace_filter"
>  
>  get_skip_targets()
>  {
> -- 
> 1.8.3.1
> 
> 
> -- 
> Mailing list info: http://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
