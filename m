From: Jinhui huang <huangjh.jy@cn.fujitsu.com>
Date: Thu, 14 Jun 2018 19:29:21 +0800
Subject: [LTP] [PATCH 1/2] syscalls/fchmod03.c: Convert to new API && merge
	fchmod04 into fchmod03
Message-ID: <1528975762-10624-1-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jinhui huang <huangjh.jy@cn.fujitsu.com>
---
 runtest/ltplite                             |   1 -
 runtest/stress.part3                        |   1 -
 runtest/syscalls                            |   1 -
 testcases/kernel/syscalls/fchmod/.gitignore |   1 -
 testcases/kernel/syscalls/fchmod/fchmod03.c | 197 ++++++++--------------------
 testcases/kernel/syscalls/fchmod/fchmod04.c | 190 ---------------------------
 6 files changed, 53 insertions(+), 338 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/fchmod/fchmod04.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 2492626..29a122e 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -187,7 +187,6 @@ fchdir03 fchdir03
 fchmod01 fchmod01
 fchmod02 fchmod02
 fchmod03 fchmod03
-fchmod04 fchmod04
 fchmod05 fchmod05
 fchmod06 fchmod06
 
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index d928719..bcea8bd 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -128,7 +128,6 @@ fchdir03 fchdir03
 fchmod01 fchmod01
 fchmod02 fchmod02
 fchmod03 fchmod03
-fchmod04 fchmod04
 fchmod05 fchmod05
 fchmod06 fchmod06
 
diff --git a/runtest/syscalls b/runtest/syscalls
index 65c96ed..4be1328 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -180,7 +180,6 @@ fchdir03 fchdir03
 fchmod01 fchmod01
 fchmod02 fchmod02
 fchmod03 fchmod03
-fchmod04 fchmod04
 fchmod05 fchmod05
 fchmod06 fchmod06
 
diff --git a/testcases/kernel/syscalls/fchmod/.gitignore b/testcases/kernel/syscalls/fchmod/.gitignore
index 3697537..1469bdc 100644
--- a/testcases/kernel/syscalls/fchmod/.gitignore
+++ b/testcases/kernel/syscalls/fchmod/.gitignore
@@ -1,6 +1,5 @@
 /fchmod01
 /fchmod02
 /fchmod03
-/fchmod04
 /fchmod05
 /fchmod06
diff --git a/testcases/kernel/syscalls/fchmod/fchmod03.c b/testcases/kernel/syscalls/fchmod/fchmod03.c
index a5824f3..34f8163 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod03.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod03.c
@@ -1,170 +1,79 @@
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
- */
-
-/*
- * Test Name: fchmod03
+ * Copyright (c) International Business Machines  Corp., 2001
+ * Author: Wayne Boyer
  *
  * Test Description:
- *  Verify that, fchmod(2) will succeed to change the mode of a file
- *  and set the sticky bit on it if invoked by non-root (uid != 0)
+ *  Verify that, fchmod(2) will succeed to change the mode of a file or
+ *  directory and set the sticky bit on it if invoked by non-root (uid != 0)
  *  process with the following constraints,
- *	- the process is the owner of the file.
- *	- the effective group ID or one of the supplementary group ID's of the
- *	  process is equal to the group ID of the file.
+ *	- the process is the owner of the file or directory.
+ *	- the effective group ID or one of the supplementary group ID's of
+ *	the process is equal to the group ID of the file or directory.
  *
  * Expected Result:
- *  fchmod() should return value 0 on success and succeeds to change
- *  the mode of specified file, sets sticky bit on it.
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
- *  fchmod03 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
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
+ *  fchmod() should return value 0 on success and succeeds to change the mode
+ *  of specified file or directory, sets sticky bit on it.
  */
 
-#include <stdio.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
 #include <pwd.h>
+#include <errno.h>
 
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 #include "fchmod.h"
 
-int fd;				/* file descriptor for test file */
-char *TCID = "fchmod03";
-int TST_TOTAL = 1;
-
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
+static int fd[2], i;
 
-void setup();			/* Main setup function for the test */
-void cleanup();			/* Main cleanup function for the test */
-
-int main(int ac, char **av)
+static void verify_fchmod(void)
 {
-	struct stat stat_buf;	/* stat struct. */
-	int lc;
-	mode_t file_mode;	/* mode permissions set on testfile */
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		TEST(fchmod(fd, PERMS));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TTERRNO, "fchmod failed");
-			continue;
+	struct stat stat_buf;
+	mode_t modes;
+
+	for (i = 0; i < 2; i++) {
+		TEST(fchmod(fd[i], PERMS));
+		if (TEST_RETURN == -1)
+			tst_res(TFAIL | TTERRNO, "fchmod() failed unexpectly");
+
+		SAFE_FSTAT(fd[i], &stat_buf);
+		modes = stat_buf.st_mode;
+
+		if ((modes & PERMS) != PERMS) {
+			tst_res(TFAIL,
+				"%s: Incorrect modes 0%3o, Expected 0%03o",
+				TESTFILE, modes, PERMS);
+		} else {
+			tst_res(TPASS,
+				"Functionality of fchmod(%d, %#o) successful",
+				fd[i], PERMS);
 		}
-		/*
-		 * Get the file information using
-		 * fstat(2).
-		 */
-		if (fstat(fd, &stat_buf) == -1)
-			tst_brkm(TFAIL | TERRNO, cleanup,
-				 "fstat failed");
-		file_mode = stat_buf.st_mode;
-
-		/* Verify STICKY BIT set on testfile */
-		if ((file_mode & PERMS) != PERMS)
-			tst_resm(TFAIL, "%s: Incorrect modes 0%3o, "
-				 "Expected 0777", TESTFILE, file_mode);
-		else
-			tst_resm(TPASS, "Functionality of fchmod(%d, "
-				 "%#o) successful", fd, PERMS);
 	}
-
-	cleanup();
-	tst_exit();
 }
 
-void setup(void)
+static void setup(void)
 {
+	struct passwd *ltpuser;
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	tst_require_root();
-
-	ltpuser = getpwnam(nobody_uid);
-	if (ltpuser == NULL)
-		tst_brkm(TBROK | TERRNO, NULL, "getpwnam failed");
-	SAFE_SETEUID(NULL, ltpuser->pw_uid);
-
-	TEST_PAUSE;
+	ltpuser = SAFE_GETPWNAM("nobody");
+	SAFE_SETEUID(ltpuser->pw_uid);
 
-	tst_tmpdir();
+	fd[0] = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, FILE_MODE);
 
-	/*
-	 * Create a test file under temporary directory with specified
-	 * mode permissios and set the ownership of the test file to the
-	 * uid/gid of guest user.
-	 */
-	if ((fd = open(TESTFILE, O_RDWR | O_CREAT, FILE_MODE)) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "open failed");
+	SAFE_MKDIR(TESTDIR, DIR_MODE);
+	fd[1] = SAFE_OPEN(TESTDIR, O_RDONLY);
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
-	if (close(fd) == -1)
-		tst_resm(TWARN | TERRNO, "close failed");
-
-	tst_rmdir();
-
+	for (i = 0; i < 2; i++) {
+		if (fd[i] > 0)
+			SAFE_CLOSE(fd[i]);
+	}
 }
+
+static struct tst_test test = {
+	.test_all = verify_fchmod,
+	.needs_root = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+};
diff --git a/testcases/kernel/syscalls/fchmod/fchmod04.c b/testcases/kernel/syscalls/fchmod/fchmod04.c
deleted file mode 100644
index befaadb..0000000
--- a/testcases/kernel/syscalls/fchmod/fchmod04.c
+++ /dev/null
@@ -1,190 +0,0 @@
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
- * Test Name: fchmod04
- *
- * Test Description:
- *  Verify that, fchmod(2) will succeed to change the mode of a directory
- *  and set the sticky bit on it if invoked by non-root (uid != 0) process
- *  with the following constraints,
- *	- the process is the owner of the directory.
- *	- the effective group ID or one of the supplementary group ID's of the
- *	  process is equal to the group ID of the directory.
- *
- * Expected Result:
- *  fchmod() should return value 0 on success and succeeds to set sticky bit
- *  on the specified directory.
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
- *  fchmod04 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
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
- */
-
-#include <stdio.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include <pwd.h>
-
-#include "test.h"
-#include "safe_macros.h"
-#include "fchmod.h"
-
-int fd;				/* file descriptor for test directory */
-char *TCID = "fchmod04";
-int TST_TOTAL = 1;
-
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
-
-void setup();
-void cleanup();
-
-int main(int ac, char **av)
-{
-	struct stat stat_buf;	/* stat struct. */
-	int lc;
-	mode_t dir_mode;	/* mode permissions set on testdirectory */
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
-		 * Call fchmod(2) with mode argument to
-		 * set sticky bit on TESTDIR
-		 */
-		TEST(fchmod(fd, PERMS));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TTERRNO, "fchmod failed");
-			continue;
-		}
-		if (fstat(fd, &stat_buf) == -1)
-			tst_brkm(TFAIL | TERRNO, cleanup,
-				 "fstat failed");
-		dir_mode = stat_buf.st_mode;
-
-		if ((dir_mode & PERMS) == PERMS)
-			tst_resm(TPASS, "Functionality of fchmod(%d, "
-				 "%#o) successful", fd, PERMS);
-		else
-			tst_resm(TFAIL, "%s: Incorrect modes 0%03o, "
-				 "Expected 0%03o",
-				 TESTDIR, dir_mode, PERMS);
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-/*
- * void
- * setup() - performs all ONE TIME setup for this test.
- *  Create a temporary directory and cd to it.
- *  Create another test directory under temporary directory.
- *  Open the test directory for reading.
- */
-void setup(void)
-{
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	/* Switch to nobody user for correct error code collection */
-	ltpuser = getpwnam(nobody_uid);
-	if (seteuid(ltpuser->pw_uid) == -1) {
-		tst_resm(TINFO, "seteuid failed to "
-			 "to set the effective uid to %d", ltpuser->pw_uid);
-		perror("seteuid");
-	}
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	/*
-	 * Create a test directory under temporary directory with specified
-	 * mode permissios and open it for reading/writing.
-	 */
-	SAFE_MKDIR(cleanup, TESTDIR, DIR_MODE);
-	if ((fd = open(TESTDIR, O_RDONLY)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "open(%s, O_RDONLY) failed, errno=%d : %s",
-			 TESTDIR, errno, strerror(errno));
-	}
-}
-
-/*
- * void
- * cleanup() - performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- *  Close the test directory opened during setup().
- *  Remove the test directory and temporary directory created in setup().
- */
-void cleanup(void)
-{
-
-	/* Close the test directory opened during setup() */
-	SAFE_CLOSE(NULL, fd);
-
-	tst_rmdir();
-
-}
-- 
1.8.3.1



