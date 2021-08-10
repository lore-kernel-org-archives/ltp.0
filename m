From: Xie Ziyao <xieziyao@huawei.com>
Date: Tue, 10 Aug 2021 19:00:23 +0800
Subject: [LTP] [PATCH 1/2] epoll_pwait: Add invalid sigmask test for
 epoll_pwait04
In-Reply-To: <20210810110024.106436-1-xieziyao@huawei.com>
References: <20210810110024.106436-1-xieziyao@huawei.com>
Message-ID: <20210810110024.106436-2-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Verify that, epoll_pwait() and epoll_pwait2() return -1 and set errno to
EFAULT with a sigmask points outside user's accessible address space.

Fixes: #792
Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/epoll_pwait/.gitignore    |  1 +
 .../syscalls/epoll_pwait/epoll_pwait04.c      | 61 +++++++++++++++++++
 3 files changed, 63 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_pwait/epoll_pwait04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 9af5aa5c0..206281f6e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -168,6 +168,7 @@ epoll_wait03 epoll_wait03
 epoll_pwait01 epoll_pwait01
 epoll_pwait02 epoll_pwait02
 epoll_pwait03 epoll_pwait03
+epoll_pwait04 epoll_pwait04

 eventfd01 eventfd01

diff --git a/testcases/kernel/syscalls/epoll_pwait/.gitignore b/testcases/kernel/syscalls/epoll_pwait/.gitignore
index 1d16367e6..cdefffa2d 100644
--- a/testcases/kernel/syscalls/epoll_pwait/.gitignore
+++ b/testcases/kernel/syscalls/epoll_pwait/.gitignore
@@ -1,3 +1,4 @@
 epoll_pwait01
 epoll_pwait02
 epoll_pwait03
+epoll_pwait04
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait04.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait04.c
new file mode 100644
index 000000000..2c855dab6
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait04.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Huawei Technologies Co., Ltd. 2021. All rights reserved.
+ * Author: Xie Ziyao <xieziyao@huawei.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that, epoll_pwait() and epoll_pwait2() return -1 and set errno to
+ * EFAULT with a sigmask points outside user's accessible address space.
+ */
+
+#include <sys/epoll.h>
+
+#include "tst_test.h"
+#include "epoll_pwait_var.h"
+
+static int efd, sfd[2];
+static struct epoll_event e;
+
+static void run(void)
+{
+	TST_EXP_FAIL(do_epoll_pwait(efd, &e, 1, -1, tst_get_bad_addr(NULL)),
+		     EFAULT, "with an invalid sigmask pointer");
+}
+
+static void setup(void)
+{
+	epoll_pwait_info();
+
+	SAFE_SOCKETPAIR(AF_UNIX, SOCK_STREAM, 0, sfd);
+
+	efd = epoll_create(1);
+	if (efd == -1)
+		tst_brk(TBROK | TERRNO, "epoll_create()");
+
+	e.events = EPOLLIN;
+	if (epoll_ctl(efd, EPOLL_CTL_ADD, sfd[0], &e))
+		tst_brk(TBROK | TERRNO, "epoll_clt(..., EPOLL_CTL_ADD, ...)");
+	SAFE_WRITE(1, sfd[1], "w", 1);
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
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_variants = TEST_VARIANTS,
+};
--
2.17.1

