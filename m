From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 14 Mar 2016 14:43:21 +0100
Subject: [LTP] question about signal handling in tst_sig()
In-Reply-To: <20160314132827.GC600@rei.lan>
References: <20160314081907.GA3579@localhost.localdomain>
 <20160314132827.GC600@rei.lan>
Message-ID: <20160314134321.GD600@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Looks like in tst_sig(), if _SC_SIGRT_MIN defined, all realtime signals
> > won't be set an handler:
> > 
> > 125 #ifdef _SC_SIGRT_MIN
> > 126                 if (sig >= sigrtmin && sig <= sigrtmax)
> > 127                         continue;
> > 128 #endif
> > 
> > but, if it wasn't defined, then all realtime signals will be set an
> > handler:
> > 
> > 134 #if !defined(_SC_SIGRT_MIN) && defined(__SIGRTMIN) &&
> > defined(__SIGRTMAX)
> > 135                         /* Ignore all real-time signals */
> > 136                 case __SIGRTMIN:
> > 137                 case __SIGRTMIN + 1:
> > ...

And also there is a break down after the long list of cases.


So it looks like:

* if _SC_SIGRT_MIN is defined we have a POSIX compilant system
  and we skip realtime signals in the if at line 125.

* Otherwise if system is not POSIX compilant but __SIGRTMIN and
  __SIGRTMAX is defined, we skip them in the hack in the switch()

  this is possibly workaround for old glibc without _SC_SIGRT_MIN
  support

> > is that correct, or I missed something here? 
> 
> The loop goes over signal numbers from 1 to NSIG (which is defined in
> system headers). Supposedly when _SC_SIGRT_MIN is not defined the system
> does not support realtime signals and the NSIG has value of the highest
> allocated (non-realtime) signal number.
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
> 
> -- 
> Mailing list info: http://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
