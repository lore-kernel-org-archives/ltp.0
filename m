Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FD9C433EF
	for <ltp@archiver.kernel.org>; Thu, 24 Mar 2022 02:25:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F8863C97F2
	for <ltp@archiver.kernel.org>; Thu, 24 Mar 2022 03:25:55 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E4863C9447
 for <ltp@lists.linux.it>; Thu, 24 Mar 2022 03:25:45 +0100 (CET)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 100891400519
 for <ltp@lists.linux.it>; Thu, 24 Mar 2022 03:25:43 +0100 (CET)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KP8Cl087BzCr6R
 for <ltp@lists.linux.it>; Thu, 24 Mar 2022 10:23:31 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Mar 2022 10:25:38 +0800
To: <ltp@lists.linux.it>
Date: Thu, 24 Mar 2022 10:24:55 +0800
Message-ID: <20220324022455.245300-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] accept02: Add SAFE_CLOSE before test return
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

If we run the test with the option -i 10000, and the ulimit
of open files little than 10000, the test would fail and report
error of EMFILE.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
v1->v2: according Cyril's review, add SAFE_CLOSE before test return.
 testcases/kernel/syscalls/accept/accept02.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/accept/accept02.c b/testcases/kernel/syscalls/accept/accept02.c
index 12a1e3ca3..7cb3d6970 100644
--- a/testcases/kernel/syscalls/accept/accept02.c
+++ b/testcases/kernel/syscalls/accept/accept02.c
@@ -67,6 +67,7 @@ static void *server_thread(void *arg)

 	TEST(setsockopt(clone_server_sockfd, SOL_IP, MCAST_LEAVE_GROUP,
 			mc_group, mc_group_len));
+	SAFE_CLOSE(clone_server_sockfd);

 	if (TST_RET != -1)
 		tst_res(TFAIL, "Multicast group was copied!");
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
