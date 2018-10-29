From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 29 Oct 2018 10:49:44 +0800
Subject: [LTP] [PATCH 3/3] syscalls/execveat02: Add new testcase
Message-ID: <1540781384-32506-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Jinhui huang <huangjh.jy@cn.fujitsu.com>

Check various errnos for execveat(2).

Note:
This patch is based on the following patch set:
http://lists.linux.it/pipermail/ltp/2018-September/009416.html
http://lists.linux.it/pipermail/ltp/2018-September/009417.html

Signed-off-by: Jinhui huang <huangjh.jy@cn.fujitsu.com>
---
 runtest/syscalls                                   |   1 +
 testcases/kernel/syscalls/execveat/.gitignore      |   2 +
 testcases/kernel/syscalls/execveat/execveat02.c    | 113 +++++++++++++++++++++
 .../kernel/syscalls/execveat/execveat_errno.c      |  19 ++++
 4 files changed, 135 insertions(+)
 create mode 100644 testcases/kernel/syscalls/execveat/execveat02.c
 create mode 100644 testcases/kernel/syscalls/execveat/execveat_errno.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 7004f64..d5b68e7 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -149,6 +149,7 @@ execve04 execve04
 execve05 execve05 -i 5 -n 32
 execvp01 execvp01
 execveat01 execveat01
+execveat02 execveat02
 execveat03 execveat03
 
 exit01 exit01
diff --git a/testcases/kernel/syscalls/execveat/.gitignore b/testcases/kernel/syscalls/execveat/.gitignore
index 4e0c786..5de1f68 100644
--- a/testcases/kernel/syscalls/execveat/.gitignore
+++ b/testcases/kernel/syscalls/execveat/.gitignore
@@ -1,3 +1,5 @@
 /execveat01
+/execveat02
 /execveat03
 /execveat_child
+/execveat_errno
diff --git a/testcases/kernel/syscalls/execveat/execveat02.c b/testcases/kernel/syscalls/execveat/execveat02.c
new file mode 100644
index 0000000..bfd2a5d
--- /dev/null
+++ b/testcases/kernel/syscalls/execveat/execveat02.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
+ * Authors: Jinhui huang <huangjh.jy@cn.fujitsu.com>
+ */
+
+/* Test Description:
+ *  Check various errnos for execveat(2):
+ *    1) execveat() fails and returns EBADF if dirfd is a invalid file
+ *	 descriptor.
+ *    2) execveat() fails and returns EINVAL if flag specified is invalid.
+ *    3) execveat() fails and returns ELOOP if the file identified by dirfd and
+ *       pathname is a symbolic link and flag includes AT_SYMLINK_NOFOLLOW.
+ *    4) execveat() fails and returns ENOTDIR if pathname is relative and dirfd
+ *       is a file descriptor referring to a file other than a directory.
+ */
+
+#define _GNU_SOURCE
+#include "config.h"
+
+#include <stdio.h>
+#include <errno.h>
+
+#include "tst_test.h"
+#include "lapi/execveat.h"
+#include "lapi/fcntl.h"
+#include "execveat.h"
+
+#define MNTPOINT "mntpoint"
+#define TEST_APP "execveat_errno"
+#define TEST_SYMLINK "execveat_symlink"
+#define TEST_REL_APP MNTPOINT"/"TEST_APP
+#define TEST_ERL_SYMLINK MNTPOINT"/"TEST_SYMLINK
+
+static int bad_fd = -1, fd;
+static char app_abs_path[512], app_sym_path[512];
+
+static struct tcase {
+	int *fd;
+	char *pathname;
+	int flag;
+	int exp_err;
+} tcases[] = {
+	{&bad_fd, "", AT_EMPTY_PATH, EBADF},
+	{&fd, app_abs_path, -1, EINVAL},
+	{&fd, app_sym_path, AT_SYMLINK_NOFOLLOW, ELOOP},
+	{&fd, TEST_REL_APP, 0, ENOTDIR},
+};
+
+static void verify_execveat(unsigned int i)
+{
+	struct tcase *tc = &tcases[i];
+	char *argv[2] = {TEST_APP, NULL};
+	pid_t pid;
+
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		TEST(execveat(*tc->fd, tc->pathname, argv, environ, tc->flag));
+		if (tc->exp_err != TST_ERR) {
+			tst_res(TFAIL,
+				"execveat() fails unexpectedly, expected: %s",
+				tst_strerrno(tc->exp_err));
+		} else {
+			tst_res(TPASS | TTERRNO,
+				"execveat() fails as expected");
+		}
+	}
+}
+
+static void setup(void)
+{
+	char cur_dir_path[512];
+
+	check_execveat();
+
+	SAFE_CP(TEST_APP, TEST_REL_APP);
+
+	SAFE_GETCWD(cur_dir_path, sizeof(cur_dir_path));
+	sprintf(app_abs_path, "%s/%s", cur_dir_path, TEST_REL_APP);
+	sprintf(app_sym_path, "%s/%s", cur_dir_path, TEST_ERL_SYMLINK);
+
+	if (symlink(TEST_REL_APP, TEST_ERL_SYMLINK)) {
+		if (errno == EPERM)
+			tst_brk(TCONF,
+				"filesystem can not support symlink()");
+	}
+
+	fd = SAFE_OPEN(TEST_REL_APP, O_PATH);
+}
+
+static const char *const resource_files[] = {
+	TEST_APP,
+	NULL,
+};
+
+static void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.resource_files = resource_files,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_execveat,
+	.child_needs_reinit = 1,
+	.all_filesystems = 1,
+	.mntpoint = MNTPOINT,
+	.mount_device = 1,
+	.forks_child = 1,
+	.needs_root = 1,
+	.cleanup = cleanup,
+	.setup = setup,
+};
diff --git a/testcases/kernel/syscalls/execveat/execveat_errno.c b/testcases/kernel/syscalls/execveat/execveat_errno.c
new file mode 100644
index 0000000..df7b371
--- /dev/null
+++ b/testcases/kernel/syscalls/execveat/execveat_errno.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
+ * Authors: Jinhui huang <huangjh.jy@cn.fujitsu.com>
+ */
+
+/*
+ * execveat_errno.c
+ *  dummy program which is used by execveat02.c testcase.
+ */
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+
+int main(void)
+{
+	tst_reinit();
+	tst_res(TFAIL, "execveat() passes unexpectedly");
+	return 0;
+}
-- 
1.8.3.1



