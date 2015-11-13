From: Rock Lee <rocklee_104@outlook.com>
Date: Fri, 13 Nov 2015 12:47:58 +0800
Subject: [LTP]  [PATCH v2] commands/mkfs/mkfs01.sh: fix mkfs
Message-ID: <BAY403-EAS3585228DE80DA72DD48E383CF110@phx.gbl>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If a block device is specified when ./runltp -b , mkfs testcase may
fail because there is only "TYPE="vfat"" token in the output of blkid,
rather than "SEC_TYPE="msdos"". BTW, mkfs.msdos and mkfs.vfat are
the same.

Signed-off-by: Rock Lee <rocklee_104@outlook.com>
---
 testcases/commands/mkfs/mkfs01.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/commands/mkfs/mkfs01.sh
b/testcases/commands/mkfs/mkfs01.sh
index 5b62df4..31e3e15 100755
--- a/testcases/commands/mkfs/mkfs01.sh
+++ b/testcases/commands/mkfs/mkfs01.sh
@@ -93,7 +93,7 @@ mkfs_verify_type()
 		blkid $2 -t TYPE="ext2" >/dev/null
 	else
 		if [ "$1" = "msdos" ]; then
-			blkid $2 -t SEC_TYPE="$1" >/dev/null
+			blkid $2 -t TYPE="vfat" >/dev/null
 		else
 			blkid $2 -t TYPE="$1" >/dev/null
 		fi
-- 
2.6.2
