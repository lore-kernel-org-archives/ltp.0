From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 26 Jan 2021 17:55:23 +0800
Subject: [LTP] [PATCH v1 1/3] syscalls/mallinfo01: Add a basic test for
 mallinfo
Message-ID: <1611654925-8994-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Referring to glibc test tst-mallinfo2.c[1], add a test to test mallinfo.
Also check mallinfo in autotools.

[1]https://sourceware.org/git/?p=glibc.git;a=blob;f=malloc/tst-mallinfo2.c

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 configure.ac                                  |  1 +
 runtest/syscalls                              |  2 +
 testcases/kernel/syscalls/mallinfo/.gitignore |  1 +
 testcases/kernel/syscalls/mallinfo/Makefile   |  8 ++
 .../kernel/syscalls/mallinfo/mallinfo01.c     | 84 +++++++++++++++++++
 5 files changed, 96 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mallinfo/.gitignore
 create mode 100644 testcases/kernel/syscalls/mallinfo/Makefile
 create mode 100644 testcases/kernel/syscalls/mallinfo/mallinfo01.c

diff --git a/configure.ac b/configure.ac
index 8bdb96300..223900ca1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -94,6 +94,7 @@ AC_CHECK_FUNCS_ONCE([ \
     io_uring_register \
     io_uring_enter \
     kcmp \
+    mallinfo \
     mallopt \
     mkdirat \
     mknodat \
diff --git a/runtest/syscalls b/runtest/syscalls
index 576eacf83..d0a9a5145 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -682,6 +682,8 @@ lstat01_64 lstat01_64
 lstat02 lstat02
 lstat02_64 lstat02_64
 
+mallinfo01 mallinfo01
+
 mallopt01 mallopt01
 
 mbind01 mbind01
diff --git a/testcases/kernel/syscalls/mallinfo/.gitignore b/testcases/kernel/syscalls/mallinfo/.gitignore
new file mode 100644
index 000000000..a7e32a637
--- /dev/null
+++ b/testcases/kernel/syscalls/mallinfo/.gitignore
@@ -0,0 +1 @@
+/mallinfo01
diff --git a/testcases/kernel/syscalls/mallinfo/Makefile b/testcases/kernel/syscalls/mallinfo/Makefile
new file mode 100644
index 000000000..044619fb8
--- /dev/null
+++ b/testcases/kernel/syscalls/mallinfo/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/mallinfo/mallinfo01.c b/testcases/kernel/syscalls/mallinfo/mallinfo01.c
new file mode 100644
index 000000000..1a2a30af1
--- /dev/null
+++ b/testcases/kernel/syscalls/mallinfo/mallinfo01.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ */
+
+/*\
+ * [DESCRIPTION]
+ *
+ * Basic mallinfo() test. Refer to glibc test
+ * https://sourceware.org/git/?p=glibc.git;a=blob;f=malloc/tst-mallinfo2.c
+\*/
+
+#include <malloc.h>
+
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+
+#ifdef HAVE_MALLINFO
+static char *buf;
+static struct mallinfo info1;
+
+static void
+print_mallinfo(const char *msg, struct mallinfo *m)
+{
+	tst_res(TINFO, "%s...", msg);
+#define P(f) tst_res(TINFO, "%s: %d", #f, m->f)
+	P(arena);
+	P(ordblks);
+	P(smblks);
+	P(hblks);
+	P(hblkhd);
+	P(usmblks);
+	P(fsmblks);
+	P(uordblks);
+	P(fordblks);
+	P(keepcost);
+}
+
+void test_mallinfo(void)
+{
+	struct mallinfo info2;
+	int i;
+	int total = 0;
+
+	for (i = 1; i < 20; i++) {
+		buf = SAFE_MALLOC(160 * i);
+		total += 16 * i;
+	}
+
+	info2 = mallinfo();
+	print_mallinfo("Test", &info2);
+	if (info2.uordblks > info1.uordblks + total)
+		tst_res(TPASS, "mallinfo() passed");
+	else
+		tst_res(TFAIL, "mallinfo() failed");
+
+	info1 = info2;
+}
+
+static void setup(void)
+{
+	if (sizeof(info1.arena) != sizeof(int))
+		tst_res(TFAIL, "The member of mallinfo struct is not int");
+
+	info1 = mallinfo();
+	print_mallinfo("Start", &info1);
+}
+
+static void cleanup(void)
+{
+	if (buf)
+		free(buf);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = test_mallinfo,
+	.cleanup = cleanup,
+};
+
+#else
+TST_TEST_TCONF("system doesn't implement non-POSIX mallinfo()");
+#endif
-- 
2.23.0



