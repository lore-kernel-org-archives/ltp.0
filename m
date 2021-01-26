From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 26 Jan 2021 17:55:24 +0800
Subject: [LTP] [PATCH v1 2/3] syscalls/mallinfo02: Add a basic test to check
 use mmap or sbrk
In-Reply-To: <1611654925-8994-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1611654925-8994-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1611654925-8994-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

According mallinfo man-page, hblkhd member represents
"The number of bytes in blocks currently allocated using mmap(2).".
For allocations greater than or equal to 128K and that can't be satisfied from
the free list, the memory-allocation functions employ mmap(2) instead of increasing
the program break using sbrk(2).

In this case, we test 20k size to use sbrk and 128k size to use mmap.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/mallinfo/.gitignore |  1 +
 .../kernel/syscalls/mallinfo/mallinfo02.c     | 76 +++++++++++++++++++
 3 files changed, 78 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mallinfo/mallinfo02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index d0a9a5145..74ad999e8 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -683,6 +683,7 @@ lstat02 lstat02
 lstat02_64 lstat02_64
 
 mallinfo01 mallinfo01
+mallinfo02 mallinfo02
 
 mallopt01 mallopt01
 
diff --git a/testcases/kernel/syscalls/mallinfo/.gitignore b/testcases/kernel/syscalls/mallinfo/.gitignore
index a7e32a637..678ac277e 100644
--- a/testcases/kernel/syscalls/mallinfo/.gitignore
+++ b/testcases/kernel/syscalls/mallinfo/.gitignore
@@ -1 +1,2 @@
 /mallinfo01
+/mallinfo02
diff --git a/testcases/kernel/syscalls/mallinfo/mallinfo02.c b/testcases/kernel/syscalls/mallinfo/mallinfo02.c
new file mode 100644
index 000000000..f0c9cb99c
--- /dev/null
+++ b/testcases/kernel/syscalls/mallinfo/mallinfo02.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ */
+
+/*\
+ * [DESCRIPTION]
+ *
+ * Basic mallinfo() test for malloc() using sbrk or mmap.
+ * It size > 128k, it will use mmap and deallocated space is not placed on
+ * the free list for reuse by later allocations.
+\*/
+
+#include <malloc.h>
+
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+
+#ifdef HAVE_MALLINFO
+static int reuse_size;
+static void print_mallinfo(const char *msg, struct mallinfo *m)
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
+void test_mallopt(void)
+{
+	struct mallinfo info;
+	int size;
+	char *buf;
+
+	buf = SAFE_MALLOC(20480);
+
+	info = mallinfo();
+	if (info.uordblks > 20480 && info.hblkhd == 0) {
+		tst_res(TPASS, "malloc() uses sbrk when size < 128k");
+	} else {
+		tst_res(TFAIL, "malloc() use mmap when size < 128k");
+		print_mallinfo("Test malloc(20480)", &info);
+	}
+	free(buf);
+
+	info = mallinfo();
+	size = MAX(info.fordblks, 131072) + reuse_size;
+	buf = SAFE_MALLOC(size);
+	info = mallinfo();
+	if (info.hblkhd > size) {
+		tst_res(TPASS, "malloc() uses mmap when size >= 128k");
+	} else {
+		tst_res(TFAIL, "malloc uses sbrk when size >= 128k");
+		print_mallinfo("Test malloc(1024*128)", &info);
+	}
+
+	reuse_size = info.hblkhd;
+	free(buf);
+}
+
+static struct tst_test test = {
+	.test_all = test_mallopt,
+};
+
+#else
+TST_TEST_TCONF("system doesn't implement non-POSIX mallinfo()");
+#endif
-- 
2.23.0



