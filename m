From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 24 Apr 2020 12:48:44 +0530
Subject: [LTP] [PATCH V5 3/5] syscalls/clock_getres: Add support for time64
 tests
In-Reply-To: <cover.1587533697.git.viresh.kumar@linaro.org>
References: <a143f48ffeec14739d35c07dfb95f237981a322d.1587712683.git.viresh.kumar@linaro.org>
Message-ID: <1f2c00709d36aa9bc810f201e3adb93808816851.1587712683.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds support for time64 tests to the existing clock_getres()
syscall tests.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/tst_timer.h                           | 18 ++++++
 .../syscalls/clock_getres/clock_getres01.c    | 58 ++++++++++++-------
 2 files changed, 54 insertions(+), 22 deletions(-)

diff --git a/include/tst_timer.h b/include/tst_timer.h
index 0c6b934157f9..4823d350fdc6 100644
--- a/include/tst_timer.h
+++ b/include/tst_timer.h
@@ -131,6 +131,9 @@ struct tst_ts {
 
 static inline void *tst_ts_get(struct tst_ts *t)
 {
+	if (!t)
+		return NULL;
+
 	switch (t->type) {
 	case TST_LIBC_TIMESPEC:
 		return &t->ts.libc_ts;
@@ -144,6 +147,21 @@ static inline void *tst_ts_get(struct tst_ts *t)
 	}
 }
 
+static inline int libc_clock_getres(clockid_t clk_id, void *ts)
+{
+	return clock_getres(clk_id, ts);
+}
+
+static inline int sys_clock_getres(clockid_t clk_id, void *ts)
+{
+	return tst_syscall(__NR_clock_getres, clk_id, ts);
+}
+
+static inline int sys_clock_getres64(clockid_t clk_id, void *ts)
+{
+	return tst_syscall(__NR_clock_getres_time64, clk_id, ts);
+}
+
 static inline int libc_clock_gettime(clockid_t clk_id, void *ts)
 {
 	return clock_gettime(clk_id, ts);
diff --git a/testcases/kernel/syscalls/clock_getres/clock_getres01.c b/testcases/kernel/syscalls/clock_getres/clock_getres01.c
index fcdf53b9cb79..5b83c2460f05 100644
--- a/testcases/kernel/syscalls/clock_getres/clock_getres01.c
+++ b/testcases/kernel/syscalls/clock_getres/clock_getres01.c
@@ -12,11 +12,9 @@
 
 #include <errno.h>
 
-#include "tst_test.h"
-#include "lapi/syscalls.h"
+#include "tst_timer.h"
 #include "lapi/posix_clocks.h"
-
-static struct timespec *res;
+#include "lapi/abisize.h"
 
 static struct test_case {
 	char *name;
@@ -37,29 +35,45 @@ static struct test_case {
 	{"-1", -1, -1, EINVAL},
 };
 
-static const char *variant_desc[] = {
-	"default (vdso or syscall)",
-	"syscall",
-	"syscall with NULL res parameter" };
+static struct tst_ts *tspec, *nspec = NULL;
+
+static struct test_variants {
+	int (*func)(clockid_t clk_id, void *ts);
+	enum tst_ts_type type;
+	struct tst_ts **spec;
+	char *desc;
+} variants[] = {
+#if defined(TST_ABI32)
+	{ .func = libc_clock_getres, .type = TST_LIBC_TIMESPEC, .spec = &tspec, .desc = "vDSO or syscall with libc spec"},
+	{ .func = libc_clock_getres, .type = TST_LIBC_TIMESPEC, .spec = &nspec, .desc = "vDSO or syscall with libc spec with NULL res"},
+	{ .func = sys_clock_getres, .type = TST_LIBC_TIMESPEC, .spec = &tspec, .desc = "syscall with libc spec"},
+	{ .func = sys_clock_getres, .type = TST_LIBC_TIMESPEC, .spec = &nspec, .desc = "syscall with libc spec with NULL res"},
+	{ .func = sys_clock_getres, .type = TST_KERN_OLD_TIMESPEC, .spec = &tspec, .desc = "syscall with kernel spec32"},
+	{ .func = sys_clock_getres, .type = TST_KERN_OLD_TIMESPEC, .spec = &nspec, .desc = "syscall with kernel spec32 with NULL res"},
+#endif
+
+#if defined(TST_ABI64)
+	{ .func = sys_clock_getres, .type = TST_KERN_TIMESPEC, .spec = &tspec, .desc = "syscall with kernel spec64"},
+	{ .func = sys_clock_getres, .type = TST_KERN_TIMESPEC, .spec = &nspec, .desc = "syscall with kernel spec64 with NULL res"},
+#endif
+
+#if (__NR_clock_getres_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .func = sys_clock_getres64, .type = TST_KERN_TIMESPEC, .spec = &tspec, .desc = "syscall time64 with kernel spec64"},
+	{ .func = sys_clock_getres64, .type = TST_KERN_TIMESPEC, .spec = &nspec, .desc = "syscall time64 with kernel spec64 with NULL res"},
+#endif
+};
 
 static void setup(void)
 {
-	tst_res(TINFO, "Testing variant: %s", variant_desc[tst_variant]);
+	tspec->type = variants[tst_variant].type;
+	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
 }
 
 static void do_test(unsigned int i)
 {
-	switch (tst_variant) {
-	case 0:
-		TEST(clock_getres(tcase[i].clk_id, res));
-		break;
-	case 1:
-		TEST(tst_syscall(__NR_clock_getres, tcase[i].clk_id, res));
-		break;
-	case 2:
-		TEST(tst_syscall(__NR_clock_getres, tcase[i].clk_id, NULL));
-		break;
-	}
+	struct test_variants *tv = &variants[tst_variant];
+
+	TEST(tv->func(tcase[i].clk_id, tst_ts_get(*tv->spec)));
 
 	if (TST_RET != tcase[i].ret) {
 		if (TST_ERR == EINVAL) {
@@ -84,10 +98,10 @@ static void do_test(unsigned int i)
 static struct tst_test test = {
 	.test = do_test,
 	.tcnt = ARRAY_SIZE(tcase),
-	.test_variants = 3,
+	.test_variants = ARRAY_SIZE(variants),
 	.setup = setup,
 	.bufs = (struct tst_buffers []) {
-		{&res, .size = sizeof(*res)},
+		{&tspec, .size = sizeof(*tspec)},
 		{},
 	}
 };
-- 
2.25.0.rc1.19.g042ed3e048af

