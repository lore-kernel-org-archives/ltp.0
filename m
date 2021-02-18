From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 18 Feb 2021 13:52:49 +0800
Subject: [LTP] [PATCH v3 1/4] syscalls/mallinfo01: Add a basic test for
 mallinfo
In-Reply-To: <YCFZB1/VMSsfxyPA@yuki.lan>
References: <YCFZB1/VMSsfxyPA@yuki.lan>
Message-ID: <1613627572-5213-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
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
 .../kernel/syscalls/mallinfo/mallinfo01.c     | 80 +++++++++++++++++++
 .../syscalls/mallinfo/mallinfo_common.h       | 31 +++++++
 6 files changed, 123 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mallinfo/.gitignore
 create mode 100644 testcases/kernel/syscalls/mallinfo/Makefile
 create mode 100644 testcases/kernel/syscalls/mallinfo/mallinfo01.c
 create mode 100644 testcases/kernel/syscalls/mallinfo/mallinfo_common.h

diff --git a/configure.ac b/configure.ac
index d4bef5e45..2e1552cf0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -97,6 +97,7 @@ AC_CHECK_FUNCS_ONCE([ \
     io_uring_register \
     io_uring_enter \
     kcmp \
+    mallinfo \
     mallopt \
     mkdirat \
     mknodat \
diff --git a/runtest/syscalls b/runtest/syscalls
index ae47a6d5e..b3f4660f4 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -685,6 +685,8 @@ lstat01_64 lstat01_64
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
index 000000000..ba5366896
--- /dev/null
+++ b/testcases/kernel/syscalls/mallinfo/mallinfo01.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ */
+
+/*\
+ * [DESCRIPTION]
+ *
+ * Basic mallinfo() test. Refer to glibc test mallinfo2 test
+ * https://sourceware.org/git/?p=glibc.git;a=blob;f=malloc/tst-mallinfo2.c
+\*/
+#include "mallinfo_common.h"
+#include "tst_safe_macros.h"
+
+#ifdef HAVE_MALLINFO
+#define M_NUM 20
+static struct mallinfo info1;
+static void *buf[M_NUM + 1];
+
+static void cleanup(void)
+{
+	int i;
+
+	for (i = M_NUM; i > 0; i--) {
+		if (buf[i]) {
+			free(buf[i]);
+			buf[i] = NULL;
+		}
+	}
+}
+
+void test_mallinfo(void)
+{
+	int i;
+	int total = 0;
+	struct mallinfo info2;
+
+	for (i = 1; i <= M_NUM; i++) {
+		buf[i] = SAFE_MALLOC(160 * i);
+		total += 160 * i;
+	}
+	info2 = mallinfo();
+	print_mallinfo("Test uordblks", &info2);
+	if (info2.uordblks >= info1.uordblks + total)
+		tst_res(TPASS, "mallinfo() uordblks passed");
+	else
+		tst_res(TFAIL, "mallinfo() uordblks failed");
+
+	//Create another free chunk
+	free(buf[M_NUM/2]);
+	buf[M_NUM/2] = NULL;
+	info2 = mallinfo();
+	print_mallinfo("Test ordblks", &info2);
+	if (info2.ordblks == info1.ordblks + 1)
+		tst_res(TPASS, "mallinfo() ordblks passed");
+	else
+		tst_res(TFAIL, "mallinfo() ordblks failed");
+
+	cleanup();
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
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = test_mallinfo,
+	.cleanup = cleanup,
+};
+
+#else
+TST_TEST_TCONF("system doesn't implement non-POSIX mallinfo()");
+#endif
diff --git a/testcases/kernel/syscalls/mallinfo/mallinfo_common.h b/testcases/kernel/syscalls/mallinfo/mallinfo_common.h
new file mode 100644
index 000000000..a00cc7a64
--- /dev/null
+++ b/testcases/kernel/syscalls/mallinfo/mallinfo_common.h
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ */
+#ifndef MALLINFO_COMMON_H
+#define MALLINFO_COMMON_H
+
+#include <malloc.h>
+#include "tst_test.h"
+#include "config.h"
+
+#ifdef HAVE_MALLINFO
+static inline void print_mallinfo(const char *msg, struct mallinfo *m)
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
+#endif
+
+#endif
-- 
2.23.0



