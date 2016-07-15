From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 15 Jul 2016 17:39:43 +0300
Subject: [LTP] [PATCH 2/8] waitpid06: use the new API
In-Reply-To: <1468593589-30545-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1468593589-30545-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1468593589-30545-3-git-send-email-stanislav.kholmanskikh@oracle.com>
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
 testcases/kernel/syscalls/waitpid/waitpid06.c      |  264 ++++----------------
 testcases/kernel/syscalls/waitpid/waitpid_common.h |   78 ++++++
 2 files changed, 121 insertions(+), 221 deletions(-)
 create mode 100644 testcases/kernel/syscalls/waitpid/waitpid_common.h

diff --git a/testcases/kernel/syscalls/waitpid/waitpid06.c b/testcases/kernel/syscalls/waitpid/waitpid06.c
index dbbc104..be3d8e2 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid06.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid06.c
@@ -1,204 +1,60 @@
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
+	int kid_count;
+	pid_t ret_val;
 	int i, j, k, found;
-	int group1, group2;
-	int wait_kid_pid[MAXKIDS], status;
-
-	setup_sigint();
+	pid_t wait_kid_pid[MAXKIDS];
+	int status;
+	int flag = 0;
 
-	group1 = getpgrp();
 	for (kid_count = 0; kid_count < MAXKIDS; kid_count++) {
 		if (kid_count == (MAXKIDS / 2))
-			group2 = setpgrp();
+			SAFE_SETPGID(0, 0);
 
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
+			do_exit(0);
 
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
-	 * pid's in an array.
+	 * pids in an array.
 	 */
 	kid_count = 0;
 	errno = 0;
@@ -207,16 +63,15 @@ static void do_child_1(void)
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
@@ -239,16 +94,16 @@ static void do_child_1(void)
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
@@ -256,48 +111,15 @@ static void do_child_1(void)
 		}
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
+	memset(fork_kid_pid, 0, sizeof(*fork_kid_pid) * MAXKIDS);
 
-	while (!intintr)
-		testvar = 0;
+	exit(flag);
 }
 
-static void do_exit(void)
-{
-	wait_for_parent();
-	exit(3);
-}
+static struct tst_test test = {
+	.tid = "waitpid06",
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+	.cleanup = cleanup,
+	.test_all = waitpid_test,
+};
diff --git a/testcases/kernel/syscalls/waitpid/waitpid_common.h b/testcases/kernel/syscalls/waitpid/waitpid_common.h
new file mode 100644
index 0000000..909468a
--- /dev/null
+++ b/testcases/kernel/syscalls/waitpid/waitpid_common.h
@@ -0,0 +1,78 @@
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
+#define	FAILED	1
+#define	MAXKIDS	8
+
+static pid_t *fork_kid_pid;
+
+static void do_child_1(void);
+
+static void cleanup(void)
+{
+	int i;
+
+	for (i = 0; i < MAXKIDS; i++) {
+		if (fork_kid_pid[i] > 0) {
+			kill(fork_kid_pid[i], SIGKILL);
+			waitpid(fork_kid_pid[i], NULL, 0);
+		}
+	}
+}
+
+static void waitpid_test(void)
+{
+	pid_t pid;
+	int status;
+
+	fork_kid_pid = SAFE_MMAP(NULL, sizeof(*fork_kid_pid) * MAXKIDS,
+				 PROT_READ | PROT_WRITE,
+				 MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		do_child_1();
+	} else {
+		SAFE_WAITPID(pid, &status, 0);
+		if (WEXITSTATUS(status) != 0)
+			tst_res(TFAIL, "Child returned bad status");
+		else
+			tst_res(TPASS, "Child returned good status");
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
+#endif /* WAITPID_COMMON_H__ */
-- 
1.7.1

