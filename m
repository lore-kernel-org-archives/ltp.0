From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 28 May 2020 12:27:39 +0530
Subject: [LTP] [PATCH V2] syscalls: clock_settime: Add test around y2038
 vulnerability
In-Reply-To: <70417fdc55c750e8b13d7124e66a7e8a59182e75.1590494889.git.viresh.kumar@linaro.org>
References: <70417fdc55c750e8b13d7124e66a7e8a59182e75.1590494889.git.viresh.kumar@linaro.org>
Message-ID: <86a36c7d5919a966e077cb76f0d8710f31bcc60a.1590649002.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds a test around the y2038 vulnerability, it sets the system time
to just before y2038 time (i.e. max value that can be stored in s32),
and adds a timer to expire just after crossing it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2:
- Fix the y2038 bug in the test itself, changes in the setup() routine.
  :)

 runtest/syscalls                              |   1 +
 .../kernel/syscalls/clock_settime/.gitignore  |   1 +
 .../syscalls/clock_settime/clock_settime03.c  | 122 ++++++++++++++++++
 3 files changed, 124 insertions(+)
 create mode 100644 testcases/kernel/syscalls/clock_settime/clock_settime03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 8457db34e999..d7c3cbed611a 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -101,6 +101,7 @@ leapsec01 leapsec01
 
 clock_settime01 clock_settime01
 clock_settime02 clock_settime02
+clock_settime03 clock_settime03
 
 clone01 clone01
 clone02 clone02
diff --git a/testcases/kernel/syscalls/clock_settime/.gitignore b/testcases/kernel/syscalls/clock_settime/.gitignore
index 28121755006b..b66169b3eb7b 100644
--- a/testcases/kernel/syscalls/clock_settime/.gitignore
+++ b/testcases/kernel/syscalls/clock_settime/.gitignore
@@ -1,2 +1,3 @@
 clock_settime01
 clock_settime02
+clock_settime03
diff --git a/testcases/kernel/syscalls/clock_settime/clock_settime03.c b/testcases/kernel/syscalls/clock_settime/clock_settime03.c
new file mode 100644
index 000000000000..9e316378b1cc
--- /dev/null
+++ b/testcases/kernel/syscalls/clock_settime/clock_settime03.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Linaro Limited. All rights reserved.
+ * Author: Viresh Kumar<viresh.kumar@linaro.org>
+ *
+ * Check Year 2038 related vulnerabilities.
+ */
+
+#include <signal.h>
+#include "config.h"
+#include "tst_timer.h"
+#include "tst_safe_clocks.h"
+
+#define EXPIREDELTA 3
+
+static struct tst_ts ts;
+static struct tst_its its;
+
+static struct test_variants {
+	int (*clock_gettime)(clockid_t clk_id, void *ts);
+	int (*clock_settime)(clockid_t clk_id, void *ts);
+	int (*timer_settime)(timer_t timerid, int flags, void *its,
+			     void *old_its);
+	enum tst_ts_type type;
+	char *desc;
+} variants[] = {
+#if (__NR_clock_settime != __LTP__NR_INVALID_SYSCALL)
+	{ .clock_gettime = sys_clock_gettime, .clock_settime = sys_clock_settime, .timer_settime = sys_timer_settime, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+#endif
+
+#if (__NR_clock_settime64 != __LTP__NR_INVALID_SYSCALL)
+	{ .clock_gettime = sys_clock_gettime64, .clock_settime = sys_clock_settime64, .timer_settime = sys_timer_settime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+#endif
+};
+
+static void setup(void)
+{
+	struct test_variants *tv = &variants[tst_variant];
+	unsigned long long time = 0x7FFFFFFF; /* Time just before y2038 */
+	struct tst_ts end;
+	int ret;
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	ts.type = end.type = its.type = tv->type;
+
+	/* Check if the kernel is y2038 safe */
+	if (tv->type != TST_KERN_OLD_TIMESPEC)
+		return;
+
+	tst_ts_set_sec(&ts, time);
+	tst_ts_set_nsec(&ts, 0);
+
+	ret = tv->clock_settime(CLOCK_REALTIME, tst_ts_get(&ts));
+	if (ret == -1)
+		tst_brk(TBROK | TERRNO, "clock_settime() failed");
+
+	usleep(2000);
+
+	ret = tv->clock_gettime(CLOCK_REALTIME, tst_ts_get(&end));
+	if (ret == -1)
+		tst_brk(TBROK | TERRNO, "clock_gettime() failed");
+
+	if (tst_ts_lt(end, ts))
+		tst_brk(TFAIL, "Kernel isn't Year 2038 safe, abandon test");
+}
+
+static void run(void)
+{
+	struct test_variants *tv = &variants[tst_variant];
+	unsigned long long time = 0x7FFFFFFE; /* Time just before y2038 */
+	struct sigevent ev = {
+		.sigev_notify = SIGEV_SIGNAL,
+		.sigev_signo = SIGABRT,
+	};
+	timer_t timer;
+	sigset_t set;
+	int sig, ret;
+
+	if (sigemptyset(&set) == -1)
+		tst_brk(TBROK, "sigemptyset() failed");
+
+	if (sigaddset(&set, SIGABRT) == -1)
+		tst_brk(TBROK, "sigaddset() failed");
+
+	if (sigprocmask(SIG_BLOCK, &set, NULL) == -1)
+		tst_brk(TBROK, "sigprocmask() failed");
+
+	TEST(tst_syscall(__NR_timer_create, CLOCK_REALTIME_ALARM, &ev, &timer));
+	if (TST_RET != 0)
+		tst_brk(TBROK | TERRNO, "timer_create() failed");
+
+	tst_ts_set_sec(&ts, time);
+	tst_ts_set_nsec(&ts, 0);
+
+	ret = tv->clock_settime(CLOCK_REALTIME, tst_ts_get(&ts));
+	if (ret == -1)
+		tst_brk(TBROK | TERRNO, "clock_settime() failed");
+
+	tst_its_set_time(&its, time + EXPIREDELTA, 0, 0, 0);
+
+	TEST(tv->timer_settime(timer, TIMER_ABSTIME, tst_its_get(&its), NULL));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "timer_settime() failed");
+
+	if (sigwait(&set, &sig) == -1)
+		tst_brk(TBROK, "sigwait() failed");
+
+	if (sig == SIGABRT) {
+		tst_res(TPASS, "clock_settime(): Y2038 test passed");
+		return;
+	}
+
+	tst_res(TFAIL, "clock_settime(): Y2038 test failed");
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.test_variants = ARRAY_SIZE(variants),
+	.setup = setup,
+	.needs_root = 1,
+	.restore_wallclock = 1,
+};
-- 
2.25.0.rc1.19.g042ed3e048af

