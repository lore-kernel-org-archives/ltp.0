From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed, 10 Aug 2016 11:41:05 +0300
Subject: [LTP] [PATCH 7/8] waitpid13: use the new API
In-Reply-To: <1470818466-28109-7-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1470818466-28109-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-2-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-3-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-4-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-5-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-6-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-7-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1470818466-28109-8-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/syscalls/waitpid/waitpid13.c      |  398 +++-----------------
 testcases/kernel/syscalls/waitpid/waitpid_common.h |   17 +
 2 files changed, 64 insertions(+), 351 deletions(-)

diff --git a/testcases/kernel/syscalls/waitpid/waitpid13.c b/testcases/kernel/syscalls/waitpid/waitpid13.c
index 5f03592..b6b22b8 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid13.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid13.c
@@ -1,382 +1,78 @@
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
- *	waitpid13.c
- *
  * DESCRIPTION
- *	Tests to see if pid's returned from fork and waitpid are same
+ *	Tests to see if pids returned from fork and waitpid are same
  *
  * ALGORITHM
  *	Check proper functioning of waitpid with pid = 0 and < -1 with arg
  *	WUNTRACED
- *
- * USAGE:  <for command-line>
- *      waitpid13 [-c n] [-t]
- *      where,  -c n : Run n copies concurrently.
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
-#define	MAXKIDS	8
-
-char *TCID = "waitpid13";
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
-
-static int fail;
+#include "waitpid_common.h"
 
-int main(int ac, char **av)
+static void do_child_1(void)
 {
-	int kid_count, ret_val, status;
-	int i, j, k, found;
-	int group1, group2;
-	int fork_kid_pid[MAXKIDS], wait_kid_pid[MAXKIDS];
-	int pid;
+	pid_t pid, group;
+	int i;
+	int status;
 
-	tst_parse_opts(ac, av, NULL, NULL);
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
-
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
-			if (self_exec(av[0], "") < 0) {
-				tst_resm(TFAIL | TERRNO, "self_exec kid %d "
-					 "failed", kid_count);
-
-			}
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
-	/* Check that waitpid with WNOHANG|WUNTRACED returns zero */
-	ret_val = waitpid(0, &status, WNOHANG | WUNTRACED);
-	if (ret_val != 0) {
-		tst_resm(TFAIL, "Waitpid returned wrong value"
-			 "from waitpid(WNOHANG|WUNTRACED)");
-		tst_resm(TFAIL, "Expected 0 got %d", ret_val);
-		fail = 1;
-	}
-#ifdef UCLINUX
-	/* Give the kids a chance to setup SIGINT again, since this is
-	 * cleared by exec().
-	 */
-	sleep(3);
-#endif
+	group = SAFE_GETPGID(0);
 
-	/* Now send all the kids a SIGINT to tell them to proceed */
 	for (i = 0; i < MAXKIDS; i++) {
-		if (kill(fork_kid_pid[i], SIGINT) < 0) {
-			tst_resm(TFAIL | TERRNO, "killing child %d failed", i);
-			fail = 1;
-		}
-	}
-
-	/*
-	 * Wait till all kids have terminated.  Stash away their
-	 * pid's in an array.
-	 */
-	kid_count = 0;
-	errno = 0;
-	while (((ret_val = waitpid(0, &status, WUNTRACED)) != -1) ||
-	       (errno == EINTR)) {
-		if (ret_val == -1)
-			continue;
-
-		if (!WIFEXITED(status)) {
-			if (!WIFSTOPPED(status)) {
-				tst_resm(TFAIL, "Child %d is not "
-					 "stopped", ret_val);
-				fail = 1;
-			} else {
-				if (WSTOPSIG(status) != SIGSTOP) {
-					tst_resm(TFAIL, "Child %d "
-						 "exited with wrong "
-						 "status", ret_val);
-					tst_resm(TFAIL, "Expected "
-						 "SIGSTOP got %d",
-						 WEXITSTATUS(status));
-					fail = 1;
-				}
-			}
-			if (kill(ret_val, SIGCONT) < 0) {
-				tst_resm(TFAIL | TERRNO,
-					 "killing child %d failed", ret_val);
-				fail = 1;
-			}
-		}
-		found = 0;
-		for (j = 0; j < kid_count; j++) {
-			if (ret_val == wait_kid_pid[j]) {
-				found = 1;
-				break;
-			}
-		}
-		if (!found)
-			wait_kid_pid[kid_count++] = ret_val;
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
-
-	if (kid_count != (MAXKIDS / 2)) {
-		tst_resm(TFAIL, "Wrong number of children waited on "
-			 "for pid = 0");
-		tst_resm(TFAIL, "Expected %d got %d", MAXKIDS, kid_count);
-		fail = 1;
-	}
+		if (i == (MAXKIDS / 2))
+			SAFE_SETPGID(0, 0);
 
-	/* Make sure can pickup children in a diff. process group */
+		pid = SAFE_FORK();
+		if (pid == 0)
+			do_exit(1);
 
-	kid_count = 0;
-	errno = 0;
-	while (((ret_val = waitpid(-(group1), &status, WUNTRACED)) !=
-		-1) || (errno == EINTR)) {
-		if (ret_val == -1)
-			continue;
-		if (!WIFEXITED(status)) {
-			if (!WIFSTOPPED(status)) {
-				tst_resm(TFAIL, "Child %d is not "
-					 "stopped", ret_val);
-				fail = 1;
-			} else {
-				if (WSTOPSIG(status) != SIGSTOP) {
-					tst_resm(TFAIL, "Child %d "
-						 "exited with wrong "
-						 "status", ret_val);
-					tst_resm(TFAIL, "Expected "
-						 "SIGSTOP got %d",
-						 WEXITSTATUS(status));
-					fail = 1;
-				}
-			}
-			if (kill(ret_val, SIGCONT) < 0) {
-				tst_resm(TFAIL | TERRNO,
-					 "Killing child %d failed", ret_val);
-				fail = 1;
-			}
-		}
-		found = 0;
-		for (j = 0; j < kid_count; j++) {
-			if (ret_val == wait_kid_pid[j]) {
-				found = 1;
-				break;
-			}
-		}
-		if (!found)
-			wait_kid_pid[kid_count++] = ret_val;
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
-		tst_resm(TFAIL, "Expected %d got %d", MAXKIDS, kid_count);
-		fail = 1;
-	}
-
-	/*
-	 * Check that waitpid(WUNTRACED) returns -1 when no stopped
-	 * children
-	 */
-	ret_val = waitpid(-1, &status, WUNTRACED);
-	if (ret_val != -1) {
-		tst_resm(TFAIL, "Waitpid returned wrong value.");
-		tst_resm(TFAIL, "Expected -1 got %d", ret_val);
-		fail = 1;
-	}
-
-	if (errno != ECHILD) {
-		tst_resm(TFAIL, "Expected ECHILD from waitpid(WUNTRACED)");
-		fail = 1;
-	}
-
-	if (fail)
-		tst_resm(TFAIL, "Test FAILED");
-	else
-		tst_resm(TPASS, "Test PASSED");
-
-	tst_exit();
-}
-
-static void setup_sigint(void)
-{
-	if (signal(SIGINT, inthandlr) == SIG_ERR)
-		tst_brkm(TFAIL | TERRNO, NULL, "signal SIGINT failed");
-}
+	if (waitpid_ret_test(0, &status, WNOHANG | WUNTRACED, 0, 0))
+		return;
 
-static void setup(void)
-{
-	TEST_PAUSE;
-}
-
-static void cleanup(void)
-{
-}
+	if (waitpid_ret_test(-group, &status, WNOHANG | WUNTRACED, 0, 0))
+		return;
 
-static void inthandlr(void)
-{
-	intintr++;
-}
+	TST_CHECKPOINT_WAKE2(0, MAXKIDS);
 
-static void wait_for_parent(void)
-{
-	int testvar;
+	if (reap_children(0, WUNTRACED, fork_kid_pid + (MAXKIDS / 2),
+			  MAXKIDS / 2))
+		return;
 
-	while (!intintr)
-		testvar = 0;
-}
+	if (reap_children(-group, WUNTRACED, fork_kid_pid, MAXKIDS / 2))
+		return;
 
-static void do_exit(void)
-{
-	wait_for_parent();
-	kill(getpid(), SIGSTOP);
-	exit(3);
+	tst_res(TPASS, "Test PASSED");
 }
 
-#ifdef UCLINUX
-static void do_exit_uclinux(void)
-{
-	setup_sigint();
-	do_exit();
-}
-#endif
+static struct tst_test test = {
+	.tid = "waitpid13",
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+	.setup = waitpid_setup,
+	.cleanup = waitpid_cleanup,
+	.test_all = waitpid_test,
+};
diff --git a/testcases/kernel/syscalls/waitpid/waitpid_common.h b/testcases/kernel/syscalls/waitpid/waitpid_common.h
index a2eb508..b17190f 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid_common.h
+++ b/testcases/kernel/syscalls/waitpid/waitpid_common.h
@@ -131,6 +131,23 @@ static int reap_children(pid_t wp_pid, int wp_opts, pid_t *children, int len)
 			return -1;
 		}
 
+		if (WIFSTOPPED(status)) {
+			if (WSTOPSIG(status) != SIGSTOP) {
+				tst_res(TFAIL,
+					"Pid %d: expected SIGSTOP, got %d",
+					pid, WSTOPSIG(status));
+				return -1;
+			}
+
+			if (kill(pid, SIGCONT) < 0) {
+				tst_res(TFAIL | TERRNO,
+					"kill(%d, SIGCONT) failed", pid);
+				return -1;
+			}
+
+			continue;
+		}
+
 		for (i = 0; i < len; i++) {
 			if (pid == children[i]) {
 				children[i] = 0;
-- 
1.7.1

