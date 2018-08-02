From: Jinhui huang <huangjh.jy@cn.fujitsu.com>
Date: Thu, 2 Aug 2018 11:53:42 +0800
Subject: [LTP] [PATCH 3/5] syscalls/flock03: Rewrite to new library
In-Reply-To: <1533182024-18841-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1533182024-18841-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <1533182024-18841-3-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jinhui huang <huangjh.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/flock/flock03.c | 203 ++++++++----------------------
 1 file changed, 53 insertions(+), 150 deletions(-)

diff --git a/testcases/kernel/syscalls/flock/flock03.c b/testcases/kernel/syscalls/flock/flock03.c
index 420f509..57dcc5f 100644
--- a/testcases/kernel/syscalls/flock/flock03.c
+++ b/testcases/kernel/syscalls/flock/flock03.c
@@ -1,28 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2002
- * Copyright (c) 2012 Cyril Hrubis <chrubis@suse.cz>
+ * Author: Cyril Hrubis
  *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-/*
- * This test verifies that flock cannot unlock a file locked
- * by another task
+ * Test Description:
+ *  This test verifies that flock() cannot unlock a file locked by another
+ *  task.
  *
  * Test Steps:
- *
  *  Fork a child processes The parent flocks a file with LOCK_EX Child waits
  *  for that to happen, then checks to make sure it is locked.  Child then
  *  tries to unlock the file. If the unlock succeeds, the child attempts to
@@ -30,166 +15,84 @@
  *  the file.
  */
 
-#include <stdio.h>
 #include <errno.h>
-#include <fcntl.h>
-#include <sys/types.h>
-#include <sys/stat.h>
+#include <stdlib.h>
 #include <sys/file.h>
-#include <sys/wait.h>
-#include "test.h"
-
-#define FILE_NAME "flock03"
-
-static void setup(void);
-static void cleanup(void);
-static void childfunc(int);
-
-#ifdef UCLINUX
-static int fd_uc;
-static void childfunc_uc(void)
-{
-	childfunc(fd_uc);
-}
-#endif
-
-char *TCID = "flock03";
-int TST_TOTAL = 3;
-
-int main(int argc, char **argv)
-{
-	int lc;
-	pid_t pid;
-	int status;
-	int fd;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-#ifdef UCLINUX
-	maybe_run_child(&childfunc_uc, "ds", &fd_uc, FILE_NAME);
-#endif
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		fd = open(FILE_NAME, O_RDWR);
-
-		if (fd == -1)
-			tst_brkm(TFAIL | TERRNO, cleanup,
-				 "parent failed to open the file");
-
-		pid = FORK_OR_VFORK();
-
-		if (pid == -1)
-			tst_brkm(TFAIL | TERRNO, cleanup, "fork() failed");
-		if (pid == 0) {
-#ifdef UCLINUX
-			if (self_exec(argv[0], "ds", fd, FILE_NAME) < 0)
-				tst_brkm(TFAIL | TERRNO, cleanup,
-					 "self_exec failed");
-#else
-			childfunc(fd);
-#endif
-		}
-
-		TEST(flock(fd, LOCK_EX | LOCK_NB));
-
-		if (TEST_RETURN != 0)
-			tst_resm(TFAIL | TTERRNO,
-				 "Parent: Initial attempt to flock() failed");
-		else
-			tst_resm(TPASS,
-				 "Parent: Initial attempt to flock() passed");
 
-		TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
-
-		if ((waitpid(pid, &status, 0)) < 0) {
-			tst_resm(TFAIL, "wait() failed");
-			continue;
-		}
-		if ((WIFEXITED(status)) && (WEXITSTATUS(status) == 0))
-			tst_resm(TPASS, "flock03 Passed");
-		else
-			tst_resm(TFAIL, "flock03 Failed");
-
-		close(fd);
-
-	}
-
-	cleanup();
-	tst_exit();
-}
+#include "tst_test.h"
 
 static void childfunc(int fd)
 {
 	int fd2;
+	TST_CHECKPOINT_WAIT(0);
 
-	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
-
-	fd2 = open(FILE_NAME, O_RDWR);
-
-	if (fd2 == -1) {
-		fprintf(stderr, "CHILD: failed to open the file: %s\n",
-		        strerror(errno));
-		exit(1);
-	}
-
-	if (flock(fd2, LOCK_EX | LOCK_NB) != -1) {
-		fprintf(stderr, "CHILD: The file was not already locked\n");
-		exit(1);
-	}
+	fd2 = SAFE_OPEN("testfile", O_RDWR);
+	if (flock(fd2, LOCK_EX | LOCK_NB) != -1)
+		tst_brk(TBROK, "CHILD: The file was not already locked");
 
 	TEST(flock(fd, LOCK_UN));
-	/* XXX: LOCK_UN does not return an error if there was nothing to
-	 * unlock.
-	 */
-	if (TEST_RETURN == -1) {
-		fprintf(stderr, "CHILD: Unable to unlock file locked by "
-		        "parent: %s\n", strerror(TEST_ERRNO));
+	if (TST_RET == -1) {
+		tst_res(TFAIL, "CHILD: Unable to unlock file locked by "
+			"parent: %s", tst_strerrno(TST_ERR));
 		exit(1);
 	} else {
-		fprintf(stderr, "CHILD: File locked by parent unlocked\n");
+		tst_res(TPASS, "CHILD: File locked by parent unlocked");
 	}
 
 	TEST(flock(fd2, LOCK_EX | LOCK_NB));
-
-	if (TEST_RETURN == -1) {
-		fprintf(stderr, "CHILD: Unable to lock file after "
-		        "unlocking: %s\n", strerror(TEST_ERRNO));
+	if (TST_RET == -1) {
+		tst_res(TFAIL, "CHILD: Unable to unlock file after "
+			"unlocking: %s", tst_strerrno(TST_ERR));
 		exit(1);
 	} else {
-		fprintf(stderr, "CHILD: Locking after unlock passed\n");
+		tst_res(TPASS, "Locking after unlock passed");
 	}
 
-	close(fd);
-	close(fd2);
+	SAFE_CLOSE(fd);
+	SAFE_CLOSE(fd2);
 
 	exit(0);
 }
 
-static void setup(void)
+static void verify_flock(void)
 {
-	int fd;
+	int fd1;
+	pid_t pid;
+
+	fd1 = SAFE_OPEN("testfile", O_RDWR);
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	pid = SAFE_FORK();
+	if (pid == 0)
+		childfunc(fd1);
 
-	TEST_PAUSE;
+	TEST(flock(fd1, LOCK_EX | LOCK_NB));
+	if (TST_RET != 0) {
+		tst_res(TFAIL | TTERRNO,
+			"Parent: Initial attempt to flock() failed");
+	} else {
+		tst_res(TPASS,
+			"Parent: Initial attempt to flock() passed");
+	}
 
-	tst_tmpdir();
+	TST_CHECKPOINT_WAKE(0);
 
-	TST_CHECKPOINT_INIT(tst_rmdir);
+	tst_reap_children();
 
-	fd = open(FILE_NAME, O_CREAT | O_TRUNC | O_RDWR, 0666);
-	if (fd < 0) {
-		tst_resm(TBROK, "creating a new file failed");
-		cleanup();
-	}
-	close(fd);
+	SAFE_CLOSE(fd1);
 }
 
-static void cleanup(void)
+static void setup(void)
 {
-	tst_rmdir();
+	int fd;
+
+	fd = SAFE_OPEN("testfile", O_CREAT | O_TRUNC | O_RDWR, 0666);
+	SAFE_CLOSE(fd);
 }
+
+static struct tst_test test = {
+	.test_all = verify_flock,
+	.needs_checkpoints = 1,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.setup = setup,
+};
-- 
1.8.3.1



