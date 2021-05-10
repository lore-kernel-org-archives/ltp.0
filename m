From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Date: Mon, 10 May 2021 10:47:39 -0300
Subject: [LTP] [PATCH] mkfs: force block size to 1024 for ext3 and ext4
Message-ID: <20210510134739.37512-1-cascardo@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

ext3 and ext4 filesystems will reserve at least 1024 blocks for the
journal.  With a blocksize of 4096, this will be 25% of the filesystem size
without accounting for any other overhead.

/etc/mke2fs.conf will use 1024 block size for small filesystems, which are
between 3M and 512M. However, on recent versions of Ubuntu, this
configuration has changed and thet default blocksize is 4096 even for small
filesystems.

Force the blocksize to 1024 on ext3 and ext4 filesystems, which will lead
to the expected results, as journals will take only 1M.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
---
 testcases/commands/mkfs/mkfs01.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/commands/mkfs/mkfs01.sh b/testcases/commands/mkfs/mkfs01.sh
index 3e3e56719cf3..17c7fb9e4a1a 100755
--- a/testcases/commands/mkfs/mkfs01.sh
+++ b/testcases/commands/mkfs/mkfs01.sh
@@ -96,6 +96,9 @@ mkfs_test()
 	if [ "$fs_type" = "xfs" ] || [ "$fs_type" = "btrfs" ]; then
 		fs_op="$fs_op -f"
 	fi
+	if [ "$fs_type" = "ext3" ] || [ "$fs_type" = "ext4" ]; then
+		fs_op="$fs_op -b 1024"
+	fi
 
 	local mkfs_cmd="mkfs $mkfs_op $fs_op $device $size"
 
-- 
2.27.0

