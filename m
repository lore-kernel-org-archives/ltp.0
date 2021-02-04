From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 4 Feb 2021 20:12:40 +0800
Subject: [LTP] [PATCH v2 3/5] syscalls/mallinfo01: Add a basic test for
 mallinfo
In-Reply-To: <1612440762-22389-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <CAEemH2eiTY7YgSYLr6_skK6PaRZb2_GchbmHUJKVuW7btA15rQ@mail.gmail.com>
 <1612440762-22389-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1612440762-22389-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
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
v1->v2
1.use tst_print_mallinfo api
2.use buf array
3.use 160 multiple instead of 16
4.add free chunk check
 runtest/syscalls                              |  2 +
 testcases/kernel/syscalls/mallinfo/.gitignore |  1 +
 testcases/kernel/syscalls/mallinfo/Makefile   |  8 ++
 .../kernel/syscalls/mallinfo/mallinfo01.c     | 82 +++++++++++++++++++
 4 files changed, 93 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mallinfo/.gitignore
 create mode 100644 testcases/kernel/syscalls/mallinfo/Makefile
 create mode 100644 testcases/kernel/syscalls/mallinfo/mallinfo01.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 11a1e83c2..753340068 100644
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
index 000000000..add3c0df3
--- /dev/null
+++ b/testcases/kernel/syscalls/mallinfo/mallinfo01.c
@@ -0,0 +1,82 @@
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
+
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "tst_mallinfo.h"
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
+	tst_print_mallinfo("Test uordblks", &info2);
+	if (info2.uordblks > info1.uordblks + total)
+		tst_res(TPASS, "mallinfo() uordblks passed");
+	else
+		tst_res(TFAIL, "mallinfo() uordblks failed");
+
+	//Create another free chunk
+	free(buf[M_NUM/2]);
+	buf[M_NUM/2] = NULL;
+	info2 = mallinfo();
+	tst_print_mallinfo("Test ordblks", &info2);
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
+	tst_print_mallinfo("Start", &info1);
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



