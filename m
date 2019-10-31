From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 31 Oct 2019 11:21:16 +0100
Subject: [LTP] [PATCH v3 2/2] Improve coverage in syscalls/fsync03
In-Reply-To: <20191031102116.10592-1-mdoucha@suse.cz>
References: <20191009152459.GB15291@rei.lan>
 <20191031102116.10592-1-mdoucha@suse.cz>
Message-ID: <20191031102116.10592-3-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Adds the following test cases where fsync is supposed to fail:
- Closed non-negative file descriptor (EBADF)
- FIFO (EINVAL)
- Socket (EINVAL)

Signed-off-by: Martin Doucha <mdoucha@suse.com>
---
 testcases/kernel/syscalls/fsync/fsync03.c | 62 ++++++++++++++++-------
 1 file changed, 44 insertions(+), 18 deletions(-)

diff --git a/testcases/kernel/syscalls/fsync/fsync03.c b/testcases/kernel/syscalls/fsync/fsync03.c
index 04d9a6c22..5636726ce 100644
--- a/testcases/kernel/syscalls/fsync/fsync03.c
+++ b/testcases/kernel/syscalls/fsync/fsync03.c
@@ -7,30 +7,58 @@
 /*
  * Test Description:
  *  Testcase to check that fsync(2) sets errno correctly.
- *  1. Call fsync() with an invalid fd, and test for EBADF.
- *  2. Call fsync() on a pipe(fd), and expect EINVAL.
+ *  1. Call fsync() on a pipe(fd), and expect EINVAL.
+ *  2. Call fsync() on a socket(fd), and expect EINVAL.
+ *  3. Call fsync() on a closed fd, and test for EBADF.
+ *  4. Call fsync() on an invalid fd, and test for EBADF.
+ *  5. Call fsync() on a fifo(fd), and expect EINVAL.
  */
 
 #include <unistd.h>
 #include <errno.h>
 #include "tst_test.h"
 
-static int pfd[2];
-static int bfd = -1;
+#define FIFO_PATH "fifo"
 
-const struct test_case {
+static int fifo_rfd, fifo_wfd;
+static int pipe_fd[2];
+static int sock_fd, bad_fd = -1;
+
+static const struct test_case {
 	int *fd;
 	int error;
-} TC[] = {
-	/* EBADF - fd is invalid (-1) */
-	{&bfd, EBADF},
+} testcase_list[] = {
 	/* EINVAL - fsync() on pipe should not succeed. */
-	{pfd, EINVAL}
+	{&pipe_fd[1], EINVAL},
+	/* EINVAL - fsync() on socket should not succeed. */
+	{&sock_fd, EINVAL},
+	/* EBADF - fd is closed */
+	{&pipe_fd[0], EBADF},
+	/* EBADF - fd is invalid (-1) */
+	{&bad_fd, EBADF},
+	/* EINVAL - fsync() on fifo should not succeed. */
+	{&fifo_wfd, EINVAL},
 };
 
+static void setup(void)
+{
+	SAFE_MKFIFO(FIFO_PATH, 0644);
+	SAFE_PIPE(pipe_fd);
+
+	// FIFO must be opened for reading first, otherwise
+	// open(fifo, O_WRONLY) will block.
+	fifo_rfd = SAFE_OPEN(FIFO_PATH, O_RDONLY | O_NONBLOCK);
+	fifo_wfd = SAFE_OPEN(FIFO_PATH, O_WRONLY);
+	sock_fd = SAFE_SOCKET(AF_UNIX, SOCK_STREAM, 0);
+
+	// Do not open any file descriptors after this line unless you close
+	// them before the next test run.
+	SAFE_CLOSE(pipe_fd[0]);
+}
+
 static void test_fsync(unsigned int n)
 {
-	const struct test_case *tc = TC + n;
+	const struct test_case *tc = testcase_list + n;
 
 	TEST(fsync(*tc->fd));
 
@@ -44,20 +72,18 @@ static void test_fsync(unsigned int n)
 	}
 }
 
-static void setup(void)
-{
-	SAFE_PIPE(pfd);
-}
-
 static void cleanup(void)
 {
-	close(pfd[0]);
-	close(pfd[1]);
+	SAFE_CLOSE(fifo_wfd);
+	SAFE_CLOSE(fifo_rfd);
+	SAFE_CLOSE(pipe_fd[1]);
+	SAFE_CLOSE(sock_fd);
 }
 
 static struct tst_test test = {
 	.test = test_fsync,
-	.tcnt = ARRAY_SIZE(TC),
+	.tcnt = ARRAY_SIZE(testcase_list),
+	.needs_tmpdir = 1,
 	.setup = setup,
 	.cleanup = cleanup
 };
-- 
2.23.0

