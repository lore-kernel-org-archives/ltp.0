Return-Path: <SRS0=uAqx=PY=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1B5C433EF
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 02:06:15 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA0A560E97
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 02:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BA0A560E97
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AEDE33C736D
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 03:06:12 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 58E303C559D
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 03:06:01 +0100 (CET)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E1295601C6A
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 03:05:59 +0100 (CET)
Received: from dggeml753-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HlkPN5f8Cz90p1
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 10:05:44 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 dggeml753-chm.china.huawei.com (10.1.199.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Fri, 5 Nov 2021 10:05:55 +0800
From: Zhao Gongyi <zhaogongyi@huawei.com>
To: <ltp@lists.linux.it>
Date: Fri, 5 Nov 2021 10:07:29 +0800
Message-ID: <20211105020729.162391-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeml753-chm.china.huawei.com (10.1.199.152)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/epoll_create: add libc test for
 epoll_create
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

For epoll_create01.c/epoll_create02.c, we add libc epoll_create()
test because Syscall __NR_epoll_create is not support in some arches.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
v1->v2: remain syscall test

 .../syscalls/epoll_create/epoll_create01.c    | 30 ++++++++++++++++--
 .../syscalls/epoll_create/epoll_create02.c    | 31 +++++++++++++++++--
 2 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/epoll_create/epoll_create01.c b/testcases/kernel/syscalls/epoll_create/epoll_create01.c
index 3ef5b5cac..5b9b48e73 100644
--- a/testcases/kernel/syscalls/epoll_create/epoll_create01.c
+++ b/testcases/kernel/syscalls/epoll_create/epoll_create01.c
@@ -15,23 +15,49 @@
  */

 #include <sys/epoll.h>
-
 #include "tst_test.h"
 #include "lapi/epoll.h"
 #include "lapi/syscalls.h"

 static int tc[] = {1, INT_MAX};

+static int do_epoll_create(int size)
+{
+	switch (tst_variant) {
+	case 0:
+		return tst_syscall(__NR_epoll_create, size);
+	break;
+	case 1:
+		return epoll_create(size);
+	break;
+	}
+}
+
+
 static void run(unsigned int n)
 {
-	TST_EXP_FD(tst_syscall(__NR_epoll_create, tc[n]), "epoll_create(%d)", tc[n]);
+	TST_EXP_FD(do_epoll_create(tc[n]), "epoll_create(%d)", tc[n]);

 	if (!TST_PASS)
 		return;
 	SAFE_CLOSE(TST_RET);
 }

+static void setup(void)
+{
+	switch (tst_variant) {
+	case 0:
+		tst_res(TINFO, "Testing variant: syscall __NR_epoll_create");
+	break;
+	case 1:
+		tst_res(TINFO, "Testing variant: libc epoll_create()");
+	break;
+	}
+}
+
 static struct tst_test test = {
+	.test_variants = 2,
 	.tcnt = ARRAY_SIZE(tc),
+	.setup = setup,
 	.test = run,
 };
diff --git a/testcases/kernel/syscalls/epoll_create/epoll_create02.c b/testcases/kernel/syscalls/epoll_create/epoll_create02.c
index c59ea7944..f19d58882 100644
--- a/testcases/kernel/syscalls/epoll_create/epoll_create02.c
+++ b/testcases/kernel/syscalls/epoll_create/epoll_create02.c
@@ -25,13 +25,40 @@ static struct test_case_t {
 	{-1, EINVAL}
 };

+static int do_epoll_create(int size)
+{
+	switch (tst_variant) {
+	case 0:
+		return tst_syscall(__NR_epoll_create, size);
+	break;
+	case 1:
+		return epoll_create(size);
+	break;
+	}
+}
+
 static void run(unsigned int n)
 {
-	TST_EXP_FAIL(tst_syscall(__NR_epoll_create, tc[n].size),
-		     tc[n].exp_err, "create(%d)", tc[n].size);
+	TST_EXP_FAIL(do_epoll_create(tc[n].size),
+		     tc[n].exp_err, "epoll_create(%d)", tc[n].size);
 }

+static void setup(void)
+{
+	switch (tst_variant) {
+	case 0:
+		tst_res(TINFO, "Testing variant: syscall __NR_epoll_create");
+	break;
+	case 1:
+		tst_res(TINFO, "Testing variant: libc epoll_create()");
+	break;
+	}
+}
+
+
 static struct tst_test test = {
+	.test_variants = 2,
 	.tcnt = ARRAY_SIZE(tc),
+	.setup = setup,
 	.test = run,
 };
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
