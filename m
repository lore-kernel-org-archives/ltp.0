From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 29 Jan 2021 13:18:15 +0100
Subject: [LTP] [PATCH 3/5] zram01.sh: Check properly mkfs.* dependencies
In-Reply-To: <20210129121817.12563-1-pvorel@suse.cz>
References: <20210129121817.12563-1-pvorel@suse.cz>
Message-ID: <20210129121817.12563-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Move check for supported system to setup().

Lower down number of created zram when missing filesystems
instead of previous fixed number and using ext2 as a fallback.
That requires to quit early when looping over other variables.

Keep fallback to ext2, but only if no other fs available and there is
mkfs.ext2 available. There is no much point to run ext2 fallback more
than once.

This also fixes problem when there is no filesystem support and also
mkfs.ext2 (fallback) not installed:
/opt/ltp/testcases/bin/zram01.sh: line 198: mkfs.ext2: not found

Quit at setup in case there is no fs support. But this can lead to
skipping zram_compress_alg(). This will be solved next commit by moving
zram_compress_alg() to zram02.sh.

Drop tst_require_cmds mkfs check, because mkfs is not actually needed.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/device-drivers/zram/zram01.sh      | 44 ++++++++++++++++++-
 .../kernel/device-drivers/zram/zram_lib.sh    | 18 ++++----
 2 files changed, 53 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
index a795ff89f..ef4ff4d75 100755
--- a/testcases/kernel/device-drivers/zram/zram01.sh
+++ b/testcases/kernel/device-drivers/zram/zram01.sh
@@ -10,10 +10,12 @@ TST_CNT=7
 TST_TESTFUNC="do_test"
 TST_NEEDS_CMDS="awk bc dd"
 . zram_lib.sh
+TST_SETUP="setup"
 
 # List of parameters for zram devices.
 # For each number the test creates own zram device.
 zram_max_streams="2 3 5 8"
+fallback_filesystem="ext2"
 
 FS_SIZE="402653184"
 FS_TYPE="btrfs"
@@ -22,7 +24,7 @@ RAM_SIZE=$(awk '/MemTotal:/ {print $2}' /proc/meminfo)
 if [ "$RAM_SIZE" -lt 1048576 ]; then
 	tst_res TINFO "not enough space for Btrfs"
 	FS_SIZE="26214400"
-	FS_TYPE="ext2"
+	FS_TYPE="$fallback_filesystem"
 fi
 
 # The zram sysfs node 'disksize' value can be either in bytes,
@@ -36,6 +38,46 @@ zram_sizes="26214400 26214400 26214400 $FS_SIZE"
 zram_mem_limits="25M 25M 25M $((FS_SIZE/1024/1024))M"
 zram_filesystems="ext3 ext4 xfs $FS_TYPE"
 
+check_fs_support()
+{
+	local fs unsupported
+	local msg="missing kernel support or mkfs for filesystems:"
+	dev_num=0
+
+	for fs in $zram_filesystems; do
+		if tst_supported_fs $fs 2> /dev/null; then
+			dev_num=$((dev_num+1))
+		else
+			unsupported="$unsupported $fs"
+		fi
+	done
+
+	if [ $dev_num -eq 0 -a "$fallback_filesystem" != "$FS_TYPE" ]; then
+		if tst_supported_fs $fallback_filesystem 2> /dev/null; then
+			dev_num=1
+		fi
+	fi
+
+	if [ $dev_num -eq 0 ]; then
+		tst_res TINFO "filesystems on the system"
+		tst_supported_fs > /dev/null
+
+		msg="$msg $zram_filesystems"
+		if [ "$fallback_filesystem" != "$FS_TYPE" ]; then
+			msg="$msg $fallback_filesystem"
+		fi
+		tst_brk TCONF "$msg"
+	fi
+
+	[ "$unsupported" ] && tst_res TINFO "$msg$unsupported"
+}
+
+setup()
+{
+	check_fs_support
+	zram_load
+}
+
 zram_fill_fs()
 {
 	for i in $(seq 0 $(($dev_num - 1))); do
diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh b/testcases/kernel/device-drivers/zram/zram_lib.sh
index 24bd37e1e..b2dce1d7d 100755
--- a/testcases/kernel/device-drivers/zram/zram_lib.sh
+++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
@@ -36,10 +36,12 @@ zram_load()
 {
 	local tmp
 
-	dev_num=0
-	for tmp in $zram_max_streams; do
-		dev_num=$((dev_num+1))
-	done
+	if [ -z "$dev_num" ]; then
+		dev_num=0
+		for tmp in $zram_max_streams; do
+			dev_num=$((dev_num+1))
+		done
+	fi
 
 	tst_res TINFO "create '$dev_num' zram device(s)"
 
@@ -125,6 +127,7 @@ zram_set_disksizes()
 
 		i=$(($i + 1))
 		tst_res TINFO "$sys_path = '$ds' ($i/$dev_num)"
+		[ $i -eq $dev_num ] && break
 	done
 
 	tst_res TPASS "test succeeded"
@@ -151,6 +154,7 @@ zram_set_memlimit()
 
 		i=$(($i + 1))
 		tst_res TINFO "$sys_path = '$ds' ($i/$dev_num)"
+		[ $i -eq $dev_num ] && break
 	done
 
 	tst_res TPASS "test succeeded"
@@ -187,13 +191,10 @@ zram_swapoff()
 
 zram_makefs()
 {
-	tst_require_cmds mkfs
 	local i=0
+	local fs
 
 	for fs in $zram_filesystems; do
-		# if requested fs not supported default it to ext2
-		tst_supported_fs $fs 2> /dev/null || fs=ext2
-
 		tst_res TINFO "make $fs filesystem on /dev/zram$i"
 		mkfs.$fs /dev/zram$i > err.log 2>&1
 		if [ $? -ne 0 ]; then
@@ -202,6 +203,7 @@ zram_makefs()
 		fi
 
 		i=$(($i + 1))
+		[ $i -eq $dev_num ] && break
 	done
 
 	tst_res TPASS "zram_makefs succeeded"
-- 
2.30.0

