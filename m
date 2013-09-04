Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1VHHfB-0003GH-QN
	for ltp-list@lists.sourceforge.net; Wed, 04 Sep 2013 18:18:45 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VHHf9-0002K4-GE
	for ltp-list@lists.sourceforge.net; Wed, 04 Sep 2013 18:18:45 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r84IIaHr023974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 4 Sep 2013 18:18:37 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r84IIZad011494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 4 Sep 2013 18:18:36 GMT
Received: from abhmt120.oracle.com (abhmt120.oracle.com [141.146.116.72])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r84IIZ7p006357
	for <ltp-list@lists.sourceforge.net>; Wed, 4 Sep 2013 18:18:35 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed,  4 Sep 2013 22:18:04 +0400
Message-Id: <1378318684-29558-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] device-drivers: acpi: update for Linux kernel 2.6.37+
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4171824119152174333=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com, Alexey Kodanev <alexey.kodanev@oracle.com>

--===============4171824119152174333==

User-space program determines block device major number using sysfs.
acpi_get_object_info external interface updated.
ACPI bit register access function renamed.
acpi_bus_get_power() changed to acpi_bus_update_power()
Added block device queue to fix NULL dereference.
Added acpi functions return status checks.
printk(KERN_ALERT ...) changed to pr_alert(...).

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/kernel/device-drivers/Makefile           |    2 +-
 testcases/kernel/device-drivers/acpi/.gitignore    |    7 +
 testcases/kernel/device-drivers/acpi/LtpAcpi.h     |    4 +-
 testcases/kernel/device-drivers/acpi/LtpAcpiCmds.c |  432 +++++++++++---------
 testcases/kernel/device-drivers/acpi/LtpAcpiMain.c |   12 +-
 testcases/kernel/device-drivers/acpi/Makefile      |   48 ++-
 6 files changed, 288 insertions(+), 217 deletions(-)
 create mode 100644 testcases/kernel/device-drivers/acpi/.gitignore

diff --git a/testcases/kernel/device-drivers/Makefile b/testcases/kernel/device-drivers/Makefile
index c402702..999d889 100644
--- a/testcases/kernel/device-drivers/Makefile
+++ b/testcases/kernel/device-drivers/Makefile
@@ -21,7 +21,7 @@ include $(top_srcdir)/include/mk/env_pre.mk
 SUBDIRS		=
 
 ifeq ($(WITH_MODULES),yes)
-
+SUBDIRS		+= acpi
 endif
 
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/device-drivers/acpi/.gitignore b/testcases/kernel/device-drivers/acpi/.gitignore
new file mode 100644
index 0000000..bbf7287
--- /dev/null
+++ b/testcases/kernel/device-drivers/acpi/.gitignore
@@ -0,0 +1,7 @@
+/LtpAcpiMain
+/LtpAcpiCmds.ko
+/*.cmd
+/modules.order
+/Module.symvers
+/LtpAcpiCmds.mod.c
+/.tmp_versions/
diff --git a/testcases/kernel/device-drivers/acpi/LtpAcpi.h b/testcases/kernel/device-drivers/acpi/LtpAcpi.h
index 5c0c37b..c1d1798 100644
--- a/testcases/kernel/device-drivers/acpi/LtpAcpi.h
+++ b/testcases/kernel/device-drivers/acpi/LtpAcpi.h
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
index 26fcc15..1e85242 100644
--- a/testcases/kernel/device-drivers/acpi/LtpAcpiCmds.c
+++ b/testcases/kernel/device-drivers/acpi/LtpAcpiCmds.c
@@ -28,6 +28,8 @@
  *  01/03/2009 M��rton N��meth <nm127@freemail.hu>
  *   - Updated for Linux kernel 2.6.28
  *
+ *  09/2013 Alexey Kodanev <alexey.kodanev@oracle.com>
+ *   - Updated for Linux kernel 2.6.37
  */
 
 #include <linux/kernel.h>
@@ -80,7 +82,8 @@ release:ltpdev_release,
 ioctl:	ltpdev_ioctl,
 };
 
-int ltp_acpi_major = LTPMAJOR;
+ACPI_MODULE_NAME("LTP_ACPI")
+
 int test_iteration = 0;
 
 static char genhd_flags = 0;
@@ -109,26 +112,26 @@ extern struct acpi_device *acpi_root;
 
 static int ltpdev_open(struct block_device *dev, fmode_t mode)
 {
-	printk(KERN_ALERT "ltpdev_open \n");
+	pr_alert("ltpdev_open \n");
 	return 0;
 }
 
 static int ltpdev_release(struct gendisk *disk, fmode_t mode)
 {
 
-	printk(KERN_ALERT "ltpdev_release \n");
+	pr_alert("ltpdev_release \n");
 	return 0;
 }
 
 static u32 ltp_test_power_button_ev_handler(void *context)
 {
-	printk(KERN_ALERT "ltp_test_power_button_ev_handler \n");
+	pr_alert("ltp_test_power_button_ev_handler \n");
 	return 1;
 }
 
 static u32 ltp_test_sleep_button_ev_handler(void *context)
 {
-	printk(KERN_ALERT "ltp_test_sleep_button_ev_handler \n");
+	pr_alert("ltp_test_sleep_button_ev_handler \n");
 	return 1;
 }
 
@@ -145,6 +148,7 @@ static int ltpdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 	struct acpi_ec *ec;
 	struct acpi_device *device;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_device_info *dev_info;
 
 #if 0
 	acpi_handle tmp_handle;
@@ -164,43 +168,79 @@ static int ltpdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 	u32 global_lock = 0;
 	int state = 0;
 
-    /*****************************************************************************/
-
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
-
-		printk(KERN_ALERT "TEST -- acpi_get_handle \n");
-
-		status = acpi_get_handle(0, ACPI_NS_SYSTEM_BUS, &parent_handle);
+	if (cmd != (LTPDEV_CMD))
+		return 0;
 
-		printk(KERN_ALERT "TEST -- acpi_get_object_info \n");
+	/**********************************************************************/
 
-		status = acpi_get_object_info(parent_handle, &buffer);
+	pr_alert("ltpdev_ioctl, cmd\n");
 
-		printk(KERN_ALERT "TEST -- acpi_get_next_object \n");
+	parent_handle = start_handle;
+	child_handle = 0;
+	level = 1;
+	test_iteration++;
 
-		status = acpi_get_next_object(ACPI_TYPE_ANY, parent_handle,
-					      child_handle, &next_child_handle);
+	pr_alert("-- IOCTL called to start ACPI tests -- Iteration:%d\n",
+	         test_iteration);
 
-		printk(KERN_ALERT "TEST -- acpi_get_parent \n");
+	pr_alert("TEST -- acpi_get_handle \n");
+	status = acpi_get_handle(NULL, "\\_SB", &parent_handle);
+	if (ACPI_FAILURE(status))
+		ACPI_EXCEPTION((AE_INFO, status, "acpi_get_handle"));
 
-		status = acpi_get_parent(parent_handle, &parent_handle);
+	pr_alert("TEST -- acpi_get_object_info \n");
+	/*
+	 * ACPICA: Major update for acpi_get_object_info external interface
+	 * http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/
+	 * commit/?id=15b8dd53f5ffaf8e2d9095c423f713423f576c0f
+	 */
+	status = acpi_get_object_info(parent_handle, &dev_info);
+	if (ACPI_FAILURE(status))
+		ACPI_EXCEPTION((AE_INFO, status, "acpi_object_info failed"));
+	else {
+		pr_alert("ACPI object name %4.4s, type %d",
+			(char *)&dev_info->name,
+			dev_info->type);
+		kfree(dev_info);
+	}
 
-		printk(KERN_ALERT "TEST -- acpi_evaluate_object \n");
+	pr_alert("TEST -- acpi_get_next_object \n");
+	status = acpi_get_next_object(ACPI_TYPE_DEVICE, parent_handle,
+				      child_handle, &next_child_handle);
+	child_handle = next_child_handle;
+
+	if (ACPI_FAILURE(status))
+		ACPI_EXCEPTION((AE_INFO, status, "acpi_get_next_object"));
+	status = acpi_get_object_info(next_child_handle, &dev_info);
+	if (ACPI_FAILURE(status))
+		ACPI_EXCEPTION((AE_INFO, status, "acpi_object_info failed"));
+	else {
+		pr_alert("ACPI object name %4.4s, type %d",
+			(char *)&dev_info->name,
+			dev_info->type);
+		kfree(dev_info);
+	}
 
-		status = acpi_evaluate_object(parent_handle, "_ON", NULL, NULL);
+	pr_alert("TEST -- acpi_evaluate_object \n");
+	status = acpi_evaluate_object(parent_handle, "_INI", NULL, NULL);
+	if (ACPI_FAILURE(status))
+		ACPI_EXCEPTION((AE_INFO, status, "acpi_evaluate_object"));
+
+	pr_alert("TEST -- acpi_get_parent \n");
+	status = acpi_get_parent(parent_handle, &parent_handle);
+	if (ACPI_FAILURE(status))
+		ACPI_EXCEPTION((AE_INFO, status, "acpi_get_parent failed"));
+	status = acpi_get_object_info(parent_handle, &dev_info);
+	if (ACPI_FAILURE(status))
+		ACPI_EXCEPTION((AE_INFO, status, "acpi_object_info failed"));
+	else {
+		pr_alert("ACPI object name %4.4s, type %d",
+			(char *)&dev_info->name,
+			dev_info->type);
+			kfree(dev_info);
+	}
 
-		printk(KERN_ALERT "TEST -- acpi_get_table \n");
+//	pr_alert("TEST -- acpi_get_table \n");
 
 //        status = acpi_get_table(ACPI_TABLE_RSDP, 1, &dsdt);
 //        status = acpi_get_table(ACPI_TABLE_DSDT, 1, &dsdt);
@@ -218,92 +258,99 @@ static int ltpdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 					    (struct acpi_table_header **)&dsdt);
 #endif
 
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
+	pr_alert("TEST -- acpi_install_notify_handler \n");
 
-		printk(KERN_ALERT
-		       "TEST -- acpi_install_fixed_event_handler \n");
-		status =
-		    acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
-						     ltp_test_power_button_ev_handler,
-						     NULL);
-		if (status)
-			printk(KERN_ALERT
-			       "Failed installing fixed event handler \n");
+	status = acpi_install_notify_handler(next_child_handle,
+		ACPI_SYSTEM_NOTIFY, &acpi_bus_notify, NULL);
+	if (ACPI_FAILURE(status)) {
+		ACPI_EXCEPTION((AE_INFO, status,
+			"acpi_install_notify_handler"));
+	}
 
-		printk(KERN_ALERT "TEST -- acpi_remove_fixed_event_handler \n");
-		status =
-		    acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
-						    ltp_test_power_button_ev_handler);
-		if (status)
-			printk(KERN_ALERT
-			       "Failed removing fixed event handler \n");
+	pr_alert("TEST -- acpi_remove_notify_handler \n");
+	status = acpi_remove_notify_handler(next_child_handle,
+		ACPI_SYSTEM_NOTIFY, &acpi_bus_notify);
+	if (ACPI_FAILURE(status))
+		ACPI_EXCEPTION((AE_INFO, status, "acpi_remove_notify_handler"));
+
+	pr_alert("TEST -- acpi_install_fixed_event_handler \n");
+	status =  acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
+		ltp_test_power_button_ev_handler, NULL);
+	if (ACPI_FAILURE(status)) {
+		ACPI_EXCEPTION((AE_INFO, status,
+			"failed installing fixed event handler"));
+	}
 
-		printk(KERN_ALERT
-		       "TEST -- acpi_install_fixed_event_handler \n");
-		status =
-		    acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
-						     ltp_test_sleep_button_ev_handler,
-						     NULL);
-		if (status)
-			printk(KERN_ALERT
-			       "Failed installing fixed event handler \n");
+	pr_alert("TEST -- acpi_remove_fixed_event_handler \n");
+	status = acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
+		ltp_test_power_button_ev_handler);
+	if (ACPI_FAILURE(status)) {
+		ACPI_EXCEPTION((AE_INFO, status,
+			"failed removing fixed event handler"));
+	}
 
-		printk(KERN_ALERT "TEST -- acpi_remove_fixed_event_handler \n");
-		status =
-		    acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
-						    ltp_test_sleep_button_ev_handler);
-		if (status)
-			printk(KERN_ALERT
-			       "Failed removing fixed event handler \n");
+	pr_alert("TEST -- acpi_install_fixed_event_handler \n");
+	status = acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
+		ltp_test_sleep_button_ev_handler, NULL);
+	if (ACPI_FAILURE(status)) {
+		ACPI_EXCEPTION((AE_INFO, status,
+			"failed installing fixed event handler"));
+	}
 
-		printk(KERN_ALERT "TEST -- acpi_acquire_global_lock \n");
-		status =
-		    acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &global_lock);
+	pr_alert("TEST -- acpi_remove_fixed_event_handler \n");
+	status = acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
+		ltp_test_sleep_button_ev_handler);
+	if (ACPI_FAILURE(status)) {
+		ACPI_EXCEPTION((AE_INFO, status,
+			"removing fixed event handler"));
+	}
 
-		printk(KERN_ALERT "TEST -- acpi_release_global_lock \n");
-		status = acpi_release_global_lock(global_lock);
+	pr_alert("TEST -- acpi_acquire_global_lock \n");
+	status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &global_lock);
+	if (ACPI_FAILURE(status))
+		ACPI_EXCEPTION((AE_INFO, status, "acpi_acquire_global_lock"));
 
-		printk(KERN_ALERT "TEST -- acpi_bus_get_device \n");
+	pr_alert("TEST -- acpi_release_global_lock \n");
+	status = acpi_release_global_lock(global_lock);
+	if (ACPI_FAILURE(status))
+		ACPI_EXCEPTION((AE_INFO, status, "acpi_release_global_lock"));
 
-		status = acpi_bus_get_device(next_child_handle, &device);
+	pr_alert("TEST -- acpi_bus_get_device \n");
+	status = acpi_bus_get_device(next_child_handle, &device);
+	if (ACPI_FAILURE(status))
+		ACPI_EXCEPTION((AE_INFO, status, "acpi_bus_get_device"));
 
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
-
-		ec = acpi_driver_data(device);
-
-		if (!ec) {
-			printk(KERN_ALERT "Failure getting device data \n");
-		} else {
-
-			printk(KERN_ALERT
-			       "TEST -- acpi_install_gpe_handler \n");
+	pr_alert("TEST -- acpi_bus_update_power \n");
+	status = acpi_bus_update_power(next_child_handle, &state);
+	if (ACPI_FAILURE(status))
+		ACPI_EXCEPTION((AE_INFO, status, "error reading power state"));
+	else
+		pr_info("acpi bus power state is %d\n", state);
+
+	pr_alert("TEST -- acpi_driver_data \n");
+
+	ec = acpi_driver_data(device);
+	if (!ec) {
+		pr_alert("Failure getting device data \n");
+	} else {
+		/*
+		pr_alert(
+		       "TEST -- acpi_install_gpe_handler \n");
 			ec->status_addr = ec->command_addr;
 			status =
 			    acpi_install_gpe_handler(device, ec->gpe_bit,
 						     ACPI_GPE_EDGE_TRIGGERED,
 						     &acpi_ec_gpe_handler, ec);
+		if (ACPI_FAILURE(status)) {
+			ACPI_EXCEPTION((AE_INFO, status,
+				"acpi_install_gpe_handler failed"));
+		}
+		*/
 /*
             status = acpi_install_address_space_handler (ACPI_ROOT_OBJECT,
                     ACPI_ADR_SPACE_EC, &acpi_ec_space_handler,
@@ -316,18 +363,24 @@ static int ltpdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
             acpi_remove_address_space_handler(ACPI_ROOT_OBJECT,
                 ACPI_ADR_SPACE_EC, &acpi_ec_space_handler);
 */
-			printk(KERN_ALERT "TEST -- acpi_remove_gpe_handler \n");
-			acpi_remove_gpe_handler(device, ec->gpe_bit,
-						&acpi_ec_gpe_handler);
+		/*
+		pr_alert("TEST -- acpi_remove_gpe_handler \n");
+		acpi_remove_gpe_handler(device, ec->gpe_bit,
+					&acpi_ec_gpe_handler);
+		if (ACPI_FAILURE(status)) {
+			ACPI_EXCEPTION((AE_INFO, status,
+				"acpi_remove_gpe_handler failed"));
 		}
+		*/
+	}
 
-		printk(KERN_ALERT "TEST -- acpi_get_current_resources \n");
-		status = acpi_get_current_resources(next_child_handle, &buffer);
+	pr_alert("TEST -- acpi_get_current_resources \n");
+	status = acpi_get_current_resources(next_child_handle, &buffer);
+	if (ACPI_FAILURE(status)) {
+		ACPI_EXCEPTION((AE_INFO, status,
+			"failed get_current_resources"));
+	}
 
-		if (status) {
-			printk(KERN_ALERT "Failed get_current_resources %d\n",
-			       status);
-		}
 #ifdef ACPI_FUTURE_USAGE
 		printk(KERN_ALERT "TEST -- acpi_get_possible_resources \n");
 		status =
@@ -339,21 +392,23 @@ static int ltpdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 		}
 #endif
 
-		printk(KERN_ALERT "TEST -- acpi_walk_resources \n");
-		status = acpi_walk_resources(ec->handle, METHOD_NAME__CRS,
-					     acpi_ec_io_ports, ec);
+	/*
+	pr_alert("TEST -- acpi_walk_resources \n");
+	status = acpi_walk_resources(ec->handle, METHOD_NAME__CRS,
+				     acpi_ec_io_ports, ec);
 
-		if (status) {
-			printk(KERN_ALERT "Failed walk_resources %d\n", status);
-		}
+	if (status) {
+		pr_alert("Failed walk_resources %d\n", status);
+	}
 
-		printk(KERN_ALERT "TEST -- acpi_evaluate_integer \n");
-		status =
-		    acpi_evaluate_integer(ec->handle, "_GPE", NULL,
-					  &ec->gpe_bit);
-		if (status)
-			printk(KERN_ALERT
-			       "Error obtaining GPE bit assignment\n");
+	pr_alert("TEST -- acpi_evaluate_integer \n");
+	status =
+	    acpi_evaluate_integer(ec->handle, "_GPE", NULL,
+				  &ec->gpe_bit);
+	if (status)
+		pr_alert(
+		       "Error obtaining GPE bit assignment\n");
+	*/
 
 #if 0
 		printk(KERN_ALERT "TEST -- acpi_get_timer \n");
@@ -383,37 +438,39 @@ static int ltpdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 		}
 #endif
 
-		for (i = 0; i < ACPI_S_STATE_COUNT; i++) {
-			printk(KERN_ALERT
-			       "TEST -- acpi_get_sleep_type_data \n");
-			status = acpi_get_sleep_type_data(i, &type_a, &type_b);
+	for (i = 0; i < ACPI_S_STATE_COUNT; i++) {
+		pr_alert("TEST -- acpi_get_sleep_type_data \n");
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
+		if (ACPI_FAILURE(status)) {
+			ACPI_EXCEPTION((AE_INFO, status,
+				"failed get_sleep_type_data"));
+		} else {
+			pr_alert(
+			       "get_sleep_type_data [%d] type_a:%d type_b:%d\n",
+			       i, type_a, type_b);
 		}
+	}
 
-		printk(KERN_ALERT "TEST -- acpi_get_register \n");
+	pr_alert("TEST -- acpi_get_register \n");
 
-/*
- * ACPICA: Remove obsolete Flags parameter.
- * http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=d8c71b6d3b21cf21ad775e1cf6da95bf87bd5ad4
- *
- */
-		acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS, &bm_status);
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
 
-		if (!bm_status) {
-			printk(KERN_ALERT "Failed get_register [%d]\n",
-			       bm_status);
-		} else {
-			printk(KERN_ALERT "get_register [%d] \n", bm_status);
-		}
+	if (!bm_status) {
+		pr_alert("Failed get_register [%d]\n",
+		       bm_status);
+	} else {
+		pr_alert("get_register [%d] \n", bm_status);
+	}
 
 //        Puts system to sleep, permenately !!!
 //        status = acpi_enter_sleep_state(ACPI_STATE_S1);
@@ -438,26 +495,25 @@ static int ltpdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 		}
 #endif
 
-		printk(KERN_ALERT "TEST -- acpi_get_devices \n");
-		status =
-		    acpi_get_devices(NULL, ltp_get_dev_callback, "LTP0001",
-				     NULL);
+	pr_alert("TEST -- acpi_get_devices \n");
+	status = acpi_get_devices(NULL, ltp_get_dev_callback, "LTP0001", NULL);
+	if (ACPI_FAILURE(status))
+		ACPI_EXCEPTION((AE_INFO, status, "Failed get_devices"));
 
-		if (status) {
-			printk(KERN_ALERT "Failed get_devices %d\n", status);
-		}
-//        status = acpi_os_create_semaphore(1, 1, &tmp_handle);
+	/*
+	status = acpi_os_create_semaphore(1, 1, &tmp_handle);
 
-		if (status) {
-			printk(KERN_ALERT "Failed os_create_semaphore %d\n",
-			       status);
-		} else {
-			printk(KERN_ALERT
-			       "os_create_semaphore OK, no deleteing %d\n",
-			       status);
-//            acpi_os_delete_semaphore(tmp_handle);
+	if (status) {
+		pr_alert("Failed os_create_semaphore %d\n",
+		       status);
+	} else {
+		pr_alert("os_create_semaphore OK, no deleteing %d\n",
+		         status);
 
-		}
+	acpi_os_delete_semaphore(tmp_handle);
+
+	}
+	*/
 
 #if 0
 		printk(KERN_ALERT "TEST -- acpi_get_system_info \n");
@@ -499,12 +555,8 @@ static int ltpdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 		}
 #endif
 
-		printk(KERN_ALERT
-		       "-- IOCTL ACPI tests Complete -- Iteration:%d\n",
-		       test_iteration);
-
-		break;
-	}
+	pr_alert("-- IOCTL ACPI tests Complete -- Iteration:%d\n",
+	         test_iteration);
 
 	return 0;
 }
@@ -617,42 +669,38 @@ static acpi_status acpi_ec_space_setup(acpi_handle region_handle,
 
 int init_module(void)
 {
-	int result;
-
-	printk(KERN_ALERT "ltpdev_init_module \n");
-
-	result = register_blkdev(ltp_acpi_major, LTP_ACPI_DEV_NAME);
+	pr_alert("ltpdev_init_module\n");
 
-	printk(KERN_ALERT "LTP ACPI: register_blkdev result=%d major %d\n",
-	       result, ltp_acpi_major);
+	LTPMAJOR = register_blkdev(0, LTP_ACPI_DEV_NAME);
 
-	if (result < 0) {
-		printk(KERN_ALERT "LTP ACPI: can't get major %d\n",
-		       ltp_acpi_major);
-		return result;
+	if (LTPMAJOR < 0) {
+		pr_alert("LTP ACPI: can't get major %d\n",
+		       LTPMAJOR);
+		return LTPMAJOR;
 	}
-//    if (ltp_acpi_major == 0)
-//      ltp_acpi_major = result; /* dynamic */
+
+	pr_alert("register_blkdev major %d\n",
+	         LTPMAJOR);
 
 	gd_ptr = kmalloc(sizeof(struct gendisk *), GFP_KERNEL);
 
 	if (!gd_ptr) {
-		printk(KERN_ALERT "ERROR getting memory !!!\n");
+		pr_alert("ERROR getting memory !!!\n");
 		return 0;
 	}
 
 	gd_ptr = alloc_disk(1);
 
-	printk(KERN_ALERT "gd_ptr after alloc = %p \n", gd_ptr);
+	pr_alert("gd_ptr after alloc = %p \n", gd_ptr);
 
-	gd_ptr->major = ltp_acpi_major;
+	gd_ptr->major = LTPMAJOR;
 	gd_ptr->first_minor = 0;
 	gd_ptr->fops = &blkops;
 //    gd_ptr->minor_shift = MINOR_SHIFT_BITS;
 	gd_ptr->driverfs_dev = NULL;
 //    gd_ptr->disk_de = NULL;
 	gd_ptr->flags = genhd_flags;
-
+	gd_ptr->queue = blk_alloc_queue(GFP_KERNEL);
 	sprintf(gd_ptr->disk_name, LTP_ACPI_DEV_NAME);
 
 	add_disk(gd_ptr);
@@ -662,13 +710,13 @@ int init_module(void)
 
 void cleanup_module(void)
 {
+	pr_alert("Exiting module and cleaning up \n");
 
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
index c3e9c91..ed90784 100644
--- a/testcases/kernel/device-drivers/acpi/LtpAcpiMain.c
+++ b/testcases/kernel/device-drivers/acpi/LtpAcpiMain.c
@@ -42,6 +42,10 @@
 
 #include "LtpAcpi.h"
 
+#include "test.h"
+
+char *TCID = "LTP_ACPI";
+
 int LTP_acpi_open_block_device(void);
 
 int ltp_block_dev_handle = 0;	/* handle to LTP Test block device */
@@ -66,7 +70,6 @@ int main(int argc, char **argv)
 			     LTP_ACPI_DEVICE_NAME, ltp_block_dev_handle, errno);
 		} else {
 			rc = ioctl(ltp_block_dev_handle, LTPDEV_CMD, &cmd);
-
 			printf("return from ioctl %d \n", rc);
 		}
 
@@ -81,7 +84,7 @@ int LTP_acpi_open_block_device()
 {
 	dev_t devt;
 	struct stat statbuf;
-	int rc;
+	int rc = -1;
 
 	if (ltp_block_dev_handle == 0) {
 
@@ -90,6 +93,11 @@ int LTP_acpi_open_block_device()
 		 * If devfs is running and mounted on /dev, these checks will all pass,
 		 * so a new node will not be created.
 		 */
+
+		SAFE_FILE_SCANF(NULL, "/sys/devices/virtual/block/"
+			LTP_ACPI_DEV_NAME"/dev",
+			"%d:0", &LTPMAJOR);
+
 		devt = makedev(LTPMAJOR, 0);
 
 		rc = stat(LTP_ACPI_DEV_NODE_PATH, &statbuf);
diff --git a/testcases/kernel/device-drivers/acpi/Makefile b/testcases/kernel/device-drivers/acpi/Makefile
index afec680..c73589d 100644
--- a/testcases/kernel/device-drivers/acpi/Makefile
+++ b/testcases/kernel/device-drivers/acpi/Makefile
@@ -1,34 +1,42 @@
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
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 
-#KERNELDIR := /usr/src/linux-2.5.64-gcov
-EXTRA_CFLAGS := -Wall -g -W -Wno-unused-parameter
+MODULE_NAME	= LtpAcpiCmds
 
 ifneq ($(KERNELRELEASE),)
 
-obj-m	:= LtpAcpiCmds.o
-obj-p   := Test
+obj-m		:= $(MODULE_NAME).o
+
 else
-KDIR	:= /lib/modules/$(shell uname -r)/build
-PWD	:= $(shell pwd)
 
-modules:
-	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
-	${CC}  $(CFLAGS) -o LtpAcpiMain  LtpAcpiMain.c
+top_srcdir	?= ../../../..
+include $(top_srcdir)/include/mk/testcases.mk
 
-clean:
-	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) clean
-	rm -f modules.order
-	rm -f LtpAcpiMain
+MAKE_TARGETS	:= $(MODULE_NAME).ko LtpAcpiMain
 
-help:
-	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) help
+# Ignoring the exit status of commands is done to be forward compatible with
+# kernel internal API changes. The user-space test will return TCONF, if it
+# doesn't find the module (i.e. it wasn't built either due to kernel-devel
+# missing or module build failure).
+$(MODULE_NAME).ko: $(MODULE_NAME).c
+	-$(MAKE) -C $(LINUX_DIR) M=$(abs_srcdir)
+	-mv $(MODULE_NAME).ko $(MODULE_NAME).ko~
+	-$(MAKE) -C $(LINUX_DIR) M=$(abs_srcdir) clean
+	-mv $(MODULE_NAME).ko~ $(MODULE_NAME).ko
 
-modules_install:
-	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules_install
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
 endif
-- 
1.7.1



--===============4171824119152174333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58040911&iu=/4140/ostg.clktrk
--===============4171824119152174333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4171824119152174333==--
