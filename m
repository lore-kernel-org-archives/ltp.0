From: Jinhui huang <huangjh.jy@cn.fujitsu.com>
Date: Thu, 2 Aug 2018 11:53:44 +0800
Subject: [LTP] [PATCH 5/5] syscalls/flock06: Rewrite to new library
In-Reply-To: <1533182024-18841-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1533182024-18841-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <1533182024-18841-5-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jinhui huang <huangjh.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/flock/flock06.c | 213 ++++++++----------------------
 1 file changed, 52 insertions(+), 161 deletions(-)

diff --git a/testcases/kernel/syscalls/flock/flock06.c b/testcases/kernel/syscalls/flock/flock06.c
index 617eddf..61e9c4e 100644
--- a/testcases/kernel/syscalls/flock/flock06.c
+++ b/testcases/kernel/syscalls/flock/flock06.c
@@ -1,177 +1,68 @@
-/*
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) Matthew Wilcox for Hewlett Packard 2003
+ * Author: Matthew Wilcox
  *
- *   Copyright (c) Matthew Wilcox for Hewlett Packard 2003
+ * Test Description:
+ *  This test verifies that flock locks held on one fd conflict with flock
+ *  locks held on a different fd.
  *
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
+ * Test Steps:
+ *  The process opens two file descriptors on the same file.  It acquires
+ *  an exclusive flock on the first descriptor, checks that attempting to
+ *  acquire an flock on the second descriptor fails.  Then it removes the
+ *  first descriptor's lock and attempts to acquire an exclusive lock on
+ *  the second descriptor.
  */
 
-/**********************************************************
- *
- *    TEST IDENTIFIER   : flock06
- *
- *    EXECUTED BY       : anyone
- *
- *    TEST TITLE        : Error condition test for flock(2)
- *
- *    TEST CASE TOTAL   : 1
- *
- *    AUTHOR            : Matthew Wilcox <willy@debian.org>
- *
- *    SIGNALS
- *      Uses SIGUSR1 to pause before test if option set.
- *      (See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- * 		 This test verifies that flock locks held on one fd conflict with
- * 		 flock locks held on a different fd.
- *
- *		 Test:
- * 		 		 The process opens two file descriptors on the same file.
- * 		 		 It acquires an exclusive flock on the first descriptor,
- * 		 		 checks that attempting to acquire an flock on the second
- * 		 		 descriptor fails.  Then it removes the first descriptor's
- * 		 		 lock and attempts to acquire an exclusive lock on the
- * 		 		 second descriptor.
- *
- * USAGE:  <for command-line>
- *      flock06 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-h] [-f] [-p]
- *                      where,  -c n : Run n copies concurrently
- *                              -f   : Turn off functional testing
- *    		 		 		 		 -e   : Turn on errno logging
- *                              -h   : Show help screen
- *		 		 		 		 -i n : Execute test n times
- *                              -I x : Execute test for x seconds
- *                              -p   : Pause for SIGUSR1 before starting
- *                              -P x : Pause for x seconds between iterations
- *                              -t   : Turn on syscall timing
- *
- ****************************************************************/
-
-#include <stdio.h>
 #include <errno.h>
-#include <fcntl.h>
-#include <sys/types.h>
-#include <sys/stat.h>
 #include <sys/file.h>
-#include <sys/wait.h>
-#include "test.h"
-#include "safe_macros.h"
 
-void setup(void);
-void cleanup(void);
+#include "tst_test.h"
 
-char *TCID = "flock06";
-int TST_TOTAL = 3;
-char filename[100];
-
-int main(int argc, char **argv)
+static void verify_flock(void)
 {
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	/* The following loop checks looping state if -i option given */
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		int fd1, fd2;
-
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		fd1 = open(filename, O_RDWR);
-		if (fd1 == -1)
-			tst_brkm(TFAIL | TERRNO, cleanup,
-				 "failed to open the file");
-
-		TEST(flock(fd1, LOCK_EX | LOCK_NB));
-		if (TEST_RETURN != 0)
-			tst_resm(TFAIL | TTERRNO,
-				 "First attempt to flock() failed");
-		else
-			tst_resm(TPASS, "First attempt to flock() passed");
-
-		fd2 = open(filename, O_RDWR);
-		if (fd2 == -1)
-			tst_brkm(TFAIL | TERRNO, cleanup,
-				 "failed to open the file");
-
-		TEST(flock(fd2, LOCK_EX | LOCK_NB));
-		if (TEST_RETURN == -1)
-			tst_resm(TPASS, "Second attempt to flock() denied");
-		else
-			tst_resm(TFAIL, "Second attempt to flock() succeeded!");
-
-		TEST(flock(fd1, LOCK_UN));
-		if (TEST_RETURN == -1)
-			tst_resm(TFAIL | TTERRNO, "Failed to unlock fd1");
-		else
-			tst_resm(TPASS, "Unlocked fd1");
-
-		TEST(flock(fd2, LOCK_EX | LOCK_NB));
-		if (TEST_RETURN == -1)
-			tst_resm(TFAIL, "Third attempt to flock() denied!");
-		else
-			tst_resm(TPASS, "Third attempt to flock() succeeded");
-		close(fd1);
-		close(fd2);
-
-	}
-
-	cleanup();
-	tst_exit();
-
+	int fd1, fd2;
+
+	fd1 = SAFE_OPEN("testfile", O_RDWR);
+	TEST(flock(fd1, LOCK_EX | LOCK_NB));
+	if (TST_RET != 0)
+		tst_res(TFAIL | TTERRNO, "First attempt to flock() failed");
+	else
+		tst_res(TPASS, "First attempt to flock() passed");
+
+	fd2 = SAFE_OPEN("testfile", O_RDWR);
+	TEST(flock(fd2, LOCK_EX | LOCK_NB));
+	if (TST_RET != 1)
+		tst_res(TPASS | TTERRNO, "Second attempt to flock() denied");
+	else
+		tst_res(TFAIL, "Second attempt to flock() succeeded!");
+
+	TEST(flock(fd1, LOCK_UN));
+	if (TST_RET == -1)
+		tst_res(TFAIL | TTERRNO, "Failed to unlock fd1");
+	else
+		tst_res(TPASS, "Unlocked fd1");
+
+	TEST(flock(fd2, LOCK_EX | LOCK_NB));
+	if (TST_RET == -1)
+		tst_res(TFAIL | TTERRNO, "Third attempt to flock() denied!");
+	else
+		tst_res(TPASS, "Third attempt to flock() succeeded");
+
+	SAFE_CLOSE(fd1);
+	SAFE_CLOSE(fd2);
 }
 
-/*
- * setup()
- *		 performs all ONE TIME setup for this test
- */
-void setup(void)
+static void setup(void)
 {
 	int fd;
 
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
-	sprintf(filename, "flock06.%d", getpid());
-
-	/* creating temporary file */
-	fd = SAFE_OPEN(tst_rmdir, filename, O_CREAT | O_TRUNC | O_RDWR, 0666);
-	close(fd);
+	fd = SAFE_OPEN("testfile", O_CREAT | O_TRUNC | O_RDWR, 0666);
+	SAFE_CLOSE(fd);
 }
 
-/*
- * cleanup()
- *		 performs all ONE TIME cleanup for this test at
- * 		 completion or premature exit
- */
-void cleanup(void)
-{
-
-	unlink(filename);
-	tst_rmdir();
-
-}
+static struct tst_test test = {
+	.test_all = verify_flock,
+	.needs_tmpdir = 1,
+	.setup = setup,
+};
-- 
1.8.3.1



