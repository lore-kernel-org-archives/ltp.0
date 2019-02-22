From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 22 Feb 2019 17:59:56 +0800
Subject: [LTP] [PATCH 2/2] fs/binfmt_misc02.sh: Add new test for basic
	functionality
In-Reply-To: <1550829596-17619-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1550829596-17619-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1550829596-17619-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Register a new binary type and then check if binfmt_misc
recognises the binary type in some conditions.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/fs                                         |   1 +
 testcases/kernel/fs/binfmt_misc/Makefile           |   4 +-
 testcases/kernel/fs/binfmt_misc/binfmt_misc02.sh   | 107 +++++++++++++++++++++
 testcases/kernel/fs/binfmt_misc/datafiles/Makefile |  13 +++
 .../kernel/fs/binfmt_misc/datafiles/file.extension |   1 +
 .../kernel/fs/binfmt_misc/datafiles/file.magic     |   1 +
 6 files changed, 125 insertions(+), 2 deletions(-)
 create mode 100755 testcases/kernel/fs/binfmt_misc/binfmt_misc02.sh
 create mode 100644 testcases/kernel/fs/binfmt_misc/datafiles/Makefile
 create mode 100755 testcases/kernel/fs/binfmt_misc/datafiles/file.extension
 create mode 100755 testcases/kernel/fs/binfmt_misc/datafiles/file.magic

diff --git a/runtest/fs b/runtest/fs
index 227c186..ef2e848 100644
--- a/runtest/fs
+++ b/runtest/fs
@@ -84,3 +84,4 @@ isofs isofs.sh
 fs_fill fs_fill
 
 binfmt_misc01 binfmt_misc01.sh
+binfmt_misc02 binfmt_misc02.sh
diff --git a/testcases/kernel/fs/binfmt_misc/Makefile b/testcases/kernel/fs/binfmt_misc/Makefile
index f9819ad..14437b5 100644
--- a/testcases/kernel/fs/binfmt_misc/Makefile
+++ b/testcases/kernel/fs/binfmt_misc/Makefile
@@ -7,6 +7,6 @@ top_srcdir              ?= ../../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-INSTALL_TARGETS         := binfmt_misc01.sh binfmt_misc_lib.sh
+INSTALL_TARGETS         := binfmt_misc01.sh binfmt_misc02.sh binfmt_misc_lib.sh
 
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/fs/binfmt_misc/binfmt_misc02.sh b/testcases/kernel/fs/binfmt_misc/binfmt_misc02.sh
new file mode 100755
index 0000000..5eb6bb8
--- /dev/null
+++ b/testcases/kernel/fs/binfmt_misc/binfmt_misc02.sh
@@ -0,0 +1,107 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
+# Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+#
+# Description:
+# Register a new binary type and then check if binfmt_misc
+# recognises the binary type in some conditions.
+# 1) binfmt_misc should recognise the binary type when extension
+#    or magic is matched.
+# 2) binfmt_misc should not recognise the binary type when extension
+#    or magic is mismatched.
+# 3) binfmt_misc should not recognise the binary type when it is
+#    disabled.
+#
+# Note:
+# We use various delimiteris to register a new binary type.
+
+TST_CNT=8
+TST_TESTFUNC=do_test
+TST_NEEDS_CMDS="perl"
+
+. binfmt_misc_lib.sh
+
+expect_recognised()
+{
+	local file=$1
+	local string=$2
+
+	eval $file >temp 2>&1
+	if [ $? -eq 0 ] && grep -q "$string" temp; then
+		tst_res TPASS "Register and recognise a binary type successfully"
+	else
+		tst_res TFAIL "Fail to recognise a binary type"
+	fi
+}
+
+expect_unrecognised()
+{
+	local file=$1
+	local string=$2
+
+	eval $file >temp 2>&1
+	if [ $? -ne 0 ] && ! grep -q "$string" temp; then
+		tst_res TPASS "Fail to recognise a binary type"
+	else
+		tst_res TFAIL "Recognise a binary type successfully"
+	fi
+}
+
+verify_binfmt_misc()
+{
+	local delimiter=${1:0:1}
+	local name=$(echo "$1" | awk -F $delimiter '{print $2}')
+	local ttype=$(echo "$1" | awk -F $delimiter '{print $3}')
+	local tfile=$2
+	local disabled=$3
+	local mntpoint=$(get_binfmt_misc_mntpoint)
+
+	(echo "$1" >"$mntpoint/register") 2>/dev/null
+	if [ $? -ne 0 -o ! -f "$mntpoint/$name" ]; then
+		tst_res TFAIL "Fail to register a binary type"
+		return
+	fi
+
+	[ "$ttype" = "E" ] && local tstring="This is test for extension"
+	[ "$ttype" = "M" ] && local tstring="This is test for magic"
+
+	if [ "$disabled" = "1" ]; then
+		(echo 0 >"$mntpoint/$name") 2>/dev/null
+		if [ $? -ne 0 ] || grep -q enable "$mntpoint/$name"; then
+			remove_binary_type "$mntpoint/$name"
+			tst_res TFAIL "Fail to disable a binary type"
+			return
+		fi
+	fi
+
+	[ -z "$disabled" ] && expect_recognised "$tfile" "$tstring"
+	[ -n "$disabled" ] && expect_unrecognised "$tfile" "$tstring"
+
+	remove_binary_type "$mntpoint/$name"
+}
+
+do_test()
+{
+	case $1 in
+	1) verify_binfmt_misc ":textension:E::extension::$(which perl):" \
+			      "$TST_DATAROOT/file.extension";;
+	2) verify_binfmt_misc ":tmagic:M:1:print::$(which perl):" \
+			      "$TST_DATAROOT/file.magic";;
+	3) verify_binfmt_misc ".textension.E..extension..$(which perl)." \
+			      "$TST_DATAROOT/file.extension";;
+	4) verify_binfmt_misc ",tmagic,M,1,print,,$(which perl)," \
+			      "$TST_DATAROOT/file.magic";;
+	5) verify_binfmt_misc ":textension:E::ltp::$(which perl):" \
+			      "$TST_DATAROOT/file.extension" "0";;
+	6) verify_binfmt_misc ":tmagic:M:0:print::$(which perl):" \
+			      "$TST_DATAROOT/file.magic" "0";;
+	7) verify_binfmt_misc ":textension:E::extension::$(which perl):" \
+			      "$TST_DATAROOT/file.extension" "1";;
+	8) verify_binfmt_misc ":tmagic:M:1:print::$(which perl):" \
+			      "$TST_DATAROOT/file.magic" "1";;
+	esac
+}
+
+tst_run
diff --git a/testcases/kernel/fs/binfmt_misc/datafiles/Makefile b/testcases/kernel/fs/binfmt_misc/datafiles/Makefile
new file mode 100644
index 0000000..e6d1487
--- /dev/null
+++ b/testcases/kernel/fs/binfmt_misc/datafiles/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
+# Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+
+top_srcdir              ?= ../../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_DIR		:= testcases/data/binfmt_misc02
+INSTALL_TARGETS		:= file.extension file.magic
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/fs/binfmt_misc/datafiles/file.extension b/testcases/kernel/fs/binfmt_misc/datafiles/file.extension
new file mode 100755
index 0000000..054ee07
--- /dev/null
+++ b/testcases/kernel/fs/binfmt_misc/datafiles/file.extension
@@ -0,0 +1 @@
+print "This is test for extension\n"
diff --git a/testcases/kernel/fs/binfmt_misc/datafiles/file.magic b/testcases/kernel/fs/binfmt_misc/datafiles/file.magic
new file mode 100755
index 0000000..a018abf
--- /dev/null
+++ b/testcases/kernel/fs/binfmt_misc/datafiles/file.magic
@@ -0,0 +1 @@
+ print "This is test for magic\n"
-- 
1.8.3.1



