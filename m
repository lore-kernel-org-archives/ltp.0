From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 17 Sep 2021 13:03:00 +0200
Subject: [LTP] [PATCH v2] tst_test: using SIGTERM to terminate process
In-Reply-To: <YUR1K7XE3QmTFxT7@yuki>
References: <20210519085812.27263-1-liwang@redhat.com> <YUJ2XA7W3JPODyNC@pevik>
 <YUJ7SC/FoA8wTaf2@pevik> <YURW7NKNSSr0J6pL@yuki>
 <YURdMRsvyGRcF77X@pevik> <YURrcrX9RQYIMt4V@pevik>
 <YUR1K7XE3QmTFxT7@yuki>
Message-ID: <YUR15AMqM4qEYXpV@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hi!
> > > > I managed to reproduce this in dash. I bet that this is a bug where
> > > > signal handler inside dash is temporarily disabled when we install the
> > > > trap and if we manage to hit that window the signal is discarded. At
> > > > least that is my working theory. After I've installed debug prints, in
> > > > the cases where it hangs the signal was sent just before have installed
> > > > the trap. And in some cases when the signal arrives the timer process is
> > > > killed but the trap is not invoked. So it really looks like signal
> > > > handling in dash is simply broken. Not sure what we can do about bugs
> > > > like this apart from switching to a real programming language.
> > Which version of bash and dash are you testing on?

> > > Thanks for the debugging. *bash* is also affected, at least some releases.
> > > I reproduced it also on some older SLES, with bash 4.4.
> > dash 0.5.11.4 and 5.1.8 on my Tumbleweed laptop are OK.

> > I tested it on various my VM:

> > dash *failing*: 0.5.8 (SLES), 0.5.11.3 (Tumbleweed), 0.5.11+git20200708+dd9ef66-5 (Debian), 0.5.7-4+b1 (Debian)
> > dash *OK*: 0.5.11.2 (SLES 15), 0.5.10.2 (CentOS)

> > bash *failing*: 5.1.4-1.4 (Tumbleweed), 4.4-9.7.1 (SLES 15)
> > bash *ok*: 4.4-17 (SLES 15), 4.3-83 (SLES 12), 4.3-11+deb8u (Debian), 5.1-2+b3
> > (Debian), 4.2.46-34 (CentOS)

> > I have no idea what it causes, whether really some bash and dash versions are
> > buggy or it's reproducible only on certain environment.

> bash 5.1.8 seems to work okay, dash 0.5.11.3-r2 seems to fail here.

> > Any tip what to search for?

> Not really, apart from reading source code and figuring out exactly what
> happens here.

> I guess that we can make things more predictable and easier to read by
> shifting parts of the shell library to a C process.

> For instance if we wrote an utility that would implement all the
> tst_kill_test and timeout process in C we would simplify things greatly.

> Something as:

> tst_timeout_kill

> that would be used as:


> tst_timeout_kill 300 12342
>                   ^    ^
> 		  |    process group leader pid
> 		  timeout in seconds


> That would implement both the loop for killing tests and timeout
> processing as well. That way we would get rid of the trap in the
> subshell and we would end up with a single pid for the whole timeout
> process and avoid the recursive sigkill to begin with.

+1 for this idea instead of never ending story to fix various shells.
Please if you have time, wrote that.

Kind regards,
Petr
