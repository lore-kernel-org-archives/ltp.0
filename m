From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue,  3 Mar 2020 16:44:56 +0530
Subject: [LTP] [PATCH V2] syscalls/openat2: New tests
Message-ID: <6b3d4c2c92b4a4e6eeef708ac181b57cf7affda4.1583233870.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add tests to check working of openat2() syscall.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V1->V2:
- Separate file for testing success/failure of different resolve flags
- Better testing for checking out of bound usage of the buffer by the
  kernel with the help of tst_buffers.
- s/__u64/uint64_t/
- Drop stale AIO_LIBS reference
- Other minor modifications

 configure.ac                                  |  1 +
 include/lapi/openat2.h                        | 72 ++++++++++++++
 runtest/syscalls                              |  4 +
 testcases/kernel/syscalls/openat2/.gitignore  |  3 +
 testcases/kernel/syscalls/openat2/Makefile    |  7 ++
 testcases/kernel/syscalls/openat2/openat201.c | 98 +++++++++++++++++++
 testcases/kernel/syscalls/openat2/openat202.c | 86 ++++++++++++++++
 testcases/kernel/syscalls/openat2/openat203.c | 80 +++++++++++++++
 8 files changed, 351 insertions(+)
 create mode 100644 include/lapi/openat2.h
 create mode 100644 testcases/kernel/syscalls/openat2/.gitignore
 create mode 100644 testcases/kernel/syscalls/openat2/Makefile
 create mode 100644 testcases/kernel/syscalls/openat2/openat201.c
 create mode 100644 testcases/kernel/syscalls/openat2/openat202.c
 create mode 100644 testcases/kernel/syscalls/openat2/openat203.c

diff --git a/configure.ac b/configure.ac
index c9ec39fce2df..238d1cde85f2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -96,6 +96,7 @@ AC_CHECK_FUNCS([ \
     name_to_handle_at \
     open_tree \
     openat \
+    openat2 \
     pidfd_open \
     pidfd_send_signal \
     pkey_mprotect \
diff --git a/include/lapi/openat2.h b/include/lapi/openat2.h
new file mode 100644
index 000000000000..446a3b172821
--- /dev/null
+++ b/include/lapi/openat2.h
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Linaro Limited. All rights reserved.
+ * Author: Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+#ifndef OPENAT2_H
+#define OPENAT2_H
+
+#include <sys/syscall.h>
+#include <linux/types.h>
+
+#include "lapi/syscalls.h"
+
+#include "config.h"
+
+#ifndef HAVE_OPENAT2
+/*
+ * Arguments for how openat2(2) should open the target path. If only @flags and
+ * @mode are non-zero, then openat2(2) operates very similarly to openat(2).
+ *
+ * However, unlike openat(2), unknown or invalid bits in @flags result in
+ * -EINVAL rather than being silently ignored. @mode must be zero unless one of
+ * {O_CREAT, O_TMPFILE} are set.
+ *
+ * @flags: O_* flags.
+ * @mode: O_CREAT/O_TMPFILE file mode.
+ * @resolve: RESOLVE_* flags.
+ */
+struct open_how {
+	uint64_t flags;
+	uint64_t mode;
+	uint64_t resolve;
+};
+
+/* how->resolve flags for openat2(2). */
+#define RESOLVE_NO_XDEV		0x01 /* Block mount-point crossings
+					(includes bind-mounts). */
+#define RESOLVE_NO_MAGICLINKS	0x02 /* Block traversal through procfs-style
+					"magic-links". */
+#define RESOLVE_NO_SYMLINKS	0x04 /* Block traversal through all symlinks
+					(implies OEXT_NO_MAGICLINKS) */
+#define RESOLVE_BENEATH		0x08 /* Block "lexical" trickery like
+					"..", symlinks, and absolute
+					paths which escape the dirfd. */
+#define RESOLVE_IN_ROOT		0x10 /* Make all jumps to "/" and ".."
+					be scoped inside the dirfd
+					(similar to chroot(2)). */
+
+int openat2(int dfd, const char *pathname, struct open_how *how, size_t size)
+{
+	return tst_syscall(__NR_openat2, dfd, pathname, how, size);
+}
+#endif
+
+struct open_how_pad {
+	/* how should be kept as the first entry here */
+	struct open_how how;
+	uint64_t pad;
+};
+
+void openat2_supported_by_kernel(void)
+{
+	if ((tst_kvercmp(5, 6, 0)) < 0) {
+		/* Check if the syscall is backported on an older kernel */
+		TEST(syscall(__NR_openat2, -1, NULL, NULL, 0));
+		if (TST_RET == -1 && TST_ERR == ENOSYS)
+			tst_brk(TCONF, "Test not supported on kernel version < v5.2");
+	}
+}
+
+#endif /* OPENAT2_H */
diff --git a/runtest/syscalls b/runtest/syscalls
index 14df8d34338e..6a571408b005 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -845,6 +845,10 @@ openat01 openat01
 openat02 openat02
 openat03 openat03
 
+openat201 openat201
+openat202 openat202
+openat203 openat203
+
 open_tree01 open_tree01
 open_tree02 open_tree02
 
diff --git a/testcases/kernel/syscalls/openat2/.gitignore b/testcases/kernel/syscalls/openat2/.gitignore
new file mode 100644
index 000000000000..5a0843a85229
--- /dev/null
+++ b/testcases/kernel/syscalls/openat2/.gitignore
@@ -0,0 +1,3 @@
+openat201
+openat202
+openat203
diff --git a/testcases/kernel/syscalls/openat2/Makefile b/testcases/kernel/syscalls/openat2/Makefile
new file mode 100644
index 000000000000..18896b6f28c0
--- /dev/null
+++ b/testcases/kernel/syscalls/openat2/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/openat2/openat201.c b/testcases/kernel/syscalls/openat2/openat201.c
new file mode 100644
index 000000000000..e2c2456769f4
--- /dev/null
+++ b/testcases/kernel/syscalls/openat2/openat201.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * Basic openat2() test.
+ */
+#include "tst_test.h"
+#include "lapi/openat2.h"
+
+#define TEST_FILE "test_file"
+#define TEST_DIR "test_dir"
+
+static struct open_how *how;
+static struct open_how_pad *phow;
+
+static int dir_fd = -1, fd_atcwd = AT_FDCWD;
+
+static struct tcase {
+	int *dfd;
+	const char *pathname;
+	uint64_t flags;
+	uint64_t mode;
+	uint64_t resolve;
+	struct open_how **how;
+	size_t size;
+} tcases[] = {
+	{&dir_fd, TEST_FILE, O_RDWR, S_IRWXU, 0, &how, sizeof(*how)},
+	{&dir_fd, TEST_FILE, O_RDONLY, S_IRUSR, 0, &how, sizeof(*how)},
+	{&dir_fd, TEST_FILE, O_WRONLY, S_IWUSR, 0, &how, sizeof(*how)},
+	{&dir_fd, TEST_FILE, O_RDWR, S_IRWXU, RESOLVE_NO_XDEV, &how, sizeof(*how)},
+	{&dir_fd, TEST_FILE, O_RDWR, S_IRWXU, RESOLVE_NO_MAGICLINKS, &how, sizeof(*how)},
+	{&dir_fd, TEST_FILE, O_RDWR, S_IRWXU, RESOLVE_NO_SYMLINKS, &how, sizeof(*how)},
+	{&dir_fd, TEST_FILE, O_RDWR, S_IRWXU, RESOLVE_BENEATH, &how, sizeof(*how)},
+	{&dir_fd, TEST_FILE, O_RDWR, S_IRWXU, RESOLVE_IN_ROOT, &how, sizeof(*how)},
+	{&fd_atcwd, TEST_FILE, O_RDWR, S_IRWXU, 0, &how, sizeof(*how)},
+	{&fd_atcwd, TEST_FILE, O_RDONLY, S_IRUSR, 0, &how, sizeof(*how)},
+	{&fd_atcwd, TEST_FILE, O_WRONLY, S_IWUSR, 0, &how, sizeof(*how)},
+	{&fd_atcwd, TEST_FILE, O_RDWR, S_IRWXU, RESOLVE_NO_XDEV, &how, sizeof(*how)},
+	{&fd_atcwd, TEST_FILE, O_RDWR, S_IRWXU, RESOLVE_NO_MAGICLINKS, &how, sizeof(*how)},
+	{&fd_atcwd, TEST_FILE, O_RDWR, S_IRWXU, RESOLVE_NO_SYMLINKS, &how, sizeof(*how)},
+	{&fd_atcwd, TEST_FILE, O_RDWR, S_IRWXU, RESOLVE_BENEATH, &how, sizeof(*how)},
+	{&fd_atcwd, TEST_FILE, O_RDWR, S_IRWXU, RESOLVE_IN_ROOT, (struct open_how **)&phow, sizeof(*how) + 1},
+};
+
+static void cleanup(void)
+{
+	if (dir_fd != -1)
+		SAFE_CLOSE(dir_fd);
+}
+
+static void setup(void)
+{
+	openat2_supported_by_kernel();
+
+	phow->pad = 0x00;
+	SAFE_MKDIR(TEST_DIR, 0700);
+	dir_fd = SAFE_OPEN(TEST_DIR, O_DIRECTORY);
+}
+
+static void run(unsigned int n)
+{
+	int fd;
+	struct stat file_stat;
+	struct tcase *tc = &tcases[n];
+	struct open_how *myhow = *tc->how;
+
+	myhow->flags = tc->flags | O_CREAT;
+	myhow->mode = tc->mode;
+	myhow->resolve = tc->resolve;
+
+	TEST(fd = openat2(*tc->dfd, tc->pathname, myhow, tc->size));
+	if (fd < 0) {
+		tst_res(TFAIL | TTERRNO, "openat2() failed (%d)", n);
+		return;
+	}
+
+	SAFE_FSTAT(fd, &file_stat);
+
+	if (file_stat.st_size == 0)
+		tst_res(TPASS, "openat2() passed (%d)", n);
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
+	.bufs = (struct tst_buffers []) {
+		{&how, .size = sizeof(*how)},
+		{&phow, .size = sizeof(*phow)},
+		{},
+	},
+};
diff --git a/testcases/kernel/syscalls/openat2/openat202.c b/testcases/kernel/syscalls/openat2/openat202.c
new file mode 100644
index 000000000000..504878277f7e
--- /dev/null
+++ b/testcases/kernel/syscalls/openat2/openat202.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * openat2() tests with various resolve flags.
+ */
+#include "tst_test.h"
+#include "lapi/openat2.h"
+
+#define FOO_SYMLINK "foo_symlink"
+
+static struct open_how *how;
+
+static struct tcase {
+	const char *name;
+	const char *pathname;
+	uint64_t resolve;
+	int exp_errno;
+} tcases[] = {
+	/* Success cases */
+	{"open /proc/version", "/proc/version", 0, 0},
+	{"open magiclinks", "/proc/self/exe", 0, 0},
+	{"open symlinks", FOO_SYMLINK, 0, 0},
+
+	/* Failure cases */
+	{"resolve-no-xdev", "/proc/version", RESOLVE_NO_XDEV, EXDEV},
+	{"resolve-no-magiclinks", "/proc/self/exe", RESOLVE_NO_MAGICLINKS, ELOOP},
+	{"resolve-no-symlinks", FOO_SYMLINK, RESOLVE_NO_SYMLINKS, ELOOP},
+	{"resolve-beneath", "/proc/version", RESOLVE_BENEATH, EXDEV},
+	{"resolve-no-in-root", "/proc/version", RESOLVE_IN_ROOT, ENOENT},
+};
+
+static void setup(void)
+{
+	openat2_supported_by_kernel();
+	SAFE_SYMLINK("/proc/version", FOO_SYMLINK);
+}
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	how->flags = O_RDONLY | O_CREAT;
+	how->mode = S_IRUSR;
+	how->resolve = tc->resolve;
+
+	TEST(openat2(AT_FDCWD, tc->pathname, how, sizeof(*how)));
+
+	if (!tc->exp_errno) {
+		if (TST_RET < 0) {
+			tst_res(TFAIL | TTERRNO, "%s: openat2() failed",
+				tc->name);
+			return;
+		}
+
+		SAFE_CLOSE(TST_RET);
+		tst_res(TPASS, "%s: openat2() passed", tc->name);
+	} else {
+		if (TST_RET >= 0) {
+			SAFE_CLOSE(TST_RET);
+			tst_res(TFAIL, "%s: openat2() passed unexpectedly",
+				tc->name);
+			return;
+		}
+
+		if (tc->exp_errno != TST_ERR) {
+			tst_res(TFAIL | TTERRNO, "%s: openat2() should fail with %s",
+				tc->name, tst_strerrno(tc->exp_errno));
+			return;
+		}
+
+		tst_res(TPASS | TTERRNO, "%s: openat2() failed as expected",
+			tc->name);
+	}
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+	.setup = setup,
+	.needs_tmpdir = 1,
+	.bufs = (struct tst_buffers []) {
+		{&how, .size = sizeof(*how)},
+		{},
+	}
+};
diff --git a/testcases/kernel/syscalls/openat2/openat203.c b/testcases/kernel/syscalls/openat2/openat203.c
new file mode 100644
index 000000000000..64a109644352
--- /dev/null
+++ b/testcases/kernel/syscalls/openat2/openat203.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * Basic openat2() test to check various failures.
+ */
+#include "tst_test.h"
+#include "lapi/openat2.h"
+
+#define TEST_FILE "test_file"
+
+static struct open_how *how;
+static struct open_how_pad *phow;
+
+static struct tcase {
+	const char *name;
+	int dfd;
+	const char *pathname;
+	uint64_t flags;
+	uint64_t mode;
+	uint64_t resolve;
+	struct open_how **how;
+	size_t size;
+	int exp_errno;
+} tcases[] = {
+	{"invalid-dfd", -1, TEST_FILE, O_RDWR | O_CREAT, S_IRWXU, 0, &how, sizeof(*how), EBADF},
+	{"invalid-pathname", AT_FDCWD, NULL, O_RDONLY | O_CREAT, S_IRUSR, 0, &how, sizeof(*how), EFAULT},
+	{"invalid-flags", AT_FDCWD, TEST_FILE, O_RDONLY, S_IWUSR, 0, &how, sizeof(*how), EINVAL},
+	{"invalid-mode", AT_FDCWD, TEST_FILE, O_RDWR | O_CREAT, -1, 0, &how, sizeof(*how), EINVAL},
+	{"invalid-resolve", AT_FDCWD, TEST_FILE, O_RDWR | O_CREAT, S_IRWXU, -1, &how, sizeof(*how), EINVAL},
+	{"invalid-size-zero", AT_FDCWD, TEST_FILE, O_RDWR | O_CREAT, S_IRWXU, 0, &how, 0, EINVAL},
+	{"invalid-size-small", AT_FDCWD, TEST_FILE, O_RDWR | O_CREAT, S_IRWXU, 0, &how, sizeof(*how) - 1, EINVAL},
+	{"invalid-size-big", AT_FDCWD, TEST_FILE, O_RDWR | O_CREAT, S_IRWXU, 0, &how, sizeof(*how) + 1, EFAULT},
+	{"invalid-size-big-with-pad", AT_FDCWD, TEST_FILE, O_RDWR | O_CREAT, S_IRWXU, 0, (struct open_how **)&phow, sizeof(*how) + 1, E2BIG},
+};
+
+static void setup(void)
+{
+	openat2_supported_by_kernel();
+	phow->pad = 0xDEAD;
+}
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	struct open_how *myhow = *tc->how;
+
+	myhow->flags = tc->flags;
+	myhow->mode = tc->mode;
+	myhow->resolve = tc->resolve;
+
+	TEST(openat2(tc->dfd, tc->pathname, myhow, tc->size));
+
+	if (TST_RET >= 0) {
+		SAFE_CLOSE(TST_RET);
+		tst_res(TFAIL, "%s: openat2() passed unexpectedly",
+			tc->name);
+		return;
+	}
+
+	if (tc->exp_errno != TST_ERR) {
+		tst_res(TFAIL | TTERRNO, "%s: openat2() should fail with %s",
+			tc->name, tst_strerrno(tc->exp_errno));
+		return;
+	}
+
+	tst_res(TPASS | TTERRNO, "%s: openat2() failed as expected", tc->name);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+	.setup = setup,
+	.needs_tmpdir = 1,
+	.bufs = (struct tst_buffers []) {
+		{&how, .size = sizeof(*how)},
+		{&phow, .size = sizeof(*phow)},
+		{},
+	}
+};
-- 
2.21.0.rc0.269.g1a574e7a288b

