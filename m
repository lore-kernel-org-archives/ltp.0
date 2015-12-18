From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Fri, 18 Dec 2015 15:07:18 +0800
Subject: [LTP] [PATCH 2/2] commands/insmod: Added new testcase to test
	insmod(8)
In-Reply-To: <1450422438-8798-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1450422438-8798-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <1450422438-8798-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test the basic functionality of insmod(8) command.

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 runtest/commands                          |  1 +
 testcases/commands/insmod/Makefile        | 36 ++++++++++++++
 testcases/commands/insmod/insmod01.sh     | 79 +++++++++++++++++++++++++++++++
 testcases/commands/insmod/test_insmod01.c | 35 ++++++++++++++
 4 files changed, 151 insertions(+)
 create mode 100644 testcases/commands/insmod/Makefile
 create mode 100755 testcases/commands/insmod/insmod01.sh
 create mode 100644 testcases/commands/insmod/test_insmod01.c

diff --git a/runtest/commands b/runtest/commands
index c1ee9f8..b377081 100644
--- a/runtest/commands
+++ b/runtest/commands
@@ -40,3 +40,4 @@ mkfs01_vfat mkfs01.sh -f vfat
 mkfs01_ntfs mkfs01.sh -f ntfs
 mkswap01 mkswap01.sh
 lsmod01 lsmod01.sh
+insmod01 insmod01.sh
diff --git a/testcases/commands/insmod/Makefile b/testcases/commands/insmod/Makefile
new file mode 100644
index 0000000..69f3ed5
--- /dev/null
+++ b/testcases/commands/insmod/Makefile
@@ -0,0 +1,36 @@
+#
+#    Copyright (c) 2015 Fujitsu Ltd.
+#    Author:Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+
+ifneq ($(KERNELRELEASE),)
+
+obj-m := test_insmod01.o
+
+else
+
+top_srcdir		?= ../../..
+include $(top_srcdir)/include/mk/testcases.mk
+
+REQ_VERSION_MAJOR       := 2
+REQ_VERSION_PATCH       := 6
+MAKE_TARGETS            := test_insmod01.ko
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_TARGETS		:= insmod01.sh
+
+include $(top_srcdir)/include/mk/module.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+endif
diff --git a/testcases/commands/insmod/insmod01.sh b/testcases/commands/insmod/insmod01.sh
new file mode 100755
index 0000000..fce111c
--- /dev/null
+++ b/testcases/commands/insmod/insmod01.sh
@@ -0,0 +1,79 @@
+#!/bin/sh
+#
+# Copyright (c) 2015 Fujitsu Ltd.
+# Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
+# the GNU General Public License for more details.
+#
+# Test the basic functionality of insmod command.
+#
+
+TCID=insmod01
+TST_TOTAL=1
+. test.sh
+
+setup()
+{
+	tst_require_root
+
+	tst_check_cmds rmmod insmod
+
+	if ! [ -e ./test_insmod01.ko ]; then
+		tst_brkm TCONF "'test_insmod01.ko' not found"
+	fi
+	inserted=0
+
+	TST_CLEANUP="cleanup"
+}
+
+cleanup()
+{
+	if [ $inserted -ne 0 ]; then
+		echo "about to rmmod test_insmod01"
+		rmmod test_insmod01
+		if [ $? -ne 0 ]; then
+			echo "failed to rmmod test_insmod01"
+		fi
+	fi
+}
+
+insmod_verify()
+{
+	grep -q test_insmod01 /proc/modules
+	if [ $? -ne 0 ]; then
+		echo "test_insmod01 not found in /proc/modules"
+		return 1
+	fi
+}
+
+insmod_test()
+{
+	insmod ./test_insmod01.ko
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "'insmod' failed."
+		return
+	fi
+	inserted=1
+
+	insmod_verify
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "'insmod' failed, not expected."
+		return
+	fi
+
+	tst_resm TPASS "'insmod' passed."
+}
+
+setup
+
+insmod_test
+
+tst_exit
diff --git a/testcases/commands/insmod/test_insmod01.c b/testcases/commands/insmod/test_insmod01.c
new file mode 100644
index 0000000..bd7464a
--- /dev/null
+++ b/testcases/commands/insmod/test_insmod01.c
@@ -0,0 +1,35 @@
+/*
+ * Copyright (c) 2015 Fujitsu Ltd.
+ * Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
+ * the GNU General Public License for more details.
+ *
+ * Description:
+ * This is a kernel loadable module programme used by insmod01.sh
+ * testcase which inserts this module for test of insmod command.
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
+module_init(test_init);
+module_exit(test_exit);
-- 
1.8.4.2



