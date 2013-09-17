Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1VLtpm-0004Am-Fw
	for ltp-list@lists.sourceforge.net; Tue, 17 Sep 2013 11:52:46 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VLtpi-0002zn-I6
	for ltp-list@lists.sourceforge.net; Tue, 17 Sep 2013 11:52:46 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r8HBqZv7002655
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 17 Sep 2013 11:52:36 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r8HBqY4S017017
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 17 Sep 2013 11:52:35 GMT
Received: from abhmt114.oracle.com (abhmt114.oracle.com [141.146.116.66])
	by userz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r8HBqY4a025574
	for <ltp-list@lists.sourceforge.net>; Tue, 17 Sep 2013 11:52:34 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 17 Sep 2013 15:52:00 +0400
Message-Id: <1379418720-26529-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH v3 2/2] device-drivers: block: fixes
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2677244583561671380=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com, Alexey Kodanev <alexey.kodanev@oracle.com>

--===============2677244583561671380==

Fixed test-cases behavior: major number greater than 255 is valid,
empty device name is valid.
Added test-cases results and sysfs files.
Added user-space program which checks each test-case result.
Added command line parameter 'a': run all test-cases.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/kernel/device-drivers/block/Makefile     |   30 ++
 testcases/kernel/device-drivers/block/README       |    8 +-
 .../block/block_dev_kernel/.gitignore              |    7 +
 .../device-drivers/block/block_dev_kernel/Makefile |   48 ++-
 .../block/block_dev_kernel/ltp_block_dev.c         |  423 ++++++++++++-------
 .../device-drivers/block/block_dev_user/.gitignore |    1 +
 .../device-drivers/block/block_dev_user/Makefile   |   20 +
 .../block/block_dev_user/block_dev.c               |  111 +++++
 8 files changed, 463 insertions(+), 185 deletions(-)
 create mode 100644 testcases/kernel/device-drivers/block/Makefile
 create mode 100644 testcases/kernel/device-drivers/block/block_dev_kernel/.gitignore
 create mode 100644 testcases/kernel/device-drivers/block/block_dev_user/.gitignore
 create mode 100644 testcases/kernel/device-drivers/block/block_dev_user/Makefile
 create mode 100644 testcases/kernel/device-drivers/block/block_dev_user/block_dev.c

diff --git a/testcases/kernel/device-drivers/block/Makefile b/testcases/kernel/device-drivers/block/Makefile
new file mode 100644
index 0000000..455354f
--- /dev/null
+++ b/testcases/kernel/device-drivers/block/Makefile
@@ -0,0 +1,30 @@
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
+
+SUBDIRS		= block_dev_user
+
+SKIP		= $(shell test "$(MAKECMDGOALS)" = "clean" -o \
+	"$(WITH_MODULES)" = "yes"; echo $$?)
+
+ifeq ($(SKIP),0)
+SUBDIRS		+= block_dev_kernel
+endif
+
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/device-drivers/block/README b/testcases/kernel/device-drivers/block/README
index 6833efd..812436b 100644
--- a/testcases/kernel/device-drivers/block/README
+++ b/testcases/kernel/device-drivers/block/README
@@ -3,8 +3,8 @@ Module under test: linux/block/genhd.c
 
   Function                    | Declared in   | Tested in
  -----------------------------+---------------+---------------
-  register_blkdev()           | linux/fs.h    | test_blkdev.c
-  unregister_blkdev()         | linux/fs.h    | test_blkdev.c
+  register_blkdev()           | linux/fs.h    | ltp_block_dev.c
+  unregister_blkdev()         | linux/fs.h    | ltp_block_dev.c
   blk_register_region()       | linux/genhd.h |
   blk_unregister_region()     | linux/genhd.h |
   add_disk()                  | linux/genhd.h |
@@ -21,7 +21,3 @@ Module under test: linux/block/genhd.c
 
 For possible test results please see "A POSIX conforming test framework" at
 http://www.gnu.org/software/dejagnu/manual/x47.html#posix
-
-TODO
-----
- - Automatically evaluate test results
diff --git a/testcases/kernel/device-drivers/block/block_dev_kernel/.gitignore b/testcases/kernel/device-drivers/block/block_dev_kernel/.gitignore
new file mode 100644
index 0000000..3beebe1
--- /dev/null
+++ b/testcases/kernel/device-drivers/block/block_dev_kernel/.gitignore
@@ -0,0 +1,7 @@
+/ltp_block_dev.ko
+/*.mod.c
+/modules.order
+/.tmp_versions
+/.*.ko
+/.*.cmd
+/Module.symvers
diff --git a/testcases/kernel/device-drivers/block/block_dev_kernel/Makefile b/testcases/kernel/device-drivers/block/block_dev_kernel/Makefile
index 10f33a7..2a23c97 100644
--- a/testcases/kernel/device-drivers/block/block_dev_kernel/Makefile
+++ b/testcases/kernel/device-drivers/block/block_dev_kernel/Makefile
@@ -1,24 +1,26 @@
-
-EXTRA_CFLAGS += -Wall -W -Wno-unused-parameter
-
-ifneq ($(KERNELRELEASE),)
-
-obj-m	:= test_block.o test_genhd.o
-else
-KDIR	:= /lib/modules/$(shell uname -r)/build
-PWD	:= $(shell pwd)
-
-modules:
-	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
-
-clean:
-	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) clean
-	rm -f modules.order
-
-help:
-	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) help
-
-modules_install:
-	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules_install
-
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
+top_srcdir	?= ../../../../..
+abs_srcdir	?= .
+
+MODULE_NAMES	:= ltp_block_dev
+
+include $(abs_srcdir)/$(top_srcdir)/include/mk/module.mk
+
+ifeq ($(KERNELRELEASE),)
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
 endif
diff --git a/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_dev.c b/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_dev.c
index 3048e09..a08534a 100644
--- a/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_dev.c
+++ b/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_dev.c
@@ -1,15 +1,21 @@
-
 /*
- * Module under test: linux/block/genhd.c
+ * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
  *
- * Only those functions are tested here which are declared in <linux/fs.h>
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  *
- * Usage:
- *   1. make
- *   2. su
- *   3. insmod ./test_block.ko
- *   4. Check the test results in "dmesg"
- *   5. rmmod test_block
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ * Only those functions are tested here which are declared in <linux/fs.h>
  *
  * Changes:
  * 16 Jan 2009  0.2  Added "tc" parameter to run test cases separately
@@ -17,20 +23,23 @@
  */
 
 #include <linux/module.h>
+#include <linux/device.h>
 #include <linux/fs.h>
 
-static unsigned int __initdata tc;
-module_param_named(tc, tc, int, 0);
-MODULE_PARM_DESC(tc,
-		 "Test Case to run. Default is 0 which means that run all tests.");
-
 MODULE_AUTHOR("M��rton N��meth <nm127@freemail.hu>");
 MODULE_DESCRIPTION("Test block drivers");
 MODULE_LICENSE("GPL");
 
-#define BLK_DEV_NAME		"test_block"
+#define BLK_DEV_NAME		"ltp_block_dev"
 #define MAX_MAJOR		255
 
+#define prk_err(fmt, ...) \
+	pr_err(BLK_DEV_NAME ": " fmt, ##__VA_ARGS__)
+#define prk_info(fmt, ...) \
+	pr_info(BLK_DEV_NAME ": " fmt, ##__VA_ARGS__)
+#define prk_debug(fmt, ...) \
+	pr_debug(BLK_DEV_NAME ": " fmt, ##__VA_ARGS__)
+
 /*
  * Analysis of "int register_blkdev(unsigned int major, const char *name)"
  *
@@ -40,271 +49,373 @@ MODULE_LICENSE("GPL");
  *  -----------+--------------------------+---------+-------------
  *  major      | [0]                      | valid   | tc01, tc02
  *             |--------------------------+---------+-------------
- *             | [1..255]                 | valid   | tc05
+ *             | [1..255]                 | valid   | tc03
  *             |--------------------------+---------+-------------
- *             | [256..UINT_MAX]          | invalid | tc03, tc04
+ *             | [256..UINT_MAX]          | valid   | tc04, tc05
  *  -----------+--------------------------+---------+-------------
  *  name       | [valid pointer to a zero |         |
  *             |  terminated string]      | valid   | tc01, tc02
  *             |--------------------------+---------+-------------
  *             | [valid pointer to a zero |         |
- *             |  length zero terminated  | invalid | tc06
+ *             |  length zero terminated  | valid   | tc06
  *             |  string]                 |         |
  *             |--------------------------+---------+-------------
- *             | [NULL]                   | invalid | tc07
+ *             | [NULL]                   | invalid | tc08, tc09
  *  -----------+--------------------------+---------+-------------
  *
  */
 
-static void tc01(void)
+#define result_str(pass) ((pass == 0) ? ("FAIL") : ("PASS"))
+
+/*
+ * bit mask for each test-case,
+ * if test is passed, bit will be set to 1
+ */
+static int test_result;
+
+static void device_release(struct device *dev)
 {
-	int major1;
-	int major2;
+	prk_info("device released\n");
+}
+
+static struct device tdev = {
+	.init_name	= BLK_DEV_NAME,
+	.release	= device_release,
+};
 
-	printk(KERN_INFO
-	       "Test Case 1: register_blkdev() with auto allocating major numbers (major=0)\n");
+static int tc01(void)
+{
+	int major1, major2;
+	int pass = 1;
+
+	prk_info("Test Case 1: register_blkdev() with auto allocating "
+		"major numbers (major=0)\n");
 
 	major1 = register_blkdev(0, BLK_DEV_NAME);
-	printk(KERN_DEBUG "major1 = %i\n", major1);
+	prk_debug("major1 = %i\n", major1);
 
 	major2 = register_blkdev(0, BLK_DEV_NAME);
-	printk(KERN_DEBUG "major2 = %i\n", major2);
+	prk_debug("major2 = %i\n", major2);
 
-	if (0 < major1) {
+	if (major1 >= 0)
 		unregister_blkdev(major1, BLK_DEV_NAME);
-	} else {
-		printk(KERN_DEBUG
-		       "first call to register_blkdev() failed with error %i\n",
-		       major1);
+	else {
+		pass = 0;
+		prk_debug("1st call to register_blkdev() failed, error %i\n",
+			major1);
 	}
 
-	if (0 < major2) {
+	if (major2 >= 0)
 		unregister_blkdev(major2, BLK_DEV_NAME);
-	} else {
-		printk(KERN_DEBUG
-		       "second call to register_blkdev() failed with error %i\n",
-		       major2);
+	else {
+		pass = 0;
+		prk_debug("2nd call to register_blkdev() failed, error %i\n",
+			major2);
 	}
 
-	printk(KERN_INFO "Test Case 1: UNRESLOVED\n");
+	prk_info("Test Case Result: %s\n", result_str(pass));
+	return pass;
 }
 
-static void tc02(void)
+static int tc02(void)
 {
 	int major[MAX_MAJOR + 1];
-	int i;
+	int i, pass = 2;
 
-	/* Try to allocate block devices until all major number are used. After this
-	 * register_blkdev() should return -EBUSY
+	/* Try to allocate block devices until all major numbers are used.
+	 * After this register_blkdev() should return -EBUSY
 	 */
 
-	printk(KERN_INFO
-	       "Test Case 2: stress test of register_blkdev() with auto allocating major numbers (major=0)\n");
+	prk_info("Test Case 2: stress test of register_blkdev() "
+		"with auto allocating major numbers (major=0)\n");
 
 	memset(major, 0, sizeof(major));
 
-	for (i = 0; i < sizeof(major) / sizeof(*major); i++) {
+	for (i = 0; i < sizeof(major) / sizeof(*major); ++i) {
 		major[i] = register_blkdev(0, BLK_DEV_NAME);
-		printk(KERN_DEBUG "major[%i] = %i\n", i, major[i]);
-		if (major[i] <= 0 && major[i] != -EBUSY) {
-			printk(KERN_INFO
-			       "unexpected return value from register_blkdev(): %i\n",
-			       major[i]);
-		}
-		if (major[i] < 0) {
-			printk(KERN_DEBUG
-			       "register_blkdev() failed with error %i\n",
-			       major[i]);
+		prk_debug("major[%i] = %i\n", i, major[i]);
+
+		if (major[i] == -EBUSY) {
+			prk_info("device is busy, register_blkdev() ret %i\n",
+				major[i]);
+		} else if (major[i] < 0) {
+			prk_debug("register_blkdev() failed with error %i\n",
+				major[i]);
+			pass = 0;
 		}
 	}
 
-	for (i = 0; i < sizeof(major) / sizeof(*major); i++) {
-		if (0 < major[i]) {
+	for (i = 0; i < sizeof(major) / sizeof(*major); ++i) {
+		if (major[i] >= 0)
 			unregister_blkdev(major[i], BLK_DEV_NAME);
-			major[i] = 0;
-		}
 	}
 
-	printk(KERN_INFO "Test Case 2: UNRESLOVED\n");
+	prk_info("Test Case Result: %s\n", result_str(pass));
+	return pass;
 }
 
-static void tc03(void)
+static int tc03(void)
 {
-	int major;
+	int major, major2, major3;
+	int pass = 4;
 
-	printk(KERN_INFO "Test Case 3: register_blkdev() with major=256\n");
+	prk_info("Test Case 3: register_blkdev() with major != 0\n");
 
-	major = register_blkdev(256, BLK_DEV_NAME);
-	printk(KERN_DEBUG "major = %i\n", major);
+	/* autosearch for a free major number */
+	major = register_blkdev(0, BLK_DEV_NAME);
+	prk_debug("major = %i\n", major);
 
-	if (0 < major) {
+	if (major > 0) {
 		unregister_blkdev(major, BLK_DEV_NAME);
+
+		/* expected to return 0 */
+		major2 = register_blkdev(major, BLK_DEV_NAME);
+
+		/* this call has to fail with EBUSY return value */
+		major3 = register_blkdev(major, BLK_DEV_NAME);
+
+		if (major2 == 0)
+			unregister_blkdev(major, BLK_DEV_NAME);
+		else {
+			pass = 0;
+			prk_debug("1st call to register_blkdev() with major=%i "
+				"failed with error %i\n", major, major2);
+		}
+
+		if (major3 == 0) {
+			unregister_blkdev(major, BLK_DEV_NAME);
+			pass = 0;
+		} else {
+			if (major3 != -EBUSY)
+				pass = 0;
+			prk_debug("2nd call to register_blkdev() with major=%i "
+				"failed with error %i\n", major, major3);
+		}
+
 	} else {
-		printk(KERN_DEBUG "register_blkdev() failed with error %i\n",
-		       major);
+		pass = 0;
+		prk_debug("register_blkdev() failed with error %i\n", major);
 	}
 
-	printk(KERN_INFO "Test Case 3: UNRESLOVED\n");
+	prk_info("Test Case Result: %s\n", result_str(pass));
+	return pass;
 }
 
-static void tc04(void)
+static int tc04(void)
 {
-	int major;
+	int major, pass = 8;
 
-	printk(KERN_INFO "Test Case 4: register_blkdev() with major=%u\n",
-	       UINT_MAX);
+	prk_info("Test Case 4: register_blkdev() with major=256\n");
 
-	major = register_blkdev(UINT_MAX, BLK_DEV_NAME);
-	printk(KERN_DEBUG "major = %i\n", major);
+	major = register_blkdev(256, BLK_DEV_NAME);
+	prk_debug("major = %i\n", major);
 
-	if (0 < major) {
-		unregister_blkdev(major, BLK_DEV_NAME);
+	if (major == 0) {
+		unregister_blkdev(256, BLK_DEV_NAME);
 	} else {
-		printk(KERN_DEBUG "register_blkdev() failed with error %i\n",
-		       major);
+		pass = 0;
+		prk_debug("register_blkdev() failed with error %i\n", major);
 	}
 
-	printk(KERN_INFO "Test Case 4: UNRESLOVED\n");
+	prk_info("Test Case Result: %s\n", result_str(pass));
+	return pass;
 }
 
-static void tc05(void)
+static int tc05(void)
 {
-	int major;
-	int major2;
-	int major3;
+	int major, pass = 16;
 
-	printk(KERN_INFO "Test Case 5: register_blkdev() with major != 0\n");
+	prk_info("Test Case 5: register_blkdev() with major=%u\n", UINT_MAX);
 
-	/* autosearch for a free major number */
-	major = register_blkdev(0, BLK_DEV_NAME);
-	printk(KERN_DEBUG "major = %i\n", major);
+	major = register_blkdev(UINT_MAX, BLK_DEV_NAME);
+	prk_debug("major = %i\n", major);
+
+	if (major == 0)
+		unregister_blkdev(UINT_MAX, BLK_DEV_NAME);
+	else {
+		prk_debug("reg blkdev with major %d failed with error %i\n",
+			UINT_MAX, major);
+		pass = 0;
+	}
 
-	if (0 < major) {
-		unregister_blkdev(major, BLK_DEV_NAME);
+	prk_info("Test Case Result: %s\n", result_str(pass));
+	return pass;
+}
 
-		major2 = register_blkdev(major, BLK_DEV_NAME);
-		major3 = register_blkdev(major, BLK_DEV_NAME);
+static int tc06(void)
+{
+	int major, pass = 32;
 
-		if (0 < major2) {
-			unregister_blkdev(major2, BLK_DEV_NAME);
-		} else {
-			printk(KERN_DEBUG
-			       "first call to register_blkdev() with major=%i failed with error %i\n",
-			       major, major2);
-		}
+	prk_info("Test Case 6: register_blkdev() with name=\"\"\n");
 
-		if (0 < major3) {
-			unregister_blkdev(major3, BLK_DEV_NAME);
-		} else {
-			printk(KERN_DEBUG
-			       "second call to register_blkdev() with major=%i failed with error %i\n",
-			       major, major3);
-		}
+	major = register_blkdev(0, "");
+	prk_debug("major = %i\n", major);
 
-	} else {
-		printk(KERN_DEBUG "register_blkdev() failed with error %i\n",
-		       major);
+	if (major >= 0)
+		unregister_blkdev(major, "");
+	else {
+		pass = 0;
+		prk_debug("register_blkdev() failed with error %i\n", major);
 	}
 
-	printk(KERN_INFO "Test Case 5: UNRESLOVED\n");
+	prk_info("Test Case Result: %s\n", result_str(pass));
+	return pass;
 }
 
-static void tc06(void)
+static int tc07(void)
 {
-	int major;
+	int major, pass = 64;
 
-	printk(KERN_INFO "Test Case 6: register_blkdev() with name=\"\"\n");
+	prk_info("Test Case 7: unregister_blkdev() with major=0\n");
 
-	major = register_blkdev(0, "");
-	printk(KERN_DEBUG "major = %i\n", major);
+	major = register_blkdev(0, BLK_DEV_NAME);
+	prk_debug("major = %i\n", major);
 
-	if (0 < major) {
-		unregister_blkdev(major, "");
+	if (major >= 0) {
+		prk_debug("calling unregister_blkdev() with major=0\n");
+		unregister_blkdev(0, BLK_DEV_NAME);
+		prk_debug("calling unregister_blkdev() with major=%i\n", major);
+		unregister_blkdev(major, BLK_DEV_NAME);
 	} else {
-		printk(KERN_DEBUG "register_blkdev() failed with error %i\n",
-		       major);
+		pass = 0;
+		prk_debug("register_blkdev() failed with error %i\n", major);
 	}
 
-	printk(KERN_INFO "Test Case 6: UNRESLOVED\n");
+	prk_info("Test Case Result: %s\n", result_str(pass));
+	return pass;
 }
 
-static void tc07(void)
+static int tc08(void)
 {
-	int major;
+	int major, pass = 128;
 
-	printk(KERN_INFO "Test Case 7: register_blkdev() with name=NULL\n");
+	prk_info("Test Case 8: register_blkdev() with name=NULL\n");
 
+	/* should fail with -EINVAL */
 	major = register_blkdev(0, NULL);
-	printk(KERN_DEBUG "major = %i\n", major);
+	prk_debug("major = %i\n", major);
 
-	if (0 < major) {
+	if (major >= 0) {
 		unregister_blkdev(major, NULL);
-	} else {
-		printk(KERN_DEBUG "register_blkdev() failed with error %i\n",
-		       major);
-	}
+		pass = 0;
+	} else
+		prk_debug("register_blkdev() failed with error %i\n", major);
 
-	printk(KERN_INFO "Test Case 7: UNRESLOVED\n");
+	prk_info("Test Case Result: %s\n", result_str(pass));
+	return pass;
 }
 
-static void tc10(void)
+static int tc09(void)
 {
-	int major;
+	int major, pass = 256;
 
-	printk(KERN_INFO "Test Case 10: unregister_blkdev() with major=0\n");
+	prk_info("Test Case 9: unregister_blkdev() with name=NULL\n");
 
 	major = register_blkdev(0, BLK_DEV_NAME);
-	printk(KERN_DEBUG "major = %i\n", major);
+	prk_debug("major = %i\n", major);
 
-	if (0 < major) {
-		printk(KERN_DEBUG "calling unregister_blkdev() with major=0\n");
-		unregister_blkdev(0, BLK_DEV_NAME);
-		printk(KERN_DEBUG "calling unregister_blkdev() with major=%i\n",
-		       major);
+	if (major >= 0) {
+		/* kernel should silently ignore this */
+		unregister_blkdev(major, NULL);
 		unregister_blkdev(major, BLK_DEV_NAME);
 	} else {
-		printk(KERN_DEBUG "register_blkdev() failed with error %i\n",
-		       major);
+		pass = 0;
+		prk_debug("register_blkdev() failed with error %i\n", major);
 	}
 
-	printk(KERN_INFO "Test Case 10: UNRESLOVED\n");
+	prk_info("Test Case Result: %s\n", result_str(pass));
+	return pass;
 }
 
-static int test_init_module(void)
+/* print test result to sysfs file */
+static ssize_t sys_result(struct device *dev,
+	struct device_attribute *attr, char *buf)
 {
-	printk(KERN_INFO "Starting test_block module\n");
+	return scnprintf(buf, PAGE_SIZE, "%d\n", test_result);
+}
+static DEVICE_ATTR(result, S_IRUSR, sys_result, NULL);
+
+/*
+ * get test-case number and run it
+ */
+static ssize_t sys_tcase(struct device *dev,
+	struct device_attribute *attr,  const char *buf, size_t count)
+{
+	int tc = 0;
+	sscanf(buf, "%d", &tc);
+	if (tc < 0 || tc > 9) {
+		prk_err(": Unexpected test-case number '%d'", tc);
+		return count;
+	}
+
+	test_result = 0;
 
 	if (tc == 0 || tc == 1)
-		tc01();
+		test_result |= tc01();
 
 	if (tc == 0 || tc == 2)
-		tc02();
+		test_result |= tc02();
 
 	if (tc == 0 || tc == 3)
-		tc03();
+		test_result |= tc03();
 
 	if (tc == 0 || tc == 4)
-		tc04();
+		test_result |= tc04();
 
 	if (tc == 0 || tc == 5)
-		tc05();
+		test_result |= tc05();
 
 	if (tc == 0 || tc == 6)
-		tc06();
+		test_result |= tc06();
 
 	if (tc == 0 || tc == 7)
-		tc07();
+		test_result |= tc07();
 
-	if (tc == 0 || tc == 10)
-		tc10();
+	if (tc == 0 || tc == 8)
+		test_result |= tc08();
 
-	return 0;
+	if (tc == 0 || tc == 9)
+		test_result |= tc09();
+
+	return count;
 }
+static DEVICE_ATTR(tcase, S_IWUSR, NULL, sys_tcase);
 
-static void test_exit_module(void)
+static int test_init_module(void)
 {
-	printk(KERN_DEBUG "Unloading test_block module\n");
-}
+	int err = 0;
+	prk_info("Starting module\n");
+
+	err = device_register(&tdev);
+	if (err) {
+		prk_err("Unable to register device\n");
+		return err;
+	}
+	prk_info("device registered\n");
+
+	err = device_create_file(&tdev, &dev_attr_result);
+	if (err) {
+		prk_err("Can't create sysfs file 'result'\n");
+		device_unregister(&tdev);
+		return err;
+	}
+
+	err = device_create_file(&tdev, &dev_attr_tcase);
+	if (err) {
+		prk_err(": Can't create sysfs file 'tc'\n");
+		device_remove_file(&tdev, &dev_attr_result);
+		device_unregister(&tdev);
+	}
 
+	return err;
+}
 module_init(test_init_module);
+
+static void test_exit_module(void)
+{
+	prk_debug("Unloading module\n");
+	device_remove_file(&tdev, &dev_attr_result);
+	device_remove_file(&tdev, &dev_attr_tcase);
+	device_unregister(&tdev);
+}
 module_exit(test_exit_module);
diff --git a/testcases/kernel/device-drivers/block/block_dev_user/.gitignore b/testcases/kernel/device-drivers/block/block_dev_user/.gitignore
new file mode 100644
index 0000000..4034ce5
--- /dev/null
+++ b/testcases/kernel/device-drivers/block/block_dev_user/.gitignore
@@ -0,0 +1 @@
+/block_dev
diff --git a/testcases/kernel/device-drivers/block/block_dev_user/Makefile b/testcases/kernel/device-drivers/block/block_dev_user/Makefile
new file mode 100644
index 0000000..6ba3465
--- /dev/null
+++ b/testcases/kernel/device-drivers/block/block_dev_user/Makefile
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
+top_srcdir		?= ../../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/device-drivers/block/block_dev_user/block_dev.c b/testcases/kernel/device-drivers/block/block_dev_user/block_dev.c
new file mode 100644
index 0000000..72e54cf
--- /dev/null
+++ b/testcases/kernel/device-drivers/block/block_dev_user/block_dev.c
@@ -0,0 +1,111 @@
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
+ * Test checks block device kernel API.
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+#include "tst_module.h"
+
+char *TCID = "block_dev";
+int TST_TOTAL = 9;
+
+static const char module_name[]	= "ltp_block_dev.ko";
+static const char dev_result[]	= "/sys/devices/ltp_block_dev/result";
+static const char dev_tcase[]	= "/sys/devices/ltp_block_dev/tcase";
+static int module_loaded;
+
+static int run_all_testcases;
+static const option_t options[] = {
+	{"a", &run_all_testcases, NULL},
+	{NULL, NULL, NULL}
+};
+
+static void cleanup(void)
+{
+	if (module_loaded)
+		tst_module_unload(NULL, module_name);
+
+	TEST_CLEANUP;
+}
+
+static void help(void)
+{
+	printf("  -a      Run all test-cases (can crash the kernel)\n");
+}
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
+	if (tst_kvercmp(2, 6, 0) < 0) {
+		tst_brkm(TCONF, NULL,
+			"Test must be run with kernel 2.6 or newer");
+	}
+
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+}
+
+static void test_run(void)
+{
+	int off = 0;
+	/*
+	 * test-cases #8 and #9 can crash the kernel.
+	 * We have to wait for kernel fix where register_blkdev() &
+	 * unregister_blkdev() checks the input device name parameter
+	 * against NULL pointer.
+	 */
+	if (!run_all_testcases)
+		off = 2;
+
+	tst_module_load(cleanup, module_name, NULL);
+	module_loaded = 1;
+
+	int i, pass = 0;
+	for (i = 0; i < TST_TOTAL - off; ++i) {
+		SAFE_FILE_PRINTF(cleanup, dev_tcase, "%d", i + 1);
+		SAFE_FILE_SCANF(cleanup, dev_result, "%d", &pass);
+		tst_resm((pass) ? TPASS : TFAIL, "Test-case '%d'", i + 1);
+	}
+}
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
-- 
1.7.1



--===============2677244583561671380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
LIMITED TIME SALE - Full Year of Microsoft Training For Just $49.99!
1,500+ hours of tutorials including VisualStudio 2012, Windows 8, SharePoint
2013, SQL 2012, MVC 4, more. BEST VALUE: New Multi-Library Power Pack includes
Mobile, Cloud, Java, and UX Design. Lowest price ever! Ends 9/20/13. 
http://pubads.g.doubleclick.net/gampad/clk?id=58041151&iu=/4140/ostg.clktrk
--===============2677244583561671380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2677244583561671380==--
