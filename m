From: Jinhui huang <huangjh.jy@cn.fujitsu.com>
Date: Mon, 10 Jun 2019 17:49:49 +0800
Subject: [LTP] [PATCH] syscalls/copy_file_range02.c: Add new check for EINVAL
Message-ID: <1560160189-21242-1-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add a new checkpoint that copy_file_range() returns EINVAL when
copying contents to non regular file.

Signed-off-by: Jinhui huang <huangjh.jy@cn.fujitsu.com>
---
 .../kernel/syscalls/copy_file_range/copy_file_range02.c    | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
index 07c0207..db99344 100644
--- a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
+++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
@@ -19,6 +19,13 @@
  *    -> EBADF
  * 6) Try to copy contents with invalid 'flags' value
  *    -> EINVAL
+ * 7) Try to copy contents to pipe ->EINVAL
+ *
+ * Note:
+ * copy_file_range() returns EISDIR and EINVAL when copying contents to
+ * directory and any other non regualr files since the commit:
+ * 11cbfb10775a vfs: deny copy_file_range() for non regular files
+ *
  */
 
 #define _GNU_SOURCE
@@ -33,6 +40,7 @@ static int fd_mnted;
 static int fd_dir;
 static int fd_closed;
 static int fd_append;
+static int fd_pipe[2];
 
 static struct tcase {
 	int	*copy_to_fd;
@@ -45,6 +53,7 @@ static struct tcase {
 	{&fd_append,	0,	EBADF},
 	{&fd_closed,	0,	EBADF},
 	{&fd_dest,	-1,	EINVAL},
+	{&fd_pipe[0],   0,      EINVAL},
 };
 
 static void verify_copy_file_range(unsigned int n)
@@ -84,6 +93,10 @@ static void cleanup(void)
 		SAFE_CLOSE(fd_dest);
 	if (fd_src > 0)
 		SAFE_CLOSE(fd_src);
+	if (fd_pipe[0] > 0)
+		SAFE_CLOSE(fd_pipe[0]);
+	if (fd_pipe[1] > 0)
+		SAFE_CLOSE(fd_pipe[1]);
 }
 
 static void setup(void)
@@ -101,6 +114,7 @@ static void setup(void)
 	fd_closed = -1;
 	fd_append = SAFE_OPEN(FILE_DEST_PATH,
 			O_RDWR | O_CREAT | O_APPEND, 0664);
+	SAFE_PIPE(fd_pipe);
 
 	SAFE_WRITE(1, fd_src,  CONTENT,  CONTSIZE);
 }
-- 
1.8.3.1



