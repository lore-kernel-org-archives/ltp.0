From: Jinhui huang <huangjh.jy@cn.fujitsu.com>
Date: Thu, 2 Aug 2018 11:53:43 +0800
Subject: [LTP] [PATCH 4/5] syscalls/flock04: Rewrite to new library
In-Reply-To: <1533182024-18841-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1533182024-18841-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <1533182024-18841-4-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) Avoid locking closed fd when running flock04 in loops
2) Merge flock05 into flock04

Signed-off-by: Jinhui huang <huangjh.jy@cn.fujitsu.com>
---
 runtest/ltplite                            |   1 -
 runtest/stress.part3                       |   1 -
 runtest/syscalls                           |   1 -
 testcases/kernel/syscalls/flock/.gitignore |   1 -
 testcases/kernel/syscalls/flock/flock04.c  | 237 ++++++++++-------------------
 testcases/kernel/syscalls/flock/flock05.c  | 207 -------------------------
 6 files changed, 82 insertions(+), 366 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/flock/flock05.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 5a7819c..b07d884 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -239,7 +239,6 @@ flock01 flock01
 flock02 flock02
 flock03 flock03
 flock04 flock04
-flock05 flock05
 flock06 flock06
 
 fmtmsg01 fmtmsg01
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 3121cd9..0c320df 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -178,7 +178,6 @@ flock01 flock01
 flock02 flock02
 flock03 flock03
 flock04 flock04
-flock05 flock05
 flock06 flock06
 
 fmtmsg01 fmtmsg01
diff --git a/runtest/syscalls b/runtest/syscalls
index dc72484..5b38132 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -286,7 +286,6 @@ flock01 flock01
 flock02 flock02
 flock03 flock03
 flock04 flock04
-flock05 flock05
 flock06 flock06
 
 fmtmsg01 fmtmsg01
diff --git a/testcases/kernel/syscalls/flock/.gitignore b/testcases/kernel/syscalls/flock/.gitignore
index 93cce0a..c8cb0fc 100644
--- a/testcases/kernel/syscalls/flock/.gitignore
+++ b/testcases/kernel/syscalls/flock/.gitignore
@@ -2,5 +2,4 @@
 /flock02
 /flock03
 /flock04
-/flock05
 /flock06
diff --git a/testcases/kernel/syscalls/flock/flock04.c b/testcases/kernel/syscalls/flock/flock04.c
index 8a282b4..78fc0f1 100644
--- a/testcases/kernel/syscalls/flock/flock04.c
+++ b/testcases/kernel/syscalls/flock/flock04.c
@@ -1,178 +1,105 @@
-/*
- * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
+ * Author: Vatsal Avasthi
  *
+ * Test Description:
+ *  This test verifies that flock() behavior with different locking
+ *  combinations along with LOCK_SH and LOCK_EX:
+ *	1) flock() succeeds in acquiring shared lock on the file which has
+ *	   been locked with shared lock.
+ *	2) flock() fails to acquire exclusive lock on the file which has been
+ *	   locked with shared lock.
+ *	3) flock() fails to acquire shared lock on the file which has been
+ *	   locked with exclusive lock.
+ *	4) flock() fails to acquire exclusive lock on the file which has been
+ *	   locked with exclusive lock.
  */
-/**********************************************************
- *
- *    TEST IDENTIFIER   : flock04
- *
- *    EXECUTED BY       : anyone
- *
- *    TEST TITLE        : Testing different locks on flock(2)
- *
- *    TEST CASE TOTAL   : 2
- *
- *    AUTHOR            : Vatsal Avasthi <vatsal.avasthi@wipro.com>
- *
- *    SIGNALS
- *      Uses SIGUSR1 to pause before test if option set.
- *      (See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- * 	Tests to verify flock(2) behavior with different locking combinations along
- *	with LOCK_SH.
- *    $
- *	Setup:
- *        Setup signal handling.
- *        Pause for SIGUSR1 if option specified.
- *        Create a temporary directory and chdir to it.
- * 	  Create a temporary file
- *
- *	Test:
- *	Loop if proper options are given.
- *		Parent flocks(2) a file
- *		fork() a child process
- * 		Child tries to flock() the already flocked file with different types of locks
- *		Check return code, if system call failed (return == -1)
- *				Log the error number and issue a FAIL message
- *		otherwise issue a PASS message
- *
- *      Cleanup:
- *        Print errno log and/or timing stats if options given
- *	  Deletes temporary directory.
- *
- * USAGE:  <for command-line>
- *      flock04 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-h] [-f] [-p]
- *                      where,  -c n : Run n copies concurrently.
- *                              -f   : Turn off functional testing
- *    				-e   : Turn on errno logging.
- *                              -h   : Show help screen                        $
- *				-i n : Execute test n times.
- *                              -I x : Execute test for x seconds.
- *                              -p   : Pause for SIGUSR1 before starting
- *                              -P x : Pause for x seconds between iterations.
- *                              -t   : Turn on syscall timing.
- *
- ****************************************************************/
 
 #include <errno.h>
-#include <stdio.h>
-#include <unistd.h>
-#include <sys/types.h>
-#include <sys/wait.h>
 #include <sys/file.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include "test.h"
-#include "safe_macros.h"
+#include <stdlib.h>
 
-void setup(void);
-void cleanup(void);
+#include "tst_test.h"
 
-char *TCID = "flock04";
-int TST_TOTAL = 2;
-char filename[100];
-int fd, fd1, status;
+static struct tcase {
+	int operation;
+	char *filelock;
+} tcases[] = {
+	{LOCK_SH, "shared lock"},
+	{LOCK_EX, "exclusive lock"},
+};
 
-int main(int argc, char **argv)
+static void child(int opt1, int opt2, char *lock)
 {
-	int lc, retval;
-	pid_t pid;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		TEST(flock(fd, LOCK_SH));
-		if (TEST_RETURN == 0) {
-
-			pid = FORK_OR_VFORK();
-			if (pid == -1)
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "fork failed");
-			if (pid == 0) {
-				fd1 = open(filename, O_RDONLY);
-				retval = flock(fd1, LOCK_SH | LOCK_NB);
-				if (retval == -1)
-					tst_resm(TFAIL,
-						 "flock() FAILED to acquire shared lock on existing "
-						 "Share Locked file");
-				else
-					tst_resm(TPASS,
-						 "flock() PASSED in acquiring shared lock on "
-						 "Share Locked file");
-				exit(0);
-			} else {
-				SAFE_WAIT(cleanup, &status);
-			}
-
-			pid = FORK_OR_VFORK();
-			if (pid == -1)
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "fork failed");
-
-			if (pid == 0) {
-				fd1 = open(filename, O_RDWR);
-				retval = flock(fd1, LOCK_EX | LOCK_NB);
-				if (retval == -1) {
-					tst_resm(TPASS,
-						 "flock() failed to acquire exclusive lock on existing "
-						 "share locked file as expected");
-				} else {
-					tst_resm(TFAIL,
-						 "flock() unexpectedly passed in acquiring exclusive lock on "
-						 "Share Locked file");
-				}
-				exit(0);
-			} else if (wait(&status) == -1)
-				tst_resm(TBROK | TERRNO, "wait failed");
-			TEST(flock(fd, LOCK_UN));
-		} else
-			tst_resm(TFAIL | TERRNO, "flock failed");
-
-		close(fd);
-		close(fd1);
+	int retval, fd1;
+
+	fd1 = SAFE_OPEN("testfile", O_RDWR);
+	retval = flock(fd1, opt1);
+	if (LOCK_SH & opt1 && opt2 == LOCK_SH) {
+		if (retval == -1) {
+			tst_res(TFAIL, "flock() failed to acquire %s",
+				lock);
+			exit(1);
+		} else {
+			tst_res(TPASS, "flock() succeeded in acquiring %s"
+				"as expecetd", lock);
+			exit(0);
+		}
+	} else {
+		if (retval == 0) {
+			tst_res(TFAIL, "flock() succeeded in acquiring %s",
+				lock);
+			exit(1);
+		} else {
+			tst_res(TPASS, "flock() failed to acquire %s "
+				"as expecetd", lock);
+			exit(0);
+		}
 	}
 
-	cleanup();
-	tst_exit();
+	SAFE_CLOSE(fd1);
 }
 
-void setup(void)
+static void verify_flock(unsigned n)
 {
+	int fd2;
+	pid_t pid;
+	struct tcase *tc = &tcases[n];
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	fd2 = SAFE_OPEN("testfile", O_RDWR);
+	TEST(flock(fd2, tc->operation));
+	if (TST_RET != 0) {
+		tst_res(TFAIL, "flock() failed to acquire %s", tc->filelock);
+		return;
+	}
 
-	tst_tmpdir();
+	pid = SAFE_FORK();
+	if (pid == 0)
+		child(LOCK_SH | LOCK_NB, tc->operation, tc->filelock);
+	else
+		tst_reap_children();
 
-	sprintf(filename, "flock04.%d", getpid());
+	pid = SAFE_FORK();
+	if (pid == 0)
+		child(LOCK_EX | LOCK_NB, tc->operation, tc->filelock);
+	else
+		tst_reap_children();
 
-	fd = open(filename, O_CREAT | O_TRUNC | O_RDWR, 0666);
-	if (fd == -1)
-		tst_brkm(TFAIL, cleanup, "creating a new file failed");
+	SAFE_CLOSE(fd2);
 }
 
-void cleanup(void)
+static void setup(void)
 {
-	unlink(filename);
+	int fd;
 
-	tst_rmdir();
+	fd = SAFE_OPEN("testfile", O_CREAT | O_TRUNC | O_RDWR, 0644);
+	SAFE_CLOSE(fd);
 }
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_flock,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.forks_child = 1,
+};
diff --git a/testcases/kernel/syscalls/flock/flock05.c b/testcases/kernel/syscalls/flock/flock05.c
deleted file mode 100644
index 13ae2f6..0000000
--- a/testcases/kernel/syscalls/flock/flock05.c
+++ /dev/null
@@ -1,207 +0,0 @@
-/*
- * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- */
-/**********************************************************
- *
- *    TEST IDENTIFIER   : flock05
- *
- *    EXECUTED BY       : anyone
- *
- *    TEST TITLE        : Testing different locks on flock(2)
- *
- *    TEST CASE TOTAL   : 2
- *
- *    AUTHOR            : Vatsal Avasthi <vatsal.avasthi@wipro.com>
- *
- *    SIGNALS
- *      Uses SIGUSR1 to pause before test if option set.
- *      (See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- * 	Tests to verify flock(2) behavior with different locking combinations along
- *	with LOCK_EX.
- *    $
- *	Setup:
- *        Setup signal handling.
- *        Pause for SIGUSR1 if option specified.
- *        Create a temporary directory and chdir to it.
- * 	  Create a temporary file
- *
- *	Test:
- *	Loop if proper options are given.
- *		Parent flocks(2) a file
- *		fork() a child process
- * 		Child tries to flock() the already flocked file with different types of locks
- *		Check return code, if system call failed (return == -1)
- *				Log the error number and issue a FAIL message
- *		otherwise issue a PASS message
- *
- *      Cleanup:
- *        Print errno log and/or timing stats if options given
- *	  Deletes temporary directory.
- *
- * USAGE:  <for command-line>
- *      flock05 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-h] [-f] [-p]
- *                      where,  -c n : Run n copies concurrently.
- *                              -f   : Turn off functional testing
- *    				-e   : Turn on errno logging.
- *                              -h   : Show help screen                        $
- *				-i n : Execute test n times.
- *                              -I x : Execute test for x seconds.
- *                              -p   : Pause for SIGUSR1 before starting
- *                              -P x : Pause for x seconds between iterations.
- *                              -t   : Turn on syscall timing.
- *
- ****************************************************************/
-
-#include <errno.h>
-#include <stdio.h>
-#include <unistd.h>
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <sys/file.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include "test.h"
-
-void setup(void);
-void cleanup(void);
-
-char *TCID = "flock05";
-int TST_TOTAL = 2;
-char filename[100];
-int fd, fd1, status;
-
-int main(int argc, char **argv)
-{
-	int lc, retval;
-	pid_t pid;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	/* global setup */
-	setup();
-
-	/* The following loop checks looping state if -i option given */
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		/* Testing Shared lock on Exclusive Locked file */
-		TEST(flock(fd, LOCK_EX));
-		if (TEST_RETURN == 0) {
-
-			pid = FORK_OR_VFORK();
-			if (pid == 0) {
-				fd1 = open(filename, O_RDWR);
-				retval = flock(fd1, LOCK_SH | LOCK_NB);
-				if (retval == -1) {
-					tst_resm(TPASS,
-						 "flock() failed to acquire shared lock on an already"
-						 "exclusive locked file as expected");
-				} else {
-					tst_resm(TFAIL,
-						 "flock() unexpectedly PASSED in acquiring shared lock on "
-						 "an already exclusive locked file");
-				}
-				exit(0);
-			} else {
-				/* parent waiting */
-				wait(&status);
-			}
-
-			/* Testing Exclusive lock on a Exclusive Locked file */
-			pid = FORK_OR_VFORK();
-
-			if (pid == 0) {
-				fd1 = open(filename, O_RDWR);
-				retval = flock(fd1, LOCK_EX | LOCK_NB);
-				if (retval == -1) {
-					tst_resm(TPASS,
-						 "flock() failed to acquire exclusive lock on existing "
-						 " exclusive locked file as expected");
-				} else {
-					tst_resm(TFAIL,
-						 "flock() unexpectedly passed in acquiring exclusive lock on "
-						 "an exclusive locked file");
-				}
-				exit(0);
-			} else {
-				/* parent waiting */
-				wait(&status);
-			}
-			TEST(flock(fd, LOCK_UN));
-		} else {
-			tst_resm(TFAIL,
-				 "flock() failed to acquire exclusive lock");
-		}
-
-	}
-
-	close(fd);
-	close(fd1);
-	cleanup();
-	tst_exit();
-
-}
-
-/*
- * setup()
- *	performs all ONE TIME setup for this test
- */
-void setup(void)
-{
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -i option.
-	 * You want to make sure you do this before you create your temporary
-	 * directory.
-	 */
-	TEST_PAUSE;
-
-	/* Create a unique temporary directory and chdir() to it. */
-	tst_tmpdir();
-
-	sprintf(filename, "flock05.%d", getpid());
-
-	/* creating temporary file */
-	fd = open(filename, O_CREAT | O_TRUNC | O_RDWR, 0666);
-	if (fd == -1) {
-		tst_resm(TFAIL, "creating a new file failed");
-
-		/* Removing temp dir */
-		tst_rmdir();
-
-	}
-}
-
-/*
- * cleanup()
- *	performs all ONE TIME cleanup for this test at
- * 	completion or premature exit
- */
-void cleanup(void)
-{
-
-	unlink(filename);
-
-	tst_rmdir();
-
-}
-- 
1.8.3.1



