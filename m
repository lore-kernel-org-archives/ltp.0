Return-Path: <SRS0=Jxr4=PG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8C2C433F5
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 13:15:43 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01CE360F44
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 13:15:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 01CE360F44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA27E3C30A1
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 15:15:41 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2434A3C30E9
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 15:15:26 +0200 (CEST)
Received: from mail1.bemta26.messagelabs.com (mail1.bemta26.messagelabs.com
 [85.158.142.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8820B600906
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 15:15:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1634562924; i=@fujitsu.com;
 bh=r1V/2sDwpNqNa78bciqnrDnGyhSshhvwXFqa2QJ4/PQ=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=lruMeKDKbkRzVPf6UVW5ZMMmHGWIK9PDeLlouM2NEpv1jR670bg2bE2p3ZeYYj0fI
 dVMRIPKLuuNNG5yF/6rd9lUoeJ4vJKbmdaJ7RLzTZTLxGU6T9IGhX1Jj+pkpAzruBE
 nztCSJMoa7lPyptdPEk0phxvDq7DKJ+91LXW9o6gz6zYi0nm45rGw3TjAiA6Pg9sue
 w56sSFvEVO7hzIAhRsuLG99yS/3gnZaBbpdxrN/QrfBlEdEbwIwk7V86RxVSivusH1
 6/lxIQ4v747Kq952PeBHdnfjy5HaFz2HIGsfYd6N8FknS2r+SJgkx+deTFAzFXTRDq
 A8bVHHXDDVW2Q==
Received: from [100.113.6.210] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-b.eu-central-1.aws.symcld.net id 71/4C-14220-C637D616;
 Mon, 18 Oct 2021 13:15:24 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRWlGSWpSXmKPExsViZ8ORqJtTnJt
 ocGWijMWK7zsYHRg99v1exxrAGMWamZeUX5HAmnF+zzL2gp1CFfOnbmdrYLzI38XIxSEkcJZR
 Ys+RJ2wQzk4miU1/2qCcPYwSfV9uM3YxcnKwCWhKPOtcwAxiiwhISHQ0vGUHsZkF1CWWT/rFB
 GILC3hLLFlzFsxmEVCVOPRhDiuIzSvgIfGzH2QoJ4eEgILElIfvweZwCnhKLD4+D6xGCKjm/L
 bLTBD1ghInZz5hgZgvIXHwxQtmiF5FiUsd3xgh7AqJWbPamCBsNYmr5zYxT2AUnIWkfRaS9gW
 MTKsYLZKKMtMzSnITM3N0DQ0MdA0NjXXNdC3M9RKrdJP0Ukt1k1PzSooSgZJ6ieXFesWVuck5
 KXp5qSWbGIEhnFLIFr6D8czrD3qHGCU5mJREefuVchOF+JLyUyozEosz4otKc1KLDzHKcHAoS
 fCezgfKCRalpqdWpGXmAOMJJi3BwaMkwqtXBJTmLS5IzC3OTIdInWJUlBLnZS0ASgiAJDJK8+
 DaYDF8iVFWSpiXkYGBQYinILUoN7MEVf4VozgHo5IwrzfIeJ7MvBK46a+AFjMBLb7qnAOyuCQ
 RISXVwDQ7gKnvUQJzy1RlZqEc1zqt+1Hb5LZ8+18eFu20Z3fli9NmFXkLnzA/f7/52heWzJa3
 QTJXbGOLG/rUXZeurg1+Nnue7+ajlbaSV4xDdiT9nMTQ+jd4ydUdW3ZV/Hh3oKQtKFBd9Mylc
 487TFx9bBLDtiT+/7qvlP1Ln4v6xG1xntqtWouyZKRfJYV47r/tI6sY7sX5/u9K1Z8Lb2Verr
 oRnLn00dIj09LSg64urL/TcPD+8/cGkWqiNTFaatvmVL7Rbrds+utv1CN52SaH7eehydcfv/k
 +x+Po3+8LGj8z1wj/kmvusk0pude8tTJVp77vRUfp2m9uF2aU3eU5oeMa4ZpreG3iTAGTNRpW
 7UosxRmJhlrMRcWJAJXPKRRcAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-11.tower-238.messagelabs.com!1634562924!302354!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 7966 invoked from network); 18 Oct 2021 13:15:24 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-11.tower-238.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 18 Oct 2021 13:15:24 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id EB2F7100231
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 14:15:23 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id BE840100235
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 14:15:23 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 18 Oct 2021 14:15:12 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 18 Oct 2021 21:14:47 +0800
Message-ID: <1634562888-5987-5-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1634562888-5987-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1634562888-5987-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 10/11] syscalls/quotactl04: Add quotactl_fd test
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

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 .../kernel/syscalls/quotactl/quotactl04.c     | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
index e01657de5..010fa8fd6 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl04.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
- * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ * Copyright (c) 2019-2021 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
  */
 
 /*\
@@ -44,11 +44,14 @@
 #include "tst_test.h"
 #include "lapi/quotactl.h"
 #include "tst_safe_stdio.h"
+#include "quotactl_var.h"
 
 #define FMTID QFMT_VFS_V1
 #define MNTPOINT	"mntpoint"
+#define TESTFILE	MNTPOINT "/testfile"
+
 static int32_t fmt_id = FMTID;
-static int test_id, mount_flag;
+static int test_id, mount_flag, fd = -1;
 static struct dqblk set_dq = {
 	.dqb_bsoftlimit = 100,
 	.dqb_valid = QIF_BLIMITS
@@ -139,6 +142,7 @@ static void setup(void)
 	const char *const fs_opts[] = {"-I 256", "-O quota,project", NULL};
 	int rc, major, minor, patch;
 
+	quotactl_info();
 	test_id = geteuid();
 	f = SAFE_POPEN("mkfs.ext4 -V 2>&1", "r");
 	rc = fscanf(f, "mke2fs %d.%d.%d", &major, &minor, &patch);
@@ -149,10 +153,14 @@ static void setup(void)
 	pclose(f);
 	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
 	do_mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
+	fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, 0666);
 }
 
 static void cleanup(void)
 {
+	if (fd > -1)
+		SAFE_CLOSE(fd);
+
 	if (mount_flag && tst_umount(MNTPOINT))
 		tst_res(TWARN | TERRNO, "umount(%s)", MNTPOINT);
 }
@@ -167,7 +175,7 @@ static void verify_quota(unsigned int n)
 
 	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
 
-	TEST(quotactl(tc->cmd, tst_device->dev, *tc->id, tc->addr));
+	TEST(do_quotactl(fd, tc->cmd, tst_device->dev, *tc->id, tc->addr));
 	if (TST_RET == -1) {
 		tst_res(TFAIL | TTERRNO, "quotactl failed to %s", tc->des);
 		return;
@@ -200,5 +208,6 @@ static struct tst_test test = {
 	.needs_cmds = (const char *[]) {
 		"mkfs.ext4",
 		NULL
-	}
+	},
+	.test_variants = 2,
 };
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
