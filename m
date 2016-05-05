From: Chunyu Hu <chuhu@redhat.com>
Date: Thu, 5 May 2016 03:44:56 -0400 (EDT)
Subject: [LTP] [PATCH V2 9/9] ftrace_stress: cleanup and use ltp API
In-Reply-To: <1857309330.43401385.1462376568052.JavaMail.zimbra@redhat.com>
References: <1460966656-28328-1-git-send-email-chuhu@redhat.com>
 <1460966656-28328-6-git-send-email-chuhu@redhat.com>
 <1460966656-28328-7-git-send-email-chuhu@redhat.com>
 <1460966656-28328-8-git-send-email-chuhu@redhat.com>
 <1460966656-28328-9-git-send-email-chuhu@redhat.com>
 <1460966656-28328-10-git-send-email-chuhu@redhat.com>
 <20160504145630.GE12244@rei.lan>
 <1857309330.43401385.1462376568052.JavaMail.zimbra@redhat.com>
Message-ID: <1504573593.43522272.1462434296013.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Chunyu Hu" <chuhu@redhat.com>
> To: "Cyril Hrubis" <chrubis@suse.cz>
> Cc: liwan@redhat.com, ltp@lists.linux.it
> Sent: Wednesday, May 4, 2016 11:42:48 PM
> Subject: Re: [LTP] [PATCH V2 9/9] ftrace_stress: cleanup and use ltp API
> 
> 
> Hi Cyril,

> > > diff --git
> > > a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_pipe.sh
> > > b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_pipe.sh
> > > index 47d42bc..a24008a 100755
> > > ---
> > > a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_pipe.sh
> > > +++
> > > b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_pipe.sh
> > > @@ -13,10 +13,11 @@
> > >  #
> > >  #
> > >  ###############################################################################
> > >  
> > > +. test.sh
> > 
> > You don't have to add test.sh for tst_sleep.
> 
> OK. will remove this.
> 
> > >  ftrace_sleep()
> > >  {
> > > -	# usleep is not a standard command?
> > > -	usleep 200000 2> /dev/null
> > > +	tst_sleep 200000us
> > >  	if [ $? -ne 0 ]; then
> > >  		sleep 1
> > >  	fi
> > 
> > You should remove the fallback to sleep 1 if the usleep wasn't found.
> > Ideally the whole function ftrace_sleep should be removed and you should
> > just call tst_sleep from the main loop.
> 
> I think using tst_sleep directly is good way. thanks.
> 
> > > @@ -33,10 +34,9 @@ trap kill_this_pid SIGUSR1
> > >  
> > >  LOOP=20
> > >  
> > > -for ((; ;))
> > > -{
> > > -	for ((i = 0; i < $LOOP; i++))
> > > -	{
> > > +while true; do
> > > +	i=0;
> > > +	while [ $i -lt $LOOP ]; do
> > >  		cat "$TRACING_PATH"/trace_pipe > /dev/null &
> > >  
> > >  		this_pid=$!
> > > @@ -45,8 +45,7 @@ for ((; ;))
> > >  		wait $this_pid
> > >  		this_pid=0
> > >  		ftrace_sleep
> > > -	}
> > > -
> > > +		i=$((i + 1))
> > > +	done
> > >  	sleep 2
> > > -}
> > > -
> > > +done
> > 
> > And you should also fix the kill called by the full path in this script.
> > It should really be just kill not /bin/kill.
> 

Hi Cyril,

After i changing it to kill directly and retest it, i hit err message:

ftrace_trace_pipe.sh: line 18: kill: SIGKILL: invalid signal specification

then i found that kill is also one of the bash built-in cmd. So we'd better
still use /bin/kill in this case.
 
# type kill
kill is a shell builtin

bash-4.2.46-19.el7.x86_64




