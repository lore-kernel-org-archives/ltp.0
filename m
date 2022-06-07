Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5FFC433EF
	for <ltp@archiver.kernel.org>; Tue,  7 Jun 2022 02:56:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B9343C8EC7
	for <ltp@archiver.kernel.org>; Tue,  7 Jun 2022 04:56:52 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7444F3C08DA
 for <ltp@lists.linux.it>; Tue,  7 Jun 2022 04:56:40 +0200 (CEST)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D97CD1400991
 for <ltp@lists.linux.it>; Tue,  7 Jun 2022 04:56:37 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.55])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LHFNw1blzzpW34
 for <ltp@lists.linux.it>; Tue,  7 Jun 2022 10:56:16 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 7 Jun 2022 10:56:33 +0800
To: <ltp@lists.linux.it>
Date: Tue, 7 Jun 2022 10:54:35 +0800
Message-ID: <20220607025435.184105-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] futex_waitv01: Add test verifies EAGIN/ETIMEDOUT
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

Add test verifies EAGIN/ETIMEDOUT for futex_waitv according to
https://www.kernel.org/doc/html/latest/userspace-api/futex2.html.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
v1->v1: move test code to futex_waitv01.c
 .../kernel/syscalls/futex/futex_waitv01.c     | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/testcases/kernel/syscalls/futex/futex_waitv01.c b/testcases/kernel/syscalls/futex/futex_waitv01.c
index f2c19b748..2d905fa5f 100644
--- a/testcases/kernel/syscalls/futex/futex_waitv01.c
+++ b/testcases/kernel/syscalls/futex/futex_waitv01.c
@@ -113,6 +113,34 @@ static void test_invalid_nr_futexes(void)
 		     "futex_waitv invalid nr_futexes");
 }

+static void test_mismatch_between_uaddr_and_val(void)
+{
+	struct timespec to;
+
+	waitv->uaddr = (uintptr_t)futex;
+	waitv->flags = FUTEX_32 | FUTEX_PRIVATE_FLAG;
+	waitv->val = 1;
+
+	init_timeout(&to);
+
+	TST_EXP_FAIL(futex_waitv(waitv, 1, 0, &to, CLOCK_MONOTONIC), EAGAIN,
+			"futex_waitv mismatch between value of uaddr and val");
+}
+
+static void test_timeout(void)
+{
+	struct timespec to;
+
+	waitv->uaddr = (uintptr_t)futex;
+	waitv->flags = FUTEX_32 | FUTEX_PRIVATE_FLAG;
+	waitv->val = 0;
+
+	init_timeout(&to);
+
+	TST_EXP_FAIL(futex_waitv(waitv, 1, 0, &to, CLOCK_REALTIME), ETIMEDOUT,
+			"futex_waitv timeout");
+}
+
 static void cleanup(void)
 {
 	free(futex);
@@ -126,6 +154,8 @@ static void run(void)
 	test_null_waiters();
 	test_invalid_clockid();
 	test_invalid_nr_futexes();
+	test_mismatch_between_uaddr_and_val();
+	test_timeout();
 }

 static struct tst_test test = {
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
