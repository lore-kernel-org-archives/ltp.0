From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 13 Feb 2018 16:41:40 +0800
Subject: [LTP] [PATCH v2 5/5] syscalls/unlink08: Cleanup && Convert to new
	API
In-Reply-To: <1518511300-12371-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20180212162258.GA26897@rei>
 <1518511300-12371-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1518511300-12371-5-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) Take use of some safe macros
2) Remove unused code

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/unlink/unlink08.c | 363 ++++++----------------------
 1 file changed, 69 insertions(+), 294 deletions(-)

diff --git a/testcases/kernel/syscalls/unlink/unlink08.c b/testcases/kernel/syscalls/unlink/unlink08.c
index 9829a7c..ed4cd32 100644
--- a/testcases/kernel/syscalls/unlink/unlink08.c
+++ b/testcases/kernel/syscalls/unlink/unlink08.c
@@ -28,328 +28,103 @@
  * For further information regarding this notice, see:
  *
  * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
- *
  */
-/* $Id: unlink08.c,v 1.5 2009/11/02 13:57:19 subrata_modak Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: unlink08
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: unlink(2) negative testcases
- *
- *    PARENT DOCUMENT	: usctpl01
- *
- *    TEST CASE TOTAL	: 3
- *
- *    WALL CLOCK TIME	: 1
- *
- *    CPU TYPES		: ALL
- *
- *    AUTHOR		: Richard Logan
- *
- *    CO-PILOT		: William Roske
- *
- *    DATE STARTED	: 03/30/94
- *
- *    INITIAL RELEASE	: UNICOS 7.0
- *
- *    TEST CASES
- *
- * 	1-3) See Testcases structure below.
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
- *	This is a Phase I test for the unlink(2) system call.  It is intended
- *	to provide a limited exposure of the system call, for now.  It
- *	should/will be extended when full functional tests are written for
- *	unlink(2).
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
-#include <sys/stat.h>
-#include <errno.h>
-#include <signal.h>
-#include <unistd.h>
-#include <string.h>
-#include "test.h"
-#include "safe_macros.h"
 
-void setup(void);
-void cleanup(void);
+/*
+ * Description:
+ * The testcase checks the various errnos of the unlink(2).
+ * 1) unlink() returns EACCES when deleting file in unwritable directory
+ *    as an unprivileged user.
+ * 2) unlink() returns EACCES when deleting file in "unsearchable directory
+ *    as an unprivileged user.
+ * 3) unlink() returns EISDIR when deleting directory in linux.
+ * 4) unlink() returns EPERM when deleting directory in non-linux.
+ */
 
-char *TCID = "unlink08";
-int TST_TOTAL = 3;
+#include <errno.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <pwd.h>
+#include "tst_test.h"
 
-int unwrite_dir_setup(int flag);
-int unsearch_dir_setup(int flag);
-int dir_setup(int flag);
-int no_setup(int flag);
+static struct passwd *pw;
 
-struct test_case_t {
-	char *pathname;
+static struct test_case_t {
+	char *name;
 	char *desc;
-	int (*setupfunc) (int flag);
-	int exp_ret;		/* -1 means error, 0 means != -1 */
 	int exp_errno;
-} Test_cases[] = {
-	{
-	"unwrite_dir/file", "unwritable directory", unwrite_dir_setup,
-		    -1, EACCES}, {
-	"unsearch_dir/file", "unsearchable directory",
-		    unsearch_dir_setup, -1, EACCES},
-#ifdef linux
-	{
-	"regdir", "directory", dir_setup, -1, EISDIR},
+	int exp_user;
+} tcases[] = {
+	{"unwrite_dir/file", "unwritable directory", EACCES, 1},
+	{"unsearch_dir/file", "unsearchable directory", EACCES, 1},
+#ifdef __linux__
+	{"regdir", "directory", EISDIR, 0},
 #else
-	{
-	"regdir", "directory", dir_setup, -1, EPERM},
+	{"regdir", "directory", EPERM, 0},
 #endif
-	{
-	NULL, NULL, no_setup, -1, 0}
 };
 
-/***********************************************************************
- * Main
- ***********************************************************************/
-int main(int ac, char **av)
+static void verify_unlink(struct test_case_t *tc)
 {
-	int lc;
-	char *fname;
-	char *desc;
-	int ind;
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
-		for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
-
-			fname = Test_cases[ind].pathname;
-			desc = Test_cases[ind].desc;
-
-			/*
-			 *  Call unlink(2)
-			 */
-			TEST(unlink(fname));
-
-			/* check return code */
-			if (TEST_RETURN == -1) {
-				if (Test_cases[ind].exp_ret == -1) {	/* neg test */
-					if (TEST_ERRNO ==
-					    Test_cases[ind].exp_errno)
-						tst_resm(TPASS,
-							 "unlink(<%s>) Failed, errno=%d",
-							 desc,
-							 TEST_ERRNO);
-					else
-						tst_resm(TFAIL,
-							 "unlink(<%s>) Failed, errno=%d, expected errno:%d",
-							 desc,
-							 TEST_ERRNO,
-							 Test_cases
-							 [ind].exp_errno);
-				} else {
-					tst_resm(TFAIL,
-						 "unlink(<%s>) Failed, errno=%d",
-						 desc, TEST_ERRNO);
-				}
-			} else {
-				if (Test_cases[ind].exp_ret == -1) {
-					tst_resm(TFAIL,
-						 "unlink(<%s>) returned %ld, expected -1, errno:%d",
-						 desc, TEST_RETURN,
-						 Test_cases[ind].exp_errno);
-				} else {
-					tst_resm(TPASS,
-						 "unlink(<%s>) returned %ld",
-						 desc, TEST_RETURN);
-				}
-				Test_cases[ind].setupfunc(1);
-			}
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
-	int ind;
-	int postest = 0;
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	if (geteuid() == 0) {
-		postest++;
+	TEST(unlink(tc->name));
+	if (TEST_RETURN != -1) {
+		tst_res(TFAIL, "unlink(<%s>) succeeded unexpectedly",
+			tc->desc);
+		return;
 	}
 
-	for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
-		if (Test_cases[ind].exp_errno == EACCES && postest)
-			Test_cases[ind].exp_ret = 0;	/* set as a pos test */
-		Test_cases[ind].setupfunc(0);
+	if (TEST_ERRNO == tc->exp_errno) {
+		tst_res(TPASS | TTERRNO, "unlink(<%s>) failed as expected",
+			tc->desc);
+	} else {
+		tst_res(TFAIL | TTERRNO, "unlink(<%s>) failed, expected errno:%s",
+			tc->desc, tst_strerrno(tc->exp_errno));
 	}
-
-}
-
-/***************************************************************
- * cleanup() - performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- ***************************************************************/
-void cleanup(void)
-{
-	chmod("unwrite_dir", 0777);
-	chmod("unsearch_dir", 0777);
-
-	tst_rmdir();
-
 }
 
-/******************************************************************
- *
- ******************************************************************/
-int unwrite_dir_setup(int flag)
+static void do_unlink(unsigned int n)
 {
-	int fd;
-
-	if (!flag) {		/* initial setup */
-		SAFE_MKDIR(cleanup, "unwrite_dir", 0777);
-
-		if ((fd = creat("unwrite_dir/file", 0777)) == -1) {
-			tst_brkm(TBROK, cleanup,
-				 "creat(unwrite_dir/file, 0777) failed, errno:%d %s",
-				 errno, strerror(errno));
-		}
-		close(fd);
-
-		SAFE_CHMOD(cleanup, "unwrite_dir", 0555);
-	} else {		/* resetup */
-		SAFE_CHMOD(cleanup, "unwrite_dir", 0777);
-
-		if ((fd = creat("unwrite_dir/file", 0777)) == -1) {
-			tst_brkm(TBROK, cleanup,
-				 "creat(unwrite_dir/file, 0777) failed, errno:%d %s",
-				 errno, strerror(errno));
+	struct test_case_t *cases = &tcases[n];
+	pid_t pid;
+
+	if (cases->exp_user) {
+		pid = SAFE_FORK();
+		if (!pid) {
+			SAFE_SETUID(pw->pw_uid);
+			verify_unlink(cases);
+			exit(0);
 		}
-		close(fd);
 
-		SAFE_CHMOD(cleanup, "unwrite_dir", 0555);
+		SAFE_WAITPID(pid, NULL, 0);
+	} else {
+		verify_unlink(cases);
 	}
-	return 0;
 }
 
-/******************************************************************
- *
- ******************************************************************/
-int unsearch_dir_setup(int flag)
+static void setup(void)
 {
 	int fd;
 
-	if (!flag) {		/* initial setup */
-		SAFE_MKDIR(cleanup, "unsearch_dir", 0777);
-
-		if ((fd = creat("unsearch_dir/file", 0777)) == -1) {
-			tst_brkm(TBROK, cleanup,
-				 "creat(unsearch_dir/file, 0777) failed, errno:%d %s",
-				 errno, strerror(errno));
-		}
-		close(fd);
-
-		SAFE_CHMOD(cleanup, "unsearch_dir", 0666);
-	} else {		/* resetup */
-		SAFE_CHMOD(cleanup, "unsearch_dir", 0777);
+	SAFE_MKDIR("unwrite_dir", 0777);
+	fd = SAFE_CREAT("unwrite_dir/file", 0777);
+	SAFE_CLOSE(fd);
+	SAFE_CHMOD("unwrite_dir", 0555);
 
-		if ((fd = creat("unsearch_dir/file", 0777)) == -1) {
-			tst_brkm(TBROK, cleanup,
-				 "creat(unsearch_dir/file, 0777) failed, errno:%d %s",
-				 errno, strerror(errno));
-		}
-		close(fd);
+	SAFE_MKDIR("unsearch_dir", 0777);
+	fd = SAFE_CREAT("unsearch_dir/file", 0777);
+	SAFE_CLOSE(fd);
+	SAFE_CHMOD("unsearch_dir", 0666);
 
-		SAFE_CHMOD(cleanup, "unsearch_dir", 0666);
-	}
-	return 0;
-}
+	SAFE_MKDIR("regdir", 0777);
 
-/******************************************************************
- *
- ******************************************************************/
-int dir_setup(int flag)
-{
-	SAFE_MKDIR(cleanup, "regdir", 0777);
-	return 0;
+	pw = SAFE_GETPWNAM("nobody");
 }
 
-/******************************************************************
- *
- ******************************************************************/
-int no_setup(int flag)
-{
-	return 0;
-}
+static struct tst_test test = {
+	.needs_root = 1,
+	.forks_child = 1,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = do_unlink,
+};
-- 
1.8.3.1



