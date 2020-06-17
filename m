From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 17 Jun 2020 14:22:06 +0200
Subject: [LTP] [PATCH V2 5/6] syscalls: Don't pass struct timespec to
 tst_syscall()
In-Reply-To: <20200522084205.hvkx4maxujzb2s2y@vireshk-i7>
References: <cover.1590130423.git.viresh.kumar@linaro.org>
 <c5428a9c88d18fac80e364281cfd4e3aefa38d2c.1590130423.git.viresh.kumar@linaro.org>
 <CAK8P3a2B35hUF3rSdJpS=M-Wekm+wUx-skekgw3CiQR=wodqXw@mail.gmail.com>
 <20200522084205.hvkx4maxujzb2s2y@vireshk-i7>
Message-ID: <20200617122206.GB8389@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > >  int tst_clock_getres(clockid_t clk_id, struct timespec *res)
> > >  {
> > > -       return tst_syscall(__NR_clock_getres, clk_id, res);
> > > +       int (*func)(clockid_t clk_id, void *ts);
> > > +       struct tst_ts tts = { 0, };
> > > +       int ret;
> > > +
> > > +#if defined(__NR_clock_getres_time64)
> > > +       tts.type = TST_KERN_TIMESPEC;
> > > +       func = sys_clock_getres64;
> > > +#elif defined(__NR_clock_getres)
> > > +       tts.type = TST_KERN_OLD_TIMESPEC;
> > > +       func = sys_clock_getres;
> > > +#else
> > > +       tts.type = TST_LIBC_TIMESPEC;
> > > +       func = libc_clock_getres;
> > > +#endif
> > > +
> > > +       ret = func(clk_id, tst_ts_get(&tts));
> > 
> > This is not enough to run on old kernels that have __NR_clock_getres
> > but don't have __NR_clock_getres_time64,
> 
> What about reversing the order of the two ? Check __NR_clock_getres
> first ?
>
> > you need a runtime fallback
> > instead of a compile-time fallback.
> 
> Why so ?

The existence of the __NR_... does not mean that particular syscall is
supported or even exists. As said previously LTP defines unimplemented
syscalls to -1 to avoid #ifdef hell.

Also even if the 64bit syscall is defined in headers on particular 32bit
platform calling it on old kernel will still fail because the
functionality is simply not there.

Hence we have to select the right function on the first call to the
tst_clock_* functions.

-- 
Cyril Hrubis
chrubis@suse.cz
