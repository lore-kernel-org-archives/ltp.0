From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 7 Apr 2020 14:36:35 +0200
Subject: [LTP] [RFC] syscalls/clock_gettime: Support time64 variants
In-Reply-To: <bff0fc8e8777a744d35bca86c83158efb90b0ff8.1586257574.git.viresh.kumar@linaro.org>
References: <bff0fc8e8777a744d35bca86c83158efb90b0ff8.1586257574.git.viresh.kumar@linaro.org>
Message-ID: <CAK8P3a2tbLZxyA-a=w7GZDwa0POwETaHQ73DqAU=FnB7zEnT2Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Apr 7, 2020 at 1:07 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Guys,
>
> I wanted to get some inputs/confirmations from everyone before going
> full fledged on implementing time64 changes and so here is an RFC.
>
> This extends the clock_gettime01.c tests to support time64 variants for
> both 32bit and 64bit architectures.
>
> Are there some other tests you guys want me to include ?
>
> @Arnd: I still wasn't able to understand how can I incorporate
> D_TIME_BITS thing here and so left it :(
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  include/tst_timer.h                           |  31 +++++
>  .../syscalls/clock_gettime/clock_gettime01.c  | 115 +++++++++---------
>  2 files changed, 89 insertions(+), 57 deletions(-)
>
> diff --git a/include/tst_timer.h b/include/tst_timer.h
> index cdb8de7987d9..282514abac08 100644
> --- a/include/tst_timer.h
> +++ b/include/tst_timer.h
> @@ -15,6 +15,37 @@
>  #include <sys/time.h>
>  #include <time.h>
>
> +#ifndef __kernel_timespec
> +typedef long __kernel_long_t;

Minor bug: __kernel_long_t is 'long long' on x32 (we might not care
here, but it's best to define the type to match the kernel)

> +typedef __kernel_long_t        __kernel_old_time_t;
> +
> +struct __kernel_old_timespec {
> +       __kernel_old_time_t     tv_sec;         /* seconds */
> +       long                    tv_nsec;        /* nanoseconds */
> +};

"__kernel_long_t tv_nsec;", also because of x32.

>
> -static int sys_clock_gettime(clockid_t clk_id, struct timespec *tp)
> +struct __kernel_timespec kspec64;
> +
> +#ifdef TST_ABI32
> +struct timespec spec32;
> +struct __kernel_old_timespec kspec32;
> +
> +static int _clock_gettime(clockid_t clk_id, void *tp)
>  {
> -       return tst_syscall(__NR_clock_gettime, clk_id, tp);
> +       return clock_gettime(clk_id, tp);
>  }

On new architectures, notably 32-bit risc-v, there is no __NR_clock_gettime,
as it only supports the 64-bit interface.

> -static int check_spec(struct timespec *spec)
> +static int sys_clock_gettime64(clockid_t clk_id, void *tp)
>  {
> -       return (spec->tv_nsec != 0 || spec->tv_sec != 0) ? 1 : 0;
> +       return tst_syscall(__NR_clock_gettime64, clk_id, tp);
>  }
> +#endif

And when building against old kernel headers or on 64-bit
architectures, this one is not available.

> +struct tmpfunc {
> +       int (*func)(clockid_t clk_id, void *tp);
> +       int (*check)(void *spec);
> +       void *spec;
> +       int spec_size;
> +       char *desc;
> +} variants[] = {
> +#ifdef TST_ABI32
> +       { .func = _clock_gettime, .check = tst_timespec_updated_32, .spec = &spec32, .spec_size = sizeof(spec32), .desc = "vDSO or syscall (32)"},
> +       { .func = sys_clock_gettime, .check = tst_timespec_updated_32, .spec = &spec32, .spec_size = sizeof(spec32), .desc = "syscall (32) with libc spec"},
> +       { .func = sys_clock_gettime, .check = tst_timespec_updated_32, .spec = &kspec32, .spec_size = sizeof(kspec32), .desc = "syscall (32) with kernel spec"},
> +       { .func = sys_clock_gettime64, .check = tst_timespec_updated_64, .spec = &kspec64, .spec_size = sizeof(kspec64), .desc = "syscall (64) with kernel spec"},
> +#else
> +       { .func = sys_clock_gettime, .check = tst_timespec_updated_64, .spec = &kspec64, .spec_size = sizeof(kspec64), .desc = "syscall (64) with kernel spec"},
> +#endif
> +};

I think instead of an #if / #else, this should have separate #if statements for
whichever versions are available on the given combination of architecture,
libc and kernel header.

       Arnd
