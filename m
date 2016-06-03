From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 3 Jun 2016 16:03:45 +0800
Subject: [LTP] [PATCH 2/2] epoll_ctl/epoll_ctl02.c: add new testcase
In-Reply-To: <1464941025-21494-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1464941025-21494-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1464941025-21494-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) epoll_ctl(2) fails if epfd is a invalid file descriptor
   and set errno to EBADF.
2) epoll_ctl(2) fails if fd is a invalid file descriptor
   and set errno to EBADF.
3) epoll_ctl(2) fails if op is not supported by this interface
   and set errno to EINVAL.
4) epoll_ctl(2) fails if fd is the same as epfd and set errno
   to EINVAL.
5) epoll_ctl(2) fails with EPOLL_CTL_DEL if fd is not registered
   with this epoll instance and set errno to ENOENT.
6) epoll_ctl(2) fails with EPOLL_CTL_MOD if fd is not registered
   with this epoll instance and set errno to ENOENT.
7) epoll_ctl(2) fails with EPOLL_CTL_ADD if fd is already registered
   with this epoll instance and set errno to EEXIST.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/ltplite                                   |   1 +
 runtest/stress.part3                              |   1 +
 runtest/syscalls                                  |   1 +
 testcases/kernel/syscalls/.gitignore              |   1 +
 testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c | 120 ++++++++++++++++++++++
 5 files changed, 124 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 0f7f249..9e1f201 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -160,6 +160,7 @@ dup204 dup204
 dup205 dup205
 
 epoll_ctl01 epoll_ctl01
+epoll_ctl02 epoll_ctl02
 
 epoll_wait01 epoll_wait01
 epoll_wait02 epoll_wait02
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 64c0a89..9f9d674 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -101,6 +101,7 @@ dup204 dup204
 dup205 dup205
 
 epoll_ctl01 epoll_ctl01
+epoll_ctl02 epoll_ctl02
 
 epoll_wait01 epoll_wait01
 epoll_wait02 epoll_wait02
diff --git a/runtest/syscalls b/runtest/syscalls
index 41412de..428b774 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -123,6 +123,7 @@ dup3_02 dup3_02
 epoll_create1_01 epoll_create1_01
 epoll01 epoll-ltp
 epoll_ctl01 epoll_ctl01
+epoll_ctl02 epoll_ctl02
 epoll_wait01 epoll_wait01
 epoll_wait02 epoll_wait02
 epoll_wait03 epoll_wait03
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 3d38557..81f4890 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -98,6 +98,7 @@
 /epoll/epoll-ltp
 /epoll_create1/epoll_create1_01
 /epoll_ctl/epoll_ctl01
+/epoll_ctl/epoll_ctl02
 /epoll_wait/epoll_wait01
 /epoll_wait/epoll_wait02
 /epoll_wait/epoll_wait03
diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c
new file mode 100644
index 0000000..3f11a3f
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c
@@ -0,0 +1,120 @@
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
+ * Test Name: epoll_ctl02.c
+ *
+ * Description:
+ * 1) epoll_ctl(2) fails if epfd is a invalid file descriptor.
+ * 2) epoll_ctl(2) fails if fd is a invalid file descriptor.
+ * 3) epoll_ctl(2) fails if op is not supported by this interface.
+ * 4) epoll_ctl(2) fails if fd is the same as epfd.
+ * 5) epoll_ctl(2) fails with EPOLL_CTL_DEL if fd is not registered
+ *    with this epoll instance.
+ * 6) epoll_ctl(2) fails with EPOLL_CTL_MOD if fd is not registered
+ *    with this epoll instance.
+ * 7) epoll_ctl(2) fails with EPOLL_CTL_ADD if fd is already registered
+ *    with this epoll instance.
+ *
+ * Expected Result:
+ * 1) epoll_ctl(2) should return -1 and set errno to EBADF.
+ * 2) epoll_ctl(2) should return -1 and set errno to EBADF.
+ * 3) epoll_ctl(2) should return -1 and set errno to EINVAL.
+ * 4) epoll_ctl(2) should return -1 and set errno to EINVAL.
+ * 5) epoll_ctl(2) should return -1 and set errno to ENOENT.
+ * 6) epoll_ctl(2) should return -1 and set errno to ENOENT.
+ * 7) epoll_ctl(2) should return -1 and set errno to EEXIST.
+ *
+ */
+#include <sys/epoll.h>
+#include <poll.h>
+#include <errno.h>
+#include "tst_test.h"
+
+static int epfd;
+static int fd[2];
+static int inv = -1;
+
+static struct epoll_event events[2] = {
+	{.events = EPOLLIN},
+	{.events = EPOLLOUT},
+};
+
+static struct testcase {
+	int *epfds;
+	int opt;
+	int *fds;
+	struct epoll_event *ts_event;
+	int exp_err;
+} tcases[] = {
+	{&inv, EPOLL_CTL_ADD, &fd[1], &events[1], EBADF},
+	{&epfd, EPOLL_CTL_ADD, &inv, &events[1], EBADF},
+	{&epfd, -1, &fd[1], &events[1], EINVAL},
+	{&epfd, EPOLL_CTL_ADD, &epfd, &events[1], EINVAL},
+	{&epfd, EPOLL_CTL_DEL, &fd[1], &events[1], ENOENT},
+	{&epfd, EPOLL_CTL_MOD, &fd[1], &events[1], ENOENT},
+	{&epfd, EPOLL_CTL_ADD, &fd[0], &events[0], EEXIST}
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
+
+	TEST(epoll_ctl(epfd, EPOLL_CTL_ADD, fd[0], &events[0]));
+	if (TEST_RETURN == -1)
+		tst_brk(TFAIL | TTERRNO, "epoll_ctl() fails to init");
+}
+
+static void cleanup(void)
+{
+	SAFE_CLOSE(epfd);
+	SAFE_CLOSE(fd[0]);
+	SAFE_CLOSE(fd[1]);
+}
+
+static void verify_epoll_ctl(unsigned int n)
+{
+	struct testcase *tc = &tcases[n];
+
+	TEST(epoll_ctl(*tc->epfds, tc->opt, *tc->fds,  tc->ts_event));
+	if (TEST_RETURN != -1) {
+		tst_res(TFAIL, "epoll_ctl() succeeds unexpectedly");
+		return;
+	}
+
+	if (tc->exp_err == TEST_ERRNO) {
+		tst_res(TPASS | TTERRNO, "epoll_ctl() fails as expected");
+	} else {
+		tst_res(TFAIL | TTERRNO,
+			"epoll_ctl() fails unexpectedly, expected %i: %s",
+			tc->exp_err, tst_strerrno(tc->exp_err));
+	}
+}
+
+static struct tst_test test = {
+	.tid = "epoll_ctl02",
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_epoll_ctl,
+};
-- 
1.8.3.1



