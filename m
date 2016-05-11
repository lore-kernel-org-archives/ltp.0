From: Chunyu Hu <chuhu@redhat.com>
Date: Wed, 11 May 2016 07:14:00 -0400 (EDT)
Subject: [LTP] [PATCH V2 4/9] ftrace_stress: skip unsupported tests
In-Reply-To: <20160510142504.GC20387@rei>
References: <1460966656-28328-1-git-send-email-chuhu@redhat.com>
 <1460966656-28328-2-git-send-email-chuhu@redhat.com>
 <1460966656-28328-3-git-send-email-chuhu@redhat.com>
 <1460966656-28328-4-git-send-email-chuhu@redhat.com>
 <1460966656-28328-5-git-send-email-chuhu@redhat.com>
 <20160504165050.GC22563@rei>
 <1084312754.43475067.1462409602628.JavaMail.zimbra@redhat.com>
 <20160510142504.GC20387@rei>
Message-ID: <1323565361.45358853.1462965240991.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Chunyu Hu" <chuhu@redhat.com>
> Cc: ltp@lists.linux.it, liwan@redhat.com
> Sent: Tuesday, May 10, 2016 10:25:04 PM
> Subject: Re: [LTP] [PATCH V2 4/9] ftrace_stress: skip unsupported tests
> 
> Hi!
> > > > +	local p=1;
> > > > +	while [ $p -lt $NR_PIDS ]; do
> > > > +                local kill_pid=pid${p}
> > > > +                kill -KILL ${!kill_pid}
> > >                                 ^
> > > 				Bashism.
> > 
> > I am trying to change to use this way
> > 
> >     local pid_var=pid${p}
> >                 eval local kill_pid=\$${pid_var}
> >                 tst_resm TINFO "killing ${kill_pid}"
> >                 eval kill -KILL $kill_pid
> >                 wait ${kill_pid}
> > 
> > maybe i'm still using bashism?  thanks. if it's ok
> > then i will use this way.
> > 
> > Ideally i should find a dash to try. but i have not
> > found the package in rhel.
> 
> You can always compile it from source:
> 
> http://gondor.apana.org.au/~herbert/dash/files/

Thanks. I compiled and tried, although test didn't hit issue,
but this is all because it's using sh xxxxx.sh to execute sub tests,
if i executed the cmd on bash directly, it would tell me the error.


> 
> And there also seems to be debian devel perl script that can check for
> bashism, maybe we can start using it to check shell scripts:
> 
> https://anonscm.debian.org/cgit/collab-maint/devscripts.git/tree/scripts/checkbashisms.pl

Thanks for the useful info, I tried the tool, it did find the bashism issue of ${!var}. 
and it also found another issue in ftrace_tracing_cpu_mask.sh of $(( a | (1 << $b) )),
i have changed to use $((a | $(( 1 << $b)) )) instead. 


> > > > +export_pids()
> > > > +{
> > > > +	local p=0
> > > > +	while [ $p -lt $NR_PIDS ]; do
> > > > +		export pid${p}
> > > > +		p=$((p + 1))
> > > > +	done
> > > > +}
> > > >  
> > > > +cd ftrace_stress/
> > > 
> > > Why the cd? It does not seem to be needed.
> > 
> > as currently we are in ftrace_test/, but sub stresses
> > cases are in ftrace_test/ftrace_stress/
> > 
> > in test_stress(), i start the sub script using
> > 
> >   sh ftrace_${target}.sh &
> > 
> > This make the path shorter. If you don't have objection,
> > I will move the cd ftrace_stress/ into test_stress().
> > What do you think of this?
> 
> The stress tests are installed into $DESTDIR/testcases/bin/ aren't they?
> 
> If that is the case these scripts are in $PATH and could be executed
> without fiddling with full path.

[root@dhcp-chuhu bin]# ls ftrace_*  -d
ftrace_lib.sh  ftrace_regression01.sh  ftrace_regression02.sh  ftrace_stress  ftrace_stress_test.sh
[root@dhcp-chuhu bin]# pwd
/opt/ltp/testcases/bin

tests are under subdir ftrace_stress of bin. so we need a cd. 
but also  can just remove it and use ftrace_stress/${target}.sh
instead, ok, i will use this way.  Please ignore the previous V3,
that's not complete considering this.

> --
> Cyril Hrubis
> chrubis@suse.cz
> 

-- 
Regards,
Chunyu Hu

