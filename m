From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 19 Feb 2020 14:58:04 +0530
Subject: [LTP] [PATCH V2 08/10] syscalls/move_mount: New tests
In-Reply-To: <cover.1582104018.git.viresh.kumar@linaro.org>
References: <cover.1582104018.git.viresh.kumar@linaro.org>
Message-ID: <d56e916a6d93c0153ecec6310d94475202fc4cde.1582104018.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add tests to check working of move_mount() syscall.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 runtest/syscalls                              |  3 +
 .../kernel/syscalls/move_mount/.gitignore     |  2 +
 testcases/kernel/syscalls/move_mount/Makefile |  6 ++
 .../kernel/syscalls/move_mount/move_mount01.c | 82 ++++++++++++++++
 .../kernel/syscalls/move_mount/move_mount02.c | 93 +++++++++++++++++++
 5 files changed, 186 insertions(+)
 create mode 100644 testcases/kernel/syscalls/move_mount/.gitignore
 create mode 100644 testcases/kernel/syscalls/move_mount/Makefile
 create mode 100644 testcases/kernel/syscalls/move_mount/move_mount01.c
 create mode 100644 testcases/kernel/syscalls/move_mount/move_mount02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 5b652a518dc6..f207a73c3e6d 100644
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
index 000000000000..83ae40145dff
--- /dev/null
+++ b/testcases/kernel/syscalls/move_mount/.gitignore
@@ -0,0 +1,2 @@
+/move_mount01
+/move_mount02
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
index 000000000000..ff281e0c565b
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
+static struct tcase {
+	char *name;
+	unsigned int flags;
+} tcases[] = {
+	{"Flag MOVE_MOUNT_F_SYMLINKS", MOVE_MOUNT_F_SYMLINKS},
+	{"Flag MOVE_MOUNT_F_AUTOMOUNTS", MOVE_MOUNT_F_AUTOMOUNTS},
+	{"Flag MOVE_MOUNT_F_EMPTY_PATH", MOVE_MOUNT_F_EMPTY_PATH},
+	{"Flag MOVE_MOUNT_T_SYMLINKS", MOVE_MOUNT_T_SYMLINKS},
+	{"Flag MOVE_MOUNT_T_AUTOMOUNTS", MOVE_MOUNT_T_AUTOMOUNTS},
+	{"Flag MOVE_MOUNT_T_EMPTY_PATH", MOVE_MOUNT_T_EMPTY_PATH},
+};
+
+static void setup(void)
+{
+	fsopen_supported_by_kernel();
+}
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	int fsmfd, fd;
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
+		tst_brk(TBROK | TERRNO, "fsconfig() failed");
+	}
+
+	TEST(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
+	if (TST_RET == -1) {
+		SAFE_CLOSE(fd);
+		tst_brk(TBROK | TERRNO, "fsconfig() failed");
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
+			tc->flags | MOVE_MOUNT_F_EMPTY_PATH));
+	SAFE_CLOSE(fsmfd);
+
+	if (TST_RET == -1)
+		tst_brk(TFAIL | TERRNO, "move_mount() failed");
+
+	if (!tst_ismount(MNTPOINT))
+		tst_res(TPASS, "%s: move_mount() passed", tc->name);
+
+	SAFE_UMOUNT(MNTPOINT);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+	.setup = setup,
+	.needs_root = 1,
+	.format_device = 1,
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
+	.dev_fs_flags = TST_FS_SKIP_FUSE,
+};
diff --git a/testcases/kernel/syscalls/move_mount/move_mount02.c b/testcases/kernel/syscalls/move_mount/move_mount02.c
new file mode 100644
index 000000000000..805a098bfac5
--- /dev/null
+++ b/testcases/kernel/syscalls/move_mount/move_mount02.c
@@ -0,0 +1,93 @@
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
+int invalid_fd = -1, fsmfd;
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
+static void setup(void)
+{
+	fsopen_supported_by_kernel();
+}
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	int fd;
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
+		tst_brk(TBROK | TERRNO, "fsconfig() failed");
+	}
+
+	TEST(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
+	if (TST_RET == -1) {
+		SAFE_CLOSE(fd);
+		tst_brk(TBROK | TERRNO, "fsconfig() failed");
+	}
+
+	TEST(fsmount(fd, 0, 0));
+	SAFE_CLOSE(fd);
+
+	if (TST_RET == -1)
+		tst_brk(TBROK | TERRNO, "fsmount() failed");
+
+	fsmfd = TST_RET;
+	TEST(move_mount(*tc->from_dirfd, tc->from_pathname, tc->to_dirfd,
+			tc->to_pathname, tc->flags));
+	SAFE_CLOSE(fsmfd);
+
+	if (TST_RET != -1) {
+		SAFE_UMOUNT(MNTPOINT);
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
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+	.setup = setup,
+	.needs_root = 1,
+	.format_device = 1,
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
+	.dev_fs_flags = TST_FS_SKIP_FUSE,
+};
-- 
2.21.0.rc0.269.g1a574e7a288b

