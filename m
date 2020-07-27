From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 27 Jul 2020 11:40:30 +0200
Subject: [LTP] [PATCH V7 14/19] syscalls/select6: Add support for time64
 tests
In-Reply-To: <883a188e83c201b23074bf0ac974b41d89d818c7.1593152309.git.viresh.kumar@linaro.org>
References: <cover.1593152309.git.viresh.kumar@linaro.org>
 <883a188e83c201b23074bf0ac974b41d89d818c7.1593152309.git.viresh.kumar@linaro.org>
Message-ID: <20200727094030.GB7863@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This adds support for time64 tests to the existing select6() syscall
> tests.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  testcases/kernel/syscalls/select/select_var.h | 25 ++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/select/select_var.h b/testcases/kernel/syscalls/select/select_var.h
> index b19a1d1bf085..2c7604807cf6 100644
> --- a/testcases/kernel/syscalls/select/select_var.h
> +++ b/testcases/kernel/syscalls/select/select_var.h
> @@ -6,6 +6,7 @@
>  #define SELECT_VAR__
>  
>  #include "lapi/syscalls.h"
> +#include "tst_timer.h"
>  
>  struct compat_sel_arg_struct {
>  	long _n;
> @@ -38,7 +39,7 @@ static int do_select(int nfds, fd_set *readfds, fd_set *writefds, fd_set *except
>  	}
>  	case 2: {
>  		int ret;
> -		struct timespec ts = {
> +		struct __kernel_old_timespec ts = {
>  			.tv_sec = timeout->tv_sec,
>  			.tv_nsec = timeout->tv_usec * 1000,
>  		};

I'm a bit lost here, should we actually pass the __kernel_old_timespec
to all the tst_syscall() fuctions here?

I guess that the only function that would take the argument as struct
timeval is the select() glibc function, or do I miss something?

Also this change should be ideally done in a separate patch from the
second half that adds the __NR_pselect6_time64.

> @@ -47,7 +48,22 @@ static int do_select(int nfds, fd_set *readfds, fd_set *writefds, fd_set *except
>  		timeout->tv_usec = ts.tv_nsec / 1000;
>  		return ret;
>  	}
> -	case 3:
> +	case 3: {
> +		int ret = 0;
> +#if (__NR_clock_settime64 != __LTP__NR_INVALID_SYSCALL)
            ^
	    __NR_pselect6_time64 ?

> +		struct __kernel_timespec ts = {
> +			.tv_sec = timeout->tv_sec,
> +			.tv_nsec = timeout->tv_usec * 1000,
> +		};
> +		ret = tst_syscall(__NR_pselect6_time64, nfds, readfds, writefds, exceptfds, &ts, NULL);
> +		timeout->tv_sec = ts.tv_sec;
> +		timeout->tv_usec = ts.tv_nsec / 1000;
> +#else
> +		tst_brk(TCONF, "__NR_pselect6 time64 variant not supported");
> +#endif
> +		return ret;
> +	}
> +	case 4:
>  #ifdef __NR__newselect
>  		return tst_syscall(__NR__newselect, nfds, readfds, writefds, exceptfds, timeout);
>  #else
> @@ -72,11 +88,14 @@ static void select_info(void)
>  		tst_res(TINFO, "Testing SYS_pselect6 syscall");
>  	break;
>  	case 3:
> +		tst_res(TINFO, "Testing SYS_pselect6 time64 syscall");
> +	break;
> +	case 4:
>  		tst_res(TINFO, "Testing SYS__newselect syscall");
>  	break;
>  	}
>  }
>  
> -#define TEST_VARIANTS 4
> +#define TEST_VARIANTS 5

Also lastly but not least we should clean up the rest of the select
tests and add support for the different variants there as well.

Looking at them these are just copy&paste of the same test with a
different fds, we can easily merge them into a single test.

And the coverate in these tests is a bit lacking, we do not have a
single tests that would send a data over a pipe to a fd select is
watching and check that select was woken up by that. There is no such
test in the pselect/ directory either.

-- 
Cyril Hrubis
chrubis@suse.cz
