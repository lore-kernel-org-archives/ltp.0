From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 6 Jul 2016 19:10:50 +0800
Subject: [LTP] [PATCH 3/3] syscalls/kcmp03.c: Add new testcase
In-Reply-To: <1467803450-11622-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1467803450-11622-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1467803450-11622-3-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) kcmp() returns 0 if the processes share the same file system
   information.
2) kcmp() returns 0 if the processes share I/O context.
3) kcmp() returns 0 if the processes share the same list of
   System V semaphore undo operations.
4) kcmp() returns 0 if the processes share the same address space.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/syscalls                        |   1 +
 testcases/kernel/syscalls/.gitignore    |   1 +
 testcases/kernel/syscalls/kcmp/kcmp03.c | 107 ++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+)
 create mode 100644 testcases/kernel/syscalls/kcmp/kcmp03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index ed63358..a76df9a 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -484,6 +484,7 @@ keyctl01 keyctl01
 
 kcmp01 kcmp01
 kcmp02 kcmp02
+kcmp03 kcmp03
 
 kill01 kill01
 kill02 kill02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 0512f8a..0c16830 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -452,6 +452,7 @@
 /keyctl/keyctl01
 /kcmp/kcmp01
 /kcmp/kcmp02
+/kcmp/kcmp03
 /kill/kill01
 /kill/kill02
 /kill/kill03
diff --git a/testcases/kernel/syscalls/kcmp/kcmp03.c b/testcases/kernel/syscalls/kcmp/kcmp03.c
new file mode 100644
index 0000000..e144609
--- /dev/null
+++ b/testcases/kernel/syscalls/kcmp/kcmp03.c
@@ -0,0 +1,107 @@
+/*
+ * Copyright (c) 2016 Xiao Yang <yangx.jy@cn.fujitsu.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.
+ */
+
+ /*
+ * Testname: kcmp03.c
+ *
+ * Description:
+ * 1) kcmp() returns 0 if the processes share the same file system information.
+ * 2) kcmp() returns 0 if the processes share I/O context.
+ * 3) kcmp() returns 0 if the processes share the same list of System V
+ *    semaphore undo operations.
+ * 4) kcmp() returns 0 if the processes share the same address space.
+ */
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <stdlib.h>
+#include <sched.h>
+#include <sys/wait.h>
+#include "tst_test.h"
+#include "kcmp.h"
+
+#ifndef CLONE_SYSVSEM
+#define CLONE_SYSVSEM	0x00040000
+#endif
+
+#ifndef CLONE_IO
+#define CLONE_IO	0x80000000
+#endif
+
+#define STACK_SIZE	(1024*1024)
+
+static int pid1;
+static int pid2;
+
+static struct tcase {
+	int clone_type;
+	int kcmp_type;
+} tcases[] = {
+	{CLONE_VM, KCMP_VM},
+	{CLONE_FS, KCMP_FS},
+	{CLONE_IO, KCMP_IO},
+	{CLONE_SYSVSEM, KCMP_SYSVSEM}
+};
+
+static int do_child(void *arg)
+{
+	pid2 = getpid();
+
+	TEST(kcmp(pid1, pid2, *(int *)arg, 0, 0));
+	if (TEST_RETURN == -1) {
+		tst_res(TFAIL | TTERRNO, "kcmp() failed unexpectedly");
+		return 1;
+	}
+
+	if (TEST_RETURN == 0) {
+		tst_res(TPASS, "kcmp() returned the expected value");
+	} else {
+		tst_res(TFAIL, "kcmp() returned the unexpected value");
+		return 1;
+	}
+
+	return 0;
+}
+
+static void verify_kcmp(unsigned int n)
+{
+	int res;
+	void *stack;
+
+	struct tcase *tc = &tcases[n];
+
+	pid1 = getpid();
+
+	stack = SAFE_MALLOC(STACK_SIZE);
+
+	res = ltp_clone(tc->clone_type | SIGCHLD, do_child, &tc->kcmp_type,
+			STACK_SIZE, stack);
+	if (res == -1)
+		tst_res(TFAIL | TERRNO, "clone() Failed");
+
+	SAFE_WAIT(NULL);
+
+	free(stack);
+}
+
+static struct tst_test test = {
+	.tid = "kcmp03",
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_kcmp,
+	.min_kver = "3.5.0"
+};
-- 
1.8.3.1



