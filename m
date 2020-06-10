From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 10 Jun 2020 13:37:07 +0800
Subject: [LTP] [PATCH v2] syscalls/ioctl_loop05: Use correct blockdev to get
 logical_block_size
In-Reply-To: <828833321.15301509.1591700517554.JavaMail.zimbra@redhat.com>
References: <828833321.15301509.1591700517554.JavaMail.zimbra@redhat.com>
Message-ID: <1591767427-29383-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
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
---------------------------------------

Using inode block is wrong because it is for filesystem io(such as we formart
filesystem can specify block size for data or log or metadata), it is not suitable
for logical block size.

Using df cmd (df -T /tmp/xxxxx/test.img)to get the correct block dev.

Also, "offset is ignored" belongs to the last test(less than logical_block_size) but not
the second test(equal to logical_block_size).

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 .../kernel/syscalls/ioctl/ioctl_loop05.c      | 47 ++++++++++++++-----
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
index a96997823..643892fff 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
@@ -28,12 +28,13 @@
 #include <sys/mount.h>
 #include "lapi/loop.h"
 #include "tst_test.h"
+#include "tst_safe_stdio.h"
 
 #define DIO_MESSAGE "In dio mode"
 #define NON_DIO_MESSAGE "In non dio mode"
 
 static char dev_path[1024], sys_loop_diopath[1024];
-static int dev_num, dev_fd, attach_flag, logical_block_size;
+static int dev_num, dev_fd, block_devfd, attach_flag, logical_block_size;
 
 static void check_dio_value(int flag)
 {
@@ -71,7 +72,7 @@ static void verify_ioctl_loop(void)
 	TST_RETRY_FUNC(ioctl(dev_fd, LOOP_SET_STATUS, &loopinfo), TST_RETVAL_EQ0);
 	TEST(ioctl(dev_fd, LOOP_SET_DIRECT_IO, 1));
 	if (TST_RET == 0) {
-		tst_res(TPASS, "LOOP_SET_DIRECT_IO succeeded, offset is ignored");
+		tst_res(TPASS, "LOOP_SET_DIRECT_IO succeeded");
 		check_dio_value(1);
 		SAFE_IOCTL(dev_fd, LOOP_SET_DIRECT_IO, 0);
 	} else {
@@ -84,7 +85,7 @@ static void verify_ioctl_loop(void)
 
 	TEST(ioctl(dev_fd, LOOP_SET_DIRECT_IO, 1));
 	if (TST_RET == 0) {
-		tst_res(TPASS, "LOOP_SET_DIRECT_IO succeeded");
+		tst_res(TPASS, "LOOP_SET_DIRECT_IO succeeded, offset is ignored");
 		SAFE_IOCTL(dev_fd, LOOP_SET_DIRECT_IO, 0);
 		return;
 	}
@@ -94,10 +95,22 @@ static void verify_ioctl_loop(void)
 		tst_res(TFAIL | TTERRNO, "LOOP_SET_DIRECT_IO failed expected EINVAL got");
 }
 
+static void find_backing_bdpath(char *buf)
+{
+	char line[PATH_MAX];
+	FILE *file;
+
+	file = SAFE_FOPEN("1.txt", "r");
+
+	while (fgets(line, sizeof(line), file) != NULL)
+		sscanf(line, "%s", buf);
+	SAFE_FCLOSE(file);
+}
+
 static void setup(void)
 {
-	int fd;
-	struct stat buf;
+	char buf[100];
+	const char *const df_cmd[] = {"df", "-T", ".", NULL};
 
 	if (tst_fs_type(".") == TST_TMPFS_MAGIC)
 		tst_brk(TCONF, "tmpfd doesn't support O_DIRECT flag");
@@ -109,13 +122,6 @@ static void setup(void)
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
@@ -130,13 +136,24 @@ static void setup(void)
 	 *   size of loop is bigger than the backing device's and the loop
 	 *   needn't transform transfer.
 	 */
-	TST_RETRY_FUNC(ioctl(dev_fd, LOOP_SET_BLOCK_SIZE, logical_block_size), TST_RETVAL_EQ0);
+	SAFE_CMD(df_cmd, "1.txt", NULL);
+	find_backing_bdpath(buf);
+	block_devfd = SAFE_OPEN(buf, O_RDWR);
+
+	SAFE_IOCTL(block_devfd, BLKSSZGET, &logical_block_size);
+	tst_res(TINFO, "backing dev logical_block_size is %d", logical_block_size);
+	SAFE_CLOSE(block_devfd);
+
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
@@ -150,5 +167,9 @@ static struct tst_test test = {
 	.needs_drivers = (const char *const []) {
 		"loop",
 		NULL
+	},
+	.needs_cmds = (const char *const []) {
+		"df",
+		NULL
 	}
 };
-- 
2.23.0



