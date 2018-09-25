From: Jinhui huang <huangjh.jy@cn.fujitsu.com>
Date: Tue, 25 Sep 2018 16:18:55 +0800
Subject: [LTP] [PATCH 2/2] syscalls/execveat01: Add new testcase
In-Reply-To: <1537863535-25744-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1537863535-25744-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <1537863535-25744-2-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) Factor out check_execveat().
2) Check the basic functionality of execveat(2).

Signed-off-by: Jinhui huang <huangjh.jy@cn.fujitsu.com>
Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/syscalls                                   |   1 +
 testcases/kernel/syscalls/execveat/.gitignore      |   1 +
 testcases/kernel/syscalls/execveat/execveat.h      |  14 +++
 testcases/kernel/syscalls/execveat/execveat01.c    | 103 +++++++++++++++++++++
 testcases/kernel/syscalls/execveat/execveat03.c    |  10 +-
 .../kernel/syscalls/execveat/execveat_child.c      |   2 +-
 6 files changed, 121 insertions(+), 10 deletions(-)
 create mode 100644 testcases/kernel/syscalls/execveat/execveat.h
 create mode 100644 testcases/kernel/syscalls/execveat/execveat01.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 0d0be77..7004f64 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -148,6 +148,7 @@ execve03 execve03
 execve04 execve04
 execve05 execve05 -i 5 -n 32
 execvp01 execvp01
+execveat01 execveat01
 execveat03 execveat03
 
 exit01 exit01
diff --git a/testcases/kernel/syscalls/execveat/.gitignore b/testcases/kernel/syscalls/execveat/.gitignore
index cec18fd..4e0c786 100644
--- a/testcases/kernel/syscalls/execveat/.gitignore
+++ b/testcases/kernel/syscalls/execveat/.gitignore
@@ -1,2 +1,3 @@
+/execveat01
 /execveat03
 /execveat_child
diff --git a/testcases/kernel/syscalls/execveat/execveat.h b/testcases/kernel/syscalls/execveat/execveat.h
new file mode 100644
index 0000000..28e10b1
--- /dev/null
+++ b/testcases/kernel/syscalls/execveat/execveat.h
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
+ * Authors: Jinhui huang <huangjh.jy@cn.fujitsu.com>
+ *          Xiao Yang <yangx.jy@cn.fujitsu.com>
+ */
+
+void check_execveat(void)
+{
+	int ret;
+
+	ret = execveat(-1, "", NULL, NULL, AT_EMPTY_PATH);
+	if (ret == -1 && errno == EINVAL)
+		tst_brk(TCONF, "execveat() not supported");
+}
diff --git a/testcases/kernel/syscalls/execveat/execveat01.c b/testcases/kernel/syscalls/execveat/execveat01.c
new file mode 100644
index 0000000..e563a48
--- /dev/null
+++ b/testcases/kernel/syscalls/execveat/execveat01.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
+ * Authors: Jinhui huang <huangjh.jy@cn.fujitsu.com>
+ *          Xiao Yang <yangx.jy@cn.fujitsu.com>
+ */
+/* Test Description:
+ *  This case checks the basic functionality of the execveat(2):
+ *	1) When pathname is relative, it is relative to the directory where
+ *	   the executed process is located and the dirfd is the descriptor of
+ *	   the directory.
+ *	2) When pathname is relative and dirfd is the special value AT_FDCWD,
+ *	   the pathname is the relative to the current working directory of
+ *	   the calling process.
+ *	3) When pathname is absolute, dirfd can be ignored.
+ *	4) When pathname is an empty string and the flag AT_EMPTY_PATH is
+ *	   specified, dirfd specifies the file to be executed.
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
+#define TEST_APP "execveat_child"
+#define TEST_REL_APP MNTPOINT"/"TEST_APP
+
+static int fd1, fd4;
+static int fd2 = AT_FDCWD, fd3 = -1;
+static char app_abs_path[512];
+
+static struct tcase {
+	int *fd;
+	char *pathname;
+	int flag;
+} tcases[] = {
+	{&fd1, TEST_APP, 0},
+	{&fd2, TEST_REL_APP, 0},
+	{&fd3, app_abs_path, 0},
+	{&fd4, "", AT_EMPTY_PATH},
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
+		tst_res(TFAIL | TERRNO, "execveat() returns unexpected errno");
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
+
+	fd1 = SAFE_OPEN(MNTPOINT, O_DIRECTORY);
+	fd4 = SAFE_OPEN(TEST_REL_APP, O_PATH);
+}
+
+static void cleanup(void)
+{
+	if (fd1 > 0)
+		SAFE_CLOSE(fd1);
+
+	if (fd4 > 0)
+		SAFE_CLOSE(fd4);
+}
+
+static const char *const resource_files[] = {
+	TEST_APP,
+	NULL,
+};
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
diff --git a/testcases/kernel/syscalls/execveat/execveat03.c b/testcases/kernel/syscalls/execveat/execveat03.c
index d2d4aaf..def3392 100644
--- a/testcases/kernel/syscalls/execveat/execveat03.c
+++ b/testcases/kernel/syscalls/execveat/execveat03.c
@@ -53,6 +53,7 @@
 #include "tst_test.h"
 #include "lapi/execveat.h"
 #include "lapi/fcntl.h"
+#include "execveat.h"
 
 #define OVL_MNT "ovl"
 #define TEST_APP "execveat_child"
@@ -83,15 +84,6 @@ static void verify_execveat(void)
 		do_child();
 }
 
-static void check_execveat(void)
-{
-	int ret;
-
-	ret = execveat(-1, "", NULL, NULL, AT_EMPTY_PATH);
-	if (ret == -1 && errno == EINVAL)
-		tst_brk(TCONF, "execveat() not supported");
-}
-
 static void setup(void)
 {
 	int ret;
diff --git a/testcases/kernel/syscalls/execveat/execveat_child.c b/testcases/kernel/syscalls/execveat/execveat_child.c
index 9a3eb94..9a56032 100644
--- a/testcases/kernel/syscalls/execveat/execveat_child.c
+++ b/testcases/kernel/syscalls/execveat/execveat_child.c
@@ -24,7 +24,7 @@
 
 /*
  * execveat_child.c
- * dummy program which is used by execveat01.c testcase
+ * dummy program which is used by execveat01.c and execveat03.c testcases
  */
 
 #define TST_NO_DEFAULT_MAIN
-- 
1.8.3.1



