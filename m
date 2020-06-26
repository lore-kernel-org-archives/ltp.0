From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 26 Jun 2020 11:52:19 +0530
Subject: [LTP] [PATCH V7 06/19] syscalls/futex: Merge futex_wait_bitset tests
In-Reply-To: <cover.1593152309.git.viresh.kumar@linaro.org>
References: <cover.1593152309.git.viresh.kumar@linaro.org>
Message-ID: <681915c7fbb224ffdd9acb5dba012cc7aadfbd46.1593152309.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We can handle them easily in a single test, lets do it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/syscalls                              |  1 -
 testcases/kernel/syscalls/futex/.gitignore    |  1 -
 testcases/kernel/syscalls/futex/Makefile      |  1 -
 .../kernel/syscalls/futex/futex_wait_bitset.h | 75 -------------------
 .../syscalls/futex/futex_wait_bitset01.c      | 73 +++++++++++++++++-
 .../syscalls/futex/futex_wait_bitset02.c      | 18 -----
 6 files changed, 71 insertions(+), 98 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/futex/futex_wait_bitset.h
 delete mode 100644 testcases/kernel/syscalls/futex/futex_wait_bitset02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index b4d523319924..5b3a0862faea 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1671,7 +1671,6 @@ futex_wake02 futex_wake02
 futex_wake03 futex_wake03
 futex_wake04 futex_wake04
 futex_wait_bitset01 futex_wait_bitset01
-futex_wait_bitset02 futex_wait_bitset02
 
 memfd_create01 memfd_create01
 memfd_create02 memfd_create02
diff --git a/testcases/kernel/syscalls/futex/.gitignore b/testcases/kernel/syscalls/futex/.gitignore
index 68bc2028e1b2..54cd02b0223f 100644
--- a/testcases/kernel/syscalls/futex/.gitignore
+++ b/testcases/kernel/syscalls/futex/.gitignore
@@ -6,7 +6,6 @@
 /futex_wait04
 /futex_wait05
 /futex_wait_bitset01
-/futex_wait_bitset02
 /futex_wake01
 /futex_wake02
 /futex_wake03
diff --git a/testcases/kernel/syscalls/futex/Makefile b/testcases/kernel/syscalls/futex/Makefile
index 8dd239301e63..c88af7c9643b 100644
--- a/testcases/kernel/syscalls/futex/Makefile
+++ b/testcases/kernel/syscalls/futex/Makefile
@@ -12,7 +12,6 @@ futex_wake02: CFLAGS+=-pthread
 futex_wake04: CFLAGS+=-pthread
 futex_wait05: LDLIBS+=-lrt
 futex_wait_bitset01: LDLIBS+=-lrt
-futex_wait_bitset02: LDLIBS+=-lrt
 
 include $(top_srcdir)/include/mk/testcases.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/futex/futex_wait_bitset.h b/testcases/kernel/syscalls/futex/futex_wait_bitset.h
deleted file mode 100644
index 84712816bfe8..000000000000
--- a/testcases/kernel/syscalls/futex/futex_wait_bitset.h
+++ /dev/null
@@ -1,75 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
- */
-
-#define THRESHOLD_US 100000
-#define DEFAULT_TIMEOUT_US 100010
-
-static void verify_futex_wait_bitset(long long wait_us, clock_t clk_id)
-{
-	struct timespec start, to, end;
-	futex_t futex = FUTEX_INITIALIZER;
-	u_int32_t bitset = 0xffffffff;
-	int flags = clk_id == CLOCK_REALTIME ? FUTEX_CLOCK_REALTIME : 0;
-
-	tst_res(TINFO, "testing futex_wait_bitset() timeout with %s",
-		clk_id == CLOCK_REALTIME ? "CLOCK_REALTIME" : "CLOCK_MONOTONIC");
-
-	clock_gettime(clk_id, &start);
-	to = tst_timespec_add_us(start, wait_us);
-
-	TEST(futex_wait_bitset(&futex, futex, &to, bitset, flags));
-
-	clock_gettime(clk_id, &end);
-
-	if (TST_RET != -1) {
-		tst_res(TFAIL, "futex_wait_bitset() returned %li, expected -1",
-			TST_RET);
-		return;
-	}
-
-	if (TST_ERR == ENOSYS) {
-		tst_res(TCONF,
-			"In this kernel, futex() does not support FUTEX_WAIT_BITSET operation");
-		return;
-	}
-
-	if (TST_ERR != ETIMEDOUT) {
-		tst_res(TFAIL | TTERRNO, "expected %s",
-			tst_strerrno(ETIMEDOUT));
-		return;
-	}
-
-	if (tst_timespec_lt(end, to)) {
-		tst_res(TFAIL,
-			"futex_wait_bitset() woken up prematurely %llius, expected %llius",
-			tst_timespec_diff_us(end, start), wait_us);
-		return;
-	}
-
-	if (tst_timespec_diff_us(end, to) > THRESHOLD_US) {
-		tst_res(TFAIL,
-			"futex_wait_bitset() waited too long %llius, expected %llius",
-			tst_timespec_diff_us(end, start), wait_us);
-		return;
-	}
-
-	tst_res(TPASS, "futex_wait_bitset() waited %llius, expected %llius",
-		tst_timespec_diff_us(end, start), wait_us);
-}
-
-static void setup(void)
-{
-	tst_timer_check(USE_CLOCK);
-}
-
-static void run(void)
-{
-	verify_futex_wait_bitset(DEFAULT_TIMEOUT_US, USE_CLOCK);
-}
-
-static struct tst_test test = {
-	.setup = setup,
-	.test_all = run,
-};
diff --git a/testcases/kernel/syscalls/futex/futex_wait_bitset01.c b/testcases/kernel/syscalls/futex/futex_wait_bitset01.c
index 1ae3253cfe13..b8546c3e640c 100644
--- a/testcases/kernel/syscalls/futex/futex_wait_bitset01.c
+++ b/testcases/kernel/syscalls/futex/futex_wait_bitset01.c
@@ -13,7 +13,76 @@
 #include "tst_timer.h"
 #include "futextest.h"
 
-#define USE_CLOCK CLOCK_MONOTONIC
+#define THRESHOLD_US 100000
+#define DEFAULT_TIMEOUT_US 100010
 
-#include "futex_wait_bitset.h"
+static struct test_case_t {
+	clockid_t clk_id;
+} tcases[] = {
+	{ CLOCK_MONOTONIC },
+	{ CLOCK_REALTIME }
+};
 
+static void verify_futex_wait_bitset(long long wait_us, clock_t clk_id)
+{
+	struct timespec start, to, end;
+	futex_t futex = FUTEX_INITIALIZER;
+	u_int32_t bitset = 0xffffffff;
+	int flags = clk_id == CLOCK_REALTIME ? FUTEX_CLOCK_REALTIME : 0;
+
+	tst_res(TINFO, "testing futex_wait_bitset() timeout with %s",
+		clk_id == CLOCK_REALTIME ? "CLOCK_REALTIME" : "CLOCK_MONOTONIC");
+
+	clock_gettime(clk_id, &start);
+	to = tst_timespec_add_us(start, wait_us);
+
+	TEST(futex_wait_bitset(&futex, futex, &to, bitset, flags));
+
+	clock_gettime(clk_id, &end);
+
+	if (TST_RET != -1) {
+		tst_res(TFAIL, "futex_wait_bitset() returned %li, expected -1",
+			TST_RET);
+		return;
+	}
+
+	if (TST_ERR == ENOSYS) {
+		tst_res(TCONF,
+			"In this kernel, futex() does not support FUTEX_WAIT_BITSET operation");
+		return;
+	}
+
+	if (TST_ERR != ETIMEDOUT) {
+		tst_res(TFAIL | TTERRNO, "expected %s",
+			tst_strerrno(ETIMEDOUT));
+		return;
+	}
+
+	if (tst_timespec_lt(end, to)) {
+		tst_res(TFAIL,
+			"futex_wait_bitset() woken up prematurely %llius, expected %llius",
+			tst_timespec_diff_us(end, start), wait_us);
+		return;
+	}
+
+	if (tst_timespec_diff_us(end, to) > THRESHOLD_US) {
+		tst_res(TFAIL,
+			"futex_wait_bitset() waited too long %llius, expected %llius",
+			tst_timespec_diff_us(end, start), wait_us);
+		return;
+	}
+
+	tst_res(TPASS, "futex_wait_bitset() waited %llius, expected %llius",
+		tst_timespec_diff_us(end, start), wait_us);
+}
+
+static void run(unsigned int n)
+{
+	tst_timer_check(tcases[n].clk_id);
+	verify_futex_wait_bitset(DEFAULT_TIMEOUT_US, tcases[n].clk_id);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+};
diff --git a/testcases/kernel/syscalls/futex/futex_wait_bitset02.c b/testcases/kernel/syscalls/futex/futex_wait_bitset02.c
deleted file mode 100644
index 4d532fc07775..000000000000
--- a/testcases/kernel/syscalls/futex/futex_wait_bitset02.c
+++ /dev/null
@@ -1,18 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
- *
- * 1. Block on a bitset futex and wait for timeout, the difference between
- *    normal futex and bitset futex is that that the later have absolute timeout.
- * 2. Check that the futex waited for expected time.
- */
-
-#include <errno.h>
-
-#include "tst_test.h"
-#include "tst_timer.h"
-#include "futextest.h"
-
-#define USE_CLOCK CLOCK_REALTIME
-
-#include "futex_wait_bitset.h"
-- 
2.25.0.rc1.19.g042ed3e048af

