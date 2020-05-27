From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 27 May 2020 15:13:47 +0530
Subject: [LTP] [PATCH V3 5/6] syscalls: Don't pass struct timespec to
 tst_syscall()
In-Reply-To: <c5428a9c88d18fac80e364281cfd4e3aefa38d2c.1590130423.git.viresh.kumar@linaro.org>
References: <c5428a9c88d18fac80e364281cfd4e3aefa38d2c.1590130423.git.viresh.kumar@linaro.org>
Message-ID: <c47220ecab3c7570f5387cd71894c977009ad3d8.1590572545.git.viresh.kumar@linaro.org>
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
V3:
- Run the syscalls at least once to verify they are supported by the
  hardware.

 lib/tst_clocks.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 87 insertions(+), 3 deletions(-)

diff --git a/lib/tst_clocks.c b/lib/tst_clocks.c
index 2eaa73b11abe..ddf54b903133 100644
--- a/lib/tst_clocks.c
+++ b/lib/tst_clocks.c
@@ -7,23 +7,107 @@
 
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
+#include "tst_timer.h"
 #include "tst_clocks.h"
 #include "lapi/syscalls.h"
 #include "lapi/posix_clocks.h"
 
+typedef int (*mysyscall)(clockid_t clk_id, void *ts);
+
+int syscall_supported_by_kernel(mysyscall func)
+{
+	int ret;
+
+	ret = func(0, NULL);
+	if (ret == ENOSYS)
+		return 0;
+
+	return 1;
+}
+
 int tst_clock_getres(clockid_t clk_id, struct timespec *res)
 {
-	return tst_syscall(__NR_clock_getres, clk_id, res);
+	static struct tst_ts tts = { 0, };
+	static mysyscall func;
+	int ret;
+
+#if (__NR_clock_getres_time64 != __LTP__NR_INVALID_SYSCALL)
+	if (!func && syscall_supported_by_kernel(sys_clock_getres64)) {
+		func = sys_clock_getres64;
+		tts.type = TST_KERN_TIMESPEC;
+	}
+#endif
+
+	if (!func && syscall_supported_by_kernel(sys_clock_getres)) {
+		func = sys_clock_getres;
+		tts.type = TST_KERN_OLD_TIMESPEC;
+	}
+
+	if (!func) {
+		tst_res(TCONF, "clock_getres() not available");
+		return ENOSYS;
+	}
+
+	ret = func(clk_id, tst_ts_get(&tts));
+	res->tv_sec = tst_ts_get_sec(tts);
+	res->tv_nsec = tst_ts_get_nsec(tts);
+	return ret;
 }
 
 int tst_clock_gettime(clockid_t clk_id, struct timespec *ts)
 {
-	return tst_syscall(__NR_clock_gettime, clk_id, ts);
+	struct tst_ts tts = { 0, };
+	static mysyscall func;
+	int ret;
+
+#if (__NR_clock_gettime64 != __LTP__NR_INVALID_SYSCALL)
+	if (!func && syscall_supported_by_kernel(sys_clock_gettime64)) {
+		func = sys_clock_gettime64;
+		tts.type = TST_KERN_TIMESPEC;
+	}
+#endif
+
+	if (!func && syscall_supported_by_kernel(sys_clock_gettime)) {
+		func = sys_clock_gettime;
+		tts.type = TST_KERN_OLD_TIMESPEC;
+	}
+
+	if (!func) {
+		tst_res(TCONF, "clock_gettime() not available");
+		return ENOSYS;
+	}
+
+	ret = func(clk_id, tst_ts_get(&tts));
+	ts->tv_sec = tst_ts_get_sec(tts);
+	ts->tv_nsec = tst_ts_get_nsec(tts);
+	return ret;
 }
 
 int tst_clock_settime(clockid_t clk_id, struct timespec *ts)
 {
-	return tst_syscall(__NR_clock_settime, clk_id, ts);
+	struct tst_ts tts = { 0, };
+	static mysyscall func;
+
+#if (__NR_clock_settime64 != __LTP__NR_INVALID_SYSCALL)
+	if (!func && syscall_supported_by_kernel(sys_clock_settime64)) {
+		func = sys_clock_settime64;
+		tts.type = TST_KERN_TIMESPEC;
+	}
+#endif
+
+	if (!func && syscall_supported_by_kernel(sys_clock_settime)) {
+		func = sys_clock_settime;
+		tts.type = TST_KERN_OLD_TIMESPEC;
+	}
+
+	if (!func) {
+		tst_res(TCONF, "clock_settime() not available");
+		return ENOSYS;
+	}
+
+	tst_ts_set_sec(&tts, ts->tv_sec);
+	tst_ts_set_nsec(&tts, ts->tv_nsec);
+	return func(clk_id, tst_ts_get(&tts));
 }
 
 const char *tst_clock_name(clockid_t clk_id)
-- 
2.25.0.rc1.19.g042ed3e048af

