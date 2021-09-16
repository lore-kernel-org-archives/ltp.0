From: QI Fuli <fukuri.sai@gmail.com>
Date: Thu, 16 Sep 2021 19:49:31 +0900
Subject: [LTP] [PATCH v3 3/5] syscalls/dup2/dup203: Convert to new API
In-Reply-To: <20210916104933.33409-1-qi.fuli@fujitsu.com>
References: <20210916104933.33409-1-qi.fuli@fujitsu.com>
Message-ID: <20210916104933.33409-4-qi.fuli@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: QI Fuli <qi.fuli@fujitsu.com>

Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
---
 testcases/kernel/syscalls/dup2/dup203.c | 307 ++++++++++--------------
 1 file changed, 121 insertions(+), 186 deletions(-)

diff --git a/testcases/kernel/syscalls/dup2/dup203.c b/testcases/kernel/syscalls/dup2/dup203.c
index e6f281adf..86ad49dc1 100644
--- a/testcases/kernel/syscalls/dup2/dup203.c
+++ b/testcases/kernel/syscalls/dup2/dup203.c
@@ -1,208 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
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
+ * Copyright (c) International Business Machines  Corp., 2001
+ * 	07/2001 Ported by Wayne Boyer
  */
 
-/*
- * NAME
- *	dup203.c
- *
- * DESCRIPTION
+/*\
+ * [Description]
  *	Testcase to check the basic functionality of dup2().
- *
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
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- *	NONE
+ *	1. Attempt to dup2() on an open file descriptor.
+ *	2. Attempt to dup2() on a close file descriptor.
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
+
+static int fd0, fd1, fd2;
+static char filename0[40], filename1[40];
+static char buf[40];
+
+static void verify_open(void);
+static void verify_close(void);
+
+static struct tcase {
+	char *desc;
+	void (*verify)();
+} tcases [] = {
+	{"Test duping over an open fd", verify_open},
+	{"Test close on exec flag", verify_close},
+};
+
+static void verify_open(void)
+{
+	fd0 = SAFE_CREAT(filename0, 0666);
+	SAFE_WRITE(1, fd0, filename0, strlen(filename0));
+	SAFE_CLOSE(fd0);
 
-void setup(void);
-void cleanup(void);
+	fd1 = SAFE_CREAT(filename1, 0666);
+	SAFE_WRITE(1, fd1, filename1, strlen(filename1));
+	SAFE_CLOSE(fd1);
 
-char *TCID = "dup203";
-int TST_TOTAL = 1;
+	fd0 = SAFE_OPEN(filename0, O_RDONLY);
+	fd1 = SAFE_OPEN(filename1, O_RDONLY);
 
-int main(int ac, char **av)
-{
-	int fd0, fd1, fd2, rval;
-	char filename0[40], filename1[40];
-	char buf[40];
-
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-//block1:
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
-		}
-
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
-
-		sprintf(filename0, "dup02.%d\n", getpid());
-		unlink(filename0);
-
-		if ((fd0 = creat(filename0, 0666)) == -1) {
-			tst_brkm(TBROK, cleanup, "Cannot create first file");
-		}
-		if (fcntl(fd0, F_SETFD, 1) == -1) {
-			tst_brkm(TBROK, cleanup, "setting close on exec flag "
-				 "on fd0 failed");
-		}
-
-		if ((fd2 = creat(filename1, 0666)) == -1) {
-			tst_brkm(TBROK, cleanup, "Cannot create second file");
-		}
-
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
-		}
-
-		close(fd0);
-		close(fd1);
-
-		unlink(filename0);
-		unlink(filename1);
-		tst_resm(TINFO, "Exit block 2");
+	TEST(dup2(fd0, fd1));
+
+	fd2 = TST_RET;
+	if (TST_RET == -1) {
+		tst_res(TFAIL, "call failed unexpectedly");
+		goto free;
 	}
 
-	cleanup();
-	tst_exit();
+	if (fd1 != fd2) {
+		tst_res(TFAIL, "file descriptors don't match");
+		goto free;
+	}
+
+	memset(buf, 0, sizeof(buf));
+	SAFE_READ(0, fd2, buf, sizeof(buf));
+	if (strcmp(buf, filename0) != 0)
+		tst_res(TFAIL, "read from file got bad data");
+	else
+		tst_res(TPASS, "dup2 test 1 functionality is correct");
+
+free:
+	SAFE_CLOSE(fd0);
+	SAFE_CLOSE(fd1);
+	SAFE_UNLINK(filename0);
+	SAFE_UNLINK(filename1);
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
+static void verify_close(void)
 {
+	int rval, rc = 0;
+
+	sprintf(filename0, "dup203.%d\n", getpid());
+	unlink(filename0);
+
+	fd0 = SAFE_CREAT(filename0, 0666);
+	SAFE_FCNTL(fd0, F_SETFD, 1);
+
+	fd2 = SAFE_CREAT(filename1, 0666);
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	/* SAFE_CLOSE() sets the fd to -1 avoid it here */
+	rval = fd2;
+	SAFE_CLOSE(rval);
 
-	TEST_PAUSE;
+	TEST(dup2(fd0, fd2));
 
-	tst_tmpdir();
+	fd1 = TST_RET;
+	if (TST_RET == -1) {
+		tst_res(TFAIL, "call failed unexpectedly");
+		goto free;
+	}
+
+	if (fd1 != fd2) {
+		tst_res(TFAIL, "bad dup2 descriptor %d", fd1);
+		goto free;
+	}
+
+	rval = SAFE_FCNTL(fd1, F_GETFD, 0);
+	if (rval != 0) {
+		tst_res(TFAIL, "fcntl F_GETFD on fd1 failed; expected a "
+			"return value of 0x0, got %#x", rval);
+		rc++;
+	}
+
+	if (!rc)
+		tst_res(TPASS, "dup2 test 2 functionality is correct");
+
+free:
+	SAFE_CLOSE(fd0);
+	SAFE_CLOSE(fd1);
+	SAFE_UNLINK(filename0);
+	SAFE_UNLINK(filename1);
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- */
-void cleanup(void)
+static void run(unsigned int i)
 {
-	tst_rmdir();
+	struct tcase *tc = tcases + i;
+
+	tst_res(TINFO, tc->desc);
+	tc->verify();
+
+}
+
+static void setup(void)
+{
+	int pid;
+
+	pid = getpid();
+	sprintf(filename0, "dup203.file0.%d\n", pid);
+	sprintf(filename1, "dup203.file1.%d\n", pid);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_tmpdir = 1,
+	.test = run,
+};
-- 
2.31.1

