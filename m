From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 22 May 2020 14:12:05 +0530
Subject: [LTP] [PATCH V2 5/6] syscalls: Don't pass struct timespec to
 tst_syscall()
In-Reply-To: <CAK8P3a2B35hUF3rSdJpS=M-Wekm+wUx-skekgw3CiQR=wodqXw@mail.gmail.com>
References: <cover.1590130423.git.viresh.kumar@linaro.org>
 <c5428a9c88d18fac80e364281cfd4e3aefa38d2c.1590130423.git.viresh.kumar@linaro.org>
 <CAK8P3a2B35hUF3rSdJpS=M-Wekm+wUx-skekgw3CiQR=wodqXw@mail.gmail.com>
Message-ID: <20200522084205.hvkx4maxujzb2s2y@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 22-05-20, 10:02, Arnd Bergmann wrote:
> On Fri, May 22, 2020 at 8:54 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> >
> >  int tst_clock_getres(clockid_t clk_id, struct timespec *res)
> >  {
> > -       return tst_syscall(__NR_clock_getres, clk_id, res);
> > +       int (*func)(clockid_t clk_id, void *ts);
> > +       struct tst_ts tts = { 0, };
> > +       int ret;
> > +
> > +#if defined(__NR_clock_getres_time64)
> > +       tts.type = TST_KERN_TIMESPEC;
> > +       func = sys_clock_getres64;
> > +#elif defined(__NR_clock_getres)
> > +       tts.type = TST_KERN_OLD_TIMESPEC;
> > +       func = sys_clock_getres;
> > +#else
> > +       tts.type = TST_LIBC_TIMESPEC;
> > +       func = libc_clock_getres;
> > +#endif
> > +
> > +       ret = func(clk_id, tst_ts_get(&tts));
> 
> This is not enough to run on old kernels that have __NR_clock_getres
> but don't have __NR_clock_getres_time64,

What about reversing the order of the two ? Check __NR_clock_getres
first ?

> you need a runtime fallback
> instead of a compile-time fallback.

Why so ?

-- 
viresh
