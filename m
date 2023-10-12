Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2118CDB47E
	for <ltp@archiver.kernel.org>; Thu, 12 Oct 2023 08:41:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA5133CD493
	for <ltp@archiver.kernel.org>; Thu, 12 Oct 2023 10:41:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F11973C8883
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 10:41:16 +0200 (CEST)
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com
 [139.138.36.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6536760122A
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 10:41:16 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="123564957"
X-IronPort-AV: E=Sophos;i="6.03,218,1694703600"; d="scan'208";a="123564957"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2023 17:41:13 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id D7CA0E42B0
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 17:41:10 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 2C082D9688
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 17:41:10 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id BF63D70BDE
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 17:41:09 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 770041A0074;
 Thu, 12 Oct 2023 16:41:09 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Thu, 12 Oct 2023 16:40:57 +0800
Message-Id: <1697100058-2859-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1697100058-2859-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1697100058-2859-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27930.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27930.006
X-TMASE-Result: 10--7.451100-10.000000
X-TMASE-MatchedRID: s7S5NEjjqbIxAROjHaAf207nLUqYrlslFIuBIWrdOeOjEIt+uIPPOBpl
 bnRIZ6aE+FyTwBk2ojzQiPkh3igW2mttoX8vLlJxxDiakrJ+SpnA10GlIGdlLDQM0/COoudwGJ0
 UP0AzEBUlnn51CX1pz4Ay6p60ZV62yA7duzCw6dLdB/CxWTRRu25FeHtsUoHuza8uISoVRv1/dm
 yL323RwZkj3f73jXqBouZyfNImy/BfCOKFKuVYGg==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] umount02: Simplify test using TST_ macros
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
 testcases/kernel/syscalls/umount/umount02.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/umount/umount02.c b/testcases/kernel/syscalls/umount/umount02.c
index 34a38c998..40fed1fbd 100644
--- a/testcases/kernel/syscalls/umount/umount02.c
+++ b/testcases/kernel/syscalls/umount/umount02.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
  * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) Linux Test Project, 2003-2023
  * Author: Nirmala Devi Dhanasekar <nirmala.devi@wipro.com>
  *
  * Check for basic errors returned by umount(2) system call.
@@ -41,21 +42,14 @@ static void verify_umount(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
 
-	TEST(umount(tc->mntpoint));
-
-	if (TST_RET != -1) {
-		tst_res(TFAIL, "umount() succeeds unexpectedly");
-		return;
-	}
+	TST_EXP_FAIL(umount(tc->mntpoint), tc->exp_errno,
+		     "umount() fail with %s", tc->err_desc);
 
 	if (tc->exp_errno != TST_ERR) {
 		tst_res(TFAIL | TTERRNO, "umount() should fail with %s",
 			tst_strerrno(tc->exp_errno));
 		return;
 	}
-
-	tst_res(TPASS | TTERRNO, "umount() fails as expected: %s",
-		tc->err_desc);
 }
 
 static void setup(void)
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
