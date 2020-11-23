From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 23 Nov 2020 14:05:53 +0530
Subject: [LTP] [PATCH V2 1/2] syscalls: Add tests for name_to_handle_at()
Message-ID: <b758999c1bd02a52a68cbb6449bb3d82dd2a4e69.1606120441.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds basic success and failure tests for name_to_handle_at()
syscall.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V1->V2:
- Separate directories for both the syscalls.
- Added common header file.
- Use tst_alloc() instead of malloc().
- Use proper format for description.
- Minor other cleanups.

 include/lapi/name_to_handle_at.h              |  54 +++++++++
 runtest/syscalls                              |   3 +
 .../syscalls/name_to_handle_at/.gitignore     |   2 +
 .../syscalls/name_to_handle_at/Makefile       |   7 ++
 .../name_to_handle_at/name_to_handle_at01.c   | 113 ++++++++++++++++++
 .../name_to_handle_at/name_to_handle_at02.c   |  82 +++++++++++++
 6 files changed, 261 insertions(+)
 create mode 100644 include/lapi/name_to_handle_at.h
 create mode 100644 testcases/kernel/syscalls/name_to_handle_at/.gitignore
 create mode 100644 testcases/kernel/syscalls/name_to_handle_at/Makefile
 create mode 100644 testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at01.c
 create mode 100644 testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at02.c

diff --git a/include/lapi/name_to_handle_at.h b/include/lapi/name_to_handle_at.h
new file mode 100644
index 000000000000..19c08545802a
--- /dev/null
+++ b/include/lapi/name_to_handle_at.h
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Linaro Limited. All rights reserved.
+ * Author: Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+#ifndef NAME_TO_HANDLE_AT_H__
+#define NAME_TO_HANDLE_AT_H__
+
+#include <sys/syscall.h>
+#include "config.h"
+#include "tst_buffers.h"
+#include "tst_test.h"
+
+#ifndef HAVE_NAME_TO_HANDLE_AT
+struct file_handle {
+	unsigned int handle_bytes;
+	int handle_type;
+	/* File identifier.  */
+	unsigned char f_handle[0];
+};
+
+int name_to_handle_at(int dfd, const char *pathname, struct file_handle *handle,
+		      int *mount_id, int flags);
+int open_by_handle_at(int mount_fd, struct file_handle *handle, int flags);
+#endif
+
+/* Returns a valid pointer on success, NULL on errors */
+static inline struct file_handle *
+allocate_file_handle(int dfd, const char *pathname)
+{
+	struct file_handle fh = {}, *fhp;
+	int mount_id;
+
+	/*
+	 * Make an initial call to name_to_handle_at() to discover the size
+	 * required for the file handle.
+	 */
+	TEST(name_to_handle_at(dfd, pathname, &fh, &mount_id, 0));
+	if (TST_RET != -1 || TST_ERR != EOVERFLOW) {
+		tst_res(TFAIL | TTERRNO,
+			"name_to_handle_at() should fail with EOVERFLOW");
+		return NULL;
+	}
+
+	/* Valid file handle */
+	fhp = tst_alloc(sizeof(*fhp) + fh.handle_bytes);
+	fhp->handle_type = fh.handle_type;
+	fhp->handle_bytes = fh.handle_bytes;
+
+	return fhp;
+}
+
+#endif /* NAME_TO_HANDLE_AT_H__ */
diff --git a/runtest/syscalls b/runtest/syscalls
index a5363277f478..65f2e58a87e4 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -846,6 +846,9 @@ nanosleep01 nanosleep01
 nanosleep02 nanosleep02
 nanosleep04 nanosleep04
 
+name_to_handle_at01 name_to_handle_at01
+name_to_handle_at02 name_to_handle_at02
+
 nftw01 nftw01
 nftw6401 nftw6401
 
diff --git a/testcases/kernel/syscalls/name_to_handle_at/.gitignore b/testcases/kernel/syscalls/name_to_handle_at/.gitignore
new file mode 100644
index 000000000000..268a8a34f85e
--- /dev/null
+++ b/testcases/kernel/syscalls/name_to_handle_at/.gitignore
@@ -0,0 +1,2 @@
+name_to_handle_at01
+name_to_handle_at02
diff --git a/testcases/kernel/syscalls/name_to_handle_at/Makefile b/testcases/kernel/syscalls/name_to_handle_at/Makefile
new file mode 100644
index 000000000000..18896b6f28c0
--- /dev/null
+++ b/testcases/kernel/syscalls/name_to_handle_at/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at01.c b/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at01.c
new file mode 100644
index 000000000000..1213654d108f
--- /dev/null
+++ b/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at01.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+/*\
+ * [DESCRIPTION]
+ *
+ * Basic name_to_handle_at() tests.
+ *
+ * [ALGORITHM]
+ *  - Check that EOVERFLOW is returned as expected by name_to_handle_at().
+ *  - Check that we were able to access a file's stat with name_to_handle_at()
+ *    and open_by_handle_at().
+\*/
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <sys/stat.h>
+#include "lapi/name_to_handle_at.h"
+
+#define TEST_FILE "test_file"
+#define TEST_DIR "test_dir"
+
+static int dir_fd, fd_atcwd = AT_FDCWD;
+static struct file_handle *fhp;
+
+static struct tcase {
+	int *dfd;
+	const char *pathname;
+	int name_flags;
+	int flags;
+} tcases[] = {
+	{&dir_fd, TEST_FILE, 0, O_RDWR},
+	{&dir_fd, TEST_FILE, 0, O_RDONLY},
+	{&dir_fd, TEST_FILE, 0, O_WRONLY},
+	{&dir_fd, TEST_FILE, AT_EMPTY_PATH, O_RDWR},
+	{&dir_fd, TEST_FILE, AT_EMPTY_PATH, O_RDONLY},
+	{&dir_fd, TEST_FILE, AT_EMPTY_PATH, O_WRONLY},
+	{&dir_fd, TEST_FILE, AT_SYMLINK_FOLLOW, O_RDWR},
+	{&dir_fd, TEST_FILE, AT_SYMLINK_FOLLOW, O_RDONLY},
+	{&dir_fd, TEST_FILE, AT_SYMLINK_FOLLOW, O_WRONLY},
+	{&dir_fd, TEST_FILE, AT_EMPTY_PATH | AT_SYMLINK_FOLLOW, O_RDWR},
+	{&dir_fd, TEST_FILE, AT_EMPTY_PATH | AT_SYMLINK_FOLLOW, O_RDONLY},
+	{&dir_fd, TEST_FILE, AT_EMPTY_PATH | AT_SYMLINK_FOLLOW, O_WRONLY},
+	{&dir_fd, "", AT_EMPTY_PATH, O_RDONLY},
+
+	{&fd_atcwd, TEST_FILE, 0, O_RDWR},
+	{&fd_atcwd, TEST_FILE, 0, O_RDONLY},
+	{&fd_atcwd, TEST_FILE, 0, O_WRONLY},
+	{&fd_atcwd, TEST_FILE, AT_EMPTY_PATH, O_RDWR},
+	{&fd_atcwd, TEST_FILE, AT_EMPTY_PATH, O_RDONLY},
+	{&fd_atcwd, TEST_FILE, AT_EMPTY_PATH, O_WRONLY},
+	{&fd_atcwd, TEST_FILE, AT_SYMLINK_FOLLOW, O_RDWR},
+	{&fd_atcwd, TEST_FILE, AT_SYMLINK_FOLLOW, O_RDONLY},
+	{&fd_atcwd, TEST_FILE, AT_SYMLINK_FOLLOW, O_WRONLY},
+	{&fd_atcwd, TEST_FILE, AT_EMPTY_PATH | AT_SYMLINK_FOLLOW, O_RDWR},
+	{&fd_atcwd, TEST_FILE, AT_EMPTY_PATH | AT_SYMLINK_FOLLOW, O_RDONLY},
+	{&fd_atcwd, TEST_FILE, AT_EMPTY_PATH | AT_SYMLINK_FOLLOW, O_WRONLY},
+	{&fd_atcwd, "", AT_EMPTY_PATH, O_RDONLY},
+};
+
+static void cleanup(void)
+{
+	SAFE_CLOSE(dir_fd);
+}
+
+static void setup(void)
+{
+	SAFE_MKDIR(TEST_DIR, 0700);
+	dir_fd = SAFE_OPEN(TEST_DIR, O_DIRECTORY);
+	SAFE_CHDIR(TEST_DIR);
+	SAFE_TOUCH(TEST_FILE, 0600, NULL);
+	fhp = allocate_file_handle(AT_FDCWD, TEST_FILE);
+}
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	struct stat file_stat;
+	int fd, mount_id;
+
+	TEST(name_to_handle_at(*tc->dfd, tc->pathname, fhp, &mount_id,
+			       tc->name_flags));
+	if (TST_RET) {
+		tst_res(TFAIL | TTERRNO, "name_to_handle_at() failed (%d)", n);
+		return;
+	}
+
+	TEST(fd = open_by_handle_at(*tc->dfd, fhp, tc->flags));
+	if (fd < 0) {
+		tst_res(TFAIL | TTERRNO, "open_by_handle_at() failed (%d)", n);
+		return;
+	}
+
+	SAFE_FSTAT(fd, &file_stat);
+
+	/* Don't check stats when pathname is empty */
+	if (file_stat.st_size == 0 || !tc->pathname[0])
+		tst_res(TPASS, "name_to_handle_at() passed (%d)", n);
+	else
+		tst_res(TFAIL, "fstat() didn't work as expected (%d)", n);
+
+	SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+};
diff --git a/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at02.c b/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at02.c
new file mode 100644
index 000000000000..4e73b2f5dee8
--- /dev/null
+++ b/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at02.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+/*\
+ * [DESCRIPTION]
+ *
+ * Failure tests for name_to_handle_at().
+\*/
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include "lapi/name_to_handle_at.h"
+
+#define TEST_FILE "test_file"
+
+static struct file_handle fh, high_fh = {.handle_bytes = MAX_HANDLE_SZ + 1};
+static struct file_handle *valid_fhp = &fh, *invalid_fhp, *high_fhp = &high_fh;
+static int mount_id, *valid_mount_id = &mount_id, *invalid_mount_id;
+static const char *valid_path = TEST_FILE, *invalid_path, *empty_path = "";
+
+static struct tcase {
+	const char *name;
+	int dfd;
+	const char **pathname;
+	int flags;
+	struct file_handle **fhp;
+	int **mount_id;
+	int exp_errno;
+} tcases[] = {
+	{"invalid-dfd", -1, &valid_path, 0, &valid_fhp, &valid_mount_id, EBADF},
+	{"not a directory", 0, &valid_path, 0, &valid_fhp, &valid_mount_id, ENOTDIR},
+	{"invalid-path", AT_FDCWD, &invalid_path, 0, &valid_fhp, &valid_mount_id, EFAULT},
+	{"invalid-file-handle", AT_FDCWD, &valid_path, 0, &invalid_fhp, &valid_mount_id, EFAULT},
+	{"zero-file-handle-size", AT_FDCWD, &valid_path, 0, &valid_fhp, &valid_mount_id, EOVERFLOW},
+	{"high-file-handle-size", AT_FDCWD, &valid_path, 0, &high_fhp, &valid_mount_id, EINVAL},
+	{"invalid-mount_id", AT_FDCWD, &valid_path, 0, &valid_fhp, &invalid_mount_id, EFAULT},
+	{"invalid-flags", AT_FDCWD, &valid_path, -1, &valid_fhp, &valid_mount_id, EINVAL},
+	{"empty-path", AT_FDCWD, &empty_path, 0, &valid_fhp, &valid_mount_id, ENOENT},
+};
+
+static void setup(void)
+{
+	void *faulty_address;
+
+	SAFE_TOUCH(TEST_FILE, 0600, NULL);
+	faulty_address = tst_get_bad_addr(NULL);
+	invalid_fhp = faulty_address;
+	invalid_mount_id = faulty_address;
+	invalid_path = faulty_address;
+}
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	TEST(name_to_handle_at(tc->dfd, *tc->pathname, *tc->fhp, *tc->mount_id,
+			       tc->flags));
+
+	if (TST_RET != -1) {
+		tst_res(TFAIL, "%s: name_to_handle_at() passed unexpectedly",
+			tc->name);
+		return;
+	}
+
+	if (tc->exp_errno != TST_ERR) {
+		tst_res(TFAIL | TTERRNO,
+			"%s: name_to_handle_at() should fail with %s", tc->name,
+			tst_strerrno(tc->exp_errno));
+		return;
+	}
+
+	tst_res(TPASS | TTERRNO, "%s: name_to_handle_at() failed as expected",
+		tc->name);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+	.setup = setup,
+	.needs_tmpdir = 1,
+};
-- 
2.25.0.rc1.19.g042ed3e048af

