Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WKivF-00032W-NV
	for ltp-list@lists.sourceforge.net; Tue, 04 Mar 2014 06:33:49 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WKivD-00018Y-ET
	for ltp-list@lists.sourceforge.net; Tue, 04 Mar 2014 06:33:49 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s246Xc65032000
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Mar 2014 14:33:39 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Tue, 4 Mar 2014 14:31:58 +0800
Message-Id: <1393914721-5288-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1393914721-5288-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <1393914721-5288-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH 1/4] fcntl/fcntl31.c: add I/O availability signals
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
 configure.ac                              |   1 +
 m4/ltp-fcntl.m4                           |  40 +++
 runtest/ltplite                           |   1 +
 runtest/stress.part3                      |   1 +
 runtest/syscalls                          |   2 +
 testcases/kernel/syscalls/.gitignore      |   2 +
 testcases/kernel/syscalls/fcntl/fcntl31.c | 389 ++++++++++++++++++++++++++++++
 7 files changed, 436 insertions(+)
 create mode 100644 m4/ltp-fcntl.m4
 create mode 100644 testcases/kernel/syscalls/fcntl/fcntl31.c

diff --git a/configure.ac b/configure.ac
index ea6fa85..59460b1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -172,5 +172,6 @@ LTP_CHECK_XFS_QUOTACTL
 LTP_CHECK_CLONE_SUPPORTS_7_ARGS
 LTP_CHECK_MKDIRAT
 LTP_CHECK_FCHOWNAT
+LTP_CHECK_FCNTL
 
 AC_OUTPUT
diff --git a/m4/ltp-fcntl.m4 b/m4/ltp-fcntl.m4
new file mode 100644
index 0000000..9a27fb7
--- /dev/null
+++ b/m4/ltp-fcntl.m4
@@ -0,0 +1,40 @@
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
+dnl LTP_CHECK_FCNTL
+dnl ----------------------------
+dnl
+AC_DEFUN([LTP_CHECK_FCNTL],[dnl
+	AC_MSG_CHECKING([for fcntl f_owner_ex])
+	AC_COMPILE_IFELSE([AC_LANG_SOURCE([
+#define _GNU_SOURCE
+#include <fcntl.h>
+int main(void) {
+	struct f_owner_ex tst_own_ex;
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
index f7127fe..7d78775 100644
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
index 2f31e93..cd49bf1 100644
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
index 9099257..7031c41 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -257,6 +257,8 @@ fcntl29 fcntl29
 fcntl29_64 fcntl29_64
 fcntl30 fcntl30
 fcntl30_64 fcntl30_64
+fcntl31 fcntl31
+fcntl31_64 fcntl31_64
 
 fdatasync01 fdatasync01
 fdatasync02 fdatasync02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index b1d4b15..dc380e3 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -214,6 +214,8 @@
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
index 0000000..6700708
--- /dev/null
+++ b/testcases/kernel/syscalls/fcntl/fcntl31.c
@@ -0,0 +1,389 @@
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
+#if defined(HAVE_STRUCT_F_OWNER_EX)
+static int ownex_enabled;
+static char *ownex_tconf_msg = "F_GETOWN_EX and F_SETOWN_EX only run on "
+			"kernels that are 2.6.32 and higher";
+static void setownex_tid_test(void);
+static void setownex_pid_test(void);
+static void setownex_pgrp_test(void);
+
+static struct f_owner_ex orig_own_ex;
+#endif
+
+static void signal_parent(void);
+static void check_io_signal(char *des);
+static void test_set_and_get_sig(int sig, char *des);
+
+static pid_t pid;
+static pid_t orig_pid;
+static pid_t pgrp_pid;
+
+static struct timespec timeout;
+static sigset_t newset, oldset;
+
+static int test_fd;
+static int pipe_fds[2];
+
+static void (*testfunc[])(void) = {
+	setown_pid_test, setown_pgrp_test,
+#if defined(HAVE_STRUCT_F_OWNER_EX)
+	setownex_tid_test, setownex_pid_test, setownex_pgrp_test
+#endif
+};
+
+char *TCID = "fcntl31";
+int TST_TOTAL = ARRAY_SIZE(testfunc);
+
+
+int main(int ac, char **av)
+{
+	int lc, i;
+	char *msg;
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
+		for (i = 0; i < TST_TOTAL; i++)
+			(*testfunc[i])();
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
+	TEST_PAUSE;
+
+	/* we have these tests on pipe */
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
+	if ((tst_kvercmp(2, 6, 32)) >= 0) {
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
+	sigemptyset(&newset);
+	sigaddset(&newset, SIGUSR1);
+	sigaddset(&newset, SIGIO);
+
+	if (sigprocmask(SIG_SETMASK, &newset, &oldset) < 0)
+		tst_brkm(TBROK | TERRNO, cleanup, "sigprocmask failed");
+
+	timeout.tv_sec = 5;
+	timeout.tv_nsec = 0;
+}
+
+static void setown_pid_test(void)
+{
+	TEST(fcntl(test_fd, F_SETOWN, pid));
+	if (TEST_RETURN < 0) {
+		tst_brkm(TFAIL | TTERRNO, cleanup,
+			 "fcntl(F_SETOWN) set process id failed");
+	}
+	test_set_and_get_sig(SIGUSR1, "F_GETOWN, F_SETOWN for process ID");
+
+	TEST(fcntl(test_fd, F_SETOWN, orig_pid));
+	if (TEST_RETURN < 0) {
+		tst_brkm(TFAIL | TTERRNO, cleanup,
+			 "fcntl(F_SETOWN) restore orig_pid failed");
+	}
+}
+
+static void setown_pgrp_test(void)
+{
+	TEST(fcntl(test_fd, F_SETOWN, -pgrp_pid));
+	if (TEST_RETURN < 0) {
+		tst_brkm(TFAIL | TTERRNO, cleanup,
+			 "fcntl(F_SETOWN) set process group id failed");
+	}
+	test_set_and_get_sig(SIGUSR1,
+			     "F_GETOWN, F_SETOWN for process group ID");
+
+	TEST(fcntl(test_fd, F_SETOWN, orig_pid));
+	if (TEST_RETURN < 0) {
+		tst_brkm(TFAIL | TTERRNO, cleanup,
+			 "fcntl(F_SETOWN) restore orig_pid failed");
+	}
+}
+
+#if defined(HAVE_STRUCT_F_OWNER_EX)
+static void setownex_cleanup(void)
+{
+	TEST(fcntl(test_fd, F_SETOWN_EX, &orig_own_ex));
+	if (TEST_RETURN < 0) {
+		tst_brkm(TFAIL | TTERRNO, cleanup,
+			 "fcntl F_SETOWN_EX restore orig_own_ex failed");
+	}
+}
+
+static void setownex_tid_test(void)
+{
+	struct f_owner_ex tst_own_ex;
+
+	if (ownex_enabled == 0) {
+		tst_resm(TCONF, ownex_tconf_msg);
+		return;
+	}
+
+	tst_own_ex.type = F_OWNER_TID;
+	tst_own_ex.pid = ltp_syscall(__NR_gettid);
+
+	TEST(fcntl(test_fd, F_SETOWN_EX, &tst_own_ex));
+	if (TEST_RETURN < 0) {
+		tst_brkm(TFAIL | TTERRNO, cleanup,
+			 "fcntl F_SETOWN_EX failed");
+	}
+	test_set_and_get_sig(SIGUSR1, "F_GETOWN_EX, F_SETOWN_EX for thread ID");
+
+	setownex_cleanup();
+}
+
+static void setownex_pid_test(void)
+{
+	struct f_owner_ex tst_own_ex;
+
+	if (ownex_enabled == 0) {
+		tst_resm(TCONF, ownex_tconf_msg);
+		return;
+	}
+
+	tst_own_ex.type = F_OWNER_PID;
+	tst_own_ex.pid = pid;
+
+	TEST(fcntl(test_fd, F_SETOWN_EX, &tst_own_ex));
+	if (TEST_RETURN < 0) {
+		tst_brkm(TFAIL | TTERRNO, cleanup,
+			 "fcntl F_SETOWN_EX failed");
+	}
+	test_set_and_get_sig(SIGUSR1,
+			     "F_GETOWN_EX, F_SETOWN_EX for process ID");
+
+	setownex_cleanup();
+}
+
+static void setownex_pgrp_test(void)
+{
+	struct f_owner_ex tst_own_ex;
+
+	if (ownex_enabled == 0) {
+		tst_resm(TCONF, ownex_tconf_msg);
+		return;
+	}
+
+	tst_own_ex.type = F_OWNER_PGRP;
+	tst_own_ex.pid = pgrp_pid;
+
+	TEST(fcntl(test_fd, F_SETOWN_EX, &tst_own_ex));
+	if (TEST_RETURN < 0) {
+		tst_brkm(TFAIL | TTERRNO, cleanup,
+			 "fcntl F_SETOWN_EX failed");
+	}
+	test_set_and_get_sig(SIGUSR1,
+			     "F_GETOWN_EX, F_SETOWN_EX for process group ID");
+
+	setownex_cleanup();
+}
+#endif
+
+static void test_set_and_get_sig(int sig, char *des)
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
+	check_io_signal(des);
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
+	ret = setpgrp();
+	if (ret < 0) {
+		fprintf(stderr, "child process(%d) setpgrp() failed \n",
+			getpid());
+	}
+
+	ret = write(fd, "c", 1);
+
+	switch (ret) {
+	case 0:
+		fprintf(stderr, "No data written, something is wrong\n");
+	break;
+	case -1:
+		fprintf(stderr, "Failed to write to pipe: %s\n",
+			strerror(errno));
+	break;
+	}
+
+	close(fd);
+	return;
+}
+
+static void check_io_signal(char *des)
+{
+	int ret;
+	pid_t child;
+
+	child = tst_fork();
+	if (child < 0)
+		tst_brkm(TBROK | TERRNO, cleanup, "fork failed");
+
+	if (child == 0) {
+		signal_parent();
+		exit(0);
+	} else {
+		ret = sigtimedwait(&newset, NULL, &timeout);
+		if (ret == -1) {
+			tst_brkm(TBROK | TERRNO, NULL,
+				 "sigtimedwait() failed.");
+		}
+
+		switch (ret) {
+		case SIGUSR1:
+			tst_resm(TPASS, "fcntl test %s success", des);
+		break;
+		case SIGIO:
+			tst_resm(TFAIL, "received default SIGIO, fcntl test "
+				 "%s failed", des);
+		break;
+		default:
+			tst_brkm(TBROK, cleanup, "fcntl io events "
+				 "signal mechanism work abnormally");
+		}
+		wait(NULL);
+	}
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+
+	if (sigprocmask(SIG_SETMASK, &oldset, NULL) < 0)
+		tst_resm(TWARN | TERRNO, "sigprocmask restore oldset failed");
+
+	if (pipe_fds[0] > 0 && close(pipe_fds[0]) == -1)
+		tst_resm(TWARN | TERRNO, "close(%d) failed", pipe_fds[0]);
+	if (pipe_fds[1] > 0 && close(pipe_fds[1]) == -1)
+		tst_resm(TWARN | TERRNO, "close(%d) failed", pipe_fds[1]);
+}
-- 
1.8.2.1


------------------------------------------------------------------------------
Subversion Kills Productivity. Get off Subversion & Make the Move to Perforce.
With Perforce, you get hassle-free workflows. Merge that actually works. 
Faster operations. Version large binaries.  Built-in WAN optimization and the
freedom to use Git, Perforce or both. Make the move to Perforce.
http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
