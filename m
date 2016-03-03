From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 3 Mar 2016 16:24:45 +0800
Subject: [LTP] [PATCH v3] epoll_pwait/epoll_pwait01.c: add new testcase
In-Reply-To: <56D7E9A0.4060701@cn.fujitsu.com>
References: <56D7E9A0.4060701@cn.fujitsu.com>
Message-ID: <1456993485-2849-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Check that:
 1) epoll_pwait(2) with sigmask argument allows the caller
    to safely wait until either a file descriptor becomes
    ready or the timeout expires.
 2) epoll_pwait(2) with NULL sigmask argument fails if
    interrupted by a signal handler, epoll_pwait(2) should
    return -1 and set errno to EINTR.

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 configure.ac                                       |   1 +
 m4/ltp-epoll_pwait.m4                              |  25 +++
 runtest/ltplite                                    |   2 +
 runtest/stress.part3                               |   2 +
 runtest/syscalls                                   |   1 +
 testcases/kernel/syscalls/.gitignore               |   1 +
 testcases/kernel/syscalls/epoll_pwait/Makefile     |  23 +++
 .../kernel/syscalls/epoll_pwait/epoll_pwait.h      |  35 ++++
 .../kernel/syscalls/epoll_pwait/epoll_pwait01.c    | 194 +++++++++++++++++++++
 9 files changed, 284 insertions(+)
 create mode 100644 m4/ltp-epoll_pwait.m4
 create mode 100644 testcases/kernel/syscalls/epoll_pwait/Makefile
 create mode 100644 testcases/kernel/syscalls/epoll_pwait/epoll_pwait.h
 create mode 100644 testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c

diff --git a/configure.ac b/configure.ac
index cc50397..b065fe6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -183,5 +183,6 @@ LTP_CHECK_KCMP
 LTP_CHECK_KCMP_TYPE
 LTP_CHECK_PREADV
 LTP_CHECK_PWRITEV
+LTP_CHECK_EPOLL_PWAIT
 
 AC_OUTPUT
diff --git a/m4/ltp-epoll_pwait.m4 b/m4/ltp-epoll_pwait.m4
new file mode 100644
index 0000000..e918110
--- /dev/null
+++ b/m4/ltp-epoll_pwait.m4
@@ -0,0 +1,25 @@
+dnl
+dnl Copyright (c) 2016 Fujitsu Ltd.
+dnl Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
+dnl
+dnl This program is free software; you can redistribute it and/or modify
+dnl it under the terms of the GNU General Public License as published by
+dnl the Free Software Foundation; either version 2 of the License, or
+dnl (at your option) any later version.
+dnl
+dnl This program is distributed in the hope that it will be useful,
+dnl but WITHOUT ANY WARRANTY; without even the implied warranty of
+dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
+dnl the GNU General Public License for more details.
+dnl
+dnl You should have received a copy of the GNU General Public License
+dnl along with this program.
+dnl
+
+dnl
+dnl LTP_CHECK_EPOLL_PWAIT
+dnl ----------------------------
+dnl
+AC_DEFUN([LTP_CHECK_EPOLL_PWAIT],[
+AC_CHECK_FUNCS(epoll_pwait,,)
+])
diff --git a/runtest/ltplite b/runtest/ltplite
index f1795ed..d762ac2 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -163,6 +163,8 @@ epoll_wait01 epoll_wait01
 epoll_wait02 epoll_wait02
 epoll_wait03 epoll_wait03
 
+epoll_pwait01 epoll_pwait01
+
 execl01 execl01
 execle01 execle01
 execlp01 execlp01
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index ab2c531..ec1de78 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -104,6 +104,8 @@ epoll_wait01 epoll_wait01
 epoll_wait02 epoll_wait02
 epoll_wait03 epoll_wait03
 
+epoll_pwait01 epoll_pwait01
+
 execl01 execl01
 execle01 execle01
 execlp01 execlp01
diff --git a/runtest/syscalls b/runtest/syscalls
index a51ac19..2d981ed 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -125,6 +125,7 @@ epoll01 epoll-ltp
 epoll_wait01 epoll_wait01
 epoll_wait02 epoll_wait02
 epoll_wait03 epoll_wait03
+epoll_pwait01 epoll_pwait01
 
 eventfd01 eventfd01
 
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 1b10650..f54e065 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -100,6 +100,7 @@
 /epoll_wait/epoll_wait01
 /epoll_wait/epoll_wait02
 /epoll_wait/epoll_wait03
+/epoll_pwait/epoll_pwait01
 /eventfd/eventfd01
 /eventfd2/eventfd2_01
 /eventfd2/eventfd2_02
diff --git a/testcases/kernel/syscalls/epoll_pwait/Makefile b/testcases/kernel/syscalls/epoll_pwait/Makefile
new file mode 100644
index 0000000..289aaaf
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_pwait/Makefile
@@ -0,0 +1,23 @@
+#
+#  Copyright (c) 2016 Fujitsu Ltd.
+#  Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
+#
+#  This program is free software; you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
+#  the GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program.
+#
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait.h b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait.h
new file mode 100644
index 0000000..694cd46
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait.h
@@ -0,0 +1,35 @@
+/*
+ * Copyright (c) 2016 Fujitsu Ltd.
+ * Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
+ * the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.
+ */
+
+#ifndef EPOLL_PWAIT_H
+#define EPOLL_PWAIT_H
+
+#include <sys/types.h>
+#include "config.h"
+#include "linux_syscall_numbers.h"
+
+#if !defined(HAVE_EPOLL_PWAIT)
+int epoll_pwait(int epfd, struct epoll_event *events, int maxevents,
+	int timeout, const sigset_t *sigmask)
+{
+	return ltp_syscall(__NR_epoll_pwait, epfd, events, maxevents,
+		timeout, sigmask);
+}
+#endif
+
+#endif /* EPOLL_PWAIT_H */
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c
new file mode 100644
index 0000000..30d1746
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c
@@ -0,0 +1,194 @@
+/*
+ * Copyright (c) 2016 Fujitsu Ltd.
+ * Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
+ * the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.
+ */
+
+/*
+ * Description:
+ *  Basic test for epoll_pwait(2).
+ *  1) epoll_pwait(2) with sigmask argument allows the caller to
+ *     safely wait until either a file descriptor becomes ready
+ *     or the timeout expires.
+ *  2) epoll_pwait(2) with NULL sigmask argument fails if
+ *     interrupted by a signal handler, epoll_pwait(2) should
+ *     return -1 and set errno to EINTR.
+ */
+
+#include <sys/epoll.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+
+#include "test.h"
+#include "epoll_pwait.h"
+#include "safe_macros.h"
+
+char *TCID = "epoll_pwait01";
+int TST_TOTAL = 2;
+
+static int epfd, fds[2];
+static sigset_t sigset;
+static struct epoll_event epevs;
+static struct sigaction sa;
+
+static void setup(void);
+static void verify_sigmask(void);
+static void verify_nonsigmask(void);
+static void sighandler(int sig LTP_ATTRIBUTE_UNUSED);
+static void do_test(sigset_t *);
+static void do_child(void);
+static void cleanup(void);
+
+int main(int ac, char **av)
+{
+	int lc;
+
+	tst_parse_opts(ac, av, NULL, NULL);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		do_test(&sigset);
+		do_test(NULL);
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	if ((tst_kvercmp(2, 6, 19)) < 0) {
+		tst_brkm(TCONF, NULL, "This test can only run on kernels "
+			 "that are 2.6.19 or higher");
+	}
+
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+
+	if (sigemptyset(&sigset) == -1)
+		tst_brkm(TFAIL | TERRNO, NULL, "sigemptyset() failed");
+
+	if (sigaddset(&sigset, SIGUSR1) == -1)
+		tst_brkm(TFAIL | TERRNO, NULL, "sigaddset() failed");
+
+	sa.sa_flags = 0;
+	sa.sa_handler = sighandler;
+	if (sigemptyset(&sa.sa_mask) == -1)
+		tst_brkm(TFAIL | TERRNO, NULL, "sigemptyset() failed");
+
+	if (sigaction(SIGUSR1, &sa, NULL) == -1)
+		tst_brkm(TFAIL | TERRNO, NULL, "sigaction() failed");
+
+	SAFE_PIPE(NULL, fds);
+
+	epfd = epoll_create(1);
+	if (epfd == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "failed to create epoll instance");
+	}
+
+	epevs.events = EPOLLIN;
+	epevs.data.fd = fds[0];
+
+	if (epoll_ctl(epfd, EPOLL_CTL_ADD, fds[0], &epevs) == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "failed to register epoll target");
+	}
+}
+
+static void verify_sigmask(void)
+{
+	if (TEST_RETURN == -1) {
+		tst_resm(TFAIL | TTERRNO, "epoll_pwait() failed");
+	} else if (TEST_RETURN != 0) {
+		tst_resm(TFAIL, "epoll_pwait() returned %li, expected 0",
+			 TEST_RETURN);
+	} else {
+		tst_resm(TPASS, "epoll_pwait(sigmask) blocked signal");
+	}
+}
+
+static void verify_nonsigmask(void)
+{
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "epoll_wait() succeeded unexpectedly");
+	} else {
+		if (TEST_ERRNO == EINTR) {
+			tst_resm(TPASS | TTERRNO,
+				 "epoll_wait() failed as expected");
+		} else {
+			tst_resm(TFAIL | TTERRNO,
+				 "epoll_wait() failed unexpectedly, "
+				 "expected errno is EINTR");
+		}
+	}
+}
+
+static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
+{
+
+}
+
+static void do_test(sigset_t *sigmask)
+{
+	pid_t cpid;
+
+	cpid = tst_fork();
+	if (cpid < 0)
+		tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
+
+	if (cpid == 0)
+		do_child();
+
+	TEST(epoll_pwait(epfd, &epevs, 1, 100, sigmask));
+
+	if (sigmask != NULL)
+		verify_sigmask();
+	else
+		verify_nonsigmask();
+
+	tst_record_childstatus(cleanup, cpid);
+}
+
+static void do_child(void)
+{
+	if (tst_process_state_wait2(getppid(), 'S') != 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "failed to wait for parent process's state");
+	}
+
+	SAFE_KILL(cleanup, getppid(), SIGUSR1);
+
+	cleanup();
+	tst_exit();
+}
+
+static void cleanup(void)
+{
+	if (epfd > 0 && close(epfd))
+		tst_resm(TWARN | TERRNO, "failed to close epfd");
+
+	if (close(fds[0]))
+		tst_resm(TWARN | TERRNO, "close(fds[0]) failed");
+
+	if (close(fds[1]))
+		tst_resm(TWARN | TERRNO, "close(fds[1]) failed");
+}
-- 
1.8.4.2



