From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  3 Aug 2017 15:52:27 +0200
Subject: [LTP] [COMMITTED] [PATCH 3/9] syscalls/splice03: Convert to the new
	library
In-Reply-To: <20170803135233.13676-1-chrubis@suse.cz>
References: <20170803135233.13676-1-chrubis@suse.cz>
Message-ID: <20170803135233.13676-3-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/splice/splice03.c | 111 ++++++++++------------------
 1 file changed, 40 insertions(+), 71 deletions(-)

diff --git a/testcases/kernel/syscalls/splice/splice03.c b/testcases/kernel/syscalls/splice/splice03.c
index b18c52a46..86363dd96 100644
--- a/testcases/kernel/syscalls/splice/splice03.c
+++ b/testcases/kernel/syscalls/splice/splice03.c
@@ -40,8 +40,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 #include "lapi/splice.h"
 
 #define TEST_FILE "testfile"
@@ -58,13 +57,13 @@ static int appendfd;
 static int pipes[2];
 static loff_t offset;
 
-static struct test_case_t {
+static struct tcase {
 	int *fdin;
 	loff_t *offin;
 	int *fdout;
 	loff_t *offout;
 	int exp_errno;
-} test_cases[] = {
+} tcases[] = {
 	{ &badfd, NULL, &pipes[1], NULL, EBADF },
 	{ &pipes[0], NULL, &badfd, NULL, EBADF },
 	{ &wrfd, NULL, &pipes[1], NULL, EBADF },
@@ -74,96 +73,66 @@ static struct test_case_t {
 	{ &rdfd, NULL, &pipes[1], &offset, ESPIPE },
 };
 
-static void setup(void);
-static void cleanup(void);
-static void splice_verify(const struct test_case_t *);
-
-char *TCID = "splice03";
-int TST_TOTAL = ARRAY_SIZE(test_cases);
-
-int main(int ac, char **av)
+static void setup(void)
 {
-	int i, lc;
+	SAFE_FILE_PRINTF(TEST_FILE, STR);
+	rdfd = SAFE_OPEN(TEST_FILE, O_RDONLY);
 
-	tst_parse_opts(ac, av, NULL, NULL);
+	wrfd = SAFE_OPEN(TEST_FILE2, O_WRONLY | O_CREAT, 0644);
 
-	setup();
+	appendfd = SAFE_OPEN(TEST_FILE3, O_RDWR | O_CREAT | O_APPEND, 0644);
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
+	SAFE_PIPE(pipes);
 
-		for (i = 0; i < TST_TOTAL; i++)
-			splice_verify(&test_cases[i]);
-	}
-
-	cleanup();
-	tst_exit();
+	SAFE_WRITE(1, pipes[1], STR, sizeof(STR) - 1);
 }
 
-void setup(void)
+static void splice_verify(unsigned int n)
 {
-	if ((tst_kvercmp(2, 6, 17)) < 0) {
-		tst_brkm(TCONF, cleanup, "This test can only run on kernels "
-			"that are 2.6.17 or higher");
-	}
-
-	TEST_PAUSE;
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	tst_tmpdir();
-
-	SAFE_FILE_PRINTF(cleanup, TEST_FILE, STR);
-	rdfd = SAFE_OPEN(cleanup, TEST_FILE, O_RDONLY);
-
-	wrfd = SAFE_OPEN(cleanup, TEST_FILE2,
-		O_WRONLY | O_CREAT, 0644);
+	struct tcase *tc = &tcases[n];
 
-	appendfd = SAFE_OPEN(cleanup, TEST_FILE3,
-		O_RDWR | O_CREAT | O_APPEND, 0644);
-
-	SAFE_PIPE(cleanup, pipes);
-
-	SAFE_WRITE(cleanup, 1, pipes[1], STR, sizeof(STR) - 1);
-}
-
-static void splice_verify(const struct test_case_t *tc)
-{
 	TEST(splice(*(tc->fdin), tc->offin, *(tc->fdout),
 		tc->offout, SPLICE_TEST_LEN, 0));
 
 	if (TEST_RETURN != -1) {
-		tst_resm(TFAIL, "splice() returned %ld, "
-			"expected -1, errno:%d", TEST_RETURN,
-			tc->exp_errno);
+		tst_res(TFAIL, "splice() returned %ld expected %s",
+			TEST_RETURN, tst_strerrno(tc->exp_errno));
 		return;
 	}
 
-	if (TEST_ERRNO == tc->exp_errno) {
-		tst_resm(TPASS | TTERRNO, "splice() failed as expected");
-	} else {
-		tst_resm(TFAIL | TTERRNO,
+	if (TEST_ERRNO != tc->exp_errno) {
+		tst_res(TFAIL | TTERRNO,
 			"splice() failed unexpectedly; expected: %d - %s",
-			tc->exp_errno, strerror(tc->exp_errno));
+			tc->exp_errno, tst_strerrno(tc->exp_errno));
+		return;
 	}
+
+	tst_res(TPASS | TTERRNO, "splice() failed as expected");
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
-	if (rdfd && close(rdfd) < 0)
-		tst_resm(TWARN | TERRNO, "close rdfd failed");
-
-	if (wrfd && close(wrfd) < 0)
-		tst_resm(TWARN | TERRNO, "close wrfd failed");
+	if (rdfd > 0)
+		SAFE_CLOSE(rdfd);
 
-	if (appendfd && close(appendfd) < 0)
-		tst_resm(TWARN | TERRNO, "close appendfd failed");
+	if (wrfd > 0)
+		SAFE_CLOSE(wrfd);
 
-	if (pipes[0] && close(pipes[0]) < 0)
-		tst_resm(TWARN | TERRNO, "close pipes[0] failed");
+	if (appendfd > 0)
+		SAFE_CLOSE(appendfd);
 
-	if (pipes[1] && close(pipes[1]) < 0)
-		tst_resm(TWARN | TERRNO, "close pipes[1] failed");
+	if (pipes[0] > 0)
+		SAFE_CLOSE(pipes[0]);
 
-	tst_rmdir();
+	if (pipes[1] > 0)
+		SAFE_CLOSE(pipes[1]);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = splice_verify,
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_tmpdir = 1,
+	.min_kver = "2.6.17",
+};
-- 
2.13.0

