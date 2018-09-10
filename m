From: subash <subash@zilogic.com>
Date: Mon, 10 Sep 2018 13:19:53 -0000
Subject: [LTP] [PATCH v2 1/4] Testing statx syscall Timestamp fields
Message-ID: <20180910131953.10668-1-subash@zilogic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


* statx07.c:The time before and after the execution of the create
system call is noted.
It is checked whether the birth time returned by statx lies in this range.

Signed-off-by: Subash <subash@zilogic.com>
Signed-off-by: Vaishnavi.D <vaishnavi.d@zilogic.com>
---
 include/safe_macros_fn.h                           |  5 ++
 include/tst_safe_macros.h                          |  6 ++
 lib/safe_macros.c                                  | 23 ++++++
 runtest/syscalls                                   |  1 +
 testcases/kernel/syscalls/statx/.gitignore         |  1 +
 testcases/kernel/syscalls/statx/Makefile           |  4 ++
 testcases/kernel/syscalls/statx/statx07.c          | 84 ++++++++++++++++++++++
 testcases/kernel/syscalls/statx/timestamp_helper.c | 30 ++++++++
 testcases/kernel/syscalls/statx/timestamp_helper.h | 15 ++++
 9 files changed, 169 insertions(+)
 create mode 100644 testcases/kernel/syscalls/statx/statx07.c
 create mode 100644 testcases/kernel/syscalls/statx/timestamp_helper.c
 create mode 100644 testcases/kernel/syscalls/statx/timestamp_helper.h

diff --git a/include/safe_macros_fn.h b/include/safe_macros_fn.h
index 3df952811..578ac08e2 100644
--- a/include/safe_macros_fn.h
+++ b/include/safe_macros_fn.h
@@ -184,4 +184,9 @@ int safe_closedir(const char *file, const int lineno,
                   void (cleanup_fn)(void),
                   DIR *dirp);
 
+void safe_clock_getres(const char *file, const int lineno,
+		clockid_t clk_id, struct timespec *res);
+
+void safe_clock_gettime(const char *file, const int lineno,
+		clockid_t clk_id, struct timespec *tp);
 #endif /* SAFE_MACROS_FN_H__ */
diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 03657a410..c47342446 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -512,4 +512,10 @@ int safe_personality(const char *filename, unsigned int lineno,
 	}							\
 	} while (0)
 
+#define SAFE_CLOCK_GETRES(clk_id, res)\
+	safe_clock_getres(__FILE__, __LINE__, (clk_id), (res))
+
+#define SAFE_CLOCK_GETTIME(clk_id, tp)\
+	safe_clock_gettime(__FILE__, __LINE__, (clk_id), (tp))
+
 #endif /* SAFE_MACROS_H__ */
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 5cc80d035..85643c743 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -1048,3 +1048,26 @@ int safe_mincore(const char *file, const int lineno, void *start,
 
 	return rval;
 }
+
+void safe_clock_getres(const char *file, const int lineno,
+	clockid_t clk_id, struct timespec *res)
+{
+	int rval;
+
+	rval = clock_getres(clk_id, res);
+	if (rval == -1)
+		tst_brkm(TBROK | TERRNO, NULL,
+			"%s:%d:, clock_getres() failed", file, lineno);
+
+}
+
+void safe_clock_gettime(const char *file, const int lineno,
+	clockid_t clk_id, struct timespec *tp)
+{
+	int rval;
+
+	rval = clock_gettime(clk_id, tp);
+	if (rval == -1)
+		tst_brkm(TBROK | TERRNO, NULL, 
+			"%s:%d:, clock_gettime() failed", file, lineno);
+}
diff --git a/runtest/syscalls b/runtest/syscalls
index 0d0be7713..da2f8c090 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1504,3 +1504,4 @@ statx02 statx02
 statx03 statx03
 statx04 statx04
 statx05 statx05
+statx07 statx07
\ No newline at end of file
diff --git a/testcases/kernel/syscalls/statx/.gitignore b/testcases/kernel/syscalls/statx/.gitignore
index 209fc3a33..14cb1ec43 100644
--- a/testcases/kernel/syscalls/statx/.gitignore
+++ b/testcases/kernel/syscalls/statx/.gitignore
@@ -3,3 +3,4 @@
 /statx03
 /statx04
 /statx05
+/statx07
\ No newline at end of file
diff --git a/testcases/kernel/syscalls/statx/Makefile b/testcases/kernel/syscalls/statx/Makefile
index 3a9c66d6d..81420497d 100644
--- a/testcases/kernel/syscalls/statx/Makefile
+++ b/testcases/kernel/syscalls/statx/Makefile
@@ -21,6 +21,10 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
+FILTER_OUT_MAKE_TARGETS         := timestamp_helper
+
 %_64: CPPFLAGS += -D_FILE_OFFSET_BITS=64
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+$(MAKE_TARGETS): %: %.o timestamp_helper.o
diff --git a/testcases/kernel/syscalls/statx/statx07.c b/testcases/kernel/syscalls/statx/statx07.c
new file mode 100644
index 000000000..8edcc1974
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx07.c
@@ -0,0 +1,84 @@
+//SPDX-License-Identifier:GPL-2.0-or-later
+/*
+ *  Copyright (c) Zilogic Systems Pvt. Ltd., 2018
+ *  Email : code@zilogic.com
+ *
+ */
+
+/*
+ * Test case for statx07.
+ *
+ * DESCRIPTION : The time before and after the execution of the create
+ *	system call is noted. It is checked whether the birth time
+ *	returned by statx lies in this range.
+ *
+ */
+
+#include <stdio.h>
+
+
+#include "tst_test.h"
+#include "lapi/stat.h"
+#include "tst_safe_macros.h"
+#include "tst_timer.h"
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
index 000000000..cea76b7fa
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/timestamp_helper.c
@@ -0,0 +1,30 @@
+//SPDX-License-Identifier:GPL-2.0-or-later
+/*
+ * Copyright (c) Zilogic Systems Pvt. Ltd., 2018
+ * Email: code@zilogic.com
+ */
+
+#define TST_NO_DEFAULT_MAIN
+
+#include "tst_test.h"
+#include "lapi/stat.h"
+#include "tst_safe_macros.h"
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
index 000000000..8dcd8d6d8
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/timestamp_helper.h
@@ -0,0 +1,15 @@
+//SPDX-License-Identifier:GPL-2.0-or-later
+/*
+ * Copyright (c) Zilogic Systems Pvt. Ltd., 2018
+ * Email: code@zilogic.com
+ */
+
+#ifndef TIMESTAMP_HELPER
+#define TIMESTAMP_HELPER
+
+#include <time.h>
+
+void statx_timestamp_to_timespec(const struct statx_timestamp *timestamp,
+				struct timespec *timespec);
+void clock_wait_tick(void);
+#endif
-- 
2.11.0

