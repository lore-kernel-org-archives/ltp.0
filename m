From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Fri, 18 Dec 2015 15:07:17 +0800
Subject: [LTP] [PATCH 1/2] commands/lsmod: Added new testcase to test
	lsmod(8)
Message-ID: <1450422438-8798-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test the basic functionality of lsmod(8) command.

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 runtest/commands                    |  1 +
 testcases/commands/lsmod/Makefile   | 22 +++++++++++
 testcases/commands/lsmod/lsmod01.sh | 74 +++++++++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+)
 create mode 100644 testcases/commands/lsmod/Makefile
 create mode 100755 testcases/commands/lsmod/lsmod01.sh

diff --git a/runtest/commands b/runtest/commands
index ab600dc..c1ee9f8 100644
--- a/runtest/commands
+++ b/runtest/commands
@@ -39,3 +39,4 @@ mkfs01_msdos mkfs01.sh -f msdos
 mkfs01_vfat mkfs01.sh -f vfat
 mkfs01_ntfs mkfs01.sh -f ntfs
 mkswap01 mkswap01.sh
+lsmod01 lsmod01.sh
diff --git a/testcases/commands/lsmod/Makefile b/testcases/commands/lsmod/Makefile
new file mode 100644
index 0000000..2af91b3
--- /dev/null
+++ b/testcases/commands/lsmod/Makefile
@@ -0,0 +1,22 @@
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
+top_srcdir		?= ../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_TARGETS		:= lsmod01.sh
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/lsmod/lsmod01.sh b/testcases/commands/lsmod/lsmod01.sh
new file mode 100755
index 0000000..2b67376
--- /dev/null
+++ b/testcases/commands/lsmod/lsmod01.sh
@@ -0,0 +1,74 @@
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
+# Test the basic functionality of lsmod command.
+#
+
+TCID=lsmod01
+TST_TOTAL=1
+. test.sh
+
+setup()
+{
+	tst_check_cmds lsmod
+
+	tst_tmpdir
+
+	TST_CLEANUP="cleanup"
+}
+
+cleanup()
+{
+	tst_rmdir
+}
+
+lsmod_verify()
+{
+	cat temp | awk 'BEGIN{FS=" "}{print $1, $2, $3}' | \
+		sed '/Module/d' | sort >temp1
+
+	cat /proc/modules | awk 'BEGIN{FS=" "}{print $1, $2, $3}' | \
+		sort >temp2
+
+	diff temp1 temp2 >/dev/null
+	if [ $? -ne 0 ]; then
+		echo "contents different between lsmod and /proc/modules"
+		return 1
+	fi
+}
+
+lsmod_test()
+{
+	lsmod >temp 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "'lsmod' failed."
+		cat temp
+		return
+	fi
+
+	lsmod_verify
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "'lsmod' failed, not expected."
+		return
+	fi
+
+	tst_resm TPASS "'lsmod' passed."
+}
+
+setup
+
+lsmod_test
+
+tst_exit
-- 
1.8.4.2



