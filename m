From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 20 May 2020 11:52:03 +0200
Subject: [LTP] [PATCH 4/5] syscalls: Don't pass struct timespec to
 tst_syscall()
In-Reply-To: <20200520093947.4vwmc4jdyqte67ua@vireshk-i7>
References: <cover.1589877853.git.viresh.kumar@linaro.org>
 <a6c2c59a9cffb86d751b911384a560803e723623.1589877853.git.viresh.kumar@linaro.org>
 <20200519122155.GB16008@yuki.lan> <20200520073151.y5xttqnqeqe4jmka@vireshk-i7>
 <CAK8P3a3kS-_ZynTR=o9FVAXEyr9VcAaigOcnG-_Se+wA_+jQoA@mail.gmail.com>
 <20200520090530.eabgbtpxlmnwbrpm@vireshk-i7>
 <CAK8P3a0DHENYhT3R6Xuygf2DiS8LLCCCfL025ESxqf6Rvth7ZA@mail.gmail.com>
 <20200520093947.4vwmc4jdyqte67ua@vireshk-i7>
Message-ID: <CAK8P3a2HW5WLLfyTY-nFpge-Ht1r1ZhtA+wFXDuws79yDjTfKw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, May 20, 2020 at 11:39 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 20-05-20, 11:35, Arnd Bergmann wrote:
> > On Wed, May 20, 2020 at 11:05 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > On 20-05-20, 10:47, Arnd Bergmann wrote:
> > > > On Wed, May 20, 2020 at 9:31 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > > int tst_clock_gettime(clockid_t clk_id, struct timespec *ts)
> > > >  {
> > > >        int ret;
> > > >
> > > > #ifdef(__NR_clock_gettime64)
> > > >         struct __kernel_timespec newts;
> > > >         ret = tst_syscall(__NR_clock_gettime64, clk_id, &newts);
> > > >         *ts = (struct timespec) { .tv_sec = newts.tv_sec, .tv_nsec =
> > > > newts.tv_nsec };
> > > >         if (ret != -ENOSYS)
> > > >               return ret;
> > > > #endif
> > > >
> > > > #ifdef __NR_clock_gettime
> > > >         struct __kernel_old_timespec oldts;
> > > >         ret = tst_syscall(__NR_clock_gettime, clk_id, &oldts);
> > > >         *ts = (struct timespec) { .tv_sec = oldts.tv_sec, .tv_nsec =
> > > > oldts.tv_nsec };
> > > >         if (ret != -ENOSYS)
> > > >               return ret;
> > > > #endif
> > > >
> > > >        /* fallback for prehistoric linux */
> > > >         struct timeval tv;
> > > >         ret = gettimeofday(&tv, NULL);
> > > >         *ts = (struct timespec) { .tv_sec = newts.tv_sec, .tv_usec =
> > > > newts.tv_nsec / 1000};
> > > >
> > > >         return ret;
> > > > }
> > >
> > > This is used only for the internal working of the library and so we may not need
> > > to support all these timespec types TBH and make it complex.
> >
> > Well, the point here is that you need the function to reliably return the
> > current time in the right format, and I don't think a simpler implementation
> > would be correct. In fact, I just realized that your patch version cannot work
> > on riscv32 since it only has __NR_clock_gettime64 but not __NR_clock_gettime.
>
> I am wondering that there would be lots of such issues across LTP, all existing
> ones btw, and should we try to fix them or not ? No one ever ran it on Risk I
> believe, otherwise they would have seen it.

I tried running LTP last year on an arm kernel that I configured to behave the
same way as rv32 (disabling CONFIG_COMPAT_32BIT_TIME) and I did
run into these problems, but I don't think they were too hard to work around.

           Arnd
