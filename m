From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 7 Jul 2020 17:02:45 +0200
Subject: [LTP] [PATCH V2] syscalls/timer_settime01: Make sure the timer
 fires
In-Reply-To: <ede8d1c6a1ad1b23d8dca2297c740c301b329e37.1593743927.git.viresh.kumar@linaro.org>
References: <7c68854a1b6ef828ed8dd83cb611bd5b5d53c2f8.1593430825.git.viresh.kumar@linaro.org>
 <ede8d1c6a1ad1b23d8dca2297c740c301b329e37.1593743927.git.viresh.kumar@linaro.org>
Message-ID: <20200707150245.GA15971@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> - Make sure the timer fires and catch the signals.
> 
> - Verify the values set to the itimerspec by reading them again using
>   timer_gettime() syscalls.
> 
> - Reduce the timer interval, 5 seconds was way too much.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V1.1->V2:
> - 1/2 patch removed and solved rebase conflicts.
> 
>  .../syscalls/timer_settime/timer_settime01.c  | 70 ++++++++++++++-----
>  1 file changed, 52 insertions(+), 18 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/timer_settime/timer_settime01.c b/testcases/kernel/syscalls/timer_settime/timer_settime01.c
> index 08fb56e4943a..67769d088ab8 100644
> --- a/testcases/kernel/syscalls/timer_settime/timer_settime01.c
> +++ b/testcases/kernel/syscalls/timer_settime/timer_settime01.c
> @@ -38,28 +38,42 @@ static struct testcase {
>  	int			flag;
>  	char			*description;
>  } tcases[] = {
> -	{NULL,     5, 0, 0, "general initialization"},
> -	{&old_set, 5, 0, 0, "setting old_value"},
> -	{&old_set, 0, 5, 0, "using periodic timer"},
> -	{&old_set, 5, 0, TIMER_ABSTIME, "using absolute time"},
> +	{NULL, 1, 0, 0, "general initialization"},
> +	{&old_set, 1, 0, 0, "setting old_value"},
> +	{&old_set, 1, 1, 0, "using periodic timer"},
> +	{&old_set, 1, 0, TIMER_ABSTIME, "using absolute time"},
>  };

One second is pretty much too long as well. Can we please reduce this to
0.1s instead?

>  static struct test_variants {
> -	int (*gettime)(clockid_t clk_id, void *ts);
> -	int (*func)(timer_t timerid, int flags, void *its,
> -		    void *old_its);
> +	int (*cgettime)(clockid_t clk_id, void *ts);
> +	int (*tgettime)(timer_t timer, void *its);
> +	int (*func)(timer_t timerid, int flags, void *its, void *old_its);
>  	enum tst_ts_type type;
>  	char *desc;
>  } variants[] = {
>  #if (__NR_timer_settime != __LTP__NR_INVALID_SYSCALL)
> -	{ .gettime = sys_clock_gettime, .func = sys_timer_settime, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
> +	{ .cgettime = sys_clock_gettime, .tgettime = sys_timer_gettime, .func = sys_timer_settime, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
>  #endif
>  
>  #if (__NR_timer_settime64 != __LTP__NR_INVALID_SYSCALL)
> -	{ .gettime = sys_clock_gettime64, .func = sys_timer_settime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
> +	{ .cgettime = sys_clock_gettime64, .tgettime = sys_timer_gettime64, .func = sys_timer_settime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
>  #endif
>  };
>  
> +static volatile int caught_signal;
> +
> +static void clear_signal(void)
> +{
> +	/*
> +	 * The busy loop is intentional. The signal is sent after X
> +	 * seconds of CPU time has been accumulated for the process and
> +	 * thread specific clocks.
> +	 */
> +	while (!caught_signal);
> +
> +	caught_signal = 0;
> +}
> +
>  static void run(unsigned int n)
>  {
>  	struct test_variants *tv = &variants[tst_variant];
> @@ -101,7 +115,7 @@ static void run(unsigned int n)
>  
>  		if (tc->flag & TIMER_ABSTIME) {
>  			timenow.type = tv->type;
> -			if (tv->gettime(clock, tst_ts_get(&timenow)) < 0) {
> +			if (tv->cgettime(clock, tst_ts_get(&timenow)) < 0) {
>  				tst_res(TFAIL,
>  					"clock_gettime(%s) failed - skipping the test",
>  					get_clock_str(clock));
> @@ -118,23 +132,43 @@ static void run(unsigned int n)
>  		TEST(tv->func(timer, tc->flag, tst_its_get(&new_set), tst_its_get(tc->old_ptr)));
>  
>  		if (TST_RET != 0) {
> -			tst_res(TFAIL | TTERRNO, "%s failed",
> -					get_clock_str(clock));
> -		} else {
> -			tst_res(TPASS, "%s was successful",
> -					get_clock_str(clock));
> +			tst_res(TFAIL | TTERRNO, "timer_settime(%s) failed",
> +				get_clock_str(clock));
> +		}
> +
> +		TEST(tv->tgettime(timer, tst_its_get(&new_set)));
> +		if (TST_RET != 0) {
> +			tst_res(TFAIL | TTERRNO, "timer_gettime(%s) failed",
> +				get_clock_str(clock));
> +		}

If we fail here we should probably skip at least new_set checks below.

> +		if (tst_its_get_interval_sec(new_set) > tc->it_interval_tv_sec ||

The interval value should be equal to the one we have set, so we can
compare exactly.

> +		    tst_its_get_value_sec(new_set) > val) {

And the time to the next expiration is always relative, so this should
be:

		    if (value > MAX(tc->interval, tc->value))

> +			tst_res(TFAIL | TTERRNO,
> +				"timer_gettime(%s) reported bad values (%llu: %llu)",
> +				get_clock_str(clock),
> +				tst_its_get_interval_sec(new_set),
> +				tst_its_get_value_sec(new_set));
>  		}
>  
> +		clear_signal();
> +
> +		/* Wait for another event when interval was set */
> +		if (tc->it_interval_tv_sec)
> +			clear_signal();
> +
> +		tst_res(TPASS, "timer_settime(%s) passed",
> +			get_clock_str(clock));
> +
>  		TEST(tst_syscall(__NR_timer_delete, timer));
>  		if (TST_RET != 0)
>  			tst_res(TFAIL | TTERRNO, "timer_delete() failed!");
>  	}
>  }
>  
> -static void sighandler(int sig)
> +static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
>  {
> -	/* sighandler for CLOCK_*_ALARM */
> -	tst_res(TINFO, "Caught signal %s", tst_strsig(sig));
> +	caught_signal = 1;
>  }

We should check that sig has correct value as well, so I guess
that we can set caught_signal to -1 if sig != SIGARLM or something.

>  static void setup(void)
> -- 
> 2.25.0.rc1.19.g042ed3e048af
> 

-- 
Cyril Hrubis
chrubis@suse.cz
