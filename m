From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  1 Dec 2016 11:23:59 +0100
Subject: [LTP] [PATCH 1/1] syscalls/mq_unlink: convert to use new test
	library API
Message-ID: <20161201102359.8164-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/mq_unlink/mq_unlink01.c | 354 +++++++---------------
 1 file changed, 112 insertions(+), 242 deletions(-)

diff --git a/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c b/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c
index 6306efc..ed0aea4 100644
--- a/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c
+++ b/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c
@@ -1,137 +1,42 @@
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
 #include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/uio.h>
-#include <getopt.h>
-#include <stdlib.h>
-#include <errno.h>
-#include <stdio.h>
-#include <unistd.h>
-#include <string.h>
+#include <pwd.h>
 #include <mqueue.h>
-#include <limits.h>
-
-#include "../utils/include_j_h.h"
-#include "../utils/common_j_h.c"
 
-#include "test.h"
+#include "tst_test.h"
 #include "linux_syscall_numbers.h"
 
-char *TCID = "mq_ulink01";
-int testno;
-int TST_TOTAL = 1;
-
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
-
-	tst_rmdir();
-}
-
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
+#define QUEUE_NAME	"/test_mqueue"
 
-/*
- * Macros
- */
-#define SYSCALL_NAME    "mq_ulink"
+static uid_t euid;
+static mqd_t fd;
+static char *user;
 
 enum test_type {
 	NORMAL,
 };
 
-/*
- * Data Structure
- */
 struct test_case {
 	char *user;
 	char *qname;
@@ -150,142 +55,107 @@ struct test_case {
 */
 
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
+		.ttype = NORMAL,
+		.qname = QUEUE_NAME,
+		.ret = 0,
+		.err = 0,
+	},
+	{
+		.ttype = NORMAL,
+		.user = "nobody",
+		.qname = QUEUE_NAME,
+		.ret = -1,
+		.err = EACCES,
+	},
+	{
+		.ttype = NORMAL,
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
+		.ttype = NORMAL,
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
-
-static int do_test(struct test_case *tc)
+void setup(void)
 {
-	int sys_ret;
-	int sys_errno;
-	int result = RESULT_OK;
-	int rc, fd1 = -1, fd2 = -1;
-	uid_t old_uid = -1;
-
-	/*
-	 * When test ended with SIGTERM etc, mq descriptor is left remains.
-	 * So we delete it first.
-	 */
-	TEST(mq_unlink(QUEUE_NAME));
-
-	/*
-	 * Open message queue
-	 */
-	rc = mq_open(QUEUE_NAME, O_CREAT | O_EXCL | O_RDWR, S_IRWXU, NULL);
-	if (rc == -1) {
-		tst_resm(TFAIL | TTERRNO, "mq_open failed");
-		result = 1;
-		goto EXIT;
-	}
-	fd1 = rc;
-
-	/*
-	 * Change effective user id
-	 */
-	if (tc->user != NULL) {
-		TEST(rc = setup_euid(tc->user, &old_uid));
-		if (TEST_RETURN < 0) {
-			result = 1;
-			goto EXIT;
-		}
-	}
-
-	/*
-	 * Execute system call
-	 */
-	errno = 0;
-	TEST(sys_ret = mq_unlink(tc->qname));
-	sys_errno = errno;
-	if (sys_ret >= 0)
-		fd2 = sys_ret;
+	euid = geteuid();
+}
 
-	/*
-	 * Check results
-	 */
-	result |= (sys_errno != tc->err);
-	PRINT_RESULT(sys_ret >= 0, tc->ret, tc->err, sys_ret, sys_errno);
+void cleanup(void)
+{
+	if (user != NULL && seteuid(euid) == -1)
+		tst_res(TWARN | TTERRNO, "seteuid back to %d failed", euid);
 
-EXIT:
-	if (tc->user != NULL && old_uid != -1)
-		cleanup_euid(old_uid);
+	if (fd >= 0)
+		close(fd);
 
-	if (fd1 >= 0)
-		close(fd1);
-	if (fd2 >= 0)
-		close(fd2);
 	mq_unlink(QUEUE_NAME);
-	return 0;
 }
 
-int main(int ac, char **av)
+static void do_test(unsigned int i)
 {
-	int i;
-	int lc;
+	struct test_case *tc = &tcase[i];
+	user = tc->user;
 
-	tst_parse_opts(ac, av, NULL, NULL);
+	tst_res(TINFO, "queue name '%s'", tc->qname);
 
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		tst_count = 0;
-		for (testno = 0; testno < TST_TOTAL; ++testno) {
+	/*
+	 * When test ended with SIGTERM etc, mq descriptor is left remains.
+	 * So we delete it first.
+	 */
+	mq_unlink(QUEUE_NAME);
 
-			int ret;
+	/* prepare */
+	fd = mq_open(QUEUE_NAME, O_CREAT | O_EXCL | O_RDWR, S_IRWXU, NULL);
+	if (fd == -1)
+		tst_brk(TBROK | TTERRNO, "mq_open failed");
 
-			ret = 0;
+	if (user != NULL) {
+		struct passwd *pw;
+		pw = getpwnam(user);
+		if (!pw)
+			tst_brk(TFAIL | TTERRNO, "getpwnam failed");
 
-			for (i = 0; ret == 0 &&
-			     i < (int)ARRAY_SIZE(tcase); i++) {
-				ret = do_test(&tcase[i]);
-			}
+		if (seteuid(pw->pw_uid))
+			tst_brk(TFAIL | TTERRNO, "seteuid failed");
+	}
 
-		}
+	/* test */
+	TEST(mq_unlink(tc->qname));
+	if (TEST_ERRNO != tc->err || TEST_RETURN != tc->ret) {
+		tst_res(TFAIL | TTERRNO, "mq_unlink returned %ld, expected %d,"
+			" expected errno: %s (%d)", TEST_RETURN,
+			tc->ret, tst_strerrno(tc->err), tc->err);
+	} else {
+		tst_res(TPASS | TTERRNO, "mq_unlink returned %ld", TEST_RETURN);
 	}
+
 	cleanup();
-	tst_exit();
 }
+
+static struct tst_test test = {
+	.tid = "mq_ulink01",
+	.tcnt = ARRAY_SIZE(tcase),
+	.test = do_test,
+	.needs_root = 1,
+	.cleanup = cleanup,
+	.setup = setup,
+};
-- 
2.10.2

