From: Xie Ziyao <xieziyao@huawei.com>
Date: Tue, 8 Jun 2021 21:57:16 +0800
Subject: [LTP] [PATCH 2/4 v2] syscalls/io_setup: Add io_setup02 test for
 native AIO
In-Reply-To: <20210608135718.36579-1-xieziyao@huawei.com>
References: <20210608135718.36579-1-xieziyao@huawei.com>
Message-ID: <20210608135718.36579-3-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test io_setup invoked via syscall(2):
1. io_setup fails and returns -EFAULT if ctxp is NULL.
2. io_setup fails and returns -EINVAL if ctxp is not initialized to 0.
3. io_setup fails and returns -EINVAL if nr_events is -1.
4. io_setup fails and returns -EAGAIN if nr_events exceeds the limit.
5. io_setup succeeds if both nr_events and ctxp are valid.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
v1->v2:
1. Add .needs_kconfig in this test.
2. Print values not variable names in TST_EXP_PASS().
3. Use TST_EXP_PASS_SILENT() instead of TST_EXP_PASS() in cleanup.

 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/io_setup/.gitignore |  1 +
 .../kernel/syscalls/io_setup/io_setup02.c     | 64 +++++++++++++++++++
 3 files changed, 66 insertions(+)
 create mode 100644 testcases/kernel/syscalls/io_setup/io_setup02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 01d26ad5a..d1ec32754 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -614,6 +614,7 @@ io_pgetevents01 io_pgetevents01
 io_pgetevents02 io_pgetevents02

 io_setup01 io_setup01
+io_setup02 io_setup02
 io_submit01 io_submit01

 keyctl01 keyctl01
diff --git a/testcases/kernel/syscalls/io_setup/.gitignore b/testcases/kernel/syscalls/io_setup/.gitignore
index 4fd03960c..37a4b8321 100644
--- a/testcases/kernel/syscalls/io_setup/.gitignore
+++ b/testcases/kernel/syscalls/io_setup/.gitignore
@@ -1 +1,2 @@
 /io_setup01
+/io_setup02
diff --git a/testcases/kernel/syscalls/io_setup/io_setup02.c b/testcases/kernel/syscalls/io_setup/io_setup02.c
new file mode 100644
index 000000000..292b7440d
--- /dev/null
+++ b/testcases/kernel/syscalls/io_setup/io_setup02.c
@@ -0,0 +1,64 @@
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
+ * Test io_setup invoked via syscall(2):
+ *
+ * 1. io_setup fails and returns -EFAULT if ctxp is NULL.
+ * 2. io_setup fails and returns -EINVAL if ctxp is not initialized to 0.
+ * 3. io_setup fails and returns -EINVAL if nr_events is -1.
+ * 4. io_setup fails and returns -EAGAIN if nr_events exceeds the limit
+ *    of available events.
+ * 5. io_setup succeeds if both nr_events and ctxp are valid.
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
+	TST_EXP_FAIL(tst_syscall(__NR_io_setup, 1, NULL), EFAULT,
+		     "io_setup() when ctxp is NULL");
+
+	memset(&ctx, 1, sizeof(ctx));
+	TST_EXP_FAIL(tst_syscall(__NR_io_setup, 1, &ctx), EINVAL,
+		     "io_setup() when ctxp is not initialized to 0");
+
+	memset(&ctx, 0, sizeof(ctx));
+	TST_EXP_FAIL(tst_syscall(__NR_io_setup, -1, &ctx), EINVAL,
+		     "io_setup() when nr_events is -1");
+
+	unsigned aio_max = 0;
+	if (!access("/proc/sys/fs/aio-max-nr", F_OK)) {
+		SAFE_FILE_SCANF("/proc/sys/fs/aio-max-nr", "%u", &aio_max);
+		TST_EXP_FAIL(tst_syscall(__NR_io_setup, aio_max + 1, &ctx), EAGAIN,
+			     "io_setup() when nr_events exceeds the limit");
+	} else {
+		tst_res(TCONF, "the aio-max-nr file did not exist");
+	}
+
+	TST_EXP_PASS(tst_syscall(__NR_io_setup, 1, &ctx),
+		     "io_setup() when both nr_events and ctxp are valid");
+	TST_EXP_PASS_SILENT(tst_syscall(__NR_io_destroy, ctx));
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

