From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 7 Nov 2019 15:37:05 +0100 (CET)
Subject: [LTP] [PATCH] kernel: use ktime_get_real_ts64() to calculate
 acct.ac_btime
In-Reply-To: <20191107125559.GI4131@hirez.programming.kicks-ass.net>
References: <a87876829697e1b3c63601b1401a07af79eddae6.1572651216.git.jstancek@redhat.com>
 <20191107123224.GA6315@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1911071335320.4256@nanos.tec.linutronix.de>
 <20191107125559.GI4131@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1911071536190.4256@nanos.tec.linutronix.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, 7 Nov 2019, Peter Zijlstra wrote:
> On Thu, Nov 07, 2019 at 01:40:47PM +0100, Thomas Gleixner wrote:
> > On Thu, 7 Nov 2019, Peter Zijlstra wrote:
> 
> > > +	mono = ktime_get_ns();
> > > +	real = ktime_get_real_ns();
> > > +	/*
> > > +	 * Compute btime by subtracting the elapsed time from the current
> > > +	 * CLOCK_REALTIME.
> > > +	 *
> > > +	 * XXX totally buggered, because it changes results across
> > > +	 * adjtime() calls and suspend/resume.
> > > +	 */
> > > +	delta = mono - tsk->start_time; // elapsed in ns
> > > +	btime = real - delta;		// real ns - elapsed ns
> > > +	do_div(btime, NSEC_PER_SEC);	// truncated to seconds
> > > +	stats->ac_btime = btime;
> > 
> > That has pretty much the same problem as just storing the CLOCK_REALTIME
> > start time at fork and additionally it is wreckaged vs. suspend resume.
> 
> It's wrecked in general. It also jumps around for any REALTIME
> adjustment.
> 
> > So a CLOCK_REALTIME time stamp at fork would at least be correct
> > vs. suspend resume.
> 
> But still wrecked vs REALTIME jumps, as in, when DST flips the clock
> back an hour, your timestamp is in the future.
> 
> Any which way around the whole thing is buggered.  The only real fix is
> not using REALTIME anything. Which is why I'm loath to add that REALTIME
> timestamp at fork(), it just encourages more use.

Fair enough. You have a sane alternative though: CLOCK_TAI

Thanks,

	tglx


