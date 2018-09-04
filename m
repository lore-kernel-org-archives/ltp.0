From: subash <subash@zilogic.com>
Date: Tue, 04 Sep 2018 08:01:52 -0000
Subject: [LTP] [PATCH v2 1/4] Testing statx syscall Timestamp fields
Message-ID: <20180904080152.22488-1-subash@zilogic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


* statx_btime.c:The time before and after the execution of the create
system call is noted.
It is checked whether the birth time returned by statx lies in this range.

Signed-off-by: Subash <subash@zilogic.com>
Signed-off-by: Vaishnavi.D <vaishnavi.d@zilogic.com>
---
 runtest/syscalls                                   |  2 +
 testcases/kernel/syscalls/statx/.gitignore         |  2 +
 testcases/kernel/syscalls/statx/Makefile           | 29 +++++++
 testcases/kernel/syscalls/statx/statx_btime.c      | 91 ++++++++++++++++++++++
 testcases/kernel/syscalls/statx/timestamp_helper.c | 40 ++++++++++
 testcases/kernel/syscalls/statx/timestamp_helper.h | 31 ++++++++
 6 files changed, 195 insertions(+)
 create mode 100644 testcases/kernel/syscalls/statx/.gitignore
 create mode 100644 testcases/kernel/syscalls/statx/Makefile
 create mode 100644 testcases/kernel/syscalls/statx/statx_btime.c
 create mode 100644 testcases/kernel/syscalls/statx/timestamp_helper.c
 create mode 100644 testcases/kernel/syscalls/statx/timestamp_helper.h

diff --git a/runtest/syscalls b/runtest/syscalls
index 3161d918d..048fb9cc4 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1493,3 +1493,5 @@ memfd_create01 memfd_create01
 memfd_create02 memfd_create02
 
 copy_file_range01 copy_file_range01
+
+statx_btime statx_btime
diff --git a/testcases/kernel/syscalls/statx/.gitignore b/testcases/kernel/syscalls/statx/.gitignore
new file mode 100644
index 000000000..4fb6f516f
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/.gitignore
@@ -0,0 +1,2 @@
+/timestamp_helper
+/statx_btime
\ No newline at end of file
diff --git a/testcases/kernel/syscalls/statx/Makefile b/testcases/kernel/syscalls/statx/Makefile
new file mode 100644
index 000000000..3a326423c
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/Makefile
@@ -0,0 +1,29 @@
+# Copyright (c) Zilogic Systems Pvt. Ltd., 2018
+#  Email : code@zilogic.com
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
+
+FILTER_OUT_MAKE_TARGETS         := timestamp_helper
+
+%_64: CPPFLAGS += -D_FILE_OFFSET_BITS=64
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+$(MAKE_TARGETS): %: %.o timestamp_helper.o
diff --git a/testcases/kernel/syscalls/statx/statx_btime.c b/testcases/kernel/syscalls/statx/statx_btime.c
new file mode 100644
index 000000000..47a40efa9
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx_btime.c
@@ -0,0 +1,91 @@
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
+	SAFE_CLOCK_GETTIME(CLOCK_REALTIME_COARSE, &before_time);
+	clock_wait_tick();
+	create_file();
+	clock_wait_tick();
+	SAFE_CLOCK_GETTIME(CLOCK_REALTIME_COARSE, &after_time);
+
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
diff --git a/testcases/kernel/syscalls/statx/timestamp_helper.c b/testcases/kernel/syscalls/statx/timestamp_helper.c
new file mode 100644
index 000000000..6b12dfd26
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/timestamp_helper.c
@@ -0,0 +1,40 @@
+//SPDX-License-Identifier:GPL-2.0-or-later
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
+#define TST_NO_DEFAULT_MAIN
+
+#include "timestamp_helper.h"
+
+void statx_timestamp_to_timespec(const struct statx_timestamp *timestamp,
+				 struct timespec *timespec)
+{
+	timespec->tv_sec = timestamp->tv_sec;
+	timespec->tv_nsec = timestamp->tv_nsec;
+}
+
+void clock_wait_tick(void)
+{
+	struct timespec res;
+	unsigned int usecs;
+
+	SAFE_CLOCK_GETRES(CLOCK_REALTIME_COARSE, &res);
+	usecs = ((res.tv_sec * 1000000) + (res.tv_nsec / 1000)) * 1.5;
+
+	usleep(usecs);
+}
diff --git a/testcases/kernel/syscalls/statx/timestamp_helper.h b/testcases/kernel/syscalls/statx/timestamp_helper.h
new file mode 100644
index 000000000..bb6794920
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/timestamp_helper.h
@@ -0,0 +1,31 @@
+//SPDX-License-Identifier:GPL-2.0-or-later
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
+void statx_timestamp_to_timespec(const struct statx_timestamp *timestamp,
+				struct timespec *timespec);
+void clock_wait_tick(void);
+#endif
-- 
2.11.0

