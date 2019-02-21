From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Thu, 21 Feb 2019 17:30:37 -0300
Subject: [LTP] [PATCH v2 2/2] syscalls/clock_adjtime: create clock_adjtime
	syscall tests
In-Reply-To: <20190221203037.21826-1-rafael.tinoco@linaro.org>
References: <20190221200547.7277-2-rafael.tinoco@linaro.org>
 <20190221203037.21826-1-rafael.tinoco@linaro.org>
Message-ID: <20190221203037.21826-2-rafael.tinoco@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes: 270

clock_adjtime{01,02} are created using the new API, based on existing
adjtimex(2) tests. clock_adjtime() syscall might have as execution
path:

 1) a regular POSIX clock (only REALTIME clock implements adjtime())
 	- will behave exactly like adjtimex() system call.
 	- only one being tested here.

 2) a dynamic POSIX clock (which ops are implemented by PTP clocks)
 	- will trigger the PTP clock driver function "adjtime()"
 	- different implementations from one PTP clock to another
 	- might return EOPNOTSUPP (like ptp_kvm_caps, for example)
 	- no observed execution entry point for clock_adjtime()

Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 runtest/syscalls                              |   3 +
 .../kernel/syscalls/clock_adjtime/.gitignore  |   2 +
 .../kernel/syscalls/clock_adjtime/Makefile    |  10 +
 .../syscalls/clock_adjtime/clock_adjtime01.c  | 249 +++++++++++++++++
 .../syscalls/clock_adjtime/clock_adjtime02.c  | 261 ++++++++++++++++++
 5 files changed, 525 insertions(+)
 create mode 100644 testcases/kernel/syscalls/clock_adjtime/.gitignore
 create mode 100644 testcases/kernel/syscalls/clock_adjtime/Makefile
 create mode 100644 testcases/kernel/syscalls/clock_adjtime/clock_adjtime01.c
 create mode 100644 testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 7bccda996..093e7f2ef 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -74,6 +74,9 @@ chroot02 chroot02
 chroot03 chroot03
 chroot04 chroot04
 
+clock_adjtime01 clock_adjtime01
+clock_adjtime02 clock_adjtime02
+
 clock_getres01 clock_getres01
 clock_nanosleep01 clock_nanosleep01
 clock_nanosleep02 clock_nanosleep02
diff --git a/testcases/kernel/syscalls/clock_adjtime/.gitignore b/testcases/kernel/syscalls/clock_adjtime/.gitignore
new file mode 100644
index 000000000..28d5a1d45
--- /dev/null
+++ b/testcases/kernel/syscalls/clock_adjtime/.gitignore
@@ -0,0 +1,2 @@
+clock_adjtime01
+clock_adjtime02
diff --git a/testcases/kernel/syscalls/clock_adjtime/Makefile b/testcases/kernel/syscalls/clock_adjtime/Makefile
new file mode 100644
index 000000000..79f671f1c
--- /dev/null
+++ b/testcases/kernel/syscalls/clock_adjtime/Makefile
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
diff --git a/testcases/kernel/syscalls/clock_adjtime/clock_adjtime01.c b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime01.c
new file mode 100644
index 000000000..541d9437d
--- /dev/null
+++ b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime01.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Linaro Limited. All rights reserved.
+ * Author: Rafael David Tinoco <rafael.tinoco@linaro.org>
+ */
+
+/*
+ * clock_adjtime() syscall might have as execution path:
+ *
+ *   1) a regular POSIX clock (only REALTIME clock implements adjtime())
+ *      - will behave exactly like adjtimex() system call.
+ *      - only one being tested here.
+ *
+ *   2) a dynamic POSIX clock (which ops are implemented by PTP clocks)
+ *      - will trigger the PTP clock driver function "adjtime()"
+ *      - different implementations from one PTP clock to another
+ *      - might return EOPNOTSUPP (like ptp_kvm_caps, for example)
+ *      - no entry point for clock_adjtime(), missing "CLOCK_PTP" model
+ *
+ * so it is sane to check possible adjustments:
+ *
+ *    - ADJ_OFFSET     - usec or nsec, kernel adjusts time gradually by offset
+ *                       (-512000 < offset < 512000)
+ *    - ADJ_FREQUENCY  - system clock frequency offset
+ *    - ADJ_MAXERROR   - maximum error (usec)
+ *    - ADJ_ESTERROR   - estimated time error in us
+ *    - ADJ_STATUS     - clock command/status of ntp implementation
+ *    - ADJ_TIMECONST  - PLL stiffness (jitter dependent) + poll int for PLL
+ *    - ADJ_TICK       - us between clock ticks
+ *                       (>= 900000/HZ, <= 1100000/HZ)
+ *
+ * and also the standalone ones (using .offset variable):
+ *
+ *    - ADJ_OFFSET_SINGLESHOT - behave like adjtime()
+ *    - ADJ_OFFSET_SS_READ - ret remaining time for completion after SINGLESHOT
+ *
+ * For ADJ_STATUS, consider the following flags:
+ *
+ *      rw  STA_PLL - enable phase-locked loop updates (ADJ_OFFSET)
+ *      rw  STA_PPSFREQ - enable PPS (pulse-per-second) freq discipline
+ *      rw  STA_PPSTIME - enable PPS time discipline
+ *      rw  STA_FLL - select freq-locked loop mode.
+ *      rw  STA_INS - ins leap sec after the last sec of UTC day (all days)
+ *      rw  STA_DEL - del leap sec@last sec of UTC day (all days)
+ *      rw  STA_UNSYNC - clock unsynced
+ *      rw  STA_FREQHOLD - hold freq. ADJ_OFFSET made w/out auto small adjs
+ *      ro  STA_PPSSIGNAL - valid PPS (pulse-per-second) signal is present
+ *      ro  STA_PPSJITTER - PPS signal jitter exceeded.
+ *      ro  STA_PPSWANDER - PPS signal wander exceeded.
+ *      ro  STA_PPSERROR - PPS signal calibration error.
+ *      ro  STA_CLOKERR - clock HW fault.
+ *      ro  STA_NANO - 0 = us, 1 = ns (set = ADJ_NANO, cl = ADJ_MICRO)
+ *      rw  STA_MODE - mode: 0 = phased locked loop. 1 = freq locked loop
+ *      ro  STA_CLK - clock source. unused.
+ */
+
+#include "config.h"
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+#include "lapi/posix_clocks.h"
+#include "tst_timer.h"
+#include "tst_safe_clocks.h"
+#include <sys/timex.h>
+
+static long hz;
+static struct timex saved, ttxc;
+
+#define ADJ_ALL (ADJ_OFFSET | ADJ_FREQUENCY | ADJ_MAXERROR | ADJ_ESTERROR | \
+	ADJ_STATUS | ADJ_TIMECONST | ADJ_TICK)
+
+struct test_case {
+	unsigned int modes;
+	long highlimit;
+	long *ptr;
+	long delta;
+};
+
+struct test_case tc[] = {
+	{
+	 .modes = ADJ_OFFSET_SINGLESHOT,
+	},
+	{
+	 .modes = ADJ_OFFSET_SS_READ,
+	},
+	{
+	 .modes = ADJ_ALL,
+	},
+	{
+	 .modes = ADJ_OFFSET,
+	 .highlimit = 512000,
+	 .ptr = &ttxc.offset,
+	 .delta = 10000,
+	},
+	{
+	 .modes = ADJ_FREQUENCY,
+	 .ptr = &ttxc.freq,
+	 .delta = 100,
+	},
+	{
+	 .modes = ADJ_MAXERROR,
+	 .ptr = &ttxc.maxerror,
+	 .delta = 100,
+	},
+	{
+	 .modes = ADJ_ESTERROR,
+	 .ptr = &ttxc.esterror,
+	 .delta = 100,
+	},
+	{
+	 .modes = ADJ_TIMECONST,
+	 .ptr = &ttxc.constant,
+	 .delta = 1,
+	},
+	{
+	 .modes = ADJ_TICK,
+	 .highlimit = 1100000,
+	 .ptr = &ttxc.tick,
+	 .delta = 1000,
+	},
+};
+
+/*
+ * bad pointer w/ libc causes SIGSEGV signal, call syscall directly
+ */
+static int sys_clock_adjtime(clockid_t clk_id, struct timex *txc)
+{
+	return tst_syscall(__NR_clock_adjtime, clk_id, txc);
+}
+
+static void timex_show(char *given, struct timex txc)
+{
+	tst_res(TINFO,  "%s\n"
+			"             mode: %d\n"
+			"           offset: %ld\n"
+			"        frequency: %ld\n"
+			"         maxerror: %ld\n"
+			"         esterror: %ld\n"
+			"           status: %d (0x%x)\n"
+			"    time_constant: %ld\n"
+			"        precision: %ld\n"
+			"        tolerance: %ld\n"
+			"             tick: %ld\n"
+			"         raw time: %d(s) %d(us)",
+			given,
+			txc.modes,
+			txc.offset,
+			txc.freq,
+			txc.maxerror,
+			txc.esterror,
+			txc.status,
+			txc.status,
+			txc.constant,
+			txc.precision,
+			txc.tolerance,
+			txc.tick,
+			(int)txc.time.tv_sec,
+			(int)txc.time.tv_usec);
+}
+
+static void verify_clock_adjtime(unsigned int i)
+{
+	long ptroff, *ptr;
+	struct timex verify;
+
+	memset(&ttxc, 0, sizeof(struct timex));
+	memset(&verify, 0, sizeof(struct timex));
+
+	SAFE_CLOCK_ADJTIME(CLOCK_REALTIME, &ttxc);
+	timex_show("GET", ttxc);
+
+	ttxc.modes = tc[i].modes;
+
+	if (tc[i].ptr && tc[i].delta) {
+
+		*tc[i].ptr += tc[i].delta;
+
+		/* fix limits, if existent, so no errors occur */
+
+		if (tc[i].highlimit) {
+			if (*tc[i].ptr >= tc[i].highlimit)
+				*tc[i].ptr -= (2 * tc[i].delta);
+		}
+	}
+
+	SAFE_CLOCK_ADJTIME(CLOCK_REALTIME, &ttxc);
+	timex_show("SET", ttxc);
+
+	if (tc[i].ptr) {
+
+		/* adjtimex field being tested so we can verify later */
+
+		ptroff = (long) tc[i].ptr - (long) &ttxc;
+		ptr = (void *) &verify + ptroff;
+	}
+
+	TEST(sys_clock_adjtime(CLOCK_REALTIME, &verify));
+	timex_show("VERIFY", verify);
+
+	if (tc[i].ptr && *tc[i].ptr != *ptr) {
+		tst_res(TFAIL, "clock_adjtime(): could not set value (mode=%x)",
+				tc[i].modes);
+	}
+
+	if (TST_RET < 0) {
+		tst_res(TFAIL | TTERRNO, "clock_adjtime(): mode=%x, returned "
+				"error", tc[i].modes);
+	}
+
+	tst_res(TPASS, "clock_adjtime(): success (mode=%x)", tc[i].modes);
+}
+
+static void setup(void)
+{
+	size_t i;
+
+	hz = SAFE_SYSCONF(_SC_CLK_TCK);
+
+	/* fix high and low limits by dividing it per HZ value */
+	for (i = 0; i < ARRAY_SIZE(tc); i++) {
+		if (tc[i].modes == ADJ_TICK)
+			tc[i].highlimit /= hz;
+	}
+
+	SAFE_CLOCK_ADJTIME(CLOCK_REALTIME, &saved);
+}
+
+static void cleanup(void)
+{
+	saved.modes = ADJ_ALL;
+
+	/* restore clock resolution based on original status flag */
+
+	if (saved.status & STA_NANO)
+		saved.modes |= ADJ_NANO;
+	else
+		saved.modes |= ADJ_MICRO;
+
+	/* restore original clock flags */
+
+	SAFE_CLOCK_ADJTIME(CLOCK_REALTIME, &saved);
+}
+
+static struct tst_test test = {
+	.test = verify_clock_adjtime,
+	.setup = setup,
+	.cleanup = cleanup,
+	.tcnt = ARRAY_SIZE(tc),
+	.needs_root = 1,
+};
diff --git a/testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c
new file mode 100644
index 000000000..ec1071c11
--- /dev/null
+++ b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c
@@ -0,0 +1,261 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Linaro Limited. All rights reserved.
+ * Author: Rafael David Tinoco <rafael.tinoco@linaro.org>
+ */
+
+/*
+ * clock_adjtime() syscall might have as execution path:
+ *
+ *   1) a regular POSIX clock (only REALTIME clock implements adjtime())
+ *      - will behave exactly like adjtimex() system call.
+ *      - only one being tested here.
+ *
+ *   2) a dynamic POSIX clock (which ops are implemented by PTP clocks)
+ *      - will trigger the PTP clock driver function "adjtime()"
+ *      - different implementations from one PTP clock to another
+ *      - might return EOPNOTSUPP (like ptp_kvm_caps, for example)
+ *      - no entry point for clock_adjtime(), missing "CLOCK_PTP" model
+ *
+ * so it is sane to check for the following errors:
+ *
+ *   EINVAL -  clock id being used does not exist
+ *
+ *   EFAULT - (struct timex *) does not point to valid memory
+ *
+ *   EINVAL - ADJ_OFFSET + .offset outside range -512000 < x < 512000
+ *            (after 2.6.26, kernels normalize to the limit if outside range)
+ *
+ *   EINVAL - ADJ_FREQUENCY + .freq outside range -32768000 < x < 3276800
+ *            (after 2.6.26, kernels normalize to the limit if outside range)
+ *
+ *   EINVAL - .tick outside permitted range (900000/HZ < .tick < 1100000/HZ)
+ *
+ *   EPERM  - .modes is neither 0 nor ADJ_OFFSET_SS_READ (CAP_SYS_TIME required)
+ *
+ *   EINVAL - .status other than those listed bellow
+ *
+ * For ADJ_STATUS, consider the following flags:
+ *
+ *      rw  STA_PLL - enable phase-locked loop updates (ADJ_OFFSET)
+ *      rw  STA_PPSFREQ - enable PPS (pulse-per-second) freq discipline
+ *      rw  STA_PPSTIME - enable PPS time discipline
+ *      rw  STA_FLL - select freq-locked loop mode.
+ *      rw  STA_INS - ins leap sec after the last sec of UTC day (all days)
+ *      rw  STA_DEL - del leap sec@last sec of UTC day (all days)
+ *      rw  STA_UNSYNC - clock unsynced
+ *      rw  STA_FREQHOLD - hold freq. ADJ_OFFSET made w/out auto small adjs
+ *      ro  STA_PPSSIGNAL - valid PPS (pulse-per-second) signal is present
+ *      ro  STA_PPSJITTER - PPS signal jitter exceeded.
+ *      ro  STA_PPSWANDER - PPS signal wander exceeded.
+ *      ro  STA_PPSERROR - PPS signal calibration error.
+ *      ro  STA_CLOKERR - clock HW fault.
+ *      ro  STA_NANO - 0 = us, 1 = ns (set = ADJ_NANO, cl = ADJ_MICRO)
+ *      rw  STA_MODE - mode: 0 = phased locked loop. 1 = freq locked loop
+ *      ro  STA_CLK - clock source. unused.
+ */
+
+#include "config.h"
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+#include "lapi/posix_clocks.h"
+#include "tst_timer.h"
+#include "tst_safe_clocks.h"
+#include <sys/timex.h>
+#include <pwd.h>
+
+#include <stdio.h>
+
+static long hz;
+static struct timex saved, ttxc;
+
+#define ADJ_ALL (ADJ_OFFSET | ADJ_FREQUENCY | ADJ_MAXERROR | ADJ_ESTERROR | \
+	ADJ_STATUS | ADJ_TIMECONST | ADJ_TICK)
+
+#define MAX_CLOCKS 16
+
+struct test_case {
+	clockid_t clktype;
+	unsigned int modes;
+	long lowlimit;
+	long highlimit;
+	long *ptr;
+	long delta;
+	int exp_err;
+	int droproot;
+};
+
+struct test_case tc[] = {
+	{
+	 .clktype = MAX_CLOCKS,
+	 .exp_err = EINVAL,
+	},
+	{
+	 .clktype = MAX_CLOCKS + 1,
+	 .exp_err = EINVAL,
+	},
+	{
+	 .clktype = CLOCK_REALTIME,
+	 .modes = ADJ_ALL,
+	 .exp_err = EFAULT,
+	},
+	{
+	 .clktype = CLOCK_REALTIME,
+	 .modes = ADJ_TICK,
+	 .lowlimit = 900000,
+	 .ptr = &ttxc.tick,
+	 .delta = 1,
+	 .exp_err = EINVAL,
+	},
+	{
+	 .clktype = CLOCK_REALTIME,
+	 .modes = ADJ_TICK,
+	 .highlimit = 1100000,
+	 .ptr = &ttxc.tick,
+	 .delta = 1,
+	 .exp_err = EINVAL,
+	},
+	{
+	 .clktype = CLOCK_REALTIME,
+	 .modes = ADJ_ALL,
+	 .exp_err = EPERM,
+	 .droproot = 1,
+	},
+};
+
+/*
+ * bad pointer w/ libc causes SIGSEGV signal, call syscall directly
+ */
+static int sys_clock_adjtime(clockid_t clk_id, struct timex *txc)
+{
+	return tst_syscall(__NR_clock_adjtime, clk_id, txc);
+}
+
+static void timex_show(char *given, struct timex txc)
+{
+	tst_res(TINFO,  "%s\n"
+			"             mode: 0x%x\n"
+			"           offset: %ld\n"
+			"        frequency: %ld\n"
+			"         maxerror: %ld\n"
+			"         esterror: %ld\n"
+			"           status: 0x%x\n"
+			"    time_constant: %ld\n"
+			"        precision: %ld\n"
+			"        tolerance: %ld\n"
+			"             tick: %ld\n"
+			"         raw time: %d(s) %d(us)",
+			given,
+			txc.modes,
+			txc.offset,
+			txc.freq,
+			txc.maxerror,
+			txc.esterror,
+			txc.status,
+			txc.constant,
+			txc.precision,
+			txc.tolerance,
+			txc.tick,
+			(int)txc.time.tv_sec,
+			(int)txc.time.tv_usec);
+}
+
+static void verify_clock_adjtime(unsigned int i)
+{
+	uid_t whoami = 0;
+	struct timex *txcptr;
+	struct passwd *nobody;
+	const char name[] = "nobody";
+
+	txcptr = &ttxc;
+
+	memset(txcptr, 0, sizeof(struct timex));
+
+	SAFE_CLOCK_ADJTIME(CLOCK_REALTIME, txcptr);
+	timex_show("GET", *txcptr);
+
+	if (tc[i].droproot) {
+		nobody = SAFE_GETPWNAM(name);
+		whoami = nobody->pw_uid;
+		SAFE_SETEUID(whoami);
+	}
+
+	txcptr->modes = tc[i].modes;
+
+	if (tc[i].ptr) {
+
+		if (tc[i].lowlimit)
+			*tc[i].ptr = tc[i].lowlimit - tc[i].delta;
+
+		if (tc[i].highlimit)
+			*tc[i].ptr = tc[i].highlimit + tc[i].delta;
+	}
+
+	/* special case - if txcptr != NULL, SIGSEGV is throwed */
+	if (tc[i].exp_err == EFAULT)
+		txcptr = NULL;
+
+	TEST(sys_clock_adjtime(tc[i].clktype, txcptr));
+	if (txcptr)
+		timex_show("TEST", *txcptr);
+
+	if (TST_RET >= 0) {
+		tst_res(TFAIL, "clock_adjtime(): passed unexpectedly (mode=%x, "
+				"uid=%d)", tc[i].modes, whoami);
+		return;
+	}
+
+	if (tc[i].exp_err != TST_ERR) {
+		tst_res(TFAIL | TTERRNO, "clock_adjtime(): expected %d but "
+				"failed with %d (mode=%x, uid=%d)",
+				tc[i].exp_err, TST_ERR, tc[i].modes, whoami);
+		return;
+	}
+
+	tst_res(TPASS, "clock_adjtime(): failed as expected (mode=0x%x, "
+			"uid=%d)", tc[i].modes, whoami);
+
+	if (tc[i].droproot)
+		SAFE_SETEUID(0);
+}
+
+static void setup(void)
+{
+	size_t i;
+
+	hz = SAFE_SYSCONF(_SC_CLK_TCK);
+
+	/* fix high and low limits by dividing it per HZ value */
+	for (i = 0; i < ARRAY_SIZE(tc); i++) {
+		if (tc[i].modes == ADJ_TICK) {
+			tc[i].highlimit /= hz;
+			tc[i].lowlimit /= hz;
+		}
+	}
+
+	SAFE_CLOCK_ADJTIME(CLOCK_REALTIME, &saved);
+}
+
+static void cleanup(void)
+{
+	saved.modes = ADJ_ALL;
+
+	/* restore clock resolution based on original status flag */
+
+	if (saved.status & STA_NANO)
+		saved.modes |= ADJ_NANO;
+	else
+		saved.modes |= ADJ_MICRO;
+
+	/* restore original clock flags */
+
+	SAFE_CLOCK_ADJTIME(CLOCK_REALTIME, &saved);
+}
+
+static struct tst_test test = {
+	.test = verify_clock_adjtime,
+	.setup = setup,
+	.cleanup = cleanup,
+	.tcnt = ARRAY_SIZE(tc),
+	.needs_root = 1,
+};
-- 
2.20.1

