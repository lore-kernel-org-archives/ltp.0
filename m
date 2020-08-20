From: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
Date: Thu, 20 Aug 2020 06:26:07 -0400
Subject: [LTP] [PATCH 3/4] syscalls/kill05:Cleanup && Convert to new library
In-Reply-To: <1597919168-10702-1-git-send-email-zhufy.jy@cn.fujitsu.com>
References: <1597919168-10702-1-git-send-email-zhufy.jy@cn.fujitsu.com>
Message-ID: <1597919168-10702-3-git-send-email-zhufy.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) Take use of some safe macros

Reviewed-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Signed-off-by: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/kill/Makefile |   4 +-
 testcases/kernel/syscalls/kill/kill05.c | 243 ++++++++------------------------
 2 files changed, 58 insertions(+), 189 deletions(-)

diff --git a/testcases/kernel/syscalls/kill/Makefile b/testcases/kernel/syscalls/kill/Makefile
index 3d1b146..0cc064b 100644
--- a/testcases/kernel/syscalls/kill/Makefile
+++ b/testcases/kernel/syscalls/kill/Makefile
@@ -3,11 +3,11 @@
 
 top_srcdir		?= ../../../..
 
-LTPLIBS = ltpipc
+LTPLIBS = ltpipc ltpnewipc
 
 include $(top_srcdir)/include/mk/testcases.mk
 
 kill07: LTPLDLIBS  = -lltpipc
-kill05: LTPLDLIBS  = -lltpipc
+kill05: LTPLDLIBS  = -lltpnewipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/kill/kill05.c b/testcases/kernel/syscalls/kill/kill05.c
index ccef5af..039d510 100644
--- a/testcases/kernel/syscalls/kill/kill05.c
+++ b/testcases/kernel/syscalls/kill/kill05.c
@@ -1,56 +1,8 @@
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
- *	kill05.c
- *
- * DESCRIPTION
- *	Test case to check that kill() fails when passed a pid owned by another
- *	user.
- *
- * ALGORITHM
- *	call setup
- *	loop if the -i option was given
- *	setup a shared memory segment to for a flag which will notify
- *	ltpuser1's process that life is not worth living in a continuous loop.
- *	fork a child and set the euid to ltpuser1
- *	set the parents euid to ltpuser2
- *	execute the kill system call on ltpuser1's pid
- *	check the return value
- *	if return value is not -1
- *		issue a FAIL message, break remaining tests and cleanup
- *      if we are doing functional testing
- *              if the errno was set to 1 (Operation not permitted)
- *                      issue a PASS message
- *              otherwise
- *                      issue a FAIL message
- *	call cleanup
- *
- * USAGE
- *  kill05 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
+ * Test case to check that kill() fails when passed a pid owned by another user.
  *
  * HISTORY
  *	07/2001 Ported by Wayne Boyer
@@ -66,67 +18,20 @@
  *	Looping with the -i option does not work correctly.
  */
 
-#include <sys/types.h>
-#include <sys/ipc.h>
-#include <sys/shm.h>
 #include <sys/wait.h>
-#include <errno.h>
 #include <pwd.h>
-#include <signal.h>
-#include <string.h>
-#include <stdio.h>
 #include <stdlib.h>
-#include <unistd.h>
-
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
+#include "libnewipc.h"
+#include "tst_safe_sysv_ipc.h"
+#include "tst_safe_macros.h"
 
-extern void rm_shm(int);
-
-void cleanup(void);
-void setup(void);
-void do_child(void);
-void do_master_child(char **av);
-
-char *TCID = "kill05";
-int TST_TOTAL = 1;
-int shmid1 = -1;
-extern key_t semkey;
+static uid_t nobody_uid, bin_uid;
 int *flag;
+static int shm_id = -1;
+static key_t shm_key;
 
-extern int getipckey();
-
-#define TEST_SIG SIGKILL
-
-int main(int ac, char **av)
-{
-	pid_t pid;
-	int status;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-#ifdef UCLINUX
-	maybe_run_child(&do_child, "");
-#endif
-
-	setup();		/* global setup */
-
-	pid = FORK_OR_VFORK();
-	if (pid == -1)
-		tst_brkm(TBROK, cleanup, "Fork failed");
-	else if (pid == 0)
-		do_master_child(av);
-
-	if (waitpid(pid, &status, 0) == -1)
-		tst_resm(TBROK | TERRNO, "waitpid failed");
-	else if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
-		tst_resm(TFAIL, "child exited abnormally");
-	else
-		tst_resm(TPASS, "received expected errno(EPERM)");
-	cleanup();
-	tst_exit();
-}
-
-void wait_for_flag(int value)
+static void wait_for_flag(int value)
 {
 	while (1) {
 		if (*flag == value)
@@ -136,107 +41,71 @@ void wait_for_flag(int value)
 	}
 }
 
-/*
- * do_master_child()
- */
-void do_master_child(char **av)
+void do_master_child(void)
 {
 	pid_t pid1;
-	int status;
-
-	char user1name[] = "nobody";
-	char user2name[] = "bin";
-
-	struct passwd *ltpuser1, *ltpuser2;
-
-	tst_count = 0;
 
 	*flag = 0;
-
-	pid1 = FORK_OR_VFORK();
-
-	if (pid1 == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Fork failed");
-
+	pid1 = SAFE_FORK();
 	if (pid1 == 0) {
-		ltpuser1 = SAFE_GETPWNAM(NULL, user1name);
-		if (setreuid(ltpuser1->pw_uid, ltpuser1->pw_uid) == -1) {
-			perror("setreuid failed (in child)");
-			exit(1);
-		}
+		SAFE_SETREUID(nobody_uid, nobody_uid);
 		*flag = 1;
-#ifdef UCLINUX
-		if (self_exec(av[0], "") < 0) {
-			perror("self_exec failed");
-			exit(1);
-		}
-#else
-		do_child();
-#endif
-	}
-	ltpuser2 = SAFE_GETPWNAM(NULL, user2name);
-	if (setreuid(ltpuser2->pw_uid, ltpuser2->pw_uid) == -1) {
-		perror("seteuid failed");
-		exit(1);
+		wait_for_flag(2);
+		exit(0);
 	}
-
-	/* wait until child sets its euid */
+	SAFE_SETREUID(bin_uid, bin_uid);
 	wait_for_flag(1);
-
-	TEST(kill(pid1, TEST_SIG));
-
-	/* signal the child that we're done */
+	TEST(kill(pid1, SIGKILL));
 	*flag = 2;
+	SAFE_WAITPID(pid1, NULL, 0);
 
-	if (waitpid(pid1, &status, 0) == -1) {
-		perror("waitpid failed");
-		exit(1);
+	if (TST_RET == 0) {
+		tst_res(TFAIL, "kill succeeded unexpectedly");
+		return;
 	}
 
-	if (TEST_RETURN != -1) {
-		printf("kill succeeded unexpectedly\n");
-		exit(1);
-	}
+	if (TST_ERR == EPERM)
+		tst_res(TPASS, "kill failed with EPERM");
+	else
+		tst_res(TFAIL | TTERRNO, "kill failed expected EPERM, but got");
+}
 
-	/*
-	 * Check to see if the errno was set to the expected
-	 * value of 1 : EPERM
-	 */
-	if (TEST_ERRNO == EPERM) {
-		printf("kill failed with EPERM\n");
+static void verify_kill(void)
+{
+	pid_t pid;
+
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		do_master_child();
 		exit(0);
 	}
-	perror("kill failed unexpectedly");
-	exit(1);
-}
 
-void do_child(void)
-{
-	wait_for_flag(2);
-	exit(0);
+	tst_reap_children();
 }
 
-void setup(void)
+static void setup(void)
 {
-	tst_require_root();
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	semkey = getipckey();
-
-	if ((shmid1 = shmget(semkey, getpagesize(), 0666 | IPC_CREAT)) == -1)
-		tst_brkm(TBROK, cleanup, "Failed to setup shared memory");
-
-	if ((flag = shmat(shmid1, 0, 0)) == (int *)-1)
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "Failed to attach shared memory:%d", shmid1);
+	struct passwd *pw;
+	shm_key = GETIPCKEY();
+	shm_id = SAFE_SHMGET(shm_key, getpagesize(), 0666 | IPC_CREAT);
+	flag = SAFE_SHMAT(shm_id, 0, 0);
+	pw = SAFE_GETPWNAM("nobody");
+	nobody_uid = pw->pw_uid;
+	pw = SAFE_GETPWNAM("bin");
+	bin_uid = pw->pw_uid;
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
-	rm_shm(shmid1);
-
-	tst_rmdir();
+	if (shm_id != -1)
+		SAFE_SHMCTL(shm_id, IPC_RMID, NULL);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_kill,
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.forks_child = 1,
+};
-- 
1.8.3.1



