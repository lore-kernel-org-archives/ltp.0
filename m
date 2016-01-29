From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 29 Jan 2016 17:08:54 +0800
Subject: [LTP] [PATCH 1/2] removexattr/removexattr01.c: add new testcase
Message-ID: <1454058535-25666-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The testcase checks the basic functionality of the removexattr(2).
removexattr(2) removes the extended attribute identified by
name and associated with the given path in the filesystem.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/ltplite                                    |   2 +
 runtest/syscalls                                   |   2 +
 testcases/kernel/syscalls/.gitignore               |   1 +
 testcases/kernel/syscalls/removexattr/Makefile     |  23 ++++
 .../kernel/syscalls/removexattr/removexattr01.c    | 125 +++++++++++++++++++++
 5 files changed, 153 insertions(+)
 create mode 100644 testcases/kernel/syscalls/removexattr/Makefile
 create mode 100644 testcases/kernel/syscalls/removexattr/removexattr01.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 6ca24c5..f1851d6 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -640,6 +640,8 @@ recvfrom01 recvfrom01
 
 recvmsg01 recvmsg01
 
+removexattr01 removexattr01
+
 rename01 rename01
 rename01A symlink01 -T rename01
 rename02 rename02
diff --git a/runtest/syscalls b/runtest/syscalls
index d206831..2c6db8c 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -861,6 +861,8 @@ recvmsg01 recvmsg01
 remap_file_pages01 remap_file_pages01
 remap_file_pages02 remap_file_pages02
 
+removexattr01 removexattr01
+
 rename01 rename01
 rename01A symlink01 -T rename01
 rename02 rename02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 1e0a85f..69e2298 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -712,6 +712,7 @@
 /recvmsg/recvmsg01
 /remap_file_pages/remap_file_pages01
 /remap_file_pages/remap_file_pages02
+/removexattr/removexattr01
 /rename/rename01
 /rename/rename02
 /rename/rename03
diff --git a/testcases/kernel/syscalls/removexattr/Makefile b/testcases/kernel/syscalls/removexattr/Makefile
new file mode 100644
index 0000000..ed05a48
--- /dev/null
+++ b/testcases/kernel/syscalls/removexattr/Makefile
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
diff --git a/testcases/kernel/syscalls/removexattr/removexattr01.c b/testcases/kernel/syscalls/removexattr/removexattr01.c
new file mode 100644
index 0000000..23ad250
--- /dev/null
+++ b/testcases/kernel/syscalls/removexattr/removexattr01.c
@@ -0,0 +1,125 @@
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
+* Test Name: removexattr01
+*
+* Description:
+* The testcase checks the basic functionality of the removexattr(2).
+* removexattr(2) removes the extended attribute identified by
+* name and associated with the given path in the filesystem.
+*/
+
+#include "config.h"
+#include <errno.h>
+#include <sys/types.h>
+
+#ifdef HAVE_ATTR_XATTR_H
+#include <attr/xattr.h>
+#endif
+
+#include "test.h"
+#include "safe_file_ops.h"
+
+char *TCID = "removexattr01";
+
+#ifdef HAVE_ATTR_XATTR_H
+#define USER_KEY	"user.test"
+#define VALUE	"test"
+#define VALUE_SIZE	4
+
+static void verify_removexattr(void);
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
+		verify_removexattr();
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void verify_removexattr(void)
+{
+	int n;
+	int size = 64;
+	char buf[size];
+
+	TEST(removexattr("testfile", USER_KEY));
+	if (TEST_RETURN != 0) {
+		tst_resm(TFAIL, "removexattr() failed");
+		return;
+	}
+
+	n = getxattr("testfile", USER_KEY, buf, size);
+	if (n != -1) {
+		tst_resm(TFAIL, "getxattr() succeeded unexpectedly");
+		return;
+	}
+
+	if (errno != ENOATTR)
+		tst_resm(TFAIL, "removexattr() failed");
+	else
+		tst_resm(TPASS, "removexattr() succeeded");
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
+	n = setxattr("testfile", USER_KEY, VALUE, VALUE_SIZE, XATTR_CREATE);
+	if (n == -1) {
+		if (errno == ENOTSUP) {
+			tst_brkm(TCONF, cleanup, "no xattr support in fs or "
+				 "mounted without user_xattr option");
+		} else {
+			tst_brkm(TFAIL | TERRNO, cleanup, "setxattr() failed");
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



