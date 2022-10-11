Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F096AC4332F
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 12:20:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6BDD03CAE9B
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 14:20:20 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 195B53CAE93
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 14:19:49 +0200 (CEST)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F0B201000B25
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 14:19:48 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.55])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Mmvqg30fMz1M8xq
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 20:15:11 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 20:19:44 +0800
To: <ltp@lists.linux.it>
Date: Tue, 11 Oct 2022 20:16:06 +0800
Message-ID: <20221011121607.55575-3-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221011121607.55575-1-zhaogongyi@huawei.com>
References: <20221011121607.55575-1-zhaogongyi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/3] syscalls/madvise04: new test for
 madvise(MADV_DONTNEED)
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

Test cases for madvise(2) system call, verify that MADV_DONTNEED
cannot be applied to Huge TLB pages.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/madvise/.gitignore  |  1 +
 testcases/kernel/syscalls/madvise/madvise04.c | 48 +++++++++++++++++++
 3 files changed, 50 insertions(+)
 create mode 100644 testcases/kernel/syscalls/madvise/madvise04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index c81764df4..eb1910cec 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -941,6 +941,7 @@ mincore04 mincore04
 madvise01 madvise01
 madvise02 madvise02
 madvise03 madvise03
+madvise04 madvise04
 madvise05 madvise05
 madvise06 madvise06
 madvise07 madvise07
diff --git a/testcases/kernel/syscalls/madvise/.gitignore b/testcases/kernel/syscalls/madvise/.gitignore
index f4bfdfefe..db8ce47c1 100644
--- a/testcases/kernel/syscalls/madvise/.gitignore
+++ b/testcases/kernel/syscalls/madvise/.gitignore
@@ -1,6 +1,7 @@
 /madvise01
 /madvise02
 /madvise03
+/madvise04
 /madvise05
 /madvise06
 /madvise07
diff --git a/testcases/kernel/syscalls/madvise/madvise04.c b/testcases/kernel/syscalls/madvise/madvise04.c
new file mode 100644
index 000000000..d7ccaf97e
--- /dev/null
+++ b/testcases/kernel/syscalls/madvise/madvise04.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Huawei Technologies Co., Ltd. 2022. All rights reserved.
+ * Author: Zhao Gongyi <zhaogongyi@huawei.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Test cases for madvise(2) system call, advise value as "MADV_MADV_DONTNEED":
+ *   MADV_DONTNEED cannot be applied to Huge TLB pages.
+ */
+
+#include "tst_test.h"
+
+#define MAP_SIZE (8 * 1024)
+
+static char *addr;
+static int mapsz;
+
+static void run(void)
+{
+	TST_EXP_FAIL(madvise(addr, mapsz, MADV_DONTNEED), EINVAL);
+}
+
+static void setup(void)
+{
+	mapsz = tst_get_hugepage_size();
+	addr = SAFE_MMAP(NULL, mapsz,
+			PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
+			-1, 0);
+}
+
+static void cleanup(void)
+{
+	if (addr)
+		SAFE_MUNMAP(addr, mapsz);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.hugepages = {1, TST_NEEDS},
+};
+
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
