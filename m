From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri,  5 Jun 2020 13:18:13 +0530
Subject: [LTP] [PATCH] syscalls/clock_gettime: Add test to check bug during
 successive readings
Message-ID: <e15907ed42f0276f09c4120b9255db5764d4e9b6.1591343286.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

An issue was reported recently where a bug was found during successive
reading of 64 bit time on arm32 platforms. Add a test for that.

https://github.com/richfelker/musl-cross-make/issues/96

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/clock_gettime/.gitignore  |  1 +
 .../syscalls/clock_gettime/clock_gettime04.c  | 96 +++++++++++++++++++
 3 files changed, 98 insertions(+)
 create mode 100644 testcases/kernel/syscalls/clock_gettime/clock_gettime04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index f9a6397560fa..d7c3cbed611a 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -96,6 +96,7 @@ clock_nanosleep04 clock_nanosleep04
 clock_gettime01 clock_gettime01
 clock_gettime02 clock_gettime02
 clock_gettime03 clock_gettime03
+clock_gettime04 clock_gettime04
 leapsec01 leapsec01
 
 clock_settime01 clock_settime01
diff --git a/testcases/kernel/syscalls/clock_gettime/.gitignore b/testcases/kernel/syscalls/clock_gettime/.gitignore
index 9d06613b6f41..304eedab68c6 100644
--- a/testcases/kernel/syscalls/clock_gettime/.gitignore
+++ b/testcases/kernel/syscalls/clock_gettime/.gitignore
@@ -1,4 +1,5 @@
 clock_gettime01
 clock_gettime02
 clock_gettime03
+clock_gettime04
 leapsec01
diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
new file mode 100644
index 000000000000..139883033dce
--- /dev/null
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Linaro Limited. All rights reserved.
+ * Author: Viresh Kumar<viresh.kumar@linaro.org>
+ *
+ * Check time difference between successive readings and report a bug if
+ * difference found to be over 5 ms.
+ */
+
+#include "config.h"
+#include "tst_timer.h"
+#include "tst_safe_clocks.h"
+
+clockid_t clks[] = {
+	CLOCK_REALTIME,
+	CLOCK_REALTIME_COARSE,
+	CLOCK_MONOTONIC,
+	CLOCK_MONOTONIC_COARSE,
+	CLOCK_MONOTONIC_RAW,
+	CLOCK_BOOTTIME,
+};
+
+static struct test_variants {
+	int (*gettime)(clockid_t clk_id, void *ts);
+	enum tst_ts_type type;
+	char *desc;
+} variants[] = {
+	{ .gettime = libc_clock_gettime, .type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
+
+#if (__NR_clock_gettime != __LTP__NR_INVALID_SYSCALL)
+	{ .gettime = sys_clock_gettime, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+#endif
+
+#if (__NR_clock_gettime64 != __LTP__NR_INVALID_SYSCALL)
+	{ .gettime = sys_clock_gettime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+#endif
+};
+
+static void run(unsigned int i)
+{
+	struct tst_ts ts_start, ts_end;
+	long long start, end, diff;
+	struct test_variants *tv;
+	int count = 10000;
+	unsigned int j;
+
+	while (--count) {
+		/* Store reference time in start */
+		if (clks[i] == CLOCK_REALTIME) {
+			struct timeval tval;
+
+			/* Compare CLOCK_REALTIME with gettimeofday() as well */
+			if (gettimeofday(&tval, NULL) < 0)
+				tst_brk(TBROK | TERRNO, "gettimeofday() failed");
+
+			start = tst_timeval_to_ms(tval);
+		} else {
+			tv = &variants[0];
+			ts_start.type = tv->type;
+			tv->gettime(clks[i], tst_ts_get(&ts_start));
+			start = tst_ts_to_ms(ts_start);
+		}
+
+		for (j = 0; j < ARRAY_SIZE(variants); j++) {
+			tv = &variants[j];
+			ts_end.type = tv->type;
+
+			tv->gettime(clks[i], tst_ts_get(&ts_end));
+			end = tst_ts_to_ms(ts_end);
+
+			diff = end - start;
+			if (diff < 0) {
+				tst_res(TFAIL, "%s: Time travelled backwards: %lld",
+						tst_clock_name(clks[i]), diff);
+				return;
+			}
+
+			if (diff >= 5) {
+				tst_res(TFAIL, "%s: Difference between successive readings greater than 5 ms: %lld",
+						tst_clock_name(clks[i]), diff);
+				return;
+			}
+
+			/* Refresh time in start */
+			start = end;
+		}
+	}
+
+	tst_res(TPASS, "%s: Difference between successive readings is reasonable",
+		tst_clock_name(clks[i]));
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(clks),
+};
-- 
2.25.0.rc1.19.g042ed3e048af

