From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 21 Jun 2017 14:12:18 +0800
Subject: [LTP] [PATCH 2/3] syscalls/lseek08,
	09: cleanup && convert to new API
In-Reply-To: <1498025539-24441-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1498025539-24441-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1498025539-24441-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) merge lseek08 into lseek01
2) lseek09 has been merge into lseek01, so remove it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/ltplite                           |   2 -
 runtest/stress.part3                      |   2 -
 runtest/syscalls                          |   2 -
 testcases/kernel/syscalls/.gitignore      |   2 -
 testcases/kernel/syscalls/lseek/lseek01.c |  12 +-
 testcases/kernel/syscalls/lseek/lseek08.c | 205 --------------------------
 testcases/kernel/syscalls/lseek/lseek09.c | 233 ------------------------------
 7 files changed, 7 insertions(+), 451 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/lseek/lseek08.c
 delete mode 100644 testcases/kernel/syscalls/lseek/lseek09.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 2826514..237a8b0 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -408,8 +408,6 @@ llseek03 llseek03
 lseek01 lseek01
 lseek02 lseek02
 lseek07 lseek07
-lseek08 lseek08
-lseek09 lseek09
 lseek10 lseek10
 lseek11 lseek11
 
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 67548dc..7c2b534 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -334,8 +334,6 @@ llseek03 llseek03
 lseek01 lseek01
 lseek02 lseek02
 lseek07 lseek07
-lseek08 lseek08
-lseek09 lseek09
 lseek10 lseek10
 lseek11 lseek11
 
diff --git a/runtest/syscalls b/runtest/syscalls
index 169bfcd..754d077 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -550,8 +550,6 @@ llseek03 llseek03
 lseek01 lseek01
 lseek02 lseek02
 lseek07 lseek07
-lseek08 lseek08
-lseek09 lseek09
 lseek10 lseek10
 lseek11 lseek11
 
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 9ea4ed8..888d622 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -501,8 +501,6 @@
 /lseek/lseek01
 /lseek/lseek02
 /lseek/lseek07
-/lseek/lseek08
-/lseek/lseek09
 /lseek/lseek10
 /lseek/lseek11
 /lstat/lstat01
diff --git a/testcases/kernel/syscalls/lseek/lseek01.c b/testcases/kernel/syscalls/lseek/lseek01.c
index 4740cf5..2e1c36e 100644
--- a/testcases/kernel/syscalls/lseek/lseek01.c
+++ b/testcases/kernel/syscalls/lseek/lseek01.c
@@ -37,11 +37,13 @@ static struct tcase {
 	int whence;
 	char *wname;
 	off_t exp_off;
+	ssize_t exp_size;
 	char *exp_data;
 } tcases[] = {
-	{4, SEEK_SET, "SEEK_SET", 4, "efg"},
-	{-2, SEEK_CUR, "SEEK_CUR", 5, "fg"},
-	{-4, SEEK_END, "SEEK_END", 3, "defg"},
+	{4, SEEK_SET, "SEEK_SET", 4, 3, "efg"},
+	{-2, SEEK_CUR, "SEEK_CUR", 5, 2, "fg"},
+	{-4, SEEK_END, "SEEK_END", 3, 4, "defg"},
+	{0, SEEK_END, "SEEK_END", 7, 0, NULL},
 };
 
 static void verify_lseek(unsigned int n)
@@ -67,9 +69,9 @@ static void verify_lseek(unsigned int n)
 		return;
 	}
 
-	SAFE_READ(0, fd, read_buf, sizeof(read_buf));
+	SAFE_READ(1, fd, read_buf, tc->exp_size);
 
-	if (strcmp(read_buf, tc->exp_data)) {
+	if (tc->exp_data && strcmp(read_buf, tc->exp_data)) {
 		tst_res(TFAIL, "lseek(%s, %ld, %s) read incorrect data",
 			TFILE, tc->off, tc->wname);
 	} else {
diff --git a/testcases/kernel/syscalls/lseek/lseek08.c b/testcases/kernel/syscalls/lseek/lseek08.c
deleted file mode 100644
index 49e787a..0000000
--- a/testcases/kernel/syscalls/lseek/lseek08.c
+++ /dev/null
@@ -1,205 +0,0 @@
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
- * Test Name: lseek08
- *
- * Test Description:
- *  Verify that, lseek() call succeeds to set the file pointer position
- *  to the end of the file when 'whence' value set to SEEK_END and any
- *  attempts to read from that position should fail.
- *
- * Expected Result:
- *  lseek() should return the offset which is set to the file size measured
- *  in bytes. read() attempt should fail with -1 return value.
- * $
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
- *  lseek08 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
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
-#define TEMP_FILE	"tmp_file"
-#define FILE_MODE	S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
-
-char *TCID = "lseek08";
-int TST_TOTAL = 1;
-int fildes;			/* file handle for temp file */
-size_t file_size;		/* size of the temporary file */
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
-		 * pointer/handle to the END of the file.
-		 */
-		TEST(lseek(fildes, 0, SEEK_END));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TTERRNO,
-				 "lseek of %s failed", TEMP_FILE);
-			continue;
-		}
-		/*
-		 * Check if the return value from lseek(2)
-		 * is equal to the file_size.
-		 */
-		if (TEST_RETURN != file_size) {
-			tst_resm(TFAIL, "lseek() returned incorrect "
-				 "value %ld, expected %zu",
-				 TEST_RETURN, file_size);
-			continue;
-		}
-		/*
-		 * The return value is okay, now attempt to read data
-		 * from the file.  This should fail as the file pointer
-		 * should be pointing to END OF FILE.
-		 */
-		read_buf[0] = '\0';
-		if (read(fildes, &read_buf, sizeof(read_buf)) > 0) {
-			tst_resm(TFAIL, "read() successful on %s",
-				 TEMP_FILE);
-		} else {
-			tst_resm(TPASS, "Functionality of lseek() on "
-				 "%s successful", TEMP_FILE);
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
- *	     Get the size of the file using fstat().
- */
-void setup(void)
-{
-	struct stat stat_buf;	/* struct. buffer for stat(2) */
-	char write_buf[BUFSIZ];	/* buffer to hold data */
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	/* Get the data to be written to temporary file */
-	strcpy(write_buf, "abcdefg\n");
-
-	/* Creat/open a temporary file under above directory */
-	if ((fildes = open(TEMP_FILE, O_RDWR | O_CREAT, FILE_MODE)) == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "open(%s, O_RDWR|O_CREAT, %#o) failed",
-			 TEMP_FILE, FILE_MODE);
-	}
-
-	/* Write data into temporary file */
-	if (write(fildes, write_buf, strlen(write_buf)) <= 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "writing to %s failed", TEMP_FILE);
-	}
-
-	/* Get the size of the file using fstat */
-	if (fstat(fildes, &stat_buf) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "fstat of %s failed", TEMP_FILE);
-	}
-
-	file_size = stat_buf.st_size;
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
-		tst_brkm(TFAIL, NULL,
-			 "close(%s) Failed, errno=%d : %s:",
-			 TEMP_FILE, errno, strerror(errno));
-	}
-
-	tst_rmdir();
-
-}
diff --git a/testcases/kernel/syscalls/lseek/lseek09.c b/testcases/kernel/syscalls/lseek/lseek09.c
deleted file mode 100644
index 38b1234..0000000
--- a/testcases/kernel/syscalls/lseek/lseek09.c
+++ /dev/null
@@ -1,233 +0,0 @@
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
- * Test Name: lseek09
- *
- * Test Description:
- *  Verify that, lseek() call succeeds to set the file pointer position
- *  to the current specified location, when 'whence' value is set to
- *  SEEK_CUR and the data read from the specified location should match
- *  the expected data.
- *
- * Expected Result:
- *  lseek() should return the specified offset from the beginning of the file
- *  measured in bytes. The data read from this location should match the
- *  expected data.
- *$
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
- *  lseek09 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
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
-#define TEMP_FILE	"tmp_file"
-#define FILE_MODE	S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
-
-char *TCID = "lseek09";
-int TST_TOTAL = 1;
-int fildes;			/* file handle for temp file */
-size_t file_size;		/* total size of file after data write */
-
-void setup();			/* Main setup function of test */
-void cleanup();			/* cleanup function for the test */
-
-int main(int ac, char **av)
-{
-	int lc;
-	char read_buf[BUFSIZ];	/* data read from temp. file */
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
-		 * Invoke lseek(2) to set the file
-		 * pointer/handle from the current location
-		 * of the file descriptor + specified offset.
-		 */
-		TEST(lseek(fildes, 1, SEEK_CUR));
-
-		if (TEST_RETURN == (off_t) - 1) {
-			tst_resm(TFAIL, "lseek on (%s) Failed, errno=%d : %s",
-				 TEMP_FILE, TEST_ERRNO, strerror(TEST_ERRNO));
-			continue;
-		}
-		/*
-		 * Check if the return value from lseek(2) is equal
-		 * to the 3 positions from the beginning of the file.
-		 * ie, 2 positions from lseek() in the setup +
-		 * 1 position from above above.
-		 */
-		if (TEST_RETURN != 3) {
-			tst_resm(TFAIL, "lseek() returned incorrect "
-				 "value %ld, expected 4", TEST_RETURN);
-			continue;
-		}
-		/*
-		 * Read the data byte from this location.
-		 */
-		memset(read_buf, 0, sizeof(read_buf));
-		if (read(fildes, &read_buf, (file_size - 3)) < 0) {
-			tst_brkm(TFAIL, cleanup,
-				 "read() failed on %s, error=%d",
-				 TEMP_FILE, errno);
-		} else {
-			/*
-			 * Check if read data contains
-			 * expected characters
-			 * From pos 4 ---> 'defg'.
-			 */
-			if (strcmp(read_buf, "defg")) {
-				tst_resm(TFAIL, "Incorrect data read "
-					 "from file %s", TEMP_FILE);
-			} else {
-				tst_resm(TPASS, "Functionality of "
-					 "lseek() on %s successful",
-					 TEMP_FILE);
-			}
-		}
-
-		/* reset file pointer in case we are looping */
-		if (lseek(fildes, 2, SEEK_SET) == -1) {
-			tst_brkm(TBROK, cleanup, "lseek failed - could not "
-				 "reset file pointer");
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
- *	     Get the size of the file using fstat().
- */
-void setup(void)
-{
-	struct stat stat_buf;	/* buffer to hold stat info. */
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
-	if (write(fildes, write_buf, strlen(write_buf)) <= 0) {
-		tst_brkm(TBROK, cleanup, "write(2) on %s Failed, errno=%d : %s",
-			 TEMP_FILE, errno, strerror(errno));
-	}
-
-	/* Get the temporary file information */
-	if (fstat(fildes, &stat_buf) < 0) {
-		tst_brkm(TBROK, cleanup, "fstat(2) on %s Failed, errno=%d : %s",
-			 TEMP_FILE, errno, strerror(errno));
-	}
-
-	file_size = stat_buf.st_size;
-
-	/*
-	 * Reset the file pointer position to the specified offset
-	 * from the beginning of the file.
-	 */
-	if (lseek(fildes, 2, SEEK_SET) != 2) {
-		tst_brkm(TBROK, cleanup,
-			 "lseek() fails to set file ptr. to specified offset");
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



