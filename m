Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEEB8C6FD1D
	for <ltp@archiver.kernel.org>; Tue,  4 Apr 2023 07:31:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 98DBE3CACBD
	for <ltp@archiver.kernel.org>; Tue,  4 Apr 2023 09:31:32 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 19CC23CB133
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 09:31:01 +0200 (CEST)
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com
 [85.158.142.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3693F1400777
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 09:30:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1680593459; i=@fujitsu.com;
 bh=C9w8PF5VLbH4xw2WIlbYySK0tqbPcp57ndGsQMN0dBc=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=m7UZCz+Yxo2PFpptFMQhePCky/44Lqa0oCNkzhLO0BFNf+gBERSQNLqSVp3EXyUOV
 HR4xuZPtmf6G/YoMhAMoJPc19slr5zynD6e+p3qkAoMj6vUCU4LMs7rjRd8h8T7YRN
 967ilAqjuaDX6TbKiQROqLe/xTiw8BLdGU5ZiyzxqdpRvDphckrWzWMC5l2bTW70PG
 cw2YsgAKPKcWvoSC3Pf4Kn0oIN4Pp7e6JfkPunxfhZq5DhBF/WvgzUV6BxPW/rI4k9
 3A2e+I8eYqytFv+B4l5KyyEGVmUBTBPVP8Nqm1TKFouTzP+3t1cpbAsXztyE9rmdY2
 TvGnv15ZWEMSA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRWlGSWpSXmKPExsViZ8ORqGt0STv
 FYMJlY4u1e/4wW6z4voPRgclj06pONo99v9exBjBFsWbmJeVXJLBmTHr/jbXgk3rFswa/Bsb1
 Sl2MXBxCAlsYJZ5cOMoO4Sxnknj3fgMzhLOHUaL1WSOQw8nBJqAp8axzAZgtIiAh0dHwlh3EZ
 hawk7izuAksLiwQLbFs7nuwOIuAikT/6fUsIDavgKfEpkeHWEFsCQEFiSkP34PVcwp4Sey5fQ
 AsLiSQLtF/7hczRL2gxMmZT1gg5ktIHHzxghmiV0mirfUK1JwKicbph5ggbDWJq+c2MU9gFJy
 FpH0WkvYFjEyrGM2KU4vKUot0DfWSijLTM0pyEzNz9BKrdBP1Ukt18/KLSjKAUonlxXqpxcV6
 xZW5yTkpenmpJZsYgQGdUpx4ewfj8t6/eocYJTmYlER5H23UThHiS8pPqcxILM6ILyrNSS0+x
 CjDwaEkwZt5HignWJSanlqRlpkDjC6YtAQHj5II799zQGne4oLE3OLMdIjUKUZFKXHejReAEg
 IgiYzSPLg2WERfYpSVEuZlZGBgEOIpSC3KzSxBlX/FKM7BqCTM63IGaApPZl4J3PRXQIuZgBa
 3RmmALC5JREhJNTBJmpkfj9L7xuXbGXLBY9OHyawT17xKfiEvskRj6pRN7i++6W/2O1jdzyHY
 nvZiOmsVyxaO9p6XS47/fle3M3HV3/zKLXPrC4P9q+aZR32t2Lwv4LCekaSm08nDvfFHVyh1n
 M5l7c31WOJolMK//mmDKqvb1JqnbqrXNFOWrXPeufbri8beHwlfeZTfb55SeKU63/H2Yfdgnx
 vV3usfKzeevdGZfaV/QZywBL92J9P+rkOXkzO0vu21ZTk40cNLobgwYMWtLS+z5nlMXVYQJB2
 pyGVtOeOakTtfVKObWdD3A58tvOO3Hjr60zO9dUkK7/5ZvVe6L81Nir7YtbfxiJ/Q06u5IoG6
 nNMsxLi3qiuxFGckGmoxFxUnAgAFxyXkYwMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-12.tower-728.messagelabs.com!1680593458!1111041!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 9314 invoked from network); 4 Apr 2023 07:30:58 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-12.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 4 Apr 2023 07:30:58 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 335511001BA;
 Tue,  4 Apr 2023 08:30:58 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121
 [10.183.43.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 26EF71001A8;
 Tue,  4 Apr 2023 08:30:58 +0100 (BST)
Received: from localhost.localdomain (10.167.215.131) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Tue, 4 Apr 2023 08:30:55 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 4 Apr 2023 15:30:29 +0800
Message-ID: <1680593430-14728-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1680593430-14728-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <ZCsHKmFrUdBw3xEw@gmail.com>
 <1680593430-14728-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.215.131]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/4] syscalls/statx11: Add basic test for
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
v2->v3:
1.remove useless TESTFILE and MNTPINT macro
2.like statx10.c, test not filled situation when not request STATX_DIOLAIGN
3.add commet that this case is tightly coupled to the kernel's current DIO restrictions on block
devices
 runtest/syscalls                           |   1 +
 testcases/kernel/syscalls/statx/.gitignore |   1 +
 testcases/kernel/syscalls/statx/statx11.c  | 107 +++++++++++++++++++++
 3 files changed, 109 insertions(+)
 create mode 100644 testcases/kernel/syscalls/statx/statx11.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 92123772c..de5f0be35 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1770,6 +1770,7 @@ statx07 statx07
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
index 000000000..35d6fbaf3
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx11.c
@@ -0,0 +1,107 @@
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
+ * These two values are only filled when STATX_DIOALIGN in the request mask.
+ * These two values are tightly coupled to the kernel's current DIO
+ * restrictions on block devices.
+ *
+ * Minimum Linux version required is v6.1.
+ */
+
+#define _GNU_SOURCE
+#include <sys/types.h>
+#include <sys/ioctl.h>
+#include <sys/mount.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include "tst_test.h"
+#include "lapi/stat.h"
+
+#ifdef HAVE_STRUCT_STATX_STX_DIO_MEM_ALIGN
+static int fd = -1, logical_sector_size;
+static char sys_bdev_dma_path[1024], sys_bdev_lgs_path[1024];
+
+static void verify_statx(void)
+{
+	struct statx buf;
+
+	memset(&buf, 0, sizeof(buf));
+	TST_EXP_PASS(statx(AT_FDCWD, tst_device->dev, 0, STATX_DIOALIGN, &buf),
+		"statx(AT_FDCWD, %s, 0, STATX_DIOALIGN, &buf)", tst_device->dev);
+
+	if (!(buf.stx_mask & STATX_DIOALIGN)) {
+		tst_res(TCONF, "STATX_DIOALIGN is not supported until linux 6.1");
+		return;
+	}
+
+	/*
+	 * This test is tightly coupled to the kernel's current DIO restrictions
+	 * on block devices. The general rule of DIO needing to be aligned to the
+	 * block device's logical block size was recently relaxed to allow user buffers
+	 * (but not file offsets) aligned to the DMA alignment instead. See v6.0
+	 * commit bf8d08532bc1 ("iomap: add support for dma aligned direct-io") and
+	 * they are subject to further change in the future.
+	 * Also can see commit 2d985f8c6b9 ("vfs: support STATX_DIOALIGN on block devices).
+	 */
+	TST_ASSERT_ULONG(sys_bdev_dma_path, buf.stx_dio_mem_align - 1);
+	TST_ASSERT_ULONG(sys_bdev_lgs_path, buf.stx_dio_offset_align);
+	TST_EXP_EQ_LU(buf.stx_dio_offset_align, logical_sector_size);
+
+	TST_EXP_PASS(statx(AT_FDCWD, tst_device->dev, 0, 0, &buf),
+		"statx(AT_FDCWD, %s, 0, STATX_DIOALIGN, &buf)", tst_device->dev);
+	TST_EXP_EQ_LU(buf.stx_dio_mem_align, 0);
+	TST_EXP_EQ_LU(buf.stx_dio_offset_align, 0);
+}
+
+static void setup(void)
+{
+	char *dev_name;
+	int dev_fd;
+
+	dev_fd = SAFE_OPEN(tst_device->dev, O_RDWR);
+	SAFE_IOCTL(dev_fd, BLKSSZGET, &logical_sector_size);
+	SAFE_CLOSE(dev_fd);
+
+	if (logical_sector_size <= 0)
+		tst_brk(TBROK, "BLKSSZGET returned invalid block size %i", logical_sector_size);
+
+	dev_name = basename((char *)tst_device->dev);
+	sprintf(sys_bdev_lgs_path, "/sys/block/%s/queue/logical_block_size", dev_name);
+	while (access(sys_bdev_lgs_path, F_OK) != 0) {
+		dev_name[strlen(dev_name)-1] = '\0';
+		sprintf(sys_bdev_lgs_path, "/sys/block/%s/queue/logical_block_size", dev_name);
+	}
+
+	sprintf(sys_bdev_dma_path, "/sys/block/%s/queue/dma_alignment", dev_name);
+	if (access(sys_bdev_dma_path, F_OK) != 0)
+		tst_brk(TCONF, "dma_alignment syfsfile doesn't exist");
+}
+
+static void cleanup(void)
+{
+	if (fd > -1)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.test_all = verify_statx,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.needs_device = 1,
+};
+#else
+TST_TEST_TCONF("test requires struct statx to have the stx_dio_mem_align fields");
+#endif
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
