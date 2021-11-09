Return-Path: <SRS0=8di7=P4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487F1C433EF
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:54:53 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA68861054
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CA68861054
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 55A0A3C07BF
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 11:54:51 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7CBBF3C06DC
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 11:54:41 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9A33D10006D0
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 11:54:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1636455279; i=@fujitsu.com;
 bh=Gz/ASBTAe7RKswUMVKG9crFoh2DTqNTzQPRtFHHOHtw=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=nTS3Eg2CI7FfvTf6FXG5oWAs9A09DAqHDlGUFd5bFL9ke69l3E+8ccYXwofdDmvQp
 +2dQI2rvMcapyplQpIm9zcrcahybovACEBKFStft/jBedXnO2DiDuCQ4t+07B8Q0Bd
 YsH6IwGkmO1Qx+sk4Q4r0rShFAvXNNkGCd1NE6i+2mkMeMk3GL9Bzwy+8OhC/8aApb
 /GUqvojPCxK33WMOgoKVj4s1dmNLhnldqAMyLPzP7PCtBXwXH/oBDiZ3r7T6h8s/r0
 q2xLbKhRJ0UWK5FzwbzAXOkghJ0ZPBDuQVIFLIkceo9JNLIoLgSNKHUoPtuOkAsVI3
 kMwAUN+O9U8wA==
Received: from [100.115.35.109] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-a.eu-west-2.aws.ess.symcld.net id 3E/76-01854-F635A816;
 Tue, 09 Nov 2021 10:54:39 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRWlGSWpSXmKPExsViZ8ORqJsf3JV
 o0P6P12LF9x2MDowe+36vYw1gjGLNzEvKr0hgzeg5MZOlYFtAxZEmvQbGzy5djFwcQgJnGSWW
 9S9mhnB2Mklc+vqbCcLZzShx7+4v1i5GTg42AU2JZ50LmEFsEQEJiY6Gt+wgNrOAusTySb+YQ
 GxhgSSJhmlz2UBsFgEViVt7d4D18gp4SEx68wWsRkJAQWLKw/dgczgFPCX2XvjPAmILAdXcmn
 YSql5Q4uTMJywQ8yUkDr54wQzRqyhxqeMbI4RdITFrVhvUTDWJq+c2MU9gFJyFpH0WkvYFjEy
 rGK2TijLTM0pyEzNzdA0NDHQNDU11jc10Dc0t9BKrdBP1Ukt1y1OLS3SN9BLLi/VSi4v1iitz
 k3NS9PJSSzYxAsM4pVhl0w7GH5e+6R1ilORgUhLlvSzWlSjEl5SfUpmRWJwRX1Sak1p8iFGGg
 0NJgjfBHygnWJSanlqRlpkDjCmYtAQHj5IIr54PUJq3uCAxtzgzHSJ1itGYY+fReYuYOd79XL
 yIWYglLz8vVUqc93UgUKkASGlGaR7cIFisX2KUlRLmZWRgYBDiKUgtys0sQZV/xSjOwagkzPs
 JZApPZl4J3L5XQKcwAZ1y8Es7yCkliQgpqQam1Ob492LHJ9wTY4g42Cr399uynMp7jE+fLLXa
 wbFOboGNg9ez1PK+dU5Bm97msr6+yih6rpzjh414jFm5npC2bE2qQvYnlmNH+ngt+NNeHcvnZ
 mk6+LL6Nf+BzLpkm2k6f+Ys5tsXL3dVKmrDpe/TZx5Ynh35u+jpilx71eiz3z5IKPtvmefaOz
 0vXu44f0uyO/8Pj83Cf2Y9uzDRcI+s4KFks2/sEpO3pSi06e06fvLWDGYhC66973bHlOioRBz
 MlF3J8o719YMPPzvZXqoby+vda5yx26StxVNJf0l+ysR/3IV7NgvkHu3TaT4XeLvt7fmdLy+v
 CVH+5iARVs0+89ahpX97Q8Jj1mhMLLioxFKckWioxVxUnAgARS4QWnADAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-15.tower-565.messagelabs.com!1636455279!345450!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 29012 invoked from network); 9 Nov 2021 10:54:39 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-15.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 9 Nov 2021 10:54:39 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id C28D2100234
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 10:54:38 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id A356D10024A
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 10:54:38 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.24; Tue, 9 Nov 2021 10:54:34 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 9 Nov 2021 18:54:43 +0800
Message-ID: <1636455285-8372-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1636455285-8372-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1636455285-8372-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 07/12] syscalls/quotactl08: Test quoatctl01 but
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

It also needs mkfs.ext4 supports quota feature.  This feature is disabled[1]
before e2fsprog 1.42 when not specifying a --enable-quota option in compile-time
and e2fsprog 1.43 remove this disable[2]. So we should limit the e2fsprog to 1.43.
The e2fsprog version check will move to ltp lib when this patchset is merged.

[1]https://ext4.wiki.kernel.org/index.php/Quota
[2]https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/commit/?h=v1.43&id=9e8fcd6e

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/quotactl/.gitignore |   1 +
 .../kernel/syscalls/quotactl/quotactl08.c     | 233 ++++++++++++++++++
 .../syscalls/quotactl/quotactl_syscall_var.h  |  32 +++
 4 files changed, 267 insertions(+)
 create mode 100644 testcases/kernel/syscalls/quotactl/quotactl08.c
 create mode 100644 testcases/kernel/syscalls/quotactl/quotactl_syscall_var.h

diff --git a/runtest/syscalls b/runtest/syscalls
index 1e6d46744..583455629 100644
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
index 000000000..c4a226c51
--- /dev/null
+++ b/testcases/kernel/syscalls/quotactl/quotactl08.c
@@ -0,0 +1,233 @@
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
+#include <stdio.h>
+#include "tst_test.h"
+#include "quotactl_syscall_var.h"
+#include "tst_safe_stdio.h"
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
+	FILE *f;
+	const char *const fs_opts[] = { "-O quota", NULL};
+	int rc, major, minor, patch;
+
+	quotactl_info();
+	f = SAFE_POPEN("mkfs.ext4 -V 2>&1", "r");
+	rc = fscanf(f, "mke2fs %d.%d.%d", &major, &minor, &patch);
+	if (rc != 3)
+		tst_res(TWARN, "Unable parse version number");
+	else if (major * 10000 + minor * 100 + patch < 14300)
+		tst_brk(TCONF, "Test needs mkfs.ext4 >= 1.43 for quota option, test skipped");
+	pclose(f);
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
