From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 23 Jan 2018 17:41:14 +0100
Subject: [LTP] [COMMITTED] [PATCH 1/4] syscalls/pwrite: pwrite02 new test
	library refactoring
Message-ID: <20180123164117.3052-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

From: Carlo Marcelo Arenas Belón <carenas@gmail.com>

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/pwrite/pwrite02.c | 188 +++++++++-------------------
 1 file changed, 56 insertions(+), 132 deletions(-)

diff --git a/testcases/kernel/syscalls/pwrite/pwrite02.c b/testcases/kernel/syscalls/pwrite/pwrite02.c
index d4592fb1d..df506afd6 100644
--- a/testcases/kernel/syscalls/pwrite/pwrite02.c
+++ b/testcases/kernel/syscalls/pwrite/pwrite02.c
@@ -35,58 +35,33 @@
 
 #include <errno.h>
 #include <unistd.h>
-#include <fcntl.h>
-
-#include "test.h"
-#include "safe_macros.h"
-
-#define TEMPFILE	"pwrite_file"
-#define K1		1024
-
-TCID_DEFINE(pwrite02);
-
-static char write_buf[K1];
-
-static void setup(void);
-static void cleanup(void);
-
-static void test_espipe(void);
-static void test_einval(void);
-static void test_ebadf1(void);
-static void test_ebadf2(void);
-
-#if !defined(UCLINUX)
-static void test_efault(void);
-#endif
-
-static void (*testfunc[])(void) = {
-	test_espipe, test_einval, test_ebadf1, test_ebadf2,
-#if !defined(UCLINUX)
-	test_efault
-#endif
+#include <string.h>
+
+#include "tst_test.h"
+
+#define TEMPFILE "pwrite_file"
+#define BS 1024
+
+static int fd;
+static int fd_ro;
+static int inv_fd = -1;
+static int pipe_fds[2];
+static char buf[BS];
+
+static struct tcase {
+	void *buf;
+	size_t size;
+	int *fd;
+	off_t off;
+	int exp_errno;
+} tcases[] = {
+	{buf, sizeof(buf), &pipe_fds[1], 0, ESPIPE},
+	{buf, sizeof(buf), &fd, -1, EINVAL},
+	{buf, sizeof(buf), &inv_fd, 0, EBADF},
+	{buf, sizeof(buf), &fd_ro, 0, EBADF},
+	{NULL, sizeof(buf), &fd, 0, EFAULT},
 };
 
-int TST_TOTAL = ARRAY_SIZE(testfunc);
-
-int main(int ac, char **av)
-{
-	int i, lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++)
-			(*testfunc[i])();
-	}
-
-	cleanup();
-	tst_exit();
-}
-
 /*
  * sighandler - handle SIGXFSZ
  *
@@ -109,106 +84,55 @@ static void sighandler(int sig)
 	(void)ret;
 }
 
-static void setup(void)
+static void verify_pwrite(unsigned int i)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	/* see the comment in the sighandler() function */
-	/* call signal() to trap the signal generated */
-	if (signal(SIGXFSZ, sighandler) == SIG_ERR)
-		tst_brkm(TBROK, cleanup, "signal() failed");
+	struct tcase *tc = &tcases[i];
 
-	TEST_PAUSE;
+	TEST(pwrite(*tc->fd, tc->buf, BS, tc->off));
 
-	tst_tmpdir();
-
-	memset(write_buf, 'a', K1);
-}
-
-static void print_test_result(int err, int exp_errno)
-{
-	if (err == 0) {
-		tst_resm(TFAIL, "call succeeded unexpectedly");
+	if (TEST_RETURN >= 0) {
+		tst_res(TFAIL, "call succeeded unexpectedly");
 		return;
 	}
 
-	if (err == exp_errno) {
-		tst_resm(TPASS, "pwrite failed as expected: %d - %s",
-			 err, strerror(err));
-	} else {
-		tst_resm(TFAIL, "pwrite failed unexpectedly; expected: %d - %s"
-			 "return: %d - %s", exp_errno, strerror(exp_errno),
-			 err, strerror(err));
+	if (TEST_ERRNO != tc->exp_errno) {
+		tst_res(TFAIL | TTERRNO,
+			"pwrite failed unexpectedly, expected %s",
+			tst_strerrno(tc->exp_errno));
 	}
-}
 
-static void test_espipe(void)
-{
-	int pipe_fds[2];
-
-	SAFE_PIPE(cleanup, pipe_fds);
-
-	TEST(pwrite(pipe_fds[1], write_buf, K1, 0));
-
-	print_test_result(errno, ESPIPE);
-
-	SAFE_CLOSE(cleanup, pipe_fds[0]);
-	SAFE_CLOSE(cleanup, pipe_fds[1]);
-}
-
-static void test_einval(void)
-{
-	int fd;
-
-	fd = SAFE_OPEN(cleanup, TEMPFILE, O_RDWR | O_CREAT, 0666);
-
-	/* the specified offset was invalid */
-	TEST(pwrite(fd, write_buf, K1, -1));
-
-	print_test_result(errno, EINVAL);
-
-	SAFE_CLOSE(cleanup, fd);
-}
-
-static void test_ebadf1(void)
-{
-	int fd = -1;
-
-	TEST(pwrite(fd, write_buf, K1, 0));
-
-	print_test_result(errno, EBADF);
+	tst_res(TPASS | TTERRNO, "pwrite failed as expected");
 }
 
-static void test_ebadf2(void)
+static void setup(void)
 {
-	int fd;
-
-	fd = SAFE_OPEN(cleanup, TEMPFILE, O_RDONLY | O_CREAT, 0666);
-
-	TEST(pwrite(fd, write_buf, K1, 0));
+	SAFE_SIGNAL(SIGXFSZ, sighandler);
 
-	print_test_result(errno, EBADF);
+	SAFE_PIPE(pipe_fds);
 
-	SAFE_CLOSE(cleanup, fd);
+	fd = SAFE_OPEN(TEMPFILE, O_RDWR | O_CREAT, 0666);
+	fd_ro = SAFE_OPEN(TEMPFILE, O_RDONLY | O_CREAT, 0666);
 }
 
-#if !defined(UCLINUX)
-static void test_efault(void)
+static void cleanup(void)
 {
-	int fd;
-	char *buf = sbrk(0);
-
-	fd = SAFE_OPEN(cleanup, TEMPFILE, O_RDWR | O_CREAT, 0666);
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 
-	TEST(pwrite(fd, buf, K1, 0));
+	if (fd_ro > 0)
+		SAFE_CLOSE(fd_ro);
 
-	print_test_result(errno, EFAULT);
+	if (pipe_fds[0] > 0)
+		SAFE_CLOSE(pipe_fds[0]);
 
-	SAFE_CLOSE(cleanup, fd);
+	if (pipe_fds[1] > 0)
+		SAFE_CLOSE(pipe_fds[1]);
 }
-#endif
 
-static void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_pwrite,
+	.tcnt = ARRAY_SIZE(tcases),
+};
-- 
2.13.6

