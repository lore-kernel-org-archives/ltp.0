From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 23 Jan 2018 17:41:15 +0100
Subject: [LTP] [COMMITTED] [PATCH 2/4] syscalls/write: write04 new test
	library refactoring
In-Reply-To: <20180123164117.3052-1-chrubis@suse.cz>
References: <20180123164117.3052-1-chrubis@suse.cz>
Message-ID: <20180123164117.3052-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

From: Carlo Marcelo Arenas Belón <carenas@gmail.com>

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/write/write04.c | 223 +++++-------------------------
 1 file changed, 38 insertions(+), 185 deletions(-)

diff --git a/testcases/kernel/syscalls/write/write04.c b/testcases/kernel/syscalls/write/write04.c
index d6a51460c..36ef97e8a 100644
--- a/testcases/kernel/syscalls/write/write04.c
+++ b/testcases/kernel/syscalls/write/write04.c
@@ -18,31 +18,12 @@
  */
 
 /*
- * NAME
- *	write04.c
- *
  * DESCRIPTION
  *	Testcase to check that write() sets errno to EAGAIN
  *
  * ALGORITHM
  *	Create a named pipe (fifo), open it in O_NONBLOCK mode, and
  *	attempt to write to it when it is full, write(2) should fail
- *	with EAGAIN.
- *
- * USAGE:  <for command-line>
- *      write04 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *      where,  -c n : Run n copies concurrently.
- *              -e   : Turn on errno logging.
- *              -i n : Execute test n times.
- *              -I x : Execute test for x seconds.
- *              -P x : Pause for x seconds between iterations.
- *              -t   : Turn on syscall timing.
- *
- * HISTORY
- *      ??/???? someone made this testcase but didn't add HISTORY
- *
- * RESTRICTIONS
- *	NONE
  */
 
 #include <sys/stat.h>
@@ -51,189 +32,61 @@
 #include <setjmp.h>
 #include <errno.h>
 #include <string.h>
-#include "test.h"
+#include <stdio.h>
+#include "tst_test.h"
 
-#define PIPE_SIZE_TEST getpagesize()
+static char fifo[100];
+static int rfd, wfd;
+static long page_size;
 
-void alarm_handler();
-void setup();
-void cleanup();
+static void verify_write(void)
+{
+	char wbuf[8 * page_size];
 
-char *TCID = "write04";
-int TST_TOTAL = 1;
+	TEST(write(wfd, wbuf, sizeof(wbuf)));
 
-char fifo[100] = "fifo";
-static sigjmp_buf jmp;
-int rfd, wfd;
+	if (TEST_RETURN != -1) {
+		tst_res(TFAIL, "write() succeeded unexpectedly");
+		return;
+	}
 
-int main(int argc, char **argv)
-{
-	int lc;
-
-	struct stat buf;
-	int fail;
-	int cnt;
-	char wbuf[17 * PIPE_SIZE_TEST];
-	struct sigaction sigptr;	/* set up signal handler */
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	/* global setup */
-	setup();
-
-	/*
-	 * The following loop checks looping state if -i option given
-	 */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		if (mknod(fifo, S_IFIFO | 0777, 0) < 0) {
-			tst_resm(TBROK, "mknod() failed, errno: %d", errno);
-			cleanup();
-		}
-		if (stat(fifo, &buf) != 0) {
-			tst_resm(TBROK, "stat() failed, errno: %d", errno);
-			cleanup();
-		}
-		if ((buf.st_mode & S_IFIFO) == 0) {
-			tst_resm(TBROK, "Mode does not indicate fifo file");
-			cleanup();
-		}
-#if 0
-		sigset(SIGALRM, alarm_handler);
-#endif
-		sigptr.sa_handler = (void (*)(int signal))alarm_handler;
-		sigfillset(&sigptr.sa_mask);
-		sigptr.sa_flags = 0;
-		sigaddset(&sigptr.sa_mask, SIGALRM);
-		if (sigaction(SIGALRM, &sigptr, NULL) == -1) {
-			tst_resm(TBROK, "sigaction(): Failed");
-			cleanup();
-		}
-//block1:
-		tst_resm(TINFO, "Enter block 1: test for EAGAIN in write()");
-		fail = 0;
-
-		(void)memset((void *)wbuf, 'A', 17 * PIPE_SIZE_TEST);
-
-		/*
-		 * open the read end of the pipe
-		 */
-		if (sigsetjmp(jmp, 1)) {
-			tst_resm(TBROK, "Error reading fifo, read blocked");
-			fail = 1;
-		}
-		(void)alarm(10);	/* set alarm for 10 seconds */
-		rfd = open(fifo, O_RDONLY | O_NONBLOCK);
-		(void)alarm(0);
-		if (rfd < 0) {
-			tst_resm(TBROK, "open() for reading the pipe failed");
-			fail = 1;
-		}
-
-		/*
-		 * open the write end of the pipe
-		 */
-		if (sigsetjmp(jmp, 1)) {
-			tst_resm(TBROK, "setjmp() failed");
-			cleanup();
-		}
-		(void)alarm(10);	/* set alarm for 10 seconds */
-		wfd = open(fifo, O_WRONLY | O_NONBLOCK);
-		(void)alarm(0);
-		if (wfd < 0) {
-			tst_resm(TBROK, "open() for writing the pipe failed");
-			fail = 1;
-		}
-
-		/*
-		 * attempt to fill the pipe with some data
-		 */
-		if (sigsetjmp(jmp, 1)) {
-			tst_resm(TBROK, "sigsetjmp() failed");
-			fail = 1;
-		}
-		(void)alarm(10);
-		cnt = write(wfd, wbuf, 17 * PIPE_SIZE_TEST);
-		(void)alarm(0);
-		if (cnt == 17 * PIPE_SIZE_TEST) {
-			tst_resm(TBROK, "Error reading fifo, nozero read");
-			fail = 1;
-		}
-
-		/*
-		 * Now that the fifo is full try and send some more
-		 */
-		if (sigsetjmp(jmp, 1)) {
-			tst_resm(TBROK, "sigsetjmp() failed");
-			fail = 1;
-		}
-		(void)alarm(10);
-		cnt = write(wfd, wbuf, 8 * PIPE_SIZE_TEST);
-		(void)alarm(0);
-		if (cnt != -1) {
-			tst_resm(TBROK, "write() failed to fail when pipe "
-				 "is full");
-			fail = 1;
-		} else {
-			if (errno != EAGAIN) {
-				tst_resm(TBROK, "write set bad errno, expected "
-					 "EAGAIN, got %d", errno);
-				fail = 1;
-			}
-			tst_resm(TINFO, "read() succeded in setting errno to "
-				 "EAGAIN");
-		}
-		if (fail) {
-			tst_resm(TFAIL, "Block 1 FAILED");
-		} else {
-			tst_resm(TPASS, "Block 1 PASSED");
-		}
-		tst_resm(TINFO, "Exit block 1");
-
-		/* unlink fifo in case we are looping. */
-		unlink(fifo);
+	if (TEST_ERRNO != EAGAIN) {
+		tst_res(TFAIL | TTERRNO,
+			"write() failed unexpectedly, expected EAGAIN");
+		return;
 	}
-	cleanup();
-	tst_exit();
-}
 
-void alarm_handler(void)
-{
-	siglongjmp(jmp, 1);
+	tst_res(TPASS | TTERRNO, "write() failed expectedly");
 }
 
-/*
- * setup()
- *	performs all ONE TIME setup for this test
- */
-void setup(void)
+static void setup(void)
 {
+	page_size = getpagesize();
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	char wbuf[17 * page_size];
 
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -i option.
-	 * You want to make sure you do this before you create your temporary
-	 * directory.
-	 */
-	TEST_PAUSE;
+	sprintf(fifo, "%s.%d", fifo, getpid());
 
-	/* Create a unique temporary directory and chdir() to it. */
-	tst_tmpdir();
+	SAFE_MKNOD(fifo, S_IFIFO | 0777, 0);
 
-	/* create a temporary filename */
-	sprintf(fifo, "%s.%d", fifo, getpid());
+	rfd = SAFE_OPEN(fifo, O_RDONLY | O_NONBLOCK);
+	wfd = SAFE_OPEN(fifo, O_WRONLY | O_NONBLOCK);
 
+	SAFE_WRITE(0, wfd, wbuf, sizeof(wbuf));
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
+	if (rfd > 0)
+		SAFE_CLOSE(rfd);
 
-	close(rfd);
-	close(wfd);
-	unlink(fifo);
-	tst_rmdir();
-
+	if (wfd > 0)
+		SAFE_CLOSE(wfd);
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_write,
+};
-- 
2.13.6

