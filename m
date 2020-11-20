From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 20 Nov 2020 11:16:33 +0800
Subject: [LTP] [PATCH v4] syscalls/ptrace11: Add test for tracing init
 process
In-Reply-To: <20201119153116.GA18048@yuki.lan>
References: <20201119153116.GA18048@yuki.lan>
Message-ID: <1605842193-10828-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Before kernel 2.6.26, ptrace can't trace init process and will get
EPERM error. Now, it should succeed when we have enough privileges.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/ptrace/.gitignore |  1 +
 testcases/kernel/syscalls/ptrace/ptrace11.c | 46 +++++++++++++++++++++
 3 files changed, 48 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ptrace/ptrace11.c

diff --git a/runtest/syscalls b/runtest/syscalls
index a5363277f..be5e1e76c 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1000,6 +1000,7 @@ ptrace07 ptrace07
 ptrace08 ptrace08
 ptrace09 ptrace09
 ptrace10 ptrace10
+ptrace11 ptrace11
 
 pwrite01 pwrite01
 pwrite02 pwrite02
diff --git a/testcases/kernel/syscalls/ptrace/.gitignore b/testcases/kernel/syscalls/ptrace/.gitignore
index 34be5148f..01cbc6072 100644
--- a/testcases/kernel/syscalls/ptrace/.gitignore
+++ b/testcases/kernel/syscalls/ptrace/.gitignore
@@ -7,3 +7,4 @@
 /ptrace08
 /ptrace09
 /ptrace10
+/ptrace11
diff --git a/testcases/kernel/syscalls/ptrace/ptrace11.c b/testcases/kernel/syscalls/ptrace/ptrace11.c
new file mode 100644
index 000000000..daaadcd3a
--- /dev/null
+++ b/testcases/kernel/syscalls/ptrace/ptrace11.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ *
+ * Before kernel 2.6.26, we can't trace init(1) process and ptrace() will
+ * get EPERM error. This case just check whether we can trace init(1)
+ * process and doesn't trigger error.
+ */
+
+#include <errno.h>
+#include <signal.h>
+#include <sys/wait.h>
+#include <pwd.h>
+#include <config.h>
+#include <stdlib.h>
+#include "ptrace.h"
+#include "tst_test.h"
+
+static void verify_ptrace(void)
+{
+	TEST(ptrace(PTRACE_ATTACH, 1, NULL, NULL));
+	if (TST_RET == 0)
+		tst_res(TPASS, "ptrace() traces init process successfully");
+	else
+		tst_res(TFAIL | TTERRNO,
+			"ptrace() returns %ld, failed unexpectedly", TST_RET);
+
+	/*
+	 * As ptrace(2) man-page said, when using PTRACE_ATTACH option, the
+	 * tracee is sent a SIGSTOP, but will not necessarily have stopped
+	 * by the completion of this call. Use waitpid(2) to wait for the
+	 * tracee into stop. Otherwise it may get ESRCH error.
+	 * As waitpid(2) man-pages said, status for traced children which have
+	 * stopped is provided even if WUNTRACED option is not specified.
+	 * So using 0 option is enough.
+	 */
+	SAFE_WAITPID(1, NULL, 0);
+
+	SAFE_PTRACE(PTRACE_DETACH, 1, NULL, NULL);
+}
+
+static struct tst_test test = {
+	.test_all = verify_ptrace,
+	.needs_root = 1,
+};
-- 
2.23.0



