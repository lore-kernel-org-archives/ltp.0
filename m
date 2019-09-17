From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 17 Sep 2019 12:17:06 +0200
Subject: [LTP] [PATCH 2/2] Improve coverage in syscalls/fsync03
In-Reply-To: <20190917101706.10013-1-mdoucha@suse.cz>
References: <20190917101706.10013-1-mdoucha@suse.cz>
Message-ID: <20190917101706.10013-3-mdoucha@suse.cz>
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
 testcases/kernel/syscalls/fsync/fsync03.c | 83 ++++++++++++++++++-----
 1 file changed, 65 insertions(+), 18 deletions(-)

diff --git a/testcases/kernel/syscalls/fsync/fsync03.c b/testcases/kernel/syscalls/fsync/fsync03.c
index 82fd52070..d574b07d7 100644
--- a/testcases/kernel/syscalls/fsync/fsync03.c
+++ b/testcases/kernel/syscalls/fsync/fsync03.c
@@ -7,31 +7,75 @@
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
 
-static int pfd[2];		/* fd's for the pipe() call in setup()  */
-static int bfd = -1;		/* an invalid fd                        */
+#define FIFO_PATH "fifo"
+
+#define PIPE_CASE 0
+#define SOCKET_CASE 1
+#define CLOSED_CASE 2
+
+/* fd's for the pipe() call in setup()  */
+static int pfd[2];
+/* FIFO must be opened for reading first, otherwise open(fifo, O_WRONLY)
+   will block. */
+static int fifo_rfd;
 
 struct test_case {
-	int *fd;
+	int fd;
 	int error;
-} TC[] = {
-	/* EBADF - fd is invalid (-1) */
-	{&bfd, EBADF},
+	const char *path;
+} testcase_list[] = {
 	/* EINVAL - fsync() on pipe should not succeed. */
-	{pfd, EINVAL}
+	{-1, EINVAL, NULL},
+	/* EINVAL - fsync() on socket should not succeed. */
+	{-1, EINVAL, NULL},
+	/* EBADF - fd is closed */
+	{-1, EBADF, NULL},
+	/* EBADF - fd is invalid (-1) */
+	{-1, EBADF, NULL},
+	/* EINVAL - fsync() on fifo should not succeed. */
+	{-1, EINVAL, FIFO_PATH},
 };
 
+static void setup(void) {
+	SAFE_MKFIFO(FIFO_PATH, 0644);
+	SAFE_PIPE(pfd);
+
+	testcase_list[CLOSED_CASE].fd = pfd[0];
+	testcase_list[PIPE_CASE].fd = pfd[1];
+	fifo_rfd = SAFE_OPEN(FIFO_PATH, O_RDONLY | O_NONBLOCK);
+	testcase_list[SOCKET_CASE].fd = SAFE_SOCKET(AF_UNIX, SOCK_STREAM, 0);
+
+	// Do not open any file descriptors after this line unless you close
+	// them before the next test run.
+	SAFE_CLOSE(testcase_list[CLOSED_CASE].fd);
+}
+
 static void test_fsync(unsigned int n) {
-	struct test_case *tc = TC + n;
+	struct test_case *tc = testcase_list + n;
+	int fd = tc->fd, result;
 
-	if (!fsync(*tc->fd)) {
+	if (tc->path) {
+		fd = SAFE_OPEN(tc->path, O_WRONLY);
+	}
+
+	result = fsync(fd);
+
+	if (tc->path) {
+		close(fd);
+	}
+
+	if (!result) {
 		tst_res(TFAIL, "fsync() succeeded unexpectedly");
 	} else if (errno != tc->error) {
 		tst_res(TFAIL | TERRNO, "Unexpected error");
@@ -40,18 +84,21 @@ static void test_fsync(unsigned int n) {
 	}
 }
 
-static void setup(void) {
-	SAFE_PIPE(pfd);
-}
-
 static void cleanup(void) {
-	close(pfd[0]);
-	close(pfd[1]);
+	// close fifo_rfd instead of the already closed test FD
+	testcase_list[CLOSED_CASE].fd = fifo_rfd;
+
+	for (int i = 0; i < ARRAY_SIZE(testcase_list); i++) {
+		if (testcase_list[i].fd >= 0) {
+			close(testcase_list[i].fd);
+		}
+	}
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
2.22.1

