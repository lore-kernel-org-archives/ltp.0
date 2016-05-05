From: Chunyu Hu <chuhu@redhat.com>
Date: Wed, 4 May 2016 20:53:22 -0400 (EDT)
Subject: [LTP] [PATCH V2 4/9] ftrace_stress: skip unsupported tests
In-Reply-To: <20160504165050.GC22563@rei>
References: <1460966656-28328-1-git-send-email-chuhu@redhat.com>
 <1460966656-28328-2-git-send-email-chuhu@redhat.com>
 <1460966656-28328-3-git-send-email-chuhu@redhat.com>
 <1460966656-28328-4-git-send-email-chuhu@redhat.com>
 <1460966656-28328-5-git-send-email-chuhu@redhat.com>
 <20160504165050.GC22563@rei>
Message-ID: <1084312754.43475067.1462409602628.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Chunyu Hu" <chuhu@redhat.com>
> Cc: ltp@lists.linux.it, liwan@redhat.com
> Sent: Thursday, May 5, 2016 12:50:50 AM
> Subject: Re: [LTP] [PATCH V2 4/9] ftrace_stress: skip unsupported tests
> 
> Hi!
> > diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
> > b/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
> > index d9f7f8b..80c914c 100755
> > --- a/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
> > +++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
> > @@ -21,87 +21,92 @@
> >  ##
> >  ##
> >  ###########################################################################
> >  
> > -
> >  export TCID="ftrace-stress-test"
> >  export TST_TOTAL=1
> >  export TST_COUNT=1
> >  
> >  . ftrace_lib.sh
> >  
> > -test_success=true
> > +test_targets=" \
> > +trace_pipe current_tracer ftrace_enabled function_profile_enabled \
> > +set_event set_ftrace_pid stack_max_size stack_trace trace trace_clock \
> > +trace_options trace_stat tracing_enabled tracing_max_latency \
> > +tracing_on function_profile_enabled buffer_size_kb"
> >  
> > -export_pids()
> > +get_skip_targets()
> >  {
> > -	export pid1 pid2 pid3 pid4 pid5 pid6 pid7 pid8 pid9 pid10 pid11 pid12 \
> > -		pid13 pid14 pid15 pid16
> > -
> > -	export NR_PIDS=16
> > +	NR_PIDS=0
> > +	for target in ${test_targets}; do
> > +		if [ ! -e $TRACING_PATH/$target ] &&
> > +			[ ! -e /proc/sys/kernel/$target ]; then
> > +			eval skip_$target=1
> > +			tst_resm TINFO "$target is not supported. Skip it."
> > +		else
> > +			eval skip_$target=0
> > +			NR_PIDS=$((NR_PIDS + 1))
> > +		fi
> > +	done
> > +	# Export it before sub case is lanuched.
> > +	export NR_PIDS
> >  }
> >  
> > -test_stress()
> > +should_skip_target()
> >  {
> > -	export_pids
> > -
> > -	$SPATH/ftrace_trace_clock.sh &
> > -	pid1=$!
> > -	$SPATH/ftrace_current_tracer.sh &
> > -	pid2=$!
> > -	$SPATH/ftrace_trace_options.sh &
> > -	pid3=$!
> > -	$SPATH/ftrace_tracing_max_latency.sh &
> > -	pid4=$!
> > -	$SPATH/ftrace_stack_trace.sh &
> > -	pid5=$!
> > -	$SPATH/ftrace_stack_max_size.sh &
> > -	pid6=$!
> > -	$SPATH/ftrace_tracing_on.sh &
> > -	pid7=$!
> > -	$SPATH/ftrace_tracing_enabled.sh &
> > -	pid8=$!
> > -	$SPATH/ftrace_set_event.sh &
> > -	pid9=$!
> > -	$SPATH/ftrace_buffer_size.sh &
> > -	pid10=$!
> > -	$SPATH/ftrace_trace.sh &
> > -	pid11=$!
> > -	$SPATH/ftrace_trace_pipe.sh &
> > -	pid12=$!
> > -	$SPATH/ftrace_ftrace_enabled.sh &
> > -	pid13=$!
> > -	$SPATH/ftrace_set_ftrace_pid.sh &
> > -	pid14=$!
> > -	$SPATH/ftrace_profile_enabled.sh &
> > -	pid15=$!
> > -	$SPATH/ftrace_trace_stat.sh &
> > -	pid16=$!
> > +	local var=skip_$1
> > +	local val=${!var}

I found here i was using bashism too as your pointed below.

> > +	[ "$val" = 1 ]
> >  }
> >  
> >  test_kill()
> >  {
> > -	kill -KILL $pid1 || test_success=false
> > -	kill -KILL $pid2 || test_success=false
> > -	kill -KILL $pid3 || test_success=false
> > -	kill -KILL $pid4 || test_success=false
> > -	kill -KILL $pid5 || test_success=false
> > -	kill -KILL $pid6 || test_success=false
> > -	kill -KILL $pid7 || test_success=false
> > -	kill -KILL $pid8 || test_success=false
> > -	kill -KILL $pid9 || test_success=false
> > -	kill -KILL $pid10 || test_success=false
> > -	kill -KILL $pid11 || test_success=false
> > -	kill -USR1 $pid12 || test_success=false
> > -	kill -KILL $pid13 || test_success=false
> > -	kill -KILL $pid14 || test_success=false
> > -	kill -KILL $pid15 || test_success=false
> > -	kill -KILL $pid16 || test_success=false
> > +	tst_resm TINFO "killing ${pid0}"
> > +	kill -USR1 ${pid0}
> > +	wait ${pid0}
> > +
> > +	local p=1;
> > +	while [ $p -lt $NR_PIDS ]; do
> > +                local kill_pid=pid${p}
> > +                kill -KILL ${!kill_pid}
>                                 ^
> 				Bashism.

I am trying to change to use this way

    local pid_var=pid${p}
                eval local kill_pid=\$${pid_var}
                tst_resm TINFO "killing ${kill_pid}"
                eval kill -KILL $kill_pid
                wait ${kill_pid}

maybe i'm still using bashism?  thanks. if it's ok
then i will use this way.

Ideally i should find a dash to try. but i have not
found the package in rhel.

> 
> > +		tst_resm TINFO "killing ${!kill_pid}"
> > +                wait ${!kill_pid}
> > +                p=$((p + 1))
> > +        done
> 
> This part seems to have misformatted whitespaces, please fix that.

OK. Noticed, fixed in my local repo now.

> >  	sleep 2
> 
> 
> The wait is done here, OK. But you should have dropped the sleep 2.

OK. removed in my local now. Won't see it in next step.

> >  	clean_up

Here i will call restore_ path. but i think we'd better move it out of
test_kill to main path, it's not appropriate in that func.

> >  }
> >  
> > +test_stress()
> > +{
> > +	local index=0;
> > +
> > +	tst_resm TINFO "Test targets: ${test_targets}"
> > +
> > +	get_skip_targets
> > +	for target in ${test_targets}; do
> > +		if should_skip_target $target; then
> > +			continue
> > +		fi
> > +		sh ftrace_${target}.sh &
> > +		eval pid${index}=$!
> > +		tst_resm TINFO "Start pid${index}=$! $SPATH/ftrace_${target}.sh"
> > +		index=$((index + 1))
> > +	done
> > +	export_pids
> > +}
> > +
> > +export_pids()
> > +{
> > +	local p=0
> > +	while [ $p -lt $NR_PIDS ]; do
> > +		export pid${p}
> > +		p=$((p + 1))
> > +	done
> > +}
> >  
> > +cd ftrace_stress/
> 
> Why the cd? It does not seem to be needed.

as currently we are in ftrace_test/, but sub stresses
cases are in ftrace_test/ftrace_stress/

in test_stress(), i start the sub script using

  sh ftrace_${target}.sh &

This make the path shorter. If you don't have objection,
I will move the cd ftrace_stress/ into test_stress(). 
What do you think of this? 


> 
> >  # ----------------------------
> > -echo "Ftrace Stress Test Begin"
> > +tst_resm TINFO "Ftrace Stress Test Begin"
> >  
> >  save_old_setting
> >  
> > @@ -113,11 +118,6 @@ test_wait
> >  
> >  test_kill
> >  
> > -echo "Ftrace Stress Test End"
> > +tst_resm TINFO "Finished running the test. Run dmesg to double-check for
> > bugs"
> 
> Well most of the things I've pointed out seems to be fixed but I still
> fail to see the restore_old_setting here. Or do I miss someting?

in ftrace_lib.sh , you can see a clean_up which calls the restore path.
Looks like leave it in clean_up can make things simpler. you mentioned ltp can
setup cleanup callback, if one clean_up can do all. then that's good to
put it there with other clean steps together. your opinion?

> > -if $test_success; then
> > -	tst_resm TPASS "finished running the test. Run dmesg to double-check for
> > bugs"
> > -else
> > -	tst_resm TFAIL "please check log message."
> > -	exit 1
> > -fi
> > +tst_exit
> 
> 
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 

-- 
Regards,
Chunyu Hu

