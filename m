From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 2 Nov 2020 19:42:17 +0800
Subject: [LTP] [PATCH 1/2] syscalls/ptrace03: Clean up and converted into
 new api
Message-ID: <1604317338-22774-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1)use SAFE_FORK and SAFE_PTRACE macro
2)remove EPERM error test for init(1) process because
it has supported since long times ago(about 2.6.26)

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/ptrace/ptrace03.c | 227 ++++----------------
 1 file changed, 42 insertions(+), 185 deletions(-)

diff --git a/testcases/kernel/syscalls/ptrace/ptrace03.c b/testcases/kernel/syscalls/ptrace/ptrace03.c
index f326b834d..b2b3fb49d 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace03.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace03.c
@@ -1,217 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
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
+ * AUTHOR: Saji Kumar.V.R <saji.kumar@wipro.com>
  *
+ * 1) ptrace() returns -1 and sets errno to ESRCH if process with
+ * specified pid does not exist.
+ * 2) ptrace() returns -1 and sets errno to EPERM if we are trying
+ * to trace a process which is already been traced
  */
-/**********************************************************
- *
- *    TEST IDENTIFIER	: ptrace03
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Tests for error conditions
- *
- *    TEST CASE TOTAL	: 3
- *
- *    AUTHOR		: Saji Kumar.V.R <saji.kumar@wipro.com>
- *
- *    SIGNALS
- * 	Uses SIGUSR1 to pause before test if option set.
- * 	(See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *	Verifies that
- *	1) ptrace() returns -1 & sets errno to EPERM while tring to trace
- *	   process 1
- *         (This test case will be executed only if the kernel version
- *          is 2.6.25 or below)
- *	2) ptrace() returns -1 & sets errno to ESRCH if process with
- *	   specified pid does not exist
- *	3) ptrace() returns -1 & sets errno to EPERM if we are trying
- *	   to trace a process which is already been traced
- *
- * 	Setup:
- * 	  Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *
- * 	Test:
- *	 Loop if the proper options are given.
- *	 setup signal handler for SIGUSR2 signal
- *	 fork a child
- *
- *	 CHILD:
- *	 	call ptrace() with proper arguments
- *	 	if ptrace() failed with expected return value & errno
- *			exit with errno
- *		else
- *			Give proper error message
- *			exit with errno
- *
- *	 PARENT:
- *		Wait for child to finish
- *		if child exits with expected errno
- *			Test Passed
- *	 	else
- *			Test failed
- *
- * 	Cleanup:
- * 	  Print errno log and/or timing stats if options given
- *
- * USAGE:  <for command-line>
- *  ptrace03 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-h] [-f] [-p]
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
 
 #include <errno.h>
 #include <signal.h>
 #include <sys/wait.h>
 #include <pwd.h>
-
 #include <config.h>
+#include <stdlib.h>
 #include "ptrace.h"
+#include "tst_test.h"
 
-#include "test.h"
-
-static void setup(void);
-static void cleanup(void);
-
-char *TCID = "ptrace03";
-
-static pid_t init_pid = 1;
 static pid_t unused_pid;
 static pid_t zero_pid;
 
-struct test_case_t {
+static struct tcase {
 	int request;
 	pid_t *pid;
 	int exp_errno;
-} test_cases[] = {
-	{
-	PTRACE_ATTACH, &init_pid, EPERM}, {
-	PTRACE_ATTACH, &unused_pid, ESRCH}, {
-	PTRACE_TRACEME, &zero_pid, EPERM},};
+	char *tname;
+} tcases[] = {
+	{PTRACE_ATTACH, &unused_pid, ESRCH,
+	"Trace a process which does not exist"},
 
-int TST_TOTAL = sizeof(test_cases) / sizeof(test_cases[0]);
+	{PTRACE_TRACEME, &zero_pid, EPERM,
+	"Trace a process which is already been traced"}
+};
 
-int main(int ac, char **av)
+static void verify_ptrace(unsigned int n)
 {
+	struct tcase *tc = &tcases[n];
+	int child_pid;
 
-	int lc, i;
-	pid_t child_pid;
-	int status;
+	tst_res(TINFO, "%s", tc->tname);
 
-	tst_parse_opts(ac, av, NULL, NULL);
+	child_pid = SAFE_FORK();
+	if (!child_pid) {
+		if (tc->exp_errno == EPERM)
+			SAFE_PTRACE(PTRACE_TRACEME, 0, NULL, NULL);
 
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; ++i) {
-
-			/* since Linux 2.6.26, it's allowed to trace init,
-			   so just skip this test case */
-			if (i == 0 && tst_kvercmp(2, 6, 25) > 0) {
-				tst_resm(TCONF,
-					 "this kernel allows to trace init");
-				continue;
-			}
-
-			/* fork() */
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
-				/* setup for third test case */
-				if (i == 2) {
-					if ((ptrace(PTRACE_TRACEME, 0,
-						    NULL, NULL)) == -1) {
-						tst_resm(TWARN, "ptrace()"
-							 " falied with errno, %d : %s",
-							 errno,
-							 strerror(errno));
-						exit(0);
-					}
-				}
-
-				TEST(ptrace(test_cases[i].request,
-					    *(test_cases[i].pid), NULL, NULL));
-				if ((TEST_RETURN == -1) && (TEST_ERRNO ==
-							    test_cases
-							    [i].exp_errno)) {
-					exit(TEST_ERRNO);
-				} else {
-					tst_resm(TWARN | TTERRNO,
-						 "ptrace() returned %ld",
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
-				if ((WIFEXITED(status)) &&
-				    (WEXITSTATUS(status) ==
-				     test_cases[i].exp_errno)) {
-					tst_resm(TPASS, "Test Passed");
-				} else {
-					tst_resm(TFAIL, "Test Failed");
-				}
-			}
+		TEST(ptrace(tc->request, *(tc->pid), NULL, NULL));
+		if (TST_RET == 0) {
+			tst_res(TFAIL, "ptrace() succeeded unexpectedly");
+			exit(1);
 		}
+		if (tc->exp_errno == TST_ERR)
+			tst_res(TPASS | TTERRNO, "ptrace() failed as expected");
+		else
+			tst_res(TFAIL | TTERRNO, "ptrace() failed unexpectedly, expected %s",
+					tst_strerrno(tc->exp_errno));
 	}
-
-	/* cleanup and exit */
-	cleanup();
-
-	tst_exit();
-
+	tst_reap_children();
 }
 
-/* setup() - performs all ONE TIME setup for this test */
-void setup(void)
+static void setup(void)
 {
-	unused_pid = tst_get_unused_pid(cleanup);
-
-	TEST_PAUSE;
-
+	unused_pid = tst_get_unused_pid();
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
+	.test = verify_ptrace,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.forks_child = 1,
+};
-- 
2.23.0



