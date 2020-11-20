From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 20 Nov 2020 14:23:40 +0530
Subject: [LTP] [PATCH] syscalls: Add tests for name_to_handle_at() and
 open_by_handle_at()
Message-ID: <9c4453f49394a7864ec9c84ccd561663f54bae51.1605862411.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds basic success and failure tests for name_to_handle_at() and
open_by_handle_at() and syscalls.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 configure.ac                                  |   1 +
 runtest/syscalls                              |   5 +
 .../syscalls/name_to_handle_at/.gitignore     |   3 +
 .../syscalls/name_to_handle_at/Makefile       |   7 +
 .../name_to_handle_at/name_to_handle_at01.c   | 131 +++++++++++++++++
 .../name_to_handle_at/name_to_handle_at02.c   |  79 ++++++++++
 .../name_to_handle_at/open_by_handle_at01.c   | 139 ++++++++++++++++++
 7 files changed, 365 insertions(+)
 create mode 100644 testcases/kernel/syscalls/name_to_handle_at/.gitignore
 create mode 100644 testcases/kernel/syscalls/name_to_handle_at/Makefile
 create mode 100644 testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at01.c
 create mode 100644 testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at02.c
 create mode 100644 testcases/kernel/syscalls/name_to_handle_at/open_by_handle_at01.c

diff --git a/configure.ac b/configure.ac
index 06be1c09417a..39ba301b855d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -99,6 +99,7 @@ AC_CHECK_FUNCS_ONCE([ \
     modify_ldt \
     move_mount \
     name_to_handle_at \
+    open_by_handle_at \
     open_tree \
     openat \
     openat2 \
diff --git a/runtest/syscalls b/runtest/syscalls
index a5363277f478..aa33c1cb322f 100644
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
 
@@ -879,6 +882,8 @@ openat201 openat201
 openat202 openat202
 openat203 openat203
 
+open_by_handle_at01 open_by_handle_at01
+
 open_tree01 open_tree01
 open_tree02 open_tree02
 
diff --git a/testcases/kernel/syscalls/name_to_handle_at/.gitignore b/testcases/kernel/syscalls/name_to_handle_at/.gitignore
new file mode 100644
index 000000000000..cefa82727253
--- /dev/null
+++ b/testcases/kernel/syscalls/name_to_handle_at/.gitignore
@@ -0,0 +1,3 @@
+name_to_handle_at01
+name_to_handle_at02
+open_by_handle_at01
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
index 000000000000..36f22c003568
--- /dev/null
+++ b/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at01.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * Basic name_to_handle_at() and open_by_handle_at() tests.
+ */
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <malloc.h>
+#include <sys/stat.h>
+#include "lapi/syscalls.h"
+#include "tst_test.h"
+
+#define TEST_FILE "test_file"
+#define TEST_DIR "test_dir"
+
+static int dir_fd, fd_atcwd = AT_FDCWD;
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
+}
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	struct file_handle fh = {0, }, *fhp;
+	struct stat file_stat;
+	int fd, mount_id;
+
+	/*
+	 * Make an initial call to name_to_handle_at() to discover the size
+	 * required for the file handle.
+	 */
+	TEST(name_to_handle_at(*tc->dfd, tc->pathname, &fh, &mount_id,
+			       tc->name_flags));
+
+	if (TST_RET != -1 || TST_ERR != EOVERFLOW) {
+		tst_res(TFAIL | TTERRNO,
+			"name_to_handle_at() should fail with %s (%d)",
+			tst_strerrno(EOVERFLOW), n);
+		return;
+	}
+
+	fhp = malloc(sizeof(*fhp) + fh.handle_bytes);
+	if (!fhp) {
+		tst_res(TFAIL, "Failed to allocate memory for fhp (%d)", n);
+		return;
+	}
+
+	fhp->handle_type = fh.handle_type;
+	fhp->handle_bytes = fh.handle_bytes;
+
+	TEST(name_to_handle_at(*tc->dfd, tc->pathname, fhp, &mount_id,
+			       tc->name_flags));
+	if (TST_RET) {
+		tst_res(TFAIL | TTERRNO, "name_to_handle_at() failed (%d)", n);
+		goto out;
+	}
+
+	TEST(fd = open_by_handle_at(*tc->dfd, fhp, tc->flags));
+	if (fd < 0) {
+		tst_res(TFAIL | TTERRNO, "open_by_handle_at() failed (%d)", n);
+		goto out;
+	}
+
+	SAFE_FSTAT(fd, &file_stat);
+
+	/* Don't check stats when pathname is empty */
+	if (file_stat.st_size == 0 || !strlen(tc->pathname))
+		tst_res(TPASS, "name_to_handle_at() and open_by_handle_at() passed (%d)", n);
+	else
+		tst_res(TFAIL, "fstat() didn't work as expected (%d)", n);
+
+	SAFE_CLOSE(fd);
+
+out:
+	free(fhp);
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
index 000000000000..2e97847a6996
--- /dev/null
+++ b/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at02.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * name_to_handle_at() failure tests.
+ */
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include "lapi/syscalls.h"
+#include "tst_test.h"
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
diff --git a/testcases/kernel/syscalls/name_to_handle_at/open_by_handle_at01.c b/testcases/kernel/syscalls/name_to_handle_at/open_by_handle_at01.c
new file mode 100644
index 000000000000..e3c24790c1f8
--- /dev/null
+++ b/testcases/kernel/syscalls/name_to_handle_at/open_by_handle_at01.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * open_by_handle_at() failure tests.
+ */
+#define _GNU_SOURCE
+#include <linux/capability.h>
+#include <fcntl.h>
+#include <malloc.h>
+#include "lapi/syscalls.h"
+#include "tst_capability.h"
+#include "tst_test.h"
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
+static void cleanup(void)
+{
+	free(valid_fhp);
+	free(link_fhp);
+}
+
+static void setup(void)
+{
+	struct file_handle fh = {0, }, *fhp;
+	void *faulty_address;
+	int mount_id;
+
+	SAFE_TOUCH(TEST_FILE, 0600, NULL);
+	SAFE_SYMLINK(TEST_FILE, FOO_SYMLINK);
+	faulty_address = tst_get_bad_addr(NULL);
+	invalid_fhp = faulty_address;
+
+	/*
+	 * Make an initial call to name_to_handle_at() to discover the size
+	 * required for the file handle.
+	 */
+	TEST(name_to_handle_at(AT_FDCWD, TEST_FILE, &fh, &mount_id, 0));
+	if (TST_RET != -1 || TST_ERR != EOVERFLOW) {
+		tst_res(TFAIL | TTERRNO,
+			"name_to_handle_at() should fail with %s",
+			tst_strerrno(EOVERFLOW));
+		return;
+	}
+
+	/* Valid file handle */
+	fhp = malloc(sizeof(*fhp) + fh.handle_bytes);
+	if (!fhp) {
+		tst_res(TFAIL, "Failed to allocate memory for fhp");
+		return;
+	}
+	valid_fhp = fhp;
+
+	fhp->handle_type = fh.handle_type;
+	fhp->handle_bytes = fh.handle_bytes;
+
+	TEST(name_to_handle_at(AT_FDCWD, TEST_FILE, fhp, &mount_id, 0));
+	if (TST_RET)
+		tst_res(TFAIL | TTERRNO, "name_to_handle_at() failed");
+
+	/* Symlink file handle */
+	link_fhp = malloc(sizeof(*link_fhp) + fh.handle_bytes);
+	if (!link_fhp) {
+		tst_res(TFAIL, "Failed to allocate memory for fhp");
+		return;
+	}
+
+	link_fhp->handle_type = fh.handle_type;
+	link_fhp->handle_bytes = fh.handle_bytes;
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
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+};
-- 
2.25.0.rc1.19.g042ed3e048af

