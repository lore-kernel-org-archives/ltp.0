From: Xie Ziyao <xieziyao@huawei.com>
Date: Fri, 16 Jul 2021 18:22:56 +0800
Subject: [LTP] [PATCH 4/5 v2] epoll_pwait: Add test for epoll_pwait02
In-Reply-To: <20210716102257.20882-1-xieziyao@huawei.com>
References: <20210628080424.245911-3-xieziyao@huawei.com>
 <20210716102257.20882-1-xieziyao@huawei.com>
Message-ID: <20210716102257.20882-5-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Basic test for epoll_pwait/epoll_pwait2.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
1. Add test variants to switch between epoll_pwait and epoll_pwait2.

 runtest/syscalls                              |  1 +
 .../kernel/syscalls/epoll_pwait/.gitignore    |  3 +-
 .../syscalls/epoll_pwait/epoll_pwait02.c      | 65 +++++++++++++++++++
 3 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/epoll_pwait/epoll_pwait02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 26786c96a..bed224809 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -166,6 +166,7 @@ epoll_wait01 epoll_wait01
 epoll_wait02 epoll_wait02
 epoll_wait03 epoll_wait03
 epoll_pwait01 epoll_pwait01
+epoll_pwait02 epoll_pwait02

 eventfd01 eventfd01

diff --git a/testcases/kernel/syscalls/epoll_pwait/.gitignore b/testcases/kernel/syscalls/epoll_pwait/.gitignore
index d53943a75..ab049f173 100644
--- a/testcases/kernel/syscalls/epoll_pwait/.gitignore
+++ b/testcases/kernel/syscalls/epoll_pwait/.gitignore
@@ -1 +1,2 @@
-/epoll_pwait01
+epoll_pwait01
+epoll_pwait02
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait02.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait02.c
new file mode 100644
index 000000000..b2733fa41
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait02.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Huawei Technologies Co., Ltd. 2021. All rights reserved.
+ * Author: Xie Ziyao <xieziyao@huawei.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Basic test for epoll_pwait and epoll_pwait2.
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
+	TEST(do_epoll_pwait(efd, &e, 1, -1, NULL));
+
+	if (TST_RET == 1) {
+		tst_res(TPASS, "do_epoll_pwait() succeeded");
+		return;
+	}
+	tst_res(TFAIL, "do_epoll_pwait() returned %li, expected 1", TST_RET);
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

