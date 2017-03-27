From: huangjh <huangjh.jy@cn.fujitsu.com>
Date: Mon, 27 Mar 2017 17:18:43 +0800
Subject: [LTP] [PATCH 2/2] syscalls/read01.c: Cleanup && convert to new API.
In-Reply-To: <1490606323-17168-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1490606323-17168-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <1490606323-17168-2-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: huangjh <huangjh.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/read/read01.c | 226 +++++---------------------------
 1 file changed, 32 insertions(+), 194 deletions(-)

diff --git a/testcases/kernel/syscalls/read/read01.c b/testcases/kernel/syscalls/read/read01.c
index 9abfdb8..61770a5 100644
--- a/testcases/kernel/syscalls/read/read01.c
+++ b/testcases/kernel/syscalls/read/read01.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ * Copyright (c) 2017 Fujitsu Ltd.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of version 2 of the GNU General Public License as
@@ -28,217 +29,54 @@
  * For further information regarding this notice, see:
  *
  * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
- *
  */
-/* $Id: read01.c,v 1.8 2009/11/02 13:57:17 subrata_modak Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: read01
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for read(2)
- *
- *    PARENT DOCUMENT	: usctpl01
- *
- *    TEST CASE TOTAL	: 1
- *
- *    WALL CLOCK TIME	: 1
- *
- *    CPU TYPES		: ALL
- *
- *    AUTHOR		: William Roske
- *
- *    CO-PILOT		: Dave Fenner
- *
- *    DATE STARTED	: 03/30/92
- *
- *    INITIAL RELEASE	: UNICOS 7.0
- *
- *    TEST CASES
- *
- * 	1.) read(2) returns...(See Description)
- *
- *    INPUT SPECIFICATIONS
- * 	The standard options for system call tests are accepted.
- *	(See the parse_opts(3) man page).
- *
- *    OUTPUT SPECIFICATIONS
- *$
- *    DURATION
- * 	Terminates - with frequency and infinite modes.
- *
- *    SIGNALS
- * 	Uses SIGUSR1 to pause before test if option set.
- * 	(See the parse_opts(3) man page).
- *
- *    RESOURCES
- * 	None
- *
- *    ENVIRONMENTAL NEEDS
- *      No run-time environmental needs.
- *
- *    SPECIAL PROCEDURAL REQUIREMENTS
- * 	None
- *
- *    INTERCASE DEPENDENCIES
- * 	None
- *
- *    DETAILED DESCRIPTION
- *	This is a Phase I test for the read(2) system call.  It is intended
- *	to provide a limited exposure of the system call, for now.  It
- *	should/will be extended when full functional tests are written for
- *	read(2).
- *
- * 	Setup:
- * 	  Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *
- * 	Test:
- *	 Loop if the proper options are given.
- * 	  Execute system call
- *	  Check return code, if system call failed (return=-1)
- *		Log the errno and Issue a FAIL message.
- *	  Otherwise, Issue a PASS message.
- *
- * 	Cleanup:
- * 	  Print errno log and/or timing stats if options given
- *
- *
- *#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#**/
 
-#include <sys/types.h>
-#include <fcntl.h>
-#include <sys/param.h>
 #include <errno.h>
-#include <signal.h>
-#include <string.h>
-#include "test.h"
+#include "tst_test.h"
 
-/*
- * Set READ_BLOCK_SIZE to the block size of the system.
- */
-#ifdef DEV_BSIZE
-#define READ_BLOCK_SIZE DEV_BSIZE
-#else
-#warning DEV_BSIZE is not defined, defaulting to 512
-#define READ_BLOCK_SIZE 512
-#endif
+#define SIZE 512
 
-void setup();
-void cleanup();
+static int fd;
+static char buf[SIZE];
 
-char *TCID = "read01";
-int TST_TOTAL = 1;
-
-char fname[255];
-int fd, i;
-int offset = 0;
-char *s;
-
-int main(int ac, char **av)
+static void verify_read(void)
 {
-	int lc;
-
-    /***************************************************************
-     * parse standard options
-     ***************************************************************/
-	tst_parse_opts(ac, av, NULL, NULL);
-
-    /***************************************************************
-     * perform global setup for test
-     ***************************************************************/
-	setup();
-
-    /***************************************************************
-     * check looping state if -c option given
-     ***************************************************************/
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		if (write(fd, s, READ_BLOCK_SIZE) == -1) {
-			tst_brkm(TBROK, cleanup,
-				 "write(%s, %s, %d) Failed, errno=%d : %s",
-				 fname, s, READ_BLOCK_SIZE, errno,
-				 strerror(errno));
-		}
-		offset += READ_BLOCK_SIZE;
-		if (lseek(fd, (long)(offset - READ_BLOCK_SIZE), 0) == -1) {
-			tst_brkm(TBROK, cleanup,
-				 "lseek(%s, %ld, 0) Failed, errno=%d : %s",
-				 fname, (long)(offset - READ_BLOCK_SIZE), errno,
-				 strerror(errno));
-		}
-		/*
-		 * Call read(2)
-		 */
-		TEST(read(fd, s, READ_BLOCK_SIZE));
+	SAFE_LSEEK(fd, 0, SEEK_SET);
 
-		/* check return code */
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL,
-				 "read(fd, s, READ_BLOCK_SIZE) Failed, errno=%d : %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-		} else {
-			tst_resm(TPASS, "read(pfds) returned %ld",
-				 TEST_RETURN);
-		}
-
-	}
+	TEST(read(fd, buf, SIZE));
 
-	cleanup();
-	tst_exit();
+	if (TEST_RETURN == -1)
+		tst_res(TFAIL | TTERRNO, "read(2) failed");
+	else
+		tst_res(TPASS, "read(2) returned %ld", TEST_RETURN);
 }
 
-/***************************************************************
- * setup() - performs all ONE TIME setup for this test.
- ***************************************************************/
-void setup(void)
+static void setup(void)
 {
+	int i;
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	if ((s = malloc(READ_BLOCK_SIZE)) == NULL) {
-		tst_brkm(TBROK, cleanup,
-			 "malloc(%d) Failed, errno=%d : %s",
-			 READ_BLOCK_SIZE, errno, strerror(errno));
-	}
-	(void)memset(s, '*', READ_BLOCK_SIZE);
-	for (i = 0; i < READ_BLOCK_SIZE; i++) {
-		if (s[i] != '*') {
-			tst_brkm(TBROK, cleanup,
-				 "File Data pattern not setup correctly : expected * at s[%d] : found %c",
-				 i, s[i]);
+	memset(buf, '*', SIZE);
+	for (i = 0; i < SIZE; i++) {
+		if (buf[i] != '*') {
+			tst_brk(TBROK, "buf setup failed: "
+				"expected *@buf[%d], found %c", i, buf[i]);
 		}
 	}
-	sprintf(fname, "./tfile_%d", getpid());
-	if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "open(%s, O_RDWR|O_CREAT,0700) Failed, errno=%d : %s",
-			 fname, errno, strerror(errno));
-	}
 
+	fd = SAFE_OPEN("testfile", O_RDWR | O_CREAT, 0700);
+	SAFE_WRITE(1, fd, buf, SIZE);
 }
 
-/***************************************************************
- * cleanup() - performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- ***************************************************************/
-void cleanup(void)
+static void cleanup(void)
 {
-
-	if (close(fd) == -1) {
-		tst_resm(TWARN, "close(%s) Failed, errno=%d : %s",
-			 fname, errno, strerror(errno));
-	}
-
-	tst_rmdir();
-
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }
+
+static struct tst_test test = {
+	.tid = "read01",
+	.test_all = verify_read,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+};
-- 
1.8.3.1



