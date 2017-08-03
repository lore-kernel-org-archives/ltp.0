From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  3 Aug 2017 15:52:25 +0200
Subject: [LTP] [COMMITTED] [PATCH 1/9] syscalls/splice01: Convert to the new
	library
Message-ID: <20170803135233.13676-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/splice/splice01.c | 97 ++++++++++-------------------
 1 file changed, 32 insertions(+), 65 deletions(-)

diff --git a/testcases/kernel/syscalls/splice/splice01.c b/testcases/kernel/syscalls/splice/splice01.c
index 773639e1c..a975ccb9a 100644
--- a/testcases/kernel/syscalls/splice/splice01.c
+++ b/testcases/kernel/syscalls/splice/splice01.c
@@ -30,10 +30,8 @@
 #include <signal.h>
 #include <sys/types.h>
 #include <fcntl.h>
-#include <sys/syscall.h>
 
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 #include "lapi/splice.h"
 
 #define TEST_BLOCK_SIZE 1024
@@ -41,37 +39,16 @@
 #define TESTFILE1 "splice_testfile_1"
 #define TESTFILE2 "splice_testfile_2"
 
-static void splice_test(void);
-static void setup(void);
-static void cleanup(void);
 static char buffer[TEST_BLOCK_SIZE];
 static int fd_in, fd_out;
 
-char *TCID = "splice01";
-int TST_TOTAL = 1;
-
-int main(int ac, char **av)
-{
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++)
-		splice_test();
-
-	cleanup();
-	tst_exit();
-}
-
 static void check_file(void)
 {
 	int i;
 	char splicebuffer[TEST_BLOCK_SIZE];
 
-	fd_out = SAFE_OPEN(cleanup, TESTFILE2, O_RDONLY);
-	SAFE_READ(cleanup, 1, fd_out, splicebuffer, TEST_BLOCK_SIZE);
+	fd_out = SAFE_OPEN(TESTFILE2, O_RDONLY);
+	SAFE_READ(1, fd_out, splicebuffer, TEST_BLOCK_SIZE);
 
 	for (i = 0; i < TEST_BLOCK_SIZE; i++) {
 		if (buffer[i] != splicebuffer[i])
@@ -79,12 +56,11 @@ static void check_file(void)
 	}
 
 	if (i < TEST_BLOCK_SIZE)
-		tst_resm(TFAIL, "Wrong data read from the buffer at %i", i);
+		tst_res(TFAIL, "Wrong data read from the buffer@%i", i);
 	else
-		tst_resm(TPASS, "Written data has been read back correctly");
+		tst_res(TPASS, "Written data has been read back correctly");
 
-	close(fd_out);
-	fd_out = 0;
+	SAFE_CLOSE(fd_out);
 }
 
 static void splice_test(void)
@@ -92,25 +68,22 @@ static void splice_test(void)
 	int pipes[2];
 	int ret;
 
-	fd_in = SAFE_OPEN(cleanup, TESTFILE1, O_RDONLY);
-	SAFE_PIPE(cleanup, pipes);
-	fd_out = SAFE_OPEN(cleanup, TESTFILE2, O_WRONLY | O_CREAT | O_TRUNC, 0666);
+	fd_in = SAFE_OPEN(TESTFILE1, O_RDONLY);
+	fd_out = SAFE_OPEN(TESTFILE2, O_WRONLY | O_CREAT | O_TRUNC, 0666);
+	SAFE_PIPE(pipes);
 
 	ret = splice(fd_in, NULL, pipes[1], NULL, TEST_BLOCK_SIZE, 0);
 	if (ret < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "splice(fd_in, pipe) failed");
+		tst_brk(TBROK | TERRNO, "splice(fd_in, pipe) failed");
 
 	ret = splice(pipes[0], NULL, fd_out, NULL, TEST_BLOCK_SIZE, 0);
 	if (ret < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "splice(pipe, fd_out) failed");
+		tst_brk(TBROK | TERRNO, "splice(pipe, fd_out) failed");
 
-	close(fd_in);
-	close(fd_out);
-	close(pipes[0]);
-	close(pipes[1]);
-
-	fd_out = 0;
-	fd_in = 0;
+	SAFE_CLOSE(fd_in);
+	SAFE_CLOSE(fd_out);
+	SAFE_CLOSE(pipes[0]);
+	SAFE_CLOSE(pipes[1]);
 
 	check_file();
 }
@@ -119,39 +92,33 @@ static void setup(void)
 {
 	int i;
 
-	if ((tst_kvercmp(2, 6, 17)) < 0) {
-		tst_brkm(TCONF, NULL,
-		         "The splice is supported 2.6.17 and newer");
-	}
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	if (tst_fs_type(cleanup, ".") == TST_NFS_MAGIC) {
+	if (tst_fs_type(".") == TST_NFS_MAGIC) {
 		if  (tst_kvercmp(2, 6, 32) < 0)
-			tst_brkm(TCONF, cleanup, "Cannot do splice on a file"
+			tst_brk(TCONF, "Cannot do splice on a file"
 				" on NFS filesystem before 2.6.32");
 	}
 
 	for (i = 0; i < TEST_BLOCK_SIZE; i++)
 		buffer[i] = i & 0xff;
 
-	fd_in = SAFE_OPEN(cleanup, TESTFILE1, O_WRONLY | O_CREAT | O_TRUNC, 0777);
-	SAFE_WRITE(cleanup, 1, fd_in, buffer, TEST_BLOCK_SIZE);
-	SAFE_CLOSE(cleanup, fd_in);
-	fd_in = 0;
+	fd_in = SAFE_OPEN(TESTFILE1, O_WRONLY | O_CREAT | O_TRUNC, 0777);
+	SAFE_WRITE(1, fd_in, buffer, TEST_BLOCK_SIZE);
+	SAFE_CLOSE(fd_in);
 }
 
 static void cleanup(void)
 {
-	if (fd_in > 0 && close(fd_in))
-		tst_resm(TWARN, "Failed to close fd_in");
+	if (fd_in > 0)
+		SAFE_CLOSE(fd_in);
 
-	if (fd_out > 0 && close(fd_out))
-		tst_resm(TWARN, "Failed to close fd_out");
-
-	tst_rmdir();
+	if (fd_out > 0)
+		SAFE_CLOSE(fd_out);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = splice_test,
+	.needs_tmpdir = 1,
+	.min_kver = "2.6.17",
+};
-- 
2.13.0

