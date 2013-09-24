Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1VOSoO-00064I-F0
	for ltp-list@lists.sourceforge.net; Tue, 24 Sep 2013 13:37:56 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VOSoK-0004kz-9F
	for ltp-list@lists.sourceforge.net; Tue, 24 Sep 2013 13:37:56 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r8ODbjMK004524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 24 Sep 2013 13:37:46 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r8ODbiJO009393
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 24 Sep 2013 13:37:45 GMT
Received: from abhmt110.oracle.com (abhmt110.oracle.com [141.146.116.62])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r8ODbiiZ002969
	for <ltp-list@lists.sourceforge.net>; Tue, 24 Sep 2013 13:37:44 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 24 Sep 2013 17:37:08 +0400
Message-Id: <1380029829-8113-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 1/2] device-drivers: pci: rename files and remove
	useless files
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

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/kernel/device-drivers/pci/tpci/Makefile  |   22 -
 .../device-drivers/pci/tpci/pci-exp-tests-HOWTO    |   58 --
 testcases/kernel/device-drivers/pci/tpci/st_tpci.h |   27 -
 testcases/kernel/device-drivers/pci/tpci/tpci.c    |  893 --------------------
 testcases/kernel/device-drivers/pci/tpci/tpci.h    |   67 --
 .../kernel/device-drivers/pci/tpci/tpci.mod.c      |   29 -
 .../kernel/device-drivers/pci/tpci_kernel/Makefile |   22 +
 .../device-drivers/pci/tpci_kernel/ltp_tpci.c      |  893 ++++++++++++++++++++
 .../pci/tpci_kernel/pci-exp-tests-HOWTO            |   58 ++
 .../kernel/device-drivers/pci/tpci_kernel/tpci.h   |   67 ++
 .../kernel/device-drivers/pci/tpci_user/Makefile   |    9 +
 .../kernel/device-drivers/pci/tpci_user/tpci.c     |  258 ++++++
 .../kernel/device-drivers/pci/user_tpci/Makefile   |    9 -
 .../kernel/device-drivers/pci/user_tpci/tpci_ki.c  |  198 -----
 .../device-drivers/pci/user_tpci/user_tpci.c       |  258 ------
 .../device-drivers/pci/user_tpci/user_tpci.h       |   31 -
 16 files changed, 1307 insertions(+), 1592 deletions(-)
 delete mode 100644 testcases/kernel/device-drivers/pci/tpci/Makefile
 delete mode 100644 testcases/kernel/device-drivers/pci/tpci/pci-exp-tests-HOWTO
 delete mode 100644 testcases/kernel/device-drivers/pci/tpci/st_tpci.h
 delete mode 100644 testcases/kernel/device-drivers/pci/tpci/tpci.c
 delete mode 100644 testcases/kernel/device-drivers/pci/tpci/tpci.h
 delete mode 100644 testcases/kernel/device-drivers/pci/tpci/tpci.mod.c
 create mode 100644 testcases/kernel/device-drivers/pci/tpci_kernel/Makefile
 create mode 100644 testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
 create mode 100644 testcases/kernel/device-drivers/pci/tpci_kernel/pci-exp-tests-HOWTO
 create mode 100644 testcases/kernel/device-drivers/pci/tpci_kernel/tpci.h
 create mode 100644 testcases/kernel/device-drivers/pci/tpci_user/Makefile
 create mode 100644 testcases/kernel/device-drivers/pci/tpci_user/tpci.c
 delete mode 100644 testcases/kernel/device-drivers/pci/user_tpci/Makefile
 delete mode 100644 testcases/kernel/device-drivers/pci/user_tpci/tpci_ki.c
 delete mode 100644 testcases/kernel/device-drivers/pci/user_tpci/user_tpci.c
 delete mode 100644 testcases/kernel/device-drivers/pci/user_tpci/user_tpci.h

diff --git a/testcases/kernel/device-drivers/pci/tpci/Makefile b/testcases/kernel/device-drivers/pci/tpci/Makefile
deleted file mode 100644
index 77c80ec..0000000
--- a/testcases/kernel/device-drivers/pci/tpci/Makefile
+++ /dev/null
@@ -1,22 +0,0 @@
-#
-# Makefile for GCOV profiling kernel module
-#
-
-#KERNELDIR := /usr/src/linux-2.5.64-gcov
-CFLAGS := $(CFLAGS) -Wall
-
-ifneq ($(KERNELRELEASE),)
-
-obj-m	:= tpci.o
-else
-KDIR	:= /lib/modules/$(shell uname -r)/build
-PWD	:= $(shell pwd)
-
-default:
-	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
-#	$(MAKE) -C $(KERNELDIR) SUBDIRS=$(PWD) modules
-endif
-
-clean:
-	rm -f tpci.o 2>/dev/null || true
-
diff --git a/testcases/kernel/device-drivers/pci/tpci/pci-exp-tests-HOWTO b/testcases/kernel/device-drivers/pci/tpci/pci-exp-tests-HOWTO
deleted file mode 100644
index fb84dfc..0000000
--- a/testcases/kernel/device-drivers/pci/tpci/pci-exp-tests-HOWTO
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
diff --git a/testcases/kernel/device-drivers/pci/tpci/st_tpci.h b/testcases/kernel/device-drivers/pci/tpci/st_tpci.h
deleted file mode 100644
index 4538890..0000000
--- a/testcases/kernel/device-drivers/pci/tpci/st_tpci.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- *
-*/
-
-struct tpci_user {
-	struct pci_dev 		*dev;
-	struct pci_bus 		*bus;
-	struct pci_driver 	*drv;
-	uint32_t		state[16];
-};
-typedef struct tpci_user tpci_user_t;
diff --git a/testcases/kernel/device-drivers/pci/tpci/tpci.c b/testcases/kernel/device-drivers/pci/tpci/tpci.c
deleted file mode 100644
index c994c55..0000000
--- a/testcases/kernel/device-drivers/pci/tpci/tpci.c
+++ /dev/null
@@ -1,893 +0,0 @@
-/*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- *
-
- * This pci and pci-express testing kernel module will allow test calls
- * to be driven through various ioctl calls in a
- * user space program that has attained the appropriate
- * file descriptor for this device. For the functions of
- * this module to work correctly there must be a pci / pci-express
- * device somewhere in the system. The tests do not need
- * a specific device, and the first pci device available
- * will be grabbed.
- *
- * author: Sean Ruyle (srruyle@us.ibm.com)
- * date:   5/20/2003
- * PCI-Express test scripts author: Amit Khanna (amit.khanna@intel.com)
- * date:   8/20/2004
- *
- * file:   tpci.c,
- * module: tpci
- */
-
-#include <linux/config.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/fs.h>
-#include <linux/ioctl.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <asm/uaccess.h>
-#include "tpci.h"
-#include "st_tpci.h"
-
-MODULE_AUTHOR
-    ("Sean Ruyle <srruyle@us.ibm.com>, Amit Khanna <amit.khanna@intel.com>");
-MODULE_DESCRIPTION(TPCI_TEST_DRIVER_NAME);
-MODULE_LICENSE("GPL");
-
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
-
-/*
- * File operations struct, to use operations find the
- * correct file descriptor
- */
-static struct file_operations tpci_fops = {
-open:	tpci_open,
-release:tpci_close,
-ioctl:	tpci_ioctl,
-};
-
-/*
- * open and close operations
- */
-static int tpci_open(struct inode *ino, struct file *f)
-{
-	return 0;
-}
-
-static int tpci_close(struct inode *ino, struct file *f)
-{
-	return 0;
-}
-
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
-
-	/*
-	 * free inparms and outparms
-	 */
-	if (inparms) {
-		kfree(inparms);
-	}
-	if (outparms) {
-		kfree(outparms);
-	}
-
-	return rc;
-}
-
-/*
- * probe_pci_dev
- * 	find a pci device that can be used for other test
- * 	calls in this kernel module, select first device
- * 	that finds for use, do not need a specific device
- */
-static int probe_pci_dev()
-{
-	unsigned int i, j;
-	struct pci_dev *dev =
-	    (struct pci_dev *)kmalloc(sizeof(struct pci_dev), GFP_KERNEL);
-	struct pci_bus *bus =
-	    (struct pci_bus *)kmalloc(sizeof(struct pci_bus), GFP_KERNEL);
-
-	/* Zero out the ltp_pci */
-	memset(&ltp_pci, 0, sizeof(tpci_user_t));
-
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
-	}
-
-	/* if reaches here did not find a pci device */
-	printk("tpci: failed to find pci device\n");
-	return 1;
-}
-
-/*
- * pci_enable
- * 	enable a pci device so that it may be used in
- * 	later testing in the user test program
- */
-static int pci_enable()
-{
-	int rc = 0;
-
-	struct pci_dev *dev = ltp_pci.dev;
-
-	/* check if can enable the device pointer */
-	if (!dev) {
-		printk("tpci: dev is NULL\n");
-		return 1;
-	}
-
-	if (pci_enable_device(dev)) {
-		printk("tpci: failed to enable pci device\n");
-		rc = 1;
-	} else {
-		printk("tpci: enabled pci device\n");
-		rc = 0;
-	}
-
-	return rc;
-}
-
-/*
- * pci_disable
- *	call to pci_disable_device
- */
-static int pci_disable()
-{
-	int rc = 0;
-
-	struct pci_dev *dev = ltp_pci.dev;
-
-	/* check if device pointer exists */
-	if (!dev) {
-		printk("tpci: dev is NULL\n");
-		return 1;
-	}
-
-	pci_disable_device(dev);
-
-	if (dev->current_state == 4 || dev->current_state == 3) {
-		printk("tpci: disabled pci device\n");
-		rc = 0;
-	} else {
-		printk("tpci: failed to disable pci device\n");
-		rc = 1;
-	}
-
-	return rc;
-}
-
-/*
- * find_bus
- *	call to pci_find_bus, use values from bus
- *	pointer in ltp_pci, make sure that returns
- * 	bus with same values
- */
-static int test_find_bus()
-{
-	int rc;
-	int num = ltp_pci.bus->number;
-	struct pci_bus *temp = NULL;
-
-	temp = pci_find_bus(num);
-
-	if (!temp) {
-		printk("tpci: pci_find_bus failed to return bus pointer\n");
-		rc = 1;
-	} else if (temp->number != num) {
-		printk("tpci: returned bus pointer w/ wrong bus number\n");
-		rc = 1;
-	} else {
-		printk("tpci: success returned bus pointer \n");
-		rc = 0;
-	}
-
-	return rc;
-}
-
-/*
- * find_class
- *	call to pci_find_class, using values from the
- *	pci_dev pointer in ltp_pci structure
- */
-static int test_find_class()
-{
-	int rc;
-	unsigned int num = ltp_pci.dev->class;
-	struct pci_dev *temp = NULL;
-
-	temp = pci_find_class(num, NULL);
-
-	if (!temp) {
-		printk("tpci: failed to find pci device from class number\n");
-		rc = 1;
-	} else {
-		printk("tpci: found pci device from class number\n");
-		rc = 0;
-	}
-
-	return rc;
-}
-
-/*
- * find_device
- * 	call to pci_find_device, using values for
- *	parameters from pci_dev pointer in the
- *	ltp_pci structure
- */
-static int test_find_device()
-{
-	int rc;
-	struct pci_dev *temp = NULL;
-	unsigned short ven = ltp_pci.dev->vendor, dev = ltp_pci.dev->device;
-
-	temp = pci_find_device(ven, dev, NULL);
-
-	if (!temp) {
-		printk("tpci: failed to find pci device from device info\n");
-		rc = 1;
-	} else {
-		printk("tpci: found pci device from device info\n");
-		rc = 0;
-	}
-
-	return rc;
-}
-
-/*
- * find_subsys
- *	call to pci_find_subsys, use valued from
- *	pci_dev pointer in ltp_pci structure to
- *	find pci_dev from subsys info
- */
-static int test_find_subsys()
-{
-	int rc;
-	struct pci_dev *temp = NULL;
-	unsigned short ven = ltp_pci.dev->vendor,
-	    dev = ltp_pci.dev->device,
-	    ss_ven = ltp_pci.dev->subsystem_vendor,
-	    ss_dev = ltp_pci.dev->subsystem_device;
-
-	temp = pci_find_subsys(ven, dev, ss_ven, ss_dev, NULL);
-
-	if (!temp) {
-		printk("tpci: failed to find pci device from subsys info\n");
-		rc = 1;
-	} else {
-		printk("tpci: found pci device from subsys info\n");
-		rc = 0;
-	}
-
-	return rc;
-}
-
-/*
- * test_scan_bus
- *	call to pci_do_scan_bus,  which takes
- *	a struct pci_bus pointer, which will
- * 	return a an integer for how far the
- *	function got in scanning bus
- */
-static int test_scan_bus()
-{
-	int rc, num;
-	struct pci_bus *bus = ltp_pci.bus;
-
-	num = pci_do_scan_bus(bus);
-
-	/*
-	 * check if returned number is greater than
-	 * max number of bus or less than 0
-	 */
-	if (num > MAX_BUS || num < 0) {
-		printk("tpci: Failed scan bus\n");
-		rc = 1;
-	} else {
-		printk("tpci: Success scan bus\n");
-		rc = 0;
-	}
-
-	return rc;
-}
-
-/*
- * test_slot_scan
- *	make call to pci_scan_slot, which will
- *	find the device pointer and setup the
- *	device info
- */
-static int test_slot_scan()
-{
-	int rc, ret;
-	int num = ltp_pci.dev->devfn;
-	struct pci_bus *bus = ltp_pci.bus;
-
-	ret = pci_scan_slot(bus, num);
-
-	if (ret > 0) {
-		printk("tpci: Found device from scan slot\n");
-		rc = 0;
-	} else {
-		printk("tpci: Failed find device from scan slot\n");
-		rc = 1;
-	}
-
-	return rc;
-}
-
-/*
- * test_bus_add_devices
- *	make call to pci_bus_add_devices,
- *	which will check the device pointer
- *	that is passed in for more devices
- *	that it can add
- */
-static int test_bus_add_devices()
-{
-	int rc;
-	struct pci_bus *bus = ltp_pci.bus;
-
-	pci_bus_add_devices(bus);
-
-	if (bus) {
-		printk("tpci: Called bus_add_device\n");
-		rc = 0;
-	} else {
-		printk("tpci: bus_add_device failed\n");
-		rc = 1;
-	}
-
-	return rc;
-}
-
-/*
- * test_enable_bridges
- *	make call to pci_enable_bridges,
- *	use bus pointer from the ltp_pci
- *	structure
- */
-static int test_enable_bridges()
-{
-	int rc;
-	struct pci_bus *bus = ltp_pci.bus;
-
-	pci_enable_bridges(bus);
-
-	if (bus) {
-		printk("tpci: Called enable bridges\n");
-		rc = 0;
-	} else {
-		printk("tpci: enable_bridges failed\n");
-		rc = 1;
-	}
-
-	return rc;
-}
-
-/*
- * test_match_device
- *	make call to pci_match_device, returns a
- *	pci_device_id pointer
- */
-static int test_match_device()
-{
-	int rc;
-	struct pci_dev *dev = ltp_pci.dev;
-	struct pci_driver *drv;
-	const struct pci_device_id *id;
-
-	drv = pci_dev_driver(dev);
-
-	if (!drv) {
-		printk("driver pointer not allocated for pci_dev\n");
-		return 1;
-	}
-
-	id = pci_match_device(drv->id_table, dev);
-
-	if (id) {
-		printk("tpci: Match device success\n");
-		rc = 0;
-	} else {
-		printk("tpci: Failed return pci_device_id \n");
-		rc = 1;
-	}
-
-	return rc;
-}
-
-/*
- * test_reg_driver
- *	make call to pci_register_driver, which will
- *	register the driver for a device with the
- *	system
- */
-static int test_reg_driver()
-{
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
-	}
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
-}
-
-/*
- * test_unreg_driver
- *	make call to pci_unregister_driver, which will
- *	unregister the driver for a device from the system
- */
-static int test_unreg_driver()
-{
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
-}
-
-/*
- * test_assign_resources
- *	make calls to pci_assign_resource, will need
- *	to setup a dev pointer and resource pointer,
- */
-static int test_assign_resources()
-{
-	int rc;
-	struct pci_dev *dev = ltp_pci.dev;
-	int resno;
-
-	for (resno = 0; resno < 7; resno++) {
-		struct resource *r = dev->resource + resno;
-		if (r->flags)
-			pci_assign_resource(dev, resno);
-	}
-
-	/*
-	 * enable device after call to assign resource
-	 * because might error if (!r->start && r->end)
-	 */
-	rc = pci_enable_device(dev);
-
-	return rc;
-}
-
-/*
- * test_save_state
- *	make call to pci_save_state, takes in a u32*
- * 	buffer
- */
-static int test_save_state()
-{
-	int rc;
-	u32 *buffer = ltp_pci.state;
-	struct pci_dev *dev = ltp_pci.dev;
-
-	rc = pci_save_state(dev, buffer);
-	if (rc)
-		printk("tpci: Failed save state\n");
-	else
-		printk("tpci: Saved state of device\n");
-
-	return rc;
-}
-
-/*
- * test_restore_state
- *	make call to pci_restore_state, get the state buffer
- *	should have been previously filled out by save state
- */
-static int test_restore_state()
-{
-	int rc;
-	u32 *buffer = ltp_pci.state;
-	struct pci_dev *dev = ltp_pci.dev;
-
-	rc = pci_restore_state(dev, buffer);
-	if (rc)
-		printk("tpci: Failed restore state\n");
-	else
-		printk("tpci: Restored state of device\n");
-
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
-
-	return rc;
-}
-
-/*
- * test_find_cap
- *	make call to pci_find_capability, which
- *	will determine if a device has a certain
- *	capability, use second parameter to specify
- *	which capability you are looking for
- */
-static int test_find_cap()
-{
-	int rc;
-	struct pci_dev *dev = ltp_pci.dev;
-
-	rc = pci_find_capability(dev, PCI_CAP_ID_PM);
-	if (rc)
-		printk("tpci: Does not have tested capability\n");
-	else
-		printk("tpci: Device has PM capability\n");
-
-	return rc;
-}
-
-/*
- * test_find_pci_exp_cap
- *	make call to pci_find_capability, which will
- *  determine if a device has PCI-EXPRESS capability,
- *  use second parameter to specify which capability
- *  you are looking for
- */
-static int test_find_pci_exp_cap()
-{
-	int rc;
-	struct pci_dev *dev = ltp_pci.dev;
-
-	rc = pci_find_capability(dev, PCI_CAP_ID_EXP);
-	if (rc)
-		printk("tpci: Device has PCI-EXP capability\n");
-	else
-		printk("tpci: Device doesn't have PCI-EXP capability\n");
-	return rc;
-}
-
-/*
- * test_read_pci_exp_config
- *	make call to pci_config_read and determine if
- *  the PCI-Express enhanced config space of this
- *  device can be read successfully.
- */
-static int test_read_pci_exp_config()
-{
-	int rc;
-	int reg = 100, len = 4;	/*PCI-Exp enhanced config register 0x100, 4 implies dword access */
-	struct pci_dev *dev = ltp_pci.dev;
-
-	u32 data, *value;
-
-	printk("tpci: Device(%d) on bus(%d) & slot(%d) \n", dev,
-	       dev->bus->number, dev->devfn);
-	printk("tpci: Reading the PCI Express configuration registers---\n");
-
-	printk
-	    ("tpci: Reading PCI-Express AER CAP-ID REGISTER at Enh-Cfg AddrSpace 0x100\n");
-
-	rc = pci_config_read(0, dev->bus->number, PCI_SLOT(dev->devfn),
-			     PCI_FUNC(dev->devfn), reg, len, &data);
-
-	*value = (u32) data;
-
-	if (*value == AER_CAP_ID_VALUE)	/*comparing the value read with AER_CAP_ID_VALUE macro */
-		printk
-		    ("tpci: \nCorrect value read using PCI-Express driver installed\n\n");
-	else
-		printk
-		    ("tpci: \nIncorrect value read. PCI-Express driver/device not installed\n\n");
-
-	return rc;
-}
-
-/*
- * tpci_init_module
- * 	set the owner of tpci_fops, register the module
- * 	as a char device, and perform any necessary
- * 	initialization for pci devices
- */
-static int tpci_init_module(void)
-{
-	int rc;
-
-	SET_MODULE_OWNER(&tpci_fops);
-
-	rc = register_chrdev(Major, DEVICE_NAME, &tpci_fops);
-	if (rc < 0) {
-		printk("tpci: Failed to register device.\n");
-		return rc;
-	}
-
-	if (Major == 0)
-		Major = rc;
-
-	printk("tpci: Registration success.\n");
-	return 0;
-}
-
-/*
- * tpci_exit_module
- * 	unregister the device and any necessary
- * 	operations to close for pci devices
- */
-static void tpci_exit_module(void)
-{
-	int rc;
-
-	kfree(ltp_pci.dev);
-	kfree(ltp_pci.bus);
-	kfree(ltp_pci.drv);
-
-	rc = unregister_chrdev(Major, DEVICE_NAME);
-	if (rc < 0)
-		printk("tpci: unregister failed\n");
-	else
-		printk("tpci: unregister success\n");
-
-}
-
-module_init(tpci_init_module)
-    module_exit(tpci_exit_module)
diff --git a/testcases/kernel/device-drivers/pci/tpci/tpci.h b/testcases/kernel/device-drivers/pci/tpci/tpci.h
deleted file mode 100644
index bd81369..0000000
--- a/testcases/kernel/device-drivers/pci/tpci/tpci.h
+++ /dev/null
@@ -1,67 +0,0 @@
-/*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-
-#define TPCI_TEST_DRIVER_NAME	"pci/pci-express test module"
-#define TPCI_MAJOR      252
-#define DEVICE_NAME		"/dev/tpci"
-#define MAX_DEVFN		256
-#define MAX_BUS			256
-#define MAG_NUM 		'k'
-#define AER_CAP_ID_VALUE	0x14011
-
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
-};
-typedef struct tpci_interface tpci_interface_t;
-
-
diff --git a/testcases/kernel/device-drivers/pci/tpci/tpci.mod.c b/testcases/kernel/device-drivers/pci/tpci/tpci.mod.c
deleted file mode 100644
index 0301727..0000000
--- a/testcases/kernel/device-drivers/pci/tpci/tpci.mod.c
+++ /dev/null
@@ -1,29 +0,0 @@
-#include <linux/module.h>
-/*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- *
-*/
-#include <linux/module.h>
-#include <linux/vermagic.h>
-#include <linux/compiler.h>
-
-const char vermagic[]
-    __attribute__ ((section("__vermagic"))) = VERMAGIC_STRING;
-
-static const char __module_depends[]
- __attribute_used__ __attribute__ ((section(".modinfo"))) = "depends=";
diff --git a/testcases/kernel/device-drivers/pci/tpci_kernel/Makefile b/testcases/kernel/device-drivers/pci/tpci_kernel/Makefile
new file mode 100644
index 0000000..77c80ec
--- /dev/null
+++ b/testcases/kernel/device-drivers/pci/tpci_kernel/Makefile
@@ -0,0 +1,22 @@
+#
+# Makefile for GCOV profiling kernel module
+#
+
+#KERNELDIR := /usr/src/linux-2.5.64-gcov
+CFLAGS := $(CFLAGS) -Wall
+
+ifneq ($(KERNELRELEASE),)
+
+obj-m	:= tpci.o
+else
+KDIR	:= /lib/modules/$(shell uname -r)/build
+PWD	:= $(shell pwd)
+
+default:
+	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
+#	$(MAKE) -C $(KERNELDIR) SUBDIRS=$(PWD) modules
+endif
+
+clean:
+	rm -f tpci.o 2>/dev/null || true
+
diff --git a/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c b/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
new file mode 100644
index 0000000..c994c55
--- /dev/null
+++ b/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
@@ -0,0 +1,893 @@
+/*
+ *
+ *   Copyright (c) International Business Machines  Corp., 2001
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ *
+
+ * This pci and pci-express testing kernel module will allow test calls
+ * to be driven through various ioctl calls in a
+ * user space program that has attained the appropriate
+ * file descriptor for this device. For the functions of
+ * this module to work correctly there must be a pci / pci-express
+ * device somewhere in the system. The tests do not need
+ * a specific device, and the first pci device available
+ * will be grabbed.
+ *
+ * author: Sean Ruyle (srruyle@us.ibm.com)
+ * date:   5/20/2003
+ * PCI-Express test scripts author: Amit Khanna (amit.khanna@intel.com)
+ * date:   8/20/2004
+ *
+ * file:   tpci.c,
+ * module: tpci
+ */
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/ioctl.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <asm/uaccess.h>
+#include "tpci.h"
+#include "st_tpci.h"
+
+MODULE_AUTHOR
+    ("Sean Ruyle <srruyle@us.ibm.com>, Amit Khanna <amit.khanna@intel.com>");
+MODULE_DESCRIPTION(TPCI_TEST_DRIVER_NAME);
+MODULE_LICENSE("GPL");
+
+static int tpci_ioctl(struct inode *, struct file *, unsigned int,
+		      unsigned long);
+static int tpci_open(struct inode *, struct file *);
+static int tpci_close(struct inode *, struct file *);
+
+static int probe_pci_dev(void);
+static int pci_enable(void);
+static int pci_disable(void);
+static int test_find_bus(void);
+static int test_find_class(void);
+static int test_find_device(void);
+static int test_find_subsys(void);
+static int test_scan_bus(void);
+static int test_slot_scan(void);
+static int test_bus_add_devices(void);
+static int test_enable_bridges(void);
+static int test_match_device(void);
+static int test_reg_driver(void);
+static int test_unreg_driver(void);
+static int test_assign_resources(void);
+static int test_save_state(void);
+static int test_restore_state(void);
+static int test_max_bus(void);
+static int test_find_cap(void);
+static int test_find_pci_exp_cap(void);
+static int test_read_pci_exp_config(void);
+
+static int Major = TPCI_MAJOR;
+static tpci_user_t ltp_pci;
+
+/*
+ * File operations struct, to use operations find the
+ * correct file descriptor
+ */
+static struct file_operations tpci_fops = {
+open:	tpci_open,
+release:tpci_close,
+ioctl:	tpci_ioctl,
+};
+
+/*
+ * open and close operations
+ */
+static int tpci_open(struct inode *ino, struct file *f)
+{
+	return 0;
+}
+
+static int tpci_close(struct inode *ino, struct file *f)
+{
+	return 0;
+}
+
+/*
+ * tpci_ioctl:
+ * 	a user space program can drive the test functions
+ *	through a call to ioctl once the correct file
+ *	descriptor has been attained
+ *
+ * calls functions:
+ *
+ */
+static int tpci_ioctl(struct inode *ino, struct file *f,
+		      unsigned int cmd, unsigned long l)
+{
+	int rc;
+	struct tpci_interface tif;
+	caddr_t *inparms;
+	caddr_t *outparms;
+
+	printk("Enter tpci_ioctl\n");
+
+	inparms = NULL;
+	outparms = NULL;
+	rc = 0;
+
+	if (copy_from_user(&tif, (void *)l, sizeof(tif))) {
+		/* Bad address */
+		return (-EFAULT);
+	}
+
+	/*
+	 * Setup inparms and outparms as needed
+	 */
+	if (tif.in_len > 0) {
+		inparms = (caddr_t *) kmalloc(tif.in_len, GFP_KERNEL);
+		if (!inparms) {
+			return (-ENOMEM);
+		}
+
+		rc = copy_from_user(inparms, tif.in_data, tif.in_len);
+		if (rc) {
+			kfree(inparms);
+			return (-EFAULT);
+		}
+	}
+	if (tif.out_len > 0) {
+		outparms = (caddr_t *) kmalloc(tif.out_len, GFP_KERNEL);
+		if (!outparms) {
+			kfree(inparms);
+			return (-ENOMEM);
+		}
+	}
+
+	/*
+	 * determine which call to make on the cmd value
+	 */
+	switch (cmd) {
+	case PCI_PROBE:
+		rc = probe_pci_dev();
+		break;
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
+	case TEST_MAX_BUS:
+		rc = test_max_bus();
+		break;
+	case FIND_CAP:
+		rc = test_find_cap();
+		break;
+	case FIND_PCI_EXP_CAP:
+		rc = test_find_pci_exp_cap();
+		break;
+	case READ_PCI_EXP_CONFIG:
+		rc = test_read_pci_exp_config();
+		break;
+	default:
+		printk("Mismatching ioctl command\n");
+		break;
+	}
+
+	if (!(ltp_pci.dev))
+		printk("tpci: After ioctl call dev is NULL\n");
+
+	/*
+	 * copy in the return data, and test return code
+	 */
+	tif.out_rc = rc;
+	rc = 0;
+
+	/* if outparms then copy outparms into tif.out_data */
+	if (outparms) {
+		if (copy_to_user(tif.out_data, outparms, tif.out_len)) {
+			printk("tpci: Unsuccessful copy_to_user of outparms\n");
+			rc = -EFAULT;
+		}
+	}
+
+	/* copy tif structure into l so that can be used by user program */
+	if (copy_to_user((void *)l, &tif, sizeof(tif))) {
+		printk("tpci: Unsuccessful copy_to_user of tif\n");
+		rc = -EFAULT;
+	}
+
+	/*
+	 * free inparms and outparms
+	 */
+	if (inparms) {
+		kfree(inparms);
+	}
+	if (outparms) {
+		kfree(outparms);
+	}
+
+	return rc;
+}
+
+/*
+ * probe_pci_dev
+ * 	find a pci device that can be used for other test
+ * 	calls in this kernel module, select first device
+ * 	that finds for use, do not need a specific device
+ */
+static int probe_pci_dev()
+{
+	unsigned int i, j;
+	struct pci_dev *dev =
+	    (struct pci_dev *)kmalloc(sizeof(struct pci_dev), GFP_KERNEL);
+	struct pci_bus *bus =
+	    (struct pci_bus *)kmalloc(sizeof(struct pci_bus), GFP_KERNEL);
+
+	/* Zero out the ltp_pci */
+	memset(&ltp_pci, 0, sizeof(tpci_user_t));
+
+	ltp_pci.dev = dev;
+	ltp_pci.bus = bus;
+
+	/* Probe until find a pci device */
+	for (i = MAX_BUS; i > 0; i--) {
+		for (j = MAX_DEVFN; j > 1; j--) {
+			dev = pci_find_slot(i, j);
+			if (dev && dev->driver) {
+				printk
+				    ("tpci: found pci_dev, bus %d, devfn %d\n",
+				     i, j);
+				printk("Slot number: %d\n", dev->devfn);
+
+				bus = dev->bus;
+				printk("Bus number: %d\n", bus->number);
+
+				/* copy data into ltp_pci struct */
+				memcpy(ltp_pci.dev, dev,
+				       sizeof(struct pci_dev));
+				memcpy(ltp_pci.bus, bus,
+				       sizeof(struct pci_bus));
+
+				return 0;
+			}
+		}
+	}
+
+	/* if reaches here did not find a pci device */
+	printk("tpci: failed to find pci device\n");
+	return 1;
+}
+
+/*
+ * pci_enable
+ * 	enable a pci device so that it may be used in
+ * 	later testing in the user test program
+ */
+static int pci_enable()
+{
+	int rc = 0;
+
+	struct pci_dev *dev = ltp_pci.dev;
+
+	/* check if can enable the device pointer */
+	if (!dev) {
+		printk("tpci: dev is NULL\n");
+		return 1;
+	}
+
+	if (pci_enable_device(dev)) {
+		printk("tpci: failed to enable pci device\n");
+		rc = 1;
+	} else {
+		printk("tpci: enabled pci device\n");
+		rc = 0;
+	}
+
+	return rc;
+}
+
+/*
+ * pci_disable
+ *	call to pci_disable_device
+ */
+static int pci_disable()
+{
+	int rc = 0;
+
+	struct pci_dev *dev = ltp_pci.dev;
+
+	/* check if device pointer exists */
+	if (!dev) {
+		printk("tpci: dev is NULL\n");
+		return 1;
+	}
+
+	pci_disable_device(dev);
+
+	if (dev->current_state == 4 || dev->current_state == 3) {
+		printk("tpci: disabled pci device\n");
+		rc = 0;
+	} else {
+		printk("tpci: failed to disable pci device\n");
+		rc = 1;
+	}
+
+	return rc;
+}
+
+/*
+ * find_bus
+ *	call to pci_find_bus, use values from bus
+ *	pointer in ltp_pci, make sure that returns
+ * 	bus with same values
+ */
+static int test_find_bus()
+{
+	int rc;
+	int num = ltp_pci.bus->number;
+	struct pci_bus *temp = NULL;
+
+	temp = pci_find_bus(num);
+
+	if (!temp) {
+		printk("tpci: pci_find_bus failed to return bus pointer\n");
+		rc = 1;
+	} else if (temp->number != num) {
+		printk("tpci: returned bus pointer w/ wrong bus number\n");
+		rc = 1;
+	} else {
+		printk("tpci: success returned bus pointer \n");
+		rc = 0;
+	}
+
+	return rc;
+}
+
+/*
+ * find_class
+ *	call to pci_find_class, using values from the
+ *	pci_dev pointer in ltp_pci structure
+ */
+static int test_find_class()
+{
+	int rc;
+	unsigned int num = ltp_pci.dev->class;
+	struct pci_dev *temp = NULL;
+
+	temp = pci_find_class(num, NULL);
+
+	if (!temp) {
+		printk("tpci: failed to find pci device from class number\n");
+		rc = 1;
+	} else {
+		printk("tpci: found pci device from class number\n");
+		rc = 0;
+	}
+
+	return rc;
+}
+
+/*
+ * find_device
+ * 	call to pci_find_device, using values for
+ *	parameters from pci_dev pointer in the
+ *	ltp_pci structure
+ */
+static int test_find_device()
+{
+	int rc;
+	struct pci_dev *temp = NULL;
+	unsigned short ven = ltp_pci.dev->vendor, dev = ltp_pci.dev->device;
+
+	temp = pci_find_device(ven, dev, NULL);
+
+	if (!temp) {
+		printk("tpci: failed to find pci device from device info\n");
+		rc = 1;
+	} else {
+		printk("tpci: found pci device from device info\n");
+		rc = 0;
+	}
+
+	return rc;
+}
+
+/*
+ * find_subsys
+ *	call to pci_find_subsys, use valued from
+ *	pci_dev pointer in ltp_pci structure to
+ *	find pci_dev from subsys info
+ */
+static int test_find_subsys()
+{
+	int rc;
+	struct pci_dev *temp = NULL;
+	unsigned short ven = ltp_pci.dev->vendor,
+	    dev = ltp_pci.dev->device,
+	    ss_ven = ltp_pci.dev->subsystem_vendor,
+	    ss_dev = ltp_pci.dev->subsystem_device;
+
+	temp = pci_find_subsys(ven, dev, ss_ven, ss_dev, NULL);
+
+	if (!temp) {
+		printk("tpci: failed to find pci device from subsys info\n");
+		rc = 1;
+	} else {
+		printk("tpci: found pci device from subsys info\n");
+		rc = 0;
+	}
+
+	return rc;
+}
+
+/*
+ * test_scan_bus
+ *	call to pci_do_scan_bus,  which takes
+ *	a struct pci_bus pointer, which will
+ * 	return a an integer for how far the
+ *	function got in scanning bus
+ */
+static int test_scan_bus()
+{
+	int rc, num;
+	struct pci_bus *bus = ltp_pci.bus;
+
+	num = pci_do_scan_bus(bus);
+
+	/*
+	 * check if returned number is greater than
+	 * max number of bus or less than 0
+	 */
+	if (num > MAX_BUS || num < 0) {
+		printk("tpci: Failed scan bus\n");
+		rc = 1;
+	} else {
+		printk("tpci: Success scan bus\n");
+		rc = 0;
+	}
+
+	return rc;
+}
+
+/*
+ * test_slot_scan
+ *	make call to pci_scan_slot, which will
+ *	find the device pointer and setup the
+ *	device info
+ */
+static int test_slot_scan()
+{
+	int rc, ret;
+	int num = ltp_pci.dev->devfn;
+	struct pci_bus *bus = ltp_pci.bus;
+
+	ret = pci_scan_slot(bus, num);
+
+	if (ret > 0) {
+		printk("tpci: Found device from scan slot\n");
+		rc = 0;
+	} else {
+		printk("tpci: Failed find device from scan slot\n");
+		rc = 1;
+	}
+
+	return rc;
+}
+
+/*
+ * test_bus_add_devices
+ *	make call to pci_bus_add_devices,
+ *	which will check the device pointer
+ *	that is passed in for more devices
+ *	that it can add
+ */
+static int test_bus_add_devices()
+{
+	int rc;
+	struct pci_bus *bus = ltp_pci.bus;
+
+	pci_bus_add_devices(bus);
+
+	if (bus) {
+		printk("tpci: Called bus_add_device\n");
+		rc = 0;
+	} else {
+		printk("tpci: bus_add_device failed\n");
+		rc = 1;
+	}
+
+	return rc;
+}
+
+/*
+ * test_enable_bridges
+ *	make call to pci_enable_bridges,
+ *	use bus pointer from the ltp_pci
+ *	structure
+ */
+static int test_enable_bridges()
+{
+	int rc;
+	struct pci_bus *bus = ltp_pci.bus;
+
+	pci_enable_bridges(bus);
+
+	if (bus) {
+		printk("tpci: Called enable bridges\n");
+		rc = 0;
+	} else {
+		printk("tpci: enable_bridges failed\n");
+		rc = 1;
+	}
+
+	return rc;
+}
+
+/*
+ * test_match_device
+ *	make call to pci_match_device, returns a
+ *	pci_device_id pointer
+ */
+static int test_match_device()
+{
+	int rc;
+	struct pci_dev *dev = ltp_pci.dev;
+	struct pci_driver *drv;
+	const struct pci_device_id *id;
+
+	drv = pci_dev_driver(dev);
+
+	if (!drv) {
+		printk("driver pointer not allocated for pci_dev\n");
+		return 1;
+	}
+
+	id = pci_match_device(drv->id_table, dev);
+
+	if (id) {
+		printk("tpci: Match device success\n");
+		rc = 0;
+	} else {
+		printk("tpci: Failed return pci_device_id \n");
+		rc = 1;
+	}
+
+	return rc;
+}
+
+/*
+ * test_reg_driver
+ *	make call to pci_register_driver, which will
+ *	register the driver for a device with the
+ *	system
+ */
+static int test_reg_driver()
+{
+	int rc, ret;
+	struct pci_driver *drv =
+	    (struct pci_driver *)kmalloc(sizeof(struct pci_driver), GFP_KERNEL);
+	struct pci_driver *tmp = ltp_pci.dev->driver;
+
+	/* zero out drv structure */
+	memset(drv, 0, sizeof(struct pci_driver));
+
+	/* copy in structure of tmp, reset some fields */
+	drv->name = "Tmod_driver";
+	drv->driver = tmp->driver;
+
+	/* copy structure into ltp_pci.drv */
+	ltp_pci.drv = drv;
+	memcpy(ltp_pci.drv, drv, sizeof(struct pci_driver));
+
+	if (!drv) {
+		printk("tpci: Device does not have a driver pointer\n");
+		return 1;
+	}
+
+	ret = pci_register_driver(drv);
+
+	if (ret) {
+		printk("tpci: Success driver register\n");
+		rc = 0;
+	} else {
+		rc = 1;
+		printk("tpci: unsuccessful registering pci driver\n");
+	}
+
+	return rc;
+}
+
+/*
+ * test_unreg_driver
+ *	make call to pci_unregister_driver, which will
+ *	unregister the driver for a device from the system
+ */
+static int test_unreg_driver()
+{
+	int rc;
+	struct pci_driver *drv = ltp_pci.drv;
+
+	if (!drv) {
+		printk("tpci: Device does not have a driver pointer\n");
+		return 1;
+	}
+
+	pci_unregister_driver(drv);
+	if (!drv) {
+		printk("tpci: Unsuccesful driver unregister\n");
+		rc = 1;
+	} else {
+		printk("tpci: unregistering pci driver\n");
+		rc = 0;
+	}
+
+	return rc;
+}
+
+/*
+ * test_assign_resources
+ *	make calls to pci_assign_resource, will need
+ *	to setup a dev pointer and resource pointer,
+ */
+static int test_assign_resources()
+{
+	int rc;
+	struct pci_dev *dev = ltp_pci.dev;
+	int resno;
+
+	for (resno = 0; resno < 7; resno++) {
+		struct resource *r = dev->resource + resno;
+		if (r->flags)
+			pci_assign_resource(dev, resno);
+	}
+
+	/*
+	 * enable device after call to assign resource
+	 * because might error if (!r->start && r->end)
+	 */
+	rc = pci_enable_device(dev);
+
+	return rc;
+}
+
+/*
+ * test_save_state
+ *	make call to pci_save_state, takes in a u32*
+ * 	buffer
+ */
+static int test_save_state()
+{
+	int rc;
+	u32 *buffer = ltp_pci.state;
+	struct pci_dev *dev = ltp_pci.dev;
+
+	rc = pci_save_state(dev, buffer);
+	if (rc)
+		printk("tpci: Failed save state\n");
+	else
+		printk("tpci: Saved state of device\n");
+
+	return rc;
+}
+
+/*
+ * test_restore_state
+ *	make call to pci_restore_state, get the state buffer
+ *	should have been previously filled out by save state
+ */
+static int test_restore_state()
+{
+	int rc;
+	u32 *buffer = ltp_pci.state;
+	struct pci_dev *dev = ltp_pci.dev;
+
+	rc = pci_restore_state(dev, buffer);
+	if (rc)
+		printk("tpci: Failed restore state\n");
+	else
+		printk("tpci: Restored state of device\n");
+
+	return rc;
+}
+
+/*
+ * test_max_bus
+ *	make call to pci_max_busnr, which will determine
+ *	the max number of bus on the system
+ */
+static int test_max_bus()
+{
+	int rc, ret;
+
+	ret = pci_max_busnr();
+	if (ret) {
+		printk("Found max busnr\n");
+		rc = 0;
+	} else {
+		printk("Did not return max busnr\n");
+		rc = 1;
+	}
+
+	return rc;
+}
+
+/*
+ * test_find_cap
+ *	make call to pci_find_capability, which
+ *	will determine if a device has a certain
+ *	capability, use second parameter to specify
+ *	which capability you are looking for
+ */
+static int test_find_cap()
+{
+	int rc;
+	struct pci_dev *dev = ltp_pci.dev;
+
+	rc = pci_find_capability(dev, PCI_CAP_ID_PM);
+	if (rc)
+		printk("tpci: Does not have tested capability\n");
+	else
+		printk("tpci: Device has PM capability\n");
+
+	return rc;
+}
+
+/*
+ * test_find_pci_exp_cap
+ *	make call to pci_find_capability, which will
+ *  determine if a device has PCI-EXPRESS capability,
+ *  use second parameter to specify which capability
+ *  you are looking for
+ */
+static int test_find_pci_exp_cap()
+{
+	int rc;
+	struct pci_dev *dev = ltp_pci.dev;
+
+	rc = pci_find_capability(dev, PCI_CAP_ID_EXP);
+	if (rc)
+		printk("tpci: Device has PCI-EXP capability\n");
+	else
+		printk("tpci: Device doesn't have PCI-EXP capability\n");
+	return rc;
+}
+
+/*
+ * test_read_pci_exp_config
+ *	make call to pci_config_read and determine if
+ *  the PCI-Express enhanced config space of this
+ *  device can be read successfully.
+ */
+static int test_read_pci_exp_config()
+{
+	int rc;
+	int reg = 100, len = 4;	/*PCI-Exp enhanced config register 0x100, 4 implies dword access */
+	struct pci_dev *dev = ltp_pci.dev;
+
+	u32 data, *value;
+
+	printk("tpci: Device(%d) on bus(%d) & slot(%d) \n", dev,
+	       dev->bus->number, dev->devfn);
+	printk("tpci: Reading the PCI Express configuration registers---\n");
+
+	printk
+	    ("tpci: Reading PCI-Express AER CAP-ID REGISTER at Enh-Cfg AddrSpace 0x100\n");
+
+	rc = pci_config_read(0, dev->bus->number, PCI_SLOT(dev->devfn),
+			     PCI_FUNC(dev->devfn), reg, len, &data);
+
+	*value = (u32) data;
+
+	if (*value == AER_CAP_ID_VALUE)	/*comparing the value read with AER_CAP_ID_VALUE macro */
+		printk
+		    ("tpci: \nCorrect value read using PCI-Express driver installed\n\n");
+	else
+		printk
+		    ("tpci: \nIncorrect value read. PCI-Express driver/device not installed\n\n");
+
+	return rc;
+}
+
+/*
+ * tpci_init_module
+ * 	set the owner of tpci_fops, register the module
+ * 	as a char device, and perform any necessary
+ * 	initialization for pci devices
+ */
+static int tpci_init_module(void)
+{
+	int rc;
+
+	SET_MODULE_OWNER(&tpci_fops);
+
+	rc = register_chrdev(Major, DEVICE_NAME, &tpci_fops);
+	if (rc < 0) {
+		printk("tpci: Failed to register device.\n");
+		return rc;
+	}
+
+	if (Major == 0)
+		Major = rc;
+
+	printk("tpci: Registration success.\n");
+	return 0;
+}
+
+/*
+ * tpci_exit_module
+ * 	unregister the device and any necessary
+ * 	operations to close for pci devices
+ */
+static void tpci_exit_module(void)
+{
+	int rc;
+
+	kfree(ltp_pci.dev);
+	kfree(ltp_pci.bus);
+	kfree(ltp_pci.drv);
+
+	rc = unregister_chrdev(Major, DEVICE_NAME);
+	if (rc < 0)
+		printk("tpci: unregister failed\n");
+	else
+		printk("tpci: unregister success\n");
+
+}
+
+module_init(tpci_init_module)
+    module_exit(tpci_exit_module)
diff --git a/testcases/kernel/device-drivers/pci/tpci_kernel/pci-exp-tests-HOWTO b/testcases/kernel/device-drivers/pci/tpci_kernel/pci-exp-tests-HOWTO
new file mode 100644
index 0000000..fb84dfc
--- /dev/null
+++ b/testcases/kernel/device-drivers/pci/tpci_kernel/pci-exp-tests-HOWTO
@@ -0,0 +1,58 @@
+HOWTO -->	PCI-Express test scripts for LTP
+	Amit Khanna amit.khanna@intel.com
+			08/20/2004
+
+1. About this HOWTO
+
+This document describes the addition of PCI-Express test cases to the existing LTP project.
+These test cases/scripts will enhance the LTP's capability to test PCI-Express devices/drivers.
+
+2. Copyright (c) Intel Corporation, 2004
+
+3. What is this patch doing?
+
+a. A function "test_find_pci_exp_cap" has been added to the tpci.c file of LTP project.
+	(\ltp\testcases\kernel\device-drivers\pci\tpci\tpci.c)
+	 This function makes a call to pci_find_capability, which will determine if a device
+	 has PCI-Express capability. A PCI Express device function indicates PCI-Express support
+	 by implementing the PCI-Express capability structure in its capability list.
+
+b. A function "test_read_pci_exp_config" has been added to the tpci.c file of LTP project.
+ 	This function calls "pci_config_read" and determines if the PCI-Express enhanced config
+ 	space of the device can be read successfully or not.
+
+	"pci_config_read" function here reads the Advanced Error Reporting CAP-ID register located
+	 at the PCI-Express enhanced config space address 0x100. The value of this register is a READ-ONLY
+	 value which is constant on all the PCI-Express devices. If the value read from this register matches with the
+	 defined macro AER_CAP_ID_VALUE(in tpci.h) that means that PCI-Express driver is accessing
+	 the enhanced config space SUCCESSFULLY.
+
+c. A user space function 'ki_generic()" is already available in user_tpci.c file of LTP project,
+   (\ltp\testcases\kernel\device-drivers\pci\user_tpci\user_tpci.c) which will drive the kernel
+   module tpci to test various pci and pci-express functions (defined & prototyped in tpci.c).
+
+
+4. Including PCI-Express support into the kernel
+
+By default, the kernel may not enable PCI-Express feature. A kernel
+configuration option must be selected to enable PCI-Express support.
+
+To include PCI-Express support into the kernel requires users to enable PCI-Access mode with
+"Any" or "MMCFG" in the "General Setup" menu in the kernel configuration menu.
+
+5. FAQ
+
+Q1. Are there any limitations on using this patch?
+
+A1. If the device supports PCI-Express feature and the PCI-Express feature is enabled in the kernel,
+then only a user will be able to access the PCI-Express space.
+Even if the device doesn't support PCI-Express feature, the traditional PCI-space would still be accessible.
+
+Q2. What is this AER_CAP_ID_VALUE macro defined in tpci.h?
+
+A2. AER_CAP_ID_VALUE represents the value of Advanced Error Reporting Capability ID in the PCI Express config space.
+The default value of this is always same for all PCI-Express devices. i.e. 0x14011.
+In the function "test_read_pci_exp_config" in tpci.c file, it is compared with the value retrieved from a PCI-Express
+capable device. If both the values match that means that the PCI-Express driver is accessing the PCI-Express config space
+SUCCESSFULLY.
+***FINISH***
diff --git a/testcases/kernel/device-drivers/pci/tpci_kernel/tpci.h b/testcases/kernel/device-drivers/pci/tpci_kernel/tpci.h
new file mode 100644
index 0000000..bd81369
--- /dev/null
+++ b/testcases/kernel/device-drivers/pci/tpci_kernel/tpci.h
@@ -0,0 +1,67 @@
+/*
+ *
+ *   Copyright (c) International Business Machines  Corp., 2001
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+
+#define TPCI_TEST_DRIVER_NAME	"pci/pci-express test module"
+#define TPCI_MAJOR      252
+#define DEVICE_NAME		"/dev/tpci"
+#define MAX_DEVFN		256
+#define MAX_BUS			256
+#define MAG_NUM 		'k'
+#define AER_CAP_ID_VALUE	0x14011
+
+#define PCI_PROBE		_IO(MAG_NUM, 1)
+#define PCI_ENABLE		_IO(MAG_NUM, 2)
+#define PCI_DISABLE		_IO(MAG_NUM, 3)
+#define FIND_BUS	        _IO(MAG_NUM, 4)
+#define FIND_DEVICE             _IO(MAG_NUM, 5)
+#define FIND_CLASS              _IO(MAG_NUM, 6)
+#define FIND_SUBSYS             _IO(MAG_NUM, 7)
+#define BUS_SCAN		_IO(MAG_NUM, 8)
+#define	SLOT_SCAN		_IO(MAG_NUM, 9)
+#define ENABLE_BRIDGES		_IO(MAG_NUM, 10)
+#define BUS_ADD_DEVICES		_IO(MAG_NUM, 11)
+#define MATCH_DEVICE		_IO(MAG_NUM, 12)
+#define REG_DRIVER		_IO(MAG_NUM, 13)
+#define UNREG_DRIVER		_IO(MAG_NUM, 14)
+#define BUS_RESOURCES		_IO(MAG_NUM, 15)
+#define PCI_RESOURCES		_IO(MAG_NUM, 16)
+#define SAVE_STATE		_IO(MAG_NUM, 19)
+#define RESTORE_STATE		_IO(MAG_NUM, 20)
+#define TEST_MAX_BUS		_IO(MAG_NUM, 21)
+#define FIND_CAP		_IO(MAG_NUM, 22)
+#define FIND_PCI_EXP_CAP	_IO(MAG_NUM, 23)
+#define READ_PCI_EXP_CONFIG	_IO(MAG_NUM, 24)
+#ifndef SET_MODULE_OWNER
+#define SET_MODULE_OWNER(dev) ((dev)->owner = THIS_MODULE)
+#endif
+
+/*
+ * structures for PCI test driver
+ */
+struct tpci_interface {
+	int 	in_len;		// input data length
+	caddr_t	in_data;	// input data
+	int 	out_rc;		// return code from the test
+	int 	out_len;	// output data length
+	caddr_t	out_data;	// output data
+};
+typedef struct tpci_interface tpci_interface_t;
+
+
diff --git a/testcases/kernel/device-drivers/pci/tpci_user/Makefile b/testcases/kernel/device-drivers/pci/tpci_user/Makefile
new file mode 100644
index 0000000..38ed3eb
--- /dev/null
+++ b/testcases/kernel/device-drivers/pci/tpci_user/Makefile
@@ -0,0 +1,9 @@
+
+CFLAGS += -Wall
+OBJS = tpci_ki.o user_tpci.o
+
+test_pci: $(OBJS)
+	$(CC) $(CFLAGS) $(LDFLAGS) $^ -o $@
+
+clean:
+	rm -f $(OBJS) test_pci
diff --git a/testcases/kernel/device-drivers/pci/tpci_user/tpci.c b/testcases/kernel/device-drivers/pci/tpci_user/tpci.c
new file mode 100644
index 0000000..3d4cc45
--- /dev/null
+++ b/testcases/kernel/device-drivers/pci/tpci_user/tpci.c
@@ -0,0 +1,258 @@
+#include <stdio.h>
+/*
+ *
+ *   Copyright (c) International Business Machines  Corp., 2001
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/stat.h>
+#include <sys/ioctl.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include "user_tpci.h"
+#include "../tpci/tpci.h"
+
+static int tpci_fd = -1;	/* file descriptor */
+
+int tpciopen()
+{
+
+	dev_t devt;
+	struct stat st;
+	int rc = 0;
+
+	devt = makedev(TPCI_MAJOR, 0);
+
+	if (rc) {
+		if (errno == ENOENT) {
+			/* dev node does not exist. */
+			rc = mkdir(DEVICE_NAME, (S_IFDIR | S_IRWXU |
+						 S_IRGRP | S_IXGRP |
+						 S_IROTH | S_IXOTH));
+		} else {
+			printf
+			    ("ERROR: Problem with Base dev directory.  Error code from stat() is %d\n\n",
+			     errno);
+		}
+
+	} else {
+		if (!(st.st_mode & S_IFDIR)) {
+			rc = unlink(DEVICE_NAME);
+			if (!rc) {
+				rc = mkdir(DEVICE_NAME, (S_IFDIR | S_IRWXU |
+							 S_IRGRP | S_IXGRP |
+							 S_IROTH | S_IXOTH));
+			}
+		}
+	}
+
+	/*
+	 * Check for the /dev/tbase node, and create if it does not
+	 * exist.
+	 */
+	rc = stat(DEVICE_NAME, &st);
+	if (rc) {
+		if (errno == ENOENT) {
+			/* dev node does not exist */
+			rc = mknod(DEVICE_NAME,
+				   (S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP |
+				    S_IWGRP), devt);
+		} else {
+			printf
+			    ("ERROR:Problem with tbase device node directory.  Error code form stat() is %d\n\n",
+			     errno);
+		}
+
+	} else {
+		/*
+		 * /dev/tbase CHR device exists.  Check to make sure it is for a
+		 * block device and that it has the right major and minor.
+		 */
+		if ((!(st.st_mode & S_IFCHR)) || (st.st_rdev != devt)) {
+
+			/* Recreate the dev node. */
+			rc = unlink(DEVICE_NAME);
+			if (!rc) {
+				rc = mknod(DEVICE_NAME,
+					   (S_IFCHR | S_IRUSR | S_IWUSR |
+					    S_IRGRP | S_IWGRP), devt);
+			}
+		}
+	}
+
+	tpci_fd = open(DEVICE_NAME, O_RDWR);
+
+	if (tpci_fd < 0) {
+		printf("ERROR: Open of device %s failed %d errno = %d\n",
+		       DEVICE_NAME, tpci_fd, errno);
+		return errno;
+	} else {
+		printf("Device opened successfully \n");
+		return 0;
+	}
+
+}
+
+int tpciclose()
+{
+
+	if (tpci_fd != -1) {
+		close(tpci_fd);
+		tpci_fd = -1;
+	}
+
+	return 0;
+}
+
+int main()
+{
+	int rc;
+
+	rc = tpciopen();
+	if (rc) {
+		printf("Test PCI Driver may not be loaded\n");
+		exit(1);
+	}
+
+	/* test find pci */
+	if (ki_generic(tpci_fd, PCI_PROBE)) {
+		printf("Failed to find a pci device\n");
+		exit(1);
+	} else
+		printf("Success probing for pci device\n");
+
+	/* test disable device */
+	if (ki_generic(tpci_fd, PCI_DISABLE))
+		printf
+		    ("Failed to disable device \nMay still be in use by system\n");
+	else
+		printf("Disabled device\n");
+
+	/* test enable device */
+	if (ki_generic(tpci_fd, PCI_ENABLE))
+		printf("Failed to enable device\n");
+	else
+		printf("Enabled device\n");
+
+	/* test find from bus */
+	if (ki_generic(tpci_fd, FIND_BUS))
+		printf("Failed to find from bus pointer\n");
+	else
+		printf("Found device from bus pointer\n");
+
+	/* test find from device */
+	if (ki_generic(tpci_fd, FIND_DEVICE))
+		printf("Failed to find device from device info\n");
+	else
+		printf("Found device from device info\n");
+
+	/* test find from class */
+	if (ki_generic(tpci_fd, FIND_CLASS))
+		printf("Failed to find device from class\n");
+	else
+		printf("Found device from class \n");
+
+	/* test find subsys */
+	if (ki_generic(tpci_fd, FIND_SUBSYS))
+		printf("Failed to find device from subsys info\n");
+	else
+		printf("Found device from subsys info\n");
+
+	/* test scan bus */
+	if (ki_generic(tpci_fd, BUS_SCAN))
+		printf("Failed on bus scan call\n");
+	else
+		printf("Success scanning bus\n");
+
+	/* test scan slot */
+	if (ki_generic(tpci_fd, SLOT_SCAN))
+		printf("Failed on scan slot \n");
+	else
+		printf("Success scan slot\n");
+
+	/* test enable bridges */
+	if (ki_generic(tpci_fd, ENABLE_BRIDGES))
+		printf("Failed to enable bridges\n");
+	else
+		printf("Enabled bridges\n");
+
+	/* test bus add devices */
+	if (ki_generic(tpci_fd, BUS_ADD_DEVICES))
+		printf("Failed on bus add devices call\n");
+	else
+		printf("Success bus add devices\n");
+
+	/* test match device */
+	if (ki_generic(tpci_fd, MATCH_DEVICE))
+		printf("Failed on match device call\n");
+	else
+		printf("Success match device\n");
+
+#if 0
+	/* test unregister driver */
+	if (ki_generic(tpci_fd, UNREG_DRIVER))
+		printf("Failed to unregister driver\n");
+	else
+		printf("Unregistered driver\n");
+#endif
+
+	/* test register driver */
+	if (ki_generic(tpci_fd, REG_DRIVER))
+		printf("Failed to register driver\n");
+	else
+		printf("Registerd driver\n");
+
+	/* test pci resources */
+	if (ki_generic(tpci_fd, PCI_RESOURCES))
+		printf("Failed on pci_resources call\n");
+	else
+		printf("Success pci resources\n");
+
+	/* test save state */
+	if (ki_generic(tpci_fd, SAVE_STATE))
+		printf("Failed to save state of device\n");
+	else
+		printf("Saved state of device\n");
+
+	/* test restore state */
+	if (ki_generic(tpci_fd, RESTORE_STATE))
+		printf("Failed to restore state\n");
+	else
+		printf("Restored state\n");
+
+	/* test max bus */
+	if (ki_generic(tpci_fd, TEST_MAX_BUS))
+		printf("Failed on max bus call\n");
+	else
+		printf("Success max bus \n");
+
+	if (ki_generic(tpci_fd, FIND_CAP))
+		printf("Does not have tested capability\n");
+	else
+		printf("Device has tested capability\n");
+
+	rc = tpciclose();
+	if (rc) {
+		printf("Test PCI Driver may not be closed\n");
+		exit(1);
+	}
+
+	return 0;
+}
diff --git a/testcases/kernel/device-drivers/pci/user_tpci/Makefile b/testcases/kernel/device-drivers/pci/user_tpci/Makefile
deleted file mode 100644
index 38ed3eb..0000000
--- a/testcases/kernel/device-drivers/pci/user_tpci/Makefile
+++ /dev/null
@@ -1,9 +0,0 @@
-
-CFLAGS += -Wall
-OBJS = tpci_ki.o user_tpci.o
-
-test_pci: $(OBJS)
-	$(CC) $(CFLAGS) $(LDFLAGS) $^ -o $@
-
-clean:
-	rm -f $(OBJS) test_pci
diff --git a/testcases/kernel/device-drivers/pci/user_tpci/tpci_ki.c b/testcases/kernel/device-drivers/pci/user_tpci/tpci_ki.c
deleted file mode 100644
index 91e1471..0000000
--- a/testcases/kernel/device-drivers/pci/user_tpci/tpci_ki.c
+++ /dev/null
@@ -1,198 +0,0 @@
-/*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- *
-
- * This file will include user space functions that will drive
- * the kernel module tpci to test various pci functions
- * and kernel calls. Each function will need to setup the tif
- * structure so that the in parameters and out parameters
- * are correctly initialized
- *
- * use tif structure for passing params between user
- * space and kernel space, in some tests it is really
- * not needed but makes easy to maintain all tests if
- * have the same process to read in params in the
- * kernel module no matter what the test is
- *
- * author: Sean Ruyle (srruyle@us.ibm.com)
- * date:   5/21/2003
- *
- * tpci_ki.c
- */
-
-#include <stdlib.h>
-#include <stdio.h>
-#include <sys/ioctl.h>
-#include "../tpci/tpci.h"
-
-int ki_generic(int fd, int flag)
-{
-	int rc;
-	tpci_interface_t tif;
-
-	/*
-	 * build interface structure
-	 */
-	tif.in_len = 0;
-	tif.in_data = 0;
-	tif.out_len = 0;
-	tif.out_data = 0;
-	tif.out_rc = 0;
-
-	/*
-	 * ioctl call for flag
-	 */
-	rc = ioctl(fd, flag, &tif);
-	if (rc) {
-		printf("Ioctl error\n");
-		return rc;
-	}
-	if (tif.out_rc) {
-		printf("Specific errorr: ");
-		return tif.out_rc;
-	}
-
-	return rc;
-}
-
-#if 0
-int ki_probe_pci_dev(int fd)
-{
-
-	int rc;
-	tpci_interface_t tif;
-
-	/*
-	 * build interface structure
-	 */
-	tif.in_len = 0;
-	tif.in_data = 0;
-	tif.out_len = 0;
-	tif.out_data = 0;
-	tif.out_rc = 0;
-
-	/*
-	 * ioctl call for PCI_PROBE
-	 */
-	rc = ioctl(fd, PCI_PROBE, &tif);
-	if (rc) {
-		printf("Ioctl error\n");
-		return rc;
-	}
-	if (tif.out_rc) {
-		printf("Specific error in ioctl call\n");
-		return tif.out_rc;
-	}
-
-	return rc;
-}
-
-int ki_enable_pci(int fd)
-{
-
-	int rc;
-	tpci_interface_t tif;
-
-	/*
-	 * build interface structure
-	 */
-	tif.in_len = 0;
-	tif.in_data = 0;
-	tif.out_len = 0;
-	tif.out_data = 0;
-	tif.out_rc = 0;
-
-	/*
-	 * ioctl call for PCI_ENABLE
-	 */
-	rc = ioctl(fd, PCI_ENABLE, &tif);
-	if (rc) {
-		printf("Ioctl error\n");
-		return rc;
-	}
-	if (tif.out_rc) {
-		printf("Specific error in ioctl call\n");
-		return tif.out_rc;
-	}
-
-	return rc;
-}
-
-int ki_disable_pci(int fd)
-{
-
-	int rc;
-	tpci_interface_t tif;
-
-	/*
-	 * build interface structure
-	 */
-	tif.in_len = 0;
-	tif.in_data = 0;
-	tif.out_len = 0;
-	tif.out_data = 0;
-	tif.out_rc = 0;
-
-	/*
-	 * ioctl call for PCI_DISABLE
-	 */
-	rc = ioctl(fd, PCI_DISABLE, &tif);
-	if (rc) {
-		printf("Ioctl error\n");
-		return rc;
-	}
-	if (tif.out_rc) {
-		printf("Specific error in ioctl call\n");
-		return tif.out_rc;
-	}
-
-	return rc;
-}
-
-int ki_find_bus(int fd)
-{
-
-	int rc;
-	tpci_interface_t tif;
-
-	/*
-	 * build interface structure
-	 */
-	tif.in_len = 0;
-	tif.in_data = 0;
-	tif.out_len = 0;
-	tif.out_data = 0;
-	tif.out_rc = 0;
-
-	/*
-	 * ioctl call for PCI_DISABLE
-	 */
-	rc = ioctl(fd, FIND_BUS, &tif);
-	if (rc) {
-		printf("Ioctl error\n");
-		return rc;
-	}
-	if (tif.out_rc) {
-		printf("Specific error in ioctl call\n");
-		return tif.out_rc;
-	}
-
-	return rc;
-}
-
-#endif
diff --git a/testcases/kernel/device-drivers/pci/user_tpci/user_tpci.c b/testcases/kernel/device-drivers/pci/user_tpci/user_tpci.c
deleted file mode 100644
index 3d4cc45..0000000
--- a/testcases/kernel/device-drivers/pci/user_tpci/user_tpci.c
+++ /dev/null
@@ -1,258 +0,0 @@
-#include <stdio.h>
-/*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <sys/stat.h>
-#include <sys/ioctl.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include "user_tpci.h"
-#include "../tpci/tpci.h"
-
-static int tpci_fd = -1;	/* file descriptor */
-
-int tpciopen()
-{
-
-	dev_t devt;
-	struct stat st;
-	int rc = 0;
-
-	devt = makedev(TPCI_MAJOR, 0);
-
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
-
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
-
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
-
-}
-
-int tpciclose()
-{
-
-	if (tpci_fd != -1) {
-		close(tpci_fd);
-		tpci_fd = -1;
-	}
-
-	return 0;
-}
-
-int main()
-{
-	int rc;
-
-	rc = tpciopen();
-	if (rc) {
-		printf("Test PCI Driver may not be loaded\n");
-		exit(1);
-	}
-
-	/* test find pci */
-	if (ki_generic(tpci_fd, PCI_PROBE)) {
-		printf("Failed to find a pci device\n");
-		exit(1);
-	} else
-		printf("Success probing for pci device\n");
-
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
-
-	/* test pci resources */
-	if (ki_generic(tpci_fd, PCI_RESOURCES))
-		printf("Failed on pci_resources call\n");
-	else
-		printf("Success pci resources\n");
-
-	/* test save state */
-	if (ki_generic(tpci_fd, SAVE_STATE))
-		printf("Failed to save state of device\n");
-	else
-		printf("Saved state of device\n");
-
-	/* test restore state */
-	if (ki_generic(tpci_fd, RESTORE_STATE))
-		printf("Failed to restore state\n");
-	else
-		printf("Restored state\n");
-
-	/* test max bus */
-	if (ki_generic(tpci_fd, TEST_MAX_BUS))
-		printf("Failed on max bus call\n");
-	else
-		printf("Success max bus \n");
-
-	if (ki_generic(tpci_fd, FIND_CAP))
-		printf("Does not have tested capability\n");
-	else
-		printf("Device has tested capability\n");
-
-	rc = tpciclose();
-	if (rc) {
-		printf("Test PCI Driver may not be closed\n");
-		exit(1);
-	}
-
-	return 0;
-}
diff --git a/testcases/kernel/device-drivers/pci/user_tpci/user_tpci.h b/testcases/kernel/device-drivers/pci/user_tpci/user_tpci.h
deleted file mode 100644
index 33f5870..0000000
--- a/testcases/kernel/device-drivers/pci/user_tpci/user_tpci.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-int ki_generic(int, int);
-
-
-#if 0
-int ki_probe_pci_dev(int);
-int ki_enable_pci(int);
-int ki_disable_pci(int);
-int ki_find_bus(int);
-int ki_find_class(int);
-int ki_find_device(int);
-int ki_find_subsys(int);
-#endif
-- 
1.7.1


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60133471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
