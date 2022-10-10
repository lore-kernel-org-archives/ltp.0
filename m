Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EC7C433FE
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 08:20:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB1C23CAEA4
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 10:20:24 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1798E3C1841
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 10:20:13 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1C2BA100047A
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 10:20:11 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MmBbG4jTmzpSvP
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 16:16:58 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 16:20:07 +0800
To: <ltp@lists.linux.it>
Date: Mon, 10 Oct 2022 16:16:28 +0800
Message-ID: <20221010081628.37168-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib: Move setup_ipc() to the beginning of do_setup()
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

Move setup_ipc() to the beginning of do_setup() since we
would use the 'results' immediately in do_setup(), otherwise,there
is no Results statistics when calling the tst_brk in do_setup().

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 lib/tst_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 8ccde1629..02fc6a06e 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1096,6 +1096,8 @@ static void do_cgroup_requires(void)

 static void do_setup(int argc, char *argv[])
 {
+	setup_ipc();
+
 	if (!tst_test)
 		tst_brk(TBROK, "No tests to run");

@@ -1169,8 +1171,6 @@ static void do_setup(int argc, char *argv[])
 	if (tst_test->hugepages.number)
 		tst_reserve_hugepages(&tst_test->hugepages);

-	setup_ipc();
-
 	if (tst_test->bufs)
 		tst_buffers_alloc(tst_test->bufs);

--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
