From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 17 Mar 2021 11:53:16 +0100
Subject: [LTP] [PATCH v3 2/4] lib: tst_fs_type change fs names to lowercase
In-Reply-To: <20210317105318.32017-1-chrubis@suse.cz>
References: <20210317105318.32017-1-chrubis@suse.cz>
Message-ID: <20210317105318.32017-3-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To make it consistent with the rest of the library.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_fs_type.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/lib/tst_fs_type.c b/lib/tst_fs_type.c
index d661d5b2a..8475f4c78 100644
--- a/lib/tst_fs_type.c
+++ b/lib/tst_fs_type.c
@@ -47,46 +47,46 @@ const char *tst_fs_type_name(long f_type)
 {
 	switch (f_type) {
 	case TST_TMPFS_MAGIC:
-		return "TMPFS";
+		return "tmpfs";
 	case TST_NFS_MAGIC:
-		return "NFS";
+		return "nfs";
 	case TST_V9FS_MAGIC:
-		return "9P";
+		return "9p";
 	case TST_RAMFS_MAGIC:
-		return "RAMFS";
+		return "ramfs";
 	case TST_BTRFS_MAGIC:
-		return "BTRFS";
+		return "btrfs";
 	case TST_XFS_MAGIC:
-		return "XFS";
+		return "xfs";
 	case TST_EXT2_OLD_MAGIC:
-		return "EXT2";
+		return "ext2";
 	case TST_EXT234_MAGIC:
-		return "EXT2/EXT3/EXT4";
+		return "ext2/ext3/ext4";
 	case TST_MINIX_MAGIC:
 	case TST_MINIX_MAGIC2:
 	case TST_MINIX2_MAGIC:
 	case TST_MINIX2_MAGIC2:
 	case TST_MINIX3_MAGIC:
-		return "MINIX";
+		return "minix";
 	case TST_UDF_MAGIC:
-		return "UDF";
+		return "udf";
 	case TST_SYSV2_MAGIC:
 	case TST_SYSV4_MAGIC:
-		return "SYSV";
+		return "sysv";
 	case TST_UFS_MAGIC:
 	case TST_UFS2_MAGIC:
-		return "UFS";
+		return "ufs";
 	case TST_F2FS_MAGIC:
-		return "F2FS";
+		return "f2fs";
 	case TST_NILFS_MAGIC:
-		return "NILFS";
+		return "nilfs";
 	case TST_EXOFS_MAGIC:
-		return "EXOFS";
+		return "exofs";
 	case TST_OVERLAYFS_MAGIC:
-		return "OVERLAYFS";
+		return "overlayfs";
 	case TST_FUSE_MAGIC:
-		return "FUSE";
+		return "fuse";
 	default:
-		return "Unknown";
+		return "unknown";
 	}
 }
-- 
2.26.2

