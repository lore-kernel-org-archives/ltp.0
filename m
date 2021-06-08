From: Xie Ziyao <xieziyao@huawei.com>
Date: Tue, 8 Jun 2021 21:57:15 +0800
Subject: [LTP] [PATCH 1/4 v2] syscalls/io_destroy: Add io_destroy02 test for
 native AIO
In-Reply-To: <20210608135718.36579-1-xieziyao@huawei.com>
References: <20210608135718.36579-1-xieziyao@huawei.com>
Message-ID: <20210608135718.36579-2-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test io_destroy invoked via syscall(2) with an invalid ctx and expects it to return EINVAL.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
v1->v2:
1. Add .needs_kconfig in this test.
2. Print values not variable names in TST_EXP_PASS().

 runtest/syscalls                              |  1 +
 .../kernel/syscalls/io_destroy/.gitignore     |  1 +
 .../kernel/syscalls/io_destroy/io_destroy02.c | 38 +++++++++++++++++++
 3 files changed, 40 insertions(+)
 create mode 100644 testcases/kernel/syscalls/io_destroy/io_destroy02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 9df181b76..01d26ad5a 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -607,6 +607,7 @@ ioprio_set03 ioprio_set03

 io_cancel01 io_cancel01
 io_destroy01 io_destroy01
+io_destroy02 io_destroy02
 io_getevents01 io_getevents01

 io_pgetevents01 io_pgetevents01
diff --git a/testcases/kernel/syscalls/io_destroy/.gitignore b/testcases/kernel/syscalls/io_destroy/.gitignore
index 025aa0f4a..48a16cd2f 100644
--- a/testcases/kernel/syscalls/io_destroy/.gitignore
+++ b/testcases/kernel/syscalls/io_destroy/.gitignore
@@ -1 +1,2 @@
 /io_destroy01
+/io_destroy02
diff --git a/testcases/kernel/syscalls/io_destroy/io_destroy02.c b/testcases/kernel/syscalls/io_destroy/io_destroy02.c
new file mode 100644
index 000000000..c8cc63818
--- /dev/null
+++ b/testcases/kernel/syscalls/io_destroy/io_destroy02.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Crackerjack Project., 2007
+ * Ported from Crackerjack to LTP by Masatake YAMATO <yamato@redhat.com>
+ * Copyright (c) 2011 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) 2017 Xiao Yang <yangx.jy@cn.fujitsu.com>
+ * Copyright (c) 2021 Xie Ziyao <xieziyao@huawei.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Test io_destroy invoked via syscall(2) with an invalid ctx and expects
+ * it to return EINVAL.
+ */
+
+#include <linux/aio_abi.h>
+
+#include "config.h"
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+
+static void run(void)
+{
+	aio_context_t ctx;
+
+	memset(&ctx, 0xff, sizeof(ctx));
+	TST_EXP_FAIL(tst_syscall(__NR_io_destroy, ctx), EINVAL,
+		     "io_destroy() with an invalid ctx");
+}
+
+static struct tst_test test = {
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_AIO=y",
+		NULL
+	},
+	.test_all = run,
+};
--
2.17.1

