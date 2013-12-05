Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1VoPzF-0000An-JK
	for ltp-list@lists.sourceforge.net; Thu, 05 Dec 2013 03:52:25 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VoPzD-0000XN-Fe
	for ltp-list@lists.sourceforge.net; Thu, 05 Dec 2013 03:52:25 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id rB53qGf0031439
	for <ltp-list@lists.sourceforge.net>; Thu, 5 Dec 2013 11:52:16 +0800
Message-ID: <529FF868.9060803@cn.fujitsu.com>
Date: Thu, 05 Dec 2013 11:52:08 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 3/3] fcntl/fcntl31.c: add I/O availability signals
 test for fcntl(2)
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


create a new case to test F_GETOWN, F_SETOWN, F_GETOWN_EX,
F_SETOWN_EX, F_GETSIG, F_SETSIG for fcntl(2)

Signed-off-by: XIAOGUANG WANG <wangxg.fnst@cn.fujitsu.com>
---
 configure.ac                              |   1 +
 m4/ltp-fcntl.m4                           |  28 +++
 runtest/syscalls                          |   2 +
 testcases/kernel/syscalls/fcntl/fcntl31.c | 405 ++++++++++++++++++++++++++++++
 4 files changed, 436 insertions(+)
 create mode 100644 m4/ltp-fcntl.m4
 create mode 100644 testcases/kernel/syscalls/fcntl/fcntl31.c

diff --git a/configure.ac b/configure.ac
index 4846afd..0b8eb29 100644
--- a/configure.ac
+++ b/configure.ac
@@ -170,5 +170,6 @@ LTP_CHECK_FS_IOC_FLAGS
 LTP_CHECK_MREMAP_FIXED
 LTP_CHECK_KERNEL_DEVEL
 LTP_CHECK_XFS_QUOTACTL
+LTP_CHECK_FCNTL
 
 AC_OUTPUT
diff --git a/m4/ltp-fcntl.m4 b/m4/ltp-fcntl.m4
new file mode 100644
index 0000000..b14eeb9
--- /dev/null
+++ b/m4/ltp-fcntl.m4
@@ -0,0 +1,28 @@
+dnl
+dnl Copyright (c) 2013 Fujitsu Ltd.
+dnl Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
+dnl
+dnl This program is free software;  you can redistribute it and/or modify
+dnl it under the terms of the GNU General Public License as published by
+dnl the Free Software Foundation; either version 2 of the License, or
+dnl (at your option) any later version.
+dnl
+dnl This program is distributed in the hope that it will be useful,
+dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
+dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+dnl the GNU General Public License for more details.
+dnl
+dnl You should have received a copy of the GNU General Public License
+dnl along with this program;  if not, write to the Free Software
+dnl Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+dnl
+dnl
+
+dnl
+dnl LTP_CHECK_FCNTL
+dnl ----------------------------
+dnl
+AC_DEFUN([LTP_CHECK_FCNTL],
+[dnl
+AC_CHECK_TYPES([struct f_owner_ex],[],[],[#include <asm-generic/fcntl.h>])
+])dnl
diff --git a/runtest/syscalls b/runtest/syscalls
index 489f318..36d7aa4 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -255,6 +255,8 @@ fcntl29 fcntl29
 fcntl29_64 fcntl29_64
 fcntl30 fcntl30
 fcntl30_64 fcntl30_64
+fcntl31 fcntl31
+fcntl31_64 fcntl31_64
 
 fdatasync01 fdatasync01
 fdatasync02 fdatasync02
diff --git a/testcases/kernel/syscalls/fcntl/fcntl31.c b/testcases/kernel/syscalls/fcntl/fcntl31.c
new file mode 100644
index 0000000..f64ee88
--- /dev/null
+++ b/testcases/kernel/syscalls/fcntl/fcntl31.c
@@ -0,0 +1,405 @@
+/*
+ * Copyright (c) 2013 Fujitsu Ltd.
+ * Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+/*
+ * Description:
+ * Verify that:
+ *     Basic test for fcntl(2) using F_GETOWN, F_SETOWN, F_GETOWN_EX,
+ *     F_SETOWN_EX, F_GETSIG, F_SETSIG argument.
+ */
+
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <string.h>
+#include <signal.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <pwd.h>
+#include <sched.h>
+
+#include "test.h"
+#include "config.h"
+#include "usctest.h"
+#include "linux_syscall_numbers.h"
+#include "safe_macros.h"
+
+
+static void setup(void);
+static void cleanup(void);
+
+static void setown_pid_test(void);
+static void setown_pgrp_test(void);
+
+static void set_get_own_cleanup(void);
+
+#if defined(HAVE_STRUCT_F_OWNER_EX)
+static void setownex_pid_setup(void);
+static void setownex_pgrp_setup(void);
+static void setownex_tid_setup(void);
+
+static void setownex_test(void);
+
+static void set_get_ownex_cleanup(void);
+
+static struct f_owner_ex tst_own_ex;
+static struct f_owner_ex orig_own_ex;
+#endif
+
+static void sig_func(int signo);
+
+static void signal_parent(void);
+static void wait_io_ready_signal(void);
+static void test_set_and_get_sig(int sig);
+
+static pid_t pid;
+static pid_t orig_pid;
+static pid_t pgrp_pid;
+
+static int test_fd;
+static int pipe_fds[2];
+static int ind;
+
+/* record the io events signal */
+static int io_signal_received;
+
+
+static struct test_case_t {
+	int cmd;
+	void (*setup)(void);
+	void (*testfunc)(void);
+	void (*cleanup)(void);
+	char *des;
+} test_cases[] = {
+	{F_SETOWN, NULL, setown_pid_test, set_get_own_cleanup,
+	 "F_SETOWN for process ID"},
+	{F_SETOWN, NULL, setown_pgrp_test, set_get_own_cleanup,
+	 "F_SETOWN for process group ID"},
+#if defined(HAVE_STRUCT_F_OWNER_EX)
+	{F_SETOWN_EX, setownex_tid_setup, setownex_test,
+	 set_get_ownex_cleanup, "F_SETOWN_EX for thread ID"},
+	{F_SETOWN_EX, setownex_pid_setup, setownex_test,
+	 set_get_ownex_cleanup, "F_SETOWN_EX for process ID"},
+	{F_SETOWN_EX, setownex_pgrp_setup, setownex_test,
+	 set_get_ownex_cleanup, "F_SETOWN_EX for process group ID"},
+#endif
+};
+
+char *TCID = "fcntl31";
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+
+
+int main(int ac, char **av)
+{
+	int lc;
+	char *msg;
+	int i;
+
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		ind = 0;
+		for (i = 0; i < TST_TOTAL; i++) {
+			if (test_cases[i].setup)
+				test_cases[i].setup();
+
+			if (test_cases[i].testfunc)
+				test_cases[i].testfunc();
+
+			if (test_cases[i].cleanup)
+				test_cases[i].cleanup();
+			ind++;
+		}
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	int ret;
+
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+
+	tst_tmpdir();
+
+	TEST_PAUSE;
+
+	/* we have the tests on pipe */
+	SAFE_PIPE(cleanup, pipe_fds);
+	test_fd = pipe_fds[0];
+	if (fcntl(test_fd, F_SETFL, O_ASYNC) < 0)
+		tst_brkm(TBROK | TERRNO, cleanup, "fcntl set O_ASYNC failed");
+
+	pid = getpid();
+
+	ret = setpgrp();
+	if (ret < 0)
+		tst_brkm(TBROK | TERRNO, cleanup, "setpgrp() failed");
+	pgrp_pid = getpgid(0);
+	if (pgrp_pid < 0)
+		tst_brkm(TBROK | TERRNO, cleanup, "getpgid() failed");
+
+#if defined(HAVE_STRUCT_F_OWNER_EX)
+	/* get original f_owner_ex info*/
+	TEST(fcntl(test_fd, F_GETOWN_EX, &orig_own_ex));
+	if (TEST_RETURN < 0) {
+		tst_brkm(TFAIL | TTERRNO, cleanup,
+			 "fcntl get original f_owner_ex info failed");
+	}
+#endif
+
+	/* get original pid info*/
+	TEST(fcntl(test_fd, F_GETOWN));
+	if (TEST_RETURN < 0) {
+		tst_brkm(TFAIL | TTERRNO, cleanup,
+			 "fcntl get original pid info failed");
+	}
+	orig_pid = TEST_RETURN;
+
+	if (signal(SIGIO, sig_func) == SIG_ERR) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "set signal handler for SIGIO failed");
+	}
+	if (signal(SIGUSR1, sig_func) == SIG_ERR) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "set signal handler for SIGUSR1 failed");
+	}
+}
+
+static void sig_func(int signo)
+{
+	int ret;
+	pid_t signaled_pid;
+	char c;
+
+	signaled_pid = getpid();
+
+	/*
+	 * just check the signal received in parent process in case
+	 * signal is sent to a process group.
+	 */
+	if (signaled_pid != pid)
+		return;
+
+	switch (signo) {
+	case SIGUSR1:
+		io_signal_received = SIGUSR1;
+	break;
+	case SIGIO:
+		io_signal_received = SIGIO;
+	}
+
+	ret = read(pipe_fds[0], &c, 1);
+	if (ret < 0)
+		tst_resm(TINFO, "no data is read");
+}
+
+static void setown_pid_test(void)
+{
+	TEST(fcntl(test_fd, F_SETOWN, pid));
+	if (TEST_RETURN < 0) {
+		tst_brkm(TFAIL | TTERRNO, cleanup,
+			 "fcntl F_SETOWN set process id failed");
+	}
+	test_set_and_get_sig(SIGUSR1);
+}
+
+static void setown_pgrp_test(void)
+{
+	TEST(fcntl(test_fd, F_SETOWN, -pgrp_pid));
+	if (TEST_RETURN < 0) {
+		tst_brkm(TFAIL | TTERRNO, cleanup,
+			 "fcntl F_SETOWN set process group id failed");
+	}
+	test_set_and_get_sig(SIGUSR1);
+}
+
+static void set_get_own_cleanup(void)
+{
+	TEST(fcntl(test_fd, F_SETOWN, orig_pid));
+	if (TEST_RETURN < 0) {
+		tst_brkm(TFAIL | TTERRNO, cleanup,
+			 "fcntl F_SETOWN restore orig_pid failed");
+	}
+}
+
+#if defined(HAVE_STRUCT_F_OWNER_EX)
+static void setownex_pid_setup(void)
+{
+	tst_own_ex.type = F_OWNER_PID;
+	tst_own_ex.pid = pid;
+}
+
+static void setownex_test(void)
+{
+	TEST(fcntl(test_fd, F_SETOWN_EX, &tst_own_ex));
+	if (TEST_RETURN < 0) {
+		tst_brkm(TFAIL | TTERRNO, cleanup,
+			 "fcntl F_SETOWN_EX failed");
+	}
+	test_set_and_get_sig(SIGUSR1);
+}
+
+static void set_get_ownex_cleanup(void)
+{
+	TEST(fcntl(test_fd, F_SETOWN_EX, &orig_own_ex));
+	if (TEST_RETURN < 0) {
+		tst_brkm(TFAIL | TTERRNO, cleanup,
+			 "fcntl F_SETOWN_EX restore orig_own_ex failed");
+	}
+}
+
+static void setownex_pgrp_setup(void)
+{
+	tst_own_ex.type = F_OWNER_PGRP;
+	tst_own_ex.pid = pgrp_pid;
+}
+
+static void setownex_tid_setup(void)
+{
+	pid_t tid;
+
+	tid = syscall(__NR_gettid);
+	tst_own_ex.type = F_OWNER_TID;
+	tst_own_ex.pid = tid;
+}
+#endif
+
+static void test_set_and_get_sig(int sig)
+{
+	int orig_sig;
+
+	TEST(fcntl(test_fd, F_GETSIG));
+	if (TEST_RETURN < 0) {
+		tst_brkm(TFAIL | TTERRNO, cleanup,
+			 "fcntl(fd, F_GETSIG) get orig_sig failed");
+	}
+	orig_sig = TEST_RETURN;
+
+	if (orig_sig == 0 || orig_sig == SIGIO)
+		tst_resm(TINFO, "default io events signal is SIGIO");
+
+	TEST(fcntl(test_fd, F_SETSIG, sig));
+	if (TEST_RETURN < 0) {
+		tst_brkm(TFAIL | TTERRNO, cleanup,
+			 "fcntl(fd, F_SETSIG, SIG: %d) failed", sig);
+	}
+
+	TEST(fcntl(test_fd, F_GETSIG));
+	if (TEST_RETURN < 0) {
+		tst_brkm(TFAIL | TTERRNO, cleanup,
+			 "fcntl(fd, F_GETSIG) get the set signal failed");
+	}
+	if (TEST_RETURN != sig) {
+		tst_brkm(TFAIL | TTERRNO, cleanup,
+			 "fcntl F_SETSIG set SIG: %d failed", sig);
+	}
+
+	wait_io_ready_signal();
+
+	/* restore the default signal*/
+	TEST(fcntl(test_fd, F_SETSIG, orig_sig));
+	if (TEST_RETURN < 0) {
+		tst_brkm(TFAIL | TTERRNO, cleanup,
+			 "fcntl restore default signal failed");
+	}
+}
+
+static void signal_parent(void)
+{
+	int ret, fd;
+
+	fd = pipe_fds[1];
+	close(pipe_fds[0]);
+
+	ret = write(fd, "c", 1);
+
+	switch (ret) {
+	case 0:
+		fprintf(stderr, "No data written, something is wrong");
+	break;
+	case -1:
+		fprintf(stderr, "Failed to write to pipe: %s\n",
+			strerror(errno));
+	}
+
+	close(fd);
+	return;
+}
+
+static void wait_io_ready_signal(void)
+{
+	pid_t child;
+	int i;
+	int status;
+
+	fflush(stdout);
+	child = FORK_OR_VFORK();
+	if (child < 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "fork failed");
+
+	if (child == 0) {
+		signal_parent();
+		exit(0);
+	} else {
+		/*
+		 * if io_signal_received is not changed by signal handler
+		 * in 5 seconds, consider the test failed.
+		 */
+		for (i = 0; i < 1000; i++) {
+			/* SIGUSR1 or SIGIO is received*/
+			if (io_signal_received > 0)
+				break;
+			sched_yield();
+			usleep(5000);
+		}
+		switch (io_signal_received) {
+		case SIGUSR1:
+			tst_resm(TPASS, "fcntl test %s success",
+				 test_cases[ind].des);
+		break;
+		case SIGIO:
+			tst_resm(TFAIL, "received default SIGIO, fcntl test "
+				 "%s failed", test_cases[ind].des);
+		break;
+		default:
+			tst_brkm(TBROK, cleanup, "fcntl io events "
+				 "signal mechanism work abnormally");
+		}
+		io_signal_received = 0;
+		wait(&status);
+	}
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+
+	SAFE_CLOSE(NULL, pipe_fds[0]);
+	SAFE_CLOSE(NULL, pipe_fds[1]);
+
+	tst_rmdir();
+}
-- 
1.8.2.1


------------------------------------------------------------------------------
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
