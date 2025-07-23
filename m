Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359F1C83F27
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 00:51:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 23D863CCD37
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 02:51:44 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2251F3C20D2
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 02:51:25 +0200 (CEST)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by in-3.smtp.seeweb.it (Postfix) with ESMTP id 02E791A000BC
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 02:51:22 +0200 (CEST)
Received: from loongson.cn (unknown [113.200.148.30])
 by gateway (Coremail) with SMTP id _____8CxbWsGMoBo5fMvAQ--.31135S3;
 Wed, 23 Jul 2025 08:51:19 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
 by front1 (Coremail) with SMTP id qMiowJAxT+YFMoBoE4AiAA--.47415S2;
 Wed, 23 Jul 2025 08:51:18 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Linux Test Project <ltp@lists.linux.it>
Date: Wed, 23 Jul 2025 08:51:16 +0800
Message-ID: <20250723005117.4282-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-CM-TRANSID: qMiowJAxT+YFMoBoE4AiAA--.47415S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrKF4rCr1fKw1ktF1xWw4fCrX_yoWktrb_uw
 1xur1xGr1rAF1Fvw4UAFs3Zr45tw42qFWSvFnFq3s5Was7Wan8Wwn5Xas8tFs8Wa1Durn5
 Gr1DWrs5tr42gosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUb7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
 0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
 7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcV
 C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
 04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
 CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] ltp_block_dev: Check HAVE_LINUX_GENHD_H to include
 genhd.h
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

After the LTP commit d4dd360b05f8 ("device-drivers/acpi/ltp_acpi_cmds:
Fix build errors"), HAVE_LINUX_GENHD_H is defined to 1 if you have the
<linux/genhd.h> header file.

The macro definition DISK_NAME_LEN may be completely removed, so it is
better to use #ifdef HAVE_LINUX_GENHD_H to include genhd.h.

Suggested-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
v2: Add Suggested-by tag

 .../device-drivers/block/block_dev_kernel/ltp_block_dev.c       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_dev.c b/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_dev.c
index 0fd278981..f50530f23 100644
--- a/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_dev.c
+++ b/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_dev.c
@@ -13,7 +13,7 @@
 #include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/blkdev.h>
-#ifndef DISK_NAME_LEN
+#ifdef HAVE_LINUX_GENHD_H
 # include <linux/genhd.h>
 #endif
 
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
