From: Xie Ziyao <xieziyao@huawei.com>
Date: Tue, 17 Aug 2021 14:49:20 +0800
Subject: [LTP] [PATCH 3/7] epoll_ctl: Add test for epoll_ctl03
In-Reply-To: <20210817064924.127970-1-xieziyao@huawei.com>
References: <20210817064924.127970-1-xieziyao@huawei.com>
Message-ID: <20210817064924.127970-4-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Check that epoll_ctl returns zero with different combinations of events on
success.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/epoll_ctl/.gitignore      |  5 +-
 .../kernel/syscalls/epoll_ctl/epoll_ctl03.c   | 75 +++++++++++++++++++
 3 files changed, 79 insertions(+), 2 deletions(-)
 create mode 100644 testcases/kernel/syscalls/epoll_ctl/epoll_ctl03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 7d308dcec..b28d19ac7 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -160,6 +160,7 @@ epoll_create1_01 epoll_create1_01
 epoll01 epoll-ltp
 epoll_ctl01 epoll_ctl01
 epoll_ctl02 epoll_ctl02
+epoll_ctl03 epoll_ctl03
 epoll_wait01 epoll_wait01
 epoll_wait02 epoll_wait02
 epoll_wait03 epoll_wait03
diff --git a/testcases/kernel/syscalls/epoll_ctl/.gitignore b/testcases/kernel/syscalls/epoll_ctl/.gitignore
index 634470a06..2b50d924c 100644
--- a/testcases/kernel/syscalls/epoll_ctl/.gitignore
+++ b/testcases/kernel/syscalls/epoll_ctl/.gitignore
@@ -1,2 +1,3 @@
-/epoll_ctl01
-/epoll_ctl02
+epoll_ctl01
+epoll_ctl02
+epoll_ctl03
diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl03.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl03.c
new file mode 100644
index 000000000..f80bef93e
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl03.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Huawei Technologies Co., Ltd. 2021. All rights reserved.
+ * Author: Xie Ziyao <xieziyao@huawei.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Check that epoll_ctl returns zero with different combinations of events on
+ * success.
+ */
+
+#include <poll.h>
+#include <sys/epoll.h>
+
+#include "tst_test.h"
+
+#define WIDTH_EPOLL_EVENTS 256
+
+static int epfd, fds[2];
+static struct epoll_event events = {.events = EPOLLIN};
+
+static void run_all(void)
+{
+	unsigned int index, events_bitmap;
+
+	for (index = 0; index < WIDTH_EPOLL_EVENTS; index++) {
+		events_bitmap = ((EPOLLIN * ((index & 0x01) >> 0)) |
+				(EPOLLOUT * ((index & 0x02) >> 1)) |
+				(EPOLLPRI * ((index & 0x04) >> 2)) |
+				(EPOLLERR * ((index & 0x08) >> 3)) |
+				(EPOLLHUP * ((index & 0x10) >> 4)) |
+				(EPOLLET * ((index & 0x20) >> 5)) |
+				(EPOLLONESHOT * ((index & 0x40) >> 6)) |
+				(EPOLLRDHUP * ((index & 0x80) >> 7)));
+
+		events.events = events_bitmap;
+		TST_EXP_PASS(epoll_ctl(epfd, EPOLL_CTL_MOD, fds[0], &events),
+			     "epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.events=%x",
+			     events.events);
+	}
+}
+
+static void setup(void)
+{
+	epfd = epoll_create(1);
+	if (epfd == -1)
+		tst_brk(TBROK | TERRNO, "fail to create epoll instance");
+
+	SAFE_PIPE(fds);
+	events.data.fd = fds[0];
+
+	if (epoll_ctl(epfd, EPOLL_CTL_ADD, fds[0], &events))
+		tst_brk(TBROK | TERRNO, "epoll_clt(..., EPOLL_CTL_ADD, ...)");
+}
+
+static void cleanup(void)
+{
+	if (epfd)
+		SAFE_CLOSE(epfd);
+
+	if (fds[0])
+		SAFE_CLOSE(fds[0]);
+
+	if (fds[1])
+		SAFE_CLOSE(fds[1]);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_all,
+	.min_kver = "2.6.17",
+};
--
2.17.1

