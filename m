Return-Path: <SRS0=5Ww9=PQ=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B6FC433F5
	for <ltp@archiver.kernel.org>; Thu, 28 Oct 2021 03:13:08 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEE87604E9
	for <ltp@archiver.kernel.org>; Thu, 28 Oct 2021 03:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DEE87604E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7649C3C6A52
	for <ltp@archiver.kernel.org>; Thu, 28 Oct 2021 05:13:04 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6AF783C6349
 for <ltp@lists.linux.it>; Thu, 28 Oct 2021 05:12:53 +0200 (CEST)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1390010006CC
 for <ltp@lists.linux.it>; Thu, 28 Oct 2021 05:12:50 +0200 (CEST)
Received: from dggeml753-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HfrDp6z0Yz8tw7
 for <ltp@lists.linux.it>; Thu, 28 Oct 2021 11:11:22 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 dggeml753-chm.china.huawei.com (10.1.199.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Thu, 28 Oct 2021 11:12:44 +0800
From: Zhao Gongyi <zhaogongyi@huawei.com>
To: <ltp@lists.linux.it>
Date: Thu, 28 Oct 2021 11:14:22 +0800
Message-ID: <20211028031422.208689-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeml753-chm.china.huawei.com (10.1.199.152)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/epoll_create: Replace syscall to libc
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

For epoll_create01.c/epoll_create02.c, we should replace syscall to libc
or the testcase will fail because of Syscall epoll_create is not support
in some arches.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 testcases/kernel/syscalls/epoll_create/epoll_create01.c | 2 +-
 testcases/kernel/syscalls/epoll_create/epoll_create02.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/epoll_create/epoll_create01.c b/testcases/kernel/syscalls/epoll_create/epoll_create01.c
index 3ef5b5cac..b6ebe9ad7 100644
--- a/testcases/kernel/syscalls/epoll_create/epoll_create01.c
+++ b/testcases/kernel/syscalls/epoll_create/epoll_create01.c
@@ -24,7 +24,7 @@ static int tc[] = {1, INT_MAX};

 static void run(unsigned int n)
 {
-	TST_EXP_FD(tst_syscall(__NR_epoll_create, tc[n]), "epoll_create(%d)", tc[n]);
+	TST_EXP_FD(epoll_create(tc[n]), "epoll_create(%d)", tc[n]);

 	if (!TST_PASS)
 		return;
diff --git a/testcases/kernel/syscalls/epoll_create/epoll_create02.c b/testcases/kernel/syscalls/epoll_create/epoll_create02.c
index c59ea7944..e96228983 100644
--- a/testcases/kernel/syscalls/epoll_create/epoll_create02.c
+++ b/testcases/kernel/syscalls/epoll_create/epoll_create02.c
@@ -27,7 +27,7 @@ static struct test_case_t {

 static void run(unsigned int n)
 {
-	TST_EXP_FAIL(tst_syscall(__NR_epoll_create, tc[n].size),
+	TST_EXP_FAIL(epoll_create(tc[n].size),
 		     tc[n].exp_err, "create(%d)", tc[n].size);
 }

--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
