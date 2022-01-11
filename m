Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346D8C433F5
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 10:28:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6492D3C93E8
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 11:28:48 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 31AA93C90AA
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 11:28:17 +0100 (CET)
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com
 [85.158.142.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8A9BD201081
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 11:28:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1641896895; i=@fujitsu.com;
 bh=AsWCPKjhaf9OjXSU3y0/RnXqb6HKfPR8NYDU55cGfPk=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=r0um+4IzQ2MZocFfSFV1QdP+vDYxSTxGDwYU5HbsSQXAsC5ZVRzE5r+ZgfA1YX65G
 I3tqwOhOIQoB88ZyIhv82kgfsIaIUlNdFwmzSAP4Mo9mQcRbGkehpCNRmKo+ymx4P0
 UECJFY214pmy7dP1vyb/IHsRZ1TKWMm2BRXHrpxqJiluLxNFyscFmr+OrVZrlK+D2i
 Q7LjsN7JAUlYIjL8U24zvtxqKxHoNiykPUC0to2xT2QJWzzYfGt6XTAuKDD79++xQY
 d8G/oXXo3/wjV+7n5/XF+zOFeaHSK5UONlIsBtZOpD75+GxpBanIuorY5OcdiHt7Ec
 TlIWYetNOBs8g==
Received: from [100.115.64.12] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-a.eu-central-1.aws.ess.symcld.net id 20/71-06990-FBB5DD16;
 Tue, 11 Jan 2022 10:28:15 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRWlGSWpSXmKPExsViZ8ORqLs/+m6
 iwcRrkhYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8adI1uZCpbpVKxYspelgXGfahcjF4eQwFlG
 iUMrL7BAODuZJOb9O8UK4exhlHj/7TtjFyMnB5uApsSzzgXMILaIgIRER8NbdhCbWUBdYvmkX
 0wgtrBAjMTMxZ1gcRYBVYl5HRPB4rwCHhJvrt4E65UQUJCY8vA9M0RcUOLkzCcsEHMkJA6+eA
 FVoyhxqeMbI4RdITFrVhsThK0mcfXcJuYJjPyzkLTPQtK+gJFpFaNdUlFmekZJbmJmjq6hgYG
 uoaGprpmZrqGloV5ilW6iXmqpbnJqXklRIlBaL7G8WC+1uFivuDI3OSdFLy+1ZBMjMDxTip32
 72B82vdT7xCjJAeTkijvyYi7iUJ8SfkplRmJxRnxRaU5qcWHGGU4OJQkeF1BcoJFqempFWmZO
 cBYgUlLcPAoifBuCQFK8xYXJOYWZ6ZDpE4x6nI0T1q+nVmIJS8/L1VKnHdSFFCRAEhRRmke3A
 hY3F5ilJUS5mVkYGAQ4ilILcrNLEGVf8UozsGoJMxrDzKFJzOvBG7TK6AjmICOSOa4DXJESSJ
 CSqqBacvO497R8cJRboKKa36/Fz7wnUE8vzCBbeuFi2WrDDxig6RZmCLfr7q48tmUiYfbhexl
 Z9ldn8EyyzPY2czyhqzRL9G5S0Kdz947Wel9z2Hi30lXe35qL0wLKopeHN86PSyETeuEX3xyj
 E6Ke6XRv69nzCLDSr+rsIcfvrUtLSSq58nM62uc3QV8s9aW2Lcyzd4no93fb9Yhcunog8wgla
 7arr96rZOcexNq/A5a1U6bPltnvSKD2aSlLNY3uFd4TWX7b7svuX/+van2oZrPN9tOTm7KMf7
 zIZ3tyu//M16d73VleSy5frFpsM025V8fldZnBP/Z+qYk5NNk31zn3OvibO6mnfWx/PMk2nSV
 WIozEg21mIuKEwGEXiJSVgMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-3.tower-532.messagelabs.com!1641896895!1958!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 17886 invoked from network); 11 Jan 2022 10:28:15 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-3.tower-532.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 11 Jan 2022 10:28:15 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id D0F76100193
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 10:28:14 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id BF123100183
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 10:28:14 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Tue, 11 Jan 2022 10:27:59 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 11 Jan 2022 18:28:37 +0800
Message-ID: <1641896919-5919-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/3] syscalls/quotactl09: Test error when quota
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

This case is similar to quotactl06 but only two differences
1) use quotactl and quotactl_fd syscalls without visible quota file
2) remove some error for addr argument

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/quotactl/.gitignore |   1 +
 .../kernel/syscalls/quotactl/quotactl09.c     | 168 ++++++++++++++++++
 3 files changed, 170 insertions(+)
 create mode 100644 testcases/kernel/syscalls/quotactl/quotactl09.c

diff --git a/runtest/syscalls b/runtest/syscalls
index a0ca84b36..3b2deb64e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1073,6 +1073,7 @@ quotactl05 quotactl05
 quotactl06 quotactl06
 quotactl07 quotactl07
 quotactl08 quotactl08
+quotactl09 quotactl09
 
 read01 read01
 read02 read02
diff --git a/testcases/kernel/syscalls/quotactl/.gitignore b/testcases/kernel/syscalls/quotactl/.gitignore
index dab9b3420..94de2c8f2 100644
--- a/testcases/kernel/syscalls/quotactl/.gitignore
+++ b/testcases/kernel/syscalls/quotactl/.gitignore
@@ -6,3 +6,4 @@
 /quotactl06
 /quotactl07
 /quotactl08
+/quotactl09
diff --git a/testcases/kernel/syscalls/quotactl/quotactl09.c b/testcases/kernel/syscalls/quotactl/quotactl09.c
new file mode 100644
index 000000000..e0411ce33
--- /dev/null
+++ b/testcases/kernel/syscalls/quotactl/quotactl09.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Tests basic error handling of the quotactl syscall without visible quota files
+ * (use quotactl and quotactl_fd syscall):
+ *
+ * - EFAULT when addr or special is invalid
+ * - EINVAL when cmd or type is invalid
+ * - ENOTBLK when special is not a block device
+ * - ERANGE when cmd is Q_SETQUOTA, but the specified limits are out of the range
+ *   allowed by the quota format
+ * - EPERM when the caller lacked the required privilege (CAP_SYS_ADMIN) for the
+ *   specified operation
+ *
+ * Minimum e2fsprogs version required is 1.43.
+ */
+
+#include <errno.h>
+#include <sys/quota.h>
+#include "tst_test.h"
+#include "tst_capability.h"
+#include "quotactl_syscall_var.h"
+
+#define OPTION_INVALID 999
+
+static int32_t fmt_id = QFMT_VFS_V1;
+static int test_id, mount_flag;
+static int getnextquota_nsup;
+
+static struct if_nextdqblk res_ndq;
+
+static struct dqblk set_dqmax = {
+	.dqb_bsoftlimit = 0x7fffffffffffffffLL,  /* 2^63-1 */
+	.dqb_valid = QIF_BLIMITS
+};
+
+static struct tst_cap dropadmin = {
+	.action = TST_CAP_DROP,
+	.id = CAP_SYS_ADMIN,
+	.name = "CAP_SYS_ADMIN",
+};
+
+static struct tst_cap needadmin = {
+	.action = TST_CAP_REQ,
+	.id = CAP_SYS_ADMIN,
+	.name = "CAP_SYS_ADMIN",
+};
+
+static struct tcase {
+	int cmd;
+	int *id;
+	void *addr;
+	int exp_err;
+	int on_flag;
+} tcases[] = {
+	{QCMD(Q_SETQUOTA, USRQUOTA), &fmt_id, NULL, EFAULT, 1},
+	{QCMD(OPTION_INVALID, USRQUOTA), &fmt_id, NULL, EINVAL, 0},
+	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, NULL, ENOTBLK, 0},
+	{QCMD(Q_SETQUOTA, USRQUOTA), &test_id, &set_dqmax, ERANGE, 1},
+	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, NULL, EPERM, 0},
+};
+
+static void verify_quotactl(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	int quota_on = 0;
+	int drop_flag = 0;
+
+	if (tc->cmd == QCMD(Q_GETNEXTQUOTA, USRQUOTA) && getnextquota_nsup) {
+		tst_res(TCONF, "current system doesn't support Q_GETNEXTQUOTA");
+		return;
+	}
+
+	if (tc->on_flag) {
+		TST_EXP_PASS_SILENT(do_quotactl(fd, QCMD(Q_QUOTAON, USRQUOTA), tst_device->dev,
+			fmt_id, NULL), "do_quotactl(QCMD(Q_QUOTAON, USRQUOTA))");
+		if (!TST_PASS)
+			return;
+		quota_on = 1;
+	}
+
+	if (tc->exp_err == EPERM) {
+		tst_cap_action(&dropadmin);
+		drop_flag = 1;
+	}
+
+	if (tst_variant) {
+		if (tc->exp_err == ENOTBLK) {
+			tst_res(TCONF, "quotactl_fd() doesn't have this error, skip");
+			return;
+		}
+	}
+	if (tc->exp_err == ENOTBLK)
+		TST_EXP_FAIL(do_quotactl(fd, tc->cmd, "/dev/null", *tc->id, tc->addr),
+			ENOTBLK, "do_quotactl()");
+	else
+		TST_EXP_FAIL(do_quotactl(fd, tc->cmd, tst_device->dev, *tc->id, tc->addr),
+			tc->exp_err, "do_quotactl()");
+
+	if (quota_on) {
+		TST_EXP_PASS_SILENT(do_quotactl(fd, QCMD(Q_QUOTAOFF, USRQUOTA), tst_device->dev,
+			fmt_id, NULL), "do_quotactl(QCMD(Q_QUOTAOFF, USRQUOTA)");
+		if (!TST_PASS)
+			return;
+		quota_on = 0;
+	}
+
+	if (drop_flag) {
+		tst_cap_action(&needadmin);
+		drop_flag = 0;
+	}
+}
+
+static void setup(void)
+{
+	unsigned int i;
+	const char *const fs_opts[] = { "-O quota", NULL};
+
+	quotactl_info();
+	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
+	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
+	mount_flag = 1;
+
+	fd = SAFE_OPEN(MNTPOINT, O_RDONLY);
+	TEST(do_quotactl(fd, QCMD(Q_GETNEXTQUOTA, USRQUOTA), tst_device->dev,
+		test_id, (void *) &res_ndq));
+	if (TST_ERR == EINVAL || TST_ERR == ENOSYS)
+		getnextquota_nsup = 1;
+
+	for (i = 0; i < ARRAY_SIZE(tcases); i++) {
+		if (!tcases[i].addr)
+			tcases[i].addr = tst_get_bad_addr(NULL);
+	}
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
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_QFMT_V2",
+		NULL
+	},
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_quotactl,
+	.dev_fs_type = "ext4",
+	.mntpoint = MNTPOINT,
+	.needs_device = 1,
+	.needs_root = 1,
+	.test_variants = QUOTACTL_SYSCALL_VARIANTS,
+	.needs_cmds = (const char *[]) {
+		"mkfs.ext4 >= 1.43.0",
+		NULL
+	}
+};
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
