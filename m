From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Date: Thu, 26 Nov 2020 11:36:54 +0000
Subject: [LTP] [PATCH 1/2] syscalls: avoid time() using
 __cvdso_gettimeofday in use-level's VDSO
In-Reply-To: <875z5tllih.fsf@nanos.tec.linutronix.de>
References: <20201123083137.11575-1-liwang@redhat.com>
 <20201124153837.GA24470@yuki.lan> <875z5tllih.fsf@nanos.tec.linutronix.de>
Message-ID: <c77c4306-6a7e-01f5-c338-ec1c8ef2c0c6@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Thomas.

On 11/25/20 11:32 AM, Thomas Gleixner wrote:
[...]

>>> Here we propose to use '__NR_time' to invoke syscall directly that makes
>>> test all get real seconds via ktime_get_real_second.
> 
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
> 
> There is no way to fix this except giving up on the fast accessors and
> make everything take the slow path and read the clock, which might make
> a lot of people unhappy.
> 
> For clock REALTIME #1 is anyway an issue, so I think documenting this
> proper is the right thing to do.
> 
> Thoughts?
>

I completely agree with your analysis and the fact that we should document this
information.

My proposal would be to use either the vDSO document present in the kernel [1]
or the man pages for time(2) and clock_gettime(2). Probably the second would be
more accessible to user space developers.

[1] Documentation/ABI/stable/vdso

> Thanks,
> 
>         tglx
> 

-- 
Regards,
Vincenzo
