From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 3 Jun 2016 16:03:44 +0800
Subject: [LTP] [PATCH 1/2] epoll_ctl/epoll_ctl01.c: add new testcase
Message-ID: <1464941025-21494-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Testcase to check the basic functionality of the epoll_ctl(2).
1) when epoll_ctl(2) succeeds to register fd on the epoll instance and
   associates event with fd, epoll_wait(2) will get registered fd and
   event correctly.
2) when epoll_ctl(2) succeeds to chage event which is related to fd,
   epoll_wait(2) will get chaged event correctly.
3) when epoll_ctl(2) succeeds to deregister fd from the epoll instance
   epoll_wait(2) won't get deregistered fd and event.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/ltplite                                   |   2 +
 runtest/stress.part3                              |   2 +
 runtest/syscalls                                  |   1 +
 testcases/kernel/syscalls/.gitignore              |   1 +
 testcases/kernel/syscalls/epoll_ctl/Makefile      |  24 ++++
 testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c | 152 ++++++++++++++++++++++
 6 files changed, 182 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_ctl/Makefile
 create mode 100644 testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 54df7e0..0f7f249 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -159,6 +159,8 @@ dup203 dup203
 dup204 dup204
 dup205 dup205
 
+epoll_ctl01 epoll_ctl01
+
 epoll_wait01 epoll_wait01
 epoll_wait02 epoll_wait02
 epoll_wait03 epoll_wait03
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index c5da547..64c0a89 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -100,6 +100,8 @@ dup203 dup203
 dup204 dup204
 dup205 dup205
 
+epoll_ctl01 epoll_ctl01
+
 epoll_wait01 epoll_wait01
 epoll_wait02 epoll_wait02
 epoll_wait03 epoll_wait03
diff --git a/runtest/syscalls b/runtest/syscalls
index 96f398d..41412de 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -122,6 +122,7 @@ dup3_02 dup3_02
 
 epoll_create1_01 epoll_create1_01
 epoll01 epoll-ltp
+epoll_ctl01 epoll_ctl01
 epoll_wait01 epoll_wait01
 epoll_wait02 epoll_wait02
 epoll_wait03 epoll_wait03
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 63fc261..3d38557 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -97,6 +97,7 @@
 /dup3/dup3_02
 /epoll/epoll-ltp
 /epoll_create1/epoll_create1_01
+/epoll_ctl/epoll_ctl01
 /epoll_wait/epoll_wait01
 /epoll_wait/epoll_wait02
 /epoll_wait/epoll_wait03
diff --git a/testcases/kernel/syscalls/epoll_ctl/Makefile b/testcases/kernel/syscalls/epoll_ctl/Makefile
new file mode 100644
index 0000000..2666822
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_ctl/Makefile
@@ -0,0 +1,24 @@
+#
+#  Copyright (c) 2016 Fujitsu Ltd.
+#  Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
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
+#
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c
new file mode 100644
index 0000000..c6233e5
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c
@@ -0,0 +1,152 @@
+/*
+ * Copyright (c) 2016 Fujitsu Ltd.
+ * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * You should have received a copy of the GNU General Public License
+ * alone with this program.
+ */
+
+/*
+ * Test Name: epoll_ctl01.c
+ *
+ * Description:
+ *    Testcase to check the basic functionality of the epoll_ctl(2).
+ * 1) when epoll_ctl(2) succeeds to register fd on the epoll instance and
+ *    associates event with fd, epoll_wait(2) will get registered fd and
+ *    event correctly.
+ * 2) when epoll_ctl(2) succeeds to chage event which is related to fd,
+ *    epoll_wait(2) will get chaged event correctly.
+ * 3) when epoll_ctl(2) succeeds to deregister fd from the epoll instance
+ *    epoll_wait(2) won't get deregistered fd and event.
+ *
+ */
+
+#include <sys/epoll.h>
+#include <poll.h>
+#include <string.h>
+#include <errno.h>
+#include "tst_test.h"
+
+static int epfd;
+static int fd[2];
+
+static struct epoll_event events[3] = {
+	{.events = EPOLLIN},
+	{.events = EPOLLOUT},
+	{.events = EPOLLIN}
+};
+
+static void setup(void)
+{
+	epfd = epoll_create(2);
+	if (epfd == -1)
+		tst_brk(TBROK | TERRNO, "fail to create epoll instance");
+
+	SAFE_PIPE(fd);
+
+	events[0].data.fd = fd[0];
+	events[1].data.fd = fd[1];
+	events[2].data.fd = fd[1];
+}
+
+static void cleanup(void)
+{
+	SAFE_CLOSE(epfd);
+	SAFE_CLOSE(fd[0]);
+	SAFE_CLOSE(fd[1]);
+}
+
+static int has_event(struct epoll_event *epvs, int len,
+	int fd, unsigned int events)
+{
+	int i;
+
+	for (i = 0; i < len; i++) {
+		if ((epvs[i].data.fd == fd) && (epvs[i].events == events))
+			return 1;
+	}
+
+	return 0;
+}
+
+static void check_epoll_ctl(int opt, int exp_num)
+{
+	int res;
+
+	char write_buf[] = "test";
+	char read_buf[sizeof(write_buf)];
+
+	struct epoll_event res_evs[2] = {
+	{.events = 0, .data.fd = 0},
+	{.events = 0, .data.fd = 0}
+	};
+
+	SAFE_WRITE(1, fd[1], write_buf, sizeof(write_buf));
+
+	res = epoll_wait(epfd, res_evs, 2, -1);
+	if (res == -1)
+		tst_brk(TBROK | TERRNO, "epoll_wait() fails");
+
+	if (res != exp_num) {
+		tst_res(TFAIL, "epoll_wait() returns %i, expected %i",
+			res, exp_num);
+		goto end;
+	}
+
+	if (exp_num == 1) {
+		if (!has_event(res_evs, 2, fd[0], EPOLLIN) ||
+		    !has_event(res_evs, 2, 0, 0)) {
+			tst_res(TFAIL, "epoll_wait() fails to "
+				"get expected fd and event");
+			goto end;
+		}
+	}
+
+	if (exp_num == 2) {
+		if (!has_event(res_evs, 2, fd[0], EPOLLIN) ||
+		    !has_event(res_evs, 2, fd[1], EPOLLOUT)) {
+			tst_res(TFAIL, "epoll_wait() fails to "
+				"get expected fd and event");
+			goto end;
+		}
+	}
+
+	tst_res(TPASS, "epoll_ctl() succeeds with op %i", opt);
+
+end:
+	SAFE_READ(1, fd[0], read_buf, sizeof(write_buf));
+}
+
+static void opera_epoll_ctl(int opt, int fd, struct epoll_event *epvs)
+{
+	TEST(epoll_ctl(epfd, opt, fd, epvs));
+	if (TEST_RETURN == -1)
+		tst_brk(TBROK | TTERRNO, "epoll_ctl() fails with op %i", opt);
+}
+
+static void verify_epoll_ctl(void)
+{
+	opera_epoll_ctl(EPOLL_CTL_ADD, fd[0], &events[0]);
+	opera_epoll_ctl(EPOLL_CTL_ADD, fd[1], &events[2]);
+	check_epoll_ctl(EPOLL_CTL_ADD, 1);
+	opera_epoll_ctl(EPOLL_CTL_MOD, fd[1], &events[1]);
+	check_epoll_ctl(EPOLL_CTL_MOD, 2);
+	opera_epoll_ctl(EPOLL_CTL_DEL, fd[1], &events[1]);
+	check_epoll_ctl(EPOLL_CTL_DEL, 1);
+	opera_epoll_ctl(EPOLL_CTL_DEL, fd[0], &events[0]);
+}
+
+static struct tst_test test = {
+	.tid = "epoll_ctl01",
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_epoll_ctl,
+};
-- 
1.8.3.1



