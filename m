From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue,  8 Sep 2020 11:49:25 +0530
Subject: [LTP] [PATCH 12/16] syscalls: timer_settime: Reuse struct
 time64_variants
In-Reply-To: <cover.1599545766.git.viresh.kumar@linaro.org>
References: <cover.1599545766.git.viresh.kumar@linaro.org>
Message-ID: <a6f51cfc469d9eb80e698cfcdbb1d96f8615d9e3.1599545766.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Lets reuse the common structure here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../syscalls/timer_settime/timer_settime01.c  | 25 ++++++++-----------
 .../syscalls/timer_settime/timer_settime02.c  | 18 ++++++-------
 2 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/testcases/kernel/syscalls/timer_settime/timer_settime01.c b/testcases/kernel/syscalls/timer_settime/timer_settime01.c
index 415c6290fe2f..67143e8f88b2 100644
--- a/testcases/kernel/syscalls/timer_settime/timer_settime01.c
+++ b/testcases/kernel/syscalls/timer_settime/timer_settime01.c
@@ -26,6 +26,7 @@
 #include <errno.h>
 #include <time.h>
 #include <signal.h>
+#include "time64_variants.h"
 #include "tst_timer.h"
 
 static struct tst_ts timenow;
@@ -45,19 +46,13 @@ static struct testcase {
 	{&old_set, 50000, 0, TIMER_ABSTIME, "using absolute time"},
 };
 
-static struct test_variants {
-	int (*cgettime)(clockid_t clk_id, void *ts);
-	int (*tgettime)(kernel_timer_t timer, void *its);
-	int (*func)(kernel_timer_t timerid, int flags, void *its, void *old_its);
-	enum tst_ts_type type;
-	char *desc;
-} variants[] = {
+static struct time64_variants variants[] = {
 #if (__NR_timer_settime != __LTP__NR_INVALID_SYSCALL)
-	{ .cgettime = sys_clock_gettime, .tgettime = sys_timer_gettime, .func = sys_timer_settime, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+	{ .clock_gettime = sys_clock_gettime, .timer_gettime = sys_timer_gettime, .timer_settime = sys_timer_settime, .ts_type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
 #endif
 
 #if (__NR_timer_settime64 != __LTP__NR_INVALID_SYSCALL)
-	{ .cgettime = sys_clock_gettime64, .tgettime = sys_timer_gettime64, .func = sys_timer_settime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+	{ .clock_gettime = sys_clock_gettime64, .timer_gettime = sys_timer_gettime64, .timer_settime = sys_timer_settime64, .ts_type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
 #endif
 };
 
@@ -93,7 +88,7 @@ static void setup(void)
 
 static void run(unsigned int n)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 	struct testcase *tc = &tcases[n];
 	long long val;
 	unsigned int i;
@@ -126,12 +121,12 @@ static void run(unsigned int n)
 		memset(&new_set, 0, sizeof(new_set));
 		memset(&old_set, 0, sizeof(old_set));
 
-		new_set.type = old_set.type = tv->type;
+		new_set.type = old_set.type = tv->ts_type;
 		val = tc->it_value_tv_usec;
 
 		if (tc->flag & TIMER_ABSTIME) {
-			timenow.type = tv->type;
-			if (tv->cgettime(clock, tst_ts_get(&timenow)) < 0) {
+			timenow.type = tv->ts_type;
+			if (tv->clock_gettime(clock, tst_ts_get(&timenow)) < 0) {
 				tst_res(TFAIL,
 					"clock_gettime(%s) failed - skipping the test",
 					get_clock_str(clock));
@@ -143,14 +138,14 @@ static void run(unsigned int n)
 		tst_its_set_interval_from_us(&new_set, tc->it_interval_tv_usec);
 		tst_its_set_value_from_us(&new_set, val);
 
-		TEST(tv->func(timer, tc->flag, tst_its_get(&new_set), tst_its_get(tc->old_ptr)));
+		TEST(tv->timer_settime(timer, tc->flag, tst_its_get(&new_set), tst_its_get(tc->old_ptr)));
 
 		if (TST_RET != 0) {
 			tst_res(TFAIL | TTERRNO, "timer_settime(%s) failed",
 				get_clock_str(clock));
 		}
 
-		TEST(tv->tgettime(timer, tst_its_get(&new_set)));
+		TEST(tv->timer_gettime(timer, tst_its_get(&new_set)));
 		if (TST_RET != 0) {
 			tst_res(TFAIL | TTERRNO, "timer_gettime(%s) failed",
 				get_clock_str(clock));
diff --git a/testcases/kernel/syscalls/timer_settime/timer_settime02.c b/testcases/kernel/syscalls/timer_settime/timer_settime02.c
index f1225c1ccfad..564f1c2ce323 100644
--- a/testcases/kernel/syscalls/timer_settime/timer_settime02.c
+++ b/testcases/kernel/syscalls/timer_settime/timer_settime02.c
@@ -25,6 +25,7 @@
 
 #include <errno.h>
 #include <time.h>
+#include "time64_variants.h"
 #include "tst_timer.h"
 
 static struct tst_its new_set, old_set;
@@ -58,18 +59,13 @@ static struct testcase {
 	{&timer, &pnew_set, (struct tst_its **)&faulty_set, 0, EFAULT},
 };
 
-static struct test_variants {
-	int (*func)(kernel_timer_t timerid, int flags, void *its,
-		    void *old_its);
-	enum tst_ts_type type;
-	char *desc;
-} variants[] = {
+static struct time64_variants variants[] = {
 #if (__NR_timer_settime != __LTP__NR_INVALID_SYSCALL)
-	{ .func = sys_timer_settime, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+	{ .timer_settime = sys_timer_settime, .ts_type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
 #endif
 
 #if (__NR_timer_settime64 != __LTP__NR_INVALID_SYSCALL)
-	{ .func = sys_timer_settime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+	{ .timer_settime = sys_timer_settime64, .ts_type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
 #endif
 };
 
@@ -81,7 +77,7 @@ static void setup(void)
 
 static void run(unsigned int n)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 	struct testcase *tc = &tcases[n];
 	void *new, *old;
 	unsigned int i;
@@ -115,7 +111,7 @@ static void run(unsigned int n)
 		memset(&new_set, 0, sizeof(new_set));
 		memset(&old_set, 0, sizeof(old_set));
 
-		new_set.type = old_set.type = tv->type;
+		new_set.type = old_set.type = tv->ts_type;
 		tst_its_set_interval_sec(&new_set, 0);
 		tst_its_set_interval_nsec(&new_set, 0);
 		tst_its_set_value_sec(&new_set, 5);
@@ -124,7 +120,7 @@ static void run(unsigned int n)
 		new = (tc->new_ptr == (struct tst_its **)&faulty_set) ? faulty_set : tst_its_get(*tc->new_ptr);
 		old = (tc->old_ptr == (struct tst_its **)&faulty_set) ? faulty_set : tst_its_get(*tc->old_ptr);
 
-		TEST(tv->func(*tc->timer_id, 0, new, old));
+		TEST(tv->timer_settime(*tc->timer_id, 0, new, old));
 
 		if (tc->error != TST_ERR) {
 			tst_res(TFAIL | TTERRNO,
-- 
2.25.0.rc1.19.g042ed3e048af

