From: Xie Ziyao <xieziyao@huawei.com>
Date: Tue, 17 Aug 2021 14:49:23 +0800
Subject: [LTP] [PATCH 6/7] epoll_create: Add test for epoll_create01
In-Reply-To: <20210817064924.127970-1-xieziyao@huawei.com>
References: <20210817064924.127970-1-xieziyao@huawei.com>
Message-ID: <20210817064924.127970-7-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Verify that epoll_create return a nonnegative file descriptor on success.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/epoll_create/.gitignore   |  1 +
 .../kernel/syscalls/epoll_create/Makefile     |  9 +++++
 .../syscalls/epoll_create/epoll_create01.c    | 40 +++++++++++++++++++
 4 files changed, 51 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_create/.gitignore
 create mode 100644 testcases/kernel/syscalls/epoll_create/Makefile
 create mode 100644 testcases/kernel/syscalls/epoll_create/epoll_create01.c

diff --git a/runtest/syscalls b/runtest/syscalls
index f6fe140b2..2540905a0 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -156,6 +156,7 @@ dup205 dup205
 dup3_01 dup3_01
 dup3_02 dup3_02

+epoll_create01 epoll_create01
 epoll_create1_01 epoll_create1_01
 epoll_create1_02 epoll_create1_02
 epoll01 epoll-ltp
diff --git a/testcases/kernel/syscalls/epoll_create/.gitignore b/testcases/kernel/syscalls/epoll_create/.gitignore
new file mode 100644
index 000000000..0ed4d940a
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_create/.gitignore
@@ -0,0 +1 @@
+epoll_create01
diff --git a/testcases/kernel/syscalls/epoll_create/Makefile b/testcases/kernel/syscalls/epoll_create/Makefile
new file mode 100644
index 000000000..0e0d8c56f
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_create/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Huawei Technologies Co., Ltd. 2021. All rights reserved.
+# Author: Xie Ziyao <xieziyao@huawei.com>
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/epoll_create/epoll_create01.c b/testcases/kernel/syscalls/epoll_create/epoll_create01.c
new file mode 100644
index 000000000..53cb1dfe1
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_create/epoll_create01.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Huawei Technologies Co., Ltd. 2021. All rights reserved.
+ * Author: Xie Ziyao <xieziyao@huawei.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that epoll_create return a nonnegative file descriptor on success.
+ *
+ * The size argument informed the kernel of the number of file descriptors
+ * that the caller expected to add to the epoll instance, but it is no longer
+ * required.
+ */
+
+#include <sys/epoll.h>
+
+#include "tst_test.h"
+#include "lapi/epoll.h"
+#include "lapi/syscalls.h"
+
+static int tc[] = {1, INT_MAX};
+
+static void run(unsigned int n)
+{
+	int fd;
+
+	fd = tst_syscall(__NR_epoll_create, tc[n]);
+	if (fd < 0)
+		tst_brk(TFAIL | TERRNO, "epoll_create(%d) failed", tc[n]);
+	tst_res(TPASS, "epoll_create(%d)", tc[n]);
+
+	SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tc),
+	.test = run,
+};
--
2.17.1

