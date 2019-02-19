From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Tue, 19 Feb 2019 19:03:55 -0300
Subject: [LTP] [PATCH v3 2/2] timers/clock_gettime: remove clock_gettime
	tests
In-Reply-To: <20190219220355.32593-1-rafael.tinoco@linaro.org>
References: <20190207123137.GA9277@rei>
 <20190219220355.32593-1-rafael.tinoco@linaro.org>
Message-ID: <20190219220355.32593-2-rafael.tinoco@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

clock_gettime{01,02} syscall tests were created, using the new API,
based on existing and older kernel/timers/clock_gettime{02,03} tests.

This commit deletes older timers/clock_gettime/* tests.

Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 runtest/timers                                |   2 -
 .../kernel/timers/clock_gettime/.gitignore    |   2 -
 .../kernel/timers/clock_gettime/Makefile      |  27 ---
 .../timers/clock_gettime/clock_gettime02.c    | 120 ------------
 .../timers/clock_gettime/clock_gettime03.c    | 173 ------------------
 5 files changed, 324 deletions(-)
 delete mode 100644 testcases/kernel/timers/clock_gettime/.gitignore
 delete mode 100644 testcases/kernel/timers/clock_gettime/Makefile
 delete mode 100644 testcases/kernel/timers/clock_gettime/clock_gettime02.c
 delete mode 100644 testcases/kernel/timers/clock_gettime/clock_gettime03.c

diff --git a/runtest/timers b/runtest/timers
index 618d2cb0c..5f5ecb6ee 100644
--- a/runtest/timers
+++ b/runtest/timers
@@ -1,6 +1,4 @@
 #DESCRIPTION:Posix Timer Tests
-clock_gettime02 clock_gettime02
-clock_gettime03 clock_gettime03
 timer_create02 timer_create02
 timer_create03 timer_create03
 timer_create04 timer_create04
diff --git a/testcases/kernel/timers/clock_gettime/.gitignore b/testcases/kernel/timers/clock_gettime/.gitignore
deleted file mode 100644
index 004e74214..000000000
--- a/testcases/kernel/timers/clock_gettime/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-/clock_gettime02
-/clock_gettime03
diff --git a/testcases/kernel/timers/clock_gettime/Makefile b/testcases/kernel/timers/clock_gettime/Makefile
deleted file mode 100644
index 8de247075..000000000
--- a/testcases/kernel/timers/clock_gettime/Makefile
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
diff --git a/testcases/kernel/timers/clock_gettime/clock_gettime02.c b/testcases/kernel/timers/clock_gettime/clock_gettime02.c
deleted file mode 100644
index e68a2070c..000000000
--- a/testcases/kernel/timers/clock_gettime/clock_gettime02.c
+++ /dev/null
@@ -1,120 +0,0 @@
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
- *    TEST IDENTIFIER	: clock_gettime02
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for clock_gettime(2)
- *
- *    TEST CASE TOTAL	: 2
- *
- *    AUTHOR		: Aniruddha Marathe <aniruddha.marathe@wipro.com>
- *
- *    SIGNALS
- * 	Uses SIGUSR1 to pause before test if option set.
- * 	(See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *     This is a Phase I test for the clock_gettime(2) system call.
- *     It is intended to provide a limited exposure of the system call.
- *
- * 	Setup:
- *	  Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *
- * 	Test:
- *	 Loop if the proper options are given.
- *	 Execute system call for each defined clock value
- *	 Check return code, if system call failed (return=-1)
- *		Log the errno and Issue a FAIL message.
- *	 Otherwise, Issue a PASS message.
- *
- * 	Cleanup:
- * 	  Print errno log and/or timing stats if options given
- *
- * USAGE:  <for command-line>
- * clock_gettime02 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-p]
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
-void setup(void);
-static clockid_t clocks[2] = { CLOCK_REALTIME, CLOCK_MONOTONIC };
-
-char *TCID = "clock_gettime02";
-int TST_TOTAL = ARRAY_SIZE(clocks);
-
-int main(int ac, char **av)
-{
-	int lc, i;
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
-		for (i = 0; i < TST_TOTAL; i++) {
-			TEST(ltp_syscall(__NR_clock_gettime, clocks[i], &spec));
-			tst_resm((TEST_RETURN < 0 ? TFAIL | TTERRNO : TPASS),
-				 "%s",
-				 (TEST_RETURN == 0 ? "passed" : "failed"));
-		}
-	}
-
-	CLEANUP();
-	tst_exit();
-}
-
-/* setup() - performs all ONE TIME setup for this test */
-void setup(void)
-{
-
-	tst_sig(NOFORK, DEF_HANDLER, CLEANUP);
-
-	TEST_PAUSE;
-}
-
-/*
- * CLEANUP() - Performs one time CLEANUP for this test at
- * completion or premature exit
- */
-void cleanup(void)
-{
-}
diff --git a/testcases/kernel/timers/clock_gettime/clock_gettime03.c b/testcases/kernel/timers/clock_gettime/clock_gettime03.c
deleted file mode 100644
index 2194d104a..000000000
--- a/testcases/kernel/timers/clock_gettime/clock_gettime03.c
+++ /dev/null
@@ -1,173 +0,0 @@
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
- *    TEST IDENTIFIER	: clock_gettime03
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Test checking for basic error conditions for
- *    			  clock_gettime(2)
- *
- *    TEST CASE TOTAL	: 7
- *
- *    AUTHOR		: Aniruddha Marathe <aniruddha.marathe@wipro.com>
- *
- *    SIGNALS
- * 	Uses SIGUSR1 to pause before test if option set.
- * 	(See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *    	This test case check whether clock_gettime(2) returns appropriate error
- *    	value for invalid parameter
- *
- * 	Setup:
- *	 Setup signal handling.
- *	 Pause for SIGUSR1 if option specified.
- *
- * 	Test:
- *	 Loop if the proper options are given.
- *	 If it is the first test case
- *	 	make temp a bad pointer
- *	 Otherwise pass defined struct timespec variable to temp
- *	 Execute system call with invalid parameter
- *	 Check return code, if system call fails with errno == expected errno
- * 	 	Issue syscall passed with expected errno
- *	 Otherwise, Issue syscall failed to produce expected errno
- *
- * 	Cleanup:
- * 	 Print errno log and/or timing stats if options given
- *
- * USAGE:  <for command-line>
- * clock_gettime03 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-p]
- * where:
- * 	-c n : run n copies simultaneously
- *	-e   : Turn on errno logging.
- *	-i n : Execute test n times.
- *	-I x : Execute test for x seconds.
- *	-p   : Pause for SIGUSR1 before starting
- *	-P x : Pause for x seconds between iterations.
- *	-t   : Turn on syscall timing.
- *
- * RESTRICTIONS:
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
-void setup(void);
-
-int testcase[6] = {
-	EFAULT,			/* Bad timespec   */
-	EFAULT,			/* Bad timespec   */
-	EINVAL,			/* MAX_CLOCKS     */
-	EINVAL			/* MAX_CLOCKS + 1 */
-};
-
-char *TCID = "clock_gettime03";	/* Test program identifier.    */
-int TST_TOTAL = ARRAY_SIZE(testcase);
-
-int main(int ac, char **av)
-{
-	int i, lc;
-	struct timespec spec, *temp;
-
-	clockid_t clocks[] = {
-		CLOCK_REALTIME,
-		CLOCK_MONOTONIC,
-		MAX_CLOCKS,
-		MAX_CLOCKS + 1,
-		CLOCK_PROCESS_CPUTIME_ID,
-		CLOCK_THREAD_CPUTIME_ID
-	};
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	/*
-	 * PROCESS_CPUTIME_ID & THREAD_CPUTIME_ID are not supported on
-	 * kernel versions lower than 2.6.12
-	 */
-	if ((tst_kvercmp(2, 6, 12)) < 0) {
-		testcase[4] = EINVAL;
-		testcase[5] = EINVAL;
-	} else {
-		testcase[4] = EFAULT;
-		testcase[5] = EFAULT;
-	}
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-			temp = &spec;
-
-			if (i == 0) {
-				temp = (struct timespec *)-1;
-			} else if (i == 1) {
-				temp = NULL;
-			} else if ((i >= 4) && (tst_kvercmp(2, 6, 12) >= 0)) {
-				temp = NULL;
-			}
-
-			TEST(ltp_syscall(__NR_clock_gettime, clocks[i], temp));
-
-			/* check return code */
-			if (TEST_RETURN == -1 && TEST_ERRNO == testcase[i]) {
-				tst_resm(TPASS | TTERRNO,
-					 "got expected failure");
-			} else {
-				tst_resm(TFAIL | TTERRNO,
-					 "failed to produce expected error "
-					 "[expected errno = %d (%s), "
-					 "TEST_RETURN = %ld]",
-					 testcase[i], strerror(testcase[i]),
-					 TEST_RETURN);
-			}	/* end of else */
-
-		}		/*End of TEST CASE LOOPING */
-
-	}			/*End for TEST_LOOPING */
-
-	cleanup();
-	tst_exit();
-}
-
-/* setup() - performs all ONE TIME setup for this test */
-void setup(void)
-{
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-}
-
-/*
- * cleanup() - Performs one time cleanup for this test at
- * completion or premature exit
- */
-void cleanup(void)
-{
-}
-- 
2.20.1

