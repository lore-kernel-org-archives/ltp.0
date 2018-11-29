From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 29 Nov 2018 12:09:42 +0100
Subject: [LTP] [PATCH] fzsync: limit sampling time
Message-ID: <c49a5628139703513cb66d84d03953ddb5cc1560.1543489660.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes: #429

Sampling can take considerably longer time on single CPU
and very slow systems. This patch limits sampling time to
1/2 of fuzzing runtime (0.25 of test time). If we don't
have enough samples by that time, stop sampling and use
stats we gathered so far.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 include/tst_fuzzy_sync.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index 03f69b78bc82..0ca292c141c3 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -162,6 +162,7 @@ struct tst_fzsync_pair {
 	 *
 	 * Defaults to 0.5 (~150 seconds with default timeout).
 	 */
+	float max_sampling_p;
 	float exec_time_p;
 	/** Internal; The test time remaining on tst_fzsync_pair_reset() */
 	float exec_time_start;
@@ -199,6 +200,7 @@ static void tst_fzsync_pair_init(struct tst_fzsync_pair *pair)
 	CHK(avg_alpha, 0, 1, 0.25);
 	CHK(min_samples, 20, INT_MAX, 1024);
 	CHK(max_dev_ratio, 0, 1, 0.1);
+	CHK(max_sampling_p, 0, 1, 0.25);
 	CHK(exec_time_p, 0, 1, 0.5);
 	CHK(exec_loops, 20, INT_MAX, 3000000);
 }
@@ -582,9 +584,18 @@ static inline void tst_fzsync_wait_b(struct tst_fzsync_pair *pair)
 static inline int tst_fzsync_run_a(struct tst_fzsync_pair *pair)
 {
 	int exit = 0;
+	float rem_p = 1 - tst_timeout_remaining() / pair->exec_time_start;
+
+	/* Limit amount of time spent on sampling */
+	if ((pair->max_sampling_p < rem_p)
+		&& (pair->sampling > 0)) {
+		tst_res(TINFO, "stopping sampling at %d samples",
+			pair->sampling);
+		pair->sampling = 0;
+		tst_fzsync_pair_info(pair);
+	}
 
-	if (pair->exec_time_p
-	    < 1 - tst_timeout_remaining() / pair->exec_time_start) {
+	if (pair->exec_time_p < rem_p) {
 		tst_res(TINFO,
 			"Exceeded execution time, requesting exit");
 		exit = 1;
-- 
1.8.3.1

