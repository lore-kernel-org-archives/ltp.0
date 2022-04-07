Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89558C433F5
	for <ltp@archiver.kernel.org>; Thu,  7 Apr 2022 07:59:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D14663CA497
	for <ltp@archiver.kernel.org>; Thu,  7 Apr 2022 09:59:16 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF7403CA2DB
 for <ltp@lists.linux.it>; Thu,  7 Apr 2022 09:59:06 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5FA656008C8
 for <ltp@lists.linux.it>; Thu,  7 Apr 2022 09:59:03 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KYtyK3p69zgYNd
 for <ltp@lists.linux.it>; Thu,  7 Apr 2022 15:57:13 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Apr 2022 15:58:58 +0800
To: <ltp@lists.linux.it>
Date: Thu, 7 Apr 2022 15:57:58 +0800
Message-ID: <20220407075758.40561-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] futex_waitv01: Add test verifies EINVAL for invalid
 nr_futexes
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

Add test verifies EINVAL for invalid nr_futexes according to
https://www.kernel.org/doc/html/latest/userspace-api/futex2.html.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 testcases/kernel/syscalls/futex/futex_waitv01.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/testcases/kernel/syscalls/futex/futex_waitv01.c b/testcases/kernel/syscalls/futex/futex_waitv01.c
index 601fee8df..525420647 100644
--- a/testcases/kernel/syscalls/futex/futex_waitv01.c
+++ b/testcases/kernel/syscalls/futex/futex_waitv01.c
@@ -98,6 +98,17 @@ static void test_invalid_clockid(void)
 		     "futex_waitv invalid clockid");
 }

+static void test_invalid_nr_futex(void)
+{
+	struct timespec to;
+	init_waitv();
+	init_timeout(&to);
+
+	/* Valid nr_futex is [1, 128] */
+	TST_EXP_FAIL(futex_waitv(waitv, 129, 0, &to, CLOCK_REALTIME), EINVAL,
+		     "futex_waitv invalid nr_futex");
+}
+
 static void run(void)
 {
 	test_invalid_flags();
@@ -105,6 +116,7 @@ static void run(void)
 	test_null_address();
 	test_null_waiters();
 	test_invalid_clockid();
+	test_invalid_nr_futex();
 }

 static struct tst_test test = {
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
