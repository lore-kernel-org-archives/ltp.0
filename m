From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 16 Aug 2018 14:00:19 +0200
Subject: [LTP] [PATCH v3 3/4] tst_timer: Create interface for using multiple
	timers
In-Reply-To: <20180816120020.11042-1-rpalethorpe@suse.com>
References: <20180816120020.11042-1-rpalethorpe@suse.com>
Message-ID: <20180816120020.11042-3-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Encapsulate information about a stopwatch timer in a struct and provide
methods for operating on that timer. This allows test authors to create
multiple timers in parallel.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_timer.h | 30 ++++++++++++++++++++++++++++++
 lib/tst_timer.c     | 17 +++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/tst_timer.h b/include/tst_timer.h
index 0fd7ed6cf..06deae88a 100644
--- a/include/tst_timer.h
+++ b/include/tst_timer.h
@@ -34,6 +34,20 @@
 #include <sys/time.h>
 #include <time.h>
 
+/**
+ * Encapsulates a stopwatch timer.
+ *
+ * Useful when you need to use multiple timers in a single test.
+ */
+struct tst_timer {
+	/** The POSIX clock type  */
+	clockid_t clock_id;
+	/** How much time can pass before tst_timer_expired_st() returns true */
+	struct timespec limit;
+	/** Where to start measuring time from */
+	struct timespec start_time;
+};
+
 /*
  * Converts timespec to microseconds.
  */
@@ -251,6 +265,14 @@ void tst_timer_check(clockid_t clk_id);
  */
 void tst_timer_start(clockid_t clk_id);
 
+/**
+ * Sets the start time for timer tim.
+ *
+ * @relates tst_timer
+ * @param tim The timer to start
+ */
+void tst_timer_start_st(struct tst_timer *tim);
+
 /*
  * Returns true if timer started by tst_timer_start() has been running for
  * longer than ms seconds.
@@ -259,6 +281,14 @@ void tst_timer_start(clockid_t clk_id);
  */
 int tst_timer_expired_ms(long long ms);
 
+/**
+ * Returns true if timer tim has been running for longer than tst_timer::limit
+ *
+ * @relates tst_timer
+ * @param tim The timer to check
+ */
+int tst_timer_expired_st(struct tst_timer *tim);
+
 /*
  * Marks timer end time.
  */
diff --git a/lib/tst_timer.c b/lib/tst_timer.c
index d5e4c49d2..baec18280 100644
--- a/lib/tst_timer.c
+++ b/lib/tst_timer.c
@@ -79,6 +79,12 @@ void tst_timer_start(clockid_t clk_id)
 		tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
 }
 
+void tst_timer_start_st(struct tst_timer *tim)
+{
+	if (tst_clock_gettime(tim->clock_id, &tim->start_time))
+		tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
+}
+
 int tst_timer_expired_ms(long long ms)
 {
 	struct timespec cur_time;
@@ -89,6 +95,17 @@ int tst_timer_expired_ms(long long ms)
 	return tst_timespec_diff_ms(cur_time, start_time) >= ms;
 }
 
+int tst_timer_expired_st(struct tst_timer *tim)
+{
+	struct timespec cur_time;
+
+	if (tst_clock_gettime(tim->clock_id, &cur_time))
+		tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
+
+	return tst_timespec_lt(tim->limit,
+			       tst_timespec_diff(cur_time, tim->start_time));
+}
+
 void tst_timer_stop(void)
 {
 	if (tst_clock_gettime(clock_id, &stop_time))
-- 
2.18.0

