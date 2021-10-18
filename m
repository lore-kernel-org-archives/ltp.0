Return-Path: <SRS0=Jxr4=PG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22389C433EF
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 13:10:37 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 908A86103C
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 13:10:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 908A86103C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 164273C2E5D
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 15:10:35 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C6CA3C2BBF
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 15:10:06 +0200 (CEST)
Received: from mail1.bemta25.messagelabs.com (mail1.bemta25.messagelabs.com
 [195.245.230.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 472E91A00992
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 15:10:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1634562604; i=@fujitsu.com;
 bh=8WHDOuWuKQ3zT7xUIpSTbegZng+Js9OKj+WgLb1eMqo=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type:Content-Transfer-Encoding;
 b=SRnvvw/NSdKx61pJcrcyiPKsmCehkTj21ni3ovI9IuH5TO+x+7YkLTN0wRapfowlN
 nCqzo3YUGPRrJAJh0Gl0FBKpQIqXG+QBeCR55VJaY+ve5VDUZ2YZO0cIt+bVF7EMmv
 nmkb2GU5f5SZUjiVKTgjFx1+01aKwQigMzXAtUbcceKl/MU/hvU5tbYlnfM9HB1YOl
 M0QyuDQBSpSBJsSfVHHFg2rbIyvduRN7LeSQhT2ATXRASZjdZN2TB+VEWEd+pUYpLV
 CTQda3AxmTwXMWoHNiYs+rwmIxwuqwuXbJ3Ek0o3CQtkd5T8qW9IkPCYpco8hZaLYB
 P7qFcxL9QJpBg==
Received: from [100.112.195.149] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-1.bemta.az-a.eu-west-1.aws.symcld.net id 5A/14-23860-C227D616;
 Mon, 18 Oct 2021 13:10:04 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRWlGSWpSXmKPExsViZ8MxVVe7KDf
 RYPlRS4sV33cwOjB67Pu9jjWAMYo1My8pvyKBNePJJKmC/6oV3yYpNzBOl+9i5OIQEmhhkmjp
 +M0K4exhlNj3bT1LFyMnB5uApsSzzgXMILaIgIRER8NbdhCbWUBdYvmkX0wgtrBAkcTzviagG
 g4OFgFViT3t1SBhXgEPiQfvD7CB2BICChJTHr4HG8Mp4Clx9fUaMFsIqObezdvMEPWCEidnPm
 GBGK8p0br9N9QqeYnmrbOZIeYoSlzq+MYIYVdIzJrVxjSBUWAWkvZZSNpnIWlfwMi8itE8qSg
 zPaMkNzEzR9fQwEDX0NBI19DSWNfYUi+xSjdRL7VUtzy1uETXUC+xvFivuDI3OSdFLy+1ZBMj
 MHBTCg6q72D8+PqD3iFGSQ4mJVHefqXcRCG+pPyUyozE4oz4otKc1OJDjDIcHEoSvKfzgXKCR
 anpqRVpmTnAKIJJS3DwKInwVhUCpXmLCxJzizPTIVKnGBWlxHlZC4ASAiCJjNI8uDZY5F5ilJ
 US5mVkYGAQ4ilILcrNLEGVf8UozsGoJMwbDTKeJzOvBG76K6DFTECLrzrngCwuSURISTUwdXl
 aPT2TKXyX4VTLpcJ/LFuUv6Qw1XhYrl3vmhoo5vq5Nv2LEH/VWWcnzmiFpwlG4UvnTvm54O7+
 V1uMLvjHxTYzdr/Kj3hwc8vVtTsedm+40CNdWCG10j5vx5LO20v+9wf+ONnEtdYi/krJmYZvs
 +d9fRrsXLDrrVglDz/L+6i1dzgOzJXdqdS3ZXsA/6LYdIs7v1IZK/Lf23Ro3dLYpvJ7yvL3yV
 mG9u0d9zbc7Dp82ub4nPI9U9NFPl7WnPrz2OI2Z94rW0PFl7+skzZ+885YJaLVJeajsdiOmSf
 Y+WtUb/JMfCb2rWLmnuaZ7TMq2BUu125tq+6RzJrlwbXpumjdS+MmPy/9MnnTXau7lViKMxIN
 tZiLihMBFqWkI1cDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-21.tower-267.messagelabs.com!1634562603!1492020!1
X-Originating-IP: [62.60.8.149]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12856 invoked from network); 18 Oct 2021 13:10:03 -0000
Received: from unknown (HELO mailhost2.uk.fujitsu.com) (62.60.8.149)
 by server-21.tower-267.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 18 Oct 2021 13:10:03 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost2.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 19ID9vIx017346
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 14:10:03 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 18 Oct 2021 14:09:58 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 18 Oct 2021 21:09:42 +0800
Message-ID: <1634562591-5830-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1634562591-5830-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1634562591-5830-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] =?utf-8?q?=5BPATCH_v1_02/11=5D_syscalls/quotactl06?=
 =?utf-8?q?=EF=BC=9AAlso_test_with_vfsv1_format?=
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

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 .../kernel/syscalls/quotactl/quotactl06.c     | 59 +++++++++++++++----
 1 file changed, 46 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
index a10d1ca07..f53f088d8 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl06.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
@@ -1,26 +1,42 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
+ * Copyright (c) 2019-2021 FUJITSU LIMITED. All rights reserved.
  * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Tests basic error handling of the quotactl syscall with visible quota files
+ * (cover two formats, vfsv0 and vfsv1):
  *
- * Tests basic error handling of the quotactl syscall.
  * 1) quotactl fails with EACCES when cmd is Q_QUOTAON and addr
  * existed but not a regular file.
+ *
  * 2) quotaclt fails with ENOENT when the file specified by special
  * or addr does not exist.
+ *
  * 3) quotactl fails with EBUSTY when  cmd is Q_QUOTAON and another
  * Q_QUOTAON had already been performed.
+ *
  * 4) quotactl fails with EFAULT when addr or special is invalid.
+ *
  * 5) quotactl fails with EINVAL when cmd or type is invalid.
+ *
  * 6) quotactl fails with ENOTBLK when special is not a block device.
+ *
  * 7) quotactl fails with ESRCH when no disk quota is found for the
  * indicated user and quotas have not been turned on for this fs.
+ *
  * 8) quotactl fails with ESRCH when cmd is Q_QUOTAON, but the quota
  * format was not found.
+ *
  * 9) quotactl fails with ESRCH when cmd is Q_GETNEXTQUOTA, but there
  * is no ID greater than or equal to id that has an active quota.
+ *
  * 10) quotactl fails with ERANGE when cmd is Q_SETQUOTA, but the
  * specified limits are out of the range allowed by the quota format.
+ *
  * 11) quotactl fails with EPERM when the caller lacked the required
  * privilege (CAP_SYS_ADMIN) for the specified operation.
  */
@@ -32,10 +48,7 @@
 #include "tst_capability.h"
 
 #define OPTION_INVALID 999
-#define QFMT_VFS_V0     2
 #define USRPATH MNTPOINT "/aquota.user"
-#define FMTID QFMT_VFS_V0
-
 #define MNTPOINT "mntpoint"
 #define TESTDIR1 MNTPOINT "/testdir1"
 #define TESTDIR2 MNTPOINT "/testdir2"
@@ -43,10 +56,10 @@
 static char usrpath[] = USRPATH;
 static char testdir1[] = TESTDIR1;
 static char testdir2[] = TESTDIR2;
-static int32_t fmt_id = FMTID;
+static int32_t fmt_id;
 static int32_t fmt_invalid = 999;
 static int test_invalid;
-static int test_id;
+static int test_id, mount_flag;
 static int getnextquota_nsup;
 
 static struct if_nextdqblk res_ndq;
@@ -105,7 +118,7 @@ static void verify_quotactl(unsigned int n)
 
 	if (tc->on_flag) {
 		TEST(quotactl(QCMD(Q_QUOTAON, USRQUOTA), tst_device->dev,
-			FMTID, usrpath));
+			fmt_id, usrpath));
 		if (TST_RET == -1)
 			tst_brk(TBROK,
 				"quotactl with Q_QUOTAON returned %ld", TST_RET);
@@ -135,7 +148,7 @@ static void verify_quotactl(unsigned int n)
 
 	if (quota_on) {
 		TEST(quotactl(QCMD(Q_QUOTAOFF, USRQUOTA), tst_device->dev,
-			FMTID, usrpath));
+			fmt_id, usrpath));
 		if (TST_RET == -1)
 			tst_brk(TBROK,
 				"quotactl with Q_QUOTAOFF returned %ld", TST_RET);
@@ -150,10 +163,23 @@ static void verify_quotactl(unsigned int n)
 
 static void setup(void)
 {
-	const char *const cmd[] = {"quotacheck", "-uF", "vfsv0", MNTPOINT, NULL};
+	const char *const vfsv0_cmd[] = {"quotacheck", "-uF", "vfsv0", MNTPOINT, NULL};
+	const char *const vfsv1_cmd[] = {"quotacheck", "-uF", "vfsv1", MNTPOINT, NULL};
 	unsigned int i;
 
-	SAFE_CMD(cmd, NULL, NULL);
+	SAFE_MKFS(tst_device->dev, tst_device->fs_type, NULL, NULL);
+	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, "usrquota");
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
 
 	if (access(USRPATH, F_OK) == -1)
 		tst_brk(TFAIL | TERRNO, "user quotafile didn't exist");
@@ -175,8 +201,15 @@ static void setup(void)
 	}
 }
 
+static void cleanup(void)
+{
+	if (mount_flag && tst_umount(MNTPOINT))
+		tst_res(TWARN | TERRNO, "umount(%s)", MNTPOINT);
+}
+
 static struct tst_test test = {
 	.setup = setup,
+	.cleanup = cleanup,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_QFMT_V2",
 		NULL
@@ -185,11 +218,11 @@ static struct tst_test test = {
 	.test = verify_quotactl,
 	.dev_fs_type = "ext4",
 	.mntpoint = MNTPOINT,
-	.mount_device = 1,
-	.mnt_data = "usrquota",
+	.needs_device = 1,
 	.needs_cmds = (const char *const []) {
 		"quotacheck",
 		NULL
 	},
 	.needs_root = 1,
+	.test_variants = 2,
 };
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
