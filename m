From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 16 Sep 2020 16:07:48 +0530
Subject: [LTP] [PATCH V2 03/17] syscalls: clock_gettime: Reuse struct
 time64_variants
In-Reply-To: <cover.1600252542.git.viresh.kumar@linaro.org>
References: <cover.1600252542.git.viresh.kumar@linaro.org>
Message-ID: <9b8795efe3813dd44d7805cd4f64d915fc48cb76.1600252542.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Lets reuse the common structure here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../syscalls/clock_gettime/clock_gettime01.c  | 19 +++++-------
 .../syscalls/clock_gettime/clock_gettime02.c  | 17 +++++------
 .../syscalls/clock_gettime/clock_gettime03.c  | 27 ++++++++---------
 .../syscalls/clock_gettime/clock_gettime04.c  | 29 +++++++++----------
 4 files changed, 40 insertions(+), 52 deletions(-)

diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime01.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime01.c
index 769ac32cd038..be9573afcc8e 100644
--- a/testcases/kernel/syscalls/clock_gettime/clock_gettime01.c
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime01.c
@@ -17,6 +17,7 @@
  */
 
 #include "config.h"
+#include "time64_variants.h"
 #include "tst_timer.h"
 #include "tst_safe_clocks.h"
 
@@ -58,19 +59,15 @@ static struct test_case tc[] = {
 
 static struct tst_ts spec;
 
-static struct test_variants {
-	int (*func)(clockid_t clk_id, void *ts);
-	enum tst_ts_type type;
-	char *desc;
-} variants[] = {
-	{ .func = libc_clock_gettime, .type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
+static struct time64_variants variants[] = {
+	{ .clock_gettime = libc_clock_gettime, .ts_type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
 
 #if (__NR_clock_gettime != __LTP__NR_INVALID_SYSCALL)
-	{ .func = sys_clock_gettime, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+	{ .clock_gettime = sys_clock_gettime, .ts_type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
 #endif
 
 #if (__NR_clock_gettime64 != __LTP__NR_INVALID_SYSCALL)
-	{ .func = sys_clock_gettime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+	{ .clock_gettime = sys_clock_gettime64, .ts_type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
 #endif
 };
 
@@ -81,13 +78,13 @@ static void setup(void)
 
 static void verify_clock_gettime(unsigned int i)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 	int ret;
 
 	memset(&spec, 0, sizeof(spec));
-	spec.type = tv->type;
+	spec.type = tv->ts_type;
 
-	TEST(tv->func(tc[i].clktype, tst_ts_get(&spec)));
+	TEST(tv->clock_gettime(tc[i].clktype, tst_ts_get(&spec)));
 
 	if (TST_RET == -1) {
 		/* errors: allow unsupported clock types */
diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c
index f26db7c577e3..b0a9e9067142 100644
--- a/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c
@@ -19,6 +19,7 @@
  */
 
 #include "config.h"
+#include "time64_variants.h"
 #include "tst_timer.h"
 #include "tst_safe_clocks.h"
 
@@ -86,17 +87,13 @@ static struct tst_ts spec;
 /*
  * bad pointer w/ libc causes SIGSEGV signal, call syscall directly
  */
-static struct test_variants {
-	int (*func)(clockid_t clk_id, void *ts);
-	enum tst_ts_type type;
-	char *desc;
-} variants[] = {
+static struct time64_variants variants[] = {
 #if (__NR_clock_gettime != __LTP__NR_INVALID_SYSCALL)
-	{ .func = sys_clock_gettime, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+	{ .clock_gettime = sys_clock_gettime, .ts_type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
 #endif
 
 #if (__NR_clock_gettime64 != __LTP__NR_INVALID_SYSCALL)
-	{ .func = sys_clock_gettime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+	{ .clock_gettime = sys_clock_gettime64, .ts_type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
 #endif
 };
 
@@ -109,18 +106,18 @@ static void setup(void)
 
 static void verify_clock_gettime(unsigned int i)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 	void *ts;
 
 	/* bad pointer cases */
 	if (tc[i].exp_err == EFAULT) {
 		ts = bad_addr;
 	} else {
-		spec.type = tv->type;
+		spec.type = tv->ts_type;
 		ts = tst_ts_get(&spec);
 	}
 
-	TEST(tv->func(tc[i].clktype, ts));
+	TEST(tv->clock_gettime(tc[i].clktype, ts));
 
 	if (TST_RET != -1) {
 		tst_res(TFAIL, "clock_gettime(2): clock %s passed unexcpectedly",
diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
index 8341051088d7..dc570a06c55c 100644
--- a/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
@@ -18,6 +18,7 @@
  */
 
 #define _GNU_SOURCE
+#include "time64_variants.h"
 #include "tst_safe_clocks.h"
 #include "tst_timer.h"
 #include "lapi/namespaces_constants.h"
@@ -40,27 +41,23 @@ static struct tcase {
 static struct tst_ts now, then, parent_then;
 static int parent_ns;
 
-static struct test_variants {
-	int (*func)(clockid_t clk_id, void *ts);
-	enum tst_ts_type type;
-	char *desc;
-} variants[] = {
-	{ .func = libc_clock_gettime, .type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
+static struct time64_variants variants[] = {
+	{ .clock_gettime = libc_clock_gettime, .ts_type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
 
 #if (__NR_clock_gettime != __LTP__NR_INVALID_SYSCALL)
-	{ .func = sys_clock_gettime, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+	{ .clock_gettime = sys_clock_gettime, .ts_type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
 #endif
 
 #if (__NR_clock_gettime64 != __LTP__NR_INVALID_SYSCALL)
-	{ .func = sys_clock_gettime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+	{ .clock_gettime = sys_clock_gettime64, .ts_type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
 #endif
 };
 
-static void child(struct test_variants *tv, struct tcase *tc)
+static void child(struct time64_variants *tv, struct tcase *tc)
 {
 	long long diff;
 
-	if (tv->func(tc->clk_id, tst_ts_get(&then))) {
+	if (tv->clock_gettime(tc->clk_id, tst_ts_get(&then))) {
 		tst_res(TFAIL | TERRNO, "clock_gettime(%s) failed",
 			tst_clock_name(tc->clk_id));
 		return;
@@ -68,7 +65,7 @@ static void child(struct test_variants *tv, struct tcase *tc)
 
 	SAFE_SETNS(parent_ns, CLONE_NEWTIME);
 
-	if (tv->func(tc->clk_id, tst_ts_get(&parent_then))) {
+	if (tv->clock_gettime(tc->clk_id, tst_ts_get(&parent_then))) {
 		tst_res(TFAIL | TERRNO, "clock_gettime(%s) failed",
 			tst_clock_name(tc->clk_id));
 		return;
@@ -97,7 +94,7 @@ static void child(struct test_variants *tv, struct tcase *tc)
 
 static void verify_ns_clock(unsigned int n)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 	struct tcase *tc = &tcases[n];
 
 	SAFE_UNSHARE(CLONE_NEWTIME);
@@ -105,7 +102,7 @@ static void verify_ns_clock(unsigned int n)
 	SAFE_FILE_PRINTF("/proc/self/timens_offsets", "%d %d 0",
 	                 tc->clk_off, tc->off);
 
-	if (tv->func(tc->clk_id, tst_ts_get(&now))) {
+	if (tv->clock_gettime(tc->clk_id, tst_ts_get(&now))) {
 		tst_res(TFAIL | TERRNO, "%d clock_gettime(%s) failed",
 			__LINE__, tst_clock_name(tc->clk_id));
 		return;
@@ -117,9 +114,9 @@ static void verify_ns_clock(unsigned int n)
 
 static void setup(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 
-	now.type = then.type = parent_then.type = tv->type;
+	now.type = then.type = parent_then.type = tv->ts_type;
 	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
 	parent_ns = SAFE_OPEN("/proc/self/ns/time_for_children", O_RDONLY);
 }
diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
index c54faa3058c3..5f8264cc65ef 100644
--- a/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
@@ -9,6 +9,7 @@
 
 #include "config.h"
 #include "parse_vdso.h"
+#include "time64_variants.h"
 #include "tst_timer.h"
 #include "tst_safe_clocks.h"
 
@@ -62,23 +63,19 @@ static inline int my_gettimeofday(clockid_t clk_id, void *ts)
 	return 0;
 }
 
-static struct test_variants {
-	int (*gettime)(clockid_t clk_id, void *ts);
-	enum tst_ts_type type;
-	char *desc;
-} variants[] = {
-	{ .gettime = libc_clock_gettime, .type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
+static struct time64_variants variants[] = {
+	{ .clock_gettime = libc_clock_gettime, .ts_type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
 
 #if (__NR_clock_gettime != __LTP__NR_INVALID_SYSCALL)
-	{ .gettime = sys_clock_gettime, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
-	{ .gettime = vdso_gettime, .type = TST_KERN_OLD_TIMESPEC, .desc = "vDSO with old kernel spec"},
+	{ .clock_gettime = sys_clock_gettime, .ts_type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+	{ .clock_gettime = vdso_gettime, .ts_type = TST_KERN_OLD_TIMESPEC, .desc = "vDSO with old kernel spec"},
 #endif
 
 #if (__NR_clock_gettime64 != __LTP__NR_INVALID_SYSCALL)
-	{ .gettime = sys_clock_gettime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
-	{ .gettime = vdso_gettime64, .type = TST_KERN_TIMESPEC, .desc = "vDSO time64 with kernel spec"},
+	{ .clock_gettime = sys_clock_gettime64, .ts_type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+	{ .clock_gettime = vdso_gettime64, .ts_type = TST_KERN_TIMESPEC, .desc = "vDSO time64 with kernel spec"},
 #endif
-	{ .gettime = my_gettimeofday, .type = TST_LIBC_TIMESPEC, .desc = "gettimeofday"},
+	{ .clock_gettime = my_gettimeofday, .ts_type = TST_LIBC_TIMESPEC, .desc = "gettimeofday"},
 };
 
 static void setup(void)
@@ -95,7 +92,7 @@ static void run(unsigned int i)
 {
 	struct tst_ts ts;
 	long long start, end = 0, diff, slack;
-	struct test_variants *tv;
+	struct time64_variants *tv;
 	int count = 10000, ret;
 	unsigned int j;
 
@@ -105,13 +102,13 @@ static void run(unsigned int i)
 			start = end;
 
 			tv = &variants[j];
-			ts.type = tv->type;
+			ts.type = tv->ts_type;
 
 			/* Do gettimeofday() test only for CLOCK_REALTIME */
-			if (tv->gettime == my_gettimeofday && clks[i] != CLOCK_REALTIME)
+			if (tv->clock_gettime == my_gettimeofday && clks[i] != CLOCK_REALTIME)
 				continue;
 
-			ret = tv->gettime(clks[i], tst_ts_get(&ts));
+			ret = tv->clock_gettime(clks[i], tst_ts_get(&ts));
 			if (ret) {
 				/*
 				 * _vdso_gettime() sets error to ENOSYS if vdso
@@ -135,7 +132,7 @@ static void run(unsigned int i)
 			 * gettimeofday() doesn't capture time less than 1 us,
 			 * add 999 to it.
 			 */
-			if (tv->gettime == my_gettimeofday)
+			if (tv->clock_gettime == my_gettimeofday)
 				slack = 999;
 			else
 				slack = 0;
-- 
2.25.0.rc1.19.g042ed3e048af

