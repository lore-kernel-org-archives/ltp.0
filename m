From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu,  7 Jul 2016 18:08:56 +0300
Subject: [LTP] [PATCH] waitpid06: use the new API
Message-ID: <1467904136-5136-1-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

 * Use the new LTP API
 * Use the checkpoint interface instead of wait_for_parent()
 * Drop UCLINUX support

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
Hi!

I'd like to update those waitpid* test cases utilizing wait_for_parent()
to use the checkpoint interface. It requires converting them for the
new LTP API. This, in turn, drops UCLINUX support. However, since nobody
has replied to:

http://lists.linux.it/pipermail/ltp/2016-May/001752.html

it (dropping UCLINUX) seems to be acceptable. Right?

This is a sample patch. If the approach is fine, I'll start updating
the rest of waitpid test cases.

Thanks!

 testcases/kernel/syscalls/waitpid/waitpid06.c |  245 +++++-------------------
 1 files changed, 51 insertions(+), 194 deletions(-)

diff --git a/testcases/kernel/syscalls/waitpid/waitpid06.c b/testcases/kernel/syscalls/waitpid/waitpid06.c
index dbbc104..da09fac 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid06.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid06.c
@@ -1,200 +1,84 @@
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
- *	waitpid06.c
- *
  * DESCRIPTION
- *	Tests to see if pid's returned from fork and waitpid are same.
+ *	Tests to see if pids returned from fork and waitpid are same.
  *
  * ALGORITHM
  *	Check proper functioning of waitpid with pid = -1 and arg = 0
- *
- * USAGE:  <for command-line>
- *      waitpid06 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
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
 
 #include <sys/types.h>
-#include <signal.h>
 #include <errno.h>
 #include <sys/wait.h>
-#include "test.h"
+#include <stdlib.h>
+#include "tst_test.h"
 
-static void setup_sigint(void);
 static void do_child_1(void);
-static void setup(void);
-static void cleanup(void);
-
-char *TCID = "waitpid06";
-int TST_TOTAL = 1;
-volatile int intintr;
-static void inthandlr();
-static void do_exit(void);
-static int flag;
+static void do_child_2(void);
 
 #define	FAILED	1
 #define	MAXKIDS	8
 
-#ifdef UCLINUX
-static char *argv0;
-static void do_child_2_uclinux(void);
-#endif
-
-int main(int argc, char **argv)
+static void waitpid_test(void)
 {
-	int lc;
-	int fail = 0;
-	int pid;
+	pid_t pid;
 	int status;
 
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
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		pid = FORK_OR_VFORK();
-		if (pid < 0) {
-			tst_resm(TINFO, "Fork Failed, may be OK under stress");
-			exit(pid);
-		} else if (pid == 0) {
-			/*
-			 * Child:
-			 * Set up to catch SIGINT.  The kids will wait till a
-			 * SIGINT has been received before they proceed.
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
-			fail = 0;
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
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		do_child_1();
+	} else {
+		SAFE_WAITPID(pid, &status, 0);
+		if (WEXITSTATUS(status) != 0)
+			tst_res(TFAIL, "Child returned bad status");
+		else
+			tst_res(TPASS, "Child returned good status");
 	}
 }
 
 static void do_child_1(void)
 {
 	int kid_count, fork_kid_pid[MAXKIDS];
-	int ret_val;
+	pid_t ret_val;
 	int i, j, k, found;
 	int group1, group2;
 	int wait_kid_pid[MAXKIDS], status;
-
-	setup_sigint();
+	int flag = 0;
 
 	group1 = getpgrp();
 	for (kid_count = 0; kid_count < MAXKIDS; kid_count++) {
 		if (kid_count == (MAXKIDS / 2))
 			group2 = setpgrp();
 
-		intintr = 0;
-		ret_val = FORK_OR_VFORK();
-		if (ret_val == 0) {	/* child */
-#ifdef UCLINUX
-			if (self_exec(argv0, "n", 2) < 0) {
-				tst_resm(TFAIL, "Fork kid %d failed. "
-					 "errno = %d", kid_count, errno);
-				exit(ret_val);
-			}
-#else
-			do_exit();
-#endif
-		} else if (ret_val < 0) {
-			tst_resm(TFAIL, "Fork kid %d failed. "
-				 "errno = %d", kid_count, errno);
-			exit(ret_val);
-		}
+		ret_val = SAFE_FORK();
+		if (ret_val == 0)
+			do_child_2();
 
-		/* parent */
 		fork_kid_pid[kid_count] = ret_val;
 	}
 
-#ifdef UCLINUX
-	/* Give the kids a chance to setup SIGINT again, since this is
-	 * cleared by exec().
-	 */
-	sleep(3);
-#endif
-
-	/* Now send all the kids a SIGINT to tell them to
-	 * proceed
-	 */
-	for (i = 0; i < MAXKIDS; i++) {
-		if (kill(fork_kid_pid[i], SIGINT) < 0) {
-			tst_resm(TFAIL, "Kill of child %d "
-				 "failed, errno = %d", i, errno);
-			exit(-1);
-		}
-	}
+	TST_CHECKPOINT_WAKE2(0, MAXKIDS);
 
 	/*
 	 * Wait till all kids have terminated.  Stash away their
@@ -207,16 +91,15 @@ static void do_child_1(void)
 			continue;
 
 		if (!WIFEXITED(status)) {
-			tst_resm(TFAIL, "Child %d did not exit "
+			tst_res(TFAIL, "Child %d did not exit "
 				 "normally", ret_val);
 			flag = FAILED;
-			printf("status: %d\n", status);
 		} else {
 			if (WEXITSTATUS(status) != 3) {
-				tst_resm(TFAIL, "Child %d"
+				tst_res(TFAIL, "Child %d "
 					 "exited with wrong "
 					 "status", ret_val);
-				tst_resm(TFAIL, "Expected 3 "
+				tst_res(TFAIL, "Expected 3 "
 					 "got %d ", WEXITSTATUS(status));
 				flag = FAILED;
 			}
@@ -239,16 +122,16 @@ static void do_child_1(void)
 		}
 
 		if (!found) {
-			tst_resm(TFAIL, "Did not find a "
+			tst_res(TFAIL, "Did not find a "
 				 "wait_kid_pid for the "
 				 "fork_kid_pid of %d", wait_kid_pid[i]);
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
@@ -262,42 +145,16 @@ static void do_child_1(void)
 		exit(0);
 }
 
-#ifdef UCLINUX
-/*
- * do_child_2_uclinux()
- *	sets up sigint handler again, then calls the normal child 2 function
- */
-static void do_child_2_uclinux(void)
+static void do_child_2(void)
 {
-	setup_sigint();
-	do_exit();
-}
-#endif
+	TST_CHECKPOINT_WAIT(0);
 
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
-}
-
-static void do_exit(void)
-{
-	wait_for_parent();
 	exit(3);
 }
+
+static struct tst_test test = {
+	.tid = "waitpid06",
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+	.test_all = waitpid_test,
+};
-- 
1.7.1

