From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 10 May 2016 16:25:04 +0200
Subject: [LTP] [PATCH V2 4/9] ftrace_stress: skip unsupported tests
In-Reply-To: <1084312754.43475067.1462409602628.JavaMail.zimbra@redhat.com>
References: <1460966656-28328-1-git-send-email-chuhu@redhat.com>
 <1460966656-28328-2-git-send-email-chuhu@redhat.com>
 <1460966656-28328-3-git-send-email-chuhu@redhat.com>
 <1460966656-28328-4-git-send-email-chuhu@redhat.com>
 <1460966656-28328-5-git-send-email-chuhu@redhat.com>
 <20160504165050.GC22563@rei>
 <1084312754.43475067.1462409602628.JavaMail.zimbra@redhat.com>
Message-ID: <20160510142504.GC20387@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > +	local p=1;
> > > +	while [ $p -lt $NR_PIDS ]; do
> > > +                local kill_pid=pid${p}
> > > +                kill -KILL ${!kill_pid}
> >                                 ^
> > 				Bashism.
> 
> I am trying to change to use this way
> 
>     local pid_var=pid${p}
>                 eval local kill_pid=\$${pid_var}
>                 tst_resm TINFO "killing ${kill_pid}"
>                 eval kill -KILL $kill_pid
>                 wait ${kill_pid}
> 
> maybe i'm still using bashism?  thanks. if it's ok
> then i will use this way.
> 
> Ideally i should find a dash to try. but i have not
> found the package in rhel.

You can always compile it from source:

http://gondor.apana.org.au/~herbert/dash/files/

And there also seems to be debian devel perl script that can check for
bashism, maybe we can start using it to check shell scripts:

https://anonscm.debian.org/cgit/collab-maint/devscripts.git/tree/scripts/checkbashisms.pl

> > > +export_pids()
> > > +{
> > > +	local p=0
> > > +	while [ $p -lt $NR_PIDS ]; do
> > > +		export pid${p}
> > > +		p=$((p + 1))
> > > +	done
> > > +}
> > >  
> > > +cd ftrace_stress/
> > 
> > Why the cd? It does not seem to be needed.
> 
> as currently we are in ftrace_test/, but sub stresses
> cases are in ftrace_test/ftrace_stress/
> 
> in test_stress(), i start the sub script using
> 
>   sh ftrace_${target}.sh &
> 
> This make the path shorter. If you don't have objection,
> I will move the cd ftrace_stress/ into test_stress(). 
> What do you think of this? 

The stress tests are installed into $DESTDIR/testcases/bin/ aren't they?

If that is the case these scripts are in $PATH and could be executed
without fiddling with full path.

-- 
Cyril Hrubis
chrubis@suse.cz
