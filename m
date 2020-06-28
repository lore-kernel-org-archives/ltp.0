From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Sun, 28 Jun 2020 15:42:03 +0800
Subject: [LTP] [PATCH v4 2/2] syscalls/ioctl_loop05: Use correct blockdev to
 get logical_block_size
In-Reply-To: <1593330123-19631-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20200624113217.GC30917@yuki.lan>
 <1593330123-19631-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1593330123-19631-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

At the first, we use BLKSSZGET ioctl to get this size, but using wrong
block dev(/dev/loopN) intead of correct backing file block dev(such as /dev/sdaN).

kernel code(driver/block/loop.c  __loop_update_dio function) as below:
---------------------------------------
if (inode->i_sb->s_bdev) {
	sb_bsize = bdev_logical_block_size(inode->i_sb->s_bdev);
	dio_align = sb_bsize - 1;
}
if (dio) {
	if (queue_logical_block_size(lo->lo_queue) >= sb_bsize &&
		!(lo->lo_offset & dio_align) &&
		mapping->a_ops->direct_IO &&!lo->transfer)
		use_dio = true;
	else
		use_dio = false;
} else {
        use_dio = false;
}
-------------------------------------

Using inode block size is also wrong because it is for filesystem io(such as we format
filesystem can specify block size for data or log or metadata), it is not suitable
for logical block size.

Using tst_find_backing_dev(path, dev)to get the correct block dev.

Also, "offset is ignored" belongs to the third test(less than logical_block_size) but not
the second test(equal to logical_block_size)

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
v3->v4:
1. using tst_find_backing_dev instead of df command
2. also print block dev name
 .../kernel/syscalls/ioctl/ioctl_loop05.c      | 29 ++++++++++---------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
index a96997823..e3c14faab 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
@@ -32,8 +32,8 @@
 #define DIO_MESSAGE "In dio mode"
 #define NON_DIO_MESSAGE "In non dio mode"
 
-static char dev_path[1024], sys_loop_diopath[1024];
-static int dev_num, dev_fd, attach_flag, logical_block_size;
+static char dev_path[1024], sys_loop_diopath[1024], backing_file_path[1024];;
+static int dev_num, dev_fd, block_devfd, attach_flag, logical_block_size;
 
 static void check_dio_value(int flag)
 {
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
+	char bd_path[100];
 
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
@@ -130,13 +122,22 @@ static void setup(void)
 	 *   size of loop is bigger than the backing device's and the loop
 	 *   needn't transform transfer.
 	 */
-	TST_RETRY_FUNC(ioctl(dev_fd, LOOP_SET_BLOCK_SIZE, logical_block_size), TST_RETVAL_EQ0);
+	sprintf(backing_file_path, "%s/test.img", tst_get_tmpdir());
+	tst_find_backing_dev(backing_file_path, bd_path);
+	block_devfd = SAFE_OPEN(bd_path, O_RDWR);
+	SAFE_IOCTL(block_devfd, BLKSSZGET, &logical_block_size);
+	tst_res(TINFO, "backing dev(%s) logical_block_size is %d", bd_path, logical_block_size);
+	SAFE_CLOSE(block_devfd);
+	if (logical_block_size > 512)
+		TST_RETRY_FUNC(ioctl(dev_fd, LOOP_SET_BLOCK_SIZE, logical_block_size), TST_RETVAL_EQ0);
 }
 
 static void cleanup(void)
 {
 	if (dev_fd > 0)
 		SAFE_CLOSE(dev_fd);
+	if (block_devfd > 0)
+		SAFE_CLOSE(block_devfd);
 	if (attach_flag)
 		tst_detach_device(dev_path);
 }
-- 
2.23.0



