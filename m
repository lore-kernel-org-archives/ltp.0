Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1UkCUY-0007Wq-Lr
	for ltp-list@lists.sourceforge.net; Wed, 05 Jun 2013 12:07:02 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UkCUW-0006SX-Oq
	for ltp-list@lists.sourceforge.net; Wed, 05 Jun 2013 12:07:02 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r55C6seX017034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 5 Jun 2013 12:06:55 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r55C6rOB025722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 5 Jun 2013 12:06:54 GMT
Received: from abhmt109.oracle.com (abhmt109.oracle.com [141.146.116.61])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r55C6rRQ007898
	for <ltp-list@lists.sourceforge.net>; Wed, 5 Jun 2013 12:06:53 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed,  5 Jun 2013 16:06:17 +0400
Message-Id: <1370433977-6944-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] fw_load: new test of device firmware loading
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

This test checks that from kernel 3.7 firmware can be loaded directly
(by-pass udev) or as usual. The test consists of the two parts: userspace
and kernelspace.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/kernel/Makefile                          |    4 +
 testcases/kernel/firmware/Makefile                 |   19 ++
 .../kernel/firmware/fw_load_kernel/.gitignore      |    1 +
 testcases/kernel/firmware/fw_load_kernel/Makefile  |   36 +++
 testcases/kernel/firmware/fw_load_kernel/README    |   14 +
 testcases/kernel/firmware/fw_load_kernel/fw_load.c |  151 ++++++++++
 testcases/kernel/firmware/fw_load_user/.gitignore  |    1 +
 testcases/kernel/firmware/fw_load_user/Makefile    |   19 ++
 testcases/kernel/firmware/fw_load_user/README      |   11 +
 testcases/kernel/firmware/fw_load_user/fw_load.c   |  299 ++++++++++++++++++++
 10 files changed, 555 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/firmware/Makefile
 create mode 100644 testcases/kernel/firmware/fw_load_kernel/.gitignore
 create mode 100644 testcases/kernel/firmware/fw_load_kernel/Makefile
 create mode 100644 testcases/kernel/firmware/fw_load_kernel/README
 create mode 100644 testcases/kernel/firmware/fw_load_kernel/fw_load.c
 create mode 100644 testcases/kernel/firmware/fw_load_user/.gitignore
 create mode 100644 testcases/kernel/firmware/fw_load_user/Makefile
 create mode 100644 testcases/kernel/firmware/fw_load_user/README
 create mode 100644 testcases/kernel/firmware/fw_load_user/fw_load.c

diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
index 4b4800d..b2be183 100644
--- a/testcases/kernel/Makefile
+++ b/testcases/kernel/Makefile
@@ -55,6 +55,10 @@ ifeq ($(WITH_POWER_MANAGEMENT_TESTSUITE),yes)
 SUBDIRS			+= power_management
 endif
 
+ifeq ($(WITH_MODULES),yes)
+SUBDIRS			+= firmware
+endif
+
 endif
 
 MAKE_DEPS		:= include/linux_syscall_numbers.h
diff --git a/testcases/kernel/firmware/Makefile b/testcases/kernel/firmware/Makefile
new file mode 100644
index 0000000..6297b1b
--- /dev/null
+++ b/testcases/kernel/firmware/Makefile
@@ -0,0 +1,19 @@
+# Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation.
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
+top_srcdir	?= ../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/firmware/fw_load_kernel/.gitignore b/testcases/kernel/firmware/fw_load_kernel/.gitignore
new file mode 100644
index 0000000..fdb463d
--- /dev/null
+++ b/testcases/kernel/firmware/fw_load_kernel/.gitignore
@@ -0,0 +1 @@
+/fw_load.ko
diff --git a/testcases/kernel/firmware/fw_load_kernel/Makefile b/testcases/kernel/firmware/fw_load_kernel/Makefile
new file mode 100644
index 0000000..c8cb78a
--- /dev/null
+++ b/testcases/kernel/firmware/fw_load_kernel/Makefile
@@ -0,0 +1,36 @@
+# Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation.
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
+MODULE		:= fw_load
+
+ifneq ($(KERNELRELEASE),)
+
+obj-m		:= $(MODULE).o
+
+else
+
+top_srcdir	?= ../../../..
+include $(top_srcdir)/include/mk/env_pre.mk
+
+MAKE_TARGETS	:= $(MODULE).ko
+$(MODULE).ko:
+	$(MAKE) -C $(KERNEL_DEVEL_DIR) M=$(abs_srcdir)
+	mv $(MODULE).ko $(MODULE).ko~
+	$(MAKE) -C $(KERNEL_DEVEL_DIR) M=$(abs_srcdir) clean
+	mv $(MODULE).ko~ $(MODULE).ko
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+endif
diff --git a/testcases/kernel/firmware/fw_load_kernel/README b/testcases/kernel/firmware/fw_load_kernel/README
new file mode 100644
index 0000000..7a2f974
--- /dev/null
+++ b/testcases/kernel/firmware/fw_load_kernel/README
@@ -0,0 +1,14 @@
+The aim of the test is to check that after kernel 3.7 firmware can be loaded
+directly (by-pass udev) or as usual. The test consists of the two parts:
+ - userspace part
+ - kernelspace part
+
+This is a kernel module, which is a part of the device firmware loading test.
+It allows to call request_firmware kernel function with specified parameters.
+The parameters passed with the insmod command. They include template firmware
+file name, number of firmware files to request, and expected data in the
+firmware files. In the end, the device will create sysfs file, that can be
+read to get request firmware results. Also, some information regarding module
+loading, can be obtained by looking at kernel log file.
+
+It is automatically used by user space part of the test.
diff --git a/testcases/kernel/firmware/fw_load_kernel/fw_load.c b/testcases/kernel/firmware/fw_load_kernel/fw_load.c
new file mode 100644
index 0000000..270ccfc
--- /dev/null
+++ b/testcases/kernel/firmware/fw_load_kernel/fw_load.c
@@ -0,0 +1,151 @@
+/*
+ * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation.
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
+ * Author:
+ * Alexey Kodanev <alexey.kodanev@oracle.com>
+ *
+ * This module is trying to load external test firmware files (load_tst_#.fw).
+ * In the end, it writes results to sys/devices/fw_load_tst/result file.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/string.h>
+#include <linux/firmware.h>
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Alexey Kodanev <alexey.kodanev@oracle.com>");
+MODULE_DESCRIPTION("This module is checking firmware loading process");
+
+#define TCID	"fw_load"
+
+/* number of firmware files to check in the test */
+static int fw_num	= 8;
+static char *fw_name	= "load_tst.fw";
+static char *fw_data	= "FirmwareTest";
+static int max_name	= 64;
+
+module_param(fw_num, int, 0444);
+MODULE_PARM_DESC(fw_num, "Number of firmwares to check");
+
+module_param(fw_name, charp, 0444);
+MODULE_PARM_DESC(fw_name, "Template firmware file: n#_name");
+
+module_param(fw_data, charp, 0444);
+MODULE_PARM_DESC(fw_data, "Firmware file data");
+
+/*
+ * bit mask for each test-case,
+ * if test is passed, bit will be set to 1
+ */
+static int test_result;
+
+/* read and print firmware data */
+static int fw_read(const u8 *data, size_t size);
+
+static void device_release(struct device *dev);
+
+static struct device tdev = {
+	.init_name	= TCID,
+	.release	= device_release,
+};
+
+static int try_request_fw(const char *name);
+
+/* print test result to sysfs file */
+static ssize_t sys_result(struct device *dev,
+	struct device_attribute *attr, char *buf);
+static DEVICE_ATTR(result, S_IRUSR, sys_result, NULL);
+
+
+static int test_init(void)
+{
+	int i, err;
+
+	err = device_register(&tdev);
+
+	if (err) {
+		pr_err(TCID ": Unable to register device\n");
+		return err;
+	}
+	pr_info(TCID ": device registered\n");
+
+	for (i = 0; i < fw_num; ++i) {
+		char name[max_name];
+		snprintf(name, max_name, "n%d_%s", i, fw_name);
+		err = try_request_fw(name);
+		test_result |= (err == 0) << i;
+	}
+
+	err = device_create_file(&tdev, &dev_attr_result);
+	if (err != 0)
+		pr_info(TCID ": Can't create sysfs file\n");
+
+	return err;
+}
+
+static void test_exit(void)
+{
+	device_remove_file(&tdev, &dev_attr_result);
+	device_unregister(&tdev);
+	pr_info(TCID ": module exited\n");
+}
+
+static void device_release(struct device *dev)
+{
+	pr_info(TCID ": device released\n");
+}
+
+static ssize_t sys_result(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "%d\n", test_result);
+}
+
+static int fw_read(const u8 *data, size_t size)
+{
+	u8 copy[size + 1];
+	memcpy(copy, data, size);
+	copy[size] = '\0';
+
+	pr_info(TCID ": Firmware data '%s', size %u\n",
+		copy, (unsigned int) size);
+
+	return strcmp(fw_data, copy);
+}
+
+static int try_request_fw(const char *name)
+{
+	int err;
+	const struct firmware *fw_entry = NULL;
+
+	err = request_firmware(&fw_entry, name, &tdev);
+
+	if (!err) {
+		pr_info(TCID ": firmware '%s' requested\n", name);
+		err = fw_read(fw_entry->data, fw_entry->size);
+	} else
+		pr_err(TCID ": Can't request firmware '%s'\n", name);
+
+	release_firmware(fw_entry);
+
+	return err;
+}
+
+module_init(test_init);
+module_exit(test_exit);
diff --git a/testcases/kernel/firmware/fw_load_user/.gitignore b/testcases/kernel/firmware/fw_load_user/.gitignore
new file mode 100644
index 0000000..1d08149
--- /dev/null
+++ b/testcases/kernel/firmware/fw_load_user/.gitignore
@@ -0,0 +1 @@
+/fw_load
diff --git a/testcases/kernel/firmware/fw_load_user/Makefile b/testcases/kernel/firmware/fw_load_user/Makefile
new file mode 100644
index 0000000..2d75069
--- /dev/null
+++ b/testcases/kernel/firmware/fw_load_user/Makefile
@@ -0,0 +1,19 @@
+# Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation.
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
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/firmware/fw_load_user/README b/testcases/kernel/firmware/fw_load_user/README
new file mode 100644
index 0000000..41c2bf9
--- /dev/null
+++ b/testcases/kernel/firmware/fw_load_user/README
@@ -0,0 +1,11 @@
+The aim of the test is to check that after kernel 3.7 firmware can be loaded
+directly (by-pass udev) or as usual. The test consists of the two parts:
+ - userspace part
+ - kernelspace part
+
+This is the userspace part, its tasks are:
+ - create firmware files in the searched paths by udev and kernels
+ - replace udev's searched paths to tmp directory (firmware.sh)
+ - load the module and wait for results
+ - read device's result file and print test results
+ - clean up tmp directory and unload the module.
diff --git a/testcases/kernel/firmware/fw_load_user/fw_load.c b/testcases/kernel/firmware/fw_load_user/fw_load.c
new file mode 100644
index 0000000..573bffd
--- /dev/null
+++ b/testcases/kernel/firmware/fw_load_user/fw_load.c
@@ -0,0 +1,299 @@
+/*
+ * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation.
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
+ * Author:
+ * Alexey Kodanev <alexey.kodanev@oracle.com>
+ *
+ * Test checks following preconditions:
+ * Linux kernels from version 3.7 are loading firmware files directly using
+ * hard coded paths. In case the firmware not found, loading will be proceeded
+ * as usual (udev).
+ */
+
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/xattr.h>
+#include <sys/utsname.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <dirent.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+
+/* number of test firmware files */
+#define FW_FILES	9
+
+char *TCID = "fw_load";
+int TST_TOTAL = FW_FILES;
+
+#define MAX_CMD_LEN	256
+/* hard coded paths in the kernel */
+#define FW_PATHS_NUM	4
+
+static const char fw_name[]	= "load_tst.fw";
+static const char module_name[]	= "fw_load.ko";
+static const char fw_data[]	= "FirmwareTest";
+static const char udev_script[]	= "/lib/udev/firmware.sh";
+
+enum load_mode {
+	DIRECT_LOAD = 0,
+	UDEV_LOAD
+};
+
+struct fw_file_info {
+	char file[PATH_MAX];
+	char dir[PATH_MAX];
+	int mode;
+	int fake;
+	int remove_dir;
+	int remove_file;
+};
+
+static struct fw_file_info fw[FW_FILES];
+static int fw_num;
+
+/* related firmware paths which are searched by kernel and udev */
+static char fw_paths[FW_PATHS_NUM][PATH_MAX];
+static char tmp_dir[PATH_MAX];
+static char mod_path[PATH_MAX];
+
+/* test options */
+static int skip_cleanup;
+static int verbose;
+static const option_t options[] = {
+	{"s", &skip_cleanup, NULL},
+	{"v", &verbose, NULL},
+	{NULL, NULL, NULL}
+};
+
+static void help(void);
+static void setup(int argc, char *argv[]);
+static void test_run(void);
+static void cleanup(void);
+
+/*
+ * create firmware files in the fw_paths
+ * @path: start directory
+ * @mode: can be DIRECT_LOAD or UDEV_LOAD
+ */
+static void create_firmware(const char *path, int mode);
+/* make a string from another by adding escape '\' before each '/' */
+static void reg_path(char *dst, const char *src);
+/* replace a string with another string in a file */
+static void str_replace(const char *file, const char *old, const char *new);
+
+int main(int argc, char *argv[])
+{
+	setup(argc, argv);
+
+	test_run();
+
+	cleanup();
+
+	tst_exit();
+}
+
+static void help(void)
+{
+	printf("  -s      Skip cleanup\n");
+	printf("  -v      Verbose\n");
+}
+
+/* cleanup flags */
+static int fw_script_changed;
+static int fw_rules_copied;
+static int module_registered;
+
+void setup(int argc, char *argv[])
+{
+	char *msg;
+	msg = parse_opts(argc, argv, options, help);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	tst_require_root(NULL);
+
+	if (tst_kvercmp(3, 7, 0) < 0) {
+		tst_brkm(TCONF, NULL,
+			"Test must be run with kernel 3.7 or newer");
+	}
+
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+
+	/* add firmware rule to udev */
+	if (access("/etc/udev/rules.d/50-firmware.rules", 0) == -1) {
+		SAFE_CP(cleanup, "/lib/udev/rules.d/50-firmware.rules",
+			"/etc/udev/rules.d/");
+		fw_rules_copied = 1;
+
+		if (system("udevadm control --reload-rules") != 0)
+			tst_resm(TWARN, "Can't update udev rules");
+	}
+
+	/* get current Linux version and make firmware paths */
+	struct utsname uts_name;
+	uname(&uts_name);
+	strcpy(fw_paths[0], "firmware");
+	strcpy(fw_paths[1], "firmware/updates");
+	snprintf(fw_paths[2], PATH_MAX, "firmware/%s", uts_name.release);
+	snprintf(fw_paths[3], PATH_MAX, "firmware/updates/%s",
+		uts_name.release);
+
+	/* copy firmware to direct firmware search paths */
+	create_firmware("/lib", DIRECT_LOAD);
+
+	/* save module path to mod_path */
+	SAFE_GETCWD(cleanup, mod_path, PATH_MAX);
+	int offset = strlen(mod_path);
+	snprintf(mod_path + offset, PATH_MAX - offset, "/%s", module_name);
+
+	tst_tmpdir();
+
+	char *cwd = get_tst_tmpdir();
+	snprintf(tmp_dir, PATH_MAX, cwd);
+	free(cwd);
+
+	/* replace udev's firmware search path in firmware.sh */
+	str_replace(udev_script, "/lib", tmp_dir);
+	fw_script_changed = 1;
+
+	/* create firmware in the udev firmware search paths */
+	create_firmware(tmp_dir, UDEV_LOAD);
+
+	/* make non-existent firmware file */
+	snprintf(fw[fw_num].file, PATH_MAX, "n%d_%s", fw_num, fw_name);
+	fw[fw_num].fake = 1;
+	fw[fw_num].mode = UDEV_LOAD;
+	++fw_num;
+}
+
+static void test_run()
+{
+	/* load test module */
+	char cmd[MAX_CMD_LEN];
+	snprintf(cmd, MAX_CMD_LEN,
+		"insmod %s fw_name=%s fw_num=%d fw_data=%s",
+		mod_path, fw_name, fw_num, fw_data);
+	if (system(cmd) != 0)
+		tst_brkm(TBROK, cleanup, "Failed to insert %s", module_name);
+	module_registered = 1;
+
+	/* get module results */
+	char dev_path[PATH_MAX];
+	snprintf(dev_path, PATH_MAX, "/sys/devices/%s/result", TCID);
+
+	int result = 0;
+	/* read result bit mask */
+	SAFE_FILE_SCANF(cleanup, dev_path, "%d", &result);
+
+	int i, fail;
+	for (i = 0; i < fw_num; ++i) {
+		fail = (result & (1 << i)) == 0 && !fw[i].fake;
+
+		tst_resm((fail) ? TFAIL : TPASS,
+			"Expect: %s load firmware '...%s', %s used",
+			(fw[i].fake) ? "can't" : "can",
+			fw[i].file + strlen(fw[i].dir),
+			(fw[i].mode == UDEV_LOAD) ? "udev" : "kernel");
+	}
+}
+
+static void cleanup(void)
+{
+	if (skip_cleanup)
+		return;
+
+	if (fw_rules_copied)
+		remove("/etc/udev/rules.d/50-firmware.rules");
+
+	if (fw_script_changed)
+		str_replace(udev_script, tmp_dir, "/lib");
+
+	int i;
+	for (i = fw_num - 1; i >= 0; --i) {
+		if (fw[i].remove_file && remove(fw[i].file) == -1)
+			tst_resm(TWARN, "Can't remove: %s", fw[i].file);
+
+		if (fw[i].remove_dir && remove(fw[i].dir) == -1)
+			tst_resm(TWARN, "Can't remove %s", fw[i].dir);
+	}
+
+	if (module_registered) {
+		char cmd[MAX_CMD_LEN];
+		snprintf(cmd, MAX_CMD_LEN, "rmmod %s", mod_path);
+		if (system(cmd) != 0)
+			tst_brkm(TBROK, NULL, "Can't remove %s", module_name);
+	}
+
+	tst_rmdir();
+	TEST_CLEANUP;
+}
+
+static void create_firmware(const char *path, int mode)
+{
+	int i;
+	for (i = 0; i < ARRAY_SIZE(fw_paths); ++i) {
+		struct fw_file_info *f = &fw[fw_num];
+		f->mode = mode;
+		snprintf(f->dir, PATH_MAX, "%s/%s", path, fw_paths[i]);
+		if (access(f->dir, X_OK) == -1) {
+			/* create dir */
+			SAFE_MKDIR(cleanup, f->dir, 0755);
+			f->remove_dir = mode == DIRECT_LOAD;
+		}
+
+		/* create test firmware file */
+		snprintf(f->file, PATH_MAX, "%s/n%d_%s",
+			f->dir, fw_num, fw_name);
+		SAFE_FILE_PRINTF(cleanup, f->file, fw_data);
+
+		f->remove_file = mode == DIRECT_LOAD;
+		++fw_num;
+	}
+}
+
+static void reg_path(char *dst, const char *src)
+{
+	const char *p = src;
+	while ((p = strchr(src, '/')) != NULL) {
+		int len = p - src;
+		strncpy(dst, src, len);
+		dst += len;
+		strcpy(dst, "\\/");
+		dst += 2;
+		src = p + 1;
+	}
+	strcpy(dst, src);
+}
+
+static void str_replace(const char *file, const char *old, const char *new)
+{
+	char cmd[MAX_CMD_LEN], reg_old[PATH_MAX], reg_new[PATH_MAX];
+
+	reg_path(reg_old, old);
+	reg_path(reg_new, new);
+
+	snprintf(cmd, MAX_CMD_LEN, "sed -i 's/%s/%s/g' %s",
+		reg_old, reg_new, file);
+	if (system(cmd) != 0)
+		tst_brkm(TBROK, cleanup, "Can't replace strings");
+}
-- 
1.7.1


------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. A cloud service to automate IT design, transition and operations
2. Dashboards that offer high-level views of enterprise services
3. A single system of record for all IT processes
http://p.sf.net/sfu/servicenow-d2d-j
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
