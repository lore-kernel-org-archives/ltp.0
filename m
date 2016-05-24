From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 24 May 2016 15:51:50 +0200
Subject: [LTP] [PATCH v2] ppoll01: rewrite in new API
In-Reply-To: <d7a24122b97ae88bdeb9d864240137494d52ee0c.1464077434.git.jstancek@redhat.com>
References: <d7a24122b97ae88bdeb9d864240137494d52ee0c.1464077434.git.jstancek@redhat.com>
Message-ID: <17056974ae9a2a50c1bf2f1b977f8ed45f9061f2.1464097493.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Main differences:
- invalid address for INVALID_FDS test is -1
  0xc0000000 can be a valid address, for example a heap on s390.
  Original testcase was rarely hanging indefinitely.
- expected retcode is matched exactly, original testcase made only
  ">=0" comparison
- disabled (#if 0) test cases have been removed

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/ppoll/ppoll01.c | 549 +++++++++++++-----------------
 1 file changed, 228 insertions(+), 321 deletions(-)

Changes in v2:
- no SAFE MACROS in cleanup
- skip unlink, let tst_rmdir handle that
- close fd1 only if it has been opened

diff --git a/testcases/kernel/syscalls/ppoll/ppoll01.c b/testcases/kernel/syscalls/ppoll/ppoll01.c
index 9ebc6e261ebf..6076f166d774 100644
--- a/testcases/kernel/syscalls/ppoll/ppoll01.c
+++ b/testcases/kernel/syscalls/ppoll/ppoll01.c
@@ -1,116 +1,57 @@
-/******************************************************************************/
-/* Copyright (c) Crackerjack Project., 2007-2008 ,Hitachi, Ltd                */
-/*          Author(s): Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,	      */
-/*		       Yumiko Sugita <yumiko.sugita.yf@hitachi.com>, 	      */
-/*		       Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>	      */
-/*                                                                  	      */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/******************************************************************************/
-/******************************************************************************/
-/*                                                                            */
-/* File:        ppoll01.c                                                     */
-/*                                                                            */
-/* Description: This tests the ppoll01() syscall                              */
-/*									      */
-/* 									      */
-/*									      */
-/*									      */
-/*									      */
-/*                                                                            */
-/* Usage:  <for command-line>                                                 */
-/* ppoll01 [-c n] [-e][-i n] [-I x] [-p x] [-t]                               */
-/*      where,  -c n : Run n copies concurrently.                             */
-/*              -e   : Turn on errno logging.                                 */
-/*              -i n : Execute test n times.                                  */
-/*              -I x : Execute test for x seconds.                            */
-/*              -P x : Pause for x seconds between iterations.                */
-/*              -t   : Turn on syscall timing.                                */
-/*                                                                            */
-/* Total Tests: 1                                                             */
-/*                                                                            */
-/* Test Name:   ppoll01                                                       */
-/* History:     Porting from Crackerjack to LTP is done by                    */
-/*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
-/******************************************************************************/
+/*
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
+ */
+
 #ifndef _GNU_SOURCE
 #define _GNU_SOURCE
 #endif
 
-#include <sys/syscall.h>
-#include <sys/types.h>
-#include <sys/select.h>
-#include <sys/wait.h>
-#include <getopt.h>
-#include <string.h>
-#include <stdlib.h>
 #include <errno.h>
-#include <stdio.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <libgen.h>
-#include <limits.h>
-#include <signal.h>
 #include <poll.h>
-
-#include "../utils/include_j_h.h"
-#include "../utils/common_j_h.c"
-
-#include "ltp_signal.h"
-#include "test.h"
+#include <signal.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/wait.h>
 #include "linux_syscall_numbers.h"
+#include "ltp_signal.h"
+#include "tst_test.h"
 
 /* Older versions of glibc don't publish this constant's value. */
 #ifndef POLLRDHUP
 #define POLLRDHUP 0x2000
 #endif
 
-char *TCID = "ppoll01";
-int testno;
-int TST_TOTAL = 1;
+#define TYPE_NAME(x) .ttype = x, .desc = #x
 
-void sighandler(int sig)
-{
-	if (sig == SIGINT)
-		return;
-	else
-		tst_brkm(TBROK, NULL, "received unexpected signal %d", sig);
-}
-
-void cleanup(void)
-{
-
-	tst_rmdir();
-}
-
-void setup(void)
-{
-	tst_sig(FORK, sighandler, cleanup);
-
-	TEST_PAUSE;
-	tst_tmpdir();
-}
-
-/*
- * Macros
- */
-#define SYSCALL_NAME    "ppoll"
-
-/*
- * Global variables
- */
+struct test_case {
+	int ttype;		   /* test type (enum) */
+	const char *desc;	   /* test description (name) */
+	int ret;		   /* expected ret code */
+	int err;		   /* expected errno code */
+	short expect_revents;	   /* expected revents value */
+	unsigned int nfds;	   /* nfds ppoll parameter */
+	sigset_t *sigmask;	   /* sigmask ppoll parameter */
+	sigset_t *sigmask_cur;	   /* sigmask set for current process */
+	struct timespec *ts;	   /* ts ppoll parameter */
+	struct pollfd *fds;	   /* fds ppoll parameter */
+	int sigint_count;	   /* if > 0, spawn process to send SIGINT */
+				   /* 'count' times to current process */
+	unsigned int sigint_delay; /* delay between SIGINT signals */
+};
 
 enum test_type {
 	NORMAL,
@@ -121,18 +62,19 @@ enum test_type {
 	SEND_SIGINT_RACE_TEST,
 	INVALID_NFDS,
 	INVALID_FDS,
-	MINUS_NSEC,
-	TOO_LARGE_NSEC,
 };
 
-/*
- * Data Structure
- */
-struct test_case {
-	short expect_revents;
-	int ttype;
-	int ret;
-	int err;
+static int fd1 = -1;
+static sigset_t sigmask_empty, sigmask_sigint;
+static struct pollfd fds_good[1], fds_already_closed[1];
+
+static struct timespec ts_short = {
+	.tv_sec = 0,
+	.tv_nsec = 200000000,
+};
+static struct timespec ts_long = {
+	.tv_sec = 2,
+	.tv_nsec = 0,
 };
 
 /* Test cases
@@ -149,234 +91,199 @@ struct test_case {
  */
 
 static struct test_case tcase[] = {
-	{			// case00
-	 .ttype = NORMAL,
-	 .expect_revents = POLLIN | POLLOUT,
-	 .ret = 0,
-	 .err = 0,
-	 },
-	{			// case01
-	 .ttype = MASK_SIGNAL,
-	 .expect_revents = 0,	// don't care
-	 .ret = 0,
-	 .err = 0,
-	 },
-	{			// case02
-	 .ttype = TIMEOUT,
-	 .expect_revents = 0,	// don't care
-	 .ret = 0,
-	 .err = 0,
-	 },
-	{			// case03
-	 .ttype = FD_ALREADY_CLOSED,
-	 .expect_revents = POLLNVAL,
-	 .ret = 0,.err = 0,
-	 },
-	{			// case04
-	 .ttype = SEND_SIGINT,
-	 .ret = -1,
-	 .err = EINTR,
-	 },
-	{			// case05
-	 .ttype = SEND_SIGINT_RACE_TEST,
-	 .ret = -1,
-	 .err = EINTR,
-	 },
-	{			// case06
-	 .ttype = INVALID_NFDS,
-	 .ret = -1,
-	 .err = EINVAL,
-	 },
-	{			// case07
-	 .ttype = INVALID_FDS,
-	 .ret = -1,
-	 .err = EFAULT,},
-#if 0
-	{			// case08
-	 .ttype = MINUS_NSEC,
-	 .ret = -1,
-	 .err = EINVAL,		// RHEL4U1 + 2.6.18 returns SUCCESS
-	 },
-	{			// case09
-	 .ttype = TOO_LARGE_NSEC,
-	 .ret = -1,
-	 .err = EINVAL,		// RHEL4U1 + 2.6.18 returns SUCCESS
-	 },
-#endif
+	{
+		TYPE_NAME(NORMAL),
+		.expect_revents = POLLIN | POLLOUT,
+		.ret = 1,
+		.err = 0,
+		.nfds = 1,
+		.ts = &ts_long,
+		.fds = fds_good,
+	},
+	{
+		TYPE_NAME(MASK_SIGNAL),
+		.ret = 0,
+		.err = 0,
+		.nfds = 0,
+		.sigmask = &sigmask_sigint,
+		.ts = &ts_short,
+		.fds = fds_good,
+		.sigint_count = 4,
+		.sigint_delay = 100000,
+	},
+	{
+		TYPE_NAME(TIMEOUT),
+		.ret = 0,
+		.err = 0,
+		.nfds = 0,
+		.ts = &ts_short,
+		.fds = fds_good,
+	},
+	{
+		TYPE_NAME(FD_ALREADY_CLOSED),
+		.expect_revents = POLLNVAL,
+		.ret = 1,
+		.err = 0,
+		.nfds = 1,
+		.ts = &ts_long,
+		.fds = fds_already_closed,
+	},
+	{
+		TYPE_NAME(SEND_SIGINT),
+		.ret = -1,
+		.err = EINTR,
+		.nfds = 0,
+		.ts = &ts_long,
+		.fds = fds_good,
+		.sigint_count = 40,
+		.sigint_delay = 100000,
+	},
+	{
+		TYPE_NAME(SEND_SIGINT_RACE_TEST),
+		.ret = -1,
+		.err = EINTR,
+		.nfds = 0,
+		.sigmask = &sigmask_empty,
+		.sigmask_cur = &sigmask_sigint,
+		.ts = &ts_long,
+		.fds = fds_good,
+		.sigint_count = 1,
+		.sigint_delay = 0,
+	},
+	{
+		TYPE_NAME(INVALID_NFDS),
+		.ret = -1,
+		.err = EINVAL,
+		.nfds = -1,
+		.ts = &ts_long,
+		.fds = fds_good,
+	},
+	{
+		TYPE_NAME(INVALID_FDS),
+		.ret = -1,
+		.err = EFAULT,
+		.nfds = 1,
+		.ts = &ts_long,
+		.fds = (struct pollfd *) -1,
+	},
 };
 
-#define NUM_TEST_FDS    1
+static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
+{
+}
+
+static void setup(void)
+{
+	int fd2;
+
+	SAFE_SIGNAL(SIGINT, sighandler);
+
+	if (sigemptyset(&sigmask_empty) == -1)
+		tst_brk(TBROK | TERRNO, "sigemptyset");
+	if (sigemptyset(&sigmask_sigint) == -1)
+		tst_brk(TBROK | TERRNO, "sigemptyset");
+	if (sigaddset(&sigmask_sigint, SIGINT) == -1)
+		tst_brk(TBROK | TERRNO, "sigaddset");
+
+	fd1 = SAFE_OPEN("testfile1", O_CREAT | O_EXCL | O_RDWR,
+		S_IRUSR | S_IWUSR);
+	fds_good[0].fd = fd1;
+	fds_good[0].events = POLLIN | POLLPRI | POLLOUT | POLLRDHUP;
+	fds_good[0].revents = 0;
+
+	fd2 = SAFE_OPEN("testfile2", O_CREAT | O_EXCL | O_RDWR,
+		S_IRUSR | S_IWUSR);
+	fds_already_closed[0].fd = fd2;
+	fds_already_closed[0].events = POLLIN | POLLPRI | POLLOUT | POLLRDHUP;
+	fds_already_closed[0].revents = 0;
+	SAFE_CLOSE(fd2);
+}
+
+static void cleanup(void)
+{
+	if (fd1 != -1)
+		close(fd1);
+}
+
+static pid_t create_sig_proc(int sig, int count, unsigned int usec)
+{
+	pid_t pid, cpid;
+
+	pid = getpid();
+	cpid = SAFE_FORK();
+
+	if (cpid == 0) {
+		while (count-- > 0) {
+			usleep(usec);
+			if (kill(pid, sig) == -1)
+				break;
+		}
+		exit(0);
+	}
 
-/*
- * do_test()
- *
- *   Input  : TestCase Data
- *   Return : RESULT_OK(0), RESULT_NG(1)
- *
- */
+	return cpid;
+}
 
-static int do_test(struct test_case *tc)
+static void do_test(unsigned int i)
 {
-	int sys_ret, sys_errno;
-	int result = RESULT_OK;
-	int fd = -1, cmp_ok = 1;
-	char fpath[PATH_MAX];
-	struct pollfd *p_fds, fds[NUM_TEST_FDS];
-	unsigned int nfds = NUM_TEST_FDS;
-	struct timespec *p_ts, ts;
-	sigset_t *p_sigmask, sigmask;
 	pid_t pid = 0;
+	int sys_ret, sys_errno = 0, dummy;
+	struct test_case *tc = &tcase[i];
 
-	TEST(fd = setup_file(".", "test.file", fpath));
-	if (fd < 0)
-		return 1;
-	fds[0].fd = fd;
-	fds[0].events = POLLIN | POLLPRI | POLLOUT | POLLRDHUP;
-	fds[0].revents = 0;
-	p_fds = fds;
-	p_ts = NULL;
-	p_sigmask = NULL;
+	tst_res(TINFO, "case %s", tc->desc);
 
-	switch (tc->ttype) {
-	case TIMEOUT:
-		nfds = 0;
-		ts.tv_sec = 0;
-		ts.tv_nsec = 50000000;	// 50msec
-		p_ts = &ts;
-		break;
-	case FD_ALREADY_CLOSED:
-		TEST(close(fd));
-		fd = -1;
-		TEST(cleanup_file(fpath));
-		break;
-	case MASK_SIGNAL:
-		TEST(sigemptyset(&sigmask));
-		TEST(sigaddset(&sigmask, SIGINT));
-		p_sigmask = &sigmask;
-		nfds = 0;
-		ts.tv_sec = 0;
-		ts.tv_nsec = 300000000;	// 300msec => need to be enough for
-		//   waiting the signal
-		p_ts = &ts;
-		// fallthrough
-	case SEND_SIGINT:
-		nfds = 0;
-		pid = create_sig_proc(100000, SIGINT, UINT_MAX);	// 100msec
-		if (pid < 0)
-			return 1;
-		break;
-	case SEND_SIGINT_RACE_TEST:
-		/* block the INT signal */
-		sigemptyset(&sigmask);
-		sigaddset(&sigmask, SIGINT);
-		sigprocmask(SIG_SETMASK, &sigmask, NULL);
-
-		/* and let it be unblocked when the syscall runs */
-		sigemptyset(&sigmask);
-		p_sigmask = &sigmask;
-		nfds = 0;
-		ts.tv_sec = 0;
-		ts.tv_nsec = 300000000;	// 300msec => need to be enough for
-		//   waiting the signal
-		p_ts = &ts;
-		nfds = 0;
-		pid = create_sig_proc(0, SIGINT, 1);
-		if (pid < 0) {
-			result = 1;
-			goto cleanup;
-		}
-		break;
-	case INVALID_NFDS:
-		//nfds = RLIMIT_NOFILE + 1; //==> RHEL4U1 + 2.6.18 returns SUCCESS
-		nfds = -1;
-		break;
-	case INVALID_FDS:
-		p_fds = (void *)0xc0000000;
-		break;
-	case MINUS_NSEC:
-		ts.tv_sec = 0;
-		ts.tv_nsec = -1;
-		p_ts = &ts;
-		break;
-	case TOO_LARGE_NSEC:
-		ts.tv_sec = 0;
-		ts.tv_nsec = 1000000000;
-		p_ts = &ts;
-		break;
+	/* setup */
+	if (tc->sigmask_cur) {
+	       if (sigprocmask(SIG_SETMASK, tc->sigmask_cur, NULL) == -1)
+			tst_brk(TBROK, "sigprocmask");
+	}
+	if (tc->sigint_count > 0) {
+		pid = create_sig_proc(SIGINT, tc->sigint_count,
+			tc->sigint_delay);
 	}
 
-	/*
-	 * Execute system call
-	 */
-	errno = 0;
-	sys_ret = ltp_syscall(__NR_ppoll, p_fds, nfds, p_ts, p_sigmask,
-		SIGSETSIZE);
+	/* test */
+	sys_ret = tst_syscall(__NR_ppoll, tc->fds, tc->nfds, tc->ts,
+		tc->sigmask, SIGSETSIZE);
 	sys_errno = errno;
-	if (sys_ret <= 0 || tc->ret < 0)
-		goto TEST_END;
 
-	cmp_ok = fds[0].revents == tc->expect_revents;
-	tst_resm(TINFO, "EXPECT: revents=0x%04x", tc->expect_revents);
-	tst_resm(TINFO, "RESULT: revents=0x%04x", fds[0].revents);
-
-TEST_END:
-	/*
-	 * Check results
-	 */
-	if (tc->ttype == SEND_SIGINT_RACE_TEST) {
-		int sig;
-		sigprocmask(SIG_SETMASK, NULL, &sigmask);
-		for (sig = 1; sig < SIGRTMAX; sig++) {
-			TEST(sigismember(&sigmask, sig));
-			if (TEST_RETURN < 0 && TEST_ERRNO == EINVAL
-			    && sig != SIGINT)
-				continue;	/* let's ignore errors if they are for other signal than SIGINT that we set */
-			if ((sig == SIGINT) != (TEST_RETURN != 0)) {
-				tst_resm(TFAIL,
-					 "Bad value of signal mask, signal %d is %s",
-					 sig, TEST_RETURN ? "on" : "off");
-				cmp_ok |= 1;
-			}
-		}
-	}
-	result |= (sys_errno != tc->err) || !cmp_ok;
-	PRINT_RESULT_CMP(sys_ret >= 0, tc->ret, tc->err, sys_ret, sys_errno,
-			 cmp_ok);
-cleanup:
-	if (fd >= 0) {
-		close(fd);
-		cleanup_file(fpath);
+	/* cleanup */
+	if (tc->sigmask_cur) {
+		if (sigprocmask(SIG_SETMASK, &sigmask_empty, NULL) == -1)
+			tst_brk(TBROK, "sigprocmask");
 	}
-
-	sigemptyset(&sigmask);
-	sigprocmask(SIG_SETMASK, &sigmask, NULL);
 	if (pid > 0) {
-		int st;
 		kill(pid, SIGTERM);
-		wait(&st);
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
-	int i;
-	int ret;
-
-	setup();
 
-	ret = 0;
-
-	for (i = 0; ret == 0 && i < (sizeof(tcase) / sizeof(tcase[0])); i++) {
-		tst_resm(TINFO, "(case%02d) START", i);
-		ret = do_test(&tcase[i]);
-		tst_resm(TINFO, "(case%02d) END => %s", i, (ret == 0) ? "OK"
-			 : "NG");
+	/* result check */
+	if (tc->expect_revents) {
+		if (tc->fds[0].revents == tc->expect_revents)
+			tst_res(TPASS, "revents=0x%04x", tc->expect_revents);
+		else
+			tst_res(TFAIL, "revents=0x%04x, expected=0x%04x",
+				tc->fds[0].revents, tc->expect_revents);
+	}
+	if (tc->ret >= 0 && tc->ret == sys_ret) {
+		tst_res(TPASS, "ret: %d", sys_ret);
+	} else if (tc->ret == -1 && sys_ret == -1 && sys_errno == tc->err) {
+		tst_res(TPASS, "ret: %d, errno: %s (%d)", sys_ret,
+			tst_strerrno(sys_errno), sys_errno);
+	} else {
+		tst_res(TFAIL, "ret: %d, exp: %d, ret_errno: %s (%d),"
+			" exp_errno: %s (%d)", tc->ret, sys_ret,
+			tst_strerrno(sys_errno), sys_errno,
+			tst_strerrno(tc->err), tc->err);
 	}
-	cleanup();
-	tst_exit();
 }
+
+static struct tst_test test = {
+	.tid = "ppoll01",
+	.tcnt = ARRAY_SIZE(tcase),
+	.test = do_test,
+	.setup = setup,
+	.cleanup = cleanup,
+	.forks_child = 1,
+	.needs_tmpdir = 1,
+};
-- 
1.8.3.1

