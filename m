From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 13 Nov 2020 10:07:53 +0800
Subject: [LTP] [PATCH v3] syscalls/ptrace11: Add test for tracing init
 process
In-Reply-To: <20201112120505.GA15765@yuki.lan>
References: <20201112120505.GA15765@yuki.lan>
Message-ID: <1605233273-3784-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
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
 testcases/kernel/syscalls/ptrace/ptrace11.c | 40 +++++++++++++++++++++
 3 files changed, 42 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ptrace/ptrace11.c

diff --git a/runtest/syscalls b/runtest/syscalls
index aeacb8bc8..6b5908662 100644
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
index 000000000..28a08f69d
--- /dev/null
+++ b/testcases/kernel/syscalls/ptrace/ptrace11.c
@@ -0,0 +1,40 @@
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
+	 * Running attach/detach more times will trigger a ESRCH error because
+	 * ptrace_check_attach function in kernel will report it if its process
+	 * stats is not __TASK_TRACED.
+	 */
+	TST_RETRY_FUNC(ptrace(PTRACE_DETACH, 1, NULL, NULL), TST_RETVAL_EQ0);
+}
+
+static struct tst_test test = {
+	.test_all = verify_ptrace,
+	.needs_root = 1,
+};
-- 
2.23.0



