From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Fri,  6 Aug 2021 19:47:20 +0300
Subject: [LTP] [PATCH v2 06/16] syscalls/sched_setparam03: convert to new API
In-Reply-To: <20210806164730.51040-1-aleksei.kodanev@bell-sw.com>
References: <20210806164730.51040-1-aleksei.kodanev@bell-sw.com>
Message-ID: <20210806164730.51040-7-aleksei.kodanev@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 .../sched_setparam/sched_setparam03.c         | 235 +++++-------------
 1 file changed, 58 insertions(+), 177 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_setparam/sched_setparam03.c b/testcases/kernel/syscalls/sched_setparam/sched_setparam03.c
index 252364e2e..8c8d1e8d5 100644
--- a/testcases/kernel/syscalls/sched_setparam/sched_setparam03.c
+++ b/testcases/kernel/syscalls/sched_setparam/sched_setparam03.c
@@ -1,196 +1,77 @@
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
-
-char *TCID = "sched_setparam03";
-int TST_TOTAL = 1;
-
-static struct sched_param param = { NEW_PRIORITY };
+ * This test forks a child and changes its parent's scheduling priority.
+ */
 
-int main(int ac, char **av)
+#include <stdlib.h>
+
+#include "tst_test.h"
+#include "tst_sched.h"
+
+static struct sched_variants variants[] = {
+	{ .sched_setparam = libc_sched_setparam,
+	  .sched_getparam = libc_sched_getparam,
+	  .sched_setscheduler = libc_sched_setscheduler,
+	  .desc = "libc"
+	},
+	{ .sched_setparam = sys_sched_setparam,
+	  .sched_getparam = sys_sched_getparam,
+	  .sched_setscheduler = sys_sched_setscheduler,
+	  .desc = "syscall"
+	},
+};
+
+static void run(void)
 {
-
-	int lc;
-	int status;
+	struct sched_variants *tv = &variants[tst_variant];
+	struct sched_param p5 = { .sched_priority = 5 };
+	struct sched_param p;
 	pid_t child_pid;
 
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	child_pid = SAFE_FORK();
 
-		tst_count = 0;
-
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
+		TST_EXP_PASS_SILENT(tv->sched_setparam(getppid(), &p5));
+		exit(0);
 	}
+	tst_reap_children();
 
-	cleanup();
-	tst_exit();
+	TST_EXP_PASS_SILENT(tv->sched_getparam(0, &p));
+
+	if (p.sched_priority == p5.sched_priority)
+		tst_res(TPASS, "got expected priority %d", p.sched_priority);
+	else
+		tst_res(TFAIL, "got priority %d, expected 5", p.sched_priority);
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
+	struct sched_variants *tv = &variants[tst_variant];
+	struct sched_param p = { .sched_priority = 1 };
 
+	tst_res(TINFO, "Testing %s variant", tv->desc);
+	TST_EXP_PASS_SILENT(tv->sched_setscheduler(0, SCHED_FIFO, &p));
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
+	.test_variants = ARRAY_SIZE(variants),
+	.test_all = run,
+};
-- 
2.25.1

