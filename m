From: Christian Amann <camann@suse.com>
Date: Thu, 11 Jul 2019 11:18:19 +0200
Subject: [LTP] [PATCH v1] timers/timer_create0{2, 3,
 4}: Ported to new library
Message-ID: <20190711091819.32556-1-camann@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Merged timer_create0{2,3} into one test, cleaned up and ported the
tests to the new library. Also added several missing clocks and made
sure that optional clocks are really tested if they are available.

Signed-off-by: Christian Amann <camann@suse.com>
---

Notes:
    This is the first step in order to port all the timer tests to the new
    library. The common_timers.h currently defines a CLEANUP macro which is
    used by the tests that are still using the old library. The new tests
    will display an unused-function warning when compiled. This will be
    removed once the last timer test is ported over.

 m4/ltp-time.m4                                     |   2 +-
 runtest/timers                                     |   1 -
 testcases/kernel/timers/include/common_timers.h    |  38 +++-
 testcases/kernel/timers/include/timer_blacklist.h  |  40 ++++
 testcases/kernel/timers/timer_create/.gitignore    |   1 -
 .../kernel/timers/timer_create/timer_create02.c    | 232 +++++++--------------
 .../kernel/timers/timer_create/timer_create03.c    | 156 --------------
 .../kernel/timers/timer_create/timer_create04.c    | 226 ++++++--------------
 8 files changed, 217 insertions(+), 479 deletions(-)
 create mode 100644 testcases/kernel/timers/include/timer_blacklist.h
 delete mode 100644 testcases/kernel/timers/timer_create/timer_create03.c

diff --git a/m4/ltp-time.m4 b/m4/ltp-time.m4
index 9d2954778..c46f1e307 100644
--- a/m4/ltp-time.m4
+++ b/m4/ltp-time.m4
@@ -26,7 +26,7 @@ dnl
 dnl ----------------------------
 dnl
 AC_DEFUN([LTP_CHECK_TIME],[
-	AC_CHECK_DECLS([CLOCK_MONOTONIC_RAW, CLOCK_REALTIME_COARSE, CLOCK_MONOTONIC_COARSE],,,[
+	AC_CHECK_DECLS([CLOCK_MONOTONIC_RAW, CLOCK_REALTIME_COARSE, CLOCK_MONOTONIC_COARSE, CLOCK_BOOTTIME, CLOCK_REALTIME_ALARM, CLOCK_BOOTTIME_ALARM, CLOCK_TAI],,,[
 #ifndef _GNU_SOURCE
 #define _GNU_SOURCE
 #endif
diff --git a/runtest/timers b/runtest/timers
index 5f5ecb6ee..54467fa78 100644
--- a/runtest/timers
+++ b/runtest/timers
@@ -1,6 +1,5 @@
 #DESCRIPTION:Posix Timer Tests
 timer_create02 timer_create02
-timer_create03 timer_create03
 timer_create04 timer_create04
 timer_delete02 timer_delete02
 timer_delete03 timer_delete03
diff --git a/testcases/kernel/timers/include/common_timers.h b/testcases/kernel/timers/include/common_timers.h
index 313cd4120..59eb8391b 100644
--- a/testcases/kernel/timers/include/common_timers.h
+++ b/testcases/kernel/timers/include/common_timers.h
@@ -6,8 +6,8 @@
 
 #ifndef __COMMON_TIMERS_H__
 #define __COMMON_TIMERS_H__
-
 #define CLEANUP cleanup
+
 #include "config.h"
 #include "lapi/syscalls.h"
 
@@ -19,15 +19,27 @@ clock_t clock_list[] = {
 	CLOCK_MONOTONIC,
 	CLOCK_PROCESS_CPUTIME_ID,
 	CLOCK_THREAD_CPUTIME_ID,
-#if HAVE_CLOCK_MONOTONIC_RAW
+#if HAVE_DECL_CLOCK_MONOTONIC_RAW
 	CLOCK_MONOTONIC_RAW,
 #endif
-#if HAVE_CLOCK_REALTIME_COARSE
+#if HAVE_DECL_CLOCK_REALTIME_COARSE
 	CLOCK_REALTIME_COARSE,
 #endif
-#if HAVE_CLOCK_MONOTONIC_COARSE
+#if HAVE_DECL_CLOCK_MONOTONIC_COARSE
 	CLOCK_MONOTONIC_COARSE,
 #endif
+#if HAVE_DECL_CLOCK_BOOTTIME
+	CLOCK_BOOTTIME,
+#endif
+#if HAVE_DECL_CLOCK_REALTIME_ALARM
+	CLOCK_REALTIME_ALARM,
+#endif
+#if HAVE_DECL_CLOCK_BOOTTIME_ALARM
+	CLOCK_BOOTTIME_ALARM,
+#endif
+#if HAVE_DECL_CLOCK_TAI
+	CLOCK_TAI,
+#endif
 };
 /* CLOCKS_DEFINED is the number of clock sources defined for sure */
 #define CLOCKS_DEFINED (sizeof(clock_list) / sizeof(*clock_list))
@@ -45,14 +57,26 @@ const char *get_clock_str(const int clock_id)
 	CLOCK_TO_STR(CLOCK_MONOTONIC);
 	CLOCK_TO_STR(CLOCK_PROCESS_CPUTIME_ID);
 	CLOCK_TO_STR(CLOCK_THREAD_CPUTIME_ID);
-#if HAVE_CLOCK_MONOTONIC_RAW
+#if HAVE_DECL_CLOCK_MONOTONIC_RAW
 	CLOCK_TO_STR(CLOCK_MONOTONIC_RAW);
 #endif
-#if HAVE_CLOCK_REALTIME_COARSE
+#if HAVE_DECL_CLOCK_REALTIME_COARSE
 	CLOCK_TO_STR(CLOCK_REALTIME_COARSE);
 #endif
-#if HAVE_CLOCK_MONOTONIC_COARSE
+#if HAVE_DECL_CLOCK_MONOTONIC_COARSE
 	CLOCK_TO_STR(CLOCK_MONOTONIC_COARSE);
+#endif
+#if HAVE_DECL_CLOCK_BOOTTIME
+	CLOCK_TO_STR(CLOCK_BOOTTIME);
+#endif
+#if HAVE_DECL_CLOCK_REALTIME_ALARM
+	CLOCK_TO_STR(CLOCK_REALTIME_ALARM);
+#endif
+#if HAVE_DECL_CLOCK_BOOTTIME_ALARM
+	CLOCK_TO_STR(CLOCK_BOOTTIME_ALARM);
+#endif
+#if HAVE_DECL_CLOCK_TAI
+	CLOCK_TO_STR(CLOCK_TAI);
 #endif
 	default:
 		return "CLOCK_!?!?!?";
diff --git a/testcases/kernel/timers/include/timer_blacklist.h b/testcases/kernel/timers/include/timer_blacklist.h
new file mode 100644
index 000000000..37a50d2e6
--- /dev/null
+++ b/testcases/kernel/timers/include/timer_blacklist.h
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) SUSE LLC, 2019.  All Rights Reserved.
+ *
+ * Author:      Christian Amann <camann@suse.com>
+ */
+/*
+ * Provides support to skip (possibly) unsupported clocks for testing
+ */
+
+#ifndef TIMER_BLACKLIST_H
+#define TIMER_BLACKLIST_H
+
+#define BLACKLIST_SIZE ARRAY_SIZE(blacklist_clocks)
+
+static kernel_timer_t blacklist_clocks[] = {
+#if HAVE_DECL_CLOCK_MONOTONIC_RAW
+	CLOCK_MONOTONIC_RAW,
+#endif
+#if HAVE_DECL_CLOCK_MONOTONIC_COARSE
+	CLOCK_MONOTONIC_COARSE,
+#endif
+#if HAVE_DECL_CLOCK_REALTIME_COARSE
+	CLOCK_REALTIME_COARSE,
+#endif
+};
+
+static int skip_clock(kernel_timer_t clock)
+{
+	unsigned int i;
+
+	for (i = 0; i < BLACKLIST_SIZE; ++i) {
+		if (clock == blacklist_clocks[i])
+			return 1;
+	}
+	return 0;
+}
+
+
+#endif /* TIMER_BLACKLIST_H */
diff --git a/testcases/kernel/timers/timer_create/.gitignore b/testcases/kernel/timers/timer_create/.gitignore
index f8bec56e9..a04bba838 100644
--- a/testcases/kernel/timers/timer_create/.gitignore
+++ b/testcases/kernel/timers/timer_create/.gitignore
@@ -1,3 +1,2 @@
 /timer_create02
-/timer_create03
 /timer_create04
diff --git a/testcases/kernel/timers/timer_create/timer_create02.c b/testcases/kernel/timers/timer_create/timer_create02.c
index 112740052..bae41f595 100644
--- a/testcases/kernel/timers/timer_create/timer_create02.c
+++ b/testcases/kernel/timers/timer_create/timer_create02.c
@@ -1,177 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) Wipro Technologies Ltd, 2003.  All Rights Reserved.
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
+ * Author:	Aniruddha Marathe <aniruddha.marathe@wipro.com>
  *
+ * Ported to new library:
+ * 07/2019	Christian Amann <camann@suse.com>
  */
-/**************************************************************************
- *
- *    TEST IDENTIFIER	: timer_create02
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for timer_create(2)
- *
- *    TEST CASE TOTAL	: 3
- *
- *    AUTHOR		: Aniruddha Marathe <aniruddha.marathe@wipro.com>
- *
- *    SIGNALS
- * 	Uses SIGUSR1 to pause before test if option set.
- * 	(See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *     This is a Phase I test for the timer_create(2) system call.
- *     It is intended to provide a limited exposure of the system call.
- *
- * 	Setup:
- *	  Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *
- * 	Test:
- *	 Loop if the proper options are given.
- *	 Execute system call with different notification types for
- *	 clock ID CLOCK_REALTIME
- *	 Check return code, if system call failed (return=-1)
- *		Log the errno and Issue a FAIL message.
- *	 Otherwise, Issue a PASS message.
- *
- * 	Cleanup:
- * 	  Print errno log and/or timing stats if options given
+/*
  *
- * USAGE:  <for command-line>
- * timer_create02 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-p]
- * where:
- * 	-c n : Run n copies simultaneously.
- *	-e   : Turn on errno logging.
- *	-i n : Execute test n times.
- *	-I x : Execute test for x seconds.
- *	-p   : Pause for SIGUSR1 before starting
- *	-P x : Pause for x seconds between iterations.
- *	-t   : Turn on syscall timing.
+ * Basic test for timer_create(2):
  *
- *RESTRICTIONS:
- * None
- *****************************************************************************/
+ *	Creates a timer for each available clock using the
+ *	following notification types:
+ *	1) SIGEV_NONE
+ *	2) SIGEV_SIGNAL
+ *	3) SIGEV_THREAD
+ *	4) SIGEV_THREAD_ID
+ *	5) NULL
+ */
 
-#include <stdlib.h>
-#include <errno.h>
-#include <time.h>
 #include <signal.h>
-
-#include "test.h"
+#include <time.h>
+#include "tst_test.h"
+#include "tst_safe_macros.h"
 #include "common_timers.h"
-
-void setup(void);
-void setup_test(int option);
-
-char *TCID = "timer_create02";	/* Test program identifier.    */
-int TST_TOTAL = 3;		/* Total number of test cases. */
-static struct sigevent evp, *evp_ptr;
-
-int main(int ac, char **av)
+#include "timer_blacklist.h"
+
+static struct sigevent evp;
+
+static struct notif_type {
+	int		sigev_signo;
+	int		sigev_notify;
+	char		*message;
+	struct sigevent *sevp;
+} types[] = {
+	{SIGALRM, SIGEV_NONE, "SIGEV_NONE", &evp},
+	{SIGALRM, SIGEV_SIGNAL, "SIGEV_SIGNAL", &evp},
+	{SIGALRM, SIGEV_THREAD, "SIGEV_THREAD", &evp},
+	{SIGALRM, SIGEV_THREAD_ID, "SIGEV_THREAD_ID", &evp},
+	{0, 0, "NULL", NULL},
+};
+
+static void run(unsigned int n)
 {
-	int lc, i, j;
-	kernel_timer_t created_timer_id;	/* holds the returned timer_id */
-	char *message[3] = {
-		"SIGEV_SIGNAL",
-		"NULL",
-		"SIGEV_NONE"
-	};
-	const char *mrstr = "MONOTONIC_RAW";
-
-	tst_parse_opts(ac, av, NULL, NULL);
+	unsigned int i, errors;
+	struct notif_type *nt = &types[n];
+	kernel_timer_t created_timer_id;
 
-	setup();
+	tst_res(TINFO, "Testing notification type: %s", nt->message);
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	memset(&evp, 0, sizeof(evp));
 
-		tst_count = 0;
+	errors = 0;
+	for (i = 0; i < CLOCKS_DEFINED; ++i) {
+		clock_t clock = clock_list[i];
 
-		for (i = 0; i < TST_TOTAL; i++) {
+		if (skip_clock(clock))
+			continue;
 
-			setup_test(i);
+		evp.sigev_value  = (union sigval) 0;
+		evp.sigev_signo  = nt->sigev_signo;
+		evp.sigev_notify = nt->sigev_notify;
 
-			for (j = 0; j < CLOCKS_DEFINED; ++j) {
+		if (strstr(get_clock_str(clock), "CPUTIME_ID")) {
+			/* (PROCESS_CPUTIME_ID &
+			 *  THREAD_CPUTIME_ID)
+			 * is not supported on kernel versions
+			 * lower than 2.6.12
+			 */
+			if ((tst_kvercmp(2, 6, 12)) < 0)
+				continue;
+		}
+		if (!strcmp(get_clock_str(clock), "MONOTONIC_RAW"))
+			continue;
 
-				if (strstr(get_clock_str(clock_list[j]),
-					   "CPUTIME_ID")) {
-					/* (PROCESS_CPUTIME_ID &
-					 *  THREAD_CPUTIME_ID)
-					 * is not supported on kernel versions
-					 * lower than 2.6.12
-					 */
-					if ((tst_kvercmp(2, 6, 12)) < 0) {
-						continue;
-					}
-				}
-				if (strstr(get_clock_str(clock_list[j]), mrstr))
-					continue;
+		if (!strcmp(nt->message, "SIGEV_THREAD_ID"))
+			evp._sigev_un._tid = getpid();
 
-				TEST(ltp_syscall(__NR_timer_create,
-					clock_list[j], evp_ptr,
-					&created_timer_id));
+		TEST(tst_syscall(__NR_timer_create,
+			clock, nt->sevp,
+			&created_timer_id));
 
-				tst_resm((TEST_RETURN == 0 ?
-					  TPASS :
-					  TFAIL | TTERRNO),
-					 "%s %s with notification type = %s",
-					 get_clock_str(clock_list[j]),
-					 (TEST_RETURN == 0 ?
-					  "passed" : "failed"), message[i]);
-			}
+		if (TST_RET != 0) {
+			tst_res(TFAIL | TTERRNO,
+				"Clock %s failed", get_clock_str(clock));
+			errors++;
 		}
-	}
 
-	cleanup();
-	tst_exit();
-}
-
-/* setup_test() - sets up individual test */
-void setup_test(int option)
-{
-	switch (option) {
-	case 0:
-		evp.sigev_value = (union sigval) 0;
-		evp.sigev_signo = SIGALRM;
-		evp.sigev_notify = SIGEV_SIGNAL;
-		evp_ptr = &evp;
-		break;
-	case 1:
-		evp_ptr = NULL;
-		break;
-	case 2:
-		evp.sigev_value = (union sigval) 0;
-		evp.sigev_signo = SIGALRM;	/* any will do */
-		evp.sigev_notify = SIGEV_NONE;
-		evp_ptr = &evp;
-		break;
+		TEST(tst_syscall(__NR_timer_delete, created_timer_id));
+		if (TST_RET != 0) {
+			tst_res(TINFO, "Failed to delete timer %s",
+				get_clock_str(clock));
+		}
 	}
+	if (!errors)
+		tst_res(TPASS,  "All clocks passed!");
 }
 
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
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(types),
+	.needs_root = 1,
+};
diff --git a/testcases/kernel/timers/timer_create/timer_create03.c b/testcases/kernel/timers/timer_create/timer_create03.c
deleted file mode 100644
index 8b01bf72d..000000000
--- a/testcases/kernel/timers/timer_create/timer_create03.c
+++ /dev/null
@@ -1,156 +0,0 @@
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
- *    TEST IDENTIFIER	: timer_create03
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for timer_create(2)
- *
- *    TEST CASE TOTAL	: 3
- *
- *    AUTHOR		: Aniruddha Marathe <aniruddha.marathe@wipro.com>
- *
- *    SIGNALS
- * 	Uses SIGUSR1 to pause before test if option set.
- * 	(See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *     This is a Phase I test for the timer_create(2) system call.
- *     It is intended to provide a limited exposure of the system call.
- *
- * 	Setup:
- *	  Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *
- * 	Test:
- *	 Loop if the proper options are given.
- *	 Execute system call with different notification types for
- *	 clock ID CLOCK_MONOTONIC
- *	 Check return code, if system call failed (return=-1)
- *		Log the errno and Issue a FAIL message.
- *	 Otherwise, Issue a PASS message.
- *
- * 	Cleanup:
- * 	  Print errno log and/or timing stats if options given
- *
- * USAGE:  <for command-line>
- * timer_create03 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-p]
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
-void setup_test(int option);
-
-char *TCID = "timer_create03";	/* Test program identifier. */
-int TST_TOTAL = 3;		/* Total number of test cases. */
-static struct sigevent evp, *evp_ptr;
-
-/*
- * cleanup() - Performs one time cleanup for this test at
- * completion or premature exit
- */
-void cleanup(void)
-{
-}
-
-int main(int ac, char **av)
-{
-	int lc, i;
-	kernel_timer_t created_timer_id;	/* holds the returned timer_id */
-	char *message[] = {
-		"SIGEV_SIGNAL",
-		"NULL",
-		"SIGEV_NONE"
-	};
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
-			setup_test(i);
-			TEST(ltp_syscall(__NR_timer_create, CLOCK_MONOTONIC,
-				     evp_ptr, &created_timer_id));
-
-			tst_resm((TEST_RETURN == 0 ? TPASS : TFAIL | TTERRNO),
-				 "%s with notification type = %s",
-				 (TEST_RETURN == 0 ? "passed" : "failed"),
-				 message[i]);
-
-		}
-
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-/* setup_test() - sets up individual test */
-void setup_test(int option)
-{
-	switch (option) {
-	case 0:
-		evp.sigev_value = (union sigval) 0;
-		evp.sigev_signo = SIGALRM;
-		evp.sigev_notify = SIGEV_SIGNAL;
-		evp_ptr = &evp;
-		break;
-	case 1:
-		evp_ptr = NULL;
-		break;
-	case 2:
-		evp.sigev_value = (union sigval) 0;
-		evp.sigev_signo = SIGALRM;	/* any will do */
-		evp.sigev_notify = SIGEV_NONE;
-		evp_ptr = &evp;
-		break;
-	}
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
diff --git a/testcases/kernel/timers/timer_create/timer_create04.c b/testcases/kernel/timers/timer_create/timer_create04.c
index 11cfc21dc..523faac51 100644
--- a/testcases/kernel/timers/timer_create/timer_create04.c
+++ b/testcases/kernel/timers/timer_create/timer_create04.c
@@ -1,187 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) Wipro Technologies Ltd, 2003.  All Rights Reserved.
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
+ * Author: Aniruddha Marathe <aniruddha.marathe@wipro.com>
  *
+ * Ported to new library:
+ * 07/2019      Christian Amann <camann@suse.com>
  */
-/**************************************************************************
- *
- *    TEST IDENTIFIER	: timer_create04
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Test checking for basic error conditions for
- *    			  timer_create(2)
- *
- *    TEST CASE TOTAL	: 8
- *
- *    AUTHOR		: Aniruddha Marathe <aniruddha.marathe@wipro.com>
- *
- *    SIGNALS
- * 	Uses SIGUSR1 to pause before test if option set.
- * 	(See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *    	This test case check whether timer_create(2) returns appropriate error
- *    	value for invalid parameter
- *
- * 	Setup:
- *	 Setup signal handling.
- *	 Pause for SIGUSR1 if option specified.
- *
- * 	Test:
- *	 Loop if the proper options are given.
- *	 For case 7 set event parameter as bad pointer
- *	 for case 8 set returned timer ID parameter as bad pointer
- *	 Execute system call with invalid parameter
- *	 Check return code, if system call fails with errno == expected errno
- * 	 	Issue syscall passed with expected errno
- *	 Otherwise, Issue syscall failed to produce expected errno
- *
- * 	Cleanup:
- * 	 Print errno log and/or timing stats if options given
- *
- * USAGE:  <for command-line>
- * timer_create04 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-p]
- * where:
- * 	-c n : run n copies simultaneously
- *	-e   : Turn on errno logging.
- *	-i n : Execute test n times.
- *	-I x : Execute test for x seconds.
- *	-p   : Pause for SIGUSR1 before starting
- *	-P x : Pause for x seconds between iterations.
- *	-t   : Turn on syscall timing.
+/*
+ * Basic error handling test for timer_create(2):
  *
- * RESTRICTIONS:
- * None
- *****************************************************************************/
+ *	Passes invalid parameters when calling the syscall and checks
+ *	if it fails with EFAULT:
+ *	1) Pass an invalid pointer for the sigevent structure parameter
+ *	2) Pass an invalid pointer for the timer ID parameter
+ */
 
 #include <stdlib.h>
 #include <errno.h>
 #include <string.h>
 #include <time.h>
 #include <signal.h>
-
-#include "test.h"
+#include "tst_test.h"
 #include "common_timers.h"
-
-void setup(void);
-
-int testcase[6] = {
-	EINVAL,			/* MAX_CLOCKS     */
-	EINVAL,			/* MAX_CLOCKS + 1 */
-	EFAULT,			/* bad sigevent   */
-	EFAULT			/* bad timer_id   */
+#include "timer_blacklist.h"
+
+static struct sigevent sig_ev;
+static kernel_timer_t  timer_id;
+
+static struct testcase {
+	struct sigevent	*ev_ptr;
+	kernel_timer_t	*kt_ptr;
+	int		error;
+} tcases[] = {
+	{NULL, &timer_id, EFAULT},
+	{&sig_ev, NULL, EFAULT},
 };
 
-char *TCID = "timer_create04";	/* Test program identifier.    */
-int TST_TOTAL = ARRAY_SIZE(testcase);
-
-/*
- * cleanup() - Performs one time cleanup for this test at
- * completion or premature exit
- */
-void cleanup(void)
+static int have_recent_kernel(void)
 {
-
+	return tst_kvercmp(2, 6, 12) >= 0;
 }
 
-int main(int ac, char **av)
+static void run(unsigned int n)
 {
-	int lc, i;
-	kernel_timer_t timer_id, *temp_id;	/* stores the returned timer_id */
-	struct sigevent *temp_ev;	/* used for bad address test case */
-
-	clockid_t clocks[6] = {
-		MAX_CLOCKS,
-		MAX_CLOCKS + 1,
-		CLOCK_REALTIME,
-		CLOCK_MONOTONIC,
-		CLOCK_PROCESS_CPUTIME_ID,
-		CLOCK_THREAD_CPUTIME_ID
-	};
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	TST_TOTAL = sizeof(testcase) / sizeof(testcase[0]);
-
-	/* PROCESS_CPUTIME_ID & THREAD_CPUTIME_ID are not supported on
-	 * kernel versions lower than 2.6.12
-	 */
-	if (tst_kvercmp(2, 6, 12) < 0) {
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
-
-			temp_ev = NULL;
-			temp_id = &timer_id;
-
-			switch (i) {
-			case 2:	/* make the timer_id bad address */
-				temp_id = (kernel_timer_t *) - 1;
-				break;
-			case 3:
-				/* make the event bad address */
-				temp_ev = (struct sigevent *)-1;
-				break;
-			case 4:
-				/* Produce an invalid timer_id address. */
-				if (tst_kvercmp(2, 6, 12) >= 0)
-					temp_id = (kernel_timer_t *) - 1;
-				break;
-			case 5:
-				/* Produce an invalid event address. */
-				if (tst_kvercmp(2, 6, 12) >= 0)
-					temp_ev = (struct sigevent *)-1;
-			}
-
-			TEST(ltp_syscall(__NR_timer_create, clocks[i], temp_ev,
-				     temp_id));
-
-			/* check return code */
-			if (TEST_RETURN == -1 && TEST_ERRNO == testcase[i]) {
-				tst_resm(TPASS | TTERRNO, "failed as expected");
-			} else {
-				tst_resm(TFAIL | TTERRNO,
-					 "didn't fail as expected [expected "
-					 "errno = %d (%s)]",
-					 testcase[i], strerror(testcase[i]));
-			}	/* end of else */
-
+	unsigned int i, errors = 0;
+	struct testcase *tc = &tcases[n];
+
+	for (i = 0; i < CLOCKS_DEFINED; ++i) {
+		clock_t clock = clock_list[i];
+
+		if (skip_clock(clock))
+			continue;
+
+		/* PROCESS_CPUTIME_ID & THREAD_CPUTIME_ID are not supported on
+		 * kernel versions lower than 2.6.12
+		 */
+		if (strstr(get_clock_str(clock), "CPUTIME_ID") &&
+		    !have_recent_kernel())
+			tc->error = EINVAL;
+
+		TEST(tst_syscall(__NR_timer_create, clock_list[n], tc->ev_ptr,
+			     tc->kt_ptr));
+
+		if (TST_RET != -1 || TST_ERR != tc->error) {
+			tst_res(TFAIL | TTERRNO,
+				 "%s didn't fail as expected (%s) - Got",
+				 get_clock_str(clock), tst_strerrno(tc->error));
+			errors++;
 		}
-
 	}
-
-	cleanup();
-	tst_exit();
+	if (!errors)
+		tst_res(TPASS, "All clocks failed as expected");
 }
 
-/* setup() - performs all ONE TIME setup for this test */
-void setup(void)
+static void setup(void)
 {
+	tcases[0].ev_ptr = tst_get_bad_addr(NULL);
+	tcases[1].kt_ptr = tst_get_bad_addr(NULL);
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	sig_ev.sigev_value  = (union sigval) 0;
+	sig_ev.sigev_signo  = SIGALRM;
+	sig_ev.sigev_notify = SIGEV_NONE;
 }
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+};
-- 
2.16.4

