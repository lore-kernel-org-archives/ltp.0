Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 964E2C433EF
	for <ltp@archiver.kernel.org>; Wed, 12 Jan 2022 07:47:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 64E213C9483
	for <ltp@archiver.kernel.org>; Wed, 12 Jan 2022 08:47:47 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 003CD3C12D0
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 08:47:36 +0100 (CET)
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com
 [85.158.142.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7F8561A008A9
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 08:47:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1641973654; i=@fujitsu.com;
 bh=L8/XNn9UhSxXm72G+Rvd8TyHDXzf1xXZgFJa4YPMUBE=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=erhj8QFijmy6ujV9fmMWcA8nR9cRIH+bZ0qnTDnXVtn5nQSg68UdJyGuL9eNdtDZK
 dH3kelsiW14E/TTKz0pYKqqz7KLOZ2dQtH+LaL71gh3Toavv6cbtHAhMElqkyR8MU4
 uFqI8dsyaJ7Z+DDD0+2HrVbm27lfrpTvnPwGPuYImZwKkoFSBqfEz0d7q/o+she3T0
 khooz6Rlx5UbnlHp7+UTf+Oi29s2AbgBqjt/PFJvX7x37iC8ZJV44kiKevsaJtY8dN
 UjAi3bq1bJIHAqqhT84idUn+0bByG/AFEhN7P/W4ht+VX8y1q2tr7Z742riSp3LF3l
 PuALDoePpI0JQ==
Received: from [100.115.70.1] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-1.bemta.az-a.eu-central-1.aws.ess.symcld.net id AE/BA-31213-6978ED16;
 Wed, 12 Jan 2022 07:47:34 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRWlGSWpSXmKPExsViZ8MxSXda+71
 EgyWz2C1WfN/B6MDose/3OtYAxijWzLyk/IoE1oyrf3YyFZw2qTjRGtvAuEKni5GLQ0jgLKPE
 tUuT2CCcnUwS21tesUI4exgl7r9pZ+5i5ORgE9CUeNa5AMwWEZCQ6Gh4yw5iMwuoSyyf9IsJx
 BYWiJG43djM0sXIwcEioCqx7kUdSJhXwFNi/b7jYCUSAgoSUx6+Z4aIC0qcnPmEBWKMhMTBFy
 +YIWoUJS51fGOEsCskZs1qg+pVk7h6bhPzBEb+WUjaZyFpX8DItIrRLqkoMz2jJDcxM0fX0MB
 A19DQVNfMQtfQxFgvsUo3US+1VDc5Na+kKBEorZdYXqyXWlysV1yZm5yTopeXWrKJERiaKcUu
 /TsY7/f91DvEKMnBpCTKO6vtXqIQX1J+SmVGYnFGfFFpTmrxIUYZDg4lCV67ZqCcYFFqempFW
 mYOME5g0hIcPEoivNkgrbzFBYm5xZnpEKlTjLoczZOWb2cWYsnLz0uVEufNBSkSACnKKM2DGw
 GL2UuMslLCvIwMDAxCPAWpRbmZJajyrxjFORiVhHk9QabwZOaVwG16BXQEE9ARyRy3QY4oSUR
 ISTUwOcacfFW35Z/o8r0B+WobbT+dq86ccF/8V5dImv+JgMbNL7xWvqvRZmvQt134SWef76uf
 4vd7DbYKcT2SP7Vrk8zjintrTgfedHY2SX9dNvHFqyrzZ6o3VT30ylu37d1aaDvzdcGt2QIN3
 FEbNnxQ/RHA6jj3VOtKqaL4kv37lszyt3gkaHn4fWnXv90bN9+9st80p8b+9Irl5d0ndOsuXh
 fKzDsuEeyoEixWGNHA4nRVJ6JW/sea8FrBXYueGX9V45T8eHxPa5fZN5/dl1cUvL+b2bU6zkX
 AYmmmZdt5c/+Vnd3uHh3ljI7vr9jLqa90XtOakyDZuy7mVlvXEpNbB87Xize4yx8rejPh3Z0H
 SizFGYmGWsxFxYkAuXCrRlQDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-7.tower-532.messagelabs.com!1641973653!77796!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 16701 invoked from network); 12 Jan 2022 07:47:34 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-7.tower-532.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 12 Jan 2022 07:47:34 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id A15FD10044F
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 07:47:33 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 94945100446
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 07:47:33 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Wed, 12 Jan 2022 07:47:31 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 12 Jan 2022 15:48:09 +0800
Message-ID: <1641973691-22981-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 1/3] syscalls/quotactl09: Test error when quota
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

This case is similar to quotactl06 but only some differences
1) use quotactl and quotactl_fd syscalls without visible quota file
2) remove some error for addr argument
3) test external_fd for quotactl_fd for EINVAL error when using Q_QUOTAON
4) add error case description when running

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/quotactl/.gitignore |   1 +
 .../kernel/syscalls/quotactl/quotactl09.c     | 195 ++++++++++++++++++
 3 files changed, 197 insertions(+)
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
index 000000000..79f506bdc
--- /dev/null
+++ b/testcases/kernel/syscalls/quotactl/quotactl09.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
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
+ * - EINVAL when cmd is Q_QUOTAON, but the fd refers to a regular file(doesn't
+ *   under this moutpoint)
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
+static int getnextquota_nsup, external_fd = -1;
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
+	int use_external_fd;
+	char *des;
+} tcases[] = {
+	{QCMD(Q_SETQUOTA, USRQUOTA), &fmt_id, NULL, EFAULT, 1, 0,
+	"EFAULT when addr or special is invalid"},
+
+	{QCMD(OPTION_INVALID, USRQUOTA), &fmt_id, NULL, EINVAL, 0, 0,
+	"EINVAL when cmd or type is invalid"},
+
+	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, NULL, ENOTBLK, 0, 0,
+	"ENOTBLK when special is not a block device"},
+
+	{QCMD(Q_SETQUOTA, USRQUOTA), &test_id, &set_dqmax, ERANGE, 1, 0,
+	"ERANGE when cmd is Q_SETQUOTA, but the specified limits are out of the range"},
+
+	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, NULL, EPERM, 0, 0,
+	"EPERM when the caller lacked the required privilege for specified operations"},
+
+	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, NULL, EINVAL, 0, 1,
+	"EINVAL when cmd is Q_QUOTAON, but the fd refers to a regular file(doesn't under "
+	"this mountpoint)"}
+};
+
+static void verify_quotactl(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	int quota_on = 0;
+	int drop_flag = 0;
+
+	tst_res(TINFO, "Testing %s", tc->des);
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
+	} else {
+		if (tc->use_external_fd) {
+			tst_res(TCONF, "quotactl() doesn't use fd, skip");
+			return;
+		}
+	}
+	if (tc->exp_err == ENOTBLK)
+		TST_EXP_FAIL(do_quotactl(fd, tc->cmd, "/dev/null", *tc->id, tc->addr),
+			ENOTBLK, "do_quotactl()");
+	else
+		TST_EXP_FAIL(do_quotactl(tc->use_external_fd ? external_fd : fd, tc->cmd,
+			tst_device->dev, *tc->id, tc->addr), tc->exp_err, "do_quotactl()");
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
+	external_fd = SAFE_CREAT("testfile", O_RDONLY);
+
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
+	if (external_fd > -1)
+		SAFE_CLOSE(external_fd);
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
