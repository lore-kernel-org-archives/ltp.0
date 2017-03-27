From: huangjh <huangjh.jy@cn.fujitsu.com>
Date: Mon, 27 Mar 2017 17:18:42 +0800
Subject: [LTP] [PATCH 1/2] syscalls/write01.c: Cleanup && convert to new API.
Message-ID: <1490606323-17168-1-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: huangjh <huangjh.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/write/write01.c | 158 +++++-------------------------
 1 file changed, 22 insertions(+), 136 deletions(-)

diff --git a/testcases/kernel/syscalls/write/write01.c b/testcases/kernel/syscalls/write/write01.c
index 2ce482f..b53f907 100644
--- a/testcases/kernel/syscalls/write/write01.c
+++ b/testcases/kernel/syscalls/write/write01.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ * Copyright (c) 2017 Fujitsu Ltd.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of version 2 of the GNU General Public License as
@@ -28,153 +29,38 @@
  * For further information regarding this notice, see:
  *
  * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
- *
  */
-/* $Id: write01.c,v 1.6 2009/11/02 13:57:19 subrata_modak Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: write01
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for write(2)
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
- *	1.) write(2) returns...(See Description)
- *
- *    INPUT SPECIFICATIONS
- *	The standard options for system call tests are accepted.
- *	(See the parse_opts(3) man page).
- *
- *    OUTPUT SPECIFICATIONS
- *
- *    DURATION
- *	Terminates - with frequency and infinite modes.
- *
- *    SIGNALS
- *	Uses SIGUSR1 to pause before test if option set.
- *	(See the parse_opts(3) man page).
- *
- *    RESOURCES
- *	None
- *
- *    ENVIRONMENTAL NEEDS
- *      No run-time environmental needs.
- *
- *    SPECIAL PROCEDURAL REQUIREMENTS
- *	None
- *
- *    INTERCASE DEPENDENCIES
- *	None
- *
- *    DETAILED DESCRIPTION
- *	This is a Phase I test for the write(2) system call.  It is intended
- *	to provide a limited exposure of the system call, for now.  It
- *	should/will be extended when full functional tests are written for
- *	write(2).
- *
- *	Setup:
- *	  Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *
- *	Test:
- *	 Loop if the proper options are given.
- *	  Execute system call
- *	  Check return code, if system call failed (return=-1)
- *		Log the errno and Issue a FAIL message.
- *	  Otherwise, Issue a PASS message.
- *
- *	Cleanup:
- *	  Print errno log and/or timing stats if options given
- *
- *    UPDATE HISTORY
- *      user     date  description
- *      ------------------------------------------------------
- *      wermager 3/00  Switched sequence of calls to TEST_PAUSE
- *                     and tst_tmpdir() in setup().$
- *
- *#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#**/
 
-#include <sys/types.h>
-#include <fcntl.h>
 #include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include "test.h"
+#include "tst_test.h"
 
-void setup();
-void cleanup();
+static int fd;
 
-char *TCID = "write01";
-int TST_TOTAL = 1;
-
-char fname[255];
-int fd;
-char buf = 'w';
-
-int main(int ac, char **av)
+static void verify_write(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	TEST(write(fd, "w", 1));
 
-		tst_count = 0;
-
-		TEST(write(fd, &buf, 1));
-
-		if (TEST_RETURN == -1)
-			tst_resm(TFAIL | TTERRNO, "write failed");
-		else
-			tst_resm(TPASS, "write returned %ld", TEST_RETURN);
-
-	}
-
-	cleanup();
-	tst_exit();
+	if (TEST_RETURN == -1)
+		tst_res(TFAIL | TTERRNO, "write(2) failed");
+	else
+		tst_res(TPASS, "write(2) returned %ld", TEST_RETURN);
 }
 
-void setup(void)
+static void setup(void)
 {
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	sprintf(fname, "tfile_%d", getpid());
-	if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "open failed");
+	fd = SAFE_OPEN("testfile", O_RDWR | O_CREAT, 0700);
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
-	if (close(fd) == -1)
-		tst_resm(TWARN | TERRNO, "close failed");
-
-	tst_rmdir();
-
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }
+
+static struct tst_test test = {
+	.tid = "write01",
+	.test_all = verify_write,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+};
-- 
1.8.3.1



