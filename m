From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 14 Feb 2018 14:19:57 +0800
Subject: [LTP] [PATCH v3 2/4] syscalls/unlink05,
	06: Cleanup && Convert to new API
In-Reply-To: <1518589199-14314-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20180213134232.GA5518@rei>
 <1518589199-14314-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1518589199-14314-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) Take use of some safe macros
2) Merge unlink06 into unlink05

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/ltplite                             |   1 -
 runtest/quickhit                            |   2 -
 runtest/stress.part3                        |   1 -
 runtest/syscalls                            |   1 -
 testcases/kernel/syscalls/.gitignore        |   1 -
 testcases/kernel/syscalls/unlink/unlink05.c | 253 +++++++---------------------
 testcases/kernel/syscalls/unlink/unlink06.c | 215 -----------------------
 7 files changed, 62 insertions(+), 412 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/unlink/unlink06.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 49d2b11..21d31ad 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -964,7 +964,6 @@ uname03 uname03
 
 unlink01 symlink01 -T unlink01
 unlink05 unlink05
-unlink06 unlink06
 unlink07 unlink07
 unlink08 unlink08
 
diff --git a/runtest/quickhit b/runtest/quickhit
index 2a42769..8264b22 100644
--- a/runtest/quickhit
+++ b/runtest/quickhit
@@ -255,8 +255,6 @@ uname01 uname01
 # Basic test for uname(2)
 unlink05 unlink05
 # Basic test for unlink(2)
-unlink06 unlink06
-# unlink(2) of a FIFO
 unlink07 unlink07
 # unlink(2) negative testcases
 unlink08 unlink08
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 004bbad..261c5f9 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -840,7 +840,6 @@ uname03 uname03
 
 unlink01 symlink01 -T unlink01
 unlink05 unlink05
-unlink06 unlink06
 unlink07 unlink07
 unlink08 unlink08
 
diff --git a/runtest/syscalls b/runtest/syscalls
index ca84c10..7c3cd5b 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1383,7 +1383,6 @@ cve-2012-0957 cve-2012-0957
 
 unlink01 symlink01 -T unlink01
 unlink05 unlink05
-unlink06 unlink06
 unlink07 unlink07
 unlink08 unlink08
 
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 684f5e7..e67d726 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -1082,7 +1082,6 @@
 /uname/uname02
 /uname/uname03
 /unlink/unlink05
-/unlink/unlink06
 /unlink/unlink07
 /unlink/unlink08
 /unlinkat/unlinkat01
diff --git a/testcases/kernel/syscalls/unlink/unlink05.c b/testcases/kernel/syscalls/unlink/unlink05.c
index aa49316..5305e94 100644
--- a/testcases/kernel/syscalls/unlink/unlink05.c
+++ b/testcases/kernel/syscalls/unlink/unlink05.c
@@ -1,209 +1,80 @@
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
  *
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
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
-/* $Id: unlink05.c,v 1.6 2009/11/02 13:57:19 subrata_modak Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: unlink05
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for unlink(2)
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
- * 	1.) unlink(2) returns...(See Description)
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
- *	This is a Phase I test for the unlink(2) system call.  It is intended
- *	to provide a limited exposure of the system call, for now.  It
- *	should/will be extended when full functional tests are written for
- *	unlink(2).
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
-
-void setup();
-void cleanup();
-void create_file();
 
-char *TCID = "unlink05";
-int TST_TOTAL = 1;
-
-char fname[255];
-int fd;
+/*
+ * Description:
+ * The testcase checks the basic functionality of the unlink(2).
+ * 1) unlink() can delete regular file successfully.
+ * 2) unlink() can delete fifo file successfully.
+ */
 
-int main(int ac, char **av)
+#include <errno.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <stdio.h>
+#include "tst_test.h"
+
+static void file_create(char *);
+static void fifo_create(char *);
+
+static struct test_case_t {
+	void (*setupfunc)(char *);
+	char *desc;
+} tcases[] = {
+	{file_create, "file"},
+	{fifo_create, "fifo"},
+};
+
+static void file_create(char *name)
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
-		/*
-		 *  Call unlink(2)
-		 */
-		TEST(unlink(fname));
-
-		/* check return code */
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "unlink(%s) Failed, errno=%d : %s",
-				 fname, TEST_ERRNO, strerror(TEST_ERRNO));
-		} else {
-			tst_resm(TPASS, "unlink(%s) returned %ld",
-				 fname, TEST_RETURN);
-			/* recreate file for next loop */
-			create_file();
-		}
-	}
-
-	cleanup();
-	tst_exit();
+	sprintf(name, "tfile_%d", getpid());
+	SAFE_TOUCH(name, 0777, NULL);
 }
 
-/***************************************************************
- * setup() - performs all ONE TIME setup for this test.
- ***************************************************************/
-void setup(void)
+static void fifo_create(char *name)
 {
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	create_file();
+	sprintf(name, "tfifo_%d", getpid());
+	SAFE_MKFIFO(name, 0777);
 }
 
-/***************************************************************
- * cleanup() - performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- ***************************************************************/
-void cleanup(void)
+static void verify_unlink(unsigned int n)
 {
+	char fname[255];
+	struct test_case_t *tc = &tcases[n];
 
-	tst_rmdir();
-
-}
+	tc->setupfunc(fname);
 
-void create_file(void)
-{
-	sprintf(fname, "tfile_%d", getpid());
-	if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "open(%s, O_RDWR|O_CREAT,0700) Failed, errno=%d : %s",
-			 fname, errno, strerror(errno));
+	TEST(unlink(fname));
+	if (TEST_RETURN == -1) {
+		tst_res(TFAIL | TTERRNO, "unlink(%s) failed", tc->desc);
+		return;
 	}
-	if (close(fd) == -1) {
-		tst_resm(TWARN, "close(%s) Failed, errno=%d : %s",
-			 fname, errno, strerror(errno));
+
+	if (!access(fname, F_OK)) {
+		tst_res(TFAIL, "unlink(%s) succeeded, but %s still existed",
+			tc->desc, tc->desc);
+		return;
 	}
+
+	tst_res(TPASS, "unlink(%s) succeeded", tc->desc);
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_unlink,
+};
diff --git a/testcases/kernel/syscalls/unlink/unlink06.c b/testcases/kernel/syscalls/unlink/unlink06.c
deleted file mode 100644
index 0e38480..0000000
--- a/testcases/kernel/syscalls/unlink/unlink06.c
+++ /dev/null
@@ -1,215 +0,0 @@
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
-/* $Id: unlink06.c,v 1.5 2009/11/02 13:57:19 subrata_modak Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: unlink06
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: unlink(2) of a FIFO
- *
- *    PARENT DOCUMENT	: usctpl01
- *
- *    TEST CASE TOTAL	: 1
- *
- *    WALL CLOCK TIME	: 1
- *
- *    CPU TYPES		: ALL
- *
- *    AUTHOR		: Richard Logan
- *
- *    CO-PILOT		: William Roske
- *
- *    DATE STARTED	: 03/30/94
- *
- *    INITIAL RELEASE	: UNICOS 7.0
- *
- *    TEST CASES
- *
- * 	1.) unlink(2) returns...(See Description)
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
- *	This is a Phase I test for the unlink(2) system call.  It is intended
- *	to provide a limited exposure of the system call, for now.  It
- *	should/will be extended when full functional tests are written for
- *	unlink(2).
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
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include <unistd.h>
-#include "test.h"
-#include "safe_macros.h"
-
-void setup();
-void create_file();
-void cleanup();
-
-char *TCID = "unlink06";
-int TST_TOTAL = 1;
-
-char Fname[255];
-
-/***********************************************************************
- * Main
- ***********************************************************************/
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
-		create_file();
-
-		/*
-		 *  Call unlink(2)
-		 */
-		TEST(unlink(Fname));
-
-		/* check return code */
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "unlink(%s) Failed, errno=%d : %s",
-				 Fname, TEST_ERRNO, strerror(TEST_ERRNO));
-		} else {
-			if (access(Fname, F_OK) != -1) {
-				tst_resm(TFAIL,
-					 "unlink(%s) returned %ld, but access says file still exists.",
-					 Fname, TEST_RETURN);
-			} else {
-				tst_resm(TPASS, "unlink(%s) returned %ld",
-					 Fname, TEST_RETURN);
-			}
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
-	sprintf(Fname, "fifo_unlink%d", getpid());
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
-
-/******************************************************************
- *
- ******************************************************************/
-void create_file(void)
-{
-	SAFE_MKFIFO(cleanup, Fname, 0777);
-}
-- 
1.8.3.1



