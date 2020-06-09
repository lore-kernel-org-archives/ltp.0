From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 9 Jun 2020 16:33:03 +0800
Subject: [LTP] [PATCH] syscalls/ioctl_loop05: Get the logic_block_size
 dynamically
Message-ID: <1591691583-12442-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In loop driver code, the sb_bsize was calculated as below
sb_bsize = bdev_logical_block_size(inode->i_sb->s_bdev),

it is the super block's block size that the backing file's inode belongs to,
not by using the st_blksize member of stat struct(it uses inode->i_blkbits).

IMO, we don't have the direct ioctl to get this size, just try it from 512 to page_size.

Also, "offset is ignored" belongs to the last test(less than logical_block_size) but not
the second test(equal to logical_block_size).

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 .../kernel/syscalls/ioctl/ioctl_loop05.c      | 21 ++++++++-----------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
index a96997823..09326042f 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
@@ -71,7 +71,7 @@ static void verify_ioctl_loop(void)
 	TST_RETRY_FUNC(ioctl(dev_fd, LOOP_SET_STATUS, &loopinfo), TST_RETVAL_EQ0);
 	TEST(ioctl(dev_fd, LOOP_SET_DIRECT_IO, 1));
 	if (TST_RET == 0) {
-		tst_res(TPASS, "LOOP_SET_DIRECT_IO succeeded, offset is ignored");
+		tst_res(TPASS, "LOOP_SET_DIRECT_IO succeeded");
 		check_dio_value(1);
 		SAFE_IOCTL(dev_fd, LOOP_SET_DIRECT_IO, 0);
 	} else {
@@ -84,7 +84,7 @@ static void verify_ioctl_loop(void)
 
 	TEST(ioctl(dev_fd, LOOP_SET_DIRECT_IO, 1));
 	if (TST_RET == 0) {
-		tst_res(TPASS, "LOOP_SET_DIRECT_IO succeeded");
+		tst_res(TPASS, "LOOP_SET_DIRECT_IO succeeded, offset is ignored");
 		SAFE_IOCTL(dev_fd, LOOP_SET_DIRECT_IO, 0);
 		return;
 	}
@@ -96,8 +96,7 @@ static void verify_ioctl_loop(void)
 
 static void setup(void)
 {
-	int fd;
-	struct stat buf;
+	int pg_size = getpagesize();
 
 	if (tst_fs_type(".") == TST_TMPFS_MAGIC)
 		tst_brk(TCONF, "tmpfd doesn't support O_DIRECT flag");
@@ -109,13 +108,6 @@ static void setup(void)
 	sprintf(sys_loop_diopath, "/sys/block/loop%d/loop/dio", dev_num);
 	tst_fill_file("test.img", 0, 1024, 1024);
 
-	fd = SAFE_OPEN("test.img", O_RDONLY);
-	SAFE_FSTAT(fd, &buf);
-	SAFE_CLOSE(fd);
-
-	logical_block_size = buf.st_blksize;
-	tst_res(TINFO, "backing dev logical_block_size is %d", logical_block_size);
-
 	tst_attach_device(dev_path, "test.img");
 	attach_flag = 1;
 	dev_fd = SAFE_OPEN(dev_path, O_RDWR);
@@ -130,7 +122,12 @@ static void setup(void)
 	 *   size of loop is bigger than the backing device's and the loop
 	 *   needn't transform transfer.
 	 */
-	TST_RETRY_FUNC(ioctl(dev_fd, LOOP_SET_BLOCK_SIZE, logical_block_size), TST_RETVAL_EQ0);
+	for (logical_block_size = 512; logical_block_size < pg_size; logical_block_size += 512) {
+		TST_RETRY_FUNC(ioctl(dev_fd, LOOP_SET_BLOCK_SIZE, logical_block_size), TST_RETVAL_EQ0);
+		if (ioctl(dev_fd, LOOP_SET_DIRECT_IO, 1) == 0)
+			break;
+	}
+	tst_res(TINFO, "backing dev logical_block_size is %d", logical_block_size);
 }
 
 static void cleanup(void)
-- 
2.23.0



