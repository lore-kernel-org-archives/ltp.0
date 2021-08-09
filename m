From: Xie Ziyao <xieziyao@huawei.com>
Date: Mon, 9 Aug 2021 16:39:03 +0800
Subject: [LTP] [PATCH 4/4] epoll_wait: Add test for epoll_wait04
In-Reply-To: <20210809083903.161596-1-xieziyao@huawei.com>
References: <20210809083903.161596-1-xieziyao@huawei.com>
Message-ID: <20210809083903.161596-5-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Check that a timeout equal to zero causes epoll_wait() to return immediately.

Fixes: #792
Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/epoll_wait/.gitignore     |  7 +-
 .../kernel/syscalls/epoll_wait/epoll_wait04.c | 71 +++++++++++++++++++
 3 files changed, 76 insertions(+), 3 deletions(-)
 create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 9af5aa5c0..57bf0477b 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -165,6 +165,7 @@ epoll_ctl02 epoll_ctl02
 epoll_wait01 epoll_wait01
 epoll_wait02 epoll_wait02
 epoll_wait03 epoll_wait03
+epoll_wait04 epoll_wait04
 epoll_pwait01 epoll_pwait01
 epoll_pwait02 epoll_pwait02
 epoll_pwait03 epoll_pwait03
diff --git a/testcases/kernel/syscalls/epoll_wait/.gitignore b/testcases/kernel/syscalls/epoll_wait/.gitignore
index 03b1be9a0..222955dd2 100644
--- a/testcases/kernel/syscalls/epoll_wait/.gitignore
+++ b/testcases/kernel/syscalls/epoll_wait/.gitignore
@@ -1,3 +1,4 @@
-/epoll_wait01
-/epoll_wait02
-/epoll_wait03
+epoll_wait01
+epoll_wait02
+epoll_wait03
+epoll_wait04
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait04.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait04.c
new file mode 100644
index 000000000..dc62e9202
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait04.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Huawei Technologies Co., Ltd. 2021. All rights reserved.
+ * Author: Xie Ziyao <xieziyao@huawei.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Check that a timeout equal to zero causes epoll_wait() to return immediately.
+ */
+
+#include <sys/epoll.h>
+
+#include "tst_test.h"
+#include "tst_timer_test.h"
+
+#define USEC_PRECISION 1000	/* Error margin allowed in usec */
+
+static int epfd, fds[2];
+static struct epoll_event epevs[1] = {
+	{.events = EPOLLIN}
+};
+
+static void run(void)
+{
+	tst_timer_start(CLOCK_MONOTONIC);
+	TEST(epoll_wait(epfd, epevs, 1, 0));
+	tst_timer_stop();
+
+	if (TST_RET != 0)
+		tst_res(TFAIL | TTERRNO, "epoll_wait() returned %li", TST_RET);
+
+	if (tst_timer_elapsed_us() <= USEC_PRECISION)
+		tst_res(TPASS, "epoll_wait() returns immediately with a timeout equal to zero");
+	else
+		tst_res(TFAIL, "epoll_wait() waited for %llius with a timeout equal to zero",
+			tst_timer_elapsed_us());
+}
+
+static void setup(void)
+{
+	SAFE_PIPE(fds);
+
+	epfd = epoll_create(1);
+	if (epfd == -1)
+		tst_brk(TBROK | TERRNO, "epoll_create()");
+
+	epevs[0].data.fd = fds[0];
+
+	if (epoll_ctl(epfd, EPOLL_CTL_ADD, fds[0], &epevs[0]))
+		tst_brk(TBROK | TERRNO, "epoll_clt(..., EPOLL_CTL_ADD, ...)");
+}
+
+static void cleanup(void)
+{
+	if (epfd > 0)
+		SAFE_CLOSE(epfd);
+
+	if (fds[0] > 0)
+		SAFE_CLOSE(fds[0]);
+
+	if (fds[1] > 0)
+		SAFE_CLOSE(fds[1]);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+};
--
2.17.1

