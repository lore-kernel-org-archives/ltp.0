Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5453BC433F5
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 12:30:19 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4A8760F5A
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 12:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D4A8760F5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 907D33C69EB
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 14:30:17 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 50EC93C004E
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 14:29:57 +0200 (CEST)
Received: from mail1.bemta26.messagelabs.com (mail1.bemta26.messagelabs.com
 [85.158.142.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 63874140173D
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 14:29:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1635337795; i=@fujitsu.com;
 bh=nVHd/UsR/I3lr88HG1SKSKSTFgTCPaiqKvzEzrZ+hqA=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=EV55UPNaefJegfM6oCrrO9a8oTu5JIm6QEBV0pcAVWnMoWJMXUuayuwdWrN1cc/k1
 epfANcYY/jZfHTPs1vKKHY54M0o5uyxF399Ls4twfEUhJzpLADbPjAU50AW00sB1q7
 zSCgl1FtfQBPCw86/oNJ8s9TC1XQfPzoNEDmkBY8LNsh/5Oqox5ayo+YNaXmu+Vn67
 U2DHYnH3Bz6nepH4M1tZl6JvD6UsdR47k1/STrMUGGVcKBv1G5YVObvn/i/tSPt2o0
 GmYnuBgQmASH4eRQLb8OB8S2nmaQXFIN7LBtfE5O5zBhBuvNPnm5XsnOdlncIKwjyL
 Ch3WzSi1TPQOQ==
Received: from [100.113.3.109] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-4.bemta.az-a.eu-central-1.aws.symcld.net id FE/2B-09980-34649716;
 Wed, 27 Oct 2021 12:29:55 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRWlGSWpSXmKPExsViZ8MxSdfZrTL
 RYOUtdosV33cwOjB67Pu9jjWAMYo1My8pvyKBNePJnlXsBat0Ko58/8nYwDhftYuRi0NI4Cyj
 xK/NF1ggnJ1MEntm9rB1MXICOXsYJW5vqQex2QQ0JZ51LmAGsUUEJCQ6Gt6yg9jMAuoSyyf9Y
 gKxhQXiJP7//sDYxcjBwSKgKrGoKxskzCvgIfHu12awcgkBBYkpD9+DjeEU8JTov3KKGaRcCK
 im6WUJRLmgxMmZT1ggpktIHHzxghmiVVHiUsc3Rgi7QmLWrDYmCFtN4uq5TcwTGAVnIWmfhaR
 9ASPTKkbLpKLM9IyS3MTMHF1DAwNdQ0NjXSBpaqiXWKWbqJdaqpucmldSlAiU1UssL9YrrsxN
 zknRy0st2cQIDN+UQobpOxjXvPmgd4hRkoNJSZQ3QKcyUYgvKT+lMiOxOCO+qDQntfgQowwHh
 5IEb6YLUE6wKDU9tSItMwcYSzBpCQ4eJRHeHFegNG9xQWJucWY6ROoUoy5H86Tl25mFWPLy81
 KlxHmVQYoEQIoySvPgRsDi+hKjrJQwLyMDA4MQT0FqUW5mCar8K0ZxDkYlYd4okCk8mXklcJt
 eAR3BBHQEs1IFyBEliQgpqQYmln+1qzI/BS3gu/Dw9XvWjHs1J1N9az1Pn92fYpVy+fbM/Fnf
 VvE9OjEn9/eGztITTXr39oQYf2lKPtrxNWobxyQfxc/a28uUfZL+GMk6M61YL1qzUk7u9O43C
 1bt6bO5tPratZW6LurbWHRldJdzNKzQe9/U8cq53EthnvvGddtuvrmtv1OHb6re7L8Nkjc55D
 7Up4bf6gz6fGsev/4qiapT4a/YpOMuz5lncMNrc+sb7qW+sie7xXSdv58+1zWHSSVdXsHvz9K
 Ps4+8VVTL5F1VX7zz5tRg+6O7Nz+p4F7xP6bb6Nnli5rvV4TG9Rdd2M1460C0/aRc6cnn/V52
 LP4Sc8986RYzfv/tl+buLVBiKc5INNRiLipOBABvjq4TZgMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-7.tower-232.messagelabs.com!1635337794!684230!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 23685 invoked from network); 27 Oct 2021 12:29:55 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-7.tower-232.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 27 Oct 2021 12:29:55 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 971EE100464
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 13:29:54 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 8978010044C
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 13:29:54 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.24; Wed, 27 Oct 2021 13:29:35 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 27 Oct 2021 20:29:28 +0800
Message-ID: <1635337770-4889-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1635337770-4889-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1635337770-4889-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 11/13] syscalls/quotactl09: Test error when quota
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
 .../kernel/syscalls/quotactl/quotactl09.c     | 171 ++++++++++++++++++
 3 files changed, 173 insertions(+)
 create mode 100644 testcases/kernel/syscalls/quotactl/quotactl09.c

diff --git a/runtest/syscalls b/runtest/syscalls
index cdeb3e142..c8df80fa0 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1074,6 +1074,7 @@ quotactl05 quotactl05
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
index 000000000..1a3a7005d
--- /dev/null
+++ b/testcases/kernel/syscalls/quotactl/quotactl09.c
@@ -0,0 +1,171 @@
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
+ */
+
+#include <errno.h>
+#include <sys/quota.h>
+#include "tst_test.h"
+#include "tst_capability.h"
+#include "quotactl_syscall_var.h"
+#include "tst_safe_stdio.h"
+
+#define OPTION_INVALID 999
+#define MNTPOINT "mntpoint"
+#define TESTFILE MNTPOINT "/testfile"
+
+static int32_t fmt_id = QFMT_VFS_V1;
+static int test_id, fd = -1;
+static int getnextquota_nsup;
+
+static struct if_nextdqblk res_ndq;
+
+static struct dqblk set_dqmax = {
+	.dqb_bsoftlimit = 0x7fffffffffffffffLL,  /* 2^63-1 */
+	.dqb_valid = QIF_BLIMITS
+};
+
+struct tst_cap dropadmin = {
+	.action = TST_CAP_DROP,
+	.id = CAP_SYS_ADMIN,
+	.name = "CAP_SYS_ADMIN",
+};
+
+struct tst_cap needadmin = {
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
+
+	quotactl_info();
+	fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, 0644);
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
+	.dev_fs_opts = (const char *const []){"-O", "quota", NULL},
+	.mntpoint = MNTPOINT,
+	.mount_device = 1,
+	.needs_root = 1,
+	.test_variants = QUOTACTL_SYSCALL_VARIANTS,
+};
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
