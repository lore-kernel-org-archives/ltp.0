From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 20 Nov 2019 17:13:35 +0800
Subject: [LTP] [PATCH v4 4/5] syscalls/quotactl05: add project quota test on
 xfs filesystem
In-Reply-To: <1574241216-15168-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1574241216-15168-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1574241216-15168-5-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is a variant about quotactl02.c and used to test project quota.
I split it into a new case instead of adding it in quotaclt02.c because
kernel doesn't permit mount both group and project quota before
commit d892d5864f02 ("xfs: Start using pquotaino from the superblock.").

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/quotactl/.gitignore |   1 +
 .../kernel/syscalls/quotactl/quotactl05.c     | 118 ++++++++++++++++++
 3 files changed, 120 insertions(+)
 create mode 100644 testcases/kernel/syscalls/quotactl/quotactl05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 078143b13..b6bf67c38 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -955,6 +955,7 @@ quotactl01 quotactl01
 quotactl02 quotactl02
 quotactl03 quotactl03
 quotactl04 quotactl04
+quotactl05 quotactl05
 
 read01 read01
 read02 read02
diff --git a/testcases/kernel/syscalls/quotactl/.gitignore b/testcases/kernel/syscalls/quotactl/.gitignore
index 1db7c5d98..6fe62fbf7 100644
--- a/testcases/kernel/syscalls/quotactl/.gitignore
+++ b/testcases/kernel/syscalls/quotactl/.gitignore
@@ -2,3 +2,4 @@
 /quotactl02
 /quotactl03
 /quotactl04
+/quotactl05
diff --git a/testcases/kernel/syscalls/quotactl/quotactl05.c b/testcases/kernel/syscalls/quotactl/quotactl05.c
new file mode 100644
index 000000000..20ef30421
--- /dev/null
+++ b/testcases/kernel/syscalls/quotactl/quotactl05.c
@@ -0,0 +1,118 @@
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
+	char *tname;
+} tcases[] = {
+	{QCMD(Q_XQUOTAOFF, PRJQUOTA), &qflagp, check_qoff,
+	QCMD(Q_XGETQSTAT, PRJQUOTA), 1,
+	"turn off xfs quota and get xfs quota off status for project",
+	"QCMD(Q_XGETQSTAT, PRJQUOTA) off"},
+
+	{QCMD(Q_XQUOTAON, PRJQUOTA), &qflagp, check_qon,
+	QCMD(Q_XGETQSTAT, PRJQUOTA), 1,
+	"turn on xfs quota and get xfs quota on status for project",
+	"QCMD(Q_XGETQSTAT, PRJQUOTA) on"},
+
+	{QCMD(Q_XSETQLIM, PRJQUOTA), &set_dquota, check_qlim,
+	QCMD(Q_XGETQUOTA, PRJQUOTA), 0,
+	"Q_XGETQUOTA for project", "QCMD(Q_XGETQUOTA, PRJQUOTA) qlim"},
+
+	{QCMD(Q_XSETQLIM, PRJQUOTA), &set_dquota, check_qlim,
+	QCMD(Q_XGETNEXTQUOTA, PRJQUOTA), 0,
+	"Q_XGETNEXTQUOTA for project", "QCMD(Q_XGETNEXTQUOTA, PRJQUOTA)"},
+
+	{QCMD(Q_XQUOTAOFF, PRJQUOTA), &qflagp, check_qoffv,
+	QCMD(Q_XGETQSTATV, PRJQUOTA), 1,
+	"turn off xfs quota and get xfs quota off statv for project",
+	"QCMD(Q_XGETQSTATV, PRJQUOTA) off"},
+
+	{QCMD(Q_XQUOTAON, PRJQUOTA), &qflagp, check_qonv,
+	QCMD(Q_XGETQSTATV, PRJQUOTA), 1,
+	"turn on xfs quota and get xfs quota on statv for project",
+	"QCMD(Q_XGETQSTATV, PRJQUOTA) on"},
+};
+
+static void setup(void)
+{
+	test_id = geteuid();
+	check_support_cmd(PRJQUOTA);
+}
+
+static void verify_quota(unsigned int n)
+{
+	struct t_case *tc = &tcases[n];
+
+	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
+
+	if ((tc->check_subcmd == QCMD(Q_XGETNEXTQUOTA, PRJQUOTA))
+		&& x_getnextquota_nsup) {
+		tst_res(TCONF,
+			"current system doesn't support this cmd, skip it");
+		return;
+	}
+	if ((tc->check_subcmd == QCMD(Q_XGETQSTATV, PRJQUOTA))
+		&& x_getstatv_nsup) {
+		tst_res(TCONF,
+			"current system doesn't support this cmd, skip it");
+		return;
+	}
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



