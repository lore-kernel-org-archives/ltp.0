From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 16 Apr 2020 16:12:31 +0530
Subject: [LTP] [PATCH V3 2/2] syscalls/clock_gettime: Add support for time64
 tests
In-Reply-To: <cover.1587033556.git.viresh.kumar@linaro.org>
References: <cover.1587033556.git.viresh.kumar@linaro.org>
Message-ID: <c0af2894e30186e4d7e7d231a5c567a7aed74113.1587033556.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds support for time64 tests to the existing clock_gettime()
syscall tests.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/tst_timer.h                                |  65 +++++++++++-
 .../syscalls/clock_gettime/clock_gettime01.c       | 116 +++++++++------------
 .../syscalls/clock_gettime/clock_gettime02.c       |  72 +++++++------
 .../syscalls/clock_gettime/clock_gettime03.c       |  55 ++++++++--
 4 files changed, 203 insertions(+), 105 deletions(-)

diff --git a/include/tst_timer.h b/include/tst_timer.h
index 0865fce88a2b..1f2893970397 100644
--- a/include/tst_timer.h
+++ b/include/tst_timer.h
@@ -15,6 +15,7 @@
 #include <sys/time.h>
 #include <time.h>
 #include "tst_test.h"
+#include "lapi/syscalls.h"
 
 #ifndef __kernel_timespec
 
@@ -42,7 +43,9 @@ struct __kernel_timespec {
 enum tst_timespec_type {
 	TST_LIBC_TIMESPEC,
 	TST_KERN_OLD_TIMESPEC,
-	TST_KERN_TIMESPEC
+	TST_KERN_TIMESPEC,
+	/* Used for indicating failure test with bad address */
+	TST_KERN_BAD_ADDR
 };
 
 struct tst_timespec {
@@ -54,6 +57,66 @@ struct tst_timespec {
 	};
 };
 
+static inline void *tst_get_timespec(struct tst_timespec *t)
+{
+	switch (t->type) {
+	case TST_LIBC_TIMESPEC:
+		return &t->libc_ts;
+	case TST_KERN_OLD_TIMESPEC:
+		return &t->kern_old_ts;
+	case TST_KERN_TIMESPEC:
+		return &t->kern_ts;
+	case TST_KERN_BAD_ADDR:
+		return tst_get_bad_addr(NULL);
+	default:
+		tst_brk(TBROK, "Invalid type: %d", t->type);
+		return NULL;
+	}
+}
+
+static inline int libc_clock_gettime(clockid_t clk_id, struct tst_timespec *t)
+{
+	return clock_gettime(clk_id, tst_get_timespec(t));
+}
+
+static inline int sys_clock_gettime(clockid_t clk_id, struct tst_timespec *t)
+{
+	return tst_syscall(__NR_clock_gettime, clk_id, tst_get_timespec(t));
+}
+
+static inline int sys_clock_gettime64(clockid_t clk_id, struct tst_timespec *t)
+{
+	return tst_syscall(__NR_clock_gettime64, clk_id, tst_get_timespec(t));
+}
+
+/*
+ * tst_timespec_nonzero return:
+ * 0: On success, i.e. timespec updated correctly.
+ * -1: Error, timespec not updated.
+ * -2: Error, tv_nsec is corrupted.
+ */
+static inline int tst_timespec_nonzero(struct tst_timespec *t)
+{
+	switch (t->type) {
+	case TST_LIBC_TIMESPEC:
+		return (t->libc_ts.tv_nsec == 0 && t->libc_ts.tv_sec == 0) ? -1 : 0;
+	case TST_KERN_OLD_TIMESPEC:
+		return (t->kern_old_ts.tv_nsec == 0 && t->kern_old_ts.tv_sec == 0) ? -1 : 0;
+	case TST_KERN_TIMESPEC:
+		if (t->kern_ts.tv_nsec == 0 && t->kern_ts.tv_sec == 0)
+			return -1;
+
+		/* Upper 32 bits of tv_nsec should be cleared */
+		if (t->kern_ts.tv_nsec >> 32)
+			return -2;
+		else
+			return 0;
+	default:
+		tst_brk(TBROK, "Invalid type: %d", t->type);
+		return -1;
+	}
+}
+
 /*
  * Converts timeval to microseconds.
  */
diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime01.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime01.c
index d365823b2f0f..f37bb1a54f77 100644
--- a/testcases/kernel/syscalls/clock_gettime/clock_gettime01.c
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime01.c
@@ -19,20 +19,14 @@
 #include "config.h"
 #include "tst_timer.h"
 #include "tst_safe_clocks.h"
-#include "tst_test.h"
-#include "lapi/syscalls.h"
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
-struct test_case tc[] = {
+static struct test_case tc[] = {
 	{
 	 .clktype = CLOCK_REALTIME,
 	 },
@@ -63,73 +57,65 @@ struct test_case tc[] = {
 	 },
 };
 
-static int sys_clock_gettime(clockid_t clk_id, struct timespec *tp)
-{
-	return tst_syscall(__NR_clock_gettime, clk_id, tp);
-}
+static struct tst_timespec spec;
 
-static int check_spec(struct timespec *spec)
+static struct test_variants {
+	int (*func)(clockid_t clk_id, struct tst_timespec *spec);
+	enum tst_timespec_type type;
+	char *desc;
+} variants[] = {
+#if defined(TST_ABI32)
+	{ .func = libc_clock_gettime, .type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
+	{ .func = sys_clock_gettime, .type = TST_LIBC_TIMESPEC, .desc = "syscall with libc spec"},
+	{ .func = sys_clock_gettime, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with kernel spec32"},
+#endif
+
+#if defined(TST_ABI64)
+	{ .func = sys_clock_gettime, .type = TST_KERN_TIMESPEC, .desc = "syscall with kernel spec64"},
+#endif
+
+#if (__NR_clock_gettime64 != __LTP__NR_INVALID_SYSCALL)
+	{ .func = sys_clock_gettime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec64"},
+#endif
+};
+
+static void setup(void)
 {
-	return (spec->tv_nsec != 0 || spec->tv_sec != 0) ? 1 : 0;
+	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
 }
 
 static void verify_clock_gettime(unsigned int i)
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
+	struct test_variants *tv = &variants[tst_variant];
+	int ret;
 
-		memset(&spec, 0, sizeof(struct timespec));
+	memset(&spec, 0, sizeof(spec));
+	spec.type = tv->type;
 
-		TEST(tf[sz].func(tc[i].clktype, &spec));
-
-		if (TST_RET == -1) {
-
-			/* errors: allow unsupported clock types */
-
-			if (tc[i].allow_inval && TST_ERR == EINVAL) {
-
-				tst_res(TPASS, "clock_gettime(2): unsupported "
-						"clock %s (%s) failed as "
-						"expected",
-						tst_clock_name(tc[i].clktype),
-						tf[sz].desc);
-
-			} else {
-
-				tst_res(TFAIL | TTERRNO, "clock_gettime(2): "
-						"clock %s (%s) failed "
-						"unexpectedly",
-						tst_clock_name(tc[i].clktype),
-						tf[sz].desc);
-			}
+	TEST(tv->func(tc[i].clktype, &spec));
 
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
+		ret = tst_timespec_nonzero(&spec);
+		if (!ret) {
+			tst_res(TPASS, "clock_gettime(2): clock %s passed",
+				tst_clock_name(tc[i].clktype));
+		} else if (ret == -1) {
+			tst_res(TFAIL, "clock_gettime(2): clock %s passed, unchanged timespec",
+				tst_clock_name(tc[i].clktype));
+		} else if (ret == -2) {
+			tst_res(TFAIL, "clock_gettime(2): clock %s passed, Corrupted timespec",
+				tst_clock_name(tc[i].clktype));
 		}
 	}
 }
@@ -137,5 +123,7 @@ static void verify_clock_gettime(unsigned int i)
 static struct tst_test test = {
 	.test = verify_clock_gettime,
 	.tcnt = ARRAY_SIZE(tc),
+	.test_variants = ARRAY_SIZE(variants),
+	.setup = setup,
 	.needs_root = 1,
 };
diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c
index b4bc6e2d55d4..ef322363b963 100644
--- a/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c
@@ -19,10 +19,9 @@
  */
 
 #include "config.h"
-#include "tst_test.h"
-#include "lapi/syscalls.h"
 #include "tst_timer.h"
 #include "tst_safe_clocks.h"
+#include "lapi/abisize.h"
 
 struct test_case {
 	clockid_t clktype;
@@ -30,7 +29,7 @@ struct test_case {
 	int allow_inval;
 };
 
-struct test_case tc[] = {
+static struct test_case tc[] = {
 	{
 	 .clktype = MAX_CLOCKS,
 	 .exp_err = EINVAL,
@@ -81,52 +80,67 @@ struct test_case tc[] = {
 	 },
 };
 
+static struct tst_timespec spec;
+
 /*
  * bad pointer w/ libc causes SIGSEGV signal, call syscall directly
  */
-static int sys_clock_gettime(clockid_t clk_id, struct timespec *tp)
+static struct test_variants {
+	int (*func)(clockid_t clk_id, struct tst_timespec *t);
+	enum tst_timespec_type type;
+	char *desc;
+} variants[] = {
+#if defined(TST_ABI32)
+	{ .func = sys_clock_gettime, .type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
+	{ .func = sys_clock_gettime, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with kernel spec32"},
+#endif
+
+#if defined(TST_ABI64)
+	{ .func = sys_clock_gettime, .type = TST_KERN_TIMESPEC, .desc = "syscall with kernel spec64"},
+#endif
+
+#if (__NR_clock_gettime64 != __LTP__NR_INVALID_SYSCALL)
+	{ .func = sys_clock_gettime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec64"},
+#endif
+};
+
+static void setup(void)
 {
-	return tst_syscall(__NR_clock_gettime, clk_id, tp);
+	tst_res(TINFO, "Testing variant: %d: %s", tst_variant, variants[tst_variant].desc);
 }
 
 static void verify_clock_gettime(unsigned int i)
 {
-	struct timespec spec, *specptr;
-
-	specptr = &spec;
+	struct test_variants *tv = &variants[tst_variant];
 
 	/* bad pointer cases */
 	if (tc[i].exp_err == EFAULT)
-		specptr = tst_get_bad_addr(NULL);
-
-	TEST(sys_clock_gettime(tc[i].clktype, specptr));
+		spec.type = TST_KERN_BAD_ADDR;
+	else
+		spec.type = tv->type;
 
-	if (TST_RET == -1) {
+	TEST(tv->func(tc[i].clktype, &spec));
 
-		if ((tc[i].exp_err == TST_ERR) ||
-			(tc[i].allow_inval && TST_ERR == EINVAL)) {
-
-			tst_res(TPASS | TTERRNO, "clock_gettime(2): "
-					"clock %s failed as expected",
-					tst_clock_name(tc[i].clktype));
-
-		} else {
-
-			tst_res(TFAIL | TTERRNO, "clock_gettime(2): "
-					"clock %s failed unexpectedly",
-					tst_clock_name(tc[i].clktype));
-		}
+	if (TST_RET != -1) {
+		tst_res(TFAIL, "clock_gettime(2): clock %s passed unexcpectedly",
+			tst_clock_name(tc[i].clktype));
+		return;
+	}
 
+	if ((tc[i].exp_err == TST_ERR) ||
+	    (tc[i].allow_inval && TST_ERR == EINVAL)) {
+		tst_res(TPASS | TTERRNO, "clock_gettime(2): clock %s failed as expected",
+			tst_clock_name(tc[i].clktype));
 	} else {
-
-		tst_res(TFAIL, "clock_gettime(2): clock %s passed"
-				" unexcpectedly",
-				tst_clock_name(tc[i].clktype));
+		tst_res(TFAIL | TTERRNO, "clock_gettime(2): clock %s failed unexpectedly",
+			tst_clock_name(tc[i].clktype));
 	}
 }
 
 static struct tst_test test = {
 	.test = verify_clock_gettime,
 	.tcnt = ARRAY_SIZE(tc),
+	.test_variants = ARRAY_SIZE(variants),
+	.setup = setup,
 	.needs_root = 1,
 };
diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
index cf4706fa0c30..ddc835c07669 100644
--- a/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
@@ -21,7 +21,7 @@
 #include "tst_safe_clocks.h"
 #include "tst_timer.h"
 #include "lapi/namespaces_constants.h"
-#include "tst_test.h"
+#include "lapi/abisize.h"
 
 static struct tcase {
 	int clk_id;
@@ -38,22 +38,46 @@ static struct tcase {
 	{CLOCK_MONOTONIC_COARSE, CLOCK_MONOTONIC, 100},
 };
 
-static struct timespec now;
+static struct tst_timespec now, then, parent_then;
 static int parent_ns;
 
-static void child(struct tcase *tc)
+static struct test_variants {
+	int (*func)(clockid_t clk_id, struct tst_timespec *spec);
+	enum tst_timespec_type type;
+	char *desc;
+} variants[] = {
+#if defined(TST_ABI32)
+	{ .func = libc_clock_gettime, .type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
+	{ .func = sys_clock_gettime, .type = TST_LIBC_TIMESPEC, .desc = "syscall with libc spec"},
+	{ .func = sys_clock_gettime, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with kernel spec32"},
+#endif
+
+#if defined(TST_ABI64)
+	{ .func = sys_clock_gettime, .type = TST_KERN_TIMESPEC, .desc = "syscall with kernel spec64"},
+#endif
+
+#if (__NR_clock_gettime64 != __LTP__NR_INVALID_SYSCALL)
+	{ .func = sys_clock_gettime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec64"},
+#endif
+};
+
+static void child(struct test_variants *tv, struct tcase *tc)
 {
-	struct timespec then;
-	struct timespec parent_then;
 	long long diff;
 
-	SAFE_CLOCK_GETTIME(tc->clk_id, &then);
+	if (tv->func(tc->clk_id, &then)) {
+		tst_brk(TBROK | TERRNO, "clock_gettime(%s) failed",
+			tst_clock_name(tc->clk_id));
+	}
 
 	SAFE_SETNS(parent_ns, CLONE_NEWTIME);
 
-	SAFE_CLOCK_GETTIME(tc->clk_id, &parent_then);
+	if (tv->func(tc->clk_id, &parent_then)) {
+		tst_brk(TBROK | TERRNO, "clock_gettime(%s) failed",
+			tst_clock_name(tc->clk_id));
+	}
 
-	diff = tst_timespec_diff_ms(then, now);
+	diff = tst_tst_timespec_diff_ms(then, now);
 
 	if (diff/1000 != tc->off) {
 		tst_res(TFAIL, "Wrong offset (%s) read %llims",
@@ -63,7 +87,7 @@ static void child(struct tcase *tc)
 		        tst_clock_name(tc->clk_id), diff);
 	}
 
-	diff = tst_timespec_diff_ms(parent_then, now);
+	diff = tst_tst_timespec_diff_ms(parent_then, now);
 
 	if (diff/1000) {
 		tst_res(TFAIL, "Wrong offset (%s) read %llims",
@@ -76,6 +100,7 @@ static void child(struct tcase *tc)
 
 static void verify_ns_clock(unsigned int n)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	struct tcase *tc = &tcases[n];
 
 	SAFE_UNSHARE(CLONE_NEWTIME);
@@ -83,14 +108,21 @@ static void verify_ns_clock(unsigned int n)
 	SAFE_FILE_PRINTF("/proc/self/timens_offsets", "%d %d 0",
 	                 tc->clk_off, tc->off);
 
-	SAFE_CLOCK_GETTIME(tc->clk_id, &now);
+	if (tv->func(tc->clk_id, &now)) {
+		tst_brk(TBROK | TERRNO, "%d clock_gettime(%s) failed",
+			__LINE__, tst_clock_name(tc->clk_id));
+	}
 
 	if (!SAFE_FORK())
-		child(tc);
+		child(tv, tc);
 }
 
 static void setup(void)
 {
+	struct test_variants *tv = &variants[tst_variant];
+
+	now.type = then.type = parent_then.type = tv->type;
+	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
 	parent_ns = SAFE_OPEN("/proc/self/ns/time_for_children", O_RDONLY);
 }
 
@@ -104,6 +136,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_ns_clock,
+	.test_variants = ARRAY_SIZE(variants),
 	.needs_root = 1,
 	.forks_child = 1,
 	.needs_kconfigs = (const char *[]) {
-- 
2.7.4

