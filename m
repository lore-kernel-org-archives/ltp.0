From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 21 Jun 2017 14:12:19 +0800
Subject: [LTP] [PATCH 3/3] syscalls/lseek10: cleanup && convert to new API
In-Reply-To: <1498025539-24441-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1498025539-24441-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1498025539-24441-3-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) add SAFE_MKNOD macro
2) remove duplicate tests
3) merge lseek10 into lseek02

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 include/tst_safe_macros.h                 |   5 +
 lib/safe_macros.c                         |  14 ++
 runtest/ltplite                           |   1 -
 runtest/stress.part3                      |   1 -
 runtest/syscalls                          |   1 -
 testcases/kernel/syscalls/.gitignore      |   1 -
 testcases/kernel/syscalls/lseek/lseek02.c |  28 ++-
 testcases/kernel/syscalls/lseek/lseek10.c | 315 ------------------------------
 8 files changed, 38 insertions(+), 328 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/lseek/lseek10.c

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 09745c1..8245b68 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -433,4 +433,9 @@ int safe_fsync(const char *file, const int lineno, int fd);
 int safe_setsid(const char *file, const int lineno);
 #define SAFE_SETSID() safe_setsid(__FILE__, __LINE__)
 
+int safe_mknod(const char *file, const int lineno, const char *pathname,
+	mode_t mode, dev_t dev);
+#define SAFE_MKNOD(pathname, mode, dev) \
+	safe_mknod(__FILE__, __LINE__, (pathname), (mode), (dev))
+
 #endif /* SAFE_MACROS_H__ */
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 3ef9266..7ca1849 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -908,3 +908,17 @@ pid_t safe_setsid(const char *file, const int lineno)
 
 	return rval;
 }
+
+int safe_mknod(const char *file, const int lineno, const char *pathname,
+	mode_t mode, dev_t dev)
+{
+	int rval;
+
+	rval = mknod(pathname, mode, dev);
+	if (rval == -1) {
+		tst_brkm(TBROK | TERRNO, NULL,
+			 "%s:%d: mknod() failed", file, lineno);
+	}
+
+	return rval;
+}
diff --git a/runtest/ltplite b/runtest/ltplite
index 237a8b0..8b7b4b9 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -408,7 +408,6 @@ llseek03 llseek03
 lseek01 lseek01
 lseek02 lseek02
 lseek07 lseek07
-lseek10 lseek10
 lseek11 lseek11
 
 lstat01A symlink01 -T lstat01
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 7c2b534..3fffa22 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -334,7 +334,6 @@ llseek03 llseek03
 lseek01 lseek01
 lseek02 lseek02
 lseek07 lseek07
-lseek10 lseek10
 lseek11 lseek11
 
 lstat01A symlink01 -T lstat01
diff --git a/runtest/syscalls b/runtest/syscalls
index 754d077..1ff71d7 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -550,7 +550,6 @@ llseek03 llseek03
 lseek01 lseek01
 lseek02 lseek02
 lseek07 lseek07
-lseek10 lseek10
 lseek11 lseek11
 
 lstat01A symlink01 -T lstat01
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 888d622..64e6146 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -501,7 +501,6 @@
 /lseek/lseek01
 /lseek/lseek02
 /lseek/lseek07
-/lseek/lseek10
 /lseek/lseek11
 /lstat/lstat01
 /lstat/lstat01_64
diff --git a/testcases/kernel/syscalls/lseek/lseek02.c b/testcases/kernel/syscalls/lseek/lseek02.c
index 3c09879..66c7bee 100644
--- a/testcases/kernel/syscalls/lseek/lseek02.c
+++ b/testcases/kernel/syscalls/lseek/lseek02.c
@@ -33,13 +33,15 @@
 #include <sys/types.h>
 #include <unistd.h>
 #include <stdio.h>
+#include <sys/stat.h>
 #include "tst_test.h"
 
 #define TFILE "tfile"
-#define TFIFO "tfifo"
+#define TFIFO1 "tfifo1"
+#define TFIFO2 "tfifo2"
 
 static int bad_fd = -1;
-static int fd, pfd;
+static int fd, pfd1, pfd2;
 static int pfds[2];
 
 static struct tcase {
@@ -53,12 +55,15 @@ static struct tcase {
 	{&fd, 5, EINVAL},
 	{&fd, -1, EINVAL},
 	{&fd, 7, EINVAL},
-	{&pfd, SEEK_SET, ESPIPE},
-	{&pfd, SEEK_CUR, ESPIPE},
-	{&pfd, SEEK_END, ESPIPE},
+	{&pfd1, SEEK_SET, ESPIPE},
+	{&pfd1, SEEK_CUR, ESPIPE},
+	{&pfd1, SEEK_END, ESPIPE},
 	{&pfds[0], SEEK_SET, ESPIPE},
 	{&pfds[0], SEEK_CUR, ESPIPE},
 	{&pfds[0], SEEK_END, ESPIPE},
+	{&pfd2, SEEK_SET, ESPIPE},
+	{&pfd2, SEEK_CUR, ESPIPE},
+	{&pfd2, SEEK_END, ESPIPE},
 };
 
 static void verify_lseek(unsigned int n)
@@ -85,9 +90,11 @@ static void verify_lseek(unsigned int n)
 static void setup(void)
 {
 	fd = SAFE_OPEN(TFILE, O_RDWR | O_CREAT, 0777);
-	SAFE_MKFIFO(TFIFO, 0777);
-	pfd = SAFE_OPEN(TFIFO, O_RDWR, 0777);
+	SAFE_MKFIFO(TFIFO1, 0777);
+	pfd1 = SAFE_OPEN(TFIFO1, O_RDWR, 0777);
 	SAFE_PIPE(pfds);
+	SAFE_MKNOD(TFIFO2, S_IFIFO | 0777, 0);
+	pfd2 = SAFE_OPEN(TFIFO2, O_RDWR, 0777);
 }
 
 static void cleanup(void)
@@ -95,14 +102,17 @@ static void cleanup(void)
 	if (fd > 0)
 		SAFE_CLOSE(fd);
 
-	if (pfd > 0)
-		SAFE_CLOSE(pfd);
+	if (pfd1 > 0)
+		SAFE_CLOSE(pfd1);
 
 	if (pfds[0] > 0)
 		SAFE_CLOSE(pfds[0]);
 
 	if (pfds[1] > 0)
 		SAFE_CLOSE(pfds[1]);
+
+	if (pfd2 > 0)
+		SAFE_CLOSE(pfd2);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/lseek/lseek10.c b/testcases/kernel/syscalls/lseek/lseek10.c
deleted file mode 100644
index 7ee25af..0000000
--- a/testcases/kernel/syscalls/lseek/lseek10.c
+++ /dev/null
@@ -1,315 +0,0 @@
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
- * Test Name: lseek10
- *
- * Test Description:
- *  Verify that,
- *  1. lseek() returns -1 and sets errno to ESPIPE, if the file handle of
- *     the specified file is associated with a pipe, socket, or  FIFO.
- *  2. lseek() returns -1 and sets errno to EINVAL, if the 'Whence' argument
- *     is not a proper value.
- *  3. lseek() returns -1 and sets errno to EBADF, if the file handle of
- *     the specified file is not valid.
- *
- * Expected Result:
- *  lseek() should fail with return value -1 and set expected errno.
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
- *   	if errno set == expected errno
- *   		Issue sys call fails with expected return value and errno.
- *   	Otherwise,
- *		Issue sys call fails with unexpected errno.
- *   Otherwise,
- *	Issue sys call returns unexpected value.
- *
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *   Delete the temporary directory(s)/file(s) created.
- *
- * Usage:  <for command-line>
- *  lseek10 [-c n] [-e] [-i n] [-I x] [-p x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
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
-#include <unistd.h>
-#include <fcntl.h>
-#include <utime.h>
-#include <string.h>
-#include <sys/stat.h>
-#include <signal.h>
-
-#include "test.h"
-
-#define TEMP_FILE1	"tmp_file1"
-#define TEMP_FILE2	"tmp_file2"
-#define TEMP_FILE3	"tmp_file3"
-#define FILE_MODE	S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
-#define PIPE_MODE	S_IFIFO | S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
-#define SEEK_TOP	10
-
-char *TCID = "lseek10";
-int TST_TOTAL = 3;
-
-int no_setup();
-int setup1();			/* setup function to test lseek() for ESPIPE */
-int setup2();			/* setup function to test lseek() for EINVAL */
-int setup3();			/* setup function to test lseek() for EBADF */
-
-int fd1;			/* file handle for testfile1  */
-int fd2;			/* file handle for testfile2  */
-int fd3;			/* file handle for testfile3  */
-
-struct test_case_t {		/* test case struct. to hold ref. test cond's */
-	int fd;
-	int Whence;
-	char *desc;
-	int exp_errno;
-	int (*setupfunc) ();
-} Test_cases[] = {
-	{
-	1, SEEK_SET, "'fd' associated with a pipe/fifo", ESPIPE, setup1}, {
-	2, SEEK_TOP, "'whence' argument is not valid", EINVAL, setup2}, {
-	3, SEEK_SET, "'fd' is not an open file descriptor", EBADF, setup3},
-	{
-	0, 0, NULL, 0, no_setup}
-};
-
-void setup();			/* Main setup function of test */
-void cleanup();			/* cleanup function for the test */
-
-int main(int ac, char **av)
-{
-	int lc;
-	int fildes;		/* file handle for testfile */
-	int whence;		/* position of file handle in the file */
-	char *test_desc;	/* test specific error message */
-	int ind;		/* counter to test different test conditions */
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
-			fildes = Test_cases[ind].fd;
-			test_desc = Test_cases[ind].desc;
-			whence = Test_cases[ind].Whence;
-
-			/* Assign the 'fd' values appropriatly */
-			if (fildes == 1) {
-				fildes = fd1;
-			} else if (fildes == 2) {
-				fildes = fd2;
-			} else {
-				fildes = fd3;
-			}
-			/*
-			 * Invoke lseek(2) to test different test conditions.
-			 * Verify that it fails with -1 return value and
-			 * sets appropriate errno.
-			 */
-			TEST(lseek(fildes, 0, whence));
-
-			if (TEST_RETURN != (off_t) - 1) {
-				tst_resm(TFAIL,
-					 "lseek() returned %ld, expected "
-					 "-1, errno:%d", TEST_RETURN,
-					 Test_cases[ind].exp_errno);
-				continue;
-			}
-			if (TEST_ERRNO == Test_cases[ind].exp_errno) {
-				tst_resm(TPASS, "lseek() fails, %s, errno:%d",
-					 test_desc, TEST_ERRNO);
-			} else {
-				tst_resm(TFAIL, "lseek() fails, %s, errno:%d, "
-					 "expected errno:%d", test_desc,
-					 TEST_ERRNO, Test_cases[ind].exp_errno);
-			}
-		}
-	}
-
-	cleanup();
-	tst_exit();
-
-}
-
-/*
- * setup() - performs all ONE TIME setup for this test.
- *	     Create a temporary directory and change directory to it.
- *	     Invoke individual test setup functions according to the order
- *	     set in test struct. definition.
- */
-void setup(void)
-{
-	int ind;
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	/* call individual setup functions */
-	for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
-		Test_cases[ind].setupfunc();
-	}
-}
-
-/*
- * no_setup() - This is a dummy function which simply returns 0.
- */
-int no_setup(void)
-{
-	return 0;
-}
-
-/*
- * setup1() - setup function for a test condition for which lseek(2)
- *	      returns -1 and sets errno to ESPIPE.
- *	      Creat a named pipe/fifo using mknod() and open it for
- *	      reading/writing.
- *	      This function returns 0 on success.
- */
-int setup1(void)
-{
-	/* Creat a named pipe/fifo using mknod() */
-	if (mknod(TEMP_FILE1, PIPE_MODE, 0) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "mknod(%s, %#o, 0) Failed, errno=%d :%s",
-			 TEMP_FILE1, FILE_MODE, errno, strerror(errno));
-	}
-
-	/* Open the named pipe/fifo for reading/writing */
-	if ((fd1 = open(TEMP_FILE1, O_RDWR)) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "open(%s, O_RDWR) Failed, errno=%d, :%s",
-			 TEMP_FILE1, errno, strerror(errno));
-	}
-
-	return 0;
-}
-
-/*
- * setup2() - setup function for a test condition for which lseek(2)
- *	      returns -1 and sets errno to EINVAL.
- *	      Creat a temporary file for reading/writing and write some data
- *	      into it.
- *	      This function returns 0 on success.
- */
-int setup2(void)
-{
-	char write_buff[BUFSIZ];	/* buffer to hold data */
-
-	/* Get the data to be written to temporary file */
-	strcpy(write_buff, "abcdefg");
-
-	/* Creat/open a temporary file under above directory */
-	if ((fd2 = open(TEMP_FILE2, O_RDWR | O_CREAT, FILE_MODE)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "open(%s, O_RDWR|O_CREAT, %#o) Failed, errno=%d :%s",
-			 TEMP_FILE2, FILE_MODE, errno, strerror(errno));
-	}
-
-	/* Write data into temporary file */
-	if (write(fd2, write_buff, sizeof(write_buff)) <= 0) {
-		tst_brkm(TBROK, cleanup,
-			 "write(2) on %s Failed, errno=%d : %s",
-			 TEMP_FILE2, errno, strerror(errno));
-	}
-
-	return 0;
-}
-
-/*
- * setup3() - setup function for a test condition for which lseek(2)
- *	      returns -1 and sets errno to EBADF.
- *	      Creat a temporary file for reading/writing and close it.
- *	      This function returns 0 on success.
- */
-int setup3(void)
-{
-	/* Creat/open a temporary file under above directory */
-	if ((fd3 = open(TEMP_FILE3, O_RDWR | O_CREAT, FILE_MODE)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "open(%s, O_RDWR|O_CREAT, %#o) Failed, errno=%d :%s",
-			 TEMP_FILE3, FILE_MODE, errno, strerror(errno));
-	}
-
-	/* Close the temporary file created above */
-	if (close(fd3) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "close(%s) Failed, errno=%d : %s:",
-			 TEMP_FILE3, errno, strerror(errno));
-	}
-
-	return 0;
-}
-
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- *	       Remove the test directory and testfile(s) created in the setup.
- */
-void cleanup(void)
-{
-
-	/* Close the temporary file(s) created in setup1/setup2 */
-	if (close(fd1) < 0) {
-		tst_brkm(TFAIL, NULL,
-			 "close(%s) Failed, errno=%d : %s:",
-			 TEMP_FILE1, errno, strerror(errno));
-	}
-	if (close(fd2) < 0) {
-		tst_brkm(TFAIL, NULL,
-			 "close(%s) Failed, errno=%d : %s:",
-			 TEMP_FILE2, errno, strerror(errno));
-	}
-
-	tst_rmdir();
-
-}
-- 
1.8.3.1



