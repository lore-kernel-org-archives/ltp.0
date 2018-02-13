From: yang xu <xuyang.jy@cn.fujitsu.com>
Date: Wed, 14 Feb 2018 00:01:34 +0800
Subject: [LTP] [PATCH 1/3] syscalls/rmdir01,
	04: Cleanup && Convert to new API
Message-ID: <1518537696-22033-1-git-send-email-xuyang.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) Take use of some safe macros
2) Remove duplicated rmdir04

Signed-off-by: yang xu <xuyang.jy@cn.fujitsu.com>
---
 runtest/ltplite                           |    1 -
 runtest/quickhit                          |    2 -
 runtest/stress.part3                      |    1 -
 runtest/syscalls                          |    1 -
 testcases/kernel/syscalls/.gitignore      |    1 -
 testcases/kernel/syscalls/rmdir/rmdir01.c |  170 +++++--------------------
 testcases/kernel/syscalls/rmdir/rmdir04.c |  198 -----------------------------
 7 files changed, 30 insertions(+), 344 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/rmdir/rmdir04.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 49d2b11..f664edc 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -666,7 +666,6 @@ rmdir01 rmdir01
 rmdir02 rmdir02
 rmdir03 rmdir03
 rmdir03A symlink01 -T rmdir03
-rmdir04 rmdir04
 rmdir05 rmdir05
 
 sbrk01 sbrk01
diff --git a/runtest/quickhit b/runtest/quickhit
index 2a42769..56dcc65 100644
--- a/runtest/quickhit
+++ b/runtest/quickhit
@@ -199,8 +199,6 @@ readlink02 readlink02
 # Basic test for readlink(2)
 rename02 rename02
 # Basic test for rename(2)
-rmdir04 rmdir04
-# Basic test for rmdir(2)
 rmdir05 rmdir05
 # rmdir(2) test for errno(s) EINVAL, EMLINK, EFAULT
 sbrk01 sbrk01
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 004bbad..eaa97cd 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -565,7 +565,6 @@ rmdir01 rmdir01
 rmdir02 rmdir02
 rmdir03 rmdir03
 rmdir03A symlink01 -T rmdir03
-rmdir04 rmdir04
 rmdir05 rmdir05
 
 sbrk01 sbrk01
diff --git a/runtest/syscalls b/runtest/syscalls
index ca84c10..bc8cf2d 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -943,7 +943,6 @@ rmdir01 rmdir01
 rmdir02 rmdir02
 rmdir03 rmdir03
 rmdir03A symlink01 -T rmdir03
-rmdir04 rmdir04
 rmdir05 rmdir05
 
 rt_sigaction01 rt_sigaction01
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 684f5e7..04b5c5f 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -781,7 +781,6 @@
 /rmdir/rmdir01
 /rmdir/rmdir02
 /rmdir/rmdir03
-/rmdir/rmdir04
 /rmdir/rmdir05
 /rt_sigaction/rt_sigaction01
 /rt_sigaction/rt_sigaction02
diff --git a/testcases/kernel/syscalls/rmdir/rmdir01.c b/testcases/kernel/syscalls/rmdir/rmdir01.c
index 370e607..9f911ec 100644
--- a/testcases/kernel/syscalls/rmdir/rmdir01.c
+++ b/testcases/kernel/syscalls/rmdir/rmdir01.c
@@ -1,162 +1,52 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
  *
- *   Copyright (c) International Business Machines  Corp., 2001
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
-/*
- * NAME
- *	rmdir01
- *
- * DESCRIPTION
- *	This test will verify that rmdir(2) syscall basic functionality.
- *	verify rmdir(2) returns a value of 0 and the directory being
- *	removed
- *
- * ALGORITHM
- *	Setup:
- *		Setup signal handling.
- *		Create temporary directory.
- *		Pause for SIGUSR1 if option specified.
- *
- *	Test:
- *		Loop if the proper options are given.
- *                 make a directory tstdir
- *                 call rmdir(tstdir), check the return value
- *                 verify the directory tstdir does not exists.
- *
- *	Cleanup:
- *		Print errno log and/or timing stats if options given
- *		Delete the temporary directory created.*
- * USAGE
- *	rmdir01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-f   : Turn off functionality Testing.
- *		-i n : Execute test n times.
- *		-I x : Execute test for x seconds.
- *		-P x : Pause for x seconds between iterations.
- *		-t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- *	None.
+/* DESCRIPTION
+ *   This test will verify that rmdir(2) syscall basic functionality.
+ *   verify rmdir(2) returns a value of 0 and the directory being removed.
  */
 #include <errno.h>
-#include <string.h>
 #include <sys/stat.h>
 #include <sys/types.h>
-#include <fcntl.h>
 #include <unistd.h>
-#include "test.h"
-#include "safe_macros.h"
-
-void setup();
-void cleanup();
+#include "tst_test.h"
 
-#define PERMS		0777
+#define TESTDIR "testdir"
 
-char *TCID = "rmdir01";
-int TST_TOTAL = 1;
-
-char tstdir[100];
-
-int main(int ac, char **av)
+static void verify_rmdir(void)
 {
-	int lc;
 	struct stat buf;
 
-	/*
-	 * parse standard options
-	 */
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	/*
-	 * perform global setup for test
-	 */
-	setup();
-
-	/*
-	 * check looping state if -i option given
-	 */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/*
-		 * TEST rmdir() base functionality
-		 */
-
-		/* Initialize the test directory name */
-
-		/* create a directory */
-		SAFE_MKDIR(cleanup, tstdir, PERMS);
-		/* call rmdir using TEST macro */
+	SAFE_MKDIR(TESTDIR, 0777);
 
-		TEST(rmdir(tstdir));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "rmdir(%s) Failed", tstdir);
-			continue;
-		}
-
-		if (stat(tstdir, &buf) != -1) {
-			tst_resm(TFAIL, "directory %s still exists",
-				 tstdir);
-			continue;
-		} else {
-			tst_resm(TPASS, "directory has been removed");
-		}
+	TEST(rmdir(TESTDIR));
+	if (TEST_RETURN == -1) {
+		tst_res(TFAIL | TTERRNO, "rmdir(%s) failed", TESTDIR);
+		return;
 	}
 
-	cleanup();
-	tst_exit();
+	if (!stat(TESTDIR, &buf))
+		tst_res(TFAIL, "rmdir(%s) failed", TESTDIR);
+	else
+		tst_res(TPASS, "rmdir(%s) success", TESTDIR);
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
-{
+static struct tst_test test = {
+	.test_all = verify_rmdir,
+	.needs_tmpdir = 1,
+};
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	/* Create a temporary directory and make it current. */
-	tst_tmpdir();
-
-	sprintf(tstdir, "./tstdir_%d", getpid());
-}
-
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *              completion or premature exit.
- */
-void cleanup(void)
-{
-
-	/*
-	 * Remove the temporary directory.
-	 */
-	tst_rmdir();
-
-	/*
-	 * Exit with return code appropriate for results.
-	 */
-
-}
diff --git a/testcases/kernel/syscalls/rmdir/rmdir04.c b/testcases/kernel/syscalls/rmdir/rmdir04.c
deleted file mode 100644
index fe5e320..0000000
--- a/testcases/kernel/syscalls/rmdir/rmdir04.c
+++ /dev/null
@@ -1,198 +0,0 @@
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
-/* $Id: rmdir04.c,v 1.6 2009/11/02 13:57:18 subrata_modak Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: rmdir04
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for rmdir(2)
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
- *	1.) rmdir(2) returns...(See Description)
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
- *	This is a Phase I test for the rmdir(2) system call.  It is intended
- *	to provide a limited exposure of the system call, for now.  It
- *	should/will be extended when full functional tests are written for
- *	rmdir(2).
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
-#include <sys/stat.h>
-#include <sys/types.h>
-#include <fcntl.h>
-#include <unistd.h>
-
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include "test.h"
-#include "safe_macros.h"
-
-void setup();
-void cleanup();
-
-char *TCID = "rmdir04";
-int TST_TOTAL = 1;
-
-char *cwd;
-char fname[255];
-
-int main(int ac, char **av)
-{
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
-		SAFE_MKDIR(cleanup, fname, 0777);
-		/*
-		 * Call rmdir(2)
-		 */
-		TEST(rmdir(fname));
-
-		/* check return code */
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "rmdir(%s) Failed, errno=%d : %s",
-				 fname, TEST_ERRNO, strerror(TEST_ERRNO));
-		} else {
-			tst_resm(TPASS, "rmdir(%s) returned %ld", fname,
-				 TEST_RETURN);
-		}
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-/***************************************************************
- * setup() - performs all ONE TIME setup for this test.
- ***************************************************************/
-void setup(void)
-{
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	sprintf(fname, "./dir_%d", getpid());
-
-}
-
-/***************************************************************
- * cleanup() - performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- ***************************************************************/
-void cleanup(void)
-{
-
-	tst_rmdir();
-
-}
-- 
1.7.1



