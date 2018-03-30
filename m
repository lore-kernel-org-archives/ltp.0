From: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
Date: Fri, 30 Mar 2018 18:56:44 +0800
Subject: [LTP] [PATCH 3/3] syscalls/fchmod02.c: Cleanup && convert to new API
In-Reply-To: <1522407404-6877-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1522407404-6877-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <1522407404-6877-3-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/fchmod/fchmod02.c | 227 +++++++---------------------
 1 file changed, 53 insertions(+), 174 deletions(-)

diff --git a/testcases/kernel/syscalls/fchmod/fchmod02.c b/testcases/kernel/syscalls/fchmod/fchmod02.c
index aa3bab3..3a7deaa 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod02.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod02.c
@@ -1,27 +1,19 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
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
-
 /*
- * Test Name: fchmod02
- *
  * Test Description:
- *  Verify that, fchmod(2) will succeed to change the mode of a file/directory
+ *  Verify that, fchmod() will succeed to change the mode of a file/directory
  *  set the sticky bit on it if invoked by root (uid = 0) process with
  *  the following constraints,
  *	- the process is not the owner of the file/directory.
@@ -31,182 +23,69 @@
  * Expected Result:
  *  fchmod() should return value 0 on success and succeeds to set sticky bit
  *  on the specified file.
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
- *  fchmod02 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
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
- *  This test should be run by 'super-user' (root) only.
- *
  */
 
-#include <stdio.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include <grp.h>
+#include <unistd.h>
 #include <pwd.h>
+#include <grp.h>
+#include <errno.h>
 
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 #include "fchmod.h"
 
 #define LTPUSER		"nobody"
 #define LTPGRP		"users"
 
-int fd;				/* file descriptor variable */
-char *TCID = "fchmod02";
-int TST_TOTAL = 1;
+static int fd;
 
-void setup();			/* Main setup function for the test */
-void cleanup();			/* Main cleanup function for the test */
-
-int main(int ac, char **av)
+static void verify_fchmod(void)
 {
-	struct stat stat_buf;	/* stat(2) struct contents */
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
-		 * Call fchmod(2) with specified mode argument
-		 * (sticky-bit set) on testfile.
-		 */
-		TEST(fchmod(fd, PERMS));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "fchmod(%d, %#o) Failed, errno=%d : %s",
-				 fd, PERMS, TEST_ERRNO, strerror(TEST_ERRNO));
-			continue;
-		}
-		/*
-		 * Get the testfile information using
-		 * fstat(2).
-		 */
-		if (fstat(fd, &stat_buf) < 0) {
-			tst_brkm(TFAIL, cleanup, "fstat(2) of %s "
-				 "failed, errno:%d", TESTFILE,
-				 TEST_ERRNO);
-		}
-
-		/* Check for expected mode permissions */
-		if ((stat_buf.st_mode & PERMS) == PERMS) {
-			tst_resm(TPASS, "Functionality of fchmod(%d, "
-				 "%#o) Successful", fd, PERMS);
-		} else {
-			tst_resm(TFAIL, "%s: Incorrect modes 0%03o, "
-				 "Expected 0%03o", TESTFILE,
-				 stat_buf.st_mode, PERMS);
-		}
+	struct stat stat_buf;
+	mode_t file_mode;
+
+	TEST(fchmod(fd, PERMS));
+	if (TEST_RETURN == -1)
+		tst_res(TFAIL | TTERRNO, "fchmod() failed unexpectly");
+
+	SAFE_FSTAT(fd, &stat_buf);
+	file_mode = stat_buf.st_mode;
+
+	if ((file_mode & ~S_IFREG) != PERMS) {
+		tst_res(TFAIL, "%s: Incorrect modes 0%03o, Expected 0%03o",
+			TESTFILE, file_mode, PERMS);
+	} else {
+		tst_res(TPASS, "Functionality of fchmod(%d, %#o) Successful",
+			fd, PERMS);
 	}
-
-	cleanup();
-	tst_exit();
 }
 
-/*
- * void
- * setup() - performs all ONE TIME setup for this test.
- *  Create a temporary directory and change directory to it.
- *  Create a test file under temporary directory.
- *  Change the ownership of test file to that of "ltpuser1" user.
- */
-void setup(void)
+static void setup(void)
 {
-	struct passwd *ltpuser;	/* password struct for ltpuser1 */
-	struct group *ltpgroup;	/* group struct for ltpuser1 */
-	gid_t group1_gid;	/* user and process group id's */
-	uid_t user1_uid;
-
-	tst_require_root();
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	/* Get the uid of guest user - ltpuser1 */
-	if ((ltpuser = getpwnam(LTPUSER)) == NULL) {
-		tst_brkm(TBROK, cleanup, "%s not in /etc/passwd", LTPUSER);
-	}
-	user1_uid = ltpuser->pw_uid;
+	struct passwd *ltpuser;
+	struct group *ltpgroup;
 
-	/* Get the group id of guest user - ltpuser1 */
-	if ((ltpgroup = getgrnam(LTPGRP)) == NULL) {
-		tst_brkm(TBROK, cleanup, "%s not in /etc/group", LTPGRP);
-	}
-	group1_gid = ltpgroup->gr_gid;
-
-	/*
-	 * Create a test file under temporary directory with specified
-	 * mode permissios and set the ownership of the test file to the
-	 * uid/gid of guest user user1.
-	 */
-	if ((fd = open(TESTFILE, O_RDWR | O_CREAT, FILE_MODE)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "open(%s, O_RDWR|O_CREAT, %#o) Failed, errno=%d : %s",
-			 TESTFILE, FILE_MODE, errno, strerror(errno));
-	}
+	ltpuser = SAFE_GETPWNAM(LTPUSER);
+	ltpgroup = getgrnam(LTPGRP);
+	if (ltpgroup == NULL)
+		tst_brk(TBROK, "%s not in /etc/group", LTPGRP);
 
-	SAFE_CHOWN(cleanup, TESTFILE, user1_uid, group1_gid);
-
-	/* Set the effective gid of the process to that of user */
-	SAFE_SETGID(cleanup, group1_gid);
+	fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, FILE_MODE);
+	SAFE_CHOWN(TESTFILE, ltpuser->pw_uid, ltpgroup->gr_gid);
+	SAFE_SETGID(ltpgroup->gr_gid);
 }
 
-/*
- * void
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- *  Close the testfile created in the setup.
- *  Remove the test directory and testfile created in the setup.
- */
-void cleanup(void)
+static void cleanup(void)
 {
-
-	/* Close the testfile created in the setup() */
-	SAFE_CLOSE(NULL, fd);
-
-	tst_rmdir();
-
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }
+
+static struct tst_test test = {
+	.test_all = verify_fchmod,
+	.needs_root = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+};
-- 
1.8.3.1



