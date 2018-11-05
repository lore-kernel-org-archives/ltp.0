From: Sandeep Patil <sspatil@google.com>
Date: Mon,  5 Nov 2018 15:50:16 -0800
Subject: [LTP] [PATCH 2/5] syscalls/chmod07: Use new ltp library
In-Reply-To: <20181105235019.254846-1-sspatil@google.com>
References: <20181105235019.254846-1-sspatil@google.com>
Message-ID: <20181105235019.254846-3-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Use SPDX-Licence-Identifier and delete dead comments / code.
Side benefit of making sure the test runs on Android when using
SAFE_GETGRNAM_FALLBACK()

Signed-off-by: Sandeep Patil <sspatil@google.com>
---
 testcases/kernel/syscalls/chmod/chmod07.c | 174 ++++++----------------
 1 file changed, 42 insertions(+), 132 deletions(-)

diff --git a/testcases/kernel/syscalls/chmod/chmod07.c b/testcases/kernel/syscalls/chmod/chmod07.c
index 6a3938840..4e43f2e32 100644
--- a/testcases/kernel/syscalls/chmod/chmod07.c
+++ b/testcases/kernel/syscalls/chmod/chmod07.c
@@ -1,20 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- *
  *   Copyright (c) International Business Machines  Corp., 2001
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
  */
 
 /*
@@ -31,43 +17,6 @@
  * Expected Result:
  *  chmod() should return value 0 on success and succeeds to set sticky bit
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
- *  chmod07 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
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
 
 #include <stdio.h>
@@ -80,75 +29,46 @@
 #include <grp.h>
 #include <pwd.h>
 
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 
-#define LTPUSER		"nobody"
-#define LTPGRP		"users"
-#define FILE_MODE 	(S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)
-#define PERMS		01777	/*
-				 * Mode permissions of test file with sticky
-				 * bit set.
-				 */
+#define FILE_MODE 	(S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH)
+#define PERMS		01777	/* Permissions with sticky bit set. */
 #define TESTFILE	"testfile"
 
-char *TCID = "chmod07";
-int TST_TOTAL = 1;
-
-void setup();			/* Main setup function for the test */
-void cleanup();			/* Main cleanup function for the test */
-
-int main(int ac, char **av)
+void test_chmod(void)
 {
 	struct stat stat_buf;	/* stat(2) struct contents */
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
 
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/*
-		 * Call chmod(2) with specified mode argument
-		 * (sticky-bit set) on testfile.
-		 */
-		TEST(chmod(TESTFILE, PERMS));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TTERRNO, "chmod(%s, %#o) failed",
-				 TESTFILE, PERMS);
-			continue;
-		}
-		/*
-		 * Get the testfile information using
-		 * stat(2).
-		 */
-		if (stat(TESTFILE, &stat_buf) == -1)
-			tst_brkm(TFAIL | TTERRNO, cleanup,
-				 "stat failed");
+	/*
+	 * Call chmod(2) with specified mode argument
+	 * (sticky-bit set) on testfile.
+	 */
+	TEST(chmod(TESTFILE, PERMS));
+	if (TST_RET == -1) {
+		tst_brk(TFAIL | TTERRNO, "chmod(%s, %#o) failed",
+				TESTFILE, PERMS);
+	}
 
-		/* Check for expected mode permissions */
-		if ((stat_buf.st_mode & PERMS) == PERMS)
-			tst_resm(TPASS, "Functionality of "
-				 "chmod(%s, %#o) successful",
-				 TESTFILE, PERMS);
-		else
-			tst_resm(TFAIL, "%s: Incorrect modes 0%03o; "
-				 "expected 0%03o", TESTFILE,
-				 stat_buf.st_mode, PERMS);
+	/*
+	 * Get the testfile information using
+	 * stat(2).
+	 */
+	if (stat(TESTFILE, &stat_buf) == -1) {
+		tst_brk(TFAIL | TTERRNO, "stat failed");
 	}
 
-	cleanup();
-	tst_exit();
+	/* Check for expected mode permissions */
+	if ((stat_buf.st_mode & PERMS) == PERMS) {
+		tst_res(TPASS, "Functionality of chmod(%s, %#o) successful",
+				TESTFILE, PERMS);
+	} else {
+		tst_res(TFAIL, "%s: Incorrect modes 0%03o; expected 0%03o",
+				TESTFILE, stat_buf.st_mode, PERMS);
+	}
 }
 
 /*
- * void
- * setup() - performs all ONE TIME setup for this test.
- *  Create a temporary directory and change directory to it.
+ *  setup() - performs all ONE TIME setup for this test.
  *  Create a test file under temporary directory and close it
  *  Change the ownership of test file to that of "ltpuser1" user.
  */
@@ -160,32 +80,22 @@ void setup(void)
 	gid_t group1_gid;	/* user and process group id's */
 	uid_t user1_uid;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_require_root();
-
-	tst_tmpdir();
-
-	/* Get the uid of guest user - ltpuser1 */
-	if ((ltpuser = getpwnam(LTPUSER)) == NULL)
-		tst_brkm(TBROK, cleanup, "getpwnam failed");
+	/* Get the uid of guest user - nobody */
+	ltpuser = SAFE_GETPWNAM("nobody");
 	user1_uid = ltpuser->pw_uid;
 
-	/* Get the group id of guest user - ltpuser1 */
-	if ((ltpgroup = getgrnam(LTPGRP)) == NULL)
-		tst_brkm(TBROK, cleanup, "getgrnam failed");
+	ltpgroup = SAFE_GETGRNAM_FALLBACK("users", "daemon");
 	group1_gid = ltpgroup->gr_gid;
 
-	fd = SAFE_OPEN(cleanup, TESTFILE, O_RDWR | O_CREAT, FILE_MODE);
-	SAFE_CLOSE(cleanup, fd);
-	SAFE_CHOWN(cleanup, TESTFILE, user1_uid, group1_gid);
-
-	SAFE_SETGID(cleanup, group1_gid);
+	fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, FILE_MODE);
+	SAFE_CLOSE(fd);
+	SAFE_CHOWN(TESTFILE, user1_uid, group1_gid);
+	SAFE_SETGID(group1_gid);
 }
 
-void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.test_all = test_chmod,
+};
-- 
2.19.1.930.g4563a0d9d0-goog

