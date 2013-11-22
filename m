Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1Vjrko-0005cv-5I
	for ltp-list@lists.sourceforge.net; Fri, 22 Nov 2013 14:30:42 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vjrkk-0000QW-Og
	for ltp-list@lists.sourceforge.net; Fri, 22 Nov 2013 14:30:42 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rAMEUWiK028517
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 22 Nov 2013 14:30:33 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rAMEUVTd016675
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Fri, 22 Nov 2013 14:30:32 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rAMEUVuN024313
	for <ltp-list@lists.sourceforge.net>; Fri, 22 Nov 2013 14:30:31 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 22 Nov 2013 18:30:16 +0400
Message-Id: <1385130616-1415-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] device-drivers: uaccess: test access to user-space
	memory
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

Test checks kernel API to safely access user-space memory using
copy_to_user(), copy_from_user(), get_user(), put_user() functions.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/kernel/device-drivers/uaccess/.gitignore |    8 +
 testcases/kernel/device-drivers/uaccess/Makefile   |   33 +++++
 .../kernel/device-drivers/uaccess/ltp_uaccess.c    |  141 ++++++++++++++++++++
 .../kernel/device-drivers/uaccess/ltp_uaccess.h    |   33 +++++
 testcases/kernel/device-drivers/uaccess/uaccess.c  |  114 ++++++++++++++++
 5 files changed, 329 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/device-drivers/uaccess/.gitignore
 create mode 100644 testcases/kernel/device-drivers/uaccess/Makefile
 create mode 100644 testcases/kernel/device-drivers/uaccess/ltp_uaccess.c
 create mode 100644 testcases/kernel/device-drivers/uaccess/ltp_uaccess.h
 create mode 100644 testcases/kernel/device-drivers/uaccess/uaccess.c

diff --git a/testcases/kernel/device-drivers/uaccess/.gitignore b/testcases/kernel/device-drivers/uaccess/.gitignore
new file mode 100644
index 0000000..cf59b68
--- /dev/null
+++ b/testcases/kernel/device-drivers/uaccess/.gitignore
@@ -0,0 +1,8 @@
+/ltp_uaccess.ko
+/uaccess
+/*.mod.c
+/modules.order
+/.tmp_versions
+/.*.ko
+/.*.cmd
+/Module.symvers
diff --git a/testcases/kernel/device-drivers/uaccess/Makefile b/testcases/kernel/device-drivers/uaccess/Makefile
new file mode 100644
index 0000000..b0e50e8
--- /dev/null
+++ b/testcases/kernel/device-drivers/uaccess/Makefile
@@ -0,0 +1,33 @@
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
+ifneq ($(KERNELRELEASE),)
+
+obj-m := ltp_uaccess.o
+
+else
+
+top_srcdir	?= ../../../..
+include $(top_srcdir)/include/mk/testcases.mk
+
+REQ_VERSION_MAJOR	:= 2
+REQ_VERSION_PATCH	:= 6
+MAKE_TARGETS		:= uaccess ltp_uaccess.ko
+
+include $(top_srcdir)/include/mk/module.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+endif
diff --git a/testcases/kernel/device-drivers/uaccess/ltp_uaccess.c b/testcases/kernel/device-drivers/uaccess/ltp_uaccess.c
new file mode 100644
index 0000000..0847942
--- /dev/null
+++ b/testcases/kernel/device-drivers/uaccess/ltp_uaccess.c
@@ -0,0 +1,141 @@
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
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <asm-generic/uaccess.h>
+#include "ltp_uaccess.h"
+
+MODULE_AUTHOR("Alexey Kodanev <alexey.kodanev@oracle.com>");
+MODULE_DESCRIPTION("User-space access LTP test");
+MODULE_LICENSE("GPL");
+
+#define prk_err(fmt, ...) \
+	pr_err(DEV_NAME ": " fmt "\n", ##__VA_ARGS__)
+#define prk_info(fmt, ...) \
+	pr_info(DEV_NAME ": " fmt "\n", ##__VA_ARGS__)
+
+/*
+ * Test-case result,
+ * if test is passed, value will be set to 0
+ */
+static int test_result;
+
+static void device_release(struct device *dev)
+{
+	prk_info("device released");
+}
+
+static struct device tdev = {
+	.init_name	= DEV_NAME,
+	.release	= device_release
+};
+
+static ssize_t sys_result(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "%d\n", test_result);
+}
+static DEVICE_ATTR(result, S_IRUSR, sys_result, NULL);
+
+
+static ssize_t sys_tcase(struct device *dev,
+	struct device_attribute *attr,  const char *buf, size_t count)
+{
+	uintptr_t ptr = 0;
+	int tc = 0;
+	char *str, ch, buffer[str_size];
+	struct pt_regs *regs;
+
+	sscanf(buf, "%d %lu", &tc, &ptr);
+	str = (char *) ptr;
+	test_result = 0;
+
+	switch (tc) {
+	case TC_READ_USER:
+		if (copy_from_user(buffer, str, str_size))
+			prk_err("copy_from_user() failed");
+		test_result = (strncmp(user_str, buffer, str_size)) ? 1 : 0;
+		if (get_user(ch, str))
+			prk_err("get_user() failed");
+		test_result |= ch != user_str[0];
+	break;
+	case TC_WRITE_USER:
+		if (copy_to_user(str + 1, kern_str + 1, str_size - 1)) {
+			prk_err("copy_to_user() failed");
+			test_result = 1;
+		}
+		/* write the first skipped character */
+		if (put_user(kern_str[0], str)) {
+			prk_err("put_user() failed");
+			test_result |= 1;
+		}
+	break;
+	}
+
+	return count;
+}
+static DEVICE_ATTR(tcase, S_IWUSR, NULL, sys_tcase);
+
+static int uaccess_init(void)
+{
+	int err = 0;
+	prk_info("Starting module");
+
+	err = device_register(&tdev);
+	if (err) {
+		prk_err("Unable to register device");
+		goto err0;
+	}
+	prk_info("device registered");
+
+	err = device_create_file(&tdev, &dev_attr_result);
+	if (err) {
+		prk_err("Can't create sysfs file 'result'");
+		goto err1;
+	}
+
+	err = device_create_file(&tdev, &dev_attr_tcase);
+	if (err) {
+		prk_err(": Can't create sysfs file 'tc'");
+		goto err2;
+	}
+
+	return 0;
+
+err2:
+	device_remove_file(&tdev, &dev_attr_result);
+err1:
+	device_unregister(&tdev);
+err0:
+	return err;
+}
+module_init(uaccess_init)
+
+static void uaccess_exit(void)
+{
+	prk_info("Unloading module");
+
+	device_remove_file(&tdev, &dev_attr_result);
+	device_remove_file(&tdev, &dev_attr_tcase);
+	device_unregister(&tdev);
+}
+module_exit(uaccess_exit)
diff --git a/testcases/kernel/device-drivers/uaccess/ltp_uaccess.h b/testcases/kernel/device-drivers/uaccess/ltp_uaccess.h
new file mode 100644
index 0000000..7b16680
--- /dev/null
+++ b/testcases/kernel/device-drivers/uaccess/ltp_uaccess.h
@@ -0,0 +1,33 @@
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
+ */
+
+#ifndef LTP_UACCESS_H
+#define LTP_UACCESS_H
+
+#define DEV_NAME "ltp_uaccess"
+
+static const char user_str[]	= "User Data";
+static const char kern_str[]	= "Kern Data";
+static const int str_size	= 10;
+
+enum {
+	TC_READ_USER = 0,
+	TC_WRITE_USER
+};
+
+#endif /* LTP_UACCESS_H */
diff --git a/testcases/kernel/device-drivers/uaccess/uaccess.c b/testcases/kernel/device-drivers/uaccess/uaccess.c
new file mode 100644
index 0000000..8c14e3b
--- /dev/null
+++ b/testcases/kernel/device-drivers/uaccess/uaccess.c
@@ -0,0 +1,114 @@
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
+ *
+ * Test checks kernel API to safely access user-space memory using
+ * copy_to_user(), copy_from_user(), get_user(), put_user() functions.
+ *
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "tst_module.h"
+#include "safe_macros.h"
+#include "safe_stdio.h"
+
+#include "ltp_uaccess.h"
+
+char *TCID = DEV_NAME;
+
+static const char dev_result[]	= "/sys/devices/" DEV_NAME "/result";
+static const char dev_tcase[]	= "/sys/devices/" DEV_NAME "/tcase";
+static const char module_name[]	= DEV_NAME ".ko";
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
+static int set_ptr_to_sysfs(int id, const void *ptr, const char *descr)
+{
+	int res;
+	tst_resm(TINFO, "TC %d: %s, ptr '%p'", id, descr, ptr);
+	SAFE_FILE_PRINTF(cleanup, dev_tcase, "%d %lu", id, (intptr_t) ptr);
+	SAFE_FILE_SCANF(cleanup, dev_result, "%d", &res);
+	return res;
+}
+
+/*
+ * Can read user-space using copy_from_user(), get_user().
+ */
+static void tc_read_userspace(void)
+{
+	int res = set_ptr_to_sysfs(TC_READ_USER, user_str,
+		"can read user-space data from kernel");
+
+	tst_resm(res, "copy_from_user(), get_user(): data%smatch",
+		(res) ? " don't " : " ");
+}
+
+/*
+ * Can write data from kernel-space to user-space
+ * using copy_to_user(), put_user().
+ */
+static void tc_write_userspace(void)
+{
+	char buf[str_size];
+	memset(buf, 0, str_size);
+
+	int res = set_ptr_to_sysfs(TC_WRITE_USER, buf,
+		"can write data from kernel to user-space");
+	tst_resm(res, "write data from kernel-space");
+	res = (strncmp(buf, kern_str, str_size)) ? 1 : 0;
+	tst_resm(res, "copy_to_user(), put_user(): data%smatch",
+		(res) ? " don't " : " ");
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
+	tc_read_userspace();
+	tc_write_userspace();
+
+	cleanup();
+	tst_exit();
+}
-- 
1.7.1


------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
