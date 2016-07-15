From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 15 Jul 2016 17:39:45 +0300
Subject: [LTP] [PATCH 4/8] waitpid09: use the new API
In-Reply-To: <1468593589-30545-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1468593589-30545-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1468593589-30545-5-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/syscalls/waitpid/waitpid09.c |  375 +++++++++----------------
 1 files changed, 140 insertions(+), 235 deletions(-)

diff --git a/testcases/kernel/syscalls/waitpid/waitpid09.c b/testcases/kernel/syscalls/waitpid/waitpid09.c
index 1339c82..fad3810 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid09.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid09.c
@@ -1,26 +1,26 @@
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
- *	waitpid09.c
- *
  * DESCRIPTION
  *	Check ability of parent to wait until child returns, and that the
  *	child's process id is returned through the waitpid. Check that
@@ -36,22 +36,6 @@
  *		Parent calls a waitpid with no children waiting. Waitpid
  *		should return a -1 since there are no children to wait for.
  *
- * USAGE:  <for command-line>
- *      waitpid09 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
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
 
 #define _GNU_SOURCE 1
@@ -60,243 +44,164 @@
 #include <errno.h>
 #include <sys/wait.h>
 #include <stdlib.h>
+#include "tst_test.h"
 
-#include "test.h"
+static pid_t pid;
 
-char *TCID = "waitpid09";
-int TST_TOTAL = 1;
-volatile int intintr;
-
-static void setup(void);
-static void cleanup(void);
-static void inthandlr();
 static void do_exit(void);
-static void setup_sigint(void);
-#ifdef UCLINUX
-static void do_exit_uclinux(void);
-#endif
 
-int main(int argc, char **argv)
+static void cleanup(void)
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
-
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
-
-				/*
-				 *Check that waitpid with WNOHANG returns zero
-				 */
-				while (((ret = waitpid(pid, &status, WNOHANG))
-					!= 0) || (errno == EINTR)) {
-					if (ret == -1)
-						continue;
-
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
-
-				/* send SIGINT to child to tell it to proceed */
-				if (kill(pid, SIGINT) < 0) {
-					tst_resm(TFAIL, "Kill of child failed, "
-						 "errno = %d", errno);
-					fail = 1;
-				}
-
-				while (((ret = waitpid(pid, &status, 0)) != -1)
-				       || (errno == EINTR)) {
-					if (ret == -1)
-						continue;
-
-					if (ret != pid) {
-						tst_resm(TFAIL, "Expected %d "
-							 "got %d as proc id of "
-							 "child", pid, ret);
-						fail = 1;
-					}
-
-					if (status != 0) {
-						tst_resm(TFAIL, "status value "
-							 "got %d expected 0",
-							 status);
-						fail = 1;
-					}
-				}
-			}
+	if (pid > 0) {
+		kill(pid, SIGKILL);
+		waitpid(pid, NULL, 0);
+	}
+}
 
-			pid = FORK_OR_VFORK();
-			if (pid < 0) {
-				tst_brkm(TFAIL, cleanup, "Second fork failed.");
-			} else if (pid == 0) {	/* child */
-				exit(0);
-			} else {	/* parent */
-				/* Give the child time to startup and exit */
-				sleep(2);
+static void case0(void)
+{
+	pid_t ret;
+	int status;
+	int fail = 0;
+
+	pid = SAFE_FORK();
+	if (pid == 0)
+		do_exit();
+
+	/*
+	 *Check that waitpid with WNOHANG returns zero
+	 */
+	while (((ret = waitpid(pid, &status, WNOHANG))
+		!= 0) || (errno == EINTR)) {
+		if (ret == -1)
+			continue;
+
+		tst_res(TFAIL, "return value for "
+			 "WNOHANG expected 0 got %d",
+			 ret);
+		fail = 1;
+	}
 
-				while (((ret = waitpid(pid, &status, WNOHANG))
-					!= -1) || (errno == EINTR)) {
-					if (ret == -1)
-						continue;
+	TST_CHECKPOINT_WAKE(0);
 
-					if (ret != pid) {
-						tst_resm(TFAIL, "proc id %d "
-							 "and retval %d do not "
-							 "match", pid, ret);
-						fail = 1;
-					}
+	while (((ret = waitpid(pid, &status, 0)) != -1)
+	       || (errno == EINTR)) {
+		if (ret == -1)
+			continue;
 
-					if (status != 0) {
-						tst_resm(TFAIL, "non zero "
-							 "status received %d",
-							 status);
-						fail = 1;
-					}
-				}
-			}
+		if (ret != pid) {
+			tst_res(TFAIL, "Expected %d "
+				 "got %d as proc id of "
+				 "child", pid, ret);
+			fail = 1;
+		}
 
-			if (fail)
-				tst_resm(TFAIL, "case 1 FAILED");
-			else
-				tst_resm(TPASS, "case 1 PASSED");
+		if (status != 0) {
+			tst_res(TFAIL, "status value "
+				 "got %d expected 0",
+				 status);
+			fail = 1;
+		}
+	}
 
-			fail = 0;
-			ret = waitpid(pid, &status, 0);
+	pid = 0;
 
-			if (ret != -1) {
-				tst_resm(TFAIL, "Expected -1 got %d", ret);
-				fail = 1;
-			}
-			if (errno != ECHILD) {
-				tst_resm(TFAIL, "Expected ECHILD got %d",
-					 errno);
-				fail = 1;
-			}
+	pid = SAFE_FORK();
+	if (pid == 0)
+		exit(0);
 
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
+	while (((ret = waitpid(pid, &status, WNOHANG))
+		!= -1) || (errno == EINTR)) {
+		if (ret == -1)
+			continue;
+		if (ret == 0)
+			continue;
 
-			if (fail)
-				tst_resm(TFAIL, "case 2 FAILED");
-			else
-				tst_resm(TPASS, "case 2 PASSED");
+		if (ret != pid) {
+			tst_res(TFAIL, "proc id %d "
+				 "and retval %d do not "
+				 "match", pid, ret);
+			fail = 1;
 		}
 
-		cleanup();
-	} else {
-		/* wait for the child to return */
-		waitpid(pid, &status, 0);
-		if (WEXITSTATUS(status) != 0) {
-			tst_brkm(TBROK, cleanup, "child returned bad "
-				 "status");
+		if (status != 0) {
+			tst_res(TFAIL, "non zero "
+				 "status received %d",
+				 status);
+			fail = 1;
 		}
 	}
 
-	tst_exit();
+	pid = 0;
+
+	if (fail)
+		tst_res(TFAIL, "case 0 FAILED");
+	else
+		tst_res(TPASS, "case 0 PASSED");
 }
 
-/*
- * setup_sigint()
- *	sets up a SIGINT handler
- */
-static void setup_sigint(void)
+static void case1(void)
 {
-	if ((sig_t) signal(SIGINT, inthandlr) == SIG_ERR) {
-		tst_brkm(TFAIL, cleanup, "signal SIGINT failed, errno = %d",
+	pid_t ret;
+	int status;
+	int fail = 0;
+
+	ret = waitpid(-1, &status, 0);
+
+	if (ret != -1) {
+		tst_res(TFAIL, "Expected -1 got %d", ret);
+		fail = 1;
+	}
+	if (errno != ECHILD) {
+		tst_res(TFAIL, "Expected ECHILD got %d",
 			 errno);
+		fail = 1;
 	}
-}
-
-static void setup(void)
-{
-	TEST_PAUSE;
-}
 
-static void cleanup(void)
-{
-}
+	ret = waitpid(-1, &status, WNOHANG);
+	if (ret != -1) {
+		tst_res(TFAIL, "WNOHANG: Expected -1 got %d",
+			 ret);
+		fail = 1;
+	}
+	if (errno != ECHILD) {
+		tst_res(TFAIL, "WNOHANG: Expected ECHILD got "
+			 "%d", errno);
+		fail = 1;
+	}
 
-static void inthandlr(void)
-{
-	intintr++;
+	if (fail)
+		tst_res(TFAIL, "case 1 FAILED");
+	else
+		tst_res(TPASS, "case 1 PASSED");
 }
 
-static void wait_for_parent(void)
+static void waitpid09_test(unsigned int id)
 {
-	int testvar;
-	while (!intintr)
-		testvar = 0;
+	switch (id) {
+	case 0:
+		case0();
+		break;
+	case 1:
+		case1();
+		break;
+	default:
+		tst_brk(TBROK, "Unknown %d", id);
+	}
 }
 
 static void do_exit(void)
 {
-	wait_for_parent();
+	TST_CHECKPOINT_WAIT(0);
+
 	exit(0);
 }
 
-#ifdef UCLINUX
-/*
- * do_exit_uclinux()
- *	Sets up SIGINT handler again, then calls do_exit
- */
-static void do_exit_uclinux(void)
-{
-	setup_sigint();
-	do_exit();
-}
-#endif
+static struct tst_test test = {
+	.tid = "waitpid09",
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+	.cleanup = cleanup,
+	.test = waitpid09_test,
+	.tcnt = 2,
+};
-- 
1.7.1

