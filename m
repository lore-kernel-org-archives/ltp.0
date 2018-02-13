From: yang xu <xuyang.jy@cn.fujitsu.com>
Date: Wed, 14 Feb 2018 00:01:36 +0800
Subject: [LTP] [PATCH 3/3] syscalls/rmdir03: Cleanup && Convert to new API
In-Reply-To: <1518537696-22033-1-git-send-email-xuyang.jy@cn.fujitsu.com>
References: <1518537696-22033-1-git-send-email-xuyang.jy@cn.fujitsu.com>
Message-ID: <1518537696-22033-3-git-send-email-xuyang.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) Take use of some safe macros
2) Don't need to fork child processes

Signed-off-by: yang xu <xuyang.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/rmdir/rmdir03.c |  373 ++++++-----------------------
 1 files changed, 70 insertions(+), 303 deletions(-)

diff --git a/testcases/kernel/syscalls/rmdir/rmdir03.c b/testcases/kernel/syscalls/rmdir/rmdir03.c
index 2bdc8ba..c4e80ff 100644
--- a/testcases/kernel/syscalls/rmdir/rmdir03.c
+++ b/testcases/kernel/syscalls/rmdir/rmdir03.c
@@ -1,338 +1,105 @@
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
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
- * NAME
- *	rmdir03
- *
  * DESCRIPTION
- *      check rmdir() fails with EPERM or EACCES
- *
- * ALGORITHM
- *	Setup:
- *		Setup signal handling.
- *		Pause for SIGUSR1 if option specified.
- *		Create temporary directory.
- *
- *	Test:
- *		Loop if the proper options are given.
- *              1. create a directory tstdir1 and set the sticky bit, then
- *                 create directory tstdir2 under tstdir1. Fork a
- *                 child , set to be user nobody. Pass tstdir2 to rmdir(2).
- *                 Verify the return value is not 0 and the errno is EPERM
- *                 or EACCES.
- *              2. Fork a child, set to be user nobody. Create a directory
- *                 tstdir1 and only give write permission to nobody.
- *                 Create directory tstdir2 under tstdir1. Fork the second
- *                 child , set to be user nobody. Pass tstdir2 to rmdir(2).
- *                 Verify the return value is not 0 and the errno is EACCES.
- *
- *	Cleanup:
- *		Print errno log and/or timing stats if options given
- *		Delete the temporary directory created.
+ *   check rmdir() fails with EPERM or EACCES
  *
- * USAGE
- *	rmdir03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-e   : Turn on errno logging.
- *		-i n : Execute test n times.
- *		-I x : Execute test for x seconds.
- *		-P x : Pause for x seconds between iterations.
- *		-t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- *	Test must be run as root.
+ *	1. Create a directory tstdir1 and set the sticky bit, then
+ *         create directory tstdir2 under tstdir1. Call dormdir(),
+ *         set to be user nobody. Pass tstdir2 to rmdir(2), verify
+ *         the return value is not 0 and the errno is EPERO or EACCES.
  *
+ *	2. Create a directory tstdir1 and doesn't give execute/search
+ *         permission to nobody, then create directory tstdir2 under
+ *         tstdir1.  Call dormdir(), set to be user nobody.  Pass
+ *         tstdir2 to rmdir(2), verify the return value is not 0 and
+ *         the errno is EACCES.
  */
 #include <errno.h>
-#include <string.h>
 #include <sys/stat.h>
 #include <sys/types.h>
-#include <sys/wait.h>
-#include <fcntl.h>
 #include <pwd.h>
 #include <unistd.h>
-
-#include "test.h"
-#include "safe_macros.h"
-
-void dochild1();
-void dochild2();
-void setup();
-void cleanup();
-
-#define PERMS		0777
-
-static uid_t nobody_uid;
-
-char *TCID = "rmdir03";
-int TST_TOTAL = 1;
-
-char tstdir1[255];
-char tstdir2[255];
-char tstdir3[255];
-char tstdir4[255];
-
-int main(int ac, char **av)
+#include "tst_test.h"
+
+#define DIR_MODE    0777
+#define NOEXCUTE_MODE 0766
+#define TESTDIR     "testdir"
+#define TESTDIR2    "testdir/testdir2"
+#define TESTDIR3    "testdir3"
+#define TESTDIR4    "testdir3/testdir4"
+
+static struct testcase {
+	mode_t dir_mode;
+	char *subdir;
+} tcases[] =  {
+	{DIR_MODE | S_ISVTX, TESTDIR2},
+	{NOEXCUTE_MODE, TESTDIR4},
+};
+
+static void do_rmdir(unsigned int n)
 {
-	int lc;
-	pid_t pid;
-	struct stat buf1;
-	int e_code, status, status2;
-
-	/*
-	 * parse standard options
-	 */
-	tst_parse_opts(ac, av, NULL, NULL);
-#ifdef UCLINUX
-	maybe_run_child(&dochild1, "ns", 1, tstdir2);
-	maybe_run_child(&dochild2, "ns", 2, tstdir4);
-#endif
-
-	/*
-	 * perform global setup for test
-	 */
-	setup();
-
-	/*
-	 * check looping state if -i option given
-	 */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-//test1:       $
-		/*
-		 * attempt to rmdir a file whose parent directory has
-		 * the sticky bit set without the root right
-		 * or effective uid
-		 */
-
-		if (stat(tstdir1, &buf1) != -1) {
-			tst_brkm(TBROK, cleanup,
-				 "tmp directory %s found!", tstdir1);
-		}
-		/* create a directory */
-		SAFE_MKDIR(cleanup, tstdir1, PERMS);
-		if (stat(tstdir1, &buf1) == -1) {
-			perror("stat");
-			tst_brkm(TBROK, cleanup, "failed to stat directory %s "
-				 "in rmdir()", tstdir1);
-
-		}
-		/* set the sticky bit */
-		if (chmod(tstdir1, buf1.st_mode | S_ISVTX) != 0) {
-			perror("chmod");
-			tst_brkm(TBROK, cleanup,
-				 "failed to set the S_ISVTX bit");
-
-		}
-		/* create a sub directory under tstdir1 */
-		SAFE_MKDIR(cleanup, tstdir2, PERMS);
-
-		if ((pid = FORK_OR_VFORK()) == -1) {
-			tst_brkm(TBROK, cleanup, "fork() failed");
-		}
-
-		if (pid == 0) {	/* first child */
-#ifdef UCLINUX
-			if (self_exec(av[0], "ns", 1, tstdir2) < 0) {
-				tst_brkm(TBROK, cleanup, "self_exec failed");
-			}
-#else
-			dochild1();
-#endif
-		}
-		/* Parent */
-
-//test2:       $
-		/* create the a directory with 0700 permits */
-		SAFE_MKDIR(cleanup, tstdir3, 0700);
-		/* create the a directory with 0700 permits */
-		SAFE_MKDIR(cleanup, tstdir4, 0777);
-
-		if ((pid = FORK_OR_VFORK()) == -1) {
-			tst_brkm(TBROK, cleanup, "fork() failed");
-		}
-
-		if (pid == 0) {	/* child */
-#ifdef UCLINUX
-			if (self_exec(av[0], "ns", 2, tstdir4) < 0) {
-				tst_brkm(TBROK, cleanup, "self_exec failed");
-			}
-#else
-			dochild2();
-#endif
-		} else {	/* parent */
-			/* wait for the child to finish */
-			wait(&status);
-			wait(&status2);
-			/* make sure the child returned a good exit status */
-			e_code = status >> 8;
-			if (e_code != 0) {
-				tst_resm(TFAIL, "Failures reported above");
-			} else {
-				/* No error in the 1st one, check the 2nd */
-				e_code = status2 >> 8;
-				if (e_code != 0) {
-					tst_resm(TFAIL,
-						 "Failures reported above");
-				}
-			}
-		}
-
-		/* clean up things in case we are looping */
-
-		(void)rmdir(tstdir2);
-		(void)rmdir(tstdir1);
-		(void)rmdir(tstdir4);
-		(void)rmdir(tstdir3);
-
-	}
-
-	/*
-	 * cleanup and exit
-	 */
-	cleanup();
-	tst_exit();
-
-}
-
-/*
- * dochild1()
- */
-void dochild1(void)
-{
-	int retval = 0;
-
-	/* set to nobody */
-	if (seteuid(nobody_uid) == -1) {
-		retval = 1;
-		tst_brkm(TBROK, cleanup, "setreuid failed to "
-			 "set effective uid to %d", nobody_uid);
-	}
-
-	/* rmdir tstdir2 */
-	TEST(rmdir(tstdir2));
-
-	if (TEST_ERRNO) {
-	}
+	struct testcase *tc = &tcases[n];
 
+	TEST(rmdir(tc->subdir));
 	if (TEST_RETURN != -1) {
-		retval = 1;
-		tst_resm(TFAIL, "call succeeded unexpectedly");
-	} else if ((TEST_ERRNO != EPERM) && (TEST_ERRNO != EACCES)) {
-		retval = 1;
-		tst_resm(TFAIL, "Expected EPERM or EACCES, got %d", TEST_ERRNO);
-	} else {
-		tst_resm(TPASS, "rmdir() produced EPERM or EACCES");
-	}
-
-	if (seteuid(0) == -1) {
-		retval = 1;
-		tst_brkm(TBROK, cleanup, "seteuid(0) failed");
+		tst_res(TFAIL, "rmdir() succeeded unexpectedly");
+		return;
 	}
-	exit(retval);
-	/* END of child 1 (test1) */
-}
-
-/*
- * dochild1()
- */
-void dochild2(void)
-{
-	int retval = 0;
 
-	/* set to nobody */
-	if (seteuid(nobody_uid) == -1) {
-		retval = 1;
-		tst_brkm(TBROK, cleanup, "setreuid failed to "
-			 "set effective uid to %d", nobody_uid);
+	if (TEST_ERRNO != EACCES) {
+		if (tc->dir_mode & S_ISVTX && TEST_ERRNO == EPERM)
+			tst_res(TPASS | TTERRNO, "rmdir() got expected errno");
+		else
+			tst_res(TFAIL | TTERRNO, "expected EPERM, but got");
+		return;
 	}
 
-	/* rmdir tstdir4 */
-	TEST(rmdir(tstdir4));
-
-	if (TEST_ERRNO) {
-	}
-
-	if (TEST_RETURN != -1) {
-		retval = 1;
-		tst_resm(TFAIL, "call succeeded unexpectedly");
-	} else if (TEST_ERRNO != EACCES) {
-		retval = 1;
-		tst_resm(TFAIL, "Expected EACCES got %d", TEST_ERRNO);
-	} else {
-		tst_resm(TPASS, "rmdir() produced EACCES");
-	}
-
-	if (seteuid(0) == -1) {
-		retval = 1;
-		tst_brkm(TBROK, cleanup, "seteuid(0) failed");
-	}
-	exit(retval);
+	tst_res(TPASS | TTERRNO, "rmdir() got expected errno");
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
+
+static void setup(void)
 {
 	struct passwd *pw;
-
-	tst_require_root();
-
-	pw = SAFE_GETPWNAM(NULL, "nobody");
-	nobody_uid = pw->pw_uid;
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	/* Create a temporary directory and make it current. */
-	tst_tmpdir();
+	pw = SAFE_GETPWNAM("nobody");
 
 	umask(0);
 
-	sprintf(tstdir1, "./tstdir1_%d", getpid());
-	sprintf(tstdir2, "%s/tstdir2_%d", tstdir1, getpid());
-	sprintf(tstdir3, "./tstdir3_%d", getpid());
-	sprintf(tstdir4, "%s/tstdir3_%d", tstdir3, getpid());
+	SAFE_MKDIR(TESTDIR, DIR_MODE | S_ISVTX);
+	SAFE_MKDIR(TESTDIR2, DIR_MODE);
+	SAFE_MKDIR(TESTDIR3, NOEXCUTE_MODE);
+	SAFE_MKDIR(TESTDIR4, DIR_MODE);
+
+	SAFE_SETEUID(pw->pw_uid);
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *              completion or premature exit.
- */
-void cleanup(void)
+static void cleanup(void)
 {
+	SAFE_SETEUID(0);
+}
 
-	/*
-	 * Remove the temporary directory.
-	 */
-	tst_rmdir();
-
-	/*
-	 * Exit with return code appropriate for results.
-	 */
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = do_rmdir,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+};
 
-}
-- 
1.7.1



