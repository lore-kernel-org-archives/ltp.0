Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FC7C433F5
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 12:29:01 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F45F60F9D
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 12:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3F45F60F9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EBEDF3C69EB
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 14:28:59 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1CA233C67D8
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 14:28:39 +0200 (CEST)
Received: from mail1.bemta25.messagelabs.com (mail1.bemta25.messagelabs.com
 [195.245.230.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6A234601BB5
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 14:28:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1635337717; i=@fujitsu.com;
 bh=dHUO6ffyspW37nExIWHvmgaNGexO1Ometl9NqkLKWo8=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=n/EHAATtCVhXR+J6wK4lhOLfjKPC+TkRcWkK0BM6TntK+q4dMk9H10v9+mIB/wFwo
 Q+1O+hlWsBx+Vb8Fwg3puEfXBHy29OwuVkQGKd2iR6RxJSPMxuyYa5cMx9KKx3SMuV
 EplvoS2qgXYhCCoFSi+q22+TdCylBuNUU2/VKPLWRgffRpegD2thwrkzQIBEB95B8f
 9PBkeuyvBTVTjP55xM+g3igWTv0uleLJ+/TaHJT0pBKC/h/2F8Unqz/3k5CKM05kwX
 o/mztA5zvU6my4ZkzKI9uYYuIaWVgIl28QpllGO0XC0AOSJKq0Ft2pED9v0s1oTgaK
 bHd8LN8EHdDOw==
Received: from [100.112.196.248] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-b.eu-west-1.aws.symcld.net id 76/10-20159-5F549716;
 Wed, 27 Oct 2021 12:28:37 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRWlGSWpSXmKPExsViZ8MRqvvVtTL
 RYMFXVosV33cwOjB67Pu9jjWAMYo1My8pvyKBNePA533sBas8Kma9OMjUwPjXtouRi0NIoIVJ
 4tGd/ewQzh5Gif8n7zB3MXJysAloSjzrXABmiwhISHQ0vGUHsZkF1CWWT/rFBGILCyRJtK+7D
 hZnEVCV2Lb7MCOIzSvgIfFtwVowW0JAQWLKw/dgczgFPCWerNnB0sXIAbTMQ2LW2hKIckGJkz
 OfsECMl5A4+OIFM0SrosSljm9QYyokZs1qY5rAyD8LScssJC0LGJlWMVokFWWmZ5TkJmbm6Bo
 aGOgaGhrpGlqa6RqZmuolVukm6aWW6panFpfoGuollhfrFVfmJuek6OWllmxiBIZjSsGR/zsY
 l7/5oHeIUZKDSUmUN0CnMlGILyk/pTIjsTgjvqg0J7X4EKMMB4eSBG+mC1BOsCg1PbUiLTMHG
 BswaQkOHiUR3hxgfAjxFhck5hZnpkOkTjHqcuw8Om8RsxBLXn5eqpQ4rzJIkQBIUUZpHtwIWJ
 xeYpSVEuZlZGBgEOIpSC3KzSxBlX/FKM7BqCTMGwUyhSczrwRu0yugI5iAjmBWqgA5oiQRISX
 VwLQ+/o5eQs+ntU17tTWUXVQ6DGbxRM+73c8ZWrzDd7qqnOheu8C/qw7FREY+nnqnl9db63FX
 8mrJb5KONo4GtzfEsjTt61KcN1Xb6jmraffMPkX9p9nbLhuITCyQv5ot6la5VpTp38NJR3Mkt
 t7crz9J/KJR48/gtHNPr51+Hj7n95vV99v2qZhKbzLzTvO/smbPiVLf4h7v5aYethY8dXHc98
 6+C7PYfjMwQfv3u/vfnnzpkrLeNtGCj+fk6dS/D/fKV+m/mqCSUb97T+4PNb6Tr884XWXP0o9
 5XWV6LmT/wZu1Wafu3uJcyf4++GUnu9WfJetDz7tKN6062R55a1a5XOrB5JCpScdsPoY+uqbE
 UpyRaKjFXFScCAABHqklTgMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-10.tower-291.messagelabs.com!1635337716!277372!1
X-Originating-IP: [62.60.8.85]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 17766 invoked from network); 27 Oct 2021 12:28:37 -0000
Received: from unknown (HELO mailhost4.uk.fujitsu.com) (62.60.8.85)
 by server-10.tower-291.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 27 Oct 2021 12:28:37 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost4.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 19RCSaxa020340
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 13:28:36 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.24; Wed, 27 Oct 2021 13:28:35 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 27 Oct 2021 20:28:24 +0800
Message-ID: <1635337706-4788-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1635337706-4788-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1635337706-4788-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 07/13] syscalls/quotactl08: Test quoatctl01 but
 quota info hidden in filesystem
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

It also needs mkfs.ext4 supports quota feature.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/quotactl/.gitignore |   1 +
 .../kernel/syscalls/quotactl/quotactl08.c     | 217 ++++++++++++++++++
 .../syscalls/quotactl/quotactl_syscall_var.h  |  29 +++
 4 files changed, 248 insertions(+)
 create mode 100644 testcases/kernel/syscalls/quotactl/quotactl08.c
 create mode 100644 testcases/kernel/syscalls/quotactl/quotactl_syscall_var.h

diff --git a/runtest/syscalls b/runtest/syscalls
index b19316805..cdeb3e142 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1073,6 +1073,7 @@ quotactl04 quotactl04
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
index 000000000..6912378f1
--- /dev/null
+++ b/testcases/kernel/syscalls/quotactl/quotactl08.c
@@ -0,0 +1,217 @@
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
+ */
+
+#include <errno.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdio.h>
+#include "tst_test.h"
+#include "quotactl_syscall_var.h"
+#include "tst_safe_stdio.h"
+
+#define MNTPOINT	"mntpoint"
+#define TESTFILE	MNTPOINT "/testfile"
+
+static int32_t fmt_id = QFMT_VFS_V1;
+static int test_id, fd = -1;
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
+	quotactl_info();
+	fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, 0666);
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
+	.dev_fs_opts = (const char *const []){"-O", "quota", NULL},
+	.mount_device = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_variants = QUOTACTL_SYSCALL_VARIANTS,
+};
diff --git a/testcases/kernel/syscalls/quotactl/quotactl_syscall_var.h b/testcases/kernel/syscalls/quotactl/quotactl_syscall_var.h
new file mode 100644
index 000000000..92a7c45db
--- /dev/null
+++ b/testcases/kernel/syscalls/quotactl/quotactl_syscall_var.h
@@ -0,0 +1,29 @@
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
