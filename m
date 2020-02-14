From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 14 Feb 2020 17:05:55 +0530
Subject: [LTP] [PATCH 6/7] syscalls/fspick: New tests
In-Reply-To: <cover.1581680021.git.viresh.kumar@linaro.org>
References: <cover.1581680021.git.viresh.kumar@linaro.org>
Message-ID: <6db1879832ebda6620a76acf3666280e87d79253.1581680021.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add tests to check working of fspick() syscall.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 configure.ac                                |   1 +
 runtest/syscalls                            |   3 +
 testcases/kernel/syscalls/fspick/.gitignore |   2 +
 testcases/kernel/syscalls/fspick/Makefile   |   6 ++
 testcases/kernel/syscalls/fspick/fspick01.c | 104 ++++++++++++++++++
 testcases/kernel/syscalls/fspick/fspick02.c | 110 ++++++++++++++++++++
 6 files changed, 226 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fspick/.gitignore
 create mode 100644 testcases/kernel/syscalls/fspick/Makefile
 create mode 100644 testcases/kernel/syscalls/fspick/fspick01.c
 create mode 100644 testcases/kernel/syscalls/fspick/fspick02.c

diff --git a/configure.ac b/configure.ac
index 05b7d0a72c0a..de767b1413bb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -81,6 +81,7 @@ AC_CHECK_FUNCS([ \
     fallocate \
     fchownat \
     fsconfig \
+    fspick \
     fsmount \
     fsopen \
     fstatat \
diff --git a/runtest/syscalls b/runtest/syscalls
index 04e11ef4f9d2..d90e212748a2 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -545,6 +545,9 @@ fanotify15 fanotify15
 fsconfig01 fsconfig01
 fsconfig02 fsconfig02
 
+fspick01 fspick01
+fspick02 fspick02
+
 fsmount01 fsmount01
 fsmount02 fsmount02
 
diff --git a/testcases/kernel/syscalls/fspick/.gitignore b/testcases/kernel/syscalls/fspick/.gitignore
new file mode 100644
index 000000000000..ddcb2231e58c
--- /dev/null
+++ b/testcases/kernel/syscalls/fspick/.gitignore
@@ -0,0 +1,2 @@
+fspick01
+fspick02
diff --git a/testcases/kernel/syscalls/fspick/Makefile b/testcases/kernel/syscalls/fspick/Makefile
new file mode 100644
index 000000000000..5ea7d67db123
--- /dev/null
+++ b/testcases/kernel/syscalls/fspick/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/fspick/fspick01.c b/testcases/kernel/syscalls/fspick/fspick01.c
new file mode 100644
index 000000000000..927435f8741f
--- /dev/null
+++ b/testcases/kernel/syscalls/fspick/fspick01.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * Description:
+ * Basic fspick() test.
+ */
+#include "tst_test.h"
+#include "lapi/fsmount.h"
+
+#define MNTPOINT	"mntpoint"
+
+static int fd, fsmfd, mmfd;
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
+	TEST(move_mount(TST_RET, "", AT_FDCWD, MNTPOINT,
+			MOVE_MOUNT_F_EMPTY_PATH));
+	if (TST_RET != -1) {
+		mmfd = TST_RET;
+		return;
+	}
+
+	SAFE_CLOSE(fsmfd);
+
+	err = "move_mount()";
+
+out:
+	SAFE_CLOSE(fd);
+	tst_brk(TBROK | TERRNO, "%s failed", err);
+}
+
+static void run(void)
+{
+	int fspick_fd;
+
+	TEST(fspick(AT_FDCWD, MNTPOINT, FSPICK_NO_AUTOMOUNT | FSPICK_CLOEXEC));
+	if (TST_RET == -1)
+		tst_brk(TFAIL | TERRNO, "fspick() failed");
+
+	fspick_fd = TST_RET;
+
+	TEST(fsconfig(fspick_fd, FSCONFIG_SET_STRING, "user_xattr", "false", 0));
+	if (TST_RET == -1) {
+		SAFE_CLOSE(fspick_fd);
+		tst_brk(TBROK | TERRNO, "fsconfig() failed");
+	}
+
+	TEST(fsconfig(fspick_fd, FSCONFIG_SET_FLAG, "ro", NULL, 0));
+	if (TST_RET == -1) {
+		SAFE_CLOSE(fspick_fd);
+		tst_brk(TBROK | TERRNO, "fsconfig() failed");
+	}
+
+	SAFE_CLOSE(fspick_fd);
+	tst_res(TPASS, "fspick() passed");
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
diff --git a/testcases/kernel/syscalls/fspick/fspick02.c b/testcases/kernel/syscalls/fspick/fspick02.c
new file mode 100644
index 000000000000..4e271aa47d0a
--- /dev/null
+++ b/testcases/kernel/syscalls/fspick/fspick02.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * Description:
+ * Basic fspick() failure tests.
+ */
+#include "tst_test.h"
+#include "lapi/fsmount.h"
+
+#define MNTPOINT	"mntpoint"
+
+int fd, fsmfd, mmfd;
+
+static struct tcase {
+	char *name;
+	int dirfd;
+	const char *pathname;
+	unsigned int flags;
+	int exp_errno;
+} tcases[] = {
+	{"invalid-fd", -1, MNTPOINT, FSPICK_NO_AUTOMOUNT | FSPICK_CLOEXEC, EBADF},
+	{"invalid-path", AT_FDCWD, "invalid", FSPICK_NO_AUTOMOUNT | FSPICK_CLOEXEC, ENOENT},
+	{"invalid-flags", AT_FDCWD, MNTPOINT, 0x10, EINVAL},
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
+	TEST(move_mount(TST_RET, "", AT_FDCWD, MNTPOINT,
+			MOVE_MOUNT_F_EMPTY_PATH));
+	if (TST_RET != -1) {
+		mmfd = TST_RET;
+		return;
+	}
+
+	SAFE_CLOSE(fsmfd);
+
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
+	TEST(fspick(tc->dirfd, tc->pathname, tc->flags));
+	if (TST_RET != -1) {
+		SAFE_CLOSE(TST_RET);
+		tst_brk(TFAIL, "%s: fspick() succeeded unexpectedly (index: %d)",
+			tc->name, n);
+	}
+
+	if (tc->exp_errno != TST_ERR) {
+		tst_brk(TFAIL | TTERRNO, "%s: fspick() should fail with %s",
+			tc->name, tst_strerrno(tc->exp_errno));
+	}
+
+	tst_res(TPASS | TTERRNO, "%s: fspick() failed as expected", tc->name);
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

