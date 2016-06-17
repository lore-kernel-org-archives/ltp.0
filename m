From: Huang Jin Bao <huangjb.jy@cn.fujitsu.com>
Date: Fri, 17 Jun 2016 15:43:23 +0800
Subject: [LTP] [PATCH 1/2] lgetxattr/lgetxattr01.c: add new testcase
Message-ID: <1466149404-22555-1-git-send-email-huangjb.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The testcase checks the basic functionality of the lgetxattr(2).
In the case of a symbolic link, we only get the value of the
extended attribute related to the link itself by name.

Signed-off-by: Huang Jin Bao <huangjb.jy@cn.fujitsu.com>
---
 runtest/ltplite                                   |   2 +
 runtest/syscalls                                  |   2 +
 testcases/kernel/syscalls/.gitignore              |   1 +
 testcases/kernel/syscalls/lgetxattr/Makefile      |  23 +++++
 testcases/kernel/syscalls/lgetxattr/lgetxattr01.c | 119 ++++++++++++++++++++++
 5 files changed, 147 insertions(+)
 create mode 100644 testcases/kernel/syscalls/lgetxattr/Makefile
 create mode 100644 testcases/kernel/syscalls/lgetxattr/lgetxattr01.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 9e1f201..9d10af2 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -385,6 +385,8 @@ lchown01 lchown01
 lchown02 lchown02
 lchown03 lchown03
 
+lgetxattr01 lgetxattr01
+
 link01 symlink01 -T link01
 link02 link02
 link03 link03
diff --git a/runtest/syscalls b/runtest/syscalls
index 428b774..e66fa87 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -505,6 +505,8 @@ lchown03  lchown03
 lchown02_16 lchown02_16
 lchown03_16 lchown03_16
 
+lgetxattr01 lgetxattr01
+
 link01 symlink01 -T link01
 link02 link02
 link03 link03
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 81f4890..4b3aa9d 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -470,6 +470,7 @@
 /lchown/lchown02_16
 /lchown/lchown03
 /lchown/lchown03_16
+/lgetxattr/lgetxattr01
 /link/link02
 /link/link03
 /link/link04
diff --git a/testcases/kernel/syscalls/lgetxattr/Makefile b/testcases/kernel/syscalls/lgetxattr/Makefile
new file mode 100644
index 0000000..10d4499
--- /dev/null
+++ b/testcases/kernel/syscalls/lgetxattr/Makefile
@@ -0,0 +1,23 @@
+#
+#  Copyright (c) 2016 Fujitsu Ltd.
+#  Author: Jinbao Huang <huangjb.jy@cn.fujitsu.com>
+#
+#  This program is free software;  you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  the GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program.
+#
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/lgetxattr/lgetxattr01.c b/testcases/kernel/syscalls/lgetxattr/lgetxattr01.c
new file mode 100644
index 0000000..d96ba8e
--- /dev/null
+++ b/testcases/kernel/syscalls/lgetxattr/lgetxattr01.c
@@ -0,0 +1,119 @@
+/*
+* Copyright (c) 2016 Fujitsu Ltd.
+* Author: Jinbao Huang <huangjb.jy@cn.fujitsu.com>
+*
+* This program is free software; you can redistribute it and/or modify it
+* under the terms of version 2 of the GNU General Public License as
+* published by the Free Software Foundation.
+*
+* This program is distributed in the hope that it would be useful, but
+* WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+*
+* You should have received a copy of the GNU General Public License
+* alone with this program.
+*/
+
+/*
+* Test Name: lgetxattr01
+*
+* Description:
+* The testcase checks the basic functionality of the lgetxattr(2).
+* In the case of a symbolic link, we only get the value of the
+* extended attribute related to the link itself by name.
+*/
+
+#include "config.h"
+#include <errno.h>
+#include <sys/types.h>
+#include <string.h>
+
+#ifdef HAVE_ATTR_XATTR_H
+#include <attr/xattr.h>
+#endif
+
+#include "tst_test.h"
+
+#ifdef HAVE_ATTR_XATTR_H
+#define SECURITY_KEY1   "security.ltptest1"
+#define SECURITY_KEY2   "security.ltptest2"
+#define VALUE1   "test1"
+#define VALUE2   "test2"
+#define VALUE_SIZE      5
+
+static void set_xattr(char *path, char *key, void *value)
+{
+	int res;
+
+	res = lsetxattr(path, key, value, VALUE_SIZE, XATTR_CREATE);
+	if (res == -1) {
+		if (errno == ENOTSUP) {
+			tst_brk(TCONF,
+				"no xattr support in fs or mounted "
+				"without user_xattr option");
+		}
+
+		if (errno == EEXIST)
+			tst_brk(TBROK, "exist attribute %s", key);
+		else
+			tst_brk(TBROK | TERRNO, "lsetxattr() failed");
+	}
+}
+
+static void setup(void)
+{
+	SAFE_TOUCH("testfile", 0644, NULL);
+	SAFE_SYMLINK("testfile", "symlink");
+
+	set_xattr("testfile", SECURITY_KEY1, VALUE1);
+	set_xattr("symlink", SECURITY_KEY2, VALUE2);
+}
+
+static void verify_lgetxattr(void)
+{
+	int size = 64;
+	char buf[size];
+
+	TEST(lgetxattr("symlink", SECURITY_KEY2, buf, size));
+	if (TEST_RETURN == -1) {
+		tst_res(TFAIL | TTERRNO, "lgetxattr() failed");
+		return;
+	}
+
+	if (TEST_RETURN != VALUE_SIZE) {
+		tst_res(TFAIL, "lgetxattr() got unexpected value size");
+		return;
+	}
+
+	if (!strncmp(buf, VALUE2, TEST_RETURN))
+		tst_res(TPASS, "lgetxattr() get expect value");
+	else
+		tst_res(TFAIL, "lgetxattr() got unexpected value");
+
+	TEST(lgetxattr("symlink", SECURITY_KEY1, buf, size));
+
+	if (TEST_RETURN != -1) {
+		tst_res(TFAIL, "lgetxattr() succeeded unexpectedly");
+		return;
+	}
+
+	if (TEST_ERRNO == ENODATA) {
+		tst_res(TPASS | TTERRNO, "lgetxattr() failed as expected");
+	} else {
+		tst_res(TFAIL | TTERRNO,
+			"lgetxattr() failed unexpectedly,"
+			"expected %s", tst_strerrno(ENODATA));
+	}
+}
+
+static struct tst_test test = {
+	.tid = "lgetxattr01",
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.test_all = verify_lgetxattr,
+	.setup = setup,
+};
+
+#else
+	TST_TEST_TCONF("<attr/xattr.h> does not exist.");
+#endif /* HAVE_ATTR_XATTR_H */
-- 
1.8.3.1



