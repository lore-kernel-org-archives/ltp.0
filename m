From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 11 Jun 2020 14:04:20 +0530
Subject: [LTP] [PATCH V2 2/2] syscalls/clock_gettime: Add test to check bug
 during successive readings
In-Reply-To: <0f1cc05d6d79238ed94b93417f300e9a026a2063.1591864369.git.viresh.kumar@linaro.org>
References: <0f1cc05d6d79238ed94b93417f300e9a026a2063.1591864369.git.viresh.kumar@linaro.org>
Message-ID: <cc75beb4074b62e94b8ac92cba17af41b8f5fbdc.1591864369.git.viresh.kumar@linaro.org>
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
V2:
- Test vDSOs as well and overall improved test.

 runtest/syscalls                              |   1 +
 .../kernel/syscalls/clock_gettime/.gitignore  |   1 +
 .../kernel/syscalls/clock_gettime/Makefile    |   5 +-
 .../syscalls/clock_gettime/clock_gettime04.c  | 197 ++++++++++++++++++
 4 files changed, 203 insertions(+), 1 deletion(-)
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
diff --git a/testcases/kernel/syscalls/clock_gettime/Makefile b/testcases/kernel/syscalls/clock_gettime/Makefile
index 79f671f1c597..1c1cbd7a8853 100644
--- a/testcases/kernel/syscalls/clock_gettime/Makefile
+++ b/testcases/kernel/syscalls/clock_gettime/Makefile
@@ -3,8 +3,11 @@
 
 top_srcdir		?= ../../../..
 
+LTPLIBS = ltpvdso
+
 include $(top_srcdir)/include/mk/testcases.mk
 
 LDLIBS+=-lrt
+clock_gettime04: LDLIBS += -lltpvdso
 
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
\ No newline at end of file
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
new file mode 100644
index 000000000000..a70288ce0cb9
--- /dev/null
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
@@ -0,0 +1,197 @@
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
+#include "parse_vdso.h"
+#include "tst_timer.h"
+#include "tst_safe_clocks.h"
+
+#include <sys/auxv.h>
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
+typedef int (*gettime_t)(clockid_t clk_id, void *ts);
+static gettime_t ptr_vdso_gettime, ptr_vdso_gettime64;
+
+static inline int _vdso_gettime(gettime_t vdso, clockid_t clk_id, void *ts)
+{
+	if (!vdso) {
+		errno = ENOSYS;
+		return -1;
+	}
+
+	return vdso(clk_id, ts);
+}
+
+static inline int vdso_gettime(clockid_t clk_id, void *ts)
+{
+	return _vdso_gettime(ptr_vdso_gettime, clk_id, ts);
+}
+
+static inline int vdso_gettime64(clockid_t clk_id, void *ts)
+{
+	return _vdso_gettime(ptr_vdso_gettime64, clk_id, ts);
+}
+
+static void find_vdso_helpers(void)
+{
+	/*
+	 * Some vDSO exports its clock_gettime() implementation with a different
+	 * name and version from other architectures, so we need to handle it as
+	 * a special case.
+	 */
+#if defined(__powerpc__) || defined(__powerpc64__)
+	const char *version = "LINUX_2.6.15";
+	const char *name = "__kernel_clock_gettime";
+#elif defined(__aarch64__)
+	const char *version = "LINUX_2.6.39";
+	const char *name = "__kernel_clock_gettime";
+#elif defined(__s390__)
+	const char *version = "LINUX_2.6.29";
+	const char *name = "__kernel_clock_gettime";
+#else
+	const char *version = "LINUX_2.6";
+	const char *name = "__vdso_clock_gettime";
+#endif
+
+	const char *version64 = "LINUX_2.6";
+	const char *name64 = "__vdso_clock_gettime64";
+
+	unsigned long sysinfo_ehdr = getauxval(AT_SYSINFO_EHDR);
+
+	if (!sysinfo_ehdr) {
+		tst_res(TINFO, "Couldn't find AT_SYSINFO_EHDR");
+		return;
+	}
+
+	vdso_init_from_sysinfo_ehdr(sysinfo_ehdr);
+
+	ptr_vdso_gettime = vdso_sym(version, name);
+	if (!ptr_vdso_gettime)
+		tst_res(TINFO, "Couldn't find vdso_gettime()");
+
+	ptr_vdso_gettime64 = vdso_sym(version64, name64);
+	if (!ptr_vdso_gettime64)
+		tst_res(TINFO, "Couldn't find vdso_gettime64()");
+}
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
+	{ .gettime = vdso_gettime, .type = TST_KERN_OLD_TIMESPEC, .desc = "vDSO with old kernel spec"},
+#endif
+
+#if (__NR_clock_gettime64 != __LTP__NR_INVALID_SYSCALL)
+	{ .gettime = sys_clock_gettime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+	{ .gettime = vdso_gettime64, .type = TST_KERN_TIMESPEC, .desc = "vDSO time64 with kernel spec"},
+#endif
+	{ .gettime = my_gettimeofday, .type = TST_LIBC_TIMESPEC, .desc = "gettimeofday"},
+};
+
+static void run(unsigned int i)
+{
+	struct tst_ts ts;
+	long long start, end = 0, diff, slack;
+	struct test_variants *tv;
+	int count = 10000, ret;
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
+			ret = tv->gettime(clks[i], tst_ts_get(&ts));
+			if (ret) {
+				if (errno != ENOSYS) {
+					tst_res(TFAIL | TERRNO, "%s: clock_gettime() failed (%d)",
+						tst_clock_name(clks[i]), j);
+				}
+				continue;
+			}
+
+			end = tst_ts_to_ns(ts);
+
+			/* Skip comparison on first traversal */
+			if (count == 10000 && !j)
+				continue;
+
+			/*
+			 * gettimeofday() doesn't capture time less than 1 us,
+			 * add 999 to it.
+			 */
+			if (tv->gettime == my_gettimeofday)
+				slack = 999;
+			else
+				slack = 0;
+
+			diff = end + slack - start;
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
+	.setup = find_vdso_helpers,
+	.tcnt = ARRAY_SIZE(clks),
+};
-- 
2.25.0.rc1.19.g042ed3e048af

