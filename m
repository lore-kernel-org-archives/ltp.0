From: subash <subash@zilogic.com>
Date: Wed, 22 Aug 2018 13:14:08 -0000
Subject: [LTP] [PATCH v1] Testing statx syscall Timestamp fields
Message-ID: <20180822131408.25449-1-subash@zilogic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


* statx_btime.c:The time before and after the execution of the create
system call is noted.
It is checked whether the birth time returned by statx lies in this range.

* statx_atime.c:The time before and after the execution of the read
system call is noted.
It is checked whether the access time returned by statx lies in this range.

* statx_mtime.c:The time before and after the execution of the write
system call is noted.
It is checked whether the modification time returned by statx lies in this range.

* statx_ctime.c:The time before and after the execution of the chmod
system call is noted.
It is checked whether the status change time returned by statx lies in this range.

Signed-off-by: Subash <subash@zilogic.com>
Signed-off-by: Vaishnavi.D <vaishnavi.d@zilogic.com>
---
 runtest/syscalls                                   | 10 +++
 testcases/kernel/syscalls/statx/.gitignore         |  9 ++
 testcases/kernel/syscalls/statx/Makefile           | 27 ++++++
 testcases/kernel/syscalls/statx/statx_atime.c      | 96 +++++++++++++++++++++
 testcases/kernel/syscalls/statx/statx_btime.c      | 90 ++++++++++++++++++++
 testcases/kernel/syscalls/statx/statx_ctime.c      | 88 ++++++++++++++++++++
 testcases/kernel/syscalls/statx/statx_mtime.c      | 97 ++++++++++++++++++++++
 testcases/kernel/syscalls/statx/timestamp_helper.c | 52 ++++++++++++
 testcases/kernel/syscalls/statx/timestamp_helper.h | 33 ++++++++
 9 files changed, 502 insertions(+)
 create mode 100644 testcases/kernel/syscalls/statx/.gitignore
 create mode 100644 testcases/kernel/syscalls/statx/Makefile
 create mode 100644 testcases/kernel/syscalls/statx/statx_atime.c
 create mode 100644 testcases/kernel/syscalls/statx/statx_btime.c
 create mode 100644 testcases/kernel/syscalls/statx/statx_ctime.c
 create mode 100644 testcases/kernel/syscalls/statx/statx_mtime.c
 create mode 100644 testcases/kernel/syscalls/statx/timestamp_helper.c
 create mode 100644 testcases/kernel/syscalls/statx/timestamp_helper.h

diff --git a/runtest/syscalls b/runtest/syscalls
index ccc3eff59..cec031bf1 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1287,6 +1287,11 @@ statfs03_64 statfs03_64
 statvfs01 statvfs01
 statvfs02 statvfs02
 
+statx01 statx01
+statx02 statx02
+statx03 statx03
+statx04 statx04
+
 stime01 stime01
 stime02 stime02
 
@@ -1495,3 +1500,8 @@ memfd_create03 memfd_create03
 memfd_create04 memfd_create04
 
 copy_file_range01 copy_file_range01
+
+statx_atime statx_atime
+statx_btime statx_btime
+statx_ctime statx_ctime
+statx_mtime statx_mtime
diff --git a/testcases/kernel/syscalls/statx/.gitignore b/testcases/kernel/syscalls/statx/.gitignore
new file mode 100644
index 000000000..9f9c2a5c2
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/.gitignore
@@ -0,0 +1,9 @@
+/statx01
+/statx02
+/statx03
+/statx04
+/timestamp_helper
+/statx_atime
+/statx_btime
+/statx_ctime
+/statx_mtime
\ No newline at end of file
diff --git a/testcases/kernel/syscalls/statx/Makefile b/testcases/kernel/syscalls/statx/Makefile
new file mode 100644
index 000000000..42849c604
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/Makefile
@@ -0,0 +1,27 @@
+#
+#  Copyright (c) Zilogic Systems Pvt. Ltd., 2018
+#  Email: code@zilogic.com
+#
+#  This program is free software;  you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  the GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program;  if not, write to the Free Software
+#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+FILTER_OUT_MAKE_TARGETS         := timestamp_helper
+%_64: CPPFLAGS += -D_FILE_OFFSET_BITS=64
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
+$(MAKE_TARGETS): %: %.o timestamp_helper.o
diff --git a/testcases/kernel/syscalls/statx/statx_atime.c b/testcases/kernel/syscalls/statx/statx_atime.c
new file mode 100644
index 000000000..4986add08
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx_atime.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0 or later
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
+ * 	system call is noted. It is checked whether the access time
+ * 	returned by statx lies in this range.
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
+	clock_get_time(&before_time);
+	clock_wait_tick();
+	read_file();
+	clock_wait_tick();
+	clock_get_time(&after_time);
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
diff --git a/testcases/kernel/syscalls/statx/statx_btime.c b/testcases/kernel/syscalls/statx/statx_btime.c
new file mode 100644
index 000000000..8d871248a
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx_btime.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0 or later
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
+
+/*
+ * Test case for statx_btime.
+ *
+ * DESCRIPTION : The time before and after the execution of the create
+ *	system call is noted. It is checked whether the birth time
+ *	returned by statx lies in this range.
+ *
+ */
+
+#include <stdio.h>
+#include "tst_test.h"
+#include "lapi/stat.h"
+#include "tst_timer.h"
+#include "tst_safe_macros.h"
+#include <sys/mount.h>
+#include "timestamp_helper.h"
+
+#define MOUNT_POINT "mount_ext"
+#define TEST_FILE MOUNT_POINT"/test_file.txt"
+
+static void create_file(void)
+{
+	int test_file_fd;
+
+	test_file_fd = SAFE_CREAT(TEST_FILE, 0666);
+	SAFE_CLOSE(test_file_fd);
+}
+
+static void test_statx_btime(void)
+{
+	struct statx buff;
+	struct timespec before_time;
+	struct timespec after_time;
+	struct timespec statx_time;
+
+	clock_get_time(&before_time);
+	clock_wait_tick();
+	create_file();
+	clock_wait_tick();
+	clock_get_time(&after_time);
+
+	TEST(statx(AT_FDCWD, TEST_FILE, 0, STATX_ALL, &buff));
+	if (TST_RET != 0)
+		tst_brk(TFAIL | TTERRNO,
+			"statx(AT_FDCWD, %s, 0, STATX_ALL, &buff)", TEST_FILE);
+
+	statx_timestamp_to_timespec(&buff.stx_btime, &statx_time);
+
+	if (tst_timespec_lt(statx_time, before_time))
+		tst_res(TFAIL, "Birth time < before time");
+	else if (tst_timespec_lt(after_time, statx_time))
+		tst_res(TFAIL, "Birth time > after_time");
+	else
+		tst_res(TPASS, "Birth Time Passed\n");
+
+}
+
+void cleanup(void)
+{
+	SAFE_UNLINK(TEST_FILE);
+}
+
+static struct tst_test test = {
+	.test_all = test_statx_btime,
+	.min_kver = "4.11",
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.mntpoint = MOUNT_POINT,
+	.mount_device = 1,
+	.dev_fs_type = "ext4",
+	.dev_min_size = 512,
+	.mnt_flags = MS_STRICTATIME,
+	.cleanup = cleanup,
+};
diff --git a/testcases/kernel/syscalls/statx/statx_ctime.c b/testcases/kernel/syscalls/statx/statx_ctime.c
new file mode 100644
index 000000000..10aa2aa13
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx_ctime.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0 or later
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
+ * Test case for statx_ctime.
+ *
+ * DESCRIPTION : The time before and after the execution of the chmod
+ * 	system call is noted. It is checked whether the status change
+ * 	time returned by statx lies in this range.
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
+
+static void setup(void)
+{
+	int test_file_fd;
+
+	test_file_fd = SAFE_OPEN(TEST_FILE, O_CREAT | O_RDWR, 0666);
+	SAFE_CLOSE(test_file_fd);
+}
+
+static void test_statx_ctime(void)
+{
+	struct statx buff;
+	struct timespec before_time;
+	struct timespec after_time;
+	struct timespec statx_time;
+
+	clock_get_time(&before_time);
+	clock_wait_tick();
+	SAFE_CHMOD(TEST_FILE, 0777);
+	clock_wait_tick();
+	clock_get_time(&after_time);
+
+	TEST(statx(AT_FDCWD, TEST_FILE, 0, STATX_ALL, &buff));
+	if (TST_RET != 0)
+		tst_brk(TFAIL | TTERRNO,
+			"statx(AT_FDCWD, %s, 0, STATX_ALL, &buff)", TEST_FILE);
+
+	statx_timestamp_to_timespec(&buff.stx_ctime, &statx_time);
+
+	if (tst_timespec_lt(statx_time, before_time))
+		tst_res(TFAIL, "Status change time < before time");
+	else if (tst_timespec_lt(after_time, statx_time))
+		tst_res(TFAIL, "Status change time > after_time");
+	else
+		tst_res(TPASS, "Status change time Passed\n");
+}
+
+static void cleanup(void)
+{
+	SAFE_UNLINK(TEST_FILE);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = test_statx_ctime,
+	.min_kver = "4.11",
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.mntpoint = MOUNT_POINT,
+	.mount_device = 1,
+	.dev_fs_type = "ext4",
+	.dev_min_size = 512,
+	.mnt_flags = MS_STRICTATIME,
+};
diff --git a/testcases/kernel/syscalls/statx/statx_mtime.c b/testcases/kernel/syscalls/statx/statx_mtime.c
new file mode 100644
index 000000000..9e5522dff
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx_mtime.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0 or later
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
+ * 	system call is noted. It is checked whether the modified time
+ * 	returned by statx lies in this range.
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
+	clock_get_time(&before_time);
+	clock_wait_tick();
+	write_file();
+	clock_wait_tick();
+	clock_get_time(&after_time);
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
diff --git a/testcases/kernel/syscalls/statx/timestamp_helper.c b/testcases/kernel/syscalls/statx/timestamp_helper.c
new file mode 100644
index 000000000..d3cca7528
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/timestamp_helper.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0 or later
+/*
+ * Copyright (c) Zilogic Systems Pvt. Ltd., 2018
+ * Email: code@zilogic.com
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define _GNU_SOURCE
+#define TST_NO_DEFAULT_MAIN
+
+
+#include "timestamp_helper.h"
+
+void clock_wait_tick(void)
+{
+	struct timespec res;
+	unsigned int usecs;
+
+	TEST(clock_getres(CLOCK_REALTIME_COARSE, &res));
+	if (TST_RET != 0)
+		tst_brk(TFAIL | TTERRNO, "Failed to get clock resolution");
+
+	usecs = ((res.tv_sec * 1000000) + (res.tv_nsec / 1000)) * 1.5;
+
+	usleep(usecs);
+}
+
+void clock_get_time(struct timespec *time)
+{
+	TEST(clock_gettime(CLOCK_REALTIME_COARSE, time));
+	if (TST_RET != 0)
+		tst_brk(TFAIL | TTERRNO, "Failed to get clock time");
+}
+
+void statx_timestamp_to_timespec(const struct statx_timestamp *timestamp,
+				 struct timespec *timespec)
+{
+	timespec->tv_sec = timestamp->tv_sec;
+	timespec->tv_nsec = timestamp->tv_nsec;
+}
diff --git a/testcases/kernel/syscalls/statx/timestamp_helper.h b/testcases/kernel/syscalls/statx/timestamp_helper.h
new file mode 100644
index 000000000..346504c42
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/timestamp_helper.h
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0 or later
+/*
+ * Copyright (c) Zilogic Systems Pvt. Ltd., 2018
+ * Email: code@zilogic.com
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef TIMESTAMP_HELPER
+#define TIMESTAMP_HELPER
+
+#include <time.h>
+#include "lapi/stat.h"
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+
+void clock_wait_tick(void);
+void clock_get_time(struct timespec *time);
+void statx_timestamp_to_timespec(const struct statx_timestamp *timestamp,
+				struct timespec *timespec);
+
+#endif
-- 
2.11.0

