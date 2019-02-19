From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 19 Feb 2019 14:58:16 +0530
Subject: [LTP] [PATCH v3 3/7] syscalls/sync: add sync device test-case
In-Reply-To: <1550568500-10871-1-git-send-email-sumit.garg@linaro.org>
References: <1550568500-10871-1-git-send-email-sumit.garg@linaro.org>
Message-ID: <1550568500-10871-4-git-send-email-sumit.garg@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

sync03 tests to sync file having large dirty file pages to block device.
It tests all supported filesystems on a test block device.

Also define TEST_VOID macro in tst_test.h.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 include/tst_test.h                        |  7 ++++
 runtest/syscalls                          |  1 +
 testcases/kernel/syscalls/sync/.gitignore |  1 +
 testcases/kernel/syscalls/sync/sync03.c   | 59 +++++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+)
 create mode 100644 testcases/kernel/syscalls/sync/sync03.c

diff --git a/include/tst_test.h b/include/tst_test.h
index 12dda2e..03c88e3 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -216,6 +216,13 @@ void tst_reinit(void);
 		TST_ERR = errno; \
 	} while (0)
 
+#define TEST_VOID(SCALL) \
+	do { \
+		errno = 0; \
+		SCALL; \
+		TST_ERR = errno; \
+	} while (0)
+
 extern long TST_RET;
 extern int TST_ERR;
 
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
index 0000000..419f9b9
--- /dev/null
+++ b/testcases/kernel/syscalls/sync/sync03.c
@@ -0,0 +1,59 @@
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
+#include "tst_sync_device.h"
+#include "tst_test.h"
+
+#define MNTPOINT		"mnt_point"
+#define TST_FILE		MNTPOINT"/test"
+#define TST_FILE_SIZE_MB	32
+
+static void verify_sync(void)
+{
+	tst_sync_device_write(TST_FILE, TST_FILE_SIZE_MB);
+
+	TEST_VOID(sync());
+	if (TST_RET != 0)
+		tst_brk(TFAIL | TTERRNO, "sync() failed");
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
+	.test_all = verify_sync,
+};
-- 
2.7.4

