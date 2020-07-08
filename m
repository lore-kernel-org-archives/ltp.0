From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed,  8 Jul 2020 16:01:04 +0530
Subject: [LTP] [PATCH V3] syscalls/timer_settime01: Make sure the timer fires
In-Reply-To: <ede8d1c6a1ad1b23d8dca2297c740c301b329e37.1593743927.git.viresh.kumar@linaro.org>
References: <ede8d1c6a1ad1b23d8dca2297c740c301b329e37.1593743927.git.viresh.kumar@linaro.org>
Message-ID: <47e40724c2a7a9612aca0265e493e62c69d65996.1594204153.git.viresh.kumar@linaro.org>
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
V3:
- Changed timer values to 100 ms instead of 1 sec and that resulted in
  few changes.
- Moved some code around to keep related bits together.
- Improved check for testing value read from timer.

 .../syscalls/timer_settime/timer_settime01.c  | 106 ++++++++++++------
 1 file changed, 70 insertions(+), 36 deletions(-)

diff --git a/testcases/kernel/syscalls/timer_settime/timer_settime01.c b/testcases/kernel/syscalls/timer_settime/timer_settime01.c
index 08fb56e4943a..f9d1456dabe9 100644
--- a/testcases/kernel/syscalls/timer_settime/timer_settime01.c
+++ b/testcases/kernel/syscalls/timer_settime/timer_settime01.c
@@ -33,33 +33,61 @@ static timer_t timer;
 
 static struct testcase {
 	struct tst_its		*old_ptr;
-	int			it_value_tv_sec;
-	int			it_interval_tv_sec;
+	int			it_value_tv_usec;
+	int			it_interval_tv_usec;
 	int			flag;
 	char			*description;
 } tcases[] = {
-	{NULL,     5, 0, 0, "general initialization"},
-	{&old_set, 5, 0, 0, "setting old_value"},
-	{&old_set, 0, 5, 0, "using periodic timer"},
-	{&old_set, 5, 0, TIMER_ABSTIME, "using absolute time"},
+	{NULL, 100000, 0, 0, "general initialization"},
+	{&old_set, 100000, 0, 0, "setting old_value"},
+	{&old_set, 100000, 100000, 0, "using periodic timer"},
+	{&old_set, 100000, 0, TIMER_ABSTIME, "using absolute time"},
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
 
+static volatile int caught_signal;
+
+static void clear_signal(void)
+{
+	/*
+	 * The busy loop is intentional. The signal is sent after X
+	 * seconds of CPU time has been accumulated for the process and
+	 * thread specific clocks.
+	 */
+	while (!caught_signal);
+
+	caught_signal = 0;
+}
+
+static void sighandler(int sig)
+{
+	if (sig != SIGALRM)
+		tst_res(TFAIL, "Received incorrect signal: %d", sig);
+
+	caught_signal = 1;
+}
+
+static void setup(void)
+{
+	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
+	SAFE_SIGNAL(SIGALRM, sighandler);
+}
+
 static void run(unsigned int n)
 {
 	struct test_variants *tv = &variants[tst_variant];
@@ -96,53 +124,59 @@ static void run(unsigned int n)
 		memset(&old_set, 0, sizeof(old_set));
 
 		new_set.type = old_set.type = tv->type;
-
-		val = tc->it_value_tv_sec;
+		val = tc->it_value_tv_usec;
 
 		if (tc->flag & TIMER_ABSTIME) {
 			timenow.type = tv->type;
-			if (tv->gettime(clock, tst_ts_get(&timenow)) < 0) {
+			if (tv->cgettime(clock, tst_ts_get(&timenow)) < 0) {
 				tst_res(TFAIL,
 					"clock_gettime(%s) failed - skipping the test",
 					get_clock_str(clock));
 				continue;
 			}
-			val += tst_ts_get_sec(timenow);
+			val += tst_ts_to_us(timenow);
 		}
 
-		tst_its_set_interval_sec(&new_set, tc->it_interval_tv_sec);
-		tst_its_set_interval_nsec(&new_set, 0);
-		tst_its_set_value_sec(&new_set, val);
-		tst_its_set_value_nsec(&new_set, 0);
+		tst_its_set_interval_from_us(&new_set, tc->it_interval_tv_usec);
+		tst_its_set_value_from_us(&new_set, val);
 
 		TEST(tv->func(timer, tc->flag, tst_its_get(&new_set), tst_its_get(tc->old_ptr)));
 
 		if (TST_RET != 0) {
-			tst_res(TFAIL | TTERRNO, "%s failed",
-					get_clock_str(clock));
-		} else {
-			tst_res(TPASS, "%s was successful",
-					get_clock_str(clock));
+			tst_res(TFAIL | TTERRNO, "timer_settime(%s) failed",
+				get_clock_str(clock));
 		}
 
+		TEST(tv->tgettime(timer, tst_its_get(&new_set)));
+		if (TST_RET != 0) {
+			tst_res(TFAIL | TTERRNO, "timer_gettime(%s) failed",
+				get_clock_str(clock));
+		} else if ((tst_its_get_interval_nsec(new_set) !=
+				tc->it_interval_tv_usec * 1000) ||
+			   (tst_its_get_value_nsec(new_set) >
+				MAX(tc->it_value_tv_usec * 1000, tc->it_interval_tv_usec * 1000))) {
+			tst_res(TFAIL | TTERRNO,
+				"timer_gettime(%s) reported bad values (%llu: %llu)",
+				get_clock_str(clock),
+				tst_its_get_interval_nsec(new_set),
+				tst_its_get_value_nsec(new_set));
+		}
+
+		clear_signal();
+
+		/* Wait for another event when interval was set */
+		if (tc->it_interval_tv_usec)
+			clear_signal();
+
+		tst_res(TPASS, "timer_settime(%s) passed",
+			get_clock_str(clock));
+
 		TEST(tst_syscall(__NR_timer_delete, timer));
 		if (TST_RET != 0)
 			tst_res(TFAIL | TTERRNO, "timer_delete() failed!");
 	}
 }
 
-static void sighandler(int sig)
-{
-	/* sighandler for CLOCK_*_ALARM */
-	tst_res(TINFO, "Caught signal %s", tst_strsig(sig));
-}
-
-static void setup(void)
-{
-	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
-	SAFE_SIGNAL(SIGALRM, sighandler);
-}
-
 static struct tst_test test = {
 	.test = run,
 	.needs_root = 1,
-- 
2.25.0.rc1.19.g042ed3e048af

