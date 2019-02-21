From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 21 Feb 2019 14:30:12 +0530
Subject: [LTP] [PATCH v4 5/9] syscalls/sync: add sync device test-case
In-Reply-To: <1550739616-24054-1-git-send-email-sumit.garg@linaro.org>
References: <1550739616-24054-1-git-send-email-sumit.garg@linaro.org>
Message-ID: <1550739616-24054-6-git-send-email-sumit.garg@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

sync03 tests to sync file having large dirty file pages to block device.
It tests all supported filesystems on a test block device.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 runtest/syscalls                          |  1 +
 testcases/kernel/syscalls/sync/.gitignore |  1 +
 testcases/kernel/syscalls/sync/sync03.c   | 60 +++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)
 create mode 100644 testcases/kernel/syscalls/sync/sync03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 9442740..dba0dee 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1345,6 +1345,7 @@ symlinkat01 symlinkat01
 
 sync01 sync01
 sync02 sync02
+sync03 sync03
 
 syncfs01 syncfs01
 
diff --git a/testcases/kernel/syscalls/sync/.gitignore b/testcases/kernel/syscalls/sync/.gitignore
index d8d304d..04f4710 100644
--- a/testcases/kernel/syscalls/sync/.gitignore
+++ b/testcases/kernel/syscalls/sync/.gitignore
@@ -1,2 +1,3 @@
 /sync01
 /sync02
+/sync03
diff --git a/testcases/kernel/syscalls/sync/sync03.c b/testcases/kernel/syscalls/sync/sync03.c
new file mode 100644
index 0000000..4dc2ff6
--- /dev/null
+++ b/testcases/kernel/syscalls/sync/sync03.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Linaro Limited. All rights reserved.
+ * Author: Sumit Garg <sumit.garg@linaro.org>
+ */
+
+/*
+ * sync03
+ *
+ * It basically tests sync() to sync test file having large dirty file pages
+ * to block device. Also, it tests all supported filesystems on a test block
+ * device.
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <sys/types.h>
+#include "tst_test.h"
+
+#define MNTPOINT		"mnt_point"
+#define TST_FILE		MNTPOINT"/test"
+#define TST_FILE_SIZE_MB	32
+#define SIZE_MB			(1024*1024)
+#define MODE			0644
+
+static void verify_sync(void)
+{
+	int fd;
+	unsigned long written;
+
+	fd = SAFE_OPEN(TST_FILE, O_RDWR|O_CREAT, MODE);
+
+	tst_dev_bytes_written(tst_device->dev);
+
+	tst_fill_fd(fd, 0, SIZE_MB, TST_FILE_SIZE_MB);
+
+	TEST_VOID(sync());
+
+	if (TST_RET)
+		tst_brk(TFAIL | TTERRNO, "sync() failed");
+
+	written = tst_dev_bytes_written(tst_device->dev);
+
+	SAFE_CLOSE(fd);
+
+	if (written >= SIZE_MB * TST_FILE_SIZE_MB)
+		tst_res(TPASS, "Test file synced to device");
+	else
+		tst_res(TFAIL, "Failed to sync test file to device");
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.mount_device = 1,
+	.all_filesystems = 1,
+	.mntpoint = MNTPOINT,
+	.test_all = verify_sync,
+};
-- 
2.7.4

