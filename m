From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 26 Jan 2017 14:50:39 +0100
Subject: [LTP] [COMMITTED] [PATCH 3/3] fcntl04: Cleanup && convert to new
	library.
In-Reply-To: <1485438639-1201-1-git-send-email-chrubis@suse.cz>
References: <1485438639-1201-1-git-send-email-chrubis@suse.cz>
Message-ID: <1485438639-1201-3-git-send-email-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/fcntl/fcntl04.c | 161 +++++++-----------------------
 1 file changed, 37 insertions(+), 124 deletions(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl04.c b/testcases/kernel/syscalls/fcntl/fcntl04.c
index ed2c016..f92f8a0 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl04.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl04.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of version 2 of the GNU General Public License as
@@ -30,146 +31,58 @@
  * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
  *
  */
-/* $Id: fcntl04.c,v 1.8 2009/11/02 13:57:16 subrata_modak Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: fcntl04
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for fcntl(2) using F_GETFL argument.
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
- *	1.) fcntl(2) returns...(See Description)
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
- *	This is a Phase I test for the fcntl(2) system call.  It is intended
- *	to provide a limited exposure of the system call, for now.  It
- *	should/will be extended when full functional tests are written for
- *	fcntl(2).
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
- *
- *#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#**/
-
+ /*
+  * Basic test for fcntl(2) using F_GETFL argument.
+  */
 #include <sys/types.h>
+#include <sys/stat.h>
 #include <fcntl.h>
 #include <unistd.h>
-#include <sys/stat.h>
 #include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include "test.h"
+#include <stdio.h>
 
-void setup();
-void cleanup();
+#include "tst_test.h"
 
-char *TCID = "fcntl04";
-int TST_TOTAL = 1;
+static int fd;
+static char fname[255];
 
-char fname[255];
-int fd;
-
-int main(int ac, char **av)
+static void verify_fcntl(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
+	TEST(fcntl(fd, F_GETFL, 0));
 
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		TEST(fcntl(fd, F_GETFL, 0));
+	if (TEST_RETURN == -1) {
+		tst_res(TFAIL | TTERRNO, "fcntl(%s, F_GETFL, 0) failed",
+			fname);
+		return;
+	}
 
-		if (TEST_RETURN == -1)
-			tst_resm(TFAIL | TTERRNO, "fcntl failed");
-		else
-			tst_resm(TPASS, "fcntl returned %ld", TEST_RETURN);
+	if ((TEST_RETURN & O_ACCMODE) != O_RDWR) {
+		tst_res(TFAIL, "fcntl(%s, F_GETFL, 0) returned wrong "
+			"access mode %li, expected %i", fname,
+			TEST_RETURN & O_ACCMODE, O_RDWR);
+		return;
 	}
 
-	cleanup();
-	tst_exit();
+	tst_res(TPASS, "fcntl(%s, F_GETFL, 0) returned %lx",
+		fname, TEST_RETURN);
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
-	sprintf(fname, "tfile_%d", getpid());
-	if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "open failed");
+	sprintf(fname, "fcntl04_%d", getpid());
+	fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0700);
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
-	if (close(fd) == -1)
-		tst_resm(TWARN | TERRNO, "close failed");
-
-	tst_rmdir();
-
+	if (fd > 0 && close(fd))
+		tst_res(TWARN | TERRNO, "close(fd) failed");
 }
+
+static struct tst_test test = {
+	.tid = "fcntl04",
+	.needs_tmpdir = 1,
+	.test_all = verify_fcntl,
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
2.7.3

