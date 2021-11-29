Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0343C433F5
	for <ltp@archiver.kernel.org>; Mon, 29 Nov 2021 03:56:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 678613C55B2
	for <ltp@archiver.kernel.org>; Mon, 29 Nov 2021 04:56:41 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C58B3C2690
 for <ltp@lists.linux.it>; Mon, 29 Nov 2021 04:56:32 +0100 (CET)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 628DF602424
 for <ltp@lists.linux.it>; Mon, 29 Nov 2021 04:56:29 +0100 (CET)
Received: from dggeml753-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J2Wjv0q8Pzbj8Y
 for <ltp@lists.linux.it>; Mon, 29 Nov 2021 11:56:19 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 dggeml753-chm.china.huawei.com (10.1.199.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Mon, 29 Nov 2021 11:56:24 +0800
To: <ltp@lists.linux.it>
Date: Mon, 29 Nov 2021 11:57:37 +0800
Message-ID: <20211129035737.15910-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeml753-chm.china.huawei.com (10.1.199.152)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] max_map_count: Delete dead code
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
From: Zhao Gongyi via ltp <ltp@lists.linux.it>
Reply-To: Zhao Gongyi <zhaogongyi@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

When we run the testcase on AARCH64, there are no TST_ARM defined.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 testcases/kernel/mem/tunable/max_map_count.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/testcases/kernel/mem/tunable/max_map_count.c b/testcases/kernel/mem/tunable/max_map_count.c
index a4c3dbf8e..bfbd8b1c7 100644
--- a/testcases/kernel/mem/tunable/max_map_count.c
+++ b/testcases/kernel/mem/tunable/max_map_count.c
@@ -100,10 +100,6 @@ static bool filter_map(const char *line)
 			return true;
 		break;
 	case TST_ARM:
-		/* Skip it when run it in aarch64 */
-		if (tst_kernel_bits() == 64)
-			return false;
-
 		/* Older arm kernels didn't label their vdso maps */
 		if (!strncmp(line, "ffff0000-ffff1000", 17))
 			return true;
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
