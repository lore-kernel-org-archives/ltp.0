From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 20 May 2020 14:35:30 +0530
Subject: [LTP] [PATCH 4/5] syscalls: Don't pass struct timespec to
 tst_syscall()
In-Reply-To: <CAK8P3a3kS-_ZynTR=o9FVAXEyr9VcAaigOcnG-_Se+wA_+jQoA@mail.gmail.com>
References: <cover.1589877853.git.viresh.kumar@linaro.org>
 <a6c2c59a9cffb86d751b911384a560803e723623.1589877853.git.viresh.kumar@linaro.org>
 <20200519122155.GB16008@yuki.lan>
 <20200520073151.y5xttqnqeqe4jmka@vireshk-i7>
 <CAK8P3a3kS-_ZynTR=o9FVAXEyr9VcAaigOcnG-_Se+wA_+jQoA@mail.gmail.com>
Message-ID: <20200520090530.eabgbtpxlmnwbrpm@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 20-05-20, 10:47, Arnd Bergmann wrote:
> On Wed, May 20, 2020 at 9:31 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 19-05-20, 14:21, Cyril Hrubis wrote:
> > > So we can as well so that they take the tst_ts structure, then we are
> > > also free to change the way the timestamp is acquired without the need
> > > to change all the callers.
> >
> > I am not sure I understood it all. What do you mean by "also free to change the
> > way the timestamp is acquired"?
> 
> The bug in the current implementation is that the tst_clock_gettime() takes
> the libc type but the argument to the kernel that may expect a different
> type.
> 
> Your patch solves the problem by using the kernel type consistently,
> but the other way to solve it is to keep passing the glibc type and
> instead make tst_clock_gettime() get a timestamp through the low
> level kernel interface using the kernel type and then convert it, like

That can be one way of doing it, but Cyril wasn't suggesting this I believe. He
talked about passing struct tst_ts instead (which is a union of all timespec
types).

> int tst_clock_gettime(clockid_t clk_id, struct timespec *ts)
>  {
>        int ret;
> 
> #ifdef(__NR_clock_gettime64)
>         struct __kernel_timespec newts;
>         ret = tst_syscall(__NR_clock_gettime64, clk_id, &newts);
>         *ts = (struct timespec) { .tv_sec = newts.tv_sec, .tv_nsec =
> newts.tv_nsec };
>         if (ret != -ENOSYS)
>               return ret;
> #endif
> 
> #ifdef __NR_clock_gettime
>         struct __kernel_old_timespec oldts;
>         ret = tst_syscall(__NR_clock_gettime, clk_id, &oldts);
>         *ts = (struct timespec) { .tv_sec = oldts.tv_sec, .tv_nsec =
> oldts.tv_nsec };
>         if (ret != -ENOSYS)
>               return ret;
> #endif
> 
>        /* fallback for prehistoric linux */
>         struct timeval tv;
>         ret = gettimeofday(&tv, NULL);
>         *ts = (struct timespec) { .tv_sec = newts.tv_sec, .tv_usec =
> newts.tv_nsec / 1000};
> 
>         return ret;
> }

This is used only for the internal working of the library and so we may not need
to support all these timespec types TBH and make it complex.

-- 
viresh
