Return-Path: <SRS0=Jxr4=PG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E121FC433F5
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 13:16:50 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EB2A6103C
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 13:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6EB2A6103C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 698773C2DE2
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 15:16:48 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C443B3C2D54
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 15:16:38 +0200 (CEST)
Received: from mail3.bemta25.messagelabs.com (mail3.bemta25.messagelabs.com
 [195.245.230.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1F3BB1000A05
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 15:16:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1634562997; i=@fujitsu.com;
 bh=vNXb+B1ygmd2G22HvaMiuI0FQuAOF2dBUPmI5c/Grgo=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=QFa8G35mvil5/qqIIZxmk3OhuA/WNpDNzSkZy7+k0nM5yBpyV0skwfglItVsamUZX
 sUP64qQVHtO6fhfw21JjsUtZ8oSf01/Nl5Y+BT+gAsPMxOiNxpIR2IWMT+DMcnVQMM
 rFGKoSQqi56s8Y2x63y1jo1Jt/aDLTb7Gku9NNNTTCsle3gBfBIg2V6Eu7mo0x7qjx
 +4vzuB4nvKVqwQ4FcieYQ/ru0VlvLnDcITxLQzRCuAYVE2LanlP1XW7tBLLZsjIKTT
 jhC1gHUezJDvgd7TJ9TpDY29OAq7ji+9OlrMFNzrZSxUOBrukv+2jQGoCiHdA9EFOE
 9QyTtrHQvS4uA==
Received: from [100.112.197.4] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-b.eu-west-1.aws.symcld.net id 9D/6C-18279-5B37D616;
 Mon, 18 Oct 2021 13:16:37 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRWlGSWpSXmKPExsViZ8MxRXdLcW6
 iweI7uhYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8bqd2+YC9boVlx/95uxgbFVrYuRi0NIoIVJ
 4tzLi+wQzh5Gicm79rN0MXJysAloSjzrXMAMYosISEh0NLxlB7GZBdQllk/6xQRiCwvEScxaM
 xesnkVAVWLjgw1sXYwcHLwCHhJr7ueBhCUEFCSmPHwPNoZXQFDi5MwnLBBjJCQOvnjBDFGjKH
 Gp4xsjhF0hMWtWG9MERt5ZSFpmIWlZwMi0itEiqSgzPaMkNzEzR9fQwEDX0NBI19DSQtfI0FQ
 vsUo3SS+1VLc8tbhE11AvsbxYr7gyNzknRS8vtWQTIzC8UgqOXd/BePX1B71DjJIcTEqivP1K
 uYlCfEn5KZUZicUZ8UWlOanFhxhlODiUJHhP5wPlBItS01Mr0jJzgKEOk5bg4FES4c0qAkrzF
 hck5hZnpkOkTjHqcjRPWr6dWYglLz8vVUqcl7UAqEgApCijNA9uBCzuLjHKSgnzMjIwMAjxFK
 QW5WaWoMq/YhTnYFQS5rUBRrEQT2ZeCdymV0BHMAEdcdU5B+SIkkSElFQD06on26/WPFBZvUF
 F2mFVZ4v4tbdrG/LWfj106Oaaibs3Tr/reJxZe/EbK/9q5b0XZypzuz10MiqtbjzPLH/y/Izr
 G1fFtDo+ZWBfUnpWcF7UF6vwd4m/itoOepwU5DS4PaNxZ/qGDukLa1ZePiybyRfYovkv/N07g
 XOnDOZYKLHvCVPN+aqrLXSr6O9xoyP3NVhjQ5T8/0zimLoh3YHhfMH0PQUBT1rOnt01c6N2Ub
 p877IIn1lfZfY3J3t9+pR/02Ot+28t1wfPk/Z6CO14mXndOoDXh2ldz7rV3SKx+0L7I/808Wo
 9ndUQtaFF/NX1FRs3bebr6di17Bzn7D/rBANWLC1xr94nWFwlLTj13F4lluKMREMt5qLiRABo
 0lpvNgMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-22.tower-285.messagelabs.com!1634562996!297909!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 23369 invoked from network); 18 Oct 2021 13:16:36 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
 by server-22.tower-285.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 18 Oct 2021 13:16:36 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 19IDGaOU026144
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 14:16:36 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 18 Oct 2021 14:16:34 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 18 Oct 2021 21:16:36 +0800
Message-ID: <1634562996-6045-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 11/11] syscalls/quotactl09: Test error when quota
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
 .../kernel/syscalls/quotactl/quotactl09.c     | 179 ++++++++++++++++++
 3 files changed, 181 insertions(+)
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
index 000000000..3276624bc
--- /dev/null
+++ b/testcases/kernel/syscalls/quotactl/quotactl09.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Tests basic error handling of the quotactl syscall without visible quota files
+ * (use quotactl and quotactl_fd syscall):
+ *
+ * 1) quotactl fails with EFAULT when addr or special is invalid.
+ *
+ * 2) quotactl fails with EINVAL when cmd or type is invalid.
+ *
+ * 3) quotactl fails with ENOTBLK when special is not a block device.
+ *
+ * 4) quotactl fails with ERANGE when cmd is Q_SETQUOTA, but the
+ * specified limits are out of the range allowed by the quota format.
+ *
+ * 5) quotactl fails with EPERM when the caller lacked the required
+ * privilege (CAP_SYS_ADMIN) for the specified operation.
+ */
+
+#include <errno.h>
+#include <sys/quota.h>
+#include "tst_test.h"
+#include "lapi/quotactl.h"
+#include "tst_capability.h"
+#include "quotactl_var.h"
+
+#define OPTION_INVALID 999
+#define MNTPOINT "mntpoint"
+#define TESTFILE MNTPOINT "/testfile"
+
+static int32_t fmt_id;
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
+	fmt_id = QFMT_VFS_V1;
+	quotactl_info();
+
+	test_id = geteuid();
+	fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, 0644);
+
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
+	.mntpoint = MNTPOINT,
+	.mount_device = 1,
+	.dev_fs_opts = (const char *const []){"-O", "quota", NULL},
+	.needs_root = 1,
+	.test_variants = 2,
+};
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
