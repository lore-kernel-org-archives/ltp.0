From: Huang Jin Bao <huangjb.jy@cn.fujitsu.com>
Date: Fri, 17 Jun 2016 15:43:24 +0800
Subject: [LTP] [PATCH 2/2] lgetxattr/lgetxattr02.c: add new testcase
In-Reply-To: <1466149404-22555-1-git-send-email-huangjb.jy@cn.fujitsu.com>
References: <1466149404-22555-1-git-send-email-huangjb.jy@cn.fujitsu.com>
Message-ID: <1466149404-22555-2-git-send-email-huangjb.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) lgetxattr(2) fails if the named attribute does not exist
   or the process has no access to this attribute.
2) lgetxattr(2) fails if the size of the value buffer is too small
   to hold the result.
3) lgetxattr(2) fails when attemptes to read from a invalid address.

Signed-off-by: Huang Jin Bao <huangjb.jy@cn.fujitsu.com>
---
 runtest/ltplite                                   |   1 +
 runtest/syscalls                                  |   1 +
 testcases/kernel/syscalls/.gitignore              |   1 +
 testcases/kernel/syscalls/lgetxattr/lgetxattr02.c | 110 ++++++++++++++++++++++
 4 files changed, 113 insertions(+)
 create mode 100644 testcases/kernel/syscalls/lgetxattr/lgetxattr02.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 9d10af2..a08e147 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -386,6 +386,7 @@ lchown02 lchown02
 lchown03 lchown03
 
 lgetxattr01 lgetxattr01
+lgetxattr02 lgetxattr02
 
 link01 symlink01 -T link01
 link02 link02
diff --git a/runtest/syscalls b/runtest/syscalls
index e66fa87..a838a5d 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -506,6 +506,7 @@ lchown02_16 lchown02_16
 lchown03_16 lchown03_16
 
 lgetxattr01 lgetxattr01
+lgetxattr02 lgetxattr02
 
 link01 symlink01 -T link01
 link02 link02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 4b3aa9d..5474795 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -471,6 +471,7 @@
 /lchown/lchown03
 /lchown/lchown03_16
 /lgetxattr/lgetxattr01
+/lgetxattr/lgetxattr02
 /link/link02
 /link/link03
 /link/link04
diff --git a/testcases/kernel/syscalls/lgetxattr/lgetxattr02.c b/testcases/kernel/syscalls/lgetxattr/lgetxattr02.c
new file mode 100644
index 0000000..c911658
--- /dev/null
+++ b/testcases/kernel/syscalls/lgetxattr/lgetxattr02.c
@@ -0,0 +1,110 @@
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
+*
+*/
+
+/*
+* Test Name: lgetxattr02
+*
+* Description:
+* 1) lgetxattr(2) fails if the named attribute does not exist
+*    or the process has no access to this attribute.
+* 2) lgetxattr(2) fails if the size of the value buffer is too small
+*    to hold the result.
+* 3) lgetxattr(2) fails when attemptes to read from a invalid address.
+*
+* Expected Result:
+* 1) lgetxattr(2) should return -1 and set errno to ENOATTR.
+* 2) lgetxattr(2) should return -1 and set errno to ERANGE.
+* 3) lgetxattr(2) should return -1 and set errno to EFAULT.
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
+#include "tst_test.h"
+
+#ifdef HAVE_ATTR_XATTR_H
+
+#define SECURITY_KEY	"security.ltptest"
+#define VALUE	"this is a test value"
+#define VALUE_SIZE	20
+
+static struct test_case {
+	const char *path;
+	size_t size;
+	int exp_err;
+} tc[] = {
+	{"testfile", 19, ENOATTR},
+	{"symlink", 1, ERANGE},
+	{(char *)-1, 20, EFAULT}
+};
+
+static void verify_lgetxattr(unsigned int n)
+{
+	struct test_case *t = tc + n;
+	char buf[t->size];
+
+	TEST(lgetxattr(t->path, SECURITY_KEY, buf, tc->size));
+	if (TEST_RETURN != -1) {
+		tst_res(TFAIL, "lgetxattr() succeeded unexpectedly");
+	} else {
+		if (TEST_ERRNO != t->exp_err) {
+			tst_res(TFAIL | TTERRNO, "lgetxattr() failed "
+				"unexpectedlly, expected %s",
+				tst_strerrno(t->exp_err));
+		} else {
+			tst_res(TPASS | TTERRNO,
+				"lgetxattr() failed as expected");
+		}
+	}
+}
+
+static void setup(void)
+{
+	int n;
+
+	SAFE_TOUCH("testfile", 0644, NULL);
+
+	SAFE_SYMLINK("testfile", "symlink");
+
+	n = lsetxattr("symlink", SECURITY_KEY, VALUE, VALUE_SIZE, XATTR_CREATE);
+	if (n == -1) {
+		if (errno == ENOTSUP) {
+			tst_brk(TCONF, "no xattr support in fs or "
+				"mounted without user_xattr option");
+		} else {
+			tst_brk(TBROK | TERRNO, "lsetxattr() failed");
+		}
+	}
+}
+
+static struct tst_test test = {
+	.tid = "lgetxattr02",
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.test = verify_lgetxattr,
+	.tcnt = ARRAY_SIZE(tc),
+	.setup = setup,
+};
+
+#else /* HAVE_ATTR_XATTR_H */
+	TST_TEST_TCONF("<attr/xattr.h> does not exist.");
+#endif
-- 
1.8.3.1



