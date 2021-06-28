From: Xie Ziyao <xieziyao@huawei.com>
Date: Mon, 28 Jun 2021 16:04:23 +0800
Subject: [LTP] [PATCH 2/3] epoll_pwait2: Add test for epoll_pwait201
In-Reply-To: <20210628080424.245911-1-xieziyao@huawei.com>
References: <20210628080424.245911-1-xieziyao@huawei.com>
Message-ID: <20210628080424.245911-3-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Basic test for epoll_pwait2().

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/epoll_pwait2/.gitignore   |  1 +
 .../kernel/syscalls/epoll_pwait2/Makefile     |  9 +++
 .../syscalls/epoll_pwait2/epoll_pwait201.c    | 62 +++++++++++++++++++
 4 files changed, 73 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_pwait2/.gitignore
 create mode 100644 testcases/kernel/syscalls/epoll_pwait2/Makefile
 create mode 100644 testcases/kernel/syscalls/epoll_pwait2/epoll_pwait201.c

diff --git a/runtest/syscalls b/runtest/syscalls
index d3eb96249..8a6b8ba20 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -166,6 +166,7 @@ epoll_wait01 epoll_wait01
 epoll_wait02 epoll_wait02
 epoll_wait03 epoll_wait03
 epoll_pwait01 epoll_pwait01
+epoll_pwait201 epoll_pwait201

 eventfd01 eventfd01

diff --git a/testcases/kernel/syscalls/epoll_pwait2/.gitignore b/testcases/kernel/syscalls/epoll_pwait2/.gitignore
new file mode 100644
index 000000000..2298cf9d9
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_pwait2/.gitignore
@@ -0,0 +1 @@
+epoll_pwait201
diff --git a/testcases/kernel/syscalls/epoll_pwait2/Makefile b/testcases/kernel/syscalls/epoll_pwait2/Makefile
new file mode 100644
index 000000000..051db0b20
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_pwait2/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2021 HUAWEI LIMITED
+# Author: Xie Ziyao <xieziyao@huawei.com>
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/epoll_pwait2/epoll_pwait201.c b/testcases/kernel/syscalls/epoll_pwait2/epoll_pwait201.c
new file mode 100644
index 000000000..a3fadc065
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_pwait2/epoll_pwait201.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 HUAWEI LIMITED
+ * Author: Xie Ziyao <xieziyao@huawei.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Basic test for epoll_pwait2().
+ */
+
+#include <sys/epoll.h>
+
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+
+static int efd, sfd[2];
+static struct epoll_event e;
+
+static void run(void)
+{
+	TEST(tst_syscall(__NR_epoll_pwait2, efd, &e, 1, NULL, NULL, 0));
+
+	if (TST_RET == 1) {
+		tst_res(TPASS, "epoll_pwait2() succeeded");
+		return;
+	}
+	tst_res(TFAIL, "epoll_pwait2() returned %li, expected 1", TST_RET);
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
+};
--
2.17.1

