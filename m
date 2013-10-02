Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1VRIVT-0007wV-UQ
	for ltp-list@lists.sourceforge.net; Wed, 02 Oct 2013 09:14:08 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VRIVR-0003vO-AN
	for ltp-list@lists.sourceforge.net; Wed, 02 Oct 2013 09:14:07 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r929DwQ8008846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 2 Oct 2013 09:13:59 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r929DtZ8021149
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 2 Oct 2013 09:13:58 GMT
Received: from abhmt117.oracle.com (abhmt117.oracle.com [141.146.116.69])
	by userz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r929Dsfi020204
	for <ltp-list@lists.sourceforge.net>; Wed, 2 Oct 2013 09:13:54 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed,  2 Oct 2013 13:13:32 +0400
Message-Id: <1380705212-7200-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH v2] device-drivers: acpi: update for Linux kernel
	2.6.37+
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4058022629293028761=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com, Alexey Kodanev <alexey.kodanev@oracle.com>

--===============4058022629293028761==

User-space program determines block device major number using sysfs.
User-space program loads/unloads kernel module.
acpi_get_object_info external interface updated.
ACPI bit register access function renamed.
acpi_bus_get_power() changed to acpi_bus_update_power()
Added block device queue to fix NULL dereference.
Added acpi functions return status checks.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/kernel/device-drivers/acpi/.gitignore    |    8 +
 testcases/kernel/device-drivers/acpi/LtpAcpi.h     |    6 +-
 testcases/kernel/device-drivers/acpi/LtpAcpiCmds.c |  439 +++++++++-----------
 testcases/kernel/device-drivers/acpi/LtpAcpiMain.c |  169 +++++---
 testcases/kernel/device-drivers/acpi/Makefile      |   43 +-
 testcases/kernel/device-drivers/acpi/ltpacpi.sh    |   54 ---
 6 files changed, 337 insertions(+), 382 deletions(-)
 create mode 100644 testcases/kernel/device-drivers/acpi/.gitignore
 delete mode 100755 testcases/kernel/device-drivers/acpi/ltpacpi.sh

diff --git a/testcases/kernel/device-drivers/acpi/.gitignore b/testcases/kernel/device-drivers/acpi/.gitignore
new file mode 100644
index 0000000..29e20d7
--- /dev/null
+++ b/testcases/kernel/device-drivers/acpi/.gitignore
@@ -0,0 +1,8 @@
+/LtpAcpiCmds.ko
+/LtpAcpiMain
+/*.mod.c
+/modules.order
+/.tmp_versions
+/.*.ko
+/.*.cmd
+/Module.symvers
diff --git a/testcases/kernel/device-drivers/acpi/LtpAcpi.h b/testcases/kernel/device-drivers/acpi/LtpAcpi.h
index 5c0c37b..ce2d4be 100644
--- a/testcases/kernel/device-drivers/acpi/LtpAcpi.h
+++ b/testcases/kernel/device-drivers/acpi/LtpAcpi.h
@@ -38,7 +38,7 @@
 #define ACPI_LTP_TEST_STATUS_ONLINE	    	0x01
 #define ACPI_LTP_TEST_STATUS_UNKNOWN		0xFF
 #define _COMPONENT		ACPI_LTP_TEST_COMPONENT
-#define ACPI_TLP_TEST_MODULE_NAME		("acpi_ltp_test")
+#define ACPI_TLP_TEST_MODULE_NAME		"ltp_acpi_test"
 #define ACPI_NS_SYSTEM_BUS          "_SB_"
 #define ACPI_BATTERY_FORMAT_BIF	"NNNNNNNNNSSSS"
 #define ACPI_BATTERY_FORMAT_BST	"NNNN"
@@ -63,7 +63,7 @@
 #define ACPI_TYPE_DEBUG_OBJECT          0x10
 
 #define ACPI_TYPE_EXTERNAL_MAX          0x10
-#define LTPMAJOR                        252
+
 
 /* Use 'k' as magic number */
 #define LTPACPI_IOC_MAGIC  'k'
@@ -92,6 +92,6 @@ typedef enum ltpdev_ioctl_cmds_s {
 	LTP_IOCTL_NUMBER = 0x5500
 } ltpdev_ioctl_cmds_t;
 
+int LTPMAJOR;
 // define the ioctl cmds
 #define LTPDEV_CMD       _IOR( LTPMAJOR, LTP_IOCTL_NUMBER, ltpdev_cmd_t **)
-
diff --git a/testcases/kernel/device-drivers/acpi/LtpAcpiCmds.c b/testcases/kernel/device-drivers/acpi/LtpAcpiCmds.c
index 26fcc15..be88117 100644
--- a/testcases/kernel/device-drivers/acpi/LtpAcpiCmds.c
+++ b/testcases/kernel/device-drivers/acpi/LtpAcpiCmds.c
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
@@ -47,20 +46,28 @@
 #define ACPI_EC_UDELAY_GLK	1000	/* Wait 1ms max. to get global lock */
 #endif
 
+#define prk_err(fmt, ...) \
+	pr_err(ACPI_TLP_TEST_MODULE_NAME ": " fmt, ##__VA_ARGS__)
+#define prk_alert(fmt, ...) \
+	pr_alert(ACPI_TLP_TEST_MODULE_NAME ": " fmt, ##__VA_ARGS__)
+#define prk_info(fmt, ...) \
+	pr_info(ACPI_TLP_TEST_MODULE_NAME ": " fmt, ##__VA_ARGS__)
+
 static int ltpdev_open(struct block_device *bdev, fmode_t mode);
 static int ltpdev_release(struct gendisk *disk, fmode_t mode);
 static int ltpdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
-			unsigned long arg);
+	unsigned long arg);
 
 static u32 ltp_test_sleep_button_ev_handler(void *context);
 static u32 ltp_test_power_button_ev_handler(void *context);
-static u32 acpi_ec_gpe_handler(void *context);
+static u32 acpi_ec_gpe_handler(acpi_handle gpe_device, u32 gpe_number, void *context);
 
 static void acpi_bus_notify(acpi_handle handle, u32 type, void *data);
 static acpi_status ltp_get_dev_callback(acpi_handle obj, u32 depth,
-					void *context, void **ret);
+	void *context, void **ret);
 static acpi_status acpi_ec_io_ports(struct acpi_resource *resource,
-				    void *context);
+	void *context);
+
 #if 0
 static acpi_status acpi_ec_space_setup(acpi_handle region_handle,
 				       u32 function,
@@ -80,63 +87,65 @@ release:ltpdev_release,
 ioctl:	ltpdev_ioctl,
 };
 
-int ltp_acpi_major = LTPMAJOR;
+ACPI_MODULE_NAME("LTP_acpi")
+
 int test_iteration = 0;
 
 static char genhd_flags = 0;
 static struct gendisk *gd_ptr;
 
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
-
 MODULE_AUTHOR("Martin Ridgeway <mridge@us.ibm.com>");
+MODULE_AUTHOR("Copyright (c) 2013 Oracle and/or its affiliates");
 MODULE_DESCRIPTION(ACPI_LTP_TEST_DRIVER_NAME);
 MODULE_LICENSE("GPL");
 
 /*
  * Device operations for the virtual ACPI devices
  */
-
 extern struct acpi_device *acpi_root;
 
 static int ltpdev_open(struct block_device *dev, fmode_t mode)
 {
-	printk(KERN_ALERT "ltpdev_open \n");
+	prk_alert("ltpdev_open \n");
 	return 0;
 }
 
 static int ltpdev_release(struct gendisk *disk, fmode_t mode)
 {
 
-	printk(KERN_ALERT "ltpdev_release \n");
+	prk_alert("ltpdev_release \n");
 	return 0;
 }
 
 static u32 ltp_test_power_button_ev_handler(void *context)
 {
-	printk(KERN_ALERT "ltp_test_power_button_ev_handler \n");
+	prk_alert("ltp_test_power_button_ev_handler \n");
 	return 1;
 }
 
 static u32 ltp_test_sleep_button_ev_handler(void *context)
 {
-	printk(KERN_ALERT "ltp_test_sleep_button_ev_handler \n");
+	prk_alert("ltp_test_sleep_button_ev_handler \n");
 	return 1;
 }
 
+static int acpi_failure(acpi_status *status, int *err, const char *name)
+{
+	if (status == NULL ||  err == NULL)
+		return 1;
+
+	if (ACPI_FAILURE(*status)) {
+		ACPI_EXCEPTION((AE_INFO, *status, name));
+		*err = 1;
+		return 1;
+	}
+	return 0;
+}
+
 static int ltpdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 			unsigned long arg)
 {
 	acpi_status status;
-//      acpi_handle        sys_bus_handle;
 	acpi_handle start_handle = 0;
 	acpi_handle parent_handle;
 	acpi_handle child_handle;
@@ -145,6 +154,7 @@ static int ltpdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 	struct acpi_ec *ec;
 	struct acpi_device *device;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_device_info *dev_info;
 
 #if 0
 	acpi_handle tmp_handle;
@@ -162,45 +172,61 @@ static int ltpdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 	u32 i, bm_status;
 	u8 type_a, type_b;
 	u32 global_lock = 0;
-	int state = 0;
-
-    /*****************************************************************************/
+	int state = 0, err = 0;
 
-	printk(KERN_ALERT "ltpdev_ioctl \n");
-	switch (cmd) {
-	case LTPDEV_CMD:
-
-		parent_handle = start_handle;
-		child_handle = 0;
-		level = 1;
-		test_iteration++;
-
-		printk(KERN_ALERT
-		       "-- IOCTL called to start ACPI tests -- Iteration:%d\n",
-		       test_iteration);
+	if (cmd != (LTPDEV_CMD))
+		return 0;
 
-		printk(KERN_ALERT "TEST -- acpi_get_handle \n");
+	/**********************************************************************/
 
-		status = acpi_get_handle(0, ACPI_NS_SYSTEM_BUS, &parent_handle);
+	prk_alert("ltpdev_ioctl, cmd\n");
 
-		printk(KERN_ALERT "TEST -- acpi_get_object_info \n");
+	parent_handle = start_handle;
+	child_handle = 0;
+	level = 1;
+	test_iteration++;
 
-		status = acpi_get_object_info(parent_handle, &buffer);
+	prk_alert("-- IOCTL called to start ACPI tests -- Iteration:%d\n",
+	         test_iteration);
 
-		printk(KERN_ALERT "TEST -- acpi_get_next_object \n");
+	prk_alert("TEST -- acpi_get_handle \n");
+	status = acpi_get_handle(NULL, "\\_SB", &parent_handle);
+	acpi_failure(&status, &err, "acpi_get_handle");
 
-		status = acpi_get_next_object(ACPI_TYPE_ANY, parent_handle,
-					      child_handle, &next_child_handle);
+	prk_alert("TEST -- acpi_get_object_info \n");
+	/*
+	 * ACPICA: Major update for acpi_get_object_info external interface
+	 * http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/
+	 * commit/?id=15b8dd53f5ffaf8e2d9095c423f713423f576c0f
+	 */
+	status = acpi_get_object_info(parent_handle, &dev_info);
+	if (!acpi_failure(&status, &err, "acpi_object_info failed")) {
+		prk_alert("ACPI object name %4.4s, type %d",
+			(char *)&dev_info->name,
+			dev_info->type);
+		kfree(dev_info);
+	}
 
-		printk(KERN_ALERT "TEST -- acpi_get_parent \n");
+	prk_alert("TEST -- acpi_get_next_object \n");
+	status = acpi_get_next_object(ACPI_TYPE_DEVICE, parent_handle,
+		child_handle, &next_child_handle);
 
-		status = acpi_get_parent(parent_handle, &parent_handle);
+	if (!acpi_failure(&status, &err, "acpi_get_next_object"))
+		child_handle = next_child_handle;
 
-		printk(KERN_ALERT "TEST -- acpi_evaluate_object \n");
+	status = acpi_get_object_info(next_child_handle, &dev_info);
+	if (!acpi_failure(&status, &err, "acpi_object_info failed")) {
+		prk_alert("ACPI object name %4.4s, type %d",
+			(char *)&dev_info->name,
+			dev_info->type);
+		kfree(dev_info);
+	}
 
-		status = acpi_evaluate_object(parent_handle, "_ON", NULL, NULL);
+	prk_alert("TEST -- acpi_evaluate_object \n");
+	status = acpi_evaluate_object(parent_handle, "_INI", NULL, NULL);
+	acpi_failure(&status, &err, "acpi_evaluate_object");
 
-		printk(KERN_ALERT "TEST -- acpi_get_table \n");
+//		printk(KERN_ALERT "TEST -- acpi_get_table \n");
 
 //        status = acpi_get_table(ACPI_TABLE_RSDP, 1, &dsdt);
 //        status = acpi_get_table(ACPI_TABLE_DSDT, 1, &dsdt);
@@ -218,92 +244,87 @@ static int ltpdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 					    (struct acpi_table_header **)&dsdt);
 #endif
 
-		printk(KERN_ALERT "TEST -- acpi_install_notify_handler \n");
 
-		status =
-		    acpi_install_notify_handler(ACPI_ROOT_OBJECT,
-						ACPI_SYSTEM_NOTIFY,
-						&acpi_bus_notify, NULL);
+	prk_alert("TEST -- acpi_get_parent \n");
+	status = acpi_get_parent(parent_handle, &parent_handle);
+	acpi_failure(&status, &err, "acpi_get_parent failed");
+
+	status = acpi_get_object_info(parent_handle, &dev_info);
+	if (!acpi_failure(&status, &err, "acpi_object_info failed")) {
+		prk_alert("ACPI object name %4.4s, type %d",
+			(char *)&dev_info->name,
+			dev_info->type);
+			kfree(dev_info);
+	}
 
-		printk(KERN_ALERT "TEST -- acpi_remove_notify_handler \n");
+	prk_alert("TEST -- acpi_install_notify_handler\n");
 
-		status =
-		    acpi_remove_notify_handler(ACPI_ROOT_OBJECT,
-					       ACPI_SYSTEM_NOTIFY,
-					       &acpi_bus_notify);
+	status = acpi_install_notify_handler(next_child_handle,
+		ACPI_SYSTEM_NOTIFY, &acpi_bus_notify, NULL);
+	acpi_failure(&status, &err, "acpi_install_notify_handler");
 
-		printk(KERN_ALERT
-		       "TEST -- acpi_install_fixed_event_handler \n");
-		status =
-		    acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
-						     ltp_test_power_button_ev_handler,
-						     NULL);
-		if (status)
-			printk(KERN_ALERT
-			       "Failed installing fixed event handler \n");
+	prk_alert("TEST -- acpi_remove_notify_handler \n");
+	status = acpi_remove_notify_handler(next_child_handle,
+		ACPI_SYSTEM_NOTIFY, &acpi_bus_notify);
+	acpi_failure(&status, &err, "acpi_remove_notify_handler");
 
-		printk(KERN_ALERT "TEST -- acpi_remove_fixed_event_handler \n");
-		status =
-		    acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
-						    ltp_test_power_button_ev_handler);
-		if (status)
-			printk(KERN_ALERT
-			       "Failed removing fixed event handler \n");
+	prk_alert("TEST -- acpi_install_fixed_event_handler \n");
+	status =  acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
+		ltp_test_power_button_ev_handler, NULL);
+	acpi_failure(&status, &err, "failed installing fixed event handler");
 
-		printk(KERN_ALERT
-		       "TEST -- acpi_install_fixed_event_handler \n");
-		status =
-		    acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
-						     ltp_test_sleep_button_ev_handler,
-						     NULL);
-		if (status)
-			printk(KERN_ALERT
-			       "Failed installing fixed event handler \n");
+	prk_alert("TEST -- acpi_remove_fixed_event_handler \n");
+	status = acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
+		ltp_test_power_button_ev_handler);
+	acpi_failure(&status, &err, "failed removing fixed event handler");
 
-		printk(KERN_ALERT "TEST -- acpi_remove_fixed_event_handler \n");
-		status =
-		    acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
-						    ltp_test_sleep_button_ev_handler);
-		if (status)
-			printk(KERN_ALERT
-			       "Failed removing fixed event handler \n");
+	prk_alert("TEST -- acpi_install_fixed_event_handler \n");
+	status = acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
+		ltp_test_sleep_button_ev_handler, NULL);
+	acpi_failure(&status, &err, "failed installing fixed event handler");
 
-		printk(KERN_ALERT "TEST -- acpi_acquire_global_lock \n");
-		status =
-		    acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &global_lock);
+	prk_alert("TEST -- acpi_remove_fixed_event_handler \n");
+	status = acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
+		ltp_test_sleep_button_ev_handler);
+	acpi_failure(&status, &err, "removing fixed event handler");
 
-		printk(KERN_ALERT "TEST -- acpi_release_global_lock \n");
-		status = acpi_release_global_lock(global_lock);
+	prk_alert("TEST -- acpi_acquire_global_lock \n");
+	status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &global_lock);
+	acpi_failure(&status, &err, "acpi_acquire_global_lock");
 
-		printk(KERN_ALERT "TEST -- acpi_bus_get_device \n");
+	prk_alert("TEST -- acpi_release_global_lock \n");
+	status = acpi_release_global_lock(global_lock);
+	acpi_failure(&status, &err, "acpi_release_global_lock");
 
-		status = acpi_bus_get_device(next_child_handle, &device);
+	prk_alert("TEST -- acpi_bus_get_device \n");
+	status = acpi_bus_get_device(next_child_handle, &device);
+	acpi_failure(&status, &err, "acpi_bus_get_device");
 
 #if 0
 		printk(KERN_ALERT "TEST -- acpi_bus_find_driver \n");
 		status = acpi_bus_find_driver(device);
 #endif
 
-		printk(KERN_ALERT "TEST -- acpi_bus_get_power \n");
-		status = acpi_bus_get_power(next_child_handle, &state);
-		if (status)
-			printk(KERN_ALERT "Error reading power state \n");
-
-		printk(KERN_ALERT "TEST -- acpi_driver_data \n");
+	prk_alert("TEST -- acpi_bus_update_power \n");
+	status = acpi_bus_update_power(next_child_handle, &state);
+	if (!acpi_failure(&status, &err, "error reading power state"))
+		prk_info("acpi bus power state is %d\n", state);
 
-		ec = acpi_driver_data(device);
+	prk_alert("TEST -- acpi_driver_data \n");
 
-		if (!ec) {
-			printk(KERN_ALERT "Failure getting device data \n");
-		} else {
-
-			printk(KERN_ALERT
+	ec = acpi_driver_data(device);
+	if (!ec) {
+		err = 1;
+		prk_alert("Failure getting device data \n");
+	} else {
+/*			printk(KERN_ALERT
 			       "TEST -- acpi_install_gpe_handler \n");
 			ec->status_addr = ec->command_addr;
 			status =
 			    acpi_install_gpe_handler(device, ec->gpe_bit,
 						     ACPI_GPE_EDGE_TRIGGERED,
 						     &acpi_ec_gpe_handler, ec);
+*/
 /*
             status = acpi_install_address_space_handler (ACPI_ROOT_OBJECT,
                     ACPI_ADR_SPACE_EC, &acpi_ec_space_handler,
@@ -316,44 +337,28 @@ static int ltpdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
             acpi_remove_address_space_handler(ACPI_ROOT_OBJECT,
                 ACPI_ADR_SPACE_EC, &acpi_ec_space_handler);
 */
+/*
 			printk(KERN_ALERT "TEST -- acpi_remove_gpe_handler \n");
 			acpi_remove_gpe_handler(device, ec->gpe_bit,
 						&acpi_ec_gpe_handler);
-		}
+*/
+	}
 
-		printk(KERN_ALERT "TEST -- acpi_get_current_resources \n");
-		status = acpi_get_current_resources(next_child_handle, &buffer);
+	prk_alert("TEST -- acpi_get_current_resources \n");
+	status = acpi_get_current_resources(next_child_handle, &buffer);
+	acpi_failure(&status, &err, "failed get_current_resources");
 
-		if (status) {
-			printk(KERN_ALERT "Failed get_current_resources %d\n",
-			       status);
-		}
 #ifdef ACPI_FUTURE_USAGE
-		printk(KERN_ALERT "TEST -- acpi_get_possible_resources \n");
-		status =
-		    acpi_get_possible_resources(next_child_handle, &buffer);
-
-		if (status) {
-			printk(KERN_ALERT "Failed get_possible_resources %d\n",
-			       status);
-		}
+	printk(KERN_ALERT "TEST -- acpi_get_possible_resources \n");
+	status = acpi_get_possible_resources(next_child_handle, &buffer);
+	acpi_failure(&status, &err, "get_possible_resources");
 #endif
 
-		printk(KERN_ALERT "TEST -- acpi_walk_resources \n");
-		status = acpi_walk_resources(ec->handle, METHOD_NAME__CRS,
-					     acpi_ec_io_ports, ec);
-
-		if (status) {
-			printk(KERN_ALERT "Failed walk_resources %d\n", status);
-		}
+	prk_alert("TEST -- acpi_walk_resources \n");
+	status = acpi_walk_resources(next_child_handle, METHOD_NAME__CRS,
+		acpi_ec_io_ports, NULL);
 
-		printk(KERN_ALERT "TEST -- acpi_evaluate_integer \n");
-		status =
-		    acpi_evaluate_integer(ec->handle, "_GPE", NULL,
-					  &ec->gpe_bit);
-		if (status)
-			printk(KERN_ALERT
-			       "Error obtaining GPE bit assignment\n");
+	acpi_failure(&status, &err, "Failed walk_resources\n");
 
 #if 0
 		printk(KERN_ALERT "TEST -- acpi_get_timer \n");
@@ -383,40 +388,35 @@ static int ltpdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 		}
 #endif
 
-		for (i = 0; i < ACPI_S_STATE_COUNT; i++) {
-			printk(KERN_ALERT
-			       "TEST -- acpi_get_sleep_type_data \n");
-			status = acpi_get_sleep_type_data(i, &type_a, &type_b);
+	for (i = 0; i < ACPI_S_STATE_COUNT; i++) {
+		prk_alert("TEST -- acpi_get_sleep_type_data \n");
+		status = acpi_get_sleep_type_data(i, &type_a, &type_b);
 
-			if (status) {
-				printk(KERN_ALERT
-				       "Failed get_sleep_type_data %d\n",
-				       status);
-			} else {
-				printk(KERN_ALERT
-				       "get_sleep_type_data [%d] type_a:%d type_b:%d\n",
-				       i, type_a, type_b);
-			}
+		if (!acpi_failure(&status, &err, "get_sleep_type_data")) {
+			prk_info("get_sleep_type_data [%d] a:%d b:%d\n",
+				i, type_a, type_b);
 		}
+	}
 
-		printk(KERN_ALERT "TEST -- acpi_get_register \n");
-
-/*
- * ACPICA: Remove obsolete Flags parameter.
- * http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=d8c71b6d3b21cf21ad775e1cf6da95bf87bd5ad4
- *
- */
-		acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS, &bm_status);
+	prk_alert("TEST -- acpi_get_register \n");
 
-		if (!bm_status) {
-			printk(KERN_ALERT "Failed get_register [%d]\n",
-			       bm_status);
-		} else {
-			printk(KERN_ALERT "get_register [%d] \n", bm_status);
-		}
+	/*
+	 * ACPICA: Remove obsolete Flags parameter.
+	 * http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;
+	 * a=commitdiff;h=d8c71b6d3b21cf21ad775e1cf6da95bf87bd5ad4
+	 *
+	 * ACPICA: Rename ACPI bit register access functions
+	 * http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/
+	 * commit/?id=50ffba1bd3120b069617455545bc27bcf3cf7579
+	 */
+	acpi_read_bit_register(ACPI_BITREG_BUS_MASTER_STATUS, &bm_status);
 
-//        Puts system to sleep, permenately !!!
-//        status = acpi_enter_sleep_state(ACPI_STATE_S1);
+	if (!bm_status) {
+		prk_alert("Failed get_register [%d]\n",
+		       bm_status);
+	} else {
+		prk_alert("get_register [%d] \n", bm_status);
+	}
 
 #if 0
 		printk(KERN_ALERT "TEST -- acpi_get_system_info \n");
@@ -438,26 +438,9 @@ static int ltpdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 		}
 #endif
 
-		printk(KERN_ALERT "TEST -- acpi_get_devices \n");
-		status =
-		    acpi_get_devices(NULL, ltp_get_dev_callback, "LTP0001",
-				     NULL);
-
-		if (status) {
-			printk(KERN_ALERT "Failed get_devices %d\n", status);
-		}
-//        status = acpi_os_create_semaphore(1, 1, &tmp_handle);
-
-		if (status) {
-			printk(KERN_ALERT "Failed os_create_semaphore %d\n",
-			       status);
-		} else {
-			printk(KERN_ALERT
-			       "os_create_semaphore OK, no deleteing %d\n",
-			       status);
-//            acpi_os_delete_semaphore(tmp_handle);
-
-		}
+	prk_alert("TEST -- acpi_get_devices \n");
+	status = acpi_get_devices(NULL, ltp_get_dev_callback, "LTP0001", NULL);
+	acpi_failure(&status, &err, "acpi_get_devices");
 
 #if 0
 		printk(KERN_ALERT "TEST -- acpi_get_system_info \n");
@@ -499,14 +482,10 @@ static int ltpdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 		}
 #endif
 
-		printk(KERN_ALERT
-		       "-- IOCTL ACPI tests Complete -- Iteration:%d\n",
-		       test_iteration);
+	prk_alert("-- IOCTL ACPI tests Complete -- Iteration:%d\n",
+		test_iteration);
 
-		break;
-	}
-
-	return 0;
+	return err;
 }
 
 static acpi_status ltp_get_dev_callback(acpi_handle obj, u32 depth,
@@ -540,7 +519,7 @@ static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
 
 }
 
-static u32 acpi_ec_gpe_handler(void *context)
+static u32 acpi_ec_gpe_handler(acpi_handle gpe_device, u32 gpe_number, void *context)
 {
 	printk(KERN_ALERT "Register ACPI ec_gpe_handler callback function \n");
 	return 1;
@@ -617,42 +596,36 @@ static acpi_status acpi_ec_space_setup(acpi_handle region_handle,
 
 int init_module(void)
 {
-	int result;
-
-	printk(KERN_ALERT "ltpdev_init_module \n");
-
-	result = register_blkdev(ltp_acpi_major, LTP_ACPI_DEV_NAME);
+	prk_alert("ltpdev_init_module\n");
 
-	printk(KERN_ALERT "LTP ACPI: register_blkdev result=%d major %d\n",
-	       result, ltp_acpi_major);
+	LTPMAJOR = register_blkdev(0, LTP_ACPI_DEV_NAME);
 
-	if (result < 0) {
-		printk(KERN_ALERT "LTP ACPI: can't get major %d\n",
-		       ltp_acpi_major);
-		return result;
+	if (LTPMAJOR < 0) {
+		prk_alert("LTP ACPI: can't get major %d\n",
+			LTPMAJOR);
+		return LTPMAJOR;
 	}
-//    if (ltp_acpi_major == 0)
-//      ltp_acpi_major = result; /* dynamic */
+
+	prk_alert("register_blkdev major %d\n",
+		LTPMAJOR);
 
 	gd_ptr = kmalloc(sizeof(struct gendisk *), GFP_KERNEL);
 
 	if (!gd_ptr) {
-		printk(KERN_ALERT "ERROR getting memory !!!\n");
+		prk_alert("ERROR getting memory !!!\n");
 		return 0;
 	}
 
 	gd_ptr = alloc_disk(1);
 
-	printk(KERN_ALERT "gd_ptr after alloc = %p \n", gd_ptr);
+	prk_alert("gd_ptr after alloc = %p \n", gd_ptr);
 
-	gd_ptr->major = ltp_acpi_major;
+	gd_ptr->major = LTPMAJOR;
 	gd_ptr->first_minor = 0;
 	gd_ptr->fops = &blkops;
-//    gd_ptr->minor_shift = MINOR_SHIFT_BITS;
 	gd_ptr->driverfs_dev = NULL;
-//    gd_ptr->disk_de = NULL;
 	gd_ptr->flags = genhd_flags;
-
+	gd_ptr->queue = blk_alloc_queue(GFP_KERNEL);
 	sprintf(gd_ptr->disk_name, LTP_ACPI_DEV_NAME);
 
 	add_disk(gd_ptr);
@@ -662,13 +635,13 @@ int init_module(void)
 
 void cleanup_module(void)
 {
+	prk_alert("Exiting module and cleaning up \n");
 
-	printk(KERN_ALERT "Exiting module and cleaning up \n");
-
-	put_disk(gd_ptr);
+	blk_cleanup_queue(gd_ptr->queue);
 
 	del_gendisk(gd_ptr);
 
-	unregister_blkdev(ltp_acpi_major, LTP_ACPI_DEV_NAME);
+	put_disk(gd_ptr);
 
+	unregister_blkdev(LTPMAJOR, LTP_ACPI_DEV_NAME);
 }
diff --git a/testcases/kernel/device-drivers/acpi/LtpAcpiMain.c b/testcases/kernel/device-drivers/acpi/LtpAcpiMain.c
index c3e9c91..4ae989e 100644
--- a/testcases/kernel/device-drivers/acpi/LtpAcpiMain.c
+++ b/testcases/kernel/device-drivers/acpi/LtpAcpiMain.c
@@ -40,119 +40,148 @@
 #include <linux/kd.h>
 #include <linux/errno.h>
 
+#include "test.h"
+#include "usctest.h"
+#include "tst_module.h"
+#include "safe_macros.h"
+
 #include "LtpAcpi.h"
 
+char *TCID = "LTP_ACPI";
+
 int LTP_acpi_open_block_device(void);
 
-int ltp_block_dev_handle = 0;	/* handle to LTP Test block device */
+/* handle to LTP Test block device */
+static int ltp_block_dev_handle;
+
+static const char module_name[]	= "LtpAcpiCmds.ko";
+static int module_loaded;
+
+static void cleanup(void)
+{
+	if (ltp_block_dev_handle)
+		SAFE_CLOSE(NULL, ltp_block_dev_handle);
+
+	if (module_loaded)
+		tst_module_unload(NULL, module_name);
+
+	TEST_CLEANUP;
+}
 
 int main(int argc, char **argv)
 {
+	tst_require_root(NULL);
 
-	ltpdev_cmd_t cmd = { 0, 0 };
-	int rc;
+	if (tst_kvercmp(2, 6, 0) < 0) {
+		tst_brkm(TCONF, NULL,
+			"Test must be run with kernel 2.6 or newer");
+	}
 
-	printf("[%s] - Running test program\n", argv[0]);
+	tst_sig(FORK, DEF_HANDLER, cleanup);
 
-	rc = LTP_acpi_open_block_device();
+	tst_module_load(NULL, module_name, NULL);
+	module_loaded = 1;
+
+	ltpdev_cmd_t cmd = { 0, 0 };
+	int rc = LTP_acpi_open_block_device();
 
 	if (!rc) {
 
 		ltp_block_dev_handle = open(LTP_ACPI_DEVICE_NAME, O_RDWR);
-
 		if (ltp_block_dev_handle < 0) {
-			printf
-			    ("ERROR: Open of device %s failed %d errno = %d\n",
-			     LTP_ACPI_DEVICE_NAME, ltp_block_dev_handle, errno);
+			tst_brkm(TBROK | TERRNO, cleanup,
+				"open device %s failed %d",
+				LTP_ACPI_DEVICE_NAME, ltp_block_dev_handle);
 		} else {
 			rc = ioctl(ltp_block_dev_handle, LTPDEV_CMD, &cmd);
-
-			printf("return from ioctl %d \n", rc);
+			tst_resm((rc == 0) ? TPASS : TFAIL,
+				"ACPI test-cases completed");
 		}
 
 	} else {
-		printf("ERROR: Create/open block device failed\n");
+		tst_brkm(TBROK, cleanup, "create/open block device failed");
 	}
 
-	return 0;
+	cleanup();
+
+	tst_exit();
 }
 
 int LTP_acpi_open_block_device()
 {
 	dev_t devt;
 	struct stat statbuf;
-	int rc;
+	int rc = -1;
 
-	if (ltp_block_dev_handle == 0) {
+	/* check for the /dev/LTPACPITest subdir, and create if it does not exist.
+	 *
+	 * If devfs is running and mounted on /dev, these checks will all pass,
+	 * so a new node will not be created.
+	 */
 
-		/* check for the /dev/LTPACPITest subdir, and create if it does not exist.
-		 *
-		 * If devfs is running and mounted on /dev, these checks will all pass,
-		 * so a new node will not be created.
-		 */
-		devt = makedev(LTPMAJOR, 0);
+	SAFE_FILE_SCANF(NULL, "/sys/devices/virtual/block/"
+		LTP_ACPI_DEV_NAME"/dev",
+		"%d:0", &LTPMAJOR);
+
+	devt = makedev(LTPMAJOR, 0);
 
-		rc = stat(LTP_ACPI_DEV_NODE_PATH, &statbuf);
+	errno = 0;
+	rc = stat(LTP_ACPI_DEV_NODE_PATH, &statbuf);
 
-		if (rc) {
-			if (errno == ENOENT) {
-				/* dev node does not exist. */
+	if (rc) {
+		if (errno == ENOENT) {
+			/* dev node does not exist. */
+			rc = mkdir(LTP_ACPI_DEV_NODE_PATH,
+				   (S_IFDIR | S_IRWXU | S_IRGRP |
+				    S_IXGRP | S_IROTH | S_IXOTH));
+		} else {
+			tst_brkm(TBROK | TERRNO, NULL,
+				"problem with LTP ACPI dev dir");
+		}
+	} else {
+		if (!(statbuf.st_mode & S_IFDIR)) {
+			rc = unlink(LTP_ACPI_DEV_NODE_PATH);
+			if (!rc) {
 				rc = mkdir(LTP_ACPI_DEV_NODE_PATH,
-					   (S_IFDIR | S_IRWXU | S_IRGRP |
-					    S_IXGRP | S_IROTH | S_IXOTH));
-			} else {
-				printf
-				    ("ERROR: Problem with LTP ACPI dev directory.  Error code from stat() is %d\n\n",
-				     errno);
+					   (S_IFDIR | S_IRWXU | S_IRGRP
+					    | S_IXGRP | S_IROTH |
+					    S_IXOTH));
 			}
+		}
+	}
 
+	/*
+	 * Check for the /dev/ltp-acpi/block_device node, and create if it does not
+	 * exist.
+	 */
+	rc = stat(LTP_ACPI_DEVICE_NAME, &statbuf);
+	if (rc) {
+		if (errno == ENOENT) {
+			/* dev node does not exist */
+			rc = mknod(LTP_ACPI_DEVICE_NAME,
+				   (S_IFBLK | S_IRUSR | S_IWUSR |
+				    S_IRGRP | S_IWGRP), devt);
 		} else {
-			if (!(statbuf.st_mode & S_IFDIR)) {
-				rc = unlink(LTP_ACPI_DEV_NODE_PATH);
-				if (!rc) {
-					rc = mkdir(LTP_ACPI_DEV_NODE_PATH,
-						   (S_IFDIR | S_IRWXU | S_IRGRP
-						    | S_IXGRP | S_IROTH |
-						    S_IXOTH));
-				}
-			}
+			tst_brkm(TBROK | TERRNO, NULL,
+				"LTP ACPI block dev node dir");
 		}
 
+	} else {
 		/*
-		 * Check for the /dev/ltp-acpi/block_device node, and create if it does not
-		 * exist.
+		 * /dev/ltp-acpi/block_device exists.  Check to make sure it is for a
+		 * block device and that it has the right major and minor.
 		 */
-		rc = stat(LTP_ACPI_DEVICE_NAME, &statbuf);
-		if (rc) {
-			if (errno == ENOENT) {
-				/* dev node does not exist */
-				rc = mknod(LTP_ACPI_DEVICE_NAME,
-					   (S_IFBLK | S_IRUSR | S_IWUSR |
-					    S_IRGRP | S_IWGRP), devt);
-			} else {
-				printf
-				    ("ERROR:Problem with LTP ACPI block device node directory.  Error code form stat() is %d\n\n",
-				     errno);
-			}
+		if ((!(statbuf.st_mode & S_IFBLK)) ||
+		    (statbuf.st_rdev != devt)) {
 
-		} else {
-			/*
-			 * /dev/ltp-acpi/block_device exists.  Check to make sure it is for a
-			 * block device and that it has the right major and minor.
-			 */
-			if ((!(statbuf.st_mode & S_IFBLK)) ||
-			    (statbuf.st_rdev != devt)) {
-
-				/* Recreate the dev node. */
-				rc = unlink(LTP_ACPI_DEVICE_NAME);
-				if (!rc) {
-					rc = mknod(LTP_ACPI_DEVICE_NAME,
-						   (S_IFBLK | S_IRUSR | S_IWUSR
-						    | S_IRGRP | S_IWGRP), devt);
-				}
+			/* Recreate the dev node. */
+			rc = unlink(LTP_ACPI_DEVICE_NAME);
+			if (!rc) {
+				rc = mknod(LTP_ACPI_DEVICE_NAME,
+					   (S_IFBLK | S_IRUSR | S_IWUSR
+					    | S_IRGRP | S_IWGRP), devt);
 			}
 		}
-
 	}
 
 	return rc;
diff --git a/testcases/kernel/device-drivers/acpi/Makefile b/testcases/kernel/device-drivers/acpi/Makefile
index afec680..15715cb 100644
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
+obj-m := LtpAcpiCmds.o
 
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
+MAKE_TARGETS		:= LtpAcpiMain LtpAcpiCmds.ko
 
-modules_install:
-	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules_install
+include $(top_srcdir)/include/mk/module.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
 endif
diff --git a/testcases/kernel/device-drivers/acpi/ltpacpi.sh b/testcases/kernel/device-drivers/acpi/ltpacpi.sh
deleted file mode 100755
index 73e26e5..0000000
--- a/testcases/kernel/device-drivers/acpi/ltpacpi.sh
+++ /dev/null
@@ -1,54 +0,0 @@
-#!/bin/sh
-# This script should be run to execute the ACPI (Avanced Control Power & Integration) tests.
-# One word of warning, since ACPI will control devices and possibly put them to sleep,
-# it's not recommended that any other tests be run concurrently with these tests. You may
-# get unexpected results.
-# 06/10/03 mridge@us.ibm.com initial script created
-
-cd `dirname $0`
-export LTPROOT=${PWD}
-export TMPBASE="/tmp"
-run=$run
-ltproot=$TPROOT
-tmpdir=$TMPBASE
-
-
-usage()
-{
-	cat <<-END >&2
-	usage: ${0##*/} [ -r run ]
-
-
-	example: ${0##*/} -r run
-
-        ACPI must be enabled in the kernel. Since ACPI will control devices and possibly put them to sleep,
-        it's not recommended that any other tests be run concurrently with these tests since you may
-        get unexpected results.
-        These tests are currently ONLY supported on the 2.5 kernels. 2.4 kernels probably won't even build much
-        less run.
-
-	END
-exit
-}
-
-while getopts :r: arg
-do      case $arg in
-		          r)	   run=$OPTARG;;
-
-                \?)     echo "************** Help Info: ********************"
-                        usage;;
-        esac
-done
-
-if [ ! -n "$run"  ]; then
-  usage;
-  exit
-fi
-
-echo "****** Loading ACPI test module ******"
-
-insmod ${LTPROOT}/LtpAcpiCmds.ko || insmod ${LTPROOT}/LtpAcpiCmds.o
-lsmod
-${LTPROOT}/LtpAcpiMain
-rmmod LtpAcpiCmds
-
-- 
1.7.1



--===============4058022629293028761==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134791&iu=/4140/ostg.clktrk
--===============4058022629293028761==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4058022629293028761==--
