From: Xie Ziyao <xieziyao@huawei.com>
Date: Tue, 22 Jun 2021 17:11:08 +0800
Subject: [LTP] [PATCH 2/2 v2] io_getevents02: Add io_getevents02 test for
 libaio
In-Reply-To: <20210622091108.249098-1-xieziyao@huawei.com>
References: <20210622091108.249098-1-xieziyao@huawei.com>
Message-ID: <20210622091108.249098-3-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test io_getevents invoked via libaio with invalid ctx and expects it to
return -EINVAL.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
v1->v2:
1. Modification of the output format.

 runtest/syscalls                              |  1 +
 .../kernel/syscalls/io_getevents/.gitignore   |  1 +
 .../syscalls/io_getevents/io_getevents02.c    | 53 +++++++++++++++++++
 3 files changed, 55 insertions(+)
 create mode 100644 testcases/kernel/syscalls/io_getevents/io_getevents02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index fdcfe9e01..d3eb96249 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -610,6 +610,7 @@ io_cancel02 io_cancel02
 io_destroy01 io_destroy01
 io_destroy02 io_destroy02
 io_getevents01 io_getevents01
+io_getevents02 io_getevents02

 io_pgetevents01 io_pgetevents01
 io_pgetevents02 io_pgetevents02
diff --git a/testcases/kernel/syscalls/io_getevents/.gitignore b/testcases/kernel/syscalls/io_getevents/.gitignore
index b3a5f4df1..b57022f73 100644
--- a/testcases/kernel/syscalls/io_getevents/.gitignore
+++ b/testcases/kernel/syscalls/io_getevents/.gitignore
@@ -1 +1,2 @@
 /io_getevents01
+/io_getevents02
diff --git a/testcases/kernel/syscalls/io_getevents/io_getevents02.c b/testcases/kernel/syscalls/io_getevents/io_getevents02.c
new file mode 100644
index 000000000..09eedd4f6
--- /dev/null
+++ b/testcases/kernel/syscalls/io_getevents/io_getevents02.c
@@ -0,0 +1,53 @@
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
+ * Test io_getevents invoked via libaio with invalid ctx and expects it to
+ * return -EINVAL.
+ */
+
+#include "config.h"
+#include "tst_test.h"
+
+#ifdef HAVE_LIBAIO
+#include <libaio.h>
+
+static void run(void)
+{
+	io_context_t ctx;
+
+	memset(&ctx, 0, sizeof(ctx));
+	TEST(io_getevents(ctx, 0, 0, NULL, NULL));
+
+	if (TST_RET == 0) {
+		tst_res(TFAIL, "io_getevents() succeeded unexpectedly");
+		return;
+	}
+
+	if (TST_RET == -EINVAL) {
+		tst_res(TPASS, "io_getevents() failed with EINVAL");
+		return;
+	}
+
+	tst_res(TFAIL, "io_getevents() failed unexpectedly %s (%ld) expected EINVAL",
+		tst_strerrno(-TST_RET), -TST_RET);
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

