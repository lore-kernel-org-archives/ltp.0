Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F94C55822
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 09:45:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 41E753E4B79
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 11:45:54 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A63C83E2DB0
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 11:45:21 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B49292001B3
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 11:45:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CD6AF7FD40;
 Wed,  5 Aug 2026 09:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785923106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zxYnO6AnPHGtPMkZRYzxfvy1ADSJe6O2H6f3bK2w4uU=;
 b=pjZe28VKxZLbLZnzbnV3GDAsv4UXjrtUy8zrWo4Hjeof9yBbHSMvHbd7h0thSamIA20CcL
 jrm/4dDJaP3rJMgz/lwPqF/7G7FtRXpbx+poj5znxGopuct2oJ/2YNOdwnGmsjOX1IITVR
 UYwaqjtSWhPHjAfp+rbE1qv5/HZuD20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785923106;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zxYnO6AnPHGtPMkZRYzxfvy1ADSJe6O2H6f3bK2w4uU=;
 b=uMdmJuaGCOHtCYOfH769RCHHrRc2AyQaZQsxmBgl1C6L+SjPruig3zR8fyNsXkhcX3Qjdn
 FM22p5ZXjJGlnhAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785923101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zxYnO6AnPHGtPMkZRYzxfvy1ADSJe6O2H6f3bK2w4uU=;
 b=en4tGB5EZcM6xci4VrfKu9lw4mFRzqLJKlMmz6z6PXheg1NOD/It8AvRbM+SFcBP4pccTG
 V5AjfffZT4m5Q+UFwdeZMbR9CS1SALL/cm+ATz31LO1M3hoxu5j5walQK2VbjIVuR6eg4h
 yB8ylA8NVtmemodfzklblgW8+pS9oWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785923101;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zxYnO6AnPHGtPMkZRYzxfvy1ADSJe6O2H6f3bK2w4uU=;
 b=pHkC8vlVERyqlk7uP7D3o/o78Siwzfse1pXkLS4cMjJIwYSZMp98TRb/heizboWzXP196p
 Pq6E3Lb0zUZICPBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94653779C3;
 Wed,  5 Aug 2026 09:45:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oBGBIh0Gc2pzRAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 05 Aug 2026 09:45:01 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 05 Aug 2026 11:44:57 +0200
MIME-Version: 1.0
Message-Id: <20260805-tpci_refactoring-v1-1-4ca8d84f8a95@suse.com>
References: <20260805-tpci_refactoring-v1-0-4ca8d84f8a95@suse.com>
In-Reply-To: <20260805-tpci_refactoring-v1-0-4ca8d84f8a95@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785923101; l=23220;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=M0ZJtUg8LQjy2vGdviKadx+1wp+ysbbGdJZnbQIY9TI=;
 b=wViNdWQggzy5AY57UsnSNxqPSHBhgvxflvPXvUlUyEaG/ozQXcTq8LwR3xHn2n37ItSVqMWfZ
 qeP6OxhyOowDMU0n3yo8Rg8EbCnuVQiT8aUKabQlJlItsLlSXQMynAp
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email, intel.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] tpci: refactor kernel module
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

The kernel module lacked proper SPDX licensing, documentation, and
used deprecated permission macros.

Update the code to modern kernel standards by applying SPDX tags,
replacing sscanf with kstrto*, replacing custom print macros with
standard pr_* macros, adding a documentation block, and removing
the stale pci-exp-tests-HOWTO file which references long-removed
paths and macros.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 .../device-drivers/pci/tpci_kernel/ltp_tpci.c      | 230 +++++++++++----------
 .../pci/tpci_kernel/pci-exp-tests-HOWTO            |  58 ------
 .../kernel/device-drivers/pci/tpci_kernel/tpci.h   |  21 +-
 3 files changed, 123 insertions(+), 186 deletions(-)

diff --git a/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c b/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
index 45138d834d099b62f201977b284bc8d12647056c..033ac1f0008e358d1afd0240bf1a9855ec32e1fd 100644
--- a/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
+++ b/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
@@ -1,47 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2001
+ *	5/20/2003 - Sean Ruyle (srruyle@us.ibm.com)
  * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+ *	8/20/2004 - Amit Khanna (amit.khanna@intel.com)
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * This PCI and PCI-Express testing kernel module allows test calls to be
+ * driven through various sysfs interactions in a user-space program.
  *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- *
- * This pci and pci-express testing kernel module will allow test calls
- * to be driven through various ioctl calls in a
- * user space program that has attained the appropriate
- * file descriptor for this device. For the functions of
- * this module to work correctly there must be a pci / pci-express
- * device somewhere in the system. The tests do not need
- * a specific device, and the first pci device available
- * will be grabbed.
+ * For the functions of this module to work correctly, there must be a
+ * PCI / PCI-Express device somewhere in the system. The tests do not need
+ * a specific device; the first PCI device available will be grabbed.
  *
- * author: Sean Ruyle (srruyle@us.ibm.com)
- * date:   5/20/2003
- * PCI-Express test scripts author: Amit Khanna (amit.khanna@intel.com)
- * date:   8/20/2004
+ * The following test cases can be called from user-space:
  *
- * file:   tpci.c,
- * module: tpci
+ * - PCI_DISABLE
+ * - PCI_ENABLE
+ * - FIND_BUS
+ * - FIND_DEVICE
+ * - FIND_CLASS
+ * - FIND_SUBSYS
+ * - BUS_SCAN
+ * - SLOT_SCAN
+ * - BUS_ADD_DEVICES
+ * - MATCH_DEVICE
+ * - REG_DRIVER
+ * - UNREG_DRIVER
+ * - PCI_RESOURCES
+ * - SAVE_STATE
+ * - RESTORE_STATE
+ * - FIND_CAP
+ * - PCI_EXP_CAP_CONFIG
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/fs.h>
-#include <linux/ioctl.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/pci.h>
-
 #include "tpci.h"
 
 MODULE_AUTHOR("Sean Ruyle <srruyle@us.ibm.com>");
@@ -50,13 +52,6 @@ MODULE_AUTHOR("Copyright (c) 2013 Oracle and/or its affiliates");
 MODULE_DESCRIPTION("LTP PCI Test");
 MODULE_LICENSE("GPL");
 
-#define prk_err(fmt, ...) \
-	pr_err(PCI_DEVICE_NAME ": " fmt "\n", ##__VA_ARGS__)
-#define prk_info(fmt, ...) \
-	pr_info(PCI_DEVICE_NAME ": " fmt "\n", ##__VA_ARGS__)
-#define prk_debug(fmt, ...) \
-	pr_debug(PCI_DEVICE_NAME ": " fmt "\n", ##__VA_ARGS__)
-
 #define TPASS	0
 #define TFAIL	1
 #define TSKIP	32
@@ -105,15 +100,19 @@ static int probe_pci_dev(unsigned int bus, unsigned int slot)
 	}
 
 	dev = pci_get_domain_bus_and_slot(0, bus, slot);
-	if (!dev || !dev->driver)
+	if (!dev)
+		return -ENODEV;
+	if (!dev->driver) {
+		pci_dev_put(dev);
 		return -ENODEV;
+	}
 
-	prk_info("found pci_dev '%s', bus %u, devfn %u",
+	pr_info("found pci_dev '%s', bus %u, devfn %u\n",
 		pci_name(dev), bus, slot);
 
 	ltp_pci.dev = dev;
 	ltp_pci.bus = dev->bus;
-	prk_info("Bus number: %d", dev->bus->number);
+	pr_info("Bus number: %d\n", dev->bus->number);
 	return 0;
 }
 
@@ -126,20 +125,20 @@ static int pci_enable(void)
 {
 	struct pci_dev *dev = ltp_pci.dev;
 
-	prk_info("enable pci device");
+	pr_info("enable pci device\n");
 
 	/* check if can enable the device pointer */
 	if (!dev) {
-		prk_err("dev is NULL");
+		pr_err("dev is NULL\n");
 		return TFAIL;
 	}
 
 	if (pci_enable_device(dev)) {
-		prk_err("failed to enable pci device");
+		pr_err("failed to enable pci device\n");
 		return TFAIL;
 	}
 
-	prk_info("enabled pci device");
+	pr_info("enabled pci device\n");
 	return TPASS;
 }
 
@@ -147,15 +146,15 @@ static int pci_disable(void)
 {
 	struct pci_dev *dev = ltp_pci.dev;
 
-	prk_info("disable pci device");
+	pr_info("disable pci device\n");
 
 	/* check if device pointer exists */
 	if (!dev) {
-		prk_err("dev is NULL");
+		pr_err("dev is NULL\n");
 		return TFAIL;
 	}
 
-	prk_info("is pci enabled '%d', is managed '%d'",
+	pr_info("is pci enabled '%d', is managed '%d'\n",
 		pci_is_enabled(dev), pci_is_managed(dev));
 
 	pci_release_regions(dev);
@@ -164,13 +163,13 @@ static int pci_disable(void)
 	if (dev->current_state == PCI_D3hot ||
 		dev->current_state == PCI_D3cold) {
 
-		prk_info("disabled pci device, state '%s'",
+		pr_info("disabled pci device, state '%s'\n",
 			pci_power_name(dev->current_state));
 		return TPASS;
 
 	}
 
-	prk_err("failed to disable pci device, state '%s'",
+	pr_err("failed to disable pci device, state '%s'\n",
 		pci_power_name(dev->current_state));
 	return TFAIL;
 }
@@ -186,19 +185,19 @@ static int test_find_bus(void)
 	int num = ltp_pci.bus->number;
 	struct pci_bus *temp = NULL;
 
-	prk_info("find bus");
+	pr_info("find bus\n");
 
 	temp = pci_find_bus(pci_domain_nr(ltp_pci.bus), num);
 
 	if (!temp) {
-		prk_info("pci_find_bus failed");
+		pr_info("pci_find_bus failed\n");
 		return TFAIL;
 	} else if (temp->number != num) {
-		prk_err("returned bus pointer w/ wrong bus number");
+		pr_err("returned bus pointer w/ wrong bus number\n");
 		return TFAIL;
 	}
 
-	prk_info("success returned bus pointer");
+	pr_info("success returned bus pointer\n");
 	return TPASS;
 }
 
@@ -212,16 +211,16 @@ static int test_find_class(void)
 	unsigned int num = ltp_pci.dev->class;
 	struct pci_dev *temp = NULL;
 
-	prk_info("find pci class");
+	pr_info("find pci class\n");
 
 	temp = pci_get_class(num, NULL);
 
 	if (!temp) {
-		prk_err("failed to find pci device from class number");
+		pr_err("failed to find pci device from class number\n");
 		return TFAIL;
 	}
 
-	prk_info("found pci device from class number");
+	pr_info("found pci device from class number\n");
 	pci_dev_put(temp);
 
 	return TPASS;
@@ -238,16 +237,16 @@ static int test_find_device(void)
 	struct pci_dev *temp = NULL;
 	unsigned short ven = ltp_pci.dev->vendor, dev = ltp_pci.dev->device;
 
-	prk_info("get pci device");
+	pr_info("get pci device\n");
 
 	temp = pci_get_device(ven, dev, NULL);
 
 	if (!temp) {
-		prk_err("failed to find pci device from device info");
+		pr_err("failed to find pci device from device info\n");
 		return TFAIL;
 	}
 
-	prk_info("found pci device from device info");
+	pr_info("found pci device from device info\n");
 	pci_dev_put(temp);
 
 	return TPASS;
@@ -267,15 +266,15 @@ static int test_find_subsys(void)
 		ss_ven = ltp_pci.dev->subsystem_vendor,
 		ss_dev = ltp_pci.dev->subsystem_device;
 
-	prk_info("get pci subsys");
+	pr_info("get pci subsys\n");
 	temp = pci_get_subsys(ven, dev, ss_ven, ss_dev, NULL);
 
 	if (!temp) {
-		prk_err("failed to find pci device from subsys info");
+		pr_err("failed to find pci device from subsys info\n");
 		return TFAIL;
 	}
 
-	prk_info("found pci device from subsys info");
+	pr_info("found pci device from subsys info\n");
 	pci_dev_put(temp);
 
 	return TPASS;
@@ -293,7 +292,7 @@ static int test_scan_bus(void)
 	int num;
 	struct pci_bus *bus = ltp_pci.bus;
 
-	prk_info("scan pci bus");
+	pr_info("scan pci bus\n");
 
 	num = pci_rescan_bus(bus);
 	/*
@@ -301,10 +300,10 @@ static int test_scan_bus(void)
 	 * max number of bus or less than 0
 	 */
 	if (num > MAX_BUS || num < 0) {
-		prk_err("failed scan bus");
+		pr_err("failed scan bus\n");
 		return TFAIL;
 	}
-	prk_info("success scan bus");
+	pr_info("success scan bus\n");
 	return TPASS;
 }
 
@@ -319,18 +318,18 @@ static int test_slot_scan(void)
 	int ret, num = ltp_pci.dev->devfn;
 	struct pci_bus *bus = ltp_pci.bus;
 
-	prk_info("scan pci slot");
+	pr_info("scan pci slot\n");
 
 	if ((num % 8) != 0)
 		return TPASS;
 
 	ret = pci_scan_slot(bus, num);
 	if (ret >= 0) {
-		prk_info("found '%d' devices from scan slot", ret);
+		pr_info("found '%d' devices from scan slot\n", ret);
 		return TPASS;
 	}
 
-	prk_err("pci_scan_slot failed");
+	pr_err("pci_scan_slot failed\n");
 	return TFAIL;
 }
 
@@ -345,16 +344,16 @@ static int test_bus_add_devices(void)
 {
 	struct pci_bus *bus = ltp_pci.bus;
 
-	prk_info("add bus device");
+	pr_info("add bus device\n");
 
 	pci_bus_add_devices(bus);
 
 	if (bus) {
-		prk_info("called bus_add_device");
+		pr_info("called bus_add_device\n");
 		return TPASS;
 	}
 
-	prk_err("bus_add_device failed");
+	pr_err("bus_add_device failed\n");
 	return TFAIL;
 }
 
@@ -369,23 +368,23 @@ static int test_match_device(void)
 	struct pci_driver *drv;
 	const struct pci_device_id *id;
 
-	prk_info("test pci_device_id()");
+	pr_info("test pci_device_id()\n");
 
 	drv = pci_dev_driver(dev);
 
 	if (!drv) {
-		prk_err("driver pointer not allocated for pci_dev");
+		pr_err("driver pointer not allocated for pci_dev\n");
 		return TFAIL;
 	}
 
 	id = pci_match_id(drv->id_table, dev);
 
 	if (id) {
-		prk_info("match device success");
+		pr_info("match device success\n");
 		return TPASS;
 	}
 
-	prk_err("failed return pci_device_id");
+	pr_err("failed return pci_device_id\n");
 	return TFAIL;
 }
 
@@ -398,13 +397,13 @@ static int test_match_device(void)
  */
 static int test_reg_driver(void)
 {
-	prk_info("test pci_register_driver");
+	pr_info("test pci_register_driver\n");
 	if (pci_register_driver(&ltp_pci_driver)) {
-		prk_err("unsuccessful registering pci driver");
+		pr_err("unsuccessful registering pci driver\n");
 		return TFAIL;
 	}
 	pci_registered = 1;
-	prk_info("success driver register");
+	pr_info("success driver register\n");
 	return TPASS;
 }
 
@@ -431,12 +430,12 @@ static int test_assign_resources(void)
 	struct pci_dev *dev = ltp_pci.dev;
 	struct resource *r;
 
-	prk_info("assign resources");
+	pr_info("assign resources\n");
 
 	for (i = 0; i < 7; ++i) {
-		prk_info("assign resource #%d", i);
+		pr_info("assign resource #%d\n", i);
 		r = &dev->resource[i];
-		prk_info("name = %s, flags = %lu, start 0x%lx, end 0x%lx",
+		pr_info("name = %s, flags = %lu, start 0x%lx, end 0x%lx\n",
 			r->name, r->flags,
 			(unsigned long)r->start, (unsigned long)r->end);
 
@@ -450,14 +449,14 @@ static int test_assign_resources(void)
 
 			pci_release_resource(dev, i);
 			ret = pci_assign_resource(dev, i);
-			prk_info("assign resource to '%d', ret '%d'", i, ret);
+			pr_info("assign resource to '%d', ret '%d'\n", i, ret);
 
 			if (ret == 0 && dev->hdr_type == PCI_HEADER_TYPE_NORMAL) {
 				int attach_ret;
 
 				attach_ret = device_attach(&dev->dev);
 				if (attach_ret < 0)
-					prk_info("device_attach failed for endpoint, ret: %d", attach_ret);
+					pr_info("device_attach failed for endpoint, ret: %d\n", attach_ret);
 			}
 
 			rc |= (ret < 0 && ret != -EBUSY) ? TFAIL : TPASS;
@@ -483,14 +482,14 @@ static int test_save_state(void)
 {
 	struct pci_dev *dev = ltp_pci.dev;
 
-	prk_info("save state");
+	pr_info("save state\n");
 
 	if (pci_save_state(dev)) {
-		prk_err("failed save state");
+		pr_err("failed save state\n");
 		return TFAIL;
 	}
 
-	prk_info("saved state of device");
+	pr_info("saved state of device\n");
 	return TPASS;
 }
 
@@ -503,7 +502,7 @@ static int test_restore_state(void)
 {
 	struct pci_dev *dev = ltp_pci.dev;
 
-	prk_info("restore state");
+	pr_info("restore state\n");
 
 	pci_restore_state(dev);
 
@@ -521,12 +520,12 @@ static int test_find_cap(void)
 {
 	struct pci_dev *dev = ltp_pci.dev;
 
-	prk_info("find device capability");
+	pr_info("find device capability\n");
 
 	if (pci_find_capability(dev, PCI_CAP_ID_PM))
-		prk_info("does not have tested capability");
+		pr_info("device has PM capability\n");
 	else
-		prk_info("device has PM capability");
+		pr_info("does not have tested capability\n");
 
 	return TPASS;
 }
@@ -546,24 +545,24 @@ static int test_read_pci_exp_config(void)
 	/* skip the test if device doesn't have PCIe capability */
 	pos = pci_pcie_cap(dev);
 	if (!pos) {
-		prk_info("device doesn't have PCI-EXP capability");
+		pr_info("device doesn't have PCI-EXP capability\n");
 		return TSKIP;
 	}
-	prk_info("read the PCI Express configuration registers at 0x%x", pos);
+	pr_info("read the PCI Express configuration registers at 0x%x\n", pos);
 
 	if (pci_read_config_dword(dev, pos, &header)) {
-		prk_err("failed to read config dword");
+		pr_err("failed to read config dword\n");
 		return TFAIL;
 	}
 
 	/* comparing the value read with PCI_CAP_ID_EXP macro */
 	if ((header & 0x000000ff) == PCI_CAP_ID_EXP) {
-		prk_info("correct val read using PCIE driver installed: 0x%x",
+		pr_info("correct val read using PCIE driver installed: 0x%x\n",
 			header);
 		return TPASS;
 	}
 
-	prk_err("incorrect val read. PCIE driver/device not installed: 0x%x",
+	pr_err("incorrect val read. PCIE driver/device not installed: 0x%x\n",
 		header);
 	return TFAIL;
 }
@@ -573,7 +572,7 @@ static int test_case(unsigned int cmd)
 	int rc = TSKIP;
 
 	if (!ltp_pci.dev || !ltp_pci.bus) {
-		prk_err("device or bus not selected for test");
+		pr_err("device or bus not selected for test\n");
 		return TFAIL;
 	}
 
@@ -630,7 +629,7 @@ static int test_case(unsigned int cmd)
 		rc = test_read_pci_exp_config();
 		break;
 	default:
-		prk_info("mismatching test-case command %d", cmd);
+		pr_info("mismatching test-case command %d\n", cmd);
 		break;
 	}
 
@@ -645,7 +644,7 @@ static int test_result;
 
 static void device_release(struct device *dev)
 {
-	prk_info("device released\n");
+	pr_info("device released\n");
 }
 
 static struct device tdev = {
@@ -654,34 +653,36 @@ static struct device tdev = {
 };
 
 /* print test result to sysfs file */
-static ssize_t sys_result(struct device *dev,
+static ssize_t result_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	return scnprintf(buf, PAGE_SIZE, "%d\n", test_result);
 }
-static DEVICE_ATTR(result, S_IRUSR, sys_result, NULL);
+static DEVICE_ATTR_RO(result);
 
-static ssize_t sys_tcase(struct device *dev,
+static ssize_t tcase_store(struct device *dev,
 	struct device_attribute *attr,  const char *buf, size_t count)
 {
 	int tc = 0;
 
-	sscanf(buf, "%d", &tc);
-	prk_info("test-case %d", tc);
+	if (kstrtoint(buf, 10, &tc) < 0)
+		return -EINVAL;
+	pr_info("test-case %d\n", tc);
 
 	test_result = test_case(tc);
 
 	return count;
 }
-static DEVICE_ATTR(tcase, S_IWUSR, NULL, sys_tcase);
+static DEVICE_ATTR_WO(tcase);
 
-static ssize_t sys_bus_slot(struct device *dev,
+static ssize_t bus_slot_store(struct device *dev,
 	struct device_attribute *attr,  const char *buf, size_t count)
 {
 	unsigned int res, bus, slot;
 	int ret;
 
-	sscanf(buf, "%u", &res);
+	if (kstrtouint(buf, 10, &res) < 0)
+		return -EINVAL;
 
 	bus = res >> 8 & 0xFF;
 	slot = res & 0xFF;
@@ -692,35 +693,36 @@ static ssize_t sys_bus_slot(struct device *dev,
 
 	return count;
 }
-static DEVICE_ATTR(bus_slot, S_IWUSR, NULL, sys_bus_slot);
+static DEVICE_ATTR_WO(bus_slot);
 
 static int tpci_init_module(void)
 {
 	int err = 0;
-	prk_info("Starting module");
+
+	pr_info("Starting module\n");
 
 	err = device_register(&tdev);
 	if (err) {
-		prk_err("Unable to register device");
+		pr_err("Unable to register device\n");
 		goto err0;
 	}
-	prk_info("device registered\n");
+	pr_info("device registered\n");
 
 	err = device_create_file(&tdev, &dev_attr_result);
 	if (err) {
-		prk_err("Can't create sysfs file 'result'");
+		pr_err("Can't create sysfs file 'result'\n");
 		goto err1;
 	}
 
 	err = device_create_file(&tdev, &dev_attr_tcase);
 	if (err) {
-		prk_err(": Can't create sysfs file 'tc'");
+		pr_err("Can't create sysfs file 'tc'\n");
 		goto err2;
 	}
 
 	err = device_create_file(&tdev, &dev_attr_bus_slot);
 	if (err) {
-		prk_err(": Can't create sysfs file 'bus_slot'");
+		pr_err("Can't create sysfs file 'bus_slot'\n");
 		goto err3;
 	}
 
@@ -739,7 +741,7 @@ module_init(tpci_init_module)
 
 static void tpci_exit_module(void)
 {
-	prk_debug("Unloading module\n");
+	pr_debug("Unloading module\n");
 	if (ltp_pci.dev)
 		pci_dev_put(ltp_pci.dev);
 
diff --git a/testcases/kernel/device-drivers/pci/tpci_kernel/pci-exp-tests-HOWTO b/testcases/kernel/device-drivers/pci/tpci_kernel/pci-exp-tests-HOWTO
deleted file mode 100644
index fb84dfc6189f2a56240d717eab87e7ee2df86fc6..0000000000000000000000000000000000000000
--- a/testcases/kernel/device-drivers/pci/tpci_kernel/pci-exp-tests-HOWTO
+++ /dev/null
@@ -1,58 +0,0 @@
-HOWTO -->	PCI-Express test scripts for LTP
-	Amit Khanna amit.khanna@intel.com
-			08/20/2004
-
-1. About this HOWTO
-
-This document describes the addition of PCI-Express test cases to the existing LTP project.
-These test cases/scripts will enhance the LTP's capability to test PCI-Express devices/drivers.
-
-2. Copyright (c) Intel Corporation, 2004
-
-3. What is this patch doing?
-
-a. A function "test_find_pci_exp_cap" has been added to the tpci.c file of LTP project.
-	(\ltp\testcases\kernel\device-drivers\pci\tpci\tpci.c)
-	 This function makes a call to pci_find_capability, which will determine if a device
-	 has PCI-Express capability. A PCI Express device function indicates PCI-Express support
-	 by implementing the PCI-Express capability structure in its capability list.
-
-b. A function "test_read_pci_exp_config" has been added to the tpci.c file of LTP project.
- 	This function calls "pci_config_read" and determines if the PCI-Express enhanced config
- 	space of the device can be read successfully or not.
-
-	"pci_config_read" function here reads the Advanced Error Reporting CAP-ID register located
-	 at the PCI-Express enhanced config space address 0x100. The value of this register is a READ-ONLY
-	 value which is constant on all the PCI-Express devices. If the value read from this register matches with the
-	 defined macro AER_CAP_ID_VALUE(in tpci.h) that means that PCI-Express driver is accessing
-	 the enhanced config space SUCCESSFULLY.
-
-c. A user space function 'ki_generic()" is already available in user_tpci.c file of LTP project,
-   (\ltp\testcases\kernel\device-drivers\pci\user_tpci\user_tpci.c) which will drive the kernel
-   module tpci to test various pci and pci-express functions (defined & prototyped in tpci.c).
-
-
-4. Including PCI-Express support into the kernel
-
-By default, the kernel may not enable PCI-Express feature. A kernel
-configuration option must be selected to enable PCI-Express support.
-
-To include PCI-Express support into the kernel requires users to enable PCI-Access mode with
-"Any" or "MMCFG" in the "General Setup" menu in the kernel configuration menu.
-
-5. FAQ
-
-Q1. Are there any limitations on using this patch?
-
-A1. If the device supports PCI-Express feature and the PCI-Express feature is enabled in the kernel,
-then only a user will be able to access the PCI-Express space.
-Even if the device doesn't support PCI-Express feature, the traditional PCI-space would still be accessible.
-
-Q2. What is this AER_CAP_ID_VALUE macro defined in tpci.h?
-
-A2. AER_CAP_ID_VALUE represents the value of Advanced Error Reporting Capability ID in the PCI Express config space.
-The default value of this is always same for all PCI-Express devices. i.e. 0x14011.
-In the function "test_read_pci_exp_config" in tpci.c file, it is compared with the value retrieved from a PCI-Express
-capable device. If both the values match that means that the PCI-Express driver is accessing the PCI-Express config space
-SUCCESSFULLY.
-***FINISH***
diff --git a/testcases/kernel/device-drivers/pci/tpci_kernel/tpci.h b/testcases/kernel/device-drivers/pci/tpci_kernel/tpci.h
index f7defb29ffc781c6ce7472b9c9545189dc4ca804..7791e3ec78a957e97a8123d7776080a7ee46f9e0 100644
--- a/testcases/kernel/device-drivers/pci/tpci_kernel/tpci.h
+++ b/testcases/kernel/device-drivers/pci/tpci_kernel/tpci.h
@@ -1,22 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * Copyright (c) International Business Machines  Corp., 2001
  * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
+#ifndef LTP_TPCI_H
+#define LTP_TPCI_H
+
 #define PCI_DEVICE_NAME		"ltp_tpci"
 #define MAX_DEVFN		256
 #define MAX_BUS			256
@@ -41,3 +32,5 @@ enum PCI_TCASES {
 	PCI_EXP_CAP_CONFIG,
 	PCI_TCASES_NUM,
 };
+
+#endif

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
