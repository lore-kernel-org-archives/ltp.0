Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8457C433EF
	for <ltp@archiver.kernel.org>; Sat, 19 Mar 2022 07:45:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 84E213C97C6
	for <ltp@archiver.kernel.org>; Sat, 19 Mar 2022 08:45:49 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E9B73C6355
 for <ltp@lists.linux.it>; Sat, 19 Mar 2022 08:45:39 +0100 (CET)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 53AD210000C8
 for <ltp@lists.linux.it>; Sat, 19 Mar 2022 08:45:36 +0100 (CET)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.56])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KLCYs1lCGzfYl0
 for <ltp@lists.linux.it>; Sat, 19 Mar 2022 15:44:01 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 19 Mar 2022 15:45:31 +0800
To: <ltp@lists.linux.it>
Date: Sat, 19 Mar 2022 15:44:53 +0800
Message-ID: <20220319074453.104636-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] readdir01: Add closedir before test return
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

If we run the test with option -i 10000, and the ulimit of
open files little than 10000, the test will fail and report:
readdir01.c:48: TBROK: opendir(.) failed: EMFILE (24).

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 testcases/kernel/syscalls/readdir/readdir01.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/readdir/readdir01.c b/testcases/kernel/syscalls/readdir/readdir01.c
index e90f50c80..d200145ea 100644
--- a/testcases/kernel/syscalls/readdir/readdir01.c
+++ b/testcases/kernel/syscalls/readdir/readdir01.c
@@ -59,6 +59,8 @@ static void verify_readdir(void)
 		tst_res(TFAIL, "found %s files than were created, created: %d, found: %d",
 					cnt > nfiles ? "more" : "less", nfiles, cnt);
 	}
+
+	SAFE_CLOSEDIR(test_dir);
 }

 static struct tst_test test = {
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
