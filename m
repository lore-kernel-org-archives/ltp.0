From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 26 Nov 2015 19:55:55 +0800
Subject: [LTP] [PATCH] commands/which: Added new testcase to test which(1).
Message-ID: <1448538955-1588-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test which(1) command with some basic options.

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 runtest/commands                    |   1 +
 testcases/commands/which/Makefile   |  22 ++++++
 testcases/commands/which/which01.sh | 142 ++++++++++++++++++++++++++++++++++++
 3 files changed, 165 insertions(+)
 create mode 100644 testcases/commands/which/Makefile
 create mode 100755 testcases/commands/which/which01.sh

diff --git a/runtest/commands b/runtest/commands
index ab600dc..b05ae7b 100644
--- a/runtest/commands
+++ b/runtest/commands
@@ -39,3 +39,4 @@ mkfs01_msdos mkfs01.sh -f msdos
 mkfs01_vfat mkfs01.sh -f vfat
 mkfs01_ntfs mkfs01.sh -f ntfs
 mkswap01 mkswap01.sh
+which01 which01.sh
diff --git a/testcases/commands/which/Makefile b/testcases/commands/which/Makefile
new file mode 100644
index 0000000..d9b4d12
--- /dev/null
+++ b/testcases/commands/which/Makefile
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
+INSTALL_TARGETS		:= which01.sh
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/which/which01.sh b/testcases/commands/which/which01.sh
new file mode 100755
index 0000000..1b6a44c
--- /dev/null
+++ b/testcases/commands/which/which01.sh
@@ -0,0 +1,142 @@
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
+# Test which command with some basic options.
+#
+
+TCID=which01
+TST_TOTAL=10
+. test.sh
+
+setup()
+{
+	tst_require_root
+
+	tst_check_cmds which
+
+	tst_tmpdir
+
+	TST_CLEANUP="cleanup"
+
+	touch programname
+	chmod +x programname
+	PATH=$PATH:.
+
+	mkdir bin
+	touch bin/programname
+	chmod +x bin/programname
+	PATH=$PATH:./bin
+
+	alias programname='programname -i'
+}
+
+cleanup()
+{
+	tst_rmdir
+}
+
+which_verify()
+{
+	local which_op=$1
+	local prog_name=$2
+
+	if [ -z "$which_op" ]; then
+		grep -q `pwd`/"$prog_name" temp
+		if [ $? -ne 0 ]; then
+			return 1
+		fi
+	elif [ "$which_op" = "--all" ] || [ "$which_op" = "-a" ]; then
+		grep -q `pwd`/"$prog_name" temp
+		if [ $? -ne 0 ]; then
+			return 1
+		fi
+		grep -q `pwd`/bin/"$prog_name" temp
+		if [ $? -ne 0 ]; then
+			return 1
+		fi
+	elif [ "$which_op" = "--read-alias" ] || [ "$which_op" = "-i" ]; then
+		grep -q "programname='programname -i'" temp
+		if [ $? -ne 0 ]; then
+			return 1
+		fi
+		grep -q `pwd`/"$prog_name" temp
+		if [ $? -ne 0 ]; then
+			return 1
+		fi
+	elif [ "$which_op" = "--skip-alias" ]; then
+		grep -q "programname='programname -i'" temp
+		if [ $? -eq 0 ]; then
+			return 1
+		fi
+		grep -q `pwd`/"$prog_name" temp
+		if [ $? -ne 0 ]; then
+			return 1
+		fi
+	fi
+}
+
+which_test()
+{
+	local which_op=$1
+	local prog_name=$2
+
+	local which_cmd="which $which_op $prog_name"
+
+	if [ "$which_op" = "--read-alias" ] || [ "$which_op" = "-i" ] || \
+		[ "$which_op" = "--skip-alias" ]; then
+		which_cmd="alias | $which_cmd"
+	fi
+
+	eval ${which_cmd} >temp 2>&1
+	if [ $? -ne 0 ]; then
+		grep -q -E "unknown option|invalid option|Usage" temp
+		if [ $? -eq 0 ]; then
+			tst_resm TCONF "'${which_cmd}' not supported."
+			return
+		fi
+
+		tst_resm TFAIL "'${which_cmd}' failed."
+		cat temp
+		return
+	fi
+
+	if [ -n "$prog_name" ]; then
+		which_verify "$which_op" "$prog_name"
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "'${which_cmd}' failed, not expected."
+			return
+		fi
+	fi
+
+	tst_resm TPASS "'${which_cmd}' passed."
+}
+
+setup
+
+which_test "" "programname"
+which_test "--all" "programname"
+which_test "-a" "programname"
+which_test "--read-alias" "programname"
+which_test "-i" "programname"
+
+alias which='which --read-alias'
+which_test "--skip-alias" "programname"
+
+which_test "--version"
+which_test "-v"
+which_test "-V"
+which_test "--help"
+
+tst_exit
-- 
1.8.4.2



