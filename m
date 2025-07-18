Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EA8C83F17
	for <ltp@archiver.kernel.org>; Fri, 18 Jul 2025 08:30:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A2313CC3CA
	for <ltp@archiver.kernel.org>; Fri, 18 Jul 2025 10:30:06 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 247703CA504
 for <ltp@lists.linux.it>; Fri, 18 Jul 2025 10:29:48 +0200 (CEST)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by in-3.smtp.seeweb.it (Postfix) with ESMTP id 16D201A00812
 for <ltp@lists.linux.it>; Fri, 18 Jul 2025 10:29:44 +0200 (CEST)
Received: from loongson.cn (unknown [113.200.148.30])
 by gateway (Coremail) with SMTP id _____8CxLGvzBXpo7NQsAQ--.27054S3;
 Fri, 18 Jul 2025 16:29:40 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
 by front1 (Coremail) with SMTP id qMiowJCxM+TwBXpowR0cAA--.18333S2;
 Fri, 18 Jul 2025 16:29:36 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Linux Test Project <ltp@lists.linux.it>
Date: Fri, 18 Jul 2025 16:29:35 +0800
Message-ID: <20250718082935.9466-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-CM-TRANSID: qMiowJCxM+TwBXpowR0cAA--.18333S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAF4xXw48Wry5ZF4fZw1UArc_yoWrXFWxpF
 W2kF4jkF4kGr18GFs5AF1FkFy5X397Z34fGrZrGr9FkF4qgrn5Zr9rur9IqFy09FWDWay0
 9r1UtFn0gr4UZabCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
 AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
 r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6x
 IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
 w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
 0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwmhFDUUUU
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] device-drivers/acpi/ltp_acpi_cmds: Fix build errors
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

There exist the following errors when building LTP on the
latest Linux kernel v6.16-rc6:

  ltp_acpi_cmds.c:39:10: fatal error: linux/genhd.h: No such file or directory
  ltp_acpi_cmds.c:131:18: error: implicit declaration of function 'acpi_bus_get_device'
  ltp_acpi_cmds.c:400:18: error: implicit declaration of function 'acpi_bus_get_device'

For the first error:

This is because genhd.h has been removed in the Linux kernel,
the contents of genhd.h was folded into blkdev.h [1].

Add linux/genhd.h into AC_CHECK_HEADERS_ONCE of configure.ac,
define HAVE_LINUX_GENHD_H to 1 if you have the <linux/genhd.h>
header file, then use #ifdef HAVE_LINUX_GENHD_H to include it.

For the second and third errors:

This is because acpi_bus_get_device() has been removed in the
Linux kernel [2] since v5.18-rc2 [3], the best way is to use
acpi_bus_get_device() if the kernel version < 5.18 and use
acpi_fetch_acpi_dev() if the kernel version >= 5.18.

While at it, remove the trailing whitespace in the following
code: prk_alert("TEST -- acpi_bus_update_power ").

Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=322cbb50de71 [1]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ac2a3feefad5 [2]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?h=v5.18-rc2 [3]

Suggested-by: Andrea Cervesato <andrea.cervesato@suse.com>
Suggested-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---

Thanks Andrea and Petr very much for your suggestions, I appreciate it.

 configure.ac                                  |  1 +
 .../device-drivers/acpi/ltp_acpi_cmds.c       | 19 +++++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 11e599a81..cf37c58be 100644
--- a/configure.ac
+++ b/configure.ac
@@ -62,6 +62,7 @@ AC_CHECK_HEADERS_ONCE([ \
     linux/dccp.h \
     linux/futex.h \
     linux/genetlink.h \
+    linux/genhd.h \
     linux/if_alg.h \
     linux/if_ether.h \
     linux/if_packet.h \
diff --git a/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c b/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c
index d12dd6b94..02c1567b4 100644
--- a/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c
+++ b/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c
@@ -36,9 +36,12 @@
 #include <linux/ioctl.h>
 #include <linux/pm.h>
 #include <linux/acpi.h>
+#ifdef HAVE_LINUX_GENHD_H
 #include <linux/genhd.h>
+#endif
 #include <linux/dmi.h>
 #include <linux/nls.h>
+#include <linux/version.h>
 
 #include "ltp_acpi.h"
 
@@ -123,14 +126,20 @@ static void get_crs_object(acpi_handle handle)
 
 static void get_sysfs_path(acpi_handle handle)
 {
-	acpi_status status;
 	struct acpi_device *device;
 
 	kfree(sysfs_path);
 	sysfs_path = NULL;
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(5, 18, 0)
+	acpi_status status;
+
 	status = acpi_bus_get_device(handle, &device);
 	if (ACPI_SUCCESS(status))
+#else
+	device = acpi_fetch_acpi_dev(handle);
+	if (device)
+#endif
 		sysfs_path = kobject_get_path(&device->dev.kobj, GFP_KERNEL);
 }
 
@@ -398,12 +407,18 @@ static int acpi_test_bus(void)
 	if (acpi_failure(status, "acpi_get_handle"))
 		return 1;
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(5, 18, 0)
 	prk_alert("TEST -- acpi_bus_get_device");
 	status = acpi_bus_get_device(bus_handle, &device);
 	if (acpi_failure(status, "acpi_bus_get_device"))
+#else
+	prk_alert("TEST -- acpi_fetch_acpi_dev");
+	device = acpi_fetch_acpi_dev(bus_handle);
+	if (!device)
+#endif
 		return 1;
 
-	prk_alert("TEST -- acpi_bus_update_power ");
+	prk_alert("TEST -- acpi_bus_update_power");
 	status = acpi_bus_update_power(device->handle, &state);
 	if (acpi_failure(status, "error reading power state"))
 		return 1;
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
