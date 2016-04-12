From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 12 Apr 2016 12:53:07 +0800
Subject: [LTP] [PATCH 1/3] syscalls/preadv02.c: add specific error
Message-ID: <1460436789-11969-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) preadv(2) fails when fd refers to a directory and
   set errno to EISDIR.
2) preadv(2) fails if fd is associated with a pipe and
   set errno to ESPIPE.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/preadv/preadv02.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/preadv/preadv02.c b/testcases/kernel/syscalls/preadv/preadv02.c
index f2f3af7..ae9fa6e 100644
--- a/testcases/kernel/syscalls/preadv/preadv02.c
+++ b/testcases/kernel/syscalls/preadv/preadv02.c
@@ -24,6 +24,8 @@
 * 4) preadv(2) fails when attempts to read into a invalid address.
 * 5) preadv(2) fails if file descriptor is invalid.
 * 6) preadv(2) fails if file descriptor is not open for reading.
+* 7) preadv(2) fails when fd refers to a directory.
+* 8) preadv(2) fails if fd is associated with a pipe.
 *
 * Expected Result:
 * 1) preadv(2) should return -1 and set errno to EINVAL.
@@ -32,6 +34,8 @@
 * 4) preadv(2) should return -1 and set errno to EFAULT.
 * 5) preadv(2) should return -1 and set errno to EBADF.
 * 6) preadv(2) should return -1 and set errno to EBADF.
+* 7) preadv(2) should return -1 and set errno to EISDIR.
+* 8) preadv(2) should return -1 and set errno to ESPIPE.
 */
 
 #include <sys/uio.h>
@@ -43,6 +47,9 @@
 static int fd1;
 static int fd2;
 static int fd3 = -1;
+static int fd4;
+static int fd5[2];
+
 static char buf[CHUNK];
 
 static struct iovec rd_iovec1[] = {
@@ -66,7 +73,9 @@ static struct tcase {
 	{&fd1, rd_iovec2, 1, -1, EINVAL},
 	{&fd1, rd_iovec2, 2, 0, EFAULT},
 	{&fd3, rd_iovec2, 1, 0, EBADF},
-	{&fd2, rd_iovec2, 1, 0, EBADF}
+	{&fd2, rd_iovec2, 1, 0, EBADF},
+	{&fd4, rd_iovec2, 1, 0, EISDIR},
+	{&fd5[0], rd_iovec2, 1, 0, ESPIPE}
 };
 
 static void verify_preadv(unsigned int n)
@@ -93,6 +102,8 @@ static void setup(void)
 {
 	fd1 = SAFE_OPEN("file1", O_RDWR | O_CREAT, 0644);
 	fd2 = SAFE_OPEN("file2", O_WRONLY | O_CREAT, 0644);
+	fd4 = SAFE_OPEN(".", O_RDONLY);
+	SAFE_PIPE(fd5);
 }
 
 static void cleanup(void)
@@ -102,6 +113,15 @@ static void cleanup(void)
 
 	if (fd2 > 0 && close(fd2))
 		tst_res(TWARN | TERRNO, "failed to close file");
+
+	if (fd4 > 0 && close(fd4))
+		tst_res(TWARN | TERRNO, "failed to close file");
+
+	if (fd5[0] > 0 && close(fd5[0]))
+		tst_res(TWARN | TERRNO, "failed to close file");
+
+	if (fd5[1] > 0 && close(fd5[1]))
+		tst_res(TWARN | TERRNO, "failed to close file");
 }
 
 static struct tst_test test = {
-- 
1.8.3.1



