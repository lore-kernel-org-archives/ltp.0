Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEF1C7EE22
	for <ltp@archiver.kernel.org>; Tue,  9 May 2023 09:17:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E1583CD729
	for <ltp@archiver.kernel.org>; Tue,  9 May 2023 11:17:01 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7565C3CD710
 for <ltp@lists.linux.it>; Tue,  9 May 2023 11:16:44 +0200 (CEST)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D113D20035D
 for <ltp@lists.linux.it>; Tue,  9 May 2023 11:16:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1683623803; i=@fujitsu.com;
 bh=z1gH+2qXve0XtE5j4gGxcE2XE/kopJF+se3Mje181dc=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
 b=erRjCpBUZEoVeO7a70qIEkm8xAIaKuNGDxr8LGnOq1VWjg5vfpEcXGAks8Iy1AoZi
 CDvgx8v8v7Q9z02vFD6hXpFw/WPzcu39yPNpRsIcbBLsNE4K5tuaKNAR+KKkdSy8/x
 e7OycS/m8VKWK5VqQRfFTLeiqWI8q4xiexcXpveokkwzkNBV4y906tu//hGu1zmiWv
 5TCKcEiWjumLFaElg854/6S9fsJLS8qSoORiRSPFdTThOi249Q12wwwrdGzbmZ8XJ1
 VWMixXI5IbuwO57ju2CdYWRx5Pt0XWF1gOwAXB28YOi4RvtX2hn2u/yFUSnDM2Sz/W
 rvkJREMbwJcZA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRWlGSWpSXmKPExsViZ8ORpFvNH5V
 iMPE/t8XaPX+YLVZ838HowOSxaVUnm8e+3+tYA5iiWDPzkvIrElgzZp9oYiroUqmYvnIhawNj
 i3wXIxeHkMBGRokLb74xdzFyAjnTmSRuzvUBsdkENCWedS4Ai4sIiElc3/CKFcRmFrCVeHl8K
 yOILSwQLdHW2gdkc3CwCKhKTN7ICxLmFfCU2NrUAVYuIaAgMeXhe7AxnAJeEnPbXkCt8pR40z
 UJqkZN4uq5TcwTGHkWMDKsYjQtTi0qSy3StdRLKspMzyjJTczM0Uus0k3USy3VLU8tLtE11Es
 sL9ZLLS7WK67MTc5J0ctLLdnECAyRlGI2gR2Mc3f91TvEKMnBpCTK27UvMkWILyk/pTIjsTgj
 vqg0J7X4EKMMB4eSBO8DnqgUIcGi1PTUirTMHGC4wqQlOHiURHhPsACleYsLEnOLM9MhUqcYF
 aXEebv4gBICIImM0jy4NliMXGKUlRLmZWRgYBDiKUgtys0sQZV/xSjOwagkzDuRF2gKT2ZeCd
 z0V0CLmYAW+18OB1lckoiQkmpguvVo1xtWN67IvSFtp1a4JM2M4w5Z5/slsOjqVe3dpSvOMfo
 +Zvb4vOrk1EVXpm7oaBepflX/fprn8/C9CVNsNa/fPb89eOUlj9hIr/S7zi9/WTUJPJo5s/kz
 g0vm9Kb+w0U5FV8+7To1yU1X4U6jfqWZ3RRHD93W4JZFBRPeXd5omLJSZtatKEkh5sfCKhJ9C
 3ecurZgD+dsfrZkxW6uzUaLzkpsjPbosGdZoF1R+FhTc8HjI50F5o4yS1d1Mi5dpdth7XX6wB
 JrHaObT678vCq84oHmefEH6/3+NgT6NryTSdy0Na6d/0mF0zWltstrD/cvD2vVf1ail/xebtO
 jFdszvtYa6P/dpHyKhbm4TImlOCPRUIu5qDgRAGUmsWsMAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-8.tower-587.messagelabs.com!1683623802!28830!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.105.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 9402 invoked from network); 9 May 2023 09:16:43 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
 by server-8.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 9 May 2023 09:16:43 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id C3BDC1B5;
 Tue,  9 May 2023 10:16:42 +0100 (BST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id C8DC21B1;
 Tue,  9 May 2023 10:16:41 +0100 (BST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Tue,  9 May 2023 17:14:08 +0800
Message-Id: <1683623648-22778-7-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1683623648-22778-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1683623648-22778-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 7/7] syscalls/statx11: Add basic test for
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
 testcases/kernel/syscalls/statx/statx11.c  | 99 ++++++++++++++++++++++
 3 files changed, 101 insertions(+)
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
index 000000000..f32f05eff
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx11.c
@@ -0,0 +1,99 @@
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
+	uint32_t stx_dio_mem_align, stx_dio_offset_align;
+
+	TST_EXP_PASS_SILENT(statx(AT_FDCWD, tst_device->dev, 0, STATX_DIOALIGN, &buf),
+		"statx(AT_FDCWD, %s, 0, STATX_DIOALIGN, &buf)", tst_device->dev);
+
+	if (!(buf.stx_mask & STATX_DIOALIGN)) {
+		tst_res(TCONF, "Filesystem does not support STATX_DIOALIGN");
+		return;
+	}
+
+#if defined(HAVE_STRUCT_STATX) && !defined(HAVE_STRUCT_STATX_STX_DIO_MEM_ALIGN)
+  #if defined(HAVE_STRUCT_STATX_STX_MNT_ID)
+	stx_dio_mem_align = buf.__spare2 >> 32;
+	stx_dio_offset_align = buf.__spare2 & 0xffff;
+  #else
+	stx_dio_mem_align = buf.__spare2[1] >> 32;
+	stx_dio_offset_align = buf.__spare2[1] & 0xffff;
+  #endif
+#else
+	stx_dio_mem_align = buf.stx_dio_mem_align;
+	stx_dio_offset_align = buf.stx_dio_offset_align;
+#endif
+
+	/*
+	 * This test is tightly coupled to the kernel's current DIO restrictions
+	 * on block devices. The general rule of DIO needing to be aligned to the
+	 * block device's logical block size was relaxed to allow user buffers
+	 * (but not file offsets) aligned to the DMA alignment instead. See v6.0
+	 * commit bf8d08532bc1 ("iomap: add support for dma aligned direct-io") and
+	 * they are subject to further change in the future.
+	 * Also can see commit 2d985f8c6b9 ("vfs: support STATX_DIOALIGN on block devices).
+	 */
+	TST_ASSERT_ULONG(sys_bdev_dma_path, stx_dio_mem_align - 1);
+	TST_ASSERT_ULONG(sys_bdev_logical_path, stx_dio_offset_align);
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
