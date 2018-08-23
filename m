From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 23 Aug 2018 15:10:17 +0800
Subject: [LTP] [PATCH] syscalls/mlock203: Add new regression testcase
Message-ID: <1535008217-27041-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This issue has been fixed in kernel:
'b155b4fde5bd("mm: mlock: avoid increase mm->locked_vm on mlock() when already mlock2(,MLOCK_ONFAULT)")'

Note:
This patch is based on the following patch set:
http://lists.linux.it/pipermail/ltp/2018-August/009086.html
http://lists.linux.it/pipermail/ltp/2018-August/009085.html
http://lists.linux.it/pipermail/ltp/2018-August/009084.html
http://lists.linux.it/pipermail/ltp/2018-August/009087.html

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/ltplite                             |  1 +
 runtest/stress.part3                        |  1 +
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/mlock2/.gitignore |  1 +
 testcases/kernel/syscalls/mlock2/mlock203.c | 92 +++++++++++++++++++++++++++++
 5 files changed, 96 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mlock2/mlock203.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 7ebe632..025a2b9 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -445,6 +445,7 @@ mlock02 mlock02
 
 mlock201 mlock201
 mlock202 mlock202
+mlock203 mlock203
 
 qmm01 mmap001 -m 1
 mmap01 mmap01
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 0804172..bb732a1 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -371,6 +371,7 @@ mlock02 mlock02
 
 mlock201 mlock201
 mlock202 mlock202
+mlock203 mlock203
 
 qmm01 mmap001 -m 1
 mmap01 mmap01
diff --git a/runtest/syscalls b/runtest/syscalls
index 2615254..959cb25 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -635,6 +635,7 @@ mlock04 mlock04
 
 mlock201 mlock201
 mlock202 mlock202
+mlock203 mlock203
 
 qmm01 mmap001 -m 1
 mmap01 mmap01
diff --git a/testcases/kernel/syscalls/mlock2/.gitignore b/testcases/kernel/syscalls/mlock2/.gitignore
index 8daf0f9..907b139 100644
--- a/testcases/kernel/syscalls/mlock2/.gitignore
+++ b/testcases/kernel/syscalls/mlock2/.gitignore
@@ -1,2 +1,3 @@
 /mlock201
 /mlock202
+/mlock203
diff --git a/testcases/kernel/syscalls/mlock2/mlock203.c b/testcases/kernel/syscalls/mlock2/mlock203.c
new file mode 100644
index 0000000..8451b2c
--- /dev/null
+++ b/testcases/kernel/syscalls/mlock2/mlock203.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
+ * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ */
+/*
+ * Description:
+ * If one memory is already locked by mlock2() with MLOCK_ONFAULT and then
+ * it is locked again by mlock()(or mlock2() without MLOCK_ONFAULT), the
+ * VmLck field in /proc/pid/status should increase once instead of twice.
+ *
+ * This issue has been fixed in kernel:
+ * 'b155b4fde5bd("mm: mlock: avoid increase mm->locked_vm on mlock() when already mlock2(,MLOCK_ONFAULT)")'
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
+static unsigned long pgsz;
+static char *addr;
+
+static void verify_mlock2(void)
+{
+	unsigned long bsize, asize1, asize2;
+
+	SAFE_FILE_LINES_SCANF("/proc/self/status", "VmLck: %lu", &bsize);
+
+	TEST(tst_syscall(__NR_mlock2, addr, pgsz, MLOCK_ONFAULT));
+	if (TST_RET != 0) {
+		if (TST_ERR == EINVAL) {
+			tst_res(TCONF,
+				"mlock2() didn't support MLOCK_ONFAULT");
+		} else {
+			tst_res(TFAIL | TTERRNO,
+				"mlock2(MLOCK_ONFAULT) failed");
+		}
+		return;
+	}
+
+	SAFE_FILE_LINES_SCANF("/proc/self/status", "VmLck: %lu", &asize1);
+
+	if ((asize1 - bsize) * 1024 != pgsz) {
+		tst_res(TFAIL,
+			"mlock2(MLOCK_ONFAULT) locked %lu size, expected %lu",
+			(asize1 - bsize) * 1024, pgsz);
+		goto end;
+	}
+
+	TEST(tst_syscall(__NR_mlock2, addr, pgsz, 0));
+	if (TST_RET != 0) {
+		tst_res(TFAIL | TTERRNO, "mlock2() failed");
+		goto end;
+	}
+
+	SAFE_FILE_LINES_SCANF("/proc/self/status", "VmLck: %lu", &asize2);
+
+	if (asize1 != asize2) {
+		tst_res(TFAIL, "Locking one memory again increased VmLck");
+	} else {
+		tst_res(TPASS,
+			"Locking one memory again didn't increased VmLck");
+	}
+
+end:
+	SAFE_MUNLOCK(addr, pgsz);
+}
+
+static void setup(void)
+{
+	pgsz = getpagesize();
+	addr = SAFE_MMAP(NULL, pgsz, PROT_WRITE,
+			 MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+}
+
+static void cleanup(void)
+{
+	if (addr)
+		SAFE_MUNMAP(addr, pgsz);
+}
+
+static struct tst_test test = {
+	.test_all = verify_mlock2,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.min_kver = "2.6.9",
+};
-- 
1.8.3.1



