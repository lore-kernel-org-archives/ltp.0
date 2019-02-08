From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Fri,  8 Feb 2019 11:29:55 -0200
Subject: [LTP] [PATCH v2 1/2] syscalls/clock_gettime: create clock_gettime
	syscall tests
In-Reply-To: <20190207123137.GA9277@rei>
References: <20190207123137.GA9277@rei>
Message-ID: <20190208132956.18990-1-rafael.tinoco@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes: 342

clock_gettime{01,02} are created using the new API, based on existing
kernel/timers/clock_gettime{02,03} tests, which will be deleted in the
next commits.

Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 runtest/syscalls                              |   3 +
 .../kernel/syscalls/clock_gettime/.gitignore  |   2 +
 .../kernel/syscalls/clock_gettime/Makefile    |  10 ++
 .../syscalls/clock_gettime/clock_gettime01.c  | 141 ++++++++++++++++++
 .../syscalls/clock_gettime/clock_gettime02.c  | 139 +++++++++++++++++
 5 files changed, 295 insertions(+)
 create mode 100644 testcases/kernel/syscalls/clock_gettime/.gitignore
 create mode 100644 testcases/kernel/syscalls/clock_gettime/Makefile
 create mode 100644 testcases/kernel/syscalls/clock_gettime/clock_gettime01.c
 create mode 100644 testcases/kernel/syscalls/clock_gettime/clock_gettime02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 668c87cd1..7bccda996 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -79,6 +79,9 @@ clock_nanosleep01 clock_nanosleep01
 clock_nanosleep02 clock_nanosleep02
 clock_nanosleep2_01 clock_nanosleep2_01
 
+clock_gettime01 clock_gettime01
+clock_gettime02 clock_gettime02
+
 clock_settime01 clock_settime01
 clock_settime02 clock_settime02
 
diff --git a/testcases/kernel/syscalls/clock_gettime/.gitignore b/testcases/kernel/syscalls/clock_gettime/.gitignore
new file mode 100644
index 000000000..0f9b24ab6
--- /dev/null
+++ b/testcases/kernel/syscalls/clock_gettime/.gitignore
@@ -0,0 +1,2 @@
+clock_gettime01
+clock_gettime02
diff --git a/testcases/kernel/syscalls/clock_gettime/Makefile b/testcases/kernel/syscalls/clock_gettime/Makefile
new file mode 100644
index 000000000..79f671f1c
--- /dev/null
+++ b/testcases/kernel/syscalls/clock_gettime/Makefile
@@ -0,0 +1,10 @@
+# Copyright (c) 2019 - Linaro Limited. All rights reserved.
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+LDLIBS+=-lrt
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
\ No newline at end of file
diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime01.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime01.c
new file mode 100644
index 000000000..d365823b2
--- /dev/null
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime01.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Linaro Limited. All rights reserved.
+ * Author: Rafael David Tinoco <rafael.tinoco@linaro.org>
+ */
+/*
+ * Basic test for clock_gettime(2) on multiple clocks:
+ *
+ *  1) CLOCK_REALTIME
+ *  2) CLOCK_MONOTONIC
+ *  3) CLOCK_PROCESS_CPUTIME_ID
+ *  4) CLOCK_THREAD_CPUTIME_ID
+ *  5) CLOCK_REALTIME_COARSE
+ *  6) CLOCK_MONOTONIC_COARSE
+ *  7) CLOCK_MONOTONIC_RAW
+ *  8) CLOCK_BOOTTIME
+ */
+
+#include "config.h"
+#include "tst_timer.h"
+#include "tst_safe_clocks.h"
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+
+struct test_case {
+	clockid_t clktype;
+	int allow_inval;
+};
+
+struct tmpfunc {
+	int (*func)(clockid_t clk_id, struct timespec *tp);
+	char *desc;
+};
+
+struct test_case tc[] = {
+	{
+	 .clktype = CLOCK_REALTIME,
+	 },
+	{
+	 .clktype = CLOCK_MONOTONIC,
+	 },
+	{
+	 .clktype = CLOCK_PROCESS_CPUTIME_ID,
+	 },
+	{
+	 .clktype = CLOCK_THREAD_CPUTIME_ID,
+	 },
+	{
+	 .clktype = CLOCK_REALTIME_COARSE,
+	 .allow_inval = 1,
+	 },
+	{
+	 .clktype = CLOCK_MONOTONIC_COARSE,
+	 .allow_inval = 1,
+	 },
+	{
+	 .clktype = CLOCK_MONOTONIC_RAW,
+	 .allow_inval = 1,
+	 },
+	{
+	 .clktype = CLOCK_BOOTTIME,
+	 .allow_inval = 1,
+	 },
+};
+
+static int sys_clock_gettime(clockid_t clk_id, struct timespec *tp)
+{
+	return tst_syscall(__NR_clock_gettime, clk_id, tp);
+}
+
+static int check_spec(struct timespec *spec)
+{
+	return (spec->tv_nsec != 0 || spec->tv_sec != 0) ? 1 : 0;
+}
+
+static void verify_clock_gettime(unsigned int i)
+{
+	size_t sz;
+	struct timespec spec;
+
+	/*
+	 * check clock_gettime() syscall AND libc (or vDSO) functions
+	 */
+	struct tmpfunc tf[] = {
+		{ .func = sys_clock_gettime, .desc = "syscall"      },
+		{ .func = clock_gettime, .desc = "vDSO or syscall"  },
+	};
+
+	for (sz = 0; sz < ARRAY_SIZE(tf); sz++) {
+
+		memset(&spec, 0, sizeof(struct timespec));
+
+		TEST(tf[sz].func(tc[i].clktype, &spec));
+
+		if (TST_RET == -1) {
+
+			/* errors: allow unsupported clock types */
+
+			if (tc[i].allow_inval && TST_ERR == EINVAL) {
+
+				tst_res(TPASS, "clock_gettime(2): unsupported "
+						"clock %s (%s) failed as "
+						"expected",
+						tst_clock_name(tc[i].clktype),
+						tf[sz].desc);
+
+			} else {
+
+				tst_res(TFAIL | TTERRNO, "clock_gettime(2): "
+						"clock %s (%s) failed "
+						"unexpectedly",
+						tst_clock_name(tc[i].clktype),
+						tf[sz].desc);
+			}
+
+		} else {
+
+			/* success: also check if timespec was changed */
+
+			if (check_spec(&spec)) {
+				tst_res(TPASS, "clock_gettime(2): clock %s "
+						"(%s) passed",
+						tst_clock_name(tc[i].clktype),
+						tf[sz].desc);
+			} else {
+
+				tst_res(TFAIL, "clock_gettime(2): clock %s "
+						"(%s) passed, unchanged "
+						"timespec",
+						tst_clock_name(tc[i].clktype),
+						tf[sz].desc);
+			}
+		}
+	}
+}
+
+static struct tst_test test = {
+	.test = verify_clock_gettime,
+	.tcnt = ARRAY_SIZE(tc),
+	.needs_root = 1,
+};
diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c
new file mode 100644
index 000000000..4db52c09d
--- /dev/null
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Linaro Limited. All rights reserved.
+ * Author: Rafael David Tinoco <rafael.tinoco@linaro.org>
+ */
+/*
+ * Bad argument tests for clock_gettime(2) on multiple clocks:
+ *
+ *  1) MAX_CLOCKS
+ *  2) MAX_CLOCKS + 1
+ *  3) CLOCK_REALTIME
+ *  4) CLOCK_MONOTONIC
+ *  5) CLOCK_PROCESS_CPUTIME_ID
+ *  6) CLOCK_THREAD_CPUTIME_ID
+ *  7) CLOCK_REALTIME_COARSE
+ *  8) CLOCK_MONOTONIC_COARSE
+ *  9) CLOCK_MONOTONIC_RAW
+ * 10) CLOCK_BOOTTIME
+ */
+
+#include "config.h"
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+#include "lapi/posix_clocks.h"
+#include "tst_timer.h"
+#include "tst_safe_clocks.h"
+
+#include <stdio.h>
+
+#define DELTA_SEC 10
+#define NSEC_PER_SEC (1000000000L)
+#define MAX_CLOCKS 16
+
+struct test_case {
+	clockid_t clktype;
+	int exp_err;
+	int allow_inval;
+};
+
+struct test_case tc[] = {
+	{
+	 .clktype = MAX_CLOCKS,
+	 .exp_err = EINVAL,
+	 },
+	{
+	 .clktype = MAX_CLOCKS + 1,
+	 .exp_err = EINVAL,
+	 },
+	/*
+	 * Different POSIX clocks have different (*clock_get)() handlers.
+	 * It justifies testing EFAULT for all.
+	 */
+	{
+	 .clktype = CLOCK_REALTIME,
+	 .exp_err = EFAULT,
+	 },
+	{
+	 .clktype = CLOCK_MONOTONIC,
+	 .exp_err = EFAULT,
+	 },
+	{
+	 .clktype = CLOCK_PROCESS_CPUTIME_ID,
+	 .exp_err = EFAULT,
+	 },
+	{
+	 .clktype = CLOCK_THREAD_CPUTIME_ID,
+	 .exp_err = EFAULT,
+	 },
+	{
+	 .clktype = CLOCK_REALTIME_COARSE,
+	 .exp_err = EFAULT,
+	 .allow_inval = 1,
+	 },
+	{
+	 .clktype = CLOCK_MONOTONIC_COARSE,
+	 .exp_err = EFAULT,
+	 .allow_inval = 1,
+	 },
+	{
+	 .clktype = CLOCK_MONOTONIC_RAW,
+	 .exp_err = EFAULT,
+	 .allow_inval = 1,
+	 },
+	{
+	 .clktype = CLOCK_BOOTTIME,
+	 .exp_err = EFAULT,
+	 .allow_inval = 1,
+	 },
+};
+
+/*
+ * bad pointer w/ libc causes SIGSEGV signal, call syscall directly
+ */
+static int sys_clock_gettime(clockid_t clk_id, struct timespec *tp)
+{
+	return tst_syscall(__NR_clock_gettime, clk_id, tp);
+}
+
+static void verify_clock_gettime(unsigned int i)
+{
+	struct timespec spec, *specptr;
+
+	specptr = &spec;
+
+	/* bad pointer cases */
+	if (tc[i].exp_err == EFAULT)
+		specptr = tst_get_bad_addr(NULL);
+
+	TEST(sys_clock_gettime(tc[i].clktype, specptr));
+
+	if (TST_RET == -1) {
+
+		if ((tc[i].exp_err == TST_ERR) ||
+			(tc[i].allow_inval && TST_ERR == EINVAL)) {
+
+			tst_res(TPASS | TTERRNO, "clock_gettime(2): "
+					"clock %s failed as expected",
+					tst_clock_name(tc[i].clktype));
+
+		} else {
+
+			tst_res(TFAIL | TTERRNO, "clock_gettime(2): "
+					"clock %s failed unexpectedly",
+					tst_clock_name(tc[i].clktype));
+		}
+
+	} else {
+
+		tst_res(TFAIL, "clock_gettime(2): clock %s passed"
+				" unexcpectedly",
+				tst_clock_name(tc[i].clktype));
+	}
+}
+
+static struct tst_test test = {
+	.test = verify_clock_gettime,
+	.tcnt = ARRAY_SIZE(tc),
+	.needs_root = 1,
+};
-- 
2.20.1

