Return-Path: <SRS0=tV2W=P3=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7851CC433F5
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 07:37:16 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A90F660ED7
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 07:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A90F660ED7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8AAD63C7616
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 08:37:13 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D1F23C702E
 for <ltp@lists.linux.it>; Mon,  8 Nov 2021 08:37:03 +0100 (CET)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 00AEA1A004F6
 for <ltp@lists.linux.it>; Mon,  8 Nov 2021 08:37:01 +0100 (CET)
Received: from dggeml753-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HnjZL6pwtz8vFT
 for <ltp@lists.linux.it>; Mon,  8 Nov 2021 15:35:22 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 dggeml753-chm.china.huawei.com (10.1.199.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Mon, 8 Nov 2021 15:36:56 +0800
From: Zhao Gongyi <zhaogongyi@huawei.com>
To: <ltp@lists.linux.it>
Date: Mon, 8 Nov 2021 15:38:28 +0800
Message-ID: <20211108073828.33126-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeml753-chm.china.huawei.com (10.1.199.152)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib/tst_test.c: add *cleanup() before exit
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

If the main process exit without *cleanup() and when the lib process
has exit, the test environment would not be reset when the testcase
needs resource of device or tmpfs.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 lib/tst_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 02ae28335..4c7e3a97b 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1226,6 +1226,8 @@ static void heartbeat(void)
 		 * We need kill the task group immediately since the
 		 * main process has exit.
 		 */
+		do_test_cleanup();
+		do_cleanup();
 		kill(0, SIGKILL);
 		exit(TBROK);
 	}
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
