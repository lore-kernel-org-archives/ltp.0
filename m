From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 13 Feb 2018 16:41:39 +0800
Subject: [LTP] [PATCH v2 4/5] syscalls/unlink07: Cleanup && Convert to new
	API
In-Reply-To: <1518511300-12371-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20180212162258.GA26897@rei>
 <1518511300-12371-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1518511300-12371-4-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) Take use of some safe macros
2) Remove duplicate tests for EFAULT

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/unlink/unlink07.c | 282 +++++-----------------------
 1 file changed, 50 insertions(+), 232 deletions(-)

diff --git a/testcases/kernel/syscalls/unlink/unlink07.c b/testcases/kernel/syscalls/unlink/unlink07.c
index 9651eda..1ef0816 100644
--- a/testcases/kernel/syscalls/unlink/unlink07.c
+++ b/testcases/kernel/syscalls/unlink/unlink07.c
@@ -28,259 +28,77 @@
  * For further information regarding this notice, see:
  *
  * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
- *
  */
-/* $Id: unlink07.c,v 1.8 2009/11/02 13:57:19 subrata_modak Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: unlink07
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: unlink(2) negative testcases
- *
- *    PARENT DOCUMENT	: usctpl01
- *
- *    TEST CASE TOTAL	: 1
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
- * 	1-8) See Testcases structure below.
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
 
-#include <sys/types.h>
-#include <fcntl.h>
-#include <sys/stat.h>
-#include <sys/mman.h>
+/*
+ * Description:
+ * The testcase checks the various errnos of the unlink(2).
+ * 1) unlink() returns ENOENT if file doesn't exist.
+ * 2) unlink() returns ENOENT if path is empty.
+ * 3) unlink() returns ENOENT if path contains a non-existent file.
+ * 4) unlink() returns EFAULT if address beyond address space.
+ * 5) unlink() returns ENOTDIR if path contains a regular file.
+ * 6) unlink() returns ENAMETOOLONG if path contains a regular file.
+ * 7) unlink() returns EFAULT if address is negative.
+ */
+
 #include <errno.h>
 #include <string.h>
-#include <signal.h>
 #include <unistd.h>
-#include <sys/param.h>		/* for PATH_MAX */
-#include "test.h"
+#include <sys/param.h>	/* for PATH_MAX */
+#include "tst_test.h"
 
-void setup();
-void cleanup();
+static char longpathname[PATH_MAX + 2];
 
-char *TCID = "unlink07";
-int TST_TOTAL = 6;
-
-int longpath_setup();
-int no_setup();
-int filepath_setup();
-char Longpathname[PATH_MAX + 2];
-char High_address[64];
-
-struct test_case_t {
-	char *pathname;
+static struct test_case_t {
+	char *name;
 	char *desc;
 	int exp_errno;
-	int (*setupfunc) ();
-} Test_cases[] = {
-	{
-	"nonexistfile", "non-existent file", ENOENT, no_setup}, {
-	"", "path is empty string", ENOENT, no_setup}, {
-	"nefile/file", "path contains a non-existent file",
-		    ENOENT, no_setup}, {
-	"file/file", "path contains a regular file",
-		    ENOTDIR, filepath_setup}, {
-	Longpathname, "pathname too long", ENAMETOOLONG, longpath_setup}, {
-	(char *)-1, "negative address", EFAULT, no_setup}, {
-	NULL, NULL, 0, no_setup}
+} tcases[] = {
+	{"nonexistfile", "non-existent file", ENOENT},
+	{"", "path is empty string", ENOENT},
+	{"nefile/file", "path contains a non-existent file", ENOENT},
+	{NULL, "negative address", EFAULT},
+	{"file/file", "path contains a regular file", ENOTDIR},
+	{longpathname, "pathname too long", ENAMETOOLONG},
 };
 
-/***********************************************************************
- * Main
- ***********************************************************************/
-int main(int ac, char **av)
+static void verify_unlink(unsigned int n)
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
+	struct test_case_t *tc = &tcases[n];
 
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
-				if (TEST_ERRNO ==
-				    Test_cases[ind].exp_errno)
-					tst_resm(TPASS,
-						 "unlink(<%s>) Failed, errno=%d",
-						 desc, TEST_ERRNO);
-				else
-					tst_resm(TFAIL,
-						 "unlink(<%s>) Failed, errno=%d, expected errno:%d",
-						 desc, TEST_ERRNO,
-						 Test_cases
-						 [ind].exp_errno);
-			} else {
-				tst_resm(TFAIL,
-					 "unlink(<%s>) returned %ld, expected -1, errno:%d",
-					 desc, TEST_RETURN,
-					 Test_cases[ind].exp_errno);
-			}
-		}
+	if (!tc->name)
+		tc->name = tst_get_bad_addr();
 
+	TEST(unlink(tc->name));
+	if (TEST_RETURN != -1) {
+		tst_res(TFAIL, "unlink(<%s>) succeeded unexpectedly",
+			tc->desc);
+		return;
 	}
 
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
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	Test_cases[5].pathname = (char *)tst_get_bad_addr();
-
-	for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
-		Test_cases[ind].setupfunc();
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
-int no_setup(void)
+static void setup(void)
 {
-	return 0;
-}
+	int fd;
 
-/******************************************************************
- *
- ******************************************************************/
-int longpath_setup(void)
-{
-	int ind;
-
-	for (ind = 0; ind <= PATH_MAX + 1; ind++) {
-		Longpathname[ind] = 'a';
-	}
-	return 0;
+	fd = SAFE_CREAT("file", 0777);
+	SAFE_CLOSE(fd);
 
+	memset(longpathname, 'a', PATH_MAX + 2);
 }
 
-/******************************************************************
- *
- ******************************************************************/
-int filepath_setup(void)
-{
-	int fd;
-
-	if ((fd = creat("file", 0777)) == -1) {
-		tst_brkm(TBROK, cleanup, "creat(file) failed, errno:%d %s",
-			 errno, strerror(errno));
-	}
-	close(fd);
-	return 0;
-}
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_unlink,
+};
-- 
1.8.3.1



