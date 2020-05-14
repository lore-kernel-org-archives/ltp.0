From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 14 May 2020 11:44:21 +0200
Subject: [LTP] [PATCH V2] syscalls: Fix issues around calling syscalls
 with old timespec
In-Reply-To: <addb718d24b6a32853bfc9fc6f47833b253fc719.1589434662.git.viresh.kumar@linaro.org>
References: <addb718d24b6a32853bfc9fc6f47833b253fc719.1589434662.git.viresh.kumar@linaro.org>
Message-ID: <20200514094421.GA18592@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The non _time64 syscalls can only be called with the old timespec and
> calling them with the libc timespec or the new kernel timespec is
> incorrect.
> 
> Similarly, calling the libc interfaces with the old timespec is
> incorrect as well and they should be called only with the libc timespec.
> 
> This patch updates various testcases that have got this issue.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V2:
> - Don't declare __kernel_old_time_t and again.
> 
>  .../syscalls/clock_adjtime/clock_adjtime.h    | 57 +++++++++++++++----
>  .../syscalls/clock_adjtime/clock_adjtime01.c  | 11 +---
>  .../syscalls/clock_adjtime/clock_adjtime02.c  | 11 +---
>  .../syscalls/clock_getres/clock_getres01.c    | 17 ++----
>  .../syscalls/clock_gettime/clock_gettime01.c  | 11 +---
>  .../syscalls/clock_gettime/clock_gettime02.c  | 12 +---
>  .../syscalls/clock_gettime/clock_gettime03.c  | 11 +---
>  .../clock_nanosleep/clock_nanosleep01.c       | 11 +---
>  .../clock_nanosleep/clock_nanosleep03.c       | 11 +---
>  .../clock_nanosleep/clock_nanosleep04.c       | 11 +---
>  .../syscalls/clock_settime/clock_settime01.c  | 11 +---
>  .../syscalls/clock_settime/clock_settime02.c  | 12 +---
>  12 files changed, 82 insertions(+), 104 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/clock_adjtime/clock_adjtime.h b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime.h
> index e4cf80fa8bcc..9dd6c1f349c1 100644
> --- a/testcases/kernel/syscalls/clock_adjtime/clock_adjtime.h
> +++ b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime.h
> @@ -14,9 +14,46 @@
>  #include <pwd.h>
>  #include <sys/timex.h>
>  #include <sys/types.h>
> +#include <asm/posix_types.h>
>  #include "lapi/timex.h"
>  
>  #ifndef __kernel_timex
> +struct __kernel_old_timeval {
> +	__kernel_old_time_t	tv_sec;		/* seconds */
> +	__kernel_suseconds_t	tv_usec;	/* microseconds */
> +};
> +
> +struct __kernel_old_timex {
> +	unsigned int modes;	/* mode selector */
> +	__kernel_long_t offset;	/* time offset (usec) */
> +	__kernel_long_t freq;	/* frequency offset (scaled ppm) */
> +	__kernel_long_t maxerror;/* maximum error (usec) */
> +	__kernel_long_t esterror;/* estimated error (usec) */
> +	int status;		/* clock command/status */
> +	__kernel_long_t constant;/* pll time constant */
> +	__kernel_long_t precision;/* clock precision (usec) (read only) */
> +	__kernel_long_t tolerance;/* clock frequency tolerance (ppm)
> +				   * (read only)
> +				   */
> +	struct timeval time;	/* (read only, except for ADJ_SETOFFSET) */

This is still libc struct timeval, should be this the
__kernel_old_timeval instead?

Other than this the patch looks obviously fine and also should be
applied before the release.

-- 
Cyril Hrubis
chrubis@suse.cz
