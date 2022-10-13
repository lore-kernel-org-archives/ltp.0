Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466F2C4332F
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 13:52:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 985EC3CAEFB
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 15:52:05 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8792F3CAED2
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 15:51:10 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 64389600E49
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 15:51:09 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mp9mF3z6PzVhtq
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 21:46:37 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 21:51:05 +0800
To: <ltp@lists.linux.it>
Date: Thu, 13 Oct 2022 21:47:27 +0800
Message-ID: <20221013134728.49609-5-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221013134728.49609-1-zhaogongyi@huawei.com>
References: <20221013134728.49609-1-zhaogongyi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 3/4] syscalls/madvise12: new test for
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

Check that after a successful madvise(2) MADV_REMOVE operation, subsequent
accesses in the specified address range will see bytes containing zero.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/madvise/.gitignore  |  1 +
 testcases/kernel/syscalls/madvise/madvise12.c | 85 +++++++++++++++++++
 3 files changed, 87 insertions(+)
 create mode 100644 testcases/kernel/syscalls/madvise/madvise12.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 296af9f9d..0697b31ab 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -949,6 +949,7 @@ madvise08 madvise08
 madvise09 madvise09
 madvise10 madvise10
 madvise11 madvise11
+madvise12 madvise12

 newuname01 newuname01

diff --git a/testcases/kernel/syscalls/madvise/.gitignore b/testcases/kernel/syscalls/madvise/.gitignore
index ffd8823d1..dc82c82bd 100644
--- a/testcases/kernel/syscalls/madvise/.gitignore
+++ b/testcases/kernel/syscalls/madvise/.gitignore
@@ -9,3 +9,4 @@
 /madvise09
 /madvise10
 /madvise11
+/madvise12
diff --git a/testcases/kernel/syscalls/madvise/madvise12.c b/testcases/kernel/syscalls/madvise/madvise12.c
new file mode 100644
index 000000000..7c22e464d
--- /dev/null
+++ b/testcases/kernel/syscalls/madvise/madvise12.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Huawei Technologies Co., Ltd. 2022. All rights reserved.
+ * Author: Zhao Gongyi <zhaogongyi@huawei.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Check that after a successful madvise(2) MADV_REMOVE operation, subsequent
+ * accesses in the specified address range will see bytes containing zero.
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
+static char *addr;
+static int fd;
+
+static void run(void)
+{
+	TEST(madvise(addr, MAP_SIZE, MADV_REMOVE));
+	if (TST_RET == -1) {
+		if (TST_ERR == EOPNOTSUPP)
+			tst_brk(TCONF, "'MADV_REMOVE' not supported?");
+		else {
+			tst_res(TFAIL | TTERRNO, "madvise(%p, %d, 0x%x) failed",
+				addr, MAP_SIZE, MADV_REMOVE);
+			return;
+		}
+	}
+
+	for (int i = 0; i < MAP_SIZE; i++) {
+		if (addr[0]) {
+			tst_res(TFAIL,
+				"The content of mapping memory is not removed");
+			return;
+		}
+	}
+
+	tst_res(TPASS, "The content of mapping memory is removed");
+}
+
+static void setup(void)
+{
+	fd = SAFE_OPEN(FNAME, O_CREAT | O_RDWR, 0777);
+	TEST(fallocate(fd, 0, 0, MAP_SIZE));
+	if (TST_RET) {
+		if (TST_ERR == ENOSYS || TST_ERR == EOPNOTSUPP)
+			tst_brk(TCONF, "fallocate not support");
+		else
+			tst_brk(TBROK | TERRNO, "fallocate failed");
+	}
+
+	addr = SAFE_MMAP(NULL, MAP_SIZE,
+			PROT_READ | PROT_WRITE,
+			MAP_SHARED,
+			fd, 0);
+	memset(addr, 1, MAP_SIZE);
+}
+
+static void cleanup(void)
+{
+	SAFE_CLOSE(fd);
+	SAFE_UNLINK(FNAME);
+	if (addr)
+		SAFE_MUNMAP(addr, MAP_SIZE);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_root = 1,
+	.min_kver = "2.6.16",
+	.setup = setup,
+	.cleanup = cleanup,
+	.all_filesystems = 1,
+	.mount_device = 1,
+	.mntpoint = MOUNT_POINT,
+};
+
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
