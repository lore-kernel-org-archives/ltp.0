From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 18 Feb 2021 13:52:52 +0800
Subject: [LTP] [PATCH v3 4/4] syscalls/mallinfo03: Add an overflow test when
 setting 2G size
In-Reply-To: <1613627572-5213-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <YCFZB1/VMSsfxyPA@yuki.lan>
 <1613627572-5213-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1613627572-5213-4-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since these members of mallinfo struct use int type, it will overflow
when allocating 2G size. mallinfo() is deprecated and we should use mallinfo2()
in the future.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/mallinfo/.gitignore |  1 +
 .../kernel/syscalls/mallinfo/mallinfo03.c     | 50 +++++++++++++++++++
 3 files changed, 52 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mallinfo/mallinfo03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 312544659..7d6d42072 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -687,6 +687,7 @@ lstat02_64 lstat02_64
 
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
index 000000000..d3c6dd52d
--- /dev/null
+++ b/testcases/kernel/syscalls/mallinfo/mallinfo03.c
@@ -0,0 +1,50 @@
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
+#include "mallinfo_common.h"
+#include "tst_safe_macros.h"
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
+		print_mallinfo("Test malloc 2G", &info);
+		tst_res(TPASS, "The member of struct mallinfo overflow, we should use mallinfo2");
+	} else {
+		/*We will never get here*/
+		tst_res(TFAIL, "The member of struct mallinfo doesn't overflow");
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



