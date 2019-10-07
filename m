From: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon,  7 Oct 2019 08:50:17 +0200
Subject: [LTP] [PATCH v3] lsmod01: Add kernel module
Message-ID: <20191007065017.86054-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

The test fails, if no kernel module is loaded. Now at least one module is
always loaded.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 testcases/commands/.gitignore          |  1 +
 testcases/commands/lsmod/Makefile      | 15 ++++++++++++
 testcases/commands/lsmod/lsmod01.sh    | 32 ++++++++++++++++++++++++++
 testcases/commands/lsmod/ltp_lsmod01.c | 28 ++++++++++++++++++++++
 4 files changed, 76 insertions(+)
 create mode 100644 testcases/commands/lsmod/ltp_lsmod01.c

diff --git a/testcases/commands/.gitignore b/testcases/commands/.gitignore
index 0ed343881..ed5e13e29 100644
--- a/testcases/commands/.gitignore
+++ b/testcases/commands/.gitignore
@@ -2,3 +2,4 @@
 /ldd/datafiles/*.obj.so
 /eject/eject_check_tray
 /insmod/ltp_insmod01.ko
+/lsmod/ltp_lsmod01.ko
diff --git a/testcases/commands/lsmod/Makefile b/testcases/commands/lsmod/Makefile
index 2af91b3de..8fc3b1436 100644
--- a/testcases/commands/lsmod/Makefile
+++ b/testcases/commands/lsmod/Makefile
@@ -13,10 +13,25 @@
 #    GNU General Public License for more details.
 #
 
+ifneq ($(KERNELRELEASE),)
+
+obj-m := ltp_lsmod01.o
+
+else
+
 top_srcdir		?= ../../..
 
+include $(top_srcdir)/include/mk/testcases.mk
+
+REQ_VERSION_MAJOR       := 2
+REQ_VERSION_PATCH       := 6
+MAKE_TARGETS            := ltp_lsmod01.ko
+
 include $(top_srcdir)/include/mk/env_pre.mk
 
 INSTALL_TARGETS		:= lsmod01.sh
 
+include $(top_srcdir)/include/mk/module.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+endif
diff --git a/testcases/commands/lsmod/lsmod01.sh b/testcases/commands/lsmod/lsmod01.sh
index ad170dcd4..c761a91af 100755
--- a/testcases/commands/lsmod/lsmod01.sh
+++ b/testcases/commands/lsmod/lsmod01.sh
@@ -5,11 +5,43 @@
 #
 # Test basic functionality of lsmod command.
 
+TST_CLEANUP=cleanup
+TST_SETUP=setup
 TST_TESTFUNC=lsmod_test
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_CMDS="lsmod"
+TST_NEEDS_MODULE="ltp_lsmod01.ko"
 . tst_test.sh
 
+inserted=0
+
+setup()
+{
+	if [ -z "$(cat /proc/modules)" ]; then
+		tst_res TINFO "Loading dummy kernel module"
+		insmod "$TST_MODPATH"
+		if [ $? -ne 0 ]; then
+			tst_res TBROK "insmod failed"
+			return
+		fi
+
+		inserted=1
+	fi
+}
+
+cleanup()
+{
+	if [ $inserted -ne 0 ]; then
+		tst_res TINFO "Unloading dummy kernel module"
+		rmmod ltp_lsmod01
+		if [ $? -ne 0 ]; then
+			tst_res TWARN "rmmod failed"
+		fi
+		inserted=0
+	fi
+}
+
+
 lsmod_test()
 {
 	lsmod_output=$(lsmod | awk '!/Module/{print $1, $2, $3}' | sort)
diff --git a/testcases/commands/lsmod/ltp_lsmod01.c b/testcases/commands/lsmod/ltp_lsmod01.c
new file mode 100644
index 000000000..19f9d9145
--- /dev/null
+++ b/testcases/commands/lsmod/ltp_lsmod01.c
@@ -0,0 +1,28 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (c) 2016 Fujitsu Ltd.
+ * Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
+ *
+ * Description:
+ *  This is a kernel loadable module programme used by lssmod01.sh
+ *  testcase which inserts this module for test of lsmod command.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+
+static int test_init(void)
+{
+	return 0;
+}
+
+static void test_exit(void)
+{
+
+}
+
+MODULE_LICENSE("GPL");
+
+module_init(test_init);
+module_exit(test_exit);
-- 
2.20.1

