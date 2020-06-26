From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 26 Jun 2020 11:52:17 +0530
Subject: [LTP] [PATCH V7 04/19] syscalls/timerfd: Add support for time64
 tests
In-Reply-To: <cover.1593152309.git.viresh.kumar@linaro.org>
References: <cover.1593152309.git.viresh.kumar@linaro.org>
Message-ID: <657d473ec91c2d43e241ebc4a1ba20679fd4ef9a.1593152309.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds support for time64 tests to the existing timerfd_gettime() and
timerfd_settime() syscall tests.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 testcases/kernel/syscalls/timerfd/timerfd01.c |  56 ++++++--
 testcases/kernel/syscalls/timerfd/timerfd04.c |  54 +++++--
 .../syscalls/timerfd/timerfd_gettime01.c      | 133 ++++++++---------
 .../syscalls/timerfd/timerfd_settime01.c      | 136 ++++++++----------
 .../syscalls/timerfd/timerfd_settime02.c      |  28 +++-
 5 files changed, 237 insertions(+), 170 deletions(-)

diff --git a/testcases/kernel/syscalls/timerfd/timerfd01.c b/testcases/kernel/syscalls/timerfd/timerfd01.c
index 45d4c5d5ea0d..90144b843e30 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd01.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd01.c
@@ -17,7 +17,6 @@
 
 #define _GNU_SOURCE
 #include <poll.h>
-#include "tst_test.h"
 #include "tst_timer.h"
 #include "tst_safe_timerfd.h"
 
@@ -29,25 +28,49 @@ static struct tcase {
 	{CLOCK_REALTIME, "CLOCK REALTIME"},
 };
 
+static struct test_variants {
+	int (*cgettime)(clockid_t clk_id, void *ts);
+	int (*tfd_gettime)(int fd, void *its);
+	int (*tfd_settime)(int fd, int flags, void *new_value, void *old_value);
+	enum tst_ts_type type;
+	char *desc;
+} variants[] = {
+#if (__NR_timerfd_gettime != __LTP__NR_INVALID_SYSCALL)
+	{ .cgettime = sys_clock_gettime, .tfd_gettime = sys_timerfd_gettime, .tfd_settime = sys_timerfd_settime, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+#endif
+
+#if (__NR_timerfd_gettime64 != __LTP__NR_INVALID_SYSCALL)
+	{ .cgettime = sys_clock_gettime64, .tfd_gettime = sys_timerfd_gettime64, .tfd_settime = sys_timerfd_settime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+#endif
+};
+
 static unsigned long long getustime(int clockid)
 {
-	struct timespec tp;
+	struct test_variants *tv = &variants[tst_variant];
+	struct tst_ts tp = {.type = tv->type, };
 
-	if (clock_gettime((clockid_t) clockid, &tp)) {
+	if (tv->cgettime((clockid_t) clockid, tst_ts_get(&tp))) {
 		tst_res(TFAIL | TERRNO, "clock_gettime() failed");
 		return 0;
 	}
 
-	return 1000000ULL * tp.tv_sec + tp.tv_nsec / 1000;
+	return 1000000ULL * tst_ts_get_sec(tp) + tst_ts_get_nsec(tp) / 1000;
 }
 
-static void settime(int tfd, struct itimerspec *tmr, int tflags,
+static void settime(int tfd, struct tst_its *tmr, int tflags,
                     unsigned long long tvalue, int tinterval)
 {
-	tmr->it_value = tst_timespec_from_us(tvalue);
-	tmr->it_interval = tst_timespec_from_us(tinterval);
+	struct test_variants *tv = &variants[tst_variant];
+	struct timespec value = tst_timespec_from_us(tvalue);
+	struct timespec interval = tst_timespec_from_us(tinterval);
 
-	SAFE_TIMERFD_SETTIME(tfd, tflags, tmr, NULL);
+	tst_its_set_interval_sec(tmr, interval.tv_sec);
+	tst_its_set_interval_nsec(tmr, interval.tv_nsec);
+	tst_its_set_value_sec(tmr, value.tv_sec);
+	tst_its_set_value_nsec(tmr, value.tv_nsec);
+
+	if (tv->tfd_settime(tfd, tflags, tst_its_get(tmr), NULL))
+		tst_res(TFAIL, "timerfd_settime() failed");
 }
 
 static void waittmr(int tfd, unsigned int exp_ticks)
@@ -78,10 +101,11 @@ static void waittmr(int tfd, unsigned int exp_ticks)
 
 static void run(unsigned int n)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	int tfd;
 	unsigned long long tnow;
 	uint64_t uticks;
-	struct itimerspec tmr;
+	struct tst_its tmr = {.type = tv->type, };
 	struct tcase *clks = &tcases[n];
 
 	tst_res(TINFO, "testing %s", clks->name);
@@ -102,11 +126,12 @@ static void run(unsigned int n)
 	settime(tfd, &tmr, TFD_TIMER_ABSTIME, tnow + 50 * 1000, 50 * 1000);
 
 	memset(&tmr, 0, sizeof(tmr));
-	if (timerfd_gettime(tfd, &tmr))
-		tst_res(TFAIL | TERRNO, "timerfd_gettime() failed");
+	tmr.type = tv->type;
 
+	if (tv->tfd_gettime(tfd, tst_its_get(&tmr)))
+		tst_res(TFAIL | TERRNO, "timerfd_gettime() failed");
 
-	if (tmr.it_value.tv_sec != 0 || tmr.it_value.tv_nsec > 50 * 1000000)
+	if (tst_its_get_value_sec(tmr) != 0 || tst_its_get_value_nsec(tmr) > 50 * 1000000)
 		tst_res(TFAIL, "Timer read back value not relative");
 	else
 		tst_res(TPASS, "Timer read back value is relative");
@@ -132,8 +157,15 @@ static void run(unsigned int n)
 	SAFE_CLOSE(tfd);
 }
 
+static void setup(void)
+{
+	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
+}
+
 static struct tst_test test = {
 	.test = run,
 	.tcnt = ARRAY_SIZE(tcases),
+	.test_variants = ARRAY_SIZE(variants),
+	.setup = setup,
 	.min_kver = "2.6.25",
 };
diff --git a/testcases/kernel/syscalls/timerfd/timerfd04.c b/testcases/kernel/syscalls/timerfd/timerfd04.c
index 7197fc67ed47..49d50d00022a 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd04.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd04.c
@@ -19,7 +19,6 @@
 #include "tst_safe_timerfd.h"
 #include "tst_timer.h"
 #include "lapi/namespaces_constants.h"
-#include "tst_test.h"
 
 #define SLEEP_US 40000
 
@@ -35,26 +34,59 @@ static struct tcase {
 	{CLOCK_BOOTTIME, CLOCK_BOOTTIME, -10},
 };
 
+static struct test_variants {
+	int (*cgettime)(clockid_t clk_id, void *ts);
+	int (*tfd_settime)(int fd, int flags, void *new_value, void *old_value);
+	enum tst_ts_type type;
+	char *desc;
+} variants[] = {
+#if (__NR_timerfd_settime != __LTP__NR_INVALID_SYSCALL)
+	{ .cgettime = sys_clock_gettime, .tfd_settime = sys_timerfd_settime, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+#endif
+
+#if (__NR_timerfd_settime64 != __LTP__NR_INVALID_SYSCALL)
+	{ .cgettime = sys_clock_gettime64, .tfd_settime = sys_timerfd_settime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+#endif
+};
+
+static void setup(void)
+{
+	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
+}
+
 static void verify_timerfd(unsigned int n)
 {
-	struct timespec start, end;
-	struct itimerspec it = {};
+	struct test_variants *tv = &variants[tst_variant];
+	struct tst_ts start, end;
+	struct tst_its it;
 	struct tcase *tc = &tcases[n];
 
+	start.type = end.type = it.type = tv->type;
 	SAFE_UNSHARE(CLONE_NEWTIME);
 
 	SAFE_FILE_PRINTF("/proc/self/timens_offsets", "%d %d 0",
 	                 tc->clk_off, tc->off);
 
-	SAFE_CLOCK_GETTIME(tc->clk_id, &start);
+	if (tv->cgettime(tc->clk_id, tst_ts_get(&start))) {
+		tst_res(TFAIL | TTERRNO, "clock_gettime(2) failed for clock %s",
+			tst_clock_name(tc->clk_id));
+		return;
+	}
 
-	it.it_value = tst_timespec_add_us(start, 1000000 * tc->off + SLEEP_US);
+	end = tst_ts_add_us(start, 1000000 * tc->off + SLEEP_US);
+	tst_its_set_interval_sec(&it, 0);
+	tst_its_set_interval_nsec(&it, 0);
+	tst_its_set_value_sec(&it, tst_ts_get_sec(end));
+	tst_its_set_value_nsec(&it, tst_ts_get_nsec(end));
 
 	if (!SAFE_FORK()) {
 		uint64_t exp;
 		int fd = SAFE_TIMERFD_CREATE(tc->clk_id, 0);
 
-		SAFE_TIMERFD_SETTIME(fd, TFD_TIMER_ABSTIME, &it, NULL);
+		if (tv->tfd_settime(fd, TFD_TIMER_ABSTIME, tst_its_get(&it), NULL)) {
+			tst_res(TFAIL, "timerfd_settime() failed");
+			return;
+		}
 
 		SAFE_READ(1, fd, &exp, sizeof(exp));
 
@@ -67,9 +99,13 @@ static void verify_timerfd(unsigned int n)
 
 	SAFE_WAIT(NULL);
 
-	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC, &end);
+	if (tv->cgettime(CLOCK_MONOTONIC, tst_ts_get(&end))) {
+		tst_res(TFAIL | TTERRNO, "clock_gettime(2) failed for clock %s",
+			tst_clock_name(CLOCK_MONOTONIC));
+		return;
+	}
 
-	long long diff = tst_timespec_diff_us(end, start);
+	long long diff = tst_ts_diff_us(end, start);
 
 	if (diff > 5 * SLEEP_US) {
 		tst_res(TFAIL, "timerfd %s slept too long %lli",
@@ -90,6 +126,8 @@ static void verify_timerfd(unsigned int n)
 static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_timerfd,
+	.test_variants = ARRAY_SIZE(variants),
+	.setup = setup,
 	.needs_root = 1,
 	.forks_child = 1,
 	.needs_kconfigs = (const char *[]) {
diff --git a/testcases/kernel/syscalls/timerfd/timerfd_gettime01.c b/testcases/kernel/syscalls/timerfd/timerfd_gettime01.c
index 5f3240bdc7d7..49f5aa59a96b 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd_gettime01.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd_gettime01.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2014 Fujitsu Ltd.
  * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
  *
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
- */
-/*
  * DESCRIPTION
  *  Verify that,
  *   1. fd is not a valid file descriptor, EBADF would return.
@@ -24,99 +12,96 @@
 
 #define _GNU_SOURCE
 
-#include <errno.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-
-#include "test.h"
-#include "safe_macros.h"
-#include "lapi/timerfd.h"
+#include "tst_timer.h"
+#include "tst_safe_timerfd.h"
 
 char *TCID = "timerfd_gettime01";
 
 static int bad_clockfd = -1;
 static int clockfd;
 static int fd;
+static void *bad_addr;
 
 static struct test_case_t {
 	int *fd;
-	struct itimerspec *curr_value;
+	struct tst_its *curr_value;
 	int exp_errno;
 } test_cases[] = {
 	{&bad_clockfd, NULL, EBADF},
-	{&clockfd, (struct itimerspec *)-1, EFAULT},
+	{&clockfd, NULL, EFAULT},
 	{&fd, NULL, EINVAL},
 };
 
-int TST_TOTAL = ARRAY_SIZE(test_cases);
-static void setup(void);
-static void timerfd_gettime_verify(const struct test_case_t *);
-static void cleanup(void);
+static struct test_variants {
+	int (*tfd_gettime)(int fd, void *its);
+	char *desc;
+} variants[] = {
+#if (__NR_timerfd_gettime != __LTP__NR_INVALID_SYSCALL)
+	{ .tfd_gettime = sys_timerfd_gettime, .desc = "syscall with old kernel spec"},
+#endif
+
+#if (__NR_timerfd_gettime64 != __LTP__NR_INVALID_SYSCALL)
+	{ .tfd_gettime = sys_timerfd_gettime64, .desc = "syscall time64 with kernel spec"},
+#endif
+};
 
-int main(int argc, char *argv[])
+static void setup(void)
 {
-	int lc;
-	int i;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
+	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
+	bad_addr = tst_get_bad_addr(NULL);
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		for (i = 0; i < TST_TOTAL; i++)
-			timerfd_gettime_verify(&test_cases[i]);
+	clockfd = timerfd_create(CLOCK_REALTIME, 0);
+	if (clockfd == -1) {
+		tst_brk(TFAIL | TERRNO, "timerfd_create() fail");
+		return;
 	}
 
-	cleanup();
-	tst_exit();
+	fd = SAFE_OPEN("test_file", O_RDWR | O_CREAT, 0644);
 }
 
-static void setup(void)
+static void cleanup(void)
 {
-	if ((tst_kvercmp(2, 6, 25)) < 0)
-		tst_brkm(TCONF, NULL, "This test needs kernel 2.6.25 or newer");
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	clockfd = timerfd_create(CLOCK_REALTIME, 0);
-	if (clockfd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "timerfd_create() fail");
+	if (clockfd > 0)
+		close(clockfd);
 
-	fd = SAFE_OPEN(cleanup, "test_file", O_RDWR | O_CREAT, 0644);
+	if (fd > 0)
+		close(fd);
 }
 
-static void timerfd_gettime_verify(const struct test_case_t *test)
+static void run(unsigned int n)
 {
-	TEST(timerfd_gettime(*test->fd, test->curr_value));
+	struct test_variants *tv = &variants[tst_variant];
+	struct test_case_t *test = &test_cases[n];
+	void *its;
 
-	if (TEST_RETURN != -1) {
-		tst_resm(TFAIL, "timerfd_gettime() succeeded unexpectedly");
+	if (test->exp_errno == EFAULT)
+		its = bad_addr;
+	else
+		its = tst_its_get(test->curr_value);
+
+	TEST(tv->tfd_gettime(*test->fd, its));
+
+	if (TST_RET != -1) {
+		tst_res(TFAIL, "timerfd_gettime() succeeded unexpectedly");
 		return;
 	}
 
-	if (TEST_ERRNO == test->exp_errno) {
-		tst_resm(TPASS | TTERRNO,
-			 "timerfd_gettime() failed as expected");
+	if (TST_ERR == test->exp_errno) {
+		tst_res(TPASS | TTERRNO,
+			"timerfd_gettime() failed as expected");
 	} else {
-		tst_resm(TFAIL | TTERRNO,
-			 "timerfd_gettime() failed unexpectedly; expected: "
-			 "%d - %s", test->exp_errno, strerror(test->exp_errno));
+		tst_res(TFAIL | TTERRNO,
+			"timerfd_gettime() failed unexpectedly; expected: "
+			"%d - %s", test->exp_errno, strerror(test->exp_errno));
 	}
 }
 
-static void cleanup(void)
-{
-	if (clockfd > 0)
-		close(clockfd);
-
-	if (fd > 0)
-		close(fd);
-
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(test_cases),
+	.test_variants = ARRAY_SIZE(variants),
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.min_kver = "2.6.25",
+};
diff --git a/testcases/kernel/syscalls/timerfd/timerfd_settime01.c b/testcases/kernel/syscalls/timerfd/timerfd_settime01.c
index 2e65d23ae825..2fd64c1c6a04 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd_settime01.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd_settime01.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2014 Fujitsu Ltd.
  * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
  *
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
- */
-/*
  * DESCRIPTION
  *  Verify that,
  *   1. fd is not a valid file descriptor, EBADF would return.
@@ -25,13 +13,7 @@
 
 #define _GNU_SOURCE
 
-#include <errno.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_timer.h"
 #include "lapi/timerfd.h"
 
 char *TCID = "timerfd_settime01";
@@ -39,80 +21,51 @@ char *TCID = "timerfd_settime01";
 static int bad_clockfd = -1;
 static int clockfd;
 static int fd;
+static void *bad_addr;
 
 static struct test_case_t {
 	int *fd;
 	int flags;
-	struct itimerspec *old_value;
+	struct tst_its *old_value;
 	int exp_errno;
 } test_cases[] = {
 	{&bad_clockfd, 0, NULL, EBADF},
-	{&clockfd, 0, (struct itimerspec *)-1, EFAULT},
+	{&clockfd, 0, NULL, EFAULT},
 	{&fd, 0, NULL, EINVAL},
 	{&clockfd, -1, NULL, EINVAL},
 };
 
-int TST_TOTAL = ARRAY_SIZE(test_cases);
-static void setup(void);
-static void timerfd_settime_verify(const struct test_case_t *);
-static void cleanup(void);
-static struct itimerspec new_value;
+static struct tst_its new_value;
 
-int main(int argc, char *argv[])
-{
-	int lc;
-	int i;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
+static struct test_variants {
+	int (*tfd_settime)(int fd, int flags, void *new_value, void *old_value);
+	enum tst_ts_type type;
+	char *desc;
+} variants[] = {
+#if (__NR_timerfd_settime != __LTP__NR_INVALID_SYSCALL)
+	{ .tfd_settime = sys_timerfd_settime, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+#endif
 
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		for (i = 0; i < TST_TOTAL; i++)
-			timerfd_settime_verify(&test_cases[i]);
-	}
-
-	cleanup();
-	tst_exit();
-}
+#if (__NR_timerfd_settime64 != __LTP__NR_INVALID_SYSCALL)
+	{ .tfd_settime = sys_timerfd_settime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+#endif
+};
 
 static void setup(void)
 {
-	if ((tst_kvercmp(2, 6, 25)) < 0)
-		tst_brkm(TCONF, NULL, "This test needs kernel 2.6.25 or newer");
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	struct test_variants *tv = &variants[tst_variant];
 
-	TEST_PAUSE;
-
-	tst_tmpdir();
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	bad_addr = tst_get_bad_addr(NULL);
+	new_value.type = tv->type;
 
 	clockfd = timerfd_create(CLOCK_REALTIME, 0);
-	if (clockfd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "timerfd_create() fail");
-
-	fd = SAFE_OPEN(cleanup, "test_file", O_RDWR | O_CREAT, 0644);
-}
-
-static void timerfd_settime_verify(const struct test_case_t *test)
-{
-	TEST(timerfd_settime(*test->fd, test->flags, &new_value,
-			     test->old_value));
-
-	if (TEST_RETURN != -1) {
-		tst_resm(TFAIL, "timerfd_settime() succeeded unexpectedly");
+	if (clockfd == -1) {
+		tst_brk(TFAIL | TERRNO, "timerfd_create() fail");
 		return;
 	}
 
-	if (TEST_ERRNO == test->exp_errno) {
-		tst_resm(TPASS | TTERRNO,
-			 "timerfd_settime() failed as expected");
-	} else {
-		tst_resm(TFAIL | TTERRNO,
-			 "timerfd_settime() failed unexpectedly; expected: "
-			 "%d - %s", test->exp_errno, strerror(test->exp_errno));
-	}
+	fd = SAFE_OPEN("test_file", O_RDWR | O_CREAT, 0644);
 }
 
 static void cleanup(void)
@@ -122,6 +75,43 @@ static void cleanup(void)
 
 	if (fd > 0)
 		close(fd);
+}
+
+static void run(unsigned int n)
+{
+	struct test_variants *tv = &variants[tst_variant];
+	struct test_case_t *test = &test_cases[n];
+	void *its;
+
+	if (test->exp_errno == EFAULT)
+		its = bad_addr;
+	else
+		its = tst_its_get(test->old_value);
 
-	tst_rmdir();
+	TEST(tv->tfd_settime(*test->fd, test->flags, tst_its_get(&new_value),
+			     its));
+
+	if (TST_RET != -1) {
+		tst_res(TFAIL, "timerfd_settime() succeeded unexpectedly");
+		return;
+	}
+
+	if (TST_ERR == test->exp_errno) {
+		tst_res(TPASS | TTERRNO,
+			"timerfd_settime() failed as expected");
+	} else {
+		tst_res(TFAIL | TTERRNO,
+			"timerfd_settime() failed unexpectedly; expected: "
+			"%d - %s", test->exp_errno, strerror(test->exp_errno));
+	}
 }
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(test_cases),
+	.test_variants = ARRAY_SIZE(variants),
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.min_kver = "2.6.25",
+};
diff --git a/testcases/kernel/syscalls/timerfd/timerfd_settime02.c b/testcases/kernel/syscalls/timerfd/timerfd_settime02.c
index 0565802f4288..c15b69dca9ca 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd_settime02.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd_settime02.c
@@ -15,8 +15,8 @@
  *  timerfd: Protect the might cancel mechanism proper
  */
 #include <unistd.h>
+#include "tst_timer.h"
 #include "tst_safe_timerfd.h"
-#include "tst_test.h"
 #include "tst_fuzzy_sync.h"
 #include "tst_taint.h"
 
@@ -27,11 +27,30 @@
 #endif
 
 static int fd = -1;
-static struct itimerspec its;
+static struct tst_its its;
 static struct tst_fzsync_pair fzsync_pair;
 
+static struct test_variants {
+	int (*tfd_settime)(int fd, int flags, void *new_value, void *old_value);
+	enum tst_ts_type type;
+	char *desc;
+} variants[] = {
+#if (__NR_timerfd_settime != __LTP__NR_INVALID_SYSCALL)
+	{ .tfd_settime = sys_timerfd_settime, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+#endif
+
+#if (__NR_timerfd_settime64 != __LTP__NR_INVALID_SYSCALL)
+	{ .tfd_settime = sys_timerfd_settime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+#endif
+};
+
 static void setup(void)
 {
+	struct test_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	its.type = tv->type;
+
 	tst_taint_init(TST_TAINT_W | TST_TAINT_D);
 	fd = SAFE_TIMERFD_CREATE(CLOCK_REALTIME, 0);
 
@@ -48,7 +67,9 @@ static void cleanup(void)
 
 static int punch_clock(int flags)
 {
-	return timerfd_settime(fd, flags, &its, NULL);
+	return variants[tst_variant].tfd_settime(fd, flags, tst_its_get(&its),
+						 NULL);
+
 }
 
 static void *thread_run(void *arg)
@@ -91,6 +112,7 @@ static void run(void)
 
 static struct tst_test test = {
 	.test_all = run,
+	.test_variants = ARRAY_SIZE(variants),
 	.setup = setup,
 	.cleanup = cleanup,
 	.min_kver = "2.6.25",
-- 
2.25.0.rc1.19.g042ed3e048af

