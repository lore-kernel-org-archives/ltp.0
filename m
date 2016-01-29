From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 29 Jan 2016 17:08:07 +0800
Subject: [LTP] [PATCH 1/3] llistxattr/llistxattr01.c: add new testcase
Message-ID: <1454058489-25625-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The testcase checks the basic functionality of the llistxattr(2).
llistxattr(2) retrieves the list of extended attribute names
associated with the link itself in the filesystem.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/ltplite                                    |   2 +
 runtest/syscalls                                   |   2 +
 testcases/kernel/syscalls/.gitignore               |   1 +
 testcases/kernel/syscalls/llistxattr/Makefile      |  23 +++
 .../kernel/syscalls/llistxattr/llistxattr01.c      | 168 +++++++++++++++++++++
 5 files changed, 196 insertions(+)
 create mode 100644 testcases/kernel/syscalls/llistxattr/Makefile
 create mode 100644 testcases/kernel/syscalls/llistxattr/llistxattr01.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 6ca24c5..0a56c3a 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -388,6 +388,8 @@ link08 link08
 
 listen01 listen01
 
+llistxattr01 llistxattr01
+
 llseek01 llseek01
 llseek02 llseek02
 llseek03 llseek03
diff --git a/runtest/syscalls b/runtest/syscalls
index d206831..ffd8be3 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -514,6 +514,8 @@ linkat02 linkat02
 
 listen01 listen01
 
+llistxattr01 llistxattr01
+
 llseek01 llseek01
 llseek02 llseek02
 llseek03 llseek03
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 1e0a85f..b283761 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -474,6 +474,7 @@
 /linkat/linkat01
 /linkat/linkat02
 /listen/listen01
+/llistxattr/llistxattr01
 /llseek/llseek01
 /llseek/llseek02
 /llseek/llseek03
diff --git a/testcases/kernel/syscalls/llistxattr/Makefile b/testcases/kernel/syscalls/llistxattr/Makefile
new file mode 100644
index 0000000..ed05a48
--- /dev/null
+++ b/testcases/kernel/syscalls/llistxattr/Makefile
@@ -0,0 +1,23 @@
+#
+#  Copyright (c) 2016 Fujitsu Ltd.
+#  Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
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
diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr01.c b/testcases/kernel/syscalls/llistxattr/llistxattr01.c
new file mode 100644
index 0000000..1f4e6b3
--- /dev/null
+++ b/testcases/kernel/syscalls/llistxattr/llistxattr01.c
@@ -0,0 +1,168 @@
+/*
+* Copyright (c) 2016 Fujitsu Ltd.
+* Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
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
+* Test Name: llistxattr01
+*
+* Description:
+* The testcase checks the basic functionality of the llistxattr(2).
+* llistxattr(2) retrieves the list of extended attribute names
+* associated with the given path in the filesystem. In the case of
+* a symbolic, the path associated with the link itself, not the file
+* that it refers to. The list is the set of (NULL-terminated) names,
+* one after the other. The length of the attribute name list is returned.
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
+#include "test.h"
+#include "safe_macros.h"
+#include "safe_file_ops.h"
+
+char *TCID = "llistxattr01";
+
+#ifdef HAVE_ATTR_XATTR_H
+#define SECURITY_KEY	"security.symtest"
+#define SECURITY_KEY_INIT	"security.selinux"
+#define VALUE	"test"
+#define VALUE_SIZE	4
+#define KEY_SIZE    17
+
+static void verify_llistxattr(void);
+static void setup(void);
+static void cleanup(void);
+
+int TST_TOTAL = 1;
+
+int main(int ac, char **av)
+{
+	int lc;
+
+	tst_parse_opts(ac, av, NULL, NULL);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		verify_llistxattr();
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void verify_llistxattr(void)
+{
+	int n;
+	int se = 1;
+	int size = 64;
+	char buf[size];
+	char cmp_buf1[size];
+	char cmp_buf2[size];
+
+	/* check selinux initialized attr */
+	n = lgetxattr("symlink", SECURITY_KEY_INIT, NULL, 0);
+	if (n == -1) {
+		if (errno == ENOATTR) {
+			se = 0;
+		} else {
+			tst_brkm(TFAIL | TERRNO, cleanup,
+				 "lgetxattr() failed");
+		}
+	}
+
+	TEST(llistxattr("symlink", buf, size));
+	if (TEST_RETURN == -1) {
+		tst_resm(TFAIL | TTERRNO, "llistxattr() failed");
+		return;
+	}
+
+	if (TEST_RETURN != KEY_SIZE*(1 + se)) {
+		tst_resm(TFAIL, "llistxattr() retrieved %li bytes, "
+			 "expected %i", TEST_RETURN, KEY_SIZE*2);
+		return;
+	}
+
+	/*
+	* The list of names is returned as an unordered array of
+	* NULL-terminated character strings.
+	*/
+	if (se == 1) {
+		memcpy(cmp_buf1, SECURITY_KEY, KEY_SIZE);
+		memcpy(cmp_buf1+KEY_SIZE, SECURITY_KEY_INIT, KEY_SIZE);
+		memcpy(cmp_buf2, SECURITY_KEY_INIT, KEY_SIZE);
+		memcpy(cmp_buf2+KEY_SIZE, SECURITY_KEY, KEY_SIZE);
+
+		if (memcmp(buf, cmp_buf1, KEY_SIZE*(1 + se)) && memcmp(buf, cmp_buf2, KEY_SIZE*(1 + se))) {
+			tst_resm(TFAIL, "name list mismatched");
+			return;
+		}
+	} else {
+		if (memcmp(buf, SECURITY_KEY, KEY_SIZE*(1 + se))) {
+			tst_resm(TFAIL, "name list mismatched");
+			return;
+		}
+	}
+
+	tst_resm(TPASS, "llistxattr() succeeded");
+}
+
+static void setup(void)
+{
+	int n;
+
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+
+	tst_tmpdir();
+
+	SAFE_TOUCH(cleanup, "testfile", 0644, NULL);
+
+	SAFE_SYMLINK(cleanup, "testfile", "symlink");
+
+	n = lsetxattr("symlink", SECURITY_KEY, VALUE, VALUE_SIZE, XATTR_CREATE);
+	if (n == -1) {
+		if (errno == ENOTSUP) {
+			tst_brkm(TCONF, cleanup,
+				 "no xattr support in fs or mounted "
+				 "without user_xattr option");
+		} else {
+			tst_brkm(TFAIL | TERRNO, cleanup,
+				 "lsetxattr() failed");
+		}
+	}
+}
+
+static void cleanup(void)
+{
+	tst_rmdir();
+}
+
+#else /* HAVE_ATTR_XATTR_H */
+int main(int ac, char **av)
+{
+	tst_brkm(TCONF, NULL, "<attr/xattr.h> does not exist.");
+}
+#endif
-- 
1.8.3.1



