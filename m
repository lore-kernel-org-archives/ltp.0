From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 19 May 2020 14:21:11 +0530
Subject: [LTP] [PATCH 4/5] syscalls: Don't pass struct timespec to
 tst_syscall()
In-Reply-To: <cover.1589877853.git.viresh.kumar@linaro.org>
References: <cover.1589877853.git.viresh.kumar@linaro.org>
Message-ID: <a6c2c59a9cffb86d751b911384a560803e723623.1589877853.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

There are compatibility issues here as we are calling the direct
syscalls with the "struct timespec" (which is a libc definition). We
must use struct __kernel_old_timespec instead.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/tst_clocks.h          |  8 +++++---
 lib/tst_clocks.c              |  6 +++---
 lib/tst_test.c                | 16 ++++++++--------
 lib/tst_timer.c               | 23 +++++++++++++++--------
 lib/tst_timer_test.c          |  2 +-
 lib/tst_wallclock.c           | 17 +++++++++--------
 testcases/cve/cve-2016-7117.c |  2 +-
 7 files changed, 42 insertions(+), 32 deletions(-)

diff --git a/include/tst_clocks.h b/include/tst_clocks.h
index 80030c6b0c68..bb149acd2f83 100644
--- a/include/tst_clocks.h
+++ b/include/tst_clocks.h
@@ -9,11 +9,13 @@
 #ifndef TST_CLOCKS__
 #define TST_CLOCKS__
 
-int tst_clock_getres(clockid_t clk_id, struct timespec *res);
+struct __kernel_old_timespec;
 
-int tst_clock_gettime(clockid_t clk_id, struct timespec *ts);
+int tst_clock_getres(clockid_t clk_id, struct __kernel_old_timespec *res);
 
-int tst_clock_settime(clockid_t clk_id, struct timespec *ts);
+int tst_clock_gettime(clockid_t clk_id, struct __kernel_old_timespec *ts);
+
+int tst_clock_settime(clockid_t clk_id, struct __kernel_old_timespec *ts);
 
 /*
  * Converts clock id to a readable name.
diff --git a/lib/tst_clocks.c b/lib/tst_clocks.c
index 2eaa73b11abe..8d8c2f7666fa 100644
--- a/lib/tst_clocks.c
+++ b/lib/tst_clocks.c
@@ -11,17 +11,17 @@
 #include "lapi/syscalls.h"
 #include "lapi/posix_clocks.h"
 
-int tst_clock_getres(clockid_t clk_id, struct timespec *res)
+int tst_clock_getres(clockid_t clk_id, struct __kernel_old_timespec *res)
 {
 	return tst_syscall(__NR_clock_getres, clk_id, res);
 }
 
-int tst_clock_gettime(clockid_t clk_id, struct timespec *ts)
+int tst_clock_gettime(clockid_t clk_id, struct __kernel_old_timespec *ts)
 {
 	return tst_syscall(__NR_clock_gettime, clk_id, ts);
 }
 
-int tst_clock_settime(clockid_t clk_id, struct timespec *ts)
+int tst_clock_settime(clockid_t clk_id, struct __kernel_old_timespec *ts)
 {
 	return tst_syscall(__NR_clock_settime, clk_id, ts);
 }
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 0e58060e0159..8f6b07072429 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -49,7 +49,7 @@ static float timeout_mul = -1;
 static pid_t main_pid, lib_pid;
 static int mntpoint_mounted;
 static int ovl_mounted;
-static struct timespec tst_start_time; /* valid only for test pid */
+static struct tst_ts tst_start_time = { .type = TST_KERN_OLD_TIMESPEC }; /* valid only for test pid */
 
 struct results {
 	int passed;
@@ -1081,12 +1081,12 @@ static void run_tests(void)
 
 static unsigned long long get_time_ms(void)
 {
-	struct timespec ts;
+	struct tst_ts ts = { .type = TST_KERN_OLD_TIMESPEC };
 
-	if (tst_clock_gettime(CLOCK_MONOTONIC, &ts))
+	if (tst_clock_gettime(CLOCK_MONOTONIC, &ts.ts.kern_old_ts))
 		tst_brk(TBROK | TERRNO, "tst_clock_gettime()");
 
-	return tst_timespec_to_ms(ts);
+	return tst_ts_to_ms(ts);
 }
 
 static void add_paths(void)
@@ -1108,7 +1108,7 @@ static void add_paths(void)
 
 static void heartbeat(void)
 {
-	if (tst_clock_gettime(CLOCK_MONOTONIC, &tst_start_time))
+	if (tst_clock_gettime(CLOCK_MONOTONIC, &tst_start_time.ts.kern_old_ts))
 		tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
 
 	kill(getppid(), SIGUSR1);
@@ -1190,13 +1190,13 @@ static void sigint_handler(int sig LTP_ATTRIBUTE_UNUSED)
 
 unsigned int tst_timeout_remaining(void)
 {
-	static struct timespec now;
+	struct tst_ts now = { .type = TST_KERN_OLD_TIMESPEC };
 	unsigned int elapsed;
 
-	if (tst_clock_gettime(CLOCK_MONOTONIC, &now))
+	if (tst_clock_gettime(CLOCK_MONOTONIC, &now.ts.kern_old_ts))
 		tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
 
-	elapsed = (tst_timespec_diff_ms(now, tst_start_time) + 500) / 1000;
+	elapsed = (tst_ts_diff_ms(now, tst_start_time) + 500) / 1000;
 	if (results->timeout > elapsed)
 		return results->timeout - elapsed;
 
diff --git a/lib/tst_timer.c b/lib/tst_timer.c
index 62d8f9080f38..97817770ec7e 100644
--- a/lib/tst_timer.c
+++ b/lib/tst_timer.c
@@ -12,12 +12,13 @@
 #include "tst_clocks.h"
 #include "lapi/posix_clocks.h"
 
-static struct timespec start_time, stop_time;
+static struct tst_ts start_time = { .type = TST_KERN_OLD_TIMESPEC };
+static struct tst_ts stop_time = { .type = TST_KERN_OLD_TIMESPEC };
 static clockid_t clock_id;
 
 void tst_timer_check(clockid_t clk_id)
 {
-	if (tst_clock_gettime(clk_id, &start_time)) {
+	if (tst_clock_gettime(clk_id, &start_time.ts.kern_old_ts)) {
 		if (errno == EINVAL) {
 			tst_brk(TCONF,
 			         "Clock id %s(%u) not supported by kernel",
@@ -33,27 +34,33 @@ void tst_timer_start(clockid_t clk_id)
 {
 	clock_id = clk_id;
 
-	if (tst_clock_gettime(clock_id, &start_time))
+	if (tst_clock_gettime(clock_id, &start_time.ts.kern_old_ts))
 		tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
 }
 
 int tst_timer_expired_ms(long long ms)
 {
-	struct timespec cur_time;
+	struct tst_ts cur_time = { .type = TST_KERN_OLD_TIMESPEC };
 
-	if (tst_clock_gettime(clock_id, &cur_time))
+	if (tst_clock_gettime(clock_id, &cur_time.ts.kern_old_ts))
 		tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
 
-	return tst_timespec_diff_ms(cur_time, start_time) >= ms;
+	return tst_ts_diff_ms(cur_time, start_time) >= ms;
 }
 
 void tst_timer_stop(void)
 {
-	if (tst_clock_gettime(clock_id, &stop_time))
+	if (tst_clock_gettime(clock_id, &stop_time.ts.kern_old_ts))
 		tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
 }
 
 struct timespec tst_timer_elapsed(void)
 {
-	return tst_timespec_diff(stop_time, start_time);
+	struct tst_ts ts;
+	struct timespec tspec;
+
+	ts = tst_ts_diff(stop_time, start_time);
+	tspec.tv_sec = ts.ts.kern_old_ts.tv_sec;
+	tspec.tv_nsec = ts.ts.kern_old_ts.tv_nsec;
+	return tspec;
 }
diff --git a/lib/tst_timer_test.c b/lib/tst_timer_test.c
index 196c51272d34..6aa5711643fe 100644
--- a/lib/tst_timer_test.c
+++ b/lib/tst_timer_test.c
@@ -341,7 +341,7 @@ static int set_latency(void)
 
 static void timer_setup(void)
 {
-	struct timespec t;
+	struct __kernel_old_timespec t;
 	int ret;
 
 	if (setup)
diff --git a/lib/tst_wallclock.c b/lib/tst_wallclock.c
index 282d6ada3008..a267792756ee 100644
--- a/lib/tst_wallclock.c
+++ b/lib/tst_wallclock.c
@@ -14,7 +14,8 @@
 #include "tst_wallclock.h"
 #include "lapi/posix_clocks.h"
 
-static struct timespec real_begin, mono_begin;
+static struct tst_ts real_begin = { .type = TST_KERN_OLD_TIMESPEC };
+static struct tst_ts mono_begin = { .type = TST_KERN_OLD_TIMESPEC };
 
 static int clock_saved;
 
@@ -22,10 +23,10 @@ void tst_wallclock_save(void)
 {
 	/* save initial monotonic time to restore it when needed */
 
-	if (tst_clock_gettime(CLOCK_REALTIME, &real_begin))
+	if (tst_clock_gettime(CLOCK_REALTIME, &real_begin.ts.kern_old_ts))
 		tst_brk(TBROK | TERRNO, "tst_clock_gettime() realtime failed");
 
-	if (tst_clock_gettime(CLOCK_MONOTONIC_RAW, &mono_begin)) {
+	if (tst_clock_gettime(CLOCK_MONOTONIC_RAW, &mono_begin.ts.kern_old_ts)) {
 		if (errno == EINVAL) {
 			tst_brk(TCONF | TERRNO,
 				"tst_clock_gettime() didn't support CLOCK_MONOTONIC_RAW");
@@ -39,22 +40,22 @@ void tst_wallclock_save(void)
 
 void tst_wallclock_restore(void)
 {
-	static struct timespec mono_end, elapsed, adjust;
+	struct tst_ts elapsed, adjust, mono_end = { .type = TST_KERN_OLD_TIMESPEC };
 
 	if (!clock_saved)
 		return;
 
 	clock_saved = 0;
 
-	if (tst_clock_gettime(CLOCK_MONOTONIC_RAW, &mono_end))
+	if (tst_clock_gettime(CLOCK_MONOTONIC_RAW, &mono_end.ts.kern_old_ts))
 		tst_brk(TBROK | TERRNO, "tst_clock_gettime() monotonic failed");
 
-	elapsed = tst_timespec_diff(mono_end, mono_begin);
+	elapsed = tst_ts_diff(mono_end, mono_begin);
 
-	adjust = tst_timespec_add(real_begin, elapsed);
+	adjust = tst_ts_add(real_begin, elapsed);
 
 	/* restore realtime clock based on monotonic delta */
 
-	if (tst_clock_settime(CLOCK_REALTIME, &adjust))
+	if (tst_clock_settime(CLOCK_REALTIME, &adjust.ts.kern_old_ts))
 		tst_brk(TBROK | TERRNO, "tst_clock_settime() realtime failed");
 }
diff --git a/testcases/cve/cve-2016-7117.c b/testcases/cve/cve-2016-7117.c
index dca002924728..cbbc1c182079 100644
--- a/testcases/cve/cve-2016-7117.c
+++ b/testcases/cve/cve-2016-7117.c
@@ -73,7 +73,7 @@ static struct mmsghdr msghdrs[2] = {
 	}
 };
 static char rbuf[sizeof(MSG)];
-static struct timespec timeout = { .tv_sec = RECV_TIMEOUT };
+static struct __kernel_old_timespec timeout = { .tv_sec = RECV_TIMEOUT };
 static struct tst_fzsync_pair fzsync_pair;
 static void *send_and_close(void *);
 
-- 
2.25.0.rc1.19.g042ed3e048af

