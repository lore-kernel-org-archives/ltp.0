From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 21 Jun 2017 14:12:17 +0800
Subject: [LTP] [PATCH 1/3] syscalls/lseek07: cleanup && convert to new API
Message-ID: <1498025539-24441-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/lseek/lseek07.c | 307 ++++++++----------------------
 1 file changed, 82 insertions(+), 225 deletions(-)

diff --git a/testcases/kernel/syscalls/lseek/lseek07.c b/testcases/kernel/syscalls/lseek/lseek07.c
index 6dfcab5..b46856b 100644
--- a/testcases/kernel/syscalls/lseek/lseek07.c
+++ b/testcases/kernel/syscalls/lseek/lseek07.c
@@ -1,253 +1,110 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
+ * 06/2017 modified by Xiao Yang <yangx.jy@cn.fujitsu.com>
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
+ * along with this program;  if not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
- * Test Name: lseek07
- *
- * Test Description:
- *  Verify that, lseek() call succeeds to set the file pointer position
- *  to more than the file size, when a file is opened for reading/writing.
- *
- * Expected Result:
- *  lseek() should return n+1, where n is the size of the file.
- *  Also when some data is written into this file it should start
- *  from that offset.
- *
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
- *  lseek07 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
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
+ * Description:
+ * lseek() succeeds to set the specified offset according to whence
+ * and write valid data from this location.
  */
 
-#include <stdio.h>
-#include <unistd.h>
-#include <sys/types.h>
 #include <errno.h>
-#include <fcntl.h>
-#include <utime.h>
 #include <string.h>
-#include <sys/stat.h>
-#include <signal.h>
-#include <inttypes.h>
-
-#include "test.h"
-
-#define TEMP_FILE	"tmp_file"
-#define FILE_MODE	S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
-
-char *TCID = "lseek07";
-int TST_TOTAL = 1;
-int fildes;			/* file handle for temp file */
-size_t file_size;		/* size of temporary file */
-char write_buf1[BUFSIZ];	/* buffer to hold data */
-char write_buf2[BUFSIZ];	/* buffer to hold data */
-
-void setup();			/* Main setup function of test */
-void cleanup();			/* cleanup function for the test */
-
-int main(int ac, char **av)
+#include <sys/types.h>
+#include <unistd.h>
+#include "tst_test.h"
+
+#define TFILE1 "tfile1"
+#define TFILE2 "tfile2"
+#define WR_STR1 "abcdefg"
+#define WR_STR2 "ijk"
+
+static int fd1, fd2;
+static struct tcase {
+	int *fd;
+	char *fname;
+	off_t off;
+	off_t exp_off;
+	int exp_size;
+	char *exp_data;
+} tcases[] = {
+	{&fd1, TFILE1, 7, 7, 10, "abcdefgijk"},
+	{&fd2, TFILE2, 2, 2, 7, "abijkfg"},
+};
+
+static void verify_lseek(unsigned int n)
 {
-	int lc;
-	char read_buf[BUFSIZ];	/* data read from temp. file */
-	off_t offset;		/* byte position in temporary file */
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/* Set the offset position */
-		offset = file_size + (lc * strlen(write_buf2));
-
-		/*
-		 * Invoke lseek(2) to move the write file
-		 * pointer/handle by the specified offset value.
-		 */
-		TEST(lseek(fildes, offset, SEEK_SET));
-
-		if (TEST_RETURN == (off_t) - 1) {
-			tst_resm(TFAIL | TTERRNO, "lseek on (%s) failed",
-				 TEMP_FILE);
-			continue;
-		}
-		/*
-		 * Check if the return value from lseek(2)
-		 * is equal to the specified offset value.
-		 */
-		if (TEST_RETURN != offset) {
-			tst_resm(TFAIL, "lseek() returned "
-				 "incorrect value %ld, expected "
-				 "%" PRId64, TEST_RETURN,
-				 (int64_t) offset);
-			continue;
-		}
-		/*
-		 * The return value is okay, now write some data at
-		 * the current offset position.
-		 */
-		if (write(fildes, write_buf2, strlen(write_buf2)) !=
-		    strlen(write_buf2)) {
-			tst_brkm(TFAIL | TERRNO, cleanup,
-				 "write() failed to write additional data");
-		}
-
-		/*
-		 * Now close the file and open it again
-		 * and read all of the data.
-		 */
-		if (close(fildes) < 0) {
-			tst_brkm(TFAIL, cleanup, "close() on %s Failed,"
-				 " errno = %d", TEMP_FILE, errno);
-		}
-
-		/* Open the file again in read/write mode */
-		if ((fildes = open(TEMP_FILE, O_RDWR)) < 0) {
-			tst_brkm(TFAIL, cleanup, "Could not open the "
-				 "%s readonly, error = %d",
-				 TEMP_FILE, errno);
-		}
-
-		/*
-		 * Now read all of the data.  The size should be the
-		 * offset + strlen(write_buf2).
-		 */
-		if (read(fildes, &read_buf, (offset +
-					     strlen(write_buf2))) < 0) {
-			tst_brkm(TFAIL, cleanup, "read() failed on %s, "
-				 "error=%d", TEMP_FILE, errno);
-		} else {
-			/*
-			 * Check data read is the complete data and not
-			 * the only portion written.
-			 */
-			if ((strncmp(read_buf, write_buf1,
-				     strlen(write_buf1))) != 0) {
-				tst_brkm(TFAIL, cleanup,
-					 "Incorrect data read #1 from "
-					 "file %s", TEMP_FILE);
-			}
-			if ((strncmp(&read_buf[offset], write_buf2,
-				     strlen(write_buf2))) != 0) {
-				tst_brkm(TFAIL, cleanup,
-					 "Incorrect data read #2 from "
-					 "file %s", TEMP_FILE);
-			}
-			tst_resm(TPASS, "Functionality of "
-				 "lseek() on %s successful", TEMP_FILE);
-		}
-	}
+	char read_buf[64];
+	struct tcase *tc = &tcases[n];
 
-	cleanup();
-	tst_exit();
-}
+	memset(read_buf, 0, sizeof(read_buf));
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- *	     Create a temporary directory and change directory to it.
- *	     Create a test file under temporary directory and write some
- *	     data into it.
- *	     Get the size of the file using fstat().
- */
-void setup(void)
-{
-	struct stat stat_buf;	/* struct buffer for stat(2) */
+	TEST(lseek(*tc->fd, tc->off, SEEK_SET));
+	if (TEST_RETURN == (off_t) -1) {
+		tst_res(TFAIL | TTERRNO, "lseek(%s, %ld, SEEK_SET) failed",
+			tc->fname, tc->off);
+		return;
+	}
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	if (TEST_RETURN != tc->exp_off) {
+		tst_res(TFAIL, "lseek(%s, %ld, SEEK_SET) returned %ld, expected %ld",
+			tc->fname, tc->off, TEST_RETURN, tc->exp_off);
+		return;
+	}
 
-	TEST_PAUSE;
+	SAFE_WRITE(1, *tc->fd, WR_STR2, sizeof(WR_STR2) - 1);
 
-	tst_tmpdir();
+	SAFE_CLOSE(*tc->fd);
 
-	/* Get the data to be written to temporary file */
-	strcpy(write_buf1, "abcdefg");
-	strcpy(write_buf2, "ijk");
+	*tc->fd = SAFE_OPEN(tc->fname, O_RDWR);
 
-	/* Creat/open a temporary file for writing under above directory */
-	if ((fildes = open(TEMP_FILE, O_WRONLY | O_CREAT, FILE_MODE)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "open(%s, O_WRONLY|O_CREAT, %#o) Failed, errno=%d :%s",
-			 TEMP_FILE, FILE_MODE, errno, strerror(errno));
-	}
+	SAFE_READ(1, *tc->fd, read_buf, tc->exp_size);
 
-	/* Write data into temporary file */
-	if (write(fildes, write_buf1, strlen(write_buf1)) != strlen(write_buf1)) {
-		tst_brkm(TBROK, cleanup, "write(2) on %s Failed, errno=%d : %s",
-			 TEMP_FILE, errno, strerror(errno));
+	if (strcmp(read_buf, tc->exp_data)) {
+		tst_res(TFAIL, "lseek(%s, %ld, SEEK_SET) wrote incorrect data %s",
+			tc->fname, tc->off, read_buf);
+	} else {
+		tst_res(TPASS, "lseek(%s, %ld, SEEK_SET) wrote correct data %s",
+			tc->fname, tc->off, read_buf);
 	}
-
-	/* Get the size of the temporary file after writing data */
-	if (fstat(fildes, &stat_buf) < 0) {
-		tst_brkm(TBROK, cleanup, "fstat() on %s Failed, errno=%d : %s",
-			 TEMP_FILE, errno, strerror(errno));
-	}
-
-	file_size = stat_buf.st_size;
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- *	       Remove the test directory and testfile created in the setup.
- */
-void cleanup(void)
+static void setup(void)
 {
+	fd1 = SAFE_OPEN(TFILE1, O_RDWR | O_CREAT, 0644);
+	fd2 = SAFE_OPEN(TFILE2, O_RDWR | O_CREAT, 0644);
 
-	/* Close the temporary file created */
-	if (close(fildes) < 0) {
-		tst_brkm(TFAIL, NULL, "close(%s) Failed, errno=%d : %s:",
-			 TEMP_FILE, errno, strerror(errno));
-	}
+	SAFE_WRITE(1, fd1, WR_STR1, sizeof(WR_STR1) - 1);
+	SAFE_WRITE(1, fd2, WR_STR1, sizeof(WR_STR1) - 1);
+}
 
-	tst_rmdir();
+static void cleanup(void)
+{
+	if (fd1 > 0)
+		SAFE_CLOSE(fd1);
 
+	if (fd2 > 0)
+		SAFE_CLOSE(fd2);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_lseek,
+	.needs_tmpdir = 1,
+};
-- 
1.8.3.1



