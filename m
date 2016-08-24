From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed, 24 Aug 2016 15:27:56 +0300
Subject: [LTP] [PATCH V2 08/11] waitpid12: use the new API
In-Reply-To: <1472041679-29759-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1472041679-29759-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1472041679-29759-9-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
No changes since V1.

 testcases/kernel/syscalls/waitpid/waitpid12.c |  353 ++++---------------------
 1 files changed, 52 insertions(+), 301 deletions(-)

diff --git a/testcases/kernel/syscalls/waitpid/waitpid12.c b/testcases/kernel/syscalls/waitpid/waitpid12.c
index bf64662..b2db49d 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid12.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid12.c
@@ -1,329 +1,80 @@
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
- *	waitpid12.c
- *
- * DESCRIPTION
- *	Tests to see if pid's returned from fork and waitpid are same
- *
- * ALGORITHM
- *	Check proper functioning of waitpid with pid = -1 and arg = WNOHANG
- *
- * USAGE:  <for command-line>
- *      waitpid12 [-c n] [-t]
- *      where,  -c n : Run n copies concurrently.
- *              -t   : Turn on syscall timing.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.
  *
  * History
  *	07/2001 John George
  *		-Ported
  *      04/2002 wjhuie sigset testx for SIG_ERR not < 0, TPASS|TFAIL issued
  *      04/2002 wjhuie sigset cleanups
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
-#define	MAXKIDS	8
-
-char *TCID = "waitpid12";
-int TST_TOTAL = 1;
-
-volatile int intintr;
-static void setup(void);
-static void cleanup(void);
-static void inthandlr();
-static void wait_for_parent(void);
-static void do_exit(void);
-static void setup_sigint(void);
-#ifdef UCLINUX
-static void do_exit_uclinux(void);
-#endif
+/*
+ * DESCRIPTION
+ *	Tests to see if pids returned from fork and waitpid are same
+ *
+ * ALGORITHM
+ *	Check proper functioning of waitpid with pid = 0 and < -1 with arg
+ *	WNOHANG
+ */
 
-static int fail;
+#include "waitpid_common.h"
 
-int main(int argc, char **argv)
+static void do_child_1(void)
 {
-	int kid_count, ret_val, status;
-	int i, j, k, found;
-	int group1, group2;
-	int fork_kid_pid[MAXKIDS], wait_kid_pid[MAXKIDS];
-	int pid;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-#ifdef UCLINUX
-	maybe_run_child(&do_exit_uclinux, "");
-#endif
-
-	setup();
-
-	tst_count = 0;
-	fail = 0;
-
-	/*
-	 * Need to have test run from child as test driver causes
-	 * test to be a session leader and setpgrp fails.
-	 */
-
-	pid = FORK_OR_VFORK();
-	if (pid > 0) {
-		waitpid(pid, &status, 0);
-		if (WEXITSTATUS(status) != 0) {
-			tst_resm(TFAIL, "child returned bad status");
-			fail = 1;
-		}
-		if (fail)
-			tst_resm(TFAIL, "%s FAILED", TCID);
-		else
-			tst_resm(TPASS, "%s PASSED", TCID);
-		cleanup();
-		tst_exit();
-	} else if (pid < 0) {
-		tst_brkm(TBROK, cleanup, "fork failed");
-	}
-
-	/*
-	 * Set up to catch SIGINT.  The kids will wait till a SIGINT
-	 * has been received before they proceed.
-	 */
-	setup_sigint();
-
-	group1 = getpgrp();
-
-	for (kid_count = 0; kid_count < MAXKIDS; kid_count++) {
-		if (kid_count == (MAXKIDS / 2))
-			group2 = setpgrp();
-
-		intintr = 0;
-		ret_val = FORK_OR_VFORK();
-		if (ret_val == 0) {
-#ifdef UCLINUX
-			if (self_exec(argv[0], "") < 0)
-				tst_resm(TFAIL, "self_exec kid %d "
-					 "failed", kid_count);
-#else
-			do_exit();
-#endif
-		}
-
-		if (ret_val < 0)
-			tst_resm(TFAIL | TERRNO, "forking kid %d failed",
-				 kid_count);
-
-		/* parent */
-		fork_kid_pid[kid_count] = ret_val;
-	}
-
-	/* Check that waitpid with WNOHANG returns zero */
-	ret_val = waitpid(0, &status, WNOHANG);
-	if (ret_val != 0) {
-		tst_resm(TFAIL, "Waitpid returned wrong value");
-		tst_resm(TFAIL, "Expected 0 got %d", ret_val);
-		fail = 1;
-	}
-#ifdef UCLINUX
-	/* Give the kids a chance to setup SIGINT again, since this is
-	 * cleared by exec().
-	 */
-	sleep(3);
-#endif
-
-	/* Now send all the kids a SIGINT to tell them to proceed */
-	for (i = 0; i < MAXKIDS; i++)
-		if (kill(fork_kid_pid[i], SIGINT) < 0)
-			tst_resm(TFAIL | TERRNO, "killing child %d failed", i);
-
-	/*
-	 * Wait till all kids have terminated.  Stash away their
-	 * pid's in an array.
-	 */
-	kid_count = 0;
-	errno = 0;
-	sleep(2);
-	while (((ret_val = waitpid(0, &status, WNOHANG)) != -1) ||
-	       (errno == EINTR)) {
-		if ((ret_val == -1) || (ret_val == 0))
-			continue;
-
-		if (!WIFEXITED(status)) {
-			tst_resm(TFAIL, "Child %d did not exit "
-				 "normally", ret_val);
-			fail = 1;
-		} else {
-			if (WEXITSTATUS(status) != 3) {
-				tst_resm(TFAIL, "Child %d exited with "
-					 "wrong status", ret_val);
-				tst_resm(TFAIL, "Expected 3 got %d",
-					 WEXITSTATUS(status));
-				fail = 1;
-			}
-		}
-		wait_kid_pid[kid_count++] = ret_val;
-	}
-
-	/*
-	 * Check that for every entry in the fork_kid_pid array,
-	 * there is a matching pid in the wait_kid_pid array.  If
-	 * not, it's an error.
-	 */
-	for (i = 0; i < kid_count; i++) {
-		found = 0;
-		for (j = (MAXKIDS / 2); j < MAXKIDS; j++) {
-			if (fork_kid_pid[j] == wait_kid_pid[i]) {
-				found = 1;
-				break;
-			}
-		}
-		if (!found) {
-			tst_resm(TFAIL, "Did not find a wait_kid_pid "
-				 "for the fork_kid_pid of %d", wait_kid_pid[i]);
-			for (k = 0; k < MAXKIDS; k++)
-				tst_resm(TFAIL, "fork_kid_pid[%d] = "
-					 "%d", k, fork_kid_pid[k]);
-			for (k = 0; k < kid_count; k++)
-				tst_resm(TFAIL, "wait_kid_pid[%d] = "
-					 "%d", k, wait_kid_pid[k]);
-			fail = 1;
-		}
-	}
+	pid_t pid, group;
+	int i;
+	int status;
 
-	if (kid_count != (MAXKIDS / 2)) {
-		tst_resm(TFAIL, "Wrong number of children waited on "
-			 "for pid = 0");
-		tst_resm(TFAIL, "Expected 4 got %d", kid_count);
-		fail = 1;
-	}
+	group = SAFE_GETPGID(0);
 
-	/* Make sure can pickup children in a diff. process group */
+	for (i = 0; i < MAXKIDS; i++) {
+		if (i == (MAXKIDS / 2))
+			SAFE_SETPGID(0, 0);
 
-	kid_count = 0;
-	errno = 0;
-	while (((ret_val = waitpid(-(group1), &status, WNOHANG)) !=
-		-1) || (errno == EINTR)) {
-		if (ret_val == -1 || ret_val == 0)
-			continue;
+		pid = SAFE_FORK();
+		if (pid == 0)
+			do_exit(0);
 
-		if (!WIFEXITED(status)) {
-			tst_resm(TFAIL, "Child %d did not exit "
-				 "normally", ret_val);
-			fail = 1;
-		} else {
-			if (WEXITSTATUS(status) != 3) {
-				tst_resm(TFAIL, "Child %d exited with "
-					 "wrong status", ret_val);
-				tst_resm(TFAIL, "Expected 3 got %d",
-					 WEXITSTATUS(status));
-				fail = 1;
-			}
-		}
-		wait_kid_pid[kid_count++] = ret_val;
+		fork_kid_pid[i] = pid;
 	}
 
-	/*
-	 * Check that for every entry in the fork_kid_pid array,
-	 * there is a matching pid in the wait_kid_pid array.  If
-	 * not, it's an error.
-	 */
-	for (i = 0; i < kid_count; i++) {
-		found = 0;
-		for (j = 0; j < (MAXKIDS / 2); j++) {
-			if (fork_kid_pid[j] == wait_kid_pid[i]) {
-				found = 1;
-				break;
-			}
-		}
-		if (!found) {
-			tst_resm(TFAIL, "Did not find a wait_kid_pid "
-				 "for the fork_kid_pid of %d", fork_kid_pid[j]);
-			for (k = 0; k < MAXKIDS; k++)
-				tst_resm(TFAIL, "fork_kid_pid[%d] = "
-					 "%d", k, fork_kid_pid[k]);
-			for (k = 0; k < kid_count; k++)
-				tst_resm(TFAIL, "wait_kid_pid[%d] = "
-					 "%d", k, wait_kid_pid[k]);
-			fail = 1;
-		}
-	}
-	if (kid_count != (MAXKIDS / 2)) {
-		tst_resm(TFAIL, "Wrong number of children waited on "
-			 "for pid = 0");
-		tst_resm(TFAIL, "Expected 4 got %d", kid_count);
-		fail = 1;
-	}
+	if (TST_TRACE(waitpid_ret_test(0, &status, WNOHANG, 0, 0)))
+		return;
 
-	if (fail)
-		tst_resm(TFAIL, "Test FAILED");
-	else
-		tst_resm(TPASS, "Test PASSED");
+	if (TST_TRACE(waitpid_ret_test(-group, &status, WNOHANG, 0, 0)))
+		return;
 
-	tst_exit();
-}
+	TST_CHECKPOINT_WAKE2(0, MAXKIDS);
 
-static void setup_sigint(void)
-{
-	if (signal(SIGINT, inthandlr) == SIG_ERR)
-		tst_brkm(TFAIL | TERRNO, NULL, "signal SIGINT failed");
-}
+	if (TST_TRACE(reap_children(0, WNOHANG, fork_kid_pid + (MAXKIDS / 2),
+				    MAXKIDS / 2)))
+		return;
 
-static void setup(void)
-{
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	if (TST_TRACE(reap_children(-group, WNOHANG, fork_kid_pid,
+				    MAXKIDS / 2)))
+		return;
 
-	TEST_PAUSE;
+	tst_res(TPASS, "Test PASSED");
 }
 
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
-	exit(3);
-}
-
-#ifdef UCLINUX
-static void do_exit_uclinux(void)
-{
-	setup_sigint();
-	do_exit();
-}
-#endif
+static struct tst_test test = {
+	.tid = "waitpid12",
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+	.setup = waitpid_setup,
+	.cleanup = waitpid_cleanup,
+	.test_all = waitpid_test,
+};
-- 
1.7.1

