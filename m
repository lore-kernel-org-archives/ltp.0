From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 20 May 2020 10:47:17 +0200
Subject: [LTP] [PATCH 4/5] syscalls: Don't pass struct timespec to
 tst_syscall()
In-Reply-To: <20200520073151.y5xttqnqeqe4jmka@vireshk-i7>
References: <cover.1589877853.git.viresh.kumar@linaro.org>
 <a6c2c59a9cffb86d751b911384a560803e723623.1589877853.git.viresh.kumar@linaro.org>
 <20200519122155.GB16008@yuki.lan> <20200520073151.y5xttqnqeqe4jmka@vireshk-i7>
Message-ID: <CAK8P3a3kS-_ZynTR=o9FVAXEyr9VcAaigOcnG-_Se+wA_+jQoA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, May 20, 2020 at 9:31 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 19-05-20, 14:21, Cyril Hrubis wrote:
> > So we can as well so that they take the tst_ts structure, then we are
> > also free to change the way the timestamp is acquired without the need
> > to change all the callers.
>
> I am not sure I understood it all. What do you mean by "also free to change the
> way the timestamp is acquired"?

The bug in the current implementation is that the tst_clock_gettime() takes
the libc type but the argument to the kernel that may expect a different
type.

Your patch solves the problem by using the kernel type consistently,
but the other way to solve it is to keep passing the glibc type and
instead make tst_clock_gettime() get a timestamp through the low
level kernel interface using the kernel type and then convert it, like

int tst_clock_gettime(clockid_t clk_id, struct timespec *ts)
 {
       int ret;

#ifdef(__NR_clock_gettime64)
        struct __kernel_timespec newts;
        ret = tst_syscall(__NR_clock_gettime64, clk_id, &newts);
        *ts = (struct timespec) { .tv_sec = newts.tv_sec, .tv_nsec =
newts.tv_nsec };
        if (ret != -ENOSYS)
              return ret;
#endif

#ifdef __NR_clock_gettime
        struct __kernel_old_timespec oldts;
        ret = tst_syscall(__NR_clock_gettime, clk_id, &oldts);
        *ts = (struct timespec) { .tv_sec = oldts.tv_sec, .tv_nsec =
oldts.tv_nsec };
        if (ret != -ENOSYS)
              return ret;
#endif

       /* fallback for prehistoric linux */
        struct timeval tv;
        ret = gettimeofday(&tv, NULL);
        *ts = (struct timespec) { .tv_sec = newts.tv_sec, .tv_usec =
newts.tv_nsec / 1000};

        return ret;
}

Or something like it that works reliably.
