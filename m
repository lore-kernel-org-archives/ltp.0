From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  3 Aug 2017 15:52:29 +0200
Subject: [LTP] [COMMITTED] [PATCH 5/9] syscalls/tee02: Convert to the new
	library
In-Reply-To: <20170803135233.13676-1-chrubis@suse.cz>
References: <20170803135233.13676-1-chrubis@suse.cz>
Message-ID: <20170803135233.13676-5-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/tee/tee02.c | 91 ++++++++++++-----------------------
 1 file changed, 31 insertions(+), 60 deletions(-)

diff --git a/testcases/kernel/syscalls/tee/tee02.c b/testcases/kernel/syscalls/tee/tee02.c
index 2173cd23c..d454f4adb 100644
--- a/testcases/kernel/syscalls/tee/tee02.c
+++ b/testcases/kernel/syscalls/tee/tee02.c
@@ -32,8 +32,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 #include "lapi/tee.h"
 
 #define TEST_FILE "testfile"
@@ -44,91 +43,63 @@
 static int fd;
 static int pipes[2];
 
-static struct test_case_t {
+static struct tcase {
 	int *fdin;
 	int *fdout;
 	int exp_errno;
-} test_cases[] = {
+} tcases[] = {
 	{ &fd, &pipes[1], EINVAL },
 	{ &pipes[0], &fd, EINVAL },
 	{ &pipes[0], &pipes[1], EINVAL },
 };
 
-static void setup(void);
-static void cleanup(void);
-static void tee_verify(const struct test_case_t *);
-
-char *TCID = "tee02";
-int TST_TOTAL = ARRAY_SIZE(test_cases);
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
-			tee_verify(&test_cases[i]);
-	}
-
-	cleanup();
-	tst_exit();
-}
-
 static void setup(void)
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
-	fd = SAFE_OPEN(cleanup, TEST_FILE, O_RDWR | O_CREAT);
-
-	SAFE_PIPE(cleanup, pipes);
-	SAFE_WRITE(cleanup, 1, pipes[1], STR, sizeof(STR) - 1);
+	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT);
+	SAFE_PIPE(pipes);
+	SAFE_WRITE(1, pipes[1], STR, sizeof(STR) - 1);
 }
 
-static void tee_verify(const struct test_case_t *tc)
+static void tee_verify(unsigned int n)
 {
+	struct tcase *tc = &tcases[n];
+
 	TEST(tee(*(tc->fdin), *(tc->fdout), TEE_TEST_LEN, 0));
 
 	if (TEST_RETURN != -1) {
-		tst_resm(TFAIL, "tee() returned %ld, "
+		tst_res(TFAIL, "tee() returned %ld, "
 			"expected -1, errno:%d", TEST_RETURN,
 			tc->exp_errno);
 		return;
 	}
 
-	if (TEST_ERRNO == tc->exp_errno) {
-		tst_resm(TPASS | TTERRNO, "tee() failed as expected");
-	} else {
-		tst_resm(TFAIL | TTERRNO,
+	if (TEST_ERRNO != tc->exp_errno) {
+		tst_res(TFAIL | TTERRNO,
 			"tee() failed unexpectedly; expected: %d - %s",
-			tc->exp_errno, strerror(tc->exp_errno));
+			tc->exp_errno, tst_strerrno(tc->exp_errno));
+		return;
 	}
+
+	tst_res(TPASS | TTERRNO, "tee() failed as expected");
 }
 
 static void cleanup(void)
 {
-	if (fd && close(fd) < 0)
-		tst_resm(TWARN | TERRNO, "close fd failed");
-
-	if (pipes[0] && close(pipes[0]) < 0)
-		tst_resm(TWARN | TERRNO, "close pipes[0] failed");
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 
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
+	.test = tee_verify,
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_tmpdir = 1,
+	.min_kver = "2.6.17",
+};
-- 
2.13.0

