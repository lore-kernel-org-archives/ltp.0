From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 12 Mar 2020 17:31:04 +0530
Subject: [LTP] [PATCH V6 04/10] syscalls/fsopen: New tests
In-Reply-To: <cover.1584014172.git.viresh.kumar@linaro.org>
References: <cover.1584014172.git.viresh.kumar@linaro.org>
Message-ID: <294687a2f59234ba24ac31a276ab20b85c1fcd97.1584014172.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add tests to check working of fsopen() syscall.

Acked-by: Li Wang <liwang@redhat.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 runtest/syscalls                            |  3 +
 testcases/kernel/syscalls/fsopen/.gitignore |  2 +
 testcases/kernel/syscalls/fsopen/Makefile   |  6 ++
 testcases/kernel/syscalls/fsopen/fsopen01.c | 80 +++++++++++++++++++++
 testcases/kernel/syscalls/fsopen/fsopen02.c | 58 +++++++++++++++
 5 files changed, 149 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fsopen/.gitignore
 create mode 100644 testcases/kernel/syscalls/fsopen/Makefile
 create mode 100644 testcases/kernel/syscalls/fsopen/fsopen01.c
 create mode 100644 testcases/kernel/syscalls/fsopen/fsopen02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 30ea8be21ec1..ce752f12ec55 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -344,6 +344,9 @@ fremovexattr02 fremovexattr02
 
 fsmount01 fsmount01
 
+fsopen01 fsopen01
+fsopen02 fsopen02
+
 fstat02 fstat02
 fstat02_64 fstat02_64
 fstat03 fstat03
diff --git a/testcases/kernel/syscalls/fsopen/.gitignore b/testcases/kernel/syscalls/fsopen/.gitignore
new file mode 100644
index 000000000000..5da868621883
--- /dev/null
+++ b/testcases/kernel/syscalls/fsopen/.gitignore
@@ -0,0 +1,2 @@
+/fsopen01
+/fsopen02
diff --git a/testcases/kernel/syscalls/fsopen/Makefile b/testcases/kernel/syscalls/fsopen/Makefile
new file mode 100644
index 000000000000..5ea7d67db123
--- /dev/null
+++ b/testcases/kernel/syscalls/fsopen/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/fsopen/fsopen01.c b/testcases/kernel/syscalls/fsopen/fsopen01.c
new file mode 100644
index 000000000000..d486361dcf01
--- /dev/null
+++ b/testcases/kernel/syscalls/fsopen/fsopen01.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * Basic fsopen() test which tries to configure and mount the filesystem as
+ * well.
+ */
+#include "tst_test.h"
+#include "lapi/fsmount.h"
+
+#define MNTPOINT	"mntpoint"
+
+#define TCASE_ENTRY(_flags)	{.name = "Flag " #_flags, .flags = _flags}
+
+static struct tcase {
+	char *name;
+	unsigned int flags;
+} tcases[] = {
+	TCASE_ENTRY(0),
+	TCASE_ENTRY(FSOPEN_CLOEXEC),
+};
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	int fd, fsmfd;
+
+	TEST(fd = fsopen(tst_device->fs_type, tc->flags));
+	if (fd == -1) {
+		tst_res(TFAIL | TERRNO, "fsopen() failed");
+		return;
+	}
+
+	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TERRNO, "fsconfig() failed");
+		goto out;
+	}
+
+	TEST(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TERRNO, "fsconfig() failed");
+		goto out;
+	}
+
+	TEST(fsmfd = fsmount(fd, 0, 0));
+	if (fsmfd == -1) {
+		tst_res(TFAIL | TERRNO, "fsmount() failed");
+		goto out;
+	}
+
+	TEST(move_mount(fsmfd, "", AT_FDCWD, MNTPOINT,
+			MOVE_MOUNT_F_EMPTY_PATH));
+
+	SAFE_CLOSE(fsmfd);
+
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TERRNO, "move_mount() failed");
+		goto out;
+	}
+
+	if (tst_is_mounted_at_tmpdir(MNTPOINT)) {
+		SAFE_UMOUNT(MNTPOINT);
+		tst_res(TPASS, "%s: fsopen() passed", tc->name);
+	}
+
+out:
+	SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+	.setup = fsopen_supported_by_kernel,
+	.needs_root = 1,
+	.format_device = 1,
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
+	.dev_fs_flags = TST_FS_SKIP_FUSE,
+};
diff --git a/testcases/kernel/syscalls/fsopen/fsopen02.c b/testcases/kernel/syscalls/fsopen/fsopen02.c
new file mode 100644
index 000000000000..3f287bf2962b
--- /dev/null
+++ b/testcases/kernel/syscalls/fsopen/fsopen02.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * Basic fsopen() failure tests.
+ */
+#include "tst_test.h"
+#include "lapi/fsmount.h"
+
+const char *invalid_fs = "invalid";
+const char *valid_fs;
+
+static struct tcase {
+	char *name;
+	const char **fs;
+	unsigned int flags;
+	int exp_errno;
+} tcases[] = {
+	{"invalid-fs", &invalid_fs, 0, ENODEV},
+	{"invalid-flags", &valid_fs, 0x10, EINVAL},
+};
+
+static void setup(void)
+{
+	fsopen_supported_by_kernel();
+
+	valid_fs = tst_device->fs_type;
+}
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	TEST(fsopen(*tc->fs, tc->flags));
+
+	if (TST_RET != -1) {
+		SAFE_CLOSE(TST_RET);
+		tst_res(TFAIL, "%s: fsopen() succeeded unexpectedly (index: %d)",
+			tc->name, n);
+		return;
+	}
+
+	if (tc->exp_errno != TST_ERR) {
+		tst_res(TFAIL | TTERRNO, "%s: fsopen() should fail with %s",
+			tc->name, tst_strerrno(tc->exp_errno));
+		return;
+	}
+
+	tst_res(TPASS | TTERRNO, "%s: fsopen() failed as expected", tc->name);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+	.setup = setup,
+	.needs_root = 1,
+	.needs_device = 1,
+};
-- 
2.21.0.rc0.269.g1a574e7a288b

