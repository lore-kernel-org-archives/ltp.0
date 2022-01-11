Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B60BC433EF
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 10:28:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5ADF83C93E2
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 11:28:37 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 034E03C90AA
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 11:28:17 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D660310009EB
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 11:28:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1641896895; i=@fujitsu.com;
 bh=Kb4B+OzSIHpzr+YmmYVv3oUTHviquxTf78l0/0orO5w=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=Nqp2SDhe3vMA6VwUgOR4IYCSbf53nMm1ILHDydgEKh+Nd4SXOeHXN+Y/nqh2vyq04
 I+Yl7bYrssKJQHSXzJQa1VJkGr4VlF1Bp35+F8hN4xnlH2mCRbeqWbVzVPST95AMMo
 BXvaWCvnyRa7gx4VEFhSvLA03DfRGhL/ov7DT6VHy39MzwADiPE+KXoSzE5ebhuQd9
 2B1i8qr7qSylRhnmlXto4AhsPGIkUM9BBnKQel0vzulMXU1QOiCz7eWXYKWy0+0eFk
 cncAkVSF9LcFZNfMwSs6lzobVQUiGNPnehP22peA6Eozw3vqFyxDK9Uq5+bf8lty1x
 HeE/djPGUD0ng==
Received: from [100.115.37.212] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-a.eu-west-2.aws.ess.symcld.net id 04/B1-09428-FBB5DD16;
 Tue, 11 Jan 2022 10:28:15 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRWlGSWpSXmKPExsViZ8ORqLs/+m6
 iwYQXghYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa0bLjCOMBZtkKqZNO8rYwHhVoouRk0NI4Cyj
 xPoHUV2MXED2TiaJpTvmMkM4exglLh2YxQJSxSagKfGscwEziC0iICHR0fCWHcRmFlCXWD7pF
 1MXIweHsICnxI0v6SBhFgFVibtvOlhBbF4BD4m7jUvByiUEFCSmPHwPNoYTqLxpXRsjxBEeEq
 dm/WOBqBeUODnzCQvEeAmJgy9eMEP0Kkpc6vjGCGFXSMya1cYEYatJXD23iXkCo+AsJO2zkLQ
 vYGRaxWidVJSZnlGSm5iZo2toYKBraGiqa2ysa2huqZdYpZuol1qqW55aXKJrpJdYXqyXWlys
 V1yZm5yTopeXWrKJERjEKcWKm3cwTlz5U+8QoyQHk5Io78mIu4lCfEn5KZUZicUZ8UWlOanFh
 xhlODiUJHhdQXKCRanpqRVpmTnAiIJJS3DwKInwbgkBSvMWFyTmFmemQ6ROMVpyXL4+bxEzR/
 Ok5duZOV63/NzBLMSSl5+XKiXOOykKqEEApCGjNA9uHCzqLzHKSgnzMjIwMAjxFKQW5WaWoMq
 /YhTnYFQS5rUHmcKTmVcCt/UV0EFMQAclc9wGOagkESEl1cAUrqu2NjbPbqWe/ELFi7smTHwg
 HjJZptd55Vtv54VdXeayf06pyNoU8FsZnCvVmKPloG2z1/XKtLvMWcJ/5fVenc+49z/i4rzm1
 ZYT5ZmmP/QzTLYP8JPbrvl8/hHnLN9ftfu27jllxn1kSUs1z0X93i18em9n61jqvt+9UCB7f0
 PIbJ2C00ErWuPUORhndb3cISPB4S0xy9Qt63PrZeHJsvP2P/RYrl/6KUdlnrTPs81r9/DJirP
 fEs3TWDrvsZbZ7XpTwy/sX2wtndr+qllPZ/g78azFBsOt6eelUoL0mR7FuX/x0JmRfuu3pMrR
 z0pi+/nDtO9xzowNUVTYm/tQ+amza6tOvcwmlfhjX5VYijMSDbWYi4oTAWe8EdB1AwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-15.tower-565.messagelabs.com!1641896895!74520!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21966 invoked from network); 11 Jan 2022 10:28:15 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-15.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 11 Jan 2022 10:28:15 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id CE12C10018C
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 10:28:14 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id C0B91100184
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 10:28:14 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Tue, 11 Jan 2022 10:28:06 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 11 Jan 2022 18:28:38 +0800
Message-ID: <1641896919-5919-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1641896919-5919-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1641896919-5919-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 2/3] syscalls/quotactl07: Add quotactl_fd test
 variant
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

Also man-pages has error that Q_XQUOTARM was not introduced by kernel
3.16[1][2]. So remove detection for this cmd.

Since kernel commit 40b52225e ("xfs: remove support for disabling quota
accounting on a mounted file system")[3] was introduced, if we want to
disable quota account feature before Q_XQUOTARM, we must need to remount
with noquota like xfs maintainer does in xfstests xfs/220 [4].

So , change this by mount with usrquota and remount with noquota to create
a test environment that superblock has quota data but quota feature not running.

[1]https://github.com/alejandro-colomar/man-pages/commit/38bccbcf4f51c5370a1060e6a80b90d68b0dcdc8
[2]https://github.com/alejandro-colomar/man-pages/commit/26f3978f04a1aeeb5397a5facebaef40a341afb6
[3]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=40b52225e58
[4]https://patchwork.kernel.org/project/fstests/patch/20220105195352.GM656707@magnolia/

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 .../kernel/syscalls/quotactl/quotactl07.c     | 43 +++++++++++--------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl07.c b/testcases/kernel/syscalls/quotactl/quotactl07.c
index 2992a6112..ae582d412 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl07.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl07.c
@@ -16,50 +16,57 @@
 #include <stdio.h>
 #include <sys/quota.h>
 #include "tst_test.h"
-#include "lapi/quotactl.h"
+#include "quotactl_syscall_var.h"
 
 #ifdef HAVE_XFS_XQM_H
 # include <xfs/xqm.h>
 
-#define MNTPOINT    "mntpoint"
-
-static uint32_t qflag_acct = XFS_QUOTA_UDQ_ACCT;
-static unsigned int valid_type = XFS_USER_QUOTA;
 /* Include a valid quota type to avoid other EINVAL error */
 static unsigned int invalid_type = XFS_GROUP_QUOTA << 1 | XFS_USER_QUOTA;
+static int mount_flag;
 
 static void verify_quota(void)
 {
-	TEST(quotactl(QCMD(Q_XQUOTARM, USRQUOTA), tst_device->dev, 0, (void *)&invalid_type));
-	if (TST_ERR == EINVAL)
-		tst_res(TPASS, "Q_XQUOTARM has quota type check");
-	else
-		tst_res(TFAIL, "Q_XQUOTARM doesn't have quota type check");
+	TST_EXP_FAIL(do_quotactl(fd, QCMD(Q_XQUOTARM, USRQUOTA), tst_device->dev, 0,
+			(void *)&invalid_type), EINVAL, "do_quotactl(Q_XQUOTARM)");
 }
 
 static void setup(void)
 {
-	TEST(quotactl(QCMD(Q_XQUOTAOFF, USRQUOTA), tst_device->dev, 0, (void *)&qflag_acct));
-	if (TST_RET == -1)
-		tst_brk(TBROK | TTERRNO, "quotactl with Q_XQUOTAOFF failed");
+	quotactl_info();
+
+	/* ensure superblock has quota data, but not running */
+	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, "usrquota");
+	mount_flag = 1;
+	SAFE_UMOUNT(MNTPOINT);
+	mount_flag = 0;
+	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, "noquota");
+	mount_flag = 1;
 
-	TEST(quotactl(QCMD(Q_XQUOTARM, USRQUOTA), tst_device->dev, 0, (void *)&valid_type));
-	if (TST_ERR == EINVAL)
-		tst_brk(TCONF, "current system doesn't support Q_XQUOTARM, skip it");
+	fd = SAFE_OPEN(MNTPOINT, O_RDONLY);
+}
+
+static void cleanup(void)
+{
+	if (fd > -1)
+		SAFE_CLOSE(fd);
+	if (mount_flag && tst_umount(MNTPOINT))
+		tst_res(TWARN | TERRNO, "umount(%s)", MNTPOINT);
 }
 
 static struct tst_test test = {
 	.setup = setup,
+	.cleanup = cleanup,
 	.needs_root = 1,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_XFS_QUOTA",
 		NULL
 	},
 	.test_all = verify_quota,
-	.mount_device = 1,
+	.format_device = 1,
 	.dev_fs_type = "xfs",
-	.mnt_data = "usrquota",
 	.mntpoint = MNTPOINT,
+	.test_variants = QUOTACTL_SYSCALL_VARIANTS,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "3dd4d40b4208"},
 		{}
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
