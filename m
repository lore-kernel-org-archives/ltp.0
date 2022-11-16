Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB1FEC4332F
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 03:52:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AFC953CD1CA
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 04:52:39 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C09433CAFBA
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 04:52:29 +0100 (CET)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 76C3F600A13
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 04:52:26 +0100 (CET)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NBpyK43jgzHvrg
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 11:51:53 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 11:52:23 +0800
To: <ltp@lists.linux.it>
Date: Wed, 16 Nov 2022 11:49:10 +0800
Message-ID: <20221116034910.37030-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/nice01: Add test nice(-1) and nice(-50)
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

1. Add test verify that the errno is zero when callling of nice
legitimately return -1.(nice(-1), the default nice is usally 0)
2. Add test verify that user of root can decrease the nice value of
the process successfully by passing a lower increment
value (< min. applicable limits) to nice() system call.(nice(-50))

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 testcases/kernel/syscalls/nice/nice01.c | 27 ++++++++++++++-----------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/syscalls/nice/nice01.c b/testcases/kernel/syscalls/nice/nice01.c
index 876246180..bc022a265 100644
--- a/testcases/kernel/syscalls/nice/nice01.c
+++ b/testcases/kernel/syscalls/nice/nice01.c
@@ -17,29 +17,31 @@
 #include <sys/resource.h>
 #include "tst_test.h"

-#define	NICEINC		-12
-#define MIN_PRIO	-20
+#define MIN_PRIO        -20

-static void verify_nice(void)
+static int nice_inc[] = {-1, -12, -50};
+
+static void verify_nice(unsigned int i)
 {
 	int new_nice;
 	int orig_nice;
 	int exp_nice;
+	int inc = nice_inc[i];

 	orig_nice = SAFE_GETPRIORITY(PRIO_PROCESS, 0);

-	TEST(nice(NICEINC));
+	TEST(nice(inc));

-	exp_nice = MAX(MIN_PRIO, (orig_nice + NICEINC));
+	exp_nice = MAX(MIN_PRIO, (orig_nice + inc));

 	if (TST_RET != exp_nice) {
 		tst_res(TFAIL | TTERRNO, "nice(%d) returned %li, expected %i",
-			NICEINC, TST_RET, exp_nice);
+				inc, TST_RET, exp_nice);
 		return;
 	}

 	if (TST_ERR) {
-		tst_res(TFAIL | TTERRNO, "nice(%d) failed", NICEINC);
+		tst_res(TFAIL | TTERRNO, "nice(%d) failed", inc);
 		return;
 	}

@@ -47,18 +49,19 @@ static void verify_nice(void)

 	if (new_nice != exp_nice) {
 		tst_res(TFAIL, "Process priority %i, expected %i",
-				new_nice, orig_nice + NICEINC);
+				new_nice, exp_nice);
 		return;
 	}

-	tst_res(TPASS, "nice(%d) passed", NICEINC);
+	tst_res(TPASS, "nice(%d) passed", inc);

-	TEST(nice(-NICEINC));
+	TEST(setpriority(PRIO_PROCESS, 0, orig_nice));
 	if (TST_ERR)
-		tst_brk(TBROK | TTERRNO, "nice(%d) failed", -NICEINC);
+		tst_brk(TBROK | TTERRNO, "setpriority(%d) failed", orig_nice);
 }

 static struct tst_test test = {
-	.test_all = verify_nice,
 	.needs_root = 1,
+	.test = verify_nice,
+	.tcnt = ARRAY_SIZE(nice_inc),
 };
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
