Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D2DC76196
	for <ltp@archiver.kernel.org>; Mon,  3 Apr 2023 10:45:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ECF573CD080
	for <ltp@archiver.kernel.org>; Mon,  3 Apr 2023 12:45:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F6753CD076
 for <ltp@lists.linux.it>; Mon,  3 Apr 2023 12:45:09 +0200 (CEST)
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com
 [85.158.142.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F307420023A
 for <ltp@lists.linux.it>; Mon,  3 Apr 2023 12:45:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1680518708; i=@fujitsu.com;
 bh=LmYNBnjbeU6ueawOq3gz3Xq4IQz5AV53txTXfx5JQ6A=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=KAitOuyTibZfqWjAxTd8oGffUMUxIdHkha2c2NoV3eUNexwyUux4ZgcSf1T2OhWtF
 228lLvGEb9yJAsw7E819agHM2q+TqBvQcvTN2ODvLRvsq79zDuaCuz4gywaMkQPQkw
 0MNRpRHzpOX3eNTbaxJPUTc7c2LA6pI82oPibBsZpHm4wC+FdLnf5u4WzKXWe8flIG
 8Q7u5cFdxJlPGY5Uk+lWPf2RosVqE2faPWnQF5LXhP9WAnYBeQ/hUunr8rVwSdUUjC
 OMAA62e1QxytnYwT7gz2B4biSyvhTXOrnRD0cWiJk6I8+ouJ7AGMPazgFp4+LVSXjg
 3SE0Wo1KhyXuw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRWlGSWpSXmKPExsViZ8OxWdd4nVa
 KwZM5shZr9/xhtljxfQejA5PHplWdbB77fq9jDWCKYs3MS8qvSGDNWPHiB2vBU5mKmwe2MTYw
 zpXsYuTiEBLYyCgx6dw9VghnCZPE5VUHmbsYOYGcPYwS5846gdhsApoSzzoXgMVFBCQkOhres
 oPYzAJ2EncWN4HFhQXCJeasfs8GYrMIqEg0fehjBLF5BTwkni5dyQRiSwgoSEx5+B6snlPAU+
 LQxNNAcQ6gXTUS1+/6QZQLSpyc+YQFYryExMEXL5ghWpUk2lqvsELYFRKN0w9BjVSTuHpuE/M
 ERsFZSNpnIWlfwMi0itG8OLWoLLVI19BcL6koMz2jJDcxM0cvsUo3US+1VDcvv6gkQ9dQL7G8
 WC+1uFivuDI3OSdFLy+1ZBMjMKBTipPu7GDc2fdX7xCjJAeTkijv2jVaKUJ8SfkplRmJxRnxR
 aU5qcWHGGU4OJQkeC1BcoJFqempFWmZOcDogklLcPAoifBeWgKU5i0uSMwtzkyHSJ1iVJQS5z
 0O0icAksgozYNrg0X0JUZZKWFeRgYGBiGegtSi3MwSVPlXjOIcjErCvHtApvBk5pXATX8FtJg
 JaHFrlAbI4pJEhJRUAxPv7NluV4MZ5l5hqO5cWW8fvSQqSzvkk4tt+YbZN10VetI/POO11WpN
 WVIxy1HDZHrMSt97O7S6N81hMw9ONNg8y/D5vzer7l3ZVrDn25e1Km1+rj/33AgSrahQ/+rf8
 7FLfsWhtV6re3Z9W2rxQnvL3qSIU49PRat3NkyLTL2m0383gzep+rtflUSunVXYLBbv3rVqYQ
 8uHy5TkBNR75y7aMGtDle/jHnuO4QfWxWmJ0wqvH2sPUV+c5V8IJvp9Q6WFfXzd+Q+LvA7cdq
 aVzv4vBdz7aI71Ru/eGzpX/XInWupeYdXKPvrWgaHf62XU3hSRZUOuM3bL8F9+3d0Qq7qJRkJ
 0XU3lDSe1Mw8r8RSnJFoqMVcVJwIAEI9YNdjAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-15.tower-728.messagelabs.com!1680518707!925021!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 2024 invoked from network); 3 Apr 2023 10:45:07 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
 by server-15.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 3 Apr 2023 10:45:07 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id D8A8F166;
 Mon,  3 Apr 2023 11:45:06 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121
 [10.183.43.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id CBBA9164;
 Mon,  3 Apr 2023 11:45:06 +0100 (BST)
Received: from localhost.localdomain (10.167.215.131) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Mon, 3 Apr 2023 11:45:04 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 3 Apr 2023 18:44:35 +0800
Message-ID: <1680518676-2863-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1680518676-2863-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <7f06d661-cb57-cb8b-481b-cafafa92009b@fujitsu.com>
 <1680518676-2863-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.215.131]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/4] syscalls/statx11: Add basic test for
 STATX_DIOALIGN on blockdev
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

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                           |  1 +
 testcases/kernel/syscalls/statx/.gitignore |  1 +
 testcases/kernel/syscalls/statx/statx11.c  | 95 ++++++++++++++++++++++
 3 files changed, 97 insertions(+)
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
index 000000000..327f74ef6
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx11.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * It is a basic test for STATX_DIOALIGN mask on blockdev.
+ *
+ * - STATX_DIOALIGN   Want stx_dio_mem_align and stx_dio_offset_align value
+ *
+ * Minimum Linux version required is v6.1.
+ */
+
+#define _GNU_SOURCE
+#include <sys/types.h>
+#include <sys/uio.h>
+#include <sys/ioctl.h>
+#include <sys/mount.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <libgen.h>
+#include "tst_test.h"
+#include "lapi/stat.h"
+
+#ifdef HAVE_STRUCT_STATX_STX_DIO_MEM_ALIGN
+#define MNTPOINT "mnt_point"
+#define TESTFILE "testfile"
+
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
+	TST_ASSERT_ULONG(sys_bdev_dma_path, buf.stx_dio_mem_align - 1);
+	TST_ASSERT_ULONG(sys_bdev_lgs_path, buf.stx_dio_offset_align);
+	TST_EXP_EQ_LU(buf.stx_dio_offset_align, logical_sector_size);
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
