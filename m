From: QI Fuli <fukuri.sai@gmail.com>
Date: Thu,  2 Sep 2021 20:58:47 +0900
Subject: [LTP] [PATCH 3/5] syscalls/dup2/dup203: Convert dup203 to the new
 API
In-Reply-To: <20210902115849.72382-1-qi.fuli@fujitsu.com>
References: <20210902115849.72382-1-qi.fuli@fujitsu.com>
Message-ID: <20210902115849.72382-4-qi.fuli@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: QI Fuli <qi.fuli@fujitsu.com>

Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
---
 testcases/kernel/syscalls/dup2/dup203.c | 291 +++++++++---------------
 1 file changed, 112 insertions(+), 179 deletions(-)

diff --git a/testcases/kernel/syscalls/dup2/dup203.c b/testcases/kernel/syscalls/dup2/dup203.c
index e6f281adf..a2cbcc8f9 100644
--- a/testcases/kernel/syscalls/dup2/dup203.c
+++ b/testcases/kernel/syscalls/dup2/dup203.c
@@ -1,208 +1,141 @@
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
+// SPDX-License-Identifier: GPL-2.0-or-later
 
 /*
- * NAME
- *	dup203.c
+ * Copyright (c) International Business Machines  Corp., 2001
  *
- * DESCRIPTION
+ * DESCRIPTION:
  *	Testcase to check the basic functionality of dup2().
+ *	1. Attempt to dup2() on an open file descriptor.
+ *	2. Attempt to dup2() on a close file descriptor.
  *
- * ALGORITHM
- *	1.	Attempt to dup2() on an open file descriptor.
- *	2.	Attempt to dup2() on a close file descriptor.
- *
- * USAGE:  <for command-line>
- *  dup203 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * HISTORY
+ * HISTORY:
  *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- *	NONE
  */
 
-#include <fcntl.h>
-#include <sys/param.h>
 #include <errno.h>
-#include <string.h>
-#include "test.h"
-#include "safe_macros.h"
+#include <stdio.h>
+#include "tst_test.h"
+#include "tst_safe_macros.h"
 
-void setup(void);
-void cleanup(void);
-
-char *TCID = "dup203";
-int TST_TOTAL = 1;
-
-int main(int ac, char **av)
+static void run(void)
 {
 	int fd0, fd1, fd2, rval;
 	char filename0[40], filename1[40];
 	char buf[40];
 
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
 //block1:
-		tst_resm(TINFO, "Enter block 1");
-		tst_resm(TINFO, "Test duping over an open fd");
-
-		sprintf(filename0, "dup202.file0.%d\n", getpid());
-		sprintf(filename1, "dup202.file1.%d\n", getpid());
-		unlink(filename0);
-		unlink(filename1);
-
-		if ((fd0 = creat(filename0, 0666)) == -1)
-			tst_brkm(TBROK, cleanup, "cannot create first file");
-		if (write(fd0, filename0, strlen(filename0)) == -1)
-			tst_brkm(TBROK, cleanup, "filename0: write(2) failed");
-
-		if ((fd1 = creat(filename1, 0666)) == -1)
-			tst_brkm(TBROK, cleanup, "Cannot create second file");
-		if (write(fd1, filename1, strlen(filename1)) == -1)
-			tst_brkm(TBROK, cleanup, "filename1: write(2) failed");
-
-		SAFE_CLOSE(cleanup, fd0);
-		if ((fd0 = open(filename0, O_RDONLY)) == -1)
-			tst_brkm(TBROK, cleanup, "open(2) on filename0 failed");
-
-		SAFE_CLOSE(cleanup, fd1);
-		if ((fd1 = open(filename1, O_RDONLY)) == -1)
-			tst_brkm(TBROK, cleanup, "open(2) on filename1 failed");
-
-		TEST(dup2(fd0, fd1));
-
-		if ((fd2 = TEST_RETURN) == -1) {
-			tst_resm(TFAIL, "call failed unexpectedly");
-		} else {
-			if (fd1 != fd2) {
-				tst_resm(TFAIL, "file descriptors don't match");
-				break;
-			}
-
-			memset(buf, 0, sizeof(buf));
-			if (read(fd2, buf, sizeof(buf)) == -1)
-				tst_brkm(TBROK, cleanup, "read(2) failed");
-			if (strcmp(buf, filename0) != 0)
-				tst_resm(TFAIL, "read from file got bad data");
-			tst_resm(TPASS, "dup2 test 1 functionality is correct");
+	tst_res(TINFO, "Enter block 1");
+	tst_res(TINFO, "Test duping over an open fd");
+
+	sprintf(filename0, "dup202.file0.%d\n", getpid());
+	sprintf(filename1, "dup202.file1.%d\n", getpid());
+	unlink(filename0);
+	unlink(filename1);
+
+	fd0 = creat(filename0, 0666);
+	if (fd0 == -1)
+		tst_brk(TBROK, "cannot create first file");
+	if (write(fd0, filename0, strlen(filename0)) == -1)
+		tst_brk(TBROK, "filename0: write(2) failed");
+
+	fd1 = creat(filename1, 0666);
+	if (fd1 == -1)
+		tst_brk(TBROK, "Cannot create second file");
+	if (write(fd1, filename1, strlen(filename1)) == -1)
+		tst_brk(TBROK, "filename1: write(2) failed");
+
+	SAFE_CLOSE(fd0);
+	fd0 = open(filename0, O_RDONLY);
+	if (fd0 == -1)
+		tst_brk(TBROK, "open(2) on filename0 failed");
+
+	SAFE_CLOSE(fd1);
+	fd1 = open(filename1, O_RDONLY);
+	if (fd1 == -1)
+		tst_brk(TBROK, "open(2) on filename1 failed");
+
+	TEST(dup2(fd0, fd1));
+
+	fd2 = TST_RET;
+	if (fd2 == -1)
+		tst_res(TFAIL, "call failed unexpectedly");
+	else {
+		if (fd1 != fd2) {
+			tst_res(TFAIL, "file descriptors don't match");
+			return;
 		}
 
-		close(fd0);
-		close(fd1);
-		close(fd2);
-		unlink(filename0);
-		unlink(filename1);
-
-		tst_resm(TINFO, "Exit block 1");
-
-//block2:
-		tst_resm(TINFO, "Enter block 2");
-		tst_resm(TINFO, "Test close on exec flag");
+		memset(buf, 0, sizeof(buf));
+		if (read(fd2, buf, sizeof(buf)) == -1)
+			tst_brk(TBROK, "read(2) failed");
+		if (strcmp(buf, filename0) != 0)
+			tst_res(TFAIL, "read from file got bad data");
+		tst_res(TPASS, "dup2 test 1 functionality is correct");
+	}
 
-		sprintf(filename0, "dup02.%d\n", getpid());
-		unlink(filename0);
+	close(fd0);
+	close(fd1);
+	close(fd2);
+	unlink(filename0);
+	unlink(filename1);
 
-		if ((fd0 = creat(filename0, 0666)) == -1) {
-			tst_brkm(TBROK, cleanup, "Cannot create first file");
-		}
-		if (fcntl(fd0, F_SETFD, 1) == -1) {
-			tst_brkm(TBROK, cleanup, "setting close on exec flag "
-				 "on fd0 failed");
-		}
+	tst_res(TINFO, "Exit block 1");
 
-		if ((fd2 = creat(filename1, 0666)) == -1) {
-			tst_brkm(TBROK, cleanup, "Cannot create second file");
+//block2:
+	tst_res(TINFO, "Enter block 2");
+	tst_res(TINFO, "Test close on exec flag");
+
+	sprintf(filename0, "dup02.%d\n", getpid());
+	unlink(filename0);
+
+	fd0 = creat(filename0, 0666);
+	if (fd0 == -1)
+		tst_brk(TBROK, "Cannot create first file");
+	if (fcntl(fd0, F_SETFD, 1) == -1)
+		tst_brk(TBROK, "setting close on exec flag on fd0 failed");
+
+	fd2 = creat(filename1, 0666);
+	if (fd2 == -1)
+		tst_brk(TBROK, "Cannot create second file");
+
+	/* SAFE_CLOSE() sets the fd to -1 avoid it here */
+	rval = fd2;
+	SAFE_CLOSE(rval);
+
+	TEST(dup2(fd0, fd2));
+
+	fd1 = TST_RET;
+	if (fd1 == -1)
+		tst_res(TFAIL, "call failed unexpectedly");
+	else {
+		if (fd1 != fd2) {
+			tst_res(TFAIL, "bad dup2 descriptor %d", fd1);
+			return;
 		}
 
-		/* SAFE_CLOSE() sets the fd to -1 avoid it here */
-		rval = fd2;
-		SAFE_CLOSE(cleanup, rval);
-
-		TEST(dup2(fd0, fd2));
-
-		if ((fd1 = TEST_RETURN) == -1) {
-			tst_resm(TFAIL, "call failed unexpectedly");
-		} else {
-			if (fd1 != fd2) {
-				tst_resm(TFAIL, "bad dup2 descriptor %d", fd1);
-				break;
-			}
-
-			if ((rval = fcntl(fd1, F_GETFD, 0)) != 0) {
-				tst_resm(TBROK | TERRNO,
-					 "fcntl F_GETFD on fd1 failed; expected a "
-					 "return value of 0x0, got %#x", rval);
-				break;
-			}
-			if ((rval = (fcntl(fd0, F_GETFL, 0) & O_ACCMODE)) !=
-			    O_WRONLY) {
-				tst_resm(TFAIL, "fctnl F_GETFL bad rval on fd0 "
-					 "Expected %#x got %#x", O_WRONLY,
-					 rval);
-			}
-			tst_resm(TPASS, "dup2 test 2 functionality is correct");
+		rval = fcntl(fd1, F_GETFD, 0);
+		if (rval != 0) {
+			tst_res(TFAIL | TERRNO,
+				"fcntl F_GETFD on fd1 failed; expected a "
+				"return value of 0x0, got %#x", rval);
+			return;
 		}
-
-		close(fd0);
-		close(fd1);
-
-		unlink(filename0);
-		unlink(filename1);
-		tst_resm(TINFO, "Exit block 2");
+		rval = fcntl(fd0, F_GETFL, 0);
+		if ((rval & O_ACCMODE) != O_WRONLY)
+			tst_res(TFAIL, "fctnl F_GETFL bad rval on fd0 "
+				"Expected %#x got %#x", O_WRONLY, rval);
+		tst_res(TPASS, "dup2 test 2 functionality is correct");
 	}
 
-	cleanup();
-	tst_exit();
-}
+	close(fd0);
+	close(fd1);
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
-{
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
+	unlink(filename0);
+	unlink(filename1);
+	tst_res(TINFO, "Exit block 2");
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- */
-void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.test_all = run,
+};
-- 
2.31.1

