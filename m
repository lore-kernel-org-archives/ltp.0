From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 22 Jun 2016 10:44:19 +0200 (CEST)
Subject: [LTP] [patch V2 00/20] timer: Refactor the timer wheel
In-Reply-To: <1466581044.3188.34.camel@gmail.com>
References: <20160617121134.417319325@linutronix.de>
 <1466581044.3188.34.camel@gmail.com>
Message-ID: <alpine.DEB.2.11.1606221037310.5839@nanos>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

B1;2802;0cOn Wed, 22 Jun 2016, Mike Galbraith wrote:
> FWIW, testing with ltp, I noticed a new failure in logs.  It turns out
> to be intermittent, but the testcase mostly fails.

You forgot to cc the LTP folks ...
 
> rtbox:~ # /usr/local/ltp/conformance/interfaces/sigtimedwait/sigtimedwait_1-1.run-test
> Test FAILED: sigtimedwait() did not return in the required time
> time_elapsed: 1.197057
> ...come on, you can do it...
> rtbox:~ # /usr/local/ltp/conformance/interfaces/sigtimedwait/sigtimedwait_1-1.run-test
> Test PASSED
> 
> #define ERRORMARGIN 0.1
> ...
>         if ((time_elapsed > SIGTIMEDWAITSEC + ERRORMARGIN)
>             || (time_elapsed < SIGTIMEDWAITSEC - ERRORMARGIN)) {
>                 printf("Test FAILED: sigtimedwait() did not return in "
>                         "the required time\n");
>                 printf("time_elapsed: %lf\n", time_elapsed);
>                 return PTS_FAIL;
>         }
> 
> Looks hohum to me, but gripe did arrive with patch set, so you get a note.

hohum is a euphemism. That's completely bogus.

The only guarantee a syscall with timers has is: timer does not fire early.

Thanks,

	tglx
