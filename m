Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1Wajty-0001Ob-Fm
	for ltp-list@lists.sourceforge.net; Thu, 17 Apr 2014 10:50:42 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Wajtv-0003wd-0q
	for ltp-list@lists.sourceforge.net; Thu, 17 Apr 2014 10:50:42 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s3HAoN2d014970
	for <ltp-list@lists.sourceforge.net>; Thu, 17 Apr 2014 18:50:23 +0800
From: "gux.fnst@cn.fujitsu.com" <gux.fnst@cn.fujitsu.com>
Date: Thu, 17 Apr 2014 10:50:23 +0000
Message-ID: <1397731818-26430-1-git-send-email-gux.fnst@cn.fujitsu.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/2] rmdir/rmdir02.c: cleanup
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
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Delete some useless comments.
Use some SAFE_* macros.
Move the test body from main() to rmdir_verify().

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/rmdir/rmdir02.c | 406 +++++++-----------------------
 1 file changed, 91 insertions(+), 315 deletions(-)

diff --git a/testcases/kernel/syscalls/rmdir/rmdir02.c b/testcases/kernel/syscalls/rmdir/rmdir02.c
index dfea028..9ae919a 100644
--- a/testcases/kernel/syscalls/rmdir/rmdir02.c
+++ b/testcases/kernel/syscalls/rmdir/rmdir02.c
@@ -1,381 +1,157 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
+ * 07/2001 Ported by Wayne Boyer
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
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
-
 /*
- * NAME
- *	rmdir02
- *
- * DESCRIPTION
- *	This test will verify that rmdir(2) fail in
- *      1. ENOTEMPTY
- *      2. ENAMETOOLONG
- *      3. ENOENT
- *      4. ENOTDIR
- *      5. EFAULT
- *      6. EFAULT
- *
- * ALGORITHM
- *	Setup:
- *		Setup signal handling.
- *		Pause for SIGUSR1 if option specified.
- *		Create temporary directory.
- *
- *	Test:
- *		Loop if the proper options are given.
- *              1. create a directory tstdir1, create a file under it.
- *                 call rmdir(tstdir1), verify the return value is not 0
- *                 and the errno is ENOTEMPTY
- *              2. create a directory with long path,
- *                 call rmdir(tstdir1), verify the return value is not 0
- *                 and the errno is ENAMETOOLONG
- *              3. pass a pathname containing non-exist directory component
- *                 to rmdir() and check the return value and errno (expect
- *                 ENOENT
- *              4. pass a pathname containing a file component
- *                 to rmdir() and check the return value and errno (expect
- *                 ENOTDIR
- *	        5. Attempt to pass an invalid pathname with an address
- *                 pointing outside the address space of the process,
- *                 as the argument to rmdir(), and expect to get EFAULT.
- *		6. Attempt to pass an invalid pathname with NULL
- *                 as the argument to rmdir(), and expect to get EFAULT.
- *
- *	Cleanup:
- *		Print errno log and/or timing stats if options given
- *		Delete the temporary directory created.
- *
- * USAGE
- *	rmdir02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
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
- *	None.
+ * Description:
+ *   1) create a directory tstdir1, create a file under it. call
+ *      rmdir(), verify the return value is -1 and the errno is
+ *      ENOTEMPTY.
+ *   2) create a directory with long path, call rmdir(), verify
+ *      the return value is -1 and the errno is ENAMETOOLONG.
+ *   3) pass a pathname containing non-exist directory component
+ *      to rmdir(), verify the return value is -1 and the errno
+ *      is ENOENT.
+ *   4) pass a pathname containing a file component to rmdir(),
+ *      verify the return value is -1 and the errno is ENOTDIR.
+ *   5) attempt to pass an invalid pathname with an address
+ *      pointing outside the address space of the process, as the
+ *      argument to rmdir(), verify the return value is -1 and
+ *      the errno is EFAULT.
+ *   6) attempt to pass an invalid pathname with NULL, as the
+ *      argument to rmdir(), verify the return value is -1 and
+ *      the errno is EFAULT.
  */
+
 #include <errno.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/mman.h>
 #include <fcntl.h>
 #include <unistd.h>
+
 #include "test.h"
 #include "usctest.h"
+#include "safe_macros.h"
 
-void setup();
-void cleanup();
-int create_longpath();
-void remove_longpath();
-void set_condition();
-void do_file_setup(char *);
-
-#define PERMS		0777
-
-char *TCID = "rmdir02";
-
-int exp_enos[] = { ENOTEMPTY, EBUSY, ENAMETOOLONG, ENOENT, ENOTDIR, EFAULT, 0 };
+#define DIR_MODE	(S_IRWXU | S_IRWXG | S_IRWXO)
+#define FILE_MODE	(S_IRWXU | S_IRWXG | S_IRWXO)
 
-char *bad_addr = 0;
+#define TESTDIR		"testdir"
+#define TESTDIR2	"nosuchdir/testdir2"
+#define TESTDIR3	"testfile2/testdir3"
+#define TESTFILE    "testdir/testfile"
+#define TESTFILE2   "testfile2"
 
-char tstfile[255];
-char tstdir1[255];
-char tstdir2[255];
-char tstdir3[255];
-char longname[255];
-char longpath[2 * PATH_MAX];
-char cwd[255];
+static char longpathname[PATH_MAX + 2];
 
-struct test_case_t {
+static struct test_case_t {
 	char *dir;
-	int error;
-	void (*set_cond) (int);
-} TC[] = {
-	/* The directory is not empty - ENOTEMPTY */
-	{
-	tstdir1, ENOTEMPTY, set_condition},
-	    /* The directory pathname is too long - ENAMETOOLONG */
-	{
-	longpath, ENAMETOOLONG, set_condition},
-	    /* A component of the pathname does not exists - ENOENT */
-	{
-	tstdir2, ENOENT, set_condition},
-	    /* The given argument is not a directory - ENOTDIR */
-	{
-	tstdir3, ENOTDIR, set_condition},
+	int exp_errno;
+} test_cases[] =  {
+	{ TESTDIR, ENOTEMPTY },
+	{ longpathname, ENAMETOOLONG },
+	{ TESTDIR2, ENOENT },
+	{ TESTDIR3, ENOTDIR },
 #if !defined(UCLINUX)
-	    /* The argument is illegal - EFAULT */
-	{
-	(char *)-1, EFAULT, NULL},
+	{ (char *)-1, EFAULT },
 #endif
-	    /* The argument is illegal - EFAULT */
-	{
-	NULL, EFAULT, NULL}
+	{ NULL, EFAULT },
 };
 
-int TST_TOTAL = (sizeof(TC) / sizeof(*TC));
+static void setup(void);
+static void rmdir_verify(struct test_case_t *tc);
+static void cleanup(void);
+
+char *TCID = "rmdir02";
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+static int exp_enos[] = { ENOTEMPTY, ENAMETOOLONG, ENOENT, ENOTDIR,
+				EFAULT, 0 };
 
 int main(int ac, char **av)
 {
-	int lc;
+	int i, lc;
 	char *msg;
-	int i;
 
-	/*
-	 * parse standard options
-	 */
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-	}
 
-	/*
-	 * perform global setup for test
-	 */
 	setup();
 
-	/* set the expected errnos... */
 	TEST_EXP_ENOS(exp_enos);
 
-	/*
-	 * check looping state if -i option given
-	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
 		tst_count = 0;
 
-		/* save current working directory */
-		getcwd(cwd, 255);
-
-		/* loop through the test cases */
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			/* make sure we start at the same place */
-			chdir(cwd);
-
-			if (TC[i].set_cond != NULL) {
-				TC[i].set_cond(i + 1);
-			}
-
-			TEST(rmdir(TC[i].dir));
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
-				continue;
-			}
-
-			TEST_ERROR_LOG(TEST_ERRNO);
-
-			if (TEST_ERRNO == TC[i].error) {
-				tst_resm(TPASS, "expected failure - "
-					 "errno = %d : %s", TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			} else {
-				tst_resm(TFAIL, "unexpected error - %d : %s - "
-					 "expected %d", TEST_ERRNO,
-					 strerror(TEST_ERRNO), TC[i].error);
-			}
-		}
-		/* clean up things in case we are looping */
-		(void)unlink(tstfile);
-
-		(void)rmdir(tstdir1);
-		(void)rmdir(tstdir2);
-		(void)rmdir(tstdir3);
-
+		for (i = 0; i < TST_TOTAL; i++)
+			rmdir_verify(&test_cases[i]);
 	}
 
-	/*
-	 * cleanup and exit
-	 */
 	cleanup();
 	tst_exit();
-
 }
 
-/*
- * set_condition - set up starting conditions for the individual tests
- */
-void set_condition(int num)
+static void setup(void)
 {
-	int fd;
-	switch (num) {
-	case 1:
-		/* set up for first test */
-		sprintf(tstdir1, "./tstdir1_%d", getpid());
-		sprintf(tstfile, "%s/tstfile_%d", tstdir1, getpid());
-
-		/* create a directory */
-		if (mkdir(tstdir1, PERMS) == -1) {
-			tst_brkm(TBROK, cleanup, "mkdir(%s, %#o) Failed",
-				 tstdir1, PERMS);
-		}
-
-		/* create a file under tstdir1 */
-		do_file_setup(tstfile);
-
-		break;
-	case 2:
-		create_longpath();
-		break;
-	case 3:
-		/* Initialize the test directory name */
-		sprintf(tstdir2, "NOSUCHADIR/tstdir2.%d", getpid());
-
-		break;
-	case 4:
-		/* Initialize the test directory name and file name */
-		sprintf(tstdir3, "%s/tstdir3", tstfile);
-
-		/* create a file */
-		if ((fd = creat(tstfile, PERMS)) == -1) {
-			tst_brkm(TBROK, cleanup, "creat() failed");
-		}
-		close(fd);
-		break;
-	default:
-		tst_brkm(TBROK, cleanup, "illegal setup case - %d", num);
-		break;
-	}
-
-}
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
-int create_longpath(void)
-{
-	sprintf(longname,
-		"abcdefghivwxyzabcdefgmopqrsqrsrsthmopqrsqrsrstijklmnopjklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdabcdefghijklmopqrsqrsrstmnopqrqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyz_%d/",
-		getpid());
+	TEST_PAUSE;
 
-	chdir(cwd);
+	tst_tmpdir();
 
-	while (strlen(longpath) < PATH_MAX) {
-		/*
-		 * if the longpath is not long enough
-		 * create a sub directory under it
-		 */
-		if (mkdir(longname, PERMS) == -1) {
-			tst_resm(TINFO, "mkdir failed in creae_longpath()");
-			break;
-		}
-		/*
-		 * save the path
-		 */
-		strcat(longpath, longname);
+	SAFE_MKDIR(cleanup, TESTDIR, DIR_MODE);
+	SAFE_TOUCH(cleanup, TESTFILE, FILE_MODE, NULL);
 
-		/*
-		 * cd to the sub directory
-		 */
-		if (chdir(longname) == -1) {
-			tst_resm(TINFO, "chdir failed in create_longpath()");
-			break;
-		}
-	}
+	memset(longpathname, 'a', PATH_MAX + 2);
 
-	/* resume original working directory */
-	chdir(cwd);
+	SAFE_TOUCH(cleanup, TESTFILE2, FILE_MODE, NULL);
 
-	return (strlen(longpath) >= PATH_MAX) ? 0 : -1;
+#if !defined(UCLINUX)
+	test_cases[4].dir = SAFE_MMAP(cleanup, 0, 1, PROT_NONE,
+		MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
+#endif
 }
 
-void remove_longpath(void)
+static void rmdir_verify(struct test_case_t *tc)
 {
-	int len, i, j;
-	int path_len;
-
-	chdir(cwd);
+	TEST(rmdir(tc->dir));
 
-	len = strlen(longname);
-	path_len = strlen(longpath);
-
-	/*
-	 * Since we can't rm directory with long pathname directly,
-	 * we remove it's sub directories one by one.
-	 */
-	for (i = (path_len / len) - 1; i >= 0; i--) {
-		for (j = 1; j <= i; j++) {
-			if (chdir(longname) == -1) {
-				tst_resm(TFAIL,
-					 "failed in chdir %s, errno: %d ",
-					 longname, errno);
-				break;
-			}
-		}
-		if (rmdir(longname) == -1) {
-			tst_resm(TFAIL,
-				 "failed in clean %s, errno: %d",
-				 longname, errno);
-			break;
-		}
-		chdir(cwd);
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "rmdir() returned %ld, "
+			"expected -1, errno:%d", TEST_RETURN,
+			tc->exp_errno);
+		return;
 	}
-	/* resume original working directory */
-	chdir(cwd);
-}
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
-{
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	/* Create a temporary directory and make it current. */
-	tst_tmpdir();
+	TEST_ERROR_LOG(TEST_ERRNO);
 
-#if !defined(UCLINUX)
-	bad_addr = mmap(0, 1, PROT_NONE,
-			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
-	if (bad_addr == MAP_FAILED) {
-		tst_brkm(TBROK, cleanup, "mmap failed");
+	if (TEST_ERRNO == tc->exp_errno) {
+		tst_resm(TPASS | TTERRNO, "rmdir() failed as expected");
+	} else {
+		tst_resm(TFAIL | TTERRNO,
+			"rmdir() failed unexpectedly; expected: %d - %s",
+			tc->exp_errno, strerror(tc->exp_errno));
 	}
-	TC[4].dir = bad_addr;
-#endif
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *              completion or premature exit.
- */
-void cleanup(void)
+static void cleanup(void)
 {
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
 	TEST_CLEANUP;
 
-	remove_longpath();
-
-	/*
-	 * Remove the temporary directory.
-	 */
 	tst_rmdir();
-
-	/*
-	 * Exit with return code appropriate for results.
-	 */
-
 }
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
