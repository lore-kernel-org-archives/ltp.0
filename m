From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 14 Feb 2020 17:05:53 +0530
Subject: [LTP] [PATCH 4/7] syscalls/fsmount: New tests
In-Reply-To: <cover.1581680021.git.viresh.kumar@linaro.org>
References: <cover.1581680021.git.viresh.kumar@linaro.org>
Message-ID: <1c61c673a02152c30edac0e25438257c23c3322e.1581680021.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add tests to check working of fsmount() syscall.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 configure.ac                                  |  1 +
 runtest/syscalls                              |  3 +
 testcases/kernel/syscalls/fsmount/.gitignore  |  2 +
 testcases/kernel/syscalls/fsmount/Makefile    |  6 ++
 testcases/kernel/syscalls/fsmount/fsmount01.c | 71 ++++++++++++++++
 testcases/kernel/syscalls/fsmount/fsmount02.c | 83 +++++++++++++++++++
 6 files changed, 166 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fsmount/.gitignore
 create mode 100644 testcases/kernel/syscalls/fsmount/Makefile
 create mode 100644 testcases/kernel/syscalls/fsmount/fsmount01.c
 create mode 100644 testcases/kernel/syscalls/fsmount/fsmount02.c

diff --git a/configure.ac b/configure.ac
index f006c53e7df1..734fb10c4b31 100644
--- a/configure.ac
+++ b/configure.ac
@@ -81,6 +81,7 @@ AC_CHECK_FUNCS([ \
     fallocate \
     fchownat \
     fsconfig \
+    fsmount \
     fsopen \
     fstatat \
     getdents \
diff --git a/runtest/syscalls b/runtest/syscalls
index e27e94d5d17f..0b1def7d4659 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -545,6 +545,9 @@ fanotify15 fanotify15
 fsconfig01 fsconfig01
 fsconfig02 fsconfig02
 
+fsmount01 fsmount01
+fsmount02 fsmount02
+
 fsopen01 fsopen01
 fsopen02 fsopen02
 
diff --git a/testcases/kernel/syscalls/fsmount/.gitignore b/testcases/kernel/syscalls/fsmount/.gitignore
new file mode 100644
index 000000000000..aaa66d57f417
--- /dev/null
+++ b/testcases/kernel/syscalls/fsmount/.gitignore
@@ -0,0 +1,2 @@
+fsmount01
+fsmount02
diff --git a/testcases/kernel/syscalls/fsmount/Makefile b/testcases/kernel/syscalls/fsmount/Makefile
new file mode 100644
index 000000000000..5ea7d67db123
--- /dev/null
+++ b/testcases/kernel/syscalls/fsmount/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/fsmount/fsmount01.c b/testcases/kernel/syscalls/fsmount/fsmount01.c
new file mode 100644
index 000000000000..83fcf0d51f47
--- /dev/null
+++ b/testcases/kernel/syscalls/fsmount/fsmount01.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * Description:
+ * Basic fsmount() test.
+ */
+#include "tst_test.h"
+#include "lapi/fsmount.h"
+
+#define MNTPOINT	"mntpoint"
+
+static int fd, fsmfd;
+
+static void setup(void)
+{
+	TEST(fsopen(tst_device->fs_type, 0));
+	fd = TST_RET;
+
+	if (fd == -1)
+		tst_brk(TBROK | TERRNO, "fsopen() failed");
+}
+
+static void cleanup(void)
+{
+	SAFE_CLOSE(fd);
+}
+
+static void run(void)
+{
+	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TERRNO, "fsconfig() failed");
+
+	TEST(fsconfig(fd, FSCONFIG_SET_FLAG, "rw", NULL, 0));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TERRNO, "fsconfig() failed");
+
+	TEST(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TERRNO, "fsconfig() failed");
+
+	TEST(fsmount(fd, 0, 0));
+	if (TST_RET == -1)
+		tst_brk(TFAIL | TERRNO, "fsmount() failed");
+
+	fsmfd = TST_RET;
+
+	TEST(move_mount(fsmfd, "", AT_FDCWD, MNTPOINT,
+			MOVE_MOUNT_F_EMPTY_PATH));
+	SAFE_CLOSE(fsmfd);
+
+	if (TST_RET == -1)
+		tst_brk(TBROK | TERRNO, "move_mount() failed");
+
+	SAFE_CLOSE(TST_RET);
+	TEST(umount(MNTPOINT));
+
+	tst_res(TPASS, "fsmount() passed");
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
diff --git a/testcases/kernel/syscalls/fsmount/fsmount02.c b/testcases/kernel/syscalls/fsmount/fsmount02.c
new file mode 100644
index 000000000000..cbe99bf99c1f
--- /dev/null
+++ b/testcases/kernel/syscalls/fsmount/fsmount02.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * Description:
+ * Basic fsmount() failure tests.
+ */
+#include "tst_test.h"
+#include "lapi/fsmount.h"
+
+int fd, invalid_fd = -1;
+
+static struct tcase {
+	char *name;
+	int *fd;
+	unsigned int flags;
+	unsigned int mount_attrs;
+	int exp_errno;
+} tcases[] = {
+	{"invalid-fd", &invalid_fd, FSMOUNT_CLOEXEC, 0, EBADF},
+	{"invalid-flags", &fd, 0x02, 0, EINVAL},
+	{"invalid-attrs", &fd, FSMOUNT_CLOEXEC, 0x100, EINVAL},
+};
+
+static void cleanup(void)
+{
+	SAFE_CLOSE(fd);
+}
+
+static void setup(void)
+{
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
+	if (TST_RET != -1)
+		return;
+
+out:
+	cleanup();
+	tst_brk(TBROK | TERRNO, "fsconfig() failed");
+}
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	TEST(fsmount(*tc->fd, tc->flags, tc->mount_attrs));
+	if (TST_RET != -1) {
+		SAFE_CLOSE(TST_RET);
+		tst_brk(TFAIL, "%s: fsmount() succeeded unexpectedly (index: %d)",
+			tc->name, n);
+	}
+
+	if (tc->exp_errno != TST_ERR) {
+		tst_brk(TFAIL | TTERRNO, "%s: fsmount() should fail with %s",
+			tc->name, tst_strerrno(tc->exp_errno));
+	}
+
+	tst_res(TPASS | TTERRNO, "%s: fsmount() failed as expected", tc->name);
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
+};
-- 
2.21.0.rc0.269.g1a574e7a288b

