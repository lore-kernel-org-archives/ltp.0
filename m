From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri, 19 Mar 2021 09:18:34 +0000
Subject: [LTP] [PATCH v3 4/7] fzsync: Add sched_yield for single core machine
In-Reply-To: <20210319091837.27319-1-rpalethorpe@suse.com>
References: <20210319091837.27319-1-rpalethorpe@suse.com>
Message-ID: <20210319091837.27319-5-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Leo Yu-Chi Liang <ycliang@andestech.com>

Fuzzy sync library uses spin waiting mechanism to implement thread
barrier behavior, which would cause this test to be time-consuming
on single core machine.

Fix this by adding sched_yield in the spin waiting loop, so that the
thread yields cpu as soon as it enters the waiting loop.

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 include/tst_fuzzy_sync.h | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index 4063e95cb..5474f81e3 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -59,12 +59,15 @@
  * @sa tst_fzsync_pair
  */
 
-#include <sys/time.h>
-#include <time.h>
 #include <math.h>
-#include <stdlib.h>
 #include <pthread.h>
+#include <sched.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <sys/time.h>
+#include <time.h>
 #include "tst_atomic.h"
+#include "tst_cpu.h"
 #include "tst_timer.h"
 #include "tst_safe_pthread.h"
 
@@ -180,6 +183,15 @@ struct tst_fzsync_pair {
 	int exec_loop;
 	/** Internal; The second thread or 0 */
 	pthread_t thread_b;
+	/** 
+	 * Internal; The flag indicates single core machines or not
+	 * 
+	 * If running on single core machines, it would take considerable
+	 * amount of time to run fuzzy sync library.
+	 * Thus call sched_yield to give up cpu to decrease the test time.
+	 */
+	bool yield_in_wait;
+
 };
 
 #define CHK(param, low, hi, def) do {					      \
@@ -206,6 +218,7 @@ static void tst_fzsync_pair_init(struct tst_fzsync_pair *pair)
 	CHK(max_dev_ratio, 0, 1, 0.1);
 	CHK(exec_time_p, 0, 1, 0.5);
 	CHK(exec_loops, 20, INT_MAX, 3000000);
+	CHK(yield_in_wait, 0, 1, (tst_ncpus() <= 1));
 }
 #undef CHK
 
@@ -551,7 +564,8 @@ static void tst_fzsync_pair_update(struct tst_fzsync_pair *pair)
  */
 static inline void tst_fzsync_pair_wait(int *our_cntr,
 					int *other_cntr,
-					int *spins)
+					int *spins,
+					bool yield_in_wait)
 {
 	if (tst_atomic_inc(other_cntr) == INT_MAX) {
 		/*
@@ -565,6 +579,8 @@ static inline void tst_fzsync_pair_wait(int *our_cntr,
 		       && tst_atomic_load(our_cntr) < INT_MAX) {
 			if (spins)
 				(*spins)++;
+			if(yield_in_wait)
+				sched_yield();
 		}
 
 		tst_atomic_store(0, other_cntr);
@@ -582,6 +598,8 @@ static inline void tst_fzsync_pair_wait(int *our_cntr,
 		while (tst_atomic_load(our_cntr) < tst_atomic_load(other_cntr)) {
 			if (spins)
 				(*spins)++;
+			if(yield_in_wait)
+				sched_yield();
 		}
 	}
 }
@@ -594,7 +612,7 @@ static inline void tst_fzsync_pair_wait(int *our_cntr,
  */
 static inline void tst_fzsync_wait_a(struct tst_fzsync_pair *pair)
 {
-	tst_fzsync_pair_wait(&pair->a_cntr, &pair->b_cntr, NULL);
+	tst_fzsync_pair_wait(&pair->a_cntr, &pair->b_cntr, NULL, pair->yield_in_wait);
 }
 
 /**
@@ -605,7 +623,7 @@ static inline void tst_fzsync_wait_a(struct tst_fzsync_pair *pair)
  */
 static inline void tst_fzsync_wait_b(struct tst_fzsync_pair *pair)
 {
-	tst_fzsync_pair_wait(&pair->b_cntr, &pair->a_cntr, NULL);
+	tst_fzsync_pair_wait(&pair->b_cntr, &pair->a_cntr, NULL, pair->yield_in_wait);
 }
 
 /**
@@ -710,7 +728,7 @@ static inline void tst_fzsync_start_race_a(struct tst_fzsync_pair *pair)
 static inline void tst_fzsync_end_race_a(struct tst_fzsync_pair *pair)
 {
 	tst_fzsync_time(&pair->a_end);
-	tst_fzsync_pair_wait(&pair->a_cntr, &pair->b_cntr, &pair->spins);
+	tst_fzsync_pair_wait(&pair->a_cntr, &pair->b_cntr, &pair->spins, pair->yield_in_wait);
 }
 
 /**
@@ -741,7 +759,7 @@ static inline void tst_fzsync_start_race_b(struct tst_fzsync_pair *pair)
 static inline void tst_fzsync_end_race_b(struct tst_fzsync_pair *pair)
 {
 	tst_fzsync_time(&pair->b_end);
-	tst_fzsync_pair_wait(&pair->b_cntr, &pair->a_cntr, &pair->spins);
+	tst_fzsync_pair_wait(&pair->b_cntr, &pair->a_cntr, &pair->spins, pair->yield_in_wait);
 }
 
 /**
-- 
2.30.1

