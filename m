Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3BAC433EF
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 12:27:09 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BE5F60EDF
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 12:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8BE5F60EDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3BBDE3C6AA8
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 14:27:07 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1DE313C6866
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 14:26:33 +0200 (CEST)
Received: from mail1.bemta26.messagelabs.com (mail1.bemta26.messagelabs.com
 [85.158.142.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 17EED1400063
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 14:26:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1635337592; i=@fujitsu.com;
 bh=OAy5b8Tz9i+ylS+7JHqrYof7ThlmXtRyiSk9109cVus=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=fl35vJLuVJB9H7bX8K7ukV0sYDDV2q52IWy6cHo+jLyi/QTdNnlEogIPeeaHzdOt8
 FLM/3w79M/Bk/qRuV7RBdrXQq7Vi17t8pkhpUKwQdMyhRZZpOUP1dDaFDRq9W/T/BR
 WutIGB1nINrkHXx//x2TdsYTSs4BDtXc//EoBL/537VdQGD8+SHnqRvxiOcZA924a4
 CnS0IbTZCQuJox3lUvtldRfSmk7idz/kNo5vZlVCds8fukm9dp0AuxhbJ8icXyDz8b
 hyxdI9H8BRKsCqwfC5lxVQKCfOepS9u6CeGBAHgCFxdbZVjQQdmBWSorjYu1jtxHd4
 QcRhcLPNXNTug==
Received: from [100.113.0.18] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-a.eu-central-1.aws.symcld.net id 2F/2C-15394-87549716;
 Wed, 27 Oct 2021 12:26:32 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRWlGSWpSXmKPExsViZ8ORqFvuWpl
 o0HLCymLF9x2MDowe+36vYw1gjGLNzEvKr0hgzTg1YS9jwTGLil83vzM1ME7U72Lk4hASOMso
 0bhgPRuEs5NJYsWCNVDOHkaJW5PXMXcxcnKwCWhKPOtcAGaLCEhIdDS8ZQexmQXUJZZP+sUEY
 gsLeElcndMFVsMioCrxpHEWC4jNK+Ah0f5nPVi9hICCxJSH75kh4oISJ2c+YYGYIyFx8MULZo
 gaRYlLHd8YIewKiVmz2pggbDWJq+c2MU9g5J+FpH0WkvYFjEyrGC2TijLTM0pyEzNzdA0NDHQ
 NDY11jXSNDM30Eqt0E/VSS3WTU/NKihKBsnqJ5cV6xZW5yTkpenmpJZsYgUGZUsh0Ywfjt9cf
 9A4xSnIwKYnyBuhUJgrxJeWnVGYkFmfEF5XmpBYfYpTh4FCS4D3jCJQTLEpNT61Iy8wBRghMW
 oKDR0mE1xAkzVtckJhbnJkOkTrFqCglzsvhApQQAElklObBtcGi8hKjrJQwLyMDA4MQT0FqUW
 5mCar8K0ZxDkYlYV57Z6ApPJl5JXDTXwEtZgJazKxUAbK4JBEhJdXA5FR46SPPWqHu/ZrzK9j
 2/Jr56KjMHy/nG0XhfHfi+I4/eGBUayOh6i4dwR0dY/R745la/V8NHx/82dbcKf/L7YSEidbq
 XzKWcoVzHoUtFXR9qe3zQiHq+4ayLReinq5etksh3GPOl6eLgx7eOWVYuFThX3nbj09VFj1Xt
 r7MT58hsFXI6ILnjrs+Ir07V6tW/bzn+b0j/EqwrE3E8cvrphqqxbwWDK95eeqd89yUwqNqSW
 yvas/ZBp3a53Hk9xnJZFXJ6EXPi2YwijO+nF7VJ6zXaybp+CHCkcWg4c2LLyHTy+e563X8YEy
 /wqHy2fDJyonrBeYdVtN0VBKw/j1zwswrpUxyf/dNyPLWSG+qVmIpzkg01GIuKk4EAMRo+QRF
 AwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-10.tower-228.messagelabs.com!1635337591!159206!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 29123 invoked from network); 27 Oct 2021 12:26:31 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-10.tower-228.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 27 Oct 2021 12:26:31 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 6D082100243
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 13:26:31 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 61870100231
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 13:26:31 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.24; Wed, 27 Oct 2021 13:26:15 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 27 Oct 2021 20:25:57 +0800
Message-ID: <1635337569-4634-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 01/13] syscalls/quotactl01: Also test with vfsv1
 format
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

Since usrquota and groupquota supports visible quota files
with two formats(vfsv0 and vfsv1) on ext4, so add a test variants to
test it.

Also fix docparse formatting and move some code to lapi/quotactl.h or
quotactl_var.h for reuse.

Remove useless geteuid.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/lapi/quotactl.h                       |  9 +++
 .../kernel/syscalls/quotactl/quotactl01.c     | 79 +++++++++----------
 .../syscalls/quotactl/quotactl_fmt_var.h      | 22 ++++++
 3 files changed, 70 insertions(+), 40 deletions(-)
 create mode 100644 testcases/kernel/syscalls/quotactl/quotactl_fmt_var.h

diff --git a/include/lapi/quotactl.h b/include/lapi/quotactl.h
index c1ec9d6e1..8e0315d03 100644
--- a/include/lapi/quotactl.h
+++ b/include/lapi/quotactl.h
@@ -8,6 +8,7 @@
 #ifndef LAPI_QUOTACTL_H__
 #define LAPI_QUOTACTL_H__
 
+#include "config.h"
 #include <sys/quota.h>
 
 #ifdef HAVE_STRUCT_IF_NEXTDQBLK
@@ -75,4 +76,12 @@ struct fs_quota_statv {
 # define Q_GETNEXTQUOTA 0x800009 /* get disk limits and usage >= ID */
 #endif
 
+#ifndef QFMT_VFS_V0
+# define QFMT_VFS_V0 2
+#endif
+
+#ifndef QFMT_VFS_V1
+# define QFMT_VFS_V1 4
+#endif
+
 #endif /* LAPI_QUOTACTL_H__ */
diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
index 56146b595..7a71dd5fc 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl01.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
@@ -1,57 +1,47 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Crackerjack Project., 2007
- * Copyright (c) 2016-2019 FUJITSU LIMITED. All rights reserved
+ * Copyright (c) 2016-2021 FUJITSU LIMITED. All rights reserved
  * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ * This testcases checks that quotactl(2) on ext4 filesystem succeeds to:
  *
- * This testcase checks the basic flag of quotactl(2) for non-XFS filesystems:
- * 1) quotactl(2) succeeds to turn on quota with Q_QUOTAON flag for user.
- * 2) quotactl(2) succeeds to set disk quota limits with Q_SETQUOTA flag
- *    for user.
- * 3) quotactl(2) succeeds to get disk quota limits with Q_GETQUOTA flag
- *    for user.
- * 4) quotactl(2) succeeds to set information about quotafile with Q_SETINFO
- *    flag for user.
- * 5) quotactl(2) succeeds to get information about quotafile with Q_GETINFO
- *    flag for user.
- * 6) quotactl(2) succeeds to get quota format with Q_GETFMT flag for user.
- * 7) quotactl(2) succeeds to update quota usages with Q_SYNC flag for user.
- * 8) quotactl(2) succeeds to get disk quota limit greater than or equal to
- *    ID with Q_GETNEXTQUOTA flag for user.
- * 9) quotactl(2) succeeds to turn off quota with Q_QUOTAOFF flag for user.
- * 10) quotactl(2) succeeds to turn on quota with Q_QUOTAON flag for group.
- * 11) quotactl(2) succeeds to set disk quota limits with Q_SETQUOTA flag
- *     for group.
- * 12) quotactl(2) succeeds to get disk quota limits with Q_GETQUOTA flag
- *     for group.
- * 13) quotactl(2) succeeds to set information about quotafile with Q_SETINFO
- *     flag for group.
- * 14) quotactl(2) succeeds to get information about quotafile with Q_GETINFO
- *     flag for group.
- * 15) quotactl(2) succeeds to get quota format with Q_GETFMT flag for group.
- * 16) quotactl(2) succeeds to update quota usages with Q_SYNC flag for group.
- * 17) quotactl(2) succeeds to get disk quota limit greater than or equal to
- *     ID with Q_GETNEXTQUOTA flag for group.
- * 18) quotactl(2) succeeds to turn off quota with Q_QUOTAOFF flag for group.
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
  */
 
-#include "config.h"
 #include <errno.h>
 #include <string.h>
 #include <unistd.h>
 #include <stdio.h>
-#include "lapi/quotactl.h"
 #include "tst_test.h"
+#include "quotactl_fmt_var.h"
 
-#ifndef QFMT_VFS_V0
-# define QFMT_VFS_V0	2
-#endif
 #define USRPATH MNTPOINT "/aquota.user"
 #define GRPPATH MNTPOINT "/aquota.group"
-#define FMTID	QFMT_VFS_V0
 #define MNTPOINT	"mntpoint"
 
-static int32_t fmt_id = FMTID;
+static int32_t fmt_id;
 static int test_id;
 static char usrpath[] = USRPATH;
 static char grppath[] = GRPPATH;
@@ -163,11 +153,12 @@ static struct tcase {
 
 static void setup(void)
 {
-	const char *const cmd[] = {"quotacheck", "-ugF", "vfsv0", MNTPOINT, NULL};
+	const char *const cmd[] = {"quotacheck", "-ugF", fmt_variants[tst_variant].fmt_name, MNTPOINT, NULL};
 
+	tst_res(TINFO, "quotactl() with %s format", fmt_variants[tst_variant].fmt_name);
 	SAFE_CMD(cmd, NULL, NULL);
+	fmt_id = fmt_variants[tst_variant].fmt_id;
 
-	test_id = geteuid();
 	if (access(USRPATH, F_OK) == -1)
 		tst_brk(TFAIL | TERRNO, "user quotafile didn't exist");
 
@@ -182,6 +173,12 @@ static void setup(void)
 		getnextquota_nsup = 1;
 }
 
+static void cleanup(void)
+{
+	SAFE_UNLINK(USRPATH);
+	SAFE_UNLINK(GRPPATH);
+}
+
 static void verify_quota(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
@@ -223,12 +220,14 @@ static struct tst_test test = {
 	.test = verify_quota,
 	.tcnt = ARRAY_SIZE(tcases),
 	.mount_device = 1,
-	.dev_fs_type = "ext4",
 	.mntpoint = MNTPOINT,
+	.dev_fs_type = "ext4",
 	.mnt_data = "usrquota,grpquota",
 	.needs_cmds = (const char *const []) {
 		"quotacheck",
 		NULL
 	},
 	.setup = setup,
+	.cleanup = cleanup,
+	.test_variants = QUOTACTL_FMT_VARIANTS,
 };
diff --git a/testcases/kernel/syscalls/quotactl/quotactl_fmt_var.h b/testcases/kernel/syscalls/quotactl/quotactl_fmt_var.h
new file mode 100644
index 000000000..cb9fa4625
--- /dev/null
+++ b/testcases/kernel/syscalls/quotactl/quotactl_fmt_var.h
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+#ifndef LTP_QUOTACTL_FMT_VAR_H
+#define LTP_QUOTACTL_FMT_VAR_H
+
+#include "lapi/quotactl.h"
+
+#define QUOTACTL_FMT_VARIANTS 2
+
+static struct quotactl_fmt_variant {
+	int32_t fmt_id;
+	const char *fmt_name;
+} fmt_variants[] = {
+	{.fmt_id = QFMT_VFS_V0, .fmt_name = "vfsv0"},
+	{.fmt_id = QFMT_VFS_V1, .fmt_name = "vfsv1"}
+};
+
+#endif /* LAPI_QUOTACTL_FMT_VAR_H__ */
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
