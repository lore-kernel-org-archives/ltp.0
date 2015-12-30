From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Wed, 30 Dec 2015 18:44:15 +0800
Subject: [LTP] [PATCH 1/3] epoll_wait/epoll_wait01.c: add new testcase
Message-ID: <1451472257-29472-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Check that epoll_wait(2) works for EPOLLOUT and EPOLLIN events
on a epoll instance and that struct epoll_event is set correctly.

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 runtest/ltplite                                    |   2 +
 runtest/stress.part3                               |   2 +
 runtest/syscalls                                   |   1 +
 testcases/kernel/syscalls/.gitignore               |   1 +
 testcases/kernel/syscalls/epoll_wait/Makefile      |  23 ++
 .../kernel/syscalls/epoll_wait/epoll_wait01.c      | 263 +++++++++++++++++++++
 6 files changed, 292 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_wait/Makefile
 create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait01.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 1aa93e6..59be3ba 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -160,6 +160,8 @@ dup203 dup203
 dup204 dup204
 dup205 dup205
 
+epoll_wait01 epoll_wait01
+
 execl01 execl01
 execle01 execle01
 execlp01 execlp01
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 87f42ea..3ed10ca 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -101,6 +101,8 @@ dup203 dup203
 dup204 dup204
 dup205 dup205
 
+epoll_wait01 epoll_wait01
+
 execl01 execl01
 execle01 execle01
 execlp01 execlp01
diff --git a/runtest/syscalls b/runtest/syscalls
index 7173f22..5dbd00f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -123,6 +123,7 @@ dup3_02 dup3_02
 
 epoll_create1_01 epoll_create1_01
 epoll01 epoll-ltp
+epoll_wait01 epoll_wait01
 
 eventfd01 eventfd01
 
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index d5f21ef..7b83307 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -98,6 +98,7 @@
 /dup3/dup3_02
 /epoll/epoll-ltp
 /epoll_create1/epoll_create1_01
+/epoll_wait/epoll_wait01
 /eventfd/eventfd01
 /eventfd2/eventfd2_01
 /eventfd2/eventfd2_02
diff --git a/testcases/kernel/syscalls/epoll_wait/Makefile b/testcases/kernel/syscalls/epoll_wait/Makefile
new file mode 100644
index 0000000..fa233c8
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_wait/Makefile
@@ -0,0 +1,23 @@
+#
+#  Copyright (c) 2015 Fujitsu Ltd.
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
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
new file mode 100644
index 0000000..46058a2
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
@@ -0,0 +1,263 @@
+/*
+ * Copyright (c) 2015 Fujitsu Ltd.
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
+ *  Basic test for epoll_wait(2).
+ *  Check that epoll_wait(2) works for EPOLLOUT and EPOLLIN events
+ *  on a epoll instance and that struct epoll_event is set correctly.
+ */
+
+#include <sys/epoll.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <poll.h>
+#include <errno.h>
+
+#include "test.h"
+#include "safe_macros.h"
+#include "lapi/fcntl.h"
+
+char *TCID = "epoll_wait01";
+int TST_TOTAL = 3;
+
+static int write_size, epfd, fds[2];
+static struct epoll_event epevs[2];
+
+static void setup(void);
+static int get_writesize(void);
+static void verify_epollout(void);
+static void verify_epollin(void);
+static void verify_epollio(void);
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
+		verify_epollout();
+		verify_epollin();
+		verify_epollio();
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	int pipe_capacity;
+
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+
+	SAFE_PIPE(NULL, fds);
+
+	/* fcntl()'s F_GETPIPE_SZ flag availbility check */
+	if ((tst_kvercmp(2, 6, 35)) < 0) {
+		write_size = get_writesize();
+	} else {
+		pipe_capacity = fcntl(fds[1], F_GETPIPE_SZ);
+		if (pipe_capacity == -1) {
+			tst_brkm(TBROK | TERRNO, cleanup,
+				 "failed to get the pipe capacity");
+		}
+
+		write_size = pipe_capacity - getpagesize() + 1;
+	}
+
+	epfd = epoll_create(2);
+	if (epfd == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "failed to create epoll instance");
+	}
+
+	epevs[0].events = EPOLLIN;
+	epevs[0].data.fd = fds[0];
+	epevs[1].events = EPOLLOUT;
+	epevs[1].data.fd = fds[1];
+
+	if (epoll_ctl(epfd, EPOLL_CTL_ADD, fds[0], &epevs[0]) ||
+		epoll_ctl(epfd, EPOLL_CTL_ADD, fds[1], &epevs[1])) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "failed to register epoll target");
+	}
+}
+
+/*
+ * fcntl(fd, F_GETPIPE_SZ) not supported on kernels which
+ * version lower than 2.6.35, so use this function instead
+ */
+static int get_writesize(void)
+{
+	int nfd, write_size;
+
+	struct pollfd pfd[] = {
+		{.fd = fds[0], .events = POLLIN},
+		{.fd = fds[1], .events = POLLOUT},
+	};
+
+	write_size = 0;
+	do {
+		SAFE_WRITE(cleanup, 1, fds[1], "a", 1);
+		write_size++;
+		nfd = poll(pfd, 2, -1);
+		if (nfd == -1)
+			tst_brkm(TBROK | TERRNO, cleanup, "poll failed");
+	} while (nfd == 2);
+
+	char buf[write_size];
+
+	SAFE_READ(cleanup, 1, fds[0], buf, write_size);
+
+	return write_size;
+}
+
+static void verify_epollout(void)
+{
+	TEST(epoll_wait(epfd, epevs, 2, -1));
+
+	if (TEST_RETURN == -1) {
+		tst_resm(TFAIL | TTERRNO, "epoll_wait() epollout failed");
+		return;
+	}
+
+	if (TEST_RETURN != 1) {
+		tst_resm(TFAIL, "epoll_wait() failed to get one fd ready");
+		return;
+	}
+
+	if (epevs[0].data.fd != fds[1]) {
+		tst_resm(TFAIL, "epoll_wait() failed to set write fd");
+		return;
+	}
+
+	if (epevs[0].events != EPOLLOUT) {
+		tst_resm(TFAIL, "epoll_wait() failed to set EPOLLOUT");
+		return;
+	}
+
+	tst_resm(TPASS, "epoll_wait() epollout");
+}
+
+static void verify_epollin(void)
+{
+	char write_buf[write_size];
+	char read_buf[sizeof(write_buf)];
+
+	memset(write_buf, 'a', sizeof(write_buf));
+
+	SAFE_WRITE(cleanup, 1, fds[1], write_buf, sizeof(write_buf));
+
+	TEST(epoll_wait(epfd, epevs, 2, -1));
+
+	if (TEST_RETURN == -1) {
+		tst_resm(TFAIL | TTERRNO, "epoll_wait() epollin failed");
+		goto end;
+	}
+
+	if (TEST_RETURN != 1) {
+		tst_resm(TFAIL, "epoll_wait() failed to get one fd ready");
+		goto end;
+	}
+
+	if (epevs[0].data.fd != fds[0]) {
+		tst_resm(TFAIL, "epoll_wait() failed to set read fd");
+		goto end;
+	}
+
+	if (epevs[0].events != EPOLLIN) {
+		tst_resm(TFAIL, "epoll_wait() failed to set EPOLLIN");
+		goto end;
+	}
+
+	tst_resm(TPASS, "epoll_wait() epollin");
+
+end:
+	SAFE_READ(cleanup, 1, fds[0], read_buf, sizeof(write_buf));
+}
+
+static void verify_epollio(void)
+{
+	int i, checked0, checked1;
+	char write_buf[] = "Testing";
+	char read_buf[sizeof(write_buf)];
+
+	SAFE_WRITE(cleanup, 1, fds[1], write_buf, sizeof(write_buf));
+
+	TEST(epoll_wait(epfd, epevs, 2, -1));
+
+	if (TEST_RETURN == -1) {
+		tst_resm(TFAIL | TTERRNO, "epoll_wait() epollio failed");
+		goto end;
+	}
+
+	if (TEST_RETURN != 2) {
+		tst_resm(TFAIL, "epoll_wait() failed to get two fds ready");
+		goto end;
+	}
+
+	checked0 = 0;
+	checked1 = 0;
+	for (i = 0; i < TEST_RETURN; i++) {
+		if (checked0 == 0 && epevs[i].data.fd == fds[0]) {
+			if (epevs[i].events != EPOLLIN) {
+				tst_resm(TFAIL, "epoll_wait()"
+					 "failed to set EPOLLIN");
+				goto end;
+			}
+			checked0 = 1;
+		} else if (checked1 == 0 && epevs[i].data.fd == fds[1]) {
+			if (epevs[i].events != EPOLLOUT) {
+				tst_resm(TFAIL, "epoll_wait()"
+					 "failed to set EPOLLOUT");
+				goto end;
+			}
+			checked1 = 1;
+		} else {
+			tst_resm(TFAIL, "epoll_wait()"
+				 "failed to set write or read fd");
+			goto end;
+		}
+	}
+
+	tst_resm(TPASS, "epoll_wait() epollio");
+
+end:
+	SAFE_READ(cleanup, 1, fds[0], read_buf, sizeof(write_buf));
+}
+
+static void cleanup(void)
+{
+	if (epfd > 0 && close(epfd))
+		tst_resm(TWARN | TERRNO, "failed to close epfd");
+
+	if (close(fds[0]))
+		tst_resm(TWARN | TERRNO, "failed to close fds[0]");
+
+	if (close(fds[1]))
+		tst_resm(TWARN | TERRNO, "failed to close fds[1]");
+}
-- 
1.8.4.2



