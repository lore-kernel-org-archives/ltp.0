From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 14 Feb 2020 17:05:54 +0530
Subject: [LTP] [PATCH 5/7] syscalls/move_mount: New tests
In-Reply-To: <cover.1581680021.git.viresh.kumar@linaro.org>
References: <cover.1581680021.git.viresh.kumar@linaro.org>
Message-ID: <dc526a3e1bfb7835860f381192babee33766340d.1581680021.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add tests to check working of move_mount() syscall.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 configure.ac                                  |   1 +
 runtest/syscalls                              |   3 +
 .../kernel/syscalls/move_mount/.gitignore     |   2 +
 testcases/kernel/syscalls/move_mount/Makefile |   6 ++
 .../kernel/syscalls/move_mount/move_mount01.c |  82 ++++++++++++++
 .../kernel/syscalls/move_mount/move_mount02.c | 102 ++++++++++++++++++
 6 files changed, 196 insertions(+)
 create mode 100644 testcases/kernel/syscalls/move_mount/.gitignore
 create mode 100644 testcases/kernel/syscalls/move_mount/Makefile
 create mode 100644 testcases/kernel/syscalls/move_mount/move_mount01.c
 create mode 100644 testcases/kernel/syscalls/move_mount/move_mount02.c

diff --git a/configure.ac b/configure.ac
index 734fb10c4b31..05b7d0a72c0a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -91,6 +91,7 @@ AC_CHECK_FUNCS([ \
     mkdirat \
     mknodat \
     modify_ldt \
+    move_mount \
     name_to_handle_at \
     openat \
     pidfd_open \
diff --git a/runtest/syscalls b/runtest/syscalls
index 0b1def7d4659..04e11ef4f9d2 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -731,6 +731,9 @@ mount04 mount04
 mount05 mount05
 mount06 mount06
 
+move_mount01 move_mount01
+move_mount02 move_mount02
+
 move_pages01 move_pages01
 move_pages02 move_pages02
 move_pages03 move_pages03
diff --git a/testcases/kernel/syscalls/move_mount/.gitignore b/testcases/kernel/syscalls/move_mount/.gitignore
new file mode 100644
index 000000000000..8e2f4aaf497b
--- /dev/null
+++ b/testcases/kernel/syscalls/move_mount/.gitignore
@@ -0,0 +1,2 @@
+move_mount01
+move_mount02
diff --git a/testcases/kernel/syscalls/move_mount/Makefile b/testcases/kernel/syscalls/move_mount/Makefile
new file mode 100644
index 000000000000..5ea7d67db123
--- /dev/null
+++ b/testcases/kernel/syscalls/move_mount/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/move_mount/move_mount01.c b/testcases/kernel/syscalls/move_mount/move_mount01.c
new file mode 100644
index 000000000000..5b719013fed2
--- /dev/null
+++ b/testcases/kernel/syscalls/move_mount/move_mount01.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * Description:
+ * Basic move_mount() test.
+ */
+#include "tst_test.h"
+#include "lapi/fsmount.h"
+
+#define MNTPOINT	"mntpoint"
+
+static int fd, fsmfd, mmfd = -1;
+
+static void cleanup(void)
+{
+	SAFE_CLOSE(fsmfd);
+
+	if (mmfd != -1) {
+		SAFE_CLOSE(mmfd);
+		TEST(umount(MNTPOINT));
+	}
+
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
+	if (TST_RET == -1)
+		goto out;
+
+	TEST(fsmount(fd, 0, 0));
+	if (TST_RET == -1) {
+		SAFE_CLOSE(fd);
+		tst_brk(TBROK | TERRNO, "fsmount() failed");
+	}
+
+	fsmfd = TST_RET;
+	return;
+
+out:
+	SAFE_CLOSE(fd);
+	tst_brk(TBROK | TERRNO, "fsconfig() failed");
+}
+
+static void run(void)
+{
+	TEST(move_mount(fsmfd, "", AT_FDCWD, MNTPOINT,
+			MOVE_MOUNT_F_EMPTY_PATH));
+	if (TST_RET == -1)
+		tst_brk(TFAIL | TERRNO, "move_mount() failed");
+
+	mmfd = TST_RET;
+
+	tst_res(TPASS, "move_mount() passed");
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
diff --git a/testcases/kernel/syscalls/move_mount/move_mount02.c b/testcases/kernel/syscalls/move_mount/move_mount02.c
new file mode 100644
index 000000000000..8cff7e82069a
--- /dev/null
+++ b/testcases/kernel/syscalls/move_mount/move_mount02.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * Description:
+ * Basic move_mount() failure tests.
+ */
+#include "tst_test.h"
+#include "lapi/fsmount.h"
+
+#define MNTPOINT	"mntpoint"
+
+int fd, invalid_fd = -1, fsmfd;
+
+static struct tcase {
+	char *name;
+	int *from_dirfd;
+	const char *from_pathname;
+	int to_dirfd;
+	const char *to_pathname;
+	unsigned int flags;
+	int exp_errno;
+} tcases[] = {
+	{"invalid-from-fd", &invalid_fd, "", AT_FDCWD, MNTPOINT, MOVE_MOUNT_F_EMPTY_PATH, EBADF},
+	{"invalid-from-path", &fsmfd, "invalid", AT_FDCWD, MNTPOINT, MOVE_MOUNT_F_EMPTY_PATH, ENOENT},
+	{"invalid-to-fd", &fsmfd, "", -1, MNTPOINT, MOVE_MOUNT_F_EMPTY_PATH, EBADF},
+	{"invalid-to-path", &fsmfd, "", AT_FDCWD, "invalid", MOVE_MOUNT_F_EMPTY_PATH, ENOENT},
+	{"invalid-flags", &fsmfd, "", AT_FDCWD, MNTPOINT, 0x08, EINVAL},
+};
+
+static void cleanup(void)
+{
+	SAFE_CLOSE(fsmfd);
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
+	if (TST_RET == -1)
+		goto out;
+
+	TEST(fsmount(fd, 0, 0));
+	if (TST_RET == -1) {
+		SAFE_CLOSE(fd);
+		tst_brk(TBROK | TERRNO, "fsmount() failed");
+	}
+
+	fsmfd = TST_RET;
+	return;
+
+out:
+	SAFE_CLOSE(fd);
+	tst_brk(TBROK | TERRNO, "fsconfig() failed");
+}
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	TEST(move_mount(*tc->from_dirfd, tc->from_pathname, tc->to_dirfd,
+			tc->to_pathname, tc->flags));
+	if (TST_RET != -1) {
+		SAFE_CLOSE(TST_RET);
+		TEST(umount(MNTPOINT));
+		tst_brk(TFAIL, "%s: move_mount() succeeded unexpectedly (index: %d)",
+			tc->name, n);
+	}
+
+	if (tc->exp_errno != TST_ERR) {
+		tst_brk(TFAIL | TTERRNO, "%s: move_mount() should fail with %s",
+			tc->name, tst_strerrno(tc->exp_errno));
+	}
+
+	tst_res(TPASS | TTERRNO, "%s: move_mount() failed as expected", tc->name);
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

