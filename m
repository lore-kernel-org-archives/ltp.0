From: Xie Ziyao <xieziyao@huawei.com>
Date: Wed, 28 Apr 2021 17:20:06 +0800
Subject: [LTP] [PATCH v3] syscalls/close: Delete close08 and convert close01
 to the new API
Message-ID: <20210428092006.80460-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1. Cleanup and convert close01 to the new API;
2. Add a testcase for closing a socket fd;
3. Delete close08 since it does not add any more coverage over close01.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
v2->v3:
1. Modify some issues to make the code more straightforward;
2. Add a testcase for closing a socket fd;
3. Delete close08 since it does not add any more coverage over close01.

 testcases/kernel/syscalls/close/close01.c | 137 +++++------------
 testcases/kernel/syscalls/close/close08.c | 177 ----------------------
 2 files changed, 35 insertions(+), 279 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/close/close08.c

diff --git a/testcases/kernel/syscalls/close/close01.c b/testcases/kernel/syscalls/close/close01.c
index c734ff7d2..f2d30a693 100644
--- a/testcases/kernel/syscalls/close/close01.c
+++ b/testcases/kernel/syscalls/close/close01.c
@@ -1,124 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2001
- *  07/2001 Ported by Wayne Boyer
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * 07/2001 Ported by Wayne Boyer
  */

-/*
- * DESCRIPTION
- *	Test that closing a regular file and a pipe works correctly
+/*\
+ * [Description]
+ *
+ * Test that closing a file/pipe/socket works correctly.
  */

 #include <stdio.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <sys/stat.h>
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"

-void cleanup(void);
-void setup(void);
+#define FILENAME "close01_testfile"

-char *TCID = "close01";
-int TST_TOTAL = 2;
-
-char fname[40] = "";
-
-int fild, newfd, pipefildes[2];
-
-struct test_case_t {
-	int *fd;
-	char *type;
-} TC[] = {
-	/* file descriptor for a regular file */
-	{
-	&newfd, "file"},
-	    /* file descriptor for a pipe */
-	{
-	&pipefildes[0], "pipe"}
-};
-
-int main(int ac, char **av)
+static int get_fd_file(void)
 {
-
-	int i;
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		if ((fild = creat(fname, 0777)) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "can't open file %s",
-				 fname);
-
-		if ((newfd = dup(fild)) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "can't dup the file des");
-
-		SAFE_PIPE(cleanup, pipefildes);
-
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			TEST(close(*TC[i].fd));
-
-			if (TEST_RETURN == -1) {
-				tst_resm(TFAIL, "call failed unexpectedly");
-				continue;
-			}
-
-			if (close(*TC[i].fd) == -1) {
-				tst_resm(TPASS, "%s appears closed",
-					 TC[i].type);
-			} else {
-				tst_resm(TFAIL, "%s close succeeded on"
-					 "second attempt", TC[i].type);
-			}
-		}
-
-	}
-
-	cleanup();
-	tst_exit();
+	return SAFE_OPEN(FILENAME, O_RDWR | O_CREAT, 0700);
 }

-void setup(void)
+static int get_fd_pipe(void)
 {
-	int mypid;
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	umask(0);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	mypid = getpid();
-	sprintf(fname, "fname.%d", mypid);
+	int pipefildes[2];
+	SAFE_PIPE(pipefildes);
+	SAFE_CLOSE(pipefildes[1]);
+	return pipefildes[0];
 }

-void cleanup(void)
+static int get_fd_socket(void)
 {
-	close(fild);
+	return SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
+}

-	tst_rmdir();
+struct test_case_t {
+	int (*get_fd) ();
+	char *type;
+} tc[] = {
+	{get_fd_file, "file"},
+	{get_fd_pipe, "pipe"},
+	{get_fd_socket, "socket"}
+};

+static void run(unsigned int i)
+{
+	TST_EXP_PASS(close(tc[i].get_fd()), "close a %s fd", tc[i].type);
 }
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tc),
+	.needs_tmpdir = 1,
+	.test = run,
+};
diff --git a/testcases/kernel/syscalls/close/close08.c b/testcases/kernel/syscalls/close/close08.c
deleted file mode 100644
index ccdefa173..000000000
--- a/testcases/kernel/syscalls/close/close08.c
+++ /dev/null
@@ -1,177 +0,0 @@
-/*
- * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
- *
- */
-/* $Id: close08.c,v 1.6 2009/10/13 14:00:46 subrata_modak Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: close08
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for close(2)
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
- * 	1.) close(2) returns...(See Description)
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
- *	This is a Phase I test for the close(2) system call.  It is intended
- *	to provide a limited exposure of the system call, for now.  It
- *	should/will be extended when full functional tests are written for
- *	close(2).
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
-
-#include <sys/types.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include "test.h"
-#include "safe_macros.h"
-
-void setup();
-void cleanup();
-
-char *TCID = "close08";
-int TST_TOTAL = 1;
-
-char fname[255];
-int fd;
-
-int main(int ac, char **av)
-{
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1) {
-			tst_brkm(TBROK | TTERRNO, cleanup,
-				 "open(%s, O_RDWR|O_CREAT,0700) failed", fname);
-		}
-		TEST(close(fd));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TTERRNO, "close(%s) failed", fname);
-		} else {
-			tst_resm(TPASS, "close(%s) returned %ld", fname,
-				 TEST_RETURN);
-		}
-
-		SAFE_UNLINK(cleanup, fname);
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-void setup(void)
-{
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	sprintf(fname, "tfile_%d", getpid());
-}
-
-void cleanup(void)
-{
-	tst_rmdir();
-
-}
--
2.17.1

