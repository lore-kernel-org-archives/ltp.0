From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Tue, 20 Jul 2021 16:33:14 +0300
Subject: [LTP] [PATCH 06/16] syscalls/sched_setparam03: convert to new API
In-Reply-To: <20210720133324.21752-1-aleksei.kodanev@bell-sw.com>
References: <20210720133324.21752-1-aleksei.kodanev@bell-sw.com>
Message-ID: <20210720133324.21752-7-aleksei.kodanev@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 .../sched_setparam/sched_setparam03.c         | 215 ++++--------------
 1 file changed, 40 insertions(+), 175 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_setparam/sched_setparam03.c b/testcases/kernel/syscalls/sched_setparam/sched_setparam03.c
index 252364e2e..e9571a9b1 100644
--- a/testcases/kernel/syscalls/sched_setparam/sched_setparam03.c
+++ b/testcases/kernel/syscalls/sched_setparam/sched_setparam03.c
@@ -1,196 +1,61 @@
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
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
+ * AUTHOR: Saji Kumar.V.R <saji.kumar@wipro.com>
  */
-/**********************************************************
- *
- *    TEST IDENTIFIER	: sched_setparam03
- *
- *    EXECUTED BY	: root / superuser
- *
- *    TEST TITLE	: Checks functionality for sched_setparam(2) for pid!=0
- *
- *    TEST CASE TOTAL	: 1
- *
- *    AUTHOR		: Saji Kumar.V.R <saji.kumar@wipro.com>
- *
- *    SIGNALS
- * 	Uses SIGUSR1 to pause before test if option set.
- * 	(See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *	This test forks a child & changes its parent's scheduling priority
- *
- * 	Setup:
- * 	  Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *	  Change scheduling policy to SCHED_FIFO
- *
- * 	Test:
- *	 Loop if the proper options are given.
- *	 Fork a child
- *
- *	 CHILD:
- *	  Changes scheduling priority for parent
- *
- *	 PARENT:
- *	  If scheduling priority is set properly,
- *		TEST passed
- *	  else
- *		TEST failed
- *
- * 	Cleanup:
- * 	  Print errno log and/or timing stats if options given
+
+/*\
+ * [Description]
  *
- * USAGE:  <for command-line>
- *  sched_setparam03 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-h] [-f] [-p]
- *			where,  -c n : Run n copies concurrently.
- *				-e   : Turn on errno logging.
- *				-h   : Show help screen
- *				-f   : Turn off functional testing
- *				-i n : Execute test n times.
- *				-I x : Execute test for x seconds.
- *				-p   : Pause for SIGUSR1 before starting
- *				-P x : Pause for x seconds between iterations.
- *				-t   : Turn on syscall timing.
+ * Checks functionality for sched_setparam(2) for pid != 0
  *
- ****************************************************************/
-
-#include <err.h>
-#include <errno.h>
-#include <sched.h>
-#include <sys/wait.h>
-#include "test.h"
-
-#define NEW_PRIORITY 5
-
-static void setup();
-static void cleanup();
-static int verify_priority();
+ * This test forks a child and changes its parent's scheduling priority.
+ */
 
-char *TCID = "sched_setparam03";
-int TST_TOTAL = 1;
+#include <stdlib.h>
 
-static struct sched_param param = { NEW_PRIORITY };
+#include "tst_test.h"
+#include "tst_sched.h"
 
-int main(int ac, char **av)
+static void run(void)
 {
-
-	int lc;
-	int status;
+	struct sched_param p5 = { .sched_priority = 5 };
+	struct sched_param p;
 	pid_t child_pid;
 
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
+	child_pid = SAFE_FORK();
 
-		switch (child_pid = FORK_OR_VFORK()) {
-
-		case -1:
-			/* fork() failed */
-			tst_resm(TFAIL, "fork() failed");
-			continue;
-
-		case 0:
-			/* Child */
-
-			/*
-			 * Call sched_setparam(2) with pid = getppid() so that
-			 * it will set the scheduling parameters for parent
-			 * process
-			 */
-			TEST(sched_setparam(getppid(), &param));
-
-			if (TEST_RETURN == -1) {
-				err(0, "sched_setparam returned %ld",
-				    TEST_RETURN);
-			}
-			exit(1);
-
-		default:
-			/* Parent */
-			if ((waitpid(child_pid, &status, 0)) < 0) {
-				tst_resm(TFAIL, "wait() failed");
-				continue;
-			}
-
-			/*
-			 * Verify that parent's scheduling priority has
-			 * changed.
-			 */
-			if ((WIFEXITED(status)) && (WEXITSTATUS(status)) &&
-			    (verify_priority())) {
-				tst_resm(TPASS, "Test Passed");
-			} else {
-				tst_resm(TFAIL, "Test Failed");
-			}
-		}
+	if (!child_pid) {
+		/*
+		 * Call sched_setparam(2) with pid = getppid() so that
+		 * it will set the scheduling parameters for parent
+		 * process
+		 */
+		TST_EXP_PASS_SILENT(tst_sched_setparam(getppid(), &p5));
+		exit(0);
 	}
+	tst_reap_children();
+
+	TST_EXP_PASS_SILENT(tst_sched_getparam(0, &p));
 
-	cleanup();
-	tst_exit();
+	if (p.sched_priority == p5.sched_priority)
+		tst_res(TPASS, "got expected priority %d", p.sched_priority);
+	else
+		tst_res(TFAIL, "got priority %d, expected %d",
+			p.sched_priority, p5.sched_priority);
 }
 
-/* setup() - performs all ONE TIME setup for this test */
 void setup(void)
 {
-	struct sched_param p = { 1 };
-
-	tst_require_root();
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	/* Change scheduling policy to SCHED_FIFO */
-	if ((sched_setscheduler(0, SCHED_FIFO, &p)) == -1) {
-		tst_brkm(TBROK, cleanup, "sched_setscheduler() failed");
-	}
+	struct sched_param p = { .sched_priority = 1 };
 
+	TST_EXP_PASS_SILENT(tst_sched_setscheduler(0, SCHED_FIFO, &p));
 }
 
-/*
- *cleanup() -   performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- */
-void cleanup(void)
-{
-}
-
-/*
- * verify_priority() -  This function checks whether the priority is
- *			set correctly
- */
-int verify_priority(void)
-{
-	struct sched_param p;
-
-	if ((sched_getparam(0, &p)) == 0) {
-		if (p.sched_priority == NEW_PRIORITY) {
-			return 1;
-		} else {
-			tst_resm(TWARN, "sched_getparam() returned priority"
-				 " value as %d", p.sched_priority);
-			return 0;
-		}
-	}
-
-	tst_resm(TWARN, "sched_getparam() failed");
-	return 0;
-}
+static struct tst_test test = {
+	.forks_child = 1,
+	.needs_root = 1,
+	.setup = setup,
+	.test_all = run,
+};
-- 
2.25.1

