Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3B2C43334
	for <ltp@archiver.kernel.org>; Wed,  8 Jun 2022 03:22:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA4B33C90BF
	for <ltp@archiver.kernel.org>; Wed,  8 Jun 2022 05:22:08 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 685113C02C2
 for <ltp@lists.linux.it>; Wed,  8 Jun 2022 05:21:58 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9AD6A200ADA
 for <ltp@lists.linux.it>; Wed,  8 Jun 2022 05:21:56 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LHssv26b0zgg1B
 for <ltp@lists.linux.it>; Wed,  8 Jun 2022 11:20:03 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 8 Jun 2022 11:21:51 +0800
To: <ltp@lists.linux.it>
Date: Wed, 8 Jun 2022 11:19:53 +0800
Message-ID: <20220608031953.152525-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] futex_waitv01: Add test verifies EAGIN/ETIMEDOUT
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
v2->v3:
	1. Replace CLOCK_REALTIME with CLOCK_MONOTONIC
	2. Change from 1s to 10ms for the timeout
 .../kernel/syscalls/futex/futex_waitv01.c     | 35 +++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/futex/futex_waitv01.c b/testcases/kernel/syscalls/futex/futex_waitv01.c
index f2c19b748..17b96738c 100644
--- a/testcases/kernel/syscalls/futex/futex_waitv01.c
+++ b/testcases/kernel/syscalls/futex/futex_waitv01.c
@@ -107,12 +107,41 @@ static void test_invalid_nr_futexes(void)
 	init_timeout(&to);

 	/* Valid nr_futexes is [1, 128] */
-	TST_EXP_FAIL(futex_waitv(waitv, 129, 0, &to, CLOCK_REALTIME), EINVAL,
+	TST_EXP_FAIL(futex_waitv(waitv, 129, 0, &to, CLOCK_MONOTONIC), EINVAL,
 		     "futex_waitv invalid nr_futexes");
-	TST_EXP_FAIL(futex_waitv(waitv, 0, 0, &to, CLOCK_REALTIME), EINVAL,
+	TST_EXP_FAIL(futex_waitv(waitv, 0, 0, &to, CLOCK_MONOTONIC), EINVAL,
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
+		     "futex_waitv mismatch between value of uaddr and val");
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
+	SAFE_CLOCK_GETTIME(CLOCK_REALTIME, &to);
+	to = tst_timespec_add_us(to, 10000);
+
+	TST_EXP_FAIL(futex_waitv(waitv, 1, 0, &to, CLOCK_REALTIME), ETIMEDOUT,
+		     "futex_waitv timeout");
+}
+
 static void cleanup(void)
 {
 	free(futex);
@@ -126,6 +155,8 @@ static void run(void)
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
