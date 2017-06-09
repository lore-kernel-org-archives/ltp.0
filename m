From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  9 Jun 2017 21:12:50 +0200
Subject: [LTP] [PATCH v2 2/4] syscalls/{mq_timedsend,
	mq_timedreceive}: Convert to new API + cleanup
In-Reply-To: <20170609191252.9870-1-pvorel@suse.cz>
References: <20170609191252.9870-1-pvorel@suse.cz>
Message-ID: <20170609191252.9870-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Convert syscalls/mq_timedsend to new API.
* Create queues in the test setup and reuse them. This requires to
delete all messages at the end of each test (cleanup queue).
* Added headers mq.h (general usage for posix messages tests) and
mq_timed.h (specific to mq_timedsend and mq_timedreceive) to reuse common code.
* Cleanup and unify syscalls/mq_timedsend and syscalls/mq_timedreceive.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
This is IMHO the best balance between reducing code duplicity and not loosing
readability (I know, there still a lot of common code in syscalls/mq_timedsend and
syscalls/mq_timedreceive).
I tried to avoid using static variables in headers where possible.
---
 testcases/kernel/syscalls/mq_timedreceive/Makefile |   1 +
 .../syscalls/mq_timedreceive/mq_timedreceive01.c   | 249 ++------
 testcases/kernel/syscalls/mq_timedsend/Makefile    |   1 +
 .../kernel/syscalls/mq_timedsend/mq_timedsend01.c  | 654 +++++++--------------
 testcases/kernel/syscalls/utils/mq.h               |  88 +++
 testcases/kernel/syscalls/utils/mq_timed.h         |  68 +++
 6 files changed, 421 insertions(+), 640 deletions(-)
 create mode 100644 testcases/kernel/syscalls/utils/mq.h
 create mode 100644 testcases/kernel/syscalls/utils/mq_timed.h

diff --git a/testcases/kernel/syscalls/mq_timedreceive/Makefile b/testcases/kernel/syscalls/mq_timedreceive/Makefile
index 2e1628e9f..1b4a564e0 100644
--- a/testcases/kernel/syscalls/mq_timedreceive/Makefile
+++ b/testcases/kernel/syscalls/mq_timedreceive/Makefile
@@ -21,6 +21,7 @@ top_srcdir		?= ../../../..
 include $(top_srcdir)/include/mk/testcases.mk
 
 CPPFLAGS		?= -D_POSIX_C_SOURCE=$(shell getconf _POSIX_MESSAGE_PASSING)L
+CPPFLAGS		+= -I$(abs_srcdir)/../utils
 LDLIBS			+= -lpthread -lrt
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
index 6ed670464..0bd8a2d9a 100644
--- a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
+++ b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
@@ -1,9 +1,11 @@
 /*
- * Copyright (c) Crackerjack Project., 2007-2008 ,Hitachi, Ltd
- *          Author(s): Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,
- *		       Yumiko Sugita <yumiko.sugita.yf@hitachi.com>,
- *		       Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>
- * Copyright (c) 2016-2017 Linux Test Project
+ * Copyright (c) Crackerjack Project., 2007-2008, Hitachi, Ltd
+ * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
+ *
+ * Authors:
+ * Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,
+ * Yumiko Sugita <yumiko.sugita.yf@hitachi.com>,
+ * Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
@@ -16,313 +18,186 @@
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <errno.h>
 #include <limits.h>
-#include <mqueue.h>
-
-#include "tst_test.h"
-#include "tst_sig_proc.h"
-#include "tst_safe_posix_ipc.h"
-
-#define MAX_MSGSIZE     8192
-#define QUEUE_NAME	"/test_mqueue"
-
-static char smsg[MAX_MSGSIZE];
-static struct sigaction act;
-static pid_t pid;
-static int fd, fd_root;
-static struct timespec timeout_ts;
-static struct timespec eintr_ts;
 
-struct test_case {
-	unsigned int len;
-	unsigned prio;
-	struct timespec *rq;
-	int fd;
-	int invalid_msg;
-	int send;
-	int ret;
-	int err;
-	void (*setup)(void);
-	void (*cleanup)(void);
-};
+#include "mq_timed.h"
 
-static void create_queue(void);
-static void create_queue_nonblock(void);
-static void create_queue_sig(void);
-static void create_queue_timeout(void);
-static void open_fd(void);
-static void unlink_queue(void);
-static void unlink_queue_sig(void);
+int fd, fd_root, fd_nonblock, fd_maxint = INT_MAX - 1, fd_invalid = -1;
 
-static const struct test_case tcase[] = {
+static struct test_case tcase[] = {
 	{
-		.setup = create_queue,
-		.cleanup = unlink_queue,
-		.send = 1,
+		.fd = &fd,
 		.len = 0,
+		.send = 1,
 		.ret = 0,
 		.err = 0,
 	},
 	{
-		.setup = create_queue,
-		.cleanup = unlink_queue,
-		.send = 1,
+		.fd = &fd,
 		.len = 1,
+		.send = 1,
 		.ret = 0,
 		.err = 0,
 	},
 	{
-		.setup = create_queue,
-		.cleanup = unlink_queue,
-		.send = 1,
+		.fd = &fd,
 		.len = MAX_MSGSIZE,
+		.send = 1,
 		.ret = 0,
 		.err = 0,
 	},
 	{
-		.setup = create_queue,
-		.cleanup = unlink_queue,
-		.send = 1,
+		.fd = &fd,
 		.len = 1,
-		.prio = 32767,	/* max priority */
+		.send = 1,
+		.prio = MQ_PRIO_MAX - 1,
 		.ret = 0,
 		.err = 0,
 	},
 	{
-		.setup = create_queue,
-		.cleanup = unlink_queue,
+		.fd = &fd,
 		.invalid_msg = 1,
-		.send = 1,
 		.len = 0,
+		.send = 1,
 		.ret = -1,
 		.err = EMSGSIZE,
 	},
 	{
+		.fd = &fd_invalid,
 		.len = 0,
-		.fd = -1,
 		.ret = -1,
 		.err = EBADF,
 	},
 	{
+		.fd = &fd_maxint,
 		.len = 0,
-		.fd = INT_MAX - 1,
 		.ret = -1,
 		.err = EBADF,
 	},
 	{
+		.fd = &fd_root,
 		.len = 0,
 		.ret = -1,
 		.err = EBADF,
-		.setup = open_fd,
 	},
 	{
+		.fd = &fd_nonblock,
 		.len = 16,
 		.ret = -1,
 		.err = EAGAIN,
-		.setup = create_queue_nonblock,
-		.cleanup = unlink_queue,
 	},
 	{
+		.fd = &fd,
 		.len = 16,
 		.rq = &(struct timespec) {.tv_sec = -1, .tv_nsec = 0},
 		.ret = -1,
 		.err = EINVAL,
-		.setup = create_queue,
-		.cleanup = unlink_queue,
 	},
 	{
+		.fd = &fd,
 		.len = 16,
 		.rq = &(struct timespec) {.tv_sec = 0, .tv_nsec = -1},
 		.ret = -1,
 		.err = EINVAL,
-		.setup = create_queue,
-		.cleanup = unlink_queue,
 	},
 	{
+		.fd = &fd,
 		.len = 16,
 		.rq = &(struct timespec) {.tv_sec = 0, .tv_nsec = 1000000000},
 		.ret = -1,
 		.err = EINVAL,
-		.setup = create_queue,
-		.cleanup = unlink_queue,
 	},
 	{
+		.fd = &fd,
 		.len = 16,
+		.timeout = 1,
 		.ret = -1,
 		.rq = &timeout_ts,
 		.err = ETIMEDOUT,
-		.setup = create_queue_timeout,
-		.cleanup = unlink_queue,
 	},
 	{
+		.fd = &fd,
 		.len = 16,
+		.signal = 1,
 		.rq = &eintr_ts,
 		.ret = -1,
 		.err = EINTR,
-		.setup = create_queue_sig,
-		.cleanup = unlink_queue_sig,
 	},
 };
 
-static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
-{
-}
-
-static void setup(void)
-{
-	unsigned int i;
-
-	act.sa_handler = sighandler;
-	sigaction(SIGINT, &act, NULL);
-
-	fd_root = SAFE_OPEN("/", O_RDONLY);
-
-	for (i = 0; i < MAX_MSGSIZE; i++)
-		smsg[i] = i;
-}
-
-static void cleanup(void)
-{
-	if (fd > 0)
-		SAFE_CLOSE(fd);
-
-	if (fd_root > 0)
-		SAFE_CLOSE(fd_root);
-}
-
-static void create_queue(void)
-{
-	fd = SAFE_MQ_OPEN(QUEUE_NAME, O_CREAT | O_EXCL | O_RDWR, S_IRWXU, NULL);
-}
-
-static void create_queue_nonblock(void)
-{
-	fd = SAFE_MQ_OPEN(QUEUE_NAME, O_CREAT | O_EXCL | O_RDWR | O_NONBLOCK,
-		S_IRWXU, NULL);
-}
-
-static void create_queue_sig(void)
-{
-	clock_gettime(CLOCK_REALTIME, &eintr_ts);
-	eintr_ts.tv_sec += 3;
-
-	create_queue();
-	pid = create_sig_proc(SIGINT, 40, 200000);
-}
-
-static void create_queue_timeout(void)
-{
-	clock_gettime(CLOCK_REALTIME, &timeout_ts);
-	timeout_ts.tv_nsec += 50000000;
-	timeout_ts.tv_sec += timeout_ts.tv_nsec / 1000000000;
-	timeout_ts.tv_nsec %= 1000000000;
-
-	create_queue();
-}
-
-static void open_fd(void)
-{
-	fd = fd_root;
-}
-
-static void send_msg(int fd, int len, int prio)
-{
-	if (mq_timedsend(fd, smsg, len, prio,
-		&((struct timespec){0})) < 0)
-		tst_brk(TBROK | TERRNO, "mq_timedsend failed");
-}
-
-static void unlink_queue(void)
-{
-	if (fd > 0)
-		SAFE_CLOSE(fd);
-
-	mq_unlink(QUEUE_NAME);
-}
-
-static void unlink_queue_sig(void)
-{
-	SAFE_KILL(pid, SIGTERM);
-	SAFE_WAIT(NULL);
-
-	unlink_queue();
-}
-
 static void do_test(unsigned int i)
 {
-	unsigned int j;
 	const struct test_case *tc = &tcase[i];
-	char rmsg[MAX_MSGSIZE];
+	unsigned int j;
 	unsigned int prio;
-	size_t msg_len = MAX_MSGSIZE;
+	size_t len = MAX_MSGSIZE;
+	char rmsg[len];
+	pid_t pid = -1;
 
-	/*
-	 * When test ended with SIGTERM etc, mq descriptor is left remains.
-	 * So we delete it first.
-	 */
-	mq_unlink(QUEUE_NAME);
+	if (tc->signal)
+		pid = set_sig();
 
-	if (tc->fd)
-		fd = tc->fd;
-
-	if (tc->setup)
-		tc->setup();
+	if (tc->timeout)
+		set_timeout();
 
 	if (tc->send)
-		send_msg(fd, tc->len, tc->prio);
+		send_msg(*tc->fd, tc->len, tc->prio);
 
 	if (tc->invalid_msg)
-		msg_len -= 1;
+		len -= 1;
+
+	TEST(mq_timedreceive(*tc->fd, rmsg, len, &prio, tc->rq));
 
-	TEST(mq_timedreceive(fd, rmsg, msg_len, &prio, tc->rq));
+	if (pid > 0)
+		kill_pid(pid);
 
-	if (tc->cleanup)
-		tc->cleanup();
+	if (*tc->fd == fd)
+		cleanup_queue(fd);
 
 	if (TEST_RETURN < 0) {
-		if (TEST_ERRNO != tc->err) {
+		if (tc->err != TEST_ERRNO)
 			tst_res(TFAIL | TTERRNO,
 				"mq_timedreceive failed unexpectedly, expected %s",
 				tst_strerrno(tc->err));
-		} else {
+		else
 			tst_res(TPASS | TTERRNO, "mq_timedreceive failed expectedly");
-		}
+
 		return;
 	}
 
-
-	if (TEST_RETURN != tc->len) {
-		tst_res(TFAIL | TTERRNO, "mq_timedreceive wrong msg_len returned %ld, expected %d",
+	if (tc->len != TEST_RETURN) {
+		tst_res(TFAIL, "mq_timedreceive wrong length %ld, expected %d",
 			TEST_RETURN, tc->len);
 		return;
 	}
 
 	if (tc->prio != prio) {
-		tst_res(TFAIL | TTERRNO, "mq_timedreceive wrong prio returned %d, expected %d",
+		tst_res(TFAIL, "mq_timedreceive wrong prio %d, expected %d",
 			prio, tc->prio);
 		return;
 	}
 
 	for (j = 0; j < tc->len; j++) {
 		if (rmsg[j] != smsg[j]) {
-			tst_res(TFAIL | TTERRNO, "mq_timedreceive wrong data in loop %d returned %d, expected %d",
-			i, rmsg[j], smsg[j]);
+			tst_res(TFAIL,
+				"mq_timedreceive wrong data %d in %u, expected %d",
+				rmsg[j], i, smsg[j]);
 			return;
 		}
 	}
 
-	tst_res(TPASS, "mq_timedreceive returned %ld prio %u", TEST_RETURN, prio);
+	tst_res(TPASS, "mq_timedreceive returned %ld, priority %u, length: %lu",
+			TEST_RETURN, prio, len);
 }
 
 static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcase),
 	.test = do_test,
-	.setup = setup,
-	.cleanup = cleanup,
+	.setup = setup_common,
+	.cleanup = cleanup_common,
 	.forks_child = 1,
 };
diff --git a/testcases/kernel/syscalls/mq_timedsend/Makefile b/testcases/kernel/syscalls/mq_timedsend/Makefile
index 71ebae98b..7b9304212 100644
--- a/testcases/kernel/syscalls/mq_timedsend/Makefile
+++ b/testcases/kernel/syscalls/mq_timedsend/Makefile
@@ -20,6 +20,7 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
+CPPFLAGS		+= -I$(abs_srcdir)/../utils
 LDLIBS			+= -lpthread -lrt
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c b/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
index 77198cea8..2a242d196 100644
--- a/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
+++ b/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
@@ -1,480 +1,228 @@
-/********************************************************************************/
-/* Copyright (c) Crackerjack Project., 2007-2008 ,Hitachi, Ltd			*/
-/*	  Author(s): Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,		*/
-/*		       Yumiko Sugita <yumiko.sugita.yf@hitachi.com>,		*/
-/*		       Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>		*/
-/*										*/
-/* This program is free software;  you can redistribute it and/or modify	*/
-/* it under the terms of the GNU General Public License as published by		*/
-/* the Free Software Foundation; either version 2 of the License, or		*/
-/* (at your option) any later version.						*/
-/*										*/
-/* This program is distributed in the hope that it will be useful,		*/
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of		*/
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See			*/
-/* the GNU General Public License for more details.				*/
-/*										*/
-/* You should have received a copy of the GNU General Public License		*/
-/* along with this program;  if not, write to the Free Software			*/
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA	*/
-/* USA										*/
-/********************************************************************************/
-/************************************************************************/
-/*									*/
-/* File:	mq_timedsend01.c					*/
-/*									*/
-/* Description: This tests the mq_timedsend() syscall			*/
-/*									*/
-/* 									*/
-/*									*/
-/*									*/
-/*									*/
-/*									*/
-/* Usage:  <for command-line>						*/
-/* mq_timedsend01 [-c n] [-e][-i n] [-I x] [-p x] [-t]			*/
-/*      where,  -c n : Run n copies concurrently.			*/
-/*	      -e   : Turn on errno logging.				*/
-/*	      -i n : Execute test n times.				*/
-/*	      -I x : Execute test for x seconds.			*/
-/*	      -P x : Pause for x seconds between iterations.		*/
-/*	      -t   : Turn on syscall timing.				*/
-/*									*/
-/* Total Tests: 1							*/
-/*									*/
-/* Test Name:   mq_timedsend01						*/
-/* History:     Porting from Crackerjack to LTP is done by		*/
-/*	      Manas Kumar Nayak maknayak@in.ibm.com>			*/
-/************************************************************************/
-#include <sys/syscall.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/wait.h>
-#include <getopt.h>
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
-char *TCID = "mq_timedsend01";
-int testno;
-int TST_TOTAL = 1;
-struct sigaction act;
-
 /*
- * sighandler()
- */
-void sighandler(int sig)
-{
-	if (sig == SIGINT)
-		return;
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
-
-	/* Capture signals if any */
-	act.sa_handler = sighandler;
-	sigfillset(&act.sa_mask);
-
-	sigaction(SIGINT, &act, NULL);
-	/* Create temporary directories */
-	TEST_PAUSE;
-	tst_tmpdir();
-}
-
-/*
- * Macros
+ * Copyright (c) Crackerjack Project., 2007-2008, Hitachi, Ltd
+ * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
+ *
+ * Authors:
+ * Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,
+ * Yumiko Sugita <yumiko.sugita.yf@hitachi.com>,
+ * Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>
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
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
-#define SYSCALL_NAME    "mq_timedsend"
-
-enum test_type {
-	NORMAL,
-	FD_NONE,
-	FD_NOT_EXIST,
-	FD_FILE,
-	FULL_QUEUE,
-	SEND_SIGINT,
-};
 
-/*
- * Data Structure
- */
-struct test_case {
-	int ttype;
-	int non_block;
-	int len;
-	unsigned prio;
-	time_t sec;
-	long nsec;
-	int ret;
-	int err;
-};
+#include <errno.h>
+#include <limits.h>
 
-#define MAX_MSG	 10
-#define MAX_MSGSIZE     8192
+#include "mq_timed.h"
 
-/* Test cases
-*
-*   test status of errors on man page
-*
-*   EAGAIN	     v (would block)
-*   EBADF	      v (not a valid descriptor)
-*   EINTR	      v (interrupted by a signal)
-*   EINVAL	     v (1. invalid 'msg_prio' or
-*			 2. would block but timeout exists)
-*   EMSGSIZE	   v ('msg_len' exceeds the message size of the queue)
-*   ETIMEDOUT	  v (not block and timeout occured)
-*/
+int fd, fd_root, fd_nonblock, fd_maxint = INT_MAX - 1, fd_invalid = -1;
 
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
-	 .ttype = NORMAL,
-	 .len = MAX_MSGSIZE + 1,
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
-	 .ttype = FULL_QUEUE,
-	 .non_block = 1,
-	 .len = 16,
-	 .ret = -1,
-	 .err = EAGAIN,
-	 },
-	{			// case09
-	 .ttype = NORMAL,
-	 .len = 1,
-	 .prio = 32768,		// max priority + 1
-	 .ret = -1,
-	 .err = EINVAL,
-	 },
-	{			// case10
-	 .ttype = FULL_QUEUE,
-	 .len = 16,
-	 .sec = -1,
-	 .nsec = 0,
-	 .ret = -1,
-	 .err = EINVAL,
-	 },
-	{			// case11
-	 .ttype = FULL_QUEUE,
-	 .len = 16,
-	 .sec = 0,
-	 .nsec = -1,
-	 .ret = -1,
-	 .err = EINVAL,
-	 },
-	{			// case12
-	 .ttype = FULL_QUEUE,
-	 .len = 16,
-	 .sec = 0,
-	 .nsec = 1000000000,
-	 .ret = -1,
-	 .err = EINVAL,
-	 },
-	{			// case13
-	 .ttype = FULL_QUEUE,
-	 .len = 16,
-	 .sec = 0,
-	 .nsec = 999999999,
-	 .ret = -1,
-	 .err = ETIMEDOUT,
-	 },
-	{			// case14
-	 .ttype = SEND_SIGINT,
-	 .len = 16,
-	 .ret = -1,
-	 .sec = 3,
-	 .nsec = 0,
-	 .err = EINTR,
-	 },
+	{
+		.fd = &fd,
+		.len = 0,
+		.ret = 0,
+		.err = 0,
+	},
+	{
+		.fd = &fd,
+		.len = 1,
+		.ret = 0,
+		.err = 0,
+	},
+	{
+		.fd = &fd,
+		.len = MAX_MSGSIZE,
+		.ret = 0,
+		.err = 0,
+	},
+	{
+		.fd = &fd,
+		.len = 1,
+		.prio = MQ_PRIO_MAX - 1,
+		.ret = 0,
+		.err = 0,
+	},
+	{
+		.fd = &fd,
+		.len = MAX_MSGSIZE + 1,
+		.ret = -1,
+		.err = EMSGSIZE,
+	},
+	{
+		.fd = &fd_invalid,
+		.len = 0,
+		.ret = -1,
+		.err = EBADF,
+	},
+	{
+		.fd = &fd_maxint,
+		.len = 0,
+		.ret = -1,
+		.err = EBADF,
+	},
+	{
+		.fd = &fd_root,
+		.len = 0,
+		.ret = -1,
+		.err = EBADF,
+	},
+	{
+		.fd = &fd_nonblock,
+		.len = 16,
+		.ret = -1,
+		.err = EAGAIN,
+	},
+	{
+		.fd = &fd,
+		.len = 1,
+		.prio = MQ_PRIO_MAX,
+		.ret = -1,
+		.err = EINVAL,
+	},
+	{
+		.fd = &fd,
+		.len = 16,
+		.rq = &(struct timespec) {.tv_sec = -1, .tv_nsec = 0},
+		.send = 1,
+		.ret = -1,
+		.err = EINVAL,
+	},
+	{
+		.fd = &fd,
+		.len = 16,
+		.rq = &(struct timespec) {.tv_sec = 0, .tv_nsec = -1},
+		.send = 1,
+		.ret = -1,
+		.err = EINVAL,
+	},
+	{
+		.fd = &fd,
+		.len = 16,
+		.rq = &(struct timespec) {.tv_sec = 0, .tv_nsec = 1000000000},
+		.send = 1,
+		.ret = -1,
+		.err = EINVAL,
+	},
+	{
+		.fd = &fd,
+		.len = 16,
+		.rq = &timeout_ts,
+		.send = 1,
+		.timeout = 1,
+		.ret = -1,
+		.err = ETIMEDOUT,
+	},
+	{
+		.fd = &fd,
+		.len = 16,
+		.send = 1,
+		.signal = 1,
+		.rq = &eintr_ts,
+		.ret = -1,
+		.err = EINTR,
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
+static void do_test(unsigned int i)
 {
-	int sys_ret;
-	int sys_errno;
-	int result = RESULT_OK;
-	int oflag;
-	int i, rc, cmp_ok = 1, fd = -1;
-	char smsg[MAX_MSGSIZE], rmsg[MAX_MSGSIZE];
-	struct timespec ts = { 0, 0 };
-	pid_t pid = 0;
-	unsigned prio;
-
-	/*
-	 * When test ended with SIGTERM etc, mq descriptor is left remains.
-	 * So we delete it first.
-	 */
-	TEST(mq_unlink(QUEUE_NAME));
-
-	switch (tc->ttype) {
-	case FD_NOT_EXIST:
-		fd = INT_MAX - 1;
-		/* fallthrough */
-	case FD_NONE:
-		break;
-	case FD_FILE:
-		TEST(fd = open("/", O_RDONLY));
-		if (fd < 0) {
-			tst_resm(TFAIL, "can't open \"/\".- errno = %d : %s\n",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
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
-			tst_resm(TFAIL, "mq_open failed - errno = %d : %s\n",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-			result = 1;
-			goto EXIT;
-		}
-		if (tc->ttype == FULL_QUEUE || tc->ttype == SEND_SIGINT) {
-			for (i = 0; i < MAX_MSG; i++) {
-				TEST(rc =
-				     mq_timedsend(fd, smsg, tc->len, 0, &ts));
-				if (rc < 0) {
-					tst_resm(TFAIL,
-						 "mq_timedsend failed - errno = %d : %s\n",
-						 TEST_ERRNO,
-						 strerror(TEST_ERRNO));
-					result = 1;
-					goto EXIT;
-				}
-			}
-			if (tc->ttype == SEND_SIGINT) {
-				pid = create_sig_proc(200000, SIGINT, UINT_MAX);
-				if (pid < 0) {
-					result = 1;
-					goto EXIT;
-				}
-			}
-		}
-		break;
+	const struct test_case *tc = &tcase[i];
+	unsigned int j;
+	unsigned int prio;
+	size_t len = MAX_MSGSIZE;
+	char rmsg[len];
+	pid_t pid = -1;
+
+	if (tc->signal)
+		pid = set_sig();
+
+	if (tc->timeout)
+		set_timeout();
+
+	if (tc->send) {
+		for (j = 0; j < MSG_LENGTH; j++)
+			send_msg(*tc->fd, tc->len, tc->prio);
 	}
 
-	/*
-	 * Prepare send message
-	 */
-	for (i = 0; i < tc->len && i < sizeof(smsg); i++)
-		smsg[i] = i;
+	TEST(mq_timedsend(*tc->fd, smsg, tc->len, tc->prio, tc->rq));
 
-	/*
-	 * Set the timeout value
-	 */
-	ts.tv_sec = tc->sec;
-	ts.tv_nsec = tc->nsec;
-	if (tc->sec >= 0 || tc->nsec != 0)
-		ts.tv_sec += time(NULL);
+	if (pid > 0)
+		kill_pid(pid);
 
-	/*
-	 * Execut test system call
-	 */
-	errno = 0;
-	TEST(sys_ret = mq_timedsend(fd, smsg, tc->len, tc->prio, &ts));
-	sys_errno = errno;
-	if (sys_ret < 0)
-		goto TEST_END;
+	if (TEST_RETURN < 0) {
+		if (tc->err != TEST_ERRNO)
+			tst_res(TFAIL | TTERRNO,
+				"mq_timedsend failed unexpectedly, expected %s",
+				tst_strerrno(tc->err));
+		else
+			tst_res(TPASS | TTERRNO, "mq_timedreceive failed expectedly");
 
-	/*
-	 * Receive echoed message and compare
-	 */
-	ts.tv_sec = 0;
-	ts.tv_nsec = 0;
-	TEST(rc = mq_timedreceive(fd, rmsg, MAX_MSGSIZE, &prio, &ts));
-	if (rc < 0) {
-		tst_resm(TFAIL, "mq_timedreceive failed - errno = %d : %s\n",
-			 TEST_ERRNO, strerror(TEST_ERRNO));
-		result = 1;
-		goto EXIT;
-	}
-	if (rc != tc->len || tc->prio != prio)
-		cmp_ok = 0;
-	else {
-		for (i = 0; i < tc->len; i++)
-			if (rmsg[i] != smsg[i]) {
-				cmp_ok = 0;
-				break;
-			}
-	}
-TEST_END:
-	/*
-	 * Check results
-	 */
-	result |= (sys_errno != tc->err) || !cmp_ok;
-	PRINT_RESULT_CMP(sys_ret >= 0, tc->ret, tc->err, sys_ret, sys_errno,
-			 cmp_ok);
+		if (*tc->fd == fd)
+			cleanup_queue(fd);
 
-EXIT:
-	if (fd >= 0) {
-		TEST(close(fd));
-		TEST(mq_unlink(QUEUE_NAME));
-	}
-	if (pid > 0) {
-		int st;
-		kill(pid, SIGTERM);
-		wait(&st);
+		return;
 	}
-	return result;
-}
-
-/*
- * main()
- */
 
-int main(int ac, char **av)
-{
-	int result = RESULT_OK;
-	int i;
-	int lc;
+	TEST(mq_timedreceive(*tc->fd, rmsg, len, &prio, tc->rq));
 
-	tst_parse_opts(ac, av, NULL, NULL);
+	if (*tc->fd == fd)
+		cleanup_queue(fd);
 
-	setup();
+	if (TEST_RETURN < 0) {
+		if (tc->err != TEST_ERRNO) {
+			tst_res(TFAIL | TTERRNO,
+				"mq_timedreceive failed unexpectedly, expected %s",
+				tst_strerrno(tc->err));
+			return;
+		}
 
-	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		tst_count = 0;
-		for (testno = 0; testno < TST_TOTAL; ++testno) {
+		if (tc->ret >= 0) {
+			tst_res(TFAIL | TTERRNO, "mq_timedreceive returned %ld, expected %d",
+					TEST_RETURN, tc->ret);
+			return;
+		}
+	}
 
-			/*
-			 * Execute test
-			 */
-			for (i = 0; i < (int)ARRAY_SIZE(tcase); i++) {
-				int ret;
-				tst_resm(TINFO, "(case%02d) START", i);
-				ret = do_test(&tcase[i]);
-				tst_resm(TINFO, "(case%02d) END => %s", i,
-					 (ret == 0) ? "OK" : "NG");
-				result |= ret;
-			}
-			/*
-			 * Check results
-			 */
-			switch (result) {
-			case RESULT_OK:
-				tst_resm(TPASS, "mq_timedsend call succeeded");
-				break;
+	if (tc->len != TEST_RETURN) {
+		tst_res(TFAIL, "mq_timedreceive wrong length %ld, expected %d",
+			TEST_RETURN, tc->len);
+		return;
+	}
 
-			default:
-				tst_brkm(TFAIL | TTERRNO, cleanup,
-					 "mq_timedsend failed");
-			}
+	if (tc->prio != prio) {
+		tst_res(TFAIL, "mq_timedreceive wrong prio %d, expected %d",
+			prio, tc->prio);
+		return;
+	}
 
+	for (j = 0; j < tc->len; j++) {
+		if (rmsg[j] != smsg[j]) {
+			tst_res(TFAIL,
+				"mq_timedreceive wrong data %d in %u, expected %d",
+				rmsg[j], i, smsg[j]);
+			return;
 		}
 	}
-	cleanup();
-	tst_exit();
+
+	tst_res(TPASS, "mq_timedreceive returned %ld, priority %u, length: %lu",
+			TEST_RETURN, prio, len);
 }
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcase),
+	.test = do_test,
+	.setup = setup_common,
+	.cleanup = cleanup_common,
+	.forks_child = 1,
+};
diff --git a/testcases/kernel/syscalls/utils/mq.h b/testcases/kernel/syscalls/utils/mq.h
new file mode 100644
index 000000000..e54b2461b
--- /dev/null
+++ b/testcases/kernel/syscalls/utils/mq.h
@@ -0,0 +1,88 @@
+/*
+ * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
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
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef MQ_H
+#define MQ_H
+
+#include "tst_test.h"
+#include "tst_sig_proc.h"
+#include "tst_safe_posix_ipc.h"
+
+#define MAX_MSGSIZE	8192
+#define MSG_LENGTH	10
+#define QUEUE_NAME	"/test_mqueue"
+#define QUEUE_NAME_NONBLOCK	"/test_mqueue_nonblock"
+
+extern int fd, fd_root, fd_nonblock;
+static char smsg[MAX_MSGSIZE];
+static struct sigaction act;
+
+static void cleanup_common(void)
+{
+	if (fd_root > 0)
+		SAFE_CLOSE(fd_root);
+
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+
+	if (fd_nonblock > 0)
+		SAFE_CLOSE(fd_nonblock);
+
+	mq_unlink(QUEUE_NAME);
+	mq_unlink(QUEUE_NAME_NONBLOCK);
+}
+
+static void sighandler(int sig LTP_ATTRIBUTE_UNUSED) { }
+
+static void setup_common(void)
+{
+	int i;
+
+	act.sa_handler = sighandler;
+	sigaction(SIGINT, &act, NULL);
+
+	cleanup_common();
+
+	fd_root = SAFE_OPEN("/", O_RDONLY);
+	fd = SAFE_MQ_OPEN(QUEUE_NAME, O_CREAT | O_EXCL | O_RDWR, 0700, NULL);
+	fd_nonblock = SAFE_MQ_OPEN(QUEUE_NAME_NONBLOCK, O_CREAT | O_EXCL | O_RDWR |
+		O_NONBLOCK, 0700, NULL);
+
+	for (i = 0; i < MAX_MSGSIZE; i++)
+		smsg[i] = i;
+}
+
+static void cleanup_queue(mqd_t fd)
+{
+	int i;
+	struct mq_attr mqstat;
+	unsigned int prio;
+	char rmsg[MAX_MSGSIZE];
+
+	memset(&mqstat, 0, sizeof(mqstat));
+	if (mq_getattr(fd, &mqstat) == -1) {
+		tst_brk(TWARN, "mq_getattr() failed");
+		return;
+	}
+
+	for (i = 0; i < mqstat.mq_curmsgs; i++) {
+		tst_res(TINFO, "receive %d/%ld message", i + 1, mqstat.mq_curmsgs);
+		mq_receive(fd, rmsg, MAX_MSGSIZE, &prio);
+	}
+}
+
+#endif /* MQ_H */
diff --git a/testcases/kernel/syscalls/utils/mq_timed.h b/testcases/kernel/syscalls/utils/mq_timed.h
new file mode 100644
index 000000000..4af07e252
--- /dev/null
+++ b/testcases/kernel/syscalls/utils/mq_timed.h
@@ -0,0 +1,68 @@
+/*
+ * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
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
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef MQ_TIMED_H
+#define MQ_TIMED_H
+
+#include "mq.h"
+
+static struct timespec timeout_ts;
+static struct timespec eintr_ts;
+
+struct test_case {
+	int *fd;
+	unsigned int len;
+	unsigned int prio;
+	struct timespec *rq;
+	int invalid_msg;
+	int send;
+	int signal;
+	int timeout;
+	int ret;
+	int err;
+};
+
+static pid_t set_sig(void)
+{
+	clock_gettime(CLOCK_REALTIME, &eintr_ts);
+	eintr_ts.tv_sec += 3;
+
+	return create_sig_proc(SIGINT, 40, 200000);
+}
+
+static void set_timeout(void)
+{
+	clock_gettime(CLOCK_REALTIME, &timeout_ts);
+	timeout_ts.tv_nsec += 50000000;
+	timeout_ts.tv_sec += timeout_ts.tv_nsec / 1000000000;
+	timeout_ts.tv_nsec %= 1000000000;
+}
+
+static void send_msg(int fd, int len, int prio)
+{
+	if (mq_timedsend(fd, smsg, len, prio,
+		&((struct timespec){0})) < 0)
+		tst_brk(TBROK | TERRNO, "mq_timedsend failed");
+}
+
+static void kill_pid(pid_t pid)
+{
+	SAFE_KILL(pid, SIGTERM);
+	SAFE_WAIT(NULL);
+}
+
+#endif /* MQ_TIMED_H */
-- 
2.12.2

