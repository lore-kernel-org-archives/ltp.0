Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1Yafs6-0008GM-S6
	for ltp-list@lists.sourceforge.net; Wed, 25 Mar 2015 07:37:02 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Yafs3-0001cK-FJ
	for ltp-list@lists.sourceforge.net; Wed, 25 Mar 2015 07:37:02 +0000
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t2P7arPK010546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 25 Mar 2015 07:36:53 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t2P7aqjj031413
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 25 Mar 2015 07:36:52 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
	by aserv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t2P7aqLW012477
	for <ltp-list@lists.sourceforge.net>; Wed, 25 Mar 2015 07:36:52 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 25 Mar 2015 10:39:27 +0300
Message-Id: <1427269167-25299-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] device-drivers/zram: new zram test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com

* create library with initialization/cleanup functions
* add two functional tests: zram01 and zram02:
  zram01 creates general purpose ram disks with different filesystems
  zram02 creates block device for swap

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/kernel_misc                              |    2 +
 testcases/kernel/device-drivers/Makefile         |    3 +-
 testcases/kernel/device-drivers/zram/Makefile    |   22 +++
 testcases/kernel/device-drivers/zram/zram01.sh   |   89 +++++++++
 testcases/kernel/device-drivers/zram/zram02.sh   |   45 +++++
 testcases/kernel/device-drivers/zram/zram_lib.sh |  209 ++++++++++++++++++++++
 6 files changed, 369 insertions(+), 1 deletions(-)
 create mode 100644 testcases/kernel/device-drivers/zram/Makefile
 create mode 100755 testcases/kernel/device-drivers/zram/zram01.sh
 create mode 100755 testcases/kernel/device-drivers/zram/zram02.sh
 create mode 100755 testcases/kernel/device-drivers/zram/zram_lib.sh

diff --git a/runtest/kernel_misc b/runtest/kernel_misc
index 6a29de6..7615c15 100644
--- a/runtest/kernel_misc
+++ b/runtest/kernel_misc
@@ -9,3 +9,5 @@ cpufreq_boost cpufreq_boost
 uaccess uaccess
 rcu_torture rcu_torture.sh
 lock_torture lock_torture.sh
+zram01 zram01.sh
+zram02 zram02.sh
diff --git a/testcases/kernel/device-drivers/Makefile b/testcases/kernel/device-drivers/Makefile
index 551d137..55e0d25 100644
--- a/testcases/kernel/device-drivers/Makefile
+++ b/testcases/kernel/device-drivers/Makefile
@@ -26,6 +26,7 @@ SUBDIRS		:= acpi \
 		   rcu \
 		   rtc \
 		   tbio \
-		   uaccess
+		   uaccess \
+		   zram
 
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/device-drivers/zram/Makefile b/testcases/kernel/device-drivers/zram/Makefile
new file mode 100644
index 0000000..0d73f66
--- /dev/null
+++ b/testcases/kernel/device-drivers/zram/Makefile
@@ -0,0 +1,22 @@
+# Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+
+top_srcdir	?= ../../../..
+include $(top_srcdir)/include/mk/testcases.mk
+
+INSTALL_TARGETS		:= *.sh
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
new file mode 100755
index 0000000..49cbbe9
--- /dev/null
+++ b/testcases/kernel/device-drivers/zram/zram01.sh
@@ -0,0 +1,89 @@
+#!/bin/sh
+# Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+# Test creates several zram devices with different filesystems on them.
+# It fills each device with zeros and checks that compression works.
+#
+# Author: Alexey Kodanev <alexey.kodanev@oracle.com>
+
+TCID="zram01"
+TST_TOTAL=8
+
+. test.sh
+. zram_lib.sh
+
+# Test will create the following number of zram devices:
+dev_num=4
+# This is a list of parameters for zram devices.
+# Number of items must be equal to 'dev_num' parameter.
+zram_max_streams="2 3 5 8"
+zram_sizes="25M 25M 25M 25M"
+zram_mem_limits="25M 25M 25M 25M"
+zram_filesystems="ext3 ext4 xfs btrfs"
+zram_algs="lzo lzo lzo lzo"
+
+TST_CLEANUP="zram_cleanup"
+
+zram_fill_fs()
+{
+	tst_check_cmds dd free awk
+	local mem_free0=$(free -m | awk 'NR==2 {print $4}')
+
+	for i in $(seq 0 $(($dev_num - 1))); do
+		tst_resm TINFO "fill zram$i..."
+		local b=0
+		while ((1)); do
+			dd conv=notrunc if=/dev/zero of=zram${i}/file \
+				oflag=append count=1 bs=1024 status=none \
+				> /dev/null 2>&1 || break
+			b=$(($b + 1))
+		done
+		tst_resm TINFO "zram$i can be filled with '$b' KB"
+	done
+
+	local mem_free1=$(free -m | awk 'NR==2 {print $4}')
+	local used_mem=$(($mem_free0 - $mem_free1))
+
+	local total_size=0
+	for sm in $zram_sizes; do
+		local s=$(echo $sm | sed 's/M//')
+		total_size=$(($total_size + $s))
+	done
+
+	tst_resm TINFO "zram used ${used_mem}M, zram disk sizes ${total_size}M"
+
+	local v=$((100 * $total_size / $used_mem))
+
+	if [ "$v" -lt 100 ]; then
+		tst_resm TFAIL "compression ratio: 0.$v:1"
+		return
+	fi
+
+	tst_resm TPASS "compression ratio: $(echo "scale=2; $v / 100 " | bc):1"
+}
+
+zram_load
+zram_max_streams
+zram_compress_alg
+zram_set_disksizes
+zram_set_memlimit
+zram_makefs
+zram_mount
+
+zram_fill_fs
+
+tst_exit
diff --git a/testcases/kernel/device-drivers/zram/zram02.sh b/testcases/kernel/device-drivers/zram/zram02.sh
new file mode 100755
index 0000000..53f69bb
--- /dev/null
+++ b/testcases/kernel/device-drivers/zram/zram02.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+# Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+# Test checks that we can create swap zram device.
+#
+# Author: Alexey Kodanev <alexey.kodanev@oracle.com>
+
+TCID="zram02"
+TST_TOTAL=7
+
+. test.sh
+. zram_lib.sh
+
+# Test will create the following number of zram devices:
+dev_num=1
+# This is a list of parameters for zram devices.
+# Number of items must be equal to 'dev_num' parameter.
+zram_max_streams="2"
+zram_sizes="100G"
+zram_mem_limits="1M"
+
+TST_CLEANUP="zram_cleanup"
+
+zram_load
+zram_max_streams
+zram_set_disksizes
+zram_set_memlimit
+zram_makeswap
+zram_swapoff
+
+tst_exit
diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh b/testcases/kernel/device-drivers/zram/zram_lib.sh
new file mode 100755
index 0000000..a424bcc
--- /dev/null
+++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
@@ -0,0 +1,209 @@
+#!/bin/sh
+# Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+# Author: Alexey Kodanev <alexey.kodanev@oracle.com>
+
+dev_makeswap=-1
+dev_mounted=-1
+
+trap tst_exit INT
+
+zram_cleanup()
+{
+	tst_resm TINFO "zram cleanup"
+	local i=
+	for i in $(seq 0 $dev_makeswap); do
+		swapoff /dev/zram$i
+	done
+
+	for i in $(seq 0 $dev_mounted); do
+		umount /dev/zram$i
+	done
+
+	for i in $(seq 0 $(($dev_num - 1))); do
+		echo 1 > /sys/block/zram${i}/reset
+	done
+
+	rmmod zram > /dev/null 2>&1
+
+	tst_rmdir
+}
+
+zram_load()
+{
+	tst_resm TINFO "create '$dev_num' zram device(s)"
+	modprobe zram num_devices=$dev_num || \
+		tst_brkm TBROK "failed to insert zram module"
+
+	dev_num_created=$(ls /dev/zram* | wc -w)
+
+	if [ "$dev_num_created" -ne "$dev_num" ]; then
+		tst_brkm TFAIL "unexpected num of devices: $dev_num_created"
+	else
+		tst_resm TPASS "test succeeded"
+	fi
+
+	tst_tmpdir
+}
+
+zram_max_streams()
+{
+	tst_resm TINFO "set max_comp_streams to zram device(s)"
+
+	local i=0
+	for max_s in $zram_max_streams; do
+		local sys_path="/sys/block/zram${i}/max_comp_streams"
+		echo $max_s > $sys_path || \
+			tst_brkm TFAIL "failed to set '$max_s' to $sys_path"
+		local max_streams=$(cat $sys_path)
+
+		[ "$max_s" -ne "$max_streams" ] && \
+			tst_brkm TFAIL "can't set max_streams '$max_s', get $max_stream"
+
+		i=$(($i + 1))
+		tst_resm TINFO "$sys_path = '$max_streams' ($i/$dev_num)"
+	done
+
+	tst_resm TPASS "test succeeded"
+}
+
+zram_compress_alg()
+{
+	tst_resm TINFO "test that we can set compression algorithm"
+	local algs=$(cat /sys/block/zram0/comp_algorithm)
+	tst_resm TINFO "supported algs: $algs"
+	local i=0
+	for alg in $zram_algs; do
+		local sys_path="/sys/block/zram${i}/comp_algorithm"
+		echo "$alg" >  $sys_path || \
+			tst_brkm TFAIL "can't set 'lzo' to $sys_path"
+		i=$(($i + 1))
+		tst_resm TINFO "$sys_path = 'lzo' ($i/$dev_num)"
+	done
+
+	tst_resm TPASS "test succeeded"
+}
+
+zram_set_disksizes()
+{
+	tst_resm TINFO "set disk size to zram device(s)"
+	local i=0
+	for ds in $zram_sizes; do
+		local sys_path="/sys/block/zram${i}/disksize"
+		echo "$ds" >  $sys_path || \
+			tst_brkm TFAIL "can't set '$ds' to $sys_path"
+
+		i=$(($i + 1))
+		tst_resm TINFO "$sys_path = '$ds' ($i/$dev_num)"
+	done
+
+	tst_resm TPASS "test succeeded"
+}
+
+zram_set_memlimit()
+{
+	tst_resm TINFO "set memory limit to zram device(s)"
+	local i=0
+	for ds in $zram_mem_limits; do
+		local sys_path="/sys/block/zram${i}/mem_limit"
+		echo "$ds" >  $sys_path || \
+			tst_brkm TFAIL "can't set '$ds' to $sys_path"
+
+		i=$(($i + 1))
+		tst_resm TINFO "$sys_path = '$ds' ($i/$dev_num)"
+	done
+
+	tst_resm TPASS "test succeeded"
+}
+
+zram_makeswap()
+{
+	tst_resm TINFO "make swap with zram device(s)"
+	tst_check_cmds mkswap swapon swapoff
+	local i=0
+	for i in $(seq 0 $(($dev_num - 1))); do
+		mkswap /dev/zram$i > err.log 2>&1
+		if [ $? -ne 0 ]; then
+			cat err.log
+			tst_brkm TFAIL "mkswap /dev/zram$1 failed"
+		fi
+
+		swapon /dev/zram$i > err.log 2>&1
+		if [ $? -ne 0 ]; then
+			cat err.log
+			tst_brkm TFAIL "swapon /dev/zram$1 failed"
+		fi
+
+		tst_resm TINFO "done with /dev/zram$i"
+		dev_makeswap=$i
+	done
+
+	tst_resm TPASS "making zram swap succeeded"
+}
+
+zram_swapoff()
+{
+	tst_check_cmds swapoff
+	local i=
+	for i in $(seq 0 $dev_makeswap); do
+		swapoff /dev/zram$i > err.log 2>&1
+		if [ $? -ne 0 ]; then
+			cat err.log
+			tst_brkm TFAIL "swapoff /dev/zram$i failed"
+		fi
+	done
+	dev_makeswap=-1
+
+	tst_resm TPASS "swapoff completed"
+}
+
+zram_makefs()
+{
+	tst_check_cmds mkfs which
+	local i=0
+	for fs in $zram_filesystems; do
+		# if requested fs not supported default it to ext2
+		which mkfs.$fs > /dev/null 2>&1 || fs=ext2
+
+		tst_resm TINFO "make $fs filesystem on /dev/zram$i"
+		mkfs.$fs /dev/zram$i > err.log 2>&1
+		if [ $? -ne 0 ]; then
+			cat err.log
+			tst_brkm TFAIL "failed to make $fs on /dev/zram$i"
+		fi
+		i=$(($i + 1))
+	done
+
+	tst_resm TPASS "zram_makefs succeeded"
+}
+
+zram_mount()
+{
+	local i=0
+	for i in $(seq 0 $(($dev_num - 1))); do
+		tst_resm TINFO "mount /dev/zram$i"
+		mkdir zram$i
+		mount /dev/zram$i zram$i > /dev/null || \
+			tst_brkm TFAIL "mount /dev/zram$i failed"
+		dev_mounted=$i
+	done
+
+	tst_resm TPASS "mount of zram device(s) succeeded"
+}
+
+modinfo zram > /dev/null 2>&1 ||
+	tst_brkm TCONF "zram not configured in kernel"
-- 
1.7.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
