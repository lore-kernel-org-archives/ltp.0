Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5038DCDB482
	for <ltp@archiver.kernel.org>; Thu, 12 Oct 2023 08:41:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 18D643CD467
	for <ltp@archiver.kernel.org>; Thu, 12 Oct 2023 10:41:28 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 89CDF3C8883
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 10:41:16 +0200 (CEST)
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com
 [139.138.36.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6699D600A31
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 10:41:14 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="123564956"
X-IronPort-AV: E=Sophos;i="6.03,218,1694703600"; d="scan'208";a="123564956"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2023 17:41:13 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id E9D55DDC63
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 17:41:10 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 1B18F31BFF
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 17:41:10 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id AFAE82005932A
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 17:41:09 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 405761A0071;
 Thu, 12 Oct 2023 16:41:09 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Thu, 12 Oct 2023 16:40:56 +0800
Message-Id: <1697100058-2859-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27930.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27930.006
X-TMASE-Result: 10--7.409200-10.000000
X-TMASE-MatchedRID: /2NGPvLZz+MxAROjHaAf207nLUqYrlslFIuBIWrdOeOU8ftiyKjZreCG
 89wh97wnj/bvtfhhXEtvp+b/wK4TT6Pr79DeRpFZxDiakrJ+Spn4uJ1REX4MHd+CFgPG/6VdTYG
 pyldZn87i8zVgXoAltuJ5hXsnxp7jC24oEZ6SpSkj80Za3RRg8JrByotRiTPW5+j2DKlQS1YkY2
 HJqCntJn2mk02Y8qjXfuSSEYqMKuk=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] umount01: Simplify test using TST_ macros
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/umount/umount01.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/umount/umount01.c b/testcases/kernel/syscalls/umount/umount01.c
index d05296dce..2950300a7 100644
--- a/testcases/kernel/syscalls/umount/umount01.c
+++ b/testcases/kernel/syscalls/umount/umount01.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
+ * Copyright (c) Linux Test Project, 2003-2023
  * Author: Nirmala Devi Dhanasekar <nirmala.devi@wipro.com>
  *
  * Phase I test for the umount(2) system call.
@@ -23,7 +24,7 @@ static void verify_umount(void)
 		mount_flag = 1;
 	}
 
-	TEST(umount(MNTPOINT));
+	TST_EXP_PASS(umount(MNTPOINT), "umount(%s)", MNTPOINT);
 
 	if (TST_RET != 0 && TST_ERR == EBUSY) {
 		tst_res(TINFO, "umount() Failed with EBUSY "
@@ -31,12 +32,6 @@ static void verify_umount(void)
 			"is probing newly mounted dirs");
 	}
 
-	if (TST_RET != 0) {
-		tst_res(TFAIL | TTERRNO, "umount() Failed");
-		return;
-	}
-
-	tst_res(TPASS, "umount() Passed");
 	mount_flag = 0;
 }
 
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
