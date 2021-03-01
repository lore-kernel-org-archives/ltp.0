From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  1 Mar 2021 23:02:17 +0100
Subject: [LTP] [PATCH 2/7] zram01.sh: Generate test setup variables in setup
In-Reply-To: <20210301220222.22705-1-pvorel@suse.cz>
References: <20210301220222.22705-1-pvorel@suse.cz>
Message-ID: <20210301220222.22705-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Generate variables in setup, based on output of tst_supported_fs.
This is more clean approach and it fixes various things:

* Error when there is no filesystem support and also mkfs.ext2
  (fallback) not installed:
/opt/ltp/testcases/bin/zram01.sh: line 198: mkfs.ext2: not found
Instead quit if there is no fs support. But this can lead to skipping
zram_compress_alg(), it will be solved next commit by moving
zram_compress_alg() to zram02.sh.

* Having ext2 as fallback could lead to run it more than once.
There is no much point to do that.

* Drop tst_require_cmds mkfs check, because mkfs is not actually needed.

Improvements:

* Test all suitable filesystems (will need increase timeout).

Reviewed-by: Li Wang <liwang@redhat.com>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v2->v3:
* drop filter "| grep -v -e fat -e ntfs -e fuse" (Li prefers to keep it,
  not against it, it's just why to avoid testing it when we don't do in
  other tests?)
* rename functions: s/check_space_for_btrfs/get_btrfs_size/
  s/generate_vars/initialize_vars/ (Li)
* drop unneeded check [ $i -eq $dev_num ] && break (which is good :)


 .../kernel/device-drivers/zram/zram01.sh      | 62 ++++++++++++++-----
 .../kernel/device-drivers/zram/zram_lib.sh    | 15 +++--
 2 files changed, 53 insertions(+), 24 deletions(-)

diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
index a795ff89f..54f7d0ebd 100755
--- a/testcases/kernel/device-drivers/zram/zram01.sh
+++ b/testcases/kernel/device-drivers/zram/zram01.sh
@@ -8,23 +8,25 @@
 
 TST_CNT=7
 TST_TESTFUNC="do_test"
-TST_NEEDS_CMDS="awk bc dd"
+TST_NEEDS_CMDS="awk bc dd grep"
 . zram_lib.sh
+TST_SETUP="setup"
 
-# List of parameters for zram devices.
-# For each number the test creates own zram device.
-zram_max_streams="2 3 5 8"
-
-FS_SIZE="402653184"
-FS_TYPE="btrfs"
+check_space_for_btrfs()
+{
+	local ram_size
 
-RAM_SIZE=$(awk '/MemTotal:/ {print $2}' /proc/meminfo)
-if [ "$RAM_SIZE" -lt 1048576 ]; then
-	tst_res TINFO "not enough space for Btrfs"
-	FS_SIZE="26214400"
-	FS_TYPE="ext2"
-fi
+	ram_size=$(awk '/MemTotal:/ {print $2}' /proc/meminfo)
+	if [ "$ram_size" -lt 1048576 ]; then
+		tst_res TINFO "not enough space for Btrfs"
+		return 1
+	fi
+	return 0
+}
 
+# List of parameters for zram devices.
+# For each number the test creates own zram device.
+# NOTE about size:
 # The zram sysfs node 'disksize' value can be either in bytes,
 # or you can use mem suffixes. But in some old kernels, mem
 # suffixes are not supported, for example, in RHEL6.6GA's kernel
@@ -32,9 +34,37 @@ fi
 # not support mem suffixes, in some newer kernels, they use
 # memparse() which supports mem suffixes. So here we just use
 # bytes to make sure everything works correctly.
-zram_sizes="26214400 26214400 26214400 $FS_SIZE"
-zram_mem_limits="25M 25M 25M $((FS_SIZE/1024/1024))M"
-zram_filesystems="ext3 ext4 xfs $FS_TYPE"
+initialize_vars()
+{
+	local fs limit size stream=-1
+	dev_num=0
+
+	for fs in $(tst_supported_fs); do
+		size="26214400"
+		limit="25M"
+		if [ "$fs" = "btrfs" ]; then
+			check_space_for_btrfs || continue
+			size="402653184"
+			limit="$((size/1024/1024))M"
+		fi
+
+		stream=$((stream+3))
+		dev_num=$((dev_num+1))
+		zram_filesystems="$zram_filesystems $fs"
+		zram_mem_limits="$zram_mem_limits $limit"
+		zram_sizes="$zram_sizes $size"
+		zram_max_streams="$zram_max_streams $stream"
+	done
+
+	[ $dev_num -eq 0 ] && \
+		tst_brk TCONF "no suitable filesystem"
+}
+
+setup()
+{
+	initialize_vars
+	zram_load
+}
 
 zram_fill_fs()
 {
diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh b/testcases/kernel/device-drivers/zram/zram_lib.sh
index a7e8b9f5b..c0a9f4618 100755
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
 
 	if [ $dev_num -le 0 ]; then
 		tst_brk TBROK "dev_num must be > 0"
@@ -191,13 +193,10 @@ zram_swapoff()
 
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
-- 
2.30.1

