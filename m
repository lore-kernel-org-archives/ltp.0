From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 25 Feb 2016 11:55:02 +0800
Subject: [LTP] [PATCH v3] llistxattr/llistxattr03.c: add new testcase
In-Reply-To: <20160224142844.GE8292@rei>
References: <20160224142844.GE8292@rei>
Message-ID: <1456372502-22000-1-git-send-email-yangx.jy@cn.fujitsu.com>
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
 .../kernel/syscalls/llistxattr/llistxattr03.c      | 137 +++++++++++++++++++++
 4 files changed, 140 insertions(+)
 create mode 100644 testcases/kernel/syscalls/llistxattr/llistxattr03.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 7766404..3e32aef 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -391,6 +391,7 @@ listen01 listen01
 
 llistxattr01 llistxattr01
 llistxattr02 llistxattr02
+llistxattr03 llistxattr03
 
 llseek01 llseek01
 llseek02 llseek02
diff --git a/runtest/syscalls b/runtest/syscalls
index 375a810..cb1b3ef 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -516,6 +516,7 @@ listen01 listen01
 
 llistxattr01 llistxattr01
 llistxattr02 llistxattr02
+llistxattr03 llistxattr03
 
 llseek01 llseek01
 llseek02 llseek02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index f53c76c..e61294b 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -476,6 +476,7 @@
 /listen/listen01
 /llistxattr/llistxattr01
 /llistxattr/llistxattr02
+/llistxattr/llistxattr03
 /llseek/llseek01
 /llseek/llseek02
 /llseek/llseek03
diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr03.c b/testcases/kernel/syscalls/llistxattr/llistxattr03.c
new file mode 100644
index 0000000..300966b
--- /dev/null
+++ b/testcases/kernel/syscalls/llistxattr/llistxattr03.c
@@ -0,0 +1,137 @@
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
+#include "safe_file_ops.h"
+
+char *TCID = "llistxattr03";
+
+#ifdef HAVE_ATTR_XATTR_H
+
+#define SECURITY_KEY	"security.ltptest"
+#define VALUE	"test"
+#define VALUE_SIZE	4
+
+static char *filename[2] = {"testfile1", "testfile2"};
+
+static void verify_llistxattr(char *);
+static void setup(void);
+static int check_suitable_buf(char *, long);
+static void cleanup(void);
+
+int TST_TOTAL = ARRAY_SIZE(filename);
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
+
+		for (i = 0; i < TST_TOTAL; i++)
+			verify_llistxattr(filename[i]);
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void verify_llistxattr(char *name)
+{
+	TEST(llistxattr(name, NULL, 0));
+	if (TEST_RETURN == -1) {
+		tst_resm(TFAIL | TERRNO, "llistxattr() failed");
+		return;
+	}
+
+	if (check_suitable_buf(name, TEST_RETURN))
+		tst_resm(TPASS, "llistxattr() succeed with suitable buffer");
+	else
+		tst_resm(TFAIL, "llistxattr() failed with small buffer");
+}
+
+static void setup(void)
+{
+	int n;
+
+	tst_require_root();
+
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+
+	tst_tmpdir();
+
+	SAFE_TOUCH(cleanup, filename[0], 0644, NULL);
+
+	SAFE_TOUCH(cleanup, filename[1], 0644, NULL);
+
+	n = lsetxattr(filename[1], SECURITY_KEY, VALUE, VALUE_SIZE, XATTR_CREATE);
+	if (n == -1) {
+		if (errno == ENOTSUP) {
+			tst_brkm(TCONF, cleanup, "no xattr support in fs or "
+				 "mounted without user_xattr option");
+		} else {
+			tst_brkm(TBROK | TERRNO, cleanup, "lsetxattr() failed");
+		}
+	}
+}
+
+static int check_suitable_buf(char *name, long size)
+{
+	int n;
+	char buf[size];
+
+	n = llistxattr(name, buf, size);
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



