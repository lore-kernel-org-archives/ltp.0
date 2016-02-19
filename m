From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 19 Feb 2016 12:55:46 +0800
Subject: [LTP] [PATCH v2 3/3] llistxattr/llistxattr03.c: add new testcase
In-Reply-To: <1455857746-25721-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20160218120305.GE19157@rei.lan>
 <1455857746-25721-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1455857746-25721-3-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

llistxattr() is identical to listxattr(), we call llistxattr() with
zero size and check that it returns value which is suitable size of
buffer to hold the name list.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/ltplite                                    |   1 +
 runtest/syscalls                                   |   1 +
 testcases/kernel/syscalls/.gitignore               |   1 +
 .../kernel/syscalls/llistxattr/llistxattr03.c      | 114 +++++++++++++++++++++
 4 files changed, 117 insertions(+)
 create mode 100644 testcases/kernel/syscalls/llistxattr/llistxattr03.c

diff --git a/runtest/ltplite b/runtest/ltplite
index ea18c22..d9a362d 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -389,6 +389,7 @@ listen01 listen01
 
 llistxattr01 llistxattr01
 llistxattr02 llistxattr02
+llistxattr03 llistxattr03
 
 llseek01 llseek01
 llseek02 llseek02
diff --git a/runtest/syscalls b/runtest/syscalls
index a986a4e..d1abf16 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -515,6 +515,7 @@ listen01 listen01
 
 llistxattr01 llistxattr01
 llistxattr02 llistxattr02
+llistxattr03 llistxattr03
 
 llseek01 llseek01
 llseek02 llseek02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 1762c14..f5ea349 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -475,6 +475,7 @@
 /listen/listen01
 /llistxattr/llistxattr01
 /llistxattr/llistxattr02
+/llistxattr/llistxattr03
 /llseek/llseek01
 /llseek/llseek02
 /llseek/llseek03
diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr03.c b/testcases/kernel/syscalls/llistxattr/llistxattr03.c
new file mode 100644
index 0000000..2c5792f
--- /dev/null
+++ b/testcases/kernel/syscalls/llistxattr/llistxattr03.c
@@ -0,0 +1,114 @@
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
+* Test Name: llistxattr03
+*
+* Description:
+* llistxattr is identical to listxattr. an empty buffer of size zero
+* can return the current size of the list of extended attribute names,
+* which can be used to estimate a suitable buffer.
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
+#include "safe_macros.h"
+#include "safe_file_ops.h"
+
+char *TCID = "llistxattr03";
+
+#ifdef HAVE_ATTR_XATTR_H
+
+static void verify_llistxattr(void);
+static void setup(void);
+static int check_suitable_buf(long);
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
+	TEST(llistxattr("testfile", NULL, 0));
+	if (TEST_RETURN == -1) {
+		tst_resm(TFAIL | TERRNO, "llistxattr() failed");
+		return;
+	}
+
+	if (check_suitable_buf(TEST_RETURN))
+		tst_resm(TPASS, "llistxattr() succeed with suitable buffer");
+	else
+		tst_resm(TFAIL, "llistxattr() failed with small buffer");
+}
+
+static void setup(void)
+{
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+
+	tst_tmpdir();
+
+	SAFE_TOUCH(cleanup, "testfile", 0644, NULL);
+}
+
+static int check_suitable_buf(long size)
+{
+	int n;
+	char buf[size];
+
+	n = llistxattr("testfile", buf, size);
+	if (n == -1)
+		return 0;
+	else
+		return 1;
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



