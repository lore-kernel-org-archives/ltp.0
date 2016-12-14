From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 14 Dec 2016 23:17:13 +0100
Subject: [LTP] [PATCH 2/2] syscalls/mq_timedreceive: convert to new API
In-Reply-To: <20161214221713.4460-1-pvorel@suse.cz>
References: <20161214221713.4460-1-pvorel@suse.cz>
Message-ID: <20161214221713.4460-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../syscalls/mq_timedreceive/mq_timedreceive01.c   | 624 ++++++++-------------
 1 file changed, 219 insertions(+), 405 deletions(-)

diff --git a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
index d3d49773d..6ffdb6a40 100644
--- a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
+++ b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
@@ -1,147 +1,35 @@
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
-/* File:	mq_timedreceive01.c					   */
-/*									    */
-/* Description: This tests the mq_timedreceive() syscall		      */
-/*									      */
-/* 									      */
-/*									      */
-/*									      */
-/*									      */
-/*									    */
-/* Usage:  <for command-line>						 */
-/* mq_timedreceive01 [-c n] [-e][-i n] [-I x] [-p x] [-t]		     */
-/*      where,  -c n : Run n copies concurrently.			     */
-/*	      -e   : Turn on errno logging.				 */
-/*	      -i n : Execute test n times.				  */
-/*	      -I x : Execute test for x seconds.			    */
-/*	      -P x : Pause for x seconds between iterations.		*/
-/*	      -t   : Turn on syscall timing.				*/
-/*									    */
-/* Total Tests: 1							     */
-/*									    */
-/* Test Name:   mq_timedreceive01					     */
-/* History:     Porting from Crackerjack to LTP is done by		    */
-/*	      Manas Kumar Nayak maknayak@in.ibm.com>			*/
-/******************************************************************************/
-#define _XOPEN_SOURCE 600
-#include <sys/syscall.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/wait.h>
-#include <getopt.h>
-#include <libgen.h>
-#include <stdlib.h>
-#include <errno.h>
-#include <stdio.h>
-#include <unistd.h>
-#include <string.h>
-#include <mqueue.h>
-#include <time.h>
-#include <signal.h>
-#include <limits.h>
-
-#include "../utils/include_j_h.h"
-#include "../utils/common_j_h.c"
-
-#include "test.h"
-#include "linux_syscall_numbers.h"
-
-char *TCID = "mq_timedreceive01";
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
  */
-void sighandler(int sig)
-{
-	if (sig == SIGINT)
-		return;
-
-	return;
-}
 
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
-
-}
+#include <errno.h>
+#include <limits.h>
+#include <mqueue.h>
 
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
-	/* Capture signals if any */
-	act.sa_handler = sighandler;
-	sigfillset(&act.sa_mask);
-	sigaction(SIGINT, &act, NULL);
-	/* Create temporary directories */
-	TEST_PAUSE;
-	tst_tmpdir();
-}
+#include "tst_sig_proc.h"
+#include "tst_test.h"
 
-/*
- * Macros
- */
-#define SYSCALL_NAME    "mq_timedreceive"
+static struct sigaction act;
+static pid_t pid;
+static int fd;
 
 enum test_type {
 	NORMAL,
@@ -153,156 +41,162 @@ enum test_type {
 	SEND_SIGINT,
 };
 
-/*
- * Data Structure
- */
 struct test_case {
 	int ttype;
+	const char *desc;
 	int non_block;
 	int len;
 	unsigned prio;
-	time_t sec;
-	long nsec;
+	struct timespec rq;
 	int ret;
 	int err;
 };
 
-#define MAX_MSG	 10
 #define MAX_MSGSIZE     8192
 
-/* Test cases
- *
- *   test status of errors on man page
- *
- *   EAGAIN	     v (would block)
- *   EBADF	      v (not a valid descriptor)
- *   EINTR	      v (interrupted by a signal)
- *   EINVAL	     v (invalid timeout value)
- *   ETIMEDOUT	  v (not block and timeout occured)
- *   EMSGSIZE	   v ('msg_len' is less than the message size of the queue)
- *   EBADMSG	    can't check because this error never occur
- */
+#define QUEUE_NAME	"/test_mqueue"
+#define TYPE_NAME(x) .ttype = x, .desc = #x
 static struct test_case tcase[] = {
-	{			// case00
-	 .ttype = NORMAL,
-	 .len = 0,		// also success when size equals zero
-	 .ret = 0,
-	 .err = 0,
-	 },
-	{			// case01
-	 .ttype = NORMAL,
-	 .len = 1,
-	 .ret = 0,
-	 .err = 0,
-	 },
-	{			// case02
-	 .ttype = NORMAL,
-	 .len = MAX_MSGSIZE,
-	 .ret = 0,
-	 .err = 0,
-	 },
-	{			// case03
-	 .ttype = NORMAL,
-	 .len = 1,
-	 .prio = 32767,		// max priority
-	 .ret = 0,
-	 .err = 0,
-	 },
-	{			// case04
-	 .ttype = INVALID_MSG_LEN,
-	 .len = 0,
-	 .ret = -1,
-	 .err = EMSGSIZE,
-	 },
-	{			// case05
-	 .ttype = FD_NONE,
-	 .len = 0,
-	 .ret = -1,
-	 .err = EBADF,
-	 },
-	{			// case06
-	 .ttype = FD_NOT_EXIST,
-	 .len = 0,
-	 .ret = -1,
-	 .err = EBADF,
-	 },
-	{			// case07
-	 .ttype = FD_FILE,
-	 .len = 0,
-	 .ret = -1,
-	 .err = EBADF,
-	 },
-	{			// case08
-	 .ttype = EMPTY_QUEUE,
-	 .non_block = 1,
-	 .len = 16,
-	 .ret = -1,
-	 .err = EAGAIN,
-	 },
-	{			// case09
-	 .ttype = EMPTY_QUEUE,
-	 .len = 16,
-	 .sec = -1,
-	 .nsec = 0,
-	 .ret = -1,
-	 .err = EINVAL,
-	 },
-	{			// case10
-	 .ttype = EMPTY_QUEUE,
-	 .len = 16,
-	 .sec = 0,
-	 .nsec = -1,
-	 .ret = -1,
-	 .err = EINVAL,
-	 },
-	{			// case11
-	 .ttype = EMPTY_QUEUE,
-	 .len = 16,
-	 .sec = 0,
-	 .nsec = 1000000000,
-	 .ret = -1,
-	 .err = EINVAL,
-	 },
-	{			// case12
-	 .ttype = EMPTY_QUEUE,
-	 .len = 16,
-	 .sec = 0,
-	 .nsec = 999999999,
-	 .ret = -1,
-	 .err = ETIMEDOUT,
-	 },
-	{			// case13
-	 .ttype = SEND_SIGINT,
-	 .len = 16,
-	 .sec = 3,
-	 .nsec = 0,
-	 .ret = -1,
-	 .err = EINTR,
-	 },
+	{
+		TYPE_NAME(NORMAL),
+		.len = 0,
+		.ret = 0,
+		.err = 0,
+	},
+	{
+		TYPE_NAME(NORMAL),
+		.len = 1,
+		.ret = 0,
+		.err = 0,
+	},
+	{
+		TYPE_NAME(NORMAL),
+		.len = MAX_MSGSIZE,
+		.ret = 0,
+		.err = 0,
+	},
+	{
+		TYPE_NAME(NORMAL),
+		.len = 1,
+		.prio = 32767,	/* max priority */
+		.ret = 0,
+		.err = 0,
+	},
+	{
+		TYPE_NAME(INVALID_MSG_LEN),
+		.len = 0,
+		.ret = -1,
+		.err = EMSGSIZE,
+	},
+	{
+		TYPE_NAME(FD_NONE),
+		.len = 0,
+		.ret = -1,
+		.err = EBADF,
+	},
+	{
+		TYPE_NAME(FD_NOT_EXIST),
+		.len = 0,
+		.ret = -1,
+		.err = EBADF,
+	},
+	{
+		TYPE_NAME(FD_FILE),
+		.len = 0,
+		.ret = -1,
+		.err = EBADF,
+	},
+	{
+		TYPE_NAME(EMPTY_QUEUE),
+		.non_block = 1,
+		.len = 16,
+		.ret = -1,
+		.err = EAGAIN,
+	},
+	{
+		TYPE_NAME(EMPTY_QUEUE),
+		.len = 16,
+		.rq = (struct timespec) {.tv_sec = -1, .tv_nsec = 0},
+		.ret = -1,
+		.err = EINVAL,
+	},
+	{
+		TYPE_NAME(EMPTY_QUEUE),
+		.len = 16,
+		.rq = (struct timespec) {.tv_sec = 0, .tv_nsec = -1},
+		.ret = -1,
+		.err = EINVAL,
+	},
+	{
+		TYPE_NAME(EMPTY_QUEUE),
+		.len = 16,
+		.rq = (struct timespec) {.tv_sec = 0, .tv_nsec = 1000000000},
+		.ret = -1,
+		.err = EINVAL,
+	},
+	{
+		TYPE_NAME(EMPTY_QUEUE),
+		.len = 16,
+		.rq = (struct timespec) {.tv_sec = 0, .tv_nsec = 999999999},
+		.ret = -1,
+		.err = ETIMEDOUT,
+	},
+	{
+		TYPE_NAME(SEND_SIGINT),
+		.len = 16,
+		.rq = (struct timespec) {.tv_sec = 3, .tv_nsec = 0},
+		.ret = -1,
+		.err = EINTR,
+	},
 };
 
-#define MEM_LENGTH	      (4 * 1024 * 1024)
-/*
- * do_test()
- *
- *   Input  : TestCase Data
- *   Return : RESULT_OK(0), RESULT_NG(1)
- *
- */
+static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
+{
+}
 
-static int do_test(struct test_case *tc)
+static void setup(void)
 {
-	int sys_ret;
-	int sys_errno;
-	int result = RESULT_OK;
+	SAFE_SIGNAL(SIGINT, sighandler);
+	act.sa_handler = sighandler;
+	sigaction(SIGINT, &act, NULL);
+}
+
+static void cleanup(void)
+{
+	if (fd > 0)
+		close(fd);
+}
+
+static void cleanup_n(unsigned int i)
+{
+	struct test_case *tc = &tcase[i];
+
+	if (fd > 0 && tc->ttype != FD_NOT_EXIST)
+		SAFE_CLOSE(fd);
+
+	if (pid) {
+		SAFE_KILL(pid, SIGTERM);
+		SAFE_WAIT(NULL);
+	}
+
+	mq_unlink(QUEUE_NAME);
+}
+
+static void do_test(unsigned int i)
+{
+	struct test_case *tc = &tcase[i];
+
 	int oflag;
-	int i, rc, cmp_ok = 1, fd = -1;
+	int j;
 	char smsg[MAX_MSGSIZE], rmsg[MAX_MSGSIZE];
-	struct timespec ts = { 0, 0 };
-	pid_t pid = 0;
 	unsigned prio;
 	size_t msg_len;
 
+	fd = -1;
+	pid = 0;
+
+	tst_res(TINFO, "case %s", tc->desc);
+
 	/*
 	 * When test ended with SIGTERM etc, mq descriptor is left remains.
 	 * So we delete it first.
@@ -310,169 +204,89 @@ static int do_test(struct test_case *tc)
 	TEST(mq_unlink(QUEUE_NAME));
 
 	switch (tc->ttype) {
+	case FD_NONE:
+		break;
 	case FD_NOT_EXIST:
 		fd = INT_MAX - 1;
-		/* fallthrough */
-	case FD_NONE:
 		break;
 	case FD_FILE:
-		TEST(fd = open("/", O_RDONLY));
-		if (TEST_RETURN < 0) {
-			tst_resm(TFAIL | TTERRNO, "can't open \"/\".");
-			result = 1;
-			goto EXIT;
+		fd = open("/", O_RDONLY);
+		if (fd < 0) {
+			tst_res(TBROK | TERRNO, "can't open \"/\".");
+			cleanup_n(i);
+			return;
 		}
 		break;
 	default:
-		/*
-		 * Open message queue
-		 */
 		oflag = O_CREAT | O_EXCL | O_RDWR;
 		if (tc->non_block)
 			oflag |= O_NONBLOCK;
-
-		TEST(fd = mq_open(QUEUE_NAME, oflag, S_IRWXU, NULL));
-		if (TEST_RETURN < 0) {
-			tst_resm(TFAIL | TTERRNO, "mq_open failed");
-			result = 1;
-			goto EXIT;
+		fd = mq_open(QUEUE_NAME, oflag, S_IRWXU, NULL);
+		if (fd < 0) {
+			tst_res(TBROK | TERRNO, "mq_open failed");
+			cleanup_n(i);
+			return;
 		}
 
-		if (tc->ttype == SEND_SIGINT) {
-			pid = create_sig_proc(200000, SIGINT, UINT_MAX);
-			if (pid < 0) {
-				result = 1;
-				goto EXIT;
-			}
-		}
-		break;
+		if (tc->ttype == SEND_SIGINT)
+			pid = create_sig_proc(SIGINT, 40, 200000);
 	}
 
-	/*
-	 * Prepare send message
-	 */
-	for (i = 0; i < tc->len; i++)
-		smsg[i] = i;
+	for (j = 0; j < tc->len; j++)
+		smsg[j] = j;
 
-	/*
-	 * Send message
-	 */
-	switch (tc->ttype) {
-	case EMPTY_QUEUE:
-	case SEND_SIGINT:
-	case FD_NONE:
-	case FD_NOT_EXIST:
-	case FD_FILE:
-		break;
-	default:
-		TEST(rc = mq_timedsend(fd, smsg, tc->len, tc->prio, &ts));
-		if (TEST_RETURN < 0) {
-			tst_resm(TFAIL | TTERRNO, "mq_timedsend failed");
-			result = 1;
-			goto EXIT;
+	/* send */
+	if (tc->ttype == NORMAL || tc->ttype == INVALID_MSG_LEN) {
+		if (mq_timedsend(fd, smsg, tc->len, tc->prio,
+			&((struct timespec){0})) < 0) {
+			tst_res(TFAIL | TERRNO, "mq_timedsend failed");
+			cleanup_n(i);
+			return;
 		}
-		break;
 	}
 
-	/*
-	 * Set the message length and timeout value
-	 */
 	msg_len = MAX_MSGSIZE;
 	if (tc->ttype == INVALID_MSG_LEN)
 		msg_len -= 1;
-	ts.tv_sec = tc->sec;
-	ts.tv_nsec = tc->nsec;
-	if (tc->sec >= 0 || tc->nsec != 0)
-		ts.tv_sec += time(NULL);
 
-	/*
-	 * Execute system call
-	 */
-	errno = 0;
-	TEST(sys_ret = mq_timedreceive(fd, rmsg, msg_len, &prio, &ts));
-	sys_errno = errno;
-	if (sys_ret < 0)
-		goto TEST_END;
-
-	/*
-	 * Compare received message
-	 */
-	if (sys_ret != tc->len || tc->prio != prio)
-		cmp_ok = 0;
-	else {
-		for (i = 0; i < tc->len; i++)
-			if (rmsg[i] != smsg[i]) {
-				cmp_ok = 0;
-				break;
-			}
-	}
-
-TEST_END:
-	/*
-	 * Check results
-	 */
-	result |= (sys_errno != tc->err) || !cmp_ok;
-	PRINT_RESULT_CMP(0, tc->ret == 0 ? tc->len : tc->ret, tc->err, sys_ret,
-			 sys_errno, cmp_ok);
-
-EXIT:
-	if (fd >= 0) {
-		TEST(close(fd));
-		TEST(mq_unlink(QUEUE_NAME));
-	}
-	if (pid > 0) {
-		int st;
-		TEST(kill(pid, SIGTERM));
-		TEST(wait(&st));
-	}
-	return result;
-}
+	if (tc->rq.tv_sec >= 0 || tc->rq.tv_nsec != 0)
+		tc->rq.tv_sec += time(NULL);
 
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
+	/* test */
+	TEST(mq_timedreceive(fd, rmsg, msg_len, &prio, &tc->rq));
 
-	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		tst_count = 0;
-		for (testno = 0; testno < TST_TOTAL; ++testno) {
+	cleanup_n(i);
 
-			/*
-			 * Execute test
-			 */
-			for (i = 0; i < (int)ARRAY_SIZE(tcase); i++) {
-				int ret;
-				tst_resm(TINFO, "(case%02d) START", i);
-				ret = do_test(&tcase[i]);
-				tst_resm(TINFO, "(case%02d) END => %s",
-					 i, (ret == 0) ? "OK" : "NG");
-				result |= ret;
-			}
-
-			/*
-			 * Check results
-			 */
-			switch (result) {
-			case RESULT_OK:
-				tst_resm(TPASS,
-					 "mq_timedreceive call succeeded");
-				break;
+	if (TEST_RETURN != -1) {
+		if (TEST_RETURN != tc->len) {
+			tst_res(TFAIL | TTERRNO, "mq_timedreceive wrong msg_len returned %ld, expected %d",
+				TEST_RETURN, tc->len);
+			return;
+		}
 
-			default:
-				tst_brkm(TFAIL | TTERRNO, cleanup,
-					 "mq_timedreceive failed");
-			}
+		if (tc->prio != prio) {
+			tst_res(TFAIL | TTERRNO, "mq_timedreceive wrong prio returned %d, expected %d",
+				prio, tc->prio);
+			return;
 		}
 	}
-	cleanup();
-	tst_exit();
+
+	if (TEST_ERRNO != tc->err || (tc->ret < 0 && TEST_RETURN != tc->ret) ||
+		(tc->ret >= 0 && TEST_RETURN < 0)) {
+		tst_res(TFAIL | TTERRNO, "%s returned: %ld, "
+			"expected: %d, expected errno: %s (%d)", tc->desc,
+			TEST_RETURN, tc->ret, tst_strerrno(tc->err), tc->err);
+	} else {
+		tst_res(TPASS | TTERRNO, "%s returned: %ld", tc->desc,
+			TEST_RETURN);
+	}
 }
+
+static struct tst_test test = {
+	.tid = "mq_timedreceive01",
+	.tcnt = ARRAY_SIZE(tcase),
+	.test = do_test,
+	.setup = setup,
+	.cleanup = cleanup,
+	.forks_child = 1,
+};
-- 
2.11.0

