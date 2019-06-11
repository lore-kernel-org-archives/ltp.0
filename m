From: Christian Amann <camann@suse.com>
Date: Tue, 11 Jun 2019 12:47:46 +0200
Subject: [LTP] [PATCH v1 1/2] syscalls/lstat{01,03} rewrote testcase
Message-ID: <20190611104747.14689-1-camann@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Merged lstat01 and lstat03:
	Expanded lstat01 testcase to also include everything
	lstat03 was testing for.
Rewrote testcase:
	Cleaned up and ported to new library.

Signed-off-by: Christian Amann <camann@suse.com>
---
 runtest/syscalls                           |   2 -
 testcases/kernel/syscalls/lstat/.gitignore |   2 -
 testcases/kernel/syscalls/lstat/lstat01.c  | 243 ++++++-----------------------
 testcases/kernel/syscalls/lstat/lstat03.c  | 121 --------------
 4 files changed, 46 insertions(+), 322 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/lstat/lstat03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 702d6a8c7..879290bce 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -621,8 +621,6 @@ lstat01 lstat01
 lstat01_64 lstat01_64
 lstat02 lstat02
 lstat02_64 lstat02_64
-lstat03 lstat03
-lstat03_64 lstat03_64
 
 mallopt01 mallopt01
 
diff --git a/testcases/kernel/syscalls/lstat/.gitignore b/testcases/kernel/syscalls/lstat/.gitignore
index 72cba871f..a497a445f 100644
--- a/testcases/kernel/syscalls/lstat/.gitignore
+++ b/testcases/kernel/syscalls/lstat/.gitignore
@@ -2,5 +2,3 @@
 /lstat01_64
 /lstat02
 /lstat02_64
-/lstat03
-/lstat03_64
diff --git a/testcases/kernel/syscalls/lstat/lstat01.c b/testcases/kernel/syscalls/lstat/lstat01.c
index 45a6176c5..c96365064 100644
--- a/testcases/kernel/syscalls/lstat/lstat01.c
+++ b/testcases/kernel/syscalls/lstat/lstat01.c
@@ -1,218 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ *  Authors:	William Roske, Dave Fenner
  *
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
+ *  06/2019 Ported to new library:
+ *		Christian Amann <camann@suse.com>
  */
-/* $Id: lstat01.c,v 1.7 2009/10/26 14:55:48 subrata_modak Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: lstat01
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for lstat(2)
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
- * 	1.) lstat(2) returns...(See Description)
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
- *	This is a Phase I test for the lstat(2) system call.  It is intended
- *	to provide a limited exposure of the system call, for now.  It
- *	should/will be extended when full functional tests are written for
- *	lstat(2).
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
+/*
+ * Basic test for lstat():
  *
- *#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#**/
+ * Tests if lstat() writes correct information about a symlink
+ * into the stat structure.
+ */
 
-#include <sys/types.h>
-#include <fcntl.h>
-#include <sys/stat.h>
 #include <errno.h>
 #include <string.h>
-#include <signal.h>
-#include "test.h"
-
-void setup();
-void cleanup();
+#include <unistd.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include "tst_test.h"
 
-char *TCID = "lstat01";
-int TST_TOTAL = 1;
+#define TESTFILE        "tst_file"
+#define TESTSYML        "tst_syml"
 
-char fname[255], lname[255], symlnk[255], buf[255];
-int fd;
-struct stat statter;
+static uid_t user_id;
+static gid_t group_id;
+static struct stat stat_buf;
 
-int main(int ac, char **av)
+static void run(void)
 {
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
-		 *  Call lstat(2)
-		 */
-		TEST(lstat(symlnk, &statter));
-
-		/* check return code */
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL,
-				 "lstat(%s, &statter) Failed, errno=%d : %s",
-				 symlnk, TEST_ERRNO, strerror(TEST_ERRNO));
-		} else {
-			tst_resm(TPASS,
-				 "lstat(%s, &statter) returned %ld",
-				 symlnk, TEST_RETURN);
-		}
-
+	TEST(lstat(TESTSYML, &stat_buf));
+	if (TST_RET == -1)
+		tst_res(TFAIL | TTERRNO, "Calling lstat() failed");
+
+	if ((stat_buf.st_mode & S_IFMT) != S_IFLNK ||
+	    stat_buf.st_uid != user_id ||
+	    stat_buf.st_gid != group_id ||
+	    stat_buf.st_size != strlen(TESTFILE)) {
+		tst_res(TFAIL,
+			"lstat() reported incorrect values for the symlink!");
+	} else {
+		tst_res(TPASS,
+			"lstat() reported correct values for the symlink!");
 	}
-
-	cleanup();
-	tst_exit();
 }
 
-/***************************************************************
- * setup() - performs all ONE TIME setup for this test.
- ***************************************************************/
-void setup(void)
+static void setup(void)
 {
+	user_id  = getuid();
+	group_id = getgid();
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	sprintf(fname, "tfile_%d", getpid());
-	if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "open(%s, O_RDWR|O_CREAT,0700) Failed, errno=%d : %s",
-			 fname, errno, strerror(errno));
-	} else if (close(fd) == -1) {
-		tst_resm(TWARN, "close(%s) Failed, errno=%d : %s",
-			 fname, errno, strerror(errno));
-	}
-
-	sprintf(symlnk, "lnfile_%d", getpid());
-	if (symlink(fname, symlnk) == -1) {
-		tst_resm(TWARN, "symlink(%s, %s) Failed, errno=%d : %s",
-			 fname, symlnk, errno, strerror(errno));
-	} else if (readlink(symlnk, buf, 255) == -1) {
-		tst_resm(TWARN, "readlink(%s, buf, 255) Failed, errno=%d : %s",
-			 symlnk, errno, strerror(errno));
-	} else if (strcmp(buf, fname) != 0) {
-		tst_resm(TWARN,
-			 "Setup Failure : Expected symbolic link contents of %s : Actual is %s",
-			 fname, buf);
-	}
+	SAFE_TOUCH(TESTFILE, 0644, NULL);
+	SAFE_SYMLINK(TESTFILE, TESTSYML);
 }
 
-/***************************************************************
- * cleanup() - performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- ***************************************************************/
-void cleanup(void)
+static void cleanup(void)
 {
-
-	tst_rmdir();
-
+	SAFE_UNLINK(TESTSYML);
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+};
diff --git a/testcases/kernel/syscalls/lstat/lstat03.c b/testcases/kernel/syscalls/lstat/lstat03.c
deleted file mode 100644
index f22281283..000000000
--- a/testcases/kernel/syscalls/lstat/lstat03.c
+++ /dev/null
@@ -1,121 +0,0 @@
-/*
- * Copyright (c) International Business Machines  Corp., 2001
- *  07/2001 Ported by Wayne Boyer
- *
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
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-/*
- * Test Name: lstat03
- *
- * Test Description:
- *  Verify that, lstat(2) succeeds to get the status of a file pointed to by
- *  symlink and fills the stat structure elements.
- *
- * Expected Result:
- *  lstat() should return value 0 on success and the stat structure elements
- *  should be filled with the symlink file information.
- */
-#include <stdio.h>
-#include <sys/types.h>
-#include <fcntl.h>
-#include <sys/stat.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include <pwd.h>
-
-#include "test.h"
-#include "safe_macros.h"
-
-#define FILE_MODE	S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
-#define TESTFILE	"testfile"
-#define SFILE		"sfile"
-#define FILE_SIZE       1024
-#define BUF_SIZE	256
-#define PERMS		0644
-
-char *TCID = "lstat03";
-int TST_TOTAL = 1;
-static uid_t user_id;
-static gid_t group_id;
-
-static char nobody_uid[] = "nobody";
-static struct passwd *ltpuser;
-
-static void setup(void);
-static void cleanup(void);
-
-int main(int ac, char **av)
-{
-	struct stat stat_buf;
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		TEST(lstat(SFILE, &stat_buf));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TTERRNO, "lstat(%s) failed", SFILE);
-			continue;
-		}
-
-		if ((stat_buf.st_uid != user_id) ||
-		    (stat_buf.st_gid != group_id) ||
-		    ((stat_buf.st_mode & S_IFMT) != S_IFLNK) ||
-		    (stat_buf.st_size != strlen(TESTFILE))) {
-			tst_resm(TFAIL, "Functionality of lstat(2) on "
-				 "'%s' Failed", SFILE);
-		} else {
-			tst_resm(TPASS, "Functionality of lstat(2) on "
-				 "'%s' Succcessful", SFILE);
-		}
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	tst_require_root();
-
-	ltpuser = SAFE_GETPWNAM(NULL, nobody_uid);
-	SAFE_SETUID(NULL, ltpuser->pw_uid);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	if (tst_fill_file(TESTFILE, 'a', 1024, 1))
-		tst_brkm(TBROK, cleanup, "Failed to create " TESTFILE);
-
-	SAFE_SYMLINK(cleanup, TESTFILE, SFILE);
-
-	user_id = getuid();
-	group_id = getgid();
-}
-
-static void cleanup(void)
-{
-	tst_rmdir();
-}
-- 
2.16.4

