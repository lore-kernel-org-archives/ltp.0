From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 8 Jun 2020 16:50:00 +0530
Subject: [LTP] [PATCH] syscalls/clock_gettime: Add test to check bug
 during successive readings
In-Reply-To: <CAK8P3a004cavRhyWx+uXYYteBi1LviahAv11+9JyGadN-vo8og@mail.gmail.com>
References: <e15907ed42f0276f09c4120b9255db5764d4e9b6.1591343286.git.viresh.kumar@linaro.org>
 <CAK8P3a0b2BbZq_yYBKJHUfZgzCYUtdidpzJEj-HzuBKf1Q_nnQ@mail.gmail.com>
 <20200608100900.c4fi7pw7euie6tnt@vireshk-i7>
 <CAK8P3a004cavRhyWx+uXYYteBi1LviahAv11+9JyGadN-vo8og@mail.gmail.com>
Message-ID: <20200608112000.sjrbvmqjciifgyub@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 08-06-20, 12:21, Arnd Bergmann wrote:
> So now you only call gettimeofday() once instead of in each loop, right?
> This won't test for spurious failures any more, but I suppose it would catch
> any case where gettimeofday() and clock_gettime() are out of sync by
> a lot. The only case you don't catch is where clock_gettime() sometimes
> returns a value that is slightly earlier than gettimeofday().

Okay, I missed the fact that we need to call gettimeofday() for every iteration
and here is the new diff which has tried to simplify the overall code. But this
has a problem now as it always reports this error:

clock_gettime04.c:88: FAIL: CLOCK_REALTIME: Time travelled backwards (2): -148 ns

I guess the problem is that gettimeofday() gets the value in usec resolution and
clock_gettime() gets it in nsec and so some nsec always get lost with
gettimeofday() and so the errors ? How should we take care of this ? Take diff
in usec instead of nsec ?

+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
@@ -0,0 +1,109 @@
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
+static inline int my_gettimeofday(clockid_t clk_id, void *ts)
+{
+	struct timeval tval;
+
+	if (clk_id != CLOCK_REALTIME)
+		tst_brk(TBROK, "%s: Invalid clk_id, exiting", tst_clock_name(clk_id));
+
+	if (gettimeofday(&tval, NULL) < 0)
+		tst_brk(TBROK | TERRNO, "gettimeofday() failed");
+
+	/*
+	 * The array defines the type to TST_LIBC_TIMESPEC and so we can cast
+	 * this into struct timespec.
+	 */
+	*((struct timespec *)ts) = tst_timespec_from_us(tst_timeval_to_us(tval));
+	return 0;
+}
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
+	{ .gettime = my_gettimeofday, .type = TST_LIBC_TIMESPEC, .desc = "gettimeofday"},
+};
+
+static void run(unsigned int i)
+{
+	struct tst_ts ts;
+	long long start, end = 0, diff;
+	struct test_variants *tv;
+	int count = 10000;
+	unsigned int j;
+
+	do {
+		for (j = 0; j < ARRAY_SIZE(variants); j++) {
+			/* Refresh time in start */
+			start = end;
+
+			tv = &variants[j];
+			ts.type = tv->type;
+
+			/* Do gettimeofday() test only for CLOCK_REALTIME */
+			if (tv->gettime == my_gettimeofday && clks[i] != CLOCK_REALTIME)
+				continue;
+
+			tv->gettime(clks[i], tst_ts_get(&ts));
+			end = tst_ts_to_ns(ts);
+
+			/* Skip comparison on first traversal */
+			if (count == 10000 && !j)
+				continue;
+
+			diff = end - start;
+			if (diff < 0) {
+				tst_res(TFAIL, "%s: Time travelled backwards (%d): %lld ns",
+					tst_clock_name(clks[i]), j, diff);
+				return;
+			}
+
+			diff /= 1000000;
+
+			if (diff >= 5) {
+				tst_res(TFAIL, "%s: Difference between successive readings greater than 5 ms (%d): %lld",
+					tst_clock_name(clks[i]), j, diff);
+				return;
+			}
+		}
+	} while (--count);
+
+	tst_res(TPASS, "%s: Difference between successive readings is reasonable",
+		tst_clock_name(clks[i]));
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(clks),
+};
