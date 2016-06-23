From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 23 Jun 2016 16:10:52 +0200 (CEST)
Subject: [LTP] [patch V2 00/20] timer: Refactor the timer wheel
In-Reply-To: <20160623135803.636.qmail@ns.sciencehorizons.net>
References: <20160623135803.636.qmail@ns.sciencehorizons.net>
Message-ID: <alpine.DEB.2.11.1606231609340.5839@nanos>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, 23 Jun 2016, George Spelvin wrote:
> Cyril Hrubis wrote:
> > Thomas Gleixner wrote:
> >> Err. You know that the timer expired because sigtimedwait() returns
> >> EAGAIN. And the only thing you can reliably check for is that the timer did
> >> not expired to early. Anything else is guesswork and voodoo programming.
> 
> > But seriously is there a reason
> > why OS that is not under heavy load cannot expire timers with reasonable
> > overruns? I.e. if I ask for a second of sleep and expect it to be woken
> > up not much more than half of a second later?
> 
> > If we stick only to guarantees that are defined in POSIX playing music
> > with mplayer would not be possible since it sleeps in futex() and if it
> > wakes too late it will fail to fill buffers. In practice this worked
> > fine for me for years.
> 
> Two points:
> 1) sigtimedwait() is unusual in that it uses the jiffies timer.  Most
>    system call timeouts (including specifically the one in FUTEX_WAIT)
>    use the high-resolution timer subsystem, which is a whole different
>    animal with tighter guarantees, and

As Peter said we want to convert sigtimedwait() to use hrtimers as well. We
converted almost all syscalls with timeouts (futex, poll, select ....) to
hrtimers years ago, but somehow we missed to do the same to sigtimedwait.

Thanks,

	tglx
