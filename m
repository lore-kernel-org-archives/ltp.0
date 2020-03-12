From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 12 Mar 2020 17:31:05 +0530
Subject: [LTP] [PATCH V6 05/10] syscalls/fsconfig: New tests
In-Reply-To: <cover.1584014172.git.viresh.kumar@linaro.org>
References: <cover.1584014172.git.viresh.kumar@linaro.org>
Message-ID: <824c287cd06190cf0a489535fd4617aff8742b03.1584014172.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add tests to check working of fsconfig() syscall.

Acked-by: Li Wang <liwang@redhat.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 runtest/syscalls                              |  3 +
 testcases/kernel/syscalls/fsconfig/.gitignore |  2 +
 testcases/kernel/syscalls/fsconfig/Makefile   |  6 ++
 .../kernel/syscalls/fsconfig/fsconfig01.c     | 91 +++++++++++++++++
 .../kernel/syscalls/fsconfig/fsconfig02.c     | 99 +++++++++++++++++++
 5 files changed, 201 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fsconfig/.gitignore
 create mode 100644 testcases/kernel/syscalls/fsconfig/Makefile
 create mode 100644 testcases/kernel/syscalls/fsconfig/fsconfig01.c
 create mode 100644 testcases/kernel/syscalls/fsconfig/fsconfig02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index ce752f12ec55..72e59059f98a 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -342,6 +342,9 @@ fpathconf01 fpathconf01
 fremovexattr01 fremovexattr01
 fremovexattr02 fremovexattr02
 
+fsconfig01 fsconfig01
+fsconfig02 fsconfig02
+
 fsmount01 fsmount01
 
 fsopen01 fsopen01
diff --git a/testcases/kernel/syscalls/fsconfig/.gitignore b/testcases/kernel/syscalls/fsconfig/.gitignore
new file mode 100644
index 000000000000..2bc54b82751b
--- /dev/null
+++ b/testcases/kernel/syscalls/fsconfig/.gitignore
@@ -0,0 +1,2 @@
+/fsconfig01
+/fsconfig02
diff --git a/testcases/kernel/syscalls/fsconfig/Makefile b/testcases/kernel/syscalls/fsconfig/Makefile
new file mode 100644
index 000000000000..5ea7d67db123
--- /dev/null
+++ b/testcases/kernel/syscalls/fsconfig/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig01.c b/testcases/kernel/syscalls/fsconfig/fsconfig01.c
new file mode 100644
index 000000000000..d05350ce214e
--- /dev/null
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig01.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * Basic fsconfig() test which tries to configure and mount the filesystem as
+ * well.
+ */
+#include "tst_test.h"
+#include "lapi/fsmount.h"
+
+#define MNTPOINT	"mntpoint"
+
+static int fd;
+
+static void cleanup(void)
+{
+	if (fd != -1)
+		SAFE_CLOSE(fd);
+}
+
+static void run(void)
+{
+	int fsmfd;
+
+	TEST(fd = fsopen(tst_device->fs_type, 0));
+	if (fd == -1)
+		tst_brk(TBROK | TERRNO, "fsopen() failed");
+
+	TEST(fsconfig(fd, FSCONFIG_SET_FLAG, "rw", NULL, 0));
+	if (TST_RET == -1)
+		tst_brk(TFAIL | TERRNO, "fsconfig() failed");
+
+	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
+	if (TST_RET == -1)
+		tst_brk(TFAIL | TERRNO, "fsconfig() failed");
+
+	TEST(fsconfig(fd, FSCONFIG_SET_PATH, "sync", tst_device->dev, 0));
+	if (TST_RET == -1) {
+		if (TST_ERR == EOPNOTSUPP)
+			tst_res(TCONF, "fsconfig(): FSCONFIG_SET_PATH not supported");
+		else
+			tst_brk(TFAIL | TERRNO, "fsconfig() failed");
+	}
+
+	TEST(fsconfig(fd, FSCONFIG_SET_PATH_EMPTY, "sync", tst_device->dev, 0));
+	if (TST_RET == -1) {
+		if (TST_ERR == EOPNOTSUPP)
+			tst_res(TCONF, "fsconfig(): FSCONFIG_SET_PATH_EMPTY not supported");
+		else
+			tst_brk(TFAIL | TERRNO, "fsconfig() failed");
+	}
+
+	TEST(fsconfig(fd, FSCONFIG_SET_FD, "sync", NULL, 0));
+	if (TST_RET == -1) {
+		if (TST_ERR == EOPNOTSUPP)
+			tst_res(TCONF, "fsconfig(): FSCONFIG_SET_FD not supported");
+		else
+			tst_brk(TFAIL | TERRNO, "fsconfig() failed");
+	}
+
+	TEST(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
+	if (TST_RET == -1)
+		tst_brk(TFAIL | TERRNO, "fsconfig() failed");
+
+	TEST(fsmfd = fsmount(fd, 0, 0));
+	if (fsmfd == -1)
+		tst_brk(TBROK | TERRNO, "fsmount() failed");
+
+	TEST(move_mount(fsmfd, "", AT_FDCWD, MNTPOINT,
+			MOVE_MOUNT_F_EMPTY_PATH));
+	SAFE_CLOSE(fsmfd);
+
+	if (TST_RET == -1)
+		tst_brk(TBROK | TERRNO, "move_mount() failed");
+
+	if (tst_is_mounted_at_tmpdir(MNTPOINT)) {
+		SAFE_UMOUNT(MNTPOINT);
+		tst_res(TPASS, "fsconfig() passed");
+	}
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = fsopen_supported_by_kernel,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.format_device = 1,
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
+	.dev_fs_flags = TST_FS_SKIP_FUSE,
+};
diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig02.c b/testcases/kernel/syscalls/fsconfig/fsconfig02.c
new file mode 100644
index 000000000000..b07a5f3ab82f
--- /dev/null
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig02.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * Basic fsconfig() failure tests.
+ */
+#include "tst_test.h"
+#include "lapi/fsmount.h"
+
+static int fd = -1, temp_fd = -1, invalid_fd = -1;
+static int aux_0 = 0, aux_1 = 1, aux_fdcwd = AT_FDCWD, aux_minus1 = -1;
+
+static struct tcase {
+	char *name;
+	int *fd;
+	unsigned int cmd;
+	const char *key;
+	const void *value;
+	int *aux;
+	int exp_errno;
+} tcases[] = {
+	{"invalid-fd", &invalid_fd, FSCONFIG_SET_FLAG, "user_xattr", NULL, &aux_0, EINVAL},
+	{"invalid-cmd", &fd, 100, "rw", NULL, &aux_0, EOPNOTSUPP},
+	{"set-flag-key", &fd, FSCONFIG_SET_FLAG, NULL, NULL, &aux_0, EINVAL},
+	{"set-flag-value", &fd, FSCONFIG_SET_FLAG, "rw", "foo", &aux_0, EINVAL},
+	{"set-flag-aux", &fd, FSCONFIG_SET_FLAG, "rw", NULL, &aux_1, EINVAL},
+	{"set-string-key", &fd, FSCONFIG_SET_STRING, NULL, "#grand.central.org:root.cell.", &aux_0, EINVAL},
+	{"set-string-value", &fd, FSCONFIG_SET_STRING, "source", NULL, &aux_0, EINVAL},
+	{"set-string-aux", &fd, FSCONFIG_SET_STRING, "source", "#grand.central.org:root.cell.", &aux_1, EINVAL},
+	{"set-binary-key", &fd, FSCONFIG_SET_BINARY, NULL, "foo", &aux_1, EINVAL},
+	{"set-binary-value", &fd, FSCONFIG_SET_BINARY, "sync", NULL, &aux_1, EINVAL},
+	{"set-binary-aux", &fd, FSCONFIG_SET_BINARY, "sync", "foo", &aux_0, EINVAL},
+	{"set-path-key", &fd, FSCONFIG_SET_PATH, NULL, "/dev/foo", &aux_fdcwd, EINVAL},
+	{"set-path-value", &fd, FSCONFIG_SET_PATH, "sync", NULL, &aux_fdcwd, EINVAL},
+	{"set-path-aux", &fd, FSCONFIG_SET_PATH, "sync", "/dev/foo", &aux_minus1, EINVAL},
+	{"set-path-empty-key", &fd, FSCONFIG_SET_PATH_EMPTY, NULL, "/dev/foo", &aux_fdcwd, EINVAL},
+	{"set-path-empty-value", &fd, FSCONFIG_SET_PATH_EMPTY, "sync", NULL, &aux_fdcwd, EINVAL},
+	{"set-path-empty-aux", &fd, FSCONFIG_SET_PATH_EMPTY, "sync", "/dev/foo", &aux_minus1, EINVAL},
+	{"set-fd-key", &fd, FSCONFIG_SET_FD, NULL, NULL, &temp_fd, EINVAL},
+	{"set-fd-value", &fd, FSCONFIG_SET_FD, "sync", "foo", &temp_fd, EINVAL},
+	{"set-fd-aux", &fd, FSCONFIG_SET_FD, "sync", NULL, &aux_minus1, EINVAL},
+	{"cmd-create-key", &fd, FSCONFIG_CMD_CREATE, "foo", NULL, &aux_0, EINVAL},
+	{"cmd-create-value", &fd, FSCONFIG_CMD_CREATE, NULL, "foo", &aux_0, EINVAL},
+	{"cmd-create-aux", &fd, FSCONFIG_CMD_CREATE, NULL, NULL, &aux_1, EINVAL},
+	{"cmd-reconfigure-key", &fd, FSCONFIG_CMD_RECONFIGURE, "foo", NULL, &aux_0, EINVAL},
+	{"cmd-reconfigure-value", &fd, FSCONFIG_CMD_RECONFIGURE, NULL, "foo", &aux_0, EINVAL},
+	{"cmd-reconfigure-aux", &fd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, &aux_1, EINVAL},
+};
+
+static void setup(void)
+{
+	fsopen_supported_by_kernel();
+
+	TEST(fd = fsopen(tst_device->fs_type, 0));
+	if (fd == -1)
+		tst_brk(TBROK | TERRNO, "fsopen() failed");
+
+	temp_fd = open("testfile", O_RDWR | O_CREAT, 01444);
+	if (temp_fd == -1)
+		tst_brk(TBROK, "Can't obtain temp_fd, open() failed");
+}
+
+static void cleanup(void)
+{
+	if (temp_fd != -1)
+		SAFE_CLOSE(temp_fd);
+	if (fd != -1)
+		SAFE_CLOSE(fd);
+}
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	TEST(fsconfig(*tc->fd, tc->cmd, tc->key, tc->value, *tc->aux));
+
+	if (TST_RET != -1) {
+		tst_res(TFAIL, "%s: fsconfig() succeeded unexpectedly (index: %d)",
+			tc->name, n);
+		return;
+	}
+
+	if (tc->exp_errno != TST_ERR) {
+		tst_res(TFAIL | TTERRNO, "%s: fsconfig() should fail with %s",
+			tc->name, tst_strerrno(tc->exp_errno));
+		return;
+	}
+
+	tst_res(TPASS | TTERRNO, "%s: fsconfig() failed as expected", tc->name);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.needs_device = 1,
+};
-- 
2.21.0.rc0.269.g1a574e7a288b

