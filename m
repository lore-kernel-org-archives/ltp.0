From: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
Date: Mon, 12 Feb 2018 18:21:36 +0800
Subject: [LTP] [PATCH 2/4] syscalls/readlink01.c: Cleanup && Convert to new
	API
In-Reply-To: <1518430898-13225-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1518430898-13225-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <1518430898-13225-2-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) Take use of some safe macros
2) Merge readlink02 into readlink01

Signed-off-by: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
---
 runtest/ltplite                                 |   1 -
 runtest/quickhit                                |   2 -
 runtest/stress.part3                            |   1 -
 runtest/syscalls                                |   1 -
 testcases/kernel/syscalls/.gitignore            |   1 -
 testcases/kernel/syscalls/readlink/readlink01.c | 216 +++++-------------------
 testcases/kernel/syscalls/readlink/readlink02.c | 210 -----------------------
 7 files changed, 44 insertions(+), 388 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/readlink/readlink02.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 5418495..cbc748b 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -623,7 +623,6 @@ readdir21 readdir21
 
 readlink01A symlink01 -T readlink01
 readlink01 readlink01
-readlink02 readlink02
 readlink03 readlink03
 readlink04 readlink04
 
diff --git a/runtest/quickhit b/runtest/quickhit
index 2a42769..6070ec0 100644
--- a/runtest/quickhit
+++ b/runtest/quickhit
@@ -195,8 +195,6 @@ readdir01 readdir01
 # write multiple files and try to find them with readdir
 #    TEST CASES
 # 	1.) Create n files and check that readdir() finds n files
-readlink02 readlink02
-# Basic test for readlink(2)
 rename02 rename02
 # Basic test for rename(2)
 rmdir04 rmdir04
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 242b696..ba83b65 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -528,7 +528,6 @@ readdir21 readdir21
 
 readlink01A symlink01 -T readlink01
 readlink01 readlink01
-readlink02 readlink02
 readlink03 readlink03
 readlink04 readlink04
 
diff --git a/runtest/syscalls b/runtest/syscalls
index 2a4fad0..72fbacf 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -882,7 +882,6 @@ readdir21 readdir21
 
 readlink01A symlink01 -T readlink01
 readlink01 readlink01
-readlink02 readlink02
 readlink03 readlink03
 readlink04 readlink04
 
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 67211ca..8b23a85 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -738,7 +738,6 @@
 /readdir/readdir21
 /readlink/creat_slink
 /readlink/readlink01
-/readlink/readlink02
 /readlink/readlink03
 /readlink/readlink04
 /readlinkat/readlinkat01
diff --git a/testcases/kernel/syscalls/readlink/readlink01.c b/testcases/kernel/syscalls/readlink/readlink01.c
index 5f6448a..9f81876 100644
--- a/testcases/kernel/syscalls/readlink/readlink01.c
+++ b/testcases/kernel/syscalls/readlink/readlink01.c
@@ -1,195 +1,67 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
+ *   07/2001 Ported by Wayne Boyer
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
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  */
 
 /*
- * Test Name : readlink01
- *
  * Test Description :
- *  Verify that, readlink will succeed to read the contents of the symbolic
- *  link created the process.
- *
- * Expected Result:
- *  readlink() should return the contents of symbolic link path in the buffer
- *  on success.
- *
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
- *   	Issue a FAIL message.
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
- *  readlink01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
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
- *  This test should be run by 'non-super-user' only.
- *
+ *   Testcase to check the basic functionality of the readlink(2),
+ *   readlink() will succeed to read the contents of the symbolic link.
  */
-#include <unistd.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <sys/stat.h>
-#include <pwd.h>
 
-#include "test.h"
-#include "safe_macros.h"
-
-#define TESTFILE	"testfile"
-#define SYMFILE		"slink_file"
-#define FILE_MODE       S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
-#define MAX_SIZE	256
-
-char *TCID = "readlink01";
-int TST_TOTAL = 1;
-
-const int exp_val = sizeof(TESTFILE) - 1;	/* strlen of testfile */
-
-void setup();
-void cleanup();
+#include <pwd.h>
+#include <errno.h>
+#include <string.h>
 
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
+#include "tst_test.h"
+#include "readlink.h"
 
-int main(int ac, char **av)
+static void verify_readlink(void)
 {
-	char buffer[MAX_SIZE];	/* temporary buffer to hold symlink contents */
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/*
-		 * Call readlink(2) to read the contents of
-		 * symlink into a buffer.
-		 */
-		TEST(readlink(SYMFILE, buffer, sizeof(buffer)));
+	char buffer[MAX_SIZE];
+	int exp_val = strlen(TESTFILE);
 
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL,
-				 "readlink() on %s failed, errno=%d : %s",
-				 SYMFILE, TEST_ERRNO, strerror(TEST_ERRNO));
-			continue;
-		}
+	TEST(readlink(SYMFILE, buffer, sizeof(buffer)));
+	if (TEST_RETURN == -1) {
+		tst_res(TFAIL | TTERRNO, "readlink() on %s failed", SYMFILE);
+		return;
+	}
 
-		/*
-		 * Compare the return value of readlink()
-		 * with the expected value which is the
-		 * strlen() of testfile.
-		 */
-		if (TEST_RETURN == exp_val) {
-			/* Check for the contents of buffer */
-			if (memcmp(buffer, TESTFILE, exp_val) != 0) {
-				tst_resm(TFAIL, "Pathname %s and buffer"
-					 " contents %s differ",
-					 TESTFILE, buffer);
-			} else {
-				tst_resm(TPASS, "readlink() "
-					 "functionality on '%s' is "
-					 "correct", SYMFILE);
-			}
+	if (TEST_RETURN != exp_val) {
+		tst_res(TFAIL, "readlink() returned value %ld "
+			"did't match, Expected %d", TEST_RETURN, exp_val);
+	} else {
+		if (memcmp(buffer, TESTFILE, exp_val) != 0) {
+			tst_res(TFAIL, "Pathname %s and buffer "
+				"contents %s differ", TESTFILE, buffer);
 		} else {
-			tst_resm(TFAIL, "readlink() return value %ld "
-				 "does't match, Expected %d",
-				 TEST_RETURN, exp_val);
+			tst_res(TPASS, "readlink() functionality on '%s' was "
+				"correct", SYMFILE);
 		}
 	}
-
-	cleanup();
-	tst_exit();
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- *
- *  Create a temporary directory and change directory to it.
- *  Create a test file under temporary directory and close it
- *  Create a symbolic link of testfile.
- */
-void setup(void)
+static void setup(void)
 {
-	int fd;			/* file handle for testfile */
-
-	tst_require_root();
-
-	if ((ltpuser = getpwnam(nobody_uid)) == NULL) {
-		tst_brkm(TBROK, cleanup, "getpwname(nobody_uid) failed ");
-	}
-	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
+	int fd;
 
-	if ((fd = open(TESTFILE, O_RDWR | O_CREAT, FILE_MODE)) == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "open(%s, O_RDWR|O_CREAT, %#o) failed",
-			 TESTFILE, FILE_MODE);
-	}
-
-	if (close(fd) == -1) {
-		tst_resm(TWARN | TERRNO, "close(%s) failed", TESTFILE);
-	}
-
-	/* Create a symlink of testfile under temporary directory */
-	SAFE_SYMLINK(cleanup, TESTFILE, SYMFILE);
+	fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, FILE_MODE);
+	SAFE_CLOSE(fd);
+	SAFE_SYMLINK(TESTFILE, SYMFILE);
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- *
- *  Remove the test directory and testfile created in the setup.
- */
-void cleanup(void)
-{
-
-	tst_rmdir();
-
-}
+static struct tst_test test = {
+	.test_all = verify_readlink,
+	.setup = setup,
+	.needs_tmpdir = 1,
+};
diff --git a/testcases/kernel/syscalls/readlink/readlink02.c b/testcases/kernel/syscalls/readlink/readlink02.c
deleted file mode 100644
index 218a6e3..0000000
--- a/testcases/kernel/syscalls/readlink/readlink02.c
+++ /dev/null
@@ -1,210 +0,0 @@
-/*
- * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
- *
- */
-/* $Id: readlink02.c,v 1.6 2009/11/02 13:57:17 subrata_modak Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: readlink02
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for readlink(2)
- *
- *    PARENT DOCUMENT	: usctpl01
- *
- *    TEST CASE TOTAL	: 1
- *
- *    WALL CLOCK TIME	: 1
- *
- *    CPU TYPES		: ALL
- *
- *    AUTHOR		: William Roske
- *
- *    CO-PILOT		: Dave Fenner
- *
- *    DATE STARTED	: 03/30/92
- *
- *    INITIAL RELEASE	: UNICOS 7.0
- *
- *    TEST CASES
- *
- * 	1.) readlink(2) returns...(See Description)
- *
- *    INPUT SPECIFICATIONS
- * 	The standard options for system call tests are accepted.
- *	(See the parse_opts(3) man page).
- *
- *    OUTPUT SPECIFICATIONS
- *$
- *    DURATION
- * 	Terminates - with frequency and infinite modes.
- *
- *    SIGNALS
- * 	Uses SIGUSR1 to pause before test if option set.
- * 	(See the parse_opts(3) man page).
- *
- *    RESOURCES
- * 	None
- *
- *    ENVIRONMENTAL NEEDS
- *      No run-time environmental needs.
- *
- *    SPECIAL PROCEDURAL REQUIREMENTS
- * 	None
- *
- *    INTERCASE DEPENDENCIES
- * 	None
- *
- *    DETAILED DESCRIPTION
- *	This is a Phase I test for the readlink(2) system call.  It is intended
- *	to provide a limited exposure of the system call, for now.  It
- *	should/will be extended when full functional tests are written for
- *	readlink(2).
- *
- * 	Setup:
- * 	  Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *
- * 	Test:
- *	 Loop if the proper options are given.
- * 	  Execute system call
- *	  Check return code, if system call failed (return=-1)
- *		Log the errno and Issue a FAIL message.
- *	  Otherwise, Issue a PASS message.
- *
- * 	Cleanup:
- * 	  Print errno log and/or timing stats if options given
- *
- *
- *#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#**/
-
-#include <sys/types.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include "test.h"
-
-void setup();
-void cleanup();
-
-char *TCID = "readlink02";
-int TST_TOTAL = 1;
-
-char fname[255], buf[255], symlnk[255];
-int fd;
-
-int main(int ac, char **av)
-{
-	int lc;
-
-    /***************************************************************
-     * parse standard options
-     ***************************************************************/
-	tst_parse_opts(ac, av, NULL, NULL);
-
-    /***************************************************************
-     * perform global setup for test
-     ***************************************************************/
-	setup();
-
-    /***************************************************************
-     * check looping state if -c option given
-     ***************************************************************/
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/*
-		 * Call readlink(2)
-		 */
-		TEST(readlink(symlnk, buf, 255));
-
-		/* check return code */
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL,
-				 "readlink(%s, buf, 255) Failed, errno=%d : %s",
-				 symlnk, TEST_ERRNO, strerror(TEST_ERRNO));
-		} else {
-			tst_resm(TPASS,
-				 "readlink(%s, buf, 255) returned %ld",
-				 symlnk, TEST_RETURN);
-		}
-
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-/***************************************************************
- * setup() - performs all ONE TIME setup for this test.
- ***************************************************************/
-void setup(void)
-{
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	sprintf(fname, "./tfile_%d", getpid());
-	if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "open(%s, O_RDWR|O_CREAT,0700) Failed, errno=%d : %s",
-			 fname, errno, strerror(errno));
-	}
-	if (close(fd) == -1) {
-		tst_resm(TWARN, "close(%s) Failed, errno=%d : %s",
-			 fname, errno, strerror(errno));
-	}
-	sprintf(symlnk, "./sl_%d", getpid());
-	if (symlink(fname, symlnk) == -1) {
-		tst_resm(TWARN, "symlnk(%s, %s) Failed, errno=%d : %s",
-			 fname, symlnk, errno, strerror(errno));
-	}
-
-}
-
-/***************************************************************
- * cleanup() - performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- ***************************************************************/
-void cleanup(void)
-{
-
-	tst_rmdir();
-
-}
-- 
1.8.3.1



