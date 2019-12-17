From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 17 Dec 2019 18:12:50 +0800
Subject: [LTP] [PATCH v1 3/4] syscalls/capset03: add new EPERM error test
 without CAP_SETPCAP
In-Reply-To: <1576577571-3668-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1576577571-3668-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1576577571-3668-4-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/capset/.gitignore |  1 +
 testcases/kernel/syscalls/capset/capset03.c | 65 +++++++++++++++++++++
 3 files changed, 67 insertions(+)
 create mode 100644 testcases/kernel/syscalls/capset/capset03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index fa87ef63f..4f481be6d 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -44,6 +44,7 @@ capget02 capget02
 
 capset01 capset01
 capset02 capset02
+capset03 capset03
 
 cacheflush01 cacheflush01
 
diff --git a/testcases/kernel/syscalls/capset/.gitignore b/testcases/kernel/syscalls/capset/.gitignore
index 004ce7b3e..3f9a4d5e8 100644
--- a/testcases/kernel/syscalls/capset/.gitignore
+++ b/testcases/kernel/syscalls/capset/.gitignore
@@ -1,2 +1,3 @@
 /capset01
 /capset02
+/capset03
diff --git a/testcases/kernel/syscalls/capset/capset03.c b/testcases/kernel/syscalls/capset/capset03.c
new file mode 100644
index 000000000..d973095a4
--- /dev/null
+++ b/testcases/kernel/syscalls/capset/capset03.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com
+ *
+ * capset() fails with errno set or EPERM if the new_Inheritable is
+ * not a subset of old_Inheritable and old_Permitted without CAP_SETPCAP.
+ */
+#include <stdlib.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <sys/prctl.h>
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+#include <linux/capability.h>
+
+static struct __user_cap_header_struct header = {
+	.version = 0x20080522,
+	.pid = 0,
+};
+
+static struct __user_cap_data_struct data[2] = {
+	{
+		.effective = 1 << CAP_KILL,
+		.permitted = 1 << CAP_KILL,
+		.inheritable = 1 << CAP_KILL,
+	},
+};
+
+static void verify_capset(void)
+{
+	tst_res(TINFO, "Test bad value data(when pI is not old pP or old pI without CAP_SETPCAP)");
+	data[0].inheritable = (1 << CAP_KILL | 1 << CAP_NET_RAW);
+	TEST(tst_syscall(__NR_capset, &header, data));
+	if (TST_RET == 0) {
+		tst_res(TFAIL, "capset succeed unexpectedly");
+		return;
+	}
+	if (TST_ERR == EPERM)
+		tst_res(TPASS | TTERRNO, "capset() failed as expected");
+	else
+		tst_res(TFAIL | TTERRNO, "capset expected EPERM, bug got");
+}
+
+static void setup(void)
+{
+	pid_t pid;
+
+	pid = getpid();
+	header.pid = pid;
+	if (geteuid() == 0) {
+		TEST(tst_syscall(__NR_capset, &header, data));
+		if (TST_RET == -1)
+			tst_brk(TBROK | TTERRNO, "capset data failed");
+	}
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = verify_capset,
+	.caps = (struct tst_cap []) {
+		TST_CAP(TST_CAP_DROP, CAP_SETPCAP),
+		{}
+	},
+};
-- 
2.18.0



