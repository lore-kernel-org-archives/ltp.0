From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 12 Sep 2017 16:41:37 +0200
Subject: [LTP] [PATCH v3 3/7] fzsync: Add long running thread support
 and deviation stats
In-Reply-To: <20170901130121.22821-3-rpalethorpe@suse.com>
References: <20170901130121.22821-1-rpalethorpe@suse.com>
 <20170901130121.22821-3-rpalethorpe@suse.com>
Message-ID: <20170912144137.GD29720@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +/**
> + * tst_fzsync_pair_info - Print some synchronisation statistics
> + */
>  static void tst_fzsync_pair_info(struct tst_fzsync_pair *pair)
>  {
> -	tst_res(TINFO, "avg_diff = %.5gns, delay = %05ld loops",
> -		pair->avg_diff, pair->delay);
> +	tst_res(TINFO,
> +		"avg_diff = %.0fns, avg_dev = %.0fns, delay = %05ld loops",
> +		pair->avg_diff, pair->avg_dev, pair->delay);
>  }
>  
>  /**
> @@ -133,18 +161,15 @@ static inline void tst_fzsync_time_b(struct tst_fzsync_pair *pair)
>  }
>  
>  /**
> - * tst_exp_moving_avg - Exponential moving average
> + * TST_EXP_MOVING_AVG - Exponential moving average
>   * @alpha: The preference for recent samples over old ones.
>   * @sample: The current sample
>   * @prev_avg: The average of the all the previous samples
>   *
>   * Returns average including the current sample.
>   */
> -static inline double tst_exp_moving_avg(double alpha, long sample,
> -					double prev_avg)
> -{
> -	return alpha * sample + (1.0 - alpha) * prev_avg;
> -}
> +#define TST_EXP_MOVING_AVG(alpha, sample, prev_avg)\
> +	(alpha * sample + (1.0 - alpha) * prev_avg)

Why do we define this as a macro instead of static inline function? As
far as I can tell the only difference is that we loose type checks and
introduce possible side effects.

>  /**
>   * tst_fzsync_pair_update - Recalculate the delay
> @@ -169,8 +194,16 @@ static void tst_fzsync_pair_update(int loop_index, struct tst_fzsync_pair *pair)
>  	double target = pair->avg_diff_trgt;
>  	double avg = pair->avg_diff;
>  
> +	if (pair->a.tv_sec > pair->b.tv_sec)
> +		pair->a.tv_nsec += 1000000000;
> +	else if (pair->a.tv_sec < pair->b.tv_sec)
> +		pair->b.tv_nsec += 1000000000;

Why the else here? These two cases are mutually exclusive.

>  	diff = pair->a.tv_nsec - pair->b.tv_nsec;
> -	avg = tst_exp_moving_avg(pair->avg_alpha, diff, avg);
> +	avg = TST_EXP_MOVING_AVG(pair->avg_alpha, diff, avg);
> +	pair->avg_dev = TST_EXP_MOVING_AVG(pair->avg_alpha,
> +					   fabs(diff - avg),
> +					   pair->avg_dev);
>  
>  	if (!(loop_index & pair->update_gap)) {
>  		if (avg > target)
> @@ -179,5 +212,87 @@ static void tst_fzsync_pair_update(int loop_index, struct tst_fzsync_pair *pair)
>  			pair->delay += inc;
>  	}
>  
> +	if (!(loop_index & pair->info_gap))
> +		tst_fzsync_pair_info(pair);
> +
>  	pair->avg_diff = avg;
>  }
> +
> +/**
> + * tst_fzsync_pair_wait - Wait for the other thread
> + * @our_cntr: The counter for the thread we are on
> + * @other_cntr: The counter for the thread we are synchronising with
> + *
> + * Use this (through tst_fzsync_pair_wait_a() and tst_fzsync_pair_wait_b()) if
> + * you need an additional synchronisation point in a thread or you do not want
> + * to use the delay facility (not recommended). See
> + * tst_fzsync_pair_wait_update().
> + *
> + * Returns a non-zero value if the thread should continue otherwise the
> + * calling thread should exit.
> + */
> +static inline int tst_fzsync_pair_wait(struct tst_fzsync_pair *pair,
> +				       int *our_cntr, int *other_cntr)
> +{
> +	tst_atomic_inc(other_cntr);
> +	while (tst_atomic_load(our_cntr) < tst_atomic_load(other_cntr)
> +	       && !tst_atomic_load(&pair->exit))
> +		;
> +
> +	return !tst_atomic_load(&pair->exit);
> +}
> +
> +static inline int tst_fzsync_wait_a(struct tst_fzsync_pair *pair)
> +{
> +	return tst_fzsync_pair_wait(pair, &pair->a_cntr, &pair->b_cntr);
> +}
> +
> +static inline int tst_fzsync_wait_b(struct tst_fzsync_pair *pair)
> +{
> +	return tst_fzsync_pair_wait(pair, &pair->b_cntr, &pair->a_cntr);
> +}
> +
> +/**
> + * tst_fzsync_pair_wait_update_{a,b} - Wait and then recalculate
> + *
> + * This allows you to have two long running threads which wait for each other
> + * every iteration. So each thread will exit this function at approximately
> + * the same time. It also updates the delay values in a thread safe manner.
> + *
> + * You must call this function in both threads the same number of times each
> + * iteration. So a call in one thread must match with a call in the
> + * other. Make sure that calls to tst_fzsync_pair_wait() and
> + * tst_fzsync_pair_wait_update() happen in the same order in each thread. That
> + * is, make sure that a call to tst_fzsync_pair_wait_update_a() in one thread
> + * corresponds to a call to tst_fzsync_pair_wait_update_b() in the other.
> + *
> + * Returns a non-zero value if the calling thread should continue to loop. If
> + * it returns zero then tst_fzsync_exit() has been called and you must exit
> + * the thread.
> + */
> +static inline int tst_fzsync_wait_update_a(struct tst_fzsync_pair *pair)
> +{
> +	static int loop_index;
> +
> +	tst_fzsync_pair_wait(pair, &pair->a_cntr, &pair->b_cntr);
> +	loop_index++;
> +	tst_fzsync_pair_update(loop_index, pair);
> +	return tst_fzsync_pair_wait(pair, &pair->a_cntr, &pair->b_cntr);
> +}
> +
> +static inline int tst_fzsync_wait_update_b(struct tst_fzsync_pair *pair)
> +{
> +	tst_fzsync_pair_wait(pair, &pair->b_cntr, &pair->a_cntr);
> +	return tst_fzsync_pair_wait(pair, &pair->b_cntr, &pair->a_cntr);
> +}
> +
> +/**
> + * tst_fzsync_pair_exit - Signal that the other thread should exit
> + *
> + * Causes tst_fzsync_pair_wait() and tst_fzsync_pair_wait_update() to return
> + * 0.
> + */
> +static inline void tst_fzsync_pair_exit(struct tst_fzsync_pair *pair)
> +{
> +	tst_atomic_store(1, &pair->exit);
> +}
> -- 
> 2.14.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
