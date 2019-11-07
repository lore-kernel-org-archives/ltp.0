From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 7 Nov 2019 13:40:47 +0100 (CET)
Subject: [LTP] [PATCH] kernel: use ktime_get_real_ts64() to calculate
 acct.ac_btime
In-Reply-To: <20191107123224.GA6315@hirez.programming.kicks-ass.net>
References: <a87876829697e1b3c63601b1401a07af79eddae6.1572651216.git.jstancek@redhat.com>
 <20191107123224.GA6315@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1911071335320.4256@nanos.tec.linutronix.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, 7 Nov 2019, Peter Zijlstra wrote:
> Lets start by saying this accounting stuff is terrible crap and it
> deserves to fail and burn.

No argument about that.

> And what does btime want? As implemented it jumps around if you ask the
> question twice with an adjtime() call or suspend in between. Of course,
> if we take an actual CLOCK_REALTIME timestamp at fork() the value
> doesn't change, but then it can be in the future (DST,adjtime()), which
> is exactly the reason why CLOCK_REALTIME is absolute shit for timestamps
> (logging, accounting, etc.).
> 
> And your 'fix' is pretty terible too. Arguably ktime_get_seconds() wants
> fixing for not having the ns accumulation and actually differing from
> tv_sec, but now you accrue one source of ns while still disregarding
> another (also, I friggin hate timespec, it's a terrible interface for
> time).
> 
> All in all, I'm tempted to just declare this stuff broken and -EWONTFIX,
> but if we have to do something, something like the below is at least
> internally consistent.

Kinda :)

> +	mono = ktime_get_ns();
> +	real = ktime_get_real_ns();
> +	/*
> +	 * Compute btime by subtracting the elapsed time from the current
> +	 * CLOCK_REALTIME.
> +	 *
> +	 * XXX totally buggered, because it changes results across
> +	 * adjtime() calls and suspend/resume.
> +	 */
> +	delta = mono - tsk->start_time; // elapsed in ns
> +	btime = real - delta;		// real ns - elapsed ns
> +	do_div(btime, NSEC_PER_SEC);	// truncated to seconds
> +	stats->ac_btime = btime;

That has pretty much the same problem as just storing the CLOCK_REALTIME
start time at fork and additionally it is wreckaged vs. suspend resume.

So a CLOCK_REALTIME time stamp at fork would at least be correct
vs. suspend resume.

The same result is achieved by:

       boot = ktime_get_boot_ns();
       delta = boot = tsk->real_start_time;

Typing real_start_time makes me really cringe.

Thanks,

	tglx
