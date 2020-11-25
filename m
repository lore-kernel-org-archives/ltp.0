From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Nov 2020 13:35:34 +0100
Subject: [LTP] [PATCH 1/2] syscalls: avoid time() using
 __cvdso_gettimeofday in use-level's VDSO
In-Reply-To: <875z5tllih.fsf@nanos.tec.linutronix.de>
References: <20201123083137.11575-1-liwang@redhat.com>
 <20201124153837.GA24470@yuki.lan>
 <875z5tllih.fsf@nanos.tec.linutronix.de>
Message-ID: <20201125123534.GA28684@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This is a general problem and not really just for this particular test
> case.
> 
> Due to the internal implementation of ktime_get_real_seconds(), which is
> a 2038 safe replacement for the former get_seconds() function, this
> accumulation issue can be observed. (time(2) via syscall and newer
> versions of VDSO use the same mechanism).
> 
>      clock_gettime(CLOCK_REALTIME, &ts);
>      sec = time();
>      assert(sec >= ts.tv_sec);
> 
> That assert can trigger for two reasons:
> 
>  1) Clock was set between the clock_gettime() and time().
> 
>  2) The clock has advanced far enough that:
> 
>     timekeeper.tv_nsec + (clock_now_ns() - last_update_ns) > NSEC_PER_SEC
> 
> #1 is just a property of clock REALTIME. There is nothing we can do
>    about that.
> 
> #2 is due to the optimized get_seconds()/time() access which avoids to
>    read the clock. This can happen on bare metal as well, but is far
>    more likely to be exposed on virt.
> 
> The same problem exists for CLOCK_XXX vs. CLOCK_XXX_COARSE
> 
>      clock_gettime(CLOCK_XXX, &ts);
>      clock_gettime(CLOCK_XXX_COARSE, &tc);
>      assert(tc.tv_sec >= ts.tv_sec);
> 
> The _COARSE variants return their associated timekeeper.tv_sec,tv_nsec
> pair without reading the clock. Same as #2 above just extended to clock
> MONOTONIC.

Good hint, I guess that easiest fix would be to switch to coarse timers
for these tests.

> There is no way to fix this except giving up on the fast accessors and
> make everything take the slow path and read the clock, which might make
> a lot of people unhappy.

That's understandable and reasonable. Thanks a lot for the confirmation.

> For clock REALTIME #1 is anyway an issue, so I think documenting this
> proper is the right thing to do.
> 
> Thoughts?

I guess that ideally BUGS section for time(2) and clock_gettime(2)
should be updated with this explanation.

-- 
Cyril Hrubis
chrubis@suse.cz
