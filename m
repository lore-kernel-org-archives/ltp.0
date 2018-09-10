From: subash <subash@zilogic.com>
Date: Mon, 10 Sep 2018 13:23:00 -0000
Subject: [LTP] [PATCH v2 4/4] Testing statx syscall Timestamp fields
Message-ID: <20180910132300.10853-1-subash@zilogic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


* statx10.c:The time before and after the execution of the write
system call is noted.
It is checked whether the modification time returned by statx lies in this range.

Signed-off-by: Subash <subash@zilogic.com>
Signed-off-by: Vaishnavi.D <vaishnavi.d@zilogic.com>
---
 runtest/syscalls                           |  3 +-
 testcases/kernel/syscalls/statx/.gitignore |  3 +-
 testcases/kernel/syscalls/statx/statx10.c  | 89 ++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+), 2 deletions(-)
 create mode 100644 testcases/kernel/syscalls/statx/statx10.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 163acf948..815d42525 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1506,4 +1506,5 @@ statx04 statx04
 statx05 statx05
 statx07 statx07
 statx08 statx08
-statx09 statx09
\ No newline at end of file
+statx09 statx09
+statx10 statx10
diff --git a/testcases/kernel/syscalls/statx/.gitignore b/testcases/kernel/syscalls/statx/.gitignore
index 9c476d303..789309a54 100644
--- a/testcases/kernel/syscalls/statx/.gitignore
+++ b/testcases/kernel/syscalls/statx/.gitignore
@@ -5,4 +5,5 @@
 /statx05
 /statx07
 /statx08
-/statx09
\ No newline at end of file
+/statx09
+/statx10
\ No newline at end of file
diff --git a/testcases/kernel/syscalls/statx/statx10.c b/testcases/kernel/syscalls/statx/statx10.c
new file mode 100644
index 000000000..44c70238e
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx10.c
@@ -0,0 +1,89 @@
+//SPDX-License-Identifier:GPL-2.0-or-later
+/*
+ *  Copyright (c) Zilogic Systems Pvt. Ltd., 2018
+ *  Email : code@zilogic.com
+ */
+
+/*
+ * Test case for statx10.
+ *
+ * DESCRIPTION : The time before and after the execution of the write
+ *	system call is noted. It is checked whether the modified time
+ *	returned by statx lies in this range.
+ *
+ */
+
+#include <stdio.h>
+#include "tst_test.h"
+#include "lapi/stat.h"
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

