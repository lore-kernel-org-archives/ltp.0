From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Wed,  5 Dec 2018 17:30:57 -0200
Subject: [LTP] [PATCH 1/2] syscalls/clock_settime01.c: create syscall
	clock_settime test
Message-ID: <20181205193058.11146-1-rafael.tinoco@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes: 343

clock_settime01 creates a new test, using new API, based on existing and
older kernel/timers/clock_settime tests. It includes tests from files
clock_settime02 and clock_settime03, which will be deleted in next
commits.

Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 runtest/syscalls                              |   2 +
 .../kernel/syscalls/clock_settime/.gitignore  |   1 +
 .../kernel/syscalls/clock_settime/Makefile    |   8 +
 .../syscalls/clock_settime/clock_settime01.c  | 187 ++++++++++++++++++
 4 files changed, 198 insertions(+)
 create mode 100644 testcases/kernel/syscalls/clock_settime/.gitignore
 create mode 100644 testcases/kernel/syscalls/clock_settime/Makefile
 create mode 100644 testcases/kernel/syscalls/clock_settime/clock_settime01.c

diff --git a/runtest/syscalls b/runtest/syscalls
index ac1d2d2cd..4cbc13209 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -79,6 +79,8 @@ clock_nanosleep01 clock_nanosleep01
 clock_nanosleep02 clock_nanosleep02
 clock_nanosleep2_01 clock_nanosleep2_01
 
+clock_settime01 clock_settime01
+
 clone01 clone01
 clone02 clone02
 clone03 clone03
diff --git a/testcases/kernel/syscalls/clock_settime/.gitignore b/testcases/kernel/syscalls/clock_settime/.gitignore
new file mode 100644
index 000000000..fcbb9fecc
--- /dev/null
+++ b/testcases/kernel/syscalls/clock_settime/.gitignore
@@ -0,0 +1 @@
+clock_settime01
diff --git a/testcases/kernel/syscalls/clock_settime/Makefile b/testcases/kernel/syscalls/clock_settime/Makefile
new file mode 100644
index 000000000..e6674a6b2
--- /dev/null
+++ b/testcases/kernel/syscalls/clock_settime/Makefile
@@ -0,0 +1,8 @@
+# Copyright (c) 2018 - Linaro Limited. All rights reserved.
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/clock_settime/clock_settime01.c b/testcases/kernel/syscalls/clock_settime/clock_settime01.c
new file mode 100644
index 000000000..591e5c723
--- /dev/null
+++ b/testcases/kernel/syscalls/clock_settime/clock_settime01.c
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2018 Linaro Limited. All rights reserved.
+ * Author: Rafael David Tinoco <rafael.tinoco@linaro.org>
+ */
+
+/*
+ * Basic tests for clock_settime(2) on different clock types
+ */
+
+#include "config.h"
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+
+#define NSEC_PER_SEC (1000000000L)
+#define MAX_CLOCKS 16
+
+static struct timespec clock_realtime_saved;
+
+struct test_case {
+	clockid_t type;
+	struct timespec newtime;
+	int exp_ret;
+	int exp_err;
+	int replace;
+};
+
+struct test_case tc[] = {
+	{				/* case 01: REALTIME		      */
+	 .type = CLOCK_REALTIME,
+	 .exp_ret = 0,
+	 },
+	{				/* case 02: REALTIME: timespec NULL   */
+	 .type = CLOCK_REALTIME,
+	 .newtime.tv_sec = -2,
+	 .exp_ret = -1,
+	 .exp_err = EFAULT,
+	 .replace = 1,
+	 },
+	{				/* case 03: REALTIME: tv_sec = -1     */
+	 .type = CLOCK_REALTIME,
+	 .newtime.tv_sec = -1,
+	 .exp_ret = -1,
+	 .exp_err = EINVAL,
+	 .replace = 1,
+	 },
+	{				/* case 04: REALTIME: tv_nsec = -1    */
+	 .type = CLOCK_REALTIME,
+	 .newtime.tv_nsec = -1,
+	 .exp_ret = -1,
+	 .exp_err = EINVAL,
+	 .replace = 1,
+	 },
+	{				/* case 05: REALTIME: tv_nsec = 1s+1  */
+	 .type = CLOCK_REALTIME,
+	 .newtime.tv_nsec = NSEC_PER_SEC + 1,
+	 .exp_ret = -1,
+	 .exp_err = EINVAL,
+	 .replace = 1,
+	 },
+	{				/* case 06: MONOTONIC		      */
+	 .type = CLOCK_MONOTONIC,
+	 .exp_ret = -1,
+	 .exp_err = EINVAL,
+	 },
+	{				/* case 07: MAXCLOCK		      */
+	 .type = MAX_CLOCKS,
+	 .exp_ret = -1,
+	 .exp_err = EINVAL,
+	 },
+	{				/* case 08: MAXCLOCK+1		      */
+	 .type = MAX_CLOCKS + 1,
+	 .exp_ret = -1,
+	 .exp_err = EINVAL,
+	 },
+	/* Linux specific */
+	{				/* case 09: CLOCK_MONOTONIC_COARSE    */
+	 .type = CLOCK_MONOTONIC_COARSE,
+	 .exp_ret = -1,
+	 .exp_err = EINVAL,
+	 },
+	{				/* case 10: CLOCK_MONOTONIC_RAW       */
+	 .type = CLOCK_MONOTONIC_RAW,
+	 .exp_ret = -1,
+	 .exp_err = EINVAL,
+	 },
+	{				/* case 11: CLOCK_BOOTTIME	      */
+	 .type = CLOCK_BOOTTIME,
+	 .exp_ret = -1,
+	 .exp_err = EINVAL,
+	 },
+	{				/* case 12: CLOCK_PROCESS_CPUTIME_ID  */
+	 .type = CLOCK_PROCESS_CPUTIME_ID,
+	 .exp_ret = -1,
+	 .exp_err = EINVAL,
+	 },
+	{				/* case 13: CLOCK_THREAD_CPUTIME_ID   */
+	 .type = CLOCK_THREAD_CPUTIME_ID,
+	 .exp_ret = -1,
+	 .exp_err = EINVAL,
+	 },
+};
+
+static int sys_clock_settime(clockid_t clk_id, struct timespec *tp)
+{
+	return tst_syscall(__NR_clock_settime, clk_id, tp);
+}
+
+static int sys_clock_gettime(clockid_t clk_id, struct timespec *tp)
+{
+	return tst_syscall(__NR_clock_gettime, clk_id, tp);
+}
+
+static void cleanup(void)
+{
+	/* restore realtime clock */
+
+	if (sys_clock_settime(CLOCK_REALTIME, &clock_realtime_saved) < 0)
+		tst_res(TBROK | TTERRNO, "clock_settime(2): could not set "
+				"current time back");
+}
+
+static void setup(void)
+{
+	if (sys_clock_gettime(CLOCK_REALTIME, &clock_realtime_saved) < 0)
+		tst_res(TBROK | TTERRNO, "clock_gettime(2): could not get "
+				"current time");
+}
+
+static void verify_clock_settime(unsigned int i)
+{
+	struct timespec spec, *specptr;
+
+	if (tc[i].replace == 0) {
+
+		/* add 1 sec to test clock */
+
+		specptr = &spec;
+		specptr->tv_sec = clock_realtime_saved.tv_sec + 1;
+		specptr->tv_nsec = clock_realtime_saved.tv_nsec;
+
+	} else {
+
+		/* bad pointer case */
+
+		if (tc[i].newtime.tv_sec == -2)
+			specptr = tst_get_bad_addr(cleanup);
+
+		/* use given values */
+
+		else {
+			specptr = &spec;
+			specptr->tv_sec = tc[i].newtime.tv_sec;
+			specptr->tv_nsec = tc[i].newtime.tv_nsec;
+		}
+	}
+
+	TEST(sys_clock_settime(tc[i].type, specptr));
+
+	if (tc[i].exp_ret == TST_RET) {
+
+		if (TST_RET >= 0)
+			tst_res(TPASS, "clock_settime(2): worked as expected");
+
+		else {
+			if (tc[i].exp_err == TST_ERR)
+				tst_res(TPASS, "clock_settime(2): failed as "
+						"expected");
+			else
+				tst_res(TFAIL | TTERRNO, "clock_settime(2): "
+						"failed with different error");
+		}
+
+		return;
+	}
+
+	tst_res(TFAIL | TTERRNO, "clock_settime(2): clock type %d failed",
+			tc[i].type);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test = verify_clock_settime,
+	.cleanup = cleanup,
+	.tcnt = ARRAY_SIZE(tc),
+	.needs_root = 1,
+};
-- 
2.20.0.rc1

