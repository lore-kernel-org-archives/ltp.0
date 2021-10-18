Return-Path: <SRS0=Jxr4=PG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15674C433EF
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 13:10:27 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D5E76103C
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 13:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5D5E76103C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC8363C2FFD
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 15:10:24 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2BC9E3C0E65
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 15:10:05 +0200 (CEST)
Received: from mail1.bemta25.messagelabs.com (mail1.bemta25.messagelabs.com
 [195.245.230.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3011B600906
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 15:10:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1634562604; i=@fujitsu.com;
 bh=95TLkjhd6gaODzmlPAbHvrSRRawjt1VU2tQKMgZByhk=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=QCpdHbHnfAThSY8NmCF3aNJYLX/p3yj+pHgLonOy0WkdPvhLCDPz5fGkGkGf16Jmz
 i3m7+8AV+UnNd7BnUfmztznY1bxtHOHsP2JyHkdypYRe2snNUI0aHOzFJE3OL0EBG0
 bnCI84nIhQte6yVbTt9SdDUvNXcNERAM5qui/t5xoAhyjqet/DGgbF1iyVclqddk2Q
 bojQulHk2Rd4LLKSb75loe4Z+PaPQYoApil7E1K7P2S7bdaioiMZPXBLzQTfHc/+3Q
 JDX3lzvIPVme2agoalS7rkOdIfVzq1OB7aMa58I/c0B5jzMmGCA8URxUIgXFArPHWD
 9L762JEvEs3Mg==
Received: from [100.112.197.4] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-b.eu-west-1.aws.symcld.net id 37/B6-18279-C227D616;
 Mon, 18 Oct 2021 13:10:04 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRWlGSWpSXmKPExsViZ8MxVVe7KDf
 R4Mlea4sV33cwOjB67Pu9jjWAMYo1My8pvyKBNeP+3tfsBYeFKt6uKm1gPMjfxcjFISTQwiQx
 +84VJghnD6PEolWrGLsYOTnYBDQlnnUuYAaxRQQkJDoa3rKD2MwC6hLLJ/1iArGFBUIkps+Yx
 AJiswioSuw6/RushlfAQ+L3zMesILaEgILElIfvweZwCnhKXH29BswWAqq5d/M2M0S9oMTJmU
 9YIOZLSBx88YIZoldR4lLHN0YIu0Ji1qw2pgmM/LOQtMxC0rKAkWkVo0VSUWZ6RkluYmaOrqG
 Bga6hoZGuoaWFrpGhqV5ilW6SXmqpbnlqcYmuoV5iebFecWVuck6KXl5qySZGYDimFBy7voPx
 6usPeocYJTmYlER5+5VyE4X4kvJTKjMSizPii0pzUosPMcpwcChJ8J7OB8oJFqWmp1akZeYAY
 wMmLcHBoyTC618AlOYtLkjMLc5Mh0idYtTlePdz8SJmIZa8/LxUKXFeVpAiAZCijNI8uBGwOL
 3EKCslzMvIwMAgxFOQWpSbWYIq/4pRnINRSZhXF2QKT2ZeCdymV0BHMAEdcdU5B+SIkkSElFQ
 DU0lG71ymm+Jfw9XSQkRFb93w0uf0cDqha9Mx62OG1o0re39s+t3fNffS61tzrWb5yVZp8Zc6
 P05Yee6laEnIt3JRlp3vJKIEuuK+L2DcN0NcVqbv8p3YJ9wajNvznwctaiyIKrg87/QP26Cql
 XFNs2L5rqi77Rdu5YqeKXo87qbltVL/baLsPhlPtly8wrhZJs1qgcHLa2rMSx+/ad/4e+8HU6
 OXnue08tvWPP9nLzLbP8/lXeqSp0+cTK6suGtz52tHeH7I3H9W+U7ixx7kHzSv2vWMV+6TdXI
 Di/tFrit9q+axRh95XvJk26LYfrma4PPnixQNrQ5fOdtam+9adLhR+1vxkdZlC6dXNX+cpMRS
 nJFoqMVcVJwIAEGCh1NOAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-9.tower-291.messagelabs.com!1634562603!1382503!1
X-Originating-IP: [62.60.8.149]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 14136 invoked from network); 18 Oct 2021 13:10:03 -0000
Received: from unknown (HELO mailhost2.uk.fujitsu.com) (62.60.8.149)
 by server-9.tower-291.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 18 Oct 2021 13:10:03 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost2.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 19ID9vJ0017346
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 14:10:03 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 18 Oct 2021 14:09:59 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 18 Oct 2021 21:09:43 +0800
Message-ID: <1634562591-5830-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1634562591-5830-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1634562591-5830-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 03/11] syscalls/quotactl04: Remove useless quotactl
 mount options
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

When use -O quota options for mkfs.ext4, quota mount option
will be ignored[1]. So remove it.

Also add docparse formatting.

[1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7c319d3

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/quotactl/quotactl04.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
index fd3afc888..ca6a94263 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl04.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
@@ -2,22 +2,33 @@
 /*
  * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
  * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ */
+
+/*\
+ * [Description]
  *
  * This testcase checks the basic flag of quotactl(2) for project quota on
  * non-XFS filesystems.
  *
  * 1) quotactl(2) succeeds to turn on quota with Q_QUOTAON flag for project.
+ *
  * 2) quotactl(2) succeeds to set disk quota limits with Q_SETQUOTA flag
  *    for project.
+ *
  * 3) quotactl(2) succeeds to get disk quota limits with Q_GETQUOTA flag
  *    for project.
+ *
  * 4) quotactl(2) succeeds to set information about quotafile with Q_SETINFO
  *    flag for project.
+ *
  * 5) quotactl(2) succeeds to get information about quotafile with Q_GETINFO
  *    flag for project.
+ *
  * 6) quotactl(2) succeeds to get quota format with Q_GETFMT flag for project.
+ *
  * 7) quotactl(2) succeeds to get disk quota limit greater than or equal to
  *    ID with Q_GETNEXTQUOTA flag for project.
+ *
  * 8) quotactl(2) succeeds to turn off quota with Q_QUOTAOFF flag for project.
  *
  * Minimum e2fsprogs version required is 1.43.
@@ -34,10 +45,6 @@
 #include "tst_safe_stdio.h"
 #include "tst_test.h"
 
-#ifndef QFMT_VFS_V1
-# define QFMT_VFS_V1 4
-#endif
-
 #define FMTID QFMT_VFS_V1
 #define MNTPOINT	"mntpoint"
 static int32_t fmt_id = FMTID;
@@ -141,7 +148,7 @@ static void setup(void)
 		tst_brk(TCONF, "Test needs mkfs.ext4 >= 1.43 for quota,project option, test skipped");
 	pclose(f);
 	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
-	do_mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, "quota");
+	do_mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
 }
 
 static void cleanup(void)
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
