From: Jorik Cronenberg <jcronenberg@suse.de>
Date: Mon, 30 Sep 2019 17:02:10 +0200
Subject: [LTP] [PATCH] Port ptrace01.c to new library
Message-ID: <20190930150210.14949-1-jcronenberg@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

This is just a port of ptrace01.c. I wanted to make sure what I'm doing is right before porting the rest. I tried to make as little changes as possible so the test should be pretty much the same.

---
 testcases/kernel/syscalls/ptrace/ptrace01.c | 296 +++++++---------------------
 1 file changed, 72 insertions(+), 224 deletions(-)

diff --git a/testcases/kernel/syscalls/ptrace/ptrace01.c b/testcases/kernel/syscalls/ptrace/ptrace01.c
index 5a7ed5ffd..ab9ef35ee 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace01.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace01.c
@@ -1,36 +1,13 @@
-/*
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* 
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
+ * Author:	Saji Kumar.V.R <saji.kumar@wipro.com>
  *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ * Ported to new library:
+ * 10/2019	Jorik Cronenberg <jcronenberg@suse.de>
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- */
-/**********************************************************
- *
- *    TEST IDENTIFIER	: ptrace01
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: functionality test for ptrace(2)
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
+ * DESCRIPTION
  *	This test case tests the functionality of ptrace() for
  *	PTRACE_TRACEME & PTRACE_KILL requests.
  *	Here, we fork a child & the child does ptrace(PTRACE_TRACEME, ...).
@@ -44,243 +21,114 @@
  * 		In both cases, child should stop & notify parent on reception
  * 		of SIGUSR2
  *
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
- *		setup signal handler for SIGUSR2 signal
- *		call ptrace() with PTRACE_TRACEME request
- *		send SIGUSR2 signal to self
- *	 PARENT:
- *		wait() for child.
- *		if parent is notified when child gets a signal through wait(),
- *		then
- *			do  ptrace(PTRACE_KILL, ..) on child
- * 			wait() for child to finish,
- * 			if child exited abnormaly,
- *				TEST passed
- * 			else
- * 				TEST failed
- *		else
- *			TEST failed
- *
- * 	Cleanup:
- * 	  Print errno log and/or timing stats if options given
- *
- * USAGE:  <for command-line>
- *  ptrace01 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-h] [-f] [-p]
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
+ */
 
+#include <stdlib.h>
 #include <errno.h>
 #include <signal.h>
 #include <sys/wait.h>
-
 #include <config.h>
 #include "ptrace.h"
+#include "tst_test.h"
 
-#include "test.h"
-
-static void do_child(void);
-static void setup(void);
-static void cleanup(void);
-static void child_handler();
-static void parent_handler();
+static int got_signal;
 
-static int got_signal = 0;
-
-char *TCID = "ptrace01";
-static int i;			/* loop test case counter, shared with do_child */
-
-int TST_TOTAL = 2;
-
-int main(int ac, char **av)
+void child_handler(void)
 {
-
-	int lc;
-	pid_t child_pid;
-	int status;
-	struct sigaction parent_act;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-#ifdef UCLINUX
-	maybe_run_child(&do_child, "d", &i);
-#endif
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; ++i) {
-			got_signal = 0;
-
-			/* Setup signal handler for parent */
-			if (i == 1) {
-				parent_act.sa_handler = parent_handler;
-				parent_act.sa_flags = SA_RESTART;
-				sigemptyset(&parent_act.sa_mask);
-
-				if ((sigaction(SIGUSR2, &parent_act, NULL))
-				    == -1) {
-					tst_resm(TWARN, "sigaction() failed"
-						 " in parent");
-					continue;
-				}
-			}
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
-#ifdef UCLINUX
-				if (self_exec(av[0], "d", i) < 0) {
-					tst_resm(TFAIL, "self_exec failed");
-					continue;
-				}
-#else
-				do_child();
-#endif
-
-			default:
-				/* Parent */
-				if ((waitpid(child_pid, &status, 0)) < 0) {
-					tst_resm(TFAIL, "waitpid() failed");
-					continue;
-				}
-
-				/*
-				 * Check the exit status of child. If (it exits
-				 * normally with exit value 1) OR (child came
-				 * through signal handler), Test Failed
-				 */
-
-				if (((WIFEXITED(status)) &&
-				     (WEXITSTATUS(status))) ||
-				    (got_signal == 1)) {
-					tst_resm(TFAIL, "Test Failed");
-					continue;
-				} else {
-					/* Kill child */
-					if ((ptrace(PTRACE_KILL, child_pid,
-						    0, 0)) == -1) {
-						tst_resm(TFAIL, "Test Failed:"
-							 " Parent was not able to kill"
-							 " child");
-						continue;
-					}
-				}
-
-				if ((waitpid(child_pid, &status, 0)) < 0) {
-					tst_resm(TFAIL, "waitpid() failed");
-					continue;
-				}
-
-				if (WIFEXITED(status)) {
-					/* Child exits normally */
-					tst_resm(TFAIL, "Test failed");
-				} else {
-					tst_resm(TPASS, "Test Passed");
-				}
-
-			}
-		}
+	if ((kill(getppid(), SIGUSR2)) == -1) {
+		tst_res(TWARN, "kill() failed in child_handler()");
+		exit(1);
 	}
+}
 
-	/* cleanup and exit */
-	cleanup();
-	tst_exit();
-
+void parent_handler(void)
+{
+	got_signal = 1;
 }
 
-/* do_child() */
-void do_child(void)
+void do_child(unsigned int i)
 {
 	struct sigaction child_act;
 
-	/* Setup signal handler for child */
-	if (i == 0) {
+	if (i == 0)
 		child_act.sa_handler = SIG_IGN;
-	} else {
+	else
 		child_act.sa_handler = child_handler;
-	}
+
 	child_act.sa_flags = SA_RESTART;
 	sigemptyset(&child_act.sa_mask);
 
 	if ((sigaction(SIGUSR2, &child_act, NULL)) == -1) {
-		tst_resm(TWARN, "sigaction() failed in child");
+		tst_res(TWARN, "sigaction() failed in child");
 		exit(1);
 	}
 
 	if ((ptrace(PTRACE_TRACEME, 0, 0, 0)) == -1) {
-		tst_resm(TWARN, "ptrace() failed in child");
+		tst_res(TWARN, "ptrace() failed in child");
 		exit(1);
 	}
-	/* ensure that child bypasses signal handler */
 	if ((kill(getpid(), SIGUSR2)) == -1) {
-		tst_resm(TWARN, "kill() failed in child");
+		tst_res(TWARN, "kill() failed in child");
 		exit(1);
 	}
 	exit(1);
 }
 
-/* setup() - performs all ONE TIME setup for this test */
-void setup(void)
+static void run(unsigned int i)
 {
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	pid_t child_pid;
+	int status;
+	struct sigaction parent_act;
 
-	TEST_PAUSE;
+#ifdef UCLINUX
+	maybe_run_child(&do_child, "d", &i);
+#endif
 
-}
+	got_signal = 0;
 
-/*
- *cleanup() -  performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- */
-void cleanup(void)
-{
+	if (i == 1) {
+		parent_act.sa_handler = parent_handler;
+		parent_act.sa_flags = SA_RESTART;
+		sigemptyset(&parent_act.sa_mask);
 
-}
+		if ((sigaction(SIGUSR2, &parent_act, NULL))
+		    == -1) {
+			tst_res(TWARN, "sigaction() failed in parent");
+		}
+	}
 
-/*
- * child_handler() - Signal handler for child
- */
-void child_handler(void)
-{
+	child_pid = SAFE_FORK();
 
-	if ((kill(getppid(), SIGUSR2)) == -1) {
-		tst_resm(TWARN, "kill() failed in child_handler()");
-		exit(1);
-	}
-}
+	if (child_pid != 0) {
 
-/*
- * parent_handler() - Signal handler for parent
- */
-void parent_handler(void)
-{
+		SAFE_WAITPID(child_pid, &status, 0);
 
-	got_signal = 1;
+		if (((WIFEXITED(status)) &&
+		     (WEXITSTATUS(status))) ||
+		    (got_signal == 1)) {
+			tst_res(TFAIL, "Test Failed");
+		} else {
+			if ((ptrace(PTRACE_KILL, child_pid,
+				    0, 0)) == -1) {
+				tst_res(TFAIL,
+						"Test Failed: Parent was not able to kill child");
+			}
+		}
+
+		SAFE_WAITPID(child_pid, &status, 0);
+
+		if (WIFEXITED(status))
+			tst_res(TFAIL, "Test failed");
+		else
+			tst_res(TPASS, "Test Passed");
+
+	} else
+		do_child(i);
 }
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = 2,
+	.forks_child = 1,
+};
-- 
2.16.4

