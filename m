From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 19 May 2020 14:21:55 +0200
Subject: [LTP] [PATCH 4/5] syscalls: Don't pass struct timespec to
 tst_syscall()
In-Reply-To: <a6c2c59a9cffb86d751b911384a560803e723623.1589877853.git.viresh.kumar@linaro.org>
References: <cover.1589877853.git.viresh.kumar@linaro.org>
 <a6c2c59a9cffb86d751b911384a560803e723623.1589877853.git.viresh.kumar@linaro.org>
Message-ID: <20200519122155.GB16008@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> There are compatibility issues here as we are calling the direct
> syscalls with the "struct timespec" (which is a libc definition). We
> must use struct __kernel_old_timespec instead.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  include/tst_clocks.h          |  8 +++++---
>  lib/tst_clocks.c              |  6 +++---
>  lib/tst_test.c                | 16 ++++++++--------
>  lib/tst_timer.c               | 23 +++++++++++++++--------
>  lib/tst_timer_test.c          |  2 +-
>  lib/tst_wallclock.c           | 17 +++++++++--------
>  testcases/cve/cve-2016-7117.c |  2 +-
>  7 files changed, 42 insertions(+), 32 deletions(-)
> 
> diff --git a/include/tst_clocks.h b/include/tst_clocks.h
> index 80030c6b0c68..bb149acd2f83 100644
> --- a/include/tst_clocks.h
> +++ b/include/tst_clocks.h
> @@ -9,11 +9,13 @@
>  #ifndef TST_CLOCKS__
>  #define TST_CLOCKS__
>  
> -int tst_clock_getres(clockid_t clk_id, struct timespec *res);
> +struct __kernel_old_timespec;
>  
> -int tst_clock_gettime(clockid_t clk_id, struct timespec *ts);
> +int tst_clock_getres(clockid_t clk_id, struct __kernel_old_timespec *res);
>  
> -int tst_clock_settime(clockid_t clk_id, struct timespec *ts);
> +int tst_clock_gettime(clockid_t clk_id, struct __kernel_old_timespec *ts);
> +
> +int tst_clock_settime(clockid_t clk_id, struct __kernel_old_timespec *ts);
>  
>  /*
>   * Converts clock id to a readable name.
> diff --git a/lib/tst_clocks.c b/lib/tst_clocks.c
> index 2eaa73b11abe..8d8c2f7666fa 100644
> --- a/lib/tst_clocks.c
> +++ b/lib/tst_clocks.c
> @@ -11,17 +11,17 @@
>  #include "lapi/syscalls.h"
>  #include "lapi/posix_clocks.h"
>  
> -int tst_clock_getres(clockid_t clk_id, struct timespec *res)
> +int tst_clock_getres(clockid_t clk_id, struct __kernel_old_timespec *res)
>  {
>  	return tst_syscall(__NR_clock_getres, clk_id, res);
>  }
>  
> -int tst_clock_gettime(clockid_t clk_id, struct timespec *ts)
> +int tst_clock_gettime(clockid_t clk_id, struct __kernel_old_timespec *ts)
>  {
>  	return tst_syscall(__NR_clock_gettime, clk_id, ts);
>  }
>  
> -int tst_clock_settime(clockid_t clk_id, struct timespec *ts)
> +int tst_clock_settime(clockid_t clk_id, struct __kernel_old_timespec *ts)
>  {
>  	return tst_syscall(__NR_clock_settime, clk_id, ts);
>  }

These functions are supposed to be library-internal and were added so
that we do not have to link everything in LTP with -lrt, which is needed
for the clock_gettime() functions on older glibc.

So we can as well so that they take the tst_ts structure, then we are
also free to change the way the timestamp is acquired without the need
to change all the callers.

-- 
Cyril Hrubis
chrubis@suse.cz
