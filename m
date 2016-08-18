From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 18 Aug 2016 10:40:38 +0300
Subject: [LTP] [PATCH 1/8 V2] waitpid09: use the new API
In-Reply-To: <20160815135523.GE20680@rei.lan>
References: <20160815135523.GE20680@rei.lan>
Message-ID: <1471506038-14128-1-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
Changes since V1:
 * remove code from case0() which is duplicated in case1()
 * rewrite the tst_res(TPASS) messages
 * use function pointers instead of the switch-case structure

 testcases/kernel/syscalls/waitpid/waitpid09.c |  374 ++++++++----------------
 1 files changed, 125 insertions(+), 249 deletions(-)

diff --git a/testcases/kernel/syscalls/waitpid/waitpid09.c b/testcases/kernel/syscalls/waitpid/waitpid09.c
index 1339c82..43beeff 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid09.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid09.c
@@ -1,57 +1,37 @@
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
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-/*
- * NAME
- *	waitpid09.c
- *
- * DESCRIPTION
- *	Check ability of parent to wait until child returns, and that the
- *	child's process id is returned through the waitpid. Check that
- *	waitpid returns immediately if no child is present.
- *
- * ALGORITHM
- *	case 0:
- *		Parent forks a child and waits. Parent should do nothing
- *		further until child returns. The pid of the forked child
- *		should match the returned value from the waitpid.
- *
- *	case 1:
- *		Parent calls a waitpid with no children waiting. Waitpid
- *		should return a -1 since there are no children to wait for.
- *
- * USAGE:  <for command-line>
- *      waitpid09 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *      where,  -c n : Run n copies concurrently.
- *              -e   : Turn on errno logging.
- *              -i n : Execute test n times.
- *              -I x : Execute test for x seconds.
- *              -P x : Pause for x seconds between iterations.
- *              -t   : Turn on syscall timing.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.
  *
  * History
  *	07/2001 John George
  *		-Ported
  *      04/2002 wjhuie sigset cleanups
- *
- * Restrictions
- *	None
+ */
+
+/*
+ * case 0:
+ *        waitpid(pid, WNOHANG) should return 0 if there is a running child
+ * case 1:
+ *        waitpid(pid, WNOHANG) should return the pid of the child if
+ *        the child has exited
+ * case 2:
+ *        waitpid(-1, 0) should return -1 with ECHILD if
+ *        there are no children to wait for.
+ * case 3:
+ *        waitpid(-1, WNOHANG) should return -1 with ECHILD if
+ *        there are no children to wait for.
  */
 
 #define _GNU_SOURCE 1
@@ -60,243 +40,139 @@
 #include <errno.h>
 #include <sys/wait.h>
 #include <stdlib.h>
+#include "tst_test.h"
 
-#include "test.h"
-
-char *TCID = "waitpid09";
-int TST_TOTAL = 1;
-volatile int intintr;
-
-static void setup(void);
-static void cleanup(void);
-static void inthandlr();
-static void do_exit(void);
-static void setup_sigint(void);
-#ifdef UCLINUX
-static void do_exit_uclinux(void);
-#endif
-
-int main(int argc, char **argv)
+static void cleanup_pid(pid_t pid)
 {
-	int lc;
-
-	int fail, pid, status, ret;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-#ifdef UCLINUX
-	maybe_run_child(&do_exit_uclinux, "");
-#endif
-
-	setup();
-
-	pid = FORK_OR_VFORK();
-	if (pid < 0) {
-		tst_brkm(TFAIL, cleanup, "Fork Failed");
-	} else if (pid == 0) {
-		/*
-		 * Child:
-		 * Set up to catch SIGINT.  The kids will wait till a
-		 * SIGINT has been received before they proceed.
-		 */
-		setup_sigint();
-
-		/* check for looping state if -i option is given */
-		for (lc = 0; TEST_LOOPING(lc); lc++) {
-			/* reset tst_count in case we are looping */
-			tst_count = 0;
-
-			intintr = 0;
+	if (pid > 0) {
+		kill(pid, SIGKILL);
+		waitpid(pid, NULL, 0);
+	}
+}
 
-			fail = 0;
-			pid = FORK_OR_VFORK();
-			if (pid < 0) {
-				tst_brkm(TFAIL, cleanup, "Fork failed.");
-			} else if (pid == 0) {	/* child */
-#ifdef UCLINUX
-				if (self_exec(argv[0], "") < 0) {
-					tst_brkm(TFAIL, cleanup,
-						 "self_exec failed");
-				}
-#else
-				do_exit();
-#endif
-			} else {	/* parent */
+static void case0(void)
+{
+	pid_t pid, ret;
+	int status;
 
-				/*
-				 *Check that waitpid with WNOHANG returns zero
-				 */
-				while (((ret = waitpid(pid, &status, WNOHANG))
-					!= 0) || (errno == EINTR)) {
-					if (ret == -1)
-						continue;
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		TST_CHECKPOINT_WAIT(0);
 
-					tst_resm(TFAIL, "return value for "
-						 "WNOHANG expected 0 got %d",
-						 ret);
-					fail = 1;
-				}
-#ifdef UCLINUX
-				/* Give the kids a chance to setup SIGINT again, since
-				 * this is cleared by exec().
-				 */
-				sleep(3);
-#endif
+		exit(0);
+	}
 
-				/* send SIGINT to child to tell it to proceed */
-				if (kill(pid, SIGINT) < 0) {
-					tst_resm(TFAIL, "Kill of child failed, "
-						 "errno = %d", errno);
-					fail = 1;
-				}
+	for (;;) {
+		ret = waitpid(pid, &status, WNOHANG);
 
-				while (((ret = waitpid(pid, &status, 0)) != -1)
-				       || (errno == EINTR)) {
-					if (ret == -1)
-						continue;
+		if ((ret == -1) && (errno == EINTR))
+			continue;
 
-					if (ret != pid) {
-						tst_resm(TFAIL, "Expected %d "
-							 "got %d as proc id of "
-							 "child", pid, ret);
-						fail = 1;
-					}
+		if (ret == 0)
+			break;
 
-					if (status != 0) {
-						tst_resm(TFAIL, "status value "
-							 "got %d expected 0",
-							 status);
-						fail = 1;
-					}
-				}
-			}
+		tst_res(TFAIL, "waitpid(WNOHANG) returned %d, expected 0",
+			ret);
+		cleanup_pid(pid);
+		return;
+	}
 
-			pid = FORK_OR_VFORK();
-			if (pid < 0) {
-				tst_brkm(TFAIL, cleanup, "Second fork failed.");
-			} else if (pid == 0) {	/* child */
-				exit(0);
-			} else {	/* parent */
-				/* Give the child time to startup and exit */
-				sleep(2);
+	TST_CHECKPOINT_WAKE(0);
+	SAFE_WAITPID(pid, NULL, 0);
 
-				while (((ret = waitpid(pid, &status, WNOHANG))
-					!= -1) || (errno == EINTR)) {
-					if (ret == -1)
-						continue;
+	tst_res(TPASS, "waitpid(pid, WNOHANG) = 0 for a running child");
+}
 
-					if (ret != pid) {
-						tst_resm(TFAIL, "proc id %d "
-							 "and retval %d do not "
-							 "match", pid, ret);
-						fail = 1;
-					}
+static void case1(void)
+{
+	pid_t pid, ret;
+	int status;
 
-					if (status != 0) {
-						tst_resm(TFAIL, "non zero "
-							 "status received %d",
-							 status);
-						fail = 1;
-					}
-				}
-			}
+	pid = SAFE_FORK();
+	if (pid == 0)
+		exit(0);
 
-			if (fail)
-				tst_resm(TFAIL, "case 1 FAILED");
-			else
-				tst_resm(TPASS, "case 1 PASSED");
+	for (;;) {
+		ret = waitpid(pid, &status, WNOHANG);
 
-			fail = 0;
-			ret = waitpid(pid, &status, 0);
+		if ((ret == -1) && (errno == EINTR))
+			continue;
+		if (ret == 0)
+			continue;
 
-			if (ret != -1) {
-				tst_resm(TFAIL, "Expected -1 got %d", ret);
-				fail = 1;
-			}
-			if (errno != ECHILD) {
-				tst_resm(TFAIL, "Expected ECHILD got %d",
-					 errno);
-				fail = 1;
-			}
+		if (ret == pid)
+			break;
 
-			ret = waitpid(pid, &status, WNOHANG);
-			if (ret != -1) {
-				tst_resm(TFAIL, "WNOHANG: Expected -1 got %d",
-					 ret);
-				fail = 1;
-			}
-			if (errno != ECHILD) {
-				tst_resm(TFAIL, "WNOHANG: Expected ECHILD got "
-					 "%d", errno);
-				fail = 1;
-			}
+		tst_res(TFAIL, "waitpid(WNOHANG) returned %d, expected %d",
+			ret, pid);
+		cleanup_pid(pid);
+		return;
+	}
 
-			if (fail)
-				tst_resm(TFAIL, "case 2 FAILED");
-			else
-				tst_resm(TPASS, "case 2 PASSED");
-		}
+	if (!WIFEXITED(status)) {
+		tst_res(TFAIL, "Child exited abnormally");
+		return;
+	}
 
-		cleanup();
-	} else {
-		/* wait for the child to return */
-		waitpid(pid, &status, 0);
-		if (WEXITSTATUS(status) != 0) {
-			tst_brkm(TBROK, cleanup, "child returned bad "
-				 "status");
-		}
+	if (WEXITSTATUS(status) != 0) {
+		tst_res(TFAIL, "Child exited with %d, expected 0",
+			WEXITSTATUS(status));
+		return;
 	}
 
-	tst_exit();
+	tst_res(TPASS, "waitpid(pid, WNOHANG) = pid for an exited child");
 }
 
-/*
- * setup_sigint()
- *	sets up a SIGINT handler
- */
-static void setup_sigint(void)
+static void case2(void)
 {
-	if ((sig_t) signal(SIGINT, inthandlr) == SIG_ERR) {
-		tst_brkm(TFAIL, cleanup, "signal SIGINT failed, errno = %d",
-			 errno);
+	pid_t ret;
+	int status;
+
+	ret = waitpid(-1, &status, 0);
+
+	if (ret != -1) {
+		tst_res(TFAIL, "Expected -1, got %d", ret);
+		return;
+	}
+	if (errno != ECHILD) {
+		tst_res(TFAIL, "Expected %s, got %s",
+			tst_strerrno(ECHILD), tst_strerrno(errno));
+		return;
 	}
-}
 
-static void setup(void)
-{
-	TEST_PAUSE;
+	tst_res(TPASS, "waitpid(-1, 0) = -1 with ECHILD if no children");
 }
 
-static void cleanup(void)
+static void case3(void)
 {
-}
+	pid_t ret;
+	int status;
 
-static void inthandlr(void)
-{
-	intintr++;
-}
+	ret = waitpid(-1, &status, WNOHANG);
+	if (ret != -1) {
+		tst_res(TFAIL, "WNOHANG: Expected -1, got %d", ret);
+		return;
+	}
+	if (errno != ECHILD) {
+		tst_res(TFAIL, "WNOHANG: Expected %s, got %s",
+			tst_strerrno(ECHILD), tst_strerrno(errno));
+		return;
+	}
 
-static void wait_for_parent(void)
-{
-	int testvar;
-	while (!intintr)
-		testvar = 0;
+	tst_res(TPASS, "waitpid(-1, WNOHANG) = -1 with ECHILD if no children");
 }
 
-static void do_exit(void)
-{
-	wait_for_parent();
-	exit(0);
-}
+static void (*tests[])(void) = { case0, case1, case2, case3 };
 
-#ifdef UCLINUX
-/*
- * do_exit_uclinux()
- *	Sets up SIGINT handler again, then calls do_exit
- */
-static void do_exit_uclinux(void)
+static void waitpid09_test(unsigned int id)
 {
-	setup_sigint();
-	do_exit();
+	tests[id]();
 }
-#endif
+
+static struct tst_test test = {
+	.tid = "waitpid09",
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+	.test = waitpid09_test,
+	.tcnt = ARRAY_SIZE(tests),
+};
-- 
1.7.1

