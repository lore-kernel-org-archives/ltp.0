From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 26 Jun 2020 11:52:18 +0530
Subject: [LTP] [PATCH V7 05/19] syscalls/sched_rr_get_interval: Add support
 for time64 tests
In-Reply-To: <cover.1593152309.git.viresh.kumar@linaro.org>
References: <cover.1593152309.git.viresh.kumar@linaro.org>
Message-ID: <325a43a851acca8bb242011a1d62063c8154653c.1593152309.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds support for time64 tests to the existing
sched_rr_get_interval() syscall tests.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../sched_rr_get_interval01.c                 | 116 ++++++--------
 .../sched_rr_get_interval02.c                 | 122 ++++++---------
 .../sched_rr_get_interval03.c                 | 146 ++++++++----------
 3 files changed, 157 insertions(+), 227 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
index 6ebf873de798..9bad698aa6ec 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
@@ -1,20 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- */
-/**********************************************************
  *
  *    TEST IDENTIFIER	: sched_rr_get_interval01
  *
@@ -62,81 +48,69 @@
  *				-P x : Pause for x seconds between iterations.
  *				-t   : Turn on syscall timing.
  *
- ****************************************************************/
+ */
 
-#include <errno.h>
 #include <sched.h>
-#include "test.h"
-
-static void setup();
-static void cleanup();
-
-char *TCID = "sched_rr_get_interval01";
-int TST_TOTAL = 1;
-
-struct timespec tp;
-
-int main(int ac, char **av)
-{
-
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
+#include "tst_timer.h"
 
-	setup();
+struct tst_ts tp;
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+static struct test_variants {
+	int (*func)(pid_t pid, void *ts);
+	enum tst_ts_type type;
+	char *desc;
+} variants[] = {
+	{ .func = libc_sched_rr_get_interval, .type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
 
-		tst_count = 0;
+#if (__NR_sched_rr_get_interval != __LTP__NR_INVALID_SYSCALL)
+	{ .func = sys_sched_rr_get_interval, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+#endif
 
-		/*
-		 * Call sched_rr_get_interval(2) with pid=0 so that it will
-		 * write into the timespec structure pointed to by tp, the
-		 * round robin time quantum for the current process.
-		 */
-		TEST(sched_rr_get_interval(0, &tp));
+#if (__NR_sched_rr_get_interval_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .func = sys_sched_rr_get_interval64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+#endif
+};
 
-		if (TEST_RETURN == 0) {
-			tst_resm(TPASS, "sched_rr_get_interval() returned %ld",
-				 TEST_RETURN);
-		} else {
-			tst_resm(TFAIL | TTERRNO,
-				 "Test Failed, sched_rr_get_interval()"
-				 "returned %ld", TEST_RETURN);
-		}
-	}
-
-	/* cleanup and exit */
-	cleanup();
-	tst_exit();
-
-}
-
-/* setup() - performs all ONE TIME setup for this test */
-void setup(void)
+static void setup(void)
 {
-	tst_require_root();
+	struct test_variants *tv = &variants[tst_variant];
 	/*
 	 * Initialize scheduling parameter structure to use with
 	 * sched_setscheduler()
 	 */
 	struct sched_param p = { 1 };
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
 
-	TEST_PAUSE;
+	tp.type = tv->type;
 
 	/* Change scheduling policy to SCHED_RR */
-	if ((sched_setscheduler(0, SCHED_RR, &p)) == -1) {
-		tst_brkm(TBROK|TERRNO, cleanup, "sched_setscheduler() failed");
-	}
+	if ((sched_setscheduler(0, SCHED_RR, &p)) == -1)
+		tst_res(TFAIL | TTERRNO, "sched_setscheduler() failed");
 }
 
-/*
- *cleanup() -  performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- */
-void cleanup(void)
+static void run(void)
 {
+	struct test_variants *tv = &variants[tst_variant];
+
+	/*
+	 * Call sched_rr_get_interval(2) with pid=0 so that it will
+	 * write into the timespec structure pointed to by tp, the
+	 * round robin time quantum for the current process.
+	 */
+	TEST(tv->func(0, tst_ts_get(&tp)));
 
+	if (!TST_RET) {
+		tst_res(TPASS, "sched_rr_get_interval() passed");
+	} else {
+		tst_res(TFAIL | TTERRNO, "Test Failed, sched_rr_get_interval() returned %ld",
+			TST_RET);
+	}
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.test_variants = ARRAY_SIZE(variants),
+	.setup = setup,
+	.needs_root = 1,
+};
diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c
index 367d9e3ff486..8da42e97404b 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c
@@ -1,20 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- */
-/**********************************************************
  *
  *    TEST IDENTIFIER	: sched_rr_get_interval02
  *
@@ -63,84 +49,72 @@
  *				-P x : Pause for x seconds between iterations.
  *				-t   : Turn on syscall timing.
  *
- ****************************************************************/
+ */
 
-#include <errno.h>
 #include <sched.h>
-#include "test.h"
-
-static void setup();
-static void cleanup();
+#include "tst_timer.h"
 
-char *TCID = "sched_rr_get_interval02";
-int TST_TOTAL = 1;
+struct tst_ts tp;
 
-struct timespec tp;
+static struct test_variants {
+	int (*func)(pid_t pid, void *ts);
+	enum tst_ts_type type;
+	char *desc;
+} variants[] = {
+	{ .func = libc_sched_rr_get_interval, .type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
 
-int main(int ac, char **av)
-{
-
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
+#if (__NR_sched_rr_get_interval != __LTP__NR_INVALID_SYSCALL)
+	{ .func = sys_sched_rr_get_interval, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+#endif
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+#if (__NR_sched_rr_get_interval_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .func = sys_sched_rr_get_interval64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+#endif
+};
 
-		tst_count = 0;
-
-		tp.tv_sec = 99;
-		tp.tv_nsec = 99;
-		/*
-		 * Call sched_rr_get_interval(2) with pid=0 sothat it will
-		 * write into the timespec structure pointed to by tp the
-		 * round robin time quantum for the current process.
-		 */
-		TEST(sched_rr_get_interval(0, &tp));
-
-		if ((TEST_RETURN == 0) && (tp.tv_sec == 0) && (tp.tv_nsec == 0)) {
-			tst_resm(TPASS, "Test passed");
-		} else {
-			tst_resm(TFAIL, "Test Failed, sched_rr_get_interval()"
-				 "returned %ld, errno = %d : %s, tp.tv_sec = %d,"
-				 " tp.tv_nsec = %ld", TEST_RETURN, TEST_ERRNO,
-				 strerror(TEST_ERRNO), (int)tp.tv_sec,
-				 tp.tv_nsec);
-		}
-	}
-
-	/* cleanup and exit */
-	cleanup();
-	tst_exit();
-
-}
-
-/* setup() - performs all ONE TIME setup for this test */
-void setup(void)
+static void setup(void)
 {
-	tst_require_root();
+	struct test_variants *tv = &variants[tst_variant];
 	/*
 	 * Initialize scheduling parameter structure to use with
 	 * sched_setscheduler()
 	 */
 	struct sched_param p = { 1 };
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
 
-	TEST_PAUSE;
+	tp.type = tv->type;
 
 	/* Change scheduling policy to SCHED_FIFO */
-	if ((sched_setscheduler(0, SCHED_FIFO, &p)) == -1) {
-		tst_brkm(TBROK|TERRNO, cleanup, "sched_setscheduler() failed");
-	}
+	if ((sched_setscheduler(0, SCHED_FIFO, &p)) == -1)
+		tst_res(TFAIL | TTERRNO, "sched_setscheduler() failed");
 }
 
-/*
- *cleanup() -  performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- */
-void cleanup(void)
+static void run(void)
 {
+	struct test_variants *tv = &variants[tst_variant];
 
+	tst_ts_set_sec(&tp, 99);
+	tst_ts_set_nsec(&tp, 99);
+
+	/*
+	 * Call sched_rr_get_interval(2) with pid=0 so that it will
+	 * write into the timespec structure pointed to by tp the
+	 * round robin time quantum for the current process.
+	 */
+	TEST(tv->func(0, tst_ts_get(&tp)));
+
+	if (!TST_RET && tst_ts_valid(&tp) == -1) {
+		tst_res(TPASS, "sched_rr_get_interval() passed");
+	} else {
+		tst_res(TFAIL | TTERRNO, "Test Failed, sched_rr_get_interval() returned %ld, tp.tv_sec = %lld, tp.tv_nsec = %lld",
+			TST_RET, tst_ts_get_sec(tp), tst_ts_get_nsec(tp));
+	}
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.test_variants = ARRAY_SIZE(variants),
+	.setup = setup,
+	.needs_root = 1,
+};
diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
index 40b636b4dc65..0ccf47d2a561 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
@@ -1,20 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- */
-/**********************************************************
  *
  *    TEST IDENTIFIER	: sched_rr_get_interval03
  *
@@ -68,104 +54,100 @@
  *				-P x : Pause for x seconds between iterations.
  *				-t   : Turn on syscall timing.
  *
- ****************************************************************/
+ */
 
-#include <errno.h>
 #include <sched.h>
-#include "test.h"
-
-static void setup();
-static void cleanup();
-
-char *TCID = "sched_rr_get_interval03";
-struct timespec tp;
+#include "tst_timer.h"
 
 static pid_t unused_pid;
 static pid_t inval_pid = -1;
 static pid_t zero_pid;
 
+struct tst_ts tp;
+static void *bad_addr;
+
 struct test_cases_t {
 	pid_t *pid;
-	struct timespec *tp;
+	struct tst_ts *tp;
 	int exp_errno;
 } test_cases[] = {
-	{
-	&inval_pid, &tp, EINVAL}, {
-	&unused_pid, &tp, ESRCH},
+	{ &inval_pid, &tp, EINVAL},
+	{ &unused_pid, &tp, ESRCH},
 #ifndef UCLINUX
-	    /* Skip since uClinux does not implement memory protection */
-	{
-	&zero_pid, (struct timespec *)-1, EFAULT}
+	/* Skip since uClinux does not implement memory protection */
+	{ &zero_pid, NULL, EFAULT}
 #endif
 };
 
-int TST_TOTAL = sizeof(test_cases) / sizeof(test_cases[0]);
+static struct test_variants {
+	int (*func)(pid_t pid, void *ts);
+	enum tst_ts_type type;
+	char *desc;
+} variants[] = {
+	{ .func = libc_sched_rr_get_interval, .type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
 
-int main(int ac, char **av)
-{
-
-	int lc, i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; ++i) {
-			/*
-			 * Call sched_rr_get_interval(2)
-			 */
-			TEST(sched_rr_get_interval(*(test_cases[i].pid),
-						   test_cases[i].tp));
-
-			if ((TEST_RETURN == -1) &&
-			    (TEST_ERRNO == test_cases[i].exp_errno)) {
-				tst_resm(TPASS, "Test Passed");
-			} else {
-				tst_resm(TFAIL | TTERRNO, "Test Failed,"
-					 " sched_rr_get_interval() returned %ld",
-					 TEST_RETURN);
-			}
-		}
-	}
-
-	/* cleanup and exit */
-	cleanup();
-
-	tst_exit();
+#if (__NR_sched_rr_get_interval != __LTP__NR_INVALID_SYSCALL)
+	{ .func = sys_sched_rr_get_interval, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+#endif
 
-}
+#if (__NR_sched_rr_get_interval_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .func = sys_sched_rr_get_interval64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+#endif
+};
 
-/* setup() - performs all ONE TIME setup for this test */
-void setup(void)
+static void setup(void)
 {
-	tst_require_root();
+	struct test_variants *tv = &variants[tst_variant];
 	/*
 	 * Initialize scheduling parameter structure to use with
 	 * sched_setscheduler()
 	 */
 	struct sched_param p = { 1 };
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
 
-	TEST_PAUSE;
+	bad_addr = tst_get_bad_addr(NULL);
+	tp.type = tv->type;
 
 	/* Change scheduling policy to SCHED_RR */
-	if ((sched_setscheduler(0, SCHED_RR, &p)) == -1) {
-		tst_brkm(TBROK|TERRNO, cleanup, "sched_setscheduler() failed");
-	}
+	if ((sched_setscheduler(0, SCHED_RR, &p)) == -1)
+		tst_res(TFAIL | TTERRNO, "sched_setscheduler() failed");
 
-	unused_pid = tst_get_unused_pid(cleanup);
+	unused_pid = tst_get_unused_pid();
 }
 
-/*
- *cleanup() -  performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- */
-void cleanup(void)
+static void run(unsigned int i)
 {
+	struct test_variants *tv = &variants[tst_variant];
+	struct test_cases_t *tc = &test_cases[i];
+	struct timerspec *ts;
 
+	if (tc->exp_errno == EFAULT)
+		ts = bad_addr;
+	else
+		ts = tst_ts_get(tc->tp);
+
+	/*
+	 * Call sched_rr_get_interval(2)
+	 */
+	TEST(tv->func(*tc->pid, ts));
+
+	if (TST_RET != -1) {
+		tst_res(TFAIL, "sched_rr_get_interval() passed unexcpectedly");
+		return;
+	}
+
+	if (tc->exp_errno == TST_ERR)
+		tst_res(TPASS | TTERRNO, "sched_rr_get_interval() failed as excpected");
+	else
+		tst_res(TFAIL | TTERRNO, "sched_rr_get_interval() failed unexcpectedly: %s",
+			tst_strerrno(tc->exp_errno));
 }
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(test_cases),
+	.test_variants = ARRAY_SIZE(variants),
+	.setup = setup,
+	.needs_root = 1,
+};
-- 
2.25.0.rc1.19.g042ed3e048af

