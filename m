Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDB9C433F5
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 03:11:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 953CA3CAE73
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 05:11:53 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7BEE3C1B92
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 05:11:43 +0200 (CEST)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2CDA51A002C9
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 05:11:40 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Mm3jh6VYHz1P6nP
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 11:07:04 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 11:11:36 +0800
To: <ltp@lists.linux.it>
Date: Mon, 10 Oct 2022 11:07:59 +0800
Message-ID: <20221010030759.248442-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/madvise11: new test for
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

Test cases for madvise(2) system call, advise value as "MADV_MADV_DONTNEED":
1. After a successful MADV_DONTNEED operation, it will result in
zero-fill-on-demand pages for anonymous private mappings
2. MADV_DONTNEED cannot be applied to Huge TLB pages

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/madvise/.gitignore  |  1 +
 testcases/kernel/syscalls/madvise/madvise11.c | 87 +++++++++++++++++++
 3 files changed, 89 insertions(+)
 create mode 100644 testcases/kernel/syscalls/madvise/madvise11.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 61a7b7677..a8ed9d65e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -946,6 +946,7 @@ madvise07 madvise07
 madvise08 madvise08
 madvise09 madvise09
 madvise10 madvise10
+madvise11 madvise11

 newuname01 newuname01

diff --git a/testcases/kernel/syscalls/madvise/.gitignore b/testcases/kernel/syscalls/madvise/.gitignore
index 002d8e5d9..6e5b92ab7 100644
--- a/testcases/kernel/syscalls/madvise/.gitignore
+++ b/testcases/kernel/syscalls/madvise/.gitignore
@@ -6,3 +6,4 @@
 /madvise08
 /madvise09
 /madvise10
+/madvise11
diff --git a/testcases/kernel/syscalls/madvise/madvise11.c b/testcases/kernel/syscalls/madvise/madvise11.c
new file mode 100644
index 000000000..358c07d3a
--- /dev/null
+++ b/testcases/kernel/syscalls/madvise/madvise11.c
@@ -0,0 +1,87 @@
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
+ * 1. After a successful MADV_DONTNEED operation, it will result in
+ *    zero-fill-on-demand pages for anonymous private mappings
+ * 2. MADV_DONTNEED cannot be applied to Huge TLB pages
+ */
+
+#include "tst_test.h"
+
+#define MAP_SIZE (8 * 1024)
+
+static char *addr;
+
+static void test_madvise01(void)
+{
+	int i;
+
+	addr = SAFE_MMAP(NULL, MAP_SIZE,
+			PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS,
+			-1, 0);
+	memset(addr, 1, MAP_SIZE);
+
+	TEST(madvise(addr, MAP_SIZE, MADV_DONTNEED));
+	if (TST_RET == -1) {
+		tst_brk(TBROK | TTERRNO, "madvise(%p, %d, 0x%x) failed",
+			addr, MAP_SIZE, MADV_DONTNEED);
+	}
+
+	for (i = 0; i < MAP_SIZE; i++) {
+		if (addr[i]) {
+			tst_res(TFAIL,
+				"There are no zero-fill-on-demand pages "
+				"for anonymous private mappings");
+			break;
+		}
+	}
+
+	if (i == MAP_SIZE) {
+		tst_res(TPASS,
+			"There are zero-fill-on-demand pages "
+			"for anonymous private mappings");
+	}
+
+	SAFE_MUNMAP(addr, MAP_SIZE);
+}
+
+static void test_madvise02(void)
+{
+	int mapsz = tst_get_hugepage_size();
+
+	addr = SAFE_MMAP(NULL, mapsz,
+			PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
+			-1, 0);
+
+	TEST(madvise(addr, mapsz, MADV_DONTNEED));
+	if (TST_RET != -1) {
+		tst_res(TFAIL, "madvise(%p, %d, 0x%x) succeed unexpectedly",
+			addr, mapsz, MADV_DONTNEED);
+	} else {
+		tst_res(TPASS, "madvise test for 'MADV_DONTNEED' passed");
+	}
+
+	SAFE_MUNMAP(addr, mapsz);
+}
+
+static void test_madvise(void)
+{
+	test_madvise01();
+	test_madvise02();
+}
+
+static struct tst_test test = {
+	.test_all = test_madvise,
+	.needs_root = 1,
+	.hugepages = {1, TST_NEEDS},
+};
+
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
