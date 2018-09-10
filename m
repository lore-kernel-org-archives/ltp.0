From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 10 Sep 2018 10:44:42 +0200
Subject: [LTP] [PATCH v2 4/4] Add delay bias for difficult races
In-Reply-To: <20180910084442.17720-1-rpalethorpe@suse.com>
References: <20180910084442.17720-1-rpalethorpe@suse.com>
Message-ID: <20180910084442.17720-5-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Races with short exploitation windows and nonlinear timings, given varying
chronological order, appear to require an offset to the synchronisation to
achieve the correct order so that the average timings are valid for the race
condition.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_fuzzy_sync.h      | 75 ++++++++++++++++++++++++++++++-----
 testcases/cve/cve-2016-7117.c |  1 +
 2 files changed, 66 insertions(+), 10 deletions(-)

diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index e38a23fa1..c6dfc2894 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -132,6 +132,8 @@ struct tst_fzsync_pair {
 	 * A negative value delays thread A and a positive delays thread B.
 	 */
 	int delay;
+	int delay_bias;
+	int discard_flag;
 	/**
 	 *  Internal; The number of samples left or the sampling state.
 	 *
@@ -178,6 +180,10 @@ struct tst_fzsync_pair {
 	/**
 	 * The maximum number of iterations to execute during the test
 	 *
+	 * Note that under normal operation this limit remains constant once
+	 * set, however some special functions, such as
+	 * tst_fzsync_pair_add_bias() may increment this limit.
+	 *
 	 * Defaults to a large number, but not too large.
 	 */
 	int exec_loops;
@@ -241,6 +247,15 @@ static void tst_init_stat(struct tst_fzsync_stat *s)
 	s->avg_dev = 0;
 }
 
+static void tst_fzsync_pair_reset_stats(struct tst_fzsync_pair *pair)
+{
+	tst_init_stat(&pair->diff_ss);
+	tst_init_stat(&pair->diff_sa);
+	tst_init_stat(&pair->diff_sb);
+	tst_init_stat(&pair->diff_ab);
+	tst_init_stat(&pair->spins_avg);
+}
+
 /**
  * Reset or initialise fzsync.
  *
@@ -264,13 +279,10 @@ static void tst_fzsync_pair_reset(struct tst_fzsync_pair *pair,
 {
 	tst_fzsync_pair_cleanup(pair);
 
-	tst_init_stat(&pair->diff_ss);
-	tst_init_stat(&pair->diff_sa);
-	tst_init_stat(&pair->diff_sb);
-	tst_init_stat(&pair->diff_ab);
-	tst_init_stat(&pair->spins_avg);
+	tst_fzsync_pair_reset_stats(pair);
 	pair->delay = 0;
 	pair->sampling = pair->min_samples;
+	pair->discard_flag = 0;
 
 	pair->exec_loop = 0;
 
@@ -303,7 +315,8 @@ static inline void tst_fzsync_stat_info(struct tst_fzsync_stat stat,
  */
 static void tst_fzsync_pair_info(struct tst_fzsync_pair *pair)
 {
-	tst_res(TINFO, "loop = %d", pair->exec_loop);
+	tst_res(TINFO, "loop = %d, delay_bias = %d",
+		pair->exec_loop, pair->delay_bias);
 	tst_fzsync_stat_info(pair->diff_ss, "ns", "start_a - start_b");
 	tst_fzsync_stat_info(pair->diff_sa, "ns", "end_a - start_a");
 	tst_fzsync_stat_info(pair->diff_sb, "ns", "end_b - start_b");
@@ -458,12 +471,20 @@ static void tst_fzsync_pair_update(struct tst_fzsync_pair *pair)
 	float alpha = pair->avg_alpha;
 	float per_spin_time, time_delay, dev_ratio;
 
+	pair->delay = pair->delay_bias;
+
 	dev_ratio = (pair->diff_sa.dev_ratio
 		     + pair->diff_sb.dev_ratio
 		     + pair->diff_ab.dev_ratio
 		     + pair->spins_avg.dev_ratio) / 4;
 
-	if (pair->sampling > 0 || dev_ratio > pair->max_dev_ratio) {
+	if (pair->sampling > 0 && pair->discard_flag) {
+		tst_fzsync_pair_reset_stats(pair);
+		pair->discard_flag = 0;
+		pair->sampling += 20;
+		if (pair->exec_loops <= INT_MAX)
+			pair->exec_loops++;
+	} else if (pair->sampling > 0 || dev_ratio > pair->max_dev_ratio) {
 		tst_upd_diff_stat(&pair->diff_ss, alpha,
 				  pair->a_start, pair->b_start);
 		tst_upd_diff_stat(&pair->diff_sa, alpha,
@@ -483,15 +504,15 @@ static void tst_fzsync_pair_update(struct tst_fzsync_pair *pair)
 		per_spin_time = fabsf(pair->diff_ab.avg) / pair->spins_avg.avg;
 		time_delay = drand48() * (pair->diff_sa.avg + pair->diff_sb.avg)
 			- pair->diff_sb.avg;
-		pair->delay = (int)(time_delay / per_spin_time);
+		pair->delay += (int)(time_delay / per_spin_time);
 
 		if (!pair->sampling) {
 			tst_res(TINFO,
 				"Reached deviation ratio %.2f (max %.2f), introducing randomness",
 				dev_ratio, pair->max_dev_ratio);
 			tst_res(TINFO, "Delay range is [-%d, %d]",
-				(int)(pair->diff_sb.avg / per_spin_time),
-				(int)(pair->diff_sa.avg / per_spin_time));
+				(int)(pair->diff_sb.avg / per_spin_time) + pair->delay_bias,
+				(int)(pair->diff_sa.avg / per_spin_time) - pair->delay_bias);
 			tst_fzsync_pair_info(pair);
 			pair->sampling = -1;
 		}
@@ -702,3 +723,37 @@ static inline void tst_fzsync_end_race_b(struct tst_fzsync_pair *pair)
 	tst_fzsync_time(&pair->b_end);
 	tst_fzsync_pair_wait(&pair->b_cntr, &pair->a_cntr, &pair->spins);
 }
+
+/**
+ * Add some amount to the delay bias
+ *
+ * @relates tst_fzsync_pair
+ * @param change The amount to add, can be negative
+ *
+ * A positive change delays thread B and a negative one delays thread
+ * A. Calling this will invalidate the statistics gathered so far and extend
+ * the minimum sampling period. Calling it once the sampling period has
+ * finished will have no effect.
+ *
+ * It is intended to be used in tests where the time taken by syscall A and/or
+ * B are significantly affected by their chronological order. To the extent
+ * that the delay range will not include the correct values if too many of the
+ * initial samples are taken when the syscalls (or operations within the
+ * syscalls) happen in the wrong order.
+ *
+ * An example of this is cve/cve-2016-7117.c where a call to close() is racing
+ * with a call to recvmmsg(). If close() happens before recvmmsg() has chance
+ * to check if the file descriptor is open then recvmmsg() completes very
+ * quickly. If the call to close() happens once recvmmsg() has already checked
+ * the descriptor it takes much longer. The sample where recvmmsg() completes
+ * quickly is essentially invalid for our purposes. The test uses the simple
+ * heuristic of whether recvmmsg() returns EBADF, to decide if it should call
+ * tst_fzsync_pair_add_bias() to further delay syscall B.
+ */
+static void tst_fzsync_pair_add_bias(struct tst_fzsync_pair *pair, int change)
+{
+	if (pair->sampling > 0) {
+		pair->delay_bias += change;
+		pair->discard_flag = 1;
+	}
+}
diff --git a/testcases/cve/cve-2016-7117.c b/testcases/cve/cve-2016-7117.c
index f3d9970c3..55cfdb05c 100644
--- a/testcases/cve/cve-2016-7117.c
+++ b/testcases/cve/cve-2016-7117.c
@@ -150,6 +150,7 @@ static void run(void)
 				tst_res(TWARN | TERRNO,
 					"recvmmsg failed unexpectedly");
 			} else {
+				tst_fzsync_pair_add_bias(&fzsync_pair, 1);
 				too_early_count++;
 			}
 		}
-- 
2.18.0

