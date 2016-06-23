From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 23 Jun 2016 17:21:14 +0200 (CEST)
Subject: [LTP] [patch V2 00/20] timer: Refactor the timer wheel
In-Reply-To: <20160623151127.GA20808@rei.lan>
References: <20160623114759.GA19250@rei.lan>
 <20160623135803.636.qmail@ns.sciencehorizons.net>
 <20160623151127.GA20808@rei.lan>
Message-ID: <alpine.DEB.2.11.1606231720080.5839@nanos>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, 23 Jun 2016, Cyril Hrubis wrote:
> > 1) sigtimedwait() is unusual in that it uses the jiffies timer.  Most
> >    system call timeouts (including specifically the one in FUTEX_WAIT)
> >    use the high-resolution timer subsystem, which is a whole different
> >    animal with tighter guarantees, and
> 
> That is likely POSIX conformance bug, since POSIX explicitly states that
> sigtimedwait() shall use CLOCK_MONOTONIC to measure the timeout.
> 
> "If the Monotonic Clock option is supported, the CLOCK_MONOTONIC clock
> shall be used to measure the time interval specified by the timeout
> argument."

That's fine because jiffies is a less granular form of CLOCK_MONOTONIC.
 
Thanks,

	tglx
