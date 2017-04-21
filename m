From: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
Date: Fri, 21 Apr 2017 18:48:27 +0800
Subject: [LTP] [PATCH 2/2] syscall/write03.c: Cleanup && convert to new API.
In-Reply-To: <1492771707-7554-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1492771707-7554-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <1492771707-7554-2-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/write/write03.c | 177 +++++++-----------------------
 1 file changed, 42 insertions(+), 135 deletions(-)

diff --git a/testcases/kernel/syscalls/write/write03.c b/testcases/kernel/syscalls/write/write03.c
index 63ef35a..4fabd62 100644
--- a/testcases/kernel/syscalls/write/write03.c
+++ b/testcases/kernel/syscalls/write/write03.c
@@ -1,6 +1,8 @@
 /*
- *
  *   Copyright (c) International Business Machines  Corp., 2001
+ *	07/2001 Ported by John George
+ *   Copyright (c) 2017 Fujitsu Ltd.
+ *	04/2017 Modified by Jinhui Huang
  *
  *   This program is free software;  you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -18,9 +20,6 @@
  */
 
 /*
- * NAME
- *	write03.c
- *
  * DESCRIPTION
  *	Testcase to check that write(2) doesn't corrupt a file when it fails
  *
@@ -29,154 +28,62 @@
  *	fail with some erroneous parameter, close the fd. Then reopen the
  *	file in RDONLY mode, and read the contents of the file. Compare the
  *	buffers, to see whether they are same.
- *
- * USAGE:  <for command-line>
- *      write03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
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
- *	NONE
  */
 
-#include <unistd.h>
-#include <string.h>
-#include <fcntl.h>
+#include <stdio.h>
 #include <errno.h>
-#include "test.h"
-#include <sys/mman.h>
-
-char *TCID = "write03";
-int TST_TOTAL = 1;
-
-char *bad_addr = 0;
+#include "tst_test.h"
 
-void setup(void);
-void cleanup(void);
+static char *bad_addr;
+static char wbuf[BUFSIZ], rbuf[BUFSIZ];
+static int fd;
 
-char filename[100];
-
-#if !defined(UCLINUX)
-
-int main(int argc, char **argv)
+static void verify_write(void)
 {
-	int lc;
-
-	char wbuf[BUFSIZ], rbuf[BUFSIZ];
-	int fd;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	/* global setup */
-	setup();
-
-	/* The following loop checks looping state if -i option given */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-//block1:
-		tst_resm(TINFO, "Enter Block 1: test to check if write "
-			 "corrupts the file when write fails");
-
-		fd = creat(filename, 0644);
-		if (fd < 0) {
-			tst_resm(TBROK, "creating a new file failed");
-			cleanup();
-		}
-
-		(void)memset(wbuf, '0', 100);
-
-		if (write(fd, wbuf, 100) == -1) {
-			tst_resm(TFAIL, "failed to write to %s", filename);
-			cleanup();
-		}
-
-		if (write(fd, bad_addr, 100) != -1) {
-			tst_resm(TFAIL, "write(2) failed to fail");
-			cleanup();
-		}
-		close(fd);
-
-		if ((fd = open(filename, O_RDONLY)) == -1) {
-			tst_resm(TBROK, "open(2) failed, errno: %d", errno);
-			cleanup();
-		}
-
-		if (read(fd, rbuf, 100) == -1) {
-			tst_resm(TBROK, "read(2) failed, errno: %d", errno);
-			cleanup();
-		}
-
-		if (memcmp(wbuf, rbuf, 100) == 0) {
-			tst_resm(TPASS, "failure of write(2) didnot corrupt "
-				 "the file");
-		} else {
-			tst_resm(TFAIL, "failure of write(2) corrupted the "
-				 "file");
-		}
-		tst_resm(TINFO, "Exit block 1");
-		close(fd);
-	}
-	cleanup();
-	tst_exit();
-}
+	fd = SAFE_CREAT("testfile", 0644);
 
-#else
+	SAFE_WRITE(1, fd, wbuf, 100);
 
-int main(void)
-{
-	tst_resm(TINFO, "test is not available on uClinux");
-	tst_exit();
-}
-
-#endif /* if !defined(UCLINUX) */
-
-/*
- * setup() - performs all ONE TIME setup for this test
- */
-void setup(void)
-{
+	if (write(fd, bad_addr, 100) != -1) {
+		tst_res(TFAIL, "write() failed to fail");
+		SAFE_CLOSE(fd);
+		return;
+	}
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	SAFE_CLOSE(fd);
 
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -i option.
-	 * You want to make sure you do this before you create your temporary
-	 * directory.
-	 */
-	TEST_PAUSE;
+	fd = SAFE_OPEN("testfile", O_RDONLY);
 
-	/* Create a unique temporary directory and chdir() to it. */
-	tst_tmpdir();
+	memset(rbuf, 0, BUFSIZ);
 
-	sprintf(filename, "./write03.%d", getpid());
+	SAFE_READ(0, fd, rbuf, 100);
 
-	bad_addr = mmap(0, 1, PROT_NONE,
-			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
-	if (bad_addr == MAP_FAILED) {
-		printf("mmap failed\n");
-	}
+	if (memcmp(wbuf, rbuf, 100) == 0)
+		tst_res(TPASS, "failure of write() didnot corrupt the file");
+	else
+		tst_res(TFAIL, "failure of write() corrupted the file");
 
+	SAFE_CLOSE(fd);
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *		completion or premature exit
- */
-void cleanup(void)
+static void setup(void)
 {
+	bad_addr = SAFE_MMAP(0, 1, PROT_NONE,
+			MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
 
-	unlink(filename);
-	tst_rmdir();
+	memset(wbuf, '0', 100);
+}
 
+static void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }
+
+static struct tst_test test = {
+	.tid = "write03",
+	.test_all = verify_write,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+};
-- 
1.8.3.1



