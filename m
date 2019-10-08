From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  8 Oct 2019 17:16:24 +0200
Subject: [LTP] [PATCH] syscalls/copy_file_range02: Add check for pipe
Message-ID: <20191008151624.19815-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The original patch that was adding this fell under a table:

http://patchwork.ozlabs.org/patch/1112976/

I guess there is no harm checking that we get EINVAL for pipe as well,
or does anyone disagree?

Signed-off-by: Jinhui huang <huangjh.jy@cn.fujitsu.com>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Amir Goldstein <amir73il@gmail.com>
---
 .../syscalls/copy_file_range/copy_file_range02.c   | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
index 6e385adbd..a55de4111 100644
--- a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
+++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
@@ -25,9 +25,10 @@
  * 9) Try to copy contents to a blkdev ->EINVAL
  * 10) Try to copy contents to a chardev ->EINVAL
  * 11) Try to copy contents to a FIFO ->EINVAL
- * 12) Try to copy contents to a file with length beyond
+ * 12) Try to copy contenst to a PIPE ->EINVAL
+ * 13) Try to copy contents to a file with length beyond
  *     16EiB wraps around 0 -> EOVERFLOW
- * 13) Try to copy contents to a file with target file range
+ * 14) Try to copy contents to a file with target file range
  *     beyond maximum supported file size ->EFBIG
  */
 
@@ -48,6 +49,7 @@ static int fd_dup;
 static int fd_blkdev;
 static int fd_chrdev;
 static int fd_fifo;
+static int fd_pipe[2];
 static int fd_copy;
 static int need_unlink;
 
@@ -73,6 +75,7 @@ static struct tcase {
 	{&fd_blkdev,	0,	EINVAL,		CONTSIZE,	"block device"},
 	{&fd_chrdev,	0,	EINVAL,		CONTSIZE,	"char device"},
 	{&fd_fifo,	0,	EINVAL,		CONTSIZE,	"fifo"},
+	{&fd_pipe[0],	0,	EINVAL,		CONTSIZE,	"pipe"},
 	{&fd_copy,	0,	EOVERFLOW,	ULLONG_MAX,	"max length lenght"},
 	{&fd_copy,	0,	EFBIG,		MIN_OFF,	"max file size"},
 };
@@ -163,6 +166,11 @@ static void cleanup(void)
 		SAFE_CLOSE(fd_copy);
 	if (need_unlink > 0)
 		SAFE_UNLINK(FILE_FIFO);
+
+	if (fd_pipe[0] > 0) {
+		SAFE_CLOSE(fd_pipe[0]);
+		SAFE_CLOSE(fd_pipe[1]);
+	}
 }
 
 static void setup(void)
@@ -201,6 +209,8 @@ static void setup(void)
 	fd_chrdev = SAFE_OPEN(FILE_CHRDEV, O_RDWR, 0600);
 	fd_fifo = SAFE_OPEN(FILE_FIFO, O_RDWR, 0600);
 
+	SAFE_PIPE(fd_pipe);
+
 	SAFE_WRITE(1, fd_src, CONTENT, CONTSIZE);
 	close(fd_src);
 	fd_src = SAFE_OPEN(FILE_SRC_PATH, O_RDONLY, 0664);
-- 
2.21.0

