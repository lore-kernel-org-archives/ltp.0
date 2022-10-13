Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A75C433FE
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 13:51:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC0B23CAED4
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 15:51:19 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AFDD83CA9C7
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 15:51:08 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 32553200C3E
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 15:51:07 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mp9ng5c7lzpVsL
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 21:47:51 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 21:51:03 +0800
To: <ltp@lists.linux.it>
Date: Thu, 13 Oct 2022 21:47:25 +0800
Message-ID: <20221013134728.49609-3-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221013134728.49609-1-zhaogongyi@huawei.com>
References: <20221013134728.49609-1-zhaogongyi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/4] syscalls/madvise04: new test for
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

Check that madvise(2) MADV_DONTNEED operation applied to Huge
TLB pages successfully after kernel version 5.18, and will result
in zero-fill-on-demand pages for anonymous private mappings.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/madvise/.gitignore  |  1 +
 testcases/kernel/syscalls/madvise/madvise04.c | 62 +++++++++++++++++++
 3 files changed, 64 insertions(+)
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
index 000000000..a970fb33e
--- /dev/null
+++ b/testcases/kernel/syscalls/madvise/madvise04.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Huawei Technologies Co., Ltd. 2022. All rights reserved.
+ * Author: Zhao Gongyi <zhaogongyi@huawei.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Check that madvise(2) MADV_DONTNEED operation applied to Huge TLB pages
+ * successfully after kernel version 5.18, and will result in
+ * zero-fill-on-demand pages for anonymous private mappings.
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
+	TST_EXP_PASS(madvise(addr, mapsz, MADV_DONTNEED));
+	for (int i = 0; i < mapsz; i++) {
+		if (addr[i]) {
+			tst_res(TFAIL,
+				"There are no zero-fill-on-demand pages "
+				"for anonymous private mappings");
+			return;
+		}
+	}
+
+	tst_res(TPASS, "There are zero-fill-on-demand pages "
+		       "for anonymous private mappings");
+}
+
+static void setup(void)
+{
+	mapsz = tst_get_hugepage_size();
+	addr = SAFE_MMAP(NULL, mapsz,
+			PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
+			-1, 0);
+	memset(addr, 1, mapsz);
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
+	.min_kver = "5.18",
+	.needs_root = 1,
+	.hugepages = {1, TST_NEEDS},
+};
+
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
