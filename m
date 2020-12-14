From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 14 Dec 2020 14:37:29 +0800
Subject: [LTP] [PATCH 2/2] syscalls/sched_getparam03: Convert to new API and
 cleanup
In-Reply-To: <20201214063729.1656200-1-yangx.jy@cn.fujitsu.com>
References: <20201214063729.1656200-1-yangx.jy@cn.fujitsu.com>
Message-ID: <20201214063729.1656200-2-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 .../sched_getparam/sched_getparam03.c         | 168 ++++--------------
 1 file changed, 31 insertions(+), 137 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_getparam/sched_getparam03.c b/testcases/kernel/syscalls/sched_getparam/sched_getparam03.c
index ceec4c380..f8723008f 100644
--- a/testcases/kernel/syscalls/sched_getparam/sched_getparam03.c
+++ b/testcases/kernel/syscalls/sched_getparam/sched_getparam03.c
@@ -1,88 +1,26 @@
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
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- *
  */
- /*******************************************************************
- *
- *    TEST IDENTIFIER   : sched_getparam03
- *
- *    EXECUTED BY       : anyone
- *
- *    TEST TITLE        : testing error conditions for sched_getparam(2)
- *
- *    TEST CASE TOTAL   : 3
- *
- *    AUTHOR            : Saji Kumar.V.R <saji.kumar@wipro.com>
- *
- *    SIGNALS
- *      Uses SIGUSR1 to pause before test if option set.
- *      (See the parse_opts(3) man page).
- *
- * DESCRIPTION
- * 	Verify that,
- *   1) sched_getparam(2) returns -1 and sets errno to ESRCH if the
- *	process with specified pid could not be found
- *   2) sched_getparam(2) returns -1 and sets errno to EINVAL if
- *	the parameter pid is an invalid value (-1)
- *   3) sched_getparam(2) returns -1 and sets errno to EINVAL if the
- *	parameter p is an invalid address
- *
- * ALGORITHM
- * Setup:
- *   Setup signal handling.
- *   Pause for SIGUSR1 if option specified.
- *
- *  Test:
- *   Loop if the proper options are given.
- *   Execute system call
- *   Check return code, if (system call failed (return=-1)) &
- *			   (errno set == expected errno)
- *              Issue sys call fails with expected return value and errno.
- *   Otherwise,
- *      Issue sys call returns unexpected value.
- *
- *  Cleanup:
- *        Print errno log and/or timing stats if options given
+
+ /*\
+ * [DESCRIPTION]
  *
- * USAGE:  <for command-line>
- *  sched_getparam03 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-h] [-f] [-p]
- *		where,  -c n : Run n copies concurrently.
- *			-e   : Turn on errno logging.
- *			-h   : Show help screen
- *			-f   : Turn off functional testing
- *			-i n : Execute test n times.
- *			-I x : Execute test for x seconds.
- *			-p   : Pause for SIGUSR1 before starting
- *			-P x : Pause for x seconds between iterations.
- *			-t   : Turn on syscall timing.
+ * Verify that:
  *
- *********************************************************************/
+ * - sched_getparam(2) returns -1 and sets errno to ESRCH if the
+ * process with specified pid could not be found
+ * - sched_getparam(2) returns -1 and sets errno to EINVAL if
+ * the parameter pid is an invalid value (-1)
+ * - sched_getparam(2) returns -1 and sets errno to EINVAL if the
+ * parameter p is an invalid address
+ \*/
 
 #include <errno.h>
 #include <sched.h>
-#include "test.h"
-
-#define LARGE_PID 999999
-
-static void cleanup(void);
-static void setup(void);
+#include "tst_test.h"
 
 static struct sched_param param;
-
-char *TCID = "sched_getparam03";
-
 static pid_t unused_pid;
 static pid_t zero_pid;
 static pid_t inval_pid = -1;
@@ -92,73 +30,29 @@ static struct test_case_t {
 	pid_t *pid;
 	struct sched_param *p;
 	int exp_errno;
-	char err_desc[10];
 } test_cases[] = {
-	{
-	"test with non-existing pid", &unused_pid, &param, ESRCH, "ESRCH"}, {
-	"test invalid pid value", &inval_pid, &param, EINVAL, "EINVAL"}, {
-	"test with invalid address for p", &zero_pid, NULL, EINVAL, "EINVAL"},};
-
-int TST_TOTAL = sizeof(test_cases) / sizeof(test_cases[0]);
-
-int main(int ac, char **av)
+	{"sched_getparam() with non-existing pid",
+	 &unused_pid, &param, ESRCH},
+	{"sched_getparam() with invalid pid",
+	 &inval_pid, &param, EINVAL},
+	{"sched_getparam() with invalid address for param",
+	 &zero_pid, NULL, EINVAL},
+};
+
+static void verify_sched_getparam(unsigned int n)
 {
-	int lc, ind;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();		/* global setup */
-
-	/* The following loop checks looping state if -i option given */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		for (ind = 0; ind < TST_TOTAL; ind++) {
-
-			/* Call sched_getparam(2) to test different test
-			 * conditions. verify that it fails with -1 return
-			 * value and sets appropriate errno.
-			 */
-			TEST(sched_getparam(*(test_cases[ind].pid),
-					    test_cases[ind].p));
-
-			if ((TEST_RETURN == -1) &&
-			    (TEST_ERRNO == test_cases[ind].exp_errno)) {
-				tst_resm(TPASS, "expected failure; Got %s",
-					 test_cases[ind].err_desc);
-			} else {
-				tst_resm(TFAIL, "Call failed to produce "
-					 "expected error;  Expected errno: %d "
-					 "Got : %d, %s",
-					 test_cases[ind].exp_errno,
-					 TEST_ERRNO, strerror(TEST_ERRNO));
-			}
-		}
-	}
-
-	cleanup();
-	tst_exit();
+	struct test_case_t *tc = &test_cases[n];
 
+	TST_EXP_FAIL(sched_getparam(*(tc->pid), tc->p), tc->exp_errno, "%s", tc->desc);
 }
 
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
+static void setup(void)
 {
-	unused_pid = tst_get_unused_pid(cleanup);
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
+	unused_pid = tst_get_unused_pid();
 }
 
-/*
- * cleanup() -  performs all the ONE TIME cleanup for this test at completion
- * 		or premature exit.
- */
-void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.setup = setup,
+	.tcnt = ARRAY_SIZE(test_cases),
+	.test = verify_sched_getparam,
+};
-- 
2.25.1



