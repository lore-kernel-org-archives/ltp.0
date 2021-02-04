From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 4 Feb 2021 20:12:42 +0800
Subject: [LTP] [PATCH v2 5/5] syscalls/mallinfo03: Add an overflow test when
 setting 2G size
In-Reply-To: <1612440762-22389-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <CAEemH2eiTY7YgSYLr6_skK6PaRZb2_GchbmHUJKVuW7btA15rQ@mail.gmail.com>
 <1612440762-22389-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1612440762-22389-5-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since these members of mallinfo struct use int data type, it will overflow
when allocating 2G size. mallinfo() is deprecated and we should use mallinfo2()
in the future.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
v1->v2
1.use tst_print_mallinfo api
2.skip test if we can't malloc 2g space
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/mallinfo/.gitignore |  1 +
 .../kernel/syscalls/mallinfo/mallinfo03.c     | 51 +++++++++++++++++++
 3 files changed, 53 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mallinfo/mallinfo03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index a8fa3f7bf..c5cf78381 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -684,6 +684,7 @@ lstat02_64 lstat02_64
 
 mallinfo01 mallinfo01
 mallinfo02 mallinfo02
+mallinfo03 mallinfo03
 
 mallopt01 mallopt01
 
diff --git a/testcases/kernel/syscalls/mallinfo/.gitignore b/testcases/kernel/syscalls/mallinfo/.gitignore
index 678ac277e..30c315cf2 100644
--- a/testcases/kernel/syscalls/mallinfo/.gitignore
+++ b/testcases/kernel/syscalls/mallinfo/.gitignore
@@ -1,2 +1,3 @@
 /mallinfo01
 /mallinfo02
+/mallinfo03
diff --git a/testcases/kernel/syscalls/mallinfo/mallinfo03.c b/testcases/kernel/syscalls/mallinfo/mallinfo03.c
new file mode 100644
index 000000000..36d9e5d85
--- /dev/null
+++ b/testcases/kernel/syscalls/mallinfo/mallinfo03.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ */
+
+/*\
+ * [DESCRIPTION]
+ *
+ * Basic mallinfo() test. Test the member of struct mallinfo
+ * whether overflow when setting 2G size. mallinfo() is deprecated
+ * since the type used for the fields is too small. We should use
+ * mallinfo2() and it was added since glibc 2.33.
+\*/
+
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "tst_mallinfo.h"
+
+#ifdef HAVE_MALLINFO
+
+void test_mallinfo(void)
+{
+	struct mallinfo info;
+	char *buf;
+	size_t size = 2UL * 1024UL * 1024UL * 1024UL;
+
+	buf = malloc(size);
+	if (!buf) {
+		tst_res(TCONF, "Current system can not malloc 2G space, skip it");
+		return;
+	}
+	info = mallinfo();
+	if (info.hblkhd < 0) {
+		tst_print_mallinfo("Test malloc 2G", &info);
+		tst_res(TFAIL, "The member of struct mallinfo overflow, we should use mallinfo2");
+	} else {
+		/*We will never get here*/
+		tst_res(TPASS, "The member of struct mallinfo doesn't overflow");
+	}
+
+	free(buf);
+}
+
+static struct tst_test test = {
+	.test_all = test_mallinfo,
+};
+
+#else
+TST_TEST_TCONF("system doesn't implement non-POSIX mallinfo()");
+#endif
-- 
2.23.0



