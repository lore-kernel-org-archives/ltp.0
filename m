From: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Thu, 3 Jun 2021 17:44:04 +0800
Subject: [LTP] [PATCH v2] syscalls/mallinfo2_01: Add a basic test for
 mallinfo2 when setting 2G size
In-Reply-To: <YKzX7FPWGGROn6kR@pevik>
References: <YKzX7FPWGGROn6kR@pevik>
Message-ID: <1622713444-21197-1-git-send-email-xuyang2018.jy@fujitsu.com>
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
 .../syscalls/mallinfo/mallinfo_common.h       | 19 ++++++++
 .../kernel/syscalls/mallinfo2/.gitignore      |  1 +
 testcases/kernel/syscalls/mallinfo2/Makefile  | 11 +++++
 .../kernel/syscalls/mallinfo2/mallinfo2_01.c  | 46 +++++++++++++++++++
 6 files changed, 80 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mallinfo2/.gitignore
 create mode 100644 testcases/kernel/syscalls/mallinfo2/Makefile
 create mode 100644 testcases/kernel/syscalls/mallinfo2/mallinfo2_01.c

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
index 9df181b76..11bb58a83 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -692,6 +692,8 @@ lstat02_64 lstat02_64
 
 mallinfo02 mallinfo02
 
+mallinfo2_01 mallinfo2_01
+
 mallopt01 mallopt01
 
 mbind01 mbind01
diff --git a/testcases/kernel/syscalls/mallinfo/mallinfo_common.h b/testcases/kernel/syscalls/mallinfo/mallinfo_common.h
index a00cc7a64..d64a9344b 100644
--- a/testcases/kernel/syscalls/mallinfo/mallinfo_common.h
+++ b/testcases/kernel/syscalls/mallinfo/mallinfo_common.h
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (C) 2020 Free Software Foundation, Inc.
  * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
  * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
  */
@@ -28,4 +29,22 @@ static inline void print_mallinfo(const char *msg, struct mallinfo *m)
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
index 000000000..349222c14
--- /dev/null
+++ b/testcases/kernel/syscalls/mallinfo2/.gitignore
@@ -0,0 +1 @@
+/mallinfo2_01
diff --git a/testcases/kernel/syscalls/mallinfo2/Makefile b/testcases/kernel/syscalls/mallinfo2/Makefile
new file mode 100644
index 000000000..b3c7d9552
--- /dev/null
+++ b/testcases/kernel/syscalls/mallinfo2/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
+# Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+CFLAGS += -I../mallinfo
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/mallinfo2/mallinfo2_01.c b/testcases/kernel/syscalls/mallinfo2/mallinfo2_01.c
new file mode 100644
index 000000000..9811f95c0
--- /dev/null
+++ b/testcases/kernel/syscalls/mallinfo2/mallinfo2_01.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*\
+ * [DESCRIPTION]
+ *
+ * Basic mallinfo2() test.
+ *
+ * Test members of struct mallinfo2() whether overflow when setting 2G size.
+ */
+
+#include "mallinfo_common.h"
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

