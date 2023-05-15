Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41467C7EE22
	for <ltp@archiver.kernel.org>; Mon, 15 May 2023 07:12:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 076743CDD6F
	for <ltp@archiver.kernel.org>; Mon, 15 May 2023 09:12:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E3703CD4E3
 for <ltp@lists.linux.it>; Mon, 15 May 2023 09:11:52 +0200 (CEST)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com
 [139.138.36.223])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8C6886005CB
 for <ltp@lists.linux.it>; Mon, 15 May 2023 09:11:50 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="104898090"
X-IronPort-AV: E=Sophos;i="5.99,275,1677510000"; d="scan'208";a="104898090"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2023 16:11:46 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id F07A0EDEA8
 for <ltp@lists.linux.it>; Mon, 15 May 2023 16:11:44 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 286B8D5B3A
 for <ltp@lists.linux.it>; Mon, 15 May 2023 16:11:44 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 973E637C45;
 Mon, 15 May 2023 16:11:43 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Mon, 15 May 2023 15:11:20 +0800
Message-Id: <1684134680-6190-6-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1684134680-6190-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1684134680-6190-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27626.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27626.005
X-TMASE-Result: 10--18.727900-10.000000
X-TMASE-MatchedRID: dEuj5lzoN6Y0b21ExFN2+hFbgtHjUWLy+VJ6lZyB0s8TMFL8shgf91h/
 NuUojaGGGIr2zyxIm4zyCZGzF+DOCba2Vh2jQ2eEOIQ9GP2P2u/lsyZ05iz8bzoUdFbHYUawjdx
 5FdhImgMi+t+0AiFaYvL3NxFKQpq1PjGcaJx+0AEZgmFGHqyx6x+KaaVwAG43J8lOf52acVAaZW
 50SGemhLX80TaNz00Ya5pnQWY12EgqXuKH5Jbj7Fk1hIeTdmvRSLyuC617NWlGMWj5IurYalVxc
 /d4wt8XtHjg2Z6JaYQKRuKRI67R4IgaBXLWjoTfxi///JpaHQMXivwflisSrAbxceezd6S1rLaE
 LwoCkYuOsnMig9C4zBUdpx4K1EAjNyl1nd9CIt0URSScn+QSXt0H8LFZNFG7/nnwJ52QYi+pygC
 GKFPC+BeYl5uS2QAg
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 6/6] syscalls/statx11: Add basic test for
 STATX_DIOALIGN on block device
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Since STATX_DIOLAIGN is only supported on regular file and block device,
so this case is used to test the latter.

This test is tightly coupled to the kernel's current DIO restrictions on block
devices.  These changed in v6.0, and they are subject to further change in the
future.

It is fine for now because STATX_DIOALIGN is only in v6.1 and later
anyway.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                           |  1 +
 testcases/kernel/syscalls/statx/.gitignore |  1 +
 testcases/kernel/syscalls/statx/statx11.c  | 89 ++++++++++++++++++++++
 3 files changed, 91 insertions(+)
 create mode 100644 testcases/kernel/syscalls/statx/statx11.c

diff --git a/runtest/syscalls b/runtest/syscalls
index e2548dae5..e5ad2c2f9 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1766,6 +1766,7 @@ statx07 statx07
 statx08 statx08
 statx09 statx09
 statx10 statx10
+statx11 statx11
 
 membarrier01 membarrier01
 
diff --git a/testcases/kernel/syscalls/statx/.gitignore b/testcases/kernel/syscalls/statx/.gitignore
index 67341ff2d..48ac4078b 100644
--- a/testcases/kernel/syscalls/statx/.gitignore
+++ b/testcases/kernel/syscalls/statx/.gitignore
@@ -8,3 +8,4 @@
 /statx08
 /statx09
 /statx10
+/statx11
diff --git a/testcases/kernel/syscalls/statx/statx11.c b/testcases/kernel/syscalls/statx/statx11.c
new file mode 100644
index 000000000..653050855
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx11.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * It is a basic test for STATX_DIOALIGN mask on block device.
+ *
+ * - STATX_DIOALIGN   Want stx_dio_mem_align and stx_dio_offset_align value
+ *
+ * These two values are tightly coupled to the kernel's current DIO
+ * restrictions on block devices.
+ *
+ * Minimum Linux version required is v6.1.
+ */
+
+#define _GNU_SOURCE
+#include <sys/types.h>
+#include <sys/mount.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include "tst_test.h"
+#include "lapi/stat.h"
+
+static char sys_bdev_dma_path[1024], sys_bdev_logical_path[1024];
+
+static void verify_statx(void)
+{
+	struct statx buf;
+
+	TST_EXP_PASS_SILENT(statx(AT_FDCWD, tst_device->dev, 0, STATX_DIOALIGN, &buf),
+		"statx(AT_FDCWD, %s, 0, STATX_DIOALIGN, &buf)", tst_device->dev);
+
+	if (!(buf.stx_mask & STATX_DIOALIGN)) {
+		tst_res(TCONF, "Filesystem does not support STATX_DIOALIGN");
+		return;
+	}
+
+#ifdef HAVE_STRUCT_STATX_STX_DIO_MEM_ALIGN
+	/*
+	 * This test is tightly coupled to the kernel's current DIO restrictions
+	 * on block devices. The general rule of DIO needing to be aligned to the
+	 * block device's logical block size was relaxed to allow user buffers
+	 * (but not file offsets) aligned to the DMA alignment instead. See v6.0
+	 * commit bf8d08532bc1 ("iomap: add support for dma aligned direct-io") and
+	 * they are subject to further change in the future.
+	 * Also can see commit 2d985f8c6b9 ("vfs: support STATX_DIOALIGN on block devices).
+	 */
+	TST_ASSERT_ULONG(sys_bdev_dma_path, buf.stx_dio_mem_align - 1);
+	TST_ASSERT_ULONG(sys_bdev_logical_path, buf.stx_dio_offset_align);
+#else
+	tst_res(TCONF, "glibc statx struct miss stx_dio_mem_align field");
+#endif
+}
+
+static void setup(void)
+{
+	char full_name[256];
+	char *dev_name;
+
+	strcpy(full_name, tst_device->dev);
+	dev_name = SAFE_BASENAME(full_name);
+	sprintf(sys_bdev_logical_path, "/sys/block/%s/queue/logical_block_size", dev_name);
+
+	/*
+	 * Since /sys/block/%s/queue doesn't exist for partition, we need to
+	 * use a while to search block device instead of partition.
+	 */
+	while (access(sys_bdev_logical_path, F_OK) != 0) {
+		dev_name[strlen(dev_name)-1] = '\0';
+		sprintf(sys_bdev_logical_path, "/sys/block/%s/queue/logical_block_size", dev_name);
+	}
+
+	sprintf(sys_bdev_dma_path, "/sys/block/%s/queue/dma_alignment", dev_name);
+	if (access(sys_bdev_dma_path, F_OK) != 0)
+		tst_brk(TCONF, "dma_alignment sysfs file doesn't exist");
+}
+
+static struct tst_test test = {
+	.test_all = verify_statx,
+	.setup = setup,
+	.needs_device = 1,
+	.needs_root = 1,
+};
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
