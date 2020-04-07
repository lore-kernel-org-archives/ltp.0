From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 7 Apr 2020 21:23:56 +0200
Subject: [LTP] [RFC] syscalls/clock_gettime: Support time64 variants
In-Reply-To: <CAK8P3a2tbLZxyA-a=w7GZDwa0POwETaHQ73DqAU=FnB7zEnT2Q@mail.gmail.com>
References: <bff0fc8e8777a744d35bca86c83158efb90b0ff8.1586257574.git.viresh.kumar@linaro.org>
 <CAK8P3a2tbLZxyA-a=w7GZDwa0POwETaHQ73DqAU=FnB7zEnT2Q@mail.gmail.com>
Message-ID: <20200407192356.GA9828@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Arnd,

thanks for a review!

...
> > +#ifndef __kernel_timespec
> > +typedef long __kernel_long_t;

> Minor bug: __kernel_long_t is 'long long' on x32 (we might not care
> here, but it's best to define the type to match the kernel)
+1 (defined in arch/x86/include/uapi/asm/posix_types_x32.h


> > +typedef __kernel_long_t        __kernel_old_time_t;
> > +
> > +struct __kernel_old_timespec {
> > +       __kernel_old_time_t     tv_sec;         /* seconds */
> > +       long                    tv_nsec;        /* nanoseconds */
> > +};

> "__kernel_long_t tv_nsec;", also because of x32.


> > -static int sys_clock_gettime(clockid_t clk_id, struct timespec *tp)
> > +struct __kernel_timespec kspec64;
> > +
> > +#ifdef TST_ABI32
> > +struct timespec spec32;
> > +struct __kernel_old_timespec kspec32;
> > +
> > +static int _clock_gettime(clockid_t clk_id, void *tp)
> >  {
> > -       return tst_syscall(__NR_clock_gettime, clk_id, tp);
> > +       return clock_gettime(clk_id, tp);
> >  }

> On new architectures, notably 32-bit risc-v, there is no __NR_clock_gettime,
> as it only supports the 64-bit interface.
That should be ok (tst_syscall() checks for ENOSYS and resulting with TCONF).

> > -static int check_spec(struct timespec *spec)
> > +static int sys_clock_gettime64(clockid_t clk_id, void *tp)
> >  {
> > -       return (spec->tv_nsec != 0 || spec->tv_sec != 0) ? 1 : 0;
> > +       return tst_syscall(__NR_clock_gettime64, clk_id, tp);
> >  }
> > +#endif

> And when building against old kernel headers or on 64-bit
> architectures, this one is not available.
I guess that's the reason Viresh used it just for 32-bit.

> > +struct tmpfunc {
> > +       int (*func)(clockid_t clk_id, void *tp);
> > +       int (*check)(void *spec);
> > +       void *spec;
> > +       int spec_size;
> > +       char *desc;
> > +} variants[] = {
> > +#ifdef TST_ABI32
> > +       { .func = _clock_gettime, .check = tst_timespec_updated_32, .spec = &spec32, .spec_size = sizeof(spec32), .desc = "vDSO or syscall (32)"},
> > +       { .func = sys_clock_gettime, .check = tst_timespec_updated_32, .spec = &spec32, .spec_size = sizeof(spec32), .desc = "syscall (32) with libc spec"},
> > +       { .func = sys_clock_gettime, .check = tst_timespec_updated_32, .spec = &kspec32, .spec_size = sizeof(kspec32), .desc = "syscall (32) with kernel spec"},
> > +       { .func = sys_clock_gettime64, .check = tst_timespec_updated_64, .spec = &kspec64, .spec_size = sizeof(kspec64), .desc = "syscall (64) with kernel spec"},
> > +#else
> > +       { .func = sys_clock_gettime, .check = tst_timespec_updated_64, .spec = &kspec64, .spec_size = sizeof(kspec64), .desc = "syscall (64) with kernel spec"},
> > +#endif
> > +};

> I think instead of an #if / #else, this should have separate #if statements for
> whichever versions are available on the given combination of architecture,
> libc and kernel header.

>        Arnd

Kind regards,
Petr
