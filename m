From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 3 Oct 2018 14:57:44 +0200
Subject: [LTP] [PATCH v2 2/4] fzsync: Simplify API with start/end race
 calls and limit exec time
In-Reply-To: <20180910084442.17720-3-rpalethorpe@suse.com>
References: <20180910084442.17720-1-rpalethorpe@suse.com>
 <20180910084442.17720-3-rpalethorpe@suse.com>
Message-ID: <20181003125744.GA19635@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#define CHK(param, low, hi, def) do {					      \
> +	pair->param = (pair->param ? pair->param : def);		      \
> +	if (pair->param <= low)						      \
> +		tst_brk(TBROK, #param " is less than the lower bound " #low); \
> +	if (pair->param >= hi)						      \
> +		tst_brk(TBROK, #param " is more than the upper bound " #hi);  \
> +	} while (0)

I would kind of expect that given parameter can be set to both low and
hi as well. I guess that it may make sense to exclude the bounds for the
two ratios, from a mathematical point of view, but not so much for
floating point I would say.

>  /**
> - * TST_FZSYNC_PAIR_INIT - Default values for struct tst_fzysnc_pair
> + * Ensures that any Fuzzy Sync parameters are properly set
> + *
> + * @relates tst_fzsync_pair
> + *
> + * Usually called from the setup function, it sets default parameter values or
> + * validates any existing non-defaults.
> + *
> + * @sa tst_fzsync_pair_reset()
>   */
> -#define TST_FZSYNC_PAIR_INIT {	\
> -	.avg_alpha = 0.25,	\
> -	.delay_inc = 1,	        \
> -	.update_gap = 0xF,	\
> -	.info_gap = 0x7FFFF     \
> +static void tst_fzsync_pair_init(struct tst_fzsync_pair *pair)
> +{
> +	CHK(avg_alpha, 0, 1, 0.25);
> +	CHK(min_samples, 20, INT_MAX, 1024);
> +	CHK(max_dev_ratio, 0, 1, 0.1);
> +	CHK(exec_time_p, 0, 1, 0.2);
> +	CHK(exec_loops, 20, INT_MAX, 1000000);
>  }
> +#undef CHK
>  
>  /**
> - * tst_fzsync_pair_info - Print some synchronisation statistics
> + * Exit and join thread B if necessary.
> + *
> + * @relates tst_fzsync_pair
> + *
> + * Call this from your cleanup function.
>   */
> -static void tst_fzsync_pair_info(struct tst_fzsync_pair *pair)
> +static void tst_fzsync_pair_cleanup(struct tst_fzsync_pair *pair)
>  {
> -	tst_res(TINFO,
> -		"avg_diff = %.0fns, avg_dev = %.0fns, delay = %05ld loops",
> -		pair->avg_diff, pair->avg_dev, pair->delay);
> +	if (pair->thread_b) {
> +		tst_atomic_store(1, &pair->exit);
> +		SAFE_PTHREAD_JOIN(pair->thread_b, 0);
                                                  ^
						  This should be NULL
> +		pair->thread_b = 0;
> +	}
>  }
>  
>  /**
> - * tst_fzsync_delay_a - Perform spin delay for A, if needed
> + * Zero some stat fields
>   *
> - * Usually called just before the point you want to synchronise.
> + * @relates tst_fzsync_stat
>   */
> -static inline void tst_fzsync_delay_a(struct tst_fzsync_pair *pair)
> +static void tst_init_stat(struct tst_fzsync_stat *s)
>  {
> -	volatile long spin_delay = pair->delay;
> +	s->avg = 0;
> +	s->avg_dev = 0;
> +}
>  
> -	while (spin_delay > 0)
> -		spin_delay--;
> +/**
> + * Reset or initialise fzsync.
> + *
> + * @relates tst_fzsync_pair
> + * @param pair The state structure initialised with TST_FZSYNC_PAIR_INIT.
> + * @param run_b The function defining thread B or NULL.
> + *
> + * Call this from your main test function (thread A), just before entering the
> + * main loop. It will (re)set any variables needed by fzsync and (re)start
> + * thread B using the function provided.
> + *
> + * If you need to use fork or clone to start the second thread/process then
> + * you can pass NULL to run_b and handle starting and stopping thread B
> + * yourself. You may need to place tst_fzsync_pair in some shared memory as
> + * well.
> + *
> + * @sa tst_fzsync_pair_init()
> + */
> +static void tst_fzsync_pair_reset(struct tst_fzsync_pair *pair,
> +				  void *(*run_b)(void *))
> +{
> +	tst_fzsync_pair_cleanup(pair);
> +
> +	tst_init_stat(&pair->diff_ss);
> +	tst_init_stat(&pair->diff_sa);
> +	tst_init_stat(&pair->diff_sb);
> +	tst_init_stat(&pair->diff_ab);
> +	tst_init_stat(&pair->spins_avg);
> +	pair->delay = 0;
> +	pair->sampling = pair->min_samples;
> +
> +	pair->exec_loop = 0;
> +
> +	pair->a_cntr = 0;
> +	pair->b_cntr = 0;
> +	tst_atomic_store(0, &pair->exit);

Do we have to use atomic store here? Aren't we running in a single
thread at this point?

> +	if (run_b)
> +		SAFE_PTHREAD_CREATE(&pair->thread_b, 0, run_b, 0);
> +
> +	pair->exec_time_start = (float)tst_timeout_remaining();
>  }
>  
>  /**
> - * tst_fzsync_delay_b - Perform spin delay for B, if needed
> + * Print stat
>   *
> - * Usually called just before the point you want to synchronise.
> + * @relates tst_fzsync_stat
>   */
> -static inline void tst_fzsync_delay_b(struct tst_fzsync_pair *pair)
> +static inline void tst_fzsync_stat_info(struct tst_fzsync_stat stat,
> +					char *unit, char *name)
>  {
> -	volatile long spin_delay = pair->delay;
> +	tst_res(TINFO,
> +		"%1$-17s: { avg = %3$5.0f%2$s, avg_dev = %4$5.0f%2$s, dev_ratio = %5$.2f }",
> +		name, unit, stat.avg, stat.avg_dev, stat.dev_ratio);
> +}
>  
> -	while (spin_delay < 0)
> -		spin_delay++;
> +/**
> + * Print some synchronisation statistics
> + *
> + * @relates tst_fzsync_pair
> + */
> +static void tst_fzsync_pair_info(struct tst_fzsync_pair *pair)
> +{
> +	tst_res(TINFO, "loop = %d", pair->exec_loop);
> +	tst_fzsync_stat_info(pair->diff_ss, "ns", "start_a - start_b");
> +	tst_fzsync_stat_info(pair->diff_sa, "ns", "end_a - start_a");
> +	tst_fzsync_stat_info(pair->diff_sb, "ns", "end_b - start_b");
> +	tst_fzsync_stat_info(pair->diff_ab, "ns", "end_a - end_b");
> +	tst_fzsync_stat_info(pair->spins_avg, "  ", "spins");
>  }
>  
> +/** Wraps clock_gettime */
>  static inline void tst_fzsync_time(struct timespec *t)
>  {
> +#ifdef CLOCK_MONOTONIC_RAW
>  	clock_gettime(CLOCK_MONOTONIC_RAW, t);
> +#else
> +	clock_gettime(CLOCK_MONOTONIC, t);
> +#endif
>  }
>  
>  /**
> - * tst_fzsync_time_a - Set A's time to now.
> + * Exponential moving average
>   *
> - * Called at the point you want to synchronise.
> + * @param alpha The preference for recent samples over old ones.
> + * @param sample The current sample
> + * @param prev_avg The average of the all the previous samples
> + *
> + * @return The average including the current sample.
>   */
> -static inline void tst_fzsync_time_a(struct tst_fzsync_pair *pair)
> +static inline float tst_exp_moving_avg(float alpha,
> +					float sample,
> +					float prev_avg)
>  {
> -	tst_fzsync_time(&pair->a);
> +	return alpha * sample + (1.0 - alpha) * prev_avg;
>  }
>  
>  /**
> - * tst_fzsync_time_b - Set B's call time to now.
> + * Update a stat with a new sample
>   *
> - * Called at the point you want to synchronise.
> + * @relates tst_fzsync_stat
>   */
> -static inline void tst_fzsync_time_b(struct tst_fzsync_pair *pair)
> +static inline void tst_upd_stat(struct tst_fzsync_stat *s,
> +				 float alpha,
> +				 float sample)
>  {
> -	tst_fzsync_time(&pair->b);
> +	s->avg = tst_exp_moving_avg(alpha, sample, s->avg);
> +	s->avg_dev = tst_exp_moving_avg(alpha,
> +					5fabs(s->avg - sample), s->avg_dev);
> +	s->dev_ratio = fabs(s->avg ? s->avg_dev / s->avg : 0);
>  }
>  
>  /**
> - * tst_exp_moving_avg - Exponential moving average
> - * @alpha: The preference for recent samples over old ones.
> - * @sample: The current sample
> - * @prev_avg: The average of the all the previous samples
> + * Update a stat with a new diff sample
>   *
> - * Returns average including the current sample.
> + * @relates tst_fzsync_stat
>   */
> -static inline float tst_exp_moving_avg(float alpha,
> -					float sample,
> -					float prev_avg)
> +static inline void tst_upd_diff_stat(struct tst_fzsync_stat *s,
> +				     float alpha,
> +				     struct timespec t1,
> +				     struct timespec t2)
>  {
> -	return alpha * sample + (1.0 - alpha) * prev_avg;
> +	tst_upd_stat(s, alpha, tst_timespec_diff_ns(t1, t2));
>  }
>  
>  /**
> - * tst_fzsync_pair_update - Recalculate the delay
> - * @loop_index: The i in "for(i = 0;..." or zero to ignore update_gap
> - * @pair: The state necessary for calculating the delay
> - *
> - * This should be called at the end of each loop to update the average
> - * measured time difference (between A and B) and update the delay. It is
> - * assumed that A and B are less than a second apart.
> - *
> - * The values of update_gap, avg_alpha and delay_inc decide the speed at which
> - * the algorithm approaches the optimum delay value and whether it is
> - * stable. If your test is behaving strangely, it could be because this
> - * algorithm is behaving chaotically and flip-flopping between large positve
> - * and negative delay values. You can call tst_fzysync_pair_info every few
> - * loops to check whether the average difference and delay values are stable.
> + * Calculate various statistics and the delay
> + *
> + * This function helps create the fuzz in fuzzy sync. Imagine we have the
> + * following timelines in threads A and B:
> + *
> + *  start_race_a
> + *      ^                    end_race_a (a)
> + *      |                        ^
> + *      |                        |
> + *  - --+------------------------+-- - -
> + *      |        Syscall A       |                 Thread A
> + *  - --+------------------------+-- - -
> + *  - --+----------------+-------+-- - -
> + *      |   Syscall B    | spin  |                 Thread B
> + *  - --+----------------+-------+-- - -
> + *      |                |
> + *      ^                ^
> + *  start_race_b     end_race_b
> + *
> + * Here we have synchronised the calls to syscall A and B with start_race_{a,
> + * b} so that they happen at approximately the same time in threads A and
> + * B. If the race condition occurs during the entry code for these two
> + * functions then we will quickly hit it. If it occurs during the exit code of
> + * B and mid way through A, then we will quickly hit it.
> + *
> + * However if the exit paths of A and B need to be aligned and (end_race_a -
> + * end_race_b) is large relative to the variation in call times, the
> + * probability of hitting the race condition is close to zero. To solve this
> + * scenario (and others) a randomised delay is introduced before the syscalls
> + * in A and B. Given enough time the following should happen where the exit
> + * paths are now synchronised:
> + *
> + *  start_race_a
> + *      ^                    end_race_a (a)
> + *      |                        ^
> + *      |                        |
> + *  - --+------------------------+-- - -
> + *      |        Syscall A       |                 Thread A
> + *  - --+------------------------+-- - -
> + *  - --+-------+----------------+-- - -
> + *      | delay |   Syscall B    |                 Thread B
> + *  - --+-------+----------------+-- - -
> + *      |                        |
> + *      ^                        ^
> + *  start_race_b             end_race_b
> + *
> + * The delay is not introduced immediately and the delay range is only
> + * calculated once the average relative deviation has dropped below some
> + * percentage of the total time.
> + *
> + * The delay range is choosen so that any point in Syscall A could be
> + * synchronised with any point in Syscall B using a value from the
> + * range. Because the delay range may be too large for a linear search, we use
> + * an evenly distributed random function to pick a value from it.
> + *
> + * The delay range goes from positive to negative. A negative delay will delay
> + * thread A and and positive one will delay thread B. The range is bounded by
> + * the point where the entry code to Syscall A is synchronised with the exit
> + * to Syscall B and the entry code to Syscall B is synchronised with the exit
> + * of A.
> + *
> + * In order to calculate the lower bound (the max delay of A) we can simply
> + * negate the execution time of Syscall B and convert it to a spin count. For
> + * the upper bound (the max delay of B), we just take the execution time of A
> + * and convert it to a spin count.
> + *
> + * In order to calculate spin count we need to know approximately how long a
> + * spin takes and devide the delay time with it. We find this by first
                     ^
		     divide?
> + * counting how many spins one thread spends waiting for the other during
> + * end_race[1]. We also know when each syscall exits so we can take the
> + * difference between the exit times and divde it with the number of spins
                                            ^
					    divide?
> + * spent waiting.
> + *
> + * All the times and counts we use in the calculation are averaged over a
> + * variable number of iterations. There is an initial sampling period where we
> + * simply collect time and count samples then caculate their averages. When a
> + * minimum number of samples have been collected, and if the average deviation
> + * is below some proportion of the average sample magnitude, then the sampling
> + * period is ended. On all further iterations a random delay is calculated and
> + * applied, but the averages are not updated.
> + *
> + * [1] This assumes there is always a significant difference. The algorithm
> + * may fail to introduce a delay (when one is needed) in situations where
> + * Syscall A and B finish at approximately the same time.
> + *
> + * @relates tst_fzsync_pair
>   */

Other than the typos pointed out and minor things this version looks
good to me.

I will try it on an old arm board that has no hadrware timers, i.e. the
clock_gettime() is backed only by jiffies to see how that will behave
and let you know later on.

-- 
Cyril Hrubis
chrubis@suse.cz
