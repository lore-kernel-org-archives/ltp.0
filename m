Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C13C433F5
	for <ltp@archiver.kernel.org>; Fri,  8 Apr 2022 09:19:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 64C153CA50D
	for <ltp@archiver.kernel.org>; Fri,  8 Apr 2022 11:19:08 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 192B43CA4E2
 for <ltp@lists.linux.it>; Fri,  8 Apr 2022 11:18:56 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1002B10009EB
 for <ltp@lists.linux.it>; Fri,  8 Apr 2022 11:18:54 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KZXfx6QHLzFpgB
 for <ltp@lists.linux.it>; Fri,  8 Apr 2022 17:16:09 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 8 Apr 2022 17:18:30 +0800
To: <ltp@lists.linux.it>
Date: Fri, 8 Apr 2022 17:17:33 +0800
Message-ID: <20220408091733.15323-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] futex_waitv01: Add test verifies EINVAL for
 invalid nr_futexes
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
v1->v2: Check also lower bound that suggested by Andrea Cervesato

 testcases/kernel/syscalls/futex/futex_waitv01.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/testcases/kernel/syscalls/futex/futex_waitv01.c b/testcases/kernel/syscalls/futex/futex_waitv01.c
index 601fee8df..721852750 100644
--- a/testcases/kernel/syscalls/futex/futex_waitv01.c
+++ b/testcases/kernel/syscalls/futex/futex_waitv01.c
@@ -98,6 +98,19 @@ static void test_invalid_clockid(void)
 		     "futex_waitv invalid clockid");
 }

+static void test_invalid_nr_futex(void)
+{
+	struct timespec to;
+	init_waitv();
+	init_timeout(&to);
+
+	/* Valid nr_futexes is [1, 128] */
+	TST_EXP_FAIL(futex_waitv(waitv, 129, 0, &to, CLOCK_REALTIME), EINVAL,
+		     "futex_waitv invalid nr_futexes");
+	TST_EXP_FAIL(futex_waitv(waitv, 0, 0, &to, CLOCK_REALTIME), EINVAL,
+		     "futex_waitv invalid nr_futexes");
+}
+
 static void run(void)
 {
 	test_invalid_flags();
@@ -105,6 +118,7 @@ static void run(void)
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
