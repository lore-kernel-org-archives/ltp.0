From: Xie Ziyao <xieziyao@huawei.com>
Date: Tue, 17 Aug 2021 14:49:22 +0800
Subject: [LTP] [PATCH 5/7] epoll_create1: Add test for epoll_create1_02
In-Reply-To: <20210817064924.127970-1-xieziyao@huawei.com>
References: <20210817064924.127970-1-xieziyao@huawei.com>
Message-ID: <20210817064924.127970-6-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Verify that epoll_create1 returns -1 and set errno to EINVAL with an invalid
value specified in flags.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/epoll_create1/.gitignore  |  3 +-
 .../syscalls/epoll_create1/epoll_create1_02.c | 38 +++++++++++++++++++
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/runtest/syscalls b/runtest/syscalls
index b28d19ac7..f6fe140b2 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -157,6 +157,7 @@ dup3_01 dup3_01
 dup3_02 dup3_02

 epoll_create1_01 epoll_create1_01
+epoll_create1_02 epoll_create1_02
 epoll01 epoll-ltp
 epoll_ctl01 epoll_ctl01
 epoll_ctl02 epoll_ctl02
diff --git a/testcases/kernel/syscalls/epoll_create1/.gitignore b/testcases/kernel/syscalls/epoll_create1/.gitignore
index 7de2e4231..3e0482de9 100644
--- a/testcases/kernel/syscalls/epoll_create1/.gitignore
+++ b/testcases/kernel/syscalls/epoll_create1/.gitignore
@@ -1 +1,2 @@
-/epoll_create1_01
+epoll_create1_01
+epoll_create1_02
diff --git a/testcases/kernel/syscalls/epoll_create1/epoll_create1_02.c b/testcases/kernel/syscalls/epoll_create1/epoll_create1_02.c
index e69de29bb..2308a65d6 100644
--- a/testcases/kernel/syscalls/epoll_create1/epoll_create1_02.c
+++ b/testcases/kernel/syscalls/epoll_create1/epoll_create1_02.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Huawei Technologies Co., Ltd. 2021. All rights reserved.
+ * Author: Xie Ziyao <xieziyao@huawei.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that epoll_create1 returns -1 and set errno to EINVAL with an invalid
+ * value specified in flags.
+ */
+
+#include <sys/epoll.h>
+
+#include "tst_test.h"
+#include "lapi/epoll.h"
+#include "lapi/syscalls.h"
+
+static struct test_case_t {
+	int flags;
+	int exp_err;
+	const char *desc;
+} tc[] = {
+	{-1, EINVAL, "-1"},
+	{EPOLL_CLOEXEC + 1, EINVAL, "EPOLL_CLOEXEC+1"}
+};
+
+static void run(unsigned int n)
+{
+	TST_EXP_FAIL(tst_syscall(__NR_epoll_create1, tc[n].flags),
+		     tc[n].exp_err, "create(%s)", tc[n].desc);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tc),
+	.test = run,
+};
--
2.17.1

