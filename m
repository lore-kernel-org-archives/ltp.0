From: Shwetha Subramanian <shwetha@zilogic.com>
Date: Mon, 06 Jul 2020 05:08:28 -0000
Subject: [LTP] [PATCH v2] Add mincore() test for anonymous mappings
Message-ID: <20200706050828.5134-1-shwetha@zilogic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Changes from v1:
	1.Changed testcase description.
	2.Checked ptr before executing SAFE_MUNMAP() in cleanup().
	3.Added a setup() fuction.
	4.Fixed formatting issues.
	5.Changed TPASS and TFAIL messages.
	6.Changed syntax for conditional statements. 

References: #461

Signed-off-by: Shwetha Subramanian. <shwetha@zilogic.com>
Reviewed-by: Vijay Kumar B. <vijaykumar@zilogic.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/mincore/.gitignore  |  1 +
 testcases/kernel/syscalls/mincore/mincore03.c | 83 +++++++++++++++++++
 3 files changed, 85 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mincore/mincore03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index b4d523319..e0fe9f87e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -879,6 +879,7 @@ open_tree02 open_tree02
 
 mincore01 mincore01
 mincore02 mincore02
+mincore03 mincore03
 
 madvise01 madvise01
 madvise02 madvise02
diff --git a/testcases/kernel/syscalls/mincore/.gitignore b/testcases/kernel/syscalls/mincore/.gitignore
index fdb2070e9..fcbe27eac 100644
--- a/testcases/kernel/syscalls/mincore/.gitignore
+++ b/testcases/kernel/syscalls/mincore/.gitignore
@@ -1,2 +1,3 @@
 /mincore01
 /mincore02
+/mincore03
\ No newline at end of file
diff --git a/testcases/kernel/syscalls/mincore/mincore03.c b/testcases/kernel/syscalls/mincore/mincore03.c
new file mode 100644
index 000000000..774fce98b
--- /dev/null
+++ b/testcases/kernel/syscalls/mincore/mincore03.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Zilogic Systems Pvt. Ltd., 2020
+ * Email: code@zilogic.com
+ */
+
+/*
+ * mincore03
+ * Testcase 1: Test shows that pages mapped as anonymous and
+ * not faulted, are reported as not resident in memory by mincore().
+ * Testcase 2: Test shows that pages mapped as anonymous and faulted,
+ * are reported as resident in memory by mincore().
+ */
+
+#include <stdbool.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include "tst_test.h"
+
+#define NUM_PAGES 3
+
+static struct tcase {
+	bool mlock;
+	int expected_pages;
+	char *desc;
+} tcases[] = {
+	{ false, 0, "untouched pages are not resident"},
+	{ true, NUM_PAGES, "locked pages are resident"},
+};
+
+static int size, page_size;
+static void *ptr;
+
+static void cleanup(void)
+{
+	if (ptr)
+		SAFE_MUNMAP(ptr, size);
+}
+
+static void setup(void)
+{
+	page_size = getpagesize();
+	size = page_size * NUM_PAGES;
+}
+
+static void test_mincore(unsigned int test_nr)
+{
+	const struct tcase *tc = &tcases[test_nr];
+	unsigned char vec[NUM_PAGES];
+	int locked_pages;
+	int count, mincore_ret;
+
+	ptr = SAFE_MMAP(NULL, size,  PROT_WRITE | PROT_READ, MAP_PRIVATE |  MAP_ANONYMOUS, 0, 0);
+	if (tc->mlock)
+		SAFE_MLOCK(ptr, size);
+
+	mincore_ret = mincore(ptr, size, vec);
+	if (mincore_ret == -1)
+		tst_brk(TBROK | TERRNO, "mincore failed");
+	locked_pages = 0;
+	for (count = 0; count < NUM_PAGES; count++)
+		if (vec[count] & 1)
+			locked_pages++;
+
+	if (locked_pages == tc->expected_pages)
+		tst_res(TPASS, "mincore() reports %s", tc->desc);
+	else
+		tst_res(TFAIL, "mincore reports resident pages as %d, but expected %d",
+			locked_pages, tc->expected_pages);
+
+	if (tc->mlock)
+		SAFE_MUNLOCK(ptr, size);
+	SAFE_MUNMAP(ptr, size);
+	ptr = NULL;
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = test_mincore,
+};
+
-- 
2.20.1

