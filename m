From: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
Date: Thu, 20 Aug 2020 06:26:06 -0400
Subject: [LTP] [PATCH 2/4] syscalls/kill03,
 04: Cleanup && Convert to new library
In-Reply-To: <1597919168-10702-1-git-send-email-zhufy.jy@cn.fujitsu.com>
References: <1597919168-10702-1-git-send-email-zhufy.jy@cn.fujitsu.com>
Message-ID: <1597919168-10702-2-git-send-email-zhufy.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) Remove uclinux code
2) Take use of safe macro
3) Merge kill04 into kill03
4) Add error test that pid is INT_MIN

Reviewed-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Signed-off-by: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
---
 runtest/syscalls                          |   1 -
 testcases/kernel/syscalls/kill/.gitignore |   1 -
 testcases/kernel/syscalls/kill/kill03.c   | 203 +++++++++---------------------
 testcases/kernel/syscalls/kill/kill04.c   | 133 --------------------
 4 files changed, 59 insertions(+), 279 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/kill/kill04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 5e2bdb1..a6ab75b 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -616,7 +616,6 @@ kcmp03 kcmp03
 
 kill02 kill02
 kill03 kill03
-kill04 kill04
 kill05 kill05
 kill06 kill06
 kill07 kill07
diff --git a/testcases/kernel/syscalls/kill/.gitignore b/testcases/kernel/syscalls/kill/.gitignore
index b62662f..75fdaa5 100644
--- a/testcases/kernel/syscalls/kill/.gitignore
+++ b/testcases/kernel/syscalls/kill/.gitignore
@@ -1,6 +1,5 @@
 /kill02
 /kill03
-/kill04
 /kill05
 /kill06
 /kill07
diff --git a/testcases/kernel/syscalls/kill/kill03.c b/testcases/kernel/syscalls/kill/kill03.c
index 5770ae0..21be09f 100644
--- a/testcases/kernel/syscalls/kill/kill03.c
+++ b/testcases/kernel/syscalls/kill/kill03.c
@@ -1,165 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
  *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
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
- *	kill03.c
- *
- * DESCRIPTION
- *	Test case to check that kill fails when given an invalid signal.
- *
- * ALGORITHM
- *	call setup
- *	loop if the -i option was given
- *	fork a child
- *	execute the kill system call with an invalid signal
- *	check the return value
- *	if return value is not -1
- *		issue a FAIL message, break remaining tests and cleanup
- *	if we are doing functional testing
- *		if the errno was set to 22 (invalid argument).
- *			issue a PASS message
- *		otherwise
- *			issue a FAIL message
- *	call cleanup
- *
- * USAGE
- *  kill03 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
+ * 1) kill() fails with errno set to EINVAL if given an invalid signal.
+ * 2) kill() fails with errno set to ESRCH if given a non-existent pid.
+ * 3) kill() fails with errno set to ESRCH if the given pid is INT_MIN.
  *
  * HISTORY
  *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- *	none
  */
 
-#include "test.h"
-
+#include <sys/types.h>
 #include <signal.h>
-#include <errno.h>
-#include <sys/wait.h>
-
-void cleanup(void);
-void setup(void);
-void do_child(void);
-
-char *TCID = "kill03";
-int TST_TOTAL = 1;
-
-#define TEST_SIG 2000
-
-int main(int ac, char **av)
+#include <unistd.h>
+#include "tst_test.h"
+
+static pid_t real_pid, fake_pid, int_min_pid;
+static void cleanup(void);
+
+static struct tcase {
+	int test_sig;
+	int exp_errno;
+	int child_flag;
+	pid_t *pid;
+} tcases[] = {
+	{2000, EINVAL, 1, &real_pid},
+	{SIGKILL, ESRCH, 0, &fake_pid},
+	{SIGKILL, ESRCH, 0, &int_min_pid}
+};
+
+static void verify_kill(unsigned int n)
 {
-	int lc;
-	pid_t pid;
-	int exno, status;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-#ifdef UCLINUX
-	maybe_run_child(&do_child, "");
-#endif
+	struct tcase *tc = &tcases[n];
 
-	setup();
-
-	/* The following loop checks looping state if -i option given */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-		status = 1;
-		exno = 1;
-		pid = FORK_OR_VFORK();
-		if (pid < 0) {
-			tst_brkm(TBROK, cleanup, "Fork of child failed");
-		} else if (pid == 0) {
-#ifdef UCLINUX
-			if (self_exec(av[0], "") < 0) {
-				tst_brkm(TBROK, cleanup,
-					 "self_exec of child failed");
-			}
-#else
-			do_child();
-#endif
-		} else {
-			TEST(kill(pid, TEST_SIG));
-			kill(pid, SIGKILL);
-			waitpid(pid, &status, 0);
-		}
+	if (tc->child_flag) {
+		real_pid = SAFE_FORK();
+		if (!real_pid)
+			pause();
+	}
+
+	TEST(kill(*tc->pid, tc->test_sig));
+	if (TST_RET != -1) {
+		tst_res(TFAIL, "kill should fail but not, return %ld", TST_RET);
+		return;
+	}
 
-		if (TEST_RETURN != -1) {
-			tst_brkm(TFAIL, cleanup, "%s failed - errno = %d : %s "
-				 "Expected a return value of -1 got %ld",
-				 TCID, TEST_ERRNO, strerror(TEST_ERRNO),
-				 TEST_RETURN);
-		}
+	if (tc->exp_errno == TST_ERR)
+		tst_res(TPASS | TTERRNO, "kill failed as expected");
+	else
+		tst_res(TFAIL | TTERRNO, "kill expected %s but got",
+			tst_strerrno(tc->exp_errno));
 
-		/*
-		 * Check to see if the errno was set to the expected
-		 * value of 22 : EINVAL.
-		 */
-		if (TEST_ERRNO == EINVAL) {
-			tst_resm(TPASS, "errno set to %d : %s, as "
-				 "expected", TEST_ERRNO,
-				 strerror(TEST_ERRNO));
-		} else {
-			tst_resm(TFAIL, "errno set to %d : %s expected "
-				 "%d : %s", TEST_ERRNO,
-				 strerror(TEST_ERRNO), 22,
-				 strerror(22));
-		}
+	if (tc->child_flag) {
+		cleanup();
+		real_pid = 0;
 	}
-
-	cleanup();
-	tst_exit();
 }
 
-/*
- * do_child()
- */
-void do_child(void)
+static void setup(void)
 {
-	int exno = 1;
-
-	pause();
-	exit(exno);
+	fake_pid = tst_get_unused_pid();
+	int_min_pid = INT_MIN;
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test
- */
-void setup(void)
+static void cleanup(void)
 {
-
-	TEST_PAUSE;
+	if (real_pid > 0) {
+		SAFE_KILL(real_pid, SIGKILL);
+		SAFE_WAIT(NULL);
+	}
 }
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * or premature exit.
- */
-void cleanup(void)
-{
-
-}
+static struct tst_test test = {
+	.test = verify_kill,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.forks_child = 1,
+};
diff --git a/testcases/kernel/syscalls/kill/kill04.c b/testcases/kernel/syscalls/kill/kill04.c
deleted file mode 100644
index f3bec13..0000000
--- a/testcases/kernel/syscalls/kill/kill04.c
+++ /dev/null
@@ -1,133 +0,0 @@
-/*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
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
- *	kill04.c
- *
- * DESCRIPTION
- *	Test case to check that kill() fails when passed a non-existant pid.
- *
- * ALGORITHM
- *	call setup
- *	loop if the -i option was given
- *	fork a child
- *	execute the kill system call with a non-existant PID
- *	check the return value
- *	if return value is not -1
- *		issue a FAIL message, break remaining tests and cleanup
- *	if we are doing functional testing
- *		if the errno was set to 3 (No such proccess)
- *			issue a PASS message
- *		otherwise
- *			issue a FAIL message
- *	call cleanup
- *
- * USAGE
- *  kill04 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- *	This test should be run by a non-root user
- */
-
-#include "test.h"
-
-#include <signal.h>
-#include <errno.h>
-#include <sys/wait.h>
-
-void cleanup(void);
-void setup(void);
-void do_child(void);
-
-char *TCID = "kill04";
-int TST_TOTAL = 1;
-
-#define TEST_SIG SIGKILL
-
-int main(int ac, char **av)
-{
-	int lc;
-	pid_t fake_pid;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	/* The following loop checks looping state if -i option given */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		fake_pid = tst_get_unused_pid(cleanup);
-		TEST(kill(fake_pid, TEST_SIG));
-
-		if (TEST_RETURN != -1) {
-			tst_brkm(TFAIL, cleanup, "%s failed - errno = %d : %s "
-				 "Expected a return value of -1 got %ld",
-				 TCID, TEST_ERRNO, strerror(TEST_ERRNO),
-				 TEST_RETURN);
-		}
-
-		/*
-		 * Check to see if the errno was set to the expected
-		 * value of 3 : ESRCH
-		 */
-		if (TEST_ERRNO == ESRCH) {
-			tst_resm(TPASS, "errno set to %d : %s, as "
-				 "expected", TEST_ERRNO,
-				 strerror(TEST_ERRNO));
-		} else {
-			tst_resm(TFAIL, "errno set to %d : %s expected "
-				 "%d : %s", TEST_ERRNO,
-				 strerror(TEST_ERRNO), 3, strerror(3));
-		}
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-/*
- * setup() - performs all ONE TIME setup for this test
- */
-void setup(void)
-{
-
-	TEST_PAUSE;
-}
-
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * or premature exit.
- */
-void cleanup(void)
-{
-
-}
-- 
1.8.3.1



