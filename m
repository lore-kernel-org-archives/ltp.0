Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF6B9C433F5
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 07:27:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 45ED03C8AA3
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 08:27:31 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E9BFA3C8867
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 08:27:18 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3D3B510005DD
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 08:27:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1639380437; i=@fujitsu.com;
 bh=sAxpeD1RqY4xs1+z2UaqtzvVP5sBwkTTNcCXhoH5+OI=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=H3up8Fjd+97MXzVXwSHro7Z8/b1POnd8QjFzGnxcorIiO2KyQJHjF9aI/rnTU7NEo
 N3U/aOwq7H90aYfaQmXqO1lf1Cu4KvBZNbb5kSZ9ywu3g0ugw3GFmkH3ruijhlhQd8
 /4wucGYAjUHy4WHPHAOQ6iGfY/yQN+ZgbC8Z8CwCg2dD5qTt9cXg61QoXqFuxh+4J/
 ngdQy83O6tZq8bCJNFO6qo2Ns3iI85sxbSZwEGN6QsNzEarV3mTP31jQ/3JPLQmYeB
 6SdA5N9QjR1zlu0u4Sh09rlXNlukeIzrR0eMJBqfv4xpgj7p7fT7raFoXu8rW0j2Rh
 GtNlLZPNcPl5w==
Received: from [100.115.39.64] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-a.eu-west-2.aws.ess.symcld.net id 82/D8-16537-5D5F6B16;
 Mon, 13 Dec 2021 07:27:17 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRWlGSWpSXmKPExsViZ8MxRffK122
 JBpvOWFus+L6D0YHRY9/vdawBjFGsmXlJ+RUJrBm3urcyFezWq2jdupa9gbFFvYuRi0NIoIlJ
 YuOGm6wQzh5GiVONF4AcTg42AU2JZ50LmEFsEQEJiY6Gt+wgNrOAusTySb+YQGxhgRiJC6t/g
 tWwCKhKHHzyC8zmFfCU2PdwApgtIaAgMeXhezCbU8BL4t2F+4wgtpBAksSE1tlMEPWCEidnPm
 GBmC8hcfDFC6heRYlLHd8YIewKiVmz2pgmMPLPQtIyC0nLAkamVYzWSUWZ6RkluYmZObqGBga
 6hoamusYWQMpQL7FKN1EvtVS3PLW4RNdIL7G8WC+1uFivuDI3OSdFLy+1ZBMjMCxTitXydzD+
 XflT7xCjJAeTkijvN8atiUJ8SfkplRmJxRnxRaU5qcWHGGU4OJQkeL2+bEsUEixKTU+tSMvMA
 cYITFqCg0dJhHc1ME6EeIsLEnOLM9MhUqcYdTmaJy3fzizEkpeflyolzvsXZIYASFFGaR7cCF
 i8XmKUlRLmZWRgYBDiKUgtys0sQZV/xSjOwagkzBsAMoUnM68EbtMroCOYgI5grNwMckRJIkJ
 KqoFpuXXvifPBAfP9zc41r3wx+/6X6Rcn1VufYZfP+Hw/IJTpXbXIBsWHos+nMAg/0C98uJ2p
 7inLfJ37Gb5Cn/YdFr36dmnkpJcFcY4d6quY1RatNWRcabLVa+09hVfBa/x4p1c/sH6vlnQn7
 XR2d4PQxV+8rPealrgwP2WzWbVOXNT57379WlbvD9MzLsVO65xl3hGhKnj10S52rUcfuH7vca
 4JYjk5S+mPwTS/2yWvM1TtbarmpJ/Pu9/Lu/bKqr0Nez6miOR/O7fea8OuLf5r2jffe7tzfaD
 qNP2Y66+mrr6s03mndN2c6gss7n5nVe78Xsja/MbLwSdnr/GvS+6tBTY8BzRO/FxvMXXyBN/N
 P5RYijMSDbWYi4oTAa//xvxSAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-13.tower-548.messagelabs.com!1639380436!198468!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 7078 invoked from network); 13 Dec 2021 07:27:16 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
 by server-13.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 13 Dec 2021 07:27:16 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 1BD7RGRm002382
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 07:27:16 GMT
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Mon, 13 Dec 2021 07:27:14 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 13 Dec 2021 15:26:53 +0800
Message-ID: <1639380414-24390-5-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1639380414-24390-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <YY0o7jAxgIHvmczq@yuki>
 <1639380414-24390-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 5/6] syscalls/quotactl09: Test error when quota
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
 .../kernel/syscalls/quotactl/quotactl09.c     | 180 ++++++++++++++++++
 3 files changed, 182 insertions(+)
 create mode 100644 testcases/kernel/syscalls/quotactl/quotactl09.c

diff --git a/runtest/syscalls b/runtest/syscalls
index c795b9101..13a62e4a1 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1072,6 +1072,7 @@ quotactl05 quotactl05
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
index 000000000..c7c485077
--- /dev/null
+++ b/testcases/kernel/syscalls/quotactl/quotactl09.c
@@ -0,0 +1,180 @@
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
+		TEST(do_quotactl(fd, QCMD(Q_QUOTAON, USRQUOTA), tst_device->dev,
+			fmt_id, NULL));
+		if (TST_RET == -1)
+			tst_brk(TBROK,
+				"quotactl with Q_QUOTAON returned %ld", TST_RET);
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
+		TEST(do_quotactl(fd, tc->cmd, "/dev/null", *tc->id, tc->addr));
+	else
+		TEST(do_quotactl(fd, tc->cmd, tst_device->dev, *tc->id, tc->addr));
+
+	if (TST_RET == -1) {
+		if (tc->exp_err == TST_ERR) {
+			tst_res(TPASS | TTERRNO, "quotactl failed as expected");
+		} else {
+			tst_res(TFAIL | TTERRNO,
+				"quotactl failed unexpectedly; expected %s, but got",
+				tst_strerrno(tc->exp_err));
+		}
+	} else {
+		tst_res(TFAIL, "quotactl returned wrong value: %ld", TST_RET);
+	}
+
+	if (quota_on) {
+		TEST(do_quotactl(fd, QCMD(Q_QUOTAOFF, USRQUOTA), tst_device->dev,
+			fmt_id, NULL));
+		if (TST_RET == -1)
+			tst_brk(TBROK,
+				"quotactl with Q_QUOTAOFF returned %ld", TST_RET);
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
