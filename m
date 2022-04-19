Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 251F6C433EF
	for <ltp@archiver.kernel.org>; Tue, 19 Apr 2022 08:51:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A76C3CA645
	for <ltp@archiver.kernel.org>; Tue, 19 Apr 2022 10:51:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 744E43C54E8
 for <ltp@lists.linux.it>; Tue, 19 Apr 2022 10:51:17 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3856B602117
 for <ltp@lists.linux.it>; Tue, 19 Apr 2022 10:51:12 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KjHX652nnzFqQb
 for <ltp@lists.linux.it>; Tue, 19 Apr 2022 16:48:38 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Apr 2022 16:51:08 +0800
To: <ltp@lists.linux.it>
Date: Tue, 19 Apr 2022 16:50:02 +0800
Message-ID: <20220419085002.65719-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/io_submit: Add TTERRNO/TERRNO when test fail
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

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 testcases/kernel/syscalls/io_submit/io_submit01.c | 2 +-
 testcases/kernel/syscalls/io_submit/io_submit02.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/io_submit/io_submit01.c b/testcases/kernel/syscalls/io_submit/io_submit01.c
index db541fc01..ba75f6d81 100644
--- a/testcases/kernel/syscalls/io_submit/io_submit01.c
+++ b/testcases/kernel/syscalls/io_submit/io_submit01.c
@@ -130,7 +130,7 @@ static void verify_io_submit(unsigned int n)
 		return;
 	}

-	tst_res(TFAIL, "io_submit() returned %i(%s), expected %s(%i)",
+	tst_res(TFAIL | TERRNO, "io_submit() returned %i(%s), expected %s(%i)",
 		ret, ret < 0 ? tst_strerrno(-ret) : "SUCCESS",
 		errno_name(t->exp_errno), t->exp_errno);
 }
diff --git a/testcases/kernel/syscalls/io_submit/io_submit02.c b/testcases/kernel/syscalls/io_submit/io_submit02.c
index 38b8555d8..6ba4d99a5 100644
--- a/testcases/kernel/syscalls/io_submit/io_submit02.c
+++ b/testcases/kernel/syscalls/io_submit/io_submit02.c
@@ -79,7 +79,7 @@ static void run(unsigned int i)
 	if (TST_RET == tc[i].nr)
 		tst_res(TPASS, "io_submit() %s", tc[i].desc);
 	else
-		tst_res(TFAIL, "io_submit() returns %ld, expected %ld", TST_RET, tc[i].nr);
+		tst_res(TFAIL | TTERRNO, "io_submit() returns %ld, expected %ld", TST_RET, tc[i].nr);

 	for (j = 0; j < TST_RET; j++) {
 		tst_syscall(__NR_io_getevents, *tc[i].ctx, 1, 1, &evbuf,
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
