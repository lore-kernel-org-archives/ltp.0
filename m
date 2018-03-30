From: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
Date: Fri, 30 Mar 2018 18:56:43 +0800
Subject: [LTP] [PATCH 2/3] syscalls/fchmod01.c: Convert to new API && merge
	fchmod07 into fchmod01
In-Reply-To: <1522407404-6877-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1522407404-6877-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <1522407404-6877-2-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
---
 runtest/ltplite                             |   1 -
 runtest/stress.part3                        |   1 -
 runtest/syscalls                            |   1 -
 testcases/kernel/syscalls/.gitignore        |   1 -
 testcases/kernel/syscalls/fchmod/fchmod01.c | 182 ++++++--------------------
 testcases/kernel/syscalls/fchmod/fchmod07.c | 192 ----------------------------
 6 files changed, 41 insertions(+), 337 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/fchmod/fchmod07.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 15dc0c2..dd8dc96 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -191,7 +191,6 @@ fchmod03 fchmod03
 fchmod04 fchmod04
 fchmod05 fchmod05
 fchmod06 fchmod06
-fchmod07 fchmod07
 
 fchown01 fchown01
 fchown02 fchown02
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 2a7747c..9eeae83 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -132,7 +132,6 @@ fchmod03 fchmod03
 fchmod04 fchmod04
 fchmod05 fchmod05
 fchmod06 fchmod06
-fchmod07 fchmod07
 
 fchown01 fchown01
 fchown02 fchown02
diff --git a/runtest/syscalls b/runtest/syscalls
index 76ab082..83bd90b 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -184,7 +184,6 @@ fchmod03 fchmod03
 fchmod04 fchmod04
 fchmod05 fchmod05
 fchmod06 fchmod06
-fchmod07 fchmod07
 
 #fchmodat test cases
 fchmodat01 fchmodat01
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index eea606e..41ca097 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -153,7 +153,6 @@
 /fchmod/fchmod04
 /fchmod/fchmod05
 /fchmod/fchmod06
-/fchmod/fchmod07
 /fchmodat/fchmodat01
 /fchown/fchown01
 /fchown/fchown01_16
diff --git a/testcases/kernel/syscalls/fchmod/fchmod01.c b/testcases/kernel/syscalls/fchmod/fchmod01.c
index dd4a28c..062290c 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod01.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod01.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ * Author: Wayne Boyer and William Roske
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of version 2 of the GNU General Public License as
@@ -15,167 +16,66 @@
  * otherwise, applies only to this software file.  Patent licenses, if
  * any, provided herein do not apply to combinations of this program with
  * other software, or any other product whatsoever.
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
  */
-/* $Id: fchmod01.c,v 1.6 2009/10/26 14:55:46 subrata_modak Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: fchmod01
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
- * 	1.) fchmod(2) returns...(See Description)
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
- *	This is a Phase I test for the fchmod(2) system call.  It is intended
- *	to provide a limited exposure of the system call, for now.  It
- *	should/will be extended when full functional tests are written for
- *	fchmod(2).
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
+/*
+ * Test Description:
+ *  fchmod() will succeed to change the mode permissions of a file specified
+ *  by file descriptor.
+ */
 
 #include <sys/types.h>
-#include <fcntl.h>
 #include <sys/stat.h>
+#include <unistd.h>
 #include <errno.h>
-#include <signal.h>
-#include <string.h>
-#include "test.h"
-
-void setup();
-void cleanup();
 
-char *TCID = "fchmod01";
-int TST_TOTAL = 1;
+#include "tst_test.h"
+#include "fchmod.h"
 
-char fname[255];
-int fd;
-char *buf = "davef";
+static int fd;
+static int Modes[] = { 0, 07, 070, 0700, 0777, 02777, 04777, 06777 };
 
-int main(int ac, char **av)
+static void verify_fchmod(void)
 {
-	int lc;
+	struct stat stat_buf;
+	int ind;
+	mode_t file_mode, mode;
 
-	tst_parse_opts(ac, av, NULL, NULL);
+	for (ind = 0; ind < 8; ind++) {
+		mode = (mode_t)Modes[ind];
 
-	setup();
+		TEST(fchmod(fd, mode));
+		if (TEST_RETURN == -1)
+			tst_res(TFAIL | TTERRNO, "fchmod() failed unexpectly");
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		SAFE_FSTAT(fd, &stat_buf);
+		file_mode = stat_buf.st_mode;
 
-		tst_count = 0;
-
-		TEST(fchmod(fd, 0700));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TTERRNO,
-				 "fchmod(%s, 0700) failed", fname);
+		if ((file_mode & ~S_IFREG) != mode) {
+			tst_res(TFAIL,
+				"%s: Incorrect modes 0%03o, Expected 0%03o",
+				TESTFILE, file_mode & ~S_IFREG, mode);
 		} else {
-			tst_resm(TPASS, "fchmod(%s, 0700) returned %ld",
-				 fname, TEST_RETURN);
+			tst_res(TPASS,
+				"Functionality of fchmod(%d, %#o) successful",
+				fd, mode);
 		}
-
 	}
-
-	cleanup();
-	tst_exit();
 }
 
-void setup(void)
+static void setup(void)
 {
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	sprintf(fname, "tfile_%d", getpid());
-	if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "open failed");
-	else if (write(fd, buf, strlen(buf)) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "write failed");
+	fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, FILE_MODE);
 }
 
-/***************************************************************
- * cleanup() - performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- ***************************************************************/
-void cleanup(void)
+static void cleanup(void)
 {
-	if (close(fd) == -1)
-		tst_brkm(TWARN | TERRNO, cleanup, "close failed");
-
-	tst_rmdir();
-
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }
+
+static struct tst_test test = {
+	.test_all = verify_fchmod,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+};
diff --git a/testcases/kernel/syscalls/fchmod/fchmod07.c b/testcases/kernel/syscalls/fchmod/fchmod07.c
deleted file mode 100644
index d7fe41f..0000000
--- a/testcases/kernel/syscalls/fchmod/fchmod07.c
+++ /dev/null
@@ -1,192 +0,0 @@
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
- * Test Name: fchmod07
- *
- * Test Description:
- *  Verify that, fchmod(2) succeeds when used to change the mode permissions
- *  of a file specified by file descriptor.
- *
- * Expected Result:
- *  fchmod(2) should return 0 and the mode permissions set on file should match
- *  the specified mode.
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
- *  fchmod07 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
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
- *  None.
- */
-
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
-#include "fchmod.h"
-
-int fd;				/* file descriptor for testfile */
-char *TCID = "fchmod07";
-int TST_TOTAL = 8;		/* Total number of test conditions */
-
-mode_t Modes[] = { 0, 07, 070, 0700, 0777, 02777, 04777, 06777 };
-
-void setup();			/* setup function for the test */
-void cleanup();			/* cleanup function for the test */
-
-int main(int ac, char **av)
-{
-	struct stat stat_buf;	/* stat(2) struct contents */
-	int lc;
-	int ind;		/* counter variable for chmod(2) tests */
-	mode_t mode;		/* file mode permission */
-
-	TST_TOTAL = sizeof(Modes) / sizeof(int);
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		for (ind = 0; ind < TST_TOTAL; ind++) {
-			mode = Modes[ind];
-
-			/*
-			 * Call fchmod(2) with different mode permission
-			 * bits to set it for "testfile".
-			 */
-			TEST(fchmod(fd, mode));
-
-			if (TEST_RETURN == -1) {
-				tst_resm(TFAIL, "fchmod(%d, %#o) Failed, "
-					 "errno=%d : %s", fd, mode, TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-				continue;
-			}
-			/*
-			 * Get the testfile information using
-			 * fstat(2).
-			 */
-			if (fstat(fd, &stat_buf) < 0) {
-				tst_brkm(TFAIL, cleanup,
-					 "fstat(2) of "
-					 "%s failed, errno:%d",
-					 TESTFILE, TEST_ERRNO);
-			}
-			stat_buf.st_mode &= ~S_IFREG;
-
-			/*
-			 * Check for expected mode permissions
-			 * on testfile.
-			 */
-			if (stat_buf.st_mode == mode) {
-				tst_resm(TPASS,
-					 "Functionality of "
-					 "fchmod(%d, %#o) successful",
-					 fd, mode);
-			} else {
-				tst_resm(TFAIL, "%s: Incorrect modes "
-					 "0%03o, Expected 0%03o",
-					 TESTFILE, stat_buf.st_mode,
-					 mode);
-			}
-		}
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-/*
- * void
- * setup() - performs all ONE TIME setup for this test.
- *  Create a temporary directory and change directory to it.
- *  Create a test file under temporary directory.
- */
-void setup(void)
-{
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	if ((fd = open(TESTFILE, O_RDWR | O_CREAT, FILE_MODE)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "open(%s, O_RDWR|O_CREAT, %o) Failed, errno=%d : %s",
-			 TESTFILE, FILE_MODE, errno, strerror(errno));
-	}
-}
-
-/*
- * void
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- *  Close the testfile created in the setup.
- *  Remove the test directory and testfile created in the setup.
- */
-void cleanup(void)
-{
-
-	/* Close the TESTFILE opened in the setup() */
-	SAFE_CLOSE(NULL, fd);
-
-	tst_rmdir();
-
-}
-- 
1.8.3.1



