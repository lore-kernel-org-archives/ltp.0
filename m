From: Chunyu Hu <chuhu@redhat.com>
Date: Fri, 18 Mar 2016 09:08:34 -0400 (EDT)
Subject: [LTP] [PATCH RFC 6/9] ftrace_stress: skip unsupported tests
In-Reply-To: <20160317170701.GG31815@rei.lan>
References: <1457079898-9449-1-git-send-email-liwang@redhat.com>
 <1457079898-9449-2-git-send-email-liwang@redhat.com>
 <1457079898-9449-3-git-send-email-liwang@redhat.com>
 <1457079898-9449-4-git-send-email-liwang@redhat.com>
 <1457079898-9449-5-git-send-email-liwang@redhat.com>
 <1457079898-9449-6-git-send-email-liwang@redhat.com>
 <1457079898-9449-7-git-send-email-liwang@redhat.com>
 <20160317170701.GG31815@rei.lan>
Message-ID: <2674277.29655623.1458306514829.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

I will fix the issues you mentioned about the stress test in V2. As when i talked 
about the  ftrace test i knew Li Wang is doing something reorg the ftrace  test.
So i just append the stress related 4 fix to his. as we guess this will make it be
simpler to be reviewed by you, and make it easier to be considered for organizing 
the case.

I also your replied the issues below. Thanks!

----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Li Wang" <liwang@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Friday, March 18, 2016 1:07:01 AM
> Subject: Re: [LTP] [PATCH RFC 6/9] ftrace_stress: skip unsupported tests
> 
> Hi!
> >  	if [ -e stack_max_size ]; then
> >  		old_stack_tracer_enabled=`cat /proc/sys/kernel/stack_tracer_enabled`
> >  	fi
> > @@ -86,7 +89,10 @@ restore_old_setting()
> >  
> >  	echo $old_buffer_size > buffer_size_kb
> >  	echo $old_tracing_on > tracing_on
> > -	echo $old_tracing_enabled > tracing_enabled
> > +
> > +	if [ -e tracing_enabled ];then
>                                   ^
> 				  missing space here

Will modify it in V2. Thanks.


> > a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_event.sh
> > b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_event.sh
> > index d7efdd4..d1a6bd3 100755
> > ---
> > a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_event.sh
> > +++
> > b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_event.sh
> > @@ -36,6 +36,8 @@ for ((; ;))
> >  
> >  	for event in `cat $TRACING_PATH/available_events`;
> >  	do
> > +		# ftrace event sys is special, skip it
> > +		[[ $event =~ ftrace:* ]] && continue
> This is bashism.


I just had a experience with bash. thanks for catching this issue. Will update it 
with something like:
 
if echo $event | grep "ftrace:*"; then
        continue;
fi


> > diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
> > b/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
> > index beced43..d1be49a 100755
> > --- a/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
> > +++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
> > @@ -21,82 +21,77 @@

> > -	kill -USR1 $pid12 || test_success=false
> > -	kill -KILL $pid13 || test_success=false
> > -	kill -KILL $pid14 || test_success=false
> > -	kill -KILL $pid15 || test_success=false
> > -	kill -KILL $pid16 || test_success=false
> > +	kill -USR1 ${pid0} || test_success=false
> > +
> > +	for ((p=1; p<NR_PIDS; p++))
> > +	{
> > +		local kill_pid=pid${p}
> > +		kill -KILL ${!kill_pid} || test_success=false
> > +	}
> 
> Again this is bashism loop over $(seq NR_PIDS).

Thanks for catching this.

Refer the style of  test.sh. I will modify this to use a while loop

        p=1;
        while [ p -lt $NR_PIDS ]; do 
                local kill_pid=pid${p}
                kill -KILL ${!kill_pid} || test_success=false 
                tst_record_childstatus ${!p}    
                p=$((p + 1))

        done

> 
> >  	sleep 2
> 
> We should wait on the pids here instead of the sleep, which would
> guarantee tha the processes have really finished.

Hi, 
Thx. I will try to update it using tst_record_childstatus as the above 
while loop did.



> >  	clean_up
> >  }
> >  
> > +test_stress()
> > +{
> > +	NR_PIDS=0
> > +	echo "Test targets: ${test_targets}"
> > +	get_skip_targets
> > +	for target in ${test_targets}; do
> > +		if should_skip_target $target; then
> > +			continue
> > +		fi
> > +		$SPATH/ftrace_${target}.sh &
> 
> The path to test binaries must be in $PATH before testcases are executed
> so you should just do ftrace_${target}.sh & instead.

Thanks. I will modify it in V2.
in ftrace_lib.sh, it executes : cd $LTPROOT/testcases/bin, So i need to cd
ftrace_stress dir first. then do as you mentioned, make the path shorter is
better.


> > +		eval pid${NR_PIDS}=$!
> > +		echo "Start pid${NR_PIDS}=$! $SPATH/ftrace_${target}.sh"
> > +		((NR_PIDS++))
> 
> Bashism. Portable way is a=$((a+1))

Thanks for reviewing this. Will update this in V2.


> > +	done
> > +	export_pids
> > +}
> > +
> > +export_pids()
> > +{
> > +	for ((i=0; i<NR_PIDS; i++))
> > +	{
> > +		export pid${i}
> > +	}
> 
> Bashism again.


Thx. Will modify it to use while [] in V2.


> > +	export NR_PIDS
> > +}
> >  
> >  # ----------------------------
> >  echo "Ftrace Stress Test Begin"
> > @@ -111,11 +106,11 @@ test_wait
> >  
> >  test_kill
> >  
> > -echo "Ftrace Stress Test End"
> > -
> >  if $test_success; then
> >  	tst_resm TPASS "finished running the test. Run dmesg to double-check for
> >  	bugs"
> >  else
> >  	tst_resm TFAIL "please check log message."
> >  	exit 1
> >  fi
> 
> Again the test should be really converted to test.sh library. That way
> we would exit with correct exit status at tst_exit instead of calling
> exit manually depending on some flag.

Thanks. have read the test.sh lib. that's really great. Will modify this in
V2.

> > +echo "Ftrace Stress Test End"
> 
> And ideally bashism should be fixed in the substests called from this
> tests. So that the test can run with dash or bussy box as well.

Thanks. I will try in V2, in fact, I was referring the old subcases,
not realizing the portable issue.

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

