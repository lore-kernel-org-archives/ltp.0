From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue,  7 Apr 2020 16:37:18 +0530
Subject: [LTP] [RFC] syscalls/clock_gettime: Support time64 variants
Message-ID: <bff0fc8e8777a744d35bca86c83158efb90b0ff8.1586257574.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Guys,

I wanted to get some inputs/confirmations from everyone before going
full fledged on implementing time64 changes and so here is an RFC.

This extends the clock_gettime01.c tests to support time64 variants for
both 32bit and 64bit architectures.

Are there some other tests you guys want me to include ?

@Arnd: I still wasn't able to understand how can I incorporate
D_TIME_BITS thing here and so left it :(

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/tst_timer.h                           |  31 +++++
 .../syscalls/clock_gettime/clock_gettime01.c  | 115 +++++++++---------
 2 files changed, 89 insertions(+), 57 deletions(-)

diff --git a/include/tst_timer.h b/include/tst_timer.h
index cdb8de7987d9..282514abac08 100644
--- a/include/tst_timer.h
+++ b/include/tst_timer.h
@@ -15,6 +15,37 @@
 #include <sys/time.h>
 #include <time.h>
 
+#ifndef __kernel_timespec
+typedef long __kernel_long_t;
+typedef __kernel_long_t	__kernel_old_time_t;
+
+struct __kernel_old_timespec {
+	__kernel_old_time_t	tv_sec;		/* seconds */
+	long			tv_nsec;	/* nanoseconds */
+};
+
+typedef long long __kernel_time64_t;
+
+struct __kernel_timespec {
+	__kernel_time64_t       tv_sec;                 /* seconds */
+	long long               tv_nsec;                /* nanoseconds */
+};
+#endif
+
+static inline int tst_timespec_updated_32(void *data)
+{
+	struct timespec *spec = data;
+
+	return (spec->tv_nsec != 0 || spec->tv_sec != 0) ? 1 : 0;
+}
+
+static inline int tst_timespec_updated_64(void *data)
+{
+	struct __kernel_timespec *spec = data;
+
+	return (spec->tv_nsec != 0 || spec->tv_sec != 0) ? 1 : 0;
+}
+
 static inline long long tst_timespec_to_ns(struct timespec t)
 {
 	return t.tv_sec * 1000000000 + t.tv_nsec;
diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime01.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime01.c
index d365823b2f0f..e220f3648434 100644
--- a/testcases/kernel/syscalls/clock_gettime/clock_gettime01.c
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime01.c
@@ -21,17 +21,13 @@
 #include "tst_safe_clocks.h"
 #include "tst_test.h"
 #include "lapi/syscalls.h"
+#include "lapi/abisize.h"
 
 struct test_case {
 	clockid_t clktype;
 	int allow_inval;
 };
 
-struct tmpfunc {
-	int (*func)(clockid_t clk_id, struct timespec *tp);
-	char *desc;
-};
-
 struct test_case tc[] = {
 	{
 	 .clktype = CLOCK_REALTIME,
@@ -63,73 +59,76 @@ struct test_case tc[] = {
 	 },
 };
 
-static int sys_clock_gettime(clockid_t clk_id, struct timespec *tp)
+struct __kernel_timespec kspec64;
+
+#ifdef TST_ABI32
+struct timespec spec32;
+struct __kernel_old_timespec kspec32;
+
+static int _clock_gettime(clockid_t clk_id, void *tp)
 {
-	return tst_syscall(__NR_clock_gettime, clk_id, tp);
+	return clock_gettime(clk_id, tp);
 }
 
-static int check_spec(struct timespec *spec)
+static int sys_clock_gettime64(clockid_t clk_id, void *tp)
 {
-	return (spec->tv_nsec != 0 || spec->tv_sec != 0) ? 1 : 0;
+	return tst_syscall(__NR_clock_gettime64, clk_id, tp);
 }
+#endif
 
-static void verify_clock_gettime(unsigned int i)
+static int sys_clock_gettime(clockid_t clk_id, void *tp)
 {
-	size_t sz;
-	struct timespec spec;
-
-	/*
-	 * check clock_gettime() syscall AND libc (or vDSO) functions
-	 */
-	struct tmpfunc tf[] = {
-		{ .func = sys_clock_gettime, .desc = "syscall"      },
-		{ .func = clock_gettime, .desc = "vDSO or syscall"  },
-	};
-
-	for (sz = 0; sz < ARRAY_SIZE(tf); sz++) {
-
-		memset(&spec, 0, sizeof(struct timespec));
-
-		TEST(tf[sz].func(tc[i].clktype, &spec));
-
-		if (TST_RET == -1) {
+	return tst_syscall(__NR_clock_gettime, clk_id, tp);
+}
 
-			/* errors: allow unsupported clock types */
+struct tmpfunc {
+	int (*func)(clockid_t clk_id, void *tp);
+	int (*check)(void *spec);
+	void *spec;
+	int spec_size;
+	char *desc;
+} variants[] = {
+#ifdef TST_ABI32
+	{ .func = _clock_gettime, .check = tst_timespec_updated_32, .spec = &spec32, .spec_size = sizeof(spec32), .desc = "vDSO or syscall (32)"},
+	{ .func = sys_clock_gettime, .check = tst_timespec_updated_32, .spec = &spec32, .spec_size = sizeof(spec32), .desc = "syscall (32) with libc spec"},
+	{ .func = sys_clock_gettime, .check = tst_timespec_updated_32, .spec = &kspec32, .spec_size = sizeof(kspec32), .desc = "syscall (32) with kernel spec"},
+	{ .func = sys_clock_gettime64, .check = tst_timespec_updated_64, .spec = &kspec64, .spec_size = sizeof(kspec64), .desc = "syscall (64) with kernel spec"},
+#else
+	{ .func = sys_clock_gettime, .check = tst_timespec_updated_64, .spec = &kspec64, .spec_size = sizeof(kspec64), .desc = "syscall (64) with kernel spec"},
+#endif
+};
 
-			if (tc[i].allow_inval && TST_ERR == EINVAL) {
+static void setup(void)
+{
+	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
+}
 
-				tst_res(TPASS, "clock_gettime(2): unsupported "
-						"clock %s (%s) failed as "
-						"expected",
-						tst_clock_name(tc[i].clktype),
-						tf[sz].desc);
+static void verify_clock_gettime(unsigned int i)
+{
+	struct tmpfunc *tf = &variants[tst_variant];
 
-			} else {
+	memset(tf->spec, 0, tf->spec_size);
 
-				tst_res(TFAIL | TTERRNO, "clock_gettime(2): "
-						"clock %s (%s) failed "
-						"unexpectedly",
-						tst_clock_name(tc[i].clktype),
-						tf[sz].desc);
-			}
+	TEST(tf->func(tc[i].clktype, tf->spec));
 
+	if (TST_RET == -1) {
+		/* errors: allow unsupported clock types */
+		if (tc[i].allow_inval && TST_ERR == EINVAL) {
+			tst_res(TPASS, "clock_gettime(2): unsupported clock %s failed as expected",
+				tst_clock_name(tc[i].clktype));
 		} else {
+			tst_res(TFAIL | TTERRNO, "clock_gettime(2): clock %s failed unexpectedly",
+				tst_clock_name(tc[i].clktype));
+		}
 
-			/* success: also check if timespec was changed */
-
-			if (check_spec(&spec)) {
-				tst_res(TPASS, "clock_gettime(2): clock %s "
-						"(%s) passed",
-						tst_clock_name(tc[i].clktype),
-						tf[sz].desc);
-			} else {
-
-				tst_res(TFAIL, "clock_gettime(2): clock %s "
-						"(%s) passed, unchanged "
-						"timespec",
-						tst_clock_name(tc[i].clktype),
-						tf[sz].desc);
-			}
+	} else {
+		/* success: also check if timespec was changed */
+		if (tf->check(tf->spec)) {
+			tst_res(TPASS, "clock_gettime(2): clock %s passed",
+				tst_clock_name(tc[i].clktype));
+		} else {
+			tst_res(TFAIL, "clock_gettime(2): clock %s passed, unchanged timespec",
+				tst_clock_name(tc[i].clktype));
 		}
 	}
 }
@@ -137,5 +136,7 @@ static void verify_clock_gettime(unsigned int i)
 static struct tst_test test = {
 	.test = verify_clock_gettime,
 	.tcnt = ARRAY_SIZE(tc),
+	.test_variants = ARRAY_SIZE(variants),
+	.setup = setup,
 	.needs_root = 1,
 };
-- 
2.21.0.rc0.269.g1a574e7a288b

