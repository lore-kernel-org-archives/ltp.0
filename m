From: Chunyu Hu <chuhu@redhat.com>
Date: Fri, 18 Mar 2016 10:08:24 -0400 (EDT)
Subject: [LTP] [PATCH RFC 9/9] ftrace_stress: add two new tests
In-Reply-To: <20160317180833.GJ31815@rei.lan>
References: <1457079898-9449-1-git-send-email-liwang@redhat.com>
 <1457079898-9449-5-git-send-email-liwang@redhat.com>
 <1457079898-9449-6-git-send-email-liwang@redhat.com>
 <1457079898-9449-7-git-send-email-liwang@redhat.com>
 <1457079898-9449-8-git-send-email-liwang@redhat.com>
 <1457079898-9449-9-git-send-email-liwang@redhat.com>
 <1457079898-9449-10-git-send-email-liwang@redhat.com>
 <20160317180833.GJ31815@rei.lan>
Message-ID: <1617631867.29672478.1458310104811.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi Cyril,

Thanks for the review. Seems some Bash styles needs to be fixed in all subcase.
I replied the issues you pointed out below. You mean I need to write a c bin 
to generate random? Or you will make it in lib?

----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Li Wang" <liwang@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Friday, March 18, 2016 2:08:33 AM
> Subject: Re: [LTP] [PATCH RFC 9/9] ftrace_stress: add two new tests
> 
> Hi!
> > +###########################################################################
> > +##
> > ##
> > +## Copyright (c) 2015, Red Hat Inc.
> > ##
> > +##
> > ##
> > +## This program is free software: you can redistribute it and/or modify
> > ##
> > +## it under the terms of the GNU General Public License as published by
> > ##
> > +## the Free Software Foundation, either version 3 of the License, or
> > ##
> > +## (at your option) any later version.
> > ##
> > +##
> > ##
> > +## This program is distributed in the hope that it will be useful,
> > ##
> > +## but WITHOUT ANY WARRANTY; without even the implied warranty of
> > ##
> > +## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> > ##
> > +## GNU General Public License for more details.
> > ##
> > +##
> > ##
> > +## You should have received a copy of the GNU General Public License
> > ##
> > +## along with this program. If not, see <http://www.gnu.org/licenses/>.
> > ##
> > +##
> > ##
> > +## Author: Chunyu Hu <chuhu@redhat.com>
> > ##
> > +##
> > ##
> > +###########################################################################
> > +
> > +triggers=( traceon traceoff enable_event disable_event snapshot\
> > +	 dump cpudump stacktrace module function )
> > +n_triggers=${#triggers}
> 
> Bashism again.

Hi Cyril,

I have to ask a question about the portable.Can we use an array here? You
mean we can't use array or just can't use the ${#array_name} to get the 
number of elements? If array can be used, I guess I can use something like

echo ${triggers[*]} | wc -w , If not accepted by some shells. Then I need to
change it to string, and use the way you mentioned echo "$string" | wc -w

Thanks!

> > +module_pick()
> > +{
> > +	nr_module=$(lsmod | wc -l)
> > +	pick_one=$(( (RANDOM % nr_module) +1 ))
> > +	picked_module=$(lsmod | sed -n ''$pick_one'p')
> 
> Unfortunately there is no portable way to get random numbers in shell.

Agree, I really worried that this RANDOME value may not work in some case,
you confirmed my concern, but i didn't come up with a good solution.

> 
> So the best we can do is to write a small helper tst_random to take a
> range and produce random number in that range. I would have just added a
> simple C program to testcases/lib/ the same way we did for portable
> sleep shorted than 1s in tst_sleep.c.

Thanks ! If we have that interface, that will be great! Hope I can use it in V2.


> > +}
> > +
> > +nr_functions=$(cat $TRACING_PATH/available_filter_functions|wc -l)
> 
> You can do just 'wc -l $TRACING_PATH/available_filter_functions'

Agree, really my bad habit of using a pipe. Thanks for the suggestion.

> > +function_pick()
> > +{
> 	local AVAILABLE_FUNCTIONS="$TRACING_PATH/available_filter_functions"
> > +	if [ -f $TRACING_PATH/available_filter_functions ]; then
> > +		local pick_one=$(( (RANDOM % nr_functions) + 1 ))
> > +		picked_function=$(cat $TRACING_PATH/available_filter_functions |\
> > +				 sed -n ''$pick_one'p'|awk '{print $1}')
> > +		echo $picked_function
> 
> You can just do:
> 
> 		awk "{if (NR==$pick_one) {print \$1}}" $AVAILABLE_FUNCTIONS
> 
> instead of cat, sed and echo.

Oh, that's amazing, I learned a new method.  Thanks for the good suggestion.
Will update it in V2.

> > +	else
> > +		echo "\*sched\*"
> > +	fi
> > +}
> > +
> > +event_pick()
> > +{
> > +	if [ -f $TRACING_PATH/available_events ]; then
> > +		nr_events=$(cat $TRACING_PATH/available_events | wc -l)
> > +		local pick_one=$(( (RANDOM % nr_events) + 1 ))
> > +		picked_event=$(cat $TRACING_PATH/available_events | sed -n
> > ''$pick_one'p')
> > +
> > +		echo "$picked_event"
> 
> Here as well no need to use echo and cat:
> 
> sed -n ''$pick_one'p' $AVAILABLE_EVENTS

Will update it V2. Thanks!


> > +	else
> > +		echo "sched:sched_switch"
> > +	fi
> > +}
> > +
> > +filter_formatter()
> > +{
> > +	local count=$(( (RANDOM % 5) + 1 ))
> > +	function_name=$(function_pick)
> > +	case $1 in
> > +	traceon|traceoff|snapshot|dump|cpudump|stacktrace|module|function)
> > +		format=$1
> > +		;;
> > +	enable_event|disable_event)
> > +		event_sys_name=$(event_pick)
> > +		format=$1:$event_sys_name
> > +		;;
> > +	module)
> > +		module_pick
> > +		echo "$picked_module:\*"
> > +		return
> > +		;;
> > +	function)
> > +		echo "$picked_function"
> > +		return
> > +		;;
> > +	*)
> > +		format=$1
> > +		;;
> > +	esac
> > +	((count)) && format=$format:$count
> 
> Bahsism. Also the count is non-zero since it's RANDOM % 5 + 1.

Will modify it in V2. Something like:

if [ $count -gt 0 ]; then
     .....
fi

And will correct the random issue in V2. Thanks.


> > +	echo $function_name:$format
> > +}
> > +
> > +for ((; ;))
> > +{
> 
> Bash style loop. Use while true; do ... done

Will make it while []; do in V2.


> > +	cat $TRACING_PATH/set_ftrace_filter > /dev/null
> 
> Why do we cat the file to /dev/null?

since the set_ftrace_filter can use reg match and support mod.
such as if I:

echo :mod:kvm > /sys/kernel/debug/tracing/set_ftrace_filter 

cat /sys/kernel/debug/tracing/set_ftrace_filter  | head -n 10
ack_flush [kvm]
kvm_get_kvm [kvm]
kvm_disable_largepages [kvm]
kvm_vcpu_mmap [kvm]
kvm_io_bus_sort_cmp [kvm]
mark_page_dirty_in_slot [kvm]
kvm_sched_out [kvm]
kvm_vcpu_init [kvm]
kvm_vcpu_uninit [kvm]

The log will be rather long, I just concern it will make the log
too large. You suggest make it show ?


> > +	trigger_index=$((RANDOM % n_triggers))
> > +	trigger_name=${triggers[$trigger_index]}
> > +	filter_format=$(filter_formatter $trigger_name)
> > +
> > +	echo "$filter_format" > $TRACING_PATH/set_ftrace_filter
> > +	[ $? -ne 0 ] && echo "setup filter <$filter_format> failed"
> 
> Shouldn't we report a failure here?

Yes, agree. I should call some ltp interface to report a fail, Will do it in V2, thx.

> > +	sleep 1
> > +
> > +	echo "!$filter_format" > $TRACING_PATH/set_ftrace_filter
> > +	[ $? -ne 0 ] && echo "remove filter <$filter_format> failed"
> 
> Here as well.

Will make it report ltp test failure on V2.

> > +}
> > diff --git
> > a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_cpumask.sh
> > b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_cpumask.sh
> > new file mode 100755
> > index 0000000..28bbc27
> > --- /dev/null
> > +++
> > b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_cpumask.sh
> > @@ -0,0 +1,51 @@
> > +#! /bin/sh
> > +
> > +###########################################################################
> > +##
> > ##
> > +## Copyright (c) 2015, Red Hat Inc.
> > ##
> > +##
> > ##
> > +## This program is free software: you can redistribute it and/or modify
> > ##
> > +## it under the terms of the GNU General Public License as published by
> > ##
> > +## the Free Software Foundation, either version 3 of the License, or
> > ##
> > +## (at your option) any later version.
> > ##
> > +##
> > ##
> > +## This program is distributed in the hope that it will be useful,
> > ##
> > +## but WITHOUT ANY WARRANTY; without even the implied warranty of
> > ##
> > +## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> > ##
> > +## GNU General Public License for more details.
> > ##
> > +##
> > ##
> > +## You should have received a copy of the GNU General Public License
> > ##
> > +## along with this program. If not, see <http://www.gnu.org/licenses/>.
> > ##
> > +##
> > ##
> > +## Author: Chunyu Hu <chuhu@redhat.com>
> > ##
> > +##
> > ##
> > +###########################################################################
> > +
> > +nr_cpus=`tst_ncpus`
> > +
> > +get_random_value()
> > +{
> > +	local max=$1
> > +	local min=${2:-0}
> > +	local random=${RANDOM:-$(date +%N)}
> > +	echo $(( random % max  ))
> > +}
> 
> Well looks like you have implemented portable random function after all
> although the range does not work at all.

Hmm, it's not working, agree. So the only portable way is using the
glibc interfaces. You mean I need to write this with c lib, or you mean
you will do this? Thanks !
 
> it should really be:
> 
> echo $((min + (random % (max - min + 1))))

Good algorithm. I just didn't realize this way. 
 
> Which would cover range [min, max] including both min and max.
> 
> And the function should be in a library used by all the testcases.
> 
> > +get_test_cpumask()
> > +{
> > +	local random=${RANDOM:-$(date +%N)}
> 
> Unused variable.

Ah, will remove that in V2.


> > +	local set_cnt=$(get_random_value $nr_cpus);
> > +	mask=0
> > +	for ((c=0; c<set_cnt; c++));do
> 
> Bashism.

Will fix this in V2.

> > +		local cpuid=$(get_random_value $nr_cpus)
> > +		mask=$(( mask| (1<<$cpuid) ))
> > +	done
> > +	mask=`echo $mask | awk '{printf "%x",$0}'`
> 
> Why can't we echo the mask here and do:
> 
> get_test_cpumask > $TRACING_PATH/tracing_cpumask
> 
> in the main loop?

Thanks for the suggestion, will use this way in V2.



> > +}
> > +
> > +for ((; ;))
> > +{
> 
> Bashism.

Will fix in V2. Thanks.


> > +	get_test_cpumask
> > +	echo $mask > $TRACING_PATH/tracing_cpumask
> > +	sleep 5
> 
> Why sleep 5?

When I was testing the code, I found sometimes it can hit an softlockup issue.I
doubt it was caused by this setup. But maybe not, it may be the func_stack_trace
under the option dir causing the issue, if set_ftrace_filter is not setup, then
alll kernel functions will be traced with every stack frame be scanned, I asked
this  issue to the ftrace maintainer Steve, I guess i can remove this in V2, to
handle the func_stack_trace instead. 

> > +}
> > diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
> > b/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
> > index d1be49a..49cae86 100755
> > --- a/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
> > +++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
> > @@ -31,7 +31,8 @@ test_targets=" \
> >  trace_pipe current_tracer ftrace_enabled function_profile_enabled \
> >  set_event set_ftrace_pid stack_max_size stack_trace trace trace_clock \
> >  trace_options trace_stat tracing_enabled tracing_max_latency \
> > -tracing_on function_profile_enabled buffer_size_kb"
> > +tracing_on function_profile_enabled buffer_size_kb tracing_cpumask \
> > +set_ftrace_filter"
> >  
> >  get_skip_targets()
> >  {
> > --
> > 1.8.3.1
> > 
> > 
> > --
> > Mailing list info: http://lists.linux.it/listinfo/ltp
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 

-- 
Regards,
Chunyu Hu

