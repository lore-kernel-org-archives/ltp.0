From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 5 Dec 2019 14:17:44 +0800
Subject: [LTP] [PATCH v2] syscalls/quotactl07: add regresstion test for
 Q_XQTUOTARM
Message-ID: <1575526664-25738-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is a regresstion test to check Q_XQUOTARM  whether has
quota flags check.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>

---------------------
1.Simplify test code
2.add comment for invalid_type,
---------------------
---
 include/lapi/quotactl.h                       |  4 ++
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/quotactl/.gitignore |  1 +
 .../kernel/syscalls/quotactl/quotactl07.c     | 71 +++++++++++++++++++
 4 files changed, 77 insertions(+)
 create mode 100644 testcases/kernel/syscalls/quotactl/quotactl07.c

diff --git a/include/lapi/quotactl.h b/include/lapi/quotactl.h
index d3223b863..c1ec9d6e1 100644
--- a/include/lapi/quotactl.h
+++ b/include/lapi/quotactl.h
@@ -59,6 +59,10 @@ struct fs_quota_statv {
 # define PRJQUOTA 2
 #endif
 
+#ifndef Q_XQUOTARM
+# define Q_XQUOTARM XQM_CMD(6)
+#endif
+
 #ifndef Q_XGETQSTATV
 # define Q_XGETQSTATV XQM_CMD(8)
 #endif
diff --git a/runtest/syscalls b/runtest/syscalls
index 15dbd9971..0f75cf3f6 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -958,6 +958,7 @@ quotactl03 quotactl03
 quotactl04 quotactl04
 quotactl05 quotactl05
 quotactl06 quotactl06
+quotactl07 quotactl07
 
 read01 read01
 read02 read02
diff --git a/testcases/kernel/syscalls/quotactl/.gitignore b/testcases/kernel/syscalls/quotactl/.gitignore
index 12896d6ad..8d2ef94d9 100644
--- a/testcases/kernel/syscalls/quotactl/.gitignore
+++ b/testcases/kernel/syscalls/quotactl/.gitignore
@@ -4,3 +4,4 @@
 /quotactl04
 /quotactl05
 /quotactl06
+/quotactl07
diff --git a/testcases/kernel/syscalls/quotactl/quotactl07.c b/testcases/kernel/syscalls/quotactl/quotactl07.c
new file mode 100644
index 000000000..cd9f629ea
--- /dev/null
+++ b/testcases/kernel/syscalls/quotactl/quotactl07.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ *
+ * This is a regresstion test for kernel commit 3dd4d40b4208
+ * ("xfs: Sanity check flags of Q_XQUOTARM call").
+ */
+
+#include "config.h"
+#include <errno.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <sys/quota.h>
+#include "lapi/quotactl.h"
+#include "tst_test.h"
+
+#ifdef HAVE_XFS_XQM_H
+# include <xfs/xqm.h>
+
+#define MNTPOINT    "mntpoint"
+
+static uint32_t qflag_acct = XFS_QUOTA_UDQ_ACCT;
+static unsigned int valid_type = XFS_USER_QUOTA;
+/*Include a valid quota type to avoid other EINVAL error*/
+static unsigned int invalid_type = XFS_GROUP_QUOTA << 1 | XFS_USER_QUOTA;
+
+static void verify_quota(void)
+{
+	TEST(quotactl(QCMD(Q_XQUOTARM, USRQUOTA), tst_device->dev, 0, (void *)&invalid_type));
+	if (TST_ERR == EINVAL)
+		tst_res(TPASS, "Q_XQUOTARM has quota type check");
+	else
+		tst_res(TFAIL, "Q_XQUOTARM doesn't have quota type check");
+}
+
+static void setup(void)
+{
+	TEST(quotactl(QCMD(Q_XQUOTAOFF, USRQUOTA), tst_device->dev, 0, (void *)&qflag_acct));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "quotactl with Q_XQUOTAOFF failed");
+
+	TEST(quotactl(QCMD(Q_XQUOTARM, USRQUOTA), tst_device->dev, 0, (void *)&valid_type));
+	if (TST_ERR == EINVAL) {
+		tst_res(TCONF, "current system doesn't support Q_XQUOTARM, skip it");
+		return;
+	}
+}
+
+static const char *kconfigs[] = {
+	"CONFIG_XFS_QUOTA",
+	NULL
+};
+
+static struct tst_test test = {
+	.setup = setup,
+	.needs_root = 1,
+	.needs_kconfigs = kconfigs,
+	.test_all = verify_quota,
+	.mount_device = 1,
+	.dev_fs_type = "xfs",
+	.mnt_data = "usrquota",
+	.mntpoint = MNTPOINT,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "3dd4d40b4208"},
+		{}
+	}
+};
+#else
+	TST_TEST_TCONF("System doesn't have <xfs/xqm.h>");
+#endif
-- 
2.18.0



