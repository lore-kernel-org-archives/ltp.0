From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 22 Apr 2020 11:07:23 +0530
Subject: [LTP] [PATCH V4 2/5] syscalls/clock_settime: Add support for time64
 tests
In-Reply-To: <cover.1587533697.git.viresh.kumar@linaro.org>
References: <cover.1587533697.git.viresh.kumar@linaro.org>
Message-ID: <22ce1a3bac6cdc36916277cc040711cd0bf27fe5.1587533697.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds support for time64 tests to the existing clock_settime()
syscall tests.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/tst_timer.h                           | 15 +++
 .../syscalls/clock_settime/clock_settime01.c  | 87 ++++++++++++++---
 .../syscalls/clock_settime/clock_settime02.c  | 95 ++++++++++++-------
 3 files changed, 146 insertions(+), 51 deletions(-)

diff --git a/include/tst_timer.h b/include/tst_timer.h
index f40b93a624b3..fef201ee04df 100644
--- a/include/tst_timer.h
+++ b/include/tst_timer.h
@@ -163,6 +163,21 @@ static inline int sys_clock_gettime64(clockid_t clk_id, struct tst_ts *t)
 	return tst_syscall(__NR_clock_gettime64, clk_id, tst_get_ts(t));
 }
 
+static inline int libc_clock_settime(clockid_t clk_id, struct tst_ts *t)
+{
+	return clock_settime(clk_id, tst_get_ts(t));
+}
+
+static inline int sys_clock_settime(clockid_t clk_id, struct tst_ts *t)
+{
+	return tst_syscall(__NR_clock_settime, clk_id, tst_get_ts(t));
+}
+
+static inline int sys_clock_settime64(clockid_t clk_id, struct tst_ts *t)
+{
+	return tst_syscall(__NR_clock_settime64, clk_id, tst_get_ts(t));
+}
+
 /*
  * tst_ts_nonzero return:
  * 0: On success, i.e. timespec updated correctly.
diff --git a/testcases/kernel/syscalls/clock_settime/clock_settime01.c b/testcases/kernel/syscalls/clock_settime/clock_settime01.c
index 62d3491544a6..199264974ed0 100644
--- a/testcases/kernel/syscalls/clock_settime/clock_settime01.c
+++ b/testcases/kernel/syscalls/clock_settime/clock_settime01.c
@@ -16,31 +16,72 @@
 #include "config.h"
 #include "tst_timer.h"
 #include "tst_safe_clocks.h"
-#include "tst_test.h"
-#include "lapi/syscalls.h"
+#include "lapi/abisize.h"
 
 #define DELTA_SEC 10
 #define DELTA_US (long long) (DELTA_SEC * 1000000)
 #define DELTA_EPS (long long) (DELTA_US * 0.1)
 
-static struct timespec *begin, *change, *end;
+static struct tst_ts *begin, *change, *end;
+
+static struct test_variants {
+	int (*gettime)(clockid_t clk_id, struct tst_ts *spec);
+	int (*settime)(clockid_t clk_id, struct tst_ts *spec);
+	enum tst_ts_type type;
+	char *desc;
+} variants[] = {
+#if defined(TST_ABI32)
+	{ .gettime = libc_clock_gettime, .settime = libc_clock_settime, .type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
+	{ .gettime = sys_clock_gettime, .settime = sys_clock_settime, .type = TST_LIBC_TIMESPEC, .desc = "syscall with libc spec"},
+	{ .gettime = sys_clock_gettime, .settime = sys_clock_settime, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with kernel spec32"},
+#endif
+
+#if defined(TST_ABI64)
+	{ .gettime = sys_clock_gettime, .settime = sys_clock_settime, .type = TST_KERN_TIMESPEC, .desc = "syscall with kernel spec64"},
+#endif
+
+#if (__NR_clock_settime64 != __LTP__NR_INVALID_SYSCALL)
+	{ .gettime = sys_clock_gettime64, .settime = sys_clock_settime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec64"},
+#endif
+};
+
+static void setup(void)
+{
+	begin->type = change->type = end->type = variants[tst_variant].type;
+	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
+}
 
 static void verify_clock_settime(void)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	long long elapsed;
 
 	/* test 01: move forward */
 
-	SAFE_CLOCK_GETTIME(CLOCK_REALTIME, begin);
+	TEST(tv->gettime(CLOCK_REALTIME, begin));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "clock_gettime(2) failed for clock %s",
+			tst_clock_name(CLOCK_REALTIME));
+		return;
+	}
 
-	*change = tst_timespec_add_us(*begin, DELTA_US);
+	*change = tst_ts_add_us(*begin, DELTA_US);
 
-	if (clock_settime(CLOCK_REALTIME, change) != 0)
-		tst_brk(TBROK | TTERRNO, "could not set realtime change");
+	TEST(tv->settime(CLOCK_REALTIME, change));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "clock_settime(2) failed for clock %s",
+			tst_clock_name(CLOCK_REALTIME));
+		return;
+	}
 
-	SAFE_CLOCK_GETTIME(CLOCK_REALTIME, end);
+	TEST(tv->gettime(CLOCK_REALTIME, end));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "clock_gettime(2) failed for clock %s",
+			tst_clock_name(CLOCK_REALTIME));
+		return;
+	}
 
-	elapsed = tst_timespec_diff_us(*end, *begin);
+	elapsed = tst_ts_diff_us(*end, *begin);
 
 	if (elapsed >= DELTA_US && elapsed < (DELTA_US + DELTA_EPS))
 		tst_res(TPASS, "clock_settime(2): was able to advance time");
@@ -49,16 +90,30 @@ static void verify_clock_settime(void)
 
 	/* test 02: move backward */
 
-	SAFE_CLOCK_GETTIME(CLOCK_REALTIME, begin);
+	TEST(tv->gettime(CLOCK_REALTIME, begin));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "clock_gettime(2) failed for clock %s",
+			tst_clock_name(CLOCK_REALTIME));
+		return;
+	}
 
-	*change = tst_timespec_sub_us(*begin, DELTA_US);
+	*change = tst_ts_sub_us(*begin, DELTA_US);
 
-	if (clock_settime(CLOCK_REALTIME, change) != 0)
-		tst_brk(TBROK | TTERRNO, "could not set realtime change");
+	TEST(tv->settime(CLOCK_REALTIME, change));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "clock_settime(2) failed for clock %s",
+			tst_clock_name(CLOCK_REALTIME));
+		return;
+	}
 
-	SAFE_CLOCK_GETTIME(CLOCK_REALTIME, end);
+	TEST(tv->gettime(CLOCK_REALTIME, end));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "clock_gettime(2) failed for clock %s",
+			tst_clock_name(CLOCK_REALTIME));
+		return;
+	}
 
-	elapsed = tst_timespec_diff_us(*end, *begin);
+	elapsed = tst_ts_diff_us(*end, *begin);
 
 	if (~(elapsed) <= DELTA_US && ~(elapsed) > (DELTA_US - DELTA_EPS))
 		tst_res(TPASS, "clock_settime(2): was able to recede time");
@@ -68,6 +123,8 @@ static void verify_clock_settime(void)
 
 static struct tst_test test = {
 	.test_all = verify_clock_settime,
+	.test_variants = ARRAY_SIZE(variants),
+	.setup = setup,
 	.needs_root = 1,
 	.restore_wallclock = 1,
 	.bufs = (struct tst_buffers []) {
diff --git a/testcases/kernel/syscalls/clock_settime/clock_settime02.c b/testcases/kernel/syscalls/clock_settime/clock_settime02.c
index e16e9061a972..29548d5a4be2 100644
--- a/testcases/kernel/syscalls/clock_settime/clock_settime02.c
+++ b/testcases/kernel/syscalls/clock_settime/clock_settime02.c
@@ -9,19 +9,19 @@
  */
 
 #include "config.h"
-#include "tst_test.h"
-#include "lapi/syscalls.h"
 #include "tst_timer.h"
 #include "tst_safe_clocks.h"
+#include "lapi/abisize.h"
 
 #define DELTA_SEC 10
 #define NSEC_PER_SEC (1000000000L)
 
 struct test_case {
 	clockid_t type;
-	struct timespec newtime;
 	int exp_err;
 	int replace;
+	long tv_sec;
+	long tv_nsec;
 };
 
 struct test_case tc[] = {
@@ -29,24 +29,29 @@ struct test_case tc[] = {
 	 .type = CLOCK_REALTIME,
 	 .exp_err = EFAULT,
 	 .replace = 1,
+	 .tv_sec = 0,
+	 .tv_nsec = 0,
 	 },
 	{				/* case 02: REALTIME: tv_sec = -1     */
 	 .type = CLOCK_REALTIME,
-	 .newtime.tv_sec = -1,
 	 .exp_err = EINVAL,
 	 .replace = 1,
+	 .tv_sec = -1,
+	 .tv_nsec = 0,
 	 },
 	{				/* case 03: REALTIME: tv_nsec = -1    */
 	 .type = CLOCK_REALTIME,
-	 .newtime.tv_nsec = -1,
 	 .exp_err = EINVAL,
 	 .replace = 1,
+	 .tv_sec = 0,
+	 .tv_nsec = -1,
 	 },
 	{				/* case 04: REALTIME: tv_nsec = 1s+1  */
 	 .type = CLOCK_REALTIME,
-	 .newtime.tv_nsec = NSEC_PER_SEC + 1,
 	 .exp_err = EINVAL,
 	 .replace = 1,
+	 .tv_sec = 0,
+	 .tv_nsec = NSEC_PER_SEC + 1,
 	 },
 	{				/* case 05: MONOTONIC		      */
 	 .type = CLOCK_MONOTONIC,
@@ -83,64 +88,82 @@ struct test_case tc[] = {
 	 },
 };
 
-/*
- * Some tests may cause libc to segfault when passing bad arguments.
- */
-static int sys_clock_settime(clockid_t clk_id, struct timespec *tp)
+static struct tst_ts spec;
+
+static struct test_variants {
+	int (*gettime)(clockid_t clk_id, struct tst_ts *spec);
+	int (*settime)(clockid_t clk_id, struct tst_ts *spec);
+	enum tst_ts_type type;
+	char *desc;
+} variants[] = {
+#if defined(TST_ABI32)
+	{ .gettime = sys_clock_gettime, .settime = sys_clock_settime, .type = TST_LIBC_TIMESPEC, .desc = "syscall with libc spec"},
+	{ .gettime = sys_clock_gettime, .settime = sys_clock_settime, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with kernel spec32"},
+#endif
+
+#if defined(TST_ABI64)
+	{ .gettime = sys_clock_gettime, .settime = sys_clock_settime, .type = TST_KERN_TIMESPEC, .desc = "syscall with kernel spec64"},
+#endif
+
+#if (__NR_clock_settime64 != __LTP__NR_INVALID_SYSCALL)
+	{ .gettime = sys_clock_gettime64, .settime = sys_clock_settime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec64"},
+#endif
+};
+
+static void setup(void)
 {
-	return tst_syscall(__NR_clock_settime, clk_id, tp);
+	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
 }
 
 static void verify_clock_settime(unsigned int i)
 {
-	struct timespec spec, *specptr;
+	struct test_variants *tv = &variants[tst_variant];
 
-	specptr = &spec;
+	spec.type = tv->type;
 
 	if (tc[i].replace == 0) {
-
-		SAFE_CLOCK_GETTIME(CLOCK_REALTIME, specptr);
+		TEST(tv->gettime(CLOCK_REALTIME, &spec));
+		if (TST_RET == -1) {
+			tst_res(TFAIL | TTERRNO, "clock_gettime(2) failed for clock %s",
+				tst_clock_name(CLOCK_REALTIME));
+			return;
+		}
 
 		/* add 1 sec to wall clock */
-		specptr->tv_sec += 1;
-
+		spec = tst_ts_add_us(spec, 1000000);
 	} else {
-
 		/* use given time spec */
-		*specptr = tc[i].newtime;
+		tst_ts_set_sec(&spec, tc[i].tv_sec);
+		tst_ts_set_nsec(&spec, tc[i].tv_nsec);
 	}
 
 	/* bad pointer case */
 	if (tc[i].exp_err == EFAULT)
-		specptr = tst_get_bad_addr(NULL);
-
-	TEST(sys_clock_settime(tc[i].type, specptr));
+		spec.type = TST_KERN_BAD_ADDR;
 
-	if (TST_RET == -1) {
+	TEST(tv->settime(tc[i].type, &spec));
 
-		if (tc[i].exp_err == TST_ERR) {
-			tst_res(TPASS | TTERRNO,
-				"clock_settime(%s): failed as expected",
-				tst_clock_name(tc[i].type));
-			return;
-		}
-
-		tst_res(TFAIL | TTERRNO, "clock_settime(2): clock %s "
-			"expected to fail with %s",
+	if (TST_RET != -1) {
+		tst_res(TFAIL | TTERRNO, "clock_settime(2): clock %s passed unexpectedly, expected %s",
 			tst_clock_name(tc[i].type),
 			tst_strerrno(tc[i].exp_err));
+		return;
+	}
 
+	if (tc[i].exp_err == TST_ERR) {
+		tst_res(TPASS | TTERRNO, "clock_settime(%s): failed as expected",
+			tst_clock_name(tc[i].type));
 		return;
 	}
 
-	tst_res(TFAIL | TTERRNO, "clock_settime(2): clock %s passed "
-				 "unexpectedly, expected %s",
-				 tst_clock_name(tc[i].type),
-				 tst_strerrno(tc[i].exp_err));
+	tst_res(TFAIL | TTERRNO, "clock_settime(2): clock %s " "expected to fail with %s",
+		tst_clock_name(tc[i].type), tst_strerrno(tc[i].exp_err));
 }
 
 static struct tst_test test = {
 	.test = verify_clock_settime,
+	.test_variants = ARRAY_SIZE(variants),
+	.setup = setup,
 	.tcnt = ARRAY_SIZE(tc),
 	.needs_root = 1,
 	.restore_wallclock = 1,
-- 
2.25.0.rc1.19.g042ed3e048af

