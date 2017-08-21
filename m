From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 21 Aug 2017 16:07:46 +0200
Subject: [LTP] [RFC] [PATCH] device-drivers/zram01: Fix failures on ppc64le
Message-ID: <20170821140746.15734-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The Btrfs filesystem on ppc64le needs at least 139MB due to larger page
size. Unfortunately the minimal size reported by mkfs.btrfs does not
seem to be correct in all cases so this patch simply bumps the device
size to 384MB which should be more than enough.

We also check that there is at least 1GB of RAM now and default to 25MB
and ext2 instead of Btrfs in order not to fail the test on a tiny
machines.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/device-drivers/zram/zram01.sh | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
index 64284d554..82e9f121b 100755
--- a/testcases/kernel/device-drivers/zram/zram01.sh
+++ b/testcases/kernel/device-drivers/zram/zram01.sh
@@ -32,6 +32,16 @@ dev_num=4
 # Number of items must be equal to 'dev_num' parameter.
 zram_max_streams="2 3 5 8"
 
+FS_SIZE="402653184"
+FS_TYPE="btrfs"
+
+RAM_SIZE=$(awk '/MemTotal:/ {print $2}' /proc/meminfo)
+if [ "$RAM_SIZE" -lt 1048576 ]; then
+	tst_res TINFO "Not enough space for Btrfs"
+	FS_SIZE="26214400"
+	FS_TYPE="ext2"
+fi
+
 # The zram sysfs node 'disksize' value can be either in bytes,
 # or you can use mem suffixes. But in some old kernels, mem
 # suffixes are not supported, for example, in RHEL6.6GA's kernel
@@ -39,9 +49,9 @@ zram_max_streams="2 3 5 8"
 # not support mem suffixes, in some newer kernels, they use
 # memparse() which supports mem suffixes. So here we just use
 # bytes to make sure everything works correctly.
-zram_sizes="26214400 26214400 26214400 41943040" # 25MB, 40MB for btrfs
-zram_mem_limits="25M 25M 25M 40M"
-zram_filesystems="ext3 ext4 xfs btrfs"
+zram_sizes="26214400 26214400 26214400 $FS_SIZE"
+zram_mem_limits="25M 25M 25M $((FS_SIZE/1024/1024))M"
+zram_filesystems="ext3 ext4 xfs $FS_TYPE"
 zram_algs="lzo lzo lzo lzo"
 
 TST_CLEANUP="zram_cleanup"
@@ -91,7 +101,6 @@ zram_set_disksizes
 zram_set_memlimit
 zram_makefs
 zram_mount
-
 zram_fill_fs
 
 tst_exit
-- 
2.13.0

