From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 29 Aug 2018 10:45:38 +0200
Subject: [LTP] [PATCH 4/5] fzsync: Simplify API with start/end race
	calls and limit exec time
In-Reply-To: <20180828162409.GC26231@rei.lan>
References: <20180828093002.20368-1-rpalethorpe@suse.com>
 <20180828093002.20368-5-rpalethorpe@suse.com>
 <20180828162409.GC26231@rei.lan>
Message-ID: <87va7tsgr1.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> + * tst_fzsync_pair_reset(&pair, run_thread_b);
>> + * for (;;) {
>> + * 	// Perform some setup which must happen before the race
>> + * 	if (!tst_fzsync_start_race_a(&pair))
>> + * 		break;
>> + * 	// Do some dodgy syscall
>> + * 	tst_fzsync_end_race_a(&pair);
>> + * }
>> + *
>> + * Then in thread B (run_thread_b):
>> + *
>> + * while (tst_fzsync_start_race_b(&pair)) {
>> + * 	// Do something which can race with the dodgy syscall in A
>> + * 	if (!tst_fzsync_end_race_b(&pair))
>> + * 		break;
>> + * }
>
>
> Speaking of API maybe it would be cleaner to split the exit condition
> from the markers so that we can do something as:
>
>
> while (tst_fzsync_run(&pair)) {
> 	...
> 	tst_fzsync_begin_race_X(&pair);
> 	...
> 	tst_fzsync_end_race_X(&pair);
> 	...
> }
>
> Or is there a good reason why the loops are different between thread A
> and thread B?

I don't think so. Not anymore anyway. I will try using this idea, it
looks good.

We can hide the time and iteration limits in tst_fzsync_run.

>
>> + * The calls to tst_fzsync_start/end_race act as barriers which niether thread
>> + * will cross until the other has reached it. You can add more barriers by
>> + * using tst_fzsync_wait_a() and tst_fzsync_wait_b() in each thread.
>> + *
>> + * You may limit the loop in thread A to a certain number of loops or just
>> + * allow fzsync to timeout. This is 60 seconds by default, but you can change
>> + * it by setting tst_fzsync_pair::execution_time before calling
>> + * tst_fzsync_pair_reset().
>> + *
>> + * Generally speaking whatever loop or time limit you choose it will be wrong
>> + * on some subset of systems supported by Linux, but a best guess, based on
>> + * whatever systems you have access to, should suffice.
>> + *
>> + * It is possible to use the library just for tst_fzsync_pair_wait() to get a
>> + * basic spin wait. However if you are actually testing a race condition then
>> + * it is recommended to use tst_fzsync_start_race_a/b even if the
>> + * randomisation is not needed. It provides some semantic information which
>> + * may be useful in the future.
>>   *
>>   * For a usage example see testcases/cve/cve-2016-7117.c or just run
>>   * 'git grep tst_fuzzy_sync.h'
>> + *
>> + * @sa tst_fzsync_pair
>>   */
>>
>>  #include <sys/time.h>
>>  #include <time.h>
>>  #include <math.h>
>> +#include <stdlib.h>
>>  #include "tst_atomic.h"
>> +#include "tst_timer.h"
>> +#include "tst_safe_pthread.h"
>>
>> -#ifndef CLOCK_MONOTONIC_RAW
>> -# define CLOCK_MONOTONIC_RAW CLOCK_MONOTONIC
>> -#endif
>> +/** Some statistics for a variable */
>> +struct tst_fzsync_stat {
>> +	float avg;
>> +	float avg_dev;
>> +	float dev_ratio;
>> +};
>>
>>  /**
>> - * struct tst_fzsync_pair - the state of a two way synchronisation
>> - * @avg_diff: Internal; the average time difference over multiple iterations.
>> - * @avg_diff_trgt: The desired average time difference, defaults to 0.
>> - * @avg_alpha: The rate at which old diff samples are forgotten,
>> - *             defaults to 0.25.
>> - * @avg_dev: Internal; Absolute average deviation.
>> - * @a: Internal; The time at which call site A was last passed.
>> - * @b: Internal; The time at which call site B was last passed.
>> - * @delay: Internal; The size of the delay, positive to delay A,
>> - *         negative to delay B.
>> - * @delay_inc: The step size of a delay increment, defaults to 1.
>> - * @update_gap: The number of iterations between recalculating the delay.
>> - *              Defaults to 0xF and must be of the form $2^n - 1$
>> - * @info_gap: The number of iterations between printing some statistics.
>> - *            Defaults to 0x7FFFF and must also be one less than a power of 2.
>> - * @a_cntr: Internal; Atomic counter used by fzsync_pair_wait()
>> - * @b_cntr: Internal; Atomic counter used by fzsync_pair_wait()
>> - * @exit: Internal; Used by tst_fzsync_pair_exit() and fzsync_pair_wait()
>> - *
>> - * This contains all the necessary state for synchronising two points A and
>> - * B. Where A is the time of an event in one process and B is the time of an
>> - * event in another process.
>> + * The state of a two way synchronisation or race.
>> + *
>> + * This contains all the necessary state for approximately synchronising two
>> + * sections of code in different threads.
>>   *
>>   * Internal fields should only be accessed by library functions.
>>   */
>>  struct tst_fzsync_pair {
>> -	float avg_diff;
>> -	float avg_diff_trgt;
>> +	/**
>> +	 * The rate at which old diff samples are forgotten
>> +	 *
>> +	 * Defaults to 0.25.
>> +	 */
>>  	float avg_alpha;
>> -	float avg_dev;
>> -	struct timespec a;
>> -	struct timespec b;
>> -	long delay;
>> -	long delay_inc;
>> -	int update_gap;
>> -	int info_gap;
>> +	/** Internal; Thread A start time */
>> +	struct timespec a_start;
>> +	/** Internal; Thread B start time */
>> +	struct timespec b_start;
>> +	/** Internal; Thread A end time */
>> +	struct timespec a_end;
>> +	/** Internal; Thread B end time */
>> +	struct timespec b_end;
>> +	/** Internal; Avg. difference between a_start and b_start */
>> +	struct tst_fzsync_stat diff_ss;
>> +	/** Internal; Avg. difference between a_start and a_end */
>> +	struct tst_fzsync_stat diff_sa;
>> +	/** Internal; Avg. difference between b_start and b_end */
>> +	struct tst_fzsync_stat diff_sb;
>> +	/** Internal; Avg. difference between a_end and b_end */
>> +	struct tst_fzsync_stat diff_ab;
>> +	/** Internal; Number of spins while waiting for the slower thread */
>> +	int spins;
>> +	struct tst_fzsync_stat spins_avg;
>> +	/**
>> +	 * Internal; Number of spins to use in the delay.
>> +	 *
>> +	 * A negative value delays thread A and a positive delays thread B.
>> +	 */
>> +	int delay;
>> +	/**
>> +	 *  Internal; The number of samples left or the sampling state.
>> +	 *
>> +	 *  A positive value is the number of remaining mandatory
>> +	 *  samples. Zero or a negative indicate ssome other state.
>> +	 */
>> +	int sampling;
>> +	/**
>> +	 * The Minimum number of statistical samples which must be collected.
>> +	 *
>> +	 * The minimum number of iterations which must be performed before a
>> +	 * random delay can be calculated. Defaults to 1024.
>> +	 */
>> +	int min_samples;
>> +	/**
>> +	 * The maximum allowed proportional average deviation.
>> +	 *
>> +	 * A value in the range (0, 1) which gives the maximum average
>> +	 * deviation which must be attained before random delays can be
>> +	 * calculated.
>> +	 *
>> +	 * It is a ratio of (average_deviation / total_time). The default is
>> +	 * 0.1, so this allows an average deviation of at most 10%.
>> +	 */
>> +	float max_dev_ratio;
>> +        /** Internal; Atomic counter used by fzsync_pair_wait() */
>>  	int a_cntr;
>> +        /** Internal; Atomic counter used by fzsync_pair_wait() */
>>  	int b_cntr;
>> +	/** Internal; Used by tst_fzsync_pair_exit() and fzsync_pair_wait() */
>>  	int exit;
>> +	/** Internal; Used to limit the execution time. */
>> +	struct tst_timer timer;
>> +	/**
>> +	 * The maximum time, in seconds, the test loop should be run.
>> +	 *
>> +	 * If the test runs for this amount of time without crashing or
>> +	 * reaching some iteration limit, the wait and race functions will
>> +	 * return zero signalling that the test loop should end.
>> +	 *
>> +	 * Note that this value is multiplied by LTP_TIMEOUT_MUL.
>> +	 *
>> +	 * Defaults to 60 seconds.
>> +	 */
>> +	int execution_time;
>> +	/** Internal; The second thread or NULL */
>> +	pthread_t thread_b;
>>  };
>>
>>  /**
>> - * TST_FZSYNC_PAIR_INIT - Default values for struct tst_fzysnc_pair
>> + * Default static values for struct tst_fzysnc_pair
>>   */
>>  #define TST_FZSYNC_PAIR_INIT {	\
>>  	.avg_alpha = 0.25,	\
>> -	.delay_inc = 1,	        \
>> -	.update_gap = 0xF,	\
>> -	.info_gap = 0x7FFFF     \
>> +	.min_samples = 1024,	\
>> +	.max_dev_ratio = 0.1,	\
>> +	.execution_time = 60	\
>>  }
>>
>>  /**
>> - * tst_fzsync_pair_info - Print some synchronisation statistics
>> + * Indicate that all threads should exit
>> + *
>> + * @relates tst_fzsync_pair
>> + *
>> + * Causes tst_fzsync_pair_wait(), and any functions which use it, to return 0.
>>   */
>> -static void tst_fzsync_pair_info(struct tst_fzsync_pair *pair)
>> +static inline void tst_fzsync_pair_exit(struct tst_fzsync_pair *pair)
>>  {
>> -	tst_res(TINFO,
>> -		"avg_diff = %.0fns, avg_dev = %.0fns, delay = %05ld loops",
>> -		pair->avg_diff, pair->avg_dev, pair->delay);
>> +	tst_atomic_store(1, &pair->exit);
>>  }
>>
>>  /**
>> - * tst_fzsync_delay_a - Perform spin delay for A, if needed
>> + * Exit and join thread B if necessary.
>> + *
>> + * @relates tst_fzsync_pair
>>   *
>> - * Usually called just before the point you want to synchronise.
>> + * Call this from your cleanup function.
>>   */
>> -static inline void tst_fzsync_delay_a(struct tst_fzsync_pair *pair)
>> +static void tst_fzsync_pair_cleanup(struct tst_fzsync_pair *pair)
>>  {
>> -	volatile long spin_delay = pair->delay;
>> -
>> -	while (spin_delay > 0)
>> -		spin_delay--;
>> +	if (pair->thread_b) {
>> +		tst_fzsync_pair_exit(pair);
>> +		SAFE_PTHREAD_JOIN(pair->thread_b, 0);
>> +		pair->thread_b = 0;
>> +	}
>>  }
>>
>>  /**
>> - * tst_fzsync_delay_b - Perform spin delay for B, if needed
>> + * Zero some stat fields
>>   *
>> - * Usually called just before the point you want to synchronise.
>> + * @relates tst_fzsync_stat
>>   */
>> -static inline void tst_fzsync_delay_b(struct tst_fzsync_pair *pair)
>> +static void tst_init_stat(struct tst_fzsync_stat *s)
>>  {
>> -	volatile long spin_delay = pair->delay;
>> -
>> -	while (spin_delay < 0)
>> -		spin_delay++;
>> +	s->avg = 0;
>> +	s->avg_dev = 0;
>>  }
>>
>> -static inline void tst_fzsync_time(struct timespec *t)
>> +/**
>> + * Reset or initialise fzsync.
>> + *
>> + * @relates tst_fzsync_pair
>> + * @param pair The state structure initialised with TST_FZSYNC_PAIR_INIT.
>> + * @param run_b The function defining thread B or NULL.
>> + *
>> + * Call this from your main test function (thread A), just before entering the
>> + * main loop. It will setup any values needed by fzsync and (re)start thread B
>> + * using the function provided.
>> + *
>> + * If you need to use fork or clone to start the second thread/process then
>> + * you can pass NULL to run_b and handle starting and stopping thread B
>> + * yourself. You may need to place tst_fzsync_pair in some shared memory as
>> + * well.
>> + */
>> +static void tst_fzsync_pair_reset(struct tst_fzsync_pair *pair,
>> +				  void *(*run_b)(void *))
>>  {
>> -	clock_gettime(CLOCK_MONOTONIC_RAW, t);
>> +	tst_fzsync_pair_cleanup(pair);
>> +
>> +	tst_init_stat(&pair->diff_ss);
>> +	tst_init_stat(&pair->diff_sa);
>> +	tst_init_stat(&pair->diff_sb);
>> +	tst_init_stat(&pair->diff_ab);
>> +	tst_init_stat(&pair->spins_avg);
>> +	pair->delay = 0;
>
> If yuo init the pair with TST_FZSYNC_PAIR_INIT these fields are already
> zeroed...

Not if the user uses the -i argument.

>
>> +	pair->sampling = pair->min_samples;
>> +
>> +	pair->timer.limit =
>> +		tst_sec_to_timespec(pair->execution_time * tst_timeout_mul());
>
> Hmm, why can't we have the limit in seconds? We do convert it to
> timespec here, then convert it again in the timer library.

I'm using the new timer API I invented which just uses timespec
structs.

>
> Also maybe it would be cleaner to have tst_timeout_scale() function that
> would return the timeout multiplied, that way we would keep the timeout
> logic in the tst_test library.

Yeah.

>
>> +	pair->a_cntr = 0;
>> +	pair->b_cntr = 0;
>> +	tst_atomic_store(0, &pair->exit);
>
> This as well has been initialized by 0 already.
>
>> +	if (run_b)
>> +		SAFE_PTHREAD_CREATE(&pair->thread_b, 0, run_b, 0);
>> +
>> +	tst_timer_start_st(&pair->timer);
>>  }
>>
>>  /**
>> - * tst_fzsync_time_a - Set A's time to now.
>> + * Print stat
>>   *
>> - * Called at the point you want to synchronise.
>> + * @relates tst_fzsync_stat
>>   */
>> -static inline void tst_fzsync_time_a(struct tst_fzsync_pair *pair)
>> +static inline void tst_fzsync_stat_info(struct tst_fzsync_stat stat,
>> +					char *unit, char *name)
>>  {
>> -	tst_fzsync_time(&pair->a);
>> +	tst_res(TINFO,
>> +		"%1$-17s: { avg = %3$5.0f%2$s, avg_dev = %4$5.0f%2$s, dev_ratio = %5$.2f }",
>> +		name, unit, stat.avg, stat.avg_dev, stat.dev_ratio);
>>  }
>>
>>  /**
>> - * tst_fzsync_time_b - Set B's call time to now.
>> + * Print some synchronisation statistics
>>   *
>> - * Called at the point you want to synchronise.
>> + * @relates tst_fzsync_pair
>>   */
>> -static inline void tst_fzsync_time_b(struct tst_fzsync_pair *pair)
>> +static void tst_fzsync_pair_info(struct tst_fzsync_pair *pair, int loop_index)
>>  {
>> -	tst_fzsync_time(&pair->b);
>> +	tst_res(TINFO, "loop = %d", loop_index);
>> +	tst_fzsync_stat_info(pair->diff_ss, "ns", "start_a - start_b");
>> +	tst_fzsync_stat_info(pair->diff_sa, "ns", "end_a - start_a");
>> +	tst_fzsync_stat_info(pair->diff_sb, "ns", "end_b - start_b");
>> +	tst_fzsync_stat_info(pair->diff_ab, "ns", "end_a - end_b");
>> +	tst_fzsync_stat_info(pair->spins_avg, "  ", "spins");
>> +}
>> +
>> +/** Wraps clock_gettime */
>> +static inline void tst_fzsync_time(struct timespec *t)
>> +{
>> +	clock_gettime(CLOCK_MONOTONIC_RAW, t);
>>  }
>>
>>  /**
>> - * tst_exp_moving_avg - Exponential moving average
>> - * @alpha: The preference for recent samples over old ones.
>> - * @sample: The current sample
>> - * @prev_avg: The average of the all the previous samples
>> + * Exponential moving average
>> + *
>> + * @param alpha The preference for recent samples over old ones.
>> + * @param sample The current sample
>> + * @param prev_avg The average of the all the previous samples
>>   *
>> - * Returns average including the current sample.
>> + * @return The average including the current sample.
>>   */
>>  static inline float tst_exp_moving_avg(float alpha,
>>  					float sample,
>> @@ -176,63 +319,160 @@ static inline float tst_exp_moving_avg(float alpha,
>>  }
>>
>>  /**
>> - * tst_fzsync_pair_update - Recalculate the delay
>> - * @loop_index: The i in "for(i = 0;..." or zero to ignore update_gap
>> - * @pair: The state necessary for calculating the delay
>> - *
>> - * This should be called at the end of each loop to update the average
>> - * measured time difference (between A and B) and update the delay. It is
>> - * assumed that A and B are less than a second apart.
>> - *
>> - * The values of update_gap, avg_alpha and delay_inc decide the speed at which
>> - * the algorithm approaches the optimum delay value and whether it is
>> - * stable. If your test is behaving strangely, it could be because this
>> - * algorithm is behaving chaotically and flip-flopping between large positve
>> - * and negative delay values. You can call tst_fzysync_pair_info every few
>> - * loops to check whether the average difference and delay values are stable.
>> + * Update a stat with a new sample
>> + *
>> + * @relates tst_fzsync_stat
>> + */
>> +static inline void tst_upd_stat(struct tst_fzsync_stat *s,
>> +				 float alpha,
>> +				 float sample)
>> +{
>> +	s->avg = tst_exp_moving_avg(alpha, sample, s->avg);
>> +	s->avg_dev = tst_exp_moving_avg(alpha, fabs(s->avg - sample), s->avg_dev);
>> +	s->dev_ratio = fabs(s->avg ? s->avg_dev / s->avg : 0);
>> +}
>> +
>> +/**
>> + * Update a stat with a new diff sample
>> + *
>> + * @relates tst_fzsync_stat
>> + */
>> +static inline void tst_upd_diff_stat(struct tst_fzsync_stat *s,
>> +				     float alpha,
>> +				     struct timespec t1,
>> +				     struct timespec t2)
>> +{
>> +	tst_upd_stat(s, alpha, tst_timespec_diff_ns(t1, t2));
>> +}
>> +
>> +/**
>> + * Calculate various statistics and the delay
>> + *
>> + * This function helps create the fuzz in fuzzy sync. Imagine we have the
>> + * following timelines in threads A and B:
>> + *
>> + *  start_race_a
>> + *      ^                    end_race_a (a)
>> + *      |                        ^
>> + *      |                        |
>> + *  - --+------------------------+-- - -
>> + *      |        Syscall A       |                 Thread A
>> + *  - --+------------------------+-- - -
>> + *  - --+----------------+-------+-- - -
>> + *      |   Syscall B    | spin  |                 Thread B
>> + *  - --+----------------+-------+-- - -
>> + *      |                |
>> + *      ^                ^
>> + *  start_race_b     end_race_b
>> + *
>> + * Here we have synchronised the calls to syscall A and B with start_race_{a,
>> + * b} so that they happen at approximately the same time in threads A and
>> + * B. If the race condition occurs during the entry code for these two
>> + * functions then we will quickly hit it. If it occurs during the exit code of
>> + * B and mid way through A, then we will quickly hit it.
>> + *
>> + * However if the exit paths of A and B need to be aligned and (end_race_a -
>> + * end_race_b) is large relative to the variation in call times, the
>> + * probability of hitting the race condition is close to zero. To solve this
>> + * scenario (and others) a randomised delay is introduced before the syscalls
>> + * in A and B. Given enough time the following should happen where the exit
>> + * paths are now synchronised:
>> + *
>> + *  start_race_a
>> + *      ^                    end_race_a (a)
>> + *      |                        ^
>> + *      |                        |
>> + *  - --+------------------------+-- - -
>> + *      |        Syscall A       |                 Thread A
>> + *  - --+------------------------+-- - -
>> + *  - --+-------+----------------+-- - -
>> + *      | delay |   Syscall B    |                 Thread B
>> + *  - --+-------+----------------+-- - -
>> + *      |                        |
>> + *      ^                        ^
>> + *  start_race_b             end_race_b
>> + *
>> + * The delay is not introduced immediately and the delay range is only
>> + * calculated once the average relative deviation has dropped below some
>> + * percentage of the total time.
>> + *
>> + * The delay range is choosen so that any point in Syscall A could be
>> + * synchronised with any point in Syscall B using a value from the
>> + * range. Because the delay range may be too large for a linear search, we use
>> + * an evenly distributed random function to pick a value from it.
>> + *
>> + * @relates tst_fzsync_pair
>>   */
>>  static void tst_fzsync_pair_update(int loop_index, struct tst_fzsync_pair *pair)
>>  {
>> -	long diff;
>> -	long inc = pair->delay_inc;
>> -	float target = pair->avg_diff_trgt;
>> -	float avg = pair->avg_diff;
>> -
>> -	diff = pair->a.tv_nsec - pair->b.tv_nsec
>> -		+ 1000000000 * (pair->a.tv_sec - pair->b.tv_sec);
>> -	avg = tst_exp_moving_avg(pair->avg_alpha, diff, avg);
>> -	pair->avg_dev = tst_exp_moving_avg(pair->avg_alpha,
>> -					   fabs(diff - avg),
>> -					   pair->avg_dev);
>> -
>> -	if (!(loop_index & pair->update_gap)) {
>> -		if (avg > target)
>> -			pair->delay -= inc;
>> -		else if (avg < target)
>> -			pair->delay += inc;
>> -	}
>> +	float alpha = pair->avg_alpha;
>> +	float per_spin_time, time_delay, dev_ratio;
>> +
>> +	dev_ratio = (pair->diff_sa.dev_ratio
>> +		     + pair->diff_sb.dev_ratio
>> +		     + pair->diff_ab.dev_ratio
>> +		     + pair->spins_avg.dev_ratio) / 4;
>> +
>> +	if (pair->sampling > 0 || dev_ratio > pair->max_dev_ratio) {
>> +		tst_upd_diff_stat(&pair->diff_ss, alpha,
>> +				  pair->a_start, pair->b_start);
>> +		tst_upd_diff_stat(&pair->diff_sa, alpha,
>> +				  pair->a_end, pair->a_start);
>> +		tst_upd_diff_stat(&pair->diff_sb, alpha,
>> +				  pair->b_end, pair->b_start);
>> +		tst_upd_diff_stat(&pair->diff_ab, alpha,
>> +				  pair->a_end, pair->b_end);
>> +		tst_upd_stat(&pair->spins_avg, alpha, pair->spins);
>> +		if (pair->sampling > 0 && --pair->sampling == 0) {
>> +			tst_res(TINFO,
>> +				"Minimum sampling period ended, deviation ratio = %.2f",
>> +				dev_ratio);
>> +			tst_fzsync_pair_info(pair, loop_index);
>> +		}
>
> So we do collect the statistic here to be used later, and we end either
> when deviation is small enough or we reached minimal number of spins?

The sampling period ends when both the minimum number of spins have been
reached and the average deviation is small.

>
> The max_dev_ratio is supposed to be set by the testcase then? I would
> like to avoid having magic constants if possible...

Well, it can be, but I think most, if not all, tests can (and should)
use the default deviation ratio. We may need to change the default,
maybe on a per platform basis, but we need more data.

>
>> +	} else if (pair->diff_ab.avg >= 1 && pair->spins_avg.avg >= 1) {
>> +		per_spin_time = fabs(pair->diff_ab.avg) / pair->spins_avg.avg;
>> +		time_delay = drand48() * (pair->diff_sa.avg + pair->diff_sb.avg)
>> +			- pair->diff_sb.avg;
>
> Uff, it took me a while to figure this out but it seems correct to me,
> given that we do
>
> race_start_a:
>
> 	while (delay < 0)
> 		delay++;
>
> race_start_b:
>
> 	while (delay > 0)
> 		delay--;
>
> This means that the range for random delay we need is [-B, A]
>
> So maybe you should explain the implementation a little bit in the
> comment above. It's nice that it explains the general idea but maybe we
> need hints to understand the implementation as well.

Yeah sorry, I actually figured it out in mathematical notation on paper
and should have tried to clean it up and rewrite it in the doc
comment. Or possibly I should write it inline like I did for the wait
function.

>
>> +		pair->delay = (int)(time_delay / per_spin_time);
>
> Also we can probably use return here to avoid the excessive else if branches.
>
>
> Generally this looks great, maybe needs a little more explanations, but
> it surely looks like a step into the right direction to me.

Thanks!

--
Thank you,
Richard.
