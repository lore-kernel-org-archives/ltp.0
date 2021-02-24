From: Liam Howlett <liam.howlett@oracle.com>
Date: Wed, 24 Feb 2021 21:31:24 +0000
Subject: [LTP] [PATCH v2 1/1] brk02: Add test for removing more than one VMA
In-Reply-To: <20210224213114.2976705-1-Liam.Howlett@Oracle.com>
References: <20210224213114.2976705-1-Liam.Howlett@Oracle.com>
Message-ID: <20210224213114.2976705-2-Liam.Howlett@Oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When brk expands, it attempts to expand a VMA.  This expansion will
succeed depending on the anonymous VMA chain and if the vma flags are
compatible.  This test expands brk() then calls mprotect to ensure the
next brk call will create a new VMA, then it calls brk a final time to
restore the first brk address.  The test is the final brk call which
will remove more than an entire VMA from the vm area.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 testcases/kernel/syscalls/brk/brk02.c | 54 +++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 testcases/kernel/syscalls/brk/brk02.c

diff --git a/testcases/kernel/syscalls/brk/brk02.c b/testcases/kernel/syscalls/brk/brk02.c
new file mode 100644
index 000000000..ef84fb440
--- /dev/null
+++ b/testcases/kernel/syscalls/brk/brk02.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 Liam R. Howlett <liam.howlett@oracle.com>
+ *
+ *  Expand the brk by at least 2 pages to ensure there is a newly created VMA
+ *  and not expanding the original due to multiple anon pages.  mprotect that
+ *  new VMA then brk back to the original address therefore causing a munmap of
+ *  at least one full VMA.
+ */
+
+#include <unistd.h>
+#include <sys/mman.h>
+#include "tst_test.h"
+
+void brk_down_vmas(void)
+{
+	void *brk_addr = sbrk(0);
+	unsigned long page_size = getpagesize();
+	void *addr = brk_addr + page_size;
+
+	if (brk(addr)) {
+		tst_res(TFAIL, "Cannot expand brk by page size.");
+		return;
+	}
+
+	addr += page_size;
+	if (brk(addr)) {
+		tst_res(TFAIL, "Cannot expand brk by 2x page size.");
+		return;
+	}
+
+	if (mprotect(addr - page_size, page_size,
+		     PROT_READ|PROT_WRITE|PROT_EXEC)) {
+		tst_res(TFAIL, "Cannot mprotect new VMA.");
+		return;
+	}
+
+	addr += page_size;
+	if (brk(addr)) {
+		tst_res(TFAIL, "Cannot expand brk after mprotect.");
+		return;
+	}
+
+	if (brk(brk_addr)) {
+		tst_res(TFAIL, "Cannot restore brk to start address.");
+		return;
+	}
+
+	tst_res(TPASS, "munmap at least two VMAs of brk() passed.");
+}
+
+static struct tst_test test = {
+	.test_all = brk_down_vmas,
+};
-- 
2.30.0
