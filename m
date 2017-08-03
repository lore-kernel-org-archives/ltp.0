From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  3 Aug 2017 15:52:28 +0200
Subject: [LTP] [COMMITTED] [PATCH 4/9] syscalls/tee01: Convert to the new
	library
In-Reply-To: <20170803135233.13676-1-chrubis@suse.cz>
References: <20170803135233.13676-1-chrubis@suse.cz>
Message-ID: <20170803135233.13676-4-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/tee/tee01.c | 107 ++++++++++++----------------------
 1 file changed, 36 insertions(+), 71 deletions(-)

diff --git a/testcases/kernel/syscalls/tee/tee01.c b/testcases/kernel/syscalls/tee/tee01.c
index ee337f868..7e64779ba 100644
--- a/testcases/kernel/syscalls/tee/tee01.c
+++ b/testcases/kernel/syscalls/tee/tee01.c
@@ -31,19 +31,12 @@
 #include <signal.h>
 #include <sys/types.h>
 #include <fcntl.h>
-#include <sys/syscall.h>
 
-#include "test.h"
-#include "lapi/syscalls.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 #include "lapi/fcntl.h"
 #include "lapi/tee.h"
 #include "lapi/splice.h"
 
-static void tee_test(void);
-static void setup(void);
-static void cleanup(void);
-
 #define TEST_BLOCK_SIZE 1024
 
 #define TESTFILE1 "tee_test_file_1"
@@ -52,31 +45,13 @@ static void cleanup(void);
 static int fd_in, fd_out;
 static char buffer[TEST_BLOCK_SIZE];
 
-char *TCID = "tee01";
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
-		tee_test();
-
-	cleanup();
-	tst_exit();
-}
-
 static void check_file(void)
 {
 	int i;
 	char teebuffer[TEST_BLOCK_SIZE];
 
-	fd_out = SAFE_OPEN(cleanup, TESTFILE2, O_RDONLY);
-	SAFE_READ(cleanup, 1, fd_out, teebuffer, TEST_BLOCK_SIZE);
+	fd_out = SAFE_OPEN(TESTFILE2, O_RDONLY);
+	SAFE_READ(1, fd_out, teebuffer, TEST_BLOCK_SIZE);
 
 	for (i = 0; i < TEST_BLOCK_SIZE; i++) {
 		if (buffer[i] != teebuffer[i])
@@ -84,12 +59,11 @@ static void check_file(void)
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
 
 static void tee_test(void)
@@ -98,33 +72,30 @@ static void tee_test(void)
 	int pipe2[2];
 	int ret = 0;
 
-	fd_in = SAFE_OPEN(cleanup, TESTFILE1, O_RDONLY);
-	fd_out = SAFE_OPEN(cleanup, TESTFILE2, O_WRONLY | O_CREAT | O_TRUNC, 0777);
+	fd_in = SAFE_OPEN(TESTFILE1, O_RDONLY);
+	fd_out = SAFE_OPEN(TESTFILE2, O_WRONLY | O_CREAT | O_TRUNC, 0777);
 
-	SAFE_PIPE(cleanup, pipe1);
-	SAFE_PIPE(cleanup, pipe2);
+	SAFE_PIPE(pipe1);
+	SAFE_PIPE(pipe2);
 
 	ret = splice(fd_in, NULL, pipe1[1], NULL, TEST_BLOCK_SIZE, 0);
 	if (ret < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "splice(fd_in, pipe1) failed");
+		tst_brk(TBROK | TERRNO, "splice(fd_in, pipe1) failed");
 
 	ret = tee(pipe1[0], pipe2[1], TEST_BLOCK_SIZE, SPLICE_F_NONBLOCK);
 	if (ret < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "tee() failed");
+		tst_brk(TBROK | TERRNO, "tee() failed");
 
 	ret = splice(pipe2[0], NULL, fd_out, NULL, TEST_BLOCK_SIZE, 0);
 	if (ret < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "splice(pipe2, fd_out) failed");
+		tst_brk(TBROK | TERRNO, "splice(pipe2, fd_out) failed");
 
-	close(pipe2[0]);
-	close(pipe2[1]);
-	close(pipe1[0]);
-	close(pipe1[1]);
-	close(fd_out);
-	close(fd_in);
-
-	fd_out = 0;
-	fd_in = 0;
+	SAFE_CLOSE(pipe2[0]);
+	SAFE_CLOSE(pipe2[1]);
+	SAFE_CLOSE(pipe1[0]);
+	SAFE_CLOSE(pipe1[1]);
+	SAFE_CLOSE(fd_out);
+	SAFE_CLOSE(fd_in);
 
 	check_file();
 }
@@ -133,39 +104,33 @@ static void setup(void)
 {
 	int i;
 
-	if ((tst_kvercmp(2, 6, 17)) < 0) {
-		tst_brkm(TCONF, cleanup, "This test can only run on kernels "
-			"that are 2.6.17 or higher");
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
 		if ((tst_kvercmp(2, 6, 32)) < 0)
-			tst_brkm(TCONF, cleanup, "Cannot do tee on a file"
+			tst_brk(TCONF, "Cannot do tee on a file"
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
+	.test_all = tee_test,
+	.needs_tmpdir = 1,
+	.min_kver = "2.6.17",
+};
-- 
2.13.0

