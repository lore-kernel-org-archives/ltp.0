From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 23 Nov 2020 14:05:54 +0530
Subject: [LTP] [PATCH V2 2/2] syscalls: Add tests for open_by_handle_at()
In-Reply-To: <b758999c1bd02a52a68cbb6449bb3d82dd2a4e69.1606120441.git.viresh.kumar@linaro.org>
References: <b758999c1bd02a52a68cbb6449bb3d82dd2a4e69.1606120441.git.viresh.kumar@linaro.org>
Message-ID: <d6ce6cbcbb1f9f92b2d3497288ce22cdec558f3e.1606120441.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds basic success and failure tests for open_by_handle_at()
syscall.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 runtest/syscalls                              |   3 +
 .../syscalls/open_by_handle_at/.gitignore     |   2 +
 .../syscalls/open_by_handle_at/Makefile       |   7 ++
 .../open_by_handle_at/open_by_handle_at01.c   | 112 ++++++++++++++++++
 .../open_by_handle_at/open_by_handle_at02.c   | 109 +++++++++++++++++
 5 files changed, 233 insertions(+)
 create mode 100644 testcases/kernel/syscalls/open_by_handle_at/.gitignore
 create mode 100644 testcases/kernel/syscalls/open_by_handle_at/Makefile
 create mode 100644 testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at01.c
 create mode 100644 testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 65f2e58a87e4..b87e57b4a3d8 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -882,6 +882,9 @@ openat201 openat201
 openat202 openat202
 openat203 openat203
 
+open_by_handle_at01 open_by_handle_at01
+open_by_handle_at02 open_by_handle_at02
+
 open_tree01 open_tree01
 open_tree02 open_tree02
 
diff --git a/testcases/kernel/syscalls/open_by_handle_at/.gitignore b/testcases/kernel/syscalls/open_by_handle_at/.gitignore
new file mode 100644
index 000000000000..799eba82a90b
--- /dev/null
+++ b/testcases/kernel/syscalls/open_by_handle_at/.gitignore
@@ -0,0 +1,2 @@
+open_by_handle_at01
+open_by_handle_at02
diff --git a/testcases/kernel/syscalls/open_by_handle_at/Makefile b/testcases/kernel/syscalls/open_by_handle_at/Makefile
new file mode 100644
index 000000000000..18896b6f28c0
--- /dev/null
+++ b/testcases/kernel/syscalls/open_by_handle_at/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at01.c b/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at01.c
new file mode 100644
index 000000000000..9abeef94ce7d
--- /dev/null
+++ b/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at01.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+/*\
+ * [DESCRIPTION]
+ *
+ * Basic open_by_handle_at() tests.
+ *
+ * [ALGORITHM]
+ *  - Check that we were able to access a file's stat which is opened with
+ *    open_by_handle_at().
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
+		tst_res(TPASS, "open_by_handle_at() passed (%d)", n);
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
diff --git a/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at02.c b/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at02.c
new file mode 100644
index 000000000000..3c8f06d854c1
--- /dev/null
+++ b/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at02.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+/*\
+ * [DESCRIPTION]
+ *
+ * Failure tests for open_by_handle_at().
+\*/
+#define _GNU_SOURCE
+#include <linux/capability.h>
+#include <fcntl.h>
+#include "tst_capability.h"
+#include "lapi/name_to_handle_at.h"
+
+#define TEST_FILE "test_file"
+#define FOO_SYMLINK "foo_symlink"
+
+static struct file_handle high_fh = {.handle_bytes = MAX_HANDLE_SZ + 1}, *high_fhp = &high_fh;
+static struct file_handle zero_fh, *zero_fhp = &zero_fh;
+static struct file_handle *valid_fhp, *invalid_fhp, *link_fhp;
+
+static struct tst_cap cap_req = TST_CAP(TST_CAP_REQ, CAP_DAC_READ_SEARCH);
+static struct tst_cap cap_drop = TST_CAP(TST_CAP_DROP, CAP_DAC_READ_SEARCH);
+
+static struct tcase {
+	const char *name;
+	int dfd;
+	struct file_handle **fhp;
+	int flags;
+	int cap;
+	int exp_errno;
+} tcases[] = {
+	{"invalid-dfd", -1, &valid_fhp, O_RDWR, 0, EBADF},
+	{"stale-dfd", 0, &valid_fhp, O_RDWR, 0, ESTALE},
+	{"invalid-file-handle", AT_FDCWD, &invalid_fhp, O_RDWR, 0, EFAULT},
+	{"high-file-handle-size", AT_FDCWD, &high_fhp, O_RDWR, 0, EINVAL},
+	{"zero-file-handle-size", AT_FDCWD, &zero_fhp, O_RDWR, 0, EINVAL},
+	{"no-capability", AT_FDCWD, &valid_fhp, O_RDWR, 1, EPERM},
+	{"symlink", AT_FDCWD, &link_fhp, O_RDWR, 0, ELOOP},
+};
+
+static void setup(void)
+{
+	void *faulty_address;
+	int mount_id;
+
+	SAFE_TOUCH(TEST_FILE, 0600, NULL);
+	SAFE_SYMLINK(TEST_FILE, FOO_SYMLINK);
+	faulty_address = tst_get_bad_addr(NULL);
+	invalid_fhp = faulty_address;
+
+	valid_fhp = allocate_file_handle(AT_FDCWD, TEST_FILE);
+	if (!valid_fhp)
+		return;
+
+	TEST(name_to_handle_at(AT_FDCWD, TEST_FILE, valid_fhp, &mount_id, 0));
+	if (TST_RET)
+		tst_res(TFAIL | TTERRNO, "name_to_handle_at() failed");
+
+	/* Symlink's file handle */
+	link_fhp = tst_alloc(sizeof(*link_fhp) + valid_fhp->handle_bytes);
+	link_fhp->handle_type = valid_fhp->handle_type;
+	link_fhp->handle_bytes = valid_fhp->handle_bytes;
+
+	TEST(name_to_handle_at(AT_FDCWD, FOO_SYMLINK, link_fhp, &mount_id, 0));
+	if (TST_RET)
+		tst_res(TFAIL | TTERRNO, "name_to_handle_at() failed");
+}
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	int fd;
+
+	if (tc->cap)
+		tst_cap_action(&cap_drop);
+
+	TEST(fd = open_by_handle_at(tc->dfd, *tc->fhp, tc->flags));
+
+	if (tc->cap)
+		tst_cap_action(&cap_req);
+
+	if (TST_RET != -1) {
+		SAFE_CLOSE(fd);
+		tst_res(TFAIL, "%s: open_by_handle_at() passed unexpectedly",
+			tc->name);
+		return;
+	}
+
+	if (tc->exp_errno != TST_ERR) {
+		tst_res(TFAIL | TTERRNO,
+			"%s: open_by_handle_at() should fail with %s", tc->name,
+			tst_strerrno(tc->exp_errno));
+		return;
+	}
+
+	tst_res(TPASS | TTERRNO, "%s: open_by_handle_at() failed as expected",
+		tc->name);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+	.setup = setup,
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+};
-- 
2.25.0.rc1.19.g042ed3e048af

