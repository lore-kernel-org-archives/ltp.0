From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Wed, 17 Feb 2016 18:51:24 +0800
Subject: [LTP] [PATCH v2 1/3] epoll_wait/epoll_wait01.c: add new testcase
In-Reply-To: <56AEECEC.8090305@cn.fujitsu.com>
References: <56AEECEC.8090305@cn.fujitsu.com>
Message-ID: <1455706286-4090-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
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
 .../kernel/syscalls/epoll_wait/epoll_wait01.c      | 281 +++++++++++++++++++++
 6 files changed, 310 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_wait/Makefile
 create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait01.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 89accc4..79ab6a1 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -159,6 +159,8 @@ dup203 dup203
 dup204 dup204
 dup205 dup205
 
+epoll_wait01 epoll_wait01
+
 execl01 execl01
 execle01 execle01
 execlp01 execlp01
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 85950bf..20fe314 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -100,6 +100,8 @@ dup203 dup203
 dup204 dup204
 dup205 dup205
 
+epoll_wait01 epoll_wait01
+
 execl01 execl01
 execle01 execle01
 execlp01 execlp01
diff --git a/runtest/syscalls b/runtest/syscalls
index 5f169a3..a1591ec 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -122,6 +122,7 @@ dup3_02 dup3_02
 
 epoll_create1_01 epoll_create1_01
 epoll01 epoll-ltp
+epoll_wait01 epoll_wait01
 
 eventfd01 eventfd01
 
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index de403e4..01a3cc0 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -97,6 +97,7 @@
 /dup3/dup3_02
 /epoll/epoll-ltp
 /epoll_create1/epoll_create1_01
+/epoll_wait/epoll_wait01
 /eventfd/eventfd01
 /eventfd2/eventfd2_01
 /eventfd2/eventfd2_02
diff --git a/testcases/kernel/syscalls/epoll_wait/Makefile b/testcases/kernel/syscalls/epoll_wait/Makefile
new file mode 100644
index 0000000..289aaaf
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_wait/Makefile
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
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
new file mode 100644
index 0000000..9ae7580
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
@@ -0,0 +1,281 @@
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
+ *  Basic test for epoll_wait(2).
+ *  Check that epoll_wait(2) works for EPOLLOUT and EPOLLIN events
+ *  on a epoll instance and that struct epoll_event is set correctly.
+ */
+
+#include <sys/epoll.h>
+#include <poll.h>
+#include <string.h>
+#include <errno.h>
+
+#include "test.h"
+#include "safe_macros.h"
+
+char *TCID = "epoll_wait01";
+int TST_TOTAL = 3;
+
+static int write_size, epfd, fds[2], fds2[2];
+static struct epoll_event epevs[3] = {
+	{.events = EPOLLIN},
+	{.events = EPOLLOUT},
+	{.events = EPOLLIN}
+};
+
+static void setup(void);
+static int get_writesize(void);
+static void verify_epollout(void);
+static void verify_epollin(void);
+static void verify_epollio(void);
+static int has_event(struct epoll_event *, int, int, uint32_t);
+static void dump_epevs(struct epoll_event *, int);
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
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+
+	SAFE_PIPE(NULL, fds);
+	SAFE_PIPE(cleanup, fds2);
+
+	write_size = get_writesize();
+
+	epfd = epoll_create(3);
+	if (epfd == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "failed to create epoll instance");
+	}
+
+	epevs[0].data.fd = fds[0];
+	epevs[1].data.fd = fds[1];
+	epevs[2].data.fd = fds2[0];
+
+	if (epoll_ctl(epfd, EPOLL_CTL_ADD, fds[0], &epevs[0]) ||
+	    epoll_ctl(epfd, EPOLL_CTL_ADD, fds[1], &epevs[1]) ||
+	    epoll_ctl(epfd, EPOLL_CTL_ADD, fds2[0], &epevs[2])) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "failed to register epoll target");
+	}
+}
+
+static int get_writesize(void)
+{
+	int nfd, write_size;
+	char buf[4096];
+
+	memset(buf, 'a', sizeof(buf));
+
+	struct pollfd pfd[] = {
+		{.fd = fds[0], .events = POLLIN},
+		{.fd = fds[1], .events = POLLOUT},
+	};
+
+	write_size = 0;
+	do {
+		write_size += SAFE_WRITE(cleanup, 0, fds[1], buf, sizeof(buf));
+		nfd = poll(pfd, 2, -1);
+		if (nfd == -1)
+			tst_brkm(TBROK | TERRNO, cleanup, "poll failed");
+	} while (nfd == 2);
+
+	char read_buf[write_size];
+
+	SAFE_READ(cleanup, 1, fds[0], read_buf, sizeof(read_buf));
+
+	return write_size;
+}
+
+static void verify_epollout(void)
+{
+	TEST(epoll_wait(epfd, epevs, 3, -1));
+
+	if (TEST_RETURN == -1) {
+		tst_resm(TFAIL | TTERRNO, "epoll_wait() epollout failed");
+		return;
+	}
+
+	if (TEST_RETURN != 1) {
+		tst_resm(TFAIL, "epoll_wait() returned %li, expected 1",
+			 TEST_RETURN);
+		return;
+	}
+
+	if (epevs[0].data.fd != fds[1]) {
+		tst_resm(TFAIL, "epoll.data.fd %i, expected %i",
+			 epevs[0].data.fd, fds[1]);
+		return;
+	}
+
+	if (epevs[0].events != EPOLLOUT) {
+		tst_resm(TFAIL, "epoll.events %x, expected EPOLLOUT %x",
+			 epevs[0].events, EPOLLOUT);
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
+	TEST(epoll_wait(epfd, epevs, 3, -1));
+
+	if (TEST_RETURN == -1) {
+		tst_resm(TFAIL | TTERRNO, "epoll_wait() epollin failed");
+		goto end;
+	}
+
+	if (TEST_RETURN != 1) {
+		tst_resm(TFAIL, "epoll_wait() returned %li, expected 1",
+			 TEST_RETURN);
+		goto end;
+	}
+
+	if (epevs[0].data.fd != fds[0]) {
+		tst_resm(TFAIL, "epoll.data.fd %i, expected %i",
+			 epevs[0].data.fd, fds[0]);
+		goto end;
+	}
+
+	if (epevs[0].events != EPOLLIN) {
+		tst_resm(TFAIL, "epoll.events %x, expected EPOLLIN %x",
+			 epevs[0].events, EPOLLIN);
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
+	char write_buf[] = "Testing";
+	char read_buf[sizeof(write_buf)];
+
+	SAFE_WRITE(cleanup, 1, fds[1], write_buf, sizeof(write_buf));
+
+	TEST(epoll_wait(epfd, epevs, 3, -1));
+
+	if (TEST_RETURN == -1) {
+		tst_resm(TFAIL | TTERRNO, "epoll_wait() epollio failed");
+		goto end;
+	}
+
+	if (TEST_RETURN != 2) {
+		tst_resm(TFAIL, "epoll_wait() returned %li, expected 2",
+			 TEST_RETURN);
+		goto end;
+	}
+
+	if (!has_event(epevs, 2, fds[0], EPOLLIN)) {
+		dump_epevs(epevs, 2);
+		tst_resm(TFAIL, "epoll_wait() expected %d and EPOLLIN %x",
+			 fds[0], EPOLLIN);
+		goto end;
+	}
+
+	if (!has_event(epevs, 2, fds[1], EPOLLOUT)) {
+		dump_epevs(epevs, 2);
+		tst_resm(TFAIL, "epoll_wait() expected %d and EPOLLOUT %x",
+			 fds[1], EPOLLOUT);
+		goto end;
+	}
+
+	tst_resm(TPASS, "epoll_wait() epollio");
+
+end:
+	SAFE_READ(cleanup, 1, fds[0], read_buf, sizeof(write_buf));
+}
+
+static int has_event(struct epoll_event *epevs, int epevs_len,
+	int fd, uint32_t events)
+{
+	int i, result;
+
+	result = 0;
+	for (i = 0; i < epevs_len; i++) {
+		if ((epevs[i].data.fd == fd) && (epevs[i].events == events)) {
+			result = 1;
+			break;
+		}
+	}
+
+	return result;
+}
+
+static void dump_epevs(struct epoll_event *epevs, int epevs_len)
+{
+	int i;
+
+	for (i = 0; i < epevs_len; i++) {
+		tst_resm(TINFO, "epevs[%d]: epoll.data.fd %d, epoll.events %x",
+			 i, epevs[i].data.fd, epevs[i].events);
+	}
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
+
+	if (fds2[0] > 0 && close(fds2[0]))
+		tst_resm(TWARN | TERRNO, "failed to close fds2[0]");
+
+	if (fds2[1] > 0 && close(fds2[1]))
+		tst_resm(TWARN | TERRNO, "failed to close fds2[1]");
+}
-- 
1.8.4.2



