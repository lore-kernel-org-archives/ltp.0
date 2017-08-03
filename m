From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  3 Aug 2017 15:52:30 +0200
Subject: [LTP] [COMMITED] [PATCH 6/9] syscalls/vmsplice01: Convert to the
	new library
In-Reply-To: <20170803135233.13676-1-chrubis@suse.cz>
References: <20170803135233.13676-1-chrubis@suse.cz>
Message-ID: <20170803135233.13676-6-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/vmsplice/vmsplice01.c | 83 ++++++++-----------------
 1 file changed, 26 insertions(+), 57 deletions(-)

diff --git a/testcases/kernel/syscalls/vmsplice/vmsplice01.c b/testcases/kernel/syscalls/vmsplice/vmsplice01.c
index ef3d80bb1..882e198a6 100644
--- a/testcases/kernel/syscalls/vmsplice/vmsplice01.c
+++ b/testcases/kernel/syscalls/vmsplice/vmsplice01.c
@@ -33,49 +33,25 @@
 #include <fcntl.h>
 #include <sys/poll.h>
 
-#include "test.h"
-#include "lapi/syscalls.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 #include "lapi/fcntl.h"
 #include "lapi/splice.h"
 #include "lapi/vmsplice.h"
 
 #define TEST_BLOCK_SIZE (1<<17)	/* 128K */
 
-static void vmsplice_test(void);
-static void setup(void);
-static void cleanup(void);
-
 #define TESTFILE "vmsplice_test_file"
 
 static int fd_out;
 static char buffer[TEST_BLOCK_SIZE];
 
-char *TCID = "vmsplice01";
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
-		vmsplice_test();
-
-	cleanup();
-	tst_exit();
-}
-
 static void check_file(void)
 {
 	int i;
 	char vmsplicebuffer[TEST_BLOCK_SIZE];
 
-	fd_out = SAFE_OPEN(cleanup, TESTFILE, O_RDONLY);
-	SAFE_READ(cleanup, 1, fd_out, vmsplicebuffer, TEST_BLOCK_SIZE);
+	fd_out = SAFE_OPEN(TESTFILE, O_RDONLY);
+	SAFE_READ(1, fd_out, vmsplicebuffer, TEST_BLOCK_SIZE);
 
 	for (i = 0; i < TEST_BLOCK_SIZE; i++) {
 		if (buffer[i] != vmsplicebuffer[i])
@@ -83,12 +59,11 @@ static void check_file(void)
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
 
 static void vmsplice_test(void)
@@ -103,8 +78,8 @@ static void vmsplice_test(void)
 	v.iov_base = buffer;
 	v.iov_len = TEST_BLOCK_SIZE;
 
-	SAFE_PIPE(cleanup, pipes);
-	fd_out = SAFE_OPEN(cleanup, TESTFILE, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+	fd_out = SAFE_OPEN(TESTFILE, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+	SAFE_PIPE(pipes);
 
 	struct pollfd pfd = {.fd = pipes[1], .events = POLLOUT};
 	offset = 0;
@@ -116,11 +91,11 @@ static void vmsplice_test(void)
 		 * not using the free time for anything interesting.
 		 */
 		if (poll(&pfd, 1, -1) < 0)
-			tst_brkm(TBROK | TERRNO, cleanup, "poll() failed");
+			tst_brk(TBROK | TERRNO, "poll() failed");
 
 		written = vmsplice(pipes[1], &v, 1, 0);
 		if (written < 0) {
-			tst_brkm(TBROK | TERRNO, cleanup, "vmsplice() failed");
+			tst_brk(TBROK | TERRNO, "vmsplice() failed");
 		} else {
 			if (written == 0) {
 				break;
@@ -132,14 +107,13 @@ static void vmsplice_test(void)
 
 		ret = splice(pipes[0], NULL, fd_out, &offset, written, 0);
 		if (ret < 0)
-			tst_brkm(TBROK | TERRNO, cleanup, "splice() failed");
+			tst_brk(TBROK | TERRNO, "splice() failed");
 		//printf("offset = %lld\n", (long long)offset);
 	}
 
-	close(pipes[0]);
-	close(pipes[1]);
-	close(fd_out);
-	fd_out = 0;
+	SAFE_CLOSE(pipes[0]);
+	SAFE_CLOSE(pipes[1]);
+	SAFE_CLOSE(fd_out);
 
 	check_file();
 }
@@ -148,30 +122,25 @@ static void setup(void)
 {
 	int i;
 
-	if ((tst_kvercmp(2, 6, 17)) < 0) {
-		tst_brkm(TCONF, NULL,
-		         "The vmsplice is supported 2.6.17 and newer");
-	}
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	tst_tmpdir();
-
-	if (tst_fs_type(cleanup, ".") == TST_NFS_MAGIC) {
-		tst_brkm(TCONF, cleanup, "Cannot do splice() "
+	if (tst_fs_type(".") == TST_NFS_MAGIC) {
+		tst_brk(TCONF, "Cannot do splice() "
 			 "on a file located on an NFS filesystem");
 	}
 
 	for (i = 0; i < TEST_BLOCK_SIZE; i++)
 		buffer[i] = i & 0xff;
-
-	TEST_PAUSE;
 }
 
 static void cleanup(void)
 {
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
+	.test_all = vmsplice_test,
+	.needs_tmpdir = 1,
+	.min_kver = "2.6.17",
+};
-- 
2.13.0

