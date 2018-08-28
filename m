From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Aug 2018 16:23:40 +0200
Subject: [LTP] [PATCH 2/5] tst_timer: Create interface for using
 multiple timers
In-Reply-To: <20180828093002.20368-3-rpalethorpe@suse.com>
References: <20180828093002.20368-1-rpalethorpe@suse.com>
 <20180828093002.20368-3-rpalethorpe@suse.com>
Message-ID: <20180828142340.GB26231@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#ifdef CLOCK_MONOTONIC_RAW
> +# define TST_CLOCK_DEFAULT CLOCK_MONOTONIC_RAW
> +#else
> +# define TST_CLOCK_DEFAULT CLOCK_MONOTONIC
> +#endif

This should probably go in a separate patch.

> +/**
> + * Encapsulates a stopwatch timer.
> + *
> + * Useful when you need to use multiple timers in a single test.
> + */
> +struct tst_timer {
> +	/** The POSIX clock type  */
> +	clockid_t clock_id;
> +	/** How much time can pass before tst_timer_expired_st() returns true */
> +	struct timespec limit;
> +	/** Where to start measuring time from */
> +	struct timespec start_time;
> +};
> +
>  /*
>   * Converts timespec to microseconds.
>   */
> @@ -92,6 +112,19 @@ static inline struct timeval tst_us_to_timeval(long long us)
>  	return ret;
>  }
>  
> +/*
> + * Converts seconds to struct timespec
> + */
> +static inline struct timespec tst_sec_to_timespec(time_t seconds)
> +{
> +	struct timespec ret;
> +
> +	ret.tv_sec = seconds;
> +	ret.tv_nsec = 0;
> +
> +	return ret;
> +}

This should be probably part of the next patch.

>  /*
>   * Converts ms to struct timespec
>   */
> @@ -244,6 +277,8 @@ static inline long long tst_timespec_abs_diff_ms(struct timespec t1,
>   */
>  void tst_timer_check(clockid_t clk_id);
>  
> +void tst_timer_init_st(struct tst_timer *tim);

Can we pass the timeout to this function instead of expecting user to
fill in the structure?

>  *
>   * Marks a start time for given clock type.
>   *
> @@ -251,6 +286,14 @@ void tst_timer_check(clockid_t clk_id);
>   */
>  void tst_timer_start(clockid_t clk_id);
>  
> +/**
> + * Sets the start time for timer tim.
> + *
> + * @relates tst_timer
> + * @param tim The timer to start
> + */
> +void tst_timer_start_st(struct tst_timer *tim);
> +
>  /*
>   * Returns true if timer started by tst_timer_start() has been running for
>   * longer than ms seconds.
> @@ -259,6 +302,14 @@ void tst_timer_start(clockid_t clk_id);
>   */
>  int tst_timer_expired_ms(long long ms);
>  
> +/**
> + * Returns true if timer tim has been running for longer than tst_timer::limit
> + *
> + * @relates tst_timer
> + * @param tim The timer to check
> + */
> +int tst_timer_expired_st(struct tst_timer *tim);
> +
>  /*
>   * Marks timer end time.
>   */
> diff --git a/lib/tst_timer.c b/lib/tst_timer.c
> index dffaba0cb..bb73018c6 100644
> --- a/lib/tst_timer.c
> +++ b/lib/tst_timer.c
> @@ -61,6 +61,16 @@ void tst_timer_start(clockid_t clk_id)
>  		tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
>  }
>  
> +void tst_timer_start_st(struct tst_timer *tim)
> +{
> +	if (!tim->clock_id)
> +		tim->clock_id = TST_CLOCK_DEFAULT;
> +	tst_timer_check(tim->clock_id);
> +
> +	if (tst_clock_gettime(tim->clock_id, &tim->start_time))
> +		tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
> +}
> +
>  int tst_timer_expired_ms(long long ms)
>  {
>  	struct timespec cur_time;
> @@ -71,6 +81,17 @@ int tst_timer_expired_ms(long long ms)
>  	return tst_timespec_diff_ms(cur_time, start_time) >= ms;
>  }
>  
> +int tst_timer_expired_st(struct tst_timer *tim)
> +{
> +	struct timespec cur_time;
> +
> +	if (tst_clock_gettime(tim->clock_id, &cur_time))
> +		tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
> +
> +	return tst_timespec_lt(tim->limit,
> +			       tst_timespec_diff(cur_time, tim->start_time));
> +}

I guess that adding more tst_timer_expired_* variants will end up quite
confusing. Maybe we should just make one timer implementation where user
has to define the tst_timer structure in order to make things simpler.

And given that the timer is used only in a single test it should be easy
to change the API.

-- 
Cyril Hrubis
chrubis@suse.cz
