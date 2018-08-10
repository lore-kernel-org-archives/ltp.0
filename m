From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri, 10 Aug 2018 10:36:53 +0200
Subject: [LTP] [PATCH 1/2] tst_timer: Add tst_timer_state_ms function
In-Reply-To: <20180810083654.28938-1-rpalethorpe@suse.com>
References: <20180810083654.28938-1-rpalethorpe@suse.com>
Message-ID: <20180810083654.28938-2-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Allow the user to discover the current timer state with a single
function. Useful for using a timer in a loop where we do not know if the timer
has already been started.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_timer.h |  7 +++++++
 lib/tst_timer.c     | 11 +++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/tst_timer.h b/include/tst_timer.h
index 0fd7ed6cf..a6df53e82 100644
--- a/include/tst_timer.h
+++ b/include/tst_timer.h
@@ -34,6 +34,11 @@
 #include <sys/time.h>
 #include <time.h>
 
+#define TST_TIMER_NONE 0
+#define TST_TIMER_STARTED 1
+#define TST_TIMER_STOPPED (1 << 1)
+#define TST_TIMER_EXPIRED (1 << 2)
+
 /*
  * Converts timespec to microseconds.
  */
@@ -259,6 +264,8 @@ void tst_timer_start(clockid_t clk_id);
  */
 int tst_timer_expired_ms(long long ms);
 
+int tst_timer_state_ms(long long ms);
+
 /*
  * Marks timer end time.
  */
diff --git a/lib/tst_timer.c b/lib/tst_timer.c
index 53ff36777..80dc8cf1f 100644
--- a/lib/tst_timer.c
+++ b/lib/tst_timer.c
@@ -87,6 +87,17 @@ int tst_timer_expired_ms(long long ms)
 	return tst_timespec_diff_ms(cur_time, start_time) >= ms;
 }
 
+int tst_timer_state_ms(long long ms)
+{
+	int status = TST_TIMER_NONE;
+
+	status |= (start_time.tv_sec | start_time.tv_nsec) > 0;
+	status |= ((stop_time.tv_sec | stop_time.tv_nsec) > 0) << 1;
+	status |= tst_timer_expired_ms(ms) << 2;
+
+	return status;
+}
+
 void tst_timer_stop(void)
 {
 	if (tst_clock_gettime(clock_id, &stop_time))
-- 
2.18.0

