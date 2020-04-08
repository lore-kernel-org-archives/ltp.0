From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 8 Apr 2020 23:06:36 +0200
Subject: [LTP] [RFC] syscalls/clock_gettime: Support time64 variants
In-Reply-To: <20200408065720.p2tkny6icrqa7o25@vireshk-i7>
References: <bff0fc8e8777a744d35bca86c83158efb90b0ff8.1586257574.git.viresh.kumar@linaro.org>
 <CAK8P3a2tbLZxyA-a=w7GZDwa0POwETaHQ73DqAU=FnB7zEnT2Q@mail.gmail.com>
 <20200408065720.p2tkny6icrqa7o25@vireshk-i7>
Message-ID: <CAK8P3a23RqzSMasitwbrmc5+HpH8zKPk-Xx5rSF75qsnDMDRCg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Apr 8, 2020 at 8:57 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 07-04-20, 14:36, Arnd Bergmann wrote:
> > On Tue, Apr 7, 2020 at 1:07 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> --- a/include/tst_timer.h
> +++ b/include/tst_timer.h
> @@ -16,12 +16,17 @@
>  #include <time.h>
>
>  #ifndef __kernel_timespec
> +#ifdef __x86_x32__
> +typedef long long __kernel_long_t;
> +#else
>  typedef long __kernel_long_t;
> +#endif

The correct portable way to check is

#if defined(__x86_64__) && defined(__ILP32__)

> > > -static int check_spec(struct timespec *spec)
> > > +static int sys_clock_gettime64(clockid_t clk_id, void *tp)
> > >  {
> > > -       return (spec->tv_nsec != 0 || spec->tv_sec != 0) ? 1 : 0;
> > > +       return tst_syscall(__NR_clock_gettime64, clk_id, tp);
> > >  }
> > > +#endif
> >
> > And when building against old kernel headers or on 64-bit
> > architectures, this one is not available.
>
> As Petr said, even if these get called on the architecture we don't support, we
> will get something like this in output only once for the tests..
>
> clock_gettime01.c:74: CONF: syscall(-1) __NR_clock_gettime64 not supported

Ok, if that is desired, it seems fine.

> > > +struct tmpfunc {
> > > +       int (*func)(clockid_t clk_id, void *tp);
> > > +       int (*check)(void *spec);
> > > +       void *spec;
> > > +       int spec_size;
> > > +       char *desc;
> > > +} variants[] = {
> > > +#ifdef TST_ABI32
> > > +       { .func = _clock_gettime, .check = tst_timespec_updated_32, .spec = &spec32, .spec_size = sizeof(spec32), .desc = "vDSO or syscall (32)"},
> > > +       { .func = sys_clock_gettime, .check = tst_timespec_updated_32, .spec = &spec32, .spec_size = sizeof(spec32), .desc = "syscall (32) with libc spec"},
> > > +       { .func = sys_clock_gettime, .check = tst_timespec_updated_32, .spec = &kspec32, .spec_size = sizeof(kspec32), .desc = "syscall (32) with kernel spec"},
> > > +       { .func = sys_clock_gettime64, .check = tst_timespec_updated_64, .spec = &kspec64, .spec_size = sizeof(kspec64), .desc = "syscall (64) with kernel spec"},
> > > +#else
> > > +       { .func = sys_clock_gettime, .check = tst_timespec_updated_64, .spec = &kspec64, .spec_size = sizeof(kspec64), .desc = "syscall (64) with kernel spec"},
> > > +#endif
> > > +};
> >
> > I think instead of an #if / #else, this should have separate #if statements for
> > whichever versions are available on the given combination of architecture,
> > libc and kernel header.
>
> Can you give an example on how you would write it ?

For the direct syscalls, I would just provide the "old" and the
"time64" versions,
based on the idea that any architecture that defines the syscall numbers
with the _time64 suffix has the time64 structures, and any architecture
that has the old macros uses the old structures.

You can have a shortcut to skip the time64 version on 64-bit architectures
that will never implement those.

> Also any other tests I should have included here ?

Aside from duplicating all the tests for old+time64, I would suggest explicitly
testing for correct behavior of the time64 syscalls regarding the upper half of
the tv_nsec field in syscalls passing a timespec structure:

When passing a __kernel_timespec into the kernel from a 32-bit process,
the kernel must ignore any garbage in the upper bits, so e.g.
".tv_nsec = 0x1234567800100000" must be interpreted by the 32-bit
syscall to be the same as 0x1000000, while the 64-bit syscall must
return -EINVAL since .tv_nsec is larger than 999999999.

When passing a timespec from the kernel to user space, any
garbage in the upper half of .tv_nsec must be zeroed by the kernel.
Note that 'glibc's timespec uses a 32-bit tv_nsec plus padding,
but the kernel ABI requires that padding to be cleared by the
kernel both ways.

        Arnd
