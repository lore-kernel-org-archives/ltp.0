From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 12 Apr 2016 12:53:08 +0800
Subject: [LTP] [PATCH 2/3] syscalls/pwritev01: convert to new test API
In-Reply-To: <1460436789-11969-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1460436789-11969-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1460436789-11969-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/pwritev/pwritev.h   |  2 +-
 testcases/kernel/syscalls/pwritev/pwritev01.c | 89 +++++++++------------------
 2 files changed, 31 insertions(+), 60 deletions(-)

diff --git a/testcases/kernel/syscalls/pwritev/pwritev.h b/testcases/kernel/syscalls/pwritev/pwritev.h
index ae9d999..4970036 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev.h
+++ b/testcases/kernel/syscalls/pwritev/pwritev.h
@@ -24,7 +24,7 @@
 #if !defined(HAVE_PWRITEV)
 int pwritev(int fd, const struct iovec *iov, int iovcnt, off_t offset)
 {
-	return ltp_syscall(__NR_pwritev, fd, iov, iovcnt, offset);
+	return tst_syscall(__NR_pwritev, fd, iov, iovcnt, offset);
 }
 #endif
 
diff --git a/testcases/kernel/syscalls/pwritev/pwritev01.c b/testcases/kernel/syscalls/pwritev/pwritev01.c
index 1cb35cb..4d3b7a3 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev01.c
+++ b/testcases/kernel/syscalls/pwritev/pwritev01.c
@@ -23,11 +23,10 @@
 * and after writing the file, the file offset is not changed.
 */
 
-#include <errno.h>
-
-#include "test.h"
+#include <string.h>
+#include <sys/uio.h>
+#include "tst_test.h"
 #include "pwritev.h"
-#include "safe_macros.h"
 
 #define	CHUNK		64
 
@@ -41,68 +40,43 @@ static struct iovec wr_iovec[] = {
 	{NULL, 0},
 };
 
-static struct test_case_t {
+static struct tcase {
 	int count;
 	off_t offset;
 	ssize_t size;
-} tc[] = {
+} tcases[] = {
 	{1, 0, CHUNK},
 	{2, 0, CHUNK},
 	{1, CHUNK/2, CHUNK},
 };
 
-void verify_pwritev(struct test_case_t *);
-void setup(void);
-void cleanup(void);
-
-char *TCID = "pwritev01";
-int TST_TOTAL =  ARRAY_SIZE(tc);
-
-int main(int ac, char **av)
-{
-	int lc;
-	int i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++)
-			verify_pwritev(&tc[i]);
-	}
-	cleanup();
-	tst_exit();
-}
-
-void verify_pwritev(struct test_case_t *tc)
+static void verify_pwritev(unsigned int n)
 {
 	int i;
+	struct tcase *tc = &tcases[n];
 
-	SAFE_PWRITE(cleanup, 1, fd, initbuf, sizeof(initbuf), 0);
+	SAFE_PWRITE(1, fd, initbuf, sizeof(initbuf), 0);
 
-	SAFE_LSEEK(cleanup, fd, 0, SEEK_SET);
+	SAFE_LSEEK(fd, 0, SEEK_SET);
 
 	TEST(pwritev(fd, wr_iovec, tc->count, tc->offset));
 	if (TEST_RETURN < 0) {
-		tst_resm(TFAIL | TTERRNO, "Pwritev(2) failed");
+		tst_res(TFAIL | TERRNO, "pwritev() failed");
 		return;
 	}
 
 	if (TEST_RETURN != tc->size) {
-		tst_resm(TFAIL, "Pwritev(2) write %li bytes, expected %li",
+		tst_res(TFAIL, "pwritev() wrote %li bytes, expected %li",
 			 TEST_RETURN, tc->size);
 		return;
 	}
 
-	if (SAFE_LSEEK(cleanup, fd, 0, SEEK_CUR) != 0) {
-		tst_resm(TFAIL, "Pwritev(2) has changed file offset");
+	if (SAFE_LSEEK(fd, 0, SEEK_CUR) != 0) {
+		tst_res(TFAIL, "pwritev() had changed file offset");
 		return;
 	}
 
-	SAFE_PREAD(cleanup, 1, fd, preadbuf, tc->size, tc->offset);
+	SAFE_PREAD(1, fd, preadbuf, tc->size, tc->offset);
 
 	for (i = 0; i < tc->size; i++) {
 		if (preadbuf[i] != 0x61)
@@ -110,37 +84,34 @@ void verify_pwritev(struct test_case_t *tc)
 	}
 
 	if (i != tc->size) {
-		tst_resm(TFAIL, "Buffer wrong at %i have %02x expected 61",
+		tst_res(TFAIL, "buffer wrong at %i have %02x expected 61",
 			 i, preadbuf[i]);
 		return;
 	}
 
-	tst_resm(TPASS, "Pwritev(2) write %li bytes successfully "
+	tst_res(TPASS, "writev() wrote %li bytes successfully "
 		 "with content 'a' expectedly ", tc->size);
 }
 
-void setup(void)
+static void setup(void)
 {
-	if ((tst_kvercmp(2, 6, 30)) < 0) {
-		tst_brkm(TCONF, NULL, "This test can only run on kernels "
-			"that are 2.6.30 and higher");
-	}
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
 	memset(&buf, 0x61, CHUNK);
 
-	fd = SAFE_OPEN(cleanup, "file", O_RDWR | O_CREAT, 0644);
+	fd = SAFE_OPEN("file", O_RDWR | O_CREAT, 0644);
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
 	if (fd > 0 && close(fd))
-		tst_resm(TWARN | TERRNO, "Failed to close file");
-
-	tst_rmdir();
+		tst_res(TWARN | TERRNO, "failed to close file");
 }
+
+static struct tst_test test = {
+	.tid = "pwritev01",
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_pwritev,
+	.min_kver = "2.6.30",
+	.needs_tmpdir = 1,
+};
-- 
1.8.3.1



