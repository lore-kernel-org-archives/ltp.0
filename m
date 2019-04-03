From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 3 Apr 2019 16:29:39 +0800
Subject: [LTP] [PATCH 1/2] syscalls/stat01, 02,
	05: Cleanup && Convert to new API
Message-ID: <1554280180-4089-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) Take use of some safe macros
2) Remove duplicate tests stat01,stat05

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 runtest/quickhit                          |   2 -
 runtest/syscalls                          |   4 -
 testcases/kernel/syscalls/stat/.gitignore |   4 -
 testcases/kernel/syscalls/stat/stat01.c   | 152 -------------
 testcases/kernel/syscalls/stat/stat02.c   | 252 ++++++----------------
 testcases/kernel/syscalls/stat/stat05.c   | 194 -----------------
 6 files changed, 65 insertions(+), 543 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/stat/stat01.c
 delete mode 100644 testcases/kernel/syscalls/stat/stat05.c

diff --git a/runtest/quickhit b/runtest/quickhit
index 74482fd46..31c571eaa 100644
--- a/runtest/quickhit
+++ b/runtest/quickhit
@@ -223,8 +223,6 @@ signal03 signal03
 # and signal sending.
 sigrelse01 sigrelse01
 # Releasing held signals
-stat05 stat05
-# Basic test for stat(2)
 stat06 stat06
 # Negative tests for stat(2)
 statfs01 statfs01
diff --git a/runtest/syscalls b/runtest/syscalls
index cf8189ebd..22fb2462c 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1317,16 +1317,12 @@ tee02 tee02
 
 ssetmask01 ssetmask01
 
-stat01 stat01
-stat01_64 stat01_64
 stat02 stat02
 stat02_64 stat02_64
 stat03 stat03
 stat03_64 stat03_64
 stat04 symlink01 -T stat04
 stat04_64 symlink01 -T stat04_64
-stat05 stat05
-stat05_64 stat05_64
 stat06 stat06
 stat06_64 stat06_64
 
diff --git a/testcases/kernel/syscalls/stat/.gitignore b/testcases/kernel/syscalls/stat/.gitignore
index cb3df91fd..c0bd39d7b 100644
--- a/testcases/kernel/syscalls/stat/.gitignore
+++ b/testcases/kernel/syscalls/stat/.gitignore
@@ -1,10 +1,6 @@
-/stat01
-/stat01_64
 /stat02
 /stat02_64
 /stat03
 /stat03_64
-/stat05
-/stat05_64
 /stat06
 /stat06_64
diff --git a/testcases/kernel/syscalls/stat/stat01.c b/testcases/kernel/syscalls/stat/stat01.c
deleted file mode 100644
index e041311f5..000000000
--- a/testcases/kernel/syscalls/stat/stat01.c
+++ /dev/null
@@ -1,152 +0,0 @@
-/*
- * Copyright (c) International Business Machines  Corp., 2001
- *  07/2001 John George
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
- */
-/*
- *  Verify that, stat(2) succeeds to get the status of a file and fills the
- *  stat structure elements.
- */
-#include <stdio.h>
-#include <sys/types.h>
-#include <fcntl.h>
-#include <sys/stat.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include <pwd.h>
-
-#include "test.h"
-#include "safe_macros.h"
-
-#define FILE_MODE	0644
-#define TESTFILE	"testfile"
-#define FILE_SIZE       1024
-#define BUF_SIZE	256
-#define MASK		0777
-
-char *TCID = "stat01";
-int TST_TOTAL = 1;
-
-static uid_t user_id;
-static gid_t group_id;
-
-static void setup(void);
-static void cleanup(void);
-
-static void verify(void)
-{
-	struct stat stat_buf;
-	int fail = 0;
-
-	TEST(stat(TESTFILE, &stat_buf));
-
-	if (TEST_RETURN == -1) {
-		tst_resm(TFAIL | TTERRNO, "fstat(%s) failed", TESTFILE);
-		return;
-	}
-
-	if (stat_buf.st_uid != user_id) {
-		tst_resm(TINFO, "stat_buf.st_uid = %i expected %i",
-		         stat_buf.st_uid, user_id);
-		fail++;
-	}
-
-	if (stat_buf.st_gid != group_id) {
-		tst_resm(TINFO, "stat_buf.st_gid = %i expected %i",
-		         stat_buf.st_gid, group_id);
-		fail++;
-	}
-
-	if (stat_buf.st_size != FILE_SIZE) {
-		tst_resm(TINFO, "stat_buf.st_size = %li expected %i",
-		         (long)stat_buf.st_size, FILE_SIZE);
-		fail++;
-	}
-
-        if ((stat_buf.st_mode & MASK) != FILE_MODE) {
-		tst_resm(TINFO, "stat_buf.st_mode = %o expected %o",
-		         (stat_buf.st_mode & MASK), FILE_MODE);
-		fail++;
-	}
-
-	if (fail) {
-		tst_resm(TFAIL, "functionality of fstat incorrect");
-		return;
-	}
-
-	tst_resm(TPASS, "functionality of fstat correct");
-}
-
-int main(int ac, char **av)
-{
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++)
-		verify();
-
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
-{
-	struct passwd *ltpuser;
-	char tst_buff[BUF_SIZE];
-	int wbytes;
-	int write_len = 0;
-	int fd;
-
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	ltpuser = SAFE_GETPWNAM(NULL, "nobody");
-	SAFE_SETUID(NULL, ltpuser->pw_uid);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	umask(022);
-
-	fd = SAFE_OPEN(tst_rmdir, TESTFILE, O_WRONLY | O_CREAT, FILE_MODE);
-
-	/* Fill the test buffer with the known data */
-	memset(tst_buff, 'a', BUF_SIZE - 1);
-
-	/* Write to the file 1k data from the buffer */
-	while (write_len < FILE_SIZE) {
-		if ((wbytes = write(fd, tst_buff, sizeof(tst_buff))) <= 0)
-			tst_brkm(TBROK | TERRNO, cleanup, "write failed");
-		else
-			write_len += wbytes;
-	}
-
-	SAFE_CLOSE(tst_rmdir, fd);
-
-	user_id = getuid();
-	group_id = getgid();
-}
-
-static void cleanup(void)
-{
-	tst_rmdir();
-}
diff --git a/testcases/kernel/syscalls/stat/stat02.c b/testcases/kernel/syscalls/stat/stat02.c
index aeaa7ab82..4e0ab5a03 100644
--- a/testcases/kernel/syscalls/stat/stat02.c
+++ b/testcases/kernel/syscalls/stat/stat02.c
@@ -1,228 +1,106 @@
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
- * Test Name: stat02
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) International Business Machines  Corp., 2001
+ *	07/2001 John George
+ *		-Ported
  *
- * Test Description:
  *  Verify that, stat(2) succeeds to get the status of a file and fills the
  *  stat structure elements though process doesn't have read access to the
  *  file.
- *
- * Expected Result:
- *  stat() should return value 0 on success and the stat structure elements
- *  should be filled with specified 'file' information.
- *
- * Algorithm:
- *  Setup:
- *   Setup signal handling.
- *   Create temporary directory.
- *   Pause for SIGUSR1 if option specified.
- *
- *  Test:
- *   Loop if the proper options are given.
- *   Execute system call
- *   Check return code, if system call failed (return=-1)
- *   	Log the errno and Issue a FAIL message.
- *   Otherwise,
- *   	Verify the Functionality of system call
- *      if successful,
- *      	Issue Functionality-Pass message.
- *      Otherwise,
- *		Issue Functionality-Fail message.
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *   Delete the temporary directory created.
- *
- * Usage:  <for command-line>
- *  stat02 [-c n] [-e] [-f] [-i n] [-I x] [-p x] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-e   : Turn on errno logging.
- *		-f   : Turn off functionality Testing.
- *		-i n : Execute test n times.
- *		-I x : Execute test for x seconds.
- *		-P x : Pause for x seconds between iterations.
- *		-t   : Turn on syscall timing.
- *
- * History
- *	07/2001 John George
- *		-Ported
- *
- * Restrictions:
- *
  */
-#include <stdio.h>
+
 #include <sys/types.h>
 #include <fcntl.h>
 #include <sys/stat.h>
 #include <errno.h>
-#include <string.h>
-#include <signal.h>
 #include <pwd.h>
+#include "tst_test.h"
 
-#include "test.h"
-#include "safe_macros.h"
-
-#define FILE_MODE	S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
-#define TESTFILE	"testfile"
+#define FILE_MODE       0644
+#define TESTFILE        "testfile"
 #define FILE_SIZE       1024
-#define BUF_SIZE	256
-#define NEW_MODE	0222
-#define MASK		0777
-
-char *TCID = "stat02";
-int TST_TOTAL = 1;
+#define BUF_SIZE        256
+#define NEW_MODE        0222
+#define MASK            0777
 
-uid_t user_id;			/* eff. user id/group id of test process */
+uid_t user_id;
 gid_t group_id;
-char nobody_uid[] = "nobody";
 struct passwd *ltpuser;
 
-void setup();
-void cleanup();
-
-int main(int ac, char **av)
+static void verify_stat(void)
 {
-	struct stat stat_buf;	/* stat structure buffer */
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
-		/*
-		 * Call stat(2) to get the status of
-		 * specified 'file' into stat structure.
-		 */
-		TEST(stat(TESTFILE, &stat_buf));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL,
-				 "stat(%s, &stat_buf) Failed, errno=%d : %s",
-				 TESTFILE, TEST_ERRNO, strerror(TEST_ERRNO));
-		} else {
-			stat_buf.st_mode &= ~S_IFREG;
-			/*
-			 * Verify the data returned by stat(2)
-			 * aganist the expected data.
-			 */
-			if ((stat_buf.st_uid != user_id) ||
-			    (stat_buf.st_gid != group_id) ||
-			    (stat_buf.st_size != FILE_SIZE) ||
-			    ((stat_buf.st_mode & MASK) != NEW_MODE)) {
-				tst_resm(TFAIL, "Functionality of "
-					 "stat(2) on '%s' Failed",
-					 TESTFILE);
-			} else {
-				tst_resm(TPASS, "Functionality of "
-					 "stat(2) on '%s' Succcessful",
-					 TESTFILE);
-			}
-		}
-		tst_count++;	/* incr TEST_LOOP counter */
+	struct stat stat_buf;
+	int fail = 0;
+
+	TEST(stat(TESTFILE, &stat_buf));
+
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "fstat(%s) failed", TESTFILE);
+		return;
 	}
 
-	cleanup();
-	tst_exit();
-}
+	if (stat_buf.st_uid != user_id) {
+		tst_res(TINFO, "stat_buf.st_uid = %i expected %i",
+			stat_buf.st_uid, user_id);
+		fail++;
+	}
 
-/*
- * void
- * setup() -  Performs setup function for the test.
- *  Creat a temporary directory and change directory to it.
- *  Creat a testfile and write some data into it.
- *  Modify the mode permissions of testfile such that test process
- *  has read-only access to testfile.
- */
-void setup(void)
-{
-	int i, fd;		/* counter, file handle for file */
-	char tst_buff[BUF_SIZE];	/* data buffer for file */
-	int wbytes;		/* no. of bytes written to file */
-	int write_len = 0;
+	if (stat_buf.st_gid != group_id) {
+		tst_res(TINFO, "stat_buf.st_gid = %i expected %i",
+			stat_buf.st_gid, group_id);
+		fail++;
+	}
 
-	tst_require_root();
+	if (stat_buf.st_size != FILE_SIZE) {
+		tst_res(TINFO, "stat_buf.st_size = %li expected %i",
+			(long)stat_buf.st_size, FILE_SIZE);
+		fail++;
+	}
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	if ((stat_buf.st_mode & MASK) != NEW_MODE) {
+		tst_res(TINFO, "stat_buf.st_mode = %o expected %o",
+			(stat_buf.st_mode & MASK), NEW_MODE);
+		fail++;
+	}
 
-	/* Switch to nobody user for correct error code collection */
-	ltpuser = getpwnam(nobody_uid);
-	if (setuid(ltpuser->pw_uid) == -1) {
-		tst_resm(TINFO, "setuid failed to "
-			 "to set the effective uid to %d", ltpuser->pw_uid);
-		perror("setuid");
+	if (fail) {
+		tst_res(TFAIL, "functionality of stat incorrect");
+		return;
 	}
 
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -i option.
-	 * You want to make sure you do this before you create your temporary
-	 * directory.
-	 */
-	TEST_PAUSE;
+	tst_res(TPASS, "functionality of stat correct");
+}
+
+void setup(void)
+{
+	int i, fd;
+	char tst_buff[BUF_SIZE];
+	int write_len = 0;
 
-	tst_tmpdir();
+	ltpuser = SAFE_GETPWNAM("nobody");
+	SAFE_SETUID(ltpuser->pw_uid);
 
-	if ((fd = open(TESTFILE, O_RDWR | O_CREAT, FILE_MODE)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "open(%s, O_RDWR|O_CREAT, %#o) Failed, errno=%d : %s",
-			 TESTFILE, FILE_MODE, errno, strerror(errno));
-	}
+	fd = SAFE_OPEN(TESTFILE, O_WRONLY | O_CREAT, FILE_MODE);
 
-	/* Fill the test buffer with the known data */
 	for (i = 0; i < BUF_SIZE; i++) {
 		tst_buff[i] = 'a';
 	}
 
 	/* Write to the file 1k data from the buffer */
 	while (write_len < FILE_SIZE) {
-		if ((wbytes = write(fd, tst_buff, sizeof(tst_buff))) <= 0) {
-			tst_brkm(TBROK | TERRNO, cleanup, "write to %s failed",
-				 TESTFILE);
-		} else {
-			write_len += wbytes;
-		}
-	}
-
-	if (close(fd) == -1) {
-		tst_resm(TWARN | TERRNO, "closing %s failed", TESTFILE);
+		SAFE_WRITE(1, fd, tst_buff, sizeof(tst_buff));
+		write_len += BUF_SIZE;
 	}
 
-	/* Modify mode permissions on the testfile */
-	SAFE_CHMOD(cleanup, TESTFILE, NEW_MODE);
+	SAFE_CLOSE(fd);
 
-	/* Get the uid/gid of the process */
+	SAFE_CHMOD(TESTFILE, NEW_MODE);
 	user_id = getuid();
 	group_id = getgid();
-
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- *  Remove the temporary directory and file created.
- */
-void cleanup(void)
-{
-
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = verify_stat,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+};
diff --git a/testcases/kernel/syscalls/stat/stat05.c b/testcases/kernel/syscalls/stat/stat05.c
deleted file mode 100644
index 300649ade..000000000
--- a/testcases/kernel/syscalls/stat/stat05.c
+++ /dev/null
@@ -1,194 +0,0 @@
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
-/* $Id: stat05.c,v 1.6 2009/11/02 13:57:19 subrata_modak Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: stat05
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for stat(2)
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
- * 	1.) stat(2) returns...(See Description)
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
- *	This is a Phase I test for the stat(2) system call.  It is intended
- *	to provide a limited exposure of the system call, for now.  It
- *	should/will be extended when full functional tests are written for
- *	stat(2).
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
-#include <sys/stat.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include "test.h"
-
-void setup();
-void cleanup();
-
-char *TCID = "stat05";
-int TST_TOTAL = 1;
-
-char fname[255];
-int fd;
-struct stat statter;
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
-		/*
-		 * Call stat(2) with F_CLRALF argument on fname
-		 */
-		TEST(stat(fname, &statter));
-
-		/* check return code */
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "stat(%s, &statter) failed", fname);
-		} else {
-			tst_resm(TPASS,
-				 "stat(%s, &statter) returned %ld",
-				 fname, TEST_RETURN);
-		}
-
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
-	sprintf(fname, "tfile_%d", getpid());
-	if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "open(%s, O_RDWR|O_CREAT,0700) Failed, errno=%d : %s",
-			 fname, errno, strerror(errno));
-	}
-
-	if (close(fd) == -1) {
-		tst_resm(TWARN | TERRNO, "close(%s) failed", fname);
-	}
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
-}
-- 
2.18.1



