From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 19 Jun 2017 13:00:30 +0800
Subject: [LTP] [PATCH 1/2] syscalls/lseek01,
	06: cleanup && convert to new API
Message-ID: <1497848431-30404-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) merge lseek06 into lseek01
2) add tests for SEEK_CUR and SEEK_END

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/ltplite                           |   1 -
 runtest/stress.part3                      |   1 -
 runtest/syscalls                          |   1 -
 testcases/kernel/syscalls/.gitignore      |   1 -
 testcases/kernel/syscalls/lseek/lseek01.c | 264 ++++++++----------------------
 testcases/kernel/syscalls/lseek/lseek06.c | 202 -----------------------
 6 files changed, 71 insertions(+), 399 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/lseek/lseek06.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 909bbdb..7904117 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -410,7 +410,6 @@ lseek02 lseek02
 lseek03 lseek03
 lseek04 lseek04
 lseek05 lseek05
-lseek06 lseek06
 lseek07 lseek07
 lseek08 lseek08
 lseek09 lseek09
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index d5db1c2..42c2b0e 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -336,7 +336,6 @@ lseek02 lseek02
 lseek03 lseek03
 lseek04 lseek04
 lseek05 lseek05
-lseek06 lseek06
 lseek07 lseek07
 lseek08 lseek08
 lseek09 lseek09
diff --git a/runtest/syscalls b/runtest/syscalls
index 8754e3e..fcef347 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -552,7 +552,6 @@ lseek02 lseek02
 lseek03 lseek03
 lseek04 lseek04
 lseek05 lseek05
-lseek06 lseek06
 lseek07 lseek07
 lseek08 lseek08
 lseek09 lseek09
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index d8a38c0..5b8e5b4 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -503,7 +503,6 @@
 /lseek/lseek03
 /lseek/lseek04
 /lseek/lseek05
-/lseek/lseek06
 /lseek/lseek07
 /lseek/lseek08
 /lseek/lseek09
diff --git a/testcases/kernel/syscalls/lseek/lseek01.c b/testcases/kernel/syscalls/lseek/lseek01.c
index a5f8524..c553ded 100644
--- a/testcases/kernel/syscalls/lseek/lseek01.c
+++ b/testcases/kernel/syscalls/lseek/lseek01.c
@@ -1,219 +1,97 @@
 /*
- * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ * Copyright (c) International Business Machines  Corp., 2001
+ * 06/2017 modified by Xiao Yang <yangx.jy@cn.fujitsu.com>
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
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
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * Description:
+ *  lseek() succeeds to set the specified offset according to whence
+ *  and read valid data from this location.
  */
-/* $Id: lseek01.c,v 1.5 2009/11/02 13:57:17 subrata_modak Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: lseek01
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for lseek(2)
- *
- *    PARENT DOCUMENT	: usctpl01
- *
- *    TEST CASE TOTAL	: 3
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
- * 	1.) lseek(2) returns...(See Description)
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
- *	This is a Phase I test for the lseek(2) system call.  It is intended
- *	to provide a limited exposure of the system call, for now.  It
- *	should/will be extended when full functional tests are written for
- *	lseek(2).
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
 #include <errno.h>
 #include <string.h>
-#include <signal.h>
+#include <sys/types.h>
 #include <unistd.h>
-#include "test.h"
-
-void setup();
-void cleanup();
-
-char *TCID = "lseek01";
-int TST_TOTAL = 3;
-
-char Fname[255];
-int Fd;
-
-int Whence[] = { SEEK_SET, SEEK_CUR, SEEK_END, -1 };
-
-int main(int ac, char **av)
+#include "tst_test.h"
+
+static int fd;
+static struct tcase {
+	off_t off;
+	int whence;
+	off_t exp_off;
+	char *exp_data;
+} tcases[] = {
+	{4, SEEK_SET, 4, "efg"},
+	{-2, SEEK_CUR, 5, "fg"},
+	{-4, SEEK_END, 3, "defg"},
+};
+
+static void verify_lseek(unsigned int n)
 {
-	int lc;
-
-	int ind;
-	int offset;
+	char read_buf[64];
+	struct tcase *tc = &tcases[n];
 
-    /***************************************************************
-     * parse standard options
-     ***************************************************************/
-	tst_parse_opts(ac, av, NULL, NULL);
+	memset(read_buf, 0, sizeof(read_buf));
 
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
-		offset = (lc % 100) * 4096;	/* max size is 100 blocks */
-
-		for (ind = 0; Whence[ind] >= 0; ind++) {
+	TEST(lseek(fd, tc->off, tc->whence));
+	if (TEST_RETURN == (off_t) -1) {
+		tst_res(TFAIL | TTERRNO, "lseek(%d, %ld, %d) failed", fd,
+			tc->off, tc->whence);
+		return;
+	}
 
-			/*
-			 *  Call lseek(2)
-			 */
-			TEST(lseek(Fd, (long)offset, Whence[ind]));
+	if (TEST_RETURN != tc->exp_off) {
+		tst_res(TFAIL, "lseek(%d, %ld, %d) returned %ld, expected %ld",
+			fd, tc->off, tc->whence, TEST_RETURN, tc->exp_off);
+		return;
+	}
 
-			/* check return code */
-			if (TEST_RETURN == -1) {
-				tst_resm(TFAIL,
-					 "lseek(%s, %d, 0) Failed, errno=%d : %s",
-					 Fname, offset, TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			} else {
-				tst_resm(TPASS,
-					 "lseek(%s, %d, %d) returned %ld",
-					 Fname, offset, Whence[ind],
-					 TEST_RETURN);
-			}
-		}
+	SAFE_READ(0, fd, &read_buf, sizeof(read_buf));
 
+	if (strcmp(read_buf, tc->exp_data)) {
+		tst_res(TFAIL, "lseek(%d, %ld, %d) read incorrect data", fd,
+			tc->off, tc->whence);
+	} else {
+		tst_res(TPASS, "lseek(%d, %ld, %d) read correct data", fd,
+			tc->off, tc->whence);
 	}
-
-	cleanup();
-	tst_exit();
 }
 
-/***************************************************************
- * setup() - performs all ONE TIME setup for this test.
- ***************************************************************/
-void setup(void)
+static void setup(void)
 {
+	char write_buf[64];
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	strcpy(write_buf, "abcdefg");
 
-	TEST_PAUSE;
+	fd = SAFE_OPEN("tmp_file", O_RDWR | O_CREAT, 0644);
 
-	tst_tmpdir();
-
-	sprintf(Fname, "tfile_%d", getpid());
-	if ((Fd = open(Fname, O_RDWR | O_CREAT, 0700)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "open(%s, O_RDWR|O_CREAT,0700) Failed, errno=%d : %s",
-			 Fname, errno, strerror(errno));
-	}
+	SAFE_WRITE(1, fd, write_buf, strlen(write_buf));
 }
 
-/***************************************************************
- * cleanup() - performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- ***************************************************************/
-void cleanup(void)
+static void cleanup(void)
 {
-
-	/* close the file we have open */
-	if (close(Fd) == -1) {
-		tst_resm(TWARN, "close(%s) Failed, errno=%d : %s", Fname, errno,
-			 strerror(errno));
-	}
-
-	tst_rmdir();
-
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_lseek,
+	.needs_tmpdir = 1,
+};
diff --git a/testcases/kernel/syscalls/lseek/lseek06.c b/testcases/kernel/syscalls/lseek/lseek06.c
deleted file mode 100644
index 056eb40..0000000
--- a/testcases/kernel/syscalls/lseek/lseek06.c
+++ /dev/null
@@ -1,202 +0,0 @@
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
- * Test Name: lseek06
- *
- * Test Description:
- *  Verify that, lseek() call succeeds to set the file pointer position
- *  to less  than  or equal to the file size, when a file is opened for
- *  read or write.
- *
- * Expected Result:
- *  lseek() should return the offset from the beginning of the file measured
- *  in bytes. Also check if able to read valid data from this location.
- * $
- * Algorithm:
- *  Setup:
- *   Setup signal handling.
- *   Pause for SIGUSR1 if option specified.
- *   Create temporary directory.
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
- *  lseek06 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS:
- *  None.
- */
-
-#include <stdio.h>
-#include <unistd.h>
-#include <sys/types.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <utime.h>
-#include <string.h>
-#include <sys/stat.h>
-#include <signal.h>
-
-#include "test.h"
-
-#define OFFSET		4
-#define TEMP_FILE	"tmp_file"
-#define FILE_MODE	S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
-
-char *TCID = "lseek06";
-int TST_TOTAL = 1;
-int fildes;			/* file handle for temp file */
-
-void setup();			/* Main setup function of test */
-void cleanup();			/* cleanup function for the test */
-
-int main(int ac, char **av)
-{
-	int lc;
-	char read_buf[1];	/* data read from temp. file */
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
-		 * Invoke lseek(2) to move the read/write file
-		 * pointer/handle by OFFSET bytes.
-		 */
-		TEST(lseek(fildes, OFFSET, SEEK_SET));
-
-		if (TEST_RETURN == (off_t) - 1) {
-			tst_resm(TFAIL, "lseek on (%s) Failed, errno=%d : %s",
-				 TEMP_FILE, TEST_ERRNO, strerror(TEST_ERRNO));
-			continue;
-		}
-		/*
-		 * Check if the return value from lseek(2)
-		 * is equal to the specified OFFSET value.
-		 */
-		if (TEST_RETURN != OFFSET) {
-			tst_resm(TFAIL, "lseek() returned incorrect "
-				 "value %ld, expected %d",
-				 TEST_RETURN, OFFSET);
-			continue;
-		}
-		/*
-		 * The return value is good, now check data.
-		 * Read the data byte from this location.
-		 */
-		if (read(fildes, &read_buf, sizeof(read_buf)) < 0) {
-			tst_brkm(TFAIL, cleanup, "read() failed "
-				 "on %s, error=%d", TEMP_FILE, errno);
-		} else {
-			/*
-			 * Check if read byte is the expected character.
-			 * For pos 4 ---> 'e'
-			 */
-			if (read_buf[0] != 'e') {
-				tst_resm(TFAIL, "Incorrect data read "
-					 "from file %s", TEMP_FILE);
-			} else {
-				tst_resm(TPASS, "Functionality "
-					 "of lseek() on %s "
-					 "successful", TEMP_FILE);
-			}
-		}
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-/*
- * setup() - performs all ONE TIME setup for this test.
- *	     Create a temporary directory and change directory to it.
- *	     Create a test file under temporary directory and write some
- *	     data into it.
- */
-void setup(void)
-{
-	char write_buf[BUFSIZ];	/* buffer to hold data */
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	/* Get the data to be written to temporary file */
-	strcpy(write_buf, "abcdefg");
-
-	/* Creat/open a temporary file under above directory */
-	if ((fildes = open(TEMP_FILE, O_RDWR | O_CREAT, FILE_MODE)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "open(%s, O_RDWR|O_CREAT, %#o) Failed, errno=%d :%s",
-			 TEMP_FILE, FILE_MODE, errno, strerror(errno));
-	}
-
-	/* Write data into temporary file */
-	if (write(fildes, write_buf, strlen(write_buf)) != strlen(write_buf)) {
-		tst_brkm(TBROK, cleanup, "write(2) on %s Failed, errno=%d : %s",
-			 TEMP_FILE, errno, strerror(errno));
-	}
-}
-
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- *	       Remove the test directory and testfile created in the setup.
- */
-void cleanup(void)
-{
-
-	/* Close the temporary file created */
-	if (close(fildes) < 0) {
-		tst_brkm(TFAIL, NULL, "close(%s) Failed, errno=%d : %s:",
-			 TEMP_FILE, errno, strerror(errno));
-	}
-
-	tst_rmdir();
-
-}
-- 
1.8.3.1



