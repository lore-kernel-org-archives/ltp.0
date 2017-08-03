From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu,  3 Aug 2017 17:33:46 +0200
Subject: [LTP] [RFC PATCH 1/4] fzsync: Add long running thread support
In-Reply-To: <20170803153349.32766-1-rpalethorpe@suse.com>
References: <20170803153349.32766-1-rpalethorpe@suse.com>
Message-ID: <20170803153349.32766-2-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

---
 include/tst_fuzzy_sync.h | 94 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 1 deletion(-)

diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index 229217495..5234c5aa5 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -49,6 +49,8 @@
  * @delay_inc: The step size of a delay increment, defaults to 10
  * @update_gap: The number of iterations between recalculating the delay.
  *              Defaults to 0xF and must be of the form $2^n - 1$
+ * @yin: Used by fzsync_pair_wait()
+ * @yang: Used by fzsync_pair_wait()
  *
  * This contains all the necessary state for synchronising two points A and
  * B. Where A is the time of an event in one process and B is the time of an
@@ -63,6 +65,8 @@ struct tst_fzsync_pair {
 	long delay;
 	long delay_inc;
 	int update_gap;
+	unsigned int yin;
+	unsigned int yang;
 };
 
 /**
@@ -70,7 +74,7 @@ struct tst_fzsync_pair {
  */
 #define TST_FZSYNC_PAIR_INIT {	\
 	.avg_alpha = 0.25,	\
-	.delay_inc = 10,	\
+	.delay_inc = 1,	        \
 	.update_gap = 0xF	\
 }
 
@@ -180,3 +184,91 @@ static void tst_fzsync_pair_update(int loop_index, struct tst_fzsync_pair *pair)
 
 	pair->avg_diff = avg;
 }
+
+#define FENCE_ERROR tst_brk(TBROK, "pair->fence is invalid: %d", f)
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
+	unsigned int n;
+
+	__atomic_add_fetch(&pair->yin, 1, __ATOMIC_RELEASE);
+	do {
+		n = 2;
+		__atomic_compare_exchange_n(&pair->yin, &n, 0, 0,
+					    __ATOMIC_RELEASE, __ATOMIC_ACQUIRE);
+	} while (n == 1);
+
+	__atomic_add_fetch(&pair->yang, 1, __ATOMIC_RELEASE);
+	do {
+		n = 2;
+		__atomic_compare_exchange_n(&pair->yang, &n, 0, 0,
+					    __ATOMIC_RELEASE, __ATOMIC_ACQUIRE);
+	} while (n == 1);
+
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
+ * tst_fzsync_pair_wait_update() happen in the same order in each thread.
+ *
+ * Returns a non-zero value if the calling thread should continue to loop. If
+ * it returns zero then tst_fzsync_exit() has been called and you must exit
+ * the thread.
+ */
+static inline int tst_fzsync_pair_wait_update(struct tst_fzsync_pair *pair)
+{
+	static int loop_index = 0;
+	unsigned int n = __atomic_add_fetch(&pair->yin, 1, __ATOMIC_ACQ_REL);
+
+	if (n == 2) {
+		loop_index++;
+		tst_fzsync_pair_update(loop_index, pair);
+		__atomic_compare_exchange_n(&pair->yin, &n, 0, 0,
+					    __ATOMIC_RELEASE, __ATOMIC_ACQUIRE);
+ 	}
+
+	 do {
+		n = __atomic_load_n(&pair->yin, __ATOMIC_ACQUIRE);
+	 } while (n && n < 3);
+
+	__atomic_add_fetch(&pair->yang, 1, __ATOMIC_RELEASE);
+	do {
+		n = 2;
+		__atomic_compare_exchange_n(&pair->yang, &n, 0, 0,
+					    __ATOMIC_RELEASE, __ATOMIC_ACQUIRE);
+	} while (n == 1);
+
+	return n < 3;
+}
+
+#undef FENCE_ERROR
+
+/**
+ * tst_fzsync_pair_exit - Signal that the other thread should exit
+ *
+ * Causes tst_fzsync_pair_wait() and tst_fzsync_pair_wait_update() to return
+ * 0.
+ */
+static inline void tst_fzsync_pair_exit(struct tst_fzsync_pair *pair)
+{
+	__atomic_store_n(&pair->yang, 3, __ATOMIC_RELEASE);
+	__atomic_store_n(&pair->yin, 3, __ATOMIC_RELEASE);
+}
-- 
2.13.3

