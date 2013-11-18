Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1ViPfS-0004ar-AS
	for ltp-list@lists.sourceforge.net; Mon, 18 Nov 2013 14:19:10 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ViPfP-0005Jl-7H
	for ltp-list@lists.sourceforge.net; Mon, 18 Nov 2013 14:19:10 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rAIEJ0jH011699
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 18 Nov 2013 14:19:01 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rAIEIxm8013799
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 18 Nov 2013 14:19:00 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rAIEIxpT012058
	for <ltp-list@lists.sourceforge.net>; Mon, 18 Nov 2013 14:18:59 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 18 Nov 2013 18:18:27 +0400
Message-Id: <1384784307-28731-2-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1384784307-28731-1-git-send-email-alexey.kodanev@oracle.com>
References: <1384784307-28731-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH v4 2/2] device-drivers: acpi: fixes
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6477219976036802788=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com, Alexey Kodanev <alexey.kodanev@oracle.com>

--===============6477219976036802788==

Obsolete code updated to the actual kernel ACPI API.
Changed test-cases handling from ioctl to sysfs.
User-space program rewritten.
User-space program loads/unloads kernel module.
Added new test-cases: traverse ACPI devices and sysfs support
for device description.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/kernel/device-drivers/acpi/.gitignore    |    8 +
 testcases/kernel/device-drivers/acpi/Makefile      |   43 +-
 testcases/kernel/device-drivers/acpi/ltp_acpi.c    |  166 ++++
 testcases/kernel/device-drivers/acpi/ltp_acpi.h    |  123 +--
 .../kernel/device-drivers/acpi/ltp_acpi_cmds.c     | 1000 ++++++++++----------
 5 files changed, 714 insertions(+), 626 deletions(-)
 create mode 100644 testcases/kernel/device-drivers/acpi/.gitignore
 create mode 100644 testcases/kernel/device-drivers/acpi/ltp_acpi.c

diff --git a/testcases/kernel/device-drivers/acpi/.gitignore b/testcases/kernel/device-drivers/acpi/.gitignore
new file mode 100644
index 0000000..76fbdc8
--- /dev/null
+++ b/testcases/kernel/device-drivers/acpi/.gitignore
@@ -0,0 +1,8 @@
+/LtpAcpiCmds.ko
+/ltp_acpi
+/*.mod.c
+/modules.order
+/.tmp_versions
+/.*.ko
+/.*.cmd
+/Module.symvers
diff --git a/testcases/kernel/device-drivers/acpi/Makefile b/testcases/kernel/device-drivers/acpi/Makefile
index afec680..31bf26b 100644
--- a/testcases/kernel/device-drivers/acpi/Makefile
+++ b/testcases/kernel/device-drivers/acpi/Makefile
@@ -1,34 +1,33 @@
+# Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
 #
-# Makefile for GCOV profiling kernel module
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
-#  1 Mar 2009 M��rton N��meth <nm127@freemail.hu>
-#   - Updated for Linux kernel 2.6.28
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
 #
-
-#KERNELDIR := /usr/src/linux-2.5.64-gcov
-EXTRA_CFLAGS := -Wall -g -W -Wno-unused-parameter
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 
 ifneq ($(KERNELRELEASE),)
 
-obj-m	:= LtpAcpiCmds.o
-obj-p   := Test
-else
-KDIR	:= /lib/modules/$(shell uname -r)/build
-PWD	:= $(shell pwd)
+obj-m := ltp_acpi_cmds.o
 
-modules:
-	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
-	${CC}  $(CFLAGS) -o LtpAcpiMain  LtpAcpiMain.c
+else
 
-clean:
-	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) clean
-	rm -f modules.order
-	rm -f LtpAcpiMain
+top_srcdir	?= ../../../..
+include $(top_srcdir)/include/mk/testcases.mk
 
-help:
-	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) help
+REQ_VERSION_MAJOR	:= 2
+REQ_VERSION_PATCH	:= 6
+MAKE_TARGETS		:= ltp_acpi ltp_acpi_cmds.ko
 
-modules_install:
-	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules_install
+include $(top_srcdir)/include/mk/module.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
 endif
diff --git a/testcases/kernel/device-drivers/acpi/ltp_acpi.c b/testcases/kernel/device-drivers/acpi/ltp_acpi.c
new file mode 100644
index 0000000..612c3d4
--- /dev/null
+++ b/testcases/kernel/device-drivers/acpi/ltp_acpi.c
@@ -0,0 +1,166 @@
+/*
+ * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ * Author: Alexey Kodanev <alexey.kodanev@oracle.com>
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "tst_module.h"
+#include "safe_macros.h"
+#include "safe_stdio.h"
+
+#include "ltp_acpi.h"
+
+char *TCID = "ltp_acpi";
+int TST_TOTAL = ACPI_TC_NUM;
+
+static const char dev_result[]	= "/sys/devices/" ACPI_TEST_NAME "/result";
+static const char dev_path[]	= "/sys/devices/" ACPI_TEST_NAME "/path";
+static const char dev_str[]	= "/sys/devices/" ACPI_TEST_NAME "/str";
+static const char dev_tcase[]	= "/sys/devices/" ACPI_TEST_NAME "/tcase";
+static const char module_name[]	= "ltp_acpi_cmds.ko";
+static int module_loaded;
+
+static void cleanup(void)
+{
+	if (module_loaded)
+		tst_module_unload(NULL, module_name);
+
+	TEST_CLEANUP;
+}
+
+static int read_sysfs_file(const char *name, char *buf, int size)
+{
+	FILE *f = SAFE_FOPEN(cleanup, name, "r");
+	if (!fgets(buf, size, f)) {
+		tst_resm(TFAIL, "failed to read sysfs file '%s'", name);
+		return 1;
+	}
+	SAFE_FCLOSE(cleanup, f);
+	return 0;
+}
+
+static int next_acpi_str(void)
+{
+	char descr[4096], sysfs_path[4096];
+
+	/*
+	 * if device has _STR object, we should get
+	 * a valid string from 'str' sysfs file and then can
+	 * find it in sysfs.
+	 */
+	if (read_sysfs_file(dev_str, descr, 4096))
+		return 0;
+	if (!strcmp(descr, "null")) {
+		tst_resm(TCONF, "None of left devices has _STR");
+		return 0;
+	}
+	tst_resm(TINFO, "read description %s", descr);
+
+	/* device's sysfs path */
+	strcpy(sysfs_path, "/sys");
+	if (read_sysfs_file(dev_path, sysfs_path + 4, 4092))
+		return 0;
+	if (!strcmp(sysfs_path + 4, "null")) {
+		tst_resm(TCONF, "device doesn't have sysfs entry");
+		/* continue, because others might have it */
+		return 1;
+	}
+	strcat(sysfs_path, "/description");
+
+	/*
+	 * Find device description in sysfs.
+	 *
+	 * New sysfs interface to export device description
+	 * implemented since Linux 3.7
+	 */
+	if (tst_kvercmp(3, 7, 0) < 0) {
+		tst_resm(TCONF,
+			"sysfs description check required Linux 3.7+");
+		return 1;
+	}
+
+	if (access(sysfs_path, R_OK)) {
+		tst_resm(TFAIL, "can't find description file '%s'", sysfs_path);
+		return 1;
+	}
+	tst_resm(TPASS, "found description file '%s'", sysfs_path);
+
+	char sysfs_descr[4096];
+	if (read_sysfs_file(sysfs_path, sysfs_descr, 4096))
+		return 1;
+
+	/*
+	 * Compare sysfs file and description from test driver
+	 */
+	int res = strncmp(descr, sysfs_descr, strlen(descr));
+
+	tst_resm((res) ? TFAIL : TPASS, "check sysfs file");
+
+	return 1;
+}
+
+static void test_run(void)
+{
+	int i = 0, res;
+	while (i < TST_TOTAL) {
+
+		SAFE_FILE_PRINTF(cleanup, dev_tcase, "%d", i);
+		SAFE_FILE_SCANF(cleanup, dev_result, "%d", &res);
+
+		tst_resm(res, "Test-case '%d'", i);
+
+		/*
+		 * trigger ACPI_TRAVERSE test-case while we can
+		 * get valid next device description.
+		 */
+		if (i == ACPI_TRAVERSE && next_acpi_str())
+			continue;
+
+		++i;
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	char *msg;
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	tst_require_root(NULL);
+
+	if (tst_kvercmp(2, 6, 0) < 0) {
+		tst_brkm(TCONF, NULL,
+			"Test must be run with kernel 2.6 or newer");
+	}
+
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+
+	tst_module_load(NULL, module_name, NULL);
+	module_loaded = 1;
+
+	test_run();
+
+	cleanup();
+
+	tst_exit();
+}
diff --git a/testcases/kernel/device-drivers/acpi/ltp_acpi.h b/testcases/kernel/device-drivers/acpi/ltp_acpi.h
index 5c0c37b..b66e8c4 100644
--- a/testcases/kernel/device-drivers/acpi/ltp_acpi.h
+++ b/testcases/kernel/device-drivers/acpi/ltp_acpi.h
@@ -1,97 +1,38 @@
 /*
+ * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
  *
- *   Copyright (c) International Business Machines  Corp., 2001
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
  *
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
-/*
- *  FILE        : LtpAcpi.h
- *  DESCRIPTION :
- *  HISTORY:
- *    06/09/2003 Initial creation mridge@us.ibm.com
- *      -Ported
- *  updated - 01/09/2005 Updates from Intel to add functionality
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#define ACPI_LTP_TEST_COMPONENT	        	0x00020999
-#define ACPI_LTP_TEST_CLASS		        	"ltp_test"
-#define ACPI_LTP_TEST_HID 		        	"ACPI0999"
-#define ACPI_LTP_TEST_DRIVER_NAME		    "ACPI LTP Test Driver"
-#define ACPI_LTP_TEST_DEVICE_NAME	    	"LTP Test"
-#define ACPI_LTP_TEST_FILE_STATE    		"state"
-#define ACPI_LTP_TEST_NOTIFY_STATUS		    0x80
-#define ACPI_LTP_TEST_STATUS_OFFLINE		0x00
-#define ACPI_LTP_TEST_STATUS_ONLINE	    	0x01
-#define ACPI_LTP_TEST_STATUS_UNKNOWN		0xFF
-#define _COMPONENT		ACPI_LTP_TEST_COMPONENT
-#define ACPI_TLP_TEST_MODULE_NAME		("acpi_ltp_test")
-#define ACPI_NS_SYSTEM_BUS          "_SB_"
-#define ACPI_BATTERY_FORMAT_BIF	"NNNNNNNNNSSSS"
-#define ACPI_BATTERY_FORMAT_BST	"NNNN"
-
-
-#define ACPI_TYPE_ANY                   0x00
-#define ACPI_TYPE_INTEGER               0x01  /* Byte/Word/Dword/Zero/One/Ones */
-#define ACPI_TYPE_STRING                0x02
-#define ACPI_TYPE_BUFFER                0x03
-#define ACPI_TYPE_PACKAGE               0x04  /* byte_const, multiple data_term/Constant/super_name */
-#define ACPI_TYPE_FIELD_UNIT            0x05
-#define ACPI_TYPE_DEVICE                0x06  /* Name, multiple Node */
-#define ACPI_TYPE_EVENT                 0x07
-#define ACPI_TYPE_METHOD                0x08  /* Name, byte_const, multiple Code */
-#define ACPI_TYPE_MUTEX                 0x09
-#define ACPI_TYPE_REGION                0x0A
-#define ACPI_TYPE_POWER                 0x0B  /* Name,byte_const,word_const,multi Node */
-#define ACPI_TYPE_PROCESSOR             0x0C  /* Name,byte_const,Dword_const,byte_const,multi nm_o */
-#define ACPI_TYPE_THERMAL               0x0D  /* Name, multiple Node */
-#define ACPI_TYPE_BUFFER_FIELD          0x0E
-#define ACPI_TYPE_DDB_HANDLE            0x0F
-#define ACPI_TYPE_DEBUG_OBJECT          0x10
-
-#define ACPI_TYPE_EXTERNAL_MAX          0x10
-#define LTPMAJOR                        252
-
-/* Use 'k' as magic number */
-#define LTPACPI_IOC_MAGIC  'k'
-#define TOMINOR(x) ((x & 3) | ((x & 4) << 5))
-
-
-#define DEV_PATH                            "/dev"
-#define LTP_ACPI_DIR_NAME                   ""
-#define LTP_ACPI_DEV_NAME                   "LTP"
-#define LTP_ACPI_DEV_NODE_PATH              DEV_PATH "/"
-#define LTP_ACPI_DEVICE_NAME                DEV_PATH "/"  LTP_ACPI_DEV_NAME
-#define MINOR_SHIFT_BITS 3
-#define MAX_PARTITIONS 8                    /* partition 0 + 7 more possible due to 3 bit partition number field */
-#define	MAX_NUM_DISKS 3                   /* number of real devices */
-
-#define MPDEV_FLAG_CLEAR 0
-#define MPDEV_FLAG_SET   1
-
-typedef struct _ltpdev_cmd {
-    u_int32_t     cmd;           // input - 0==recover, 1==fail
-    u_int32_t     status;        // ouput - 0==success
-} ltpdev_cmd_t;
-
-typedef enum ltpdev_ioctl_cmds_s {
-	/* version commands */
-	LTP_IOCTL_NUMBER = 0x5500
-} ltpdev_ioctl_cmds_t;
-
-// define the ioctl cmds
-#define LTPDEV_CMD       _IOR( LTPMAJOR, LTP_IOCTL_NUMBER, ltpdev_cmd_t **)
-
+#define ACPI_TEST_NAME		"ltp_acpi_test"
+
+enum ACPI_TEST_CASES {
+	ACPI_INIT = 0,
+
+	/*
+	 * Test-case will stop traversing if it finds _STR.
+	 * To continue, please trigger it again.
+	 */
+	ACPI_TRAVERSE,
+	ACPI_NOTIFY_HANDLER,
+	ACPI_EVENT_HANDLER,
+	ACPI_GLOBAL_LOCK,
+	ACPI_TEST_BUS,
+	ACPI_TEST_RESOURCES,
+	ACPI_SLEEP_TEST,
+	ACPI_TEST_REGISTER,
+	ACPI_TEST_DEV_CALLBACK,
+	ACPI_TC_NUM
+};
diff --git a/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c b/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c
index 26fcc15..ff89bc5 100644
--- a/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c
+++ b/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c
@@ -1,20 +1,20 @@
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
 
 /*
@@ -27,7 +27,6 @@
  *
  *  01/03/2009 M��rton N��meth <nm127@freemail.hu>
  *   - Updated for Linux kernel 2.6.28
- *
  */
 
 #include <linux/kernel.h>
@@ -40,477 +39,443 @@
 #include <linux/pm.h>
 #include <linux/acpi.h>
 #include <linux/genhd.h>
-#include <asm/uaccess.h>
-#include "LtpAcpi.h"
-
-#ifndef ACPI_EC_UDELAY_GLK
-#define ACPI_EC_UDELAY_GLK	1000	/* Wait 1ms max. to get global lock */
-#endif
-
-static int ltpdev_open(struct block_device *bdev, fmode_t mode);
-static int ltpdev_release(struct gendisk *disk, fmode_t mode);
-static int ltpdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
-			unsigned long arg);
-
-static u32 ltp_test_sleep_button_ev_handler(void *context);
-static u32 ltp_test_power_button_ev_handler(void *context);
-static u32 acpi_ec_gpe_handler(void *context);
-
-static void acpi_bus_notify(acpi_handle handle, u32 type, void *data);
-static acpi_status ltp_get_dev_callback(acpi_handle obj, u32 depth,
-					void *context, void **ret);
-static acpi_status acpi_ec_io_ports(struct acpi_resource *resource,
-				    void *context);
-#if 0
-static acpi_status acpi_ec_space_setup(acpi_handle region_handle,
-				       u32 function,
-				       void *handler_context,
-				       void **return_context);
-static acpi_status acpi_ec_space_handler(u32 function,
-					 acpi_physical_address address,
-					 u32 bit_width,
-					 acpi_integer * value,
-					 void *handler_context,
-					 void *region_context);
-#endif
+#include <linux/dmi.h>
+#include <linux/nls.h>
 
-static struct block_device_operations blkops = {
-open:	ltpdev_open,
-release:ltpdev_release,
-ioctl:	ltpdev_ioctl,
-};
-
-int ltp_acpi_major = LTPMAJOR;
-int test_iteration = 0;
-
-static char genhd_flags = 0;
-static struct gendisk *gd_ptr;
-
-struct acpi_ec {
-	acpi_handle handle;
-	unsigned long uid;
-	unsigned long long gpe_bit;
-	struct acpi_generic_address status_addr;
-	struct acpi_generic_address command_addr;
-	struct acpi_generic_address data_addr;
-	unsigned long global_lock;
-	spinlock_t lock;
-};
+#include "ltp_acpi.h"
 
 MODULE_AUTHOR("Martin Ridgeway <mridge@us.ibm.com>");
-MODULE_DESCRIPTION(ACPI_LTP_TEST_DRIVER_NAME);
+MODULE_AUTHOR("Alexey Kodanev <alexey.kodanev@oracle.com>");
+MODULE_DESCRIPTION("ACPI LTP Test Driver");
 MODULE_LICENSE("GPL");
+ACPI_MODULE_NAME("LTP_ACPI")
 
-/*
- * Device operations for the virtual ACPI devices
- */
-
-extern struct acpi_device *acpi_root;
+#define prk_err(fmt, ...) \
+	pr_err(ACPI_TEST_NAME ": " fmt "\n", ##__VA_ARGS__)
+#define prk_alert(fmt, ...) \
+	pr_alert(ACPI_TEST_NAME ": " fmt "\n", ##__VA_ARGS__)
+#define prk_info(fmt, ...) \
+	pr_info(ACPI_TEST_NAME ": " fmt "\n", ##__VA_ARGS__)
 
-static int ltpdev_open(struct block_device *dev, fmode_t mode)
+static int acpi_failure(acpi_status status, const char *name)
 {
-	printk(KERN_ALERT "ltpdev_open \n");
+	if (ACPI_FAILURE(status)) {
+		ACPI_EXCEPTION((AE_INFO, status, name));
+		return 1;
+	}
 	return 0;
 }
 
-static int ltpdev_release(struct gendisk *disk, fmode_t mode)
-{
-
-	printk(KERN_ALERT "ltpdev_release \n");
-	return 0;
-}
+/* points to the string of the last found object _STR */
+static char *str_obj_result;
 
-static u32 ltp_test_power_button_ev_handler(void *context)
-{
-	printk(KERN_ALERT "ltp_test_power_button_ev_handler \n");
-	return 1;
-}
+/* sysfs device path of the last found device */
+static char *sysfs_path;
 
-static u32 ltp_test_sleep_button_ev_handler(void *context)
-{
-	printk(KERN_ALERT "ltp_test_sleep_button_ev_handler \n");
-	return 1;
-}
+/* first found device with _CRS */
+static acpi_handle res_handle;
 
-static int ltpdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
-			unsigned long arg)
+static acpi_status get_str_object(acpi_handle handle)
 {
+	int res;
 	acpi_status status;
-//      acpi_handle        sys_bus_handle;
-	acpi_handle start_handle = 0;
-	acpi_handle parent_handle;
-	acpi_handle child_handle;
-	acpi_handle next_child_handle;
-	acpi_status level;
-	struct acpi_ec *ec;
-	struct acpi_device *device;
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	acpi_handle temp = 0;
+	union acpi_object *str_obj;
+	char *buf = NULL;
 
-#if 0
-	acpi_handle tmp_handle;
-	struct acpi_table_ecdt *ecdt_ptr;
-	struct acpi_buffer dsdt = { ACPI_ALLOCATE_BUFFER, NULL };
-	struct acpi_buffer batt_buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	struct acpi_buffer format = { sizeof(ACPI_BATTERY_FORMAT_BIF),
-		ACPI_BATTERY_FORMAT_BIF
-	};
-	struct acpi_buffer data = { 0, NULL };
-	union acpi_object *package = NULL;
-	u32 start_ticks, stop_ticks, total_ticks;
-#endif
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
 
-	u32 i, bm_status;
-	u8 type_a, type_b;
-	u32 global_lock = 0;
-	int state = 0;
+	status = acpi_get_handle(handle, "_STR", &temp);
 
-    /*****************************************************************************/
+	if (ACPI_SUCCESS(status) && !acpi_evaluate_object(handle,
+		"_STR", NULL, &buffer)) {
 
-	printk(KERN_ALERT "ltpdev_ioctl \n");
-	switch (cmd) {
-	case LTPDEV_CMD:
+		str_obj = buffer.pointer;
 
-		parent_handle = start_handle;
-		child_handle = 0;
-		level = 1;
-		test_iteration++;
+		buf = kmalloc(str_obj->buffer.length / 2, GFP_KERNEL);
+		if (!buf) {
+			kfree(str_obj);
+			return AE_NO_MEMORY;
+		}
 
-		printk(KERN_ALERT
-		       "-- IOCTL called to start ACPI tests -- Iteration:%d\n",
-		       test_iteration);
+		res = utf16s_to_utf8s((wchar_t *)str_obj->buffer.pointer,
+			str_obj->buffer.length, UTF16_LITTLE_ENDIAN, buf,
+			str_obj->buffer.length / 2);
 
-		printk(KERN_ALERT "TEST -- acpi_get_handle \n");
+		buf[res] = '\0';
 
-		status = acpi_get_handle(0, ACPI_NS_SYSTEM_BUS, &parent_handle);
+		kfree(str_obj_result);
+		str_obj_result = buf;
+		kfree(str_obj);
+	}
 
-		printk(KERN_ALERT "TEST -- acpi_get_object_info \n");
+	return status;
+}
 
-		status = acpi_get_object_info(parent_handle, &buffer);
+static void get_crs_object(acpi_handle handle)
+{
+	acpi_status status;
+	acpi_handle temp;
+	if (!res_handle) {
+		status = acpi_get_handle(handle, METHOD_NAME__CRS, &temp);
+		if (ACPI_SUCCESS(status))
+			res_handle = handle;
+	}
+}
 
-		printk(KERN_ALERT "TEST -- acpi_get_next_object \n");
+static void get_sysfs_path(acpi_handle handle)
+{
+	acpi_status status;
+	struct acpi_device *device;
+	struct device *dev;
+	struct kobject *kobj;
 
-		status = acpi_get_next_object(ACPI_TYPE_ANY, parent_handle,
-					      child_handle, &next_child_handle);
+	kfree(sysfs_path);
+	sysfs_path = NULL;
 
-		printk(KERN_ALERT "TEST -- acpi_get_parent \n");
+	status = acpi_bus_get_device(handle, &device);
+	if (ACPI_SUCCESS(status)) {
+		dev = &device->dev;
+		kobj = &dev->kobj;
+		sysfs_path = kobject_get_path(&device->dev.kobj, GFP_KERNEL);
+	}
+}
 
-		status = acpi_get_parent(parent_handle, &parent_handle);
+/* acpi handle of the last visited device */
+static acpi_handle start_parent;
 
-		printk(KERN_ALERT "TEST -- acpi_evaluate_object \n");
+static int acpi_traverse(acpi_handle parent, acpi_handle child)
+{
+	static char indent[64];
+	const char * const ind_end = indent + 63;
+	static const char *ind = ind_end;
+	acpi_status status;
+	struct acpi_device_info *dev_info;
+	acpi_handle new_child;
 
-		status = acpi_evaluate_object(parent_handle, "_ON", NULL, NULL);
+	if (!indent[0])
+		memset(indent, 0x20, 63);
 
-		printk(KERN_ALERT "TEST -- acpi_get_table \n");
+	while (parent) {
+		status = acpi_get_next_object(ACPI_TYPE_DEVICE,
+			parent, child, &new_child);
 
-//        status = acpi_get_table(ACPI_TABLE_RSDP, 1, &dsdt);
-//        status = acpi_get_table(ACPI_TABLE_DSDT, 1, &dsdt);
-//        status = acpi_get_table(ACPI_TABLE_FADT, 1, &dsdt);
-//        status = acpi_get_table(ACPI_TABLE_FACS, 1, &dsdt);
-//        status = acpi_get_table(ACPI_TABLE_PSDT, 1, &dsdt);
-//        status = acpi_get_table(ACPI_TABLE_SSDT, 1, &dsdt);
-//        status = acpi_get_table(ACPI_TABLE_XSDT, 1, &dsdt);
+		if (ACPI_FAILURE(status)) {
+			ind += 4;
 
-#if 0
-		printk(KERN_ALERT "TEST -- acpi_get_firmware_table \n");
+			child = parent;
+			status = acpi_get_parent(child, &parent);
 
-		status =
-		    acpi_get_firmware_table("ECDT", 1, ACPI_LOGICAL_ADDRESSING,
-					    (struct acpi_table_header **)&dsdt);
-#endif
+			/* no more devices */
+			if (ACPI_FAILURE(status)) {
+				start_parent = 0;
+				kfree(str_obj_result);
+				str_obj_result = NULL;
+				break;
+			}
+			continue;
+		}
 
-		printk(KERN_ALERT "TEST -- acpi_install_notify_handler \n");
-
-		status =
-		    acpi_install_notify_handler(ACPI_ROOT_OBJECT,
-						ACPI_SYSTEM_NOTIFY,
-						&acpi_bus_notify, NULL);
-
-		printk(KERN_ALERT "TEST -- acpi_remove_notify_handler \n");
-
-		status =
-		    acpi_remove_notify_handler(ACPI_ROOT_OBJECT,
-					       ACPI_SYSTEM_NOTIFY,
-					       &acpi_bus_notify);
-
-		printk(KERN_ALERT
-		       "TEST -- acpi_install_fixed_event_handler \n");
-		status =
-		    acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
-						     ltp_test_power_button_ev_handler,
-						     NULL);
-		if (status)
-			printk(KERN_ALERT
-			       "Failed installing fixed event handler \n");
-
-		printk(KERN_ALERT "TEST -- acpi_remove_fixed_event_handler \n");
-		status =
-		    acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
-						    ltp_test_power_button_ev_handler);
-		if (status)
-			printk(KERN_ALERT
-			       "Failed removing fixed event handler \n");
-
-		printk(KERN_ALERT
-		       "TEST -- acpi_install_fixed_event_handler \n");
-		status =
-		    acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
-						     ltp_test_sleep_button_ev_handler,
-						     NULL);
-		if (status)
-			printk(KERN_ALERT
-			       "Failed installing fixed event handler \n");
-
-		printk(KERN_ALERT "TEST -- acpi_remove_fixed_event_handler \n");
-		status =
-		    acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
-						    ltp_test_sleep_button_ev_handler);
-		if (status)
-			printk(KERN_ALERT
-			       "Failed removing fixed event handler \n");
-
-		printk(KERN_ALERT "TEST -- acpi_acquire_global_lock \n");
-		status =
-		    acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &global_lock);
-
-		printk(KERN_ALERT "TEST -- acpi_release_global_lock \n");
-		status = acpi_release_global_lock(global_lock);
-
-		printk(KERN_ALERT "TEST -- acpi_bus_get_device \n");
-
-		status = acpi_bus_get_device(next_child_handle, &device);
-
-#if 0
-		printk(KERN_ALERT "TEST -- acpi_bus_find_driver \n");
-		status = acpi_bus_find_driver(device);
-#endif
+		status = acpi_get_object_info(new_child, &dev_info);
+		if (acpi_failure(status, "acpi_object_info failed"))
+			return 1;
+
+		get_sysfs_path(new_child);
+
+		get_crs_object(new_child);
+
+		if (ind < indent)
+			ind = indent;
+		else if (ind > ind_end)
+			ind = ind_end;
+
+		/*
+		 * if we find _STR object we will stop here
+		 * and save last visited child
+		 */
+		if (ACPI_SUCCESS(get_str_object(new_child))) {
+			prk_info("%s%4.4s: has '_STR' '%s' path '%s'",
+				ind, (char *)&dev_info->name, str_obj_result,
+				(sysfs_path) ? sysfs_path : "no path");
+			ind -= 4;
+			start_parent = new_child;
+			kfree(dev_info);
+			break;
+		}
+		prk_info("%s%4.4s: path '%s'", ind, (char *)&dev_info->name,
+			(sysfs_path) ? sysfs_path : "no path");
 
-		printk(KERN_ALERT "TEST -- acpi_bus_get_power \n");
-		status = acpi_bus_get_power(next_child_handle, &state);
-		if (status)
-			printk(KERN_ALERT "Error reading power state \n");
+		ind -= 4;
+		parent = new_child;
+		child = 0;
+		kfree(dev_info);
+	}
 
-		printk(KERN_ALERT "TEST -- acpi_driver_data \n");
+	return 0;
+}
 
-		ec = acpi_driver_data(device);
+static int acpi_traverse_from_root(void)
+{
+	acpi_status status;
+	struct acpi_device_info *dev_info;
+	acpi_handle parent = 0, child = 0;
+
+	if (!start_parent) {
+		status = acpi_get_handle(NULL, ACPI_NS_ROOT_PATH, &parent);
+		if (acpi_failure(status, "acpi_get_handle"))
+			return 1;
+		status = acpi_get_object_info(parent, &dev_info);
+		if (acpi_failure(status, "acpi_object_info failed"))
+			return 1;
+		prk_info("start from %4.4s", (char *)&dev_info->name);
+	} else {
+		/* continue with the last visited child */
+		parent = start_parent;
+	}
 
-		if (!ec) {
-			printk(KERN_ALERT "Failure getting device data \n");
-		} else {
+	return acpi_traverse(parent, child);
+}
 
-			printk(KERN_ALERT
-			       "TEST -- acpi_install_gpe_handler \n");
-			ec->status_addr = ec->command_addr;
-			status =
-			    acpi_install_gpe_handler(device, ec->gpe_bit,
-						     ACPI_GPE_EDGE_TRIGGERED,
-						     &acpi_ec_gpe_handler, ec);
-/*
-            status = acpi_install_address_space_handler (ACPI_ROOT_OBJECT,
-                    ACPI_ADR_SPACE_EC, &acpi_ec_space_handler,
-                    &acpi_ec_space_setup, ec);
-
-            if (status) {
-                printk(KERN_ALERT "Failed installing address space handler \n");
-            }
-
-            acpi_remove_address_space_handler(ACPI_ROOT_OBJECT,
-                ACPI_ADR_SPACE_EC, &acpi_ec_space_handler);
-*/
-			printk(KERN_ALERT "TEST -- acpi_remove_gpe_handler \n");
-			acpi_remove_gpe_handler(device, ec->gpe_bit,
-						&acpi_ec_gpe_handler);
-		}
+/* first found device with _STR */
+static acpi_handle dev_handle;
 
-		printk(KERN_ALERT "TEST -- acpi_get_current_resources \n");
-		status = acpi_get_current_resources(next_child_handle, &buffer);
+static int acpi_init(void)
+{
+	acpi_status status;
+	acpi_handle parent_handle;
 
-		if (status) {
-			printk(KERN_ALERT "Failed get_current_resources %d\n",
-			       status);
-		}
-#ifdef ACPI_FUTURE_USAGE
-		printk(KERN_ALERT "TEST -- acpi_get_possible_resources \n");
-		status =
-		    acpi_get_possible_resources(next_child_handle, &buffer);
+	struct acpi_device_info *dev_info;
 
-		if (status) {
-			printk(KERN_ALERT "Failed get_possible_resources %d\n",
-			       status);
-		}
-#endif
+	prk_alert("TEST -- acpi_get_handle ");
+	status = acpi_get_handle(NULL, "\\_SB", &parent_handle);
+	if (acpi_failure(status, "acpi_get_handle"))
+		return 1;
 
-		printk(KERN_ALERT "TEST -- acpi_walk_resources \n");
-		status = acpi_walk_resources(ec->handle, METHOD_NAME__CRS,
-					     acpi_ec_io_ports, ec);
+	/* get first device on SYS bus, it will be used in other tests */
+	while (acpi_get_next_object(ACPI_TYPE_DEVICE,
+		parent_handle, 0, &dev_handle) == 0) {
+		parent_handle = dev_handle;
+	}
 
-		if (status) {
-			printk(KERN_ALERT "Failed walk_resources %d\n", status);
-		}
+	status = acpi_get_object_info(dev_handle, &dev_info);
+	if (acpi_failure(status, "acpi_object_info failed"))
+		return 1;
 
-		printk(KERN_ALERT "TEST -- acpi_evaluate_integer \n");
-		status =
-		    acpi_evaluate_integer(ec->handle, "_GPE", NULL,
-					  &ec->gpe_bit);
-		if (status)
-			printk(KERN_ALERT
-			       "Error obtaining GPE bit assignment\n");
-
-#if 0
-		printk(KERN_ALERT "TEST -- acpi_get_timer \n");
-		status = acpi_get_timer(&total_ticks);
-
-		if (status) {
-			printk(KERN_ALERT "Failed get_timer %d\n", status);
-		} else {
-			printk(KERN_ALERT "get_timer -- total_ticks %d\n",
-			       total_ticks);
-		}
+	prk_alert("ACPI object name %4.4s, type %d", (char *)&dev_info->name,
+		dev_info->type);
+	kfree(dev_info);
 
-		start_ticks = 20;
-		stop_ticks = 30;
+	prk_alert("TEST -- acpi_get_parent ");
+	status = acpi_get_parent(dev_handle, &parent_handle);
+	return acpi_failure(status, "acpi_get_parent failed");
+}
 
-		printk(KERN_ALERT "TEST -- acpi_get_timer_duration \n");
-		status =
-		    acpi_get_timer_duration(start_ticks, stop_ticks,
-					    &total_ticks);
+/*
+ * acpi_bus_notify
+ * ---------------
+ * Callback for all 'system-level' device notifications (values 0x00-0x7F).
+ */
+static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
+{
+	prk_alert("Register ACPI Bus Notify callback function");
+}
 
-		if (status) {
-			printk(KERN_ALERT "Failed get_timer_duration %d\n",
-			       status);
-		} else {
-			printk(KERN_ALERT "get_timer_duration total_ticks %d\n",
-			       total_ticks);
-		}
-#endif
+static int acpi_test_notify_handler(void)
+{
+	acpi_status status;
 
-		for (i = 0; i < ACPI_S_STATE_COUNT; i++) {
-			printk(KERN_ALERT
-			       "TEST -- acpi_get_sleep_type_data \n");
-			status = acpi_get_sleep_type_data(i, &type_a, &type_b);
-
-			if (status) {
-				printk(KERN_ALERT
-				       "Failed get_sleep_type_data %d\n",
-				       status);
-			} else {
-				printk(KERN_ALERT
-				       "get_sleep_type_data [%d] type_a:%d type_b:%d\n",
-				       i, type_a, type_b);
-			}
-		}
+	prk_alert("TEST -- acpi_install_notify_handler");
 
-		printk(KERN_ALERT "TEST -- acpi_get_register \n");
+	status = acpi_install_notify_handler(dev_handle,
+		ACPI_SYSTEM_NOTIFY, &acpi_bus_notify, NULL);
 
-/*
- * ACPICA: Remove obsolete Flags parameter.
- * http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=d8c71b6d3b21cf21ad775e1cf6da95bf87bd5ad4
- *
- */
-		acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS, &bm_status);
+	if (ACPI_SUCCESS(status)) {
+		prk_alert("TEST -- acpi_remove_notify_handler");
+		status = acpi_remove_notify_handler(dev_handle,
+			ACPI_SYSTEM_NOTIFY, &acpi_bus_notify);
+		return acpi_failure(status, "acpi_remove_notify_handler");
+	} else if (status != AE_ALREADY_EXISTS) {
+		return acpi_failure(status, "acpi_install_notify_handler");
+	}
 
-		if (!bm_status) {
-			printk(KERN_ALERT "Failed get_register [%d]\n",
-			       bm_status);
-		} else {
-			printk(KERN_ALERT "get_register [%d] \n", bm_status);
-		}
+	return 0;
+}
+
+static u32 ltp_test_power_button_ev_handler(void *context)
+{
+	prk_alert("ltp_test_power_button_ev_handler");
+	return 1;
+}
+
+static u32 ltp_test_sleep_button_ev_handler(void *context)
+{
+	prk_alert("ltp_test_sleep_button_ev_handler");
+	return 1;
+}
 
-//        Puts system to sleep, permenately !!!
-//        status = acpi_enter_sleep_state(ACPI_STATE_S1);
+static int acpi_test_event_handler(void)
+{
+	int err = 0;
+	acpi_status status;
 
-#if 0
-		printk(KERN_ALERT "TEST -- acpi_get_system_info \n");
-		status = acpi_get_system_info(&buffer);
+	prk_alert("TEST -- acpi_install_fixed_event_handler");
+	status = acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
+		ltp_test_power_button_ev_handler, NULL);
+
+	if (ACPI_SUCCESS(status)) {
+		prk_alert("TEST -- acpi_remove_fixed_event_handler");
+		status = acpi_remove_fixed_event_handler(
+			ACPI_EVENT_POWER_BUTTON,
+			ltp_test_power_button_ev_handler);
+		err = acpi_failure(status, "remove fixed event handler");
+	} else if (status != AE_ALREADY_EXISTS) {
+		err = acpi_failure(status, "install fixed event handler");
+	}
 
-		if (status) {
-			printk(KERN_ALERT "Failed get_system_info %d\n",
-			       status);
-		} else {
-			printk(KERN_ALERT
-			       "get_system_info buffer.length:%d buffer.pointer:%p\n",
-			       buffer.length, buffer.pointer);
+	prk_alert("TEST -- acpi_install_fixed_event_handler");
+	status = acpi_install_fixed_event_handler(ACPI_EVENT_RTC,
+		ltp_test_sleep_button_ev_handler, NULL);
+
+	if (ACPI_SUCCESS(status)) {
+		prk_alert("TEST -- acpi_remove_fixed_event_handler");
+		status = acpi_remove_fixed_event_handler(
+			ACPI_EVENT_RTC,
+			ltp_test_sleep_button_ev_handler);
+		err |= acpi_failure(status, "remove fixed event handler");
+	} else if (status != AE_ALREADY_EXISTS) {
+		err |= acpi_failure(status, "install fixed event handler");
+	}
 
-			acpi_os_printf("os_printf OK %d\n", status);
+	return err;
+}
 
-			if (buffer.pointer) {
-				acpi_os_free(buffer.pointer);
-			}
-		}
+#ifndef ACPI_EC_UDELAY_GLK
+#define ACPI_EC_UDELAY_GLK	1000	/* Wait 1ms max. to get global lock */
 #endif
 
-		printk(KERN_ALERT "TEST -- acpi_get_devices \n");
-		status =
-		    acpi_get_devices(NULL, ltp_get_dev_callback, "LTP0001",
-				     NULL);
+static int acpi_global_lock(void)
+{
+	acpi_status status;
+	u32 global_lock = 0;
+
+	prk_alert("TEST -- acpi_acquire_global_lock ");
+	status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &global_lock);
+	if (acpi_failure(status, "acpi_acquire_global_lock"))
+		return 1;
 
-		if (status) {
-			printk(KERN_ALERT "Failed get_devices %d\n", status);
-		}
-//        status = acpi_os_create_semaphore(1, 1, &tmp_handle);
+	prk_alert("TEST -- acpi_release_global_lock ");
+	status = acpi_release_global_lock(global_lock);
+	return acpi_failure(status, "acpi_release_global_lock");
+}
+
+static int acpi_test_bus(void)
+{
+	int state = 0;
+	acpi_status status;
+	acpi_handle bus_handle;
+	struct acpi_device *device;
 
-		if (status) {
-			printk(KERN_ALERT "Failed os_create_semaphore %d\n",
-			       status);
-		} else {
-			printk(KERN_ALERT
-			       "os_create_semaphore OK, no deleteing %d\n",
-			       status);
-//            acpi_os_delete_semaphore(tmp_handle);
+	status = acpi_get_handle(NULL, "\\_SB", &bus_handle);
+	if (acpi_failure(status, "acpi_get_handle"))
+		return 1;
 
-		}
+	prk_alert("TEST -- acpi_bus_get_device");
+	status = acpi_bus_get_device(bus_handle, &device);
+	if (acpi_failure(status, "acpi_bus_get_device"))
+		return 1;
 
-#if 0
-		printk(KERN_ALERT "TEST -- acpi_get_system_info \n");
-		status = acpi_get_system_info(&batt_buffer);
+	prk_alert("TEST -- acpi_bus_update_power ");
+	status = acpi_bus_update_power(device->handle, &state);
+	if (acpi_failure(status, "error reading power state"))
+		return 1;
 
-		if (status) {
-			printk(KERN_ALERT "Failed get_system_info %d\n",
-			       status);
-		} else {
-			printk(KERN_ALERT
-			       "get_system_info buffer.length:%d buffer.pointer:%p\n",
-			       buffer.length, buffer.pointer);
+	prk_info("acpi bus power state is %d", state);
+	return 0;
+}
 
-			package = (union acpi_object *)batt_buffer.pointer;
+static acpi_status acpi_ec_io_ports(struct acpi_resource *resource,
+	void *context)
+{
+	return 0;
+}
 
-			/* Extract Package Data */
+static int acpi_test_resources(void)
+{
+	int err = 0;
+	acpi_status status;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
-			printk(KERN_ALERT "TEST -- acpi_extract_package \n");
-			status = acpi_extract_package(package, &format, &data);
+	/* skip if we don't find device with _CRC */
+	if (res_handle == 0)
+		return 0;
 
-			data.pointer = kmalloc(data.length, GFP_KERNEL);
+	prk_alert("TEST -- acpi_get_current_resources");
+	status = acpi_get_current_resources(res_handle, &buffer);
+	err = acpi_failure(status, "failed get_current_resources");
 
-			if (!data.pointer) {
-				printk(KERN_ALERT
-				       "Failed getting memory kalloc \n");
-			} else {
-				memset(data.pointer, 0, data.length);
+#ifdef ACPI_FUTURE_USAGE
+	prk_alert("TEST -- acpi_get_possible_resources");
+	status = acpi_get_possible_resources(res_handle, &buffer);
+	err |= acpi_failure(status, "get_possible_resources");
+#endif
 
-				printk(KERN_ALERT
-				       "TEST -- acpi_extract_package \n");
-				status =
-				    acpi_extract_package(package, &format,
-							 &data);
+	prk_alert("TEST -- acpi_walk_resources ");
+	status = acpi_walk_resources(res_handle, METHOD_NAME__CRS,
+		acpi_ec_io_ports, NULL);
+	err |= acpi_failure(status, "Failed walk_resources");
 
-				kfree(data.pointer);
-			}
+	return err;
+}
 
-//            acpi_os_free(buffer.pointer);
+static int acpi_sleep_test(void)
+{
+	int err = 0;
+	acpi_status status;
+	u32 i;
+	u8 type_a, type_b;
+	prk_alert("TEST -- acpi_get_sleep_type_data ");
+
+	for (i = 0; i < ACPI_S_STATE_COUNT; ++i) {
+		status = acpi_get_sleep_type_data(i, &type_a, &type_b);
+		if (ACPI_SUCCESS(status)) {
+			prk_info("get_sleep_type_data S%d a:%d b:%d",
+				i, type_a, type_b);
+		} else if (status != AE_NOT_FOUND) {
+			err |= 1;
 		}
-#endif
+	}
+
+	return err;
+}
 
-		printk(KERN_ALERT
-		       "-- IOCTL ACPI tests Complete -- Iteration:%d\n",
-		       test_iteration);
+static int acpi_test_register(void)
+{
+	int i, err = 0;
+	u32 val;
+	acpi_status status;
 
-		break;
+	prk_alert("TEST -- acpi_read_bit_register");
+	/*
+	 * ACPICA: Remove obsolete Flags parameter.
+	 * http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;
+	 * a=commitdiff;h=d8c71b6d3b21cf21ad775e1cf6da95bf87bd5ad4
+	 *
+	 * ACPICA: Rename ACPI bit register access functions
+	 * http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/
+	 * commit/?id=50ffba1bd3120b069617455545bc27bcf3cf7579
+	 */
+	for (i = 0; i < ACPI_NUM_BITREG; ++i) {
+		status = acpi_read_bit_register(i, &val);
+		err |= acpi_failure(status, "acpi_read_bit_register");
+		if (ACPI_SUCCESS(status))
+			prk_alert("get register: %02x val: %04x", i, val);
 	}
 
-	return 0;
+	return err;
 }
 
 static acpi_status ltp_get_dev_callback(acpi_handle obj, u32 depth,
-					void *context, void **ret)
+	void *context, void **ret)
 {
 	char *name = context;
 	char fullname[20];
@@ -521,154 +486,163 @@ static acpi_status ltp_get_dev_callback(acpi_handle obj, u32 depth,
 	 * separately in PCI space.
 	 */
 	sprintf(fullname, "%s SBA", name);
-	printk(KERN_ALERT "get_dev_callback SBA name %s \n", fullname);
+	prk_info("get_dev_callback SBA name %s", fullname);
 	sprintf(fullname, "%s IOC", name);
-	printk(KERN_ALERT "get_dev_callback IOC name %s \n", fullname);
+	prk_info("get_dev_callback IOC name %s", fullname);
 
 	return 0;
 }
 
-/**
- * acpi_bus_notify
- * ---------------
- * Callback for all 'system-level' device notifications (values 0x00-0x7F).
- */
-static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
+static int acpi_test_dev_callback(void)
 {
+	acpi_status status;
+	prk_alert("TEST -- acpi_get_devices ");
+	status = acpi_get_devices(NULL, ltp_get_dev_callback, "LTP0001", NULL);
+	return acpi_failure(status, "acpi_get_devices");
+}
 
-	printk(KERN_ALERT "Register ACPI Bus Notify callback function \n");
+static int current_test_case;
+static int test_result;
 
+static void device_release(struct device *dev)
+{
+	prk_info("device released");
 }
 
-static u32 acpi_ec_gpe_handler(void *context)
+static struct device tdev = {
+	.init_name	= ACPI_TEST_NAME,
+	.release	= device_release,
+};
+
+/* print test result to sysfs file */
+static ssize_t sys_result(struct device *dev,
+	struct device_attribute *attr, char *buf)
 {
-	printk(KERN_ALERT "Register ACPI ec_gpe_handler callback function \n");
-	return 1;
+	return scnprintf(buf, PAGE_SIZE, "%d\n", test_result);
 }
+static DEVICE_ATTR(result, S_IRUSR, sys_result, NULL);
 
-static acpi_status acpi_ec_io_ports(struct acpi_resource *resource,
-				    void *context)
+/* print found device description */
+static ssize_t sys_str(struct device *dev,
+	struct device_attribute *attr, char *buf)
 {
-	return 0;
+	return scnprintf(buf, PAGE_SIZE, "%s",
+		(str_obj_result) ? str_obj_result : "null");
 }
+static DEVICE_ATTR(str, S_IRUSR, sys_str, NULL);
 
-#if 0
-static acpi_status acpi_ec_space_handler(u32 function,
-					 acpi_physical_address address,
-					 u32 bit_width,
-					 acpi_integer * value,
-					 void *handler_context,
-					 void *region_context)
+/* print found device's sysfs path */
+static ssize_t sys_path(struct device *dev,
+	struct device_attribute *attr, char *buf)
 {
-	int result = 0;
-	struct acpi_ec *ec = NULL;
-	u32 temp = 0;
-
-	ACPI_FUNCTION_TRACE("acpi_ec_space_handler");
-
-	if ((address > 0xFF) || (bit_width != 8) || !value || !handler_context)
-		return_VALUE(AE_BAD_PARAMETER);
-
-	ec = (struct acpi_ec *)handler_context;
-
-	switch (function) {
-	case ACPI_READ:
-		result = 0;
-		*value = (acpi_integer) temp;
-		break;
-	case ACPI_WRITE:
-		result = 0;
-		break;
-	default:
-		result = -EINVAL;
-		break;
-	}
-
-	switch (result) {
-	case -EINVAL:
-		return_VALUE(AE_BAD_PARAMETER);
-		break;
-	case -ENODEV:
-		return_VALUE(AE_NOT_FOUND);
-		break;
-	case -ETIME:
-		return_VALUE(AE_TIME);
-		break;
-	default:
-		return_VALUE(AE_OK);
-	}
-
+	return scnprintf(buf, PAGE_SIZE, "%s",
+		(sysfs_path) ? sysfs_path : "null");
 }
+static DEVICE_ATTR(path, S_IRUSR, sys_path, NULL);
 
-static acpi_status acpi_ec_space_setup(acpi_handle region_handle,
-				       u32 function,
-				       void *handler_context,
-				       void **return_context)
+static ssize_t sys_tcase(struct device *dev,
+	struct device_attribute *attr,  const char *buf, size_t count)
 {
-	/*
-	 * The EC object is in the handler context and is needed
-	 * when calling the acpi_ec_space_handler.
-	 */
-	*return_context = handler_context;
+	sscanf(buf, "%d", &current_test_case);
+	prk_info("test-case %d", current_test_case);
+
+	switch (current_test_case) {
+	case ACPI_INIT:
+		test_result = acpi_init();
+	break;
+	case ACPI_TRAVERSE:
+		test_result = acpi_traverse_from_root();
+	break;
+	case ACPI_NOTIFY_HANDLER:
+		test_result = acpi_test_notify_handler();
+	break;
+	case ACPI_EVENT_HANDLER:
+		test_result = acpi_test_event_handler();
+	break;
+	case ACPI_GLOBAL_LOCK:
+		test_result = acpi_global_lock();
+	break;
+	case ACPI_TEST_BUS:
+		test_result = acpi_test_bus();
+	break;
+	case ACPI_TEST_RESOURCES:
+		test_result = acpi_test_resources();
+	break;
+	case ACPI_SLEEP_TEST:
+		test_result = acpi_sleep_test();
+	break;
+	case ACPI_TEST_REGISTER:
+		test_result = acpi_test_register();
+	break;
+	case ACPI_TEST_DEV_CALLBACK:
+		test_result = acpi_test_dev_callback();
+	break;
+	}
 
-	return AE_OK;
+	return count;
 }
-#endif
+static DEVICE_ATTR(tcase, S_IWUSR, NULL, sys_tcase);
 
 int init_module(void)
 {
-	int result;
-
-	printk(KERN_ALERT "ltpdev_init_module \n");
-
-	result = register_blkdev(ltp_acpi_major, LTP_ACPI_DEV_NAME);
-
-	printk(KERN_ALERT "LTP ACPI: register_blkdev result=%d major %d\n",
-	       result, ltp_acpi_major);
+	int err = 0;
+	prk_info("Starting module");
 
-	if (result < 0) {
-		printk(KERN_ALERT "LTP ACPI: can't get major %d\n",
-		       ltp_acpi_major);
-		return result;
+	err = device_register(&tdev);
+	if (err) {
+		prk_err("Unable to register device");
+		goto err0;
 	}
-//    if (ltp_acpi_major == 0)
-//      ltp_acpi_major = result; /* dynamic */
+	prk_info("device registered");
 
-	gd_ptr = kmalloc(sizeof(struct gendisk *), GFP_KERNEL);
-
-	if (!gd_ptr) {
-		printk(KERN_ALERT "ERROR getting memory !!!\n");
-		return 0;
+	err = device_create_file(&tdev, &dev_attr_result);
+	if (err) {
+		prk_err("Can't create sysfs file 'result'");
+		goto err1;
 	}
 
-	gd_ptr = alloc_disk(1);
-
-	printk(KERN_ALERT "gd_ptr after alloc = %p \n", gd_ptr);
-
-	gd_ptr->major = ltp_acpi_major;
-	gd_ptr->first_minor = 0;
-	gd_ptr->fops = &blkops;
-//    gd_ptr->minor_shift = MINOR_SHIFT_BITS;
-	gd_ptr->driverfs_dev = NULL;
-//    gd_ptr->disk_de = NULL;
-	gd_ptr->flags = genhd_flags;
+	err = device_create_file(&tdev, &dev_attr_str);
+	if (err) {
+		prk_err("Can't create sysfs file 'str'");
+		goto err2;
+	}
 
-	sprintf(gd_ptr->disk_name, LTP_ACPI_DEV_NAME);
+	err = device_create_file(&tdev, &dev_attr_tcase);
+	if (err) {
+		prk_err(": Can't create sysfs file 'tc'");
+		goto err3;
+	}
 
-	add_disk(gd_ptr);
+	err = device_create_file(&tdev, &dev_attr_path);
+	if (err) {
+		prk_err(": Can't create sysfs file 'path'");
+		goto err4;
+	}
 
 	return 0;
+
+err4:
+	device_remove_file(&tdev, &dev_attr_tcase);
+err3:
+	device_remove_file(&tdev, &dev_attr_str);
+err2:
+	device_remove_file(&tdev, &dev_attr_result);
+err1:
+	device_unregister(&tdev);
+err0:
+	return err;
 }
 
 void cleanup_module(void)
 {
+	prk_info("Unloading module\n");
 
-	printk(KERN_ALERT "Exiting module and cleaning up \n");
-
-	put_disk(gd_ptr);
-
-	del_gendisk(gd_ptr);
-
-	unregister_blkdev(ltp_acpi_major, LTP_ACPI_DEV_NAME);
+	kfree(str_obj_result);
+	kfree(sysfs_path);
 
+	device_remove_file(&tdev, &dev_attr_result);
+	device_remove_file(&tdev, &dev_attr_str);
+	device_remove_file(&tdev, &dev_attr_tcase);
+	device_remove_file(&tdev, &dev_attr_path);
+	device_unregister(&tdev);
 }
-- 
1.7.1



--===============6477219976036802788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
--===============6477219976036802788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6477219976036802788==--
