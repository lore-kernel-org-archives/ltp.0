From: subash <subash@zilogic.com>
Date: Tue, 04 Sep 2018 08:03:03 -0000
Subject: [LTP] [PATCH v2 2/4] Testing statx syscall Timestamp fields
Message-ID: <20180904080303.22546-1-subash@zilogic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


* statx_atime.c:The time before and after the execution of the read
system call is noted.
It is checked whether the access time returned by statx lies in this range.

Signed-off-by: Subash <subash@zilogic.com>
Signed-off-by: Vaishnavi.D <vaishnavi.d@zilogic.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/statx/.gitignore    |  3 +-
 testcases/kernel/syscalls/statx/statx_atime.c | 96 +++++++++++++++++++++++++++
 3 files changed, 99 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/statx/statx_atime.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 048fb9cc4..6f5eb656a 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1495,3 +1495,4 @@ memfd_create02 memfd_create02
 copy_file_range01 copy_file_range01
 
 statx_btime statx_btime
+statx_atime statx_atime
diff --git a/testcases/kernel/syscalls/statx/.gitignore b/testcases/kernel/syscalls/statx/.gitignore
index 4fb6f516f..c5433d6bc 100644
--- a/testcases/kernel/syscalls/statx/.gitignore
+++ b/testcases/kernel/syscalls/statx/.gitignore
@@ -1,2 +1,3 @@
 /timestamp_helper
-/statx_btime
\ No newline at end of file
+/statx_btime
+/statx_atime
diff --git a/testcases/kernel/syscalls/statx/statx_atime.c b/testcases/kernel/syscalls/statx/statx_atime.c
new file mode 100644
index 000000000..3e0ed8c2f
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx_atime.c
@@ -0,0 +1,96 @@
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
+ * Test case for statx_atime.
+ *
+ * DESCRIPTION : The time before and after the execution of the read
+ *	system call is noted. It is checked whether the access time
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
+static void read_file(void)
+{
+	char data[SIZE];
+
+	SAFE_READ(0, test_file_fd, data, sizeof(data));
+}
+
+static void test_statx_atime(void)
+{
+	struct statx buff;
+	struct timespec before_time;
+	struct timespec after_time;
+	struct timespec statx_time;
+
+	SAFE_CLOCK_GETTIME(CLOCK_REALTIME_COARSE, &before_time);
+	clock_wait_tick();
+	read_file();
+	clock_wait_tick();
+	SAFE_CLOCK_GETTIME(CLOCK_REALTIME_COARSE, &after_time);
+
+	TEST(statx(AT_FDCWD, TEST_FILE, 0, STATX_ALL, &buff));
+	if (TST_RET != 0)
+		tst_brk(TFAIL | TTERRNO,
+			"statx(AT_FDCWD, %s, 0, STATX_ALL, &buff)", TEST_FILE);
+
+	statx_timestamp_to_timespec(&buff.stx_atime, &statx_time);
+
+	if (tst_timespec_lt(statx_time, before_time))
+		tst_res(TFAIL, "Access time < before time");
+	else if (tst_timespec_lt(after_time, statx_time))
+		tst_res(TFAIL, "Access time > after_time");
+	else
+		tst_res(TPASS, "Access Time Passed\n");
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
+	.test_all = test_statx_atime,
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

