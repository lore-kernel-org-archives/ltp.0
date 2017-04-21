From: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
Date: Fri, 21 Apr 2017 18:48:26 +0800
Subject: [LTP] [PATCH 1/2] syscall/write02.c: Cleanup && convert to new API.
Message-ID: <1492771707-7554-1-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/write/write02.c | 142 ++++++++----------------------
 1 file changed, 37 insertions(+), 105 deletions(-)

diff --git a/testcases/kernel/syscalls/write/write02.c b/testcases/kernel/syscalls/write/write02.c
index 4924422..2ce94cd 100644
--- a/testcases/kernel/syscalls/write/write02.c
+++ b/testcases/kernel/syscalls/write/write02.c
@@ -1,6 +1,8 @@
 /*
- *
  *   Copyright (c) International Business Machines  Corp., 2001
+ *	07/2001 ported by John George
+ *   Copyright (c) 2017 Fujitsu Ltd.
+ *	04/2017 Modified by Jinhui Huang
  *
  *   This program is free software;  you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -18,129 +20,59 @@
  */
 
 /*
- * NAME
- *	write02.c
- *
  * DESCRIPTION
  *	Basic functionality test: does the return from write match the count
  *	of the number of bytes written.
- *
- *
- * ALGORITHM
- *	Create a file and write some bytes out to it.
- *	Check the return count against the number returned.
- *
- * USAGE:  <for command-line>
- *      write02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *      where,  -c n : Run n copies concurrently.
- *              -e   : Turn on errno logging.
- *              -i n : Execute test n times.
- *              -I x : Execute test for x seconds.
- *              -P x : Pause for x seconds between iterations.
- *              -t   : Turn on syscall timing.
- *
- * History
- *	07/2001 John George
- *		-Ported
- *
- * Restrictions
- *	None
  */
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <stdio.h>
-#include "test.h"
 
-char *TCID = "write02";
-int TST_TOTAL = 1;
-
-void cleanup(void);
-void setup(void);
+#include <stdio.h>
+#include <errno.h>
+#include "tst_test.h"
 
-char pfiln[40] = "";
+static int fd, iws;
+static char pwbuf[BUFSIZ + 1];
 
-int main(int argc, char **argv)
+static void verify_write(void)
 {
-	int lc;
-
-	int cwrite;
-	int fild;
-	int iws;
 	int badcount = 0;
-	char pwbuf[BUFSIZ + 1];
 
-	tst_parse_opts(argc, argv, NULL, NULL);
+	fd = SAFE_CREAT("testfile", 0777);
 
-	setup();		/* global setup for test */
+	for (iws = BUFSIZ; iws > 0; iws--) {
+		TEST(write(fd, pwbuf, iws));
 
-	/* The following loop checks looping state if -i option given */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-//block1:
-		tst_resm(TINFO, "Block 1: test to see write() returns proper "
-			 "write count");
-
-		for (iws = 0; iws < BUFSIZ; iws++) {
-			pwbuf[iws] = 'A' + (iws % 26);
+		if (TEST_RETURN != iws) {
+			tst_res(TINFO, "bad write count");
+			badcount++;
 		}
-		pwbuf[BUFSIZ] = '\n';
-
-		if ((fild = creat(pfiln, 0777)) == -1) {
-			tst_brkm(TBROK, cleanup, "Can't creat Xwrit");
-		}
-		for (iws = BUFSIZ; iws > 0; iws--) {
-			if ((cwrite = write(fild, pwbuf, iws)) != iws) {
-				badcount++;
-				tst_resm(TINFO, "bad write count");
-			}
-		}
-		if (badcount != 0) {
-			tst_resm(TFAIL, "write() FAILED to return proper cnt");
-		} else {
-			tst_resm(TPASS, "write() PASSED");
-		}
-		tst_resm(TINFO, "block 1 passed");
-		close(fild);
 	}
-	cleanup();
-	tst_exit();
-}
-
-/*
- * setup() - performs all ONE TIME setup for this test
- */
-void setup(void)
-{
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	if (badcount != 0)
+		tst_res(TFAIL, "write() failed to return proper count");
+	else
+		tst_res(TPASS, "write() returned proper count");
 
-	umask(0);
-
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -i option.
-	 * You want to make sure you do this before you create your temporary
-	 * directory.
-	 */
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	sprintf(pfiln, "write1.%d", getpid());
+	SAFE_CLOSE(fd);
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at completion or
- * premature exit.
- */
-void cleanup(void)
+static void setup(void)
 {
+	for (iws = 0; iws < BUFSIZ; iws++)
+		pwbuf[iws] = 'A' + (iws % 26);
 
-	unlink(pfiln);
+	pwbuf[BUFSIZ] = '\n';
+}
 
-	tst_rmdir();
+static void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }
+
+static struct tst_test test = {
+	.tid = "write02",
+	.test_all = verify_write,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+};
-- 
1.8.3.1



