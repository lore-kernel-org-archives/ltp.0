Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1VWOJt-0006w1-EJ
	for ltp-list@lists.sourceforge.net; Wed, 16 Oct 2013 10:27:13 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VWOJq-0008CE-D6
	for ltp-list@lists.sourceforge.net; Wed, 16 Oct 2013 10:27:13 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r9GAR4gI012172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 16 Oct 2013 10:27:04 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r9GAR38X005363
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 16 Oct 2013 10:27:04 GMT
Received: from abhmt104.oracle.com (abhmt104.oracle.com [141.146.116.56])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r9GAR2Ta007676
	for <ltp-list@lists.sourceforge.net>; Wed, 16 Oct 2013 10:27:02 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 16 Oct 2013 14:26:40 +0400
Message-Id: <1381919200-15004-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH v2 2/2] device-drivers: pci: fixes
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com, Alexey Kodanev <alexey.kodanev@oracle.com>

Obsolete code updated to the actual kernel PCI API.
Changed test-cases handling from ioctl to sysfs.
User-space program rewritten.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/kernel/device-drivers/pci/Makefile       |   20 +
 .../device-drivers/pci/tpci_kernel/.gitignore      |    7 +
 .../kernel/device-drivers/pci/tpci_kernel/Makefile |   39 +-
 .../device-drivers/pci/tpci_kernel/ltp_tpci.c      |  992 +++++++++-----------
 .../kernel/device-drivers/pci/tpci_kernel/tpci.h   |   90 +--
 .../kernel/device-drivers/pci/tpci_user/.gitignore |    1 +
 .../kernel/device-drivers/pci/tpci_user/Makefile   |   25 +-
 .../kernel/device-drivers/pci/tpci_user/tpci.c     |  308 ++-----
 8 files changed, 634 insertions(+), 848 deletions(-)
 create mode 100644 testcases/kernel/device-drivers/pci/Makefile
 create mode 100644 testcases/kernel/device-drivers/pci/tpci_kernel/.gitignore
 create mode 100644 testcases/kernel/device-drivers/pci/tpci_user/.gitignore

diff --git a/testcases/kernel/device-drivers/pci/Makefile b/testcases/kernel/device-drivers/pci/Makefile
new file mode 100644
index 0000000..b3bb5aa
--- /dev/null
+++ b/testcases/kernel/device-drivers/pci/Makefile
@@ -0,0 +1,20 @@
+# Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+
+top_srcdir	?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/device-drivers/pci/tpci_kernel/.gitignore b/testcases/kernel/device-drivers/pci/tpci_kernel/.gitignore
new file mode 100644
index 0000000..3e100ad
--- /dev/null
+++ b/testcases/kernel/device-drivers/pci/tpci_kernel/.gitignore
@@ -0,0 +1,7 @@
+/ltp_tpci.ko
+/*.mod.c
+/modules.order
+/.tmp_versions
+/.*.ko
+/.*.cmd
+/Module.symvers
diff --git a/testcases/kernel/device-drivers/pci/tpci_kernel/Makefile b/testcases/kernel/device-drivers/pci/tpci_kernel/Makefile
index 77c80ec..02496af 100644
--- a/testcases/kernel/device-drivers/pci/tpci_kernel/Makefile
+++ b/testcases/kernel/device-drivers/pci/tpci_kernel/Makefile
@@ -1,22 +1,35 @@
+# Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
 #
-# Makefile for GCOV profiling kernel module
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
-
-#KERNELDIR := /usr/src/linux-2.5.64-gcov
-CFLAGS := $(CFLAGS) -Wall
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 
 ifneq ($(KERNELRELEASE),)
 
-obj-m	:= tpci.o
+obj-m := ltp_tpci.o
+
 else
-KDIR	:= /lib/modules/$(shell uname -r)/build
-PWD	:= $(shell pwd)
 
-default:
-	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
-#	$(MAKE) -C $(KERNELDIR) SUBDIRS=$(PWD) modules
-endif
+top_srcdir	?= ../../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+REQ_VERSION_MAJOR := 2
+REQ_VERSION_PATCH := 6
+
+MAKE_TARGETS := ltp_tpci.ko
 
-clean:
-	rm -f tpci.o 2>/dev/null || true
+include $(top_srcdir)/include/mk/module.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
+endif
\ No newline at end of file
diff --git a/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c b/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
index c994c55..c6ce22c 100644
--- a/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
+++ b/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
@@ -1,22 +1,21 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
  *
- *   Copyright (c) International Business Machines  Corp., 2001
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- *
-
  * This pci and pci-express testing kernel module will allow test calls
  * to be driven through various ioctl calls in a
  * user space program that has attained the appropriate
@@ -35,7 +34,6 @@
  * module: tpci
  */
 
-#include <linux/config.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/fs.h>
@@ -43,359 +41,167 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/pci.h>
-#include <asm/uaccess.h>
+
 #include "tpci.h"
-#include "st_tpci.h"
 
-MODULE_AUTHOR
-    ("Sean Ruyle <srruyle@us.ibm.com>, Amit Khanna <amit.khanna@intel.com>");
-MODULE_DESCRIPTION(TPCI_TEST_DRIVER_NAME);
+MODULE_AUTHOR("Sean Ruyle <srruyle@us.ibm.com>");
+MODULE_AUTHOR("Amit Khanna <amit.khanna@intel.com>");
+MODULE_AUTHOR("Copyright (c) 2013 Oracle and/or its affiliates");
+MODULE_DESCRIPTION("LTP PCI Test");
 MODULE_LICENSE("GPL");
 
-static int tpci_ioctl(struct inode *, struct file *, unsigned int,
-		      unsigned long);
-static int tpci_open(struct inode *, struct file *);
-static int tpci_close(struct inode *, struct file *);
-
-static int probe_pci_dev(void);
-static int pci_enable(void);
-static int pci_disable(void);
-static int test_find_bus(void);
-static int test_find_class(void);
-static int test_find_device(void);
-static int test_find_subsys(void);
-static int test_scan_bus(void);
-static int test_slot_scan(void);
-static int test_bus_add_devices(void);
-static int test_enable_bridges(void);
-static int test_match_device(void);
-static int test_reg_driver(void);
-static int test_unreg_driver(void);
-static int test_assign_resources(void);
-static int test_save_state(void);
-static int test_restore_state(void);
-static int test_max_bus(void);
-static int test_find_cap(void);
-static int test_find_pci_exp_cap(void);
-static int test_read_pci_exp_config(void);
-
-static int Major = TPCI_MAJOR;
-static tpci_user_t ltp_pci;
+#define prk_err(fmt, ...) \
+	pr_err(PCI_DEVICE_NAME ": " fmt "\n", ##__VA_ARGS__)
+#define prk_info(fmt, ...) \
+	pr_info(PCI_DEVICE_NAME ": " fmt "\n", ##__VA_ARGS__)
+#define prk_debug(fmt, ...) \
+	pr_debug(PCI_DEVICE_NAME ": " fmt "\n", ##__VA_ARGS__)
 
-/*
- * File operations struct, to use operations find the
- * correct file descriptor
- */
-static struct file_operations tpci_fops = {
-open:	tpci_open,
-release:tpci_close,
-ioctl:	tpci_ioctl,
+#define TPASS	0
+#define TFAIL	1
+#define TSKIP	32
+
+static DEFINE_PCI_DEVICE_TABLE(ltp_pci_tbl) = {
+	{ PCI_DEVICE(PCI_ANY_ID, PCI_ANY_ID) },
+	{ 0, }
 };
 
-/*
- * open and close operations
- */
-static int tpci_open(struct inode *ino, struct file *f)
-{
-	return 0;
-}
+MODULE_DEVICE_TABLE(pci, ltp_pci_tbl);
 
-static int tpci_close(struct inode *ino, struct file *f)
+static int ltp_pci_probe(struct pci_dev *pci_dev,
+	const struct pci_device_id *pci_ent)
 {
 	return 0;
 }
 
-/*
- * tpci_ioctl:
- * 	a user space program can drive the test functions
- *	through a call to ioctl once the correct file
- *	descriptor has been attained
- *
- * calls functions:
- *
- */
-static int tpci_ioctl(struct inode *ino, struct file *f,
-		      unsigned int cmd, unsigned long l)
-{
-	int rc;
-	struct tpci_interface tif;
-	caddr_t *inparms;
-	caddr_t *outparms;
-
-	printk("Enter tpci_ioctl\n");
-
-	inparms = NULL;
-	outparms = NULL;
-	rc = 0;
-
-	if (copy_from_user(&tif, (void *)l, sizeof(tif))) {
-		/* Bad address */
-		return (-EFAULT);
-	}
-
-	/*
-	 * Setup inparms and outparms as needed
-	 */
-	if (tif.in_len > 0) {
-		inparms = (caddr_t *) kmalloc(tif.in_len, GFP_KERNEL);
-		if (!inparms) {
-			return (-ENOMEM);
-		}
-
-		rc = copy_from_user(inparms, tif.in_data, tif.in_len);
-		if (rc) {
-			kfree(inparms);
-			return (-EFAULT);
-		}
-	}
-	if (tif.out_len > 0) {
-		outparms = (caddr_t *) kmalloc(tif.out_len, GFP_KERNEL);
-		if (!outparms) {
-			kfree(inparms);
-			return (-ENOMEM);
-		}
-	}
-
-	/*
-	 * determine which call to make on the cmd value
-	 */
-	switch (cmd) {
-	case PCI_PROBE:
-		rc = probe_pci_dev();
-		break;
-	case PCI_ENABLE:
-		rc = pci_enable();
-		break;
-	case PCI_DISABLE:
-		rc = pci_disable();
-		break;
-	case FIND_BUS:
-		rc = test_find_bus();
-		break;
-	case FIND_CLASS:
-		rc = test_find_class();
-		break;
-	case FIND_DEVICE:
-		rc = test_find_device();
-		break;
-	case FIND_SUBSYS:
-		rc = test_find_subsys();
-		break;
-	case BUS_SCAN:
-		rc = test_scan_bus();
-		break;
-	case SLOT_SCAN:
-		rc = test_slot_scan();
-		break;
-	case BUS_ADD_DEVICES:
-		rc = test_bus_add_devices();
-		break;
-	case ENABLE_BRIDGES:
-		rc = test_enable_bridges();
-		break;
-	case MATCH_DEVICE:
-		rc = test_match_device();
-		break;
-	case REG_DRIVER:
-		rc = test_reg_driver();
-		break;
-	case UNREG_DRIVER:
-		rc = test_unreg_driver();
-		break;
-	case PCI_RESOURCES:
-		rc = test_assign_resources();
-		break;
-	case SAVE_STATE:
-		rc = test_save_state();
-		break;
-	case RESTORE_STATE:
-		rc = test_restore_state();
-		break;
-	case TEST_MAX_BUS:
-		rc = test_max_bus();
-		break;
-	case FIND_CAP:
-		rc = test_find_cap();
-		break;
-	case FIND_PCI_EXP_CAP:
-		rc = test_find_pci_exp_cap();
-		break;
-	case READ_PCI_EXP_CONFIG:
-		rc = test_read_pci_exp_config();
-		break;
-	default:
-		printk("Mismatching ioctl command\n");
-		break;
-	}
-
-	if (!(ltp_pci.dev))
-		printk("tpci: After ioctl call dev is NULL\n");
-
-	/*
-	 * copy in the return data, and test return code
-	 */
-	tif.out_rc = rc;
-	rc = 0;
-
-	/* if outparms then copy outparms into tif.out_data */
-	if (outparms) {
-		if (copy_to_user(tif.out_data, outparms, tif.out_len)) {
-			printk("tpci: Unsuccessful copy_to_user of outparms\n");
-			rc = -EFAULT;
-		}
-	}
-
-	/* copy tif structure into l so that can be used by user program */
-	if (copy_to_user((void *)l, &tif, sizeof(tif))) {
-		printk("tpci: Unsuccessful copy_to_user of tif\n");
-		rc = -EFAULT;
-	}
+static struct pci_driver ltp_pci_driver = {
+	.name     = "LTP_PCI_DRIVER",
+	.id_table = ltp_pci_tbl,
+	.probe    = ltp_pci_probe,
+};
 
-	/*
-	 * free inparms and outparms
-	 */
-	if (inparms) {
-		kfree(inparms);
-	}
-	if (outparms) {
-		kfree(outparms);
-	}
+static int pci_registered;
 
-	return rc;
-}
+struct tpci_user {
+	struct pci_dev		*dev;
+	struct pci_bus		*bus;
+	struct pci_driver	*drv;
+	uint32_t		state[16];
+};
+static struct tpci_user ltp_pci;
 
 /*
  * probe_pci_dev
- * 	find a pci device that can be used for other test
- * 	calls in this kernel module, select first device
- * 	that finds for use, do not need a specific device
+ *	find a pci device that can be used for other test
+ *	calls in this kernel module.
  */
-static int probe_pci_dev()
+static int probe_pci_dev(unsigned int bus, unsigned int slot)
 {
-	unsigned int i, j;
-	struct pci_dev *dev =
-	    (struct pci_dev *)kmalloc(sizeof(struct pci_dev), GFP_KERNEL);
-	struct pci_bus *bus =
-	    (struct pci_bus *)kmalloc(sizeof(struct pci_bus), GFP_KERNEL);
+	struct pci_dev *dev;
 
-	/* Zero out the ltp_pci */
-	memset(&ltp_pci, 0, sizeof(tpci_user_t));
+	prk_info("find arbitrary pci device for test");
 
-	ltp_pci.dev = dev;
-	ltp_pci.bus = bus;
-
-	/* Probe until find a pci device */
-	for (i = MAX_BUS; i > 0; i--) {
-		for (j = MAX_DEVFN; j > 1; j--) {
-			dev = pci_find_slot(i, j);
-			if (dev && dev->driver) {
-				printk
-				    ("tpci: found pci_dev, bus %d, devfn %d\n",
-				     i, j);
-				printk("Slot number: %d\n", dev->devfn);
-
-				bus = dev->bus;
-				printk("Bus number: %d\n", bus->number);
-
-				/* copy data into ltp_pci struct */
-				memcpy(ltp_pci.dev, dev,
-				       sizeof(struct pci_dev));
-				memcpy(ltp_pci.bus, bus,
-				       sizeof(struct pci_bus));
-
-				return 0;
-			}
-		}
+	if (ltp_pci.dev) {
+		pci_dev_put(ltp_pci.dev);
+		ltp_pci.dev = NULL;
 	}
 
-	/* if reaches here did not find a pci device */
-	printk("tpci: failed to find pci device\n");
-	return 1;
+	dev = pci_get_bus_and_slot(bus, slot);
+	if (!dev || !dev->driver)
+		return -ENODEV;
+
+	prk_info("found pci_dev '%s', bus %u, devfn %u",
+		pci_name(dev), bus, slot);
+
+	ltp_pci.dev = dev;
+	ltp_pci.bus = dev->bus;
+	prk_info("Bus number: %d", dev->bus->number);
+	return 0;
 }
 
 /*
  * pci_enable
- * 	enable a pci device so that it may be used in
- * 	later testing in the user test program
+ *	enable a pci device so that it may be used in
+ *	later testing in the user test program
  */
-static int pci_enable()
+static int pci_enable(void)
 {
-	int rc = 0;
-
 	struct pci_dev *dev = ltp_pci.dev;
 
+	prk_info("enable pci device");
+
 	/* check if can enable the device pointer */
 	if (!dev) {
-		printk("tpci: dev is NULL\n");
-		return 1;
+		prk_err("dev is NULL");
+		return TFAIL;
 	}
 
 	if (pci_enable_device(dev)) {
-		printk("tpci: failed to enable pci device\n");
-		rc = 1;
-	} else {
-		printk("tpci: enabled pci device\n");
-		rc = 0;
+		prk_err("failed to enable pci device");
+		return TFAIL;
 	}
 
-	return rc;
+	prk_info("enabled pci device");
+	return TPASS;
 }
 
-/*
- * pci_disable
- *	call to pci_disable_device
- */
-static int pci_disable()
+static int pci_disable(void)
 {
-	int rc = 0;
-
 	struct pci_dev *dev = ltp_pci.dev;
 
+	prk_info("disable pci device");
+
 	/* check if device pointer exists */
 	if (!dev) {
-		printk("tpci: dev is NULL\n");
-		return 1;
+		prk_err("dev is NULL");
+		return TFAIL;
 	}
 
+	prk_info("is pci enabled '%d', is managed '%d'",
+		pci_is_enabled(dev), pci_is_managed(dev));
+
+	pci_release_regions(dev);
 	pci_disable_device(dev);
 
-	if (dev->current_state == 4 || dev->current_state == 3) {
-		printk("tpci: disabled pci device\n");
-		rc = 0;
-	} else {
-		printk("tpci: failed to disable pci device\n");
-		rc = 1;
+	if (dev->current_state == PCI_D3hot ||
+		dev->current_state == PCI_D3cold) {
+
+		prk_info("disabled pci device, state '%s'",
+			pci_power_name(dev->current_state));
+		return TPASS;
+
 	}
 
-	return rc;
+	prk_err("failed to disable pci device, state '%s'",
+		pci_power_name(dev->current_state));
+	return TFAIL;
 }
 
 /*
  * find_bus
  *	call to pci_find_bus, use values from bus
  *	pointer in ltp_pci, make sure that returns
- * 	bus with same values
+ *	bus with same values
  */
-static int test_find_bus()
+static int test_find_bus(void)
 {
-	int rc;
 	int num = ltp_pci.bus->number;
 	struct pci_bus *temp = NULL;
 
-	temp = pci_find_bus(num);
+	prk_info("find bus");
+
+	temp = pci_find_bus(pci_domain_nr(ltp_pci.bus), num);
 
 	if (!temp) {
-		printk("tpci: pci_find_bus failed to return bus pointer\n");
-		rc = 1;
+		prk_info("pci_find_bus failed");
+		return TFAIL;
 	} else if (temp->number != num) {
-		printk("tpci: returned bus pointer w/ wrong bus number\n");
-		rc = 1;
-	} else {
-		printk("tpci: success returned bus pointer \n");
-		rc = 0;
+		prk_err("returned bus pointer w/ wrong bus number");
+		return TFAIL;
 	}
 
-	return rc;
+	prk_info("success returned bus pointer");
+	return TPASS;
 }
 
 /*
@@ -403,48 +209,50 @@ static int test_find_bus()
  *	call to pci_find_class, using values from the
  *	pci_dev pointer in ltp_pci structure
  */
-static int test_find_class()
+static int test_find_class(void)
 {
-	int rc;
 	unsigned int num = ltp_pci.dev->class;
 	struct pci_dev *temp = NULL;
 
-	temp = pci_find_class(num, NULL);
+	prk_info("find pci class");
+
+	temp = pci_get_class(num, NULL);
 
 	if (!temp) {
-		printk("tpci: failed to find pci device from class number\n");
-		rc = 1;
-	} else {
-		printk("tpci: found pci device from class number\n");
-		rc = 0;
+		prk_err("failed to find pci device from class number");
+		return TFAIL;
 	}
 
-	return rc;
+	prk_info("found pci device from class number");
+	pci_dev_put(temp);
+
+	return TPASS;
 }
 
 /*
  * find_device
- * 	call to pci_find_device, using values for
+ *	call to pci_find_device, using values for
  *	parameters from pci_dev pointer in the
  *	ltp_pci structure
  */
-static int test_find_device()
+static int test_find_device(void)
 {
-	int rc;
 	struct pci_dev *temp = NULL;
 	unsigned short ven = ltp_pci.dev->vendor, dev = ltp_pci.dev->device;
 
-	temp = pci_find_device(ven, dev, NULL);
+	prk_info("get pci device");
+
+	temp = pci_get_device(ven, dev, NULL);
 
 	if (!temp) {
-		printk("tpci: failed to find pci device from device info\n");
-		rc = 1;
-	} else {
-		printk("tpci: found pci device from device info\n");
-		rc = 0;
+		prk_err("failed to find pci device from device info");
+		return TFAIL;
 	}
 
-	return rc;
+	prk_info("found pci device from device info");
+	pci_dev_put(temp);
+
+	return TPASS;
 }
 
 /*
@@ -453,55 +261,58 @@ static int test_find_device()
  *	pci_dev pointer in ltp_pci structure to
  *	find pci_dev from subsys info
  */
-static int test_find_subsys()
+static int test_find_subsys(void)
 {
-	int rc;
-	struct pci_dev *temp = NULL;
+	struct pci_dev *temp;
 	unsigned short ven = ltp_pci.dev->vendor,
-	    dev = ltp_pci.dev->device,
-	    ss_ven = ltp_pci.dev->subsystem_vendor,
-	    ss_dev = ltp_pci.dev->subsystem_device;
+		dev = ltp_pci.dev->device,
+		ss_ven = ltp_pci.dev->subsystem_vendor,
+		ss_dev = ltp_pci.dev->subsystem_device;
 
-	temp = pci_find_subsys(ven, dev, ss_ven, ss_dev, NULL);
+	prk_info("get pci subsys");
+	temp = pci_get_subsys(ven, dev, ss_ven, ss_dev, NULL);
 
 	if (!temp) {
-		printk("tpci: failed to find pci device from subsys info\n");
-		rc = 1;
-	} else {
-		printk("tpci: found pci device from subsys info\n");
-		rc = 0;
+		prk_err("failed to find pci device from subsys info");
+		return TFAIL;
 	}
 
-	return rc;
+	prk_info("found pci device from subsys info");
+	pci_dev_put(temp);
+
+	return TPASS;
 }
 
 /*
  * test_scan_bus
  *	call to pci_do_scan_bus,  which takes
  *	a struct pci_bus pointer, which will
- * 	return a an integer for how far the
+ *	return an integer for how far the
  *	function got in scanning bus
  */
-static int test_scan_bus()
+static int test_scan_bus(void)
 {
-	int rc, num;
+	int num;
 	struct pci_bus *bus = ltp_pci.bus;
 
-	num = pci_do_scan_bus(bus);
+#ifdef CONFIG_HOTPLUG
+	prk_info("scan pci bus");
 
+	num = pci_rescan_bus(bus);
 	/*
 	 * check if returned number is greater than
 	 * max number of bus or less than 0
 	 */
 	if (num > MAX_BUS || num < 0) {
-		printk("tpci: Failed scan bus\n");
-		rc = 1;
-	} else {
-		printk("tpci: Success scan bus\n");
-		rc = 0;
+		prk_err("failed scan bus");
+		return TFAIL;
 	}
-
-	return rc;
+	prk_info("success scan bus");
+	return TPASS;
+#else
+	prk_info("pci_rescan_bus() is not supported");
+	return TSKIP;
+#endif
 }
 
 /*
@@ -510,23 +321,21 @@ static int test_scan_bus()
  *	find the device pointer and setup the
  *	device info
  */
-static int test_slot_scan()
+static int test_slot_scan(void)
 {
-	int rc, ret;
-	int num = ltp_pci.dev->devfn;
+	int ret, num = ltp_pci.dev->devfn;
 	struct pci_bus *bus = ltp_pci.bus;
 
-	ret = pci_scan_slot(bus, num);
+	prk_info("scan pci slot");
 
-	if (ret > 0) {
-		printk("tpci: Found device from scan slot\n");
-		rc = 0;
-	} else {
-		printk("tpci: Failed find device from scan slot\n");
-		rc = 1;
+	ret = pci_scan_slot(bus, num);
+	if (ret >= 0) {
+		prk_info("found '%d' devices from scan slot", ret);
+		return TPASS;
 	}
 
-	return rc;
+	prk_err("pci_scan_slot failed");
+	return TFAIL;
 }
 
 /*
@@ -536,22 +345,21 @@ static int test_slot_scan()
  *	that is passed in for more devices
  *	that it can add
  */
-static int test_bus_add_devices()
+static int test_bus_add_devices(void)
 {
-	int rc;
 	struct pci_bus *bus = ltp_pci.bus;
 
+	prk_info("add bus device");
+
 	pci_bus_add_devices(bus);
 
 	if (bus) {
-		printk("tpci: Called bus_add_device\n");
-		rc = 0;
-	} else {
-		printk("tpci: bus_add_device failed\n");
-		rc = 1;
+		prk_info("called bus_add_device");
+		return TPASS;
 	}
 
-	return rc;
+	prk_err("bus_add_device failed");
+	return TFAIL;
 }
 
 /*
@@ -560,22 +368,21 @@ static int test_bus_add_devices()
  *	use bus pointer from the ltp_pci
  *	structure
  */
-static int test_enable_bridges()
+static int test_enable_bridges(void)
 {
-	int rc;
 	struct pci_bus *bus = ltp_pci.bus;
 
+	prk_info("enable bridges");
+
 	pci_enable_bridges(bus);
 
 	if (bus) {
-		printk("tpci: Called enable bridges\n");
-		rc = 0;
-	} else {
-		printk("tpci: enable_bridges failed\n");
-		rc = 1;
+		prk_info("called enable bridges");
+		return TPASS;
 	}
 
-	return rc;
+	prk_err("enable_bridges failed");
+	return TFAIL;
 }
 
 /*
@@ -583,73 +390,49 @@ static int test_enable_bridges()
  *	make call to pci_match_device, returns a
  *	pci_device_id pointer
  */
-static int test_match_device()
+static int test_match_device(void)
 {
-	int rc;
 	struct pci_dev *dev = ltp_pci.dev;
 	struct pci_driver *drv;
 	const struct pci_device_id *id;
 
+	prk_info("test pci_device_id()");
+
 	drv = pci_dev_driver(dev);
 
 	if (!drv) {
-		printk("driver pointer not allocated for pci_dev\n");
-		return 1;
+		prk_err("driver pointer not allocated for pci_dev");
+		return TFAIL;
 	}
 
-	id = pci_match_device(drv->id_table, dev);
+	id = pci_match_id(drv->id_table, dev);
 
 	if (id) {
-		printk("tpci: Match device success\n");
-		rc = 0;
-	} else {
-		printk("tpci: Failed return pci_device_id \n");
-		rc = 1;
+		prk_info("match device success");
+		return TPASS;
 	}
 
-	return rc;
+	prk_err("failed return pci_device_id");
+	return TFAIL;
 }
 
+
 /*
  * test_reg_driver
  *	make call to pci_register_driver, which will
  *	register the driver for a device with the
  *	system
  */
-static int test_reg_driver()
+static int test_reg_driver(void)
 {
-	int rc, ret;
-	struct pci_driver *drv =
-	    (struct pci_driver *)kmalloc(sizeof(struct pci_driver), GFP_KERNEL);
-	struct pci_driver *tmp = ltp_pci.dev->driver;
-
-	/* zero out drv structure */
-	memset(drv, 0, sizeof(struct pci_driver));
-
-	/* copy in structure of tmp, reset some fields */
-	drv->name = "Tmod_driver";
-	drv->driver = tmp->driver;
-
-	/* copy structure into ltp_pci.drv */
-	ltp_pci.drv = drv;
-	memcpy(ltp_pci.drv, drv, sizeof(struct pci_driver));
-
-	if (!drv) {
-		printk("tpci: Device does not have a driver pointer\n");
-		return 1;
+	prk_info("test pci_register_driver");
+	if (pci_register_driver(&ltp_pci_driver)) {
+		prk_err("unsuccessful registering pci driver");
+		return TFAIL;
 	}
-
-	ret = pci_register_driver(drv);
-
-	if (ret) {
-		printk("tpci: Success driver register\n");
-		rc = 0;
-	} else {
-		rc = 1;
-		printk("tpci: unsuccessful registering pci driver\n");
-	}
-
-	return rc;
+	pci_registered = 1;
+	prk_info("success driver register");
+	return TPASS;
 }
 
 /*
@@ -657,26 +440,11 @@ static int test_reg_driver()
  *	make call to pci_unregister_driver, which will
  *	unregister the driver for a device from the system
  */
-static int test_unreg_driver()
+static int test_unreg_driver(void)
 {
-	int rc;
-	struct pci_driver *drv = ltp_pci.drv;
-
-	if (!drv) {
-		printk("tpci: Device does not have a driver pointer\n");
-		return 1;
-	}
-
-	pci_unregister_driver(drv);
-	if (!drv) {
-		printk("tpci: Unsuccesful driver unregister\n");
-		rc = 1;
-	} else {
-		printk("tpci: unregistering pci driver\n");
-		rc = 0;
-	}
-
-	return rc;
+	pci_unregister_driver(&ltp_pci_driver);
+	pci_registered = 0;
+	return TPASS;
 }
 
 /*
@@ -684,23 +452,34 @@ static int test_unreg_driver()
  *	make calls to pci_assign_resource, will need
  *	to setup a dev pointer and resource pointer,
  */
-static int test_assign_resources()
+static int test_assign_resources(void)
 {
-	int rc;
+	int i, ret, rc = 0;
 	struct pci_dev *dev = ltp_pci.dev;
-	int resno;
+	struct resource *r;
+
+	prk_info("assign resources");
 
-	for (resno = 0; resno < 7; resno++) {
-		struct resource *r = dev->resource + resno;
-		if (r->flags)
-			pci_assign_resource(dev, resno);
+	for (i = 0; i < 7; ++i) {
+		prk_info("assign resource #%d", i);
+		r = &dev->resource[i];
+		prk_info("name = %s, flags = %lu, start 0x%lx, end 0x%lx",
+			r->name, r->flags,
+			(unsigned long)r->start, (unsigned long)r->end);
+
+		if ((r->flags & IORESOURCE_MEM) == IORESOURCE_MEM) {
+			ret = pci_assign_resource(dev, i);
+			prk_info("assign resource to '%d', ret '%d'", i, ret);
+			rc |= (ret < 0 && ret != -EBUSY) ? TFAIL : TPASS;
+		}
 	}
 
 	/*
 	 * enable device after call to assign resource
 	 * because might error if (!r->start && r->end)
 	 */
-	rc = pci_enable_device(dev);
+	if (pci_enable_device(dev))
+		return TFAIL;
 
 	return rc;
 }
@@ -708,21 +487,21 @@ static int test_assign_resources()
 /*
  * test_save_state
  *	make call to pci_save_state, takes in a u32*
- * 	buffer
+ *	buffer
  */
-static int test_save_state()
+static int test_save_state(void)
 {
-	int rc;
-	u32 *buffer = ltp_pci.state;
 	struct pci_dev *dev = ltp_pci.dev;
 
-	rc = pci_save_state(dev, buffer);
-	if (rc)
-		printk("tpci: Failed save state\n");
-	else
-		printk("tpci: Saved state of device\n");
+	prk_info("save state");
 
-	return rc;
+	if (pci_save_state(dev)) {
+		prk_err("failed save state");
+		return TFAIL;
+	}
+
+	prk_info("saved state of device");
+	return TPASS;
 }
 
 /*
@@ -730,40 +509,15 @@ static int test_save_state()
  *	make call to pci_restore_state, get the state buffer
  *	should have been previously filled out by save state
  */
-static int test_restore_state()
+static int test_restore_state(void)
 {
-	int rc;
-	u32 *buffer = ltp_pci.state;
 	struct pci_dev *dev = ltp_pci.dev;
 
-	rc = pci_restore_state(dev, buffer);
-	if (rc)
-		printk("tpci: Failed restore state\n");
-	else
-		printk("tpci: Restored state of device\n");
+	prk_info("restore state");
 
-	return rc;
-}
-
-/*
- * test_max_bus
- *	make call to pci_max_busnr, which will determine
- *	the max number of bus on the system
- */
-static int test_max_bus()
-{
-	int rc, ret;
-
-	ret = pci_max_busnr();
-	if (ret) {
-		printk("Found max busnr\n");
-		rc = 0;
-	} else {
-		printk("Did not return max busnr\n");
-		rc = 1;
-	}
+	pci_restore_state(dev);
 
-	return rc;
+	return TPASS;
 }
 
 /*
@@ -773,121 +527,261 @@ static int test_max_bus()
  *	capability, use second parameter to specify
  *	which capability you are looking for
  */
-static int test_find_cap()
+static int test_find_cap(void)
 {
-	int rc;
 	struct pci_dev *dev = ltp_pci.dev;
 
-	rc = pci_find_capability(dev, PCI_CAP_ID_PM);
-	if (rc)
-		printk("tpci: Does not have tested capability\n");
+	prk_info("find device capability");
+
+	if (pci_find_capability(dev, PCI_CAP_ID_PM))
+		prk_info("does not have tested capability");
 	else
-		printk("tpci: Device has PM capability\n");
+		prk_info("device has PM capability");
 
-	return rc;
+	return TPASS;
 }
 
 /*
  * test_find_pci_exp_cap
  *	make call to pci_find_capability, which will
- *  determine if a device has PCI-EXPRESS capability,
- *  use second parameter to specify which capability
- *  you are looking for
+ *	determine if a device has PCI-EXPRESS capability,
+ *	use second parameter to specify which capability
+ *	you are looking for
  */
-static int test_find_pci_exp_cap()
+static int test_find_pci_exp_cap(void)
 {
-	int rc;
 	struct pci_dev *dev = ltp_pci.dev;
 
-	rc = pci_find_capability(dev, PCI_CAP_ID_EXP);
-	if (rc)
-		printk("tpci: Device has PCI-EXP capability\n");
-	else
-		printk("tpci: Device doesn't have PCI-EXP capability\n");
-	return rc;
+	prk_info("find PCIe capability");
+
+	if (pci_find_capability(dev, PCI_CAP_ID_EXP)) {
+		prk_info("device has PCI-EXP capability");
+		return TPASS;
+	}
+
+	prk_info("device doesn't have PCI-EXP capability");
+	return TFAIL;
 }
 
 /*
  * test_read_pci_exp_config
  *	make call to pci_config_read and determine if
- *  the PCI-Express enhanced config space of this
- *  device can be read successfully.
+ *	the PCI-Express enhanced config space of this
+ *	device can be read successfully.
  */
-static int test_read_pci_exp_config()
+static int test_read_pci_exp_config(void)
 {
-	int rc;
-	int reg = 100, len = 4;	/*PCI-Exp enhanced config register 0x100, 4 implies dword access */
+	/* PCI-Exp enhanced config register 0x100, 4 implies dword access */
+	int reg = 100;
 	struct pci_dev *dev = ltp_pci.dev;
+	u32 data;
 
-	u32 data, *value;
+	/* skip the test if device doesn't have PCIe capability */
+	if (test_find_pci_exp_cap() == TFAIL)
+		return TSKIP;
 
-	printk("tpci: Device(%d) on bus(%d) & slot(%d) \n", dev,
-	       dev->bus->number, dev->devfn);
-	printk("tpci: Reading the PCI Express configuration registers---\n");
+	prk_info("dev on bus(%d) & slot (%d)", dev->bus->number, dev->devfn);
+	prk_info("reading the PCI Express configuration registers---");
+	prk_info("reading PCI-Express AER CAP-ID REGISTER at Enh-Cfg AddrSpace 0x100");
 
-	printk
-	    ("tpci: Reading PCI-Express AER CAP-ID REGISTER at Enh-Cfg AddrSpace 0x100\n");
+	if (pci_read_config_dword(dev, reg, &data)) {
+		prk_err("failed to read config word");
+		return TFAIL;
+	}
 
-	rc = pci_config_read(0, dev->bus->number, PCI_SLOT(dev->devfn),
-			     PCI_FUNC(dev->devfn), reg, len, &data);
+	/* comparing the value read with AER_CAP_ID_VALUE macro */
+	if (data == AER_CAP_ID_VALUE) {
+		prk_info("correct val read using PCIE driver installed: '%u'",
+			data);
+		return TPASS;
+	}
 
-	*value = (u32) data;
+	prk_err("incorrect val read. PCIE driver/device not installed: '%u'",
+		data);
+	return TFAIL;
+}
 
-	if (*value == AER_CAP_ID_VALUE)	/*comparing the value read with AER_CAP_ID_VALUE macro */
-		printk
-		    ("tpci: \nCorrect value read using PCI-Express driver installed\n\n");
-	else
-		printk
-		    ("tpci: \nIncorrect value read. PCI-Express driver/device not installed\n\n");
+
+static int test_case(unsigned int cmd)
+{
+	int rc = TSKIP;
+
+	switch (cmd) {
+	case PCI_ENABLE:
+		rc = pci_enable();
+		break;
+	case PCI_DISABLE:
+		rc = pci_disable();
+		break;
+	case FIND_BUS:
+		rc = test_find_bus();
+		break;
+	case FIND_CLASS:
+		rc = test_find_class();
+		break;
+	case FIND_DEVICE:
+		rc = test_find_device();
+		break;
+	case FIND_SUBSYS:
+		rc = test_find_subsys();
+		break;
+	case BUS_SCAN:
+		rc = test_scan_bus();
+		break;
+	case SLOT_SCAN:
+		rc = test_slot_scan();
+		break;
+	case BUS_ADD_DEVICES:
+		rc = test_bus_add_devices();
+		break;
+	case ENABLE_BRIDGES:
+		rc = test_enable_bridges();
+		break;
+	case MATCH_DEVICE:
+		rc = test_match_device();
+		break;
+	case REG_DRIVER:
+		rc = test_reg_driver();
+		break;
+	case UNREG_DRIVER:
+		rc = test_unreg_driver();
+		break;
+	case PCI_RESOURCES:
+		rc = test_assign_resources();
+		break;
+	case SAVE_STATE:
+		rc = test_save_state();
+		break;
+	case RESTORE_STATE:
+		rc = test_restore_state();
+		break;
+	case FIND_CAP:
+		rc = test_find_cap();
+		break;
+	case PCI_EXP_CAP_CONFIG:
+		rc = test_read_pci_exp_config();
+		break;
+	default:
+		prk_info("mismatching test-case command %d", cmd);
+		break;
+	}
 
 	return rc;
 }
 
 /*
- * tpci_init_module
- * 	set the owner of tpci_fops, register the module
- * 	as a char device, and perform any necessary
- * 	initialization for pci devices
+ * Test-case result,
+ * if test is passed, value will be set to 0
  */
+static int test_result;
+
+static void device_release(struct device *dev)
+{
+	prk_info("device released\n");
+}
+
+static struct device tdev = {
+	.init_name	= PCI_DEVICE_NAME,
+	.release	= device_release,
+};
+
+/* print test result to sysfs file */
+static ssize_t sys_result(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "%d\n", test_result);
+}
+static DEVICE_ATTR(result, S_IRUSR, sys_result, NULL);
+
+static ssize_t sys_tcase(struct device *dev,
+	struct device_attribute *attr,  const char *buf, size_t count)
+{
+	int tc = 0;
+
+	sscanf(buf, "%d", &tc);
+	prk_info("test-case %d", tc);
+
+	test_result = test_case(tc);
+
+	return count;
+}
+static DEVICE_ATTR(tcase, S_IWUSR, NULL, sys_tcase);
+
+static ssize_t sys_bus_slot(struct device *dev,
+	struct device_attribute *attr,  const char *buf, size_t count)
+{
+	unsigned int res, bus, slot;
+	int ret;
+
+	sscanf(buf, "%u", &res);
+
+	bus = res >> 8 & 0xFF;
+	slot = res & 0xFF;
+
+	prk_info("get bus '%u' slot '%u'", bus, slot);
+
+	ret = probe_pci_dev(bus, slot);
+	if (ret)
+		return ret;
+
+	return count;
+}
+static DEVICE_ATTR(bus_slot, S_IWUSR, NULL, sys_bus_slot);
+
 static int tpci_init_module(void)
 {
-	int rc;
+	int err = 0;
+	prk_info("Starting module");
+
+	err = device_register(&tdev);
+	if (err) {
+		prk_err("Unable to register device");
+		goto err0;
+	}
+	prk_info("device registered\n");
 
-	SET_MODULE_OWNER(&tpci_fops);
+	err = device_create_file(&tdev, &dev_attr_result);
+	if (err) {
+		prk_err("Can't create sysfs file 'result'");
+		goto err1;
+	}
 
-	rc = register_chrdev(Major, DEVICE_NAME, &tpci_fops);
-	if (rc < 0) {
-		printk("tpci: Failed to register device.\n");
-		return rc;
+	err = device_create_file(&tdev, &dev_attr_tcase);
+	if (err) {
+		prk_err(": Can't create sysfs file 'tc'");
+		goto err2;
 	}
 
-	if (Major == 0)
-		Major = rc;
+	err = device_create_file(&tdev, &dev_attr_bus_slot);
+	if (err) {
+		prk_err(": Can't create sysfs file 'bus_slot'");
+		goto err3;
+	}
 
-	printk("tpci: Registration success.\n");
 	return 0;
+
+err3:
+	device_remove_file(&tdev, &dev_attr_tcase);
+err2:
+	device_remove_file(&tdev, &dev_attr_result);
+err1:
+	device_unregister(&tdev);
+err0:
+	return err;
 }
+module_init(tpci_init_module)
 
-/*
- * tpci_exit_module
- * 	unregister the device and any necessary
- * 	operations to close for pci devices
- */
 static void tpci_exit_module(void)
 {
-	int rc;
+	prk_debug("Unloading module\n");
+	if (ltp_pci.dev)
+		pci_dev_put(ltp_pci.dev);
 
-	kfree(ltp_pci.dev);
-	kfree(ltp_pci.bus);
-	kfree(ltp_pci.drv);
-
-	rc = unregister_chrdev(Major, DEVICE_NAME);
-	if (rc < 0)
-		printk("tpci: unregister failed\n");
-	else
-		printk("tpci: unregister success\n");
+	if (pci_registered)
+		pci_unregister_driver(&ltp_pci_driver);
 
+	device_remove_file(&tdev, &dev_attr_result);
+	device_remove_file(&tdev, &dev_attr_tcase);
+	device_unregister(&tdev);
 }
-
-module_init(tpci_init_module)
-    module_exit(tpci_exit_module)
+module_exit(tpci_exit_module)
diff --git a/testcases/kernel/device-drivers/pci/tpci_kernel/tpci.h b/testcases/kernel/device-drivers/pci/tpci_kernel/tpci.h
index bd81369..d5ee669 100644
--- a/testcases/kernel/device-drivers/pci/tpci_kernel/tpci.h
+++ b/testcases/kernel/device-drivers/pci/tpci_kernel/tpci.h
@@ -1,67 +1,45 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
  *
- *   Copyright (c) International Business Machines  Corp., 2001
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
-
-#define TPCI_TEST_DRIVER_NAME	"pci/pci-express test module"
-#define TPCI_MAJOR      252
-#define DEVICE_NAME		"/dev/tpci"
+#define PCI_DEVICE_NAME		"ltp_tpci"
 #define MAX_DEVFN		256
 #define MAX_BUS			256
-#define MAG_NUM 		'k'
 #define AER_CAP_ID_VALUE	0x14011
 
-#define PCI_PROBE		_IO(MAG_NUM, 1)
-#define PCI_ENABLE		_IO(MAG_NUM, 2)
-#define PCI_DISABLE		_IO(MAG_NUM, 3)
-#define FIND_BUS	        _IO(MAG_NUM, 4)
-#define FIND_DEVICE             _IO(MAG_NUM, 5)
-#define FIND_CLASS              _IO(MAG_NUM, 6)
-#define FIND_SUBSYS             _IO(MAG_NUM, 7)
-#define BUS_SCAN		_IO(MAG_NUM, 8)
-#define	SLOT_SCAN		_IO(MAG_NUM, 9)
-#define ENABLE_BRIDGES		_IO(MAG_NUM, 10)
-#define BUS_ADD_DEVICES		_IO(MAG_NUM, 11)
-#define MATCH_DEVICE		_IO(MAG_NUM, 12)
-#define REG_DRIVER		_IO(MAG_NUM, 13)
-#define UNREG_DRIVER		_IO(MAG_NUM, 14)
-#define BUS_RESOURCES		_IO(MAG_NUM, 15)
-#define PCI_RESOURCES		_IO(MAG_NUM, 16)
-#define SAVE_STATE		_IO(MAG_NUM, 19)
-#define RESTORE_STATE		_IO(MAG_NUM, 20)
-#define TEST_MAX_BUS		_IO(MAG_NUM, 21)
-#define FIND_CAP		_IO(MAG_NUM, 22)
-#define FIND_PCI_EXP_CAP	_IO(MAG_NUM, 23)
-#define READ_PCI_EXP_CONFIG	_IO(MAG_NUM, 24)
-#ifndef SET_MODULE_OWNER
-#define SET_MODULE_OWNER(dev) ((dev)->owner = THIS_MODULE)
-#endif
-
-/*
- * structures for PCI test driver
- */
-struct tpci_interface {
-	int 	in_len;		// input data length
-	caddr_t	in_data;	// input data
-	int 	out_rc;		// return code from the test
-	int 	out_len;	// output data length
-	caddr_t	out_data;	// output data
+enum PCI_TCASES {
+	PCI_DISABLE = 0,
+	PCI_ENABLE,
+	FIND_BUS,
+	FIND_DEVICE,
+	FIND_CLASS,
+	FIND_SUBSYS,
+	BUS_SCAN,
+	SLOT_SCAN,
+	ENABLE_BRIDGES,
+	BUS_ADD_DEVICES,
+	MATCH_DEVICE,
+	REG_DRIVER,
+	UNREG_DRIVER,
+	PCI_RESOURCES,
+	SAVE_STATE,
+	RESTORE_STATE,
+	FIND_CAP,
+	PCI_EXP_CAP_CONFIG,
+	PCI_TCASES_NUM,
 };
-typedef struct tpci_interface tpci_interface_t;
-
-
diff --git a/testcases/kernel/device-drivers/pci/tpci_user/.gitignore b/testcases/kernel/device-drivers/pci/tpci_user/.gitignore
new file mode 100644
index 0000000..b1817e5
--- /dev/null
+++ b/testcases/kernel/device-drivers/pci/tpci_user/.gitignore
@@ -0,0 +1 @@
+/tpci
diff --git a/testcases/kernel/device-drivers/pci/tpci_user/Makefile b/testcases/kernel/device-drivers/pci/tpci_user/Makefile
index 38ed3eb..6ba3465 100644
--- a/testcases/kernel/device-drivers/pci/tpci_user/Makefile
+++ b/testcases/kernel/device-drivers/pci/tpci_user/Makefile
@@ -1,9 +1,20 @@
+# Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 
-CFLAGS += -Wall
-OBJS = tpci_ki.o user_tpci.o
+top_srcdir		?= ../../../../..
 
-test_pci: $(OBJS)
-	$(CC) $(CFLAGS) $(LDFLAGS) $^ -o $@
-
-clean:
-	rm -f $(OBJS) test_pci
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/device-drivers/pci/tpci_user/tpci.c b/testcases/kernel/device-drivers/pci/tpci_user/tpci.c
index 3d4cc45..b0273de 100644
--- a/testcases/kernel/device-drivers/pci/tpci_user/tpci.c
+++ b/testcases/kernel/device-drivers/pci/tpci_user/tpci.c
@@ -1,258 +1,120 @@
-#include <stdio.h>
 /*
+ * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
  *
- *   Copyright (c) International Business Machines  Corp., 2001
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
+ * Author: Alexey Kodanev <alexey.kodanev@oracle.com>
  *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
-#include <sys/stat.h>
-#include <sys/ioctl.h>
-#include <fcntl.h>
+#include <unistd.h>
+#include <string.h>
 #include <errno.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include "user_tpci.h"
-#include "../tpci/tpci.h"
-
-static int tpci_fd = -1;	/* file descriptor */
 
-int tpciopen()
-{
-
-	dev_t devt;
-	struct stat st;
-	int rc = 0;
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+#include "tst_module.h"
 
-	devt = makedev(TPCI_MAJOR, 0);
+#include "../tpci_kernel/tpci.h"
 
-	if (rc) {
-		if (errno == ENOENT) {
-			/* dev node does not exist. */
-			rc = mkdir(DEVICE_NAME, (S_IFDIR | S_IRWXU |
-						 S_IRGRP | S_IXGRP |
-						 S_IROTH | S_IXOTH));
-		} else {
-			printf
-			    ("ERROR: Problem with Base dev directory.  Error code from stat() is %d\n\n",
-			     errno);
-		}
+char *TCID = "test_pci";
+int TST_TOTAL = PCI_TCASES_NUM;
 
-	} else {
-		if (!(st.st_mode & S_IFDIR)) {
-			rc = unlink(DEVICE_NAME);
-			if (!rc) {
-				rc = mkdir(DEVICE_NAME, (S_IFDIR | S_IRWXU |
-							 S_IRGRP | S_IXGRP |
-							 S_IROTH | S_IXOTH));
-			}
-		}
-	}
-
-	/*
-	 * Check for the /dev/tbase node, and create if it does not
-	 * exist.
-	 */
-	rc = stat(DEVICE_NAME, &st);
-	if (rc) {
-		if (errno == ENOENT) {
-			/* dev node does not exist */
-			rc = mknod(DEVICE_NAME,
-				   (S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP |
-				    S_IWGRP), devt);
-		} else {
-			printf
-			    ("ERROR:Problem with tbase device node directory.  Error code form stat() is %d\n\n",
-			     errno);
-		}
+static const char module_name[]	= PCI_DEVICE_NAME ".ko";
+static const char dev_result[]	= "/sys/devices/" PCI_DEVICE_NAME "/result";
+static const char dev_tcase[]	= "/sys/devices/" PCI_DEVICE_NAME "/tcase";
+static const char dev_busslot[]	= "/sys/devices/" PCI_DEVICE_NAME "/bus_slot";
+static int module_loaded;
 
-	} else {
-		/*
-		 * /dev/tbase CHR device exists.  Check to make sure it is for a
-		 * block device and that it has the right major and minor.
-		 */
-		if ((!(st.st_mode & S_IFCHR)) || (st.st_rdev != devt)) {
-
-			/* Recreate the dev node. */
-			rc = unlink(DEVICE_NAME);
-			if (!rc) {
-				rc = mknod(DEVICE_NAME,
-					   (S_IFCHR | S_IRUSR | S_IWUSR |
-					    S_IRGRP | S_IWGRP), devt);
-			}
-		}
-	}
-
-	tpci_fd = open(DEVICE_NAME, O_RDWR);
-
-	if (tpci_fd < 0) {
-		printf("ERROR: Open of device %s failed %d errno = %d\n",
-		       DEVICE_NAME, tpci_fd, errno);
-		return errno;
-	} else {
-		printf("Device opened successfully \n");
-		return 0;
-	}
+static void cleanup(void)
+{
+	if (module_loaded)
+		tst_module_unload(NULL, module_name);
 
+	TEST_CLEANUP;
 }
 
-int tpciclose()
+void setup(int argc, char *argv[])
 {
+	tst_require_root(NULL);
 
-	if (tpci_fd != -1) {
-		close(tpci_fd);
-		tpci_fd = -1;
+	if (tst_kvercmp(2, 6, 0) < 0) {
+		tst_brkm(TCONF, NULL,
+			"Test must be run with kernel 2.6 or newer");
 	}
 
-	return 0;
+	tst_sig(FORK, DEF_HANDLER, cleanup);
 }
 
-int main()
+static void run_pci_testcases(int bus, int slot)
 {
-	int rc;
-
-	rc = tpciopen();
-	if (rc) {
-		printf("Test PCI Driver may not be loaded\n");
-		exit(1);
-	}
+	int i, res;
+	for (i = 0; i < TST_TOTAL; ++i) {
+		/* skip pci disable test-case, it is manual */
+		if (i == PCI_DISABLE)
+			continue;
 
-	/* test find pci */
-	if (ki_generic(tpci_fd, PCI_PROBE)) {
-		printf("Failed to find a pci device\n");
-		exit(1);
-	} else
-		printf("Success probing for pci device\n");
+		SAFE_FILE_PRINTF(cleanup, dev_tcase, "%d", i);
+		SAFE_FILE_SCANF(cleanup, dev_result, "%d", &res);
 
-	/* test disable device */
-	if (ki_generic(tpci_fd, PCI_DISABLE))
-		printf
-		    ("Failed to disable device \nMay still be in use by system\n");
-	else
-		printf("Disabled device\n");
-
-	/* test enable device */
-	if (ki_generic(tpci_fd, PCI_ENABLE))
-		printf("Failed to enable device\n");
-	else
-		printf("Enabled device\n");
-
-	/* test find from bus */
-	if (ki_generic(tpci_fd, FIND_BUS))
-		printf("Failed to find from bus pointer\n");
-	else
-		printf("Found device from bus pointer\n");
-
-	/* test find from device */
-	if (ki_generic(tpci_fd, FIND_DEVICE))
-		printf("Failed to find device from device info\n");
-	else
-		printf("Found device from device info\n");
-
-	/* test find from class */
-	if (ki_generic(tpci_fd, FIND_CLASS))
-		printf("Failed to find device from class\n");
-	else
-		printf("Found device from class \n");
-
-	/* test find subsys */
-	if (ki_generic(tpci_fd, FIND_SUBSYS))
-		printf("Failed to find device from subsys info\n");
-	else
-		printf("Found device from subsys info\n");
-
-	/* test scan bus */
-	if (ki_generic(tpci_fd, BUS_SCAN))
-		printf("Failed on bus scan call\n");
-	else
-		printf("Success scanning bus\n");
-
-	/* test scan slot */
-	if (ki_generic(tpci_fd, SLOT_SCAN))
-		printf("Failed on scan slot \n");
-	else
-		printf("Success scan slot\n");
-
-	/* test enable bridges */
-	if (ki_generic(tpci_fd, ENABLE_BRIDGES))
-		printf("Failed to enable bridges\n");
-	else
-		printf("Enabled bridges\n");
-
-	/* test bus add devices */
-	if (ki_generic(tpci_fd, BUS_ADD_DEVICES))
-		printf("Failed on bus add devices call\n");
-	else
-		printf("Success bus add devices\n");
-
-	/* test match device */
-	if (ki_generic(tpci_fd, MATCH_DEVICE))
-		printf("Failed on match device call\n");
-	else
-		printf("Success match device\n");
-
-#if 0
-	/* test unregister driver */
-	if (ki_generic(tpci_fd, UNREG_DRIVER))
-		printf("Failed to unregister driver\n");
-	else
-		printf("Unregistered driver\n");
-#endif
-
-	/* test register driver */
-	if (ki_generic(tpci_fd, REG_DRIVER))
-		printf("Failed to register driver\n");
-	else
-		printf("Registerd driver\n");
+		tst_resm(res, "PCI bus %02x slot %02x : Test-case '%d'",
+			bus, slot, i);
+	}
+}
 
-	/* test pci resources */
-	if (ki_generic(tpci_fd, PCI_RESOURCES))
-		printf("Failed on pci_resources call\n");
-	else
-		printf("Success pci resources\n");
+static void test_run(void)
+{
+	tst_module_load(cleanup, module_name, NULL);
+	module_loaded = 1;
+
+	char buf[6];
+	int i, j, fd, count;
+
+	for (i = 0; i < MAX_BUS; ++i) {
+		for (j = 0; j < MAX_DEVFN; ++j) {
+			/* set pci device for the test */
+			fd = SAFE_OPEN(cleanup, dev_busslot, O_WRONLY);
+			count = snprintf(buf, 6, "%u", i << 8 | j);
+			errno = 0;
+			if (write(fd, buf, count) < 0) {
+				if (errno == ENODEV) {
+					SAFE_CLOSE(cleanup, fd);
+					continue;
+				}
+				tst_brkm(TBROK | TERRNO, cleanup,
+					"write to '%s' failed", dev_busslot);
+			}
+			SAFE_CLOSE(cleanup, fd);
 
-	/* test save state */
-	if (ki_generic(tpci_fd, SAVE_STATE))
-		printf("Failed to save state of device\n");
-	else
-		printf("Saved state of device\n");
+			run_pci_testcases(i, j);
 
-	/* test restore state */
-	if (ki_generic(tpci_fd, RESTORE_STATE))
-		printf("Failed to restore state\n");
-	else
-		printf("Restored state\n");
+		}
+	}
+}
 
-	/* test max bus */
-	if (ki_generic(tpci_fd, TEST_MAX_BUS))
-		printf("Failed on max bus call\n");
-	else
-		printf("Success max bus \n");
+int main(int argc, char *argv[])
+{
+	setup(argc, argv);
 
-	if (ki_generic(tpci_fd, FIND_CAP))
-		printf("Does not have tested capability\n");
-	else
-		printf("Device has tested capability\n");
+	test_run();
 
-	rc = tpciclose();
-	if (rc) {
-		printf("Test PCI Driver may not be closed\n");
-		exit(1);
-	}
+	cleanup();
 
-	return 0;
+	tst_exit();
 }
-- 
1.7.1


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
