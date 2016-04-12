From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 12 Apr 2016 12:53:09 +0800
Subject: [LTP] [PATCH 3/3] syscalls/pwritev02.c: add specific error &&
	convert to new test API
In-Reply-To: <1460436789-11969-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1460436789-11969-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1460436789-11969-3-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) pwritev(2) fails if fd is associated with a pipe and
   set errno to ESPIPE.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/pwritev/pwritev02.c | 107 ++++++++++----------------
 1 file changed, 41 insertions(+), 66 deletions(-)

diff --git a/testcases/kernel/syscalls/pwritev/pwritev02.c b/testcases/kernel/syscalls/pwritev/pwritev02.c
index 6e8b7ea..d7ca105 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev02.c
+++ b/testcases/kernel/syscalls/pwritev/pwritev02.c
@@ -24,6 +24,7 @@
 * 4) pwritev(2) fails when attempts to write from a invalid address
 * 5) pwritev(2) fails if file descriptor is invalid.
 * 6) pwritev(2) fails if file descriptor is not open for writing.
+* 7) pwritev(2) fails if fd is associated with a pipe.
 *
 * Expected Result:
 * 1) pwritev(2) should return -1 and set errno to EINVAL.
@@ -32,20 +33,20 @@
 * 4) pwritev(2) should return -1 and set errno to EFAULT.
 * 5) pwritev(2) should return -1 and set errno to EBADF.
 * 6) pwritev(2) should return -1 and set errno to EBADF.
+* 7) pwritev(2) should return -1 and set errno to ESPIPE.
 */
 
-#include <errno.h>
 #include <sys/uio.h>
-
-#include "test.h"
+#include "tst_test.h"
 #include "pwritev.h"
-#include "safe_macros.h"
 
 #define CHUNK           64
 
 static int fd1;
 static int fd2;
 static int fd3 = -1;
+static int fd4[2];
+
 static char buf[CHUNK];
 
 static struct iovec wr_iovec1[] = {
@@ -57,95 +58,69 @@ static struct iovec wr_iovec2[] = {
 	{(char *)-1, CHUNK},
 };
 
-static struct test_case_t {
+static struct tcase {
 	int *fd;
 	struct iovec *name;
 	int count;
 	off_t offset;
 	int exp_err;
-} tc[] = {
-	/* test1 */
+} tcases[] = {
 	{&fd1, wr_iovec1, 1, 0, EINVAL},
-	/* test2 */
 	{&fd1, wr_iovec2, -1, 0, EINVAL},
-	/* test3 */
 	{&fd1, wr_iovec2, 1, -1, EINVAL},
-	/* test4 */
 	{&fd1, wr_iovec2, 2, 0, EFAULT},
-	/* test5 */
 	{&fd3, wr_iovec2, 1, 0, EBADF},
-	/* test6 */
-	{&fd2, wr_iovec2, 1, 0, EBADF}
+	{&fd2, wr_iovec2, 1, 0, EBADF},
+	{&fd4[1], wr_iovec2, 1, 0, ESPIPE}
 };
 
-static void verify_pwritev(struct test_case_t *tc);
-static void setup(void);
-static void cleanup(void);
-
-char *TCID = "pwritev02";
-int TST_TOTAL = ARRAY_SIZE(tc);
-
-int main(int ac, char **av)
+static void verify_pwritev(unsigned int n)
 {
-	int lc;
-	int i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
+	struct tcase *tc = &tcases[n];
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		for (i = 0; i < TST_TOTAL; i++)
-			verify_pwritev(&tc[i]);
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-static void verify_pwritev(struct test_case_t *tc)
-{
 	TEST(pwritev(*tc->fd, tc->name, tc->count, tc->offset));
 	if (TEST_RETURN == 0) {
-		tst_resm(TFAIL, "pwritev() succeeded unexpectedly");
-	} else {
-		if (TEST_ERRNO == tc->exp_err) {
-			tst_resm(TPASS | TTERRNO,
-				 "pwritev() failed as expected");
-		} else {
-			tst_resm(TFAIL | TTERRNO,
-				 "pwritev() failed unexpectedly, expected"
-				 " errno is %s", tst_strerrno(tc->exp_err));
-		}
+		tst_res(TFAIL, "pwritev() succeeded unexpectedly");
+		return;
 	}
-}
 
-static void setup(void)
-{
-	if ((tst_kvercmp(2, 6, 30)) < 0) {
-		tst_brkm(TCONF, NULL, "This test can only run on kernels"
-			 " that are 2.6.30 or higher.");
+	if (TEST_ERRNO == tc->exp_err) {
+		tst_res(TPASS | TTERRNO, "pwritev() failed as expected");
+		return;
 	}
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	fd1 = SAFE_OPEN(cleanup, "file", O_RDWR | O_CREAT, 0644);
+	tst_res(TFAIL | TTERRNO, "pwritev() failed unexpectedly, expected %s",
+		tst_strerrno(tc->exp_err));
+}
 
-	fd2 = SAFE_OPEN(cleanup, "file", O_RDONLY | O_CREAT, 0644);
+static void setup(void)
+{
+	fd1 = SAFE_OPEN("file", O_RDWR | O_CREAT, 0644);
+	fd2 = SAFE_OPEN("file", O_RDONLY | O_CREAT, 0644);
+	SAFE_PIPE(fd4);
 }
 
 static void cleanup(void)
 {
 	if (fd1 > 0 && close(fd1))
-		tst_resm(TWARN | TERRNO, "failed to close file");
+		tst_res(TWARN | TERRNO, "failed to close file");
 
 	if (fd2 > 0 && close(fd2))
-		tst_resm(TWARN | TERRNO, "failed to close file");
+		tst_res(TWARN | TERRNO, "failed to close file");
+
+	if (fd4[0] > 0 && close(fd4[0]))
+		tst_res(TWARN | TERRNO, "failed to close file");
 
-	tst_rmdir();
+	if (fd4[1] > 0 && close(fd4[1]))
+		tst_res(TWARN | TERRNO, "failed to close file");
 }
+
+static struct tst_test test = {
+	.tid = "pwritev02",
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_pwritev,
+	.min_kver = "2.6.30",
+	.needs_tmpdir = 1,
+};
-- 
1.8.3.1



