Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51365C7618D
	for <ltp@archiver.kernel.org>; Thu,  6 Apr 2023 05:41:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01A6D3CC75B
	for <ltp@archiver.kernel.org>; Thu,  6 Apr 2023 07:41:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F00FB3C00D1
 for <ltp@lists.linux.it>; Thu,  6 Apr 2023 07:41:17 +0200 (CEST)
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com
 [195.245.230.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BF0D1600A98
 for <ltp@lists.linux.it>; Thu,  6 Apr 2023 07:41:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1680759675; i=@fujitsu.com;
 bh=epWHlYv50wpoFndzgQfN7674IfHfiEeub75uuZVrPdo=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=bV7sU/ewPRO75XKM2pwSiKYic3r+/HCLqV+iH3RFBZKozc63W7rZfQCA4mheBhuvi
 AZ6vJNiZbnCS+615ZDJcJZpMrE/MB2XiGET6bsGr0cn+rEuJlxSEE2fFSa2CPx2tm0
 rBG3/AgARxJNskGbaqO1oj3V/O14JZNmOe48IOxnbOObQuyIMjcii0JAQXUzwjoFy8
 nEz1dmxGVCGiWgaDHXl9IciqshgfJg5aM42ZaPqk1Up67JQp7Uja2t1yCdqluDOZbk
 fSDcu55M3UxGoNJfXnUcDEW+Pjeb2laUVAS9x62YYjARBmJp/JlQHDuyxL0qT4UzV0
 AEsk/3acTOgdQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRWlGSWpSXmKPExsViZ8ORpFsdrZd
 i0N8hbLF2zx9mixXfdzA6MHlsWtXJ5rHv9zrWAKYo1sy8pPyKBNaMCU+OMBVska+4OesHUwPj
 P6kuRi4OIYGNjBKzD21kgXCWMEnMOL2aCcLZwyixae1h1i5GTg42AU2JZ50LmEFsEQEJiY6Gt
 +wgNrOAncSdxU1gcWGBaIl3v9eCxVkEVCR2H+0As3kFPCTm3v4NZksIKEhMefgeqJ6Dg1PAU+
 Lb23KQsJBAocSrHY+YIcoFJU7OfMICMV5C4uCLF8wQrUoSba1XWCHsConG6YeYIGw1iavnNjF
 PYBSchaR9FpL2BYxMqxhNi1OLylKLdM30kooy0zNKchMzc/QSq3QT9VJLdctTi0t0DfUSy4v1
 UouL9Yorc5NzUvTyUks2MQLDOaWY4cYOxjl9f/UOMUpyMCmJ8s5V0UkR4kvKT6nMSCzOiC8qz
 UktPsQow8GhJMG7K0ovRUiwKDU9tSItMwcYWzBpCQ4eJRHehX5Aad7igsTc4sx0iNQpRkUpcd
 7LIH0CIImM0jy4Nlg8X2KUlRLmZWRgYBDiKUgtys0sQZV/xSjOwagkzFsNMoUnM68EbvoroMV
 MQItt/XVAFpckIqSkGpiaXjsLP+QQ7Yizkvoz88OkIK20gF0LahKP3N+hFcKyPNw5V8nvN8+H
 tU6vWA5o+m+ft+mN1jk3trBGpsdyU18Ubl93+KvQszOTs6Zffxh24vQJTYb5RTm7VrnVXK+V3
 r757t5JUyY3Vahk+XlXvbD+9ouTn8X7ZcLymZk391qwHTLdvE38yLezfd1es9MmF4lbNp53P9
 imNmOR2ddWJ4GZmzdv6le9umqxRu2ipppPEw+3Me2Y2d9ZlX518en6yg7n75ZiIkEcjuve8jb
 IfhF8+TN4qv+vbTWb55xx19736t/WBRH/vkgx33M595FhTvezBWufX636X7VkZ+Hau9kbllSm
 /aqd0nJsR5iQu2GvghJLcUaioRZzUXEiAOGIcJliAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-6.tower-585.messagelabs.com!1680759675!122723!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 23417 invoked from network); 6 Apr 2023 05:41:15 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
 by server-6.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 6 Apr 2023 05:41:15 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id E0B981C1;
 Thu,  6 Apr 2023 06:41:14 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121
 [10.183.43.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id D4F5F1BF;
 Thu,  6 Apr 2023 06:41:14 +0100 (BST)
Received: from localhost.localdomain (10.167.215.131) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Thu, 6 Apr 2023 06:41:13 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Thu, 6 Apr 2023 13:40:21 +0800
Message-ID: <1680759622-8738-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1680759622-8738-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <20230404215918.GA1893@sol.localdomain>
 <1680759622-8738-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.215.131]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 3/4] syscalls/statx11: Add basic test for
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
 runtest/syscalls                           |  1 +
 testcases/kernel/syscalls/statx/.gitignore |  1 +
 testcases/kernel/syscalls/statx/statx11.c  | 81 ++++++++++++++++++++++
 3 files changed, 83 insertions(+)
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
index 000000000..02449888a
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx11.c
@@ -0,0 +1,81 @@
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
+	memset(&buf, 0, sizeof(buf));
+	TST_EXP_PASS_SILENT(statx(AT_FDCWD, tst_device->dev, 0, STATX_DIOALIGN, &buf),
+		"statx(AT_FDCWD, %s, 0, STATX_DIOALIGN, &buf)", tst_device->dev);
+
+	if (!(buf.stx_mask & STATX_DIOALIGN)) {
+		tst_res(TCONF, "STATX_DIOALIGN is not supported until linux 6.1");
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
+#endif
+}
+
+static void setup(void)
+{
+	char *dev_name;
+
+	dev_name = basename((char *)tst_device->dev);
+	sprintf(sys_bdev_logical_path, "/sys/block/%s/queue/logical_block_size", dev_name);
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
