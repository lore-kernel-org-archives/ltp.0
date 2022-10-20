Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5252CC4332F
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 13:01:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4699C3CB1C4
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 15:01:43 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D3B253CB17D
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 15:01:23 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9B39A1A0115A
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 15:01:22 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MtSLt6kfWzpVbc
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 20:57:58 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 21:01:18 +0800
To: <ltp@lists.linux.it>
Date: Thu, 20 Oct 2022 20:57:46 +0800
Message-ID: <20221020125747.231509-2-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221020125747.231509-1-zhaogongyi@huawei.com>
References: <20221020125747.231509-1-zhaogongyi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] syscalls/nice06: new test for nice()
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

Verify that user of root can decrease the nice value of
the process successfully by passing a lower increment
value (< min. applicable limits) to nice() system call.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 runtest/syscalls                          |  1 +
 testcases/kernel/syscalls/nice/.gitignore |  1 +
 testcases/kernel/syscalls/nice/nice06.c   | 54 +++++++++++++++++++++++
 3 files changed, 56 insertions(+)
 create mode 100644 testcases/kernel/syscalls/nice/nice06.c

diff --git a/runtest/syscalls b/runtest/syscalls
index a52b93c92..557c946ec 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -902,6 +902,7 @@ nice02 nice02
 nice03 nice03
 nice04 nice04
 nice05 nice05
+nice06 nice06

 open01 open01
 open01A symlink01 -T open01
diff --git a/testcases/kernel/syscalls/nice/.gitignore b/testcases/kernel/syscalls/nice/.gitignore
index 58d64779e..c96064cdf 100644
--- a/testcases/kernel/syscalls/nice/.gitignore
+++ b/testcases/kernel/syscalls/nice/.gitignore
@@ -3,3 +3,4 @@
 /nice03
 /nice04
 /nice05
+/nice06
diff --git a/testcases/kernel/syscalls/nice/nice06.c b/testcases/kernel/syscalls/nice/nice06.c
new file mode 100644
index 000000000..92138f21e
--- /dev/null
+++ b/testcases/kernel/syscalls/nice/nice06.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright(c) 2022 Huawei Technologies Co., Ltd
+ * Author: Zhao Gongyi <zhaogongyi@huawei.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that user of root can decrease the nice value of
+ * the process successfully by passing a lower increment
+ * value (< min. applicable limits) to nice() system call.
+ */
+#include <unistd.h>
+#include "tst_test.h"
+
+#define	NICEINC -50
+#define MIN_PRIO  -20
+#define DEFAULT_PRIO 0
+
+static void verify_nice(void)
+{
+	int new_nice;
+
+	TEST(nice(NICEINC));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "nice(%d) returned -1", NICEINC);
+		return;
+	}
+
+	if (TST_ERR) {
+		tst_res(TFAIL | TTERRNO, "nice(%d) failed", NICEINC);
+		return;
+	}
+
+	new_nice = SAFE_GETPRIORITY(PRIO_PROCESS, 0);
+
+	if (new_nice != MIN_PRIO) {
+		tst_res(TFAIL, "Process priority %i, expected %i",
+			new_nice, MIN_PRIO);
+		return;
+	}
+
+	tst_res(TPASS, "nice(%d) passed", NICEINC);
+
+	TEST(nice(DEFAULT_PRIO));
+	if (TST_ERR)
+		tst_brk(TBROK | TTERRNO, "nice(%d) failed", DEFAULT_PRIO);
+}
+
+static struct tst_test test = {
+	.test_all = verify_nice,
+	.needs_root = 1,
+};
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
