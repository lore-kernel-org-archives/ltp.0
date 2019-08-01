From: Jinhui huang <huangjh.jy@cn.fujitsu.com>
Date: Thu, 1 Aug 2019 15:42:27 +0800
Subject: [LTP] [PATCH v2 1/3] syscalls/ftruncate: Rewrite ftruncate01 and
 merge ftruncate02
In-Reply-To: <1564395109-7165-3-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1564395109-7165-3-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <1564645349-10859-1-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jinhui huang <huangjh.jy@cn.fujitsu.com>
---
 runtest/syscalls                                  |   2 -
 testcases/kernel/syscalls/ftruncate/.gitignore    |   2 -
 testcases/kernel/syscalls/ftruncate/ftruncate01.c | 237 +++++-------------
 testcases/kernel/syscalls/ftruncate/ftruncate02.c | 286 ----------------------
 4 files changed, 66 insertions(+), 461 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/ftruncate/ftruncate02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index a68a4c9..bf5a5f6 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -354,8 +354,6 @@ fsync04 fsync04
 
 ftruncate01 ftruncate01
 ftruncate01_64 ftruncate01_64
-ftruncate02 ftruncate02
-ftruncate02_64 ftruncate02_64
 ftruncate03 ftruncate03
 ftruncate03_64 ftruncate03_64
 ftruncate04 ftruncate04
diff --git a/testcases/kernel/syscalls/ftruncate/.gitignore b/testcases/kernel/syscalls/ftruncate/.gitignore
index 814b707..b08763f 100644
--- a/testcases/kernel/syscalls/ftruncate/.gitignore
+++ b/testcases/kernel/syscalls/ftruncate/.gitignore
@@ -1,7 +1,5 @@
 /ftruncate01
 /ftruncate01_64
-/ftruncate02
-/ftruncate02_64
 /ftruncate03
 /ftruncate03_64
 /ftruncate04
diff --git a/testcases/kernel/syscalls/ftruncate/ftruncate01.c b/testcases/kernel/syscalls/ftruncate/ftruncate01.c
index 3309af5..930d86c 100644
--- a/testcases/kernel/syscalls/ftruncate/ftruncate01.c
+++ b/testcases/kernel/syscalls/ftruncate/ftruncate01.c
@@ -1,203 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
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
+ * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
+ * Author: Wayne Boyer
  */
-
 /*
- * Test Name: ftruncate01
- *
  * Test Description:
- *  Verify that, ftruncate(2) succeeds to truncate a file to a specified
- *  length if the file indicated by file descriptor opened for writing.
- *
- * Expected Result:
- *  ftruncate(2) should return a value 0 and the length of the file after
- *  truncation should be equal to the length it is truncated to.
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
- *	Log the errno and Issue a FAIL message.
- *   Otherwise,
- *	Verify the Functionality of system call
- *      if successful,
- *		Issue Functionality-Pass message.
- *      Otherwise,
- *		Issue Functionality-Fail message.
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *   Delete the temporary directory created.
- *
- * Usage:  <for command-line>
- *  ftruncate01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
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
- *  This test should be run by 'non-super-user' only.
- *
+ *  Verify that, ftruncate() succeeds to truncate a file to a certain length,
+ *  if the file previously is smaller than the truncated size, ftruncate()
+ *  shall increase the size of the file.
  */
 
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <unistd.h>
 #include <fcntl.h>
 #include <errno.h>
 #include <string.h>
-#include <signal.h>
-#include <inttypes.h>
 
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 
-#define TESTFILE	"testfile"	/* file under test */
-#define FILE_MODE	S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
-#define BUF_SIZE	256	/* buffer size */
-#define FILE_SIZE	1024	/* test file size */
-#define TRUNC_LEN	256	/* truncation length */
+#define TESTFILE	"testfile"
 
-TCID_DEFINE(ftruncate01);
-int TST_TOTAL = 1;		/* Total number of test conditions */
-int fildes;			/* file descriptor for test file */
+#define TRUNC_LEN1	256
+#define TRUNC_LEN2	512
+#define FILE_SIZE	1024
 
-void setup();			/* setup function for the test */
-void cleanup();			/* cleanup function for the test */
+static int fd;
 
-int main(int ac, char **av)
+static void check_and_report(off_t offset, char data, off_t trunc_len)
 {
-	struct stat stat_buf;	/* stat(2) struct contents */
-	int lc;
-	off_t file_length;	/* test file length */
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
-		 * Call ftruncate(2) to truncate a test file to a
-		 * specified length.
-		 */
-		TEST(ftruncate(fildes, TRUNC_LEN));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TTERRNO, "ftruncate(%s) failed",
-				 TESTFILE);
-			continue;
-		}
-		/*
-		 * Get the testfile information using
-		 * fstat(2).
-		 */
-		if (fstat(fildes, &stat_buf) < 0) {
-			tst_brkm(TFAIL, cleanup,
-				 "stat(2) of %s failed, error:%d",
-				 TESTFILE, errno);
-		}
-		stat_buf.st_mode &= ~S_IFREG;
-		file_length = stat_buf.st_size;
-
-		/*
-		 * Check for expected size of testfile after
-		 * truncate(2) on it.
-		 */
-		if (file_length != TRUNC_LEN) {
-			tst_resm(TFAIL,
-				 "%s: Incorrect file size %" PRId64 ", "
-				 "Expected %d", TESTFILE,
-				 (int64_t) file_length, TRUNC_LEN);
-		} else {
-			tst_resm(TPASS, "Functionality of ftruncate() "
-				 "on %s successful", TESTFILE);
-		}
-	}
+	int i, file_length;
+	char buf[FILE_SIZE];
+	struct stat stat_buf;
 
-	cleanup();
-	tst_exit();
-}
+	memset(buf, '*', sizeof(buf));
 
-/*
- * void
- * setup() - performs all ONE TIME setup for this test.
- *  Create a temporary directory and change directory to it.
- *  Create a test file under temporary directory and write some
- *  data into it.
- */
-void setup(void)
-{
-	int i;
-	int c, c_total = 0;	/* bytes to be written to file */
-	char tst_buff[BUF_SIZE];	/* buffer to hold data */
+	SAFE_FSTAT(fd, &stat_buf);
+	file_length = stat_buf.st_size;
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	if (file_length != trunc_len) {
+		tst_brk(TBROK, "ftruncate() got incorrected size: %d",
+			file_length);
+	}
 
-	TEST_PAUSE;
+	SAFE_LSEEK(fd, offset, SEEK_SET);
+	SAFE_READ(0, fd, buf, sizeof(buf));
 
-	tst_tmpdir();
+	for (i = 0; i < TRUNC_LEN1; i++) {
+		if (buf[i] != data)
+			tst_brk(TBROK, "ftruncate() got incorrect data");
+	}
+
+	tst_res(TPASS, "ftruncate() succeeded");
+}
 
-	/* Fill the test buffer with the known data */
-	for (i = 0; i < BUF_SIZE; i++) {
-		tst_buff[i] = 'a';
+static void verify_ftruncate(void)
+{
+	tst_res(TINFO, "Truncated length smaller than file size");
+	TEST(ftruncate(fd, TRUNC_LEN1));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "ftruncate() failed");
+		return;
 	}
 
-	/* open a file for reading/writing */
-	fildes = SAFE_OPEN(cleanup, TESTFILE, O_RDWR | O_CREAT, FILE_MODE);
-
-	/* Write to the file 1k data from the buffer */
-	while (c_total < FILE_SIZE) {
-		if ((c = write(fildes, tst_buff, sizeof(tst_buff))) <= 0) {
-			tst_brkm(TBROK | TERRNO, cleanup, "write(%s) failed",
-				 TESTFILE);
-		} else {
-			c_total += c;
-		}
+	check_and_report(0, 'a', TRUNC_LEN1);
+
+	tst_res(TINFO, "Truncated length exceeds file size");
+	TEST(ftruncate(fd, TRUNC_LEN2));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "ftruncate() failed");
+		return;
 	}
+
+	check_and_report(TRUNC_LEN1, 0, TRUNC_LEN2);
 }
 
-/*
- * void
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- *  Close the temporary file.
- *  Remove the test directory and testfile created in the setup.
- */
-void cleanup(void)
+static void setup(void)
 {
+	if (tst_fill_file(TESTFILE, 'a', FILE_SIZE, 1))
+		tst_brk(TBROK, "Failed to create test file");
 
-	/* Close the testfile after writing data into it */
-	if (close(fildes) == -1)
-		tst_brkm(TFAIL | TERRNO, NULL, "close(%s) failed", TESTFILE);
-
-	tst_rmdir();
+	fd = SAFE_OPEN(TESTFILE, O_RDWR);
+}
 
+static void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }
+
+static struct tst_test test = {
+	.test_all = verify_ftruncate,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+};
diff --git a/testcases/kernel/syscalls/ftruncate/ftruncate02.c b/testcases/kernel/syscalls/ftruncate/ftruncate02.c
deleted file mode 100644
index 8ae226a..0000000
--- a/testcases/kernel/syscalls/ftruncate/ftruncate02.c
+++ /dev/null
@@ -1,286 +0,0 @@
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
- * Test Name: ftruncate02
- *
- * Test Description:
- *  Verify that, ftruncate(2) succeeds to truncate a file to a certain length,
- *  but the attempt to read past the truncated length will fail.
- *
- * Expected Result:
- *  ftruncate(2) should return a value 0 and the attempt to read past the
- *  truncated length will fail. In case where the file before  truncation was
- *  shorter, the bytes between the old and new should  be all zeroes.
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
- *	Log the errno and Issue a FAIL message.
- *   Otherwise,
- *	Verify the Functionality of system call
- *      if successful,
- *		Issue Functionality-Pass message.
- *      Otherwise,
- *		Issue Functionality-Fail message.
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *   Delete the temporary directory created.
- *
- * Usage:  <for command-line>
- *  ftruncate02 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
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
- *
- */
-
-#include <stdio.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-
-#include "test.h"
-#include "safe_macros.h"
-
-#define TESTFILE	"testfile"	/* file under test */
-#define FILE_MODE	S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
-#define BUF_SIZE	256	/* buffer size */
-#define FILE_SIZE	1024	/* test file size */
-#define TRUNC_LEN1	256	/* truncation length */
-#define TRUNC_LEN2	512	/* truncation length */
-
-TCID_DEFINE(ftruncate02);
-int TST_TOTAL = 1;		/* Total number of test conditions */
-int fd;				/* file descriptor of testfile */
-char tst_buff[BUF_SIZE];	/* buffer to hold testfile contents */
-
-void setup();			/* setup function for the test */
-void cleanup();			/* cleanup function for the test */
-
-int main(int ac, char **av)
-{
-	struct stat stat_buf;	/* stat(2) struct contents */
-	int lc;
-	off_t file_length2;	/* test file length */
-	off_t file_length1;	/* test file length */
-	int rbytes, i;		/* bytes read from testfile */
-	int read_len;		/* total no. of bytes read from testfile */
-	int err_flag = 0;	/* error indicator flag */
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-		read_len = 0;
-
-		/*
-		 * Call ftruncate(2) to truncate a test file to a
-		 * specified length (TRUNC_LEN1).
-		 */
-		TEST(ftruncate(fd, TRUNC_LEN1));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TTERRNO,
-				 "ftruncate(%s) to size %d failed", TESTFILE,
-				 TRUNC_LEN1);
-			continue;
-		}
-		/*
-		 * Get the testfile information using
-		 * fstat(2).
-		 */
-		if (fstat(fd, &stat_buf) < 0) {
-			tst_brkm(TFAIL, cleanup, "fstat(2) of %s failed"
-				 " after 1st truncate, error:%d",
-				 TESTFILE, errno);
-		}
-		stat_buf.st_mode &= ~S_IFREG;
-		file_length1 = stat_buf.st_size;
-
-		/*
-		 * Set the file pointer of testfile to the
-		 * beginning of the file.
-		 */
-		if (lseek(fd, 0, SEEK_SET) < 0) {
-			tst_brkm(TFAIL, cleanup, "lseek(2) on %s failed"
-				 " after 1st ftruncate, error:%d",
-				 TESTFILE, errno);
-		}
-
-		/* Read the testfile from the beginning. */
-		while ((rbytes = read(fd, tst_buff,
-				      sizeof(tst_buff))) > 0) {
-			read_len += rbytes;
-		}
-
-		/*
-		 * Execute ftruncate(2) again to truncate
-		 * testfile to a size TRUNC_LEN2.
-		 */
-		TEST(ftruncate(fd, TRUNC_LEN2));
-
-		/*
-		 * Get the testfile information using
-		 * fstat(2)
-		 */
-		if (fstat(fd, &stat_buf) < 0) {
-			tst_brkm(TFAIL, cleanup, "fstat(2) of %s failed"
-				 " after 2nd truncate, error:%d",
-				 TESTFILE, errno);
-		}
-		stat_buf.st_mode &= ~S_IFREG;
-		file_length2 = stat_buf.st_size;
-
-		/*
-		 * Set the file pointer of testfile to the
-		 * offset TRUNC_LEN1 of testfile.
-		 */
-		if (lseek(fd, TRUNC_LEN1, SEEK_SET) < 0) {
-			tst_brkm(TFAIL, cleanup, "lseek(2) on %s failed"
-				 " after 2nd ftruncate, error:%d",
-				 TESTFILE, errno);
-		}
-
-		/* Read the testfile contents till EOF */
-		while ((rbytes = read(fd, tst_buff,
-				      sizeof(tst_buff))) > 0) {
-			for (i = 0; i < rbytes; i++) {
-				if (tst_buff[i] != 0) {
-					err_flag++;
-				}
-			}
-		}
-
-		/*
-		 * Check for expected size of testfile after
-		 * issuing ftruncate(2) on it. If the ftruncate(2)
-		 * to a smaller file passed, then check to see
-		 * if file size was increased. If the ftruncate(2)
-		 * to a smaller file failed, then don't check.
-		 * Both results are allowed according to the SUS.
-		 */
-
-		if (TEST_RETURN != -1) {
-			if ((file_length1 != TRUNC_LEN1) ||
-			    (file_length2 != TRUNC_LEN2) ||
-			    (read_len != TRUNC_LEN1) ||
-			    (err_flag != 0)) {
-				tst_resm(TFAIL,
-					 "Functionality of ftruncate(2) "
-					 "on %s Failed", TESTFILE);
-			} else {
-				tst_resm(TPASS,
-					 "Functionality of ftruncate(2) "
-					 "on %s successful", TESTFILE);
-			}
-		}
-		if (TEST_RETURN == -1) {
-			if ((file_length1 != TRUNC_LEN1) ||
-			    (read_len != TRUNC_LEN1) ||
-			    (err_flag != 0)) {
-				tst_resm(TFAIL,
-					 "Functionality of ftruncate(2) "
-					 "on %s Failed", TESTFILE);
-			} else {
-				tst_resm(TPASS,
-					 "Functionality of ftruncate(2) "
-					 "on %s successful", TESTFILE);
-			}
-		}
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-/*
- * void
- * setup() - performs all ONE TIME setup for this test.
- *  Create a temporary directory and change directory to it.
- *  Create a test file under temporary directory and write some
- *  data into it.
- */
-void setup(void)
-{
-	int i;
-	int wbytes;		/* bytes written to testfile */
-	int write_len = 0;	/* total no. of bytes written to testfile */
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	/* Fill the test buffer with the known data */
-	for (i = 0; i < BUF_SIZE; i++) {
-		tst_buff[i] = 'a';
-	}
-	/* open a file for reading/writing */
-	fd = SAFE_OPEN(cleanup, TESTFILE, O_RDWR | O_CREAT, FILE_MODE);
-
-	/* Write to the file 1k data from the buffer */
-	while (write_len < FILE_SIZE) {
-		if ((wbytes = write(fd, tst_buff, sizeof(tst_buff))) <= 0) {
-			tst_brkm(TBROK, cleanup, "write(%s) failed", TESTFILE);
-		} else {
-			write_len += wbytes;
-		}
-	}
-}
-
-/*
- * void
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- *  Close the testfile.
- *  Remove the test directory and testfile created in the setup.
- */
-void cleanup(void)
-{
-
-	/* Close the testfile after writing data into it */
-	if (close(fd) == -1)
-		tst_brkm(TFAIL | TERRNO, NULL, "close(%s) failed", TESTFILE);
-
-	tst_rmdir();
-
-}
-- 
1.8.3.1



