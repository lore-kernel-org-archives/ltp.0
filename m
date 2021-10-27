Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F34C433EF
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 12:27:21 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DB3160EDF
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 12:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3DB3160EDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D6C823C6ADD
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 14:27:19 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 833BE3C67D8
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 14:26:34 +0200 (CEST)
Received: from mail1.bemta26.messagelabs.com (mail1.bemta26.messagelabs.com
 [85.158.142.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E3239140173D
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 14:26:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1635337592; i=@fujitsu.com;
 bh=cv7ZUW7EKMomb2VcGgu7cYn7etzJ2/VsOXAtnaVgUQ4=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=NJUME6bGVYa4YcNUjYGnWThj3OScwl3m+VvH11CxDzZvC2OCoDFStF1ng8Xcoisil
 SS8XWTJdCeEy0yFFzrq2FuSsBkI+S14VU6tjnGJMpiRUoxCSwi51QLOHVAq7kgLCKX
 IUpx0xuqdJsFRj7+x3de82XKbsKyI5DhXtsSipLLLq9WDH1NdQt5rTHqhVgIYPIpNk
 NRu2nzoeDDJFvpy9aELnDvlGFW8ZT7KrAasMu7QK3TCNunskBfD5OfVnLcRcv6LBh9
 7pYqN8K3aLlcQkmvwv+7FXlWyEc9+gcoRWWBr//ZJVSL9fjlUFWzIDeq3CTpmVIq25
 po/xSro2X/awg==
Received: from [100.113.0.18] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-a.eu-central-1.aws.symcld.net id 1F/2C-15394-87549716;
 Wed, 27 Oct 2021 12:26:32 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRWlGSWpSXmKPExsViZ8ORqFvuWpl
 osLPP2mLF9x2MDowe+36vYw1gjGLNzEvKr0hgzfjW+oat4IBkRVtPF2sD4yHRLkYuDiGBs4wS
 Z+e9YoRwdjJJ9B15xwzh7GGU+L7yOGsXIycHm4CmxLPOBcwgtoiAhERHw1t2EJtZQF1i+aRfT
 F2MHBzCAl4SU5fag4RZBFQleqZeByvnFfCQ+NI/iQ3ElhBQkJjy8D1YnFPAU2LSrkVg44WAai
 ZcfwZVLyhxcuYTFojxEhIHX7xghuhVlLjU8Y0Rwq6QmDWrjQnCVpO4em4T8wRGwVlI2mchaV/
 AyLSK0TKpKDM9oyQ3MTNH19DAQNfQ0FgXSBob6CVW6SbqpZbqJqfmlRQlAmX1EsuL9Yorc5Nz
 UvTyUks2MQJDOKWQoWkH47tXH/QOMUpyMCmJ8gboVCYK8SXlp1RmJBZnxBeV5qQWH2KU4eBQk
 uA94wiUEyxKTU+tSMvMAcYTTFqCg0dJhNcQJM1bXJCYW5yZDpE6xajL8e7n4kXMQix5+XmpUu
 K8HC5ARQIgRRmleXAjYLF9iVFWSpiXkYGBQYinILUoN7MEVf4VozgHo5Iwr70z0BSezLwSuE2
 vgI5gAjqCWakC5IiSRISUVANTmKfL6oy2w2vt+M5uPbfB0EHhl3dO8s0+lj0Trz11n8YVkHlq
 xmOV2bu/fjryxqndO2rSp+0Nz/4dm3U68PcM6+obL1NOf+xu35XU5P7g9Fb3UzMkXNP8tjL5T
 Nyo7LFM8LrJxCsnLWWUbxjWRMlu7poWHhbBeUj9b4LvisKfyefWJxf9mX5GKXn3DgNRlwCuij
 ix3VnvKybw7JNetSrkYPJdleqjs75dt7/49W/wWY4W6a7/B6KsQkslVxhvbFZqK2TPPXljp7n
 k8zcGvvm63sLTrgdyCNpGfWyb/Ie56HRg353uvmSTshDHHsN1fcufrK0vUl3tNOHePgvTDvF1
 fyQ+XZl5N3F/Pdvn1Rm+SizFGYmGWsxFxYkA0pqRfmgDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-17.tower-228.messagelabs.com!1635337591!158539!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 25229 invoked from network); 27 Oct 2021 12:26:31 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-17.tower-228.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 27 Oct 2021 12:26:31 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 7321110024F
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 13:26:31 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 64A34100237
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 13:26:31 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.24; Wed, 27 Oct 2021 13:26:26 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 27 Oct 2021 20:25:59 +0800
Message-ID: <1635337569-4634-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1635337569-4634-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1635337569-4634-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 03/13] syscalls/quotactl04: Remove useless mount
 option
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

Also add docparse formatting and remove duplicated header.

Adjust header position.

[1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7c319d3

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 .../kernel/syscalls/quotactl/quotactl04.c     | 41 ++++++++-----------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
index fd3afc888..f34050716 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl04.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
@@ -1,24 +1,22 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
- * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ * Copyright (c) 2019-2021 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*\
+ * [Description]
  *
- * This testcase checks the basic flag of quotactl(2) for project quota on
- * non-XFS filesystems.
+ * This testcases checks that quotactl(2) on ext4 filesystem succeeds to:
  *
- * 1) quotactl(2) succeeds to turn on quota with Q_QUOTAON flag for project.
- * 2) quotactl(2) succeeds to set disk quota limits with Q_SETQUOTA flag
- *    for project.
- * 3) quotactl(2) succeeds to get disk quota limits with Q_GETQUOTA flag
- *    for project.
- * 4) quotactl(2) succeeds to set information about quotafile with Q_SETINFO
- *    flag for project.
- * 5) quotactl(2) succeeds to get information about quotafile with Q_GETINFO
- *    flag for project.
- * 6) quotactl(2) succeeds to get quota format with Q_GETFMT flag for project.
- * 7) quotactl(2) succeeds to get disk quota limit greater than or equal to
- *    ID with Q_GETNEXTQUOTA flag for project.
- * 8) quotactl(2) succeeds to turn off quota with Q_QUOTAOFF flag for project.
+ * - turn on quota with Q_QUOTAON flag for project
+ * - set disk quota limits with Q_SETQUOTA flag for project
+ * - get disk quota limits with Q_GETQUOTA flag for project
+ * - set information about quotafile with Q_SETINFO flag for project
+ * - get information about quotafile with Q_GETINFO flag for project
+ * - get quota format with Q_GETFMT flag for project
+ * - get disk quota limit greater than or equal to ID with Q_GETNEXTQUOTA flag for project
+ * - turn off quota with Q_QUOTAOFF flag for project
  *
  * Minimum e2fsprogs version required is 1.43.
  */
@@ -29,14 +27,9 @@
 #include <stdio.h>
 #include <sys/stat.h>
 #include <sys/mount.h>
-#include "config.h"
-#include "lapi/quotactl.h"
 #include "tst_safe_stdio.h"
 #include "tst_test.h"
-
-#ifndef QFMT_VFS_V1
-# define QFMT_VFS_V1 4
-#endif
+#include "lapi/quotactl.h"
 
 #define FMTID QFMT_VFS_V1
 #define MNTPOINT	"mntpoint"
@@ -141,7 +134,7 @@ static void setup(void)
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
