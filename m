From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 18 Feb 2021 13:52:51 +0800
Subject: [LTP] [PATCH v3 3/4] syscalls/mallinfo02: Add a basic test to check
 use mmap or sbrk
In-Reply-To: <1613627572-5213-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <YCFZB1/VMSsfxyPA@yuki.lan>
 <1613627572-5213-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1613627572-5213-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
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
 .../kernel/syscalls/mallinfo/mallinfo02.c     | 63 +++++++++++++++++++
 3 files changed, 65 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mallinfo/mallinfo02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index b3f4660f4..312544659 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -686,6 +686,7 @@ lstat02 lstat02
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
index 000000000..945d3227c
--- /dev/null
+++ b/testcases/kernel/syscalls/mallinfo/mallinfo02.c
@@ -0,0 +1,63 @@
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
+ * It size > MMAP_THRESHOLD, it will use mmap. Otherwise, use sbrk.
+\*/
+
+#include "mallinfo_common.h"
+#include "tst_safe_macros.h"
+
+#ifdef HAVE_MALLINFO
+void test_mallinfo(void)
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
+	size = MAX(info.fordblks, 131072);
+
+	buf = SAFE_MALLOC(size);
+	info = mallinfo();
+	if (info.hblkhd > size && info.hblks > 0) {
+		tst_res(TPASS, "malloc() uses mmap when size >= 128k");
+	} else {
+		tst_res(TFAIL, "malloc uses sbrk when size >= 128k");
+		print_mallinfo("Test malloc(1024*128)", &info);
+	}
+
+	free(buf);
+}
+
+static void setup(void)
+{
+	if (mallopt(M_MMAP_THRESHOLD, 131072) == 0)
+		tst_res(TFAIL, "mallopt(M_MMAP_THRESHOLD, 128K) failed");
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = test_mallinfo,
+};
+
+#else
+TST_TEST_TCONF("system doesn't implement non-POSIX mallinfo()");
+#endif
-- 
2.23.0



