Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WvGmM-0003S9-KE
	for ltp-list@lists.sourceforge.net; Fri, 13 Jun 2014 01:59:42 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WvGmK-00066B-Bx
	for ltp-list@lists.sourceforge.net; Fri, 13 Jun 2014 01:59:42 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s5D1xWOR019600
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Jun 2014 09:59:33 +0800
Message-ID: <1402624753.2098.9.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Fri, 13 Jun 2014 09:59:13 +0800
In-Reply-To: <1402624697.2098.8.camel@G08JYZSD130126>
References: <1402624697.2098.8.camel@G08JYZSD130126>
MIME-Version: 1.0
Subject: [LTP] [PATCH 2/3] utime/utime06.c: cleanup
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

* Delete some useless comments.

* Delete some useless variable value.

* Test without fork().

* Some cleanup.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/utime/utime06.c | 290 ++++++------------------------
 1 file changed, 53 insertions(+), 237 deletions(-)

diff --git a/testcases/kernel/syscalls/utime/utime06.c b/testcases/kernel/syscalls/utime/utime06.c
index a1a9230..2dd68d8 100644
--- a/testcases/kernel/syscalls/utime/utime06.c
+++ b/testcases/kernel/syscalls/utime/utime06.c
@@ -1,78 +1,31 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
+ *	07/2001 John George
  *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
- * Test Name: utime06
- *
  * Test Description:
  * 1. Verify that the system call utime() fails to set the modification
  *    and access times of a file to the current time, under the following
  *    constraints,
  *	 - The times argument is null.
  *	 - The user ID of the process is not "root".
- *	 - The file is not owned by the user ID of the process.
- *	 - The user ID of the process does not have write access to the
- *	   file.
  * 2. Verify that the system call utime() fails to set the modification
  *    and access times of a file if the specified file doesn't exist.
- *
- * Expected Result:
- * 1. utime should fail with -1 return value and sets errno EACCES.
- * 2. utime should fail with -1 return value and sets errno ENOENT.
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
- *	if errno set == expected errno
- *		Issue sys call fails with expected return value and errno.
- *	Otherwise,
- *		Issue sys call fails with unexpected errno.
- *   Otherwise,
- *	Issue sys call returns unexpected value.
- *
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *   Delete the temporary directory(s)/file(s) created.
- *
- * Usage:  <for command-line>
- *  utime06 [-c n] [-e] [-i n] [-I x] [-p x] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-e   : Turn on errno logging.
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
- *  This test must be executed by root.
- *   nobody and bin must be valid users.
  */
 
 #include <errno.h>
@@ -90,230 +43,93 @@
 
 #include "test.h"
 #include "usctest.h"
+#include "safe_macros.h"
 
-#define LTPUSER1        "nobody"
-#define LTPUSER2        "bin"
 #define TEMP_FILE	"tmp_file"
-#define FILE_MODE	S_IRUSR | S_IRGRP | S_IROTH
 
 char *TCID = "utime06";
-int TST_TOTAL = 2;
-time_t curr_time;		/* current time in seconds */
-time_t tloc;			/* argument var. for time() */
-int exp_enos[] = { EACCES, ENOENT, 0 };
+static int exp_enos[] = { EACCES, ENOENT, 0 };
 
-struct passwd *ltpuser;		/* password struct for ltpusers */
-uid_t user_uid;			/* user id of ltpuser */
-gid_t group_gid;		/* group id of ltpuser */
-int status;
+static struct passwd *ltpuser;
 
-int setup1();			/* setup function to test error EACCES */
-int no_setup();
-
-struct test_case_t {		/* test case struct. to hold ref. test cond's */
+struct test_case_t {
 	char *pathname;
-	char *desc;
 	int exp_errno;
-	int (*setupfunc) ();
 } Test_cases[] = {
-	{
-	TEMP_FILE, "Permission denied to modify file time", EACCES, setup1},
-	{
-	"", "Specified file doesn't exist", ENOENT, no_setup}, {
-	NULL, NULL, 0, NULL}
+	{TEMP_FILE, EACCES},
+	{"", ENOENT},
 };
 
-void setup();			/* Main setup function of test */
-void cleanup();			/* cleanup function for the test */
+int TST_TOTAL = ARRAY_SIZE(Test_cases);
+static void setup(void);
+static void utime_verify(const struct test_case_t *);
+static void cleanup(void);
 
 int main(int ac, char **av)
 {
 	int lc;
 	const char *msg;
-	char *file_name;	/* testfile name */
-	char *test_desc;	/* test specific error message */
-	int ind;		/* counter to test different test conditions */
-	int pid;
+	int i;
 
 	msg = parse_opts(ac, av, NULL, NULL);
-	if (msg != NULL) {
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
-	}
-
 	setup();
 
-	/* set the expected errnos... */
-	TEST_EXP_ENOS(exp_enos);
-
-	pid = FORK_OR_VFORK();
-
-	if (pid == -1) {
-		tst_brkm(TBROK, cleanup, "fork() failed");
-	} else if (pid == 0) {
-		if ((ltpuser = getpwnam(LTPUSER1)) == NULL) {
-			tst_brkm(TBROK, cleanup, "%s not found in /etc/passwd",
-				 LTPUSER1);
-		}
-
-		/* get uid of user */
-		user_uid = ltpuser->pw_uid;
-
-		seteuid(user_uid);
-
-		for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-			tst_count = 0;
-
-			for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
-				file_name = Test_cases[ind].pathname;
-				test_desc = Test_cases[ind].desc;
-
-				/*
-				 * Call utime(2) to test different test
-				 * conditions. Verify that it fails with -1
-				 * return value and sets appropriate errno.
-				 */
-				TEST(utime(file_name, NULL));
-
-				/* Check return code from utime(2) */
-				if (TEST_RETURN == -1) {
-					TEST_ERROR_LOG(TEST_ERRNO);
-					if (TEST_ERRNO ==
-					    Test_cases[ind].exp_errno) {
-						tst_resm(TPASS, "utime() "
-							 "fails, %s, errno:%d",
-							 test_desc, TEST_ERRNO);
-					} else {
-						tst_resm(TFAIL, "utime(2) "
-							 "fails, %s, errno:%d, "
-							 "expected errno:%d",
-							 test_desc, TEST_ERRNO,
-							 Test_cases
-							 [ind].exp_errno);
-					}
-				} else {
-					tst_resm(TFAIL,
-						 "utime(2) returned %ld, "
-						 "expected -1, errno:%d",
-						 TEST_RETURN,
-						 Test_cases[ind].exp_errno);
-				}
-			}
-
-			tst_count++;	/* incr TEST_LOOP counter */
-
-		}
-	} else {
-		waitpid(pid, &status, 0);
-		_exit(0);	/*
-				 * Exit here and let the child clean up.
-				 * This allows the errno information set
-				 * by the TEST_ERROR_LOG macro and the
-				 * PASS/FAIL status to be preserved for
-				 * use during cleanup.
-				 */
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+		for (i = 0; i < TST_TOTAL; i++)
+			utime_verify(&Test_cases[i]);
 	}
 
 	cleanup();
 	tst_exit();
-
 }
 
-/*
- * void
- * setup() - performs all ONE TIME setup for this test.
- *  Create a temporary directory and change directory to it.
- *  Invoke individual test setup functions according to the order
- *  set in test struct. definition.
- */
-void setup(void)
+static void setup(void)
 {
-	int ind;
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	/* Check that the test process id is non-super/root  */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Must be root for this test!");
-		tst_exit();
-	}
+	tst_require_root(NULL);
 
 	TEST_PAUSE;
 
 	tst_tmpdir();
 
-	/* call individual setup functions */
-	for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
-		Test_cases[ind].setupfunc();
-	}
-}
+	SAFE_TOUCH(cleanup, TEMP_FILE, 0644, NULL);
 
-/*
- * int
- * no_setup() - Some test conditions for utime(2) do not any setup.
- *              Hence, this function just returns 0.
- */
-int no_setup(void)
-{
-	return 0;
-}
+	TEST_EXP_ENOS(exp_enos);
 
-/*
- * int
- * setup1() - setup function for a test condition for which utime(2)
- *		returns -1 and sets errno to EACCES.
- *  Create a testfile under temporary directory and change the ownership of
- *  testfile to "bin".
- */
-int setup1(void)
-{
-	int fildes;		/* file handle for temp file */
+	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
 
-	/* Creat a temporary file under above directory */
-	if ((fildes = creat(TEMP_FILE, FILE_MODE)) == -1) {
-		tst_brkm(TBROK, cleanup, "creat(%s, %#o) Failed, errno=%d :%s",
-			 TEMP_FILE, FILE_MODE, errno, strerror(errno));
-	}
+	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
+}
 
-	/* Close the temporary file created */
-	if (close(fildes) < 0) {
-		tst_brkm(TBROK, cleanup, "close(%s) Failed, errno=%d : %s:",
-			 TEMP_FILE, errno, strerror(errno));
-	}
+static void utime_verify(const struct test_case_t *test)
+{
+	TEST(utime(test->pathname, NULL));
 
-	if ((ltpuser = getpwnam(LTPUSER2)) == NULL) {
-		tst_brkm(TBROK, cleanup, "%s not found in /etc/passwd",
-			 LTPUSER2);
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "utime succeeded unexpectedly");
+		return;
 	}
 
-	/* get uid/gid of user accordingly */
-	user_uid = ltpuser->pw_uid;
-	group_gid = ltpuser->pw_gid;
-
-	if (chown(TEMP_FILE, user_uid, group_gid) < 0) {
-		tst_brkm(TBROK, cleanup, "chown() of %s failed, error %d",
-			 TEMP_FILE, errno);
+	if (TEST_ERRNO == test->exp_errno) {
+		tst_resm(TPASS | TTERRNO, "utime failed as expected");
+	} else {
+		tst_resm(TFAIL | TTERRNO,
+			 "utime failed unexpectedly; expected: %d - %s",
+			 test->exp_errno, strerror(test->exp_errno));
 	}
-
-	return 0;
 }
 
-/*
- * void
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- *  Remove the test directory and testfile created in the setup.
- */
-void cleanup(void)
+static void cleanup(void)
 {
-	seteuid(0);
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
+	if (seteuid(0) != 0)
+		tst_resm(TWARN | TERRNO, "seteuid failed");
+
 	TEST_CLEANUP;
 
 	tst_rmdir();
-
 }
-- 
1.9.3




------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
