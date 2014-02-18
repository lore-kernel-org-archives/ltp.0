Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WFmRB-0007j7-C3
	for ltp-list@lists.sourceforge.net; Tue, 18 Feb 2014 15:18:21 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WFmR8-0007PU-Ue
	for ltp-list@lists.sourceforge.net; Tue, 18 Feb 2014 15:18:21 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s1IFI8vZ008441
	for <ltp-list@lists.sourceforge.net>; Tue, 18 Feb 2014 23:18:09 +0800
Message-ID: <1392736686.2654.13.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Tue, 18 Feb 2014 23:18:06 +0800
In-Reply-To: <1390210861.6682.14.camel@G08JYZSD130126>
References: <1390210456.6682.12.camel@G08JYZSD130126>
	<1390210861.6682.14.camel@G08JYZSD130126>
Mime-Version: 1.0
Subject: [LTP] [PATCH v2 1/2] mkdir/mkdir03.c: cleanup
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

Fix FSF address
Make use of SAFE_MACROS()
Some cleanup

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/mkdir/mkdir03.c | 283 +++++++-----------------------
 1 file changed, 61 insertions(+), 222 deletions(-)

diff --git a/testcases/kernel/syscalls/mkdir/mkdir03.c b/testcases/kernel/syscalls/mkdir/mkdir03.c
index 9243299..f0f444f 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir03.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir03.c
@@ -1,6 +1,6 @@
 /*
- *
  *   Copyright (c) International Business Machines  Corp., 2001
+ *	07/2001 Ported by Wayne Boyer
  *
  *   This program is free software;  you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -13,54 +13,13 @@
  *   the GNU General Public License for more details.
  *
  *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1303 USA
+ *   along with this program;  if not, write to the Free Software Foundation,
+ *   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
-
 /*
- * NAME
- *	mkdir03
- *
  * DESCRIPTION
  *	check mkdir() with various error conditions that should produce
  *	EFAULT, ENAMETOOLONG, EEXIST, ENOENT and ENOTDIR
- *
- * ALGORITHM
- *	Setup:
- *		Setup signal handling.
- *		Pause for SIGUSR1 if option specified.
- *		Create temporary directory.
- *
- *	Test:
- *		Loop if the proper options are given.
- *              Loop through the test cases
- *                 call the test case specific setup routine if necessary
- *                 call mkdir() using the TEST macro
- *		   if the call succeeds
- *		      print a FAIL message and continue
- *		   Log the errno value
- *		   if the errno is expected
- *			issue a PASS message
- *		   else
- *			issue a FAIL message
- *	Cleanup:
- *		Print errno log and/or timing stats if options given
- *		Delete the temporary directory created.
- * USAGE
- *	mkdir03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
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
- *
  */
 
 #include <errno.h>
@@ -70,234 +29,114 @@
 #include <fcntl.h>
 #include "test.h"
 #include "usctest.h"
+#include "safe_macros.h"
 
-void setup();
-void cleanup();
-void setup1();
-void setup2();
-void setup3();
-void setup4();
-void setup5();
+static void setup(void);
+struct test_case_t;
+static void mkdir_verify(struct test_case_t *tc);
+static void bad_addr_setup(struct test_case_t *tc);
+static void cleanup(void);
 
-#define PERMS		0777
-#define PERMS2		0277
-
-#define NAMELEN		50
+#define TST_EEXIST	"tst_eexist"
+#define TST_ENOENT	"tst_enoent/tst"
+#define TST_ENOTDIR	"tst_enotdir/tst"
+#define MODE		0777
 
 char *TCID = "mkdir03";
-int fileHandle, fileHandle2 = 0;
-
-char tstdir3[NAMELEN];
-char tstdir4[NAMELEN];
-char tstdir5[NAMELEN];
 
-char long_dir[] =
-    "abcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyz";
+static char long_dir[PATH_MAX+2];
+static int exp_enos[] = { EFAULT, ENAMETOOLONG, EEXIST, ENOENT, ENOTDIR, 0 };
 
-int exp_enos[] = { EFAULT, ENAMETOOLONG, EEXIST, ENOENT, ENOTDIR, 0 };
-
-char *bad_addr = 0;
-
-struct test_case_t {
-	char *dir;
-	int perms;
-	int error;
-	void (*setupfunc) ();
+static struct test_case_t {
+	char *pathname;
+	int mode;
+	int exp_errno;
+	void (*setupfunc) (struct test_case_t *tc);
 } TC[] = {
 #if !defined(UCLINUX)
-	/* try to create a directory with an illegal name/address */
-	{
-	(void *)-1, PERMS, EFAULT, NULL},
+	{NULL, MODE, EFAULT, bad_addr_setup},
 #endif
-	    /* try to create a directory using a name that is too long */
-	{
-	long_dir, PERMS2, ENAMETOOLONG, NULL},
-	    /* try to create a directory with the same name as an existing file */
-	{
-	tstdir3, PERMS, EEXIST, setup3},
-	    /* try to create a directory under a directory that doesn't exist */
-	{
-	tstdir4, PERMS, ENOENT, setup4},
-	    /*
-	     * try to create a directory under a path with a non-directory
-	     * component
-	     */
-	{
-	tstdir5, PERMS, ENOTDIR, setup5}
+	{long_dir, MODE, ENAMETOOLONG, NULL},
+	{TST_EEXIST, MODE, EEXIST, NULL},
+	{TST_ENOENT, MODE, ENOENT, NULL},
+	{TST_ENOTDIR, MODE, ENOTDIR, NULL},
 };
 
-int TST_TOTAL = sizeof(TC) / sizeof(TC[0]);
+int TST_TOTAL = ARRAY_SIZE(TC);
 
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
-	TEST_EXP_ENOS(exp_enos);
-
-	/*
-	 * check looping state if -i option given
-	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
 		tst_count = 0;
-
-		/* loop through the test cases */
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			/* perform test specific setup if necessary */
-			if (TC[i].setupfunc != NULL) {
-				(*TC[i].setupfunc) ();
-			}
-
-			TEST(mkdir(TC[i].dir, TC[i].perms));
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
+		for (i = 0; i < TST_TOTAL; i++)
+			mkdir_verify(&TC[i]);
 	}
 
-	/*
-	 * cleanup and exit
-	 */
 	cleanup();
-
 	tst_exit();
 }
 
-/*
- * setup3() - performs all ONE TIME setup for this test case 3.
- */
-void setup3()
+static void setup(void)
 {
-	char tstfile3[NAMELEN];
-
-	/* Initialize the test directory name and file name */
-	sprintf(tstfile3, "tst.%d", getpid());
-	sprintf(tstdir3, "%s", tstfile3);
-
-	/* create a file */
-	if ((fileHandle = creat(tstfile3, PERMS)) == -1) {
-		tst_brkm(TBROK, cleanup, "file creation failed is setup3");
-	}
-}
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
-/*
- * setup4() - performs all ONE TIME setup for this test case 4.
- */
-void setup4()
-{
-	char tstdir[NAMELEN];
-	struct stat statbuf;
+	TEST_EXP_ENOS(exp_enos);
 
-	/* Initialize the test directory name */
-	sprintf(tstdir, "tstdir4.%d", getpid());
-	sprintf(tstdir4, "%s/tst", tstdir);
-/*
-	sprintf(tstdir4, "%s/tst", tstdir4);
+	TEST_PAUSE;
 
-  This fails with EACCES           ^^^^^^^
-  add this as testcase?
+	tst_tmpdir();
 
-*/
+	memset(long_dir, 'a', PATH_MAX+1);
 
-	/* make sure tstdir4 does not exist */
-	if (stat(tstdir4, &statbuf) != -1) {
-		tst_brkm(TBROK, cleanup, "directory exists - test #4");
-	}
+	SAFE_TOUCH(cleanup, TST_EEXIST, MODE, NULL);
 
+	SAFE_TOUCH(cleanup, "tst_enotdir", MODE, NULL);
 }
 
-/*
- * setup5() - performs all ONE TIME setup for this test case 5.
- */
-void setup5()
+#if !defined(UCLINUX)
+static void bad_addr_setup(struct test_case_t *tc)
 {
-	char tstfile5[NAMELEN];
-
-	/* Initialize the test directories name and file name */
-	sprintf(tstfile5, "tstfile5.%d", getpid());
-	sprintf(tstdir5, "%s/tst", tstfile5);
-
-	/* create a file */
-	if ((fileHandle2 = creat(tstfile5, PERMS)) == -1) {
-		tst_brkm(TBROK, cleanup, "creat a file failed");
-	}
+	tc->pathname = SAFE_MMAP(cleanup, 0, 1, PROT_NONE,
+				 MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
 }
+#endif
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup()
+static void mkdir_verify(struct test_case_t *tc)
 {
+	if (tc->setupfunc != NULL)
+		tc->setupfunc(tc);
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	TEST(mkdir(tc->pathname, tc->mode));
 
-	TEST_PAUSE;
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "mkdir() returned %ld, expected -1, errno=%d",
+			 TEST_RETURN, tc->exp_errno);
+		return;
+	}
 
-	/* Create a temporary directory and make it current. */
-	tst_tmpdir();
+	TEST_ERROR_LOG(TEST_ERRNO);
 
-#if !defined(UCLINUX)
-	bad_addr = mmap(0, 1, PROT_NONE,
-			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
-	if (bad_addr == MAP_FAILED) {
-		tst_brkm(TBROK, cleanup, "mmap failed");
+	if (TEST_ERRNO == tc->exp_errno) {
+		tst_resm(TPASS | TTERRNO, "mkdir() failed as expected");
+	} else {
+		tst_resm(TFAIL | TTERRNO,
+			 "mkdir() failed unexpectedly; expected: %d - %s",
+			 tc->exp_errno, strerror(tc->exp_errno));
 	}
-	TC[0].dir = bad_addr;
-#endif
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *              completion or premature exit.
- */
-void cleanup()
+static void cleanup(void)
 {
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
-	close(fileHandle);
-	close(fileHandle2);
-
 	TEST_CLEANUP;
 
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
