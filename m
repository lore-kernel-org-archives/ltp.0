Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9081FC3F6B0
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 12:54:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CDA8A3CA457
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 14:54:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 257F23CA45D
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 14:54:19 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A6668600082
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 14:54:16 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MD2rH1P56zkWg0
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 20:50:39 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 25 Aug 2022 20:54:10 +0800
To: <ltp@lists.linux.it>
Date: Thu, 25 Aug 2022 20:50:54 +0800
Message-ID: <20220825125054.1074-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/nice: Adjust the expected priority after
 calling nice()
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

If we run test as nice -n -10 ./nice01, it will fail and report:

nice01.c:37: TFAIL: nice(-12) returned -20, expected -22: SUCCESS (0)

for nice01.c/nice02.c: correct log info.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 testcases/kernel/syscalls/nice/nice01.c | 14 +++++++++-----
 testcases/kernel/syscalls/nice/nice02.c |  2 +-
 testcases/kernel/syscalls/nice/nice03.c |  7 +++++--
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/nice/nice01.c b/testcases/kernel/syscalls/nice/nice01.c
index ee360bfbf..876246180 100644
--- a/testcases/kernel/syscalls/nice/nice01.c
+++ b/testcases/kernel/syscalls/nice/nice01.c
@@ -18,19 +18,23 @@
 #include "tst_test.h"

 #define	NICEINC		-12
+#define MIN_PRIO	-20

 static void verify_nice(void)
 {
 	int new_nice;
 	int orig_nice;
+	int exp_nice;

 	orig_nice = SAFE_GETPRIORITY(PRIO_PROCESS, 0);

 	TEST(nice(NICEINC));

-	if (TST_RET != (orig_nice + NICEINC)) {
+	exp_nice = MAX(MIN_PRIO, (orig_nice + NICEINC));
+
+	if (TST_RET != exp_nice) {
 		tst_res(TFAIL | TTERRNO, "nice(%d) returned %li, expected %i",
-			NICEINC, TST_RET, orig_nice + NICEINC);
+			NICEINC, TST_RET, exp_nice);
 		return;
 	}

@@ -41,9 +45,9 @@ static void verify_nice(void)

 	new_nice = SAFE_GETPRIORITY(PRIO_PROCESS, 0);

-	if (new_nice != (orig_nice + NICEINC)) {
+	if (new_nice != exp_nice) {
 		tst_res(TFAIL, "Process priority %i, expected %i",
-		        new_nice, orig_nice + NICEINC);
+				new_nice, orig_nice + NICEINC);
 		return;
 	}

@@ -51,7 +55,7 @@ static void verify_nice(void)

 	TEST(nice(-NICEINC));
 	if (TST_ERR)
-		tst_brk(TBROK | TTERRNO, "nice(-NICEINC) failed");
+		tst_brk(TBROK | TTERRNO, "nice(%d) failed", -NICEINC);
 }

 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/nice/nice02.c b/testcases/kernel/syscalls/nice/nice02.c
index 1c7103758..b08e1d751 100644
--- a/testcases/kernel/syscalls/nice/nice02.c
+++ b/testcases/kernel/syscalls/nice/nice02.c
@@ -50,7 +50,7 @@ static void verify_nice(void)

 	TEST(nice(DEFAULT_PRIO));
 	if (TST_ERR)
-		tst_brk(TBROK | TTERRNO, "nice(-NICEINC) failed");
+		tst_brk(TBROK | TTERRNO, "nice(%d) failed", DEFAULT_PRIO);
 }

 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/nice/nice03.c b/testcases/kernel/syscalls/nice/nice03.c
index 8198f2cf0..061592e6c 100644
--- a/testcases/kernel/syscalls/nice/nice03.c
+++ b/testcases/kernel/syscalls/nice/nice03.c
@@ -19,11 +19,13 @@
 #include "tst_test.h"

 #define	NICEINC	2
+#define MAX_PRIO 19

 static void nice_test(void)
 {
 	int new_nice;
 	int orig_nice;
+	int exp_nice;

 	orig_nice = SAFE_GETPRIORITY(PRIO_PROCESS, 0);

@@ -40,10 +42,11 @@ static void nice_test(void)
 	}

 	new_nice = SAFE_GETPRIORITY(PRIO_PROCESS, 0);
+	exp_nice = MIN(MAX_PRIO, (orig_nice + NICEINC));

-	if (new_nice != (orig_nice + NICEINC)) {
+	if (new_nice != exp_nice) {
 		tst_res(TFAIL, "Process priority %i, expected %i",
-		        new_nice, orig_nice + NICEINC);
+				new_nice, exp_nice);
 		return;
 	}

--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
