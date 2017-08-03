From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  3 Aug 2017 15:52:31 +0200
Subject: [LTP] [COMMITTED] [PATCH 7/9] syscalls/vmsplice02: Convert to the
	new library
In-Reply-To: <20170803135233.13676-1-chrubis@suse.cz>
References: <20170803135233.13676-1-chrubis@suse.cz>
Message-ID: <20170803135233.13676-7-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/vmsplice/vmsplice02.c | 93 +++++++++----------------
 1 file changed, 32 insertions(+), 61 deletions(-)

diff --git a/testcases/kernel/syscalls/vmsplice/vmsplice02.c b/testcases/kernel/syscalls/vmsplice/vmsplice02.c
index 730b0fa64..1e100a143 100644
--- a/testcases/kernel/syscalls/vmsplice/vmsplice02.c
+++ b/testcases/kernel/syscalls/vmsplice/vmsplice02.c
@@ -35,8 +35,7 @@
 #include <sys/uio.h>
 #include <limits.h>
 
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 #include "lapi/syscalls.h"
 #include "lapi/fcntl.h"
 #include "lapi/vmsplice.h"
@@ -51,100 +50,72 @@ static int filefd;
 static int pipes[2];
 static struct iovec ivc;
 
-static struct test_case_t {
+static struct tcase {
 	int *fd;
 	const struct iovec *iov;
 	unsigned long nr_segs;
 	int exp_errno;
-} test_cases[] = {
+} tcases[] = {
 	{ &notvalidfd, &ivc, 1, EBADF },
 	{ &filefd, &ivc, 1, EBADF },
 	{ &pipes[1], &ivc, IOV_MAX + 1, EINVAL },
 };
 
-static void setup(void);
-static void cleanup(void);
-static void vmsplice_verify(const struct test_case_t *);
-
-char *TCID = "vmsplice02";
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
-			vmsplice_verify(&test_cases[i]);
-	}
-
-	cleanup();
-	tst_exit();
-}
-
 static void setup(void)
 {
-	if ((tst_kvercmp(2, 6, 17)) < 0) {
-		tst_brkm(TCONF, cleanup, "This test can only run on "
-			"kernels that are 2.6.17 or higher");
-	}
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	if (tst_fs_type(cleanup, ".") == TST_NFS_MAGIC) {
-		tst_brkm(TCONF, cleanup, "Cannot do splice() "
+	if (tst_fs_type(".") == TST_NFS_MAGIC) {
+		tst_brk(TCONF, "Cannot do splice() "
 			"on a file located on an NFS filesystem");
 	}
 
-	filefd = SAFE_OPEN(cleanup, TESTFILE,
-				O_WRONLY | O_CREAT, 0644);
+	filefd = SAFE_OPEN(TESTFILE, O_WRONLY | O_CREAT, 0644);
 
-	SAFE_PIPE(cleanup, pipes);
+	SAFE_PIPE(pipes);
 
 	ivc.iov_base = buffer;
 	ivc.iov_len = TEST_BLOCK_SIZE;
 }
 
-static void vmsplice_verify(const struct test_case_t *tc)
+static void vmsplice_verify(unsigned int n)
 {
+	struct tcase *tc = &tcases[n];
+
 	TEST(vmsplice(*(tc->fd), tc->iov, tc->nr_segs, 0));
 
 	if (TEST_RETURN != -1) {
-		tst_resm(TFAIL, "vmsplice() returned %ld, "
+		tst_res(TFAIL, "vmsplice() returned %ld, "
 			"expected -1, errno:%d", TEST_RETURN,
 			tc->exp_errno);
 		return;
 	}
 
-	if (TEST_ERRNO == tc->exp_errno) {
-		tst_resm(TPASS | TTERRNO, "vmsplice() failed as expected");
-	} else {
-		tst_resm(TFAIL | TTERRNO,
+	if (TEST_ERRNO != tc->exp_errno) {
+		tst_res(TFAIL | TTERRNO,
 			"vmsplice() failed unexpectedly; expected: %d - %s",
-			tc->exp_errno, strerror(tc->exp_errno));
+			tc->exp_errno, tst_strerrno(tc->exp_errno));
+		return;
 	}
+
+	tst_res(TPASS | TTERRNO, "vmsplice() failed as expected");
 }
 
 static void cleanup(void)
 {
-	if (filefd && close(filefd) < 0)
-		tst_resm(TWARN | TERRNO, "close filefd failed");
-
-	if (pipes[0] && close(pipes[0]) < 0)
-		tst_resm(TWARN | TERRNO, "close pipes[0] failed");
+	if (filefd > 0)
+		SAFE_CLOSE(filefd);
 
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
+	.test = vmsplice_verify,
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_tmpdir = 1,
+	.min_kver = "2.6.17",
+};
-- 
2.13.0

