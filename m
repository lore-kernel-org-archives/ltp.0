From: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Fri, 7 May 2021 15:30:38 +0800
Subject: [LTP] [PATCH] syscalls/mallinfo201: Add a basic test for mallinfo2
 when setting 2G size
Message-ID: <1620372638-25690-1-git-send-email-xuyang2018.jy@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since these members of mallinfo struct use int data type, it will overflow
when allocating 2G size. mallinfo() is deprecated and we should use mallinfo2()
in the future. So we test mallinfo2 whether works well.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 configure.ac                                  |  1 +
 runtest/syscalls                              |  2 +
 .../syscalls/mallinfo/mallinfo_common.h       | 18 +++++++
 .../kernel/syscalls/mallinfo2/.gitignore      |  1 +
 testcases/kernel/syscalls/mallinfo2/Makefile  |  8 ++++
 .../kernel/syscalls/mallinfo2/mallinfo201.c   | 47 +++++++++++++++++++
 6 files changed, 77 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mallinfo2/.gitignore
 create mode 100644 testcases/kernel/syscalls/mallinfo2/Makefile
 create mode 100644 testcases/kernel/syscalls/mallinfo2/mallinfo201.c

diff --git a/configure.ac b/configure.ac
index 136d82d09..eb675b367 100644
--- a/configure.ac
+++ b/configure.ac
@@ -102,6 +102,7 @@ AC_CHECK_FUNCS_ONCE([ \
     io_uring_enter \
     kcmp \
     mallinfo \
+    mallinfo2 \
     mallopt \
     mkdirat \
     mknodat \
diff --git a/runtest/syscalls b/runtest/syscalls
index aa7fa24dd..ea48efd26 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -693,6 +693,8 @@ lstat02_64 lstat02_64
 mallinfo01 mallinfo01
 mallinfo02 mallinfo02
 
+mallinfo201 mallinfo201
+
 mallopt01 mallopt01
 
 mbind01 mbind01
diff --git a/testcases/kernel/syscalls/mallinfo/mallinfo_common.h b/testcases/kernel/syscalls/mallinfo/mallinfo_common.h
index a00cc7a64..e7737b270 100644
--- a/testcases/kernel/syscalls/mallinfo/mallinfo_common.h
+++ b/testcases/kernel/syscalls/mallinfo/mallinfo_common.h
@@ -28,4 +28,22 @@ static inline void print_mallinfo(const char *msg, struct mallinfo *m)
 }
 #endif
 
+#ifdef HAVE_MALLINFO2
+static inline void print_mallinfo2(const char *msg, struct mallinfo2 *m)
+{
+	tst_res(TINFO, "%s...", msg);
+#define P2(f) tst_res(TINFO, "%s: %ld", #f, m->f)
+	P2(arena);
+	P2(ordblks);
+	P2(smblks);
+	P2(hblks);
+	P2(hblkhd);
+	P2(usmblks);
+	P2(fsmblks);
+	P2(uordblks);
+	P2(fordblks);
+	P2(keepcost);
+}
+#endif
+
 #endif
diff --git a/testcases/kernel/syscalls/mallinfo2/.gitignore b/testcases/kernel/syscalls/mallinfo2/.gitignore
new file mode 100644
index 000000000..848f00130
--- /dev/null
+++ b/testcases/kernel/syscalls/mallinfo2/.gitignore
@@ -0,0 +1 @@
+/mallinfo201
diff --git a/testcases/kernel/syscalls/mallinfo2/Makefile b/testcases/kernel/syscalls/mallinfo2/Makefile
new file mode 100644
index 000000000..044619fb8
--- /dev/null
+++ b/testcases/kernel/syscalls/mallinfo2/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/mallinfo2/mallinfo201.c b/testcases/kernel/syscalls/mallinfo2/mallinfo201.c
new file mode 100644
index 000000000..0bc2520a0
--- /dev/null
+++ b/testcases/kernel/syscalls/mallinfo2/mallinfo201.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*\
+ * [DESCRIPTION]
+ *
+ * Basic mallinfo2() test. Test the member of struct mallinfo2
+ * whether overflow when setting 2G size. mallinfo() is deprecated
+ * since the type used for the fields is too small. We should use
+ * mallinfo2() and it was added since glibc 2.33.
+ */
+
+#include "../mallinfo/mallinfo_common.h"
+#include "tst_safe_macros.h"
+
+#ifdef HAVE_MALLINFO2
+
+void test_mallinfo2(void)
+{
+	struct mallinfo2 info;
+	char *buf;
+	size_t size = 2UL * 1024UL * 1024UL * 1024UL;
+
+	buf = malloc(size);
+	if (!buf) {
+		tst_res(TCONF, "Current system can not malloc 2G space, skip it");
+		return;
+	}
+	info = mallinfo2();
+	if (info.hblkhd < size) {
+		print_mallinfo2("Test malloc 2G", &info);
+		tst_brk(TFAIL, "The member of struct mallinfo2 overflow?");
+	}
+	tst_res(TPASS, "The member of struct mallinfo2 doesn't overflow");
+	free(buf);
+}
+
+static struct tst_test test = {
+	.test_all = test_mallinfo2,
+};
+
+#else
+TST_TEST_TCONF("system doesn't implement non-POSIX mallinfo2()");
+#endif
-- 
2.23.0

