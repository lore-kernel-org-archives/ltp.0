From: Jorik Cronenberg <jcronenberg@suse.de>
Date: Thu, 31 Oct 2019 09:28:08 +0100
Subject: [LTP] [PATCH v3] Port ptrace01 to new library
Message-ID: <20191031082808.13485-1-jcronenberg@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Ported ptrace01 to the new library

Signed-off-by: Jorik Cronenberg <jcronenberg@suse.de>
---
 testcases/kernel/syscalls/ptrace/ptrace01.c | 313 ++++++----------------------
 1 file changed, 68 insertions(+), 245 deletions(-)

 v3: Implemented changes suggested by Petr.

diff --git a/testcases/kernel/syscalls/ptrace/ptrace01.c b/testcases/kernel/syscalls/ptrace/ptrace01.c
index 5a7ed5ffd..edbeeb5e1 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace01.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace01.c
@@ -1,286 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
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
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
+ * Copyright (c) 2019 Jorik Cronenberg <jcronenberg@suse.de>
+ *
+ * Author:
+ * 	Saji Kumar.V.R <saji.kumar@wipro.com>
+ * Ported to new library:
+ * 	Jorik Cronenberg <jcronenberg@suse.de>
+ *
+ * Test the functionality of ptrace() for PTRACE_TRACEME & PTRACE_KILL requests.
+ * Forked child does ptrace(PTRACE_TRACEME, ...).
+ * Then a signal is delivered to the child and verified that parent
+ * is notified via wait().
+ * After parent does ptrace(PTRACE_KILL, ..) to kill the child
+ * and parent wait() for child to finish.
+ * Test passes if child finished abnormally.
+ *
+ * Testing two cases:
+ * 1) child ignore SIGUSR2 signal
+ * 2) using a signal handler for child for SIGUSR2
+ * In both cases, child should stop & notify parent on reception of SIGUSR2.
  */
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
- *	This test case tests the functionality of ptrace() for
- *	PTRACE_TRACEME & PTRACE_KILL requests.
- *	Here, we fork a child & the child does ptrace(PTRACE_TRACEME, ...).
- *	Then a signal is delivered to the child & verified that parent
- *	is notified via wait(). then parent does ptrace(PTRACE_KILL, ..)
- *	to kill the child. Again parent wait() for child to finish.
- *	If child finished abnormally, test passes.
- *		We test two cases
- * 			1) By telling child to ignore SIGUSR2 signal
- * 			2) By installing a signal handler for child for SIGUSR2
- * 		In both cases, child should stop & notify parent on reception
- * 		of SIGUSR2
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
+static volatile int got_signal;
 
-static int got_signal = 0;
-
-char *TCID = "ptrace01";
-static int i;			/* loop test case counter, shared with do_child */
-
-int TST_TOTAL = 2;
-
-int main(int ac, char **av)
+static void child_handler(int sig LTP_ATTRIBUTE_UNUSED)
 {
+	SAFE_KILL(getppid(), SIGUSR2);
+}
 
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
-	}
-
-	/* cleanup and exit */
-	cleanup();
-	tst_exit();
-
+static void parent_handler(int sig LTP_ATTRIBUTE_UNUSED)
+{
+	got_signal = 1;
 }
 
-/* do_child() */
-void do_child(void)
+static void do_child(unsigned int i)
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
 
-	if ((sigaction(SIGUSR2, &child_act, NULL)) == -1) {
-		tst_resm(TWARN, "sigaction() failed in child");
-		exit(1);
-	}
+	SAFE_SIGACTION(SIGUSR2, &child_act, NULL);
 
 	if ((ptrace(PTRACE_TRACEME, 0, 0, 0)) == -1) {
-		tst_resm(TWARN, "ptrace() failed in child");
-		exit(1);
-	}
-	/* ensure that child bypasses signal handler */
-	if ((kill(getpid(), SIGUSR2)) == -1) {
-		tst_resm(TWARN, "kill() failed in child");
+		tst_res(TWARN, "ptrace() failed in child");
 		exit(1);
 	}
+	SAFE_KILL(getpid(), SIGUSR2);
 	exit(1);
 }
 
-/* setup() - performs all ONE TIME setup for this test */
-void setup(void)
+static void run(unsigned int i)
 {
+	pid_t child_pid;
+	int status;
+	struct sigaction parent_act;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	got_signal = 0;
 
-	TEST_PAUSE;
+	if (i == 1) {
+		parent_act.sa_handler = parent_handler;
+		parent_act.sa_flags = SA_RESTART;
+		sigemptyset(&parent_act.sa_mask);
+		SAFE_SIGACTION(SIGUSR2, &parent_act, NULL);
+	}
 
-}
+	child_pid = SAFE_FORK();
 
-/*
- *cleanup() -  performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- */
-void cleanup(void)
-{
+	if (!child_pid)
+		do_child(i);
 
-}
+	SAFE_WAITPID(child_pid, &status, 0);
 
-/*
- * child_handler() - Signal handler for child
- */
-void child_handler(void)
-{
+	if (((WIFEXITED(status)) && (WEXITSTATUS(status)))
+		 || (got_signal == 1))
+		tst_res(TFAIL, "Test Failed");
+	else if ((ptrace(PTRACE_KILL, child_pid, 0, 0)) == -1)
+		tst_res(TFAIL | TERRNO, "ptrace(PTRACE_KILL, %i, 0, 0) failed",
+				child_pid);
 
-	if ((kill(getppid(), SIGUSR2)) == -1) {
-		tst_resm(TWARN, "kill() failed in child_handler()");
-		exit(1);
-	}
-}
+	SAFE_WAITPID(child_pid, &status, 0);
 
-/*
- * parent_handler() - Signal handler for parent
- */
-void parent_handler(void)
-{
+	if (WTERMSIG(status) == 9)
+		tst_res(TPASS, "Child %s as expected", tst_strstatus(status));
+	else
+		tst_res(TFAIL, "Child %s unexpectedly", tst_strstatus(status));
 
-	got_signal = 1;
 }
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = 2,
+	.forks_child = 1,
+};
-- 
2.16.4

