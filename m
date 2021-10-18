Return-Path: <SRS0=Jxr4=PG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B13DC433EF
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 13:10:18 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 917AE6103C
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 13:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 917AE6103C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B51A3C304F
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 15:10:15 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 324BD3C2287
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 15:10:05 +0200 (CEST)
Received: from mail3.bemta25.messagelabs.com (mail3.bemta25.messagelabs.com
 [195.245.230.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 304F5600C97
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 15:10:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1634562604; i=@fujitsu.com;
 bh=kIZW5k8aRbcpAwjCCQS3kLTAUI66dca+/hfZW9RS73Q=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=ndS/IvaIIRvHwQzVXWqXaSYua5X7T0q8a90p8taYJHqVLbt13YKDpfGNJrf4LGdyg
 3F1+H5EwU868tBGAIT5t3sbevGE1j66w+AirNa0fPpbfbt92ZubQThNHPHbU+yX3g3
 4J6+dYuxdNfLTPhJwK5ph891JPjgiOIfJcgiu0RRABm4aCQVlEPLw452FOLo331fhg
 06WZv7B+JAC0EAyixncezAFR6JOQQiCTM1xh6htw4WaVRCyYR7RteiKWVQLjYAMK6C
 BaVKX/+EKktH7BW9mTbB0uGicdKYe6XkPR8v+sACWbEAkanieYgYXkN9HuRqH6//Zi
 bhVmpQXK5Hywg==
Received: from [100.112.196.227] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-4.bemta.az-b.eu-west-1.aws.symcld.net id 7C/36-17571-C227D616;
 Mon, 18 Oct 2021 13:10:04 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRWlGSWpSXmKPExsViZ8MxVVe7KDf
 R4N49Y4sV33cwOjB67Pu9jjWAMYo1My8pvyKBNWPeG9OCLVoVL0/WNzDeUepi5OIQEmhhkjjw
 +BA7hLOHUeLoytmMXYycHGwCmhLPOhcwg9giAhISHQ1v2UFsZgF1ieWTfjF1MXJwCAt4Scy9W
 QpisgioSjzpKQCp4BXwkJhw5x0biC0hoCAx5eF7Zoi4oMTJmU9YIKZISBx88YIZokZR4lLHN0
 YIu0Ji1qw2pgmMvLOQtMxC0rKAkWkVo0VSUWZ6RkluYmaOrqGBga6hoZGuoaWFrqGFmV5ilW6
 SXmqpbnlqcYmuoV5iebFecWVuck6KXl5qySZGYGClFBzbtYPx7esPeocYJTmYlER5+5VyE4X4
 kvJTKjMSizPii0pzUosPMcpwcChJ8J7OB8oJFqWmp1akZeYAgxwmLcHBoyTCW1UIlOYtLkjML
 c5Mh0idYlSUEudlLQBKCIAkMkrz4NpgkXWJUVZKmJeRgYFBiKcgtSg3swRV/hWjOAejkjBvNM
 h4nsy8Erjpr4AWMwEtvuqcA7K4JBEhJdXApMCbx/D/z9cV87qFepRaJA5wlU9L3f78nz/rsbd
 /vhqz8DBUXp2Rzvyr4WDYprrLGonHzL8oZuTkmAn1pfFluu6/8/y0h0pEQFbFrVMvNv5cHrBg
 Rt3GoF1rmWc6MaWaT7+T/bDpwoJohze7Hb5aG+aduGP02OuAsttHL8a+TzGq+fEX3Xo/fH/2s
 vWn9WPXu35/wg126qsx3bvpuX4Pf/kvg/sdewOenw/hf3GX6XbNYx/hKRbinsmbexX9dgQlL0
 rQ0Vbwl/+6pPujWfDtiMh5FWwTfu2/qVfq4ifPIRHf3iigaMWhrtxQs2tOcW5nya8Vr1Skj77
 7yHbtmuV73mrNCcLvMpO9J09LfblQiaU4I9FQi7moOBEA0LnnNScDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-4.tower-285.messagelabs.com!1634562603!387249!1
X-Originating-IP: [62.60.8.149]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21946 invoked from network); 18 Oct 2021 13:10:03 -0000
Received: from unknown (HELO mailhost2.uk.fujitsu.com) (62.60.8.149)
 by server-4.tower-285.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 18 Oct 2021 13:10:03 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost2.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 19ID9vIu017346
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 14:10:03 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 18 Oct 2021 14:09:56 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 18 Oct 2021 21:09:41 +0800
Message-ID: <1634562591-5830-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 01/11] syscalls/quotactl01: Also test with vfsv1
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

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/lapi/quotactl.h                       |  8 +++
 .../kernel/syscalls/quotactl/quotactl01.c     | 67 +++++++++++++++----
 2 files changed, 61 insertions(+), 14 deletions(-)

diff --git a/include/lapi/quotactl.h b/include/lapi/quotactl.h
index c1ec9d6e1..348b70b58 100644
--- a/include/lapi/quotactl.h
+++ b/include/lapi/quotactl.h
@@ -75,4 +75,12 @@ struct fs_quota_statv {
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
index 56146b595..4b791a03a 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl01.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
@@ -1,37 +1,60 @@
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
+ * This testcase checks the basic flag of quotactl(2) for non-XFS filesystems
+ * with visible quota files(cover two formats, vfsv0 and vfsv1):
  *
- * This testcase checks the basic flag of quotactl(2) for non-XFS filesystems:
  * 1) quotactl(2) succeeds to turn on quota with Q_QUOTAON flag for user.
- * 2) quotactl(2) succeeds to set disk quota limits with Q_SETQUOTA flag
+ *
+ * 2 quotactl(2) succeeds to set disk quota limits with Q_SETQUOTA flag
  *    for user.
+ *
  * 3) quotactl(2) succeeds to get disk quota limits with Q_GETQUOTA flag
  *    for user.
+ *
  * 4) quotactl(2) succeeds to set information about quotafile with Q_SETINFO
  *    flag for user.
+ *
  * 5) quotactl(2) succeeds to get information about quotafile with Q_GETINFO
  *    flag for user.
+ *
  * 6) quotactl(2) succeeds to get quota format with Q_GETFMT flag for user.
+ *
  * 7) quotactl(2) succeeds to update quota usages with Q_SYNC flag for user.
+ *
  * 8) quotactl(2) succeeds to get disk quota limit greater than or equal to
  *    ID with Q_GETNEXTQUOTA flag for user.
+ *
  * 9) quotactl(2) succeeds to turn off quota with Q_QUOTAOFF flag for user.
+ *
  * 10) quotactl(2) succeeds to turn on quota with Q_QUOTAON flag for group.
+ *
  * 11) quotactl(2) succeeds to set disk quota limits with Q_SETQUOTA flag
  *     for group.
+ *
  * 12) quotactl(2) succeeds to get disk quota limits with Q_GETQUOTA flag
  *     for group.
+ *
  * 13) quotactl(2) succeeds to set information about quotafile with Q_SETINFO
  *     flag for group.
+ *
  * 14) quotactl(2) succeeds to get information about quotafile with Q_GETINFO
  *     flag for group.
+ *
  * 15) quotactl(2) succeeds to get quota format with Q_GETFMT flag for group.
+ *
  * 16) quotactl(2) succeeds to update quota usages with Q_SYNC flag for group.
+ *
  * 17) quotactl(2) succeeds to get disk quota limit greater than or equal to
  *     ID with Q_GETNEXTQUOTA flag for group.
+ *
  * 18) quotactl(2) succeeds to turn off quota with Q_QUOTAOFF flag for group.
  */
 
@@ -43,16 +66,12 @@
 #include "lapi/quotactl.h"
 #include "tst_test.h"
 
-#ifndef QFMT_VFS_V0
-# define QFMT_VFS_V0	2
-#endif
 #define USRPATH MNTPOINT "/aquota.user"
 #define GRPPATH MNTPOINT "/aquota.group"
-#define FMTID	QFMT_VFS_V0
 #define MNTPOINT	"mntpoint"
 
-static int32_t fmt_id = FMTID;
-static int test_id;
+static int32_t fmt_id;
+static int test_id, mount_flag;
 static char usrpath[] = USRPATH;
 static char grppath[] = GRPPATH;
 static struct dqblk set_dq = {
@@ -163,9 +182,22 @@ static struct tcase {
 
 static void setup(void)
 {
-	const char *const cmd[] = {"quotacheck", "-ugF", "vfsv0", MNTPOINT, NULL};
-
-	SAFE_CMD(cmd, NULL, NULL);
+	const char *const vfsv0_cmd[] = {"quotacheck", "-ugF", "vfsv0", MNTPOINT, NULL};
+	const char *const vfsv1_cmd[] = {"quotacheck", "-ugF", "vfsv1", MNTPOINT, NULL};
+
+	SAFE_MKFS(tst_device->dev, tst_device->fs_type, NULL, NULL);
+	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, "usrquota,grpquota");
+	mount_flag = 1;
+
+	if (tst_variant) {
+		tst_res(TINFO, "quotactl() with vfsv1 format");
+		SAFE_CMD(vfsv1_cmd, NULL, NULL);
+		fmt_id = QFMT_VFS_V1;
+	} else {
+		tst_res(TINFO, "quotactl() with vfsv0 format");
+		SAFE_CMD(vfsv0_cmd, NULL, NULL);
+		fmt_id = QFMT_VFS_V0;
+	}
 
 	test_id = geteuid();
 	if (access(USRPATH, F_OK) == -1)
@@ -182,6 +214,12 @@ static void setup(void)
 		getnextquota_nsup = 1;
 }
 
+static void cleanup(void)
+{
+	if (mount_flag && tst_umount(MNTPOINT))
+		tst_res(TWARN | TERRNO, "umount(%s)", MNTPOINT);
+}
+
 static void verify_quota(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
@@ -222,13 +260,14 @@ static struct tst_test test = {
 	},
 	.test = verify_quota,
 	.tcnt = ARRAY_SIZE(tcases),
-	.mount_device = 1,
+	.needs_device = 1,
 	.dev_fs_type = "ext4",
 	.mntpoint = MNTPOINT,
-	.mnt_data = "usrquota,grpquota",
 	.needs_cmds = (const char *const []) {
 		"quotacheck",
 		NULL
 	},
 	.setup = setup,
+	.cleanup = cleanup,
+	.test_variants = 2,
 };
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
