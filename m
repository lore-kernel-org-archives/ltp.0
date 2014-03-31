Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <root@localhost.localdomain>) id 1WUZQF-0002HY-2D
	for ltp-list@lists.sourceforge.net; Mon, 31 Mar 2014 10:26:31 +0000
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WUZQB-0007xc-Ic
	for ltp-list@lists.sourceforge.net; Mon, 31 Mar 2014 10:26:31 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id D2FA83EE0BC
	for <ltp-list@lists.sourceforge.net>;
	Mon, 31 Mar 2014 19:26:20 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id C799445DE4D
	for <ltp-list@lists.sourceforge.net>;
	Mon, 31 Mar 2014 19:26:20 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.nic.fujitsu.com [10.0.50.92])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id B077D45DE4E
	for <ltp-list@lists.sourceforge.net>;
	Mon, 31 Mar 2014 19:26:20 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id A470C1DB8040
	for <ltp-list@lists.sourceforge.net>;
	Mon, 31 Mar 2014 19:26:20 +0900 (JST)
Received: from s01.gw.fujitsu.co.jp (s01.gw.nic.fujitsu.com [133.161.11.16])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 4E10E1DB803F
	for <ltp-list@lists.sourceforge.net>;
	Mon, 31 Mar 2014 19:26:20 +0900 (JST)
Received: from s01.gw.fujitsu.co.jp (yt-mxio2.gw.nic.fujitsu.com
	[10.134.25.142])
	by s01.gw.fujitsu.co.jp (Postfix) with ESMTP id 1166BD8162
	for <ltp-list@lists.sourceforge.net>;
	Mon, 31 Mar 2014 19:26:20 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.127])
	by s01.gw.fujitsu.co.jp (Postfix) with ESMTP id A26338A005
	for <ltp-list@lists.sourceforge.net>;
	Mon, 31 Mar 2014 19:26:19 +0900 (JST)
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Mon, 31 Mar 2014 18:26:24 +0800
Message-Id: <1396261585-3628-1-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH 1/2] readlink/readlink03.c: cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Delete some useless comments.
Use some SAFE_* macros.
Move the test body from main() to readlink_verify().

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/readlink/readlink03.c | 333 ++++++------------------
 1 file changed, 74 insertions(+), 259 deletions(-)

diff --git a/testcases/kernel/syscalls/readlink/readlink03.c b/testcases/kernel/syscalls/readlink/readlink03.c
index 8362844..d713810 100644
--- a/testcases/kernel/syscalls/readlink/readlink03.c
+++ b/testcases/kernel/syscalls/readlink/readlink03.c
@@ -1,6 +1,7 @@
 /*
  *
  *   Copyright (c) International Business Machines  Corp., 2001
+ *   07/2001 Ported by Wayne Boyer
  *
  *   This program is free software;  you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -13,13 +14,10 @@
  *   the GNU General Public License for more details.
  *
  *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ *   along with this program;  if not, write to the Free Software Foundation,
+ *   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
-
 /*
- * Test Name : readlink03
- *
  * Test Description :
  *   Verify that,
  *   1) readlink(2) returns -1 and sets errno to EACCES if search/write
@@ -33,44 +31,6 @@
  *	pathname component of symbolic link is too long (ie, > PATH_MAX).
  *   5) readlink(2) returns -1 and sets errno to ENOENT if the component of
  *	symbolic link points to an empty string.
- *
- * Expected Result:
- *  readlink() should fail with return value -1 and set expected errno.
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
- *   	if errno set == expected errno
- *   		Issue sys call fails with expected return value and errno.
- *   	Otherwise,
- *		Issue sys call fails with unexpected errno.
- *   Otherwise,
- *	Issue sys call returns unexpected value.
- *
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *   Delete the temporary directory(s)/file(s) created.
- *
- * Usage:  <for command-line>
- *  readlink03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS:
  */
 
 #include <stdio.h>
@@ -84,284 +44,139 @@
 
 #include "test.h"
 #include "usctest.h"
+#include "safe_macros.h"
 
-#define MODE_RWX        S_IRWXU | S_IRWXG | S_IRWXO
-#define FILE_MODE       S_IRUSR | S_IRGRP | S_IROTH
-#define DIR_TEMP        "testdir_1"
-#define TESTFILE	"testfile"
-#define TEST_FILE1      "testdir_1/tfile_1"
+#define MODE_RWX	(S_IRWXU | S_IRWXG | S_IRWXO)
+#define FILE_MODE	(S_IRUSR | S_IRGRP | S_IROTH)
+#define DIR_TEMP	"testdir_1"
+#define TEST_FILE1	"testdir_1/tfile_1"
 #define SYM_FILE1	"testdir_1/sfile_1"
-#define TEST_FILE2      "tfile_2"
+#define TEST_FILE2	"tfile_2"
 #define SYM_FILE2	"sfile_2"
 #define MAX_SIZE	256
 
-char *TCID = "readlink03";
-int TST_TOTAL = 5;
-int exp_enos[] = { EACCES, EINVAL, ENAMETOOLONG, ENOENT, 0 };
-
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
-
-int no_setup();
-int setup1();			/* setup function to test symlink for EACCES */
-int setup2();			/* setup function to test symlink for EEXIST */
-int lpath_setup();		/* setup function to test chmod for ENAMETOOLONG */
+static char longpathname[PATH_MAX + 2];
 
-char Longpathname[PATH_MAX + 2];
-
-struct test_case_t {		/* test case struct. to hold ref. test cond's */
+static struct test_case_t {
 	char *link;
-	char *desc;
+	size_t buf_size;
 	int exp_errno;
-	size_t buf_siz;
-	int (*setupfunc) ();
-} Test_cases[] = {
-	{
-	SYM_FILE1, "No Search permissions to process", EACCES, 1, setup1},
+	void (*setupfunc) (struct test_case_t *);
+} test_cases[] = {
+	{SYM_FILE1, 1, EACCES, NULL},
 	    /* Don't test with bufsize -1, since this cause a fortify-check-fail when
 	       using glibc and -D_FORITY_SOURCE=2
 
 	       Discussion: http://lkml.org/lkml/2008/10/23/229
 	       Conclusion: Only test with 0 as non-positive bufsize.
 
-	       { SYM_FILE2, "Buffer size is not positive", EINVAL, -1, setup2 },
+	       { SYM_FILE2, -1, EINVAL, NULL },
 	     */
-	{
-	SYM_FILE2, "Buffer size is not positive", EINVAL, 0, setup2}, {
-	TEST_FILE2, "File is not symbolic link", EINVAL, 1, no_setup}, {
-	Longpathname, "Symlink path too long", ENAMETOOLONG, 1, lpath_setup},
-	{
-	"", "Symlink Pathname is empty", ENOENT, 1, no_setup}, {
-	NULL, NULL, 0, 0, no_setup}
+	{SYM_FILE2, 0, EINVAL, NULL},
+	{TEST_FILE2, 1, EINVAL, NULL},
+	{longpathname, 1, ENAMETOOLONG, NULL},
+	{"", 1, ENOENT, NULL},
 };
 
-void setup();
-void cleanup();
+static void setup(void);
+static void readlink_verify(struct test_case_t *);
+static void cleanup(void);
+
+char *TCID = "readlink03";
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+static int exp_enos[] = { EACCES, EINVAL, ENAMETOOLONG, ENOENT, 0 };
 
 int main(int ac, char **av)
 {
-	char buffer[MAX_SIZE];	/* temporary buffer to hold symlink contents */
-	int lc;
+	int i, lc;
 	char *msg;
-	char *sym_file;		/* symbolic link file name */
-	char *test_desc;	/* test specific error message */
-	int i;
-	size_t buf_size;	/* size of buffer for readlink */
 
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
-	/*
-	 * Invoke setup function to call individual test setup functions
-	 * to simulate test conditions.
-	 */
 	setup();
 
-	/* set the expected errnos... */
 	TEST_EXP_ENOS(exp_enos);
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
 		tst_count = 0;
 
-		for (i = 0; Test_cases[i].desc != NULL; i++) {
-			sym_file = Test_cases[i].link;
-			test_desc = Test_cases[i].desc;
-			buf_size = Test_cases[i].buf_siz;
-
-			if (buf_size == 1) {
-				buf_size = sizeof(buffer);
-			}
-
-			/*
-			 * Call readlink(2) to test different test conditions.
-			 * verify that it fails with -1 return value and sets
-			 * appropriate errno.
-			 */
-			TEST(readlink(sym_file, buffer, buf_size));
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "readlink() returned %ld, "
-					 "expected -1, errno:%d", TEST_RETURN,
-					 Test_cases[i].exp_errno);
-				continue;
-			}
-
-			TEST_ERROR_LOG(TEST_ERRNO);
-
-			if (TEST_ERRNO == Test_cases[i].exp_errno) {
-				tst_resm(TPASS, "readlink(), %s, returned "
-					 "errno %d", test_desc, TEST_ERRNO);
-				tst_resm(TPASS, "readlink(), %s, returned "
-					 "errno %d", test_desc, TEST_ERRNO);
-			} else {
-				tst_resm(TFAIL, "readlink() failed, %s, "
-					 "errno=%d, expected errno=%d",
-					 test_desc, TEST_ERRNO,
-					 Test_cases[i].exp_errno);
-				if ((strncmp
-				     (test_desc, "Symlink Pathname is empty",
-				      25) == 0) && TEST_ERRNO == EINVAL)
-					tst_resm(TWARN,
-						 "It may be a Kernel Bug, see the patch:"
-						 "http://git.kernel.org/linus/1fa1e7f6");
-			}
-		}
+		for (i = 0; i < TST_TOTAL; i++)
+			readlink_verify(&test_cases[i]);
 	}
 
 	cleanup();
 	tst_exit();
-
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- *
- *  Create a temporary directory and change directory to it.
- *  Call test specific setup functions.
- */
-void setup()
+void setup(void)
 {
-	int i;
+	struct passwd *ltpuser;
 
-	/* Switch to nobody user for correct error code collection */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
-	if ((ltpuser = getpwnam(nobody_uid)) == NULL) {
-		tst_brkm(TBROK, cleanup, "getpwname(nobody_uid) failed ");
-	}
-
-	if (seteuid(ltpuser->pw_uid) == -1) {
-		tst_resm(TINFO, "seteuid failed to "
-			 "to set the effective uid to %d", ltpuser->pw_uid);
-		perror("seteuid");
-	}
+	tst_require_root(NULL);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
+	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
+	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
+
 	TEST_PAUSE;
 
 	tst_tmpdir();
 
-	/* call individual setup functions */
-	for (i = 0; Test_cases[i].desc != NULL; i++) {
-		Test_cases[i].setupfunc();
-	}
-}
+	SAFE_MKDIR(cleanup, DIR_TEMP, MODE_RWX);
+	SAFE_TOUCH(cleanup, TEST_FILE1, 0666, NULL);
+	SAFE_SYMLINK(cleanup, TEST_FILE1, SYM_FILE1);
+	SAFE_CHMOD(cleanup, DIR_TEMP, FILE_MODE);
 
-/*
- * no_setup() - Some test conditions for readlink(2) do not any setup.
- */
-int no_setup()
-{
-	return 0;
+	SAFE_TOUCH(cleanup, TEST_FILE2, 0666, NULL);
+	SAFE_SYMLINK(cleanup, TEST_FILE2, SYM_FILE2);
+
+	memset(longpathname, 'a', PATH_MAX + 2);
 }
 
-/*
- * setup1() - setup function for a test condition for which readlink(2)
- *            returns -1 and sets errno to EACCES.
- *
- *  Create a test directory under temporary directory and create a test file
- *  under this directory with mode "0666" permissions.
- *  Create a symlink of testfile under test directory.
- *  Modify the mode permissions on test directory such that process will not
- *  have search permissions on test directory.
- */
-int setup1()
+void readlink_verify(struct test_case_t *tc)
 {
-	int fd;			/* file handle for testfile */
+	char buffer[MAX_SIZE];
 
-	if (mkdir(DIR_TEMP, MODE_RWX) < 0) {
-		tst_brkm(TBROK, cleanup, "mkdir(2) of %s failed", DIR_TEMP);
-	}
+	if (tc->setupfunc != NULL)
+		tc->setupfunc(tc);
 
-	if ((fd = open(TEST_FILE1, O_RDWR | O_CREAT, 0666)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "open(%s, O_RDWR|O_CREAT, 0666) failed, errno=%d : %s",
-			 TEST_FILE1, errno, strerror(errno));
-	}
-	if (close(fd) == -1) {
-		tst_brkm(TBROK, cleanup, "close(%s) failed, errno=%d : %s",
-			 TEST_FILE1, errno, strerror(errno));
-	}
+	if (tc->buf_size == 1)
+		tc->buf_size = sizeof(buffer);
 
-	/* Creat a symbolic link of testfile under test directory */
-	if (symlink(TEST_FILE1, SYM_FILE1) < 0) {
-		tst_brkm(TBROK, cleanup, "symlink of %s failed", TEST_FILE1);
-	}
-
-	/* Modify mode permissions on test directory */
-	if (chmod(DIR_TEMP, FILE_MODE) < 0) {
-		tst_brkm(TBROK, cleanup, "chmod(2) of %s failed", DIR_TEMP);
-	}
-	return 0;
-}
-
-/*
- * setup2() -  setup function for a test condition for which readlink(2)
- *	       returns -1 and sets errno to EINVAL.
- *
- *	Create a testfile under temporary directory and create a symlink
- *	file of it.
- */
-int setup2()
-{
-	int fd;			/* file handle for testfile */
+	TEST(readlink(tc->link, buffer, tc->buf_size));
 
-	/* Creat a testfile and close it */
-	if ((fd = open(TEST_FILE2, O_RDWR | O_CREAT, 0666)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "open(%s, O_RDWR|O_CREAT, 0666) failed, errno=%d : %s",
-			 TEST_FILE2, errno, strerror(errno));
-	}
-	if (close(fd) == -1) {
-		tst_brkm(TBROK, cleanup, "close(%s) failed, errno=%d : %s",
-			 TEST_FILE2, errno, strerror(errno));
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "readlink() returned %ld, "
+			"expected -1, errno:%d", TEST_RETURN,
+			tc->exp_errno);
+		return;
 	}
 
-	/* Creat a symlink of testfile created above */
-	if (symlink(TEST_FILE2, SYM_FILE2) < 0) {
-		tst_brkm(TBROK, cleanup, "symlink() failed to create %s in "
-			 "setup2, error=%d", SYM_FILE2, errno);
+	TEST_ERROR_LOG(TEST_ERRNO);
+
+	if (TEST_ERRNO == tc->exp_errno) {
+		tst_resm(TPASS | TTERRNO, "readlink() failed as expected");
+	} else {
+		tst_resm(TFAIL | TTERRNO,
+			"readlink() failed unexpectedly; expected: %d - %s",
+			tc->exp_errno, strerror(tc->exp_errno));
+		if (tc->exp_errno == ENOENT && TEST_ERRNO == EINVAL) {
+			tst_resm(TWARN | TTERRNO,
+				"It may be a Kernel Bug, see the patch:"
+				"http://git.kernel.org/linus/1fa1e7f6");
+		}
 	}
-	return 0;
 }
 
-/*
- * lpath_setup() - setup to create a node with a name length exceeding
- *		   the MAX. length of PATH_MAX.
- */
-int lpath_setup()
+void cleanup(void)
 {
-	int i;
-
-	for (i = 0; i <= (PATH_MAX + 1); i++) {
-		Longpathname[i] = 'a';
-	}
-	return 0;
-}
+	if (seteuid(0) == -1)
+		tst_resm(TWARN | TERRNO, "seteuid(0) failed");
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- *
- *  Restore the mode permissions on test directory.
- *  Remove the temporary directory created in the setup.
- */
-void cleanup()
-{
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
 	TEST_CLEANUP;
 
-	/* Restore mode permissions on test directory created in setup2() */
-	if (chmod(DIR_TEMP, MODE_RWX) < 0) {
-		tst_brkm(TBROK, NULL, "chmod(2) of %s failed", DIR_TEMP);
-	}
-
 	tst_rmdir();
-
 }
-- 
1.8.3.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
