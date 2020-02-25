From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 25 Feb 2020 12:10:48 +0530
Subject: [LTP] [PATCH V3 10/10] syscalls/open_tree: New tests
In-Reply-To: <cover.1582612624.git.viresh.kumar@linaro.org>
References: <cover.1582612624.git.viresh.kumar@linaro.org>
Message-ID: <04fc7b57299c4b7f30551840f782c5fb8a424bcd.1582612624.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add tests to check working of open_tree() syscall.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 runtest/syscalls                              |   3 +
 .../kernel/syscalls/open_tree/.gitignore      |   2 +
 testcases/kernel/syscalls/open_tree/Makefile  |   6 +
 .../kernel/syscalls/open_tree/open_tree01.c   | 124 ++++++++++++++++++
 .../kernel/syscalls/open_tree/open_tree02.c   | 104 +++++++++++++++
 5 files changed, 239 insertions(+)
 create mode 100644 testcases/kernel/syscalls/open_tree/.gitignore
 create mode 100644 testcases/kernel/syscalls/open_tree/Makefile
 create mode 100644 testcases/kernel/syscalls/open_tree/open_tree01.c
 create mode 100644 testcases/kernel/syscalls/open_tree/open_tree02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index b899cc76542d..2bbbcc9ce0c3 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -844,6 +844,9 @@ openat01 openat01
 openat02 openat02
 openat03 openat03
 
+open_tree01 open_tree01
+open_tree02 open_tree02
+
 mincore01 mincore01
 mincore02 mincore02
 
diff --git a/testcases/kernel/syscalls/open_tree/.gitignore b/testcases/kernel/syscalls/open_tree/.gitignore
new file mode 100644
index 000000000000..2f732b44518e
--- /dev/null
+++ b/testcases/kernel/syscalls/open_tree/.gitignore
@@ -0,0 +1,2 @@
+/open_tree01
+/open_tree02
diff --git a/testcases/kernel/syscalls/open_tree/Makefile b/testcases/kernel/syscalls/open_tree/Makefile
new file mode 100644
index 000000000000..5ea7d67db123
--- /dev/null
+++ b/testcases/kernel/syscalls/open_tree/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/open_tree/open_tree01.c b/testcases/kernel/syscalls/open_tree/open_tree01.c
new file mode 100644
index 000000000000..ef603cc270a0
--- /dev/null
+++ b/testcases/kernel/syscalls/open_tree/open_tree01.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * Basic open_tree() test.
+ */
+#include "tst_test.h"
+#include "lapi/fsmount.h"
+
+#define MNTPOINT	"mntpoint"
+#define OT_MNTPOINT	"ot_mntpoint"
+
+#define TCASE_ENTRY(_flags)	{.name = "Flag " #_flags, .flags = _flags}
+
+static struct tcase {
+	char *name;
+	unsigned int flags;
+} tcases[] = {
+	TCASE_ENTRY(OPEN_TREE_CLONE),
+	TCASE_ENTRY(OPEN_TREE_CLOEXEC)
+};
+
+static int dir_created;
+
+static void setup(void)
+{
+	fsopen_supported_by_kernel();
+
+	SAFE_MKDIR(OT_MNTPOINT, 0777);
+	dir_created = 1;
+}
+
+static void cleanup(void)
+{
+	if (dir_created)
+		SAFE_RMDIR(OT_MNTPOINT);
+}
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	int fd, fsmfd, otfd;
+
+	TEST(fsopen(tst_device->fs_type, 0));
+	fd = TST_RET;
+
+	if (fd == -1) {
+		tst_res(TBROK | TERRNO, "fsopen() failed");
+		return;
+	}
+
+	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
+	if (TST_RET == -1) {
+		SAFE_CLOSE(fd);
+		tst_res(TBROK | TERRNO, "fsconfig failed");
+		return;
+	}
+
+	TEST(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
+	if (TST_RET == -1) {
+		SAFE_CLOSE(fd);
+		tst_res(TBROK | TERRNO, "fsconfig failed");
+		return;
+	}
+
+	TEST(fsmount(fd, 0, 0));
+	SAFE_CLOSE(fd);
+
+	if (TST_RET == -1) {
+		tst_res(TBROK | TERRNO, "fsmount() failed");
+		return;
+	}
+
+	fsmfd = TST_RET;
+
+	TEST(move_mount(fsmfd, "", AT_FDCWD, MNTPOINT,
+			MOVE_MOUNT_F_EMPTY_PATH));
+	SAFE_CLOSE(fsmfd);
+
+	if (TST_RET == -1) {
+		tst_res(TBROK | TERRNO, "move_mount() failed");
+		return;
+	}
+
+	if (!tst_is_mounted(MNTPOINT)) {
+		tst_res(TBROK | TERRNO, "device not mounted");
+		goto out;
+	}
+
+	TEST(open_tree(AT_FDCWD, MNTPOINT, tc->flags | OPEN_TREE_CLONE));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TERRNO, "open_tree() failed");
+		goto out;
+	}
+
+	otfd = TST_RET;
+	TEST(move_mount(otfd, "", AT_FDCWD, OT_MNTPOINT,
+			MOVE_MOUNT_F_EMPTY_PATH));
+	SAFE_CLOSE(otfd);
+
+	if (TST_RET == -1) {
+		tst_res(TBROK | TERRNO, "move_mount() failed");
+		goto out;
+	}
+
+	if (tst_is_mounted(OT_MNTPOINT))
+		tst_res(TPASS, "%s: open_tree() passed", tc->name);
+
+	SAFE_UMOUNT(OT_MNTPOINT);
+out:
+	SAFE_UMOUNT(MNTPOINT);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.format_device = 1,
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
+	.dev_fs_flags = TST_FS_SKIP_FUSE,
+};
diff --git a/testcases/kernel/syscalls/open_tree/open_tree02.c b/testcases/kernel/syscalls/open_tree/open_tree02.c
new file mode 100644
index 000000000000..5d0ffcf4eb09
--- /dev/null
+++ b/testcases/kernel/syscalls/open_tree/open_tree02.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * Basic open_tree() failure tests.
+ */
+#include "tst_test.h"
+#include "lapi/fsmount.h"
+
+#define MNTPOINT	"mntpoint"
+
+static struct tcase {
+	char *name;
+	int dirfd;
+	const char *pathname;
+	unsigned int flags;
+	int exp_errno;
+} tcases[] = {
+	{"invalid-fd", -1, MNTPOINT, OPEN_TREE_CLONE, EBADF},
+	{"invalid-path", AT_FDCWD, "invalid", OPEN_TREE_CLONE, ENOENT},
+	{"invalid-flags", AT_FDCWD, MNTPOINT, 0xFFFFFFFF, EINVAL},
+};
+
+static int ismounted;
+
+static void cleanup(void)
+{
+	if (ismounted)
+		SAFE_UMOUNT(MNTPOINT);
+}
+
+static void setup(void)
+{
+	int fd, fsmfd;
+
+	fsopen_supported_by_kernel();
+
+	TEST(fsopen(tst_device->fs_type, 0));
+	fd = TST_RET;
+
+	if (fd == -1)
+		tst_brk(TBROK | TERRNO, "fsopen() failed");
+
+	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
+	if (TST_RET == -1) {
+		SAFE_CLOSE(fd);
+		tst_brk(TBROK | TERRNO, "fsconfig failed");
+	}
+
+	TEST(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
+	if (TST_RET == -1) {
+		SAFE_CLOSE(fd);
+		tst_brk(TBROK | TERRNO, "fsconfig failed");
+	}
+
+	TEST(fsmount(fd, 0, 0));
+	SAFE_CLOSE(fd);
+
+	if (TST_RET == -1)
+		tst_brk(TBROK | TERRNO, "fsmount() failed");
+
+	fsmfd = TST_RET;
+	TEST(move_mount(fsmfd, "", AT_FDCWD, MNTPOINT,
+			MOVE_MOUNT_F_EMPTY_PATH));
+	SAFE_CLOSE(fsmfd);
+
+	if (TST_RET == -1)
+		tst_brk(TBROK | TERRNO, "move_mount() failed");
+
+	ismounted = 1;
+
+	if (!tst_is_mounted(MNTPOINT))
+		tst_brk(TBROK | TERRNO, "device not mounted");
+}
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	TEST(open_tree(tc->dirfd, tc->pathname, tc->flags));
+	if (TST_RET != -1) {
+		SAFE_CLOSE(TST_RET);
+		tst_res(TFAIL, "%s: open_tree() succeeded unexpectedly (index: %d)",
+			tc->name, n);
+	} else if (tc->exp_errno != TST_ERR) {
+		tst_res(TFAIL | TTERRNO, "%s: open_tree() should fail with %s",
+			tc->name, tst_strerrno(tc->exp_errno));
+	} else {
+		tst_res(TPASS | TTERRNO, "%s: open_tree() failed as expected",
+			tc->name);
+	}
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.format_device = 1,
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
+	.dev_fs_flags = TST_FS_SKIP_FUSE,
+};
-- 
2.21.0.rc0.269.g1a574e7a288b

