From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Tue, 20 Jul 2021 16:33:15 +0300
Subject: [LTP] [PATCH 07/16] syscalls/sched_setparam04: convert to new API
In-Reply-To: <20210720133324.21752-1-aleksei.kodanev@bell-sw.com>
References: <20210720133324.21752-1-aleksei.kodanev@bell-sw.com>
Message-ID: <20210720133324.21752-8-aleksei.kodanev@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 .../sched_setparam/sched_setparam04.c         | 161 ++++--------------
 1 file changed, 30 insertions(+), 131 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_setparam/sched_setparam04.c b/testcases/kernel/syscalls/sched_setparam/sched_setparam04.c
index f6e017d3d..d80fd0d2a 100644
--- a/testcases/kernel/syscalls/sched_setparam/sched_setparam04.c
+++ b/testcases/kernel/syscalls/sched_setparam/sched_setparam04.c
@@ -1,34 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
+ * Copyright (c) 2021, BELLSOFT. All rights reserved.
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
+ * AUTHOR: Saji Kumar.V.R <saji.kumar@wipro.com>
  */
- /*******************************************************************
- *
- *    TEST IDENTIFIER   : sched_setparam04
- *
- *    EXECUTED BY       : anyone
- *
- *    TEST TITLE        : testing error conditions for sched_setparam(2)
- *
- *    TEST CASE TOTAL   : 4
- *
- *    AUTHOR            : Saji Kumar.V.R <saji.kumar@wipro.com>
+
+/*\
+ * [Description]
  *
- *    SIGNALS
- *      Uses SIGUSR1 to pause before test if option set.
- *      (See the parse_opts(3) man page).
+ * Testing error conditions for sched_setparam(2)
  *
  * DESCRIPTION
  * 	Verify that,
@@ -41,129 +21,48 @@
  *   4) sched_setparam(2) returns -1 sets errno to EINVAL if the
  *	value for p.sched_priority is other than 0 for scheduling
  *	policy, SCHED_OTHER
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
- *
- * USAGE:  <for command-line>
- *  sched_setparam04 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-h] [-f] [-p]
- *		where,  -c n : Run n copies concurrently.
- *			-e   : Turn on errno logging.
- *			-h   : Show help screen
- *			-f   : Turn off functional testing
- *			-i n : Execute test n times.
- *			-I x : Execute test for x seconds.
- *			-p   : Pause for SIGUSR1 before starting
- *			-P x : Pause for x seconds between iterations.
- *			-t   : Turn on syscall timing.
- *
- *********************************************************************/
-
-#include <errno.h>
-#include <sched.h>
-#include <pwd.h>
-#include "test.h"
+ */
 
-static void cleanup(void);
-static void setup(void);
+#include <stdlib.h>
 
-static struct sched_param param = { 0 };
-static struct sched_param param1 = { 1 };
+#include "tst_test.h"
+#include "tst_sched.h"
 
-char *TCID = "sched_setparam04";
+static struct sched_param p = { .sched_priority = 0 };
+static struct sched_param p1 = { .sched_priority = 1 };
 
 static pid_t unused_pid;
 static pid_t inval_pid = -1;
 static pid_t zero_pid;
 
-static struct test_case_t {
+static struct test_cases_t {
 	char *desc;
 	pid_t *pid;
 	struct sched_param *p;
 	int exp_errno;
-	char err_desc[10];
-} test_cases[] = {
+} tcases[] = {
 	{
-	"test with non-existing pid", &unused_pid, &param, ESRCH, "ESRCH"}, {
-	"test invalid pid value", &inval_pid, &param, EINVAL, "EINVAL"}, {
-	"test with invalid address for p", &zero_pid, NULL, EINVAL, "EINVAL"}, {
-	"test with invalid p.sched_priority", &zero_pid, &param1, EINVAL,
-		    "EINVAL"}
+	"test with non-existing pid", &unused_pid, &p, ESRCH}, {
+	"test invalid pid value", &inval_pid, &p, EINVAL,}, {
+	"test with invalid address for p", &zero_pid, NULL, EINVAL}, {
+	"test with invalid p.sched_priority", &zero_pid, &p1, EINVAL}
 };
 
-int TST_TOTAL = sizeof(test_cases) / sizeof(test_cases[0]);
-
-int main(int ac, char **av)
+static void setup(void)
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
-			/*
-			 * call the system call with the TEST() macro
-			 */
-			TEST(sched_setparam(*(test_cases[ind].pid),
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
-
-	tst_exit();
+	unused_pid = tst_get_unused_pid();
 }
 
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
+static void run(unsigned int n)
 {
-	unused_pid = tst_get_unused_pid(cleanup);
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	struct test_cases_t *tc = &tcases[n];
 
+	TST_EXP_FAIL(tst_sched_setparam(*tc->pid, tc->p), tc->exp_errno,
+		     "%s", tc->desc);
 }
 
-/*
- * cleanup() -  performs all the ONE TIME cleanup for this test at completion
- *		or premature exit.
- */
-void cleanup(void)
-{
-
-}
+static struct tst_test test = {
+	.setup = setup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+};
-- 
2.25.1

