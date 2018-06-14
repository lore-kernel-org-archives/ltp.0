From: Jinhui huang <huangjh.jy@cn.fujitsu.com>
Date: Thu, 14 Jun 2018 19:29:22 +0800
Subject: [LTP] [PATCH 2/2] syscalls/fchmod05.c: Cleanup && convert to new API
In-Reply-To: <1528975762-10624-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1528975762-10624-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <1528975762-10624-2-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jinhui huang <huangjh.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/fchmod/fchmod05.c | 238 ++++++----------------------
 1 file changed, 52 insertions(+), 186 deletions(-)

diff --git a/testcases/kernel/syscalls/fchmod/fchmod05.c b/testcases/kernel/syscalls/fchmod/fchmod05.c
index 0ab2023..ffddd58 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod05.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod05.c
@@ -1,24 +1,7 @@
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
- * Test Name: fchmod05
+ * Copyright (c) International Business Machines  Corp., 2001
+ * Author: Wayne Boyer
  *
  * Test Description:
  *  Verify that, fchmod(2) will succeed to change the mode of a directory
@@ -31,197 +14,80 @@
  * Expected Result:
  *  fchmod() should return value 0 on success and though succeeds to change
  *  the mode of a directory but fails to set setgid bit on it.
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
- *	Log the errno and Issue a FAIL message.
- *   Otherwise,
- *	Verify the Functionality of system call
- *      if successful,
- *		Issue Functionality-Pass message.
- *      Otherwise,
- *		Issue Functionality-Fail message.
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *   Delete the temporary directory created.
- *
- * Usage:  <for command-line>
- *  fchmod05 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
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
  */
 
 #ifndef _GNU_SOURCE
 #define _GNU_SOURCE
 #endif
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include <unistd.h>
-#include <grp.h>
 #include <pwd.h>
+#include <grp.h>
+#include <errno.h>
 
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 #include "fchmod.h"
 
-#define PERMS_GID		043777
+#define PERMS_DIR	043777
 
-int fd;				/* file descriptor for test directory */
-char *TCID = "fchmod05";
-int TST_TOTAL = 1;
+static int fd;
 
-void setup();			/* Main setup function for test */
-void cleanup();			/* Main cleanup function for test */
-
-int main(int ac, char **av)
+static void verify_fchmod(void)
 {
-	struct stat stat_buf;	/* stat struct */
-	int lc;
-	mode_t dir_mode;	/* mode permissions set on test directory */
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
-		 * Call fchmod(2) with mode argument
-		 * to set setgid bit on TESTDIR.
-		 */
-
-		TEST(fchmod(fd, PERMS_GID));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "fchmod(%d, %#o) Failed, errno=%d : %s",
-				 fd, PERMS, TEST_ERRNO, strerror(TEST_ERRNO));
-			continue;
-		}
-		/*
-		 * Get the directory information using
-		 * fstat(2).
-		 */
-		if (fstat(fd, &stat_buf) < 0) {
-			tst_brkm(TFAIL, cleanup,
-				 "fstat(2) of %s failed, errno:%d",
-				 TESTDIR, TEST_ERRNO);
-		}
-		dir_mode = stat_buf.st_mode;
-		if ((PERMS_GID & ~S_ISGID) != dir_mode) {
-			tst_resm(TFAIL, "%s: Incorrect modes 0%03o, "
-				 "Expected 0%03o",
-				 TESTDIR, dir_mode, PERMS_GID & ~S_ISGID);
-		} else {
-			tst_resm(TPASS, "Functionality of fchmod(%d, "
-				 "%#o) successful", fd,
-				 PERMS_GID & ~S_ISGID);
-		}
+	struct stat stat_buf;
+	mode_t dir_mode;
+
+	TEST(fchmod(fd, PERMS_DIR));
+	if (TEST_RETURN == -1)
+		tst_res(TFAIL | TTERRNO, "fchmod() failed unexpectly");
+
+	SAFE_FSTAT(fd, &stat_buf);
+	dir_mode = stat_buf.st_mode;
+
+	if ((PERMS_DIR & ~S_ISGID) != dir_mode) {
+		tst_res(TFAIL, "%s: Incorrect modes 0%03o, Expected 0%03o",
+			TESTDIR, dir_mode & ~S_ISGID, PERMS_DIR);
+	} else {
+		tst_res(TPASS, "Functionality of fchmod(%d, %#o) successful",
+			fd, PERMS_DIR);
 	}
-
-	cleanup();
-	tst_exit();
 }
 
-/*
- * void
- * setup() - performs all ONE TIME setup for this test.
- *  Create a temporary directory and cd to it.
- *  Create a test directory under temporary directory.
- *  Invoke setuid to root program to modify group ownership
- *  on test directory.
- *  Open the test directory for reading.
- */
-void setup(void)
+static void setup(void)
 {
-	struct passwd *nobody_u;
-	struct group *bin_group;
-
-	tst_require_root();
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
+	struct passwd *ltpuser;
+	struct group *ltpgroup;
 
-	nobody_u = getpwnam("nobody");
-	if (!nobody_u)
-		tst_brkm(TBROK, cleanup,
-			 "Couldn't find uid of nobody: %s", strerror(errno));
+	ltpuser = SAFE_GETPWNAM("nobody");
+	ltpgroup = SAFE_GETGRNAM("bin");
 
-	bin_group = getgrnam("bin");
-	if (!bin_group)
-		tst_brkm(TBROK, cleanup,
-			 "Couldn't find gid of bin: %s", strerror(errno));
+	SAFE_MKDIR(TESTDIR, DIR_MODE);
 
-	/*
-	 * Create a test directory under temporary directory with specified
-	 * mode permissions and change the gid of test directory to that of
-	 * guest user.
-	 */
-	SAFE_MKDIR(cleanup, TESTDIR, DIR_MODE);
-
-	if (setgroups(1, &nobody_u->pw_gid) == -1)
-		tst_brkm(TBROK, cleanup,
-			 "Couldn't change supplementary group Id: %s",
-			 strerror(errno));
+	if (setgroups(1, &ltpuser->pw_gid) == -1) {
+		tst_brk(TBROK, "Couldn't change supplementary group Id: %s",
+			tst_strerrno(TEST_ERRNO));
+	}
 
-	SAFE_CHOWN(cleanup, TESTDIR, nobody_u->pw_uid, bin_group->gr_gid);
+	SAFE_CHOWN(TESTDIR, ltpuser->pw_uid, ltpgroup->gr_gid);
 
-	/* change to nobody:nobody */
-	if (setegid(nobody_u->pw_gid) == -1 || seteuid(nobody_u->pw_uid) == -1)
-		tst_brkm(TBROK, cleanup, "Couldn't switch to nobody:nobody: %s",
-			 strerror(errno));
+	SAFE_SETEGID(ltpuser->pw_gid);
+	SAFE_SETEUID(ltpuser->pw_uid);
 
-	/* Open the test directory for reading */
-	fd = SAFE_OPEN(cleanup, TESTDIR, O_RDONLY);
+	fd = SAFE_OPEN(TESTDIR, O_RDONLY);
 }
 
-/*
- * void
- * cleanup() - performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- *  Close the test directory opened in the setup().
- *  Remove the test directory and temporary directory created in
- *  in the setup().
- */
-void cleanup(void)
+static void cleanup(void)
 {
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 
-	/* Close the test directory opened in the setup() */
-	SAFE_CLOSE(NULL, fd);
-
-	SAFE_SETEGID(NULL, 0);
-	SAFE_SETEUID(NULL, 0);
-
-	tst_rmdir();
-
+	SAFE_SETEGID(0);
+	SAFE_SETEUID(0);
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



