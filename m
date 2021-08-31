From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 31 Aug 2021 17:55:49 +0200
Subject: [LTP] [PATCH v2] syscalls/readv02: Convert to new API and merge
 readv03 into readv02
In-Reply-To: <1629025363-21885-1-git-send-email-daisl.fnst@fujitsu.com>
References: <YQlIFagVIrWXjmgY@yuki>
 <1629025363-21885-1-git-send-email-daisl.fnst@fujitsu.com>
Message-ID: <YS5RBesRGNvIfaWp@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, thanks.

- reformatted the documentation comment so that it renders nicely in
  asccidoc

- got rid of the fd array, it's a bit more readable with fd_file and
  fd_dir instead

- simplified setup a bit

Full diff:

diff --git a/testcases/kernel/syscalls/readv/readv02.c b/testcases/kernel/syscalls/readv/readv02.c
index 9a26e50a8..c09e69bc8 100644
--- a/testcases/kernel/syscalls/readv/readv02.c
+++ b/testcases/kernel/syscalls/readv/readv02.c
@@ -7,22 +7,15 @@
  */
 
 /*\
- * DESCRIPTION
- *  test 1:
- *  The sum of the iov_len values overflows an ssize_t value, expect an EINVAL.
+ * [Description]
  *
- *  test 2:
- *  Buf is outside the accessible address space, expect an EFAULT.
+ * Tests readv() failures:
  *
- *  test 3:
- *  The vector count iovcnt is less than zero, expect an EINVAL.
- *
- *  test 4:
- *  The parameter passed to read is a directory, check if the errno is
- *  set to EISDIR.
- *
- *  test 5:
- *  Read with an invalid file descriptor, and expect an EBADF.
+ * - EINVAL the sum of the iov_len values overflows an ssize_t value
+ * - EFAULT buffer is outside the accessible address space
+ * - EINVAL the vector count iovcnt is less than zero
+ * - EISDIR the file descriptor is a directory
+ * - EBADF  the file descriptor is not valid
  */
 
 #include <sys/uio.h>
@@ -34,7 +27,7 @@
 #define CHUNK           64
 
 static int badfd = -1;
-static int fd[2] = {-1, -1};
+static int fd_dir, fd_file;
 static char buf1[K_1];
 const char *TEST_DIR = "test_dir";
 const char *TEST_FILE = "test_file";
@@ -67,10 +60,10 @@ static struct tcase {
 	int count;
 	int exp_error;
 } tcases[] = {
-	{&fd[0], invalid_iovec, 1, EINVAL},
-	{&fd[0], efault_iovec, 3, EFAULT},
-	{&fd[0], large_iovec, -1, EINVAL},
-	{&fd[1], valid_iovec, 1, EISDIR},
+	{&fd_file, invalid_iovec, 1, EINVAL},
+	{&fd_file, efault_iovec, 3, EFAULT},
+	{&fd_file, large_iovec, -1, EINVAL},
+	{&fd_dir, valid_iovec, 1, EISDIR},
 	{&badfd, valid_iovec, 3, EBADF},
 };
 
@@ -84,26 +77,23 @@ static void verify_readv(unsigned int n)
 
 static void setup(void)
 {
-	fd[0] = SAFE_OPEN(TEST_FILE, O_WRONLY | O_CREAT, 0666);
-	SAFE_WRITE(1, fd[0], buf1, CHUNK);
-	SAFE_CLOSE(fd[0]);
+	SAFE_FILE_PRINTF(TEST_FILE, "test");
 
-	fd[0] = SAFE_OPEN(TEST_FILE, O_RDONLY, 0666);
+	fd_file = SAFE_OPEN(TEST_FILE, O_RDONLY);
 
 	efault_iovec[0].iov_base = tst_get_bad_addr(NULL);
 
 	SAFE_MKDIR(TEST_DIR, MODES);
-	fd[1] = SAFE_OPEN(TEST_DIR, O_RDONLY);
+	fd_dir = SAFE_OPEN(TEST_DIR, O_RDONLY);
 }
 
 static void cleanup(void)
 {
-	int i;
+	if (fd_file > 0)
+		SAFE_CLOSE(fd_file);
 
-	for (i = 0; i < 2; i++) {
-		if (fd[i] > 0)
-			SAFE_CLOSE(fd[i]);
-	}
+	if (fd_dir > 0)
+		SAFE_CLOSE(fd_dir);
 }
 
 static struct tst_test test = {

-- 
Cyril Hrubis
chrubis@suse.cz
