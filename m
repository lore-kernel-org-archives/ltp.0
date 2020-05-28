From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 28 May 2020 12:28:15 +0530
Subject: [LTP] [PATCH] syscalls: clock_settime: Add test around y2038
 vulnerability
In-Reply-To: <CAK8P3a13aJ3joRBE=P06fX8fxS-yroHx=T=bG0ZtdjhWE3RAJg@mail.gmail.com>
References: <70417fdc55c750e8b13d7124e66a7e8a59182e75.1590494889.git.viresh.kumar@linaro.org>
 <CAK8P3a13aJ3joRBE=P06fX8fxS-yroHx=T=bG0ZtdjhWE3RAJg@mail.gmail.com>
Message-ID: <20200528065815.4zygmlzz4s2xpuq6@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 27-05-20, 13:18, Arnd Bergmann wrote:
> On Tue, May 26, 2020 at 2:10 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > This adds a test around the y2038 vulnerability, it sets the system time
> > to just before y2038 time (i.e. max value that can be stored in s32),
> > and adds a timer to expire just after crossing it.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Nice!
> > +static struct test_variants {
> > +       int (*clock_settime)(clockid_t clk_id, void *ts);
> > +       int (*timer_settime)(timer_t timerid, int flags, void *its,
> > +                            void *old_its);
> > +       enum tst_ts_type type;
> > +       char *desc;
> > +} variants[] = {
> > +#if (__NR_clock_settime != __LTP__NR_INVALID_SYSCALL)
> > +       { .clock_settime = sys_clock_settime, .timer_settime = sys_timer_settime, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
> > +#endif
> > +
> > +#if (__NR_clock_settime64 != __LTP__NR_INVALID_SYSCALL)
> > +       { .clock_settime = sys_clock_settime64, .timer_settime = sys_timer_settime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
> > +#endif
> 
> I think the first one has to be guarded so we do not try to set
> the time to just before the end with sys_clock_settime() on
> 32-bit machines, as kernels that don't fully support 64-bit
> time_t behave in unpredictable ways when you do that and
> are likely to crash.
> 
> However, we probably do want to test this on 64-bit kernels
> with sys_clock_settime() anyway.

I have done this differently, please see V2.

-- 
viresh
