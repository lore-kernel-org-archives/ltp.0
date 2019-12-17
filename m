From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 17 Dec 2019 18:15:22 +0800
Subject: [LTP] [PATCH v1 4/4] syscalls/capset04: add new EPERM error test
 with vfs cap support
Message-ID: <1576577722-3727-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Now, most linux distributions has VFS capabilities supports, so
modifying other process cap is never permitted. This case from old
capset02.c.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/capset/.gitignore |  1 +
 testcases/kernel/syscalls/capset/capset04.c | 86 +++++++++++++++++++++
 3 files changed, 88 insertions(+)
 create mode 100644 testcases/kernel/syscalls/capset/capset04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 4f481be6d..f58fefe17 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -45,6 +45,7 @@ capget02 capget02
 capset01 capset01
 capset02 capset02
 capset03 capset03
+capset04 capset04
 
 cacheflush01 cacheflush01
 
diff --git a/testcases/kernel/syscalls/capset/.gitignore b/testcases/kernel/syscalls/capset/.gitignore
index 3f9a4d5e8..d0a7a13a4 100644
--- a/testcases/kernel/syscalls/capset/.gitignore
+++ b/testcases/kernel/syscalls/capset/.gitignore
@@ -1,3 +1,4 @@
 /capset01
 /capset02
 /capset03
+/capset04
diff --git a/testcases/kernel/syscalls/capset/capset04.c b/testcases/kernel/syscalls/capset/capset04.c
new file mode 100644
index 000000000..ba8546521
--- /dev/null
+++ b/testcases/kernel/syscalls/capset/capset04.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
+ * Author: Saji Kumar.V.R <saji.kumar@wipro.com>
+ *
+ * Tests whether we can use capset() to modify the capabilities of a thread
+ * other than itself. Now, most linux distributions with kernel supporting
+ * VFS capabilities, this should be never permitted.
+ */
+#include <stdlib.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+#include <linux/capability.h>
+
+static struct __user_cap_header_struct header = {
+	.version = 0x20080522,
+	.pid = 0,
+};
+static struct __user_cap_data_struct data[2];
+static pid_t child_pid;
+static int clean_nflag;
+static void cleanup(void);
+
+static void child_func(void)
+{
+	for (;;)
+		sleep(10);
+}
+
+static void verify_capset(void)
+{
+	child_pid = SAFE_FORK();
+	if (child_pid == 0) {
+		child_func();
+		exit(0);
+	}
+
+	clean_nflag = 0;
+	header.pid = child_pid;
+
+	TEST(tst_syscall(__NR_capset, &header, data));
+	if (TST_RET == 0) {
+		tst_res(TFAIL, "capset succeed unexpectedly");
+		cleanup();
+		return;
+	}
+	if (TST_ERR == EPERM)
+		tst_res(TPASS, "capset doesn't can modify other process capabilities");
+	else
+		tst_res(TFAIL | TTERRNO, "capset expected EPERM, bug got");
+
+	cleanup();
+}
+
+static void setup(void)
+{
+	pid_t pid;
+
+	pid = getpid();
+	header.pid = pid;
+	TEST(tst_syscall(__NR_capget, &header, data));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "capget data failed");
+}
+
+static void cleanup(void)
+{
+	if (child_pid > 0 && !clean_nflag) {
+		SAFE_KILL(child_pid, SIGTERM);
+		SAFE_WAIT(NULL);
+		clean_nflag = 1;
+	}
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_capset,
+	.forks_child = 1,
+	.caps = (struct tst_cap []) {
+		TST_CAP(TST_CAP_REQ, CAP_SETPCAP),
+		{}
+	},
+};
-- 
2.18.0



