From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 31 Jan 2017 14:44:33 +0100
Subject: [LTP] [PATCH] [RFC] zram01: Fix on ppc64le
Message-ID: <1485870273-26990-1-git-send-email-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The minimal size for Btrfs filesystem on ppc64le is around 139MB, most
likely because of larger page size, hence the test fails.

This commit adds tst_min_fs_size.sh library, that parses mkfs.btrfs
output which includes minimal filesystem size in case of a failure.

The code also falls back to 150MB if the mkfs.btrfs output wasn't parsed
correctly.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/device-drivers/zram/zram01.sh |  8 ++++--
 testcases/lib/tst_min_fs_size.sh               | 35 ++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 2 deletions(-)
 create mode 100644 testcases/lib/tst_min_fs_size.sh

diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
index 64284d5..f0dc83c 100755
--- a/testcases/kernel/device-drivers/zram/zram01.sh
+++ b/testcases/kernel/device-drivers/zram/zram01.sh
@@ -24,6 +24,7 @@ TCID="zram01"
 TST_TOTAL=8
 
 . test.sh
+. tst_min_fs_size.sh
 . zram_lib.sh
 
 # Test will create the following number of zram devices:
@@ -39,8 +40,11 @@ zram_max_streams="2 3 5 8"
 # not support mem suffixes, in some newer kernels, they use
 # memparse() which supports mem suffixes. So here we just use
 # bytes to make sure everything works correctly.
-zram_sizes="26214400 26214400 26214400 41943040" # 25MB, 40MB for btrfs
-zram_mem_limits="25M 25M 25M 40M"
+min_btrfs_size=$(tst_min_btrfs_size)
+min_btrfs_size_mb=$((min_btrfs_size/1024/1024))
+
+zram_sizes="26214400 26214400 26214400 $min_btrfs_size" # 25MB, 40MB for btrfs
+zram_mem_limits="25M 25M 25M ${min_btrfs_size_mb}M"
 zram_filesystems="ext3 ext4 xfs btrfs"
 zram_algs="lzo lzo lzo lzo"
 
diff --git a/testcases/lib/tst_min_fs_size.sh b/testcases/lib/tst_min_fs_size.sh
new file mode 100644
index 0000000..9428ff9
--- /dev/null
+++ b/testcases/lib/tst_min_fs_size.sh
@@ -0,0 +1,35 @@
+#!/bin/sh
+#
+# Copyright (c) Linux Test Project, 2017
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Written by Cyril Hrubis <chrubis@suse.cz>
+#
+
+tst_min_btrfs_size()
+{
+	local output
+
+	output=$(mkfs.btrfs -q /dev/null 2>&1)
+	output=$(echo $output | awk -F' ' '{print substr($NF, 1, length($NF) - 1)}' -)
+
+	if [ "$output" -a "$output" -eq "$output" ] 2>/dev/null; then
+		echo "$output"
+	else
+		echo "Invalid size ($output) reported by mkfs.btrfs, defaulting to 150MB" 1>&2
+		echo $((150 * 1024 * 1024))
+	fi
+}
-- 
2.7.3

