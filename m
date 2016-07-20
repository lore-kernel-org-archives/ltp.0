From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 20 Jul 2016 16:21:14 +0800
Subject: [LTP] [PATCH v2 3/3] syscalls/kcmp03.c: Add new testcase
In-Reply-To: <1469002874-18630-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20160719135349.GE6409@rei.lan>
 <1469002874-18630-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1469002874-18630-3-git-send-email-yangx.jy@cn.fujitsu.com>
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
 include/lapi/sched.h                    |  16 +++++
 runtest/syscalls                        |   1 +
 testcases/kernel/syscalls/.gitignore    |   1 +
 testcases/kernel/syscalls/kcmp/kcmp03.c | 105 ++++++++++++++++++++++++++++++++
 4 files changed, 123 insertions(+)
 create mode 100644 testcases/kernel/syscalls/kcmp/kcmp03.c

diff --git a/include/lapi/sched.h b/include/lapi/sched.h
index 189c2de..a0efbb0 100644
--- a/include/lapi/sched.h
+++ b/include/lapi/sched.h
@@ -56,4 +56,20 @@ int sched_getattr(pid_t pid,
 	return syscall(__NR_sched_getattr, pid, attr, size, flags);
 }
 
+#ifndef CLONE_VM
+#define CLONE_VM   0x00000100
+#endif
+
+#ifndef CLONE_FS
+#define CLONE_FS   0x00000200
+#endif
+
+#ifndef CLONE_SYSVSEM
+#define CLONE_SYSVSEM   0x00040000
+#endif
+
+#ifndef CLONE_IO
+#define CLONE_IO        0x80000000
+#endif
+
 #endif /* __SCHED_H__ */
diff --git a/runtest/syscalls b/runtest/syscalls
index 40b3257..75fdd4a 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -484,6 +484,7 @@ keyctl01 keyctl01
 
 kcmp01 kcmp01
 kcmp02 kcmp02
+kcmp03 kcmp03
 
 kill01 kill01
 kill02 kill02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index fb980ba..217b38e 100644
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
index 0000000..d64ea2c
--- /dev/null
+++ b/testcases/kernel/syscalls/kcmp/kcmp03.c
@@ -0,0 +1,105 @@
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
+#include "lapi/sched.h"
+
+#define STACK_SIZE	(1024*1024)
+
+static int pid1;
+static int pid2;
+static void *stack;
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
+static void setup(void)
+{
+	stack = SAFE_MALLOC(STACK_SIZE);
+}
+
+static void cleanup(void)
+{
+	free(stack);
+}
+
+static int do_child(void *arg)
+{
+	pid2 = getpid();
+
+	TEST(kcmp(pid1, pid2, *(int *)arg, 0, 0));
+	if (TEST_RETURN == -1) {
+		tst_res(TFAIL | TTERRNO, "kcmp() failed unexpectedly");
+		return 0;
+	}
+
+	if (TEST_RETURN == 0)
+		tst_res(TPASS, "kcmp() returned the expected value");
+	else
+		tst_res(TFAIL, "kcmp() returned the unexpected value");
+
+	return 0;
+}
+
+static void verify_kcmp(unsigned int n)
+{
+	int res;
+
+	struct tcase *tc = &tcases[n];
+
+	pid1 = getpid();
+
+	res = ltp_clone(tc->clone_type | SIGCHLD, do_child, &tc->kcmp_type,
+			STACK_SIZE, stack);
+	if (res == -1)
+		tst_res(TFAIL | TERRNO, "clone() Failed");
+}
+
+static struct tst_test test = {
+	.tid = "kcmp03",
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.forks_child = 1,
+	.test = verify_kcmp,
+	.min_kver = "3.5.0"
+};
-- 
1.8.3.1



