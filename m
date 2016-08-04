From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu,  4 Aug 2016 17:16:32 +0300
Subject: [LTP] [PATCH V3 3/6] waitpid06: use the new API
In-Reply-To: <1470320195-22145-2-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1470320195-22145-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470320195-22145-2-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1470320195-22145-3-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

 * Use the new LTP API
 * Use the checkpoint interface instead of wait_for_parent()
 * Drop UCLINUX support

Common items were moved to a header file.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
Changes since V2:
 * Use tst_reap_children() in waitpid_test()
 * Removed reduntant tst_res(TFAIL) next to reap_children()

 Changes since V1:
 * Rename cleanup() to waitpid_cleanup()
 * Kill child_1 pid in waitpid_cleanup()
 * Remove waitpid() calls from waitpid_cleanup()
 * Move mmap/unmap of fork_kid_pid to the setup
   and cleanup functions
 * Removed the 'fail = FAILED' logic
 * Created reap_children(). It calls waitpid() with necessary
   arguments and verifies that all the expected pids have
   terminated as they should

testcases/kernel/syscalls/waitpid/waitpid06.c      |  313 +++-----------------
 testcases/kernel/syscalls/waitpid/waitpid_common.h |  136 +++++++++
 2 files changed, 173 insertions(+), 276 deletions(-)
 create mode 100644 testcases/kernel/syscalls/waitpid/waitpid_common.h

diff --git a/testcases/kernel/syscalls/waitpid/waitpid06.c b/testcases/kernel/syscalls/waitpid/waitpid06.c
index dbbc104..66d5ebc 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid06.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid06.c
@@ -1,303 +1,64 @@
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
 
-#include <sys/types.h>
-#include <signal.h>
-#include <errno.h>
-#include <sys/wait.h>
-#include "test.h"
-
-static void setup_sigint(void);
-static void do_child_1(void);
-static void setup(void);
-static void cleanup(void);
-
-char *TCID = "waitpid06";
-int TST_TOTAL = 1;
-volatile int intintr;
-static void inthandlr();
-static void do_exit(void);
-static int flag;
-
-#define	FAILED	1
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
-	int fail = 0;
-	int pid;
-	int status;
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
-	}
-}
+#include "waitpid_common.h"
 
 static void do_child_1(void)
 {
-	int kid_count, fork_kid_pid[MAXKIDS];
-	int ret_val;
-	int i, j, k, found;
-	int group1, group2;
-	int wait_kid_pid[MAXKIDS], status;
-
-	setup_sigint();
-
-	group1 = getpgrp();
-	for (kid_count = 0; kid_count < MAXKIDS; kid_count++) {
-		if (kid_count == (MAXKIDS / 2))
-			group2 = setpgrp();
-
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
-
-		/* parent */
-		fork_kid_pid[kid_count] = ret_val;
-	}
-
-#ifdef UCLINUX
-	/* Give the kids a chance to setup SIGINT again, since this is
-	 * cleared by exec().
-	 */
-	sleep(3);
-#endif
+	pid_t pid;
+	int i;
 
-	/* Now send all the kids a SIGINT to tell them to
-	 * proceed
-	 */
 	for (i = 0; i < MAXKIDS; i++) {
-		if (kill(fork_kid_pid[i], SIGINT) < 0) {
-			tst_resm(TFAIL, "Kill of child %d "
-				 "failed, errno = %d", i, errno);
-			exit(-1);
-		}
-	}
-
-	/*
-	 * Wait till all kids have terminated.  Stash away their
-	 * pid's in an array.
-	 */
-	kid_count = 0;
-	errno = 0;
-	while (((ret_val = waitpid(-1, &status, 0)) != -1) || (errno == EINTR)) {
-		if (ret_val == -1)
-			continue;
-
-		if (!WIFEXITED(status)) {
-			tst_resm(TFAIL, "Child %d did not exit "
-				 "normally", ret_val);
-			flag = FAILED;
-			printf("status: %d\n", status);
-		} else {
-			if (WEXITSTATUS(status) != 3) {
-				tst_resm(TFAIL, "Child %d"
-					 "exited with wrong "
-					 "status", ret_val);
-				tst_resm(TFAIL, "Expected 3 "
-					 "got %d ", WEXITSTATUS(status));
-				flag = FAILED;
-			}
-		}
-		wait_kid_pid[kid_count++] = ret_val;
-	}
+		if (i == (MAXKIDS / 2))
+			SAFE_SETPGID(0, 0);
 
-	/*
-	 * Check that for every entry in the fork_kid_pid array,
-	 * there is a matching pid in the wait_kid_pid array. If
-	 * not, it's an error.
-	 */
-	for (i = 0; i < kid_count; i++) {
-		found = 0;
-		for (j = 0; j < MAXKIDS; j++) {
-			if (fork_kid_pid[j] == wait_kid_pid[i]) {
-				found = 1;
-				break;
-			}
-		}
+		pid = SAFE_FORK();
+		if (pid == 0)
+			do_exit(0);
 
-		if (!found) {
-			tst_resm(TFAIL, "Did not find a "
-				 "wait_kid_pid for the "
-				 "fork_kid_pid of %d", wait_kid_pid[i]);
-			for (k = 0; k < MAXKIDS; k++) {
-				tst_resm(TFAIL,
-					 "fork_kid_pid[%d] = "
-					 "%d", k, fork_kid_pid[k]);
-			}
-			for (k = 0; k < kid_count; k++) {
-				tst_resm(TFAIL,
-					 "wait_kid_pid[%d] = "
-					 "%d", k, wait_kid_pid[k]);
-			}
-			flag = FAILED;
-		}
+		fork_kid_pid[i] = pid;
 	}
 
-	if (flag)
-		exit(1);
-	else
-		exit(0);
-}
-
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
+	TST_CHECKPOINT_WAKE2(0, MAXKIDS);
 
-static void cleanup(void)
-{
-}
+	if (reap_children(-1, 0, fork_kid_pid, MAXKIDS))
+		return;
 
-static void inthandlr(void)
-{
-	intintr++;
+	tst_res(TPASS, "Test PASSED");
 }
 
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
+static struct tst_test test = {
+	.tid = "waitpid06",
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+	.setup = waitpid_setup,
+	.cleanup = waitpid_cleanup,
+	.test_all = waitpid_test,
+};
diff --git a/testcases/kernel/syscalls/waitpid/waitpid_common.h b/testcases/kernel/syscalls/waitpid/waitpid_common.h
new file mode 100644
index 0000000..008577a
--- /dev/null
+++ b/testcases/kernel/syscalls/waitpid/waitpid_common.h
@@ -0,0 +1,136 @@
+/*
+ * Copyright (c) 2016 Linux Test Project
+ *
+ * Licensed under the GNU GPLv2 or later.
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.
+ */
+
+#ifndef WAITPID_COMMON_H__
+#define WAITPID_COMMON_H__
+
+#include <sys/types.h>
+#include <errno.h>
+#include <sys/wait.h>
+#include <stdlib.h>
+#include "tst_test.h"
+
+#define	MAXKIDS	8
+
+static pid_t *fork_kid_pid;
+static pid_t child_1_pid;
+
+static void do_child_1(void);
+
+static void waitpid_setup(void)
+{
+	fork_kid_pid = SAFE_MMAP(NULL, sizeof(*fork_kid_pid) * MAXKIDS,
+				 PROT_READ | PROT_WRITE,
+				 MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+}
+
+static void waitpid_cleanup(void)
+{
+	int i;
+
+	for (i = 0; i < MAXKIDS; i++) {
+		if (fork_kid_pid[i] > 0)
+			kill(fork_kid_pid[i], SIGKILL);
+	}
+
+	if (child_1_pid > 0)
+		kill(child_1_pid, SIGKILL);
+
+	munmap(fork_kid_pid, sizeof(*fork_kid_pid) * MAXKIDS);
+}
+
+static void waitpid_test(void)
+{
+	child_1_pid = SAFE_FORK();
+	if (child_1_pid == 0) {
+		do_child_1();
+	} else {
+		tst_reap_children();
+		child_1_pid = 0;
+	}
+}
+
+static void do_exit(int stop)
+{
+	TST_CHECKPOINT_WAIT(0);
+
+	if (stop)
+		kill(getpid(), SIGSTOP);
+
+	exit(3);
+}
+
+static int reap_children(pid_t wp_pid, int wp_opts, pid_t *children, int len)
+{
+	pid_t pid;
+	int i;
+	int status;
+
+	for (;;) {
+		pid = waitpid(wp_pid, &status, wp_opts);
+
+		if (pid == -1) {
+			if (errno == EINTR)
+				continue;
+
+			break;
+		}
+
+		if (pid == 0) {
+			if (wp_opts & WNOHANG)
+				continue;
+
+			tst_res(TFAIL, "waitpid() returned 0 unexpectedly");
+			return -1;
+		}
+
+		for (i = 0; i < len; i++) {
+			if (pid == children[i]) {
+				children[i] = 0;
+				break;
+			}
+		}
+
+		if (i == len) {
+			tst_res(TFAIL, "Pid %d not found", pid);
+			return -1;
+		}
+
+		if (!WIFEXITED(status)) {
+			tst_res(TFAIL, "Pid %d exited abnormally", pid);
+			return -1;
+		}
+
+		if (WEXITSTATUS(status) != 3) {
+			tst_res(TFAIL, "Pid %d exited with %d, expected 3",
+				pid, WEXITSTATUS(status));
+			return -1;
+		}
+	}
+
+	for (i = 0; i < len; i++) {
+		if (children[i]) {
+			tst_res(TFAIL, "Pid %d not reaped", children[i]);
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+#endif /* WAITPID_COMMON_H__ */
-- 
1.7.1

