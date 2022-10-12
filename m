Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1741FC4332F
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 09:19:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F7513CAEC3
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 11:19:29 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B0BD23CAEBB
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 11:19:06 +0200 (CEST)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5AEE9601156
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 11:19:05 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.56])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MnRmg6rLqz1P72m
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 17:14:27 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 12 Oct 2022 17:19:02 +0800
To: <ltp@lists.linux.it>
Date: Wed, 12 Oct 2022 17:15:25 +0800
Message-ID: <20221012091526.35373-2-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221012091526.35373-1-zhaogongyi@huawei.com>
References: <20221012091526.35373-1-zhaogongyi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] lib: Add checking of needs_root
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

We need to check needs_root is set when tst_test->needs_device or
tst_test->mount_device is set since access the /dev/* need a
privilege.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 lib/tst_test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 8ccde1629..728a1d921 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1196,6 +1196,11 @@ static void do_setup(int argc, char *argv[])
 		tst_brk(TBROK, "tst_test->mntpoint must be set!");
 	}

+	if ((tst_test->needs_device || tst_test->mount_device) &&
+	     !tst_test->needs_root) {
+		tst_brk(TBROK, "tst_test->needs_root must be set!");
+	}
+
 	if (!!tst_test->needs_rofs + !!tst_test->needs_devfs +
 	    !!tst_test->needs_device > 1) {
 		tst_brk(TBROK,
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
