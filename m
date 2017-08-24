From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 24 Aug 2017 13:08:00 +0200
Subject: [LTP] [PATCH 3/6] fzsync: Add long running thread support and
	deviation stats
In-Reply-To: <20170824110803.9994-1-rpalethorpe@suse.com>
References: <20170824110803.9994-1-rpalethorpe@suse.com>
Message-ID: <20170824110803.9994-5-rpalethorpe@suse.com>
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
addition to the new method.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_fuzzy_sync.h | 223 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 203 insertions(+), 20 deletions(-)

diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index f97137c35..eefff700d 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -17,23 +17,35 @@
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
+ * thread.
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
 
+#ifdef LTP_FZSYNC_USE_FUTEX
+# include <sys/syscall.h>
+# include <linux/futex.h>
+#endif
+
 #ifndef CLOCK_MONOTONIC_RAW
 # define CLOCK_MONOTONIC_RAW CLOCK_MONOTONIC
 #endif
@@ -44,12 +56,17 @@
  * @avg_diff_trgt: The desired average time difference, defaults to 0
  * @avg_alpha: The rate at which old diff samples are forgotten,
  *             defaults to 0.25
+ * @avg_dev: Absolute average deviation
  * @a: The time at which call site A was last passed
  * @b: The time at which call site B was last passed
  * @delay: The size of the delay, positive to delay A, negative to delay B
  * @delay_inc: The step size of a delay increment, defaults to 10
  * @update_gap: The number of iterations between recalculating the delay.
  *              Defaults to 0xF and must be of the form $2^n - 1$
+ * @info_gap: The number of iterations between printing some statistics.
+ *            Defaults to 0x7FFFF and must also be one less than a power of 2.
+ * @entry: Used by fzsync_pair_wait()
+ * @exit: Used by fzsync_pair_wait()
  *
  * This contains all the necessary state for synchronising two points A and
  * B. Where A is the time of an event in one process and B is the time of an
@@ -59,11 +76,18 @@ struct tst_fzsync_pair {
 	double avg_diff;
 	double avg_diff_trgt;
 	double avg_alpha;
+	double avg_dev;
 	struct timespec a;
 	struct timespec b;
 	long delay;
 	long delay_inc;
 	int update_gap;
+	int info_gap;
+	int entry;
+	int exit;
+#ifdef LTP_FZSYNC_USE_FUTEX
+	int exit;
+#endif
 };
 
 /**
@@ -71,14 +95,19 @@ struct tst_fzsync_pair {
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
@@ -133,18 +162,15 @@ static inline void tst_fzsync_time_b(struct tst_fzsync_pair *pair)
 }
 
 /**
- * tst_exp_moving_avg - Exponential moving average
+ * TST_EXP_MOVING_AVG - Exponential moving average
  * @alpha: The preference for recent samples over old ones.
  * @sample: The current sample
  * @prev_avg: The average of the all the previous samples
  *
  * Returns average including the current sample.
  */
-static inline double tst_exp_moving_avg(double alpha, long sample,
-					double prev_avg)
-{
-	return alpha * sample + (1.0 - alpha) * prev_avg;
-}
+#define TST_EXP_MOVING_AVG(alpha, sample, prev_avg)\
+	(alpha * sample + (1.0 - alpha) * prev_avg)
 
 /**
  * tst_fzsync_pair_update - Recalculate the delay
@@ -169,8 +195,16 @@ static void tst_fzsync_pair_update(int loop_index, struct tst_fzsync_pair *pair)
 	double target = pair->avg_diff_trgt;
 	double avg = pair->avg_diff;
 
+	if (pair->a.tv_sec > pair->b.tv_sec)
+		pair->a.tv_nsec += 1000000000;
+	else if (pair->a.tv_sec < pair->b.tv_sec)
+		pair->b.tv_nsec += 1000000000;
+
 	diff = pair->a.tv_nsec - pair->b.tv_nsec;
-	avg = tst_exp_moving_avg(pair->avg_alpha, diff, avg);
+	avg = TST_EXP_MOVING_AVG(pair->avg_alpha, diff, avg);
+	pair->avg_dev = TST_EXP_MOVING_AVG(pair->avg_alpha,
+					   fabs(diff - avg),
+					   pair->avg_dev);
 
 	if (!(loop_index & pair->update_gap)) {
 		if (avg > target)
@@ -179,5 +213,154 @@ static void tst_fzsync_pair_update(int loop_index, struct tst_fzsync_pair *pair)
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
+ *
+ * Use this if you need an additional synchronisation point in a thread. See
+ * tst_fzsync_pair_wait_update().
+ *
+ * Returns a non-zero value if the thread should continue otherwise the
+ * calling thread should exit.
+ */
+static inline int tst_fzsync_pair_wait(struct tst_fzsync_pair *pair)
+{
+	int n = tst_atomic_add_return_(1, &pair->entry, LTP_ACQUIRE);
+
+#ifndef LTP_FZSYNC_USE_FUTEX
+	do {
+		n = 2;
+		tst_atomic_cmpxchg_(&pair->entry, &n, 0,
+				    LTP_RELEASE, LTP_ACQUIRE);
+	} while (n == 1);
+
+	tst_atomic_add_return_(1, &pair->exit, LTP_ACQUIRE);
+	do {
+		n = 2;
+		tst_atomic_cmpxchg_(&pair->exit, &n, 0,
+				    LTP_RELEASE, LTP_ACQUIRE);
+	} while (n == 1);
+
+#else
+	if (n == 1) {
+		syscall(SYS_futex, &pair->entry, FUTEX_WAIT, 1, 0, 0);
+	} else {
+		n = 2;
+		tst_atomic_cmpxchg_(&pair->entry, &n, 0,
+				    LTP_RELEASE, LTP_ACQUIRE);
+		syscall(SYS_futex, &pair->entry, FUTEX_WAKE, 1, 0, 0);
+	}
+
+	n = tst_atomic_add_return_(1, &pair->exit, LTP_ACQUIRE);
+	if (n == 1) {
+		syscall(SYS_futex, &pair->exit, FUTEX_WAIT, 1, 0, 0);
+	} else {
+		n = 2;
+		tst_atomic_cmpxchg_(&pair->exit, &n, 0,
+				    LTP_RELEASE, LTP_ACQUIRE);
+		syscall(SYS_futex, &pair->exit, FUTEX_WAKE, 1, 0, 0);
+	}
+#endif
+	return n < 3;
+}
+
+/**
+ * tst_fzsync_pair_wait_update - Wait for the other thread and then recalculate
+ *
+ * This allows you to have two long running threads which wait for each other
+ * every iteration. So each thread will exit this function@approximately
+ * the same time. It also updates the delay values in a thread safe manner.
+ *
+ * You must call this function in both threads the same number of times each
+ * iteration. So a call in one thread must match with a call in the
+ * other. Make sure that calls to tst_fzsync_pair_wait() and
+ * tst_fzsync_pair_wait_update() happen in the same order in each thread. That
+ * is, make sure that a call to tst_fzsync_pair_wait_update() in one thread
+ * corresponds to a call to tst_fzsync_pair_wait_update() in the other.
+ *
+ * Implementation notes: [ Because we expect to run in a loop, we have to
+ * prevent the scenario where one thread 'overlaps' the other. For example
+ * thread A may be spinning inside the wait function, when it is then put to
+ * sleep by the kernel. Thread B then enters the wait function, resets the
+ * atomic variable to zero and exits again. Then, before A is woken, B
+ * re-enters the wait function on the next iteration and increments the atomic
+ * variable to one.
+ *
+ * A then wakes and continues to spin because the atomic variable is set to
+ * one. B is also spinning waiting for A to increment the atomic variable. In
+ * order to prevent this we use two atomic variables; entry and exit. If one
+ * thread begins to race ahead while the other is sleeping in the entry spin
+ * state then it will transition to the exit spin state and stay there until
+ * the other thread joins it.
+ *
+ * When setting the atomic variables to zero we use cmpxchg to prevent the
+ * exit signal (the atomic variables are set to any value > 2) from being
+ * overwritten. ]
+ *
+ * Returns a non-zero value if the calling thread should continue to loop. If
+ * it returns zero then tst_fzsync_exit() has been called and you must exit
+ * the thread.
+ */
+static inline int tst_fzsync_pair_wait_update(struct tst_fzsync_pair *pair)
+{
+	static int loop_index;
+	int n = tst_atomic_add_return_(1, &pair->entry, LTP_ACQ_REL);
+
+#ifndef LTP_FZSYNC_USE_FUTEX
+	if (n == 2) {
+		loop_index++;
+		tst_fzsync_pair_update(loop_index, pair);
+		tst_atomic_cmpxchg_(&pair->entry, &n, 0,
+				    LTP_RELEASE, LTP_ACQUIRE);
+	}
+
+	do {
+		n = tst_atomic_load_(&pair->entry, LTP_ACQUIRE);
+	} while (n && n < 3);
+
+	tst_atomic_add_return_(1, &pair->exit, LTP_ACQUIRE);
+	do {
+		n = 2;
+		tst_atomic_cmpxchg_(&pair->exit, &n, 0,
+				    LTP_RELEASE, LTP_ACQUIRE);
+	} while (n == 1);
+#else
+	if (n == 2) {
+		loop_index++;
+		tst_fzsync_pair_update(loop_index, pair);
+		tst_atomic_cmpxchg_(&pair->entry, &n, 0,
+				    LTP_RELEASE, LTP_ACQUIRE);
+		syscall(SYS_futex, &pair->entry, FUTEX_WAKE, 1, 0, 0);
+	} else {
+		syscall(SYS_futex, &pair->entry, FUTEX_WAIT, 1, 0, 0);
+	}
+
+	n = tst_atomic_add_return_(1, &pair->exit, LTP_ACQUIRE);
+	if (n == 1) {
+		syscall(SYS_futex, &pair->exit, FUTEX_WAIT, 1, 0, 0);
+	} else {
+		n = 2;
+		tst_atomic_cmpxchg_(&pair->exit, &n, 0,
+				    LTP_RELEASE, LTP_ACQUIRE);
+		syscall(SYS_futex, &pair->exit, FUTEX_WAKE, 1, 0, 0);
+	}
+#endif
+	return n < 3;
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
+	tst_atomic_store_(3, &pair->exit, LTP_RELEASE);
+	tst_atomic_store_(3, &pair->entry, LTP_RELEASE);
+}
-- 
2.14.1

