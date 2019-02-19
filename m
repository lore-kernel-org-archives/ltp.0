From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 19 Feb 2019 14:58:18 +0530
Subject: [LTP] [PATCH v3 5/7] syscalls/fdatasync: add sync device test-case
In-Reply-To: <1550568500-10871-1-git-send-email-sumit.garg@linaro.org>
References: <1550568500-10871-1-git-send-email-sumit.garg@linaro.org>
Message-ID: <1550568500-10871-6-git-send-email-sumit.garg@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

fdatasync03 tests to sync file data having large dirty file pages to
block device. Also, it tests all supported filesystems on a test block
device.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 runtest/syscalls                                  |  1 +
 testcases/kernel/syscalls/fdatasync/.gitignore    |  1 +
 testcases/kernel/syscalls/fdatasync/fdatasync03.c | 61 +++++++++++++++++++++++
 3 files changed, 63 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fdatasync/fdatasync03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 0d09509..aaad651 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -291,6 +291,7 @@ fcntl36_64 fcntl36_64
 
 fdatasync01 fdatasync01
 fdatasync02 fdatasync02
+fdatasync03 fdatasync03
 
 fgetxattr01 fgetxattr01
 fgetxattr02 fgetxattr02
diff --git a/testcases/kernel/syscalls/fdatasync/.gitignore b/testcases/kernel/syscalls/fdatasync/.gitignore
index d1d3cba..dc56ad7 100644
--- a/testcases/kernel/syscalls/fdatasync/.gitignore
+++ b/testcases/kernel/syscalls/fdatasync/.gitignore
@@ -1,2 +1,3 @@
 /fdatasync01
 /fdatasync02
+/fdatasync03
diff --git a/testcases/kernel/syscalls/fdatasync/fdatasync03.c b/testcases/kernel/syscalls/fdatasync/fdatasync03.c
new file mode 100644
index 0000000..3a4f694
--- /dev/null
+++ b/testcases/kernel/syscalls/fdatasync/fdatasync03.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Linaro Limited. All rights reserved.
+ * Author: Sumit Garg <sumit.garg@linaro.org>
+ */
+
+/*
+ * fdatasync03
+ *
+ * It basically tests fdatasync() to sync test file data having large dirty
+ * file pages to block device. Also, it tests all supported filesystems on a
+ * test block device.
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <sys/types.h>
+#include "tst_sync_device.h"
+#include "tst_test.h"
+
+#define MNTPOINT		"mnt_point"
+#define TST_FILE		MNTPOINT"/test"
+#define TST_FILE_SIZE_MB	32
+
+static void verify_fdatasync(void)
+{
+	int fd;
+
+	fd = tst_sync_device_write(TST_FILE, TST_FILE_SIZE_MB);
+
+	TEST(fdatasync(fd));
+	if (TST_RET != 0)
+		tst_brk(TFAIL | TTERRNO, "fdatasync(fd) failed");
+
+	if (tst_sync_device_check(TST_FILE_SIZE_MB))
+		tst_res(TPASS, "Test file data synced to device");
+	else
+		tst_res(TFAIL, "Failed to sync test file data to device");
+}
+
+static void setup(void)
+{
+	tst_sync_device_init(tst_device->dev);
+}
+
+static void cleanup(void)
+{
+	tst_sync_device_cleanup();
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.mount_device = 1,
+	.all_filesystems = 1,
+	.mntpoint = MNTPOINT,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_fdatasync,
+};
-- 
2.7.4

