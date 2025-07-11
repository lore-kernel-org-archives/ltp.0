Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67EFEC8303C
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 08:02:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 859883CB161
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 10:02:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 855E33C65DA
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 10:02:15 +0200 (CEST)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by in-2.smtp.seeweb.it (Postfix) with ESMTP id B81EA600914
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 10:02:11 +0200 (CEST)
Received: from loongson.cn (unknown [113.200.148.30])
 by gateway (Coremail) with SMTP id _____8BxrnL7xHBozwwnAQ--.18003S3;
 Fri, 11 Jul 2025 16:02:04 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
 by front1 (Coremail) with SMTP id qMiowJCxocL0xHBoaHoSAA--.38948S2;
 Fri, 11 Jul 2025 16:01:57 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: ltp@lists.linux.it
Date: Fri, 11 Jul 2025 16:01:55 +0800
Message-ID: <20250711080155.7473-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-CM-TRANSID: qMiowJCxocL0xHBoaHoSAA--.38948S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGry5AryfGF1DXryfJF4UJrc_yoW5JFWDpF
 W7KFWqkrWDGr18GF1kAF4Y9Fy5AwnrZ34fGr4DG3s2kanI9r95JrykWr1aqFy09rWqgayx
 uFy7JFnYgr4UZFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
 xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
 Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jr0_JrylIxkGc2Ij64vIr41lIxAIcVC0I7
 IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
 6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
 AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] device-drivers/acpi/ltp_acpi_cmds: Fix build errors
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

There exist the following errors when building LTP:

  ltp_acpi_cmds.c:39:10: fatal error: linux/genhd.h: No such file or directory
  ltp_acpi_cmds.c:131:18: error: implicit declaration of function 'acpi_bus_get_device'
  ltp_acpi_cmds.c:400:18: error: implicit declaration of function 'acpi_bus_get_device'

For the first error:

This is because genhd.h has been removed in the Linux kernel, the contents
of genhd.h was folded into blkdev.h [1]. Since blkdev.h has been included
in the C file, just remove unused include genhd.h to fix the build error.

For the second and third errors:

This is because acpi_bus_get_device() has been droped in the Linux kernel,
in order to fix the build errors, just replace acpi_bus_get_device() with
acpi_fetch_acpi_dev() like the kernel commit [2].

[1] https://git.kernel.org/torvalds/c/322cbb50de71
[2] https://git.kernel.org/torvalds/c/ac2a3feefad5

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c b/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c
index d12dd6b94..b2d46e1a8 100644
--- a/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c
+++ b/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c
@@ -36,7 +36,6 @@
 #include <linux/ioctl.h>
 #include <linux/pm.h>
 #include <linux/acpi.h>
-#include <linux/genhd.h>
 #include <linux/dmi.h>
 #include <linux/nls.h>
 
@@ -123,14 +122,13 @@ static void get_crs_object(acpi_handle handle)
 
 static void get_sysfs_path(acpi_handle handle)
 {
-	acpi_status status;
 	struct acpi_device *device;
 
 	kfree(sysfs_path);
 	sysfs_path = NULL;
 
-	status = acpi_bus_get_device(handle, &device);
-	if (ACPI_SUCCESS(status))
+	device = acpi_fetch_acpi_dev(handle);
+	if (device)
 		sysfs_path = kobject_get_path(&device->dev.kobj, GFP_KERNEL);
 }
 
@@ -398,9 +396,9 @@ static int acpi_test_bus(void)
 	if (acpi_failure(status, "acpi_get_handle"))
 		return 1;
 
-	prk_alert("TEST -- acpi_bus_get_device");
-	status = acpi_bus_get_device(bus_handle, &device);
-	if (acpi_failure(status, "acpi_bus_get_device"))
+	prk_alert("TEST -- acpi_fetch_acpi_dev");
+	device = acpi_fetch_acpi_dev(bus_handle);
+	if (!device)
 		return 1;
 
 	prk_alert("TEST -- acpi_bus_update_power ");
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
