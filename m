Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382C7C433EF
	for <ltp@archiver.kernel.org>; Wed, 13 Apr 2022 11:41:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 483123CA5C1
	for <ltp@archiver.kernel.org>; Wed, 13 Apr 2022 13:41:33 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E9D0A3CA53D
 for <ltp@lists.linux.it>; Wed, 13 Apr 2022 13:41:23 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5BD101A0065A
 for <ltp@lists.linux.it>; Wed, 13 Apr 2022 13:41:20 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kdgbz3pnhzgYms
 for <ltp@lists.linux.it>; Wed, 13 Apr 2022 19:39:27 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 19:41:16 +0800
To: <ltp@lists.linux.it>
Date: Wed, 13 Apr 2022 19:40:14 +0800
Message-ID: <20220413114014.51577-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] futex_waitv04: Add test for futex_waitv syscall
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
 testcases/kernel/syscalls/futex/.gitignore    |  1 +
 .../kernel/syscalls/futex/futex_waitv04.c     | 83 +++++++++++++++++++
 2 files changed, 84 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_waitv04.c

diff --git a/testcases/kernel/syscalls/futex/.gitignore b/testcases/kernel/syscalls/futex/.gitignore
index 9d08ba7d3..13fd202f4 100644
--- a/testcases/kernel/syscalls/futex/.gitignore
+++ b/testcases/kernel/syscalls/futex/.gitignore
@@ -13,3 +13,4 @@
 /futex_waitv01
 /futex_waitv02
 /futex_waitv03
+/futex_waitv04
diff --git a/testcases/kernel/syscalls/futex/futex_waitv04.c b/testcases/kernel/syscalls/futex/futex_waitv04.c
new file mode 100644
index 000000000..783d481e9
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_waitv04.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2022 Zhao Gongyi <zhaogongyi@huawei.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies EAGIN and ETIMEDOUT for futex_waitv syscall.
+ */
+
+#include <time.h>
+#include "tst_test.h"
+#include "lapi/futex.h"
+#include "futex2test.h"
+#include "tst_safe_clocks.h"
+
+static uint32_t *futex;
+static struct futex_waitv *waitv;
+
+static void setup(void)
+{
+	futex = SAFE_MALLOC(sizeof(uint32_t));
+	*futex = FUTEX_INITIALIZER;
+}
+
+static void init_timeout(struct timespec *to)
+{
+	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC, to);
+	to->tv_sec++;
+}
+
+static void mismatch_between_uaddr_and_val(void)
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
+        struct timespec to;
+
+	waitv->uaddr = (uintptr_t)futex;
+	waitv->flags = FUTEX_32 | FUTEX_PRIVATE_FLAG;
+	waitv->val = 0;
+
+	init_timeout(&to);
+
+	TST_EXP_FAIL(futex_waitv(waitv, 1, 0, &to, CLOCK_REALTIME), ETIMEDOUT,
+		     "futex_waitv timeout");
+}
+
+static void cleanup(void)
+{
+	if (futex != NULL)
+		free(futex);
+}
+
+static void run(void)
+{
+	mismatch_between_uaddr_and_val();
+	test_timeout();
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_kver = "5.16",
+	.bufs =
+		(struct tst_buffers[]){
+			{ &waitv, .size = sizeof(struct futex_waitv) },
+			{},
+		},
+};
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
