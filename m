From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri, 29 Sep 2017 12:23:11 +0200
Subject: [LTP] [PATCH v5 3/7] fzsync: Add long running thread support and
	deviation stats
In-Reply-To: <20170929102315.32691-1-rpalethorpe@suse.com>
References: <20170929102315.32691-1-rpalethorpe@suse.com>
Message-ID: <20170929102315.32691-3-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Introduce a new synchronisation method which causes two threads to stop and
wait for each other. Continuing only when both threads have signaled their
readiness. Previously we would start a new thread in each iteration which
creates a variable delay in either the parent or child.

Using two long running threads significantly reduces the time needed to
perform a single race and may also increase timing stability on some
architectures.

This does not replace the delay method of synchronisation which can be used in
addition to the new method. Also the precision of the averages has been
reduced because double precision appears to be unnecessary.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_fuzzy_sync.h | 197 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 169 insertions(+), 28 deletions(-)

diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index f97137c35..d89f034f0 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -17,21 +17,30 @@
 /*
  * Fuzzy Synchronisation - abreviated to fzsync
  *
- * This library is intended to help reproduce race conditions while running in
- * a loop. You can use it to measure the time at which two functions are
- * called in different threads. Then calculate the average time gap between
- * the function calls and introduce a delay in one thread to synchronise the
- * calls.
+ * This library is intended to help reproduce race conditions by providing two
+ * thread synchronisation mechanisms. The first is a 'checkpoint' system where
+ * each thread will wait indefinitely for the other to enter a checkpoint
+ * before continuing. This is acheived by calling tst_fzsync_wait() and/or
+ * tst_fzsync_wait_update() at the points you want to synchronise in each
+ * thread. This is functionally very similar to using pthread_barrier_wait()
+ * with two threads. However tst_fzsync_wait() can be inlined and is
+ * guaranteed not to call sleep or futex.
  *
- * It is called 'fuzzy' synchronisation because the time gap will naturally vary
- * due to environmental factors. It is not a 'hard' synchronisation mechanism
- * like lockstepping.
+ * The second takes the form a of a delay which is calculated by measuring the
+ * time difference between two points in each thread and comparing it to the
+ * desired difference (default is zero). Using a delay allows you to
+ * synchronise the threads at a point outside of your direct control
+ * (e.g. inside the kernel) or just increase the accuracy for the first
+ * mechanism. It is acheived using tst_fzsync_delay_{a,b}(),
+ * tst_fzsync_time_{a,b}() and tst_fzsync[_wait_]update().
  *
- * For a usage example see testcases/cve/cve-2017-2671.c
+ * For a usage example see testcases/cve/cve-2016-7117.c or just run
+ * 'git grep tst_fuzzy_sync.h'
  */
 
 #include <sys/time.h>
 #include <time.h>
+#include <math.h>
 #include "tst_atomic.h"
 
 #ifndef CLOCK_MONOTONIC_RAW
@@ -40,30 +49,44 @@
 
 /**
  * struct tst_fzsync_pair - the state of a two way synchronisation
- * @avg_diff: The average time difference over multiple iterations
- * @avg_diff_trgt: The desired average time difference, defaults to 0
+ * @avg_diff: Internal; the average time difference over multiple iterations.
+ * @avg_diff_trgt: The desired average time difference, defaults to 0.
  * @avg_alpha: The rate at which old diff samples are forgotten,
- *             defaults to 0.25
- * @a: The time at which call site A was last passed
- * @b: The time at which call site B was last passed
- * @delay: The size of the delay, positive to delay A, negative to delay B
- * @delay_inc: The step size of a delay increment, defaults to 10
+ *             defaults to 0.25.
+ * @avg_dev: Internal; Absolute average deviation.
+ * @a: Internal; The time at which call site A was last passed.
+ * @b: Internal; The time at which call site B was last passed.
+ * @delay: Internal; The size of the delay, positive to delay A,
+ *         negative to delay B.
+ * @delay_inc: The step size of a delay increment, defaults to 1.
  * @update_gap: The number of iterations between recalculating the delay.
  *              Defaults to 0xF and must be of the form $2^n - 1$
+ * @info_gap: The number of iterations between printing some statistics.
+ *            Defaults to 0x7FFFF and must also be one less than a power of 2.
+ * @a_cntr: Internal; Atomic counter used by fzsync_pair_wait()
+ * @b_cntr: Internal; Atomic counter used by fzsync_pair_wait()
+ * @exit: Internal; Used by tst_fzsync_pair_exit() and fzsync_pair_wait()
  *
  * This contains all the necessary state for synchronising two points A and
  * B. Where A is the time of an event in one process and B is the time of an
  * event in another process.
+ *
+ * Internal fields should only be accessed by library functions.
  */
 struct tst_fzsync_pair {
-	double avg_diff;
-	double avg_diff_trgt;
-	double avg_alpha;
+	float avg_diff;
+	float avg_diff_trgt;
+	float avg_alpha;
+	float avg_dev;
 	struct timespec a;
 	struct timespec b;
 	long delay;
 	long delay_inc;
 	int update_gap;
+	int info_gap;
+	int a_cntr;
+	int b_cntr;
+	int exit;
 };
 
 /**
@@ -71,14 +94,19 @@ struct tst_fzsync_pair {
  */
 #define TST_FZSYNC_PAIR_INIT {	\
 	.avg_alpha = 0.25,	\
-	.delay_inc = 10,	\
-	.update_gap = 0xF	\
+	.delay_inc = 1,	        \
+	.update_gap = 0xF,	\
+	.info_gap = 0x7FFFF     \
 }
 
+/**
+ * tst_fzsync_pair_info - Print some synchronisation statistics
+ */
 static void tst_fzsync_pair_info(struct tst_fzsync_pair *pair)
 {
-	tst_res(TINFO, "avg_diff = %.5gns, delay = %05ld loops",
-		pair->avg_diff, pair->delay);
+	tst_res(TINFO,
+		"avg_diff = %.0fns, avg_dev = %.0fns, delay = %05ld loops",
+		pair->avg_diff, pair->avg_dev, pair->delay);
 }
 
 /**
@@ -140,8 +168,9 @@ static inline void tst_fzsync_time_b(struct tst_fzsync_pair *pair)
  *
  * Returns average including the current sample.
  */
-static inline double tst_exp_moving_avg(double alpha, long sample,
-					double prev_avg)
+static inline float tst_exp_moving_avg(float alpha,
+					float sample,
+					float prev_avg)
 {
 	return alpha * sample + (1.0 - alpha) * prev_avg;
 }
@@ -166,11 +195,15 @@ static void tst_fzsync_pair_update(int loop_index, struct tst_fzsync_pair *pair)
 {
 	long diff;
 	long inc = pair->delay_inc;
-	double target = pair->avg_diff_trgt;
-	double avg = pair->avg_diff;
+	float target = pair->avg_diff_trgt;
+	float avg = pair->avg_diff;
 
-	diff = pair->a.tv_nsec - pair->b.tv_nsec;
+	diff = pair->a.tv_nsec - pair->b.tv_nsec
+		+ 1000000000 * (pair->a.tv_sec - pair->b.tv_sec);
 	avg = tst_exp_moving_avg(pair->avg_alpha, diff, avg);
+	pair->avg_dev = tst_exp_moving_avg(pair->avg_alpha,
+					   fabs(diff - avg),
+					   pair->avg_dev);
 
 	if (!(loop_index & pair->update_gap)) {
 		if (avg > target)
@@ -179,5 +212,113 @@ static void tst_fzsync_pair_update(int loop_index, struct tst_fzsync_pair *pair)
 			pair->delay += inc;
 	}
 
+	if (!(loop_index & pair->info_gap))
+		tst_fzsync_pair_info(pair);
+
 	pair->avg_diff = avg;
 }
+
+/**
+ * tst_fzsync_pair_wait - Wait for the other thread
+ * @our_cntr: The counter for the thread we are on
+ * @other_cntr: The counter for the thread we are synchronising with
+ *
+ * Use this (through tst_fzsync_pair_wait_a() and tst_fzsync_pair_wait_b()) if
+ * you need an additional synchronisation point in a thread or you do not want
+ * to use the delay facility (not recommended). See
+ * tst_fzsync_pair_wait_update().
+ *
+ * Returns a non-zero value if the thread should continue otherwise the
+ * calling thread should exit.
+ */
+static inline int tst_fzsync_pair_wait(struct tst_fzsync_pair *pair,
+				       int *our_cntr, int *other_cntr)
+{
+	if (tst_atomic_inc(other_cntr) == INT_MAX) {
+		/*
+		 * We are about to break the invariant that the thread with
+		 * the lowest count is in front of the other. So we must wait
+		 * here to ensure the other thread has atleast reached the
+		 * line above before doing that. If we are in rear position
+		 * then our counter may already have been set to zero.
+		 */
+		while (tst_atomic_load(our_cntr) > 0
+		       && tst_atomic_load(our_cntr) < INT_MAX
+		       && !tst_atomic_load(&pair->exit))
+			;
+
+		tst_atomic_store(0, other_cntr);
+		/*
+		 * Once both counters have been set to zero the invariant
+		 * is restored and we can continue.
+		 */
+		while (tst_atomic_load(our_cntr) > 1
+		       && !tst_atomic_load(&pair->exit))
+			;
+	} else {
+		/*
+		 * If our counter is less than the other thread's we are ahead
+		 * of it and need to wait.
+		 */
+		while (tst_atomic_load(our_cntr) < tst_atomic_load(other_cntr)
+		       && !tst_atomic_load(&pair->exit))
+			;
+	}
+
+	return !tst_atomic_load(&pair->exit);
+}
+
+static inline int tst_fzsync_wait_a(struct tst_fzsync_pair *pair)
+{
+	return tst_fzsync_pair_wait(pair, &pair->a_cntr, &pair->b_cntr);
+}
+
+static inline int tst_fzsync_wait_b(struct tst_fzsync_pair *pair)
+{
+	return tst_fzsync_pair_wait(pair, &pair->b_cntr, &pair->a_cntr);
+}
+
+/**
+ * tst_fzsync_pair_wait_update_{a,b} - Wait and then recalculate
+ *
+ * This allows you to have two long running threads which wait for each other
+ * every iteration. So each thread will exit this function at approximately
+ * the same time. It also updates the delay values in a thread safe manner.
+ *
+ * You must call this function in both threads the same number of times each
+ * iteration. So a call in one thread must match with a call in the
+ * other. Make sure that calls to tst_fzsync_pair_wait() and
+ * tst_fzsync_pair_wait_update() happen in the same order in each thread. That
+ * is, make sure that a call to tst_fzsync_pair_wait_update_a() in one thread
+ * corresponds to a call to tst_fzsync_pair_wait_update_b() in the other.
+ *
+ * Returns a non-zero value if the calling thread should continue to loop. If
+ * it returns zero then tst_fzsync_exit() has been called and you must exit
+ * the thread.
+ */
+static inline int tst_fzsync_wait_update_a(struct tst_fzsync_pair *pair)
+{
+	static int loop_index;
+
+	tst_fzsync_pair_wait(pair, &pair->a_cntr, &pair->b_cntr);
+	loop_index++;
+	tst_fzsync_pair_update(loop_index, pair);
+	return tst_fzsync_pair_wait(pair, &pair->a_cntr, &pair->b_cntr);
+}
+
+static inline int tst_fzsync_wait_update_b(struct tst_fzsync_pair *pair)
+{
+	tst_fzsync_pair_wait(pair, &pair->b_cntr, &pair->a_cntr);
+	return tst_fzsync_pair_wait(pair, &pair->b_cntr, &pair->a_cntr);
+}
+
+/**
+ * tst_fzsync_pair_exit - Signal that the other thread should exit
+ *
+ * Causes tst_fzsync_pair_wait() and tst_fzsync_pair_wait_update() to return
+ * 0.
+ */
+static inline void tst_fzsync_pair_exit(struct tst_fzsync_pair *pair)
+{
+	tst_atomic_store(1, &pair->exit);
+}
-- 
2.14.1

