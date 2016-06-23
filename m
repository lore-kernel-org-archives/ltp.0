From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 23 Jun 2016 17:11:27 +0200
Subject: [LTP] [patch V2 00/20] timer: Refactor the timer wheel
In-Reply-To: <20160623135803.636.qmail@ns.sciencehorizons.net>
References: <20160623114759.GA19250@rei.lan>
 <20160623135803.636.qmail@ns.sciencehorizons.net>
Message-ID: <20160623151127.GA20808@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Two points:
> 1) sigtimedwait() is unusual in that it uses the jiffies timer.  Most
>    system call timeouts (including specifically the one in FUTEX_WAIT)
>    use the high-resolution timer subsystem, which is a whole different
>    animal with tighter guarantees, and

That is likely POSIX conformance bug, since POSIX explicitly states that
sigtimedwait() shall use CLOCK_MONOTONIC to measure the timeout.

"If the Monotonic Clock option is supported, the CLOCK_MONOTONIC clock
shall be used to measure the time interval specified by the timeout
argument."

> 2) The worst-case error in tglx's proposal is 1/8 of the requested
>    timeout: the wakeup is after 112.5% of the requested time, plus
>    one tick.  This is well within your requested accuracy.  (For very
>    short timeouts, the "plus one tick" can dominate the percentage error.)

Hmm, that still does not add up to the number in the original email
where it says time_elapsed: 1.197057. As far as I can tell the worst
case for a tick is CONFIG_HZ=100 so one tick is 0.01s and even after
that we get 118.7% since we requested 1s. But that may be caused by the
fact that the test uses gettimeofday() to measure the elapsed time, it
should use CLOCK_MONOTONIC instead.

-- 
Cyril Hrubis
chrubis@suse.cz
