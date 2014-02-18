Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WFfpQ-00010M-3z
	for ltp-list@lists.sourceforge.net; Tue, 18 Feb 2014 08:14:56 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WFfpN-0004ty-Fh
	for ltp-list@lists.sourceforge.net; Tue, 18 Feb 2014 08:14:56 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s1I8A22n021514
	for <ltp-list@lists.sourceforge.net>; Tue, 18 Feb 2014 16:10:10 +0800
Message-ID: <1392710999.2036.16.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Tue, 18 Feb 2014 16:09:59 +0800
In-Reply-To: <1389854521.2282.10.camel@G08JYZSD130126>
References: <1389853977.2282.9.camel@G08JYZSD130126>
	<1389854521.2282.10.camel@G08JYZSD130126>
Mime-Version: 1.0
Subject: [LTP] [PATCH v2 1/2] lstat/lstat02.c: cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sourceforge.net>

* Delete some useless commtents.
* Use SAFE_* macros.
* Move the test body form main() to lstat_verify().
* Some cleanup.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/lstat/lstat02.c | 340 +++++++-----------------------
 1 file changed, 74 insertions(+), 266 deletions(-)

diff --git a/testcases/kernel/syscalls/lstat/lstat02.c b/testcases/kernel/syscalls/lstat/lstat02.c
index 7111cce..d108c12 100644
--- a/testcases/kernel/syscalls/lstat/lstat02.c
+++ b/testcases/kernel/syscalls/lstat/lstat02.c
@@ -1,6 +1,6 @@
 /*
- *
  *   Copyright (c) International Business Machines  Corp., 2001
+ *   07/2001 Ported by Wayne Boyer
  *
  *   This program is free software;  you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -13,17 +13,14 @@
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
- * Test Name: lstat02
- *
  * Test Description:
  *   Verify that,
  *   1) lstat(2) returns -1 and sets errno to EACCES if search permission is
- *      denied on a component of the path prefix.
+ *	denied on a component of the path prefix.
  *   2) lstat(2) returns -1 and sets errno to ENOENT if the specified file
  *	does not exists or empty string.
  *   3) lstat(2) returns -1 and sets errno to EFAULT if pathname points
@@ -32,46 +29,6 @@
  *	component is too long.
  *   5) lstat(2) returns -1 and sets errno to ENOTDIR if the directory
  *	component in pathname is not a directory.
- *
- * Expected Result:
- *  lstat() should fail with return value -1 and set expected errno.
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
- *  lstat02 [-c n] [-e] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
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
- *  This test should be executed by 'non-super-user' only.
  */
 
 #include <stdio.h>
@@ -88,289 +45,140 @@
 
 #include "test.h"
 #include "usctest.h"
+#include "safe_macros.h"
 
 #define MODE_RWX	S_IRWXU | S_IRWXG | S_IRWXO
 #define FILE_MODE	S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
-#define DIR_TEMP	"testdir_1"
-#define TEST_FILE1	"testdir_1/tfile_1"
-#define SFILE1		"testdir_1/sfile_1"
-#define TEST_FILE2	"t_file/tfile_2"
-#define SFILE2		"t_file/sfile_2"
+#define TEST_DIR	"test_dir"
+#define TEST_EACCES	TEST_DIR"/test_eacces"
+#define TEST_ENOENT	""
+#define TEST_ENOTDIR	"test_file/test_enotdir"
 
-int no_setup();
-int setup1();			/* setup function to test chmod for EACCES */
-int setup2();			/* setup function to test chmod for ENOTDIR */
-int longpath_setup();		/* setup function to test chmod for ENAMETOOLONG */
-
-char Longpathname[PATH_MAX + 2];
+static char longpathname[PATH_MAX + 2];
 
 #if !defined(UCLINUX)
-char High_address_node[64];
-#endif /* if !defined(UCLINUX) */
+static void bad_addr_setup(int);
+static void high_address_setup(int);
+#endif
 
-struct test_case_t {		/* test case struct. to hold ref. test cond's */
+static struct test_case_t {
 	char *pathname;
-	char *desc;
 	int exp_errno;
-	int (*setupfunc) ();
-} Test_cases[] = {
-	{
-	SFILE1, "No Search permissions to process", EACCES, setup1},
+	void (*setup) ();
+} test_cases[] = {
+	{TEST_EACCES, EACCES, NULL},
+	{TEST_ENOENT, ENOENT, NULL},
 #if !defined(UCLINUX)
-	{
-	(char *)-1, "Negative address", EFAULT, no_setup}, {
-	High_address_node, "Address beyond address space", EFAULT,
-		    no_setup},
+	{NULL, EFAULT, bad_addr_setup},
+	{NULL, EFAULT, high_address_setup},
 #endif
-	{
-	Longpathname, "Pathname too long", ENAMETOOLONG, longpath_setup}, {
-	"", "Pathname is empty", ENOENT, no_setup}, {
-	SFILE2, "Path contains regular file", ENOTDIR, setup2}, {
-	NULL, NULL, 0, no_setup}
+	{longpathname, ENAMETOOLONG, NULL},
+	{TEST_ENOTDIR, ENOTDIR, NULL},
 };
 
 char *TCID = "lstat02";
-int TST_TOTAL = sizeof(Test_cases) / sizeof(*Test_cases);
-int exp_enos[] = { EACCES, EFAULT, ENAMETOOLONG, ENOENT, ENOTDIR, 0 };
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+static int exp_enos[] = { EACCES, EFAULT, ENAMETOOLONG, ENOENT, ENOTDIR, 0 };
 
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
-
-char *bad_addr = 0;
-
-void setup();			/* Main setup function for the tests */
-void cleanup();			/* cleanup function for the test */
+static void setup(void);
+static void lstat_verify(int);
+static void cleanup(void);
 
 int main(int ac, char **av)
 {
-	struct stat stat_buf;	/* stat structure buffer */
 	int lc;
+	int i;
 	char *msg;
-	char *file_name;	/* ptr. for file name whose mode is modified */
-	char *test_desc;	/* test specific error message */
-	int ind;		/* counter to test different test conditions */
 
 	msg = parse_opts(ac, av, NULL, NULL);
-	if (msg != NULL) {
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
-	}
-
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
-
-		for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
-			file_name = Test_cases[ind].pathname;
-			test_desc = Test_cases[ind].desc;
-
-#if !defined(UCLINUX)
-			if (file_name == High_address_node) {
-				file_name = (char *)get_high_address();
-			}
-#endif
-
-			/*
-			 * Call lstat(2) to test different test conditions.
-			 * verify that it fails with -1 return value and
-			 * sets appropriate errno.
-			 */
-			TEST(lstat(file_name, &stat_buf));
-
-			/* Check return code from lstat(2) */
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL,
-					 "lstat(2) returned %ld, expected"
-					 " -1, errno:%d", TEST_RETURN,
-					 Test_cases[ind].exp_errno);
-				continue;
-			}
-			TEST_ERROR_LOG(TEST_ERRNO);
-			if (TEST_ERRNO == Test_cases[ind].exp_errno) {
-				tst_resm(TPASS, "lstat() fails, %s, errno:%d",
-					 test_desc, TEST_ERRNO);
-			} else {
-				tst_resm(TFAIL, "lstat() fails, %s, errno:%d, "
-					 "expected errno:%d", test_desc,
-					 TEST_ERRNO, Test_cases[ind].exp_errno);
-			}
-		}
+		for (i = 0; i < TST_TOTAL; i++)
+			lstat_verify(i);
 	}
 
-	/*
-	 * Invoke cleanup() to delete the test directory/file(s) created
-	 * in the setup().
-	 */
 	cleanup();
 	tst_exit();
-	tst_exit();
-
 }
 
-/*
- * setup(void) - performs all ONE TIME setup for this test.
- * 	Exit the test program on receipt of unexpected signals.
- *	Create a temporary directory and change directory to it.
- *	Invoke individual test setup functions according to the order
- *	set in struct. definition.
- */
-void setup()
+static void setup(void)
 {
-	int ind;
+	struct passwd *ltpuser;
 
-	/* Capture unexpected signals */
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_require_root(NULL);
 
-	/* Switch to nobody user for correct error code collection */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
-	ltpuser = getpwnam(nobody_uid);
-	if (setuid(ltpuser->pw_uid) == -1) {
-		tst_resm(TINFO, "setuid failed to "
-			 "to set the effective uid to %d", ltpuser->pw_uid);
-		perror("setuid");
-	}
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
+	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
 
 	TEST_PAUSE;
 
-	/* Make a temp dir and cd to it */
 	tst_tmpdir();
 
-#if !defined(UCLINUX)
-	bad_addr = mmap(0, 1, PROT_NONE,
-			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
-	if (bad_addr == MAP_FAILED) {
-		tst_brkm(TBROK, cleanup, "mmap failed");
-	}
-	Test_cases[2].pathname = bad_addr;
-#endif
+	SAFE_MKDIR(cleanup, TEST_DIR, MODE_RWX);
+	SAFE_TOUCH(cleanup, TEST_EACCES, 0666, NULL);
+	if (chmod(TEST_DIR, FILE_MODE) < 0)
+		tst_brkm(TBROK, cleanup, "chmod(2) of %s failed", TEST_DIR);
 
-	/* call individual setup functions */
-	for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
-		Test_cases[ind].setupfunc();
-	}
+	SAFE_TOUCH(cleanup, "test_file", MODE_RWX, NULL);
+
+	memset(longpathname, 'a', PATH_MAX+1);
 }
 
-/*
- * no_setup() - Some test conditions for lstat(2) do not any setup.
- *              Hence, this function just returns 0.
- *  		This function simply returns 0.
- */
-int no_setup()
+#if !defined(UCLINUX)
+static void bad_addr_setup(int i)
 {
-	return 0;
+	test_cases[i].pathname = SAFE_MMAP(cleanup, 0, 1, PROT_NONE,
+					   MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
 }
 
-/*
- * setup1() - setup function for a test condition for which lstat(2)
- *	      returns -1 and sets errno to EACCES.
- *  Create a test directory under temporary directory and create a test file
- *  under this directory with mode "0666" permissions.
- *  Modify the mode permissions on test directory such that process will not
- *  have search permissions on test directory.
- *
- *  The function returns 0.
- */
-int setup1()
+static void high_address_setup(int i)
 {
-	int fd;			/* file handle for testfile */
+	test_cases[i].pathname = (char *)get_high_address();
+}
+#endif
 
-	if (mkdir(DIR_TEMP, MODE_RWX) < 0) {
-		tst_brkm(TBROK, cleanup, "mkdir(2) of %s failed", DIR_TEMP);
-	}
+static void lstat_verify(int i)
+{
+	struct stat stat_buf;
 
-	if ((fd = open(TEST_FILE1, O_RDWR | O_CREAT, 0666)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "open(%s, O_RDWR|O_CREAT, 0666) failed, errno=%d : %s",
-			 TEST_FILE1, errno, strerror(errno));
-	}
-	if (close(fd) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "close(%s) Failed, errno=%d : %s",
-			 TEST_FILE1, errno, strerror(errno));
-	}
+	if (test_cases[i].setup != NULL)
+		test_cases[i].setup(i);
 
-	/* Create a symlink of testfile */
-	if (symlink(TEST_FILE1, SFILE1) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "symlink() of %s Failed, errno=%d : %s",
-			 TEST_FILE1, errno, strerror(errno));
-	}
+	TEST(lstat(test_cases[i].pathname, &stat_buf));
 
-	/* Modify mode permissions on test directory */
-	if (chmod(DIR_TEMP, FILE_MODE) < 0) {
-		tst_brkm(TBROK, cleanup, "chmod(2) of %s failed", DIR_TEMP);
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "lstat() returned %ld, expected -1, errno=%d",
+			 TEST_RETURN, test_cases[i].exp_errno);
+		return;
 	}
-	return 0;
-}
 
-/*
- * setup2() - setup function for a test condition for which lstat(2)
- *	     returns -1 and sets errno to ENOTDIR.
- *
- *  Create a test file under temporary directory so that test tries to
- *  change mode of a testfile "tfile_2" under "t_file" which happens to be
- *  another regular file.
- */
-int setup2()
-{
-	int fd;			/* file handle */
+	TEST_ERROR_LOG(TEST_ERRNO);
 
-	if ((fd = open("t_file", O_RDWR | O_CREAT, MODE_RWX)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "open(2) on t_file failed, errno=%d : %s",
-			 errno, strerror(errno));
+	if (TEST_ERRNO == test_cases[i].exp_errno) {
+		tst_resm(TPASS | TTERRNO, "lstat() failed as expected");
+	} else {
+		tst_resm(TFAIL | TTERRNO,
+			 "lstat() failed unexpectedly; expected: %d - %s",
+			 test_cases[i].exp_errno,
+			 strerror(test_cases[i].exp_errno));
 	}
-	if (close(fd) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "close(t_file) Failed, errno=%d : %s",
-			 errno, strerror(errno));
-	}
-	return 0;
 }
 
-/*
- * longpath_setup() - setup to create a node with a name length exceeding
- *                    the MAX. length of PATH_MAX.
- *		      This function retruns 0.
- */
-int longpath_setup()
+static void cleanup(void)
 {
-	int ind;		/* counter variable */
-
-	for (ind = 0; ind <= (PATH_MAX + 1); ind++) {
-		Longpathname[ind] = 'a';
-	}
-	return 0;
-}
+	if (seteuid(0))
+		tst_resm(TINFO | TERRNO, "Failet to seteuid(0) before cleanup");
 
-/*
- * cleanup() - Performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
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
1.8.4.2




------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
