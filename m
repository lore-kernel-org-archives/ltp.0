Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1VJhio-0000jn-B7
	for ltp-list@lists.sourceforge.net; Wed, 11 Sep 2013 10:32:30 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VJhim-0003li-BX
	for ltp-list@lists.sourceforge.net; Wed, 11 Sep 2013 10:32:30 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r8BAWLiM007583
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 11 Sep 2013 10:32:22 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r8BAWLlN027377
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 11 Sep 2013 10:32:21 GMT
Received: from abhmt101.oracle.com (abhmt101.oracle.com [141.146.116.53])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r8BAWK5X028521
	for <ltp-list@lists.sourceforge.net>; Wed, 11 Sep 2013 10:32:20 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 11 Sep 2013 14:31:48 +0400
Message-Id: <1378895508-28703-2-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1378895508-28703-1-git-send-email-alexey.kodanev@oracle.com>
References: <1378895508-28703-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH v2 2/2] device-drivers: block: fixes
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5597246655785691882=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com, Alexey Kodanev <alexey.kodanev@oracle.com>

--===============5597246655785691882==

Fixed test-cases behavior: major number greater than 255 is valid,
empty device name is valid.
Added test-cases results.
Added user-space program which checks each test-case result.
Added command line parameter 'a': run all test-cases.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/kernel/device-drivers/block/README       |    8 +-
 .../block/block_dev_kernel/.gitignore              |    6 +
 .../device-drivers/block/block_dev_kernel/Makefile |   44 ++-
 .../block/block_dev_kernel/ltp_block_dev.c         |  331 ++++++++++++--------
 .../device-drivers/block/block_dev_user/.gitignore |    1 +
 .../device-drivers/block/block_dev_user/Makefile   |   20 ++
 .../block/block_dev_user/block_dev.c               |  121 +++++++
 7 files changed, 373 insertions(+), 158 deletions(-)
 create mode 100644 testcases/kernel/device-drivers/block/block_dev_kernel/.gitignore
 create mode 100644 testcases/kernel/device-drivers/block/block_dev_user/.gitignore
 create mode 100644 testcases/kernel/device-drivers/block/block_dev_user/Makefile
 create mode 100644 testcases/kernel/device-drivers/block/block_dev_user/block_dev.c

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
index 0000000..0d8a536
--- /dev/null
+++ b/testcases/kernel/device-drivers/block/block_dev_kernel/.gitignore
@@ -0,0 +1,6 @@
+/ltp_block_dev.ko
+/*.cmd
+/modules.order
+/Module.symvers
+/ltp_block_dev.mod.c
+/.tmp_versions/
diff --git a/testcases/kernel/device-drivers/block/block_dev_kernel/Makefile b/testcases/kernel/device-drivers/block/block_dev_kernel/Makefile
index 10f33a7..891568d 100644
--- a/testcases/kernel/device-drivers/block/block_dev_kernel/Makefile
+++ b/testcases/kernel/device-drivers/block/block_dev_kernel/Makefile
@@ -1,24 +1,40 @@
-
-EXTRA_CFLAGS += -Wall -W -Wno-unused-parameter
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
 
 ifneq ($(KERNELRELEASE),)
 
-obj-m	:= test_block.o test_genhd.o
+obj-m		:= ltp_block_dev.o
+
 else
-KDIR	:= /lib/modules/$(shell uname -r)/build
-PWD	:= $(shell pwd)
 
-modules:
-	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
+top_srcdir	?= ../../../../..
+include $(top_srcdir)/include/mk/testcases.mk
 
-clean:
-	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) clean
-	rm -f modules.order
+MAKE_TARGETS	:= ltp_block_dev.ko
 
-help:
-	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) help
+# Ignoring the exit status of commands is done to be forward compatible with
+# kernel internal API changes. The user-space test will return TCONF, if it
+# doesn't find the module (i.e. it wasn't built either due to kernel-devel
+# missing or module build failure).
+%.ko: %.c
+	-$(MAKE) -C $(LINUX_DIR) M=$(abs_srcdir)
+	-mv $@ $@~
+	-$(MAKE) -C $(LINUX_DIR) M=$(abs_srcdir) clean
+	-mv $@~ $@
 
-modules_install:
-	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules_install
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
 endif
diff --git a/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_dev.c b/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_dev.c
index 3048e09..83ff212 100644
--- a/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_dev.c
+++ b/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_dev.c
@@ -1,17 +1,28 @@
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
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  *
- * Usage:
- *   1. make
- *   2. su
- *   3. insmod ./test_block.ko
- *   4. Check the test results in "dmesg"
- *   5. rmmod test_block
+ * Only those functions are tested here which are declared in <linux/fs.h>
  *
  * Changes:
+ *    Sep 2013  0.3  Changed test-case behavior: major number greater
+ *                   than 255 is valid, empty device name is valid.
+ *                   Added test-case result.
+ *                   Added test-case: unregister_blkdev() with NULL name.
+ *                   Added command line parameter 'a': run all test-cases.
  * 16 Jan 2009  0.2  Added "tc" parameter to run test cases separately
  * 11 Jan 2009  0.1  First release
  */
@@ -19,18 +30,25 @@
 #include <linux/module.h>
 #include <linux/fs.h>
 
-static unsigned int __initdata tc;
-module_param_named(tc, tc, int, 0);
-MODULE_PARM_DESC(tc,
-		 "Test Case to run. Default is 0 which means that run all tests.");
+static int tc;
+module_param(tc, int, 0444);
+MODULE_PARM_DESC(tc, "Test Case to run. Default is 0 - run all tests.");
 
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
+
 /*
  * Analysis of "int register_blkdev(unsigned int major, const char *name)"
  *
@@ -42,268 +60,305 @@ MODULE_LICENSE("GPL");
  *             |--------------------------+---------+-------------
  *             | [1..255]                 | valid   | tc05
  *             |--------------------------+---------+-------------
- *             | [256..UINT_MAX]          | invalid | tc03, tc04
+ *             | [256..UINT_MAX]          | valid   | tc03, tc04
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
+ *             | [NULL]                   | invalid | tc07, tc08
  *  -----------+--------------------------+---------+-------------
  *
  */
 
-static void tc01(void)
+#define result_str(err) ((err == 0) ? ("PASS") : ("FAIL"))
+
+static int tc01(void)
 {
-	int major1;
-	int major2;
+	int major1, major2;
+	int err = 0;
 
-	printk(KERN_INFO
-	       "Test Case 1: register_blkdev() with auto allocating major numbers (major=0)\n");
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
+		err = 1;
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
+		err = 1;
+		prk_debug("2nd call to register_blkdev() failed, error %i\n",
+			major2);
 	}
 
-	printk(KERN_INFO "Test Case 1: UNRESLOVED\n");
+	prk_info("Test Case Result: %s\n", result_str(err));
+	return err;
 }
 
-static void tc02(void)
+static int tc02(void)
 {
 	int major[MAX_MAJOR + 1];
-	int i;
+	int i, err = 0;
 
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
+			err = 1;
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
+	prk_info("Test Case Result: %s\n", result_str(err));
+	return err;
 }
 
-static void tc03(void)
+static int tc03(void)
 {
-	int major;
+	int major, err = 0;
 
-	printk(KERN_INFO "Test Case 3: register_blkdev() with major=256\n");
+	prk_info("Test Case 3: register_blkdev() with major=256\n");
 
 	major = register_blkdev(256, BLK_DEV_NAME);
-	printk(KERN_DEBUG "major = %i\n", major);
+	prk_debug("major = %i\n", major);
 
-	if (0 < major) {
-		unregister_blkdev(major, BLK_DEV_NAME);
+	if (major == 0) {
+		unregister_blkdev(256, BLK_DEV_NAME);
 	} else {
-		printk(KERN_DEBUG "register_blkdev() failed with error %i\n",
-		       major);
+		err = 1;
+		prk_debug("register_blkdev() failed with error %i\n", major);
 	}
 
-	printk(KERN_INFO "Test Case 3: UNRESLOVED\n");
+	prk_info("Test Case Result: %s\n", result_str(err));
+	return err;
 }
 
-static void tc04(void)
+static int tc04(void)
 {
-	int major;
+	int major, err = 0;
 
-	printk(KERN_INFO "Test Case 4: register_blkdev() with major=%u\n",
-	       UINT_MAX);
+	prk_info("Test Case 4: register_blkdev() with major=%u\n", UINT_MAX);
 
 	major = register_blkdev(UINT_MAX, BLK_DEV_NAME);
-	printk(KERN_DEBUG "major = %i\n", major);
-
-	if (0 < major) {
-		unregister_blkdev(major, BLK_DEV_NAME);
-	} else {
-		printk(KERN_DEBUG "register_blkdev() failed with error %i\n",
-		       major);
+	prk_debug("major = %i\n", major);
+
+	if (major == 0)
+		unregister_blkdev(UINT_MAX, BLK_DEV_NAME);
+	else {
+		prk_debug("reg blkdev with major %d failed with error %i\n",
+			UINT_MAX, major);
+		err = 1;
 	}
 
-	printk(KERN_INFO "Test Case 4: UNRESLOVED\n");
+	prk_info("Test Case Result: %s\n", result_str(err));
+	return err;
 }
 
-static void tc05(void)
+static int tc05(void)
 {
-	int major;
-	int major2;
-	int major3;
+	int major, major2, major3;
+	int err = 0;
 
-	printk(KERN_INFO "Test Case 5: register_blkdev() with major != 0\n");
+	prk_info("Test Case 5: register_blkdev() with major != 0\n");
 
 	/* autosearch for a free major number */
 	major = register_blkdev(0, BLK_DEV_NAME);
-	printk(KERN_DEBUG "major = %i\n", major);
+	prk_debug("major = %i\n", major);
 
-	if (0 < major) {
+	if (major > 0) {
 		unregister_blkdev(major, BLK_DEV_NAME);
 
+		/* expected to return 0 */
 		major2 = register_blkdev(major, BLK_DEV_NAME);
+
+		/* this call has to fail with EBUSY return value */
 		major3 = register_blkdev(major, BLK_DEV_NAME);
 
-		if (0 < major2) {
-			unregister_blkdev(major2, BLK_DEV_NAME);
-		} else {
-			printk(KERN_DEBUG
-			       "first call to register_blkdev() with major=%i failed with error %i\n",
-			       major, major2);
+		if (major2 == 0)
+			unregister_blkdev(major, BLK_DEV_NAME);
+		else {
+			err = 1;
+			prk_debug("1st call to register_blkdev() with major=%i "
+				"failed with error %i\n", major, major2);
 		}
 
-		if (0 < major3) {
-			unregister_blkdev(major3, BLK_DEV_NAME);
+		if (major3 == 0) {
+			unregister_blkdev(major, BLK_DEV_NAME);
+			err = 1;
 		} else {
-			printk(KERN_DEBUG
-			       "second call to register_blkdev() with major=%i failed with error %i\n",
-			       major, major3);
+			if (major3 != -EBUSY)
+				err = 1;
+			prk_debug("2nd call to register_blkdev() with major=%i "
+				"failed with error %i\n", major, major3);
 		}
 
 	} else {
-		printk(KERN_DEBUG "register_blkdev() failed with error %i\n",
-		       major);
+		err = 1;
+		prk_debug("register_blkdev() failed with error %i\n", major);
 	}
 
-	printk(KERN_INFO "Test Case 5: UNRESLOVED\n");
+	prk_info("Test Case Result: %s\n", result_str(err));
+	return err;
 }
 
-static void tc06(void)
+static int tc06(void)
 {
-	int major;
+	int major, err = 0;
 
-	printk(KERN_INFO "Test Case 6: register_blkdev() with name=\"\"\n");
+	prk_info("Test Case 6: register_blkdev() with name=\"\"\n");
 
 	major = register_blkdev(0, "");
-	printk(KERN_DEBUG "major = %i\n", major);
+	prk_debug("major = %i\n", major);
 
-	if (0 < major) {
+	if (major >= 0)
 		unregister_blkdev(major, "");
-	} else {
-		printk(KERN_DEBUG "register_blkdev() failed with error %i\n",
-		       major);
+	else {
+		err = 1;
+		prk_debug("register_blkdev() failed with error %i\n", major);
 	}
 
-	printk(KERN_INFO "Test Case 6: UNRESLOVED\n");
+	prk_info("Test Case Result: %s\n", result_str(err));
+	return err;
 }
 
-static void tc07(void)
+static int tc07(void)
 {
-	int major;
+	int major, err = 0;
 
-	printk(KERN_INFO "Test Case 7: register_blkdev() with name=NULL\n");
+	prk_info("Test Case 7: register_blkdev() with name=NULL\n");
 
+	/* should fail with -EINVAL */
 	major = register_blkdev(0, NULL);
-	printk(KERN_DEBUG "major = %i\n", major);
+	prk_debug("major = %i\n", major);
 
-	if (0 < major) {
+	if (major >= 0) {
 		unregister_blkdev(major, NULL);
+		err = 1;
+	} else
+		prk_debug("register_blkdev() failed with error %i\n", major);
+
+	prk_info("Test Case Result: %s\n", result_str(err));
+	return err;
+}
+
+static int tc08(void)
+{
+	int major, err = 0;
+
+	prk_info("Test Case 8: unregister_blkdev() with name=NULL\n");
+
+	major = register_blkdev(0, BLK_DEV_NAME);
+	prk_debug("major = %i\n", major);
+
+	if (major >= 0) {
+		/* kernel should silently ignore this */
+		unregister_blkdev(major, NULL);
+		unregister_blkdev(major, BLK_DEV_NAME);
 	} else {
-		printk(KERN_DEBUG "register_blkdev() failed with error %i\n",
-		       major);
+		err = 1;
+		prk_debug("register_blkdev() failed with error %i\n", major);
 	}
 
-	printk(KERN_INFO "Test Case 7: UNRESLOVED\n");
+	prk_info("Test Case Result: %s\n", result_str(err));
+	return err;
 }
 
-static void tc10(void)
+static int tc10(void)
 {
-	int major;
+	int major, err = 0;
 
-	printk(KERN_INFO "Test Case 10: unregister_blkdev() with major=0\n");
+	prk_info("Test Case 10: unregister_blkdev() with major=0\n");
 
 	major = register_blkdev(0, BLK_DEV_NAME);
-	printk(KERN_DEBUG "major = %i\n", major);
+	prk_debug("major = %i\n", major);
 
-	if (0 < major) {
-		printk(KERN_DEBUG "calling unregister_blkdev() with major=0\n");
+	if (major >= 0) {
+		prk_debug("calling unregister_blkdev() with major=0\n");
 		unregister_blkdev(0, BLK_DEV_NAME);
-		printk(KERN_DEBUG "calling unregister_blkdev() with major=%i\n",
-		       major);
+		prk_debug("calling unregister_blkdev() with major=%i\n", major);
 		unregister_blkdev(major, BLK_DEV_NAME);
 	} else {
-		printk(KERN_DEBUG "register_blkdev() failed with error %i\n",
-		       major);
+		err = 1;
+		prk_debug("register_blkdev() failed with error %i\n", major);
 	}
 
-	printk(KERN_INFO "Test Case 10: UNRESLOVED\n");
+	prk_info("Test Case Result: %s\n", result_str(err));
+	return err;
 }
 
 static int test_init_module(void)
 {
-	printk(KERN_INFO "Starting test_block module\n");
+	int err = 0;
+	prk_info("Starting module\n");
 
 	if (tc == 0 || tc == 1)
-		tc01();
+		err |= tc01();
 
 	if (tc == 0 || tc == 2)
-		tc02();
+		err |= tc02();
 
 	if (tc == 0 || tc == 3)
-		tc03();
+		err |= tc03();
 
 	if (tc == 0 || tc == 4)
-		tc04();
+		err |= tc04();
 
 	if (tc == 0 || tc == 5)
-		tc05();
+		err |= tc05();
 
 	if (tc == 0 || tc == 6)
-		tc06();
+		err |= tc06();
 
 	if (tc == 0 || tc == 7)
-		tc07();
+		err |= tc07();
+
+	if (tc == 0 || tc == 8)
+		err |= tc08();
 
 	if (tc == 0 || tc == 10)
-		tc10();
+		err |= tc10();
+
 
-	return 0;
+	return -err;
 }
 
 static void test_exit_module(void)
 {
-	printk(KERN_DEBUG "Unloading test_block module\n");
+	prk_debug("Unloading module\n");
 }
 
 module_init(test_init_module);
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
index 0000000..8e813bd
--- /dev/null
+++ b/testcases/kernel/device-drivers/block/block_dev_user/block_dev.c
@@ -0,0 +1,121 @@
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
+static int curr_test_case;
+
+static void test_fail()
+{
+	tst_resm(TFAIL, "Test Case %d failed", curr_test_case);
+}
+
+static void test_run(void)
+{
+	int off = 0;
+	int test_case[] = { 1, 2, 5, 3, 4, 10, 6, 7, 8 };
+	/*
+	 * test-cases #7 and #8 can crash the kernel.
+	 * We have to wait for kernel fix where register_blkdev() &
+	 * unregister_blkdev() checks the input device name parameter
+	 * against NULL pointer.
+	 */
+	if (!run_all_testcases)
+		off = 2;
+
+	char *tc_param = NULL;
+	int i;
+	for (i = 0; i < TST_TOTAL - off; ++i) {
+		curr_test_case = test_case[i];
+		SAFE_ASPRINTF(cleanup, &tc_param, "tc=%d", curr_test_case);
+		char *const mod_params[2] = { tc_param, NULL };
+		tst_module_load(test_fail, module_name, mod_params);
+		module_loaded = 1;
+		tst_module_unload(NULL, module_name);
+		module_loaded = 0;
+		tst_resm(TPASS, "Test Case %d passed", curr_test_case);
+		free(tc_param);
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



--===============5597246655785691882==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. Consolidate legacy IT systems to a single system of record for IT
2. Standardize and globalize service processes across IT
3. Implement zero-touch automation to replace manual, redundant tasks
http://pubads.g.doubleclick.net/gampad/clk?id=51271111&iu=/4140/ostg.clktrk
--===============5597246655785691882==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5597246655785691882==--
