From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Tue, 3 Nov 2015 19:43:27 +0800
Subject: [LTP] [PATCH v2] commands/mkfs: Added new testcase to test mkfs(8)
	command.
In-Reply-To: <56385136.8060007@cn.fujitsu.com>
References: <56385136.8060007@cn.fujitsu.com>
Message-ID: <1446551007-7826-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test mkfs(8) command with some basic options.

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 runtest/commands                  |  10 ++
 testcases/commands/mkfs/Makefile  |  24 +++++
 testcases/commands/mkfs/mkfs01.sh | 217 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 251 insertions(+)
 create mode 100644 testcases/commands/mkfs/Makefile
 create mode 100755 testcases/commands/mkfs/mkfs01.sh

diff --git a/runtest/commands b/runtest/commands
index e5260ba..6c0485b 100644
--- a/runtest/commands
+++ b/runtest/commands
@@ -28,3 +28,13 @@ df01_xfs df01.sh -f xfs
 df01_vfat df01.sh -f vfat
 df01_exfat df01.sh -f exfat
 df01_ntfs df01.sh -f ntfs
+mkfs01 mkfs01.sh
+mkfs01_ext2 mkfs01.sh -f ext2
+mkfs01_ext3 mkfs01.sh -f ext3
+mkfs01_ext4 mkfs01.sh -f ext4
+mkfs01_xfs mkfs01.sh -f xfs
+mkfs01_btrfs mkfs01.sh -f btrfs
+mkfs01_minix mkfs01.sh -f minix
+mkfs01_msdos mkfs01.sh -f msdos
+mkfs01_vfat mkfs01.sh -f vfat
+mkfs01_ntfs mkfs01.sh -f ntfs
diff --git a/testcases/commands/mkfs/Makefile b/testcases/commands/mkfs/Makefile
new file mode 100644
index 0000000..6099017
--- /dev/null
+++ b/testcases/commands/mkfs/Makefile
@@ -0,0 +1,24 @@
+#
+#    commands/mkfs testcases Makefile.
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
+INSTALL_TARGETS		:= mkfs01.sh
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/mkfs/mkfs01.sh b/testcases/commands/mkfs/mkfs01.sh
new file mode 100755
index 0000000..c1337a6
--- /dev/null
+++ b/testcases/commands/mkfs/mkfs01.sh
@@ -0,0 +1,217 @@
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
+# Test mkfs command with some basic options.
+#
+
+TCID=mkfs01
+TST_TOTAL=5
+. test.sh
+
+setup()
+{
+	tst_require_root
+
+	tst_check_cmds blkid df
+
+	if [ -n "$FS_TYPE" ]; then
+		tst_check_cmds mkfs.${FS_TYPE}
+	fi
+
+	tst_tmpdir
+
+	tst_acquire_device
+
+	TST_CLEANUP="cleanup"
+
+	ROD_SILENT mkdir -p mntpoint
+}
+
+cleanup()
+{
+	tst_release_device
+
+	tst_rmdir
+}
+
+mkfs_mount()
+{
+	mount ${TST_DEVICE} mntpoint
+	local ret=$?
+	if [ $ret -eq 32 ]; then
+		tst_brkm TCONF "Cannot mount ${FS_TYPE}, missing driver?"
+	fi
+
+	if [ $ret -ne 0 ]; then
+		tst_brkm TBROK "Failed to mount device: mount exit = $ret"
+	fi
+}
+
+mkfs_umount()
+{
+	grep -q ${TST_DEVICE} /proc/mounts
+	if [ $? -eq 0 ]; then
+		umount ${TST_DEVICE}
+		if [ $? -ne 0 ];then
+			tst_resm TWARN "'umount ${TST_DEVICE}' failed"
+		fi
+	else
+		tst_resm TINFO "${TST_DEVICE} is not mounted"
+	fi
+}
+
+usage()
+{
+	cat << EOF
+	usage: $0 [-f <ext2|ext3|ext4|vfat|...>]
+
+	OPTIONS
+		-f	Specify the type of filesystem to be built. If not
+			specified, the default filesystem type (currently ext2)
+			is used.
+		-h	Display help text and exit.
+
+EOF
+	tst_brkm TWARN "Display help text or unknown options"
+}
+
+mkfs_verify_type()
+{
+	if [ -z "$1" ]; then
+		blkid $2 | grep -q "ext2"
+	else
+		blkid $2 | grep -q "$1"
+	fi
+}
+
+mkfs_verify_size()
+{
+	mkfs_mount
+	local blocknum=`df -aT mntpoint | tail -n1 | awk '{print $3}'`
+	mkfs_umount
+
+	if [ $blocknum -gt "$1" ]; then
+		return 1
+	fi
+}
+
+mkfs_test()
+{
+	local mkfs_op=$1
+	local fs_type=$2
+	local fs_op=$3
+	local device=$4
+	local size=$5
+
+	if [ -n "$fs_type" ]; then
+		mkfs_op="-t $fs_type"
+	fi
+
+	if [ "$fs_type" = "xfs" ] || [ "$fs_type" = "btrfs" ]; then
+		fs_op="$fs_op -f"
+	fi
+
+	local mkfs_cmd="mkfs $mkfs_op $fs_op $device $size"
+
+	echo ${fs_op} | grep -q "\-c"
+	if [ $? -eq 0 ] && [ "$fs_type" = "ntfs" ]; then
+		tst_resm TCONF "'${mkfs_cmd}' not supported."
+		return
+	fi
+
+	if [ -n "$size" ]; then
+		if [ "$fs_type" = "xfs" ] || [ "$fs_type" = "btrfs" ]; then
+			tst_resm TCONF "'${mkfs_cmd}' not supported."
+			return
+		fi
+	fi
+
+	${mkfs_cmd} >temp 2>&1
+	if [ $? -ne 0 ]; then
+		grep -q -E "unknown option | invalid option" temp
+		if [ $? -eq 0 ]; then
+			tst_resm TCONF "'${mkfs_cmd}' not supported."
+			return
+		else
+			tst_resm TFAIL "'${mkfs_cmd}' failed."
+			cat temp
+			return
+		fi
+	fi
+
+	if [ -n "$device" ]; then
+		mkfs_verify_type "$fs_type" "$device"
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "'${mkfs_cmd}' failed, not expected."
+			return
+		fi
+	fi
+
+	if [ -n "$size" ]; then
+		mkfs_verify_size "$size"
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "'${mkfs_cmd}' failed, not expected."
+			return
+		fi
+	fi
+
+	tst_resm TPASS "'${mkfs_cmd}' passed."
+}
+
+test1()
+{
+	mkfs_test "" "$FS_TYPE" "" "$TST_DEVICE"
+}
+
+test2()
+{
+	mkfs_test "" "$FS_TYPE" "" "$TST_DEVICE" "10000"
+}
+
+test3()
+{
+	mkfs_test "" "$FS_TYPE" "-c" "$TST_DEVICE"
+}
+
+test4()
+{
+	mkfs_test "-V"
+}
+
+test5()
+{
+	mkfs_test "-h"
+}
+
+FS_TYPE=""
+
+while getopts f:h OPTION; do
+	case $OPTION in
+	f)
+		FS_TYPE=$OPTARG;;
+	h)
+		usage;;
+	?)
+		usage;;
+	esac
+done
+
+setup
+for i in $(seq 1 ${TST_TOTAL})
+do
+	test$i
+done
+
+tst_exit
-- 
1.8.4.2

