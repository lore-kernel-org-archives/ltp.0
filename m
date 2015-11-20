From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Fri, 20 Nov 2015 14:04:28 +0800
Subject: [LTP] [PATCH v5] commands/mkswap: Added new testcase to test
	mkswap(8).
In-Reply-To: <564EB14C.7090906@cn.fujitsu.com>
References: <564EB14C.7090906@cn.fujitsu.com>
Message-ID: <1447999468-30044-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test mkswap(8) command with some basic options.

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 runtest/commands                      |   1 +
 testcases/commands/mkswap/Makefile    |  22 +++++
 testcases/commands/mkswap/mkswap01.sh | 156 ++++++++++++++++++++++++++++++++++
 3 files changed, 179 insertions(+)
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
index 0000000..5c8bd9b
--- /dev/null
+++ b/testcases/commands/mkswap/Makefile
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
+INSTALL_TARGETS		:= mkswap01.sh
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/mkswap/mkswap01.sh b/testcases/commands/mkswap/mkswap01.sh
new file mode 100755
index 0000000..2a0b3c7
--- /dev/null
+++ b/testcases/commands/mkswap/mkswap01.sh
@@ -0,0 +1,156 @@
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
+	tst_check_cmds uuidgen blkid blockdev mkswap
+
+	tst_tmpdir
+
+	TST_CLEANUP=cleanup
+
+	tst_acquire_device
+
+	UUID=`uuidgen`
+
+	DEVICE_SIZE=$((`blockdev --getsize64 $TST_DEVICE`/1024))
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
+	local mkswap_op=$1
+	local op_arg=$2
+	local swapfile=$3
+
+	local before=`awk '/SwapTotal/ {print $2}' /proc/meminfo`
+
+	local swapsize=${4:-$DEVICE_SIZE}
+
+	if [ "$mkswap_op" = "-p" ]; then
+		local pagesize=$op_arg
+	else
+		local pagesize=$PAGE_SIZE
+	fi
+
+	swapon $swapfile 2>/dev/null
+	if [ $? -ne 0 ]; then
+		tst_resm TINFO "Can not do swapon on $swapfile."
+		if [ $pagesize -ne $PAGE_SIZE ]; then
+			tst_resm TINFO "Page size specified by 'mkswap -p' \
+is not equal to system's page size."
+			tst_resm TINFO "Swapon failed expectedly."
+			return 0
+		fi
+
+		if [ $swapsize -gt $DEVICE_SIZE ]; then
+			tst_resm TINFO "Device size specified by 'mkswap' \
+greater than real size."
+			tst_resm TINFO "Swapon failed expectedly."
+			return 0
+		fi
+
+		tst_resm TINFO "Swapon failed unexpectedly."
+		return 1
+	fi
+
+	local after=`awk '/SwapTotal/ {print $2}' /proc/meminfo`
+
+	local diff=$((after-before))
+	local filesize=$((swapsize-pagesize/1024))
+
+	local ret=0
+
+	# In general, the swap increment by doing swapon should be equal to
+	# the device size minus a page size, however for some kernels, the
+	# increment we get is not exactly equal to that value, but is equal
+	# to the value minus an extra page size, e.g. on RHEL5.11GA.
+	if [ $diff -ne $filesize ] && \
+		[ $diff -ne $((filesize-pagesize/1024)) ]; then
+		ret=1
+	fi
+
+	swapoff $swapfile 2>/dev/null
+	if [ $? -ne 0 ]; then
+		tst_resm TWARN "Can not do swapoff on $swapfile."
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
+	local mkswap_cmd="mkswap $mkswap_op $op_arg $TST_DEVICE $size"
+
+	${mkswap_cmd} >temp 2>&1
+	if [ $? -ne 0 ]; then
+		grep -q -E "unknown option|invalid option|Usage" temp
+		if [ $? -eq 0 ]; then
+			tst_resm TCONF "'${mkswap_cmd}' not supported."
+			return
+		fi
+
+		tst_resm TFAIL "'${mkswap_cmd}' failed."
+		cat temp
+		return
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
+setup
+
+mkswap_test "" "" "$TST_DEVICE"
+mkswap_test "" "" "$TST_DEVICE" "$((DEVICE_SIZE-10000))"
+mkswap_test "-f" "" "$TST_DEVICE" "$((DEVICE_SIZE+10000))"
+mkswap_test "-c" "" "$TST_DEVICE"
+mkswap_test "-p" "2048" "$TST_DEVICE"
+mkswap_test "-L" "testswap" "-L testswap"
+mkswap_test "-v1" "" "$TST_DEVICE"
+mkswap_test "-U" "$UUID" "-U $UUID"
+mkswap_test "-V"
+mkswap_test "-h"
+
+tst_exit
-- 
1.8.4.2

