From: subash <subash@zilogic.com>
Date: Tue, 04 Sep 2018 08:03:57 -0000
Subject: [LTP] [PATCH v2 3/4] Testing statx syscall Timestamp fields
Message-ID: <20180904080357.22601-1-subash@zilogic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


* statx_mtime.c:The time before and after the execution of the write
system call is noted.
It is checked whether the modification time returned by statx lies in this range.

Signed-off-by: Subash <subash@zilogic.com>
Signed-off-by: Vaishnavi.D <vaishnavi.d@zilogic.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/statx/.gitignore    |  1 +
 testcases/kernel/syscalls/statx/statx_mtime.c | 97 +++++++++++++++++++++++++++
 3 files changed, 99 insertions(+)
 create mode 100644 testcases/kernel/syscalls/statx/statx_mtime.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 6f5eb656a..eea045aac 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1496,3 +1496,4 @@ copy_file_range01 copy_file_range01
 
 statx_btime statx_btime
 statx_atime statx_atime
+statx_mtime statx_mtime
diff --git a/testcases/kernel/syscalls/statx/.gitignore b/testcases/kernel/syscalls/statx/.gitignore
index c5433d6bc..c9aef59be 100644
--- a/testcases/kernel/syscalls/statx/.gitignore
+++ b/testcases/kernel/syscalls/statx/.gitignore
@@ -1,3 +1,4 @@
 /timestamp_helper
 /statx_btime
 /statx_atime
+/statx_mtime
diff --git a/testcases/kernel/syscalls/statx/statx_mtime.c b/testcases/kernel/syscalls/statx/statx_mtime.c
new file mode 100644
index 000000000..c3fb1ea40
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx_mtime.c
@@ -0,0 +1,97 @@
+//SPDX-License-Identifier:GPL-2.0-or-later
+/*
+ *  Copyright (c) Zilogic Systems Pvt. Ltd., 2018
+ *  Email : code@zilogic.com
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ */
+/*
+ * Test case for statx_mtime.
+ *
+ * DESCRIPTION : The time before and after the execution of the write
+ *	system call is noted. It is checked whether the modified time
+ *	returned by statx lies in this range.
+ *
+ */
+
+#include <stdio.h>
+#include "tst_test.h"
+#include "tst_timer.h"
+#include <sys/mount.h>
+#include "tst_safe_macros.h"
+#include "timestamp_helper.h"
+
+#define MOUNT_POINT "mount_ext"
+#define TEST_FILE MOUNT_POINT"/test_file.txt"
+#define SIZE 2
+
+static int test_file_fd;
+
+static void setup(void)
+{
+	test_file_fd = SAFE_OPEN(TEST_FILE, O_CREAT | O_RDWR, 0666);
+}
+
+static void write_file(void)
+{
+	char data[SIZE] = "hi";
+
+	SAFE_WRITE(0, test_file_fd, data, sizeof(data));
+}
+
+static void test_statx_mtime(void)
+{
+	struct statx buff;
+	struct timespec before_time;
+	struct timespec after_time;
+	struct timespec statx_time;
+
+
+	SAFE_CLOCK_GETTIME(CLOCK_REALTIME_COARSE, &before_time);
+	clock_wait_tick();
+	write_file();
+	clock_wait_tick();
+	SAFE_CLOCK_GETTIME(CLOCK_REALTIME_COARSE, &after_time);
+
+	TEST(statx(AT_FDCWD, TEST_FILE, 0, STATX_ALL, &buff));
+	if (TST_RET != 0)
+		tst_brk(TFAIL | TTERRNO,
+			"statx(AT_FDCWD, %s, 0, STATX_ALL, &buff)", TEST_FILE);
+
+	statx_timestamp_to_timespec(&buff.stx_mtime, &statx_time);
+
+	if (tst_timespec_lt(statx_time, before_time))
+		tst_res(TFAIL, "Modification time < before time");
+	else if (tst_timespec_lt(after_time, statx_time))
+		tst_res(TFAIL, "Modification time > after_time");
+	else
+		tst_res(TPASS, "Modification time Passed\n");
+}
+
+static void cleanup(void)
+{
+	SAFE_CLOSE(test_file_fd);
+	SAFE_UNLINK(TEST_FILE);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = test_statx_mtime,
+	.min_kver = "4.11",
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.mntpoint = MOUNT_POINT,
+	.mount_device = 1,
+	.dev_fs_type = "ext4",
+	.dev_min_size = 512,
+	.mnt_flags = MS_STRICTATIME,
+};
-- 
2.11.0

