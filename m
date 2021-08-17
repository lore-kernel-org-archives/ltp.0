From: Xie Ziyao <xieziyao@huawei.com>
Date: Tue, 17 Aug 2021 14:49:24 +0800
Subject: [LTP] [PATCH 7/7] epoll_create: Add test for epoll_create02
In-Reply-To: <20210817064924.127970-1-xieziyao@huawei.com>
References: <20210817064924.127970-1-xieziyao@huawei.com>
Message-ID: <20210817064924.127970-8-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Verify that epoll_create returns -1 and set errno to EINVAL if size is
not positive.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/epoll_create/.gitignore   |  1 +
 .../syscalls/epoll_create/epoll_create02.c    | 37 +++++++++++++++++++
 3 files changed, 39 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_create/epoll_create02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 2540905a0..d5a1e86e8 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -157,6 +157,7 @@ dup3_01 dup3_01
 dup3_02 dup3_02

 epoll_create01 epoll_create01
+epoll_create02 epoll_create02
 epoll_create1_01 epoll_create1_01
 epoll_create1_02 epoll_create1_02
 epoll01 epoll-ltp
diff --git a/testcases/kernel/syscalls/epoll_create/.gitignore b/testcases/kernel/syscalls/epoll_create/.gitignore
index 0ed4d940a..5c16cfa8c 100644
--- a/testcases/kernel/syscalls/epoll_create/.gitignore
+++ b/testcases/kernel/syscalls/epoll_create/.gitignore
@@ -1 +1,2 @@
 epoll_create01
+epoll_create02
diff --git a/testcases/kernel/syscalls/epoll_create/epoll_create02.c b/testcases/kernel/syscalls/epoll_create/epoll_create02.c
new file mode 100644
index 000000000..bbc493906
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_create/epoll_create02.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Huawei Technologies Co., Ltd. 2021. All rights reserved.
+ * Author: Xie Ziyao <xieziyao@huawei.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that epoll_create returns -1 and set errno to EINVAL if size is not
+ * positive.
+ */
+
+#include <sys/epoll.h>
+
+#include "tst_test.h"
+#include "lapi/epoll.h"
+#include "lapi/syscalls.h"
+
+static struct test_case_t {
+	int size;
+	int exp_err;
+} tc[] = {
+	{0, EINVAL},
+	{-1, EINVAL}
+};
+
+static void run(unsigned int n)
+{
+	TST_EXP_FAIL(tst_syscall(__NR_epoll_create, tc[n].size),
+		     tc[n].exp_err, "create(%d)", tc[n].size);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tc),
+	.test = run,
+};
--
2.17.1

