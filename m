From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  1 Mar 2017 21:13:31 +0100
Subject: [LTP] [PATCH v2 1/1] syscalls/mq_timedreceive: convert to new API
Message-ID: <20170301201331.22402-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../syscalls/mq_timedreceive/mq_timedreceive01.c   | 678 ++++++++-------------
 1 file changed, 257 insertions(+), 421 deletions(-)

diff --git a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
index d3d49773d..efccc4427 100644
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
+ * Copyright (c) 2016-2017 Linux Test Project
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
 
-	tst_rmdir();
+#include <errno.h>
+#include <limits.h>
+#include <mqueue.h>
 
-}
+#include "tst_sig_proc.h"
+#include "tst_test.h"
 
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
-
-/*
- * Macros
- */
-#define SYSCALL_NAME    "mq_timedreceive"
+static struct sigaction act;
+static pid_t pid;
+static int fd;
 
 enum test_type {
 	NORMAL,
@@ -153,326 +41,274 @@ enum test_type {
 	SEND_SIGINT,
 };
 
-/*
- * Data Structure
- */
 struct test_case {
 	int ttype;
-	int non_block;
+	const char *desc;
 	int len;
 	unsigned prio;
-	time_t sec;
-	long nsec;
+	struct timespec rq;
+	int fd;
 	int ret;
 	int err;
+	void (*setup)(void);
+	void (*cleanup)(void);
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
+
+static void create_queue(void);
+static void create_queue_nonblock(void);
+static void open_fd(void);
+static void unlink_queue(void);
+
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
+		.setup = create_queue,
+		.len = 0,
+		.ret = 0,
+		.err = 0,
+	},
+	{
+		TYPE_NAME(NORMAL),
+		.setup = create_queue,
+		.len = 1,
+		.ret = 0,
+		.err = 0,
+	},
+	{
+		TYPE_NAME(NORMAL),
+		.setup = create_queue,
+		.len = MAX_MSGSIZE,
+		.ret = 0,
+		.err = 0,
+	},
+	{
+		TYPE_NAME(NORMAL),
+		.setup = create_queue,
+		.len = 1,
+		.prio = 32767,	/* max priority */
+		.ret = 0,
+		.err = 0,
+	},
+	{
+		TYPE_NAME(INVALID_MSG_LEN),
+		.setup = create_queue,
+		.len = 0,
+		.ret = -1,
+		.err = EMSGSIZE,
+	},
+	{
+		TYPE_NAME(FD_NONE),
+		.len = 0,
+		.fd = -1,
+		.ret = -1,
+		.err = EBADF,
+	},
+	{
+		TYPE_NAME(FD_NOT_EXIST),
+		.len = 0,
+		.fd = INT_MAX - 1,
+		.ret = -1,
+		.err = EBADF,
+	},
+	{
+		TYPE_NAME(FD_FILE),
+		.len = 0,
+		.ret = -1,
+		.err = EBADF,
+		.setup = open_fd,
+	},
+	{
+		TYPE_NAME(EMPTY_QUEUE),
+		.len = 16,
+		.ret = -1,
+		.err = EAGAIN,
+		.setup = create_queue_nonblock,
+		.cleanup = unlink_queue,
+	},
+	{
+		TYPE_NAME(EMPTY_QUEUE),
+		.len = 16,
+		.rq = (struct timespec) {.tv_sec = -1, .tv_nsec = 0},
+		.ret = -1,
+		.err = EINVAL,
+		.setup = create_queue,
+		.cleanup = unlink_queue,
+	},
+	{
+		TYPE_NAME(EMPTY_QUEUE),
+		.len = 16,
+		.rq = (struct timespec) {.tv_sec = 0, .tv_nsec = -1},
+		.ret = -1,
+		.err = EINVAL,
+		.setup = create_queue,
+		.cleanup = unlink_queue,
+	},
+	{
+		TYPE_NAME(EMPTY_QUEUE),
+		.len = 16,
+		.rq = (struct timespec) {.tv_sec = 0, .tv_nsec = 1000000000},
+		.ret = -1,
+		.err = EINVAL,
+		.setup = create_queue,
+		.cleanup = unlink_queue,
+	},
+	{
+		TYPE_NAME(EMPTY_QUEUE),
+		.len = 16,
+		.rq = (struct timespec) {.tv_sec = 0, .tv_nsec = 999999999},
+		.ret = -1,
+		.err = ETIMEDOUT,
+		.setup = create_queue,
+		.cleanup = unlink_queue,
+	},
+	{
+		TYPE_NAME(SEND_SIGINT),
+		.len = 16,
+		.rq = (struct timespec) {.tv_sec = 3, .tv_nsec = 0},
+		.ret = -1,
+		.err = EINTR,
+		.setup = create_queue,
+		.cleanup = unlink_queue,
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
+
+static void setup(void)
+{
+	SAFE_SIGNAL(SIGINT, sighandler);
+	act.sa_handler = sighandler;
+	sigaction(SIGINT, &act, NULL);
+}
+
+static void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+}
 
-static int do_test(struct test_case *tc)
+static void create_queue(void)
 {
-	int sys_ret;
-	int sys_errno;
-	int result = RESULT_OK;
-	int oflag;
-	int i, rc, cmp_ok = 1, fd = -1;
+	fd = mq_open(QUEUE_NAME, O_CREAT | O_EXCL | O_RDWR, S_IRWXU, NULL);
+	if (fd == -1)
+		tst_brk(TBROK | TERRNO, "mq_open(" QUEUE_NAME ") failed");
+}
+
+static void create_queue_nonblock(void)
+{
+	fd = mq_open(QUEUE_NAME, O_CREAT | O_EXCL | O_RDWR | O_NONBLOCK, S_IRWXU,
+		     NULL);
+	if (fd == -1)
+		tst_brk(TBROK | TERRNO, "mq_open(" QUEUE_NAME ") failed");
+}
+
+static void open_fd(void)
+{
+	fd = open("/", O_RDONLY);
+	if (fd < 0)
+		tst_brk(TBROK | TERRNO, "can't open \"/\".");
+}
+
+static void unlink_queue(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+
+	mq_unlink(QUEUE_NAME);
+}
+
+static void do_test(unsigned int i)
+{
+	struct test_case *tc = &tcase[i];
+
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
 	 */
 	TEST(mq_unlink(QUEUE_NAME));
 
-	switch (tc->ttype) {
-	case FD_NOT_EXIST:
-		fd = INT_MAX - 1;
-		/* fallthrough */
-	case FD_NONE:
-		break;
-	case FD_FILE:
-		TEST(fd = open("/", O_RDONLY));
-		if (TEST_RETURN < 0) {
-			tst_resm(TFAIL | TTERRNO, "can't open \"/\".");
-			result = 1;
-			goto EXIT;
-		}
-		break;
-	default:
-		/*
-		 * Open message queue
-		 */
-		oflag = O_CREAT | O_EXCL | O_RDWR;
-		if (tc->non_block)
-			oflag |= O_NONBLOCK;
-
-		TEST(fd = mq_open(QUEUE_NAME, oflag, S_IRWXU, NULL));
-		if (TEST_RETURN < 0) {
-			tst_resm(TFAIL | TTERRNO, "mq_open failed");
-			result = 1;
-			goto EXIT;
-		}
+	if (tc->fd)
+		fd = tc->fd;
 
-		if (tc->ttype == SEND_SIGINT) {
-			pid = create_sig_proc(200000, SIGINT, UINT_MAX);
-			if (pid < 0) {
-				result = 1;
-				goto EXIT;
-			}
-		}
-		break;
-	}
+	if (tc->setup)
+		tc->setup();
 
-	/*
-	 * Prepare send message
-	 */
-	for (i = 0; i < tc->len; i++)
-		smsg[i] = i;
+	if (tc->ttype == SEND_SIGINT)
+		pid = create_sig_proc(SIGINT, 40, 200000);
 
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
-		}
-		break;
-	}
+	for (j = 0; j < tc->len; j++)
+		smsg[j] = j;
+
+	/* send */
+	if ((tc->ttype == NORMAL || tc->ttype == INVALID_MSG_LEN)
+		&& mq_timedsend(fd, smsg, tc->len, tc->prio,
+			     &((struct timespec){0})) < 0)
+			tst_brk(TBROK | TERRNO, "mq_timedsend failed");
 
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
+	if (tc->rq.tv_sec >= 0 || tc->rq.tv_nsec != 0)
+		tc->rq.tv_sec += time(NULL);
 
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
+	/* test */
+	TEST(mq_timedreceive(fd, rmsg, msg_len, &prio, &tc->rq));
 
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
+	/* cleanup */
+	if (tc->cleanup)
+		tc->cleanup();
+
+	if (pid) {
+		SAFE_KILL(pid, SIGTERM);
+		SAFE_WAIT(NULL);
 	}
-	return result;
-}
 
-/*
- * main()
- */
+	/* result */
+	if (TEST_RETURN != -1) {
+		if (TEST_RETURN != tc->len) {
+			tst_res(TFAIL | TTERRNO, "mq_timedreceive wrong msg_len returned %ld, expected %d",
+				TEST_RETURN, tc->len);
+			return;
+		}
 
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
-		tst_count = 0;
-		for (testno = 0; testno < TST_TOTAL; ++testno) {
-
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
-
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
+	if (TEST_ERRNO != tc->err || (tc->ret < 0 && TEST_RETURN != tc->ret)
+		|| (tc->ret >= 0 && TEST_RETURN < 0))
+		tst_res(TFAIL | TTERRNO, "%s returned: %ld, expected: %d, expected errno: %s (%d)",
+				tc->desc, TEST_RETURN, tc->ret, tst_strerrno(tc->err), tc->err);
+	else
+		tst_res(TPASS | TTERRNO, "%s returned: %ld", tc->desc, TEST_RETURN);
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

