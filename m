From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 8 Apr 2019 14:52:27 +0800
Subject: [LTP] [PATCH v2 2/2] syscalls/stat03,
	06: Cleanup && Convert to new API
In-Reply-To: <1554706347-2452-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20190404131911.GB10585@rei.lan>
 <1554706347-2452-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1554706347-2452-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) Take use of some safe macros
2) Remove duplicate tests stat06
3) Add ELOOP check
4) Remove useless struct member

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 runtest/quickhit                          |   2 -
 runtest/syscalls                          |   2 -
 testcases/kernel/syscalls/stat/.gitignore |   2 -
 testcases/kernel/syscalls/stat/stat03.c   | 354 ++++-----------------
 testcases/kernel/syscalls/stat/stat06.c   | 361 ----------------------
 5 files changed, 57 insertions(+), 664 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/stat/stat06.c

diff --git a/runtest/quickhit b/runtest/quickhit
index 31c571eaa..b13ce0887 100644
--- a/runtest/quickhit
+++ b/runtest/quickhit
@@ -223,8 +223,6 @@ signal03 signal03
 # and signal sending.
 sigrelse01 sigrelse01
 # Releasing held signals
-stat06 stat06
-# Negative tests for stat(2)
 statfs01 statfs01
 # Basic test for statfs(2) mounted filesys
 statvfs01 statvfs01
diff --git a/runtest/syscalls b/runtest/syscalls
index 9fa58f7f9..e8fe9785a 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1323,8 +1323,6 @@ stat03 stat03
 stat03_64 stat03_64
 stat04 symlink01 -T stat04
 stat04_64 symlink01 -T stat04_64
-stat06 stat06
-stat06_64 stat06_64
 
 statfs01 statfs01
 statfs01_64 statfs01_64
diff --git a/testcases/kernel/syscalls/stat/.gitignore b/testcases/kernel/syscalls/stat/.gitignore
index 0705df714..4a8f61858 100644
--- a/testcases/kernel/syscalls/stat/.gitignore
+++ b/testcases/kernel/syscalls/stat/.gitignore
@@ -2,5 +2,3 @@
 /stat01_64
 /stat03
 /stat03_64
-/stat06
-/stat06_64
diff --git a/testcases/kernel/syscalls/stat/stat03.c b/testcases/kernel/syscalls/stat/stat03.c
index 2e4c83a93..20d4c772f 100644
--- a/testcases/kernel/syscalls/stat/stat03.c
+++ b/testcases/kernel/syscalls/stat/stat03.c
@@ -1,333 +1,93 @@
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
- * Test Name: stat03
- *
- * Test Description:
- *   Verify that,
- *   1) stat(2) returns -1 and sets errno to EACCES if search permission is
- *      denied on a component of the path prefix.
- *   2) stat(2) returns -1 and sets errno to ENOENT if the specified file
- *	does not exists or empty string.
- *   3) stat(2) returns -1 and sets errno to EFAULT if pathname points
- *	outside user's accessible address space.
- *   4) stat(2) returns -1 and sets errno to ENAMETOOLONG if the pathname
- *	component is too long.
- *   5) stat(2) returns -1 and sets errno to ENOTDIR if the directory
- *	component in pathname is not a directory.
- *
- * Expected Result:
- *  stat() should fail with return value -1 and set expected errno.
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
- *  stat03 [-c n] [-e] [-i n] [-I x] [-p x] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-e   : Turn on errno logging.
- *		-i n : Execute test n times.
- *		-I x : Execute test for x seconds.
- *		-P x : Pause for x seconds between iterations.
- *		-t   : Turn on syscall timing.
- *
- * History
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) International Business Machines  Corp., 2001
  *	07/2001 John George
  *		-Ported
  *
- * Restrictions:
- *
+ * check stat() with various error conditions that should produce
+ * EACCES, EFAULT, ENAMETOOLONG,  ENOENT, ENOTDIR, ELOOP
  */
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
 #include <fcntl.h>
 #include <errno.h>
-#include <string.h>
-#include <signal.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <sys/mman.h>
 #include <pwd.h>
+#include "tst_test.h"
 
-#include "test.h"
-#include "safe_macros.h"
+#define TST_EACCES_DIR   "tst_eaccesdir"
+#define TST_EACCES_FILE  "tst_eaccesdir/tst"
+#define TST_ENOENT       "tst_enoent/tst"
+#define TST_ENOTDIR_DIR  "tst_enotdir/tst"
+#define TST_ENOTDIR_FILE "tst_enotdir"
 
-#define MODE_RWX	S_IRWXU | S_IRWXG | S_IRWXO
-#define FILE_MODE	S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
-#define DIR_TEMP	"testdir_1"
-#define TEST_FILE1	"testdir_1/tfile_1"
-#define TEST_FILE2	"t_file/tfile_2"
+#define MODE_RW	        0666
+#define DIR_MODE        0755
 
-int no_setup();
-int setup1();			/* setup function to test chmod for EACCES */
-int setup2();			/* setup function to test chmod for ENOTDIR */
-int longpath_setup();		/* setup function to test chmod for ENAMETOOLONG */
-char nobody_uid[] = "nobody";
 struct passwd *ltpuser;
 
-char Longpathname[PATH_MAX + 2];
+static char long_dir[PATH_MAX + 2] = {[0 ... PATH_MAX + 1] = 'a'};
+static char loop_dir[PATH_MAX] = ".";
 
-struct test_case_t {		/* test case struct. to hold ref. test cond's */
+static struct tcase{
 	char *pathname;
-	char *desc;
 	int exp_errno;
-	int (*setupfunc) ();
-} Test_cases[] = {
-	{TEST_FILE1, "No Search permissions to process", EACCES, setup1}, {
-	NULL, "Invalid address", EFAULT, no_setup}, {
-	Longpathname, "Pathname too long", ENAMETOOLONG, longpath_setup}, {
-	"", "Pathname is empty", ENOENT, no_setup}, {
-	TEST_FILE2, "Path contains regular file", ENOTDIR, setup2}, {
-	NULL, NULL, 0, no_setup}
+} TC[] = {
+	{TST_EACCES_FILE, EACCES},
+	{NULL, EFAULT},
+	{long_dir, ENAMETOOLONG},
+	{TST_ENOENT, ENOENT},
+	{TST_ENOTDIR_DIR, ENOTDIR},
+	{loop_dir, ELOOP}
 };
 
-char *TCID = "stat03";
-int TST_TOTAL = ARRAY_SIZE(Test_cases);
-
-void setup();			/* Main setup function for the tests */
-void cleanup();			/* cleanup function for the test */
-
-int main(int ac, char **av)
-{
-	struct stat stat_buf;	/* stat structure buffer */
-	int lc;
-	char *file_name;	/* ptr. for file name whose mode is modified */
-	char *test_desc;	/* test specific error message */
-	int ind;		/* counter to test different test conditions */
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	/*
-	 * Invoke setup function to call individual test setup functions
-	 * to simulate test conditions.
-	 */
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
-			file_name = Test_cases[ind].pathname;
-			test_desc = Test_cases[ind].desc;
-
-			/*
-			 * Call stat(2) to test different test conditions.
-			 * verify that it fails with -1 return value and
-			 * sets appropriate errno.
-			 */
-			TEST(stat(file_name, &stat_buf));
-
-			/* Check return code from stat(2) */
-			if (TEST_RETURN == -1) {
-				if (TEST_ERRNO == Test_cases[ind].exp_errno) {
-					tst_resm(TPASS,
-						 "stat() fails, %s, errno:%d",
-						 test_desc, TEST_ERRNO);
-				} else {
-					tst_resm(TFAIL,
-						 "stat() fails, %s, errno:%d, expected errno:%d",
-						 test_desc, TEST_ERRNO,
-						 Test_cases[ind].exp_errno);
-				}
-			} else {
-				tst_resm(TFAIL,
-					 "stat(2) returned %ld, expected -1, errno:%d",
-					 TEST_RETURN,
-					 Test_cases[ind].exp_errno);
-			}
-		}
-		tst_count++;	/* incr TEST_LOOP counter */
-	}
-
-	/*
-	 * Invoke cleanup() to delete the test directory/file(s) created
-	 * in the setup().
-	 */
-	cleanup();
-	tst_exit();
-
-}
-
-/*
- * void
- * setup(void) - performs all ONE TIME setup for this test.
- * 	Exit the test program on receipt of unexpected signals.
- *	Create a temporary directory and change directory to it.
- *	Invoke individual test setup functions according to the order
- *	set in struct. definition.
- */
-void setup(void)
+static void verify_stat(unsigned int n)
 {
-	int ind;
-
-	tst_require_root();
+	struct tcase *tc = TC + n;
+	struct stat stat_buf;
 
-	/* Capture unexpected signals */
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	/* Switch to nobody user for correct error code collection */
-	ltpuser = getpwnam(nobody_uid);
-	if (setuid(ltpuser->pw_uid) == -1) {
-		tst_resm(TINFO, "setuid failed to "
-			 "to set the effective uid to %d", ltpuser->pw_uid);
-		perror("setuid");
+	TEST(stat(tc->pathname, &stat_buf));
+	if (TST_RET != -1) {
+		tst_res(TFAIL, "stat() succeeded unexpectedly");
+		return;
 	}
 
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -i option.
-	 * You want to make sure you do this before you create your temporary
-	 * directory.
-	 */
-	TEST_PAUSE;
-
-	/* Make a temp dir and cd to it */
-	tst_tmpdir();
-
-	/* call individual setup functions */
-	for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
-		if (!Test_cases[ind].pathname)
-			Test_cases[ind].pathname = tst_get_bad_addr(cleanup);
-		Test_cases[ind].setupfunc();
+	if (TST_ERR == tc->exp_errno) {
+		tst_res(TPASS | TTERRNO, "stat() failed as expected");
+	} else {
+		tst_res(TFAIL | TTERRNO,
+			"stat() failed unexpectedly; expected: %d - %s",
+			tc->exp_errno, tst_strerrno(tc->exp_errno));
 	}
 }
 
-/*
- * int
- * no_setup() - Some test conditions for stat(2) do not any setup.
- *              Hence, this function just returns 0.
- *  This function simply returns 0.
- */
-int no_setup(void)
+static void setup(void)
 {
-	return 0;
-}
+	unsigned int i;
 
-/*
- * int
- * setup1() - setup function for a test condition for which stat(2)
- *	      returns -1 and sets errno to EACCES.
- *  Create a test directory under temporary directory and create a test file
- *  under this directory with mode "0666" permissions.
- *  Modify the mode permissions on test directory such that process will not
- *  have search permissions on test directory.
- *
- *  The function returns 0.
- */
-int setup1(void)
-{
-	int fd;			/* file handle for testfile */
+	ltpuser = SAFE_GETPWNAM("nobody");
+	SAFE_SETUID(ltpuser->pw_uid);
 
-	/* Creat a test directory */
-	SAFE_MKDIR(cleanup, DIR_TEMP, MODE_RWX);
+	SAFE_MKDIR(TST_EACCES_DIR, DIR_MODE);
+	SAFE_TOUCH(TST_EACCES_FILE, DIR_MODE, NULL);
+	SAFE_CHMOD(TST_EACCES_DIR, MODE_RW);
 
-	/* Creat a test file under above test directory */
-	if ((fd = open(TEST_FILE1, O_RDWR | O_CREAT, 0666)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "open(%s, O_RDWR|O_CREAT, 0666) failed, errno=%d : %s",
-			 TEST_FILE1, errno, strerror(errno));
+	for (i = 0; i < ARRAY_SIZE(TC); i++) {
+		if (TC[i].exp_errno == EFAULT)
+			TC[i].pathname = tst_get_bad_addr(NULL);
 	}
-	/* Close the test file */
-	SAFE_CLOSE(cleanup, fd);
-
-	/* Modify mode permissions on test directory */
-	SAFE_CHMOD(cleanup, DIR_TEMP, FILE_MODE);
-	return 0;
-}
 
-/*
- * int
- * setup2() - setup function for a test condition for which stat(2)
- *	     returns -1 and sets errno to ENOTDIR.
- *
- *  Create a test file under temporary directory so that test tries to
- *  change mode of a testfile "tfile_2" under "t_file" which happens to be
- *  another regular file.
- */
-int setup2(void)
-{
-	int fd;			/* File handle for test file */
+	SAFE_TOUCH(TST_ENOTDIR_FILE, DIR_MODE, NULL);
 
-	/* Creat a test file under temporary directory */
-	if ((fd = open("t_file", O_RDWR | O_CREAT, MODE_RWX)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "open(2) on t_file failed, errno=%d : %s",
-			 errno, strerror(errno));
-	}
-	/* Close the test file created above */
-	SAFE_CLOSE(cleanup, fd);
-	return 0;
-}
-
-/*
- * int
- * longpath_setup() - setup to create a node with a name length exceeding
- *                    the MAX. length of PATH_MAX.
- *   This function retruns 0.
- */
-int longpath_setup(void)
-{
-	int ind;		/* counter variable */
-
-	for (ind = 0; ind <= (PATH_MAX + 1); ind++) {
-		Longpathname[ind] = 'a';
-	}
-	return 0;
+	SAFE_MKDIR("test_eloop", DIR_MODE);
+	SAFE_SYMLINK("../test_eloop", "test_eloop/test_eloop");
+	for (i = 0; i < 43; i++)
+		strcat(loop_dir, "/test_eloop");
 }
 
-/*
- * void
- * cleanup() - Performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- *	Print test timing stats and errno log if test executed with options.
- *	Remove temporary directory and sub-directories/files under it
- *	created during setup().
- *	Exit the test program with normal exit code.
- */
-void cleanup(void)
-{
-
-	/* Restore mode permissions on test directory created in setup2() */
-	if (chmod(DIR_TEMP, MODE_RWX) < 0) {
-		tst_brkm(TFAIL, NULL, "chmod(2) of %s failed", DIR_TEMP);
-	}
-
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(TC),
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.setup = setup,
+	.test = verify_stat,
+};
diff --git a/testcases/kernel/syscalls/stat/stat06.c b/testcases/kernel/syscalls/stat/stat06.c
deleted file mode 100644
index c5eb1da82..000000000
--- a/testcases/kernel/syscalls/stat/stat06.c
+++ /dev/null
@@ -1,361 +0,0 @@
-/*
- * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
- *
- */
-/* $Id: stat06.c,v 1.10 2009/11/02 13:57:19 subrata_modak Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: stat06
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: stat(2) negative path testcases
- *
- *    PARENT DOCUMENT	: None
- *
- *    TEST CASE TOTAL	: 7
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
- * 	1-7) See Testcases structure below.
- *
- *    INPUT SPECIFICATIONS
- * 	The standard options for system call tests are accepted.
- *	(See the parse_opts(3) man page).
- *      -h  : print help and exit
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
- * 	The libcuts.a and libsys.a libraries must be included in
- *	the compilation of this test.
- *
- *    SPECIAL PROCEDURAL REQUIREMENTS
- * 	None
- *
- *    INTERCASE DEPENDENCIES
- * 	None
- *
- *    DETAILED DESCRIPTION
- *	This is a Phase I test for the stat(2) system call.  It is intended
- *	to provide a limited exposure of the system call, for now.  It
- *	should/will be extended when full functional tests are written for
- *	stat(2).
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
-#include <sys/mman.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include <setjmp.h>
-#include <unistd.h>
-#include "test.h"
-
-void setup();
-void cleanup();
-
-char *TCID = "stat06";
-
-char *bad_addr = 0;
-
-#if !defined(UCLINUX)
-int high_address_setup();
-char High_address[64];
-#endif
-int longpath_setup();
-int no_setup();
-int filepath_setup();
-char Longpathname[PATH_MAX + 2];
-struct stat statbuf;
-jmp_buf sig11_recover;
-void sig11_handler(int sig);
-
-struct test_case_t {
-	char *pathname;
-	struct stat *stbuf;
-	char *desc;
-	int exp_errno;
-	int (*setupfunc) ();
-} Test_cases[] = {
-	{
-	"nonexistfile", &statbuf, "non-existent file", ENOENT, no_setup}, {
-	"", &statbuf, "path is empty string", ENOENT, no_setup}, {
-	"nefile/file", &statbuf, "path contains a non-existent file",
-		    ENOENT, no_setup}, {
-	"file/file", &statbuf, "path contains a regular file",
-		    ENOTDIR, filepath_setup}, {
-	Longpathname, &statbuf, "pathname too long", ENAMETOOLONG,
-		    longpath_setup},
-#if !defined(UCLINUX)
-	{
-	High_address, &statbuf, "address beyond address space", EFAULT,
-		    high_address_setup}, {
-	(char *)-1, &statbuf, "negative address", EFAULT, no_setup},
-#endif
-	{
-	NULL, NULL, NULL, 0, no_setup}
-};
-
-int TST_TOTAL = ARRAY_SIZE(Test_cases);
-
-/***********************************************************************
- * Main
- ***********************************************************************/
-int main(int ac, char **av)
-{
-	int lc;
-	char *fname;
-	char *desc;
-	int ind;
-	struct stat *stbuf;
-	struct sigaction sa, osa;
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
-			stbuf = Test_cases[ind].stbuf;
-
-			if (stbuf == (struct stat *)-1) {
-				/* special sig11 case */
-				sa.sa_handler = &sig11_handler;
-				sigemptyset(&sa.sa_mask);
-				sa.sa_flags = 0;
-
-				sigaction(SIGSEGV, NULL, &osa);
-				sigaction(SIGSEGV, &sa, NULL);
-
-				if (setjmp(sig11_recover)) {
-					TEST_RETURN = -1;
-					TEST_ERRNO = EFAULT;
-				} else {
-					TEST(stat(fname, stbuf));
-				}
-				sigaction(SIGSEGV, &osa, NULL);
-			} else {
-				/*
-				 *  Call stat(2)
-				 */
-
-				TEST(stat(fname, stbuf));
-			}
-
-			/* check return code */
-			if (TEST_RETURN == -1) {
-				if (TEST_ERRNO ==
-				    Test_cases[ind].exp_errno)
-					tst_resm(TPASS,
-						 "stat(<%s>, &stbuf) Failed, errno=%d",
-						 desc, TEST_ERRNO);
-				else
-					tst_resm(TFAIL,
-						 "stat(<%s>, &stbuf) Failed, errno=%d, expected errno:%d",
-						 desc, TEST_ERRNO,
-						 Test_cases
-						 [ind].exp_errno);
-			} else {
-				tst_resm(TFAIL,
-					 "stat(<%s>, &stbuf) returned %ld, expected -1, errno:%d",
-					 desc, TEST_RETURN,
-					 Test_cases[ind].exp_errno);
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
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-#if !defined(UCLINUX)
-	bad_addr = mmap(0, 1, PROT_NONE,
-			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
-	if (bad_addr == MAP_FAILED) {
-		tst_brkm(TBROK, cleanup, "mmap failed");
-	}
-	Test_cases[6].pathname = bad_addr;
-#endif
-
-	for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
-		Test_cases[ind].setupfunc();
-	}
-
-}
-
-/***************************************************************
- * cleanup() - performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- ***************************************************************/
-void cleanup(void)
-{
-
-	tst_rmdir();
-
-}
-
-/******************************************************************
- * no_setup() - does nothing
- ******************************************************************/
-int no_setup(void)
-{
-	return 0;
-}
-
-#if !defined(UCLINUX)
-
-/******************************************************************
- * high_address_setup() - generates an address that should cause a segfault
- ******************************************************************/
-int high_address_setup(void)
-{
-	int ind;
-
-	for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
-		if (Test_cases[ind].pathname == High_address) {
-			/*if (strcmp(Test_cases[ind].pathname, HIGH_ADDRESS) == 0) { ** */
-			Test_cases[ind].pathname = (char *)(sbrk(0) + 5);
-			break;
-		}
-	}
-	return 0;
-
-}
-#endif
-
-/******************************************************************
- * longpath_setup() - creates a filename that is too long
- ******************************************************************/
-int longpath_setup(void)
-{
-	int ind;
-
-	for (ind = 0; ind <= PATH_MAX + 1; ind++) {
-		Longpathname[ind] = 'a';
-	}
-	return 0;
-
-}
-
-/******************************************************************
- * filepath_setup() creates a file the exists that we will treat as a directory
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
-
-/******************************************************************
- * sig11_handler() - our segfault recover hack
- ******************************************************************/
-void sig11_handler(int sig)
-{
-	longjmp(sig11_recover, 1);
-}
-- 
2.18.1



