From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 14 Feb 2020 17:05:56 +0530
Subject: [LTP] [PATCH 7/7] syscalls/open_tree: New tests
In-Reply-To: <cover.1581680021.git.viresh.kumar@linaro.org>
References: <cover.1581680021.git.viresh.kumar@linaro.org>
Message-ID: <4f704460cf7087dd8710eeabbc452d4394d61c2d.1581680021.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add tests to check working of open_tree() syscall.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 configure.ac                                  |   1 +
 runtest/syscalls                              |   3 +
 .../kernel/syscalls/open_tree/.gitignore      |   2 +
 testcases/kernel/syscalls/open_tree/Makefile  |   6 +
 .../kernel/syscalls/open_tree/open_tree01.c   | 115 ++++++++++++++++++
 .../kernel/syscalls/open_tree/open_tree02.c   | 110 +++++++++++++++++
 6 files changed, 237 insertions(+)
 create mode 100644 testcases/kernel/syscalls/open_tree/.gitignore
 create mode 100644 testcases/kernel/syscalls/open_tree/Makefile
 create mode 100644 testcases/kernel/syscalls/open_tree/open_tree01.c
 create mode 100644 testcases/kernel/syscalls/open_tree/open_tree02.c

diff --git a/configure.ac b/configure.ac
index de767b1413bb..a6753d03b884 100644
--- a/configure.ac
+++ b/configure.ac
@@ -95,6 +95,7 @@ AC_CHECK_FUNCS([ \
     move_mount \
     name_to_handle_at \
     openat \
+    open_tree \
     pidfd_open \
     pidfd_send_signal \
     pkey_mprotect \
diff --git a/runtest/syscalls b/runtest/syscalls
index d90e212748a2..9cea13141b31 100644
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
index 000000000000..dc62a52b03b4
--- /dev/null
+++ b/testcases/kernel/syscalls/open_tree/.gitignore
@@ -0,0 +1,2 @@
+open_tree01
+open_tree02
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
index 000000000000..74feb9556478
--- /dev/null
+++ b/testcases/kernel/syscalls/open_tree/open_tree01.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * Description:
+ * Basic open_tree() test.
+ */
+#include "tst_test.h"
+#include "lapi/fsmount.h"
+
+#define MNTPOINT	"mntpoint"
+#define OT_MNTPOINT	"ot_mntpoint"
+
+static int fd, fsmfd, mmfd;
+
+static void cleanup(void)
+{
+	if (mmfd != -1)
+		SAFE_CLOSE(mmfd);
+
+	SAFE_CLOSE(fsmfd);
+	TEST(umount(MNTPOINT));
+	SAFE_CLOSE(fd);
+}
+
+static void setup(void)
+{
+	char *err = "fsconfig()";
+
+	TEST(fsopen(tst_device->fs_type, 0));
+	fd = TST_RET;
+
+	if (fd == -1)
+		tst_brk(TBROK | TERRNO, "fsopen() failed");
+
+	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
+	if (TST_RET == -1)
+		goto out;
+
+	TEST(fsconfig(fd, FSCONFIG_SET_FLAG, "rw", NULL, 0));
+	if (TST_RET == -1)
+		goto out;
+
+	TEST(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
+	if (TST_RET == -1)
+		goto out;
+
+	TEST(fsmount(fd, 0, 0));
+	if (TST_RET == -1) {
+		err = "fsmount()";
+		goto out;
+	}
+
+	fsmfd = TST_RET;
+
+	TEST(move_mount(fsmfd, "", AT_FDCWD, MNTPOINT,
+			MOVE_MOUNT_F_EMPTY_PATH));
+	if (TST_RET != -1) {
+		mmfd = TST_RET;
+		return;
+	}
+
+	SAFE_CLOSE(fsmfd);
+	err = "move_mount()";
+
+out:
+	SAFE_CLOSE(fd);
+	tst_brk(TBROK | TERRNO, "%s failed", err);
+}
+
+static void run(void)
+{
+	int otfd;
+
+	SAFE_MKDIR(OT_MNTPOINT, 0777);
+
+	TEST(open_tree(AT_FDCWD, MNTPOINT, OPEN_TREE_CLONE));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TERRNO, "open_tree() failed");
+		goto out;
+	}
+
+	otfd = TST_RET;
+
+	/* Earlier file descriptor isn't valid anymore */
+	mmfd = -1;
+
+	TEST(move_mount(otfd, "", AT_FDCWD, OT_MNTPOINT,
+			MOVE_MOUNT_F_EMPTY_PATH));
+
+	SAFE_CLOSE(otfd);
+
+	if (TST_RET == -1) {
+		tst_res(TBROK | TERRNO, "move_mount() failed");
+		goto out;
+	}
+
+	SAFE_CLOSE(TST_RET);
+	TEST(umount(OT_MNTPOINT));
+
+	tst_res(TPASS, "open_tree() passed");
+out:
+	SAFE_RMDIR(OT_MNTPOINT);
+}
+
+static struct tst_test test = {
+	.min_kver = "5.2",
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.format_device = 1,
+	.mntpoint = MNTPOINT,
+};
diff --git a/testcases/kernel/syscalls/open_tree/open_tree02.c b/testcases/kernel/syscalls/open_tree/open_tree02.c
new file mode 100644
index 000000000000..136c1b25a2b9
--- /dev/null
+++ b/testcases/kernel/syscalls/open_tree/open_tree02.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * Description:
+ * Basic open_tree() failure tests.
+ */
+#include "tst_test.h"
+#include "lapi/fsmount.h"
+
+#define MNTPOINT	"mntpoint"
+
+static int fd, fsmfd, mmfd;
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
+static void cleanup(void)
+{
+	SAFE_CLOSE(mmfd);
+	SAFE_CLOSE(fsmfd);
+	TEST(umount(MNTPOINT));
+	SAFE_CLOSE(fd);
+}
+
+static void setup(void)
+
+{
+	char *err = "fsconfig()";
+
+	TEST(fsopen(tst_device->fs_type, 0));
+	fd = TST_RET;
+
+	if (fd == -1)
+		tst_brk(TBROK | TERRNO, "fsopen() failed");
+
+	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
+	if (TST_RET == -1)
+		goto out;
+
+	TEST(fsconfig(fd, FSCONFIG_SET_FLAG, "rw", NULL, 0));
+	if (TST_RET == -1)
+		goto out;
+
+	TEST(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
+	if (TST_RET == -1)
+		goto out;
+
+	TEST(fsmount(fd, 0, 0));
+	if (TST_RET == -1) {
+		err = "fsmount()";
+		goto out;
+	}
+
+	fsmfd = TST_RET;
+
+	TEST(move_mount(fsmfd, "", AT_FDCWD, MNTPOINT,
+			MOVE_MOUNT_F_EMPTY_PATH));
+	if (TST_RET != -1) {
+		mmfd = TST_RET;
+		return;
+	}
+
+	SAFE_CLOSE(fsmfd);
+	err = "move_mount()";
+
+out:
+	SAFE_CLOSE(fd);
+	tst_brk(TBROK | TERRNO, "%s failed", err);
+}
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	TEST(open_tree(tc->dirfd, tc->pathname, tc->flags));
+	if (TST_RET != -1) {
+		SAFE_CLOSE(TST_RET);
+		tst_brk(TFAIL, "%s: open_tree() succeeded unexpectedly (index: %d)",
+			tc->name, n);
+	}
+
+	if (tc->exp_errno != TST_ERR) {
+		tst_brk(TFAIL | TTERRNO, "%s: open_tree() should fail with %s",
+			tc->name, tst_strerrno(tc->exp_errno));
+	}
+
+	tst_res(TPASS | TTERRNO, "%s: open_tree() failed as expected", tc->name);
+}
+
+static struct tst_test test = {
+	.min_kver = "5.2",
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.format_device = 1,
+	.mntpoint = MNTPOINT,
+};
-- 
2.21.0.rc0.269.g1a574e7a288b

