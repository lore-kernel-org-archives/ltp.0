From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 19 Feb 2019 14:58:17 +0530
Subject: [LTP] [PATCH v3 4/7] syscalls/fsync: add sync device test-case
In-Reply-To: <1550568500-10871-1-git-send-email-sumit.garg@linaro.org>
References: <1550568500-10871-1-git-send-email-sumit.garg@linaro.org>
Message-ID: <1550568500-10871-5-git-send-email-sumit.garg@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

fsync04 tests to sync file having large dirty file pages to block
device. Also, it tests all supported filesystems on a test block device.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 runtest/syscalls                           |  1 +
 testcases/kernel/syscalls/fsync/.gitignore |  1 +
 testcases/kernel/syscalls/fsync/fsync04.c  | 61 ++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fsync/fsync04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index dba0dee..0d09509 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -347,6 +347,7 @@ fstatfs02_64 fstatfs02_64
 fsync01 fsync01
 fsync02 fsync02
 fsync03 fsync03
+fsync04 fsync04
 
 ftruncate01 ftruncate01
 ftruncate01_64 ftruncate01_64
diff --git a/testcases/kernel/syscalls/fsync/.gitignore b/testcases/kernel/syscalls/fsync/.gitignore
index 3c694a4..4b5ea83 100644
--- a/testcases/kernel/syscalls/fsync/.gitignore
+++ b/testcases/kernel/syscalls/fsync/.gitignore
@@ -1,3 +1,4 @@
 /fsync01
 /fsync02
 /fsync03
+/fsync04
diff --git a/testcases/kernel/syscalls/fsync/fsync04.c b/testcases/kernel/syscalls/fsync/fsync04.c
new file mode 100644
index 0000000..72c73ce
--- /dev/null
+++ b/testcases/kernel/syscalls/fsync/fsync04.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Linaro Limited. All rights reserved.
+ * Author: Sumit Garg <sumit.garg@linaro.org>
+ */
+
+/*
+ * fsync04
+ *
+ * It basically tests fsync() to sync test file having large dirty file pages
+ * to block device. Also, it tests all supported filesystems on a test block
+ * device.
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
+static void verify_fsync(void)
+{
+	int fd;
+
+	fd = tst_sync_device_write(TST_FILE, TST_FILE_SIZE_MB);
+
+	TEST(fsync(fd));
+	if (TST_RET != 0)
+		tst_brk(TFAIL | TTERRNO, "fsync(fd) failed");
+
+	if (tst_sync_device_check(TST_FILE_SIZE_MB))
+		tst_res(TPASS, "Test file synced to device");
+	else
+		tst_res(TFAIL, "Failed to sync test file to device");
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
+	.test_all = verify_fsync,
+};
-- 
2.7.4

