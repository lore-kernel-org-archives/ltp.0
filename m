From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 31 Aug 2018 15:13:21 +0800
Subject: [LTP] [PATCH v2 3/4] syscalls/mlock201: Add new testcase
In-Reply-To: <864746561.43466655.1535545169373.JavaMail.zimbra@redhat.com>
References: <864746561.43466655.1535545169373.JavaMail.zimbra@redhat.com>
Message-ID: <1535699602-28185-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) Add SAFE_MINCORE() macro
2) Check the basic functionality of mlock2(2).

Note:
1) We use tst_syscall() to check if mlock2() is supported.
2) since kernel v2.6.9, the limits and permissions of mlock2()
   changed, so we just check mlock2() since the version.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 include/lapi/mlock2.h                       |  16 ++++
 include/tst_safe_macros.h                   |   5 +
 lib/safe_macros.c                           |  14 +++
 runtest/ltplite                             |   2 +
 runtest/stress.part3                        |   2 +
 runtest/syscalls                            |   2 +
 testcases/kernel/syscalls/mlock2/.gitignore |   1 +
 testcases/kernel/syscalls/mlock2/Makefile   |   8 ++
 testcases/kernel/syscalls/mlock2/mlock201.c | 144 ++++++++++++++++++++++++++++
 9 files changed, 194 insertions(+)
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
diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index dc6c1f7..03657a4 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -490,6 +490,11 @@ int safe_munlock(const char *file, const int lineno, const char *addr,
 	size_t len);
 #define SAFE_MUNLOCK(addr, len) safe_munlock(__FILE__, __LINE__, (addr), (len))
 
+int safe_mincore(const char *file, const int lineno, void *start,
+	size_t length, unsigned char *vec);
+#define SAFE_MINCORE(start, length, vec) \
+	safe_mincore(__FILE__, __LINE__, (start), (length), (vec))
+
 int safe_fanotify_init(const char *file, const int lineno,
 	unsigned int flags, unsigned int event_f_flags);
 #define SAFE_FANOTIFY_INIT(fan, mode)  \
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index fa92a6f..5cc80d0 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -1034,3 +1034,17 @@ int safe_munlock(const char *file, const int lineno, const void *addr,
 
 	return rval;
 }
+
+int safe_mincore(const char *file, const int lineno, void *start,
+	size_t length, unsigned char *vec)
+{
+	int rval;
+
+	rval = mincore(start, length, vec);
+	if (rval == -1) {
+		tst_brkm(TBROK | TERRNO, NULL,
+			 "%s:%d: mincore() failed", file, lineno);
+	}
+
+	return rval;
+}
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
index 0000000..d2090bc
--- /dev/null
+++ b/testcases/kernel/syscalls/mlock2/mlock201.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
+ * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ */
+/*
+ * Description:
+ * Check the basic functionality of the mlock2(2) since kernel v2.6.9:
+ * 1) When we use mlock2() without MLOCK_ONFAULT to lock memory in the
+ *    specified range that is multiples of page size or not, we can
+ *    show correct size of locked memory by VmLck from /proc/PID/status
+ *    and lock all pages including non-present.
+ * 2) When we use mlock2() with MLOCK_ONFAULT to lock memory in the
+ *    specified range that is multiples of page size or not, we can
+ *    show correct size of locked memory by VmLck from /proc/PID/status
+ *    and just lock present pages.
+ */
+#include <errno.h>
+#include <unistd.h>
+#include <string.h>
+#include <stdlib.h>
+#include <sys/mman.h>
+#include <linux/mman.h>
+
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+#include "lapi/mlock2.h"
+
+#define PAGES	8
+#define HPAGES	(PAGES / 2)
+
+static size_t pgsz;
+static unsigned char *vec;
+
+static struct tcase {
+	size_t pop_pgs;
+	size_t lock_pgs;
+	size_t offset;
+	size_t exp_vmlcks;
+	size_t exp_pgs;
+	int flag;
+} tcases[] = {
+	{0, 1, 0, 1, 1, 0},
+	{0, PAGES, 0, PAGES, PAGES, 0},
+	/* mlock2() locks 3 pages if the specified
+	 * range is little more than 2 pages.
+	 */
+	{0, 2, 1, 3, 3, 0},
+	/* mlock2() locks 2 pages if the specified
+	 * range is little less than 2 pages.
+	 */
+	{0, 2, -1, 2, 2, 0},
+	/* mlock2() with MLOCK_ONFAULT just lock present
+	 * pages populated by data.
+	 */
+	{0, 1, 0, 1, 0, MLOCK_ONFAULT},
+	{HPAGES, PAGES, 0, PAGES, HPAGES, MLOCK_ONFAULT},
+	{1, HPAGES, 1, HPAGES + 1, 1, MLOCK_ONFAULT},
+	{HPAGES, HPAGES, -1, HPAGES, HPAGES, MLOCK_ONFAULT},
+};
+
+static size_t check_locked_pages(char *addr, size_t len, size_t num_pgs)
+{
+	size_t n;
+	size_t act_pages = 0;
+
+	SAFE_MINCORE(addr, len, vec);
+
+	for (n = 0; n < num_pgs; n++) {
+		if (vec[n] & 1)
+			act_pages++;
+	}
+
+	return act_pages;
+}
+
+static void verify_mlock2(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	size_t bsize, asize, act_vmlcks, act_pgs;
+	char *addr;
+
+	addr = SAFE_MMAP(NULL, PAGES * pgsz, PROT_WRITE,
+			 MAP_SHARED | MAP_ANONYMOUS, 0, 0);
+
+	if (tc->pop_pgs)
+		memset(addr, 0, tc->pop_pgs * pgsz);
+
+	SAFE_FILE_LINES_SCANF("/proc/self/status", "VmLck: %ld", &bsize);
+
+	TEST(tst_syscall(__NR_mlock2, addr, tc->lock_pgs * pgsz + tc->offset,
+			 tc->flag));
+	if (TST_RET != 0) {
+		if (tc->flag && TST_ERR == EINVAL)
+			tst_res(TCONF, "mlock2() didn't support MLOCK_ONFAULT");
+		else
+			tst_res(TFAIL | TTERRNO, "mlock2() failed");
+		goto end2;
+	}
+
+	SAFE_FILE_LINES_SCANF("/proc/self/status", "VmLck: %ld", &asize);
+
+	act_vmlcks = (asize - bsize) * 1024 / pgsz;
+	if (tc->exp_vmlcks != act_vmlcks) {
+		tst_res(TFAIL, "VmLck showed wrong %ld pages, expected %ld",
+			act_vmlcks, tc->exp_vmlcks);
+		goto end1;
+	}
+
+	act_pgs = check_locked_pages(addr, PAGES * pgsz, PAGES);
+	if (act_pgs != tc->exp_pgs) {
+		tst_res(TFAIL, "mlock2(%d) locked %ld pages, expected %ld",
+			tc->flag, act_pgs, tc->exp_pgs);
+	} else {
+		tst_res(TPASS, "mlock2(%d) succeeded in locking %ld pages",
+			tc->flag, tc->exp_pgs);
+	}
+
+end1:
+	SAFE_MUNLOCK(addr, tc->lock_pgs * pgsz + tc->offset);
+end2:
+	SAFE_MUNMAP(addr, PAGES * pgsz);
+}
+
+static void setup(void)
+{
+	pgsz = getpagesize();
+	vec = SAFE_MALLOC((PAGES * pgsz + pgsz - 1) / pgsz);
+}
+
+static void cleanup(void)
+{
+	if (vec)
+		free(vec);
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



