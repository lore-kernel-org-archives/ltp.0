From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 22 May 2020 12:24:11 +0530
Subject: [LTP] [PATCH V2 5/6] syscalls: Don't pass struct timespec to
 tst_syscall()
In-Reply-To: <cover.1590130423.git.viresh.kumar@linaro.org>
References: <cover.1590130423.git.viresh.kumar@linaro.org>
Message-ID: <c5428a9c88d18fac80e364281cfd4e3aefa38d2c.1590130423.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

There are compatibility issues here as we are calling the direct
syscalls (with tst_syscall()) with the "struct timespec" (which is a
libc definition). Over that, an architecture may not define
__NR_clock_getres (for example) and so we must have the fallback version
in place.

This updates the tst_clock_*() routines in core libraries and adds
support for different syscall variants.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 lib/tst_clocks.c | 59 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 56 insertions(+), 3 deletions(-)

diff --git a/lib/tst_clocks.c b/lib/tst_clocks.c
index 2eaa73b11abe..ed13f0af0c60 100644
--- a/lib/tst_clocks.c
+++ b/lib/tst_clocks.c
@@ -7,23 +7,76 @@
 
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
+#include "tst_timer.h"
 #include "tst_clocks.h"
 #include "lapi/syscalls.h"
 #include "lapi/posix_clocks.h"
 
 int tst_clock_getres(clockid_t clk_id, struct timespec *res)
 {
-	return tst_syscall(__NR_clock_getres, clk_id, res);
+	int (*func)(clockid_t clk_id, void *ts);
+	struct tst_ts tts = { 0, };
+	int ret;
+
+#if defined(__NR_clock_getres_time64)
+	tts.type = TST_KERN_TIMESPEC;
+	func = sys_clock_getres64;
+#elif defined(__NR_clock_getres)
+	tts.type = TST_KERN_OLD_TIMESPEC;
+	func = sys_clock_getres;
+#else
+	tts.type = TST_LIBC_TIMESPEC;
+	func = libc_clock_getres;
+#endif
+
+	ret = func(clk_id, tst_ts_get(&tts));
+	res->tv_sec = tst_ts_get_sec(tts);
+	res->tv_nsec = tst_ts_get_nsec(tts);
+	return ret;
 }
 
 int tst_clock_gettime(clockid_t clk_id, struct timespec *ts)
 {
-	return tst_syscall(__NR_clock_gettime, clk_id, ts);
+	int (*func)(clockid_t clk_id, void *ts);
+	struct tst_ts tts = { 0, };
+	int ret;
+
+#if defined(__NR_clock_gettime64)
+	tts.type = TST_KERN_TIMESPEC;
+	func = sys_clock_gettime64;
+#elif defined(__NR_clock_gettime)
+	tts.type = TST_KERN_OLD_TIMESPEC;
+	func = sys_clock_gettime;
+#else
+	tts.type = TST_LIBC_TIMESPEC;
+	func = libc_clock_gettime;
+#endif
+
+	ret = func(clk_id, tst_ts_get(&tts));
+	ts->tv_sec = tst_ts_get_sec(tts);
+	ts->tv_nsec = tst_ts_get_nsec(tts);
+	return ret;
 }
 
 int tst_clock_settime(clockid_t clk_id, struct timespec *ts)
 {
-	return tst_syscall(__NR_clock_settime, clk_id, ts);
+	int (*func)(clockid_t clk_id, void *ts);
+	struct tst_ts tts = { 0, };
+
+#if defined(__NR_clock_settime64)
+	tts.type = TST_KERN_TIMESPEC;
+	func = sys_clock_settime64;
+#elif defined(__NR_clock_settime)
+	tts.type = TST_KERN_OLD_TIMESPEC;
+	func = sys_clock_settime;
+#else
+	tts.type = TST_LIBC_TIMESPEC;
+	func = libc_clock_settime;
+#endif
+
+	tst_ts_set_sec(&tts, ts->tv_sec);
+	tst_ts_set_nsec(&tts, ts->tv_nsec);
+	return func(clk_id, tst_ts_get(&tts));
 }
 
 const char *tst_clock_name(clockid_t clk_id)
-- 
2.25.0.rc1.19.g042ed3e048af

