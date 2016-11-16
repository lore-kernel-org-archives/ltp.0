From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 16 Nov 2016 17:18:33 +0100
Subject: [LTP] [PATCH 2/2] testcases/clock_nanosleep01: convert to use new
	test library API
In-Reply-To: <20161116161833.16910-1-pvorel@suse.cz>
References: <20161116161833.16910-1-pvorel@suse.cz>
Message-ID: <20161116161833.16910-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Removed test type NULL_POINTER.
Not sure if I've done signal hadling correctly and whether it needs
temporary directory.
---
 .../syscalls/clock_nanosleep/clock_nanosleep01.c   | 397 ++++++---------------
 1 file changed, 104 insertions(+), 293 deletions(-)

diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
index 08c1fbd..82e7381 100644
--- a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
+++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
@@ -1,158 +1,54 @@
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
-/* File:	clock_nanosleep01.c					   */
-/*									    */
-/* Description: This tests the clock_nanosleep() syscall		      */
-/*									      */
-/* 									      */
-/*									      */
-/*									      */
-/*									      */
-/*									    */
-/* Usage:  <for command-line>						 */
-/* clock_nanosleep01 [-c n] [-e][-i n] [-I x] [-p x] [-t]		     */
-/*      where,  -c n : Run n copies concurrently.			     */
-/*	      -e   : Turn on errno logging.				 */
-/*	      -i n : Execute test n times.				  */
-/*	      -I x : Execute test for x seconds.			    */
-/*	      -P x : Pause for x seconds between iterations.		*/
-/*	      -t   : Turn on syscall timing.				*/
-/*									    */
-/* Total Tests: 1							     */
-/*									    */
-/* Test Name:   clock_nanosleep01					     */
-/* History:     Porting from Crackerjack to LTP is done by		    */
-/*	      Manas Kumar Nayak maknayak@in.ibm.com>			*/
-/******************************************************************************/
-#include <sys/syscall.h>
-#include <sys/types.h>
-#include <getopt.h>
-#include <string.h>
-#include <stdlib.h>
-#include <errno.h>
-#include <stdio.h>
-#include <time.h>
-#include <signal.h>
-#include "../utils/common_j_h.c"
-#include "../utils/include_j_h.h"
-
-#include "test.h"
-#include "linux_syscall_numbers.h"
-
-char *TCID = "clock_nanosleep01";
-int testno;
-int TST_TOTAL = 1;
-struct sigaction act;
-
 /*
- * sighandler()
+ * Copyright (c) Crackerjack Project., 2007-2008 ,Hitachi, Ltd
+ *          Author(s): Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,
+ *		       Yumiko Sugita <yumiko.sugita.yf@hitachi.com>,
+ *		       Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>
+ * Copyright (c) 2016 Linux Test Project
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
  */
-void sighandler(int sig)
-{
-	if (sig == SIGINT)
-		return;
 
-	return;
-}
+#include <limits.h>
 
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
+#include "linux_syscall_numbers.h"
+#include "tst_sig_proc.h"
+#include "tst_test.h"
 
-	tst_rmdir();
+int testno;
 
+static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
+{
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
-	/* Capture signals if any */
-	act.sa_handler = sighandler;
-	sigfillset(&act.sa_mask);
-	sigaction(SIGINT, &act, NULL);
-
-	/* Create temporary directories */
-	TEST_PAUSE;
-	tst_tmpdir();
+	SAFE_SIGNAL(SIGINT, sighandler);
 }
 
-/*
- * Macros
- */
-#define SYSCALL_NAME    "clock_nanosleep"
-
 enum test_type {
 	NORMAL,
-	NULL_POINTER,
 	SEND_SIGINT,
 };
 
-/*
- * Data Structure
- */
+#define TYPE_NAME(x) .ttype = x, .desc = #x
+
 struct test_case {
-	clockid_t clk_id;
-	int ttype;
-	int flags;
+	clockid_t clk_id;	   /* clock_* clock type parameter */
+	int ttype;		   /* test type (enum) */
+	const char *desc;	   /* test description (name) */
+	int flags;		   /* clock_nanosleep flags parameter */
 	time_t sec;
 	long nsec;
-	int ret;
-	int err;
+	int ret;		   /* expected ret code */
+	int err;		   /* expected errno code */
 };
 
 /* Test cases
@@ -161,58 +57,57 @@ struct test_case {
  *
  *   EINTR	      v (function was interrupted by a signal)
  *   EINVAL	     v (invalid tv_nsec, etc.)
- *   ENOTSUP	    can't check because not supported clk_id generates
- *		      EINVAL
+ *   ENOTSUP	    can't check because not supported clk_id generates EINVAL
  */
 
 static struct test_case tcase[] = {
-	{			// case00
+	{
 	 .clk_id = CLOCK_REALTIME,
-	 .ttype = NORMAL,
+	 TYPE_NAME(NORMAL),
 	 .flags = 0,
 	 .sec = 0,
-	 .nsec = 500000000,	// 500msec
+	 .nsec = 500000000,
 	 .ret = 0,
 	 .err = 0,
 	 },
-	{			// case01
+	{
 	 .clk_id = CLOCK_MONOTONIC,
-	 .ttype = NORMAL,
+	 TYPE_NAME(NORMAL),
 	 .flags = 0,
 	 .sec = 0,
-	 .nsec = 500000000,	// 500msec
+	 .nsec = 500000000,
 	 .ret = 0,
 	 .err = 0,
 	 },
-	{			// case02
-	 .ttype = NORMAL,
+	{
+	 TYPE_NAME(NORMAL),
 	 .clk_id = CLOCK_REALTIME,
 	 .flags = 0,
 	 .sec = 0,
-	 .nsec = -1,		// invalid
+	 .nsec = -1,
 	 .ret = EINVAL,
 	 .err = 0,
 	 },
-	{			// case03
-	 .ttype = NORMAL,
+	{
+	 TYPE_NAME(NORMAL),
 	 .clk_id = CLOCK_REALTIME,
 	 .flags = 0,
 	 .sec = 0,
-	 .nsec = 1000000000,	// invalid
+	 .nsec = 1000000000,
 	 .ret = EINVAL,
 	 .err = 0,
 	 },
-	{			// case04
-	 .ttype = NORMAL,
-	 .clk_id = CLOCK_THREAD_CPUTIME_ID,	// not supported
+	{
+	 TYPE_NAME(NORMAL),
+	 .clk_id = CLOCK_THREAD_CPUTIME_ID,
 	 .flags = 0,
 	 .sec = 0,
-	 .nsec = 500000000,	// 500msec
-	 .ret = EINVAL,		// RHEL4U1 + 2.6.18 returns EINVAL
+	 .nsec = 500000000,
+	 .ret = EINVAL,
 	 .err = 0,
 	 },
-	{			// case05
-	 .ttype = SEND_SIGINT,
+	{
+	 TYPE_NAME(SEND_SIGINT),
 	 .clk_id = CLOCK_REALTIME,
 	 .flags = 0,
 	 .sec = 10,
@@ -220,23 +115,8 @@ static struct test_case tcase[] = {
 	 .ret = EINTR,
 	 .err = 0,
 	 },
-#if 0				// glibc generates SEGV error (RHEL4U1 + 2.6.18)
-	{			// caseXX
-	 .ttype = NULL_POINTER,
-	 .clk_id = CLOCK_REALTIME,
-	 .flags = 0,
-	 .sec = 0,
-	 .nsec = 500000000,	// 500msec
-	 .ret = EFAULT,
-	 .err = 0,
-	 },
-#endif
 };
 
-/*
- * chk_difftime()
- *   Return : OK(0), NG(-1)
- */
 #define MAX_MSEC_DIFF   20
 
 static int chk_difftime(struct timespec *bef, struct timespec *aft,
@@ -254,152 +134,83 @@ static int chk_difftime(struct timespec *bef, struct timespec *aft,
 	}
 	expect = (sec * 1000) + (nsec / 1000000);
 	result = (t.tv_sec * 1000) + (t.tv_nsec / 1000000);
-	tst_resm(TINFO, "check sleep time: (min:%ld) < %ld < (max:%ld) (msec)",
+
+	tst_res(TINFO, "check sleep time: (min: %ld) < %ld < (max: %ld) (msec)",
 		 expect - MAX_MSEC_DIFF, result, expect + MAX_MSEC_DIFF);
+
 	if (result < expect - MAX_MSEC_DIFF || result > expect + MAX_MSEC_DIFF)
 		return -1;
+
 	return 0;
 }
 
-/*
- * do_test()
- *
- *   Input  : TestCase Data
- *   Return : RESULT_OK(0), RESULT_NG(1)
- *
- */
-static int do_test(struct test_case *tc)
+static void do_test(unsigned int i)
 {
-	int sys_ret;
-	int sys_errno;
-	int result = RESULT_OK;
+	int sys_ret, sys_errno, dummy;
 	struct timespec beftp, afttp, rq, rm;
-	int rc, range_ok = 1, remain_ok = 1;
+	int rc;
 	pid_t pid = 0;
+	struct test_case *tc = &tcase[i];
 
-	/*
-	 * Check before sleep time
-	 */
+	tst_res(TINFO, "case %s", tc->desc);
+
+	/* setup */
 	if (tc->ttype == SEND_SIGINT) {
-		pid = create_sig_proc(500000, SIGINT, UINT_MAX);
-		if (pid < 0)
-			return 1;
+		pid = create_sig_proc(SIGINT, 40, 500000);
 	}
 
-	/*
-	 * Check before sleep time
-	 */
 	TEST(rc = clock_gettime(tc->clk_id, &beftp));
 	if (rc < 0) {
-		tst_resm(TFAIL | TTERRNO, "clock_gettime failed");
-		result = 1;
-		goto EXIT;
+		tst_brk(TBROK, "clock_gettime failed");
 	}
-	/*
-	 * Execute system call
-	 */
+
+	/* test */
 	rq.tv_sec = tc->sec;
 	rq.tv_nsec = tc->nsec;
-	// !!!CAUTION: 'clock_gettime' returns errno itself
 	errno = 0;
-	if (tc->ttype == NULL_POINTER)
-		TEST(sys_ret =
-		     clock_nanosleep(tc->clk_id, tc->flags, NULL, &rm));
-	else
-		TEST(sys_ret =
-		     clock_nanosleep(tc->clk_id, tc->flags, &rq, &rm));
+	TEST(sys_ret = clock_nanosleep(tc->clk_id, tc->flags, &rq, &rm));
 	sys_errno = errno;
-	if (sys_ret != 0)
-		goto TEST_END;
-
-	/*
-	 * Check after sleep time
-	 */
-	TEST(rc = clock_gettime(tc->clk_id, &afttp));
-	if (TEST_RETURN < 0) {
-		EPRINTF("clock_gettime failed.\n");
-		result = 1;
-		goto EXIT;
-	}
-	range_ok = chk_difftime(&beftp, &afttp, tc->sec, tc->nsec) == 0;
-	/*
-	 * Check remaining time
-	 */
-TEST_END:
-	if (tc->ttype == NORMAL || tc->ttype == SEND_SIGINT) {
-		tst_resm(TINFO, "remain time: %ld %ld", rm.tv_sec, rm.tv_nsec);
-		if (tc->ttype == NORMAL)
-			remain_ok = 1;
-		else
-			remain_ok = rm.tv_sec != 0 || rm.tv_nsec != 0;
+	if (sys_ret == 0) {
+		TEST(rc = clock_gettime(tc->clk_id, &afttp));
+		if (TEST_RETURN < 0) {
+			tst_brk(TBROK, "clock_gettime failed");
+		}
 	}
 
-	/*
-	 * Check results
-	 */
-	result |= (sys_ret != tc->ret) || !range_ok || !remain_ok;
-	if (!range_ok)
-		PRINT_RESULT_EXTRA(0, tc->ret, tc->err, sys_ret, sys_errno,
-				   "time range check", range_ok);
-	else
-		PRINT_RESULT_EXTRA(0, tc->ret, tc->err, sys_ret, sys_errno,
-				   "remain time check", remain_ok);
-EXIT:
+	tst_res(TINFO, "remain time: %ld %ld", rm.tv_sec, rm.tv_nsec);
+
+	/* cleanup */
 	if (pid > 0) {
-		int st;
-		TEST(kill(pid, SIGTERM));
-		TEST(wait(&st));
+		kill(pid, SIGTERM);
+		SAFE_WAIT(&dummy);
 	}
-	return result;
-}
-
-/*
- * main()
- */
-
-int main(int ac, char **av)
-{
-	int result = RESULT_OK;
-	int i;
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-
-		tst_count = 0;
-
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
-			switch (result) {
-			case RESULT_OK:
-				tst_resm(TPASS,
-					 "clock_nanosleep call succeeded");
-				break;
-
-			default:
-				tst_brkm(TFAIL | TERRNO, cleanup,
-					 "clock_nanosleep failed");
-				break;
-			}
-
-		}
 
+	/* result check */
+	if (sys_ret == 0 && chk_difftime(&beftp, &afttp, tc->sec, tc->nsec) != 0) {
+		tst_res(TFAIL, "time range check ret: %d, exp: %d, ret_errno: %s (%d),"
+			" exp_errno: %s (%d)", sys_ret, tc->ret,
+			tst_strerrno(sys_errno), sys_errno,
+			tst_strerrno(tc->err), tc->err);
+	} else if (tc->ttype == SEND_SIGINT && !rm.tv_sec && !rm.tv_nsec) {
+		tst_res(TFAIL, "remain time check ret: %d, exp: %d, ret_errno: %s (%d),"
+			" exp_errno: %s (%d)", sys_ret, tc->ret,
+			tst_strerrno(sys_errno), sys_errno,
+			tst_strerrno(tc->err), tc->err);
+	} else if (sys_ret != tc->ret) {
+		tst_res(TFAIL, "ret: %d, exp: %d, ret_errno: %s (%d),"
+			" exp_errno: %s (%d)", sys_ret, tc->ret,
+			tst_strerrno(sys_errno), sys_errno,
+			tst_strerrno(tc->err), tc->err);
+	} else {
+		tst_res(TPASS, "ret: %d", sys_ret);
 	}
-
-	cleanup();
-	tst_exit();
-
 }
+
+static struct tst_test test = {
+	.tid = "clock_nanosleep01",
+	.tcnt = ARRAY_SIZE(tcase),
+	.test = do_test,
+	.setup = setup,
+	.forks_child = 1,
+	.needs_tmpdir = 1,
+};
-- 
2.10.2

