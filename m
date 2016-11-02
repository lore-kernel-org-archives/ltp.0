From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Wed, 2 Nov 2016 15:14:37 +0800
Subject: [LTP] [PATCH v2] syscalls/umask01: Cleanup && Use the new API &&
	Rename
In-Reply-To: <58195279.7030405@cn.fujitsu.com>
References: <58195279.7030405@cn.fujitsu.com>
Message-ID: <1478070877-8453-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cleanup umask03 and convert it to new API, then remove
umask01 and umask02, rename the new umask03 to umask01.

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 runtest/ltplite                           |   2 -
 runtest/stress.part3                      |   2 -
 runtest/syscalls                          |   2 -
 testcases/kernel/syscalls/.gitignore      |   2 -
 testcases/kernel/syscalls/umask/umask01.c | 194 +++++++++---------------------
 testcases/kernel/syscalls/umask/umask02.c | 118 ------------------
 testcases/kernel/syscalls/umask/umask03.c | 155 ------------------------
 7 files changed, 59 insertions(+), 416 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/umask/umask02.c
 delete mode 100644 testcases/kernel/syscalls/umask/umask03.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 338d6eb..4ad77f3 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -972,8 +972,6 @@ truncate03 truncate03
 # ulimit01 ulimit01
 
 umask01 umask01
-umask02 umask02
-umask03 umask03
 
 uname01 uname01
 uname02 uname02
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 8abed95..6b48316 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -849,8 +849,6 @@ truncate03 truncate03
 # ulimit01 ulimit01
 
 umask01 umask01
-umask02 umask02
-umask03 umask03
 
 uname01 uname01
 uname02 uname02
diff --git a/runtest/syscalls b/runtest/syscalls
index 7c84296..1bd6252 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1334,8 +1334,6 @@ truncate03_64 truncate03_64
 ulimit01 ulimit01
 
 umask01 umask01
-umask02 umask02
-umask03 umask03
 
 uname01 uname01
 uname02 uname02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index f53cc05..77d150a 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -1040,8 +1040,6 @@
 /truncate/truncate03_64
 /ulimit/ulimit01
 /umask/umask01
-/umask/umask02
-/umask/umask03
 /umount/umount01
 /umount/umount02
 /umount/umount03
diff --git a/testcases/kernel/syscalls/umask/umask01.c b/testcases/kernel/syscalls/umask/umask01.c
index 9677539..7d9334e 100644
--- a/testcases/kernel/syscalls/umask/umask01.c
+++ b/testcases/kernel/syscalls/umask/umask01.c
@@ -1,153 +1,77 @@
 /*
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
+ * Copyright (c) International Business Machines  Corp., 2001
+ *  07/2001 Ported by John George
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+/*
+ * umask(2) sets the mask from 0000 to 0777 while we create files,
+ * the previous value of the mask should be returned correctly,
+ * and the file mode should be correct for each creation mask.
  */
-/* $Id: umask01.c,v 1.6 2009/11/02 13:57:19 subrata_modak Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: umask01
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for umask(2)
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
- *	1.) umask(2) returns...(See Description)
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
- *	This is a Phase I test for the umask(2) system call.  It is intended
- *	to provide a limited exposure of the system call, for now.  It
- *	should/will be extended when full functional tests are written for
- *	umask(2).
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
 
 #include <errno.h>
-#include <string.h>
-#include <signal.h>
+#include <stdio.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-#include "test.h"
-
-void setup();
-void cleanup();
-
-char *TCID = "umask01";
-int TST_TOTAL = 1;
+#include "tst_test.h"
 
-int main(int ac, char **av)
+static void verify_umask(void)
 {
-	int lc;
+	struct stat statbuf;
+	int mskval;
+	int fd;
+	int failflag = 0;
+	unsigned low9mode;
 
-	tst_parse_opts(ac, av, NULL, NULL);
+	for (mskval = 0000; mskval < 01000; mskval++) {
+		TEST(umask(mskval));
+		if (TEST_RETURN < 0 || TEST_RETURN > 0777) {
+			tst_brk(TFAIL, "umask(%o) result outside range %ld",
+				mskval, TEST_RETURN);
+		}
 
-	setup();
+		if (mskval > 0000 && TEST_RETURN != mskval - 1) {
+			failflag = 1;
+			tst_res(TFAIL, "umask(%o) returned %ld, expected %d",
+				mskval, TEST_RETURN, mskval - 1);
+		}
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		fd = SAFE_CREAT("testfile", 0777);
+		SAFE_CLOSE(fd);
 
-		tst_count = 0;
+		SAFE_STAT("testfile", &statbuf);
 
-		TEST(umask(022));
+		low9mode = statbuf.st_mode & 0777;
 
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "umask(022) Failed, errno=%d : %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-		} else {
-			tst_resm(TPASS, "umask(022) returned %ld",
-				 TEST_RETURN);
+		if (low9mode != (~mskval & 0777)) {
+			failflag = 1;
+			tst_res(TFAIL, "File mode got %o, expected %o",
+				low9mode, ~mskval & 0777);
 		}
+
+		SAFE_UNLINK("testfile");
 	}
-	tst_exit();
-}
 
-void setup(void)
-{
-	TEST_PAUSE;
+	if (!failflag)
+		tst_res(TPASS, "All files' mode created correctly");
 }
+
+static struct tst_test test = {
+	.tid = "umask01",
+	.test_all = verify_umask,
+	.needs_tmpdir = 1,
+};
diff --git a/testcases/kernel/syscalls/umask/umask02.c b/testcases/kernel/syscalls/umask/umask02.c
deleted file mode 100644
index 0ba797c..0000000
--- a/testcases/kernel/syscalls/umask/umask02.c
+++ /dev/null
@@ -1,118 +0,0 @@
-/*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-/*
- * NAME
- *	umask02.c
- *
- * DESCRIPTION
- *	Check that umask changes the mask, and that the previous
- *	value of the mask is returned correctly for each value.
- *
- * ALGORITHM
- *	For each mask value (9 bits) set mask, and check that the return
- *	corresponds to the previous value set.
- *
- * USAGE:  <for command-line>
- *	umask02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-e   : Turn on errno logging.
- *		-i n : Execute test n times.
- *		-I x : Execute test for x seconds.
- *		-P x : Pause for x seconds between iterations.
- *		-t   : Turn on syscall timing.
- *
- * History
- *	07/2001 John George
- *		-Ported
- *
- * Restrictions
- *	None
- */
-
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <stdio.h>
-#include "test.h"
-
-char *TCID = "umask02";
-int TST_TOTAL = 1;
-
-void setup(void);
-void cleanup(void);
-
-int main(int argc, char **argv)
-{
-	int lc;
-
-	int uret = 0, i, mskval = 0000;
-	int failcnt = 0;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	/* Check for looping state if -i option is given */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		for (umask(++mskval), i = 1; mskval < 01000;
-		     uret = umask(++mskval), i++) {
-			if ((uret != mskval - 1) && (mskval != 0000)) {
-				failcnt = 1;
-				tst_resm(TFAIL, "umask(%d) returned bad mask "
-					 "value %d.", mskval, uret);
-			}
-		}
-		if (!failcnt)
-			tst_resm(TPASS, "All umask values return correct "
-				 "values");
-	}
-	cleanup();
-	tst_exit();
-
-}
-
-/*
- * setup()
- *	performs all ONE TIME setup for this test
- */
-void setup(void)
-{
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -c option.
-	 */
-	TEST_PAUSE;
-}
-
-/*
- * cleanup()
- *	performs all ONE TIME cleanup for this test at
- *	completion or premature exit
- */
-void cleanup(void)
-{
-
-}
diff --git a/testcases/kernel/syscalls/umask/umask03.c b/testcases/kernel/syscalls/umask/umask03.c
deleted file mode 100644
index e10009c..0000000
--- a/testcases/kernel/syscalls/umask/umask03.c
+++ /dev/null
@@ -1,155 +0,0 @@
-/*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-/*
- * NAME
- *	umask03.c
- *
- * DESCRIPTION
- *	Check that umask changes the mask, and that the previous
- *	value of the mask is returned correctly for each value.
- *
- * ALGORITHM
- *	For each mask value (9 bits) set mask, and check that the return
- *	corresponds to the previous value set.
- *
- * USAGE:  <for command-line>
- *		umask03 [-c n] [-i n] [-I x] [-P x] [-t]
- *		where,  -c n : Run n copies concurrently.
- *			-i n : Execute test n times.
- *			-I x : Execute test for x seconds.
- *			-P x : Pause for x seconds between iterations.
- *			-t   : Turn on syscall timing.
- *
- * History
- *	07/2001 John George
- *		-Ported
- *
- * Restrictions
- *	None
- */
-
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <stdio.h>
-#include "test.h"
-#include <sys/types.h>
-#include <sys/stat.h>
-
-char *TCID = "umask03";
-int TST_TOTAL = 1;
-
-char filname[40];
-
-void setup(void);
-void cleanup(void);
-
-int main(int argc, char **argv)
-{
-	int lc;
-
-	struct stat statbuf;
-	int mskval = 0000;
-	int failcnt = 0;
-	int fildes, i;
-	unsigned low9mode;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();		/* global setup */
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		for (umask(mskval = 0077), i = 1; mskval < 01000;
-		     i++, umask(++mskval)) {
-			unlink(filname);
-			if ((fildes = creat(filname, 0777)) == -1) {
-				tst_resm(TBROK, "cannot create "
-					 "file with mskval 0%o %d",
-					 mskval, mskval);
-			} else {
-				if (fstat(fildes, &statbuf) != 0) {
-					tst_resm(TBROK, "cannot fstat file");
-				} else {
-					low9mode = statbuf.st_mode & 0777;
-					if (low9mode != (~mskval & 0777)) {
-						tst_resm(TFAIL,
-							 "got %o expected %o"
-							 "mask didnot take",
-							 low9mode,
-							 (~mskval & 0777));
-					}
-				}
-			}
-			close(fildes);
-		}
-		if (!failcnt)
-			tst_resm(TPASS, "umask correctly returns the "
-				 "previous value for all masks");
-	}
-	cleanup();
-	tst_exit();
-
-}
-
-/*
- * setup
- *	performs all ONE TIME setup for this test
- */
-void setup(void)
-{
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -i option.
-	 * You want to make sure you do this before you create your temporary
-	 * directory.
-	 */
-	TEST_PAUSE;
-
-	/* make temp dir and cd to it */
-	tst_tmpdir();
-
-	sprintf(filname, "umask2.%d", getpid());
-}
-
-/*
- * cleanup
- *	performs all ONE TIME cleanup for this test@completion or
- *	premature exit
- */
-void cleanup(void)
-{
-
-	/*
-	 * cleanup the temporary files and the temporary directory
-	 */
-	unlink(filname);
-	tst_rmdir();
-
-	/*
-	 * exit with return code appropriate for results
-	 */
-
-}
-- 
1.8.4.2



