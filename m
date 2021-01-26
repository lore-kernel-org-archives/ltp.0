From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 26 Jan 2021 17:55:25 +0800
Subject: [LTP] [PATCH v1 3/3] syscalls/mallinfo03: Add an overflow test when
 setting 2G size
In-Reply-To: <1611654925-8994-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1611654925-8994-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1611654925-8994-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
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
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/mallinfo/.gitignore |  1 +
 .../kernel/syscalls/mallinfo/mallinfo03.c     | 62 +++++++++++++++++++
 3 files changed, 64 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mallinfo/mallinfo03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 74ad999e8..8fe123f8c 100644
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
index 000000000..e8dc35e42
--- /dev/null
+++ b/testcases/kernel/syscalls/mallinfo/mallinfo03.c
@@ -0,0 +1,62 @@
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
+#include <malloc.h>
+
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+
+#ifdef HAVE_MALLINFO
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
+void test_mallinfo(void)
+{
+	struct mallinfo info;
+	char *buf;
+	size_t size = 2UL * 1024UL * 1024UL * 1024UL;
+
+	buf = SAFE_MALLOC(size);
+	info = mallinfo();
+	if (info.hblkhd < 0) {
+		print_mallinfo("Test malloc 2G", &info);
+		tst_res(TFAIL, "The member of struct mallinfo overflow, we should use mallinfo2");
+	} else {
+		/*We will never get here*/
+		tst_res(TPASS, "The member of struct mallinfo doesn't overflow");
+	}
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



