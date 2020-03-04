From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed,  4 Mar 2020 16:24:00 +0100
Subject: [LTP] [PATCH 01/12] lib: Move tst_clock_name() to tst_clock.c
Message-ID: <20200304152401.7432-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Move tst_clock_name() from tst_timer.c to tst_clock.c and add a few
missing clocks.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_clocks.h |  5 +++++
 include/tst_timer.h  |  5 -----
 lib/tst_clocks.c     | 31 +++++++++++++++++++++++++++++++
 lib/tst_timer.c      | 24 ------------------------
 4 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/include/tst_clocks.h b/include/tst_clocks.h
index 90784a3fd..f4a2c3301 100644
--- a/include/tst_clocks.h
+++ b/include/tst_clocks.h
@@ -28,4 +28,9 @@ int tst_clock_gettime(clockid_t clk_id, struct timespec *ts);
 
 int tst_clock_settime(clockid_t clk_id, struct timespec *ts);
 
+/*
+ * Converts clock id to a readable name.
+ */
+const char *tst_clock_name(clockid_t clk_id);
+
 #endif /* TST_CLOCKS__ */
diff --git a/include/tst_timer.h b/include/tst_timer.h
index d361aa2ed..de60bc62a 100644
--- a/include/tst_timer.h
+++ b/include/tst_timer.h
@@ -332,9 +332,4 @@ static inline long long tst_timer_elapsed_us(void)
 	return tst_timespec_to_us(tst_timer_elapsed());
 }
 
-/*
- * Returns a string containing given clock type name
- */
-const char *tst_clock_name(clockid_t);
-
 #endif /* TST_TIMER */
diff --git a/lib/tst_clocks.c b/lib/tst_clocks.c
index fa2f1cb84..2eaa73b11 100644
--- a/lib/tst_clocks.c
+++ b/lib/tst_clocks.c
@@ -9,6 +9,7 @@
 #include "tst_test.h"
 #include "tst_clocks.h"
 #include "lapi/syscalls.h"
+#include "lapi/posix_clocks.h"
 
 int tst_clock_getres(clockid_t clk_id, struct timespec *res)
 {
@@ -24,3 +25,33 @@ int tst_clock_settime(clockid_t clk_id, struct timespec *ts)
 {
 	return tst_syscall(__NR_clock_settime, clk_id, ts);
 }
+
+const char *tst_clock_name(clockid_t clk_id)
+{
+	switch (clk_id) {
+	case CLOCK_REALTIME:
+		return "CLOCK_REALTIME";
+	case CLOCK_MONOTONIC:
+		return "CLOCK_MONOTONIC";
+	case CLOCK_PROCESS_CPUTIME_ID:
+		return "CLOCK_PROCESS_CPUTIME_ID";
+	case CLOCK_THREAD_CPUTIME_ID:
+		return "CLOCK_THREAD_CPUTIME_ID";
+	case CLOCK_MONOTONIC_RAW:
+		return "CLOCK_MONOTONIC_RAW";
+	case CLOCK_REALTIME_COARSE:
+		return "CLOCK_REALTIME_COARSE";
+	case CLOCK_MONOTONIC_COARSE:
+		return "CLOCK_MONOTONIC_COARSE";
+	case CLOCK_BOOTTIME:
+		return "CLOCK_BOOTTIME";
+	case CLOCK_REALTIME_ALARM:
+		return "CLOCK_REALTIME_ALARM";
+	case CLOCK_BOOTTIME_ALARM:
+		return "CLOCK_BOOTTIME_ALARM";
+	case CLOCK_TAI:
+		return "CLOCK_TAI";
+	default:
+		return "INVALID/UNKNOWN CLOCK";
+	}
+}
diff --git a/lib/tst_timer.c b/lib/tst_timer.c
index f7f09f3d2..62d8f9080 100644
--- a/lib/tst_timer.c
+++ b/lib/tst_timer.c
@@ -15,30 +15,6 @@
 static struct timespec start_time, stop_time;
 static clockid_t clock_id;
 
-const char *tst_clock_name(clockid_t clk_id)
-{
-	switch (clk_id) {
-	case CLOCK_REALTIME:
-		return "CLOCK_REALTIME";
-	case CLOCK_REALTIME_COARSE:
-		return "CLOCK_REALTIME_COARSE";
-	case CLOCK_MONOTONIC:
-		return "CLOCK_MONOTONIC";
-	case CLOCK_MONOTONIC_COARSE:
-		return "CLOCK_MONOTONIC_COARSE";
-	case CLOCK_MONOTONIC_RAW:
-		return "CLOCK_MONOTONIC_RAW";
-	case CLOCK_BOOTTIME:
-		return "CLOCK_BOOTTIME";
-	case CLOCK_PROCESS_CPUTIME_ID:
-		return "CLOCK_PROCESS_CPUTIME_ID";
-	case CLOCK_THREAD_CPUTIME_ID:
-		return "CLOCK_THREAD_CPUTIME_ID";
-	default:
-		return "UNKNOWN/INVALID";
-	}
-}
-
 void tst_timer_check(clockid_t clk_id)
 {
 	if (tst_clock_gettime(clk_id, &start_time)) {
-- 
2.24.1

