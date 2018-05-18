From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 18 May 2018 09:30:36 +0800
Subject: [LTP] [PATCH v2 1/2] syscalls/prctl01: Rewrite to the new library
In-Reply-To: <20180517152329.3h7zuuoatcbtklbl@dell5510>
References: <20180517152329.3h7zuuoatcbtklbl@dell5510>
Message-ID: <1526607037-22667-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/prctl/prctl01.c | 187 +++++-------------------------
 1 file changed, 30 insertions(+), 157 deletions(-)

diff --git a/testcases/kernel/syscalls/prctl/prctl01.c b/testcases/kernel/syscalls/prctl/prctl01.c
index 1857dfb..4270e84 100644
--- a/testcases/kernel/syscalls/prctl/prctl01.c
+++ b/testcases/kernel/syscalls/prctl/prctl01.c
@@ -1,174 +1,47 @@
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
- *    TEST IDENTIFIER	: prctl01
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for prctl(2)
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
- *	This is a Phase I test for the prctl(2) system call.
- *	It is intended to provide a limited exposure of the system call.
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
- *		If call succeeds,
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
- *  prctl01 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-h] [-f] [-p]
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
+ * This is a Phase I test for the prctl(2) system call.
+ * It is intended to provide a limited exposure of the system call.
+ */
 
 #include <errno.h>
 #include <signal.h>
 #include <sys/prctl.h>
-#include <sys/wait.h>
-
-#include "test.h"
 
-static void setup(void);
-static void cleanup(void);
+#include "tst_test.h"
 
-char *TCID = "prctl01";
-
-int option[2] = { PR_GET_PDEATHSIG, PR_SET_PDEATHSIG };
-
-int TST_TOTAL = 2;
-
-int main(int ac, char **av)
+static void verify_prctl(void)
 {
+	int get_sig = 0;
 
-	int lc, i;
-	pid_t child_pid;
-	int status, sig;
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
-				if (i == 1) {
-					sig = SIGUSR2;
-					TEST(prctl(option[i], sig));
-				} else {
-					TEST(prctl(option[i], &sig));
-				}
-
-				if (TEST_RETURN == 0) {
-					exit(0);
-				} else {
-					tst_resm(TWARN | TTERRNO,
-						 "prctl() returned %ld",
-						 TEST_RETURN);
-					exit(1);
-				}
-
-			default:
-				/* Parent */
-				if ((waitpid(child_pid, &status, 0)) < 0) {
-					tst_resm(TFAIL, "waitpid() failed");
-					continue;
-				}
-
-				if ((WIFEXITED(status)) &&
-				    (WEXITSTATUS(status) == 0)) {
-					tst_resm(TPASS, "Test Passed");
-				} else {
-					tst_resm(TFAIL, "Test Failed");
-				}
-
-			}
-		}
+	TEST(prctl(PR_SET_PDEATHSIG, SIGUSR2));
+	if (TEST_RETURN == -1) {
+		tst_res(TFAIL | TTERRNO, "prctl(PR_SET_PDEATHSIG) failed");
+		return;
 	}
 
-	/* cleanup and exit */
-	cleanup();
-	tst_exit();
-
-}
-
-/* setup() - performs all ONE TIME setup for this test */
-void setup(void)
-{
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_res(TINFO, "prctl(PR_SET_PDEATHSIG) succeeded");
 
-	TEST_PAUSE;
+	TEST(prctl(PR_GET_PDEATHSIG, &get_sig));
+	if (TEST_RETURN == -1) {
+		tst_res(TFAIL | TTERRNO, "prctl(PR_GET_PDEATHSIG) failed");
+		return;
+	}
 
+	if (get_sig == SIGUSR2) {
+		tst_res(TPASS,
+			"prctl(PR_GET_PDEATHSIG) got expected death signal");
+	} else {
+		tst_res(TFAIL, "prctl(PR_GET_PDEATHSIG) got death signal %d,"
+			" expected %d", get_sig, SIGUSR2);
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
+	.test_all = verify_prctl,
+};
-- 
1.8.3.1



