From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  5 Dec 2016 15:32:58 +0100
Subject: [LTP] [PATCH v5 1/1] syscalls/mq_unlink: convert to use new test
	library API
Message-ID: <20161205143258.8102-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
+	pw = SAFE_GETPWNAM("nobody");
I don't like hardwired constants, but nobody user name is used across whole
codebase. I'd be happier to have some constant in lib (although it's unlikely
one day we might want to allow user to choose their "nobody" user).

> We may also run the test for nobody in a child process so
> that we don't have to take care restoring the euid at the end of the
> function.
It's require to restore euid for other tests (to be running as root again). Or
have I overlooked something?

Changes v4->v5:
* Fix using ttype constants.
* Getting struct passwd with SAFE_GETPWNAM() in setup().
* Using only single non-root user => have it as int flag in struct test_case.
* Remove unused enum test_type.

Changes v3->v4:
* Cleanup variables (wrong in v3).
* Cleanup includes.
* Cleanup closing fd.

Changes v2->v3:
* Use tst_res() and goto instead of tst_brk() (can't use it that way as it
  exits) and remove cleanup() (now useless).

Changes v1->v2:
* Close fd only when needed + pri
---
 testcases/kernel/syscalls/mq_unlink/mq_unlink01.c | 356 ++++++----------------
 1 file changed, 100 insertions(+), 256 deletions(-)

diff --git a/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c b/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c
index 6306efc..9569739 100644
--- a/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c
+++ b/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c
@@ -1,291 +1,135 @@
-/******************************************************************************/
-/* Copyright (c) Crackerjack Project., 2007-2008 ,Hitachi, Ltd		*/
-/*	  Author(s): Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,	      */
-/*		       Yumiko Sugita <yumiko.sugita.yf@hitachi.com>, 	      */
-/*		       Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>	      */
-/*								  	      */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or	  */
-/* (at your option) any later version.					*/
-/*									    */
-/* This program is distributed in the hope that it will be useful,	    */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of	    */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See		  */
-/* the GNU General Public License for more details.			   */
-/*									    */
-/* You should have received a copy of the GNU General Public License	  */
-/* along with this program;  if not, write to the Free Software	       */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*									    */
-/******************************************************************************/
-/******************************************************************************/
-/*									    */
-/* File:	mq_ulink01.c						  */
-/*									    */
-/* Description: This tests the mq_ulink() syscall			     */
-/*									      */
-/* 									      */
-/*									      */
-/*									      */
-/*									      */
-/*									    */
-/* Usage:  <for command-line>						 */
-/* mq_ulink01 [-c n] [-e][-i n] [-I x] [-p x] [-t]			    */
-/*      where,  -c n : Run n copies concurrently.			     */
-/*	      -e   : Turn on errno logging.				 */
-/*	      -i n : Execute test n times.				  */
-/*	      -I x : Execute test for x seconds.			    */
-/*	      -P x : Pause for x seconds between iterations.		*/
-/*	      -t   : Turn on syscall timing.				*/
-/*									    */
-/* Total Tests: 1							     */
-/*									    */
-/* Test Name:   mq_ulink01					     */
-/* History:     Porting from Crackerjack to LTP is done by		    */
-/*	      Manas Kumar Nayak maknayak@in.ibm.com>			*/
-/******************************************************************************/
+/*
+ * Copyright (c) Crackerjack Project., 2007-2008 ,Hitachi, Ltd
+ *          Author(s): Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,
+ *		       Yumiko Sugita <yumiko.sugita.yf@hitachi.com>,
+ *		       Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>
+ * Copyright (c) 2016 Linux Test Project
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
 
-#include <sys/syscall.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/uio.h>
-#include <getopt.h>
-#include <stdlib.h>
 #include <errno.h>
-#include <stdio.h>
-#include <unistd.h>
-#include <string.h>
+#include <pwd.h>
 #include <mqueue.h>
-#include <limits.h>
-
-#include "../utils/include_j_h.h"
-#include "../utils/common_j_h.c"
-
-#include "test.h"
-#include "linux_syscall_numbers.h"
 
-char *TCID = "mq_ulink01";
-int testno;
-int TST_TOTAL = 1;
+#include "tst_test.h"
 
-/* Extern Global Functions */
-/******************************************************************************/
-/*									    */
-/* Function:    cleanup						       */
-/*									    */
-/* Description: Performs all one time clean up for this test on successful    */
-/*	      completion,  premature exit or  failure. Closes all temporary */
-/*	      files, removes all temporary directories exits the test with  */
-/*	      appropriate return code by calling tst_exit() function.       */
-/*									    */
-/* Input:       None.							 */
-/*									    */
-/* Output:      None.							 */
-/*									    */
-/* Return:      On failure - Exits calling tst_exit(). Non '0' return code.   */
-/*	      On success - Exits calling tst_exit(). With '0' return code.  */
-/*									    */
-/******************************************************************************/
-void cleanup(void)
-{
+#define QUEUE_NAME	"/test_mqueue"
 
-	tst_rmdir();
-}
+static uid_t euid;
+static struct passwd *pw;
 
-/* Local  Functions */
-/******************************************************************************/
-/*									    */
-/* Function:    setup							 */
-/*									    */
-/* Description: Performs all one time setup for this test. This function is   */
-/*	      typically used to capture signals, create temporary dirs      */
-/*	      and temporary files that may be used in the course of this    */
-/*	      test.							 */
-/*									    */
-/* Input:       None.							 */
-/*									    */
-/* Output:      None.							 */
-/*									    */
-/* Return:      On failure - Exits by calling cleanup().		      */
-/*	      On success - returns 0.				       */
-/*									    */
-/******************************************************************************/
-void setup(void)
-{
-	tst_require_root();
-	/* Capture signals if any */
-	/* Create temporary directories */
-	TEST_PAUSE;
-	tst_tmpdir();
-}
-
-/*
- * Macros
- */
-#define SYSCALL_NAME    "mq_ulink"
-
-enum test_type {
-	NORMAL,
-};
-
-/*
- * Data Structure
- */
 struct test_case {
-	char *user;
+	int as_nobody;
 	char *qname;
-	int ttype;
 	int ret;
 	int err;
 };
 
-/* Test cases
-*
-*   test status of errors on man page
-*
-*   EACCES	     v (permission is denied)
-*   ENAMETOOLONG       v (too long name length)
-*   ENOENT	     v (named message queue does not exist)
-*/
-
 static struct test_case tcase[] = {
-	{			// case00
-	 .ttype = NORMAL,
-	 .qname = QUEUE_NAME,
-	 .ret = 0,
-	 .err = 0,
-	 },
-	{			// case01
-	 .ttype = NORMAL,
-	 .user = "nobody",
-	 .qname = QUEUE_NAME,
-	 .ret = -1,
-	 .err = EACCES,
-	 },
-	{			// case02
-	 .ttype = NORMAL,
-	 //  0    1       2       3
-	 //  0123456789012345678901234567890123456789
-	 .qname = "/aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
-	 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
-	 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
-	 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
-	 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
-	 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" "aaaaaaaaaaaaaaa",
-	 .ret = -1,
-	 .err = ENOENT,
-	 },
-	{			// case03
-	 .ttype = NORMAL,
-	 //  0    1       2       3
-	 //  0123456789012345678901234567890123456789
-	 .qname = "/aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
-	 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
-	 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
-	 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
-	 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
-	 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" "aaaaaaaaaaaaaaaa",
-	 .ret = -1,
-	 .err = ENAMETOOLONG,
-	 },
+	{
+		.qname = QUEUE_NAME,
+		.ret = 0,
+		.err = 0,
+	},
+	{
+		.as_nobody = 1,
+		.qname = QUEUE_NAME,
+		.ret = -1,
+		.err = EACCES,
+	},
+	{
+		.qname = "/aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
+			"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
+			"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
+			"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
+			"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
+			"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
+			"aaaaaaaaaaaaaaa",
+		.ret = -1,
+		.err = ENOENT,
+	},
+	{
+		.qname = "/aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
+			"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
+			"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
+			"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
+			"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
+			"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
+			"aaaaaaaaaaaaaaaa",
+		.ret = -1,
+		.err = ENAMETOOLONG,
+	},
 };
 
-/*
- * do_test()
- *
- *   Input  : TestCase Data
- *   Return : RESULT_OK(0), RESULT_NG(1)
- *
- */
+void setup(void)
+{
+	euid = geteuid();
+	pw = SAFE_GETPWNAM("nobody");
+}
 
-static int do_test(struct test_case *tc)
+static void do_test(unsigned int i)
 {
-	int sys_ret;
-	int sys_errno;
-	int result = RESULT_OK;
-	int rc, fd1 = -1, fd2 = -1;
-	uid_t old_uid = -1;
+	struct test_case *tc = &tcase[i];
+	mqd_t fd;
+
+	tst_res(TINFO, "queue name %s", tc->qname);
 
 	/*
 	 * When test ended with SIGTERM etc, mq descriptor is left remains.
 	 * So we delete it first.
 	 */
-	TEST(mq_unlink(QUEUE_NAME));
+	mq_unlink(QUEUE_NAME);
 
-	/*
-	 * Open message queue
-	 */
-	rc = mq_open(QUEUE_NAME, O_CREAT | O_EXCL | O_RDWR, S_IRWXU, NULL);
-	if (rc == -1) {
-		tst_resm(TFAIL | TTERRNO, "mq_open failed");
-		result = 1;
+	/* prepare */
+	fd = mq_open(QUEUE_NAME, O_CREAT | O_EXCL | O_RDWR, S_IRWXU, NULL);
+	if (fd == -1) {
+		tst_res(TBROK | TERRNO, "mq_open failed");
 		goto EXIT;
 	}
-	fd1 = rc;
 
-	/*
-	 * Change effective user id
-	 */
-	if (tc->user != NULL) {
-		TEST(rc = setup_euid(tc->user, &old_uid));
-		if (TEST_RETURN < 0) {
-			result = 1;
-			goto EXIT;
-		}
+	if (tc->as_nobody && seteuid(pw->pw_uid)) {
+		tst_res(TBROK | TERRNO, "seteuid failed");
+		goto EXIT;
 	}
 
-	/*
-	 * Execute system call
-	 */
-	errno = 0;
-	TEST(sys_ret = mq_unlink(tc->qname));
-	sys_errno = errno;
-	if (sys_ret >= 0)
-		fd2 = sys_ret;
-
-	/*
-	 * Check results
-	 */
-	result |= (sys_errno != tc->err);
-	PRINT_RESULT(sys_ret >= 0, tc->ret, tc->err, sys_ret, sys_errno);
+	/* test */
+	TEST(mq_unlink(tc->qname));
+	if (TEST_ERRNO != tc->err || TEST_RETURN != tc->ret) {
+		tst_res(TFAIL | TTERRNO, "mq_unlink returned %ld, expected %d,"
+			" expected errno %s (%d)", TEST_RETURN,
+			tc->ret, tst_strerrno(tc->err), tc->err);
+	} else {
+		tst_res(TPASS | TTERRNO, "mq_unlink returned %ld", TEST_RETURN);
+	}
 
 EXIT:
-	if (tc->user != NULL && old_uid != -1)
-		cleanup_euid(old_uid);
+	/* cleanup */
+	if (tc->as_nobody && seteuid(euid) == -1)
+		tst_res(TWARN | TTERRNO, "seteuid back to %d failed", euid);
+
+	if (fd > 0 && close(fd))
+		tst_res(TWARN | TTERRNO, "close(fd) failed");
 
-	if (fd1 >= 0)
-		close(fd1);
-	if (fd2 >= 0)
-		close(fd2);
 	mq_unlink(QUEUE_NAME);
-	return 0;
 }
 
-int main(int ac, char **av)
-{
-	int i;
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		tst_count = 0;
-		for (testno = 0; testno < TST_TOTAL; ++testno) {
-
-			int ret;
-
-			ret = 0;
-
-			for (i = 0; ret == 0 &&
-			     i < (int)ARRAY_SIZE(tcase); i++) {
-				ret = do_test(&tcase[i]);
-			}
-
-		}
-	}
-	cleanup();
-	tst_exit();
-}
+static struct tst_test test = {
+	.tid = "mq_ulink01",
+	.tcnt = ARRAY_SIZE(tcase),
+	.test = do_test,
+	.needs_root = 1,
+	.setup = setup,
+};
-- 
2.10.2

