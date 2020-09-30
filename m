From: Qian Cai <cai@redhat.com>
Date: Wed, 30 Sep 2020 10:11:30 -0400
Subject: [LTP] [PATCH v2] diotest4: Fix false postives on FUSE
Message-ID: <20200930141130.13100-1-cai@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It looks like FUSE does not support the unaligned IO, because it does
not directly backed by a block device. Therefore, in fuse_direct_IO(),
there is no checking of unaligned IO to return -EINVAL like other
filesystems from iomap_dio_bio_actor().

diotest4    3  TFAIL  :  diotest4.c:114: read allows odd count. returns 1: Success
diotest4    4  TFAIL  :  diotest4.c:129: write allows odd count.returns 1: Success
diotest4    5  TFAIL  :  diotest4.c:180: Odd count of read and write
...
diotest4   16  TFAIL  :  diotest4.c:114: read allows  nonaligned buf. returns 4096: Success
diotest4   17  TFAIL  :  diotest4.c:129: write allows  nonaligned buf.returns 4096: Success
diotest4   18  TFAIL  :  diotest4.c:180: read, write with non-aligned buffer

Signed-off-by: Qian Cai <cai@redhat.com>
---
 include/tst_fs.h                         | 1 +
 lib/tst_fs_type.c                        | 2 ++
 testcases/kernel/io/direct_io/diotest4.c | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/include/tst_fs.h b/include/tst_fs.h
index fc0390582..4f7dd68d2 100644
--- a/include/tst_fs.h
+++ b/include/tst_fs.h
@@ -29,6 +29,7 @@
 #define TST_NILFS_MAGIC    0x3434
 #define TST_EXOFS_MAGIC    0x5DF5
 #define TST_OVERLAYFS_MAGIC 0x794c7630
+#define TST_FUSE_MAGIC     0x65735546
 
 enum {
 	TST_BYTES = 1,
diff --git a/lib/tst_fs_type.c b/lib/tst_fs_type.c
index 1d0ac9669..d661d5b2a 100644
--- a/lib/tst_fs_type.c
+++ b/lib/tst_fs_type.c
@@ -84,6 +84,8 @@ const char *tst_fs_type_name(long f_type)
 		return "EXOFS";
 	case TST_OVERLAYFS_MAGIC:
 		return "OVERLAYFS";
+	case TST_FUSE_MAGIC:
+		return "FUSE";
 	default:
 		return "Unknown";
 	}
diff --git a/testcases/kernel/io/direct_io/diotest4.c b/testcases/kernel/io/direct_io/diotest4.c
index bf200cd41..f3c9c19d7 100644
--- a/testcases/kernel/io/direct_io/diotest4.c
+++ b/testcases/kernel/io/direct_io/diotest4.c
@@ -270,6 +270,7 @@ int main(int argc, char *argv[])
 	switch (fs_type) {
 	case TST_NFS_MAGIC:
 	case TST_BTRFS_MAGIC:
+	case TST_FUSE_MAGIC:
 		tst_resm(TCONF, "%s supports odd count IO",
 			 tst_fs_type_name(fs_type));
 	break;
@@ -442,6 +443,7 @@ int main(int argc, char *argv[])
 	switch (fs_type) {
 	case TST_NFS_MAGIC:
 	case TST_BTRFS_MAGIC:
+	case TST_FUSE_MAGIC:
 		tst_resm(TCONF, "%s supports non-aligned buffer",
 			 tst_fs_type_name(fs_type));
 	break;
-- 
2.28.0

