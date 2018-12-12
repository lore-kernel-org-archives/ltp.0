From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Wed, 12 Dec 2018 18:37:23 -0200
Subject: [LTP] [PATCH v3 6/6] timers/clock_settime: remove clock_settime
	tests
In-Reply-To: <20181212203723.18810-1-rafael.tinoco@linaro.org>
References: <20181211142750.GA27159@rei>
 <20181212203723.18810-1-rafael.tinoco@linaro.org>
Message-ID: <20181212203723.18810-6-rafael.tinoco@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes: 343

clock_settime01 creates a new test, using new API, based on existing and
older kernel/timers/clock_settime tests. It includes tests from files
clock_settime02 and clock_settime03.

This commit deletes timers/clock_settime/* tests.

Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 runtest/timers                                |   2 -
 .../kernel/timers/clock_settime/.gitignore    |   2 -
 .../kernel/timers/clock_settime/Makefile      |  27 ---
 .../timers/clock_settime/clock_settime02.c    | 128 -------------
 .../timers/clock_settime/clock_settime03.c    | 173 ------------------
 5 files changed, 332 deletions(-)
 delete mode 100644 testcases/kernel/timers/clock_settime/.gitignore
 delete mode 100644 testcases/kernel/timers/clock_settime/Makefile
 delete mode 100644 testcases/kernel/timers/clock_settime/clock_settime02.c
 delete mode 100644 testcases/kernel/timers/clock_settime/clock_settime03.c

diff --git a/runtest/timers b/runtest/timers
index a58ac57fc..618d2cb0c 100644
--- a/runtest/timers
+++ b/runtest/timers
@@ -1,8 +1,6 @@
 #DESCRIPTION:Posix Timer Tests
 clock_gettime02 clock_gettime02
 clock_gettime03 clock_gettime03
-clock_settime02 clock_settime02
-clock_settime03 clock_settime03
 timer_create02 timer_create02
 timer_create03 timer_create03
 timer_create04 timer_create04
diff --git a/testcases/kernel/timers/clock_settime/.gitignore b/testcases/kernel/timers/clock_settime/.gitignore
deleted file mode 100644
index 957c5ac26..000000000
--- a/testcases/kernel/timers/clock_settime/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-/clock_settime02
-/clock_settime03
diff --git a/testcases/kernel/timers/clock_settime/Makefile b/testcases/kernel/timers/clock_settime/Makefile
deleted file mode 100644
index 8de247075..000000000
--- a/testcases/kernel/timers/clock_settime/Makefile
+++ /dev/null
@@ -1,27 +0,0 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
-
-top_srcdir		?= ../../../..
-
-include $(top_srcdir)/include/mk/testcases.mk
-
-CPPFLAGS		+= -D_GNU_SOURCE -I$(abs_srcdir)/../include
-
-LDLIBS			+= -lpthread -lrt
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/timers/clock_settime/clock_settime02.c b/testcases/kernel/timers/clock_settime/clock_settime02.c
deleted file mode 100644
index 65721c1ae..000000000
--- a/testcases/kernel/timers/clock_settime/clock_settime02.c
+++ /dev/null
@@ -1,128 +0,0 @@
-/*
- * Copyright (c) Wipro Technologies Ltd, 2003.  All Rights Reserved.
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
-/**************************************************************************
- *
- *    TEST IDENTIFIER	: clock_settime02
- *
- *    EXECUTED BY	: root / superuser
- *
- *    TEST TITLE	: Basic test for clock_settime(2)
- *
- *    TEST CASE TOTAL	: 1
- *
- *    AUTHOR		: Aniruddha Marathe <aniruddha.marathe@wipro.com>
- *
- *    SIGNALS
- * 	Uses SIGUSR1 to pause before test if option set.
- * 	(See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *     This is a Phase I test for the clock_settime(2) system call.
- *     It is intended to provide a limited exposure of the system call.
- *
- * 	Setup:
- *	  Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *
- * 	Test:
- *	 Loop if the proper options are given.
- *	 Set the parameters of timespec struct
- *	 Execute system call
- *	 Check return code, if system call failed (return=-1)
- *		Log the errno and Issue a FAIL message.
- *	 Otherwise, Issue a PASS message.
- *
- * 	Cleanup:
- * 	  Print errno log and/or timing stats if options given
- *
- * USAGE:  <for command-line>
- * clock_settime02 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-p]
- * where:
- * 	-c n : Run n copies simultaneously.
- *	-e   : Turn on errno logging.
- *	-i n : Execute test n times.
- *	-I x : Execute test for x seconds.
- *	-p   : Pause for SIGUSR1 before starting
- *	-P x : Pause for x seconds between iterations.
- *	-t   : Turn on syscall timing.
- *
- *RESTRICTIONS:
- * None
- *****************************************************************************/
-
-#include <stdlib.h>
-#include <errno.h>
-#include <time.h>
-#include <signal.h>
-
-#include "test.h"
-#include "common_timers.h"
-
-static void setup(void);
-static void cleanup(void);
-
-char *TCID = "clock_settime02";
-int TST_TOTAL = 1;
-static struct timespec saved;
-
-int main(int ac, char **av)
-{
-	int lc;
-	struct timespec spec;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		spec.tv_sec = saved.tv_sec + 1;
-		spec.tv_nsec = 0;
-
-		TEST(ltp_syscall(__NR_clock_settime, CLOCK_REALTIME, &spec));
-		tst_resm((TEST_RETURN < 0 ? TFAIL | TTERRNO : TPASS),
-			 "clock_settime %s",
-			 (TEST_RETURN == 0 ? "passed" : "failed"));
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	tst_require_root();
-
-	/* Save the current time specifications */
-	if (ltp_syscall(__NR_clock_gettime, CLOCK_REALTIME, &saved) < 0)
-		tst_brkm(TBROK, NULL, "Could not save the current time");
-
-	TEST_PAUSE;
-}
-
-static void cleanup(void)
-{
-	/* Set the saved time */
-	if (clock_settime(CLOCK_REALTIME, &saved) < 0) {
-		tst_resm(TWARN, "FATAL COULD NOT RESET THE CLOCK");
-		tst_resm(TFAIL, "Error Setting Time, errno=%d", errno);
-	}
-}
diff --git a/testcases/kernel/timers/clock_settime/clock_settime03.c b/testcases/kernel/timers/clock_settime/clock_settime03.c
deleted file mode 100644
index 38b41d025..000000000
--- a/testcases/kernel/timers/clock_settime/clock_settime03.c
+++ /dev/null
@@ -1,173 +0,0 @@
-/*
- * Copyright (c) Wipro Technologies Ltd, 2003.  All Rights Reserved.
- * Copyright (c) 2011 Cyril Hrubis <chrubis@suse.cz>
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
-
-#include <errno.h>
-#include <time.h>
-#include <pwd.h>
-#include <unistd.h>
-
-#include "test.h"
-#include "safe_macros.h"
-#include "common_timers.h"
-
-static void setup(void);
-static void cleanup(void);
-static int setup_test(int option);
-
-clockid_t clocks[] = {
-	CLOCK_REALTIME,
-	CLOCK_MONOTONIC,
-	MAX_CLOCKS,
-	MAX_CLOCKS + 1,
-	CLOCK_REALTIME,
-	CLOCK_REALTIME,
-	CLOCK_REALTIME,
-	CLOCK_PROCESS_CPUTIME_ID,
-	CLOCK_THREAD_CPUTIME_ID
-};
-
-int testcases[] = {
-	EFAULT,			/* tp bad               */
-	EINVAL,			/* CLOCK_MONOTONIC      */
-	EINVAL,			/* MAX_CLOCKS           */
-	EINVAL,			/* MAX_CLOCKS + 1       */
-	EINVAL,			/* Invalid timespec     */
-	EINVAL,			/* NSEC_PER_SEC + 1     */
-	EPERM,			/* non-root user        */
-	EINVAL,			/* PROCESS_CPUTIME_ID	*/
-	EINVAL,			/* THREAD_CPUTIME_ID	*/
-};
-
-char *TCID = "clock_settime03";
-int TST_TOTAL = ARRAY_SIZE(testcases);
-
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
-static struct timespec spec, *temp, saved;
-
-int main(int ac, char **av)
-{
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
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			if (setup_test(i) < 0)
-				continue;
-
-			TEST(ltp_syscall(__NR_clock_settime, clocks[i], temp));
-
-			/* Change the UID back to root */
-			if (i == TST_TOTAL - 1) {
-				SAFE_SETEUID(cleanup, 0);
-			}
-
-			/* check return code */
-			if (TEST_RETURN == -1 && TEST_ERRNO == testcases[i]) {
-				tst_resm(TPASS | TTERRNO,
-					 "clock_settime(2) got expected "
-					 "failure.");
-			} else {
-				tst_resm(TFAIL | TTERRNO,
-					 "clock_settime(2) failed to produce "
-					 "expected error (return code = %ld)",
-					 TEST_RETURN);
-				/* Restore the clock to its previous state. */
-				if (TEST_RETURN == 0) {
-					if (ltp_syscall(__NR_clock_settime,
-						    CLOCK_REALTIME,
-						    &saved) < 0) {
-						tst_resm(TWARN | TERRNO,
-							 "FATAL: could not set "
-							 "the clock!");
-					}
-				}
-			}
-
-		}
-
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-static int setup_test(int option)
-{
-	/* valid timespec */
-	spec = saved;
-	temp = &spec;
-
-	/* error sceanrios */
-	switch (option) {
-	case 0:
-		/* Make tp argument bad pointer */
-		temp = (struct timespec *)-1;
-		break;
-	case 4:
-		/* Make the parameter of timespec invalid */
-		spec.tv_nsec = -1;
-		break;
-	case 5:
-		/* Make the parameter of timespec invalid */
-		spec.tv_nsec = NSEC_PER_SEC + 1;
-		break;
-	case 6:
-		/* change the User to non-root */
-		spec.tv_nsec = 0;
-		if ((ltpuser = getpwnam(nobody_uid)) == NULL) {
-			tst_resm(TWARN, "user \"nobody\" not present; "
-				 "skipping test");
-			return -1;
-		}
-		if (seteuid(ltpuser->pw_uid) == -1) {
-			tst_resm(TWARN | TERRNO,
-				 "seteuid failed to set the effective "
-				 "uid to %d (nobody)", ltpuser->pw_uid);
-			return -1;
-		}
-		break;
-	}
-	return 0;
-}
-
-static void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	tst_require_root();
-
-	if (ltp_syscall(__NR_clock_gettime, CLOCK_REALTIME, &saved) < 0)
-		tst_brkm(TBROK, NULL, "Clock gettime failed");
-
-	spec.tv_sec = 1;
-	spec.tv_nsec = 0;
-
-	TEST_PAUSE;
-}
-
-static void cleanup(void)
-{
-}
-- 
2.20.0.rc1

