From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 15 Jul 2016 12:46:03 +0800
Subject: [LTP] [PATCH v2 2/2] lgetxattr/lgetxattr02.c: add new testcase
In-Reply-To: <1468557963-28644-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20160713122247.GA2232@rei.scz.novell.com>
 <1468557963-28644-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1468557963-28644-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) lgetxattr(2) fails if the named attribute does not exist.
2) lgetxattr(2) fails if the size of the value buffer is too small
   to hold the result.
3) lgetxattr(2) fails when attemptes to read from a invalid address.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/ltplite                                   |   1 +
 runtest/syscalls                                  |   1 +
 testcases/kernel/syscalls/.gitignore              |   1 +
 testcases/kernel/syscalls/lgetxattr/lgetxattr02.c | 108 ++++++++++++++++++++++
 4 files changed, 111 insertions(+)
 create mode 100644 testcases/kernel/syscalls/lgetxattr/lgetxattr02.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 27ee584..87dcc36 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -386,6 +386,7 @@ lchown02 lchown02
 lchown03 lchown03
 
 lgetxattr01 lgetxattr01
+lgetxattr02 lgetxattr02
 
 link01 symlink01 -T link01
 link02 link02
diff --git a/runtest/syscalls b/runtest/syscalls
index 44f6810..87fae55 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -506,6 +506,7 @@ lchown02_16 lchown02_16
 lchown03_16 lchown03_16
 
 lgetxattr01 lgetxattr01
+lgetxattr02 lgetxattr02
 
 link01 symlink01 -T link01
 link02 link02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 9e4dcf0..784cf1d 100644
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
index 0000000..6d23469
--- /dev/null
+++ b/testcases/kernel/syscalls/lgetxattr/lgetxattr02.c
@@ -0,0 +1,108 @@
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
+* 1) lgetxattr(2) fails if the named attribute does not exist.
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
+#include <string.h>
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
+
+static struct test_case {
+	const char *path;
+	size_t size;
+	int exp_err;
+} tcase[] = {
+	{"testfile", sizeof(VALUE), ENOATTR},
+	{"symlink", 1, ERANGE},
+	{(char *)-1, sizeof(VALUE), EFAULT}
+};
+
+static void verify_lgetxattr(unsigned int n)
+{
+	struct test_case *tc = tcase + n;
+	char buf[tc->size];
+
+	TEST(lgetxattr(tc->path, SECURITY_KEY, buf, sizeof(buf)));
+	if (TEST_RETURN != -1) {
+		tst_res(TFAIL, "lgetxattr() succeeded unexpectedly");
+		return;
+	}
+
+	if (TEST_ERRNO != tc->exp_err) {
+		tst_res(TFAIL | TTERRNO, "lgetxattr() failed unexpectedlly, "
+			"expected %s", tst_strerrno(tc->exp_err));
+	} else {
+		tst_res(TPASS | TTERRNO, "lgetxattr() failed as expected");
+	}
+}
+
+static void setup(void)
+{
+	int res;
+
+	SAFE_TOUCH("testfile", 0644, NULL);
+	SAFE_SYMLINK("testfile", "symlink");
+
+	res = lsetxattr("symlink", SECURITY_KEY, VALUE, strlen(VALUE), XATTR_CREATE);
+	if (res == -1) {
+		if (errno == ENOTSUP) {
+			tst_brk(TCONF, "no xattr support in fs or "
+				"mounted without user_xattr option");
+		} else {
+			tst_brk(TBROK | TERRNO, "lsetxattr(%s) failed",
+				SECURITY_KEY);
+		}
+	}
+}
+
+static struct tst_test test = {
+	.tid = "lgetxattr02",
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.test = verify_lgetxattr,
+	.tcnt = ARRAY_SIZE(tcase),
+	.setup = setup
+};
+
+#else /* HAVE_ATTR_XATTR_H */
+	TST_TEST_TCONF("<attr/xattr.h> does not exist.");
+#endif
-- 
1.8.3.1



