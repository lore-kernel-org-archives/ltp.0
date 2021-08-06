From: zhanglianjie <zhanglianjie@uniontech.com>
Date: Fri,  6 Aug 2021 15:23:38 +0800
Subject: [LTP] [PATCH 1/4] syscalls/chmod01: Convert to new API
Message-ID: <20210806072338.8240-1-zhanglianjie@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>

diff --git a/testcases/kernel/syscalls/chmod/chmod01.c b/testcases/kernel/syscalls/chmod/chmod01.c
index 55ddf8a73..15d975be5 100644
--- a/testcases/kernel/syscalls/chmod/chmod01.c
+++ b/testcases/kernel/syscalls/chmod/chmod01.c
@@ -1,24 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *   Copyright (c) International Business Machines  Corp., 2001
+ *   07/2001 Ported by Wayne Boyer
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
  */

-/*
- * Test Name: chmod01
+/*\
+ * [Description
  *
  * Test Description:
  *  Verify that, chmod(2) succeeds when used to change the mode permissions
@@ -28,132 +17,50 @@
  *  chmod(2) should return 0 and the mode permissions set on file should match
  *  the specified mode.
  *
- * Algorithm:
- *  Setup:
- *   Setup signal handling.
- *   Create temporary directory.
- *   Pause for SIGUSR1 if option specified.
- *
- *  Test:
- *   Loop if the proper options are given.
- *   Execute system call
- *   Check return code, if system call failed (return=-1)
- *   	Log the errno and Issue a FAIL message.
- *   Otherwise,
- *   	Verify the Functionality of system call
- *      if successful,
- *      	Issue Functionality-Pass message.
- *      Otherwise,
- *		Issue Functionality-Fail message.
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *   Delete the temporary directory created.
- *
- * Usage:  <for command-line>
- *  chmod01 [-c n] [-e] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *             -f   : Turn off functionality Testing.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS:
- *  None.
- *
  */

-#include <stdio.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"

 #define FILE_MODE	S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
 #define TESTFILE	"testfile"

-char *TCID = "chmod01";
-int TST_TOTAL = 8;
-
-int modes[] = { 0, 07, 070, 0700, 0777, 02777, 04777, 06777 };
+static int modes[] = { 0, 07, 070, 0700, 0777, 02777, 04777, 06777 };

-void setup();
-void cleanup();
-
-int main(int ac, char **av)
+static void verify_chmod(unsigned int n)
 {
 	struct stat stat_buf;
-	int lc;
-	int i;
-	int mode;
-
-	TST_TOTAL = sizeof(modes) / sizeof(int);
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-			mode = modes[i];
-
-			TEST(chmod(TESTFILE, mode));
-
-			if (TEST_RETURN == -1) {
-				tst_resm(TFAIL | TTERRNO,
-					 "chmod(%s, %#o) failed", TESTFILE,
-					 mode);
-				continue;
-			}
-			if (stat(TESTFILE, &stat_buf) < 0)
-				tst_brkm(TFAIL | TERRNO, cleanup,
-					 "stat(%s) failed", TESTFILE);
-			stat_buf.st_mode &= ~S_IFREG;
-
-			if (stat_buf.st_mode == (unsigned int)mode)
-				tst_resm(TPASS, "Functionality of "
-					 "chmod(%s, %#o) successful",
-					 TESTFILE, mode);
-			else
-				tst_resm(TFAIL, "%s: Incorrect "
-					 "modes 0%03o, Expected 0%03o",
-					 TESTFILE, stat_buf.st_mode,
-					 mode);
-		}
+	int mode = modes[n];
+
+	TST_EXP_PASS_SILENT(chmod(TESTFILE, mode), "chmod(%s, %#o) failed",
+	TESTFILE, mode);
+	if (TST_PASS) {
+		SAFE_STAT(TESTFILE, &stat_buf);
+		stat_buf.st_mode &= ~S_IFREG;
+
+		if (stat_buf.st_mode == (unsigned int)mode)
+			tst_res(TPASS, "Functionality of "
+					"chmod(%s, %#o) successful",
+					TESTFILE, mode);
+		else
+			tst_res(TFAIL, "%s: Incorrect "
+					"modes 0%03o, Expected 0%03o",
+					TESTFILE, stat_buf.st_mode,
+					mode);
 	}
-
-	cleanup();
-	tst_exit();
 }

-void setup(void)
+static void setup(void)
 {
 	int fd;
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	fd = SAFE_OPEN(cleanup, TESTFILE, O_RDWR | O_CREAT, FILE_MODE);
-	SAFE_CLOSE(cleanup, fd);
-
+	fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, FILE_MODE);
+	SAFE_CLOSE(fd);
 }

-void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.setup = setup,
+	.tcnt = ARRAY_SIZE(modes),
+	.test = verify_chmod,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+};
+
--
2.20.1



