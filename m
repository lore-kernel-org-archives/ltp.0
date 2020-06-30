From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 30 Jun 2020 08:06:15 +0530
Subject: [LTP] [PATCH V1.1 2/2] syscalls/timer_settime01: Make sure the
 timer fires
In-Reply-To: <7c68854a1b6ef828ed8dd83cb611bd5b5d53c2f8.1593430825.git.viresh.kumar@linaro.org>
References: <7c68854a1b6ef828ed8dd83cb611bd5b5d53c2f8.1593430825.git.viresh.kumar@linaro.org>
Message-ID: <aa1007391fe6c4a281b880b38ec4d6f46d56b034.1593484488.git.viresh.kumar@linaro.org>
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
V1.1:
- Use busy loop while waiting for signal and use the existing signal
  mechanism.

 .../syscalls/timer_settime/timer_settime01.c  | 63 ++++++++++++++-----
 1 file changed, 48 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/syscalls/timer_settime/timer_settime01.c b/testcases/kernel/syscalls/timer_settime/timer_settime01.c
index 52c435ee3d91..7e53fce23527 100644
--- a/testcases/kernel/syscalls/timer_settime/timer_settime01.c
+++ b/testcases/kernel/syscalls/timer_settime/timer_settime01.c
@@ -38,28 +38,42 @@ static struct testcase {
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
 static void run(unsigned int n)
 {
 	struct test_variants *tv = &variants[tst_variant];
@@ -101,7 +115,7 @@ static void run(unsigned int n)
 
 		if (tc->flag & TIMER_ABSTIME) {
 			timenow.type = tv->type;
-			if (tv->gettime(clock, tst_ts_get(&timenow)) < 0) {
+			if (tv->cgettime(clock, tst_ts_get(&timenow)) < 0) {
 				tst_res(TFAIL, "%s: clock_gettime(%s) failed - skipping the test",
 					tv->desc, get_clock_str(clock));
 				continue;
@@ -119,11 +133,31 @@ static void run(unsigned int n)
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
+		clear_signal();
+
+		/* Wait for another event when interval was set */
+		if (tc->it_interval_tv_sec)
+			clear_signal();
+
+		tst_res(TPASS, "%s: timer_settime(%s) passed", tv->desc,
+			get_clock_str(clock));
+
 		TEST(tst_syscall(__NR_timer_delete, timer));
 		if (TST_RET != 0) {
 			tst_res(TFAIL | TTERRNO, "%s: %s: timer_delete() failed!",
@@ -132,10 +166,9 @@ static void run(unsigned int n)
 	}
 }
 
-static void sighandler(int sig)
+static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
 {
-	/* sighandler for CLOCK_*_ALARM */
-	tst_res(TINFO, "Caught signal %s", tst_strsig(sig));
+	caught_signal = 1;
 }
 
 static void setup(void)
-- 
2.25.0.rc1.19.g042ed3e048af

