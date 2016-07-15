From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 15 Jul 2016 17:39:49 +0300
Subject: [LTP] [PATCH 8/8] waitpid08: use the new API
In-Reply-To: <1468593589-30545-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1468593589-30545-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1468593589-30545-9-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

And also use the WIFEXITED/WEXITSTATUS logic from waitpid06, 07
test cases. It seems this was the initial idea of the test's author.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/syscalls/waitpid/waitpid08.c |  297 +++++--------------------
 1 files changed, 55 insertions(+), 242 deletions(-)

diff --git a/testcases/kernel/syscalls/waitpid/waitpid08.c b/testcases/kernel/syscalls/waitpid/waitpid08.c
index b2e9e9b..4021441 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid08.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid08.c
@@ -1,185 +1,53 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
  *
- *   Copyright (c) International Business Machines  Corp., 2001
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.
  *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * History
+ *	07/2001 John George
+ *		-Ported
+ *      04/2002 wjhuie sigset cleanups
  */
 
 /*
- * NAME
- *	waitpid08.c
- *
  * DESCRIPTION
- *	Tests to see if pid's returned from fork and waitpid are same
+ *	Tests to see if pids returned from fork and waitpid are same.
  *
  * ALGORITHM
  *	Check proper functioning of waitpid with pid = -1 and arg =
  *	WUNTRACED
- *
- * USAGE:  <for command-line>
- *      waitpid08 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *      where,  -c n : Run n copies concurrently.
- *              -e   : Turn on errno logging.
- *              -i n : Execute test n times.
- *              -I x : Execute test for x seconds.
- *              -P x : Pause for x seconds between iterations.
- *              -t   : Turn on syscall timing.
- *
- * History
- *	07/2001 John George
- *		-Ported
- *      04/2002 wjhuie sigset cleanups
- *
- * Restrictions
- *	None
  */
 
-#include <sys/types.h>
-#include <signal.h>
-#include <errno.h>
-#include <sys/wait.h>
-#include "test.h"
-
-static void inthandlr();
-static void do_exit(void);
-static void setup_sigint(void);
-static void do_child_1(void);
-static void setup(void);
-static void cleanup(void);
-
-char *TCID = "waitpid08";
-int TST_TOTAL = 1;
-volatile int intintr;
-static int fail;
-
-#define	MAXKIDS	8
-
-#ifdef UCLINUX
-static char *argv0;
-static void do_child_2_uclinux(void);
-#endif
-
-int main(int argc, char **argv)
-{
-	int lc;
-
-	int status;
-	int pid;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-#ifdef UCLINUX
-	argv0 = argv[0];
-
-	maybe_run_child(&do_child_1, "n", 1);
-	maybe_run_child(&do_child_2_uclinux, "n", 2);
-#endif
-
-	setup();
-
-	/* check for looping state if -i option is given */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-		fail = 0;
-
-		pid = FORK_OR_VFORK();
-		if (pid < 0) {
-			tst_resm(TFAIL, "Fork Failed, may be OK under stress");
-
-		} else if (pid == 0) {
-			/*
-			 * Child:
-			 * Set up to catch SIGINT.
-			 * The kids will wait till a SIGINT has been received
-			 * before they proceed.
-			 */
-#ifdef UCLINUX
-			if (self_exec(argv[0], "n", 1) < 0) {
-				tst_resm(TINFO, "self_exec failed");
-				exit(pid);
-			}
-#else
-			do_child_1();
-#endif
-		} else {	/* parent */
-			waitpid(pid, &status, 0);
-			if (WEXITSTATUS(status) != 0) {
-				tst_resm(TFAIL, "child returned bad status");
-				fail = 1;
-			}
-			if (fail)
-				tst_resm(TFAIL, "%s FAILED", TCID);
-			else
-				tst_resm(TPASS, "%s PASSED", TCID);
-		}
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-/*
- * setup_sigint()
- *	Sets up a SIGINT handler
- */
-static void setup_sigint(void)
-{
-	if ((sig_t) signal(SIGINT, inthandlr) == SIG_ERR) {
-		tst_resm(TFAIL, "signal SIGINT failed. " "errno = %d", errno);
-		exit(-1);
-	}
-}
+#include "waitpid_common.h"
 
 static void do_child_1(void)
 {
-	int kid_count, fork_kid_pid[MAXKIDS];
-	int ret_val;
+	int kid_count;
+	pid_t ret_val;
 	int i, j, k, found;
-	int group1, group2;
-	int wait_kid_pid[MAXKIDS], status;
-
-	setup_sigint();
-
-	group1 = getpgrp();
+	pid_t wait_kid_pid[MAXKIDS];
+	int status;
+	int fail = 0;
 
 	for (kid_count = 0; kid_count < MAXKIDS; kid_count++) {
 		if (kid_count == (MAXKIDS / 2))
-			group2 = setpgrp();
+			SAFE_SETPGID(0, 0);
 
-		intintr = 0;
-		ret_val = FORK_OR_VFORK();
-		if (ret_val == 0) {
-#ifdef UCLINUX
-			if (self_exec(argv0, "n", 2) < 0) {
-				tst_resm(TFAIL, "Fork kid %d failed. "
-					 "errno = %d", kid_count, errno);
-				exit(ret_val);
-			}
-#else
-			do_exit();
-#endif
-		}
+		ret_val = SAFE_FORK();
+		if (ret_val == 0)
+			do_exit(0);
 
-		if (ret_val < 0) {
-			tst_resm(TFAIL, "Fork kid %d failed. "
-				 "errno = %d", kid_count, errno);
-			exit(ret_val);
-		}
-
-		/* parent */
 		fork_kid_pid[kid_count] = ret_val;
 	}
 
@@ -188,26 +56,12 @@ static void do_child_1(void)
 	 */
 	ret_val = waitpid(-1, &status, WNOHANG | WUNTRACED);
 	if (ret_val != 0) {
-		tst_resm(TFAIL, "Waitpid returned wrong value");
-		tst_resm(TFAIL, "Expected 0 got %d", ret_val);
+		tst_res(TFAIL, "Waitpid returned wrong value");
+		tst_res(TFAIL, "Expected 0 got %d", ret_val);
 		fail = 1;
 	}
-#ifdef UCLINUX
-	/* Give the kids a chance to setup SIGINT again, since this is
-	 * cleared by exec().
-	 */
-	sleep(3);
-#endif
 
-	/* Now send all the kids a SIGINT to tell them to
-	 * proceed
-	 */
-	for (i = 0; i < MAXKIDS; i++) {
-		if (kill(fork_kid_pid[i], SIGINT) < 0) {
-			tst_brkm(TFAIL, NULL, "Kill of child %d "
-				 "failed, errno = %d", i, errno);
-		}
-	}
+	TST_CHECKPOINT_WAKE2(0, MAXKIDS);
 
 	/*
 	 * Wait till all kids have terminated.  Stash away their
@@ -221,27 +75,16 @@ static void do_child_1(void)
 			continue;
 
 		if (!WIFEXITED(status)) {
-			if (!WIFSTOPPED(status)) {
-				tst_resm(TFAIL, "Child %d did "
-					 "not stopped", ret_val);
-				fail = 1;
-			} else {
-				if (WSTOPSIG(status) != SIGSTOP) {
-					tst_resm(TFAIL,
-						 "Child %d "
-						 "exited with "
-						 "wrong status", ret_val);
-					tst_resm(TFAIL,
-						 "Expected "
-						 "SIGSTOP got %d",
-						 WSTOPSIG(status));
-					fail = 1;
-				}
-			}
-			if (kill(ret_val, SIGCONT) < 0) {
-				tst_resm(TFAIL, "Kill of child "
-					 "%d failed, errno = %d",
-					 ret_val, errno);
+			tst_res(TFAIL, "Child %d did not exit "
+				 "normally", ret_val);
+			fail = 1;
+		} else {
+			if (WEXITSTATUS(status) != 3) {
+				tst_res(TFAIL, "Child %d "
+					 "exited with wrong "
+					 "status", ret_val);
+				tst_res(TFAIL, "Expected 3 "
+					 "got %d ", WEXITSTATUS(status));
 				fail = 1;
 			}
 		}
@@ -262,16 +105,16 @@ static void do_child_1(void)
 			}
 		}
 		if (!found) {
-			tst_resm(TFAIL,
+			tst_res(TFAIL,
 				 "Did not find a wait_kid_pid "
 				 "for the fork_kid_pid of %d", wait_kid_pid[i]);
 			for (k = 0; k < MAXKIDS; k++) {
-				tst_resm(TFAIL,
+				tst_res(TFAIL,
 					 "fork_kid_pid[%d] = "
 					 "%d", k, fork_kid_pid[k]);
 			}
 			for (k = 0; k < kid_count; k++) {
-				tst_resm(TFAIL,
+				tst_res(TFAIL,
 					 "wait_kid_pid[%d] = "
 					 "%d", k, wait_kid_pid[k]);
 			}
@@ -285,57 +128,27 @@ static void do_child_1(void)
 	 */
 	ret_val = waitpid(-1, &status, WUNTRACED);
 	if (ret_val != -1) {
-		tst_resm(TFAIL, "Waitpid returned wrong value.");
-		tst_resm(TFAIL, "Expected -1 got %d from "
+		tst_res(TFAIL, "Waitpid returned wrong value.");
+		tst_res(TFAIL, "Expected -1 got %d from "
 			 "waitpid(WUNTRACED)", ret_val);
 		fail = 1;
 	}
 
 	if (errno != ECHILD) {
-		tst_resm(TFAIL, "Waitpid returned wrong errno.");
-		tst_resm(TFAIL, "Expected ECHILD got %d", errno);
+		tst_res(TFAIL, "Waitpid returned wrong errno.");
+		tst_res(TFAIL, "Expected ECHILD got %d", errno);
 		fail = 1;
 	}
 
-	exit(fail);
-}
+	memset(fork_kid_pid, 0, sizeof(*fork_kid_pid) * MAXKIDS);
 
-#ifdef UCLINUX
-/*
- * do_child_2_uclinux()
- *	sets up sigint handler again, then calls the normal child 2 function
- */
-static void do_child_2_uclinux(void)
-{
-	setup_sigint();
-	do_exit();
-}
-#endif
-
-static void setup(void)
-{
-	TEST_PAUSE;
-}
-
-static void cleanup(void)
-{
-}
-
-static void inthandlr(void)
-{
-	intintr++;
-}
-
-static void wait_for_parent(void)
-{
-	int testvar;
-
-	while (!intintr)
-		testvar = 0;
+	exit(fail);
 }
 
-static void do_exit(void)
-{
-	wait_for_parent();
-	exit(3);
-}
+static struct tst_test test = {
+	.tid = "waitpid08",
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+	.cleanup = cleanup,
+	.test_all = waitpid_test,
+};
-- 
1.7.1

