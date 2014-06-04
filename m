Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1Ws7kY-0001OD-6l
	for ltp-list@lists.sourceforge.net; Wed, 04 Jun 2014 09:44:50 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Ws7kI-0003Ei-JY
	for ltp-list@lists.sourceforge.net; Wed, 04 Jun 2014 09:44:50 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s549iQKK005189
	for <ltp-list@lists.sourceforge.net>; Wed, 4 Jun 2014 17:44:26 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Wed, 4 Jun 2014 17:43:26 +0800
Message-ID: <1401875007-27025-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/2] truncate/truncate03.c: cleanup
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
To: ltp-list@lists.sourceforge.net

Merge truncate03, truncate04 into truncate03 test.
Delete some useless comments.
Use some SAFE_* macros.
Move the test body from main() to truncate_verify().

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 runtest/ltplite                                 |   1 -
 runtest/stress.part3                            |   1 -
 runtest/syscalls                                |   2 -
 testcases/kernel/syscalls/.gitignore            |   2 -
 testcases/kernel/syscalls/truncate/truncate03.c | 366 +++++-------------------
 testcases/kernel/syscalls/truncate/truncate04.c | 219 --------------
 6 files changed, 78 insertions(+), 513 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/truncate/truncate04.c

diff --git a/runtest/ltplite b/runtest/ltplite
index d71f137..f7529b2 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -933,7 +933,6 @@ times03 times03
 truncate01 truncate01
 truncate02 truncate02
 truncate03 truncate03
-truncate04 truncate04
 
 # This syscall is obsolete.  The latest glibc does not even
 # include the ulimit.h file anymore.  The test will fail
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index bc71013..c7d360d 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -823,7 +823,6 @@ times03 times03
 truncate01 truncate01
 truncate02 truncate02
 truncate03 truncate03
-truncate04 truncate04
 
 # This syscall is obsolete.  The latest glibc does not even
 # include the ulimit.h file anymore.  The test will fail
diff --git a/runtest/syscalls b/runtest/syscalls
index 3db5f2a..1c8c60d 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1265,8 +1265,6 @@ truncate02 truncate02
 truncate02_64 truncate02_64
 truncate03 truncate03
 truncate03_64 truncate03_64
-truncate04 truncate04
-truncate04_64 truncate04_64
 
 # This syscall is obsolete.  The latest glibc does not even
 # include the ulimit.h file anymore.  The test will fail
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index e1ee18b..2829fc1 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -974,8 +974,6 @@
 /truncate/truncate02_64
 /truncate/truncate03
 /truncate/truncate03_64
-/truncate/truncate04
-/truncate/truncate04_64
 /ulimit/ulimit01
 /umask/umask01
 /umask/umask02
diff --git a/testcases/kernel/syscalls/truncate/truncate03.c b/testcases/kernel/syscalls/truncate/truncate03.c
index a0c98d0..99f5c1e 100644
--- a/testcases/kernel/syscalls/truncate/truncate03.c
+++ b/testcases/kernel/syscalls/truncate/truncate03.c
@@ -1,6 +1,6 @@
 /*
- *
  *   Copyright (c) International Business Machines  Corp., 2001
+ *   07/2001 John George
  *
  *   This program is free software;  you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -13,69 +13,26 @@
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
- * Test Name: truncate03
- *
- * Test Description:
- *  Verify that,
- *  1) truncate(2) returns -1 and sets errno to EACCES if search/write
- *     permission denied for the process on the component of the path prefix
- *     or named file.
- *  2) truncate(2) returns -1 and sets errno to ENOTDIR if the component of
- *     the path prefix is not a directory.
- *  3) truncate(2) returns -1 and sets errno to EFAULT if pathname points
- *     outside user's accessible address space.
- *  4) truncate(2) returns -1 and sets errno to ENAMETOOLONG if the component
- *     of a pathname exceeded 255 characters or entire pathname exceeds 1023
- *     characters.
- *  5) truncate(2) returns -1 and sets errno to ENOENT if the named file
- *     does not exist.
- *
- * Expected Result:
- *  truncate() should fail with return value -1 and set expected errno.
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
- *   truncate03 [-c n] [-e] [-f] [-i n] [-I x] [-p x] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-e   : Turn on errno logging.
- *		-f   : Turn off functionality Testing.
- *		-i n : Execute test n times.
- *		-I x : Execute test for x seconds.
- *		-P x : Pause for x seconds between iterations.
- *		-t   : Turn on syscall timing.
- *
- * History
- *	07/2001 John George
- *		-Ported
- *
- * Restrictions:
- *  This test should be executed by 'non-super-user' only.
- *
+ *   Test Description:
+ *     Verify that,
+ *     1) truncate(2) returns -1 and sets errno to EACCES if search/write
+ *        permission denied for the process on the component of the path prefix
+ *        or named file.
+ *     2) truncate(2) returns -1 and sets errno to ENOTDIR if the component of
+ *        the path prefix is not a directory.
+ *     3) truncate(2) returns -1 and sets errno to EFAULT if pathname points
+ *        outside user's accessible address space.
+ *     4) truncate(2) returns -1 and sets errno to ENAMETOOLONG if the component
+ *        of a pathname exceeded 255 characters or entire pathname exceeds 1023
+ *        characters.
+ *     5) truncate(2) returns -1 and sets errno to ENOENT if the named file
+ *        does not exist.
+ *     6) truncate(2) returns -1 and sets errno to EISDIR if the named file
+ *        is a directory.
  */
 
 #include <stdio.h>
@@ -90,295 +47,128 @@
 
 #include "test.h"
 #include "usctest.h"
+#include "safe_macros.h"
 
-#define TEST_FILE1	"testfile"	/* file under test */
-#define TEST_FILE2	"t_file/testfile"	/* file under test */
+#define TEST_FILE1	"testfile"
+#define TEST_FILE2	"t_file/testfile"
+#define TEST_DIR1	"testdir"
 #define FILE_MODE	S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
 #define NEW_MODE	S_IRUSR | S_IRGRP | S_IROTH
-#define BUF_SIZE	256	/* buffer size */
-#define FILE_SIZE	1024	/* test file size */
-#define TRUNC_LEN	256	/* truncation length */
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
-
-int no_setup();
-int setup1();			/* setup function to test chmod for EACCES */
-int setup2();			/* setup function to test chmod for ENOTDIR */
-int longpath_setup();		/* setup function to test chmod for ENAMETOOLONG */
+#define DIR_MODE	S_IRWXU
+#define TRUNC_LEN	256
 
-TCID_DEFINE(truncate03);
-int exp_enos[] = { EACCES, ENOTDIR, EFAULT, ENAMETOOLONG, ENOENT, 0 };
+static char Longpathname[PATH_MAX + 2];
+static char High_address_node[64];
 
-char *bad_addr = 0;
-
-char Longpathname[PATH_MAX + 2];
-char High_address_node[64];
-
-struct test_case_t {		/* test case struct. to hold ref. test cond's */
+static struct test_case_t {
 	char *pathname;
-	char *desc;
+	off_t length;
 	int exp_errno;
-	int (*setupfunc) ();
-} Test_cases[] = {
-	{
-	TEST_FILE1, "No Search permissions to process", EACCES, setup1}, {
-	TEST_FILE2, "Path contains regular file", ENOTDIR, setup2},
+} test_cases[] = {
+	{ TEST_FILE1, TRUNC_LEN, EACCES },
+	{ TEST_FILE2, TRUNC_LEN, ENOTDIR },
 #if !defined(UCLINUX)
-	{
-	High_address_node, "Address beyond address space", EFAULT, no_setup},
-	{
-	(char *)-1, "Negative address", EFAULT, no_setup},
+	{ High_address_node, TRUNC_LEN, EFAULT },
+	{ (char *)-1, TRUNC_LEN, EFAULT },
 #endif
-	{
-	Longpathname, "Pathname too long", ENAMETOOLONG, longpath_setup}, {
-	"", "Pathname is empty", ENOENT, no_setup}, {
-	NULL, NULL, 0, no_setup}
+	{ Longpathname, TRUNC_LEN, ENAMETOOLONG },
+	{ "", TRUNC_LEN, ENOENT },
+	{ TEST_DIR1, TRUNC_LEN, EISDIR }
 };
 
-int TST_TOTAL = sizeof(Test_cases) / sizeof(*Test_cases);
+static void setup(void);
+static void cleanup(void);
+static void truncate_verify(struct test_case_t *);
 
-void setup();			/* Main setup function for the test */
-void cleanup();			/* Main cleanup function for the test */
+char *TCID = "truncate03";
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+static int exp_enos[] = { EACCES, ENOTDIR, EFAULT, ENAMETOOLONG,
+							ENOENT, EISDIR, 0 };
 
 int main(int ac, char **av)
 {
-	int lc;
+	int i, lc;
 	const char *msg;
-	char *file_name;	/* testfile name */
-	char *test_desc;	/* test specific error message */
-	int ind;
 
 	msg = parse_opts(ac, av, NULL, NULL);
-	if (msg != NULL) {
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
-	}
-
-	/*
-	 * Perform global setup for test to call individual test specific
-	 * setup functions.
-	 */
 	setup();
 
-	/* set the expected errnos... */
 	TEST_EXP_ENOS(exp_enos);
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
 		tst_count = 0;
 
-		for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
-			file_name = Test_cases[ind].pathname;
-			test_desc = Test_cases[ind].desc;
+		for (i = 0; i < TST_TOTAL; i++)
+			truncate_verify(&test_cases[i]);
 
-#if !defined(UCLINUX)
-			if (file_name == High_address_node) {
-				file_name = (char *)get_high_address();
-			}
-#endif
-
-			/*
-			 * Call truncate(2) to test different test conditions.
-			 * verify that it fails with return code -1 and sets
-			 * appropriate errno.
-			 */
-			TEST(truncate(file_name, TRUNC_LEN));
-
-			if (TEST_RETURN == -1) {
-				TEST_ERROR_LOG(TEST_ERRNO);
-				if (TEST_ERRNO == Test_cases[ind].exp_errno) {
-					tst_resm(TPASS, "truncate() fails, %s, "
-						 "errno=%d", test_desc,
-						 TEST_ERRNO);
-				} else {
-					tst_resm(TFAIL, "truncate() fails, %s, "
-						 "errno=%d, expected errno:%d",
-						 test_desc, TEST_ERRNO,
-						 Test_cases[ind].exp_errno);
-				}
-			} else {
-				tst_resm(TFAIL, "truncate() returned %ld, "
-					 "expected -1, errno:%d",
-					 TEST_RETURN,
-					 Test_cases[ind].exp_errno);
-			}
-		}
-		tst_count++;	/* incr TEST_LOOP counter */
 	}
 
 	cleanup();
 	tst_exit();
-	tst_exit();
-
 }
 
-/*
- * void
- * setup() - performs all ONE TIME setup for this test.
- *  Create a temporary directory and change directory to it.
- *  Create a test file under temporary directory and write some data
- *  into it, close it.
- *  Call individual test specific setup functions.
- */
 void setup(void)
 {
-	int fd, i, ind;		/* file handler for testfile */
-	int c, c_total = 0;	/* no. of bytes written to file */
-	char tst_buff[BUF_SIZE];	/* buffer to hold data */
+	struct passwd *ltpuser;
+	char *bad_addr;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
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
+	tst_require_root(NULL);
+
+	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
+	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
 
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -i option.
-	 * You want to make sure you do this before you create your temporary
-	 * directory.
-	 */
 	TEST_PAUSE;
 
 	tst_tmpdir();
 
-	/* Fill the test buffer with the known data */
-	for (i = 0; i < BUF_SIZE; i++) {
-		tst_buff[i] = 'a';
-	}
-
-	/* Creat a testfile and open it for reading/writing */
-	if ((fd = open(TEST_FILE1, O_RDWR | O_CREAT, FILE_MODE)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "open(%s, O_RDWR|O_CREAT, %o) Failed, errno=%d : %s",
-			 TEST_FILE1, FILE_MODE, errno, strerror(errno));
-	}
+	SAFE_TOUCH(cleanup, TEST_FILE1, FILE_MODE, NULL);
+	SAFE_CHMOD(cleanup, TEST_FILE1, NEW_MODE);
 
-	/* Write to the file 1k data from the buffer */
-	while (c_total < FILE_SIZE) {
-		if ((c = write(fd, tst_buff, sizeof(tst_buff))) <= 0) {
-			tst_brkm(TBROK, cleanup,
-				 "write(2) on %s Failed, errno=%d : %s",
-				 TEST_FILE1, errno, strerror(errno));
-		} else {
-			c_total += c;
-		}
-	}
+	SAFE_TOUCH(cleanup, "t_file", FILE_MODE, NULL);
 
-	/* Close the testfile after writing data into it */
-	if (close(fd) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "close(%s) Failed, errno=%d : %s",
-			 TEST_FILE1, errno, strerror(errno));
-	}
 #if !defined(UCLINUX)
-	bad_addr = mmap(0, 1, PROT_NONE,
+	test_cases[2].pathname = (char *)get_high_address();
+
+	bad_addr = SAFE_MMAP(cleanup, 0, 1, PROT_NONE,
 			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
-	if (bad_addr == MAP_FAILED) {
-		tst_brkm(TBROK, cleanup, "mmap failed");
-	}
-	Test_cases[3].pathname = bad_addr;
+	test_cases[3].pathname = bad_addr;
 #endif
 
-	/* call individual setup functions */
-	for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
-		Test_cases[ind].setupfunc();
-	}
-}
+	memset(Longpathname, 'a', PATH_MAX + 1);
 
-/*
- * int
- * no_setup() - Some test conditions for mknod(2) do not any setup.
- *              Hence, this function just returns 0.
- *  This function simply returns 0.
- */
-int no_setup(void)
-{
-	return 0;
+	SAFE_MKDIR(cleanup, TEST_DIR1, DIR_MODE);
 }
 
-/*
- * int
- * setup1() - setup function for a test condition for which truncate(2)
- *            returns -1 and sets errno to EACCES.
- *  Modify the mode permissions on testfile such that process will not
- *  have write permissions on it.
- *
- *  The function returns 0.
- */
-int setup1(void)
+void truncate_verify(struct test_case_t *tc)
 {
-	/* Change mode permissions on test file */
-	if (chmod(TEST_FILE1, NEW_MODE) < 0) {
-		tst_brkm(TBROK, cleanup, "chmod(2) of %s failed", TEST_FILE1);
-	}
+	TEST(truncate(tc->pathname, tc->length));
 
-	return 0;
-}
-
-/*
- * int
- * setup2() - setup function for a test condition for which truncate(2)
- *           returns -1 and sets errno to ENOTDIR.
- *
- *  Create a test file under temporary directory so that test tries to
- *  truncate testfile under "t_file" which happens to be another regular file.
- *  The function returns 0.
- */
-int setup2(void)
-{
-	int fildes;
-
-	/* creat/open a test file under temporary directory */
-	if ((fildes = open("t_file", O_RDWR | O_CREAT, FILE_MODE)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "open(2) on t_file failed, errno=%d : %s",
-			 errno, strerror(errno));
-	}
-	/* Close the file created above */
-	if (close(fildes) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "close(t_file) Failed, errno=%d : %s",
-			 errno, strerror(errno));
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "truncate() returned %ld, "
+			"expected -1, errno:%d", TEST_RETURN,
+			tc->exp_errno);
+		return;
 	}
-	return 0;
-}
 
-/*
- * int
- * longpath_setup() - setup to create a node with a name length exceeding
- *                    the MAX. length of PATH_MAX.
- *   This function retruns 0.
- */
-int longpath_setup(void)
-{
-	int ind;		/* counter variable */
+	TEST_ERROR_LOG(TEST_ERRNO);
 
-	for (ind = 0; ind <= (PATH_MAX + 1); ind++) {
-		Longpathname[ind] = 'a';
+	if (TEST_ERRNO == tc->exp_errno) {
+		tst_resm(TPASS | TTERRNO, "truncate() failed as expected");
+	} else {
+		tst_resm(TFAIL | TTERRNO,
+			"truncate() failed unexpectedly; expected: %d - %s",
+			tc->exp_errno, strerror(tc->exp_errno));
 	}
-	return 0;
 }
 
-/*
- * void
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- *  Remove the test directory and testfile created in the setup.
- */
 void cleanup(void)
 {
-	/*
-	 * print timing stats if that option was specified.
-	 */
 	TEST_CLEANUP;
 
 	tst_rmdir();
-
 }
diff --git a/testcases/kernel/syscalls/truncate/truncate04.c b/testcases/kernel/syscalls/truncate/truncate04.c
deleted file mode 100644
index ff38e64..0000000
--- a/testcases/kernel/syscalls/truncate/truncate04.c
+++ /dev/null
@@ -1,219 +0,0 @@
-/*
- *
- *   Copyright (C) Bull S.A. 2001
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
- * Test Name: truncate04
- *
- * Test Description:
- *  Verify that,
- *     truncate(2) returns -1 and sets errno to EISDIR if the named file
- *     is a directory.
- *
- * Expected Result:
- *  truncate() should fail with return value -1 and set expected errno.
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
- *   truncate04 [-c n] [-e] [-f] [-i n] [-I x] [-p x] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-e   : Turn on errno logging.
- *		-f   : Turn off functionality Testing.
- *		-i n : Execute test n times.
- *		-I x : Execute test for x seconds.
- *		-P x : Pause for x seconds between iterations.
- *		-t   : Turn on syscall timing.
- *
- * History
- *	05/2002 Jacky Malcles
- *		-Ported
- *
- * Restrictions:
- *  This test should be executed by 'non-super-user' only.
- *
- */
-
-#include <stdio.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/fcntl.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include <pwd.h>
-
-#include "test.h"
-#include "usctest.h"
-
-#define MODES   	S_IRWXU
-#define TEST_DIR	"testdir"
-#define TRUNC_LEN	256	/* truncation length */
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
-
-TCID_DEFINE(truncate04);
-int TST_TOTAL = 1;		/* Total number of test conditions */
-
-char test_desc[] = "File is a directory";
-int exp_enos[] = { EISDIR, 0 };
-
-int r_val;
-int fd;
-
-void setup();			/* Main setup function for the test */
-void cleanup();			/* Main cleanup function for the test */
-
-int main(int ac, char **av)
-{
-	int lc;
-	const char *msg;
-	char *file_name;	/* testfile name */
-
-	msg = parse_opts(ac, av, NULL, NULL);
-	if (msg != NULL) {
-		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-
-	}
-
-	/*
-	 * Perform global setup
-	 */
-	setup();
-
-	/* set the expected errnos... */
-	TEST_EXP_ENOS(exp_enos);
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/*
-		 * Call truncate(2)
-		 * verify that it fails with return code -1 and sets
-		 * appropriate errno.
-		 */
-		file_name = TEST_DIR;
-		TEST(truncate(file_name, TRUNC_LEN));
-
-		if (TEST_RETURN == -1) {
-			TEST_ERROR_LOG(TEST_ERRNO);
-			if (TEST_ERRNO == EISDIR) {
-				tst_resm(TPASS, "truncate() fails, %s, "
-					 "errno=%d", test_desc, TEST_ERRNO);
-			} else {
-				tst_resm(TFAIL, "truncate() fails, %s, "
-					 "errno=%d, expected errno:%d",
-					 test_desc, TEST_ERRNO, EISDIR);
-			}
-		} else {
-			tst_resm(TFAIL, "truncate() returned %ld, "
-				 "expected -1, errno EISDIR", TEST_RETURN);
-		}
-	}
-
-	cleanup();
-	tst_exit();
-	tst_exit();
-
-}
-
-/*
- * void
- * setup() - performs all ONE TIME setup for this test.
- *  Create a temporary directory and change directory to it.
- *  Create a test directory under temporary directory and open it
- */
-void setup(void)
-{
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
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
-
-	/*
-	 * Pause if that option was specified
-	 */
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	/*
-	 * create a new directory and open it
-	 */
-
-	if ((r_val = mkdir(TEST_DIR, MODES)) == -1) {
-		tst_brkm(TBROK, cleanup, "%s - mkdir() in main() "
-			 "failed", TCID);
-	}
-
-	if ((fd = open(TEST_DIR, O_RDONLY)) == -1) {
-		tst_brkm(TBROK, cleanup, "open of directory failed");
-	}
-
-}
-
-/*
- * void
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- *  Remove the test directory and testfile created in the setup.
- */
-void cleanup(void)
-{
-	/*
-	 * print timing stats if that option was specified.
-	 */
-	TEST_CLEANUP;
-
-	if (close(fd) < 0) {
-		tst_brkm(TBROK, cleanup, "close failed: errno = %d", errno);
-	}
-
-	tst_rmdir();
-
-}
-- 
1.9.0


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their 
applications. Written by three acclaimed leaders in the field, 
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
