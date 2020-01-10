From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 10 Jan 2020 18:21:41 +0800
Subject: [LTP] [PATCH v2 2/3] syscalls/capset03: add new EPERM error test
 without CAP_SETPCAP
In-Reply-To: <1578651702-19486-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20200109124101.GE31981@rei.lan>
 <1578651702-19486-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1578651702-19486-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

-------------------
v1->v2:
1.remove useless drop
2. use guarded buffer allocation
-------------------

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/capset/.gitignore |  1 +
 testcases/kernel/syscalls/capset/capset03.c | 59 +++++++++++++++++++++
 3 files changed, 61 insertions(+)
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
index 000000000..d5754753d
--- /dev/null
+++ b/testcases/kernel/syscalls/capset/capset03.c
@@ -0,0 +1,59 @@
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
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+#include <linux/capability.h>
+
+#define CAP1 (1 << CAP_KILL)
+#define CAP2 (CAP1 | 1 << CAP_NET_RAW)
+
+static struct __user_cap_header_struct *header;
+static struct __user_cap_data_struct *data;
+
+static void verify_capset(void)
+{
+	tst_res(TINFO, "Test bad value data(when pI is not old pP or old pI without CAP_SETPCAP)");
+	data[0].inheritable = CAP2;
+	TEST(tst_syscall(__NR_capset, header, data));
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
+	header->version = 0x20080522;
+
+	data[0].effective = CAP1;
+	data[0].permitted = CAP1;
+	data[0].inheritable = CAP1;
+
+	TEST(tst_syscall(__NR_capset, header, data));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "capset data failed");
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = verify_capset,
+	.needs_root = 1,
+	.bufs = (struct tst_buffers []) {
+		{&header, .size = sizeof(*header)},
+		{&data, .size = 2 * sizeof(*data)},
+		{},
+	}
+};
-- 
2.18.0



