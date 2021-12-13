Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E90C433EF
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 07:26:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA8723C897C
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 08:26:56 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 506653C2242
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 08:26:37 +0100 (CET)
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com
 [85.158.142.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 84CE71000D12
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 08:26:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1639380396; i=@fujitsu.com;
 bh=vHOUf4TWSeeY6DEKgXsCROnICzMzUjQzcmVCdHyfRPs=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=qFama2g80kuEhn4IwUPOe8qXNL46x3vKtb9aMbywFIPWZ6fr94JPwQV1UPQSKtKGZ
 TStwMn16o59WCMomvOEvASebVXDvOR3rUozbVpRuYpa2izcgDAJJ5TUfL1UNB8qHEk
 yRkOcwrdAU7osZDBkO9E0NEmjPrvR6OJFXPoSAkDI8LMWVK5uraQaEo3zXgl+UgP7+
 3Wv1nQ8B2BKhvFgR5EPoKKX/OwwipnhyQNXp7Yzx1jRI5FA3B8TtSG+1dfx1RHOJk4
 IaGY+Lj9+t40hWJC5qy/4kg/KME2f8th5jQwVf9pVF+YnHnZfx61dMRR3yW7wYBej5
 C1UX2EMA18nEQ==
Received: from [100.115.71.165] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-a.eu-central-1.aws.ess.symcld.net id DE/CC-06990-CA5F6B16;
 Mon, 13 Dec 2021 07:26:36 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRWlGSWpSXmKPExsViZ8MxSXfl122
 JBlcfGlus+L6D0YHRY9/vdawBjFGsmXlJ+RUJrBn7171mLtjiWzFj0l2mBsYNTl2MXBxCAmcZ
 Jc61/WWCcHYySez9fZ4VwtnDKHH20i6gDCcHm4CmxLPOBcwgtoiAhERHw1t2EJtZQF1i+aRfQ
 DUcHMICCRK3PpSBhFkEVCXuXrjEDhLmFfCUONFfCBKWEFCQmPLwPdgUTgEViSnzT7KA2EICyh
 LTTh4B28QrIChxcuYTFojpEhIHX7xghuhVlLjU8Y0Rwq6QmDWrjQnCVpO4em4T8wRGwVlI2mc
 haV/AyLSK0S6pKDM9oyQ3MTNH19DAQNfQ0FTXzEzX0NRUL7FKN1EvtVQ3OTWvpCgRKK2XWF6s
 l1pcrFdcmZuck6KXl1qyiREYyinFTrN3MO7o+6l3iFGSg0lJlPcb49ZEIb6k/JTKjMTijPii0
 pzU4kOMMhwcShK8Xl+2JQoJFqWmp1akZeYA4womLcHBoyTC6wqS5i0uSMwtzkyHSJ1iNObYeX
 TeImaO1y0/dzALseTl56VKifNmgZQKgJRmlObBDYLF+yVGWSlhXkYGBgYhnoLUotzMElT5V4z
 iHIxKwrwBIFN4MvNK4Pa9AjqFCegUxsrNIKeUJCKkpBqY5hqkaU2eeGHp3kvq1tK/iou7G8qP
 XJEUM751x7Pu7p+bniEFWyROJAbdy9jyzfS5TBwns+xMB+P0VtZHk9gM9zrLnGKtmS5yJej9y
 nbh4Glsf/+ym5mzLuScErplO9e15d+aDiiZTVQIPqZisD71YYHM1imn+t7t7eyQujX10c7mPK
 aTE0vfz9hues5Inu94sPlFrsmxk4Q62IK+PDt2NL7WR+DkdJu1LjqhT0M/OMoE1+3csMvluWJ
 p7MvEm6x3DrXHnFR6kaIV9XbVz06lNW5fX027WJ178PJ1vhe5beaP+6cdCNc9bNXc2vko3PPG
 x6usX8pMuGL4+df1nPmSFqq8iVm0QvpFE4f0i9ZmJZbijERDLeai4kQA9p9JbHIDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-21.tower-545.messagelabs.com!1639380393!180462!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 29005 invoked from network); 13 Dec 2021 07:26:33 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-21.tower-545.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 13 Dec 2021 07:26:33 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 5CB4210033A
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 07:26:33 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 501EB1000FB
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 07:26:33 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Mon, 13 Dec 2021 07:26:20 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 13 Dec 2021 15:26:49 +0800
Message-ID: <1639380414-24390-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <YY0o7jAxgIHvmczq@yuki>
References: <YY0o7jAxgIHvmczq@yuki>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/6] syscalls/quotactl08: Test quoatctl01 but quota
 info hidden in filesystem
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

It uses two variants(quotactl and quotactl_fd). The difference for quotactl01
is that we don't use quotacheck command and quota info hidden in filesystem.

It also needs mkfs.ext4 supports quota feature.  This feature is disabled[1]
before e2fsprog 1.42 when not specifying a --enable-quota option in compile-time
and e2fsprog 1.43 remove this disable[2]. So we should limit the e2fsprog to 1.43.

[1]https://ext4.wiki.kernel.org/index.php/Quota
[2]https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/commit/?h=v1.43&id=9e8fcd6e

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/quotactl/.gitignore |   1 +
 .../kernel/syscalls/quotactl/quotactl08.c     | 228 ++++++++++++++++++
 .../syscalls/quotactl/quotactl_syscall_var.h  |  32 +++
 4 files changed, 262 insertions(+)
 create mode 100644 testcases/kernel/syscalls/quotactl/quotactl08.c
 create mode 100644 testcases/kernel/syscalls/quotactl/quotactl_syscall_var.h

diff --git a/runtest/syscalls b/runtest/syscalls
index bcf3d56c9..c795b9101 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1071,6 +1071,7 @@ quotactl04 quotactl04
 quotactl05 quotactl05
 quotactl06 quotactl06
 quotactl07 quotactl07
+quotactl08 quotactl08
 
 read01 read01
 read02 read02
diff --git a/testcases/kernel/syscalls/quotactl/.gitignore b/testcases/kernel/syscalls/quotactl/.gitignore
index 8d2ef94d9..dab9b3420 100644
--- a/testcases/kernel/syscalls/quotactl/.gitignore
+++ b/testcases/kernel/syscalls/quotactl/.gitignore
@@ -5,3 +5,4 @@
 /quotactl05
 /quotactl06
 /quotactl07
+/quotactl08
diff --git a/testcases/kernel/syscalls/quotactl/quotactl08.c b/testcases/kernel/syscalls/quotactl/quotactl08.c
new file mode 100644
index 000000000..1b8f1cd2b
--- /dev/null
+++ b/testcases/kernel/syscalls/quotactl/quotactl08.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ * This testcases checks that quotactl(2) on ext4 filesystem succeeds to:
+ *
+ * - turn on quota with Q_QUOTAON flag for user
+ * - set disk quota limits with Q_SETQUOTA flag for user
+ * - get disk quota limits with Q_GETQUOTA flag for user
+ * - set information about quotafile with Q_SETINFO flag for user
+ * - get information about quotafile with Q_GETINFO flag for user
+ * - get quota format with Q_GETFMT flag for user
+ * - update quota usages with Q_SYNC flag for user
+ * - get disk quota limit greater than or equal to ID with Q_GETNEXTQUOTA flag for user
+ * - turn off quota with Q_QUOTAOFF flag for user
+ * - turn on quota with Q_QUOTAON flag for group
+ * - set disk quota limits with Q_SETQUOTA flag for group
+ * - get disk quota limits with Q_GETQUOTA flag for group
+ * - set information about quotafile with Q_SETINFO flag for group
+ * - get information about quotafile with Q_GETINFO flag for group
+ * - get quota format with Q_GETFMT flag for group
+ * - update quota usages with Q_SYNC flag for group
+ * - get disk quota limit greater than or equal to ID with Q_GETNEXTQUOTA flag for group
+ * - turn off quota with Q_QUOTAOFF flag for group
+ *
+ * It is similar to quotactl01.c, only two difference
+ * - use new quotactl_fd syscalls if supports
+ * - quota file hidden in filesystem
+ *
+ * Minimum e2fsprogs version required is 1.43.
+ */
+
+#include <errno.h>
+#include <string.h>
+#include <unistd.h>
+#include "tst_test.h"
+#include "quotactl_syscall_var.h"
+
+#define MNTPOINT	"mntpoint"
+
+static int32_t fmt_id = QFMT_VFS_V1;
+static int test_id, mount_flag;
+static struct dqblk set_dq = {
+	.dqb_bsoftlimit = 100,
+	.dqb_valid = QIF_BLIMITS
+};
+static struct dqblk res_dq;
+
+static struct dqinfo set_qf = {
+	.dqi_bgrace = 80,
+	.dqi_valid = IIF_BGRACE
+};
+static struct dqinfo res_qf;
+static int32_t fmt_buf;
+static int getnextquota_nsup;
+
+static struct if_nextdqblk res_ndq;
+
+static struct tcase {
+	int cmd;
+	int *id;
+	void *addr;
+	void *set_data;
+	void *res_data;
+	int sz;
+	char *des;
+	char *tname;
+} tcases[] = {
+	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, NULL,
+	NULL, NULL, 0, "turn on quota for user",
+	"QCMD(Q_QUOTAON, USRQUOTA)"},
+
+	{QCMD(Q_SETQUOTA, USRQUOTA), &test_id, &set_dq,
+	NULL, NULL, 0, "set disk quota limit for user",
+	"QCMD(Q_SETQUOTA, USRQUOTA)"},
+
+	{QCMD(Q_GETQUOTA, USRQUOTA), &test_id, &res_dq,
+	&set_dq.dqb_bsoftlimit, &res_dq.dqb_bsoftlimit,
+	sizeof(res_dq.dqb_bsoftlimit), "get disk quota limit for user",
+	"QCMD(Q_GETQUOTA, USRQUOTA)"},
+
+	{QCMD(Q_SETINFO, USRQUOTA), &test_id, &set_qf,
+	NULL, NULL, 0, "set information about quotafile for user",
+	"QCMD(Q_SETINFO, USRQUOTA)"},
+
+	{QCMD(Q_GETINFO, USRQUOTA), &test_id, &res_qf,
+	&set_qf.dqi_bgrace, &res_qf.dqi_bgrace, sizeof(res_qf.dqi_bgrace),
+	"get information about quotafile for user",
+	"QCMD(Q_GETINFO, USRQUOTA)"},
+
+	{QCMD(Q_GETFMT, USRQUOTA), &test_id, &fmt_buf,
+	&fmt_id, &fmt_buf, sizeof(fmt_buf),
+	"get quota format for user",
+	"QCMD(Q_GETFMT, USRQUOTA)"},
+
+	{QCMD(Q_SYNC, USRQUOTA), &test_id, &res_dq,
+	NULL, NULL, 0, "update quota usages for user",
+	"QCMD(Q_SYNC, USRQUOTA)"},
+
+	{QCMD(Q_GETNEXTQUOTA, USRQUOTA), &test_id, &res_ndq,
+	&test_id, &res_ndq.dqb_id, sizeof(res_ndq.dqb_id),
+	"get next disk quota limit for user",
+	"QCMD(Q_GETNEXTQUOTA, USRQUOTA)"},
+
+	{QCMD(Q_QUOTAOFF, USRQUOTA), &test_id, NULL,
+	NULL, NULL, 0, "turn off quota for user",
+	"QCMD(Q_QUOTAOFF, USRQUOTA)"},
+
+	{QCMD(Q_QUOTAON, GRPQUOTA), &fmt_id, NULL,
+	NULL, NULL, 0, "turn on quota for group",
+	"QCMD(Q_QUOTAON, GRPQUOTA)"},
+
+	{QCMD(Q_SETQUOTA, GRPQUOTA), &test_id, &set_dq,
+	NULL, NULL, 0, "set disk quota limit for group",
+	"QCMD(Q_SETQUOTA, GRPQUOTA)"},
+
+	{QCMD(Q_GETQUOTA, GRPQUOTA), &test_id, &res_dq, &set_dq.dqb_bsoftlimit,
+	&res_dq.dqb_bsoftlimit, sizeof(res_dq.dqb_bsoftlimit),
+	"set disk quota limit for group",
+	"QCMD(Q_GETQUOTA, GRPQUOTA)"},
+
+	{QCMD(Q_SETINFO, GRPQUOTA), &test_id, &set_qf,
+	NULL, NULL, 0, "set information about quotafile for group",
+	"QCMD(Q_SETINFO, GRPQUOTA)"},
+
+	{QCMD(Q_GETINFO, GRPQUOTA), &test_id, &res_qf, &set_qf.dqi_bgrace,
+	&res_qf.dqi_bgrace, sizeof(res_qf.dqi_bgrace),
+	"get information about quotafile for group",
+	"QCMD(Q_GETINFO, GRPQUOTA)"},
+
+	{QCMD(Q_GETFMT, GRPQUOTA), &test_id, &fmt_buf,
+	&fmt_id, &fmt_buf, sizeof(fmt_buf), "get quota format for group",
+	"QCMD(Q_GETFMT, GRPQUOTA)"},
+
+	{QCMD(Q_SYNC, GRPQUOTA), &test_id, &res_dq,
+	NULL, NULL, 0, "update quota usages for group",
+	"QCMD(Q_SYNC, GRPQUOTA)"},
+
+	{QCMD(Q_GETNEXTQUOTA, GRPQUOTA), &test_id, &res_ndq,
+	&test_id, &res_ndq.dqb_id, sizeof(res_ndq.dqb_id),
+	"get next disk quota limit for group",
+	"QCMD(Q_GETNEXTQUOTA, GRPQUOTA)"},
+
+	{QCMD(Q_QUOTAOFF, GRPQUOTA), &test_id, NULL,
+	NULL, NULL, 0, "turn off quota for group",
+	"QCMD(Q_QUOTAOFF, GRPQUOTA)"},
+};
+
+static void setup(void)
+{
+	const char *const fs_opts[] = { "-O quota", NULL};
+
+	quotactl_info();
+
+	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
+	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
+	mount_flag = 1;
+
+	fd = SAFE_OPEN(MNTPOINT, O_RDONLY);
+	TEST(do_quotactl(fd, QCMD(Q_GETNEXTQUOTA, USRQUOTA), tst_device->dev,
+		0, (void *) &res_ndq));
+	if (TST_ERR == EINVAL || TST_ERR == ENOSYS)
+		getnextquota_nsup = 1;
+}
+
+static void cleanup(void)
+{
+	if (fd > -1)
+		SAFE_CLOSE(fd);
+	if (mount_flag && tst_umount(MNTPOINT))
+		tst_res(TWARN | TERRNO, "umount(%s)", MNTPOINT);
+}
+
+static void verify_quota(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	res_dq.dqb_bsoftlimit = 0;
+	res_qf.dqi_igrace = 0;
+	fmt_buf = 0;
+	res_ndq.dqb_id = -1;
+
+	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
+	if ((tc->cmd == QCMD(Q_GETNEXTQUOTA, USRQUOTA) ||
+		tc->cmd == QCMD(Q_GETNEXTQUOTA, GRPQUOTA)) &&
+		getnextquota_nsup) {
+		tst_res(TCONF, "current system doesn't support this cmd");
+		return;
+	}
+	TEST(do_quotactl(fd, tc->cmd, tst_device->dev, *tc->id, tc->addr));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "quotactl failed to %s", tc->des);
+		return;
+	}
+
+	if (memcmp(tc->res_data, tc->set_data, tc->sz)) {
+		tst_res(TFAIL, "quotactl failed to %s", tc->des);
+		tst_res_hexd(TINFO, tc->res_data, tc->sz, "retval:   ");
+		tst_res_hexd(TINFO, tc->set_data, tc->sz, "expected: ");
+		return;
+	}
+
+	tst_res(TPASS, "quotactl succeeded to %s", tc->des);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_QFMT_V2",
+		NULL
+	},
+	.test = verify_quota,
+	.tcnt = ARRAY_SIZE(tcases),
+	.mntpoint = MNTPOINT,
+	.dev_fs_type = "ext4",
+	.needs_device = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_variants = QUOTACTL_SYSCALL_VARIANTS,
+	.needs_cmds = (const char *[]) {
+		"mkfs.ext4 >= 1.43.0",
+		NULL
+	}
+};
diff --git a/testcases/kernel/syscalls/quotactl/quotactl_syscall_var.h b/testcases/kernel/syscalls/quotactl/quotactl_syscall_var.h
new file mode 100644
index 000000000..3d1a2c8f5
--- /dev/null
+++ b/testcases/kernel/syscalls/quotactl/quotactl_syscall_var.h
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+#ifndef LTP_QUOTACTL_SYSCALL_VAR_H
+#define LTP_QUOTACTL_SYSCALL_VAR_H
+
+#include "lapi/quotactl.h"
+
+#define QUOTACTL_SYSCALL_VARIANTS 2
+#define MNTPOINT "mntpoint"
+
+static int fd = -1;
+
+static int do_quotactl(int fd, int cmd, const char *special, int id, caddr_t addr)
+{
+	if (tst_variant == 0)
+		return quotactl(cmd, special, id, addr);
+	return quotactl_fd(fd, cmd, id, addr);
+}
+
+static void quotactl_info(void)
+{
+	if (tst_variant == 0)
+		tst_res(TINFO, "Test quotactl()");
+	else
+		tst_res(TINFO, "Test quotactl_fd()");
+}
+
+#endif /* LTP_QUOTACTL_SYSCALL_VAR_H */
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
