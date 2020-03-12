From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 12 Mar 2020 17:31:07 +0530
Subject: [LTP] [PATCH V6 07/10] syscalls/fsmount: Add failure tests
In-Reply-To: <cover.1584014172.git.viresh.kumar@linaro.org>
References: <cover.1584014172.git.viresh.kumar@linaro.org>
Message-ID: <0345637ff16eb9232412028b20c11fc2c33620e9.1584014172.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds fsmount02.c tests to verify all the errors returned on
failures.

Acked-by: Li Wang <liwang@redhat.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/fsmount/.gitignore  |  1 +
 testcases/kernel/syscalls/fsmount/fsmount02.c | 80 +++++++++++++++++++
 3 files changed, 82 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fsmount/fsmount02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 72e59059f98a..41d824562dde 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -346,6 +346,7 @@ fsconfig01 fsconfig01
 fsconfig02 fsconfig02
 
 fsmount01 fsmount01
+fsmount02 fsmount02
 
 fsopen01 fsopen01
 fsopen02 fsopen02
diff --git a/testcases/kernel/syscalls/fsmount/.gitignore b/testcases/kernel/syscalls/fsmount/.gitignore
index e2f01ea17a40..7b77c5e33ee6 100644
--- a/testcases/kernel/syscalls/fsmount/.gitignore
+++ b/testcases/kernel/syscalls/fsmount/.gitignore
@@ -1 +1,2 @@
 /fsmount01
+/fsmount02
diff --git a/testcases/kernel/syscalls/fsmount/fsmount02.c b/testcases/kernel/syscalls/fsmount/fsmount02.c
new file mode 100644
index 000000000000..e3419200961c
--- /dev/null
+++ b/testcases/kernel/syscalls/fsmount/fsmount02.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * Basic fsmount() failure tests.
+ */
+#include "tst_test.h"
+#include "lapi/fsmount.h"
+
+int fd = -1, invalid_fd = -1;
+
+#define MNTPOINT	"mntpoint"
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
+	if (fd != -1)
+		SAFE_CLOSE(fd);
+}
+
+static void setup(void)
+{
+	fsopen_supported_by_kernel();
+
+	TEST(fd = fsopen(tst_device->fs_type, 0));
+	if (fd == -1)
+		tst_brk(TBROK | TERRNO, "fsopen() failed");
+
+	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TERRNO, "fsconfig() failed");
+
+	TEST(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TERRNO, "fsconfig() failed");
+}
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	TEST(fsmount(*tc->fd, tc->flags, tc->mount_attrs));
+	if (TST_RET != -1) {
+		SAFE_CLOSE(TST_RET);
+		tst_res(TFAIL, "%s: fsmount() succeeded unexpectedly (index: %d)",
+			tc->name, n);
+		return;
+	}
+
+	if (tc->exp_errno != TST_ERR) {
+		tst_res(TFAIL | TTERRNO, "%s: fsmount() should fail with %s",
+			tc->name, tst_strerrno(tc->exp_errno));
+		return;
+	}
+
+	tst_res(TPASS | TTERRNO, "%s: fsmount() failed as expected", tc->name);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.format_device = 1,
+	.all_filesystems = 1,
+	.dev_fs_flags = TST_FS_SKIP_FUSE,
+};
-- 
2.21.0.rc0.269.g1a574e7a288b

