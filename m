From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 18 May 2018 09:30:37 +0800
Subject: [LTP] [PATCH v2 2/2] syscalls/prctl02: Rewrite to the new library
In-Reply-To: <1526607037-22667-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20180517152329.3h7zuuoatcbtklbl@dell5510>
 <1526607037-22667-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1526607037-22667-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/prctl/prctl02.c | 195 +++++-------------------------
 1 file changed, 29 insertions(+), 166 deletions(-)

diff --git a/testcases/kernel/syscalls/prctl/prctl02.c b/testcases/kernel/syscalls/prctl/prctl02.c
index 67e3b6f..1e7640b 100644
--- a/testcases/kernel/syscalls/prctl/prctl02.c
+++ b/testcases/kernel/syscalls/prctl/prctl02.c
@@ -1,189 +1,52 @@
 /*
+ * SPDX-License-Identifier: GPL-2.0-or-later
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
  */
-/**********************************************************
- *
- *    TEST IDENTIFIER	: prctl02
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Tests for error conditions
- *
- *    TEST CASE TOTAL	: 2
- *
- *    AUTHOR		: Saji Kumar.V.R <saji.kumar@wipro.com>
- *
- *    SIGNALS
- * 	Uses SIGUSR1 to pause before test if option set.
- * 	(See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *	Verify that
- *	1) prctl() fails with errno, EINVAL when an invalid value is given for
- *	   option
- *	2) prctl() fails with errno, EINVAL when option is PR_SET_PDEATHSIG
- *	   & arg2 is not zero or a valid signal number
- *
- * 	Setup:
- * 	  Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *
- * 	Test:
- *	 Loop if the proper options are given.
- *	 fork a child
- *
- *	 CHILD:
- *		call prctl() with proper arguments
- *		If call fails with expected errno,
- *			exit with 0
- *		else
- *			exit with 1
- *	 PARENT:
- *		wait() for child.
- *		If child exits with exit value 0,
- *			Test passed
- *		else
- *			Test Failed
- *
- * 	Cleanup:
- * 	  Print errno log and/or timing stats if options given
- *
- * USAGE:  <for command-line>
- *  prctl02 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-h] [-f] [-p]
- *			where,  -c n : Run n copies concurrently.
- *				-e   : Turn on errno logging.
- *				-h   : Show help screen
- *				-f   : Turn off functional testing
- *				-i n : Execute test n times.
- *				-I x : Execute test for x seconds.
- *				-p   : Pause for SIGUSR1 before starting
- *				-P x : Pause for x seconds between iterations.
- *				-t   : Turn on syscall timing.
- *
- ****************************************************************/
+
+/*
+ * DESCRIPTION
+ * 1) prctl() fails with EINVAL when an invalid value is given for option
+ * 2) prctl() fails with EINVAL when option is PR_SET_PDEATHSIG & arg2 is
+ * not zero or a valid signal number
+ */
 
 #include <errno.h>
 #include <signal.h>
 #include <sys/prctl.h>
-#include <sys/wait.h>
 
-#include "test.h"
+#include "tst_test.h"
 
 #define OPTION_INVALID 999
 #define INVALID_ARG 999
 
-static void setup(void);
-static void cleanup(void);
-
-char *TCID = "prctl02";
-
-struct test_cases_t {
+static struct tcase {
 	int option;
 	unsigned long arg2;
 	int exp_errno;
-} test_cases[] = {
-	{
-	OPTION_INVALID, 0, EINVAL}, {
-	PR_SET_PDEATHSIG, INVALID_ARG, EINVAL}
+} tcases[] = {
+	{OPTION_INVALID, 0, EINVAL},
+	{PR_SET_PDEATHSIG, INVALID_ARG, EINVAL},
 };
 
-int TST_TOTAL = sizeof(test_cases) / sizeof(test_cases[0]);
-
-int main(int ac, char **av)
+static void verify_prctl(unsigned int n)
 {
+	struct tcase *tc = &tcases[n];
 
-	int lc, i;
-	pid_t child_pid;
-	int status;
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
-
-			switch (child_pid = FORK_OR_VFORK()) {
-
-			case -1:
-				/* fork() failed */
-				tst_resm(TFAIL, "fork() failed");
-				continue;
-
-			case 0:
-				/* Child */
-
-				TEST(prctl(test_cases[i].option,
-					   test_cases[i].arg2));
-				if ((TEST_RETURN == -1) && (TEST_ERRNO ==
-							    test_cases
-							    [i].exp_errno)) {
-					exit(TEST_ERRNO);
-				} else {
-					tst_resm(TWARN | TTERRNO,
-						 "prctl() returned %ld",
-						 TEST_RETURN);
-					exit(TEST_ERRNO);
-				}
-
-			default:
-				/* Parent */
-				if ((waitpid(child_pid, &status, 0)) < 0) {
-					tst_resm(TFAIL, "waitpid() failed");
-					continue;
-				}
-
-				if ((WIFEXITED(status)) && (WEXITSTATUS(status)
-							    ==
-							    test_cases
-							    [i].exp_errno)) {
-					tst_resm(TPASS, "Test Passed");
-				} else {
-					tst_resm(TFAIL, "Test Failed");
-				}
-
-			}
-		}
+	TEST(prctl(tc->option, tc->arg2));
+	if (TEST_RETURN == 0) {
+		tst_res(TFAIL, "prctl() succeeded unexpectedly");
+		return;
 	}
 
-	/* cleanup and exit */
-	cleanup();
-
-	tst_exit();
-
-}
-
-/* setup() - performs all ONE TIME setup for this test */
-void setup(void)
-{
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
+	if (tc->exp_errno == TEST_ERRNO) {
+		tst_res(TPASS | TTERRNO, "prctl() failed as expected");
+	} else {
+		tst_res(TPASS | TTERRNO, "prctl() failed unexpectedly, "
+			"expected %s", tst_strerrno(tc->exp_errno));
+	}
 }
 
-/*
- *cleanup() -  performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- */
-void cleanup(void)
-{
-
-}
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_prctl,
+};
-- 
1.8.3.1



