From: Subash Ganesan <subash@zilogic.com>
Date: Fri, 09 Nov 2018 11:30:14 -0000
Subject: [LTP] [PATCH v4] Testing statx syscall Timestamp fields
Message-ID: <20181109113014.6756-1-subash@zilogic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


The time before and after the execution of the corresponding
system call is noted.

It is checked whether the time returned by statx lies in this range.

open syscall with O_CREAT flag for birth time.
write syscall for modified time.
read syscall for access time.
chmod syscall for status change time.

Signed-off-by: Subash Ganesan <subash@zilogic.com>
Signed-off-by: Vaishnavi.D <vaishnavi.d@zilogic.com>
---
 include/tst_safe_clocks.h                  |  38 +++++++
 runtest/syscalls                           |   1 +
 testcases/kernel/syscalls/statx/.gitignore |   2 +
 testcases/kernel/syscalls/statx/Makefile   |   4 +
 testcases/kernel/syscalls/statx/statx06.c  | 174 +++++++++++++++++++++++++++++
 5 files changed, 219 insertions(+)
 create mode 100644 include/tst_safe_clocks.h
 create mode 100644 testcases/kernel/syscalls/statx/statx06.c

diff --git a/include/tst_safe_clocks.h b/include/tst_safe_clocks.h
new file mode 100644
index 000000000..1b4d48543
--- /dev/null
+++ b/include/tst_safe_clocks.h
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0 or later
+/*
+ *  Copyright (c) Zilogic Systems Pvt. Ltd., 2018
+ *  Email : code@zilogic.com
+ */
+
+#include <time.h>
+#include "tst_test.h"
+
+static inline void safe_clock_getres(const char *file, const int lineno,
+	clockid_t clk_id, struct timespec *res)
+{
+	int rval;
+
+	rval = clock_getres(clk_id, res);
+	if (rval != 0)
+		tst_brk(TBROK | TERRNO,
+			"%s:%d clock_getres() failed", file, lineno);
+
+}
+
+static inline void safe_clock_gettime(const char *file, const int lineno,
+	clockid_t clk_id, struct timespec *tp)
+{
+	int rval;
+
+	rval = clock_gettime(clk_id, tp);
+	if (rval != 0)
+		tst_brk(TBROK | TERRNO,
+			"%s:%d clock_gettime() failed", file, lineno);
+}
+
+#define SAFE_CLOCK_GETRES(clk_id, res)\
+	safe_clock_getres(__FILE__, __LINE__, (clk_id), (res))
+
+#define SAFE_CLOCK_GETTIME(clk_id, tp)\
+	safe_clock_gettime(__FILE__, __LINE__, (clk_id), (tp))
+
diff --git a/runtest/syscalls b/runtest/syscalls
index 53a4a427e..1f76cd9de 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1514,3 +1514,4 @@ statx02 statx02
 statx03 statx03
 statx04 statx04
 statx05 statx05
+statx06 statx06
diff --git a/testcases/kernel/syscalls/statx/.gitignore b/testcases/kernel/syscalls/statx/.gitignore
index 209fc3a33..40b5ee392 100644
--- a/testcases/kernel/syscalls/statx/.gitignore
+++ b/testcases/kernel/syscalls/statx/.gitignore
@@ -3,3 +3,5 @@
 /statx03
 /statx04
 /statx05
+/statx06
+
diff --git a/testcases/kernel/syscalls/statx/Makefile b/testcases/kernel/syscalls/statx/Makefile
index 3a9c66d6d..563c868e5 100644
--- a/testcases/kernel/syscalls/statx/Makefile
+++ b/testcases/kernel/syscalls/statx/Makefile
@@ -24,3 +24,7 @@ include $(top_srcdir)/include/mk/testcases.mk
 %_64: CPPFLAGS += -D_FILE_OFFSET_BITS=64
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+statx06: LDLIBS += -lrt
+
+
diff --git a/testcases/kernel/syscalls/statx/statx06.c b/testcases/kernel/syscalls/statx/statx06.c
new file mode 100644
index 000000000..d96041b6f
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx06.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0 or later
+/*
+ *  Copyright (c) Zilogic Systems Pvt. Ltd., 2018
+ *  Email : code@zilogic.com
+ */
+
+/*
+ * DESCRIPTION :
+ *
+ * Test-Case 1 : Testing btime
+ * flow :       The time before and after the execution of the create
+ *              system call is noted.
+ *		It is checked whether the birth time returned by statx lies in
+ *              this range.
+ *
+ * Test-Case 2 : Testing mtime
+ * flow :       The time before and after the execution of the write
+ *              system call is noted.
+ *              It is checked whether the modification time returned
+ *              by statx lies in this range.
+ *
+ * Test-Case 3 : Testing atime
+ * flow :       The time before and after the execution of the read
+ *              system call is noted.
+ *              It is checked whether the access time returned by statx lies in
+ *              this range.
+ *
+ * Test-Case 4 : Testing ctime
+ * flow :	The time before and after the execution of the chmod
+ *              system call is noted.
+ *              It is checked whether the status change time returned by statx
+ *              lies in this range.
+ *
+ */
+
+#include <stdio.h>
+#include "tst_test.h"
+#include "lapi/stat.h"
+#include "tst_safe_clocks.h"
+#include "tst_safe_macros.h"
+#include "tst_timer.h"
+#include <sys/mount.h>
+#include <time.h>
+
+#define MOUNT_POINT "mount_ext"
+#define TEST_FILE MOUNT_POINT"/test_file.txt"
+#define SIZE 2
+
+static int fd;
+
+static void timestamp_to_timespec(const struct statx_timestamp *timestamp,
+				  struct timespec *timespec)
+{
+	timespec->tv_sec = timestamp->tv_sec;
+	timespec->tv_nsec = timestamp->tv_nsec;
+}
+
+static void clock_wait_tick(void)
+{
+	struct timespec res;
+	unsigned int usecs;
+
+	SAFE_CLOCK_GETRES(CLOCK_REALTIME_COARSE, &res);
+	usecs = tst_timespec_to_us(res);
+
+	usleep(usecs);
+}
+
+static void create_file(void)
+{
+	if (fd > 0) {
+		SAFE_CLOSE(fd);
+		SAFE_UNLINK(TEST_FILE);
+	}
+	fd = SAFE_OPEN(TEST_FILE, O_CREAT | O_RDWR, 0666);
+}
+
+static void write_file(void)
+{
+	char data[SIZE] = "hi";
+
+	SAFE_WRITE(0, fd, data, sizeof(data));
+}
+
+static void read_file(void)
+{
+	char data[SIZE];
+
+	SAFE_READ(0, fd, data, sizeof(data));
+}
+
+static void change_mode(void)
+{
+	SAFE_CHMOD(TEST_FILE, 0777);
+}
+
+static struct test_case {
+	void (*operation)(void);
+	char *op_name;
+} tcases[] = {
+	{.operation = create_file,
+	 .op_name = "Birth time"},
+	{.operation = write_file,
+	 .op_name = "Modified time"},
+	{.operation = read_file,
+	 .op_name = "Access time"},
+	{.operation = change_mode,
+	 .op_name = "Change time"}
+};
+
+static void test_statx(unsigned int test_nr)
+{
+	struct statx buff;
+	struct timespec before_time;
+	struct timespec after_time;
+	struct timespec statx_time = {0, 0};
+
+	struct test_case *tc = &tcases[test_nr];
+
+	SAFE_CLOCK_GETTIME(CLOCK_REALTIME_COARSE, &before_time);
+	clock_wait_tick();
+	tc->operation();
+	clock_wait_tick();
+	SAFE_CLOCK_GETTIME(CLOCK_REALTIME_COARSE, &after_time);
+
+	TEST(statx(AT_FDCWD, TEST_FILE, 0, STATX_ALL, &buff));
+	if (TST_RET != 0)
+		tst_brk(TFAIL | TTERRNO,
+			"statx(AT_FDCWD, %s, 0, STATX_ALL, &buff)",
+			TEST_FILE);
+
+	switch (test_nr) {
+	case 0:
+		timestamp_to_timespec(&buff.stx_btime, &statx_time);
+		break;
+	case 1:
+		timestamp_to_timespec(&buff.stx_mtime, &statx_time);
+		break;
+	case 2:
+		timestamp_to_timespec(&buff.stx_atime, &statx_time);
+		break;
+	case 3:
+		timestamp_to_timespec(&buff.stx_ctime, &statx_time);
+		break;
+	}
+	if (tst_timespec_lt(statx_time, before_time))
+		tst_res(TFAIL, "%s < before time", tc->op_name);
+	else if (tst_timespec_lt(after_time, statx_time))
+		tst_res(TFAIL, "%s > after_time", tc->op_name);
+	else
+		tst_res(TPASS, "%s Passed\n", tc->op_name);
+}
+
+
+static void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.cleanup = cleanup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = test_statx,
+	.min_kver = "4.11",
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.mntpoint = MOUNT_POINT,
+	.mount_device = 1,
+	.dev_fs_type = "ext4",
+	.dev_min_size = 512,
+	.mnt_flags = MS_STRICTATIME,
+};
+
-- 
2.11.0

