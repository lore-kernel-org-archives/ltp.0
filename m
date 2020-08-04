From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue,  4 Aug 2020 18:20:08 +0530
Subject: [LTP] [PATCH V8] syscalls: clock_settime: Add test around y2038
 vulnerability
Message-ID: <96ce72a605e365a040b258db9323d3962ab80e29.1596545279.git.viresh.kumar@linaro.org>
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
V8:
- Check compatibility issues for TST_KERN_OLD_TIMESPEC and not the new
  timespec.
- s/TFAIL/TCONF/ in setup()
- Use kernel_timer_t
- rearrange code and don't expect timer to fire before.

 runtest/syscalls                                   |   1 +
 testcases/kernel/syscalls/clock_settime/.gitignore |   1 +
 .../syscalls/clock_settime/clock_settime03.c       | 123 +++++++++++++++++++++
 3 files changed, 125 insertions(+)
 create mode 100644 testcases/kernel/syscalls/clock_settime/clock_settime03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 3c6e78a4c6d0..3c2f5f6c0b37 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -99,6 +99,7 @@ leapsec01 leapsec01
 
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
index 000000000000..da062a8d0333
--- /dev/null
+++ b/testcases/kernel/syscalls/clock_settime/clock_settime03.c
@@ -0,0 +1,123 @@
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
+#define TIMER_DELTA	3
+#define ALLOWED_DELTA	(50 * 1000) /* 50 ms */
+
+static struct tst_ts start, end;
+static struct tst_its its;
+
+static struct test_variants {
+	int (*clock_gettime)(clockid_t clk_id, void *ts);
+	int (*clock_settime)(clockid_t clk_id, void *ts);
+	int (*timer_settime)(kernel_timer_t timerid, int flags, void *its,
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
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	start.type = end.type = its.type = tv->type;
+
+	/* Check if the kernel is y2038 safe */
+	if (tv->type == TST_KERN_OLD_TIMESPEC &&
+	    sizeof(start.ts.kern_old_ts) == 8)
+		tst_brk(TCONF, "Not Y2038 safe to run test");
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
+	long long diff;
+	kernel_timer_t timer;
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
+	tst_ts_set_sec(&start, time);
+	tst_ts_set_nsec(&start, 0);
+
+	ret = tv->clock_settime(CLOCK_REALTIME, tst_ts_get(&start));
+	if (ret == -1)
+		tst_brk(TBROK | TERRNO, "clock_settime() failed");
+
+	tst_its_set_interval_sec(&its, 0);
+	tst_its_set_interval_nsec(&its, 0);
+	tst_its_set_value_sec(&its, time + TIMER_DELTA);
+	tst_its_set_value_nsec(&its, 0);
+
+	TEST(tv->timer_settime(timer, TIMER_ABSTIME, tst_its_get(&its), NULL));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "timer_settime() failed");
+
+	if (sigwait(&set, &sig) == -1)
+		tst_brk(TBROK, "sigwait() failed");
+
+	ret = tv->clock_gettime(CLOCK_REALTIME, tst_ts_get(&end));
+	if (ret == -1)
+		tst_brk(TBROK | TERRNO, "clock_gettime() failed");
+
+	if (sig != SIGABRT) {
+		tst_res(TFAIL, "clock_settime(): Y2038 test failed");
+		return;
+	}
+
+	diff = tst_ts_diff_ms(end, start);
+
+	if (diff < TIMER_DELTA * 1000) {
+		tst_res(TFAIL, "Timer expired too soon, after %llims", diff);
+		return;
+	}
+
+	if (diff > TIMER_DELTA * 1000 + ALLOWED_DELTA)
+		tst_res(TINFO, "Time expired too late, after %llims", diff);
+	else
+		tst_res(TPASS, "clock_settime(): Y2038 test passed");
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
2.14.1

