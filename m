From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Fri, 22 Apr 2016 14:28:29 +0800
Subject: [LTP] [PATCH v3] commands/insmod: add new testcase to test insmod(8)
In-Reply-To: <20160418154419.GA11649@rei.lan>
References: <20160418154419.GA11649@rei.lan>
Message-ID: <1461306509-4945-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test the basic functionality of insmod(8) command.

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 runtest/commands                         |  1 +
 testcases/commands/insmod/Makefile       | 36 ++++++++++++++++
 testcases/commands/insmod/insmod01.sh    | 71 ++++++++++++++++++++++++++++++++
 testcases/commands/insmod/ltp_insmod01.c | 35 ++++++++++++++++
 testcases/lib/test.sh                    | 31 ++++++++++++++
 5 files changed, 174 insertions(+)
 create mode 100644 testcases/commands/insmod/Makefile
 create mode 100755 testcases/commands/insmod/insmod01.sh
 create mode 100644 testcases/commands/insmod/ltp_insmod01.c

diff --git a/runtest/commands b/runtest/commands
index db89424..abbbd96 100644
--- a/runtest/commands
+++ b/runtest/commands
@@ -41,3 +41,4 @@ mkfs01_ntfs mkfs01.sh -f ntfs
 mkswap01 mkswap01.sh
 which01 which01.sh
 lsmod01 lsmod01.sh
+insmod01 insmod01.sh
diff --git a/testcases/commands/insmod/Makefile b/testcases/commands/insmod/Makefile
new file mode 100644
index 0000000..e5e68b6
--- /dev/null
+++ b/testcases/commands/insmod/Makefile
@@ -0,0 +1,36 @@
+#
+#    Copyright (c) 2016 Fujitsu Ltd.
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
+obj-m := ltp_insmod01.o
+
+else
+
+top_srcdir		?= ../../..
+include $(top_srcdir)/include/mk/testcases.mk
+
+REQ_VERSION_MAJOR       := 2
+REQ_VERSION_PATCH       := 6
+MAKE_TARGETS            := ltp_insmod01.ko
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
index 0000000..f19c068
--- /dev/null
+++ b/testcases/commands/insmod/insmod01.sh
@@ -0,0 +1,71 @@
+#!/bin/sh
+#
+# Copyright (c) 2016 Fujitsu Ltd.
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
+	tst_module_exists ltp_insmod01.ko
+
+	inserted=0
+
+	TST_CLEANUP="cleanup"
+}
+
+cleanup()
+{
+	if [ $inserted -ne 0 ]; then
+		echo "about to rmmod ltp_insmod01"
+		rmmod ltp_insmod01
+		if [ $? -ne 0 ]; then
+			echo "failed to rmmod ltp_insmod01"
+		fi
+	fi
+}
+
+insmod_test()
+{
+	insmod "$TST_MODPATH"
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "'insmod' failed."
+		return
+	fi
+	inserted=1
+
+	grep -q ltp_insmod01 /proc/modules
+
+	if [ $? -ne 0 ]; then
+		tst_resm TINFO "ltp_insmod01 not found in /proc/modules"
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
diff --git a/testcases/commands/insmod/ltp_insmod01.c b/testcases/commands/insmod/ltp_insmod01.c
new file mode 100644
index 0000000..398714e
--- /dev/null
+++ b/testcases/commands/insmod/ltp_insmod01.c
@@ -0,0 +1,35 @@
+/*
+ * Copyright (c) 2016 Fujitsu Ltd.
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
+ *  This is a kernel loadable module programme used by insmod01.sh
+ *  testcase which inserts this module for test of insmod command.
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
diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index 458bbca..70345e5 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -113,6 +113,9 @@ tst_tmpdir()
 	TST_TMPDIR=$(mktemp -d "$TMPDIR/$TCID.XXXXXXXXXX")
 
 	chmod 777 "$TST_TMPDIR"
+
+	TST_STARTWD=$(pwd)
+
 	cd "$TST_TMPDIR"
 }
 
@@ -343,6 +346,34 @@ tst_umount()
 	tst_resm TWARN "Failed to umount($device) after 50 retries"
 }
 
+# Check a module file existence
+# Should be called after tst_tmpdir()
+tst_module_exists()
+{
+	local mod_name="$1"
+
+	if [ -f "$mod_name" ]; then
+		TST_MODPATH="$mod_name"
+		return
+	fi
+
+	local mod_path="$LTPROOT/testcases/bin/$mod_name"
+	if [ -f "$mod_path" ]; then
+		TST_MODPATH="$mod_path"
+		return
+	fi
+
+	if [ -n "$TST_TMPDIR" ]; then
+		mod_path="$TST_STARTWD/$mod_name"
+		if [ -f "$mod_path" ]; then
+			TST_MODPATH="$mod_path"
+			return
+		fi
+	fi
+
+	tst_brkm TCONF "Failed to find module '$mod_name'"
+}
+
 # Check that test name is set
 if [ -z "$TCID" ]; then
 	tst_brkm TBROK "TCID is not defined"
-- 
1.8.4.2



