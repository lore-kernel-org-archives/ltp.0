Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128A3CD8CB9
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 17:07:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 494CC3E6EA8
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 19:07:39 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E41BF3E6EA4
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 19:07:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 59101100046C
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 19:07:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 17F93759E7;
 Wed, 10 Jun 2026 17:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781111225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2/ggcLbUEkBS6dswXjpAoVXfYtl5mQ1WXoI/PC4r1kA=;
 b=V3lDDGwNDbGLaAxy8K+7WHMWRxW1Ch1Gg7wP9C43Trn1BmHns3+Q7I84CzUZ8YRL/Tty0O
 V4YqeHXA1APRSPwMPn0QMYYtAG08T3HpAJx0pcB07MpObWqRFrtOwQtKffFqzq+Z0NCZMP
 bYyYPZqA+p/gxvBNYiCz+0pbKniWjVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781111225;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2/ggcLbUEkBS6dswXjpAoVXfYtl5mQ1WXoI/PC4r1kA=;
 b=/CmIN/4lU2gHVca9eV/R37wEusn2kTrtd7Wre2a+NThjMYp0Ri7upWBst+keX1b8IkGBke
 JkWIp+ZU+hRRt1BA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=V3lDDGwN;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/CmIN/4l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781111225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2/ggcLbUEkBS6dswXjpAoVXfYtl5mQ1WXoI/PC4r1kA=;
 b=V3lDDGwNDbGLaAxy8K+7WHMWRxW1Ch1Gg7wP9C43Trn1BmHns3+Q7I84CzUZ8YRL/Tty0O
 V4YqeHXA1APRSPwMPn0QMYYtAG08T3HpAJx0pcB07MpObWqRFrtOwQtKffFqzq+Z0NCZMP
 bYyYPZqA+p/gxvBNYiCz+0pbKniWjVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781111225;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2/ggcLbUEkBS6dswXjpAoVXfYtl5mQ1WXoI/PC4r1kA=;
 b=/CmIN/4lU2gHVca9eV/R37wEusn2kTrtd7Wre2a+NThjMYp0Ri7upWBst+keX1b8IkGBke
 JkWIp+ZU+hRRt1BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED2D5779A9;
 Wed, 10 Jun 2026 17:07:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4Gb0N7iZKWrIAQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 10 Jun 2026 17:07:04 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 10 Jun 2026 19:07:04 +0200
MIME-Version: 1.0
Message-Id: <20260610-fw_load-v3-1-eef32edfe8d5@suse.com>
References: <20260610-fw_load-v3-0-eef32edfe8d5@suse.com>
In-Reply-To: <20260610-fw_load-v3-0-eef32edfe8d5@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781111224; l=10368;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=S4bpmYUB1ng8nf1Sau9X23hH1hV5xvke9o+AKynf91M=;
 b=fvsmTYblHluFsB65+0M27ToNv0E4KQTM28zRBNLn1g4Pr9ik5TA1jpp8JFAY6172LIzkQkbUS
 MlfxkZqi+SMCmQ4TqFntUgBtoSa6v70m/uyGDjnTQSQDLjVhcPDmTOk
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 17F93759E7
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.de:dkim];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/3] fw_load: Modernize ltp_fw_load kernel module
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Fix VLA (banned since kernel v4.20), replace sscanf() with
kstrtoint(), reset test_result between invocations, make the
loop variable local and pass expected data explicitly.

Update license headers, fix brace style, drop obsolete README
in favour of the in-source documentation.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/firmware/fw_load_kernel/Makefile  |  16 +--
 testcases/kernel/firmware/fw_load_kernel/README    |  16 ---
 .../kernel/firmware/fw_load_kernel/ltp_fw_load.c   | 114 ++++++++++++---------
 3 files changed, 66 insertions(+), 80 deletions(-)

diff --git a/testcases/kernel/firmware/fw_load_kernel/Makefile b/testcases/kernel/firmware/fw_load_kernel/Makefile
index 73996996f3397fb0a7f4616457168213587e654f..e81b300faaa6b4056d4b5f3d1417c381a000256d 100644
--- a/testcases/kernel/firmware/fw_load_kernel/Makefile
+++ b/testcases/kernel/firmware/fw_load_kernel/Makefile
@@ -1,18 +1,6 @@
 # Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+# Copyright (c) Linux Test Project, 2026
+# SPDX-License-Identifier: GPL-2.0-or-later
 
 ifneq ($(KERNELRELEASE),)
 
diff --git a/testcases/kernel/firmware/fw_load_kernel/README b/testcases/kernel/firmware/fw_load_kernel/README
deleted file mode 100644
index 97507fd99aa3bead708cd4bf599f4abf9ec6e2da..0000000000000000000000000000000000000000
--- a/testcases/kernel/firmware/fw_load_kernel/README
+++ /dev/null
@@ -1,16 +0,0 @@
-The aim of the test is to check device firmware loading. Since kernel 3.7
-firmware loading changed to direct loading (by-pass udev). The test consists
-of the two parts:
- - userspace part
- - kernelspace part
-
-This is a kernel module, which is a part of the device firmware loading test.
-It allows to call request_firmware kernel function with specified parameters.
-Template firmware file name and expected firmware file's data size are passed
-as the insmod command line parameters. Then, the number of firmware test files
-should be written to sysfs file 'fwnum' (the maximum number is 32). This write
-will initiate request firmware procedure. In the end, results can be read from
-'result' device sysfs file. Also, some information regarding module loading,
-can be obtained by looking at kernel log file.
-
-It is automatically used by userspace part of the test.
diff --git a/testcases/kernel/firmware/fw_load_kernel/ltp_fw_load.c b/testcases/kernel/firmware/fw_load_kernel/ltp_fw_load.c
index b7397e8f13154a16c2626517545c3c14d153a043..6018e9a630d2f2328c8023568f2b61f7b80831fe 100644
--- a/testcases/kernel/firmware/fw_load_kernel/ltp_fw_load.c
+++ b/testcases/kernel/firmware/fw_load_kernel/ltp_fw_load.c
@@ -1,25 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+ * Author: Alexey Kodanev <alexey.kodanev@oracle.com>
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*
+ * Kernel module helper for the fw_load test.
  *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
+ * Registers a virtual device (ltp_fw_load) that exposes two sysfs
+ * attributes:
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *   fwnum  (write-only) - accepts the number of firmware files to
+ *           request (1-32). Writing triggers request_firmware() for
+ *           each file named n<i>_<fw_name> (i = 0 .. fwnum-1).
+ *           Each loaded blob is verified against the expected size
+ *           (fw_size) and byte pattern (every byte == i).
  *
- * Author:
- * Alexey Kodanev <alexey.kodanev@oracle.com>
+ *   result (read-only)  - bitmask of per-file pass/fail results.
+ *           Bit i is set when n<i>_<fw_name> was loaded and
+ *           verified successfully.
  *
- * This module is trying to load external test firmware files (n#_load_tst.fw).
- * In the end, it writes results to /sys/devices/ltp_fw_load/result file.
+ * Module parameters:
+ *   fw_name  - template firmware file name (default: load_tst.fw)
+ *   fw_size  - expected firmware blob size  (default: 0x1000)
  */
 
 #include <linux/module.h>
@@ -33,12 +38,11 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Alexey Kodanev <alexey.kodanev@oracle.com>");
 MODULE_DESCRIPTION("This module is checking device firmware loading");
 
-#define TCID	"ltp_fw_load"
+#define MODULE_NAME	"ltp_fw_load"
+#define MAX_NAME	64
 
 static char *fw_name	= "load_tst.fw";
 static int fw_size	= 0x1000;
-static int max_name	= 64;
-static int fw;
 
 module_param(fw_name, charp, 0444);
 MODULE_PARM_DESC(fw_name, "Template firmware file name: n#_name");
@@ -54,47 +58,53 @@ static int test_result;
 
 static void device_release(struct device *dev)
 {
-	pr_info(TCID ": device released\n");
+	pr_info(MODULE_NAME ": device released\n");
 }
 
 static struct device tdev = {
-	.init_name	= TCID,
+	.init_name	= MODULE_NAME,
 	.release	= device_release,
 };
 
-/* read and print firmware data */
-static int fw_read(const u8 *data, size_t size)
+/* read and verify firmware data */
+static int fw_read(const u8 *data, size_t size, u8 expected)
 {
 	size_t i;
-	pr_info(TCID ": Firmware has size '%zu'\n", size);
+
+	pr_info(MODULE_NAME ": Firmware has size '%zu'\n", size);
 	if (size != fw_size) {
-		pr_err(TCID ": Expected firmware size '%d'\n", fw_size);
+		pr_err(MODULE_NAME ": Expected firmware size '%d'\n", fw_size);
 		return -1;
 	}
+
 	for (i = 0; i < size; ++i) {
-		if (data[i] != (u8)fw) {
-			pr_err(TCID ": Unexpected firmware data\n");
+		if (data[i] != expected) {
+			pr_err(MODULE_NAME ": Unexpected firmware data\n");
 			return -1;
 		}
 	}
+
 	return 0;
 }
 
-static int try_request_fw(const char *name)
+static int try_request_fw(const char *name, u8 expected)
 {
 	int err;
 	const struct firmware *fw_entry = NULL;
+
 	err = request_firmware(&fw_entry, name, &tdev);
 	if (!err) {
-		pr_info(TCID ": firmware '%s' requested\n", name);
-		err = fw_read(fw_entry->data, fw_entry->size);
-	} else
-		pr_err(TCID ": Can't request firmware '%s'\n", name);
+		pr_info(MODULE_NAME ": firmware '%s' requested\n", name);
+		err = fw_read(fw_entry->data, fw_entry->size, expected);
+	} else {
+		pr_err(MODULE_NAME ": Can't request firmware '%s'\n", name);
+	}
+
 	release_firmware(fw_entry);
 	return err;
 }
 
-/* print test result to sysfs file */
+/* Print test result to sysfs file. */
 static ssize_t sys_result(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
@@ -102,26 +112,28 @@ static ssize_t sys_result(struct device *dev,
 }
 static DEVICE_ATTR(result, S_IRUSR, sys_result, NULL);
 
-/*
- * get the number of firmware files and
- * perform firmware requests
- */
+/* Get the number of firmware files and perform firmware requests. */
 static ssize_t sys_fwnum(struct device *dev,
-	struct device_attribute *attr,  const char *buf, size_t count)
+	struct device_attribute *attr, const char *buf, size_t count)
 {
-	int err, fw_num = 0;
+	int err, fw, fw_num;
 
-	sscanf(buf, "%d", &fw_num);
-	if (fw_num <= 0 || fw_num > 32) {
-		pr_err(TCID ": Unexpected number of firmwares '%d'", fw_num);
-		return count;
+	err = kstrtoint(buf, 10, &fw_num);
+	if (err || fw_num <= 0 || fw_num > 32) {
+		pr_err(MODULE_NAME ": Unexpected number of firmwares '%s'", buf);
+		return err ? err : -EINVAL;
 	}
+
+	test_result = 0;
+
 	for (fw = 0; fw < fw_num; ++fw) {
-		char name[max_name];
-		snprintf(name, max_name, "n%d_%s", fw, fw_name);
-		err = try_request_fw(name);
+		char name[MAX_NAME];
+
+		snprintf(name, sizeof(name), "n%d_%s", fw, fw_name);
+		err = try_request_fw(name, (u8)fw);
 		test_result |= (err == 0) << fw;
 	}
+
 	return count;
 }
 static DEVICE_ATTR(fwnum, S_IWUSR, NULL, sys_fwnum);
@@ -132,23 +144,25 @@ static int test_init(void)
 
 	err = device_register(&tdev);
 	if (err) {
-		pr_err(TCID ": Unable to register device\n");
+		pr_err(MODULE_NAME ": Unable to register device\n");
 		return err;
 	}
-	pr_info(TCID ": device registered\n");
+	pr_info(MODULE_NAME ": device registered\n");
 
 	err = device_create_file(&tdev, &dev_attr_result);
 	if (err) {
-		pr_err(TCID ": Can't create sysfs file 'result'\n");
+		pr_err(MODULE_NAME ": Can't create sysfs file 'result'\n");
 		device_unregister(&tdev);
 		return err;
 	}
+
 	err = device_create_file(&tdev, &dev_attr_fwnum);
 	if (err) {
-		pr_err(TCID ": Can't create sysfs file 'fwnum'\n");
+		pr_err(MODULE_NAME ": Can't create sysfs file 'fwnum'\n");
 		device_remove_file(&tdev, &dev_attr_result);
 		device_unregister(&tdev);
 	}
+
 	return err;
 }
 module_init(test_init);
@@ -159,6 +173,6 @@ static void test_exit(void)
 	device_remove_file(&tdev, &dev_attr_fwnum);
 
 	device_unregister(&tdev);
-	pr_info(TCID ": module exited\n");
+	pr_info(MODULE_NAME ": module exited\n");
 }
 module_exit(test_exit);

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
