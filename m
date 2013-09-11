Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1VJhik-0000jT-QM
	for ltp-list@lists.sourceforge.net; Wed, 11 Sep 2013 10:32:26 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VJhii-0006lN-LZ
	for ltp-list@lists.sourceforge.net; Wed, 11 Sep 2013 10:32:26 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r8BAWHrt007545
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 11 Sep 2013 10:32:18 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r8BAWGTG000127
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 11 Sep 2013 10:32:17 GMT
Received: from abhmt101.oracle.com (abhmt101.oracle.com [141.146.116.53])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r8BAWGLk027149
	for <ltp-list@lists.sourceforge.net>; Wed, 11 Sep 2013 10:32:16 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 11 Sep 2013 14:31:47 +0400
Message-Id: <1378895508-28703-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH v2 1/2] device-drivers: block: rename test files and
	remove run.sh
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4166166593677042055=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com, Alexey Kodanev <alexey.kodanev@oracle.com>

--===============4166166593677042055==

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/kernel/device-drivers/block/README       |   27 ++
 .../device-drivers/block/block_dev_kernel/Makefile |   24 ++
 .../block/block_dev_kernel/ltp_block_dev.c         |  310 ++++++++++++++++++++
 .../block/block_dev_kernel/test_genhd.c            |   53 ++++
 .../device-drivers/block/kernel_space/Makefile     |   24 --
 .../device-drivers/block/kernel_space/README       |   27 --
 .../device-drivers/block/kernel_space/run.sh       |   47 ---
 .../device-drivers/block/kernel_space/test_block.c |  310 --------------------
 .../device-drivers/block/kernel_space/test_genhd.c |   53 ----
 9 files changed, 414 insertions(+), 461 deletions(-)
 create mode 100644 testcases/kernel/device-drivers/block/README
 create mode 100644 testcases/kernel/device-drivers/block/block_dev_kernel/Makefile
 create mode 100644 testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_dev.c
 create mode 100644 testcases/kernel/device-drivers/block/block_dev_kernel/test_genhd.c
 delete mode 100644 testcases/kernel/device-drivers/block/kernel_space/Makefile
 delete mode 100644 testcases/kernel/device-drivers/block/kernel_space/README
 delete mode 100755 testcases/kernel/device-drivers/block/kernel_space/run.sh
 delete mode 100644 testcases/kernel/device-drivers/block/kernel_space/test_block.c
 delete mode 100644 testcases/kernel/device-drivers/block/kernel_space/test_genhd.c

diff --git a/testcases/kernel/device-drivers/block/README b/testcases/kernel/device-drivers/block/README
new file mode 100644
index 0000000..6833efd
--- /dev/null
+++ b/testcases/kernel/device-drivers/block/README
@@ -0,0 +1,27 @@
+
+Module under test: linux/block/genhd.c
+
+  Function                    | Declared in   | Tested in
+ -----------------------------+---------------+---------------
+  register_blkdev()           | linux/fs.h    | test_blkdev.c
+  unregister_blkdev()         | linux/fs.h    | test_blkdev.c
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
diff --git a/testcases/kernel/device-drivers/block/block_dev_kernel/Makefile b/testcases/kernel/device-drivers/block/block_dev_kernel/Makefile
new file mode 100644
index 0000000..10f33a7
--- /dev/null
+++ b/testcases/kernel/device-drivers/block/block_dev_kernel/Makefile
@@ -0,0 +1,24 @@
+
+EXTRA_CFLAGS += -Wall -W -Wno-unused-parameter
+
+ifneq ($(KERNELRELEASE),)
+
+obj-m	:= test_block.o test_genhd.o
+else
+KDIR	:= /lib/modules/$(shell uname -r)/build
+PWD	:= $(shell pwd)
+
+modules:
+	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
+
+clean:
+	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) clean
+	rm -f modules.order
+
+help:
+	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) help
+
+modules_install:
+	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules_install
+
+endif
diff --git a/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_dev.c b/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_dev.c
new file mode 100644
index 0000000..3048e09
--- /dev/null
+++ b/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_dev.c
@@ -0,0 +1,310 @@
+
+/*
+ * Module under test: linux/block/genhd.c
+ *
+ * Only those functions are tested here which are declared in <linux/fs.h>
+ *
+ * Usage:
+ *   1. make
+ *   2. su
+ *   3. insmod ./test_block.ko
+ *   4. Check the test results in "dmesg"
+ *   5. rmmod test_block
+ *
+ * Changes:
+ * 16 Jan 2009  0.2  Added "tc" parameter to run test cases separately
+ * 11 Jan 2009  0.1  First release
+ */
+
+#include <linux/module.h>
+#include <linux/fs.h>
+
+static unsigned int __initdata tc;
+module_param_named(tc, tc, int, 0);
+MODULE_PARM_DESC(tc,
+		 "Test Case to run. Default is 0 which means that run all tests.");
+
+MODULE_AUTHOR("M��rton N��meth <nm127@freemail.hu>");
+MODULE_DESCRIPTION("Test block drivers");
+MODULE_LICENSE("GPL");
+
+#define BLK_DEV_NAME		"test_block"
+#define MAX_MAJOR		255
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
+ *             | [256..UINT_MAX]          | invalid | tc03, tc04
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
+static void tc01(void)
+{
+	int major1;
+	int major2;
+
+	printk(KERN_INFO
+	       "Test Case 1: register_blkdev() with auto allocating major numbers (major=0)\n");
+
+	major1 = register_blkdev(0, BLK_DEV_NAME);
+	printk(KERN_DEBUG "major1 = %i\n", major1);
+
+	major2 = register_blkdev(0, BLK_DEV_NAME);
+	printk(KERN_DEBUG "major2 = %i\n", major2);
+
+	if (0 < major1) {
+		unregister_blkdev(major1, BLK_DEV_NAME);
+	} else {
+		printk(KERN_DEBUG
+		       "first call to register_blkdev() failed with error %i\n",
+		       major1);
+	}
+
+	if (0 < major2) {
+		unregister_blkdev(major2, BLK_DEV_NAME);
+	} else {
+		printk(KERN_DEBUG
+		       "second call to register_blkdev() failed with error %i\n",
+		       major2);
+	}
+
+	printk(KERN_INFO "Test Case 1: UNRESLOVED\n");
+}
+
+static void tc02(void)
+{
+	int major[MAX_MAJOR + 1];
+	int i;
+
+	/* Try to allocate block devices until all major number are used. After this
+	 * register_blkdev() should return -EBUSY
+	 */
+
+	printk(KERN_INFO
+	       "Test Case 2: stress test of register_blkdev() with auto allocating major numbers (major=0)\n");
+
+	memset(major, 0, sizeof(major));
+
+	for (i = 0; i < sizeof(major) / sizeof(*major); i++) {
+		major[i] = register_blkdev(0, BLK_DEV_NAME);
+		printk(KERN_DEBUG "major[%i] = %i\n", i, major[i]);
+		if (major[i] <= 0 && major[i] != -EBUSY) {
+			printk(KERN_INFO
+			       "unexpected return value from register_blkdev(): %i\n",
+			       major[i]);
+		}
+		if (major[i] < 0) {
+			printk(KERN_DEBUG
+			       "register_blkdev() failed with error %i\n",
+			       major[i]);
+		}
+	}
+
+	for (i = 0; i < sizeof(major) / sizeof(*major); i++) {
+		if (0 < major[i]) {
+			unregister_blkdev(major[i], BLK_DEV_NAME);
+			major[i] = 0;
+		}
+	}
+
+	printk(KERN_INFO "Test Case 2: UNRESLOVED\n");
+}
+
+static void tc03(void)
+{
+	int major;
+
+	printk(KERN_INFO "Test Case 3: register_blkdev() with major=256\n");
+
+	major = register_blkdev(256, BLK_DEV_NAME);
+	printk(KERN_DEBUG "major = %i\n", major);
+
+	if (0 < major) {
+		unregister_blkdev(major, BLK_DEV_NAME);
+	} else {
+		printk(KERN_DEBUG "register_blkdev() failed with error %i\n",
+		       major);
+	}
+
+	printk(KERN_INFO "Test Case 3: UNRESLOVED\n");
+}
+
+static void tc04(void)
+{
+	int major;
+
+	printk(KERN_INFO "Test Case 4: register_blkdev() with major=%u\n",
+	       UINT_MAX);
+
+	major = register_blkdev(UINT_MAX, BLK_DEV_NAME);
+	printk(KERN_DEBUG "major = %i\n", major);
+
+	if (0 < major) {
+		unregister_blkdev(major, BLK_DEV_NAME);
+	} else {
+		printk(KERN_DEBUG "register_blkdev() failed with error %i\n",
+		       major);
+	}
+
+	printk(KERN_INFO "Test Case 4: UNRESLOVED\n");
+}
+
+static void tc05(void)
+{
+	int major;
+	int major2;
+	int major3;
+
+	printk(KERN_INFO "Test Case 5: register_blkdev() with major != 0\n");
+
+	/* autosearch for a free major number */
+	major = register_blkdev(0, BLK_DEV_NAME);
+	printk(KERN_DEBUG "major = %i\n", major);
+
+	if (0 < major) {
+		unregister_blkdev(major, BLK_DEV_NAME);
+
+		major2 = register_blkdev(major, BLK_DEV_NAME);
+		major3 = register_blkdev(major, BLK_DEV_NAME);
+
+		if (0 < major2) {
+			unregister_blkdev(major2, BLK_DEV_NAME);
+		} else {
+			printk(KERN_DEBUG
+			       "first call to register_blkdev() with major=%i failed with error %i\n",
+			       major, major2);
+		}
+
+		if (0 < major3) {
+			unregister_blkdev(major3, BLK_DEV_NAME);
+		} else {
+			printk(KERN_DEBUG
+			       "second call to register_blkdev() with major=%i failed with error %i\n",
+			       major, major3);
+		}
+
+	} else {
+		printk(KERN_DEBUG "register_blkdev() failed with error %i\n",
+		       major);
+	}
+
+	printk(KERN_INFO "Test Case 5: UNRESLOVED\n");
+}
+
+static void tc06(void)
+{
+	int major;
+
+	printk(KERN_INFO "Test Case 6: register_blkdev() with name=\"\"\n");
+
+	major = register_blkdev(0, "");
+	printk(KERN_DEBUG "major = %i\n", major);
+
+	if (0 < major) {
+		unregister_blkdev(major, "");
+	} else {
+		printk(KERN_DEBUG "register_blkdev() failed with error %i\n",
+		       major);
+	}
+
+	printk(KERN_INFO "Test Case 6: UNRESLOVED\n");
+}
+
+static void tc07(void)
+{
+	int major;
+
+	printk(KERN_INFO "Test Case 7: register_blkdev() with name=NULL\n");
+
+	major = register_blkdev(0, NULL);
+	printk(KERN_DEBUG "major = %i\n", major);
+
+	if (0 < major) {
+		unregister_blkdev(major, NULL);
+	} else {
+		printk(KERN_DEBUG "register_blkdev() failed with error %i\n",
+		       major);
+	}
+
+	printk(KERN_INFO "Test Case 7: UNRESLOVED\n");
+}
+
+static void tc10(void)
+{
+	int major;
+
+	printk(KERN_INFO "Test Case 10: unregister_blkdev() with major=0\n");
+
+	major = register_blkdev(0, BLK_DEV_NAME);
+	printk(KERN_DEBUG "major = %i\n", major);
+
+	if (0 < major) {
+		printk(KERN_DEBUG "calling unregister_blkdev() with major=0\n");
+		unregister_blkdev(0, BLK_DEV_NAME);
+		printk(KERN_DEBUG "calling unregister_blkdev() with major=%i\n",
+		       major);
+		unregister_blkdev(major, BLK_DEV_NAME);
+	} else {
+		printk(KERN_DEBUG "register_blkdev() failed with error %i\n",
+		       major);
+	}
+
+	printk(KERN_INFO "Test Case 10: UNRESLOVED\n");
+}
+
+static int test_init_module(void)
+{
+	printk(KERN_INFO "Starting test_block module\n");
+
+	if (tc == 0 || tc == 1)
+		tc01();
+
+	if (tc == 0 || tc == 2)
+		tc02();
+
+	if (tc == 0 || tc == 3)
+		tc03();
+
+	if (tc == 0 || tc == 4)
+		tc04();
+
+	if (tc == 0 || tc == 5)
+		tc05();
+
+	if (tc == 0 || tc == 6)
+		tc06();
+
+	if (tc == 0 || tc == 7)
+		tc07();
+
+	if (tc == 0 || tc == 10)
+		tc10();
+
+	return 0;
+}
+
+static void test_exit_module(void)
+{
+	printk(KERN_DEBUG "Unloading test_block module\n");
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



--===============4166166593677042055==
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
--===============4166166593677042055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4166166593677042055==--
