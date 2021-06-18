From: Xie Ziyao <xieziyao@huawei.com>
Date: Fri, 18 Jun 2021 17:42:04 +0800
Subject: [LTP] [PATCH 1/7] io_cancel02: Add io_cancel02 test for libaio
In-Reply-To: <20210618094210.183027-1-xieziyao@huawei.com>
References: <20210618094210.183027-1-xieziyao@huawei.com>
Message-ID: <20210618094210.183027-2-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test io_cancel invoked via libaio with one of the data structures
points to invalid data and expects it to return -EFAULT.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/io_cancel/.gitignore      |  1 +
 .../kernel/syscalls/io_cancel/io_cancel02.c   | 51 +++++++++++++++++++
 3 files changed, 53 insertions(+)
 create mode 100644 testcases/kernel/syscalls/io_cancel/io_cancel02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 6c42c0b09..28ffa1286 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -606,6 +606,7 @@ ioprio_set02 ioprio_set02
 ioprio_set03 ioprio_set03

 io_cancel01 io_cancel01
+io_cancel02 io_cancel02
 io_destroy01 io_destroy01
 io_destroy02 io_destroy02
 io_getevents01 io_getevents01
diff --git a/testcases/kernel/syscalls/io_cancel/.gitignore b/testcases/kernel/syscalls/io_cancel/.gitignore
index 1728695a6..f01afa592 100644
--- a/testcases/kernel/syscalls/io_cancel/.gitignore
+++ b/testcases/kernel/syscalls/io_cancel/.gitignore
@@ -1 +1,2 @@
 /io_cancel01
+/io_cancel02
diff --git a/testcases/kernel/syscalls/io_cancel/io_cancel02.c b/testcases/kernel/syscalls/io_cancel/io_cancel02.c
new file mode 100644
index 000000000..9fc131065
--- /dev/null
+++ b/testcases/kernel/syscalls/io_cancel/io_cancel02.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Crackerjack Project., 2007
+ * Ported from Crackerjack to LTP by Masatake YAMATO <yamato@redhat.com>
+ * Copyright (c) 2011 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) 2021 Xie Ziyao <xieziyao@huawei.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Test io_cancel invoked via libaio with one of the data structures points
+ * to invalid data and expects it to return -EFAULT.
+ */
+
+#include "config.h"
+#include "tst_test.h"
+
+#ifdef HAVE_LIBAIO
+#define EXP_RET (-EFAULT)
+
+#include <libaio.h>
+
+static void run(void)
+{
+	io_context_t ctx;
+
+	memset(&ctx, 0, sizeof(ctx));
+	TEST(io_cancel(ctx, NULL, NULL));
+
+	if (TST_RET == 0)
+		tst_res(TFAIL, "call succeeded unexpectedly");
+	else if (TST_RET == EXP_RET)
+		tst_res(TPASS, "io_cancel(ctx, NULL, NULL) returns %ld : %s",
+			TST_RET, strerror(-TST_RET));
+	else
+		tst_res(TFAIL, "io_cancel(ctx, NULL, NULL) returns %ld : %s, expected %d : %s",
+			TST_RET, strerror(-TST_RET), EXP_RET, strerror(-EXP_RET));
+}
+
+static struct tst_test test = {
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_AIO=y",
+		NULL
+	},
+	.test_all = run,
+};
+
+#else
+TST_TEST_TCONF("test requires libaio and it's development packages");
+#endif
--
2.17.1

