From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 29 Jan 2016 17:08:55 +0800
Subject: [LTP] [PATCH 2/2] removexattr/removexattr02.c: add new testcase
In-Reply-To: <1454058535-25666-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1454058535-25666-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1454058535-25666-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) removexattr(2) fails if the named attribute does not exist set
   errno to ENOATTR.
2) removexattr(2) fails if path is an empty string set errno to ENOENT.
3) removexattr(2) fails when attempted to read from a invalid address
   and set errno to EFAULT.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/ltplite                                    |   1 +
 runtest/syscalls                                   |   1 +
 testcases/kernel/syscalls/.gitignore               |   1 +
 .../kernel/syscalls/removexattr/removexattr02.c    | 138 +++++++++++++++++++++
 4 files changed, 141 insertions(+)
 create mode 100644 testcases/kernel/syscalls/removexattr/removexattr02.c

diff --git a/runtest/ltplite b/runtest/ltplite
index f1851d6..9e5fbbb 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -641,6 +641,7 @@ recvfrom01 recvfrom01
 recvmsg01 recvmsg01
 
 removexattr01 removexattr01
+removexattr02 removexattr02
 
 rename01 rename01
 rename01A symlink01 -T rename01
diff --git a/runtest/syscalls b/runtest/syscalls
index 2c6db8c..fb4fde5 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -862,6 +862,7 @@ remap_file_pages01 remap_file_pages01
 remap_file_pages02 remap_file_pages02
 
 removexattr01 removexattr01
+removexattr02 removexattr02
 
 rename01 rename01
 rename01A symlink01 -T rename01
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 69e2298..d9350ef 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -713,6 +713,7 @@
 /remap_file_pages/remap_file_pages01
 /remap_file_pages/remap_file_pages02
 /removexattr/removexattr01
+/removexattr/removexattr02
 /rename/rename01
 /rename/rename02
 /rename/rename03
diff --git a/testcases/kernel/syscalls/removexattr/removexattr02.c b/testcases/kernel/syscalls/removexattr/removexattr02.c
new file mode 100644
index 0000000..b9ca791
--- /dev/null
+++ b/testcases/kernel/syscalls/removexattr/removexattr02.c
@@ -0,0 +1,138 @@
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
+* Test Name: removexattr02
+*
+* Description:
+* 1) removexattr(2) fails if the named attribute does not exist.
+* 2) removexattr(2) fails if path is an empty string.
+* 3) removexattr(2) fails when attempted to read from a invalid address.
+*
+* Expected Result:
+* 1) removexattr(2) should return -1 and set errno to ENOATTR.
+* 2) removcxattr(2) should return -1 and set errno to ENOENT.
+* 3) removexattr(2) should return -1 and set errno to EFAULT.
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
+char *TCID = "removexattr02";
+
+#ifdef HAVE_ATTR_XATTR_H
+#define USER_KEY	"user.test"
+#define VALUE	"test"
+#define VALUE_SIZE	4
+
+static struct test_case {
+	const char *path;
+	char *name;
+	int exp_err;
+} tc[] = {
+	/* test1 */
+	{"testfile", "user.test1", ENOATTR},
+	/* test2 */
+	{"", USER_KEY, ENOENT},
+	/* test3 */
+	{NULL, USER_KEY, EFAULT}
+};
+
+static void verify_removexattr(struct test_case *tc);
+static void setup(void);
+static void cleanup(void);
+
+int TST_TOTAL = ARRAY_SIZE(tc);
+
+int main(int ac, char **av)
+{
+	int lc;
+	int i;
+
+	tst_parse_opts(ac, av, NULL, NULL);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+		for (i = 0; i < TST_TOTAL; i++)
+			verify_removexattr(&tc[i]);
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void verify_removexattr(struct test_case *tc)
+{
+
+	TEST(removexattr(tc->path, tc->name));
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "removexattr() succeeded unexpectedly");
+	} else {
+		if (TEST_ERRNO != tc->exp_err) {
+			tst_resm(TFAIL | TTERRNO, "removexattr() failed "
+				 "unexpectedly, expected errno is %s",
+				 tst_strerrno(tc->exp_err));
+		} else {
+			tst_resm(TPASS | TTERRNO,
+				 "removexattr() failed as expected");
+		}
+	}
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



