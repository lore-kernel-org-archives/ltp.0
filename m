Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1UoZ4g-0002qT-Na
	for ltp-list@lists.sourceforge.net; Mon, 17 Jun 2013 13:02:22 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UoZ4e-0006Yh-Qv
	for ltp-list@lists.sourceforge.net; Mon, 17 Jun 2013 13:02:22 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r5HD2B8x017954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 17 Jun 2013 13:02:12 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r5HD2C5h009126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 17 Jun 2013 13:02:13 GMT
Received: from abhmt108.oracle.com (abhmt108.oracle.com [141.146.116.60])
	by userz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r5HD2CmR014640
	for <ltp-list@lists.sourceforge.net>; Mon, 17 Jun 2013 13:02:12 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 17 Jun 2013 17:01:37 +0400
Message-Id: <1371474097-17589-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH v3] fw_load: new test of device firmware loading
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

This test checks the device firmware loading. Since Linux 3.7 it can be loaded
directly (by-pass udev). The test consists of the two parts: userspace and
kernelspace.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/syscalls                                   |    2 +
 testcases/kernel/Makefile                          |    1 +
 testcases/kernel/firmware/Makefile                 |   45 ++++
 .../kernel/firmware/fw_load_kernel/.gitignore      |    1 +
 testcases/kernel/firmware/fw_load_kernel/Makefile  |   37 +++
 testcases/kernel/firmware/fw_load_kernel/README    |   16 ++
 testcases/kernel/firmware/fw_load_kernel/fw_load.c |  173 ++++++++++++++
 testcases/kernel/firmware/fw_load_user/.gitignore  |    1 +
 testcases/kernel/firmware/fw_load_user/Makefile    |   20 ++
 testcases/kernel/firmware/fw_load_user/README      |   11 +
 testcases/kernel/firmware/fw_load_user/fw_load.c   |  242 ++++++++++++++++++++
 11 files changed, 549 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/firmware/Makefile
 create mode 100644 testcases/kernel/firmware/fw_load_kernel/.gitignore
 create mode 100644 testcases/kernel/firmware/fw_load_kernel/Makefile
 create mode 100644 testcases/kernel/firmware/fw_load_kernel/README
 create mode 100644 testcases/kernel/firmware/fw_load_kernel/fw_load.c
 create mode 100644 testcases/kernel/firmware/fw_load_user/.gitignore
 create mode 100644 testcases/kernel/firmware/fw_load_user/Makefile
 create mode 100644 testcases/kernel/firmware/fw_load_user/README
 create mode 100644 testcases/kernel/firmware/fw_load_user/fw_load.c

diff --git a/runtest/syscalls b/runtest/syscalls
index e6ce29c..c11379c 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -314,6 +314,8 @@ ftruncate04_64 ftruncate04.sh 64
 #futimesat test cases
 futimesat01 futimesat01
 
+fw_load fw_load
+
 getcontext01 getcontext01
 
 getcpu01 getcpu01
diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
index 4b4800d..256a574 100644
--- a/testcases/kernel/Makefile
+++ b/testcases/kernel/Makefile
@@ -38,6 +38,7 @@ ifneq ($(UCLINUX),1)
 SUBDIRS			+= connectors \
 			   containers \
 			   controllers \
+			   firmware \
 			   fs \
 			   hotplug \
 			   io \
diff --git a/testcases/kernel/firmware/Makefile b/testcases/kernel/firmware/Makefile
new file mode 100644
index 0000000..f6db454
--- /dev/null
+++ b/testcases/kernel/firmware/Makefile
@@ -0,0 +1,45 @@
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
+top_srcdir	?= ../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+SUBDIRS			=
+PROCEED			= 0
+REQ_VERSION_MAJOR	= 3
+REQ_VERSION_MINOR	= 7
+
+ifeq ($(MAKECMDGOALS),clean)
+proceed = 1
+endif
+
+ifeq ($(WITH_MODULES),yes)
+proceed = $(shell expr $(LINUX_VERSION_MAJOR) '>' $(REQ_VERSION_MAJOR))
+ifeq ($(proceed),0)
+proceed = $(shell expr $(LINUX_VERSION_MAJOR) '=' $(REQ_VERSION_MAJOR))
+ifeq ($(proceed),1)
+proceed = $(shell expr $(LINUX_PATCHLEVEL) '>=' $(REQ_VERSION_MINOR))
+endif
+endif
+endif
+
+ifeq ($(proceed),1)
+SUBDIRS			+= fw_load_kernel
+SUBDIRS			+= fw_load_user
+endif
+
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
index 0000000..e8d12be
--- /dev/null
+++ b/testcases/kernel/firmware/fw_load_kernel/Makefile
@@ -0,0 +1,37 @@
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
+	-$(MAKE) -C $(LINUX_DIR) M=$(abs_srcdir)
+	-mv $(MODULE).ko $(MODULE).ko~
+	-$(MAKE) -C $(LINUX_DIR) M=$(abs_srcdir) clean
+	-mv $(MODULE).ko~ $(MODULE).ko
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+endif
diff --git a/testcases/kernel/firmware/fw_load_kernel/README b/testcases/kernel/firmware/fw_load_kernel/README
new file mode 100644
index 0000000..320d956
--- /dev/null
+++ b/testcases/kernel/firmware/fw_load_kernel/README
@@ -0,0 +1,16 @@
+The aim of the test is to check device firmware loading. Since kernel 3.7
+firmware loading changed to direct loading (by-pass udev). The test consists
+of the two parts:
+ - userspace part
+ - kernelspace part
+
+This is a kernel module, which is a part of the device firmware loading test.
+It allows to call request_firmware kernel function with specified parameters.
+Template firmware file name and expected firmware file's data size are passed
+as the insmod command line parameters. Then, the number of firmware test files
+should be written to sysfs file 'fwnum'. This write will initiate request
+firmware procedure. In the end, results can be read from 'result' device sysfs
+file. Also, some information regarding module loading, can be obtained by
+looking at kernel log file.
+
+It is automatically used by userspace part of the test.
diff --git a/testcases/kernel/firmware/fw_load_kernel/fw_load.c b/testcases/kernel/firmware/fw_load_kernel/fw_load.c
new file mode 100644
index 0000000..2da9517
--- /dev/null
+++ b/testcases/kernel/firmware/fw_load_kernel/fw_load.c
@@ -0,0 +1,173 @@
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
+ * Author:
+ * Alexey Kodanev <alexey.kodanev@oracle.com>
+ *
+ * This module is trying to load external test firmware files (n#_load_tst.fw).
+ * In the end, it writes results to /sys/devices/fw_load/result file.
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
+MODULE_DESCRIPTION("This module is checking device firmware loading");
+
+#define TCID		"fw_load"
+
+static char *fw_name	= "load_tst.fw";
+static int fw_size	= 0x1000;
+static int max_name	= 64;
+static int fw;
+
+module_param(fw_name, charp, 0444);
+MODULE_PARM_DESC(fw_name, "Template firmware file name: n#_name");
+
+module_param(fw_size, int, 0444);
+MODULE_PARM_DESC(fw_size, "Firmware file size");
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
+/*
+ * get the number of firmware files and
+ * perform firmware requests
+ */
+static ssize_t sys_fwnum(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count);
+static DEVICE_ATTR(fwnum, S_IWUSR, NULL, sys_fwnum);
+
+static int test_init(void)
+{
+	int err;
+
+	err = device_register(&tdev);
+	if (err) {
+		pr_err(TCID ": Unable to register device\n");
+		return err;
+	}
+	pr_info(TCID ": device registered\n");
+
+	err = device_create_file(&tdev, &dev_attr_result);
+	if (err != 0)
+		pr_info(TCID ": Can't create sysfs file 'result'\n");
+	err = device_create_file(&tdev, &dev_attr_fwnum);
+	if (err != 0)
+		pr_info(TCID ": Can't create sysfs file 'fwnum'\n");
+
+	return err;
+}
+
+static void test_exit(void)
+{
+	device_remove_file(&tdev, &dev_attr_result);
+	device_remove_file(&tdev, &dev_attr_fwnum);
+
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
+static ssize_t sys_fwnum(struct device *dev,
+	struct device_attribute *attr,  const char *buf, size_t count)
+{
+	int err, fw_num = 0;
+
+	sscanf(buf, "%d", &fw_num);
+	if (fw_num <= 0) {
+		pr_err(TCID ": Unexpected number of firmwares '%d'", fw_num);
+		return count;
+	}
+	for (fw = 0; fw < fw_num; ++fw) {
+		char name[max_name];
+		snprintf(name, max_name, "n%d_%s", fw, fw_name);
+		err = try_request_fw(name);
+		test_result |= (err == 0) << fw;
+	}
+	return count;
+}
+
+static int fw_read(const u8 *data, size_t size)
+{
+	size_t i;
+	pr_info(TCID ": Firmware has size '%d'\n", (unsigned int) size);
+	if (size != fw_size) {
+		pr_err(TCID ": Expected firmware size '%d'\n",
+		(unsigned int) fw_size);
+		return -1;
+	}
+	for (i = 0; i < size; ++i) {
+		if (data[i] != (u8)fw) {
+			pr_err(TCID ": Unexpected firmware data\n");
+			return -1;
+		}
+	}
+	return 0;
+}
+
+static int try_request_fw(const char *name)
+{
+	int err;
+	const struct firmware *fw_entry = NULL;
+	err = request_firmware(&fw_entry, name, &tdev);
+	if (!err) {
+		pr_info(TCID ": firmware '%s' requested\n", name);
+		err = fw_read(fw_entry->data, fw_entry->size);
+	} else
+		pr_err(TCID ": Can't request firmware '%s'\n", name);
+	release_firmware(fw_entry);
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
index 0000000..effd5da
--- /dev/null
+++ b/testcases/kernel/firmware/fw_load_user/Makefile
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
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/firmware/fw_load_user/README b/testcases/kernel/firmware/fw_load_user/README
new file mode 100644
index 0000000..702fac9
--- /dev/null
+++ b/testcases/kernel/firmware/fw_load_user/README
@@ -0,0 +1,11 @@
+The aim of the test is to check device firmware loading. Since kernel 3.7
+firmware loading changed to direct loading (by-pass udev). The test consists
+of the two parts:
+ - userspace part
+ - kernelspace part
+
+This is the userspace part, its tasks are:
+ - create firmware files in the standard firmware paths
+ - load the module and initiate firmware request procedure
+ - read device's result file and print final results
+ - unload the module.
diff --git a/testcases/kernel/firmware/fw_load_user/fw_load.c b/testcases/kernel/firmware/fw_load_user/fw_load.c
new file mode 100644
index 0000000..943f793
--- /dev/null
+++ b/testcases/kernel/firmware/fw_load_user/fw_load.c
@@ -0,0 +1,242 @@
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
+ * Author:
+ * Alexey Kodanev <alexey.kodanev@oracle.com>
+ *
+ * Test checks device firmware loading.
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
+#define FW_FILES	5
+
+char *TCID = "fw_load";
+int TST_TOTAL = FW_FILES;
+
+#define MAX_CMD_LEN	256
+/* hard coded paths in the kernel */
+#define FW_PATHS_NUM	4
+
+static int fw_size = 0x1000;
+
+static const char fw_name[]	= "load_tst.fw";
+static const char module_name[]	= "fw_load.ko";
+
+struct fw_file_info {
+	char file[PATH_MAX];
+	char dir[PATH_MAX];
+	int fake;
+	int remove_dir;
+	int remove_file;
+};
+
+static struct fw_file_info fw[FW_FILES];
+static int fw_num;
+
+/* related firmware paths which are searched by kernel */
+static char fw_paths[FW_PATHS_NUM][PATH_MAX];
+
+/* cleanup flags */
+static int module_registered;
+
+/* test options */
+static char *narg;
+static int nflag;
+static int skip_cleanup;
+static int verbose;
+static const option_t options[] = {
+	{"n:", &nflag, &narg},
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
+ */
+static void create_firmware(const char *path);
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
+	printf("  -n x    Write x bytes to firmware file, default is %d\n",
+		fw_size);
+	printf("  -s      Skip cleanup\n");
+	printf("  -v      Verbose\n");
+}
+
+void setup(int argc, char *argv[])
+{
+	char *msg;
+	msg = parse_opts(argc, argv, options, help);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	if (nflag) {
+		if (sscanf(narg, "%i", &fw_size) != 1)
+			tst_brkm(TBROK, NULL, "-n option arg is not a number");
+		if (fw_size < 0)
+			tst_brkm(TBROK, NULL, "-n option arg is less than 0");
+	}
+
+	tst_require_root(NULL);
+
+	if (tst_kvercmp(3, 7, 0) < 0) {
+		tst_brkm(TCONF, NULL,
+			"Test must be run with kernel 3.7 or newer");
+	}
+
+	if (access(module_name, F_OK) == -1) {
+		tst_brkm(TCONF, NULL,
+			"Test requires kernel module '%s'", module_name);
+	}
+
+	tst_sig(FORK, DEF_HANDLER, cleanup);
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
+	/* copy firmware to hard coded firmware search paths */
+	create_firmware("/lib");
+
+	/* make non-existent firmware file */
+	snprintf(fw[fw_num].file, PATH_MAX, "n%d_%s", fw_num, fw_name);
+	fw[fw_num].fake = 1;
+	++fw_num;
+}
+
+static void test_run()
+{
+	/* load test module */
+	char cmd[MAX_CMD_LEN];
+	snprintf(cmd, MAX_CMD_LEN, "insmod %s fw_name=%s fw_size=%d",
+		module_name, fw_name, fw_size);
+	if (system(cmd) != 0)
+		tst_brkm(TBROK, cleanup, "Failed to insert %s", module_name);
+	module_registered = 1;
+
+	char dev_path[PATH_MAX];
+	/* set number of testing firmware files to module */
+	snprintf(dev_path, PATH_MAX, "/sys/devices/%s/fwnum", TCID);
+	SAFE_FILE_PRINTF(cleanup, dev_path, "%d", fw_num);
+
+	/* get module results */
+	snprintf(dev_path, PATH_MAX, "/sys/devices/%s/result", TCID);
+	int result = 0;
+	/* read result bit mask */
+	SAFE_FILE_SCANF(cleanup, dev_path, "%d", &result);
+
+	int i, fail;
+	for (i = 0; i < fw_num; ++i) {
+		fail = (result & (1 << i)) == 0 && !fw[i].fake;
+
+		tst_resm((fail) ? TFAIL : TPASS,
+			"Expect: %s load firmware '...%s'",
+			(fw[i].fake) ? "can't" : "can",
+			fw[i].file + strlen(fw[i].dir));
+	}
+}
+
+static void cleanup(void)
+{
+	if (skip_cleanup)
+		return;
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
+		snprintf(cmd, MAX_CMD_LEN, "rmmod %s", module_name);
+		if (system(cmd) != 0)
+			tst_brkm(TBROK, NULL, "Can't remove %s", module_name);
+	}
+
+	TEST_CLEANUP;
+}
+
+static void create_firmware(const char *path)
+{
+	int i;
+	for (i = 0; i < ARRAY_SIZE(fw_paths); ++i) {
+		struct fw_file_info *f = &fw[fw_num];
+		snprintf(f->dir, PATH_MAX, "%s/%s", path, fw_paths[i]);
+		if (access(f->dir, X_OK) == -1) {
+			/* create dir */
+			SAFE_MKDIR(cleanup, f->dir, 0755);
+			f->remove_dir = 1;
+		}
+
+		/* create test firmware file */
+		snprintf(f->file, PATH_MAX, "%s/n%d_%s",
+			f->dir, fw_num, fw_name);
+
+		FILE *fd = fopen(f->file, "w");
+		if (fd == NULL)
+			tst_brkm(TBROK, cleanup, "Failed to create firmware");
+		int k;
+		for (k = 0; k < fw_size; ++k)
+			fputc(fw_num, fd);
+		fclose(fd);
+
+		f->remove_file = 1;
+		++fw_num;
+	}
+}
-- 
1.7.1


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
