From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 10 Sep 2018 10:44:40 +0200
Subject: [LTP] [PATCH v2 2/4] fzsync: Simplify API with start/end race calls
	and limit exec time
In-Reply-To: <20180910084442.17720-1-rpalethorpe@suse.com>
References: <20180910084442.17720-1-rpalethorpe@suse.com>
Message-ID: <20180910084442.17720-3-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Make it so the test writer simply has to mark the beginning and end of a race
in each thread. Previously they must choose where to call a delay and where to
call a timestamp function which is used to calculate the delay as well as the
update function.

Along with the new API a randomised delay has been introduced which helps hit
some race conditions (see doc comments).

Also use the tst_timer library to check how long the main test loop has been
running for and break the loop if it exceeds (60 * LTP_TIMEOUT_MUL)
seconds. This prevents an overall test timeout which is reported as a failure.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_fuzzy_sync.h | 732 +++++++++++++++++++++++++++++----------
 1 file changed, 555 insertions(+), 177 deletions(-)

diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index bcc625e24..e38a23fa1 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
  *
@@ -14,225 +15,513 @@
  * You should have received a copy of the GNU General Public License
  * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
-/*
+/**
+ * @file tst_fuzzy_sync.h
  * Fuzzy Synchronisation - abreviated to fzsync
  *
- * This library is intended to help reproduce race conditions by providing two
- * thread synchronisation mechanisms. The first is a 'checkpoint' system where
- * each thread will wait indefinitely for the other to enter a checkpoint
- * before continuing. This is acheived by calling tst_fzsync_wait() and/or
- * tst_fzsync_wait_update() at the points you want to synchronise in each
- * thread. This is functionally very similar to using pthread_barrier_wait()
- * with two threads. However tst_fzsync_wait() can be inlined and is
- * guaranteed not to call sleep or futex.
- *
- * The second takes the form a of a delay which is calculated by measuring the
- * time difference between two points in each thread and comparing it to the
- * desired difference (default is zero). Using a delay allows you to
- * synchronise the threads at a point outside of your direct control
- * (e.g. inside the kernel) or just increase the accuracy for the first
- * mechanism. It is acheived using tst_fzsync_delay_{a,b}(),
- * tst_fzsync_time_{a,b}() and tst_fzsync[_wait_]update().
+ * This library is intended to help reproduce race conditions by synchronising
+ * two threads at a given place by marking the range a race may occur
+ * in. Because the exact place where any race occurs is whithin the kernel,
+ * and therefor impossible to mark accurately, the library may add randomised
+ * delays to either thread in order to help find the exact race timing.
+ *
+ * Currently only two way races are explicitly supported, that is races
+ * involving two threads or processes. We refer to the main test thread as
+ * thread A and the child thread as thread B.
+ *
+ * In each thread you need a simple while- or for-loop which the tst_fzsync_*
+ * functions are called in. In the simplest case thread A will look something
+ * like:
+ *
+ * tst_fzsync_pair_reset(&pair, run_thread_b);
+ * while (tst_fzsync_run_a(&pair)) {
+ *	// Perform some setup which must happen before the race
+ *	tst_fzsync_start_race_a(&pair);
+ *	// Do some dodgy syscall
+ *	tst_fzsync_end_race_a(&pair);
+ * }
+ *
+ * Then in thread B (run_thread_b):
+ *
+ * while (tst_fzsync_run_b(&pair)) {
+ *	tst_fzsync_start_race_b(&pair);
+ *	// Do something which can race with the dodgy syscall in A
+ *	tst_fzsync_end_race_b(&pair)
+ * }
+ *
+ * The calls to tst_fzsync_start/end_race and tst_fzsync_run_a/b block (at
+ * least) until both threads have enter them. These functions can only be
+ * called once for each iteration, but further sychronisation points can be
+ * added by calling tst_fzsync_wait_a() and tst_fzsync_wait_b() in each
+ * thread.
+ *
+ * The execution of the loops in threads A and B are bounded by both iteration
+ * count and time. A slow machine is likely to be limited by time and a fast
+ * one by iteration count. The user can use the -i parameter to run the test
+ * multiple times or LTP_TIMEOUT_MUL to give the test more time.
+ *
+ * It is possible to use the library just for tst_fzsync_pair_wait() to get a
+ * basic spin wait. However if you are actually testing a race condition then
+ * it is recommended to use tst_fzsync_start_race_a/b even if the
+ * randomisation is not needed. It provides some semantic information which
+ * may be useful in the future.
  *
  * For a usage example see testcases/cve/cve-2016-7117.c or just run
  * 'git grep tst_fuzzy_sync.h'
+ *
+ * @sa tst_fzsync_pair
  */
 
 #include <sys/time.h>
 #include <time.h>
 #include <math.h>
+#include <stdlib.h>
 #include "tst_atomic.h"
+#include "tst_timer.h"
+#include "tst_safe_pthread.h"
 
-#ifndef CLOCK_MONOTONIC_RAW
-# define CLOCK_MONOTONIC_RAW CLOCK_MONOTONIC
-#endif
+/** Some statistics for a variable */
+struct tst_fzsync_stat {
+	float avg;
+	float avg_dev;
+	float dev_ratio;
+};
 
 /**
- * struct tst_fzsync_pair - the state of a two way synchronisation
- * @avg_diff: Internal; the average time difference over multiple iterations.
- * @avg_diff_trgt: The desired average time difference, defaults to 0.
- * @avg_alpha: The rate at which old diff samples are forgotten,
- *             defaults to 0.25.
- * @avg_dev: Internal; Absolute average deviation.
- * @a: Internal; The time at which call site A was last passed.
- * @b: Internal; The time at which call site B was last passed.
- * @delay: Internal; The size of the delay, positive to delay A,
- *         negative to delay B.
- * @delay_inc: The step size of a delay increment, defaults to 1.
- * @update_gap: The number of iterations between recalculating the delay.
- *              Defaults to 0xF and must be of the form $2^n - 1$
- * @info_gap: The number of iterations between printing some statistics.
- *            Defaults to 0x7FFFF and must also be one less than a power of 2.
- * @a_cntr: Internal; Atomic counter used by fzsync_pair_wait()
- * @b_cntr: Internal; Atomic counter used by fzsync_pair_wait()
- * @exit: Internal; Used by tst_fzsync_pair_exit() and fzsync_pair_wait()
- *
- * This contains all the necessary state for synchronising two points A and
- * B. Where A is the time of an event in one process and B is the time of an
- * event in another process.
+ * The state of a two way synchronisation or race.
+ *
+ * This contains all the necessary state for approximately synchronising two
+ * sections of code in different threads.
+ *
+ * Some of the fields can be configured before calling
+ * tst_fzsync_pair_reset(), however this is mainly for debugging purposes. If
+ * a test requires one of the parameters to be modified, we should consider
+ * finding a way of automatically selecting an appropriate value at runtime.
  *
  * Internal fields should only be accessed by library functions.
  */
 struct tst_fzsync_pair {
-	float avg_diff;
-	float avg_diff_trgt;
+	/**
+	 * The rate at which old diff samples are forgotten
+	 *
+	 * Defaults to 0.25.
+	 */
 	float avg_alpha;
-	float avg_dev;
-	struct timespec a;
-	struct timespec b;
-	long delay;
-	long delay_inc;
-	int update_gap;
-	int info_gap;
+	/** Internal; Thread A start time */
+	struct timespec a_start;
+	/** Internal; Thread B start time */
+	struct timespec b_start;
+	/** Internal; Thread A end time */
+	struct timespec a_end;
+	/** Internal; Thread B end time */
+	struct timespec b_end;
+	/** Internal; Avg. difference between a_start and b_start */
+	struct tst_fzsync_stat diff_ss;
+	/** Internal; Avg. difference between a_start and a_end */
+	struct tst_fzsync_stat diff_sa;
+	/** Internal; Avg. difference between b_start and b_end */
+	struct tst_fzsync_stat diff_sb;
+	/** Internal; Avg. difference between a_end and b_end */
+	struct tst_fzsync_stat diff_ab;
+	/** Internal; Number of spins while waiting for the slower thread */
+	int spins;
+	struct tst_fzsync_stat spins_avg;
+	/**
+	 * Internal; Number of spins to use in the delay.
+	 *
+	 * A negative value delays thread A and a positive delays thread B.
+	 */
+	int delay;
+	/**
+	 *  Internal; The number of samples left or the sampling state.
+	 *
+	 *  A positive value is the number of remaining mandatory
+	 *  samples. Zero or a negative indicate ssome other state.
+	 */
+	int sampling;
+	/**
+	 * The Minimum number of statistical samples which must be collected.
+	 *
+	 * The minimum number of iterations which must be performed before a
+	 * random delay can be calculated. Defaults to 1024.
+	 */
+	int min_samples;
+	/**
+	 * The maximum allowed proportional average deviation.
+	 *
+	 * A value in the range (0, 1) which gives the maximum average
+	 * deviation which must be attained before random delays can be
+	 * calculated.
+	 *
+	 * It is a ratio of (average_deviation / total_time). The default is
+	 * 0.1, so this allows an average deviation of at most 10%.
+	 */
+	float max_dev_ratio;
+
+	/** Internal; Atomic counter used by fzsync_pair_wait() */
 	int a_cntr;
+	/** Internal; Atomic counter used by fzsync_pair_wait() */
 	int b_cntr;
+	/** Internal; Used by tst_fzsync_pair_exit() and fzsync_pair_wait() */
 	int exit;
+	/**
+	 * The maximum desired execution time as a proportion of the timeout
+	 *
+	 * A value x so that 0 < x < 1 which decides how long the test should
+	 * be run for (assuming the loop limit is not exceeded first).
+	 *
+	 * Defaults to 0.1 (~30 seconds with default timeout).
+	 */
+	float exec_time_p;
+	/** Internal; The test time remaining on tst_fzsync_pair_reset() */
+	float exec_time_start;
+	/**
+	 * The maximum number of iterations to execute during the test
+	 *
+	 * Defaults to a large number, but not too large.
+	 */
+	int exec_loops;
+	/** Internal; The current loop index  */
+	int exec_loop;
+	/** Internal; The second thread or NULL */
+	pthread_t thread_b;
 };
 
+#define CHK(param, low, hi, def) do {					      \
+	pair->param = (pair->param ? pair->param : def);		      \
+	if (pair->param <= low)						      \
+		tst_brk(TBROK, #param " is less than the lower bound " #low); \
+	if (pair->param >= hi)						      \
+		tst_brk(TBROK, #param " is more than the upper bound " #hi);  \
+	} while (0)
 /**
- * TST_FZSYNC_PAIR_INIT - Default values for struct tst_fzysnc_pair
+ * Ensures that any Fuzzy Sync parameters are properly set
+ *
+ * @relates tst_fzsync_pair
+ *
+ * Usually called from the setup function, it sets default parameter values or
+ * validates any existing non-defaults.
+ *
+ * @sa tst_fzsync_pair_reset()
  */
-#define TST_FZSYNC_PAIR_INIT {	\
-	.avg_alpha = 0.25,	\
-	.delay_inc = 1,	        \
-	.update_gap = 0xF,	\
-	.info_gap = 0x7FFFF     \
+static void tst_fzsync_pair_init(struct tst_fzsync_pair *pair)
+{
+	CHK(avg_alpha, 0, 1, 0.25);
+	CHK(min_samples, 20, INT_MAX, 1024);
+	CHK(max_dev_ratio, 0, 1, 0.1);
+	CHK(exec_time_p, 0, 1, 0.2);
+	CHK(exec_loops, 20, INT_MAX, 1000000);
 }
+#undef CHK
 
 /**
- * tst_fzsync_pair_info - Print some synchronisation statistics
+ * Exit and join thread B if necessary.
+ *
+ * @relates tst_fzsync_pair
+ *
+ * Call this from your cleanup function.
  */
-static void tst_fzsync_pair_info(struct tst_fzsync_pair *pair)
+static void tst_fzsync_pair_cleanup(struct tst_fzsync_pair *pair)
 {
-	tst_res(TINFO,
-		"avg_diff = %.0fns, avg_dev = %.0fns, delay = %05ld loops",
-		pair->avg_diff, pair->avg_dev, pair->delay);
+	if (pair->thread_b) {
+		tst_atomic_store(1, &pair->exit);
+		SAFE_PTHREAD_JOIN(pair->thread_b, 0);
+		pair->thread_b = 0;
+	}
 }
 
 /**
- * tst_fzsync_delay_a - Perform spin delay for A, if needed
+ * Zero some stat fields
  *
- * Usually called just before the point you want to synchronise.
+ * @relates tst_fzsync_stat
  */
-static inline void tst_fzsync_delay_a(struct tst_fzsync_pair *pair)
+static void tst_init_stat(struct tst_fzsync_stat *s)
 {
-	volatile long spin_delay = pair->delay;
+	s->avg = 0;
+	s->avg_dev = 0;
+}
 
-	while (spin_delay > 0)
-		spin_delay--;
+/**
+ * Reset or initialise fzsync.
+ *
+ * @relates tst_fzsync_pair
+ * @param pair The state structure initialised with TST_FZSYNC_PAIR_INIT.
+ * @param run_b The function defining thread B or NULL.
+ *
+ * Call this from your main test function (thread A), just before entering the
+ * main loop. It will (re)set any variables needed by fzsync and (re)start
+ * thread B using the function provided.
+ *
+ * If you need to use fork or clone to start the second thread/process then
+ * you can pass NULL to run_b and handle starting and stopping thread B
+ * yourself. You may need to place tst_fzsync_pair in some shared memory as
+ * well.
+ *
+ * @sa tst_fzsync_pair_init()
+ */
+static void tst_fzsync_pair_reset(struct tst_fzsync_pair *pair,
+				  void *(*run_b)(void *))
+{
+	tst_fzsync_pair_cleanup(pair);
+
+	tst_init_stat(&pair->diff_ss);
+	tst_init_stat(&pair->diff_sa);
+	tst_init_stat(&pair->diff_sb);
+	tst_init_stat(&pair->diff_ab);
+	tst_init_stat(&pair->spins_avg);
+	pair->delay = 0;
+	pair->sampling = pair->min_samples;
+
+	pair->exec_loop = 0;
+
+	pair->a_cntr = 0;
+	pair->b_cntr = 0;
+	tst_atomic_store(0, &pair->exit);
+	if (run_b)
+		SAFE_PTHREAD_CREATE(&pair->thread_b, 0, run_b, 0);
+
+	pair->exec_time_start = (float)tst_timeout_remaining();
 }
 
 /**
- * tst_fzsync_delay_b - Perform spin delay for B, if needed
+ * Print stat
  *
- * Usually called just before the point you want to synchronise.
+ * @relates tst_fzsync_stat
  */
-static inline void tst_fzsync_delay_b(struct tst_fzsync_pair *pair)
+static inline void tst_fzsync_stat_info(struct tst_fzsync_stat stat,
+					char *unit, char *name)
 {
-	volatile long spin_delay = pair->delay;
+	tst_res(TINFO,
+		"%1$-17s: { avg = %3$5.0f%2$s, avg_dev = %4$5.0f%2$s, dev_ratio = %5$.2f }",
+		name, unit, stat.avg, stat.avg_dev, stat.dev_ratio);
+}
 
-	while (spin_delay < 0)
-		spin_delay++;
+/**
+ * Print some synchronisation statistics
+ *
+ * @relates tst_fzsync_pair
+ */
+static void tst_fzsync_pair_info(struct tst_fzsync_pair *pair)
+{
+	tst_res(TINFO, "loop = %d", pair->exec_loop);
+	tst_fzsync_stat_info(pair->diff_ss, "ns", "start_a - start_b");
+	tst_fzsync_stat_info(pair->diff_sa, "ns", "end_a - start_a");
+	tst_fzsync_stat_info(pair->diff_sb, "ns", "end_b - start_b");
+	tst_fzsync_stat_info(pair->diff_ab, "ns", "end_a - end_b");
+	tst_fzsync_stat_info(pair->spins_avg, "  ", "spins");
 }
 
+/** Wraps clock_gettime */
 static inline void tst_fzsync_time(struct timespec *t)
 {
+#ifdef CLOCK_MONOTONIC_RAW
 	clock_gettime(CLOCK_MONOTONIC_RAW, t);
+#else
+	clock_gettime(CLOCK_MONOTONIC, t);
+#endif
 }
 
 /**
- * tst_fzsync_time_a - Set A's time to now.
+ * Exponential moving average
  *
- * Called at the point you want to synchronise.
+ * @param alpha The preference for recent samples over old ones.
+ * @param sample The current sample
+ * @param prev_avg The average of the all the previous samples
+ *
+ * @return The average including the current sample.
  */
-static inline void tst_fzsync_time_a(struct tst_fzsync_pair *pair)
+static inline float tst_exp_moving_avg(float alpha,
+					float sample,
+					float prev_avg)
 {
-	tst_fzsync_time(&pair->a);
+	return alpha * sample + (1.0 - alpha) * prev_avg;
 }
 
 /**
- * tst_fzsync_time_b - Set B's call time to now.
+ * Update a stat with a new sample
  *
- * Called at the point you want to synchronise.
+ * @relates tst_fzsync_stat
  */
-static inline void tst_fzsync_time_b(struct tst_fzsync_pair *pair)
+static inline void tst_upd_stat(struct tst_fzsync_stat *s,
+				 float alpha,
+				 float sample)
 {
-	tst_fzsync_time(&pair->b);
+	s->avg = tst_exp_moving_avg(alpha, sample, s->avg);
+	s->avg_dev = tst_exp_moving_avg(alpha,
+					5fabs(s->avg - sample), s->avg_dev);
+	s->dev_ratio = fabs(s->avg ? s->avg_dev / s->avg : 0);
 }
 
 /**
- * tst_exp_moving_avg - Exponential moving average
- * @alpha: The preference for recent samples over old ones.
- * @sample: The current sample
- * @prev_avg: The average of the all the previous samples
+ * Update a stat with a new diff sample
  *
- * Returns average including the current sample.
+ * @relates tst_fzsync_stat
  */
-static inline float tst_exp_moving_avg(float alpha,
-					float sample,
-					float prev_avg)
+static inline void tst_upd_diff_stat(struct tst_fzsync_stat *s,
+				     float alpha,
+				     struct timespec t1,
+				     struct timespec t2)
 {
-	return alpha * sample + (1.0 - alpha) * prev_avg;
+	tst_upd_stat(s, alpha, tst_timespec_diff_ns(t1, t2));
 }
 
 /**
- * tst_fzsync_pair_update - Recalculate the delay
- * @loop_index: The i in "for(i = 0;..." or zero to ignore update_gap
- * @pair: The state necessary for calculating the delay
- *
- * This should be called at the end of each loop to update the average
- * measured time difference (between A and B) and update the delay. It is
- * assumed that A and B are less than a second apart.
- *
- * The values of update_gap, avg_alpha and delay_inc decide the speed at which
- * the algorithm approaches the optimum delay value and whether it is
- * stable. If your test is behaving strangely, it could be because this
- * algorithm is behaving chaotically and flip-flopping between large positve
- * and negative delay values. You can call tst_fzysync_pair_info every few
- * loops to check whether the average difference and delay values are stable.
+ * Calculate various statistics and the delay
+ *
+ * This function helps create the fuzz in fuzzy sync. Imagine we have the
+ * following timelines in threads A and B:
+ *
+ *  start_race_a
+ *      ^                    end_race_a (a)
+ *      |                        ^
+ *      |                        |
+ *  - --+------------------------+-- - -
+ *      |        Syscall A       |                 Thread A
+ *  - --+------------------------+-- - -
+ *  - --+----------------+-------+-- - -
+ *      |   Syscall B    | spin  |                 Thread B
+ *  - --+----------------+-------+-- - -
+ *      |                |
+ *      ^                ^
+ *  start_race_b     end_race_b
+ *
+ * Here we have synchronised the calls to syscall A and B with start_race_{a,
+ * b} so that they happen at approximately the same time in threads A and
+ * B. If the race condition occurs during the entry code for these two
+ * functions then we will quickly hit it. If it occurs during the exit code of
+ * B and mid way through A, then we will quickly hit it.
+ *
+ * However if the exit paths of A and B need to be aligned and (end_race_a -
+ * end_race_b) is large relative to the variation in call times, the
+ * probability of hitting the race condition is close to zero. To solve this
+ * scenario (and others) a randomised delay is introduced before the syscalls
+ * in A and B. Given enough time the following should happen where the exit
+ * paths are now synchronised:
+ *
+ *  start_race_a
+ *      ^                    end_race_a (a)
+ *      |                        ^
+ *      |                        |
+ *  - --+------------------------+-- - -
+ *      |        Syscall A       |                 Thread A
+ *  - --+------------------------+-- - -
+ *  - --+-------+----------------+-- - -
+ *      | delay |   Syscall B    |                 Thread B
+ *  - --+-------+----------------+-- - -
+ *      |                        |
+ *      ^                        ^
+ *  start_race_b             end_race_b
+ *
+ * The delay is not introduced immediately and the delay range is only
+ * calculated once the average relative deviation has dropped below some
+ * percentage of the total time.
+ *
+ * The delay range is choosen so that any point in Syscall A could be
+ * synchronised with any point in Syscall B using a value from the
+ * range. Because the delay range may be too large for a linear search, we use
+ * an evenly distributed random function to pick a value from it.
+ *
+ * The delay range goes from positive to negative. A negative delay will delay
+ * thread A and and positive one will delay thread B. The range is bounded by
+ * the point where the entry code to Syscall A is synchronised with the exit
+ * to Syscall B and the entry code to Syscall B is synchronised with the exit
+ * of A.
+ *
+ * In order to calculate the lower bound (the max delay of A) we can simply
+ * negate the execution time of Syscall B and convert it to a spin count. For
+ * the upper bound (the max delay of B), we just take the execution time of A
+ * and convert it to a spin count.
+ *
+ * In order to calculate spin count we need to know approximately how long a
+ * spin takes and devide the delay time with it. We find this by first
+ * counting how many spins one thread spends waiting for the other during
+ * end_race[1]. We also know when each syscall exits so we can take the
+ * difference between the exit times and divde it with the number of spins
+ * spent waiting.
+ *
+ * All the times and counts we use in the calculation are averaged over a
+ * variable number of iterations. There is an initial sampling period where we
+ * simply collect time and count samples then caculate their averages. When a
+ * minimum number of samples have been collected, and if the average deviation
+ * is below some proportion of the average sample magnitude, then the sampling
+ * period is ended. On all further iterations a random delay is calculated and
+ * applied, but the averages are not updated.
+ *
+ * [1] This assumes there is always a significant difference. The algorithm
+ * may fail to introduce a delay (when one is needed) in situations where
+ * Syscall A and B finish at approximately the same time.
+ *
+ * @relates tst_fzsync_pair
  */
-static void tst_fzsync_pair_update(int loop_index, struct tst_fzsync_pair *pair)
+static void tst_fzsync_pair_update(struct tst_fzsync_pair *pair)
 {
-	long diff;
-	long inc = pair->delay_inc;
-	float target = pair->avg_diff_trgt;
-	float avg = pair->avg_diff;
-
-	diff = pair->a.tv_nsec - pair->b.tv_nsec
-		+ 1000000000 * (pair->a.tv_sec - pair->b.tv_sec);
-	avg = tst_exp_moving_avg(pair->avg_alpha, diff, avg);
-	pair->avg_dev = tst_exp_moving_avg(pair->avg_alpha,
-					   fabs(diff - avg),
-					   pair->avg_dev);
-
-	if (!(loop_index & pair->update_gap)) {
-		if (avg > target)
-			pair->delay -= inc;
-		else if (avg < target)
-			pair->delay += inc;
-	}
+	float alpha = pair->avg_alpha;
+	float per_spin_time, time_delay, dev_ratio;
+
+	dev_ratio = (pair->diff_sa.dev_ratio
+		     + pair->diff_sb.dev_ratio
+		     + pair->diff_ab.dev_ratio
+		     + pair->spins_avg.dev_ratio) / 4;
 
-	if (!(loop_index & pair->info_gap))
-		tst_fzsync_pair_info(pair);
+	if (pair->sampling > 0 || dev_ratio > pair->max_dev_ratio) {
+		tst_upd_diff_stat(&pair->diff_ss, alpha,
+				  pair->a_start, pair->b_start);
+		tst_upd_diff_stat(&pair->diff_sa, alpha,
+				  pair->a_end, pair->a_start);
+		tst_upd_diff_stat(&pair->diff_sb, alpha,
+				  pair->b_end, pair->b_start);
+		tst_upd_diff_stat(&pair->diff_ab, alpha,
+				  pair->a_end, pair->b_end);
+		tst_upd_stat(&pair->spins_avg, alpha, pair->spins);
+		if (pair->sampling > 0 && --pair->sampling == 0) {
+			tst_res(TINFO,
+				"Minimum sampling period ended, deviation ratio = %.2f",
+				dev_ratio);
+			tst_fzsync_pair_info(pair);
+		}
+	} else if (fabsf(pair->diff_ab.avg) >= 1 && pair->spins_avg.avg >= 1) {
+		per_spin_time = fabsf(pair->diff_ab.avg) / pair->spins_avg.avg;
+		time_delay = drand48() * (pair->diff_sa.avg + pair->diff_sb.avg)
+			- pair->diff_sb.avg;
+		pair->delay = (int)(time_delay / per_spin_time);
 
-	pair->avg_diff = avg;
+		if (!pair->sampling) {
+			tst_res(TINFO,
+				"Reached deviation ratio %.2f (max %.2f), introducing randomness",
+				dev_ratio, pair->max_dev_ratio);
+			tst_res(TINFO, "Delay range is [-%d, %d]",
+				(int)(pair->diff_sb.avg / per_spin_time),
+				(int)(pair->diff_sa.avg / per_spin_time));
+			tst_fzsync_pair_info(pair);
+			pair->sampling = -1;
+		}
+	} else if (!pair->sampling) {
+		tst_res(TWARN, "Can't calculate random delay");
+		pair->sampling = -1;
+	}
+
+	pair->spins = 0;
 }
 
 /**
- * tst_fzsync_pair_wait - Wait for the other thread
- * @our_cntr: The counter for the thread we are on
- * @other_cntr: The counter for the thread we are synchronising with
+ * Wait for the other thread
+ *
+ * @relates tst_fzsync_pair
+ * @param our_cntr The counter for the thread we are on
+ * @param other_cntr The counter for the thread we are synchronising with
+ * @param spins A pointer to the spin counter or NULL
  *
- * Use this (through tst_fzsync_pair_wait_a() and tst_fzsync_pair_wait_b()) if
- * you need an additional synchronisation point in a thread or you do not want
- * to use the delay facility (not recommended). See
- * tst_fzsync_pair_wait_update().
+ * Used by tst_fzsync_pair_wait_a(), tst_fzsync_pair_wait_b(),
+ * tst_fzsync_start_race_a(), etc. If the calling thread is ahead of the other
+ * thread, then it will spin wait. Unlike pthread_barrier_wait it will never
+ * use futex and can count the number of spins spent waiting.
  *
- * Returns a non-zero value if the thread should continue otherwise the
+ * @return A non-zero value if the thread should continue otherwise the
  * calling thread should exit.
  */
-static inline int tst_fzsync_pair_wait(struct tst_fzsync_pair *pair,
-				       int *our_cntr, int *other_cntr)
+static inline void tst_fzsync_pair_wait(int *our_cntr,
+					int *other_cntr,
+					int *spins)
 {
 	if (tst_atomic_inc(other_cntr) == INT_MAX) {
 		/*
@@ -243,84 +532,173 @@ static inline int tst_fzsync_pair_wait(struct tst_fzsync_pair *pair,
 		 * then our counter may already have been set to zero.
 		 */
 		while (tst_atomic_load(our_cntr) > 0
-		       && tst_atomic_load(our_cntr) < INT_MAX
-		       && !tst_atomic_load(&pair->exit))
-			;
+		       && tst_atomic_load(our_cntr) < INT_MAX) {
+			if (spins)
+				(*spins)++;
+		}
 
 		tst_atomic_store(0, other_cntr);
 		/*
 		 * Once both counters have been set to zero the invariant
 		 * is restored and we can continue.
 		 */
-		while (tst_atomic_load(our_cntr) > 1
-		       && !tst_atomic_load(&pair->exit))
+		while (tst_atomic_load(our_cntr) > 1)
 			;
 	} else {
 		/*
 		 * If our counter is less than the other thread's we are ahead
 		 * of it and need to wait.
 		 */
-		while (tst_atomic_load(our_cntr) < tst_atomic_load(other_cntr)
-		       && !tst_atomic_load(&pair->exit))
-			;
+		while (tst_atomic_load(our_cntr) < tst_atomic_load(other_cntr)) {
+			if (spins)
+				(*spins)++;
+		}
 	}
+}
 
-	/* Only exit if we have done the same amount of work as the other thread */
-	return !tst_atomic_load(&pair->exit) ||
-	  tst_atomic_load(other_cntr) <= tst_atomic_load(our_cntr);
+/**
+ * Wait in thread A
+ *
+ * @relates tst_fzsync_pair
+ * @sa tst_fzsync_pair_wait
+ */
+static inline void tst_fzsync_wait_a(struct tst_fzsync_pair *pair)
+{
+	tst_fzsync_pair_wait(&pair->a_cntr, &pair->b_cntr, NULL);
 }
 
-static inline int tst_fzsync_wait_a(struct tst_fzsync_pair *pair)
+/**
+ * Wait in thread B
+ *
+ * @relates tst_fzsync_pair
+ * @sa tst_fzsync_pair_wait
+ */
+static inline void tst_fzsync_wait_b(struct tst_fzsync_pair *pair)
 {
-	return tst_fzsync_pair_wait(pair, &pair->a_cntr, &pair->b_cntr);
+	tst_fzsync_pair_wait(&pair->b_cntr, &pair->a_cntr, NULL);
 }
 
-static inline int tst_fzsync_wait_b(struct tst_fzsync_pair *pair)
+/**
+ * Decide whether to continue running thread A
+ *
+ * @relates tst_fzsync_pair
+ *
+ * Checks some values and decides whether it is time to break the loop of
+ * thread A.
+ *
+ * @return True to continue and false to break.
+ * @sa tst_fzsync_run_a
+ */
+static inline int tst_fzsync_run_a(struct tst_fzsync_pair *pair)
 {
-	return tst_fzsync_pair_wait(pair, &pair->b_cntr, &pair->a_cntr);
+	int exit = 0;
+
+	if (pair->exec_time_p
+	    < 1 - tst_timeout_remaining() / pair->exec_time_start) {
+		tst_res(TINFO,
+			"Exceeded execution time, requesting exit");
+		exit = 1;
+	}
+
+	if (++pair->exec_loop > pair->exec_loops) {
+		tst_res(TINFO,
+			"Exceeded execution loops, requesting exit");
+		exit = 1;
+	}
+
+	tst_atomic_store(exit, &pair->exit);
+	tst_fzsync_wait_a(pair);
+
+	if (exit) {
+		tst_fzsync_pair_cleanup(pair);
+		return 0;
+	}
+
+	return 1;
 }
 
 /**
- * tst_fzsync_pair_wait_update_{a,b} - Wait and then recalculate
+ * Decide whether to continue running thread B
+ *
+ * @relates tst_fzsync_pair
+ * @sa tst_fzsync_run_a
+ */
+static inline int tst_fzsync_run_b(struct tst_fzsync_pair *pair)
+{
+	tst_fzsync_wait_b(pair);
+	return !tst_atomic_load(&pair->exit);
+}
+
+/**
+ * Marks the start of a race region in thread A
+ *
+ * @relates tst_fzsync_pair
  *
- * This allows you to have two long running threads which wait for each other
- * every iteration. So each thread will exit this function at approximately
- * the same time. It also updates the delay values in a thread safe manner.
+ * This should be placed just before performing whatever action can cause a
+ * race condition. Usually it is placed just before a syscall and
+ * tst_fzsync_end_race_a() is placed just afterward.
  *
- * You must call this function in both threads the same number of times each
- * iteration. So a call in one thread must match with a call in the
- * other. Make sure that calls to tst_fzsync_pair_wait() and
- * tst_fzsync_pair_wait_update() happen in the same order in each thread. That
- * is, make sure that a call to tst_fzsync_pair_wait_update_a() in one thread
- * corresponds to a call to tst_fzsync_pair_wait_update_b() in the other.
+ * A corrosponding call to tst_fzsync_start_race_b() should be made in thread
+ * B.
  *
- * Returns a non-zero value if the calling thread should continue to loop. If
+ * @return A non-zero value if the calling thread should continue to loop. If
  * it returns zero then tst_fzsync_exit() has been called and you must exit
  * the thread.
+ *
+ * @sa tst_fzsync_pair_update
  */
-static inline int tst_fzsync_wait_update_a(struct tst_fzsync_pair *pair)
+static inline void tst_fzsync_start_race_a(struct tst_fzsync_pair *pair)
 {
-	static int loop_index;
+	volatile int delay;
+
+	tst_fzsync_pair_update(pair);
 
-	tst_fzsync_pair_wait(pair, &pair->a_cntr, &pair->b_cntr);
-	loop_index++;
-	tst_fzsync_pair_update(loop_index, pair);
-	return tst_fzsync_pair_wait(pair, &pair->a_cntr, &pair->b_cntr);
+	tst_fzsync_wait_a(pair);
+	tst_fzsync_time(&pair->a_start);
+
+	delay = pair->delay;
+	while (delay < 0)
+		delay++;
+}
+
+/**
+ * Marks the end of a race region in thread A
+ *
+ * @relates tst_fzsync_pair
+ * @sa tst_fzsync_start_race_a
+ */
+static inline void tst_fzsync_end_race_a(struct tst_fzsync_pair *pair)
+{
+	tst_fzsync_time(&pair->a_end);
+	tst_fzsync_pair_wait(&pair->a_cntr, &pair->b_cntr, &pair->spins);
 }
 
-static inline int tst_fzsync_wait_update_b(struct tst_fzsync_pair *pair)
+/**
+ * Marks the start of a race region in thread B
+ *
+ * @relates tst_fzsync_pair
+ * @sa tst_fzsync_start_race_a
+ */
+static inline void tst_fzsync_start_race_b(struct tst_fzsync_pair *pair)
 {
-	tst_fzsync_pair_wait(pair, &pair->b_cntr, &pair->a_cntr);
-	return tst_fzsync_pair_wait(pair, &pair->b_cntr, &pair->a_cntr);
+	volatile int delay;
+
+	tst_fzsync_wait_b(pair);
+	tst_fzsync_time(&pair->b_start);
+
+	delay = pair->delay;
+	while (delay > 0)
+		delay--;
 }
 
 /**
- * tst_fzsync_pair_exit - Signal that the other thread should exit
+ * Marks the end of a race region in thread B
  *
- * Causes tst_fzsync_pair_wait() and tst_fzsync_pair_wait_update() to return
- * 0.
+ * @relates tst_fzsync_pair
+ * @sa tst_fzsync_start_race_a
  */
-static inline void tst_fzsync_pair_exit(struct tst_fzsync_pair *pair)
+static inline void tst_fzsync_end_race_b(struct tst_fzsync_pair *pair)
 {
-	tst_atomic_store(1, &pair->exit);
+	tst_fzsync_time(&pair->b_end);
+	tst_fzsync_pair_wait(&pair->b_cntr, &pair->a_cntr, &pair->spins);
 }
-- 
2.18.0

