From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon,  3 Dec 2018 11:53:23 +0100
Subject: [LTP] [PATCH v5] fzsync: Add delay bias for difficult races
Message-ID: <20181203105323.11768-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The ordering of some operations is significant and we need to force a
particular order without creating a large time gap between them. It is
difficult to do this without knowledge of the operations being run so this
just gives the test writer the ability to directly modify the delay value.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Reviewed-by: Cyril Hrubis <chrubis@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---

The other patches in this series have already been committed, but I have
continued using the patch version numbers.

V5: Remove the stats' init function and associated documentation as it is now
only used in a single location. Also rebase on master.

There is another fzsync patch in flight from Jan (limit sampling time) which
maybe should be committed first.

 include/tst_fuzzy_sync.h      | 71 ++++++++++++++++++++++++++---------
 testcases/cve/cve-2016-7117.c |  3 ++
 2 files changed, 57 insertions(+), 17 deletions(-)

diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index 03f69b78b..cbb54c42d 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -122,6 +122,7 @@ struct tst_fzsync_pair {
 	 * A negative value delays thread A and a positive delays thread B.
 	 */
 	int delay;
+	int delay_bias;
 	/**
 	 *  Internal; The number of samples left or the sampling state.
 	 *
@@ -293,7 +294,8 @@ static inline void tst_fzsync_stat_info(struct tst_fzsync_stat stat,
  */
 static void tst_fzsync_pair_info(struct tst_fzsync_pair *pair)
 {
-	tst_res(TINFO, "loop = %d", pair->exec_loop);
+	tst_res(TINFO, "loop = %d, delay_bias = %d",
+		pair->exec_loop, pair->delay_bias);
 	tst_fzsync_stat_info(pair->diff_ss, "ns", "start_a - start_b");
 	tst_fzsync_stat_info(pair->diff_sa, "ns", "end_a - start_a");
 	tst_fzsync_stat_info(pair->diff_sb, "ns", "end_b - start_b");
@@ -446,14 +448,19 @@ static inline void tst_upd_diff_stat(struct tst_fzsync_stat *s,
 static void tst_fzsync_pair_update(struct tst_fzsync_pair *pair)
 {
 	float alpha = pair->avg_alpha;
-	float per_spin_time, time_delay, dev_ratio;
+	float per_spin_time, time_delay;
+	float max_dev = pair->max_dev_ratio;
+	int over_max_dev;
 
-	dev_ratio = (pair->diff_sa.dev_ratio
-		     + pair->diff_sb.dev_ratio
-		     + pair->diff_ab.dev_ratio
-		     + pair->spins_avg.dev_ratio) / 4;
+	pair->delay = pair->delay_bias;
 
-	if (pair->sampling > 0 || dev_ratio > pair->max_dev_ratio) {
+	over_max_dev = pair->diff_ss.dev_ratio > max_dev
+		|| pair->diff_sa.dev_ratio > max_dev
+		|| pair->diff_sb.dev_ratio > max_dev
+		|| pair->diff_ab.dev_ratio > max_dev
+		|| pair->spins_avg.dev_ratio > max_dev;
+
+	if (pair->sampling > 0 || over_max_dev) {
 		tst_upd_diff_stat(&pair->diff_ss, alpha,
 				  pair->a_start, pair->b_start);
 		tst_upd_diff_stat(&pair->diff_sa, alpha,
@@ -464,24 +471,22 @@ static void tst_fzsync_pair_update(struct tst_fzsync_pair *pair)
 				  pair->a_end, pair->b_end);
 		tst_upd_stat(&pair->spins_avg, alpha, pair->spins);
 		if (pair->sampling > 0 && --pair->sampling == 0) {
-			tst_res(TINFO,
-				"Minimum sampling period ended, deviation ratio = %.2f",
-				dev_ratio);
+			tst_res(TINFO, "Minimum sampling period ended");
 			tst_fzsync_pair_info(pair);
 		}
 	} else if (fabsf(pair->diff_ab.avg) >= 1 && pair->spins_avg.avg >= 1) {
 		per_spin_time = fabsf(pair->diff_ab.avg) / pair->spins_avg.avg;
 		time_delay = drand48() * (pair->diff_sa.avg + pair->diff_sb.avg)
 			- pair->diff_sb.avg;
-		pair->delay = (int)(time_delay / per_spin_time);
+		pair->delay += (int)(time_delay / per_spin_time);
 
 		if (!pair->sampling) {
 			tst_res(TINFO,
-				"Reached deviation ratio %.2f (max %.2f), introducing randomness",
-				dev_ratio, pair->max_dev_ratio);
+				"Reached deviation ratios < %.2f, introducing randomness",
+				pair->max_dev_ratio);
 			tst_res(TINFO, "Delay range is [-%d, %d]",
-				(int)(pair->diff_sb.avg / per_spin_time),
-				(int)(pair->diff_sa.avg / per_spin_time));
+				(int)(pair->diff_sb.avg / per_spin_time) + pair->delay_bias,
+				(int)(pair->diff_sa.avg / per_spin_time) - pair->delay_bias);
 			tst_fzsync_pair_info(pair);
 			pair->sampling = -1;
 		}
@@ -649,11 +654,12 @@ static inline void tst_fzsync_start_race_a(struct tst_fzsync_pair *pair)
 	tst_fzsync_pair_update(pair);
 
 	tst_fzsync_wait_a(pair);
-	tst_fzsync_time(&pair->a_start);
 
 	delay = pair->delay;
 	while (delay < 0)
 		delay++;
+
+	tst_fzsync_time(&pair->a_start);
 }
 
 /**
@@ -679,11 +685,12 @@ static inline void tst_fzsync_start_race_b(struct tst_fzsync_pair *pair)
 	volatile int delay;
 
 	tst_fzsync_wait_b(pair);
-	tst_fzsync_time(&pair->b_start);
 
 	delay = pair->delay;
 	while (delay > 0)
 		delay--;
+
+	tst_fzsync_time(&pair->b_start);
 }
 
 /**
@@ -698,4 +705,34 @@ static inline void tst_fzsync_end_race_b(struct tst_fzsync_pair *pair)
 	tst_fzsync_pair_wait(&pair->b_cntr, &pair->a_cntr, &pair->spins);
 }
 
+/**
+ * Add some amount to the delay bias
+ *
+ * @relates tst_fzsync_pair
+ * @param change The amount to add, can be negative
+ *
+ * A positive change delays thread B and a negative one delays thread
+ * A.
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
+static inline void tst_fzsync_pair_add_bias(struct tst_fzsync_pair *pair, int change)
+{
+	if (pair->sampling > 0)
+		pair->delay_bias += change;
+}
+
 #endif /* TST_FUZZY_SYNC_H__ */
diff --git a/testcases/cve/cve-2016-7117.c b/testcases/cve/cve-2016-7117.c
index f3d9970c3..6290af077 100644
--- a/testcases/cve/cve-2016-7117.c
+++ b/testcases/cve/cve-2016-7117.c
@@ -97,6 +97,8 @@ static void *send_and_close(void *);
 
 static void setup(void)
 {
+	fzsync_pair.min_samples = 10000;
+
 	tst_fzsync_pair_init(&fzsync_pair);
 }
 
@@ -150,6 +152,7 @@ static void run(void)
 				tst_res(TWARN | TERRNO,
 					"recvmmsg failed unexpectedly");
 			} else {
+				tst_fzsync_pair_add_bias(&fzsync_pair, 1);
 				too_early_count++;
 			}
 		}
-- 
2.19.1

