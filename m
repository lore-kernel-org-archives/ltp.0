From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 17 Dec 2019 18:12:51 +0800
Subject: [LTP] [PATCH v3 4/5] syscalls/quotactl05: add project quota test
 for xfs filesystem
In-Reply-To: <1576577571-3668-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1576577571-3668-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1576577571-3668-5-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is a variant about quotactl02. It is used to test project quota.
I split it into a new case instead of adding it in quotaclt02 because
kernel doesn't permit mount both group and project quota before
commit d892d5864f02 ("xfs: Start using pquotaino from the superblock.").

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/quotactl/.gitignore |  2 +
 .../kernel/syscalls/quotactl/quotactl05.c     | 99 +++++++++++++++++++
 3 files changed, 102 insertions(+)
 create mode 100644 testcases/kernel/syscalls/quotactl/quotactl05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index c30e9e620..f2c7b0daf 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -954,6 +954,7 @@ quotactl01 quotactl01
 quotactl02 quotactl02
 quotactl03 quotactl03
 quotactl04 quotactl04
+quotactl05 quotactl05
 
 read01 read01
 read02 read02
diff --git a/testcases/kernel/syscalls/quotactl/.gitignore b/testcases/kernel/syscalls/quotactl/.gitignore
index 1db7c5d98..9621e7717 100644
--- a/testcases/kernel/syscalls/quotactl/.gitignore
+++ b/testcases/kernel/syscalls/quotactl/.gitignore
@@ -2,3 +2,5 @@
 /quotactl02
 /quotactl03
 /quotactl04
+/quotactl05
+
diff --git a/testcases/kernel/syscalls/quotactl/quotactl05.c b/testcases/kernel/syscalls/quotactl/quotactl05.c
new file mode 100644
index 000000000..2c4f49f7c
--- /dev/null
+++ b/testcases/kernel/syscalls/quotactl/quotactl05.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ *
+ * Test Name: quotactl05
+ *
+ * Description:
+ * This testcase checks basic flags of quotactl(2) for project on an XFS file
+ * system:
+ * 1) quotactl(2) succeeds to turn off xfs quota and get xfs quota off status
+ *    for project.
+ * 2) quotactl(2) succeeds to turn on xfs quota and get xfs quota on status
+ *    for project.
+ * 3) quotactl(2) succeeds to set and use Q_XGETQUOTA to get xfs disk quota
+ *    limits for project.
+ * 4) quotactl(2) succeeds to set and use Q_XGETNEXTQUOTA to get xfs disk
+ *    quota limits Cgreater than or equal to ID for project.
+ * 5) quotactl(2) succeeds to turn off xfs quota and get xfs quota off statv
+ *    for project.
+ * 6) quotactl(2) succeeds to turn on xfs quota and get xfs quota on statv
+ *    for project.
+ */
+#include "quotactl02.h"
+#if defined(HAVE_XFS_XQM_H)
+
+static uint32_t qflagp = XFS_QUOTA_PDQ_ENFD;
+static struct t_case {
+	int cmd;
+	void *addr;
+	void (*func_check)();
+	int check_subcmd;
+	int flag;
+	char *des;
+} tcases[] = {
+	{QCMD(Q_XQUOTAOFF, PRJQUOTA), &qflagp, check_qoff,
+	QCMD(Q_XGETQSTAT, PRJQUOTA), 1,
+	"turn off xfs quota and get xfs quota off status for project"},
+
+	{QCMD(Q_XQUOTAON, PRJQUOTA), &qflagp, check_qon,
+	QCMD(Q_XGETQSTAT, PRJQUOTA), 1,
+	"turn on xfs quota and get xfs quota on status for project"},
+
+	{QCMD(Q_XSETQLIM, PRJQUOTA), &set_dquota, check_qlim,
+	QCMD(Q_XGETQUOTA, PRJQUOTA), 0,
+	"Q_XGETQUOTA for project"},
+
+	{QCMD(Q_XSETQLIM, PRJQUOTA), &set_dquota, check_qlim,
+	QCMD(Q_XGETNEXTQUOTA, PRJQUOTA), 0,
+	"Q_XGETNEXTQUOTA for project"},
+
+#if defined(HAVE_STRUCT_FS_QUOTA_STATV)
+	{QCMD(Q_XQUOTAOFF, PRJQUOTA), &qflagp, check_qoffv,
+	QCMD(Q_XGETQSTATV, PRJQUOTA), 1,
+	"turn off xfs quota and get xfs quota off statv for project"},
+
+	{QCMD(Q_XQUOTAON, PRJQUOTA), &qflagp, check_qonv,
+	QCMD(Q_XGETQSTATV, PRJQUOTA), 1,
+	"turn on xfs quota and get xfs quota on statv for project"},
+#endif
+};
+
+static void setup(void)
+{
+	test_id = geteuid();
+}
+
+static void verify_quota(unsigned int n)
+{
+	struct t_case *tc = &tcases[n];
+
+	TEST(quotactl(tc->cmd, tst_device->dev, test_id, tc->addr));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "quotactl() failed to %s", tc->des);
+		return;
+	}
+
+	if (tc->flag)
+		tc->func_check(tc->check_subcmd, tc->des, *(int *)(tc->addr));
+	else
+		tc->func_check(tc->check_subcmd, tc->des);
+}
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.needs_kconfigs = kconfigs,
+	.test = verify_quota,
+	.tcnt = ARRAY_SIZE(tcases),
+	.mount_device = 1,
+	.dev_fs_type = "xfs",
+	.mntpoint = mntpoint,
+	.mnt_data = "prjquota",
+	.setup = setup,
+};
+
+#else
+	TST_TEST_TCONF("This system didn't have <xfs/xqm.h>");
+#endif
-- 
2.18.0



