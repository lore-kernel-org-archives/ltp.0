From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 16 Nov 2020 17:01:19 +0800
Subject: [LTP] [PATCH 1/2] syscalls/truncate{01,
 02}: Convert to new API and cleanup
Message-ID: <20201116090120.31942-1-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Also do the following work:
1) Merge truncate01 into truncate02.
2) Check that truncate(2) doesn't change offset.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/syscalls                              |   2 -
 testcases/kernel/syscalls/truncate/.gitignore |   2 -
 .../kernel/syscalls/truncate/truncate01.c     | 218 -----------
 .../kernel/syscalls/truncate/truncate02.c     | 337 ++++--------------
 4 files changed, 78 insertions(+), 481 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/truncate/truncate01.c

diff --git a/runtest/syscalls b/runtest/syscalls
index aeacb8bc8..2cee745f2 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1556,8 +1556,6 @@ timer_settime03 timer_settime03
 tkill01 tkill01
 tkill02 tkill02
 
-truncate01 truncate01
-truncate01_64 truncate01_64
 truncate02 truncate02
 truncate02_64 truncate02_64
 truncate03 truncate03
diff --git a/testcases/kernel/syscalls/truncate/.gitignore b/testcases/kernel/syscalls/truncate/.gitignore
index b0efbc280..ae58daa0f 100644
--- a/testcases/kernel/syscalls/truncate/.gitignore
+++ b/testcases/kernel/syscalls/truncate/.gitignore
@@ -1,5 +1,3 @@
-/truncate01
-/truncate01_64
 /truncate02
 /truncate02_64
 /truncate03
diff --git a/testcases/kernel/syscalls/truncate/truncate01.c b/testcases/kernel/syscalls/truncate/truncate01.c
deleted file mode 100644
index b3a535f94..000000000
--- a/testcases/kernel/syscalls/truncate/truncate01.c
+++ /dev/null
@@ -1,218 +0,0 @@
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
- * Test Name: truncate01
- *
- * Test Description:
- *  Verify that, truncate(2) succeeds to truncate a file to a specified
- *  length.
- *
- * Expected Result:
- *  truncate(2) should return a value 0 and the length of the file after
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
- *  truncate01 [-c n] [-e] [-f] [-i n] [-I x] [-p x] [-t]
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
- *  This test should be run by 'non-super-user' only.
- *
- */
-
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include <inttypes.h>
-
-#include "test.h"
-#include "safe_macros.h"
-
-#define TESTFILE	"testfile"	/* file under test */
-#define FILE_MODE	S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
-#define BUF_SIZE	256	/* buffer size */
-#define FILE_SIZE	1024	/* test file size */
-#define TRUNC_LEN	256	/* truncation length */
-
-TCID_DEFINE(truncate01);
-int TST_TOTAL = 1;
-
-void setup();			/* setup function for the test */
-void cleanup();			/* cleanup function for the test */
-
-int main(int ac, char **av)
-{
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
-		 * Call truncate(2) to truncate a test file to a
-		 * specified length.
-		 */
-		TEST(truncate(TESTFILE, TRUNC_LEN));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL,
-				 "truncate(%s, %d) Failed, errno=%d : %s",
-				 TESTFILE, TRUNC_LEN, TEST_ERRNO,
-				 strerror(TEST_ERRNO));
-		} else {
-			/*
-			 * Get the testfile information using
-			 * stat(2).
-			 */
-			if (stat(TESTFILE, &stat_buf) < 0) {
-				tst_brkm(TFAIL, cleanup, "stat(2) of "
-					 "%s failed, error:%d",
-					 TESTFILE, errno);
-			}
-			stat_buf.st_mode &= ~S_IFREG;
-			file_length = stat_buf.st_size;
-
-			/*
-			 * Check for expected size of testfile after
-			 * truncate(2) on it.
-			 */
-			if (file_length != TRUNC_LEN) {
-				tst_resm(TFAIL, "%s: Incorrect file "
-					 "size %" PRId64
-					 ", Expected %d", TESTFILE,
-					 (int64_t) file_length,
-					 TRUNC_LEN);
-			} else {
-				tst_resm(TPASS, "Functionality of "
-					 "truncate(%s, %d) successful",
-					 TESTFILE, TRUNC_LEN);
-			}
-		}
-		tst_count++;	/* incr TEST_LOOP counter */
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
- *  Fill the buffer with some arbitrary data to be written to a file.
- *  Create a test file under temporary directory and close it
- *  write arbitrary data into testfile.
- */
-void setup(void)
-{
-	int fd, i;		/* file handler for testfile */
-	int c, c_total = 0;	/* no. bytes to be written to file */
-	char tst_buff[BUF_SIZE];	/* buffer to hold data */
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -i option.
-	 * You want to make sure you do this before you create your temporary
-	 * directory.
-	 */
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	/* Fill the test buffer with the known data */
-	for (i = 0; i < BUF_SIZE; i++) {
-		tst_buff[i] = 'a';
-	}
-
-	/* Creat a testfile under temporary directory */
-	if ((fd = open(TESTFILE, O_RDWR | O_CREAT, FILE_MODE)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "open(%s, O_RDWR|O_CREAT, %o) Failed, errno=%d : %s",
-			 TESTFILE, FILE_MODE, errno, strerror(errno));
-	}
-
-	/* Write to the file 1k data from the buffer */
-	while (c_total < FILE_SIZE) {
-		if ((c = write(fd, tst_buff, sizeof(tst_buff))) <= 0) {
-			tst_brkm(TBROK, cleanup,
-				 "write(2) on %s Failed, errno=%d : %s",
-				 TESTFILE, errno, strerror(errno));
-		} else {
-			c_total += c;
-		}
-	}
-
-	/* Close the testfile after writing data into it */
-	SAFE_CLOSE(cleanup, fd);
-}
-
-/*
- * void
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- *  Remove the test directory and testfile created in the setup.
- */
-void cleanup(void)
-{
-
-	tst_rmdir();
-
-}
diff --git a/testcases/kernel/syscalls/truncate/truncate02.c b/testcases/kernel/syscalls/truncate/truncate02.c
index 7a201eea1..9461b35dc 100644
--- a/testcases/kernel/syscalls/truncate/truncate02.c
+++ b/testcases/kernel/syscalls/truncate/truncate02.c
@@ -1,290 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
+ * 07/2001 John George
  *
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
- * Test Name: truncate02
- *
- * Test Description:
- *  Verify that, truncate(2) succeeds to truncate a file to a certain length,
- *  but the attempt to read past the truncated length will fail.$
- *
- * Expected Result:
- *  truncate(2) should return a value 0 and the attempt to read past the
- *  truncated length will fail. In case where the file before truncation was
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
- *  truncate02 [-c n] [-e] [-f] [-i n] [-I x] [-p x] [-t]
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
- *  This test should be run by 'non-super-user' only.
- *
+ * Verify that:
+ * 1) truncate(2) truncates a file to a specified length successfully.
+ * 2) If the file is larger than the specified length, the extra data is lost.
+ * 3) If the file is shorter than the specified length, the extra data is filled by '\0'.
+ * 4) truncate(2) doesn't change offset.
  */
 
+#include <errno.h>
+#include <unistd.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <fcntl.h>
-#include <errno.h>
 #include <string.h>
-#include <signal.h>
 
-#include "test.h"
+#include "tst_test.h"
+#include "tst_safe_prw.h"
 
-#define TESTFILE	"testfile"	/* file under test */
-#define FILE_MODE	S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
-#define BUF_SIZE	256	/* buffer size */
-#define FILE_SIZE	1024	/* test file size */
-#define TRUNC_LEN1	256	/* truncation length */
-#define TRUNC_LEN2	512	/* truncation length */
+#define TESTFILE	"testfile"
+#define FILE_SIZE	1024
+#define TRUNC_LEN1	256
+#define TRUNC_LEN2	512
 
-TCID_DEFINE(truncate02);
-int TST_TOTAL = 1;		/* Total number of test conditions */
-int fd;				/* file descriptor of testfile */
-char tst_buff[BUF_SIZE];	/* buffer to hold testfile contents */
+static int fd;
 
-void setup();			/* setup function for the test */
-void cleanup();			/* cleanup function for the test */
+static struct tcase {
+	off_t trunc_len;
+	off_t read_off;
+	off_t read_count;
+	char exp_char;
+} tcases[] = {
+	{TRUNC_LEN1, 0, TRUNC_LEN1, 'a'},
+	{TRUNC_LEN2, TRUNC_LEN1, TRUNC_LEN1, '\0'},
+};
 
-int main(int ac, char **av)
-{
-	struct stat stat_buf;	/* stat(2) struct contents */
-	int lc, i;
-	off_t file_length2;	/* test file length */
-	off_t file_length1;	/* test file length */
-	int rbytes;		/* bytes read from testfile */
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
-		 * Call truncate(2) to truncate a test file to a
-		 * specified length (TRUNC_LEN1).
-		 */
-		TEST(truncate(TESTFILE, TRUNC_LEN1));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL,
-				 "truncate(%s, %d) Failed, errno=%d : %s",
-				 TESTFILE, TRUNC_LEN1, TEST_ERRNO,
-				 strerror(TEST_ERRNO));
-		} else {
-			/*
-			 * Get the testfile information using
-			 * stat(2).
-			 */
-			if (stat(TESTFILE, &stat_buf) < 0) {
-				tst_brkm(TFAIL, cleanup, "stat(2) of "
-					 "%s failed after 1st truncate, "
-					 "error:%d", TESTFILE, errno);
-			}
-			file_length1 = stat_buf.st_size;
-
-			/*
-			 * Set the file pointer of testfile to the
-			 * beginning of the file.
-			 */
-			if (lseek(fd, 0, SEEK_SET) < 0) {
-				tst_brkm(TFAIL, cleanup, "lseek(2) on "
-					 "%s failed after 1st truncate, "
-					 "error:%d", TESTFILE, errno);
-			}
-
-			/* Read the testfile from the beginning. */
-			while ((rbytes = read(fd, tst_buff,
-					      sizeof(tst_buff))) > 0) {
-				read_len += rbytes;
-			}
-
-			/*
-			 * Execute truncate(2) again to truncate
-			 * testfile to a size TRUNC_LEN2.
-			 */
-			TEST(truncate(TESTFILE, TRUNC_LEN2));
-
-			if (TEST_RETURN == -1) {
-				tst_resm(TFAIL, "truncate of %s to "
-					 "size %d Failed, errno=%d : %s",
-					 TESTFILE, TRUNC_LEN2,
-					 TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			}
-
-			/*
-			 * Get the testfile information using
-			 * stat(2)
-			 */
-			if (stat(TESTFILE, &stat_buf) < 0) {
-				tst_brkm(TFAIL, cleanup, "stat(2) of "
-					 "%s failed after 2nd truncate, "
-					 "error:%d", TESTFILE, errno);
-			}
-			file_length2 = stat_buf.st_size;
-
-			/*
-			 * Set the file pointer of testfile to the
-			 * offset TRUNC_LEN1 of testfile.
-			 */
-			if (lseek(fd, TRUNC_LEN1, SEEK_SET) < 0) {
-				tst_brkm(TFAIL, cleanup, "lseek(2) on "
-					 "%s failed after 2nd truncate, "
-					 "error:%d", TESTFILE, errno);
-			}
-
-			/* Read the testfile contents till EOF */
-			while ((rbytes = read(fd, tst_buff,
-					      sizeof(tst_buff))) > 0) {
-				for (i = 0; i < rbytes; i++) {
-					if (tst_buff[i] != 0) {
-						err_flag++;
-					}
-				}
-			}
-
-			/*
-			 * Check for expected size of testfile after
-			 * issuing truncate(2) on it.
-			 */
-			if ((file_length1 != TRUNC_LEN1) ||
-			    (file_length2 != TRUNC_LEN2) ||
-			    (read_len != TRUNC_LEN1) ||
-			    (err_flag != 0)) {
-				tst_resm(TFAIL, "Functionality of "
-					 "truncate(2) on %s Failed",
-					 TESTFILE);
-			} else {
-				tst_resm(TPASS,
-					 "Functionality of truncate(2) "
-					 "on %s successful", TESTFILE);
-			}
-		}
-		tst_count++;	/* incr. TEST_LOOP counter */
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
+static void verify_truncate(unsigned int n)
 {
+	struct tcase *tc = &tcases[n];
+	struct stat stat_buf;
+	char read_buf[tc->read_count];
 	int i;
-	int wbytes;		/* bytes written to testfile */
-	int write_len = 0;	/* total no. of bytes written to testfile */
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	memset(read_buf, 'b', tc->read_count);
 
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -i option.
-	 * You want to make sure you do this before you create your temporary
-	 * directory.
-	 */
-	TEST_PAUSE;
+	TEST(truncate(TESTFILE, tc->trunc_len));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "truncate(%s, %ld) failed",
+			TESTFILE, tc->trunc_len);
+		return;
+	}
 
-	tst_tmpdir();
+	if (TST_RET != 0) {
+		tst_res(TFAIL | TTERRNO,
+			"truncate(%s, %ld) returned invalid value %ld",
+			TESTFILE, tc->trunc_len, TST_RET);
+		return;
+	}
 
-	/* Fill the test buffer with the known data */
-	for (i = 0; i < BUF_SIZE; i++) {
-		tst_buff[i] = 'a';
+	SAFE_STAT(TESTFILE, &stat_buf);
+	if (stat_buf.st_size != tc->trunc_len) {
+		tst_res(TFAIL, "%s: Incorrect file size %ld, expected %ld",
+			TESTFILE, stat_buf.st_size, tc->trunc_len);
+		return;
 	}
 
-	/* Creat a testfile  and write some data into it */
-	if ((fd = open(TESTFILE, O_RDWR | O_CREAT, FILE_MODE)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "open(%s, O_RDWR|O_CREAT, %o) Failed, errno=%d : %s",
-			 TESTFILE, FILE_MODE, errno, strerror(errno));
+	if (SAFE_LSEEK(fd, 0, SEEK_CUR)) {
+		tst_res(TFAIL, "truncate(%s, %ld) changes offset",
+			TESTFILE, tc->trunc_len);
+		return;
 	}
 
-	/* Write to the file 1k data from the buffer */
-	while (write_len < FILE_SIZE) {
-		if ((wbytes = write(fd, tst_buff, sizeof(tst_buff))) <= 0) {
-			tst_brkm(TBROK, cleanup,
-				 "write(2) on %s Failed, errno=%d : %s",
-				 TESTFILE, errno, strerror(errno));
-		} else {
-			write_len += wbytes;
+	SAFE_PREAD(1, fd, read_buf, tc->read_count, tc->read_off);
+	for (i = 0; i < tc->read_count; i++) {
+		if (read_buf[i] != tc->exp_char) {
+			tst_res(TFAIL, "%s: wrong content %c, expected %c",
+				TESTFILE, read_buf[i], tc->exp_char);
+			return;
 		}
 	}
+
+	tst_res(TPASS, "truncate(%s, %ld) succeeded",
+		TESTFILE, tc->trunc_len);
 }
 
-/*
- * void
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- *  Close the temporary file opened for reading/writing.
- *  Remove the test directory and testfile created in the setup.
- */
-void cleanup(void)
+static void setup(void)
 {
+	fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, 0644);
 
-	/* Close the testfile after writing data into it */
-	if (close(fd) == -1) {
-		tst_brkm(TFAIL, NULL,
-			 "close(%s) Failed, errno=%d : %s",
-			 TESTFILE, errno, strerror(errno));
-	}
+	tst_fill_fd(fd, 'a', FILE_SIZE, 1);
 
-	tst_rmdir();
+	SAFE_LSEEK(fd, 0, SEEK_SET);
+}
 
+static void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_truncate,
+};
-- 
2.21.0



