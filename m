From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 22 Jun 2016 12:28:59 +0200
Subject: [LTP] [patch V2 00/20] timer: Refactor the timer wheel
In-Reply-To: <alpine.DEB.2.11.1606221037310.5839@nanos>
References: <20160617121134.417319325@linutronix.de>
 <1466581044.3188.34.camel@gmail.com>
 <alpine.DEB.2.11.1606221037310.5839@nanos>
Message-ID: <20160622102858.GA13962@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > rtbox:~ # /usr/local/ltp/conformance/interfaces/sigtimedwait/sigtimedwait_1-1.run-test
> > Test FAILED: sigtimedwait() did not return in the required time
> > time_elapsed: 1.197057
> > ...come on, you can do it...
> > rtbox:~ # /usr/local/ltp/conformance/interfaces/sigtimedwait/sigtimedwait_1-1.run-test
> > Test PASSED
> > 
> > #define ERRORMARGIN 0.1
> > ...
> >         if ((time_elapsed > SIGTIMEDWAITSEC + ERRORMARGIN)
> >             || (time_elapsed < SIGTIMEDWAITSEC - ERRORMARGIN)) {
> >                 printf("Test FAILED: sigtimedwait() did not return in "
> >                         "the required time\n");
> >                 printf("time_elapsed: %lf\n", time_elapsed);
> >                 return PTS_FAIL;
> >         }
> > 
> > Looks hohum to me, but gripe did arrive with patch set, so you get a note.
> 
> hohum is a euphemism. That's completely bogus.
> 
> The only guarantee a syscall with timers has is: timer does not fire early.

While this is true, checking with reasonable error margin works just
fine 99% of the time. You cannot really test that timer expires, without
setting arbitrary margin.

Looking into POSIX sigtimedwait() timer should run on CLOCK_MONOTONIC so
we can call clock_getres(CLOCK_MONOTOINC, ...) double or tripple the
value and use it for error margin. And also fix the test to use
the CLOCK_MONOTONIC timer.

And of course the error margin must not be used when we check that the
elapsed time wasn't shorter than we expected.

Does that sound reasonable?

-- 
Cyril Hrubis
chrubis@suse.cz
