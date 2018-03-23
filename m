From: yang xu <xuyang.jy@cn.fujitsu.com>
Date: Fri, 23 Mar 2018 19:34:50 +0800
Subject: [LTP] [PATCH 3/5] syscalls/mkdir02: Cleanup && Convert to new API
In-Reply-To: <1521804892-5783-1-git-send-email-xuyang.jy@cn.fujitsu.com>
References: <1521804892-5783-1-git-send-email-xuyang.jy@cn.fujitsu.com>
Message-ID: <1521804892-5783-3-git-send-email-xuyang.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) Take use of some safe macros
2  Remove temporary directory in loops

Signed-off-by: yang xu <xuyang.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/mkdir/mkdir02.c | 384 ++++++++----------------------
 1 file changed, 99 insertions(+), 285 deletions(-)

diff --git a/testcases/kernel/syscalls/mkdir/mkdir02.c b/testcases/kernel/syscalls/mkdir/mkdir02.c
index 87d1345..63e6f3f 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir02.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir02.c
@@ -1,345 +1,159 @@
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
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *  the GNU General Public License for more details.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
-/*
- * NAME
- *	mkdir02
- *
- * DESCRIPTION
- *	This test will verify that new directory created
- *	by mkdir(2) inherites the group ID from the parent
- *      directory and S_ISGID bit, if the S_ISGID bit is set
- *	in the parent directory.
- *
- * ALGORITHM
- *	Setup:
- *		Setup signal handling.
- *		Pause for SIGUSR1 if option specified.
- *		Create temporary directory.
- *              Give write permission on temporary directory for all users.
- *              set up umask
- *
- *	Test:
- *		Loop if the proper options are given.
- *              fork the first child as ltpuser1
- *                  create a directory tstdir1 with S_ISGID set
- *              fork the second child as ltpuser2
- *                  create a directtory tstdir2 user tstdir1
- *                  check tstdir2's group ID and the S_ISGID bit
- *                  if they are the same as tstdir1's
- *                       PASS
- *                  else FAIL
- *	Cleanup:
- *		Print errno log and/or timing stats if options given
- *		Delete the temporary directory created.*
- * USAGE
- *	mkdir02 [-c n] [-e] [-f] [-i n] [-I x] [-P x] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-e   : Turn on errno logging.
- *		-f   : Turn off functionality Testing.
- *		-i n : Execute test n times.
- *		-I x : Execute test for x seconds.
- *		-P x : Pause for x seconds between iterations.
- *		-t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- *	None.
+/*  DESCRIPTION
+ *  This test will verify that new directory created by mkdir(2) inherites
+ *  the group ID from the parent directory and S_ISGID bit, if the S_ISGID
+ *  bit is set in the parent directory.
  */
 
 #include <errno.h>
-#include <string.h>
-#include <signal.h>
 #include <sys/stat.h>
 #include <sys/types.h>
-#include <fcntl.h>
 #include <pwd.h>
 #include <sys/wait.h>
 #include <unistd.h>
+#include <stdlib.h>
+#include "tst_test.h"
 
-#include "test.h"
-#include "safe_macros.h"
-
-void setup();
-void cleanup();
-
-#define PERMS		0777
+#define PERMS	0777
+#define TESTDIR1	"testdir1"
+#define TESTDIR2	"testdir1/testdir2"
 
 static uid_t nobody_uid, bin_uid;
 static gid_t nobody_gid, bin_gid;
 
-char *TCID = "mkdir02";
-int TST_TOTAL = 1;
-
-char tstdir1[100];
-char tstdir2[100];
-
-int main(int ac, char **av)
+static void verify_mkdir(void)
 {
-	int lc;
 	struct stat buf, buf1;
 	pid_t pid, pid1;
-	int rval, status;
+	int status;
 
-	/*
-	 * parse standard options
-	 */
-	tst_parse_opts(ac, av, NULL, NULL);
+	/* check the inherited group ID */
 
 	/*
-	 * perform global setup for test
-	 */
-	setup();
+	 * first, fork the first child, set to ltpuser1's uid and gid,
+	 * create a directory, with S_ISGID bit set
+	*/
 
-	/*
-	 * check looping state if -i option given
-	 */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	pid = SAFE_FORK();
+	if (pid == 0) {
 
-		tst_count = 0;
+		SAFE_SETREGID(nobody_gid, nobody_gid);
 
-		/* check the inherited group ID */
+		/* being ltupuser1 */
+		SAFE_SETREUID(nobody_uid, nobody_uid);
 
-		/*
-		 * first, fork the first child, set to ltpuser1's uid and gid,
-		 * create a directory, with S_ISGID bit set
+		/* create a direcoty with S_ISGID bit set
+		 * and the group ID is ltpuser1
 		 */
+		SAFE_MKDIR(TESTDIR1, PERMS);
 
-		sprintf(tstdir1, "tstdir1.%d", getpid());
+		SAFE_STAT(TESTDIR1, &buf1);
 
-		if ((pid = FORK_OR_VFORK()) < 0) {
-			tst_brkm(TFAIL, cleanup, "fork() failed");
+		SAFE_CHMOD(TESTDIR1, buf1.st_mode | S_ISGID);
 
-		}
+		/* Successfully create the parent directory */
+		exit(0);
 
-		if (pid == 0) {	/* first child */
-			rval = setregid(nobody_gid, nobody_gid);
-			if (rval < 0) {
-				perror("setregid");
-				tst_resm(TFAIL, "setregid failed to "
-					 "to set the real gid to %d and "
-					 "effective gid to %d",
-					 nobody_gid, nobody_gid);
-				exit(1);
-
-			}
-			/* being ltupuser1 */
-			rval = setreuid(nobody_uid, nobody_uid);
-			if (rval < 0) {
-				perror("setreuid");
-				tst_resm(TFAIL, "setreuid failed to "
-					 "to set the real uid to %d and "
-					 "effective uid to %d",
-					 nobody_uid, nobody_uid);
-				exit(1);
-
-			}
-
-			/*
-			 * create a direcoty with S_ISGID bit set
-			 * and the group ID is ltpuser1
-			 */
-			if (mkdir(tstdir1, PERMS) != 0) {
-				perror("mkdir");
-				tst_resm(TFAIL, "mkdir() failed to create"
-					 " a directory with Set "
-					 " group ID turn on ");
-				exit(1);
-
-			}
-			if (stat(tstdir1, &buf1) == -1) {
-				perror("stat");
-				tst_resm(TFAIL,
-					 "failed to stat the new directory"
-					 "in mkdir()");
-				exit(1);
-
-			}
-			if (chmod(tstdir1, buf1.st_mode | S_ISGID) != 0) {
-				perror("chmod");
-				tst_resm(TFAIL, "failed to set S_ISGID bit");
-				exit(1);
-
-			}
-
-			/* Successfully create the parent directory */
-			exit(0);
+	}
 
-		}
-		wait(&status);
-		if (WEXITSTATUS(status) != 0) {
-			tst_brkm(TFAIL, cleanup,
-				 "Test to attempt to make a directory"
-				 " inherits group ID FAILED ");
-		}
+	SAFE_WAITPID(pid, &status, 0);
+	if (WEXITSTATUS(status) != 0) {
+		tst_brk(TFAIL, "Test to attempt to make a directory"
+			" inherits group ID FAILED ");
+	}
+
+	/*
+	 * fork the second child process, set to ltpuser2's uid and gid
+	 * create a sub directory under the directory
+	 * just created by child process 1
+	 * check the group ID of the sub directory
+	 * should inherit from parent directory
+	 */
+
+	pid1 = SAFE_FORK();
+	if (pid1 == 0) {
+
+		/* being user ltpuser2 */
+		SAFE_SETREGID(bin_gid, bin_gid);
+
+		SAFE_SETREUID(bin_uid, bin_uid);
+
+		SAFE_MKDIR(TESTDIR2, PERMS);
 		/*
-		 * fork the second child process, set to ltpuser2's uid and gid
-		 * create a sub directory under the directory
-		 * just created by child process 1
-		 * check the group ID of the sub directory
-		 * should inherit from parent directory
+		 * check the group ID
+		 * should not be the same as the current processs's
+		 * since parent directory is set with S_ISGID bit
 		 */
+		SAFE_STAT(TESTDIR2, &buf);
 
-		sprintf(tstdir2, "%s/tstdir2.%d", tstdir1, getpid());
-		if ((pid1 = FORK_OR_VFORK()) < 0) {
-			perror("fork failed");
-			tst_brkm(TFAIL, cleanup, "fork() failed");
-
-		} else if (pid1 == 0) {	/* second child */
-
-			/* being user ltpuser2 */
-			rval = setregid(bin_gid, bin_gid);
-			if (rval < 0) {
-				tst_resm(TFAIL, "setregid failed to "
-					 "to set the real gid to %d and "
-					 "effective gid to %d",
-					 bin_gid, bin_gid);
-				perror("setregid");
-				exit(1);
-
-			}
-			rval = setreuid(bin_uid, bin_uid);
-			if (rval < 0) {
-				tst_resm(TFAIL, "setreuid failed to "
-					 "to set the real uid to %d and "
-					 "effective uid to %d",
-					 bin_uid, bin_uid);
-				perror("setreuid");
-				exit(1);
-
-			}
-
-			/*
-			 * create a sub direcoty
-			 * under the directory just created
-			 * by ltpuser1
-			 */
-			if (mkdir(tstdir2, PERMS) != 0) {
-				tst_resm(TFAIL, "mkdir() failed to create"
-					 " a directory %s under %s ", tstdir2,
-					 tstdir1);
-				exit(1);
-
-			}
-			/*
-			 * check the group ID
-			 * should not be the same as the current processs's
-			 * since parent directory is set with S_ISGID bit
-			 */
-			if (stat(tstdir2, &buf) == -1) {
-				tst_resm(TFAIL,
-					 "failed to stat the new directory"
-					 "in mkdir()");
-				exit(1);
-
-			}
-			if (stat(tstdir1, &buf1) == -1) {
-				tst_resm(TFAIL,
-					 "failed to stat the new directory"
-					 "in mkdir()");
-				exit(1);
-
-			}
-			if (buf.st_gid != buf1.st_gid) {
-				tst_resm(TFAIL, "mkdir() FAILED to inherit "
-					 " the group ID %d from parent "
-					 " directory %d",
-					 buf.st_gid, buf1.st_gid);
-				exit(1);
-
-			}
-
-			/* check the S_ISGID  bit */
-			if (!(buf.st_mode & S_ISGID)) {
-				tst_resm(TFAIL, "mkdir() FAILED to inherit "
-					 " the S_ISGID bit from parent "
-					 " directory");
-				exit(1);
-
-			}
-			/* PASS */
-			exit(0);
+		SAFE_STAT(TESTDIR1, &buf1);
 
+		if (buf.st_gid != buf1.st_gid) {
+			tst_res(TFAIL, "mkdir() FAILED to inherit the group ID"
+				" %d from parent  directory %d",
+				 buf.st_gid, buf1.st_gid);
+			exit(1);
 		}
 
-		waitpid(pid1, &status, 0);
-		if (WEXITSTATUS(status) == 0) {
-			tst_resm(TPASS, "Test to attempt to make a directory"
-				 " inherits group ID SUCCEEDED ");
-		} else {
-			tst_resm(TFAIL, "Test to attempt to make a directory"
-				 " inherits group ID FAILED");
-			cleanup();
+		if (!(buf.st_mode & S_ISGID)) {
+			tst_res(TFAIL, "mkdir() FAILED to inherit "
+				" the S_ISGID bit from parent directory");
+			exit(1);
 		}
 
+		exit(0);
+
 	}
 
-	/*
-	 * cleanup and exit
-	 */
-	cleanup();
+	SAFE_WAITPID(pid1, &status, 0);
+	if (WEXITSTATUS(status) == 0) {
+		tst_res(TPASS, "Test to attempt to make a directory"
+			" inherits group ID SUCCEEDED");
+	} else {
+		tst_res(TFAIL, "Test to attempt to make a directory"
+			" inherits group ID FAILED");
+	}
 
-	tst_exit();
+	/* rmdir() TESTDIR1 TESTDIR2 for loop test*/
+	SAFE_RMDIR(TESTDIR2);
+	SAFE_RMDIR(TESTDIR1);
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
+
 void setup(void)
 {
 	struct passwd *pw;
 
-	tst_require_root();
-
-	pw = SAFE_GETPWNAM(NULL, "nobody");
+	pw = SAFE_GETPWNAM("nobody");
 	nobody_uid = pw->pw_uid;
 	nobody_gid = pw->pw_gid;
-	pw = SAFE_GETPWNAM(NULL, "bin");
+	pw = SAFE_GETPWNAM("bin");
 	bin_uid = pw->pw_uid;
 	bin_gid = pw->pw_gid;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	/* Create a temporary directory and make it current. */
-	tst_tmpdir();
-
 	umask(0);
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- */
-void cleanup(void)
-{
-
-	/*
-	 * Remove the temporary directory.
-	 */
-	tst_rmdir();
-
-	/*
-	 * Exit with return code appropriate for results.
-	 */
-
-}
+static struct tst_test test = {
+	.setup = setup,
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.test_all = verify_mkdir,
+	.forks_child = 1,
+};
-- 
1.8.3.1



