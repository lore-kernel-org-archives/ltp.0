From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 21 Aug 2018 17:38:58 +0800
Subject: [LTP] [PATCH 3/4] syscalls/mlock201: Add new testcase
In-Reply-To: <1534844339-8655-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1534844339-8655-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1534844339-8655-3-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Check the basic functionality of mlock2(2) since kernel v2.6.9.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 include/lapi/mlock2.h                       |  16 +++++
 runtest/ltplite                             |   2 +
 runtest/stress.part3                        |   2 +
 runtest/syscalls                            |   2 +
 testcases/kernel/syscalls/mlock2/.gitignore |   1 +
 testcases/kernel/syscalls/mlock2/Makefile   |   8 +++
 testcases/kernel/syscalls/mlock2/mlock201.c | 103 ++++++++++++++++++++++++++++
 7 files changed, 134 insertions(+)
 create mode 100644 include/lapi/mlock2.h
 create mode 100644 testcases/kernel/syscalls/mlock2/.gitignore
 create mode 100644 testcases/kernel/syscalls/mlock2/Makefile
 create mode 100644 testcases/kernel/syscalls/mlock2/mlock201.c

diff --git a/include/lapi/mlock2.h b/include/lapi/mlock2.h
new file mode 100644
index 0000000..fa2b2de
--- /dev/null
+++ b/include/lapi/mlock2.h
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
+ * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ */
+
+#ifndef LAPI_MLOCK2_H__
+# define LAPI_MLOCK2_H__
+
+#include <linux/mman.h>
+
+#ifndef MLOCK_ONFAULT
+# define MLOCK_ONFAULT	0x01
+#endif
+
+#endif /* LAPI_MLOCK2_H__ */
diff --git a/runtest/ltplite b/runtest/ltplite
index 9ca6c42..270c649 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -443,6 +443,8 @@ mknod09 mknod09
 mlock01 mlock01
 mlock02 mlock02
 
+mlock201 mlock201
+
 qmm01 mmap001 -m 1
 mmap01 mmap01
 mmap02 mmap02
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index ec18dcf..6850572 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -369,6 +369,8 @@ mknod09 mknod09
 mlock01 mlock01
 mlock02 mlock02
 
+mlock201 mlock201
+
 qmm01 mmap001 -m 1
 mmap01 mmap01
 mmap02 mmap02
diff --git a/runtest/syscalls b/runtest/syscalls
index 3161d91..5d84d48 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -633,6 +633,8 @@ mlock02 mlock02
 mlock03 mlock03 -i 20
 mlock04 mlock04
 
+mlock201 mlock201
+
 qmm01 mmap001 -m 1
 mmap01 mmap01
 mmap02 mmap02
diff --git a/testcases/kernel/syscalls/mlock2/.gitignore b/testcases/kernel/syscalls/mlock2/.gitignore
new file mode 100644
index 0000000..431eff8
--- /dev/null
+++ b/testcases/kernel/syscalls/mlock2/.gitignore
@@ -0,0 +1 @@
+/mlock201
diff --git a/testcases/kernel/syscalls/mlock2/Makefile b/testcases/kernel/syscalls/mlock2/Makefile
new file mode 100644
index 0000000..427df06
--- /dev/null
+++ b/testcases/kernel/syscalls/mlock2/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
+# Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/mlock2/mlock201.c b/testcases/kernel/syscalls/mlock2/mlock201.c
new file mode 100644
index 0000000..e0517e1
--- /dev/null
+++ b/testcases/kernel/syscalls/mlock2/mlock201.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
+ * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ */
+/*
+ * Description:
+ * Check the basic functionality of the mlock2(2) since kernel v2.6.9:
+ * 1) Use mlock2(2) without MLOCK_ONFAULT to lock memory in the specified
+ *    range that is multiples of page size or not, and the VmLck from
+ *    /proc/PID/status shows correct size of memory that is locked by PID.
+ * 2) Use mlock2(2) with MLOCK_ONFAULT to lock memory in the specified
+ *    range that is multiples of page size or not, and the VmLck from
+ *    /proc/PID/status show correct size of memory that is locked by PID.
+ */
+#include <errno.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <linux/mman.h>
+
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+#include "lapi/mlock2.h"
+
+#define PAGES	8
+
+static unsigned long pgsz;
+static char *addr;
+
+static struct tcase {
+	unsigned long mlock_pgs;
+	long len_off;
+	unsigned long exp_pgs;
+	int flag;
+} tcases[] = {
+	{1, 0, 1, 0},
+	{PAGES, 0, PAGES, 0},
+	/* mlock2() locks 3 pages if the specified
+	 * range is little more than 2 pages.
+	 */
+	{2, 1, 3, 0},
+	/* mlock2() locks 2 pages if the specified
+	 * range is little less than 2 pages.
+	 */
+	{2, -1, 2, 0},
+	{1, 0, 1, MLOCK_ONFAULT},
+	{PAGES, 0, PAGES, MLOCK_ONFAULT},
+	{2, 1, 3, MLOCK_ONFAULT},
+	{2, -1, 2, MLOCK_ONFAULT},
+};
+
+static void verify_mlock2(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	unsigned long bsize, asize, act_pgs;
+
+	SAFE_FILE_LINES_SCANF("/proc/self/status", "VmLck: %lu", &bsize);
+
+	TEST(tst_syscall(__NR_mlock2, addr, tc->mlock_pgs * pgsz + tc->len_off,
+			 tc->flag));
+	if (TST_RET != 0) {
+		if (tc->flag && TST_ERR == EINVAL)
+			tst_res(TCONF, "mlock2() didn't support MLOCK_ONFAULT");
+		else
+			tst_res(TFAIL | TTERRNO, "mlock2() failed");
+		return;
+	}
+
+	SAFE_FILE_LINES_SCANF("/proc/self/status", "VmLck: %lu", &asize);
+
+	act_pgs = (asize - bsize) * 1024 / pgsz;
+	if (tc->exp_pgs != act_pgs) {
+		tst_res(TFAIL, "mlock2() locked %lu pages, expected %lu",
+			tc->exp_pgs, act_pgs);
+	} else {
+		tst_res(TPASS, "mlock2() succeeded in locking %lu pages",
+			tc->exp_pgs);
+	}
+
+	SAFE_MUNLOCK(addr, tc->mlock_pgs * pgsz + tc->len_off);
+}
+
+static void setup(void)
+{
+	pgsz = getpagesize();
+	addr = SAFE_MMAP(NULL, PAGES * pgsz, PROT_WRITE,
+			 MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+}
+
+static void cleanup(void)
+{
+	if (addr)
+		SAFE_MUNMAP(addr, PAGES * pgsz);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_mlock2,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.min_kver = "2.6.9",
+};
-- 
1.8.3.1



