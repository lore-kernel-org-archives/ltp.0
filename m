Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1VIyuH-0004qg-TZ
	for ltp-list@lists.sourceforge.net; Mon, 09 Sep 2013 10:41:22 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VIyuD-0004fN-Pd
	for ltp-list@lists.sourceforge.net; Mon, 09 Sep 2013 10:41:21 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r89AfBKl001525
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 9 Sep 2013 10:41:12 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r89AfBnn001534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 9 Sep 2013 10:41:11 GMT
Received: from abhmt109.oracle.com (abhmt109.oracle.com [141.146.116.61])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r89AfAFV001530
	for <ltp-list@lists.sourceforge.net>; Mon, 9 Sep 2013 10:41:10 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon,  9 Sep 2013 14:40:27 +0400
Message-Id: <1378723227-30907-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] device-drivers: block: fixes
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2136942331570916846=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com, Alexey Kodanev <alexey.kodanev@oracle.com>

--===============2136942331570916846==

Fixed test-cases behavior: major number greater than 255 is valid.
Added test-cases results (pass/fail).
run.sh removed and substituted for the user-space program which automatically
checks each test-case result.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/kernel/device-drivers/Makefile           |    2 +-
 testcases/kernel/device-drivers/block/Makefile     |   30 ++
 testcases/kernel/device-drivers/block/README       |   27 ++
 .../block/block_dev_kernel/.gitignore              |    6 +
 .../device-drivers/block/block_dev_kernel/Makefile |   40 +++
 .../block/block_dev_kernel/ltp_block_dev.c         |  336 ++++++++++++++++++++
 .../block/block_dev_kernel/test_genhd.c            |   53 +++
 .../device-drivers/block/block_dev_user/.gitignore |    1 +
 .../device-drivers/block/block_dev_user/Makefile   |   20 ++
 .../block/block_dev_user/block_dev.c               |  102 ++++++
 .../device-drivers/block/kernel_space/Makefile     |   24 --
 .../device-drivers/block/kernel_space/README       |   27 --
 .../device-drivers/block/kernel_space/run.sh       |   47 ---
 .../device-drivers/block/kernel_space/test_block.c |  310 ------------------
 .../device-drivers/block/kernel_space/test_genhd.c |   53 ---
 15 files changed, 616 insertions(+), 462 deletions(-)
 create mode 100644 testcases/kernel/device-drivers/block/Makefile
 create mode 100644 testcases/kernel/device-drivers/block/README
 create mode 100644 testcases/kernel/device-drivers/block/block_dev_kernel/.gitignore
 create mode 100644 testcases/kernel/device-drivers/block/block_dev_kernel/Makefile
 create mode 100644 testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_dev.c
 create mode 100644 testcases/kernel/device-drivers/block/block_dev_kernel/test_genhd.c
 create mode 100644 testcases/kernel/device-drivers/block/block_dev_user/.gitignore
 create mode 100644 testcases/kernel/device-drivers/block/block_dev_user/Makefile
 create mode 100644 testcases/kernel/device-drivers/block/block_dev_user/block_dev.c
 delete mode 100644 testcases/kernel/device-drivers/block/kernel_space/Makefile
 delete mode 100644 testcases/kernel/device-drivers/block/kernel_space/README
 delete mode 100755 testcases/kernel/device-drivers/block/kernel_space/run.sh
 delete mode 100644 testcases/kernel/device-drivers/block/kernel_space/test_block.c
 delete mode 100644 testcases/kernel/device-drivers/block/kernel_space/test_genhd.c

diff --git a/testcases/kernel/device-drivers/Makefile b/testcases/kernel/device-drivers/Makefile
index c402702..02d872e 100644
--- a/testcases/kernel/device-drivers/Makefile
+++ b/testcases/kernel/device-drivers/Makefile
@@ -18,7 +18,7 @@ top_srcdir	?= ../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-SUBDIRS		=
+SUBDIRS		= block
 
 ifeq ($(WITH_MODULES),yes)
 
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
new file mode 100644
index 0000000..e5dc102
--- /dev/null
+++ b/testcases/kernel/device-drivers/block/README
@@ -0,0 +1,27 @@
+
+Module under test: linux/block/genhd.c
+
+  Function                    | Declared in   | Tested in
+ -----------------------------+---------------+---------------
+  register_blkdev()           | linux/fs.h    | ltp_block_dev.c
+  unregister_blkdev()         | linux/fs.h    | ltp_block_dev.c
+  blk_register_region()       | linux/genhd.h |
+  blk_unregister_region()     | linux/genhd.h |
+  add_disk()                  | linux/genhd.h |
+  del_gendisk()               | linux/genhd.h | test_genhd.c
+  blk_lookup_devt()           | linux/genhd.h |
+  alloc_disk()                | linux/genhd.h | test_genhd.c
+  alloc_disk_node()           | linux/genhd.h |
+  get_disk()                  | linux/genhd.h |
+  put_disk()                  | linux/genhd.h |
+  set_device_ro()             | linux/genhd.h |
+  set_disk_ro()               | linux/genhd.h |
+  bdev_read_only()            | linux/fs.h    |
+  invalidate_partition()      | linux/fs.h    |
+
+For possible test results please see "A POSIX conforming test framework" at
+http://www.gnu.org/software/dejagnu/manual/x47.html#posix
+
+TODO
+----
+ - Automatically evaluate test results
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
new file mode 100644
index 0000000..891568d
--- /dev/null
+++ b/testcases/kernel/device-drivers/block/block_dev_kernel/Makefile
@@ -0,0 +1,40 @@
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
+obj-m		:= ltp_block_dev.o
+
+else
+
+top_srcdir	?= ../../../../..
+include $(top_srcdir)/include/mk/testcases.mk
+
+MAKE_TARGETS	:= ltp_block_dev.ko
+
+# Ignoring the exit status of commands is done to be forward compatible with
+# kernel internal API changes. The user-space test will return TCONF, if it
+# doesn't find the module (i.e. it wasn't built either due to kernel-devel
+# missing or module build failure).
+%.ko: %.c
+	-$(MAKE) -C $(LINUX_DIR) M=$(abs_srcdir)
+	-mv $@ $@~
+	-$(MAKE) -C $(LINUX_DIR) M=$(abs_srcdir) clean
+	-mv $@~ $@
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+endif
diff --git a/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_dev.c b/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_dev.c
new file mode 100644
index 0000000..39e7e3e
--- /dev/null
+++ b/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_dev.c
@@ -0,0 +1,336 @@
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
+ * Only those functions are tested here which are declared in <linux/fs.h>
+ *
+ * Changes:
+ *    Sep 2013  0.3  Changed test-case behavior: major number greater
+ *                   than 255 is valid.
+ *                   Added test-case result.
+ * 16 Jan 2009  0.2  Added "tc" parameter to run test cases separately
+ * 11 Jan 2009  0.1  First release
+ */
+
+#include <linux/module.h>
+#include <linux/fs.h>
+
+static int tc;
+module_param(tc, int, 0444);
+MODULE_PARM_DESC(tc, "Test Case to run. Default is 0 - run all tests.");
+
+MODULE_AUTHOR("M��rton N��meth <nm127@freemail.hu>");
+MODULE_DESCRIPTION("Test block drivers");
+MODULE_LICENSE("GPL");
+
+#define BLK_DEV_NAME		"ltp_block_dev"
+#define MAX_MAJOR		255
+
+#define prk_err(fmt, ...) \
+	pr_err(BLK_DEV_NAME ": " fmt, ##__VA_ARGS__)
+#define prk_info(fmt, ...) \
+	pr_info(BLK_DEV_NAME ": " fmt, ##__VA_ARGS__)
+#define prk_debug(fmt, ...) \
+	pr_debug(BLK_DEV_NAME ": " fmt, ##__VA_ARGS__)
+
+
+/*
+ * Analysis of "int register_blkdev(unsigned int major, const char *name)"
+ *
+ * Equivalence classes:
+ *
+ *  Parameter  | Values                   | Valid?  | Covered in
+ *  -----------+--------------------------+---------+-------------
+ *  major      | [0]                      | valid   | tc01, tc02
+ *             |--------------------------+---------+-------------
+ *             | [1..255]                 | valid   | tc05
+ *             |--------------------------+---------+-------------
+ *             | [256..UINT_MAX]          | valid   | tc03, tc04
+ *  -----------+--------------------------+---------+-------------
+ *  name       | [valid pointer to a zero |         |
+ *             |  terminated string]      | valid   | tc01, tc02
+ *             |--------------------------+---------+-------------
+ *             | [valid pointer to a zero |         |
+ *             |  length zero terminated  | invalid | tc06
+ *             |  string]                 |         |
+ *             |--------------------------+---------+-------------
+ *             | [NULL]                   | invalid | tc07
+ *  -----------+--------------------------+---------+-------------
+ *
+ */
+
+#define result_str(err) ((err == 0) ? ("PASS") : ("FAIL"))
+
+static int tc01(void)
+{
+	int major1, major2;
+	int err = 0;
+
+	prk_info("Test Case 1: register_blkdev() with auto allocating "
+		"major numbers (major=0)\n");
+
+	major1 = register_blkdev(0, BLK_DEV_NAME);
+	prk_debug("major1 = %i\n", major1);
+
+	major2 = register_blkdev(0, BLK_DEV_NAME);
+	prk_debug("major2 = %i\n", major2);
+
+	if (major1 >= 0)
+		unregister_blkdev(major1, BLK_DEV_NAME);
+	else {
+		err = 1;
+		prk_debug("1st call to register_blkdev() failed, error %i\n",
+			major1);
+	}
+
+	if (major2 >= 0)
+		unregister_blkdev(major2, BLK_DEV_NAME);
+	else {
+		err = 1;
+		prk_debug("2nd call to register_blkdev() failed, error %i\n",
+			major2);
+	}
+
+	prk_info("Test Case Result: %s\n", result_str(err));
+	return err;
+}
+
+static int tc02(void)
+{
+	int major[MAX_MAJOR + 1];
+	int i, err = 0;
+
+	/* Try to allocate block devices until all major numbers are used.
+	 * After this register_blkdev() should return -EBUSY
+	 */
+
+	prk_info("Test Case 2: stress test of register_blkdev() "
+		"with auto allocating major numbers (major=0)\n");
+
+	memset(major, 0, sizeof(major));
+
+	for (i = 0; i < sizeof(major) / sizeof(*major); ++i) {
+		major[i] = register_blkdev(0, BLK_DEV_NAME);
+		prk_debug("major[%i] = %i\n", i, major[i]);
+
+		if (major[i] == -EBUSY) {
+			prk_info("device is busy, register_blkdev() ret %i\n",
+				major[i]);
+		} else if (major[i] < 0) {
+			prk_debug("register_blkdev() failed with error %i\n",
+				major[i]);
+			err = 1;
+		}
+	}
+
+	for (i = 0; i < sizeof(major) / sizeof(*major); ++i) {
+		if (major[i] >= 0)
+			unregister_blkdev(major[i], BLK_DEV_NAME);
+	}
+
+	prk_info("Test Case Result: %s\n", result_str(err));
+	return err;
+}
+
+static int tc03(void)
+{
+	int major, err = 0;
+
+	prk_info("Test Case 3: register_blkdev() with major=256\n");
+
+	major = register_blkdev(256, BLK_DEV_NAME);
+	prk_debug("major = %i\n", major);
+
+	if (major == 0) {
+		unregister_blkdev(256, BLK_DEV_NAME);
+	} else {
+		err = 1;
+		prk_debug("register_blkdev() failed with error %i\n", major);
+	}
+
+	prk_info("Test Case Result: %s\n", result_str(err));
+	return err;
+}
+
+static int tc04(void)
+{
+	int major, err = 0;
+
+	prk_info("Test Case 4: register_blkdev() with major=%u\n", UINT_MAX);
+
+	major = register_blkdev(UINT_MAX, BLK_DEV_NAME);
+	prk_debug("major = %i\n", major);
+
+	if (major == 0)
+		unregister_blkdev(UINT_MAX, BLK_DEV_NAME);
+	else {
+		prk_debug("reg blkdev with major %d failed with error %i\n",
+			UINT_MAX, major);
+		err = 1;
+	}
+
+	prk_info("Test Case Result: %s\n", result_str(err));
+	return err;
+}
+
+static int tc05(void)
+{
+	int major, major2, major3;
+	int err = 0;
+
+	prk_info("Test Case 5: register_blkdev() with major != 0\n");
+
+	/* autosearch for a free major number */
+	major = register_blkdev(0, BLK_DEV_NAME);
+	prk_debug("major = %i\n", major);
+
+	if (major > 0) {
+		unregister_blkdev(major, BLK_DEV_NAME);
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
+			err = 1;
+			prk_debug("1st call to register_blkdev() with major=%i "
+				"failed with error %i\n", major, major2);
+		}
+
+		if (major3 == 0) {
+			unregister_blkdev(major, BLK_DEV_NAME);
+			err = 1;
+		} else {
+			if (major3 != -EBUSY)
+				err = 1;
+			prk_debug("2nd call to register_blkdev() with major=%i "
+				"failed with error %i\n", major, major3);
+		}
+
+	} else {
+		err = 1;
+		prk_debug("register_blkdev() failed with error %i\n", major);
+	}
+
+	prk_info("Test Case Result: %s\n", result_str(err));
+	return err;
+}
+
+static int tc06(void)
+{
+	int major, err = 0;
+
+	prk_info("Test Case 6: register_blkdev() with name=\"\"\n");
+
+	major = register_blkdev(0, "");
+	prk_debug("major = %i\n", major);
+
+	if (major >= 0) {
+		unregister_blkdev(major, "");
+		err = 1;
+	} else {
+		prk_debug("register_blkdev() failed with error %i\n", major);
+	}
+
+	prk_info("Test Case Result: %s\n", result_str(err));
+	return err;
+}
+
+static int tc07(void)
+{
+	int major, err = 0;
+
+	prk_info("Test Case 7: register_blkdev() with name=NULL\n");
+
+	major = register_blkdev(0, NULL);
+	prk_debug("major = %i\n", major);
+
+	if (major >= 0) {
+		unregister_blkdev(major, NULL);
+		err = 1;
+	} else
+		prk_debug("register_blkdev() failed with error %i\n", major);
+
+	prk_info("Test Case Result: %s\n", result_str(err));
+	return err;
+}
+
+static int tc10(void)
+{
+	int major, err = 0;
+
+	prk_info("Test Case 10: unregister_blkdev() with major=0\n");
+
+	major = register_blkdev(0, BLK_DEV_NAME);
+	prk_debug("major = %i\n", major);
+
+	if (major >= 0) {
+		prk_debug("calling unregister_blkdev() with major=0\n");
+		unregister_blkdev(0, BLK_DEV_NAME);
+		prk_debug("calling unregister_blkdev() with major=%i\n", major);
+		unregister_blkdev(major, BLK_DEV_NAME);
+	} else {
+		err = 1;
+		prk_debug("register_blkdev() failed with error %i\n", major);
+	}
+
+	prk_info("Test Case Result: %s\n", result_str(err));
+	return err;
+}
+
+static int test_init_module(void)
+{
+	int err = 0;
+	prk_info("Starting module\n");
+
+	if (tc == 0 || tc == 1)
+		err |= tc01();
+
+	if (tc == 0 || tc == 2)
+		err |= tc02();
+
+	if (tc == 0 || tc == 3)
+		err |= tc03();
+
+	if (tc == 0 || tc == 4)
+		err |= tc04();
+
+	if (tc == 0 || tc == 5)
+		err |= tc05();
+
+	if (tc == 0 || tc == 6)
+		err |= tc06();
+
+	if (tc == 0 || tc == 7)
+		err |= tc07();
+
+	if (tc == 0 || tc == 10)
+		err |= tc10();
+
+	return -err;
+}
+
+static void test_exit_module(void)
+{
+	prk_debug("Unloading module\n");
+}
+
+module_init(test_init_module);
+module_exit(test_exit_module);
diff --git a/testcases/kernel/device-drivers/block/block_dev_kernel/test_genhd.c b/testcases/kernel/device-drivers/block/block_dev_kernel/test_genhd.c
new file mode 100644
index 0000000..d34a236
--- /dev/null
+++ b/testcases/kernel/device-drivers/block/block_dev_kernel/test_genhd.c
@@ -0,0 +1,53 @@
+
+/*
+ * Module under test: linux/block/genhd.c
+ *
+ * Only those functions are tested here which are declared in <linux/genhd.h>
+ *
+ * Usage:
+ *   1. make
+ *   2. su
+ *   3. insmod ./test_genhd.ko
+ *   4. Check the test results in "dmesg"
+ *   5. rmmod test_genhd
+ */
+
+#include <linux/module.h>
+#include <linux/genhd.h>
+
+MODULE_AUTHOR("M��rton N��meth <nm127@freemail.hu>");
+MODULE_DESCRIPTION("Test block drivers");
+MODULE_LICENSE("GPL");
+
+#define BLK_DEV_NAME		"test_block"
+#define MAX_MAJOR		255
+
+static void tc20(void)
+{
+	struct gendisk *gd_ptr;
+
+	gd_ptr = alloc_disk(1);
+	if (!gd_ptr) {
+		return;
+	}
+	printk(KERN_DEBUG "gd_ptr after alloc=%p\n", gd_ptr);
+
+	del_gendisk(gd_ptr);
+}
+
+static int test_init_module(void)
+{
+	printk(KERN_INFO "Starting test_genhd module\n");
+
+	tc20();
+
+	return 0;
+}
+
+static void test_exit_module(void)
+{
+	printk(KERN_DEBUG "Unloading test_genhd module\n");
+}
+
+module_init(test_init_module);
+module_exit(test_exit_module);
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
index 0000000..b614d3c
--- /dev/null
+++ b/testcases/kernel/device-drivers/block/block_dev_user/block_dev.c
@@ -0,0 +1,102 @@
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
+int TST_TOTAL = 8;
+
+static const char module_name[]	= "ltp_block_dev.ko";
+
+static void setup(int argc, char *argv[]);
+static void test_run(void);
+static void cleanup(void);
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
+void setup(int argc, char *argv[])
+{
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
+static void tst_fail()
+{
+	tst_resm(TFAIL, "Test Case %d failed", curr_test_case);
+}
+
+static void test_run(void)
+{
+	/*
+	 * test-case #7 can crash the kernel but on most kernels
+	 * test-case #6 will fail with no damage, so 7 won't even
+	 * run. We have to wait for kernel fix where register_blkdev()
+	 * checks the input device name parameter against zero-length
+	 * string & NULL pointer.
+	 */
+	const int test_cases[] = { 1, 2, 5, 3, 4, 10, 6, 7 };
+
+	char *tc = NULL;
+	int i;
+	for (i = 0; i < ARRAY_SIZE(test_cases); ++i) {
+		curr_test_case = test_cases[i];
+		SAFE_ASPRINTF(cleanup, &tc, "tc=%d", curr_test_case);
+		char *const mod_params[2] = { tc, NULL };
+		tst_module_load(tst_fail, module_name, mod_params);
+		tst_module_unload(NULL, module_name);
+		tst_resm(TPASS, "Test Case %d passed", curr_test_case);
+		free(tc);
+	}
+}
+
+static void cleanup(void)
+{
+	tst_module_unload(NULL, module_name);
+	TEST_CLEANUP;
+}
diff --git a/testcases/kernel/device-drivers/block/kernel_space/Makefile b/testcases/kernel/device-drivers/block/kernel_space/Makefile
deleted file mode 100644
index 10f33a7..0000000
--- a/testcases/kernel/device-drivers/block/kernel_space/Makefile
+++ /dev/null
@@ -1,24 +0,0 @@
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
-endif
diff --git a/testcases/kernel/device-drivers/block/kernel_space/README b/testcases/kernel/device-drivers/block/kernel_space/README
deleted file mode 100644
index 6833efd..0000000
--- a/testcases/kernel/device-drivers/block/kernel_space/README
+++ /dev/null
@@ -1,27 +0,0 @@
-
-Module under test: linux/block/genhd.c
-
-  Function                    | Declared in   | Tested in
- -----------------------------+---------------+---------------
-  register_blkdev()           | linux/fs.h    | test_blkdev.c
-  unregister_blkdev()         | linux/fs.h    | test_blkdev.c
-  blk_register_region()       | linux/genhd.h |
-  blk_unregister_region()     | linux/genhd.h |
-  add_disk()                  | linux/genhd.h |
-  del_gendisk()               | linux/genhd.h | test_genhd.c
-  blk_lookup_devt()           | linux/genhd.h |
-  alloc_disk()                | linux/genhd.h | test_genhd.c
-  alloc_disk_node()           | linux/genhd.h |
-  get_disk()                  | linux/genhd.h |
-  put_disk()                  | linux/genhd.h |
-  set_device_ro()             | linux/genhd.h |
-  set_disk_ro()               | linux/genhd.h |
-  bdev_read_only()            | linux/fs.h    |
-  invalidate_partition()      | linux/fs.h    |
-
-For possible test results please see "A POSIX conforming test framework" at
-http://www.gnu.org/software/dejagnu/manual/x47.html#posix
-
-TODO
-----
- - Automatically evaluate test results
diff --git a/testcases/kernel/device-drivers/block/kernel_space/run.sh b/testcases/kernel/device-drivers/block/kernel_space/run.sh
deleted file mode 100755
index 9044453..0000000
--- a/testcases/kernel/device-drivers/block/kernel_space/run.sh
+++ /dev/null
@@ -1,47 +0,0 @@
-#!/bin/sh
-
-# Tell the system to flush write buffers in order to minimize data loss in
-# case of a crash.
-sync
-
-echo Running Test Cases of "block" testsuite one by one.
-echo The test results are printed to "dmesg".
-echo
-
-#
-# Valid test cases (should run stable)
-#
-echo Test Case 1
-insmod ./test_block.ko tc=1
-rmmod test_block
-
-echo Test Case 2
-insmod ./test_block.ko tc=2
-rmmod test_block
-
-echo Test Case 5
-insmod ./test_block.ko tc=5
-rmmod test_block
-
-#
-# Invalid testcases (more probable to crash the module under test)
-#
-echo Test Case 3
-insmod ./test_block.ko tc=3
-rmmod test_block
-
-echo Test Case 4
-insmod ./test_block.ko tc=4
-rmmod test_block
-
-echo Test Case 6
-insmod ./test_block.ko tc=6
-rmmod test_block
-
-echo Test Case 7
-insmod ./test_block.ko tc=7
-rmmod test_block
-
-echo Test Case 10
-insmod ./test_block.ko tc=10
-rmmod test_block
diff --git a/testcases/kernel/device-drivers/block/kernel_space/test_block.c b/testcases/kernel/device-drivers/block/kernel_space/test_block.c
deleted file mode 100644
index 3048e09..0000000
--- a/testcases/kernel/device-drivers/block/kernel_space/test_block.c
+++ /dev/null
@@ -1,310 +0,0 @@
-
-/*
- * Module under test: linux/block/genhd.c
- *
- * Only those functions are tested here which are declared in <linux/fs.h>
- *
- * Usage:
- *   1. make
- *   2. su
- *   3. insmod ./test_block.ko
- *   4. Check the test results in "dmesg"
- *   5. rmmod test_block
- *
- * Changes:
- * 16 Jan 2009  0.2  Added "tc" parameter to run test cases separately
- * 11 Jan 2009  0.1  First release
- */
-
-#include <linux/module.h>
-#include <linux/fs.h>
-
-static unsigned int __initdata tc;
-module_param_named(tc, tc, int, 0);
-MODULE_PARM_DESC(tc,
-		 "Test Case to run. Default is 0 which means that run all tests.");
-
-MODULE_AUTHOR("M��rton N��meth <nm127@freemail.hu>");
-MODULE_DESCRIPTION("Test block drivers");
-MODULE_LICENSE("GPL");
-
-#define BLK_DEV_NAME		"test_block"
-#define MAX_MAJOR		255
-
-/*
- * Analysis of "int register_blkdev(unsigned int major, const char *name)"
- *
- * Equivalence classes:
- *
- *  Parameter  | Values                   | Valid?  | Covered in
- *  -----------+--------------------------+---------+-------------
- *  major      | [0]                      | valid   | tc01, tc02
- *             |--------------------------+---------+-------------
- *             | [1..255]                 | valid   | tc05
- *             |--------------------------+---------+-------------
- *             | [256..UINT_MAX]          | invalid | tc03, tc04
- *  -----------+--------------------------+---------+-------------
- *  name       | [valid pointer to a zero |         |
- *             |  terminated string]      | valid   | tc01, tc02
- *             |--------------------------+---------+-------------
- *             | [valid pointer to a zero |         |
- *             |  length zero terminated  | invalid | tc06
- *             |  string]                 |         |
- *             |--------------------------+---------+-------------
- *             | [NULL]                   | invalid | tc07
- *  -----------+--------------------------+---------+-------------
- *
- */
-
-static void tc01(void)
-{
-	int major1;
-	int major2;
-
-	printk(KERN_INFO
-	       "Test Case 1: register_blkdev() with auto allocating major numbers (major=0)\n");
-
-	major1 = register_blkdev(0, BLK_DEV_NAME);
-	printk(KERN_DEBUG "major1 = %i\n", major1);
-
-	major2 = register_blkdev(0, BLK_DEV_NAME);
-	printk(KERN_DEBUG "major2 = %i\n", major2);
-
-	if (0 < major1) {
-		unregister_blkdev(major1, BLK_DEV_NAME);
-	} else {
-		printk(KERN_DEBUG
-		       "first call to register_blkdev() failed with error %i\n",
-		       major1);
-	}
-
-	if (0 < major2) {
-		unregister_blkdev(major2, BLK_DEV_NAME);
-	} else {
-		printk(KERN_DEBUG
-		       "second call to register_blkdev() failed with error %i\n",
-		       major2);
-	}
-
-	printk(KERN_INFO "Test Case 1: UNRESLOVED\n");
-}
-
-static void tc02(void)
-{
-	int major[MAX_MAJOR + 1];
-	int i;
-
-	/* Try to allocate block devices until all major number are used. After this
-	 * register_blkdev() should return -EBUSY
-	 */
-
-	printk(KERN_INFO
-	       "Test Case 2: stress test of register_blkdev() with auto allocating major numbers (major=0)\n");
-
-	memset(major, 0, sizeof(major));
-
-	for (i = 0; i < sizeof(major) / sizeof(*major); i++) {
-		major[i] = register_blkdev(0, BLK_DEV_NAME);
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
-		}
-	}
-
-	for (i = 0; i < sizeof(major) / sizeof(*major); i++) {
-		if (0 < major[i]) {
-			unregister_blkdev(major[i], BLK_DEV_NAME);
-			major[i] = 0;
-		}
-	}
-
-	printk(KERN_INFO "Test Case 2: UNRESLOVED\n");
-}
-
-static void tc03(void)
-{
-	int major;
-
-	printk(KERN_INFO "Test Case 3: register_blkdev() with major=256\n");
-
-	major = register_blkdev(256, BLK_DEV_NAME);
-	printk(KERN_DEBUG "major = %i\n", major);
-
-	if (0 < major) {
-		unregister_blkdev(major, BLK_DEV_NAME);
-	} else {
-		printk(KERN_DEBUG "register_blkdev() failed with error %i\n",
-		       major);
-	}
-
-	printk(KERN_INFO "Test Case 3: UNRESLOVED\n");
-}
-
-static void tc04(void)
-{
-	int major;
-
-	printk(KERN_INFO "Test Case 4: register_blkdev() with major=%u\n",
-	       UINT_MAX);
-
-	major = register_blkdev(UINT_MAX, BLK_DEV_NAME);
-	printk(KERN_DEBUG "major = %i\n", major);
-
-	if (0 < major) {
-		unregister_blkdev(major, BLK_DEV_NAME);
-	} else {
-		printk(KERN_DEBUG "register_blkdev() failed with error %i\n",
-		       major);
-	}
-
-	printk(KERN_INFO "Test Case 4: UNRESLOVED\n");
-}
-
-static void tc05(void)
-{
-	int major;
-	int major2;
-	int major3;
-
-	printk(KERN_INFO "Test Case 5: register_blkdev() with major != 0\n");
-
-	/* autosearch for a free major number */
-	major = register_blkdev(0, BLK_DEV_NAME);
-	printk(KERN_DEBUG "major = %i\n", major);
-
-	if (0 < major) {
-		unregister_blkdev(major, BLK_DEV_NAME);
-
-		major2 = register_blkdev(major, BLK_DEV_NAME);
-		major3 = register_blkdev(major, BLK_DEV_NAME);
-
-		if (0 < major2) {
-			unregister_blkdev(major2, BLK_DEV_NAME);
-		} else {
-			printk(KERN_DEBUG
-			       "first call to register_blkdev() with major=%i failed with error %i\n",
-			       major, major2);
-		}
-
-		if (0 < major3) {
-			unregister_blkdev(major3, BLK_DEV_NAME);
-		} else {
-			printk(KERN_DEBUG
-			       "second call to register_blkdev() with major=%i failed with error %i\n",
-			       major, major3);
-		}
-
-	} else {
-		printk(KERN_DEBUG "register_blkdev() failed with error %i\n",
-		       major);
-	}
-
-	printk(KERN_INFO "Test Case 5: UNRESLOVED\n");
-}
-
-static void tc06(void)
-{
-	int major;
-
-	printk(KERN_INFO "Test Case 6: register_blkdev() with name=\"\"\n");
-
-	major = register_blkdev(0, "");
-	printk(KERN_DEBUG "major = %i\n", major);
-
-	if (0 < major) {
-		unregister_blkdev(major, "");
-	} else {
-		printk(KERN_DEBUG "register_blkdev() failed with error %i\n",
-		       major);
-	}
-
-	printk(KERN_INFO "Test Case 6: UNRESLOVED\n");
-}
-
-static void tc07(void)
-{
-	int major;
-
-	printk(KERN_INFO "Test Case 7: register_blkdev() with name=NULL\n");
-
-	major = register_blkdev(0, NULL);
-	printk(KERN_DEBUG "major = %i\n", major);
-
-	if (0 < major) {
-		unregister_blkdev(major, NULL);
-	} else {
-		printk(KERN_DEBUG "register_blkdev() failed with error %i\n",
-		       major);
-	}
-
-	printk(KERN_INFO "Test Case 7: UNRESLOVED\n");
-}
-
-static void tc10(void)
-{
-	int major;
-
-	printk(KERN_INFO "Test Case 10: unregister_blkdev() with major=0\n");
-
-	major = register_blkdev(0, BLK_DEV_NAME);
-	printk(KERN_DEBUG "major = %i\n", major);
-
-	if (0 < major) {
-		printk(KERN_DEBUG "calling unregister_blkdev() with major=0\n");
-		unregister_blkdev(0, BLK_DEV_NAME);
-		printk(KERN_DEBUG "calling unregister_blkdev() with major=%i\n",
-		       major);
-		unregister_blkdev(major, BLK_DEV_NAME);
-	} else {
-		printk(KERN_DEBUG "register_blkdev() failed with error %i\n",
-		       major);
-	}
-
-	printk(KERN_INFO "Test Case 10: UNRESLOVED\n");
-}
-
-static int test_init_module(void)
-{
-	printk(KERN_INFO "Starting test_block module\n");
-
-	if (tc == 0 || tc == 1)
-		tc01();
-
-	if (tc == 0 || tc == 2)
-		tc02();
-
-	if (tc == 0 || tc == 3)
-		tc03();
-
-	if (tc == 0 || tc == 4)
-		tc04();
-
-	if (tc == 0 || tc == 5)
-		tc05();
-
-	if (tc == 0 || tc == 6)
-		tc06();
-
-	if (tc == 0 || tc == 7)
-		tc07();
-
-	if (tc == 0 || tc == 10)
-		tc10();
-
-	return 0;
-}
-
-static void test_exit_module(void)
-{
-	printk(KERN_DEBUG "Unloading test_block module\n");
-}
-
-module_init(test_init_module);
-module_exit(test_exit_module);
diff --git a/testcases/kernel/device-drivers/block/kernel_space/test_genhd.c b/testcases/kernel/device-drivers/block/kernel_space/test_genhd.c
deleted file mode 100644
index d34a236..0000000
--- a/testcases/kernel/device-drivers/block/kernel_space/test_genhd.c
+++ /dev/null
@@ -1,53 +0,0 @@
-
-/*
- * Module under test: linux/block/genhd.c
- *
- * Only those functions are tested here which are declared in <linux/genhd.h>
- *
- * Usage:
- *   1. make
- *   2. su
- *   3. insmod ./test_genhd.ko
- *   4. Check the test results in "dmesg"
- *   5. rmmod test_genhd
- */
-
-#include <linux/module.h>
-#include <linux/genhd.h>
-
-MODULE_AUTHOR("M��rton N��meth <nm127@freemail.hu>");
-MODULE_DESCRIPTION("Test block drivers");
-MODULE_LICENSE("GPL");
-
-#define BLK_DEV_NAME		"test_block"
-#define MAX_MAJOR		255
-
-static void tc20(void)
-{
-	struct gendisk *gd_ptr;
-
-	gd_ptr = alloc_disk(1);
-	if (!gd_ptr) {
-		return;
-	}
-	printk(KERN_DEBUG "gd_ptr after alloc=%p\n", gd_ptr);
-
-	del_gendisk(gd_ptr);
-}
-
-static int test_init_module(void)
-{
-	printk(KERN_INFO "Starting test_genhd module\n");
-
-	tc20();
-
-	return 0;
-}
-
-static void test_exit_module(void)
-{
-	printk(KERN_DEBUG "Unloading test_genhd module\n");
-}
-
-module_init(test_init_module);
-module_exit(test_exit_module);
-- 
1.7.1



--===============2136942331570916846==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58041391&iu=/4140/ostg.clktrk
--===============2136942331570916846==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2136942331570916846==--
