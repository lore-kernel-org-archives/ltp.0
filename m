From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 5 Nov 2015 11:03:48 +0800
Subject: [LTP] [PATCH] commands/mkswap: Added new testcase to test mkswap(8).
Message-ID: <1446692628-12706-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test mkswap(8) command with some basic options.

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 runtest/commands                      |   1 +
 testcases/commands/mkswap/Makefile    |  24 +++++
 testcases/commands/mkswap/mkswap01.sh | 196 ++++++++++++++++++++++++++++++++++
 3 files changed, 221 insertions(+)
 create mode 100644 testcases/commands/mkswap/Makefile
 create mode 100755 testcases/commands/mkswap/mkswap01.sh

diff --git a/runtest/commands b/runtest/commands
index 6c0485b..ab600dc 100644
--- a/runtest/commands
+++ b/runtest/commands
@@ -38,3 +38,4 @@ mkfs01_minix mkfs01.sh -f minix
 mkfs01_msdos mkfs01.sh -f msdos
 mkfs01_vfat mkfs01.sh -f vfat
 mkfs01_ntfs mkfs01.sh -f ntfs
+mkswap01 mkswap01.sh
diff --git a/testcases/commands/mkswap/Makefile b/testcases/commands/mkswap/Makefile
new file mode 100644
index 0000000..39651c0
--- /dev/null
+++ b/testcases/commands/mkswap/Makefile
@@ -0,0 +1,24 @@
+#
+#    commands/mkswap testcases Makefile.
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
+INSTALL_TARGETS		:= mkswap01.sh
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/mkswap/mkswap01.sh b/testcases/commands/mkswap/mkswap01.sh
new file mode 100755
index 0000000..e0c1a08
--- /dev/null
+++ b/testcases/commands/mkswap/mkswap01.sh
@@ -0,0 +1,196 @@
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
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+# GNU General Public License for more details.
+#
+# Test mkswap command with some basic options.
+#
+
+TCID=mkswap01
+TST_TOTAL=10
+. test.sh
+
+setup()
+{
+	tst_require_root
+
+	tst_check_cmds losetup free mkswap
+
+	tst_tmpdir
+
+	TST_CLEANUP=cleanup
+
+	tst_acquire_device
+
+	local path=`losetup -a | grep "$TMPDIR"  | awk '{print $3}' | \
+		cut -d '(' -f2 | cut -d ')' -f1`
+	DEVICE_SIZE=$((`ls -l $path | awk '{print $5}'`/1024))
+
+	PAGE_SIZE=`getconf PAGE_SIZE`
+}
+
+cleanup()
+{
+	tst_release_device
+
+	tst_rmdir
+}
+
+mkswap_verify()
+{
+	local ret=0
+
+	local before=`free | grep "Swap" | awk '{print $2}'`
+
+	if [ -z "$4" ]; then
+		local swapsize=$DEVICE_SIZE
+	else
+		local swapsize=$4
+	fi
+
+	if [ "$1" = "-p" ]; then
+		local pagesize=$2
+	else
+		local pagesize=$PAGE_SIZE
+	fi
+
+	if [ "$1" = "-L" ]; then
+		local swap_op="-L"
+		local swapfile=$2
+	elif [ "$1" = "-U" ]; then
+		local swap_op="-U"
+		local swapfile=$2
+	else
+		local swap_op=""
+		local swapfile=$3
+	fi
+
+	swapon $swap_op $swapfile 2>/dev/null
+	if [ $? -ne 0 ]; then
+		tst_resm TINFO "can not do swapon on $swapfile."
+		if [ $pagesize -ne $PAGE_SIZE ]; then
+			return $ret
+		fi
+
+		if [ $swapsize -gt $DEVICE_SIZE ]; then
+			return $ret
+		fi
+	fi
+
+	local after=`free | grep "Swap" | awk '{print $2}'`
+
+	local est=16
+	if [ $((after-before)) -lt $((swapsize-pagesize/1024-est)) ] || \
+		[ $((after-before)) -gt $((swapsize-pagesize/1024+est)) ]; then
+		ret=1
+	fi
+
+	swapoff $swap_op $swapfile 2>/dev/null
+	if [ $? -ne 0 ]; then
+		tst_resm TINFO "can not do swapoff on $swapfile."
+	fi
+
+	return $ret
+}
+
+mkswap_test()
+{
+	local mkswap_op=$1
+	local op_arg=$2
+	local device=$3
+	local size=$4
+
+	local mkswap_cmd="mkswap $mkswap_op $op_arg $device $size"
+
+	${mkswap_cmd} >temp 2>&1
+	if [ $? -ne 0 ]; then
+		grep -q -E "unknown option|invalid option|Usage" temp
+		if [ $? -eq 0 ]; then
+			tst_resm TCONF "'${mkswap_cmd}' not supported."
+			return
+		else
+			tst_resm TFAIL "'${mkswap_cmd}' failed."
+			cat temp
+			return
+		fi
+	fi
+
+	if [ -n "$device" ]; then
+		mkswap_verify "$mkswap_op" "$op_arg" "$device" "$size"
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "'${mkswap_cmd}' failed, not expected."
+			return
+		fi
+	fi
+
+	tst_resm TPASS "'${mkswap_cmd}' passed."
+}
+
+test1()
+{
+	mkswap_test "" "" "$TST_DEVICE"
+}
+
+test2()
+{
+	mkswap_test "" "" "$TST_DEVICE" "10000"
+}
+
+test3()
+{
+	mkswap_test "-f" "" "$TST_DEVICE" "30000"
+}
+
+test4()
+{
+	mkswap_test "-c" "" "$TST_DEVICE"
+}
+
+test5()
+{
+	mkswap_test "-p" "2048" "$TST_DEVICE"
+}
+
+test6()
+{
+	mkswap_test "-L" "testswap" "$TST_DEVICE"
+}
+
+test7()
+{
+	mkswap_test "-v1" "" "$TST_DEVICE"
+}
+
+test8()
+{
+	mkswap_test "-U" "ffffffff-ffff-ffff-ffff-ffffffffffff" "$TST_DEVICE"
+}
+
+test9()
+{
+	mkswap_test "-V"
+}
+
+test10()
+{
+	mkswap_test "-h"
+}
+
+setup
+
+for i in $(seq 1 ${TST_TOTAL})
+do
+	test$i
+done
+
+tst_exit
-- 
1.8.4.2

