From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 29 Jun 2020 17:13:24 +0530
Subject: [LTP] [PATCH 2/2] syscalls/timer_settime01: Make sure the timer
 fires
In-Reply-To: <7c68854a1b6ef828ed8dd83cb611bd5b5d53c2f8.1593430825.git.viresh.kumar@linaro.org>
References: <7c68854a1b6ef828ed8dd83cb611bd5b5d53c2f8.1593430825.git.viresh.kumar@linaro.org>
Message-ID: <7d8f71c73ac4518375b81651f82ef040c02082a1.1593430825.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch improves the testcase by doing multiple things:

- Make sure the timer fires and catch the signals.

- Verify the values set to the itimerspec by reading them again using
  timer_gettime() syscalls.

- Reduce the timer interval, 5 seconds was way too much.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Cyril/Arnd,

This works well for all clocks except CLOCK_PROCESS_CPUTIME_ID and
CLOCK_THREAD_CPUTIME_ID for some reason. I tried to read the values for
those clocks by sleeping for 1 second and then reading values using
timer_gettime() in a loop, and the value incremented every 15-16 seconds
by a value of 1 (which was in ms if I am not wrong).

No idea what the hell is going on here and so need experts advice :)

 .../syscalls/timer_settime/timer_settime01.c  | 72 +++++++++++++------
 1 file changed, 52 insertions(+), 20 deletions(-)

diff --git a/testcases/kernel/syscalls/timer_settime/timer_settime01.c b/testcases/kernel/syscalls/timer_settime/timer_settime01.c
index 52c435ee3d91..d786938c7aa5 100644
--- a/testcases/kernel/syscalls/timer_settime/timer_settime01.c
+++ b/testcases/kernel/syscalls/timer_settime/timer_settime01.c
@@ -38,25 +38,25 @@ static struct testcase {
 	int			flag;
 	char			*description;
 } tcases[] = {
-	{NULL,     5, 0, 0, "general initialization"},
-	{&old_set, 5, 0, 0, "setting old_value"},
-	{&old_set, 0, 5, 0, "using periodic timer"},
-	{&old_set, 5, 0, TIMER_ABSTIME, "using absolute time"},
+	{NULL, 1, 0, 0, "general initialization"},
+	{&old_set, 1, 0, 0, "setting old_value"},
+	{&old_set, 1, 1, 0, "using periodic timer"},
+	{&old_set, 1, 0, TIMER_ABSTIME, "using absolute time"},
 };
 
 static struct test_variants {
-	int (*gettime)(clockid_t clk_id, void *ts);
-	int (*func)(timer_t timerid, int flags, void *its,
-		    void *old_its);
+	int (*cgettime)(clockid_t clk_id, void *ts);
+	int (*tgettime)(timer_t timer, void *its);
+	int (*func)(timer_t timerid, int flags, void *its, void *old_its);
 	enum tst_ts_type type;
 	char *desc;
 } variants[] = {
 #if (__NR_timer_settime != __LTP__NR_INVALID_SYSCALL)
-	{ .gettime = sys_clock_gettime, .func = sys_timer_settime, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+	{ .cgettime = sys_clock_gettime, .tgettime = sys_timer_gettime, .func = sys_timer_settime, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
 #endif
 
 #if (__NR_timer_settime64 != __LTP__NR_INVALID_SYSCALL)
-	{ .gettime = sys_clock_gettime64, .func = sys_timer_settime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+	{ .cgettime = sys_clock_gettime64, .tgettime = sys_timer_gettime64, .func = sys_timer_settime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
 #endif
 };
 
@@ -64,8 +64,23 @@ static void run(unsigned int n)
 {
 	struct test_variants *tv = &variants[tst_variant];
 	struct testcase *tc = &tcases[n];
+	struct sigevent ev = {
+		.sigev_notify = SIGEV_SIGNAL,
+		.sigev_signo = SIGABRT,
+	};
 	long long val;
+	sigset_t set;
 	unsigned int i;
+	int sig;
+
+	if (sigemptyset(&set) == -1)
+		tst_brk(TBROK, "sigemptyset() failed");
+
+	if (sigaddset(&set, SIGABRT) == -1)
+		tst_brk(TBROK, "sigaddset() failed");
+
+	if (sigprocmask(SIG_BLOCK, &set, NULL) == -1)
+		tst_brk(TBROK, "sigprocmask() failed");
 
 	tst_res(TINFO, "Testing for %s:", tc->description);
 
@@ -78,7 +93,7 @@ static void run(unsigned int n)
 				continue;
 		}
 
-		TEST(tst_syscall(__NR_timer_create, clock, NULL, &timer));
+		TEST(tst_syscall(__NR_timer_create, clock, &ev, &timer));
 		if (TST_RET != 0) {
 			if (possibly_unsupported(clock) &&
 				(TST_ERR == EINVAL || TST_ERR == ENOTSUP)) {
@@ -101,7 +116,7 @@ static void run(unsigned int n)
 
 		if (tc->flag & TIMER_ABSTIME) {
 			timenow.type = tv->type;
-			if (tv->gettime(clock, tst_ts_get(&timenow)) < 0) {
+			if (tv->cgettime(clock, tst_ts_get(&timenow)) < 0) {
 				tst_res(TFAIL, "%s: clock_gettime(%s) failed - skipping the test",
 					tv->desc, get_clock_str(clock));
 				continue;
@@ -119,11 +134,35 @@ static void run(unsigned int n)
 		if (TST_RET != 0) {
 			tst_res(TFAIL | TTERRNO, "%s: timer_settime(%s) failed",
 				tv->desc, get_clock_str(clock));
-		} else {
-			tst_res(TPASS, "%s: timer_settime(%s) was successful",
+		}
+
+		TEST(tv->tgettime(timer, tst_its_get(&new_set)));
+		if (TST_RET != 0) {
+			tst_res(TFAIL | TTERRNO, "%s: timer_gettime(%s) failed",
 				tv->desc, get_clock_str(clock));
 		}
 
+		if (tst_its_get_interval_sec(new_set) > tc->it_interval_tv_sec ||
+		    tst_its_get_value_sec(new_set) > val) {
+			tst_res(TFAIL | TTERRNO, "%s: timer_gettime(%s) reported bad values (%llu: %llu)",
+				tv->desc, get_clock_str(clock),
+				tst_its_get_interval_sec(new_set),
+				tst_its_get_value_sec(new_set));
+		}
+
+		if (sigwait(&set, &sig) == -1) {
+			tst_brk(TBROK, "%s: %s: sigwait() failed", tv->desc,
+				get_clock_str(clock));
+		} else if (tc->it_interval_tv_sec) {
+			if (sigwait(&set, &sig) == -1) {
+				tst_brk(TBROK, "%s: %s: Second sigwait() failed",
+					tv->desc, get_clock_str(clock));
+			}
+		}
+
+		tst_res(TPASS, "%s: timer_settime(%s) passed", tv->desc,
+			get_clock_str(clock));
+
 		TEST(tst_syscall(__NR_timer_delete, timer));
 		if (TST_RET != 0) {
 			tst_res(TFAIL | TTERRNO, "%s: %s: timer_delete() failed!",
@@ -132,16 +171,9 @@ static void run(unsigned int n)
 	}
 }
 
-static void sighandler(int sig)
-{
-	/* sighandler for CLOCK_*_ALARM */
-	tst_res(TINFO, "Caught signal %s", tst_strsig(sig));
-}
-
 static void setup(void)
 {
 	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
-	SAFE_SIGNAL(SIGALRM, sighandler);
 }
 
 static struct tst_test test = {
-- 
2.25.0.rc1.19.g042ed3e048af

