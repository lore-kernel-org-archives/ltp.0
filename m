Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EDEBECAAA1
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 06:18:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 302733CA926
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 08:18:33 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 18B303C8095
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 08:18:18 +0200 (CEST)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3FD08600047
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 08:18:15 +0200 (CEST)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MLdX05X6Rz1N7wZ
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 14:14:24 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.155) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 5 Sep 2022 14:18:10 +0800
To: <ltp@lists.linux.it>
Date: Mon, 5 Sep 2022 14:14:25 +0800
Message-ID: <20220905061425.22852-1-luoxiaoyu9@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.155]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] pty04.c/pidfd_send_signal03.c: Drop redundant
 tst_reap_children()
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
From: Luo xiaoyu via ltp <ltp@lists.linux.it>
Reply-To: Luo xiaoyu <luoxiaoyu9@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Drop redundant calling of tst_reap_children() in cleanup() since
it has been called in the API (run_tests()).

Signed-off-by: Luo xiaoyu <luoxiaoyu9@huawei.com>
---
 testcases/kernel/pty/pty04.c                                    | 2 --
 .../kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c     | 1 -
 2 files changed, 3 deletions(-)

diff --git a/testcases/kernel/pty/pty04.c b/testcases/kernel/pty/pty04.c
index 8c7b1bf92..efd5bd364 100644
--- a/testcases/kernel/pty/pty04.c
+++ b/testcases/kernel/pty/pty04.c
@@ -462,8 +462,6 @@ static void cleanup(void)
 	if (sk >= 0)
 		close(sk);
-
-	tst_reap_children();
 }
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c
index 20d96b118..5bc5c4d81 100644
--- a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c
+++ b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c
@@ -128,7 +128,6 @@ static void setup(void)
 static void cleanup(void)
 {
-	tst_reap_children();
 	if (new_pidfd > 0)
 		SAFE_CLOSE(new_pidfd);
 	if (pidfd > 0)
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
