From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 16 Sep 2020 16:07:50 +0530
Subject: [LTP] [PATCH V2 05/17] syscalls: clock_settime: Reuse struct
 time64_variants
In-Reply-To: <cover.1600252542.git.viresh.kumar@linaro.org>
References: <cover.1600252542.git.viresh.kumar@linaro.org>
Message-ID: <98c41b19bf7e98930fd7a541ae6a67805262c396.1600252542.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Lets reuse the common structure here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../syscalls/clock_settime/clock_settime01.c  | 26 ++++++++-----------
 .../syscalls/clock_settime/clock_settime02.c  | 20 ++++++--------
 .../syscalls/clock_settime/clock_settime03.c  | 22 ++++++----------
 3 files changed, 27 insertions(+), 41 deletions(-)

diff --git a/testcases/kernel/syscalls/clock_settime/clock_settime01.c b/testcases/kernel/syscalls/clock_settime/clock_settime01.c
index ba6045fc5c8f..19bddbcd30ef 100644
--- a/testcases/kernel/syscalls/clock_settime/clock_settime01.c
+++ b/testcases/kernel/syscalls/clock_settime/clock_settime01.c
@@ -14,6 +14,7 @@
  */
 
 #include "config.h"
+#include "time64_variants.h"
 #include "tst_timer.h"
 #include "tst_safe_clocks.h"
 
@@ -23,41 +24,36 @@
 
 static struct tst_ts *begin, *change, *end;
 
-static struct test_variants {
-	int (*gettime)(clockid_t clk_id, void *ts);
-	int (*settime)(clockid_t clk_id, void *ts);
-	enum tst_ts_type type;
-	char *desc;
-} variants[] = {
-	{ .gettime = libc_clock_gettime, .settime = libc_clock_settime, .type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
+static struct time64_variants variants[] = {
+	{ .clock_gettime = libc_clock_gettime, .clock_settime = libc_clock_settime, .ts_type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
 
 #if (__NR_clock_settime != __LTP__NR_INVALID_SYSCALL)
-	{ .gettime = sys_clock_gettime, .settime = sys_clock_settime, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+	{ .clock_gettime = sys_clock_gettime, .clock_settime = sys_clock_settime, .ts_type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
 #endif
 
 #if (__NR_clock_settime64 != __LTP__NR_INVALID_SYSCALL)
-	{ .gettime = sys_clock_gettime64, .settime = sys_clock_settime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+	{ .clock_gettime = sys_clock_gettime64, .clock_settime = sys_clock_settime64, .ts_type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
 #endif
 };
 
 static void setup(void)
 {
-	begin->type = change->type = end->type = variants[tst_variant].type;
+	begin->type = change->type = end->type = variants[tst_variant].ts_type;
 	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
 }
 
-static void do_clock_gettime(struct test_variants *tv, struct tst_ts *ts)
+static void do_clock_gettime(struct time64_variants *tv, struct tst_ts *ts)
 {
 	int ret;
 
-	ret = tv->gettime(CLOCK_REALTIME, tst_ts_get(ts));
+	ret = tv->clock_gettime(CLOCK_REALTIME, tst_ts_get(ts));
 	if (ret == -1)
 		tst_brk(TBROK | TERRNO, "clock_settime(CLOCK_REALTIME) failed");
 }
 
 static void verify_clock_settime(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 	long long elapsed;
 
 	/* test 01: move forward */
@@ -65,7 +61,7 @@ static void verify_clock_settime(void)
 
 	*change = tst_ts_add_us(*begin, DELTA_US);
 
-	TEST(tv->settime(CLOCK_REALTIME, tst_ts_get(change)));
+	TEST(tv->clock_settime(CLOCK_REALTIME, tst_ts_get(change)));
 	if (TST_RET == -1) {
 		tst_res(TFAIL | TTERRNO, "clock_settime(2) failed for clock %s",
 			tst_clock_name(CLOCK_REALTIME));
@@ -86,7 +82,7 @@ static void verify_clock_settime(void)
 
 	*change = tst_ts_sub_us(*begin, DELTA_US);
 
-	TEST(tv->settime(CLOCK_REALTIME, tst_ts_get(change)));
+	TEST(tv->clock_settime(CLOCK_REALTIME, tst_ts_get(change)));
 	if (TST_RET == -1) {
 		tst_res(TFAIL | TTERRNO, "clock_settime(2) failed for clock %s",
 			tst_clock_name(CLOCK_REALTIME));
diff --git a/testcases/kernel/syscalls/clock_settime/clock_settime02.c b/testcases/kernel/syscalls/clock_settime/clock_settime02.c
index 0a8245dd4889..88d4492456f8 100644
--- a/testcases/kernel/syscalls/clock_settime/clock_settime02.c
+++ b/testcases/kernel/syscalls/clock_settime/clock_settime02.c
@@ -9,6 +9,7 @@
  */
 
 #include "config.h"
+#include "time64_variants.h"
 #include "tst_timer.h"
 #include "tst_safe_clocks.h"
 
@@ -91,18 +92,13 @@ struct test_case tc[] = {
 
 static struct tst_ts spec;
 
-static struct test_variants {
-	int (*gettime)(clockid_t clk_id, void *ts);
-	int (*settime)(clockid_t clk_id, void *ts);
-	enum tst_ts_type type;
-	char *desc;
-} variants[] = {
+static struct time64_variants variants[] = {
 #if (__NR_clock_settime != __LTP__NR_INVALID_SYSCALL)
-	{ .gettime = sys_clock_gettime, .settime = sys_clock_settime, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+	{ .clock_gettime = sys_clock_gettime, .clock_settime = sys_clock_settime, .ts_type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
 #endif
 
 #if (__NR_clock_settime64 != __LTP__NR_INVALID_SYSCALL)
-	{ .gettime = sys_clock_gettime64, .settime = sys_clock_settime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+	{ .clock_gettime = sys_clock_gettime64, .clock_settime = sys_clock_settime64, .ts_type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
 #endif
 };
 
@@ -115,13 +111,13 @@ static void setup(void)
 
 static void verify_clock_settime(unsigned int i)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 	void *ts;
 
-	spec.type = tv->type;
+	spec.type = tv->ts_type;
 
 	if (tc[i].replace == 0) {
-		TEST(tv->gettime(CLOCK_REALTIME, tst_ts_get(&spec)));
+		TEST(tv->clock_gettime(CLOCK_REALTIME, tst_ts_get(&spec)));
 		if (TST_RET == -1) {
 			tst_res(TFAIL | TTERRNO, "clock_gettime(2) failed for clock %s",
 				tst_clock_name(CLOCK_REALTIME));
@@ -142,7 +138,7 @@ static void verify_clock_settime(unsigned int i)
 	else
 		ts = tst_ts_get(&spec);
 
-	TEST(tv->settime(tc[i].type, ts));
+	TEST(tv->clock_settime(tc[i].type, ts));
 
 	if (TST_RET != -1) {
 		tst_res(TFAIL | TTERRNO, "clock_settime(2): clock %s passed unexpectedly, expected %s",
diff --git a/testcases/kernel/syscalls/clock_settime/clock_settime03.c b/testcases/kernel/syscalls/clock_settime/clock_settime03.c
index ad6183e4ce3e..fef3c10e98b1 100644
--- a/testcases/kernel/syscalls/clock_settime/clock_settime03.c
+++ b/testcases/kernel/syscalls/clock_settime/clock_settime03.c
@@ -8,6 +8,7 @@
 
 #include <signal.h>
 #include "config.h"
+#include "time64_variants.h"
 #include "tst_timer.h"
 #include "tst_safe_clocks.h"
 
@@ -17,32 +18,25 @@
 static struct tst_ts start, end;
 static struct tst_its its;
 
-static struct test_variants {
-	int (*clock_gettime)(clockid_t clk_id, void *ts);
-	int (*clock_settime)(clockid_t clk_id, void *ts);
-	int (*timer_settime)(kernel_timer_t timerid, int flags, void *its,
-			     void *old_its);
-	enum tst_ts_type type;
-	char *desc;
-} variants[] = {
+static struct time64_variants variants[] = {
 #if (__NR_clock_settime != __LTP__NR_INVALID_SYSCALL)
-	{ .clock_gettime = sys_clock_gettime, .clock_settime = sys_clock_settime, .timer_settime = sys_timer_settime, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+	{ .clock_gettime = sys_clock_gettime, .clock_settime = sys_clock_settime, .timer_settime = sys_timer_settime, .ts_type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
 #endif
 
 #if (__NR_clock_settime64 != __LTP__NR_INVALID_SYSCALL)
-	{ .clock_gettime = sys_clock_gettime64, .clock_settime = sys_clock_settime64, .timer_settime = sys_timer_settime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+	{ .clock_gettime = sys_clock_gettime64, .clock_settime = sys_clock_settime64, .timer_settime = sys_timer_settime64, .ts_type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
 #endif
 };
 
 static void setup(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 
 	tst_res(TINFO, "Testing variant: %s", tv->desc);
-	start.type = end.type = its.type = tv->type;
+	start.type = end.type = its.type = tv->ts_type;
 
 	/* Check if the kernel is y2038 safe */
-	if (tv->type == TST_KERN_OLD_TIMESPEC &&
+	if (tv->ts_type == TST_KERN_OLD_TIMESPEC &&
 	    sizeof(start.ts.kern_old_ts.tv_sec) == 4) {
 		tst_brk(TCONF, "Not Y2038 safe to run test");
 	}
@@ -50,7 +44,7 @@ static void setup(void)
 
 static void run(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 	unsigned long long time = 0x7FFFFFFE; /* Time just before y2038 */
 	struct sigevent ev = {
 		.sigev_notify = SIGEV_SIGNAL,
-- 
2.25.0.rc1.19.g042ed3e048af

