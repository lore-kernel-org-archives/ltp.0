From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 19 Feb 2019 10:42:46 +0800
Subject: [LTP] [PATCH v2] fs/binfmt_misc01.sh: Add new test for invalid
	inputs
In-Reply-To: <20190218161316.GE25025@rei.lan>
References: <20190218161316.GE25025@rei.lan>
Message-ID: <1550544166-7049-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Use various invalid inputs to register a new binary type.

Note:
This is also a regression test for the following kernel bug:
'5cc41e099504 ("fs/binfmt_misc.c: do not allow offset overflow")

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/fs                                         |  2 +
 testcases/kernel/fs/binfmt_misc/Makefile           | 12 ++++
 testcases/kernel/fs/binfmt_misc/binfmt_misc01.sh   | 67 ++++++++++++++++++++++
 testcases/kernel/fs/binfmt_misc/binfmt_misc_lib.sh | 65 +++++++++++++++++++++
 4 files changed, 146 insertions(+)
 create mode 100644 testcases/kernel/fs/binfmt_misc/Makefile
 create mode 100755 testcases/kernel/fs/binfmt_misc/binfmt_misc01.sh
 create mode 100755 testcases/kernel/fs/binfmt_misc/binfmt_misc_lib.sh

diff --git a/runtest/fs b/runtest/fs
index aca7e35..227c186 100644
--- a/runtest/fs
+++ b/runtest/fs
@@ -82,3 +82,5 @@ quota_remount_test01 quota_remount_test01.sh
 isofs isofs.sh
 
 fs_fill fs_fill
+
+binfmt_misc01 binfmt_misc01.sh
diff --git a/testcases/kernel/fs/binfmt_misc/Makefile b/testcases/kernel/fs/binfmt_misc/Makefile
new file mode 100644
index 0000000..f9819ad
--- /dev/null
+++ b/testcases/kernel/fs/binfmt_misc/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
+# Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+
+top_srcdir              ?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_TARGETS         := binfmt_misc01.sh binfmt_misc_lib.sh
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/fs/binfmt_misc/binfmt_misc01.sh b/testcases/kernel/fs/binfmt_misc/binfmt_misc01.sh
new file mode 100755
index 0000000..6c9aa64
--- /dev/null
+++ b/testcases/kernel/fs/binfmt_misc/binfmt_misc01.sh
@@ -0,0 +1,67 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
+# Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+#
+# Description:
+# Use various invalid inputs to register a new binary type.
+# 1) Invalid format of string fails to register a new binary type.
+# 2) Invalid type fails to register a new binary type.
+# 3) Invalid name containing slashes fails to register a new
+#    binary type.
+# 4) If extension matching is chosen, invalid magic containing
+#    slashes fails to register a new binary type.
+# 5) If magic matching is chosen, invalid offset(e.g. -1 and
+#    2500000000) fails to register a new binary type.
+# 6) Invalid flag fails to register a new binary type.
+#
+# Note:
+# This is also a regression test for the following kernel bug:
+# '5cc41e099504 ("fs/binfmt_misc.c: do not allow offset overflow")'
+
+
+TST_CNT=9
+TST_TESTFUNC=do_test
+TST_NEEDS_CMDS="cat"
+
+. binfmt_misc_lib.sh
+
+verify_binfmt_misc()
+{
+	local name=$(echo "$1" | awk -F ':' '{print $2}')
+	local mntpoint=$(get_binfmt_misc_mntpoint)
+
+	(echo "$1" >"$mntpoint/register") 2>/dev/null
+	if [ $? -ne 0 -a ! -f "$mntpoint/$name" ]; then
+		tst_res TPASS "Failed to register a binary type"
+		return
+	fi
+
+	# Trigger kernel crash reliably by cat command.
+	cat "$mntpoint/$name" >/dev/null 2>&1
+	tst_res TFAIL "Register a binary type successfully"
+
+	if [ -f "$mntpoint/$name" ]; then
+		(echo -1 >"$mntpoint/$name") 2>/dev/null
+		[ $? -ne 0 -o -f "$mntpoint/$name" ] && \
+			tst_res TWARN "Failed to remove a binary type"
+	fi
+}
+
+do_test()
+{
+	case $1 in
+	1) verify_binfmt_misc ".textension,E,,ltp,,$(which cat),";;
+	2) verify_binfmt_misc ":tnone:X::ltp::$(which cat):";;
+	3) verify_binfmt_misc ":textension/:E::ltp::$(which cat):";;
+	4) verify_binfmt_misc ":tmagic/:M::ltp::$(which cat):";;
+	5) verify_binfmt_misc ":textension:E::ltp/::$(which cat):";;
+	6) verify_binfmt_misc ":tmagic:M:-1:ltp::$(which cat):";;
+	7) verify_binfmt_misc ":tmagic:M:2500000000:ltp::$(which cat):";;
+	8) verify_binfmt_misc ":textension:E::ltp::$(which cat):A";;
+	9) verify_binfmt_misc ":tmagic:M::ltp::$(which cat):A";;
+	esac
+}
+
+tst_run
diff --git a/testcases/kernel/fs/binfmt_misc/binfmt_misc_lib.sh b/testcases/kernel/fs/binfmt_misc/binfmt_misc_lib.sh
new file mode 100755
index 0000000..5d00ab6
--- /dev/null
+++ b/testcases/kernel/fs/binfmt_misc/binfmt_misc_lib.sh
@@ -0,0 +1,65 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
+# Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+
+TST_SETUP=binfmt_misc_setup
+TST_CLEANUP=binfmt_misc_cleanup
+TST_NEEDS_DRIVERS="binfmt_misc"
+TST_NEEDS_TMPDIR=1
+TST_NEEDS_ROOT=1
+TST_NEEDS_CMDS="${TST_NEEDS_CMDS} modprobe mount umount mkdir rm"
+
+. tst_test.sh
+
+rmod_binfmt_misc=0
+umount_binfmt_misc=0
+binfmt_misc_mntpoint="ltp_binfmt_misc"
+
+get_binfmt_misc_mntpoint()
+{
+	local mntpoint
+
+	mntpoint=$(awk '/ binfmt_misc / { print $2 }' /proc/mounts)
+	[ -z "$mntpoint" ] && tst_brk TBROK "Can't get binfmt_misc mntpoint"
+
+	echo "$mntpoint"
+}
+
+binfmt_misc_setup()
+{
+	local mntpoint
+
+	if ! grep -q "binfmt_misc" /proc/filesystems; then
+		ROD modprobe binfmt_misc
+		rmod_binfmt_misc=1
+	fi
+
+	# Match fs type accurately, because autofs is also mounted on
+	# /proc/sys/fs/binfmt_misc on some distros, as below:
+	# cat /proc/mounts | grep binfmt_misc
+	# systemd-1 /proc/sys/fs/binfmt_misc autofs ...
+	# binfmt_misc /proc/sys/fs/binfmt_misc binfmt_misc ...
+	mntpoint=$(awk '/ binfmt_misc / { print $2 }' /proc/mounts)
+	[ -n "$mntpoint" ] && return
+
+	ROD mkdir ${binfmt_misc_mntpoint}
+	ROD mount -t binfmt_misc none ${binfmt_misc_mntpoint}
+	umount_binfmt_misc=1
+}
+
+binfmt_misc_cleanup()
+{
+	if [ ${umount_binfmt_misc} -ne 0 ]; then
+		umount ${binfmt_misc_mntpoint}
+		umount_binfmt_misc=0
+	fi
+
+	[ -d ${binfmt_misc_mntpoint} ] && rm -rf ${binfmt_misc_mntpoint}
+
+	if [ ${rmod_binfmt_misc} -ne 0 ]; then
+		modprobe -r binfmt_misc
+		rmod_binfmt_misc=0
+	fi
+}
-- 
1.8.3.1



