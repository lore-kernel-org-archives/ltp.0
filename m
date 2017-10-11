From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 Oct 2017 16:41:27 +0200
Subject: [LTP] [PATCH v3 13/16] syscalls/fsync01: Convert to the new library.
In-Reply-To: <20171011144130.29728-1-chrubis@suse.cz>
References: <20171011144130.29728-1-chrubis@suse.cz>
Message-ID: <20171011144130.29728-13-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/fsync/fsync01.c | 157 +++++-------------------------
 1 file changed, 27 insertions(+), 130 deletions(-)

diff --git a/testcases/kernel/syscalls/fsync/fsync01.c b/testcases/kernel/syscalls/fsync/fsync01.c
index d7cc4f0a4..af35902bd 100644
--- a/testcases/kernel/syscalls/fsync/fsync01.c
+++ b/testcases/kernel/syscalls/fsync/fsync01.c
@@ -1,5 +1,7 @@
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ *    AUTHOR		: William Roske
+ *    CO-PILOT		: Dave Fenner
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of version 2 of the GNU General Public License as
@@ -30,149 +32,44 @@
  * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
  *
  */
-/* $Id: fsync01.c,v 1.6 2009/10/26 14:55:47 subrata_modak Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: fsync01
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for fsync(2)
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
- * 	1.) fsync(2) returns...(See Description)
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
- *	This is a Phase I test for the fsync(2) system call.  It is intended
- *	to provide a limited exposure of the system call, for now.  It
- *	should/will be extended when full functional tests are written for
- *	fsync(2).
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
-#include <sys/statfs.h>
+#include <unistd.h>
 #include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include "test.h"
-
-void setup();
-void cleanup();
+#include <stdio.h>
 
-char *TCID = "fsync01";
-int TST_TOTAL = 1;
+#include "tst_test.h"
 
-char fname[255];
-int fd;
-char *buf = "davef";
+static char fname[255];
+static int fd;
+#define BUF "davef"
 
-int main(int ac, char **av)
+static void verify_fsync(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
+	SAFE_WRITE(1, fd, BUF, sizeof(BUF));
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	TEST(fsync(fd));
 
-		tst_count = 0;
-
-		if (write(fd, buf, strlen(buf)) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "write failed");
-		TEST(fsync(fd));
-
-		if (TEST_RETURN == -1)
-			tst_resm(TFAIL | TTERRNO, "fsync failed");
-		else
-			tst_resm(TPASS, "fsync returned %ld", TEST_RETURN);
-
-	}
-
-	cleanup();
-	tst_exit();
+	if (TEST_RETURN == -1)
+		tst_res(TFAIL | TTERRNO, "fsync failed");
+	else
+		tst_res(TPASS, "fsync() returned %ld", TEST_RETURN);
 }
 
-void setup(void)
+static void setup(void)
 {
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
 	sprintf(fname, "tfile_%d", getpid());
-	if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "open failed");
+	fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0700);
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
-	if (close(fd) == -1)
-		tst_resm(TWARN, "close failed");
-
-	tst_rmdir();
-
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }
+
+static struct tst_test test = {
+	.cleanup = cleanup,
+	.setup = setup,
+	.test_all = verify_fsync,
+	.needs_tmpdir = 1,
+};
-- 
2.13.5

