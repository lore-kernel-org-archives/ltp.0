From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 17 Sep 2021 12:18:26 +0200
Subject: [LTP] [PATCH v2] tst_test: using SIGTERM to terminate process
In-Reply-To: <YURdMRsvyGRcF77X@pevik>
References: <20210519085812.27263-1-liwang@redhat.com> <YUJ2XA7W3JPODyNC@pevik>
 <YUJ7SC/FoA8wTaf2@pevik> <YURW7NKNSSr0J6pL@yuki>
 <YURdMRsvyGRcF77X@pevik>
Message-ID: <YURrcrX9RQYIMt4V@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hi Cyril,

> > Hi!
> > > setup()
> > > {
> > > 	tst_brk TCONF "quit now!"
> > > }

> > > do_test()
> > > {
> > > 	tst_res TPASS "pass :)"
> > > }

> > > tst_run
> > > EOF

> > > # while true; do ./debug.sh; done

> > I managed to reproduce this in dash. I bet that this is a bug where
> > signal handler inside dash is temporarily disabled when we install the
> > trap and if we manage to hit that window the signal is discarded. At
> > least that is my working theory. After I've installed debug prints, in
> > the cases where it hangs the signal was sent just before have installed
> > the trap. And in some cases when the signal arrives the timer process is
> > killed but the trap is not invoked. So it really looks like signal
> > handling in dash is simply broken. Not sure what we can do about bugs
> > like this apart from switching to a real programming language.
Which version of bash and dash are you testing on?

> Thanks for the debugging. *bash* is also affected, at least some releases.
> I reproduced it also on some older SLES, with bash 4.4.
dash 0.5.11.4 and 5.1.8 on my Tumbleweed laptop are OK.

I tested it on various my VM:

dash *failing*: 0.5.8 (SLES), 0.5.11.3 (Tumbleweed), 0.5.11+git20200708+dd9ef66-5 (Debian), 0.5.7-4+b1 (Debian)
dash *OK*: 0.5.11.2 (SLES 15), 0.5.10.2 (CentOS)

bash *failing*: 5.1.4-1.4 (Tumbleweed), 4.4-9.7.1 (SLES 15)
bash *ok*: 4.4-17 (SLES 15), 4.3-83 (SLES 12), 4.3-11+deb8u (Debian), 5.1-2+b3
(Debian), 4.2.46-34 (CentOS)

I have no idea what it causes, whether really some bash and dash versions are
buggy or it's reproducible only on certain environment.

Any tip what to search for?

Kind regards,
Petr

> Kind regards,
> Petr
