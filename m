From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 11 Nov 2019 15:09:20 +0100
Subject: [LTP] [PATCH] zram: Rewrite shell tests into new API
Message-ID: <20191111140920.24033-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Simplified code by using ROD instead of redirection into log file,
mkfs.$fs kept redirected into err.log due multiline output in stdout
(useful when debug error).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/device-drivers/zram/zram01.sh      |  67 ++++-----
 .../kernel/device-drivers/zram/zram02.sh      |  44 ++----
 .../kernel/device-drivers/zram/zram_lib.sh    | 139 ++++++++----------
 3 files changed, 101 insertions(+), 149 deletions(-)

diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
index cc8b5193a..7f855ef37 100755
--- a/testcases/kernel/device-drivers/zram/zram01.sh
+++ b/testcases/kernel/device-drivers/zram/zram01.sh
@@ -1,29 +1,14 @@
 #!/bin/sh
 # Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
+# Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
 # Test creates several zram devices with different filesystems on them.
 # It fills each device with zeros and checks that compression works.
-#
-# Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
-TCID="zram01"
-TST_TOTAL=8
-
-. test.sh
+TST_CNT=7
+TST_TESTFUNC="do_test"
+TST_NEEDS_CMDS="awk bc dd"
 . zram_lib.sh
 
 # Test will create the following number of zram devices:
@@ -37,7 +22,7 @@ FS_TYPE="btrfs"
 
 RAM_SIZE=$(awk '/MemTotal:/ {print $2}' /proc/meminfo)
 if [ "$RAM_SIZE" -lt 1048576 ]; then
-	tst_resm TINFO "Not enough space for Btrfs"
+	tst_res TINFO "not enough space for Btrfs"
 	FS_SIZE="26214400"
 	FS_TYPE="ext2"
 fi
@@ -54,14 +39,10 @@ zram_mem_limits="25M 25M 25M $((FS_SIZE/1024/1024))M"
 zram_filesystems="ext3 ext4 xfs $FS_TYPE"
 zram_algs="lzo lzo lzo lzo"
 
-TST_CLEANUP="zram_cleanup"
-
 zram_fill_fs()
 {
-	tst_require_cmds awk bc dd
-
 	for i in $(seq 0 $(($dev_num - 1))); do
-		tst_resm TINFO "fill zram$i..."
+		tst_res TINFO "filling zram$i (it can take long time)"
 		local b=0
 		while true; do
 			dd conv=notrunc if=/dev/zero of=zram${i}/file \
@@ -70,14 +51,14 @@ zram_fill_fs()
 			b=$(($b + 1))
 		done
 		if [ $b -eq 0 ]; then
-			[ -s err.txt ] && tst_resm TWARN "dd error: $(cat err.txt)"
-			tst_brkm TBROK "cannot fill zram"
+			[ -s err.txt ] && tst_res TWARN "dd error: $(cat err.txt)"
+			tst_brk TBROK "cannot fill zram $i"
 		fi
-		tst_resm TPASS "zram$i can be filled with '$b' KB"
+		tst_res TPASS "zram$i was filled with '$b' KB"
 
 		if [ ! -f "/sys/block/zram$i/mm_stat" ]; then
 			if [ $i -eq 0 ]; then
-				tst_resm TCONF "zram compression ratio test requires zram mm_stat sysfs file"
+				tst_res TCONF "zram compression ratio test requires zram mm_stat sysfs file"
 			fi
 
 			continue
@@ -88,21 +69,25 @@ zram_fill_fs()
 		local r=`echo "scale=2; $v / 100 " | bc`
 
 		if [ "$v" -lt 100 ]; then
-			tst_resm TFAIL "compression ratio: $r:1"
+			tst_res TFAIL "compression ratio: $r:1"
 			break
 		fi
 
-		tst_resm TPASS "compression ratio: $r:1"
+		tst_res TPASS "compression ratio: $r:1"
 	done
 }
 
-zram_load
-zram_max_streams
-zram_compress_alg
-zram_set_disksizes
-zram_set_memlimit
-zram_makefs
-zram_mount
-zram_fill_fs
+do_test()
+{
+	case $1 in
+	 1) zram_max_streams;;
+	 2) zram_compress_alg;;
+	 3) zram_set_disksizes;;
+	 4) zram_set_memlimit;;
+	 5) zram_makefs;;
+	 6) zram_mount;;
+	 7) zram_fill_fs;;
+	esac
+}
 
-tst_exit
+tst_run
diff --git a/testcases/kernel/device-drivers/zram/zram02.sh b/testcases/kernel/device-drivers/zram/zram02.sh
index 59b3f9fec..f97cf646c 100755
--- a/testcases/kernel/device-drivers/zram/zram02.sh
+++ b/testcases/kernel/device-drivers/zram/zram02.sh
@@ -1,28 +1,12 @@
 #!/bin/sh
 # Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
+# Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
 # Test checks that we can create swap zram device.
-#
-# Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
-TCID="zram02"
-TST_TOTAL=7
-
-. test.sh
+TST_CNT=5
+TST_TESTFUNC="do_test"
 . zram_lib.sh
 
 # Test will create the following number of zram devices:
@@ -41,13 +25,15 @@ zram_max_streams="2"
 zram_sizes="107374182400" # 100GB
 zram_mem_limits="1M"
 
-TST_CLEANUP="zram_cleanup"
-
-zram_load
-zram_max_streams
-zram_set_disksizes
-zram_set_memlimit
-zram_makeswap
-zram_swapoff
+do_test()
+{
+	case $1 in
+	 1) zram_max_streams;;
+	 2) zram_set_disksizes;;
+	 3) zram_set_memlimit;;
+	 4) zram_makeswap;;
+	 5) zram_swapoff;;
+	esac
+}
 
-tst_exit
+tst_run
diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh b/testcases/kernel/device-drivers/zram/zram_lib.sh
index d51b527f6..68b933cc4 100755
--- a/testcases/kernel/device-drivers/zram/zram_lib.sh
+++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
@@ -1,31 +1,20 @@
 #!/bin/sh
 # Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
 dev_makeswap=-1
 dev_mounted=-1
 
-trap tst_exit INT
+TST_NEEDS_TMPDIR=1
+TST_SETUP="zram_load"
+TST_CLEANUP="zram_cleanup"
+. tst_test.sh
 
 zram_cleanup()
 {
-	tst_resm TINFO "zram cleanup"
-	local i=
+	local i
+
 	for i in $(seq 0 $dev_makeswap); do
 		swapoff /dev/zram$i
 	done
@@ -39,193 +28,185 @@ zram_cleanup()
 	done
 
 	rmmod zram > /dev/null 2>&1
-
-	tst_rmdir
 }
 
 zram_load()
 {
-	tst_resm TINFO "create '$dev_num' zram device(s)"
+	tst_res TINFO "create '$dev_num' zram device(s)"
 	modprobe zram num_devices=$dev_num || \
-		tst_brkm TBROK "failed to insert zram module"
+		tst_brk TBROK "failed to insert zram module"
 
 	dev_num_created=$(ls /dev/zram* | wc -w)
 
 	if [ "$dev_num_created" -ne "$dev_num" ]; then
-		tst_brkm TFAIL "unexpected num of devices: $dev_num_created"
+		tst_brk TFAIL "unexpected num of devices: $dev_num_created"
 	else
-		tst_resm TPASS "test succeeded"
+		tst_res TPASS "test succeeded"
 	fi
-
-	tst_tmpdir
 }
 
 zram_max_streams()
 {
 	if tst_kvcmp -lt "3.15" -o -ge "4.7"; then
-		tst_resm TCONF "The device attribute max_comp_streams was"\
+		tst_res TCONF "The device attribute max_comp_streams was"\
 		               "introduced in kernel 3.15 and deprecated in 4.7"
 		return
 	fi
 
-	tst_resm TINFO "set max_comp_streams to zram device(s)"
+	tst_res TINFO "set max_comp_streams to zram device(s)"
 
 	local i=0
+
 	for max_s in $zram_max_streams; do
 		local sys_path="/sys/block/zram${i}/max_comp_streams"
 		echo $max_s > $sys_path || \
-			tst_brkm TFAIL "failed to set '$max_s' to $sys_path"
+			tst_brk TFAIL "failed to set '$max_s' to $sys_path"
 		local max_streams=$(cat $sys_path)
 
 		[ "$max_s" -ne "$max_streams" ] && \
-			tst_brkm TFAIL "can't set max_streams '$max_s', get $max_stream"
+			tst_brk TFAIL "can't set max_streams '$max_s', get $max_stream"
 
 		i=$(($i + 1))
-		tst_resm TINFO "$sys_path = '$max_streams' ($i/$dev_num)"
+		tst_res TINFO "$sys_path = '$max_streams' ($i/$dev_num)"
 	done
 
-	tst_resm TPASS "test succeeded"
+	tst_res TPASS "test succeeded"
 }
 
 zram_compress_alg()
 {
 	if tst_kvcmp -lt "3.15"; then
-		tst_resm TCONF "device attribute comp_algorithm is"\
+		tst_res TCONF "device attribute comp_algorithm is"\
 			"introduced since kernel v3.15, the running kernel"\
 			"does not support it"
 		return
 	fi
 
-	tst_resm TINFO "test that we can set compression algorithm"
+	local i=0
 
+	tst_res TINFO "test that we can set compression algorithm"
 	local algs="$(cat /sys/block/zram0/comp_algorithm)"
-	tst_resm TINFO "supported algs: $algs"
-	local i=0
+	tst_res TINFO "supported algs: $algs"
+
 	for alg in $zram_algs; do
 		local sys_path="/sys/block/zram${i}/comp_algorithm"
 		echo "$alg" >  $sys_path || \
-			tst_brkm TFAIL "can't set '$alg' to $sys_path"
+			tst_brk TFAIL "can't set '$alg' to $sys_path"
 		i=$(($i + 1))
-		tst_resm TINFO "$sys_path = '$alg' ($i/$dev_num)"
+		tst_res TINFO "$sys_path = '$alg' ($i/$dev_num)"
 	done
 
-	tst_resm TPASS "test succeeded"
+	tst_res TPASS "test succeeded"
 }
 
 zram_set_disksizes()
 {
-	tst_resm TINFO "set disk size to zram device(s)"
 	local i=0
+	local ds
+
+	tst_res TINFO "set disk size to zram device(s)"
 	for ds in $zram_sizes; do
 		local sys_path="/sys/block/zram${i}/disksize"
 		echo "$ds" >  $sys_path || \
-			tst_brkm TFAIL "can't set '$ds' to $sys_path"
+			tst_brk TFAIL "can't set '$ds' to $sys_path"
 
 		i=$(($i + 1))
-		tst_resm TINFO "$sys_path = '$ds' ($i/$dev_num)"
+		tst_res TINFO "$sys_path = '$ds' ($i/$dev_num)"
 	done
 
-	tst_resm TPASS "test succeeded"
+	tst_res TPASS "test succeeded"
 }
 
 zram_set_memlimit()
 {
 	if tst_kvcmp -lt "3.18"; then
-		tst_resm TCONF "device attribute mem_limit is"\
+		tst_res TCONF "device attribute mem_limit is"\
 			"introduced since kernel v3.18, the running kernel"\
 			"does not support it"
 		return
 	fi
 
-	tst_resm TINFO "set memory limit to zram device(s)"
-
 	local i=0
+	local ds
+
+	tst_res TINFO "set memory limit to zram device(s)"
+
 	for ds in $zram_mem_limits; do
 		local sys_path="/sys/block/zram${i}/mem_limit"
 		echo "$ds" >  $sys_path || \
-			tst_brkm TFAIL "can't set '$ds' to $sys_path"
+			tst_brk TFAIL "can't set '$ds' to $sys_path"
 
 		i=$(($i + 1))
-		tst_resm TINFO "$sys_path = '$ds' ($i/$dev_num)"
+		tst_res TINFO "$sys_path = '$ds' ($i/$dev_num)"
 	done
 
-	tst_resm TPASS "test succeeded"
+	tst_res TPASS "test succeeded"
 }
 
 zram_makeswap()
 {
-	tst_resm TINFO "make swap with zram device(s)"
+	tst_res TINFO "make swap with zram device(s)"
 	tst_require_cmds mkswap swapon swapoff
 	local i=0
-	for i in $(seq 0 $(($dev_num - 1))); do
-		mkswap /dev/zram$i > err.log 2>&1
-		if [ $? -ne 0 ]; then
-			cat err.log
-			tst_brkm TFAIL "mkswap /dev/zram$1 failed"
-		fi
 
-		swapon /dev/zram$i > err.log 2>&1
-		if [ $? -ne 0 ]; then
-			cat err.log
-			tst_brkm TFAIL "swapon /dev/zram$1 failed"
-		fi
-
-		tst_resm TINFO "done with /dev/zram$i"
+	for i in $(seq 0 $(($dev_num - 1))); do
+		ROD mkswap /dev/zram$i
+		ROD swapon /dev/zram$i
+		tst_res TINFO "done with /dev/zram$i"
 		dev_makeswap=$i
 	done
 
-	tst_resm TPASS "making zram swap succeeded"
+	tst_res TPASS "making zram swap succeeded"
 }
 
 zram_swapoff()
 {
 	tst_require_cmds swapoff
-	local i=
+	local i
+
 	for i in $(seq 0 $dev_makeswap); do
-		swapoff /dev/zram$i > err.log 2>&1
-		if [ $? -ne 0 ]; then
-			cat err.log
-			tst_brkm TFAIL "swapoff /dev/zram$i failed"
-		fi
+		ROD swapoff /dev/zram$i
 	done
 	dev_makeswap=-1
 
-	tst_resm TPASS "swapoff completed"
+	tst_res TPASS "swapoff completed"
 }
 
 zram_makefs()
 {
 	tst_require_cmds mkfs
 	local i=0
+
 	for fs in $zram_filesystems; do
 		# if requested fs not supported default it to ext2
 		tst_supported_fs $fs 2> /dev/null || fs=ext2
 
-		tst_resm TINFO "make $fs filesystem on /dev/zram$i"
+		tst_res TINFO "make $fs filesystem on /dev/zram$i"
 		mkfs.$fs /dev/zram$i > err.log 2>&1
 		if [ $? -ne 0 ]; then
 			cat err.log
-			tst_brkm TFAIL "failed to make $fs on /dev/zram$i"
+			tst_brk TFAIL "failed to make $fs on /dev/zram$i"
 		fi
+
 		i=$(($i + 1))
 	done
 
-	tst_resm TPASS "zram_makefs succeeded"
+	tst_res TPASS "zram_makefs succeeded"
 }
 
 zram_mount()
 {
 	local i=0
+
 	for i in $(seq 0 $(($dev_num - 1))); do
-		tst_resm TINFO "mount /dev/zram$i"
+		tst_res TINFO "mount /dev/zram$i"
 		mkdir zram$i
-		mount /dev/zram$i zram$i > /dev/null || \
-			tst_brkm TFAIL "mount /dev/zram$i failed"
+		ROD mount /dev/zram$i zram$i
 		dev_mounted=$i
 	done
 
-	tst_resm TPASS "mount of zram device(s) succeeded"
+	tst_res TPASS "mount of zram device(s) succeeded"
 }
 
 modinfo zram > /dev/null 2>&1 ||
-	tst_brkm TCONF "zram not configured in kernel"
+	tst_brk TCONF "zram not configured in kernel"
-- 
2.23.0

