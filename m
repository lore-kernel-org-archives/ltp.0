From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri, 19 Mar 2021 09:18:35 +0000
Subject: [LTP] [PATCH v3 5/7] fzsync: Move yield check out of loop and add
 yield to delay
In-Reply-To: <20210319091837.27319-1-rpalethorpe@suse.com>
References: <20210319091837.27319-1-rpalethorpe@suse.com>
Message-ID: <20210319091837.27319-6-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

During my testing I found no difference between having the branch
inside the loop and outside. However looking at the generated
assembly, it definitely does perform the branch inside the loop. This
could have an effect on some platform with worse branch prediction. So
I have moved the branch outside of the loop.

Also I have added sched_yield to the delay loop. If we only have one
CPU then it is not delaying anything unless the other process can
progress.

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_fuzzy_sync.h | 72 ++++++++++++++++++++++++++++++----------
 1 file changed, 54 insertions(+), 18 deletions(-)

diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index 5474f81e3..36a604e13 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -183,9 +183,9 @@ struct tst_fzsync_pair {
 	int exec_loop;
 	/** Internal; The second thread or 0 */
 	pthread_t thread_b;
-	/** 
-	 * Internal; The flag indicates single core machines or not
-	 * 
+	/**
+	 * The flag indicates single core machines or not
+	 *
 	 * If running on single core machines, it would take considerable
 	 * amount of time to run fuzzy sync library.
 	 * Thus call sched_yield to give up cpu to decrease the test time.
@@ -575,31 +575,53 @@ static inline void tst_fzsync_pair_wait(int *our_cntr,
 		 * line above before doing that. If we are in rear position
 		 * then our counter may already have been set to zero.
 		 */
-		while (tst_atomic_load(our_cntr) > 0
-		       && tst_atomic_load(our_cntr) < INT_MAX) {
-			if (spins)
-				(*spins)++;
-			if(yield_in_wait)
+		if (yield_in_wait) {
+			while (tst_atomic_load(our_cntr) > 0
+			       && tst_atomic_load(our_cntr) < INT_MAX) {
+				if (spins)
+					(*spins)++;
+
 				sched_yield();
+			}
+		} else {
+			while (tst_atomic_load(our_cntr) > 0
+			       && tst_atomic_load(our_cntr) < INT_MAX) {
+				if (spins)
+					(*spins)++;
+			}
 		}
 
+
 		tst_atomic_store(0, other_cntr);
 		/*
 		 * Once both counters have been set to zero the invariant
 		 * is restored and we can continue.
 		 */
-		while (tst_atomic_load(our_cntr) > 1)
-			;
+		if (yield_in_wait) {
+			while (tst_atomic_load(our_cntr) > 1)
+				sched_yield();
+		} else {
+			while (tst_atomic_load(our_cntr) > 1)
+				;
+		}
 	} else {
 		/*
 		 * If our counter is less than the other thread's we are ahead
 		 * of it and need to wait.
 		 */
-		while (tst_atomic_load(our_cntr) < tst_atomic_load(other_cntr)) {
-			if (spins)
-				(*spins)++;
-			if(yield_in_wait)
+		if (yield_in_wait) {
+			while (tst_atomic_load(our_cntr) <
+			       tst_atomic_load(other_cntr)) {
+				if (spins)
+					(*spins)++;
 				sched_yield();
+			}
+		} else {
+			while (tst_atomic_load(our_cntr) <
+			       tst_atomic_load(other_cntr)) {
+				if (spins)
+					(*spins)++;
+			}
 		}
 	}
 }
@@ -713,8 +735,15 @@ static inline void tst_fzsync_start_race_a(struct tst_fzsync_pair *pair)
 	tst_fzsync_wait_a(pair);
 
 	delay = pair->delay;
-	while (delay < 0)
-		delay++;
+	if (pair->yield_in_wait) {
+		while (delay < 0) {
+			sched_yield();
+			delay++;
+		}
+	} else {
+		while (delay < 0)
+			delay++;
+	}
 
 	tst_fzsync_time(&pair->a_start);
 }
@@ -744,8 +773,15 @@ static inline void tst_fzsync_start_race_b(struct tst_fzsync_pair *pair)
 	tst_fzsync_wait_b(pair);
 
 	delay = pair->delay;
-	while (delay > 0)
-		delay--;
+	if (pair->yield_in_wait) {
+		while (delay > 0) {
+			sched_yield();
+			delay--;
+		}
+	} else {
+		while (delay > 0)
+			delay--;
+	}
 
 	tst_fzsync_time(&pair->b_start);
 }
-- 
2.30.1

