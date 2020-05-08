From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri,  8 May 2020 09:53:47 +0530
Subject: [LTP] [PATCH V2 02/17] syscalls/timer_settime: Add support for
 time64 tests
In-Reply-To: <cover.1588911607.git.viresh.kumar@linaro.org>
References: <cover.1588911607.git.viresh.kumar@linaro.org>
Message-ID: <cd002c8c3a5a67ba87eaa54c61387e54d71404b4.1588911607.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds support for time64 tests to the existing timer_settime()
syscall tests.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/tst_timer.h                           | 34 ++++++++++
 .../syscalls/timer_settime/timer_settime01.c  | 51 +++++++++++----
 .../syscalls/timer_settime/timer_settime02.c  | 65 ++++++++++++++-----
 3 files changed, 122 insertions(+), 28 deletions(-)

diff --git a/include/tst_timer.h b/include/tst_timer.h
index 601f934da670..94d03cecdabe 100644
--- a/include/tst_timer.h
+++ b/include/tst_timer.h
@@ -252,6 +252,40 @@ static inline int sys_timer_gettime64(kernel_timer_t timerid, void *its)
 	return tst_syscall(__NR_timer_gettime64, timerid, its);
 }
 
+static inline int sys_timer_settime(kernel_timer_t timerid, int flags,
+				    void *its, void *old_its)
+{
+	return tst_syscall(__NR_timer_settime, timerid, flags, its, old_its);
+}
+
+static inline int sys_timer_settime64(kernel_timer_t timerid, int flags,
+				      void *its, void *old_its)
+{
+	return tst_syscall(__NR_timer_settime64, timerid, flags, its, old_its);
+}
+
+static inline void tst_its_set_time(struct tst_its *its, long long value_sec,
+				long long value_nsec, long long interval_sec,
+				long long interval_nsec)
+{
+	switch (its->type) {
+	case TST_LIBC_TIMESPEC:
+		its->ts.libc_its.it_value.tv_sec = value_sec;
+		its->ts.libc_its.it_value.tv_nsec = value_nsec;
+		its->ts.libc_its.it_interval.tv_sec = interval_sec;
+		its->ts.libc_its.it_interval.tv_nsec = interval_nsec;
+	break;
+	case TST_KERN_TIMESPEC:
+		its->ts.kern_its.it_value.tv_sec = value_sec;
+		its->ts.kern_its.it_value.tv_nsec = value_nsec;
+		its->ts.kern_its.it_interval.tv_sec = interval_sec;
+		its->ts.kern_its.it_interval.tv_nsec = interval_nsec;
+	break;
+	default:
+		tst_brk(TBROK, "Invalid type: %d", its->type);
+	}
+}
+
 /*
  * Returns tst_ts seconds.
  */
diff --git a/testcases/kernel/syscalls/timer_settime/timer_settime01.c b/testcases/kernel/syscalls/timer_settime/timer_settime01.c
index da365d221086..8c00718eedaf 100644
--- a/testcases/kernel/syscalls/timer_settime/timer_settime01.c
+++ b/testcases/kernel/syscalls/timer_settime/timer_settime01.c
@@ -25,15 +25,15 @@
 #include <errno.h>
 #include <time.h>
 #include <signal.h>
-#include "tst_test.h"
-#include "lapi/common_timers.h"
+#include "tst_timer.h"
+#include "lapi/abisize.h"
 
-static struct timespec timenow;
-static struct itimerspec new_set, old_set;
+static struct tst_ts timenow;
+static struct tst_its new_set, old_set;
 static kernel_timer_t timer;
 
 static struct testcase {
-	struct itimerspec	*old_ptr;
+	struct tst_its		*old_ptr;
 	int			it_value_tv_sec;
 	int			it_interval_tv_sec;
 	int			flag;
@@ -45,10 +45,32 @@ static struct testcase {
 	{&old_set, 5, 0, TIMER_ABSTIME, "using absolute time"},
 };
 
+static struct test_variants {
+	int (*gettime)(clockid_t clk_id, void *ts);
+	int (*func)(kernel_timer_t timerid, int flags, void *its,
+		    void *old_its);
+	enum tst_ts_type type;
+	char *desc;
+} variants[] = {
+#if defined(TST_ABI32)
+	{ .gettime = sys_clock_gettime, .func = sys_timer_settime, .type = TST_LIBC_TIMESPEC, .desc = "syscall with libc spec"},
+#endif
+
+#if defined(TST_ABI64)
+	{ .gettime = sys_clock_gettime, .func = sys_timer_settime, .type = TST_KERN_TIMESPEC, .desc = "syscall with kernel spec64"},
+#endif
+
+#if (__NR_timer_settime64 != __LTP__NR_INVALID_SYSCALL)
+	{ .gettime = sys_clock_gettime64, .func = sys_timer_settime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec64"},
+#endif
+};
+
 static void run(unsigned int n)
 {
-	unsigned int i;
+	struct test_variants *tv = &variants[tst_variant];
 	struct testcase *tc = &tcases[n];
+	long long val;
+	unsigned int i;
 
 	tst_res(TINFO, "Testing for %s:", tc->description);
 
@@ -78,21 +100,24 @@ static void run(unsigned int n)
 		memset(&new_set, 0, sizeof(new_set));
 		memset(&old_set, 0, sizeof(old_set));
 
-		new_set.it_value.tv_sec = tc->it_value_tv_sec;
-		new_set.it_interval.tv_sec = tc->it_interval_tv_sec;
+		new_set.type = old_set.type = tv->type;
+
+		val = tc->it_value_tv_sec;
 
 		if (tc->flag & TIMER_ABSTIME) {
-			if (clock_gettime(clock, &timenow) < 0) {
+			timenow.type = tv->type;
+			if (tv->gettime(clock, tst_ts_get(&timenow)) < 0) {
 				tst_res(TFAIL,
 					"clock_gettime(%s) failed - skipping the test",
 					get_clock_str(clock));
 				continue;
 			}
-			new_set.it_value.tv_sec += timenow.tv_sec;
+			val += tst_ts_get_sec(timenow);
 		}
 
-		TEST(tst_syscall(__NR_timer_settime, timer,
-			tc->flag, &new_set, tc->old_ptr));
+		tst_its_set_time(&new_set, val, 0, tc->it_interval_tv_sec, 0);
+
+		TEST(tv->func(timer, tc->flag, tst_its_get(&new_set), tst_its_get(tc->old_ptr)));
 
 		if (TST_RET != 0) {
 			tst_res(TFAIL | TTERRNO, "%s failed",
@@ -116,6 +141,7 @@ static void sighandler(int sig)
 
 static void setup(void)
 {
+	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
 	SAFE_SIGNAL(SIGALRM, sighandler);
 }
 
@@ -123,6 +149,7 @@ static struct tst_test test = {
 	.test = run,
 	.needs_root = 1,
 	.tcnt = ARRAY_SIZE(tcases),
+	.test_variants = ARRAY_SIZE(variants),
 	.setup = setup,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "f18ddc13af98"},
diff --git a/testcases/kernel/syscalls/timer_settime/timer_settime02.c b/testcases/kernel/syscalls/timer_settime/timer_settime02.c
index bcabb76956f8..9ca62e15b690 100644
--- a/testcases/kernel/syscalls/timer_settime/timer_settime02.c
+++ b/testcases/kernel/syscalls/timer_settime/timer_settime02.c
@@ -25,10 +25,12 @@
 
 #include <errno.h>
 #include <time.h>
-#include "tst_test.h"
-#include "lapi/common_timers.h"
+#include "tst_timer.h"
+#include "lapi/abisize.h"
 
-static struct itimerspec new_set, old_set;
+static struct tst_its new_set, old_set;
+static struct tst_its *pnew_set = &new_set, *pold_set = &old_set, *null_set = NULL;
+static void *faulty_set;
 static kernel_timer_t timer;
 static kernel_timer_t timer_inval = -1;
 
@@ -44,23 +46,50 @@ static const char * const descriptions[] = {
 
 static struct testcase {
 	kernel_timer_t		*timer_id;
-	struct itimerspec	*new_ptr;
-	struct itimerspec	*old_ptr;
+	struct tst_its		**new_ptr;
+	struct tst_its		**old_ptr;
 	int			it_value_tv_nsec;
 	int			error;
 } tcases[] = {
-	{&timer, NULL, &old_set, 0, EINVAL},
-	{&timer, &new_set, &old_set, -1, EINVAL},
-	{&timer, &new_set, &old_set, NSEC_PER_SEC + 1, EINVAL},
-	{&timer_inval, &new_set, &old_set, 0, EINVAL},
-	{&timer, (struct itimerspec *) -1, &old_set, 0, EFAULT},
-	{&timer, &new_set, (struct itimerspec *) -1, 0, EFAULT},
+	{&timer, &null_set, &pold_set, 0, EINVAL},
+	{&timer, &pnew_set, &pold_set, -1, EINVAL},
+	{&timer, &pnew_set, &pold_set, NSEC_PER_SEC + 1, EINVAL},
+	{&timer_inval, &pnew_set, &pold_set, 0, EINVAL},
+	{&timer, (struct tst_its **)&faulty_set, &pold_set, 0, EFAULT},
+	{&timer, &pnew_set, (struct tst_its **)&faulty_set, 0, EFAULT},
 };
 
+static struct test_variants {
+	int (*func)(kernel_timer_t timerid, int flags, void *its,
+		    void *old_its);
+	enum tst_ts_type type;
+	char *desc;
+} variants[] = {
+#if defined(TST_ABI32)
+	{ .func = sys_timer_settime, .type = TST_LIBC_TIMESPEC, .desc = "syscall with libc spec"},
+#endif
+
+#if defined(TST_ABI64)
+	{ .func = sys_timer_settime, .type = TST_KERN_TIMESPEC, .desc = "syscall with kernel spec64"},
+#endif
+
+#if (__NR_timer_settime64 != __LTP__NR_INVALID_SYSCALL)
+	{ .func = sys_timer_settime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec64"},
+#endif
+};
+
+static void setup(void)
+{
+	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
+	faulty_set = tst_get_bad_addr(NULL);
+}
+
 static void run(unsigned int n)
 {
-	unsigned int i;
+	struct test_variants *tv = &variants[tst_variant];
 	struct testcase *tc = &tcases[n];
+	void *new, *old;
+	unsigned int i;
 
 	tst_res(TINFO, "Testing for %s:", descriptions[n]);
 
@@ -91,11 +120,13 @@ static void run(unsigned int n)
 		memset(&new_set, 0, sizeof(new_set));
 		memset(&old_set, 0, sizeof(old_set));
 
-		new_set.it_value.tv_sec  = 5;
-		new_set.it_value.tv_nsec = tc->it_value_tv_nsec;
+		new_set.type = old_set.type = tv->type;
+		tst_its_set_time(&new_set, 5, tc->it_value_tv_nsec, 0, 0);
+
+		new = (tc->new_ptr == (struct tst_its **)&faulty_set) ? faulty_set : tst_its_get(*tc->new_ptr);
+		old = (tc->old_ptr == (struct tst_its **)&faulty_set) ? faulty_set : tst_its_get(*tc->old_ptr);
 
-		TEST(tst_syscall(__NR_timer_settime, *tc->timer_id,
-					0, tc->new_ptr,	tc->old_ptr));
+		TEST(tv->func(*tc->timer_id, 0, new, old));
 
 		if (tc->error != TST_ERR) {
 			tst_res(TFAIL | TTERRNO,
@@ -119,6 +150,8 @@ static struct tst_test test = {
 	.test = run,
 	.needs_root = 1,
 	.tcnt = ARRAY_SIZE(tcases),
+	.test_variants = ARRAY_SIZE(variants),
+	.setup = setup,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "f18ddc13af98"},
 		{}
-- 
2.25.0.rc1.19.g042ed3e048af

