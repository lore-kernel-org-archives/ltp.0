Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99011C433FE
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 13:52:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 18BA63CAEFD
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 15:52:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB8B23CAED8
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 15:51:10 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C410010009A3
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 15:51:09 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mp9mG4mR7zVhvR
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 21:46:38 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 21:51:06 +0800
To: <ltp@lists.linux.it>
Date: Thu, 13 Oct 2022 21:47:28 +0800
Message-ID: <20221013134728.49609-6-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221013134728.49609-1-zhaogongyi@huawei.com>
References: <20221013134728.49609-1-zhaogongyi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 4/4] syscalls/madvise13: new test for
 madvise(MADV_REMOVE)
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

Check that the specified address range must be mapped shared and writable
and this flag cannot be applied to locked pages.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/madvise/.gitignore  |  1 +
 testcases/kernel/syscalls/madvise/madvise13.c | 80 +++++++++++++++++++
 3 files changed, 82 insertions(+)
 create mode 100644 testcases/kernel/syscalls/madvise/madvise13.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 0697b31ab..bd74373a4 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -950,6 +950,7 @@ madvise09 madvise09
 madvise10 madvise10
 madvise11 madvise11
 madvise12 madvise12
+madvise13 madvise13

 newuname01 newuname01

diff --git a/testcases/kernel/syscalls/madvise/.gitignore b/testcases/kernel/syscalls/madvise/.gitignore
index dc82c82bd..fcf04c749 100644
--- a/testcases/kernel/syscalls/madvise/.gitignore
+++ b/testcases/kernel/syscalls/madvise/.gitignore
@@ -10,3 +10,4 @@
 /madvise10
 /madvise11
 /madvise12
+/madvise13
diff --git a/testcases/kernel/syscalls/madvise/madvise13.c b/testcases/kernel/syscalls/madvise/madvise13.c
new file mode 100644
index 000000000..15b17a6a8
--- /dev/null
+++ b/testcases/kernel/syscalls/madvise/madvise13.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Huawei Technologies Co., Ltd. 2022. All rights reserved.
+ * Author: Zhao Gongyi <zhaogongyi@huawei.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Check that in madvise(2) MADV_REMOVE operation, the specified address
+ * range must be mapped shared and writable and this flag cannot be applied
+ * to locked pages.
+ */
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include "tst_test.h"
+
+#define MAP_SIZE (8 * 1024)
+#define FNAME "madvise_remove"
+#define MOUNT_POINT "mntpoint"
+
+static int fd;
+static struct tcase {
+	int prot;
+	int flags;
+	int exp;
+	int err;
+} tcases[] = {
+	{PROT_READ, MAP_PRIVATE, -1, EACCES},
+	{PROT_READ, MAP_PRIVATE | MAP_LOCKED, -1, EINVAL},
+	{PROT_READ, MAP_SHARED, -1, EACCES},
+	{PROT_READ, MAP_SHARED | MAP_LOCKED, -1, EINVAL},
+	{PROT_WRITE, MAP_PRIVATE, -1, EACCES},
+	{PROT_WRITE, MAP_PRIVATE | MAP_LOCKED, -1, EINVAL},
+	{PROT_WRITE, MAP_SHARED | MAP_LOCKED, -1, EINVAL},
+	{PROT_WRITE, MAP_SHARED, 0, 0},
+	{PROT_WRITE | PROT_READ, MAP_SHARED, 0, 0},
+};
+
+
+static void run(unsigned int i)
+{
+	char *addr = SAFE_MMAP(NULL, MAP_SIZE,
+			tcases[i].prot,
+			tcases[i].flags,
+			fd, 0);
+
+	if (tcases[i].exp)
+		TST_EXP_FAIL(madvise(addr, MAP_SIZE, MADV_REMOVE),
+			     tcases[i].err);
+	else
+		TST_EXP_PASS(madvise(addr, MAP_SIZE, MADV_REMOVE));
+
+	SAFE_MUNMAP(addr, MAP_SIZE);
+}
+
+static void setup(void)
+{
+	fd = SAFE_OPEN(FNAME, O_CREAT | O_RDWR, 0777);
+}
+
+static void cleanup(void)
+{
+	SAFE_CLOSE(fd);
+	SAFE_UNLINK(FNAME);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+	.min_kver = "2.6.16",
+	.setup = setup,
+	.cleanup = cleanup,
+	.all_filesystems = 1,
+	.mntpoint = MOUNT_POINT,
+	.mount_device = 1,
+};
+
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
