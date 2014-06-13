Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1WvHdN-00016k-T1
	for ltp-list@lists.sourceforge.net; Fri, 13 Jun 2014 02:54:29 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WvHdL-0007g6-5p
	for ltp-list@lists.sourceforge.net; Fri, 13 Jun 2014 02:54:29 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s5D2sKCc022974
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Jun 2014 10:54:20 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Fri, 13 Jun 2014 10:53:18 +0800
Message-ID: <1402627999-11535-2-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1402627999-11535-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1402627999-11535-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 2/3] utimes/utimes01.c: cleanup
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

Delete some useless comments.
Use some SAFE_* macros.
Move the test body from main() to utimes_verify().

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/utimes/utimes01.c | 440 ++++++++--------------------
 1 file changed, 124 insertions(+), 316 deletions(-)

diff --git a/testcases/kernel/syscalls/utimes/utimes01.c b/testcases/kernel/syscalls/utimes/utimes01.c
index fec55b8..25d6bfa 100644
--- a/testcases/kernel/syscalls/utimes/utimes01.c
+++ b/testcases/kernel/syscalls/utimes/utimes01.c
@@ -1,48 +1,34 @@
-/******************************************************************************/
-/* Copyright (c) Crackerjack Project., 2007 ,Hitachi, Ltd		     */
-/*	  Author(s): Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,	      */
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
-/* File:	utimes01.c						    */
-/*									    */
-/* Description: This tests the utimes() syscall			       */
-/*									      */
-/* 									      */
-/*									      */
-/*									      */
-/*									      */
-/*									    */
-/* Usage:  <for command-line>						 */
-/* utimes01 [-c n] [-e][-i n] [-I x] [-p x] [-t]			      */
-/*      where,  -c n : Run n copies concurrently.			     */
-/*	      -e   : Turn on errno logging.				 */
-/*	      -i n : Execute test n times.				  */
-/*	      -I x : Execute test for x seconds.			    */
-/*	      -P x : Pause for x seconds between iterations.		*/
-/*	      -t   : Turn on syscall timing.				*/
-/*									    */
-/* Total Tests: 1							     */
-/*									    */
-/* Test Name:   utimes01						      */
-/* History:     Porting from Crackerjack to LTP is done by		    */
-/*	      Manas Kumar Nayak maknayak@in.ibm.com>			*/
-/******************************************************************************/
+/*
+ * Copyright (c) Crackerjack Project., 2007 ,Hitachi, Ltd
+ * Author(s): Takahiro Yasui <takahiro.yasui.mp@hitachi.com>
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software Foundation,
+ * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+/*
+ * Description:
+ *   Verify that,
+ *   1) utimes() returns -1 and sets errno to EACCES if times
+ *      is NULL, the caller's effective user ID does not match
+ *      the owner of the file, the caller does not have write
+ *      access to the file, and the caller is not privileged.
+ *   2) utimes() returns -1 and sets errno to ENOENT if filename
+ *      does not exist.
+ *   3) utimes() returns -1 and sets errno to EFAULT if filename
+ *      is NULL.
+ */
+
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/time.h>
@@ -53,309 +39,131 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <stdio.h>
-
-#include "../utils/include_j_h.h"
-#include "../utils/common_j_h.c"
+#include <pwd.h>
 
 #include "test.h"
 #include "usctest.h"
+#include "safe_macros.h"
 #include "linux_syscall_numbers.h"
 
+#define TESTFILE1 "testfile1"
+#define TESTFILE2 "testfile2"
+#define FILE_MODE (S_IRWXU | S_IRGRP | S_IXGRP | \
+					S_IROTH | S_IXOTH)
+
+#define LTPUSER1 "nobody"
+#define LTPUSER2 "bin"
+
+static struct timeval a_tv[2] = { {0, 0}, {1000, 0} };
+static struct timeval m_tv[2] = { {1000, 0}, {0, 0} };
+static struct timeval tv[2] = { {1000, 0}, {2000, 0} };
+
+static struct test_case_t {
+	char *pathname;
+	struct timeval *times;
+	int exp_errno;
+} test_cases[] = {
+	{ TESTFILE1, a_tv, 0 },
+	{ TESTFILE1, m_tv, 0 },
+	{ TESTFILE2, NULL, EACCES },
+	{ "notexistfile", tv, ENOENT },
+	{ NULL, tv, EFAULT },
+};
+
+static void setup(void);
+static void cleanup(void);
+static void utimes_verify(const struct test_case_t *);
+
 char *TCID = "utimes01";
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
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+static int exp_enos[] = { EACCES, ENOENT, EFAULT, 0 };
+
+int main(int ac, char **av)
 {
+	int i, lc;
+	const char *msg;
 
-	TEST_CLEANUP;
-	tst_rmdir();
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
+	setup();
+
+	TEST_EXP_ENOS(exp_enos);
+
+	for (lc = 0; TEST_LOOPING(lc); ++lc) {
+		tst_count = 0;
+
+		for (i = 0; i < TST_TOTAL; i++)
+			utimes_verify(&test_cases[i]);
+	}
+
+	cleanup();
+	tst_exit();
 }
 
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
 void setup(void)
 {
+	struct passwd *ltpuser;
+
 	tst_require_root(NULL);
 
-	/* Capture signals if any */
-	/* Create temporary directories */
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
 	TEST_PAUSE;
+
 	tst_tmpdir();
-}
 
-/*
- * Macros
- */
-#define SYSCALL_NAME    "utimes"
+	SAFE_TOUCH(cleanup, TESTFILE1, FILE_MODE, NULL);
+	ltpuser = SAFE_GETPWNAM(cleanup, LTPUSER1);
+	SAFE_CHOWN(cleanup, TESTFILE1, ltpuser->pw_uid,
+		ltpuser->pw_gid);
 
-enum test_type {
-	NORMAL,
-	FILE_NOT_EXIST,
-	NO_FNAME,
-};
+	SAFE_TOUCH(cleanup, TESTFILE2, FILE_MODE, NULL);
+	ltpuser = SAFE_GETPWNAM(cleanup, LTPUSER2);
+	SAFE_CHOWN(cleanup, TESTFILE2, ltpuser->pw_uid,
+		ltpuser->pw_gid);
 
-/*
- * Data Structure
- */
-struct test_case {
-	int ttype;
-	long a_sec;
-	long m_sec;
-	char *user;
-	int ret;
-	int err;
+	ltpuser = SAFE_GETPWNAM(cleanup, LTPUSER1);
+	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
+}
 
-};
+static void utimes_verify(const struct test_case_t *tc)
+{
+	struct stat st;
+	struct timeval tmp_tv[2];
 
-/* Test cases
- *
- *   test status of errors on man page
- *
- *   EACCES	     v (permission denied)
- *   ENOENT	     v (file does not exist)
- *
- *   test status of errors on man page
- *
- *   EFAULT	     v (points to not process address space)
- */
+	if (tc->exp_errno == 0) {
+		SAFE_STAT(cleanup, tc->pathname, &st);
 
-static struct test_case tcase[] = {
-	{			// case00
-	 .ttype = NORMAL,
-	 .a_sec = 0,
-	 .m_sec = 1000,
-	 .ret = 0,
-	 .err = 0,
-	 },
-	{			// case01
-	 .ttype = NORMAL,
-	 .a_sec = 1000,
-	 .m_sec = 0,
-	 .ret = 0,
-	 .err = 0,
-	 },
-	{			// case02
-	 .ttype = NORMAL,
-	 .user = "nobody",
-	 .ret = -1,
-	 .err = EACCES,		// RHEL4U1 + 2.6.18 returns EPERM
-	 },
-	{			// case03
-	 .ttype = FILE_NOT_EXIST,
-	 .a_sec = 1000,
-	 .m_sec = 2000,
-	 .ret = -1,
-	 .err = ENOENT,
-	 },
-
-	{			// case04
-	 .ttype = NO_FNAME,
-	 .a_sec = 1000,
-	 .m_sec = 2000,
-	 .ret = -1,
-	 .err = EFAULT,
-	 },
-};
+		tmp_tv[0].tv_sec = st.st_atime;
+		tmp_tv[0].tv_usec = 0;
+		tmp_tv[1].tv_sec = st.st_mtime;
+		tmp_tv[1].tv_usec = 0;
+	}
 
-/*
- * do_test()
- *
- *   Input  : TestCase Data
- *   Return : RESULT_OK(0), RESULT_NG(1)
- *
- */
+	TEST(utimes(tc->pathname, tc->times));
 
-static int do_test(struct test_case *tc)
-{
-	int sys_ret;
-	int sys_errno;
-	int result = RESULT_OK;
-	struct timeval tv[2];
-	char fpath[PATH_MAX], c = '\0';
-	int rc, len, cmp_ok = 1;
-	struct stat st;
-	uid_t old_uid;
-
-	/* XXX (garrcoop): memory leak with tst_get_tmpdir. */
-	TEST(rc = setup_file(tst_get_tmpdir(), "test.file", fpath));
-	if (rc < 0)
-		return 1;
-	/* The test just needs the file, so no need to keep it open. */
-	close(rc);
-
-	/*
-	 * Change effective user id
-	 */
-	if (tc->user != NULL) {
-		TEST(rc = setup_euid(tc->user, &old_uid));
-		if (rc < 0)
-			goto EXIT2;
-	}
+	TEST_ERROR_LOG(TEST_ERRNO);
 
-	/*
-	 * Execute system call
-	 */
-	memset(tv, 0, 2 * sizeof(struct timeval));
-	tv[0].tv_sec = tc->a_sec;
-	tv[1].tv_sec = tc->m_sec;
-	TEST(len = strlen(fpath));
-	if (tc->ttype == FILE_NOT_EXIST) {
-		c = fpath[len - 1];
-		fpath[len - 1] = '\0';
-	}
-	errno = 0;
-	if (tc->ttype == NO_FNAME) {
-		/**
-		 * Note (garrcoop):
-		 *
-		 * If you do NULL directly, then gcc [4.3] will complain when
-		 * one specifies -Wnonnull in CPPFLAGS. This is a negative
-		 * test, but let's not allow the compiler to complain about
-		 * something trivial like this.
-		 **/
-		const char *dummy = NULL;
-		TEST(sys_ret = utimes(dummy, tv));
+	if (TEST_ERRNO == tc->exp_errno) {
+		tst_resm(TPASS | TTERRNO, "utimes() failed as expected");
 	} else {
-		if (tc->user == NULL)
-			TEST(sys_ret = utimes(fpath, tv));
-		else
-			TEST(sys_ret = utimes(fpath, NULL));
+		tst_resm(TFAIL | TTERRNO,
+			"utimes() failed unexpectedly; expected: %d - %s",
+			tc->exp_errno, strerror(tc->exp_errno));
 	}
-	tv[0].tv_sec = tc->a_sec;
-	tv[1].tv_sec = tc->m_sec;
-	TEST(len = strlen(fpath));
-	if (tc->ttype == FILE_NOT_EXIST) {
-		c = fpath[len - 1];
-		fpath[len - 1] = '\0';
-	}
-	errno = 0;
-	if (tc->ttype == NO_FNAME) {
-		/**
-                 * Note (garrcoop):
-                 *
-                 * If you do NULL directly, then gcc [4.3] will complain when
-                 * one specifies -Wnonnull in CPPFLAGS. This is a negative
-                 * test, but let's not allow the compiler to complain about
-                 * something trivial like this.
-                 **/
-		const char *dummy = NULL;
-		TEST(sys_ret = utimes(dummy, tv));
-	} else {
-		if (tc->user == NULL)
-			TEST(sys_ret = utimes(fpath, tv));
-		else
-			TEST(sys_ret = utimes(fpath, NULL));
-	}
-	sys_errno = errno;
-	if (tc->ttype == FILE_NOT_EXIST)
-		fpath[len - 1] = c;
-	if (sys_ret < 0)
-		goto TEST_END;
-
-	/*
-	 * Check test file's time stamp
-	 */
-	rc = stat(fpath, &st);
-	if (rc < 0) {
-		EPRINTF("stat failed.\n");
-		result = 1;
-		goto EXIT1;
-	}
-	tst_resm(TINFO, "E:%ld,%ld <=> R:%ld,%ld", tv[0].tv_sec, tv[1].tv_sec,
-		 st.st_atime, st.st_mtime);
-	cmp_ok = st.st_atime == tv[0].tv_sec && st.st_mtime == tv[1].tv_sec;
-
-	/*
-	 * Check results
-	 */
-TEST_END:
-	result |= (sys_errno != tc->err) || !cmp_ok;
-	PRINT_RESULT_CMP(sys_ret >= 0, tc->ret, tc->err, sys_ret, sys_errno,
-			 cmp_ok);
-
-	/*
-	 * Restore effective user id
-	 */
-EXIT1:
-	if (tc->user != NULL) {
-		TEST(rc = cleanup_euid(old_uid));
-		if (rc < 0)
-			return 1;
-	}
-EXIT2:
-	TEST(cleanup_file(fpath));
 
-	return result;
+	if (TEST_ERRNO == 0 && utimes(tc->pathname, tmp_tv) == -1)
+			tst_brkm(TBROK | TERRNO, cleanup, "utimes() failed.");
 }
 
-/*
- * main()
- */
-
-int main(int ac, char **av)
+void cleanup(void)
 {
-	int result = RESULT_OK;
-	int i;
-	int lc;
-	const char *msg;
+	if (seteuid(0) == -1)
+		tst_resm(TWARN | TERRNO, "seteuid(0) failed");
 
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
-		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-
-	setup();
+	TEST_CLEANUP;
 
-	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		tst_count = 0;
-		for (testno = 0; testno < TST_TOTAL; ++testno) {
-
-			for (i = 0; i < (int)(sizeof(tcase) / sizeof(tcase[0]));
-			     i++) {
-				int ret;
-				tst_resm(TINFO, "(case%02d) START", i);
-				ret = do_test(&tcase[i]);
-				tst_resm(TINFO, "(case%02d) END => %s",
-					 i, (ret == 0) ? "OK" : "NG");
-				result |= ret;
-			}
-
-		}
-	}
-	cleanup();
-	tst_exit();
+	tst_rmdir();
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
