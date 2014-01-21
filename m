Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1W5YCw-0007ye-Ht
	for ltp-list@lists.sourceforge.net; Tue, 21 Jan 2014 10:05:22 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1W5YCs-0002IY-A8
	for ltp-list@lists.sourceforge.net; Tue, 21 Jan 2014 10:05:22 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s0LA48w2009880
	for <ltp-list@lists.sourceforge.net>; Tue, 21 Jan 2014 18:04:08 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Tue, 21 Jan 2014 18:02:54 +0800
Message-Id: <1390298574-2966-3-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1390298574-2966-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <1390298574-2966-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH v2 3/3] fcntl/fcntl31.c: add I/O availability signals
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

create a new case to test F_GETOWN, F_SETOWN, F_GETOWN_EX,
F_SETOWN_EX, F_GETSIG, F_SETSIG for fcntl(2)

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 m4/ltp-fcntl.m4                           |  46 ++++
 runtest/ltplite                           |   1 +
 runtest/stress.part3                      |   1 +
 runtest/syscalls                          |   2 +
 testcases/kernel/syscalls/.gitignore      |   2 +
 testcases/kernel/syscalls/fcntl/fcntl31.c | 426 ++++++++++++++++++++++++++++++
 6 files changed, 478 insertions(+)
 create mode 100644 m4/ltp-fcntl.m4
 create mode 100644 testcases/kernel/syscalls/fcntl/fcntl31.c

diff --git a/m4/ltp-fcntl.m4 b/m4/ltp-fcntl.m4
new file mode 100644
index 0000000..2ec284b
--- /dev/null
+++ b/m4/ltp-fcntl.m4
@@ -0,0 +1,46 @@
+dnl
+dnl Copyright (c) 2014 Fujitsu Ltd.
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
+
+dnl
+dnl LTP_CHECK_SYSCALL_FCNTL
+dnl ----------------------------
+dnl
+AC_DEFUN([LTP_CHECK_SYSCALL_FCNTL],[dnl
+	AC_MSG_CHECKING([for fcntl f_owner_ex])
+	AC_LINK_IFELSE([AC_LANG_SOURCE([
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <unistd.h>
+#include <fcntl.h>
+int main(void) {
+	struct f_owner_ex tst_own_ex;
+	FILE *fp;
+
+	fp = tmpfile();
+	fcntl(fileno(fp), F_GETOWN_EX, &tst_own_ex);
+	return 0;
+}])],[has_f_owner_ex="yes"])
+
+if test "x$has_f_owner_ex" = xyes; then
+	AC_DEFINE(HAVE_STRUCT_F_OWNER_EX,1,[Define to 1 if you have struct f_owner_ex])
+	AC_MSG_RESULT(yes)
+else
+	AC_MSG_RESULT(no)
+fi
+])
diff --git a/runtest/ltplite b/runtest/ltplite
index 80e9527..dff3542 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -225,6 +225,7 @@ fcntl26 fcntl26
 # fcntl28 fcntl28
 fcntl29 fcntl29
 fcntl30 fcntl30
+fcntl31 fcntl31
 
 fdatasync01 fdatasync01
 fdatasync02 fdatasync02
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index d593f92..906cbdd 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -164,6 +164,7 @@ fcntl26 fcntl26
 # fcntl28 fcntl28
 fcntl29 fcntl29
 fcntl30 fcntl30
+fcntl31 fcntl31
 
 fdatasync01 fdatasync01
 fdatasync02 fdatasync02
diff --git a/runtest/syscalls b/runtest/syscalls
index eec05a9..f775a36 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -256,6 +256,8 @@ fcntl29 fcntl29
 fcntl29_64 fcntl29_64
 fcntl30 fcntl30
 fcntl30_64 fcntl30_64
+fcntl31 fcntl31
+fcntl31_64 fcntl31_64
 
 fdatasync01 fdatasync01
 fdatasync02 fdatasync02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index a5a999d..e616bdc 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -218,6 +218,8 @@
 /fcntl/fcntl29_64
 /fcntl/fcntl30
 /fcntl/fcntl30_64
+/fcntl/fcntl31
+/fcntl/fcntl31_64
 /fdatasync/fdatasync01
 /fdatasync/fdatasync02
 /flock/flock01
diff --git a/testcases/kernel/syscalls/fcntl/fcntl31.c b/testcases/kernel/syscalls/fcntl/fcntl31.c
new file mode 100644
index 0000000..5943385
--- /dev/null
+++ b/testcases/kernel/syscalls/fcntl/fcntl31.c
@@ -0,0 +1,426 @@
+/*
+ * Copyright (c) 2014 Fujitsu Ltd.
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
+static int setownex_pid_setup(void);
+static int setownex_pgrp_setup(void);
+static int setownex_tid_setup(void);
+
+static void setownex_test(void);
+static void setownex_cleanup(void);
+
+static struct f_owner_ex tst_own_ex;
+static struct f_owner_ex orig_own_ex;
+#endif
+
+static void sig_func(int signo);
+
+static void signal_parent(void);
+static void wait_io_ready(void);
+static void test_set_and_get_sig(int sig);
+
+static pid_t pid;
+static pid_t orig_pid;
+static pid_t pgrp_pid;
+
+static int test_fd;
+static int pipe_fds[2];
+static int ind;
+static int ownex_enabled;
+
+/* record the io events signal */
+static int io_signal_received;
+
+
+static struct test_case_t {
+	int cmd;
+	int (*setup)(void);
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
+	 setownex_cleanup, "F_SETOWN_EX for thread ID"},
+	{F_SETOWN_EX, setownex_pid_setup, setownex_test,
+	 setownex_cleanup, "F_SETOWN_EX for process ID"},
+	{F_SETOWN_EX, setownex_pgrp_setup, setownex_test,
+	 setownex_cleanup, "F_SETOWN_EX for process group ID"},
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
+		ind = -1;
+		for (i = 0; i < TST_TOTAL; i++) {
+			ind++;
+			if (test_cases[i].setup && test_cases[i].setup() != 0)
+				continue;
+
+			if (test_cases[i].testfunc)
+				test_cases[i].testfunc();
+
+			if (test_cases[i].cleanup)
+				test_cases[i].cleanup();
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
+	if ((tst_kvercmp(2, 6, 32)) < 0) {
+		tst_resm(TCONF, "F_GETOWN_EX and F_GETOWN_EX only run on "
+			 "kernels that are 2.6.32 and higher");
+	} else {
+		ownex_enabled = 1;
+
+		/* get original f_owner_ex info */
+		TEST(fcntl(test_fd, F_GETOWN_EX, &orig_own_ex));
+		if (TEST_RETURN < 0) {
+			tst_brkm(TFAIL | TTERRNO, cleanup,
+				 "fcntl get original f_owner_ex info failed");
+		}
+	}
+#endif
+
+	/* get original pid info */
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
+	 * just check the signal received in parent process, in case
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
+static int setownex_pid_setup(void)
+{
+	if (ownex_enabled == 0)
+		return 1;
+
+	tst_own_ex.type = F_OWNER_PID;
+	tst_own_ex.pid = pid;
+	return 0;
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
+static void setownex_cleanup(void)
+{
+	TEST(fcntl(test_fd, F_SETOWN_EX, &orig_own_ex));
+	if (TEST_RETURN < 0) {
+		tst_brkm(TFAIL | TTERRNO, cleanup,
+			 "fcntl F_SETOWN_EX restore orig_own_ex failed");
+	}
+}
+
+static int setownex_pgrp_setup(void)
+{
+	if (ownex_enabled == 0)
+		return 1;
+
+	tst_own_ex.type = F_OWNER_PGRP;
+	tst_own_ex.pid = pgrp_pid;
+	return 0;
+}
+
+static int setownex_tid_setup(void)
+{
+	pid_t tid;
+
+	if (ownex_enabled == 0)
+		return 1;
+
+	tid = syscall(__NR_gettid);
+	tst_own_ex.type = F_OWNER_TID;
+	tst_own_ex.pid = tid;
+	return 0;
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
+	wait_io_ready();
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
+static void wait_io_ready(void)
+{
+	pid_t child;
+	int i;
+
+	fflush(stdout);
+	child = FORK_OR_VFORK();
+	if (child < 0)
+		tst_brkm(TBROK | TERRNO, cleanup, "fork failed");
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
+
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
+		wait(NULL);
+	}
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+
+	if (pipe_fds[0] > 0)
+		SAFE_CLOSE(NULL, pipe_fds[0]);
+	if (pipe_fds[1] > 0)
+		SAFE_CLOSE(NULL, pipe_fds[1]);
+
+	tst_rmdir();
+}
-- 
1.8.2.1


------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
