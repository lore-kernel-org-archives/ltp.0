From: Xie Ziyao <xieziyao@huawei.com>
Date: Mon, 28 Jun 2021 16:04:24 +0800
Subject: [LTP] [PATCH 3/3] epoll_pwait2: Add test for epoll_pwait202
In-Reply-To: <20210628080424.245911-1-xieziyao@huawei.com>
References: <20210628080424.245911-1-xieziyao@huawei.com>
Message-ID: <20210628080424.245911-4-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Check that epoll_pwait2 timeouts correctly.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/epoll_pwait2/.gitignore   |  1 +
 .../syscalls/epoll_pwait2/epoll_pwait202.c    | 76 +++++++++++++++++++
 3 files changed, 78 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_pwait2/epoll_pwait202.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 8a6b8ba20..f63e57fee 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -167,6 +167,7 @@ epoll_wait02 epoll_wait02
 epoll_wait03 epoll_wait03
 epoll_pwait01 epoll_pwait01
 epoll_pwait201 epoll_pwait201
+epoll_pwait202 epoll_pwait202

 eventfd01 eventfd01

diff --git a/testcases/kernel/syscalls/epoll_pwait2/.gitignore b/testcases/kernel/syscalls/epoll_pwait2/.gitignore
index 2298cf9d9..8b2c314ea 100644
--- a/testcases/kernel/syscalls/epoll_pwait2/.gitignore
+++ b/testcases/kernel/syscalls/epoll_pwait2/.gitignore
@@ -1 +1,2 @@
 epoll_pwait201
+epoll_pwait202
diff --git a/testcases/kernel/syscalls/epoll_pwait2/epoll_pwait202.c b/testcases/kernel/syscalls/epoll_pwait2/epoll_pwait202.c
new file mode 100644
index 000000000..2b0d5dd5b
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_pwait2/epoll_pwait202.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 HUAWEI LIMITED
+ * Author: Xie Ziyao <xieziyao@huawei.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Check that epoll_pwait2 timeouts correctly.
+ */
+
+#include <sys/epoll.h>
+
+#include "tst_timer_test.h"
+#include "lapi/epoll.h"
+
+static int efd, sfd[2];
+static struct epoll_event e;
+static struct __kernel_timespec ts;
+
+int sample_fn(int clk_id, long long usec)
+{
+	if (usec >= 1000000) {
+		ts.tv_sec = usec / 1000000;
+		ts.tv_nsec = 0;
+	} else {
+		ts.tv_sec = 0;
+		ts.tv_nsec = usec * 1000;
+	}
+
+	tst_timer_start(clk_id);
+	TEST(tst_syscall(__NR_epoll_pwait2, efd, &e, 1, &ts, NULL, 0));
+	tst_timer_stop();
+	tst_timer_sample();
+
+	if (TST_RET != 0) {
+		tst_res(TFAIL | TTERRNO,
+			"epoll_pwait2() returned %li, expected 0", TST_RET);
+		return 1;
+	}
+
+	return 0;
+}
+
+static void setup(void)
+{
+	SAFE_SOCKETPAIR(AF_UNIX, SOCK_STREAM, 0, sfd);
+
+	efd = epoll_create(1);
+	if (efd == -1)
+		tst_brk(TBROK | TERRNO, "epoll_create()");
+
+	e.events = EPOLLIN;
+	if (epoll_ctl(efd, EPOLL_CTL_ADD, sfd[0], &e))
+		tst_brk(TBROK | TERRNO, "epoll_clt(..., EPOLL_CTL_ADD, ...)");
+}
+
+static void cleanup(void)
+{
+	if (efd > 0)
+		SAFE_CLOSE(efd);
+
+	if (sfd[0] > 0)
+		SAFE_CLOSE(sfd[0]);
+
+	if (sfd[1] > 0)
+		SAFE_CLOSE(sfd[1]);
+}
+
+static struct tst_test test = {
+	.scall = "epoll_pwait2()",
+	.sample = sample_fn,
+	.setup = setup,
+	.cleanup = cleanup,
+};
--
2.17.1

