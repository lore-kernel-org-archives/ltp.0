Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85775C433EF
	for <ltp@archiver.kernel.org>; Mon, 28 Mar 2022 11:51:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2806A3C980A
	for <ltp@archiver.kernel.org>; Mon, 28 Mar 2022 13:51:35 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 413A13C0325
 for <ltp@lists.linux.it>; Mon, 28 Mar 2022 13:51:22 +0200 (CEST)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 86B69200990
 for <ltp@lists.linux.it>; Mon, 28 Mar 2022 13:51:21 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.55])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KRrXN2N1hzBrbk;
 Mon, 28 Mar 2022 19:47:16 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Mar 2022 19:51:17 +0800
To: <ltp@lists.linux.it>
Date: Mon, 28 Mar 2022 19:50:26 +0800
Message-ID: <20220328115026.182554-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] io_pgetevents01: Move the SAFE_CLOSE to the suitable
 location
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
Cc: viresh.kumar@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

If we run the test with the option -i 10000, and the ulimit
of open files little than 10000, the test would fail and report
error of EMFILE.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 .../kernel/syscalls/io_pgetevents/io_pgetevents01.c      | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/io_pgetevents/io_pgetevents01.c b/testcases/kernel/syscalls/io_pgetevents/io_pgetevents01.c
index a0b56d814..0525221e8 100644
--- a/testcases/kernel/syscalls/io_pgetevents/io_pgetevents01.c
+++ b/testcases/kernel/syscalls/io_pgetevents/io_pgetevents01.c
@@ -28,12 +28,6 @@ static void setup(void)
 	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
 }

-static void cleanup(void)
-{
-	if (fd > 0)
-		SAFE_CLOSE(fd);
-}
-
 static void run(void)
 {
 	struct time64_variants *tv = &variants[tst_variant];
@@ -71,6 +65,8 @@ static void run(void)

 	if (io_destroy(ctx) < 0)
 		tst_brk(TBROK | TERRNO, "io_destroy() failed");
+
+	SAFE_CLOSE(fd);
 }

 static struct tst_test test = {
@@ -78,7 +74,6 @@ static struct tst_test test = {
 	.test_all = run,
 	.test_variants = ARRAY_SIZE(variants),
 	.needs_tmpdir = 1,
-	.cleanup = cleanup,
 	.setup = setup,
 };

--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
