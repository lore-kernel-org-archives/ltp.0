From: Christian Amann <camann@suse.com>
Date: Tue, 23 Jul 2019 09:08:16 +0200
Subject: [LTP] [PATCH v1 2/3] timers/timer_settime0{2,
 3}: Ported to new library
In-Reply-To: <20190723070817.637-1-camann@suse.com>
References: <20190723070817.637-1-camann@suse.com>
Message-ID: <20190723070817.637-2-camann@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cleaned up and ported both timer_settime(2) tests to new library.

Signed-off-by: Christian Amann <camann@suse.com>
---
 .../kernel/timers/timer_settime/timer_settime02.c  | 318 ++++++++-------------
 .../kernel/timers/timer_settime/timer_settime03.c  | 314 ++++++++------------
 2 files changed, 249 insertions(+), 383 deletions(-)
 rewrite testcases/kernel/timers/timer_settime/timer_settime02.c (92%)
 rewrite testcases/kernel/timers/timer_settime/timer_settime03.c (95%)

diff --git a/testcases/kernel/timers/timer_settime/timer_settime02.c b/testcases/kernel/timers/timer_settime/timer_settime02.c
dissimilarity index 92%
index cfeb7b3d3..36d9a745f 100644
--- a/testcases/kernel/timers/timer_settime/timer_settime02.c
+++ b/testcases/kernel/timers/timer_settime/timer_settime02.c
@@ -1,193 +1,125 @@
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
- *    TEST IDENTIFIER	: timer_settime02
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for timer_settime(2)
- *
- *    TEST CASE TOTAL	: 4
- *
- *    AUTHOR		: Aniruddha Marathe <aniruddha.marathe@wipro.com>
- *
- *    SIGNALS
- * 	Uses SIGUSR1 to pause before test if option set.
- * 	(See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *     This is a Phase I test for the timer_settime(2) system call.
- *     It is intended to provide a limited exposure of the system call.
- *
- * 	Setup:
- *	  Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *
- * 	Test:
- *	 Loop if the proper options are given.
- *	 setup individual test
- *	 Execute system call
- *	 Check return code, if system call failed (return=-1)
- *		Log the errno and Issue a FAIL message.
- *	 Otherwise, Issue a PASS message.
- *
- * 	Cleanup:
- * 	  Print errno log and/or timing stats if options given
- *
- * USAGE:  <for command-line>
- * timer_settime02 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-p]
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
-static int setup_test(int option);
-
-char *TCID = "timer_settime02";	/* Test program identifier.    */
-int TST_TOTAL = 4;		/* Total number of test cases. */
-
-static struct itimerspec new_set, old_set, *old_temp;
-static kernel_timer_t timer;
-static int flag;
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
-			/* Set up individual test */
-			if (setup_test(i) == 0) {
-				TEST(ltp_syscall(__NR_timer_settime, timer,
-					flag, &new_set, old_temp));
-				tst_resm((TEST_RETURN == 0 ?
-					  TPASS :
-					  TFAIL | TTERRNO),
-					 "%s",
-					 (TEST_RETURN ==
-					  0 ? "passed" : "failed")
-				    );
-			}
-
-		}
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-/* This function does set up for individual tests */
-static int setup_test(int option)
-{
-	struct timespec timenow;	/* Used to obtain current time */
-	int rc = 0;
-
-	switch (option) {
-	case 0:
-		/* This is general initialization.
-		 * make old_setting NULL
-		 * make flags equal to zero
-		 * use one-shot timer
-		 */
-		old_temp = NULL;
-		new_set.it_interval.tv_sec = 0;
-		new_set.it_interval.tv_nsec = 0;
-		new_set.it_value.tv_sec = 5;
-		new_set.it_value.tv_nsec = 0;
-		flag = 0;
-		break;
-	case 1:
-		/* get the old_setting in old_set
-		 * This test case also takes care
-		 * of situation where the timerid is
-		 * already armed
-		 */
-		old_temp = &old_set;
-		break;
-	case 2:
-		/* Use the periodic timer */
-		new_set.it_interval.tv_sec = 5;
-		new_set.it_value.tv_sec = 0;
-		break;
-	case 3:
-		/* Use TIMER_ABSTIME flag for setting
-		 * absolute time for timer
-		 */
-		flag = TIMER_ABSTIME;
-		/*
-		 * Let's not use the linux_syscall_number syscall(2)
-		 * wrapper here because our primary test focus is
-		 * timer_create, not clock_gettime. That's covered in
-		 * those respective tests.
-		 */
-		if (clock_gettime(CLOCK_REALTIME, &timenow) < 0) {
-			tst_resm(TWARN | TERRNO,
-				 "clock_gettime failed; skipping the test");
-			rc = -1;
-		} else {
-			new_set.it_value.tv_sec = timenow.tv_sec + 25;
-		}
-		break;
-	}
-	return rc;
-}
-
-/* setup() - performs all ONE TIME setup for this test */
-void setup(void)
-{
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	if (ltp_syscall(__NR_timer_create, CLOCK_REALTIME, NULL, &timer) < 0)
-		tst_brkm(TBROK, NULL, "timer_create failed");
-}
-
-/*
- * cleanup() - Performs one time cleanup for this test at
- * completion or premature exit
- */
-void cleanup(void)
-{
-}
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Wipro Technologies Ltd, 2003.  All Rights Reserved.
+ *
+ * Author:	Aniruddha Marathe <aniruddha.marathe@wipro.com>
+ *
+ * Ported to new library:
+ * 07/2019      Christian Amann <camann@suse.com>
+ */
+/*
+ * This tests the timer_settime(2) syscall under various conditions:
+ *
+ * 1) General initialization: No old_value, no flags, 5-second-timer
+ * 2) Setting a pointer to a itimerspec struct as old_set parameter
+ * 3) Using a periodic timer
+ * 4) Using absolute time
+ *
+ * All of these tests are supposed to be successful.
+ */
+
+#include <stdlib.h>
+#include <errno.h>
+#include <time.h>
+#include <signal.h>
+#include "tst_test.h"
+#include "common_timers.h"
+
+static struct timespec timenow;
+static struct itimerspec new_set, old_set;
+static kernel_timer_t timer;
+
+static struct testcase {
+	struct itimerspec	*old_ptr;
+	int			it_value_tv_sec;
+	int			it_internal_tv_sec;
+	int			check_clock_gettime;
+	int			flag;
+	char			*description;
+} tcases[] = {
+	{NULL, 5, 0, 0, 0, "general initialization"},
+	{&old_set, 5, 0, 0, 0, "setting old_value"},
+	{&old_set, 0, 5, 0, 0, "using periodic timer"},
+	{&old_set, 5, 0, 1, TIMER_ABSTIME, "using absolute time"},
+};
+
+static void run(unsigned int n)
+{
+	unsigned int i;
+	struct testcase *tc = &tcases[n];
+
+	tst_res(TINFO, "Testing for %s:", tc->description);
+
+	for (i = 0; i < CLOCKS_DEFINED; ++i) {
+		clock_t clock = clock_list[i];
+
+		if (clock == CLOCK_PROCESS_CPUTIME_ID ||
+			clock == CLOCK_THREAD_CPUTIME_ID) {
+			if (!have_cputime_timers())
+				continue;
+		}
+
+		TEST(tst_syscall(__NR_timer_create, clock, NULL, &timer));
+		if (TST_RET != 0) {
+			if (possibly_unsupported(clock) && TST_ERR == EINVAL) {
+				tst_res(TPASS | TTERRNO,
+					"%s unsupported, failed as expected",
+					get_clock_str(clock));
+			} else {
+				tst_res(TBROK | TTERRNO,
+					"timer_create(%s) failed",
+					get_clock_str(clock));
+			}
+			continue;
+		}
+
+		memset(&new_set, 0, sizeof(new_set));
+		memset(&old_set, 0, sizeof(old_set));
+
+		new_set.it_value.tv_sec = tc->it_value_tv_sec;
+		new_set.it_interval.tv_sec = tc->it_internal_tv_sec;
+
+		if (tc->check_clock_gettime) {
+			if (clock_gettime(clock, &timenow) < 0) {
+				tst_res(TBROK,
+					"clock_gettime(%s) failed - skipping the test",
+					get_clock_str(clock));
+				continue;
+			}
+			new_set.it_value.tv_sec = timenow.tv_sec + 25;
+		}
+
+		TEST(tst_syscall(__NR_timer_settime, timer,
+			tc->flag, &new_set, tc->old_ptr));
+
+		if (TST_RET != 0) {
+			tst_res(TFAIL | TTERRNO, "%s failed",
+					get_clock_str(clock));
+		} else {
+			tst_res(TPASS, "%s was successful",
+					get_clock_str(clock));
+		}
+
+		TEST(tst_syscall(__NR_timer_delete, timer));
+		if (TST_RET != 0)
+			tst_res(TFAIL | TTERRNO, "timer_delete() failed!");
+	}
+}
+
+static void sighandler(int sig)
+{
+	/* sighandler for CLOCK_*_ALARM */
+	tst_res(TINFO, "Caught signal %s", tst_strsig(sig));
+}
+
+static void setup(void)
+{
+	SAFE_SIGNAL(SIGALRM, sighandler);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.needs_root = 1,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+};
diff --git a/testcases/kernel/timers/timer_settime/timer_settime03.c b/testcases/kernel/timers/timer_settime/timer_settime03.c
dissimilarity index 95%
index 1216c117c..80861995f 100644
--- a/testcases/kernel/timers/timer_settime/timer_settime03.c
+++ b/testcases/kernel/timers/timer_settime/timer_settime03.c
@@ -1,190 +1,124 @@
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
- *    TEST IDENTIFIER	: timer_settime03
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Test checking for basic error conditions for
- *    			  timer_settime(2)
- *
- *    TEST CASE TOTAL	: 6
- *
- *    AUTHOR		: Aniruddha Marathe <aniruddha.marathe@wipro.com>
- *
- *    SIGNALS
- * 	Uses SIGUSR1 to pause before test if option set.
- * 	(See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *    	This test case check whether timer_settime(2) returns appropriate error
- *    	value for invalid parameter
- *
- * 	Setup:
- *	 Setup signal handling.
- *	 Pause for SIGUSR1 if option specified.
- *
- * 	Test:
- *	 Loop if the proper options are given.
- *	 setup the individual test.
- *	 Execute system call with invalid parameters.
- *	 Check return code, if system call fails with errno == expected errno
- * 	 	Issue syscall passed with expected errno
- *	 Otherwise, Issue syscall failed to produce expected errno
- *
- * 	Cleanup:
- * 	 Print errno log and/or timing stats if options given
- *
- * USAGE:  <for command-line>
- * timer_settime03 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-p]
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
-#include <errno.h>
-#include <time.h>
-#include <unistd.h>
-
-#include "test.h"
-#include "common_timers.h"
-
-void setup(void);
-void setup_test(int option);
-
-int testcase[] = {
-	EINVAL,			/* New setting null */
-	EINVAL,			/* tv_nsec < 0 */
-	EINVAL,			/* nsec > NSEC/SEC */
-	EINVAL,			/* Invalid timerid */
-	EFAULT,			/* bad newsetting * */
-	EFAULT			/* bad oldsetting * */
-};
-
-char *TCID = "timer_settime03";
-int TST_TOTAL = ARRAY_SIZE(testcase);
-
-static struct itimerspec new_set, old_set, *old_temp, *new_temp;
-static kernel_timer_t timer, tim;
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
-			/* Set up individual tests */
-			setup_test(i);
-			TEST(ltp_syscall(__NR_timer_settime, tim, 0, new_temp,
-				     old_temp));
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
-		}
-
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-/* This function sets up individual tests */
-void setup_test(int option)
-{
-	switch (option) {
-	case 0:
-		/* Pass NULL structure as new setting */
-		new_temp = NULL;
-		tim = timer;
-		old_temp = &old_set;
-		break;
-	case 1:
-		/* Make tv_nsec value less than 0 */
-		new_set.it_value.tv_nsec = -1;
-		new_set.it_value.tv_sec = 5;
-		new_set.it_interval.tv_sec = 0;
-		new_set.it_interval.tv_nsec = 0;
-		new_temp = &new_set;
-		break;
-	case 2:
-		/* Make tv_nsec more than NSEC_PER_SEC */
-		new_set.it_value.tv_nsec = NSEC_PER_SEC + 1;
-		break;
-	case 3:
-		/* make timer_id invalid */
-		tim = (kernel_timer_t) - 1;
-		new_set.it_value.tv_nsec = 0;
-		break;
-	case 4:
-		/* make new_setting a bad pointer */
-		tim = timer;
-		new_temp = (struct itimerspec *)-1;
-		break;
-	case 5:
-		/* make old_setting a bad pointer */
-		new_temp = &new_set;
-		old_temp = (struct itimerspec *)-1;
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
-	if (ltp_syscall(__NR_timer_create, CLOCK_REALTIME, NULL, &timer) < 0) {
-		tst_brkm(TBROK, NULL, "Timer create failed. Cannot"
-			 " setup test");
-	}
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
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Wipro Technologies Ltd, 2003.  All Rights Reserved.
+ *
+ * Author:	Aniruddha Marathe <aniruddha.marathe@wipro.com>
+ *
+ * Ported to new library:
+ * 07/2019      Christian Amann <camann@suse.com>
+ */
+/*
+ * This tests basic error handling of the timer_settime(2) syscall:
+ *
+ * 1) Setting pointer to new settings to NULL -> EINVAL
+ * 2) Setting tv_nsec of the itimerspec structure to a negative value
+ *    -> EINVAL
+ * 3) Setting tv_nsec of the itimerspec structure to something larger
+ *    than NSEC_PER_SEC -> EINVAL
+ * 4) Passing an invalid timer -> EINVAL
+ * 5) Passing an invalid address for new_value -> EFAULT
+ * 6) Passing an invalid address for old_value -> EFAULT
+ */
+
+#include <errno.h>
+#include <time.h>
+#include "tst_test.h"
+#include "common_timers.h"
+
+static struct itimerspec new_set, old_set;
+static kernel_timer_t timer, timer_inval;
+
+/* separate description-array to (hopefully) improve readability */
+static const char * const descriptions[] = {
+	"setting new_set pointer to NULL",
+	"setting tv_nsec to a negative value",
+	"setting tv_nsec value too high",
+	"passing pointer to invalid timer_id",
+	"passing invalid address for new_value",
+	"passing invalid address for old_value",
+};
+
+static struct testcase {
+	kernel_timer_t		*timer_id;
+	struct itimerspec	*new_ptr;
+	struct itimerspec	*old_ptr;
+	int			it_value_tv_nsec;
+	int			error;
+} tcases[] = {
+	{&timer, NULL, &old_set, 0, EINVAL},
+	{&timer, &new_set, &old_set, -1, EINVAL},
+	{&timer, &new_set, &old_set, NSEC_PER_SEC + 1, EINVAL},
+	{&timer_inval, &new_set, &old_set, 0, EINVAL},
+	{&timer, (struct itimerspec *) -1, &old_set, 0, EFAULT},
+	{&timer, &new_set, (struct itimerspec *) -1, 0, EFAULT},
+};
+
+static void run(unsigned int n)
+{
+	unsigned int i;
+	struct testcase *tc = &tcases[n];
+
+	tst_res(TINFO, "Testing for %s:", descriptions[n]);
+
+	for (i = 0; i < CLOCKS_DEFINED; ++i) {
+		clock_t clock = clock_list[i];
+
+		if (clock == CLOCK_PROCESS_CPUTIME_ID ||
+			clock == CLOCK_THREAD_CPUTIME_ID) {
+			if (!have_cputime_timers())
+				continue;
+		}
+
+		/* Init temporary timer */
+		TEST(tst_syscall(__NR_timer_create, clock, NULL, &timer));
+		if (TST_RET != 0) {
+			if (possibly_unsupported(clock) && TST_ERR == EINVAL) {
+				tst_res(TPASS | TTERRNO,
+					"%s unsupported, failed as expected",
+					get_clock_str(clock));
+			} else {
+				tst_res(TBROK | TTERRNO,
+					"timer_create(%s) failed",
+					get_clock_str(clock));
+			}
+			continue;
+		}
+
+		memset(&new_set, 0, sizeof(new_set));
+		memset(&old_set, 0, sizeof(old_set));
+
+		new_set.it_value.tv_sec  = 5;
+		new_set.it_value.tv_nsec = tc->it_value_tv_nsec;
+
+		TEST(tst_syscall(__NR_timer_settime, *tc->timer_id,
+					0, tc->new_ptr,	tc->old_ptr));
+
+		if (tc->error != TST_ERR) {
+			tst_res(TFAIL | TTERRNO,
+				 "%s didn't fail as expected. Expected: %s - Got",
+				 get_clock_str(clock),
+				 tst_strerrno(tc->error));
+		} else {
+			tst_res(TPASS | TTERRNO,
+				"%s failed as expected",
+				get_clock_str(clock));
+		}
+
+		/* Delete temporary timer */
+		TEST(tst_syscall(__NR_timer_delete, timer));
+		if (TST_RET != 0)
+			tst_res(TFAIL | TTERRNO, "timer_delete() failed!");
+	}
+}
+
+static void setup(void)
+{
+	timer_inval = -1;
+}
+
+static struct tst_test test = {
+	.test = run,
+	.needs_root = 1,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+};
-- 
2.16.4

