From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 22 Apr 2016 00:22:31 +0200
Subject: [LTP] [PATCH] preadv02/pwritev02: fix EFAULT testcase on s390/x
Message-ID: <4d64dda152c0b8020df70f88d838c649aec716c0.1461277019.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

EFAULT testcase is behaving differently on s390, mainly because
access_ok() always returns true, so rw_copy_check_uvector() can't
detect that something is wrong with iovec we pass in.

1. access_ok() on s390/x always return true [1], so we don't
fail at rw_copy_check_uvector() as we do on other arches

  preadv
    vfs_readv
      do_readv_writev
        rw_copy_check_uvector
          access_ok

2. With access_ok() ineffective, do_generic_file_read() returns
failure only if nothing could be read. So we pass just one bad
iovec to trigger EFAULT on s390.

  preadv
    vfs_readv
      do_readv_writev
        xfs_file_read_iter
          generic_file_read_iter
            do_generic_file_read
              written ? written : error;

3. To avoid inode size check in do_generic_file_read() that would
prematurely end this function, we truncate new file to size of 1 page.

[1] d12a2970385c "s390/uaccess: remove pointless access_ok() checks"

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/preadv/preadv02.c   | 6 +++++-
 testcases/kernel/syscalls/pwritev/pwritev02.c | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/preadv/preadv02.c b/testcases/kernel/syscalls/preadv/preadv02.c
index ae9fa6e46e2a..3076b8c1df76 100644
--- a/testcases/kernel/syscalls/preadv/preadv02.c
+++ b/testcases/kernel/syscalls/preadv/preadv02.c
@@ -39,6 +39,7 @@
 */
 
 #include <sys/uio.h>
+#include <unistd.h>
 #include "tst_test.h"
 #include "preadv.h"
 
@@ -57,7 +58,9 @@ static struct iovec rd_iovec1[] = {
 };
 
 static struct iovec rd_iovec2[] = {
+#if !defined(__s390__) && !defined(__s390x__)
 	{buf, CHUNK},
+#endif
 	{(char *)-1, CHUNK},
 };
 
@@ -71,7 +74,7 @@ static struct tcase {
 	{&fd1, rd_iovec1, 1, 0, EINVAL},
 	{&fd1, rd_iovec2, -1, 0, EINVAL},
 	{&fd1, rd_iovec2, 1, -1, EINVAL},
-	{&fd1, rd_iovec2, 2, 0, EFAULT},
+	{&fd1, rd_iovec2, ARRAY_SIZE(rd_iovec2), 0, EFAULT},
 	{&fd3, rd_iovec2, 1, 0, EBADF},
 	{&fd2, rd_iovec2, 1, 0, EBADF},
 	{&fd4, rd_iovec2, 1, 0, EISDIR},
@@ -101,6 +104,7 @@ static void verify_preadv(unsigned int n)
 static void setup(void)
 {
 	fd1 = SAFE_OPEN("file1", O_RDWR | O_CREAT, 0644);
+	SAFE_FTRUNCATE(fd1, getpagesize());
 	fd2 = SAFE_OPEN("file2", O_WRONLY | O_CREAT, 0644);
 	fd4 = SAFE_OPEN(".", O_RDONLY);
 	SAFE_PIPE(fd5);
diff --git a/testcases/kernel/syscalls/pwritev/pwritev02.c b/testcases/kernel/syscalls/pwritev/pwritev02.c
index d7ca1055644c..97f2cf0d5abc 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev02.c
+++ b/testcases/kernel/syscalls/pwritev/pwritev02.c
@@ -37,6 +37,7 @@
 */
 
 #include <sys/uio.h>
+#include <unistd.h>
 #include "tst_test.h"
 #include "pwritev.h"
 
@@ -54,7 +55,9 @@ static struct iovec wr_iovec1[] = {
 };
 
 static struct iovec wr_iovec2[] = {
+#if !defined(__s390__) && !defined(__s390x__)
 	{buf, CHUNK},
+#endif
 	{(char *)-1, CHUNK},
 };
 
@@ -68,7 +71,7 @@ static struct tcase {
 	{&fd1, wr_iovec1, 1, 0, EINVAL},
 	{&fd1, wr_iovec2, -1, 0, EINVAL},
 	{&fd1, wr_iovec2, 1, -1, EINVAL},
-	{&fd1, wr_iovec2, 2, 0, EFAULT},
+	{&fd1, wr_iovec2, ARRAY_SIZE(wr_iovec2), 0, EFAULT},
 	{&fd3, wr_iovec2, 1, 0, EBADF},
 	{&fd2, wr_iovec2, 1, 0, EBADF},
 	{&fd4[1], wr_iovec2, 1, 0, ESPIPE}
@@ -96,6 +99,7 @@ static void verify_pwritev(unsigned int n)
 static void setup(void)
 {
 	fd1 = SAFE_OPEN("file", O_RDWR | O_CREAT, 0644);
+	SAFE_FTRUNCATE(fd1, getpagesize());
 	fd2 = SAFE_OPEN("file", O_RDONLY | O_CREAT, 0644);
 	SAFE_PIPE(fd4);
 }
-- 
1.8.3.1

