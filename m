From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 19 Feb 2019 14:58:15 +0530
Subject: [LTP] [PATCH v3 2/7] syscalls: add syncfs() sync device test-case
In-Reply-To: <1550568500-10871-1-git-send-email-sumit.garg@linaro.org>
References: <1550568500-10871-1-git-send-email-sumit.garg@linaro.org>
Message-ID: <1550568500-10871-3-git-send-email-sumit.garg@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

syncfs01 tests to sync filesystem having large dirty file pages to block
device. Also, it tests all supported filesystems on a test block device.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 configure.ac                                    |  1 +
 include/lapi/syncfs.h                           | 21 ++++++++
 m4/ltp-syncfs.m4                                | 10 ++++
 runtest/syscalls                                |  2 +
 testcases/kernel/syscalls/syncfs/.gitignore     |  1 +
 testcases/kernel/syscalls/syncfs/Makefile       |  8 ++++
 testcases/kernel/syscalls/syncfs/check_syncfs.h | 19 ++++++++
 testcases/kernel/syscalls/syncfs/syncfs01.c     | 64 +++++++++++++++++++++++++
 8 files changed, 126 insertions(+)
 create mode 100644 include/lapi/syncfs.h
 create mode 100644 m4/ltp-syncfs.m4
 create mode 100644 testcases/kernel/syscalls/syncfs/.gitignore
 create mode 100644 testcases/kernel/syscalls/syncfs/Makefile
 create mode 100644 testcases/kernel/syscalls/syncfs/check_syncfs.h
 create mode 100644 testcases/kernel/syscalls/syncfs/syncfs01.c

diff --git a/configure.ac b/configure.ac
index caea344..9122b6d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -231,6 +231,7 @@ LTP_CHECK_TPACKET_V3
 LTP_CHECK_RLIMIT64
 LTP_DETECT_HOST_CPU
 LTP_CHECK_PERF_EVENT
+LTP_CHECK_SYNCFS
 
 if test "x$with_numa" = xyes; then
 	LTP_CHECK_SYSCALL_NUMA
diff --git a/include/lapi/syncfs.h b/include/lapi/syncfs.h
new file mode 100644
index 0000000..1341c6b
--- /dev/null
+++ b/include/lapi/syncfs.h
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Linaro Limited. All rights reserved.
+ * Author: Sumit Garg <sumit.garg@linaro.org>
+ */
+
+#ifndef SYNCFS_H
+#define SYNCFS_H
+
+#include <sys/types.h>
+#include "config.h"
+#include "lapi/syscalls.h"
+
+#if !defined(HAVE_SYNCFS)
+int syncfs(int fd)
+{
+	return tst_syscall(__NR_syncfs, fd);
+}
+#endif
+
+#endif /* SYNCFS_H */
diff --git a/m4/ltp-syncfs.m4 b/m4/ltp-syncfs.m4
new file mode 100644
index 0000000..836a055
--- /dev/null
+++ b/m4/ltp-syncfs.m4
@@ -0,0 +1,10 @@
+dnl SPDX-License-Identifier: GPL-2.0-or-later
+dnl Copyright (c) 2019 Linaro Limited. All rights reserved.
+
+dnl
+dnl LTP_CHECK_SYNCFS
+dnl ----------------------------
+dnl
+AC_DEFUN([LTP_CHECK_SYNCFS],[
+AC_CHECK_FUNCS(syncfs,,)
+])
diff --git a/runtest/syscalls b/runtest/syscalls
index 668c87c..9442740 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1346,6 +1346,8 @@ symlinkat01 symlinkat01
 sync01 sync01
 sync02 sync02
 
+syncfs01 syncfs01
+
 #testcases for sync_file_range
 sync_file_range01 sync_file_range01
 
diff --git a/testcases/kernel/syscalls/syncfs/.gitignore b/testcases/kernel/syscalls/syncfs/.gitignore
new file mode 100644
index 0000000..6066295
--- /dev/null
+++ b/testcases/kernel/syscalls/syncfs/.gitignore
@@ -0,0 +1 @@
+syncfs01
diff --git a/testcases/kernel/syscalls/syncfs/Makefile b/testcases/kernel/syscalls/syncfs/Makefile
new file mode 100644
index 0000000..3e6c2f4
--- /dev/null
+++ b/testcases/kernel/syscalls/syncfs/Makefile
@@ -0,0 +1,8 @@
+# Copyright (c) 2019 - Linaro Limited. All rights reserved.
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+top_srcdir             ?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/syncfs/check_syncfs.h b/testcases/kernel/syscalls/syncfs/check_syncfs.h
new file mode 100644
index 0000000..26991d2
--- /dev/null
+++ b/testcases/kernel/syscalls/syncfs/check_syncfs.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Linaro Limited. All rights reserved.
+ * Author: Sumit Garg <sumit.garg@linaro.org>
+ */
+
+#ifndef CHECK_SYNCFS_H
+#define CHECK_SYNCFS_H
+
+void check_syncfs(void)
+{
+	int ret;
+
+	ret = syncfs(-1);
+	if (ret == -1 && errno == EINVAL)
+		tst_brk(TCONF, "syncfs() not supported");
+}
+
+#endif /* CHECK_SYNCFS_H */
diff --git a/testcases/kernel/syscalls/syncfs/syncfs01.c b/testcases/kernel/syscalls/syncfs/syncfs01.c
new file mode 100644
index 0000000..7c3efb0
--- /dev/null
+++ b/testcases/kernel/syscalls/syncfs/syncfs01.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Linaro Limited. All rights reserved.
+ * Author: Sumit Garg <sumit.garg@linaro.org>
+ */
+
+/*
+ * Test syncfs
+ *
+ * It basically tests syncfs() to sync filesystem having large dirty file
+ * pages to block device. Also, it tests all supported filesystems on a test
+ * block device.
+ */
+
+#define _GNU_SOURCE
+#include <stdlib.h>
+#include <stdio.h>
+#include <sys/types.h>
+#include "lapi/syncfs.h"
+#include "tst_sync_device.h"
+#include "tst_test.h"
+#include "check_syncfs.h"
+
+#define MNTPOINT		"mnt_point"
+#define TST_FILE		MNTPOINT"/test"
+#define TST_FILE_SIZE_MB	32
+
+static void verify_syncfs(void)
+{
+	int fd;
+
+	fd = tst_sync_device_write(TST_FILE, TST_FILE_SIZE_MB);
+
+	TEST(syncfs(fd));
+	if (TST_RET != 0)
+		tst_brk(TFAIL | TTERRNO, "syncfs(fd) failed");
+
+	if (tst_sync_device_check(TST_FILE_SIZE_MB))
+		tst_res(TPASS, "Test filesystem synced to device");
+	else
+		tst_res(TFAIL, "Failed to sync test filesystem to device");
+}
+
+static void setup(void)
+{
+	check_syncfs();
+
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
+	.test_all = verify_syncfs,
+};
-- 
2.7.4

