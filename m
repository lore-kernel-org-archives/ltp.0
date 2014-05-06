Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WhaTU-0001CY-Cv
	for ltp-list@lists.sourceforge.net; Tue, 06 May 2014 08:11:40 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WhaTR-000243-ND
	for ltp-list@lists.sourceforge.net; Tue, 06 May 2014 08:11:40 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s468B1HO030718
	for <ltp-list@lists.sourceforge.net>; Tue, 6 May 2014 16:11:01 +0800
Message-ID: <53689895.8080505@cn.fujitsu.com>
Date: Tue, 6 May 2014 16:08:53 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080409050706080801020404"
Subject: [LTP] [PATCH v2 1/2] pwrite/pwrite02.c: cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP <ltp-list@lists.sourceforge.net>

--------------080409050706080801020404
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Hi,

   In pwrite/pwrite03.c, there is a invalid character encoding and it causes
that "git am" failed, so I send this patch as a attachment, thanks.

Regards,
Wang

--------------080409050706080801020404
Content-Type: text/x-patch; name="v2-0001-pwrite-pwrite02.c-cleanup.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="v2-0001-pwrite-pwrite02.c-cleanup.patch"

From d434449268b94176a4e5f1040d9735f312b00fb9 Mon Sep 17 00:00:00 2001
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Tue, 6 May 2014 09:32:58 +0800
Subject: [PATCH v2 1/2] pwrite/pwrite02.c: cleanup

Merge pwrite02, pwrite03 into one pwrite02 test, which contains
ESPIPE, EINVAL, EBADF and EFAULT tests.

Remove useless comments and make use of SAFE_MACROS().

Delete some useless code and do some code re-arrangement.

printf() is not async-signal-safe, so use write(2) in signal handler directly.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 runtest/ltplite                             |   2 -
 runtest/stress.part3                        |   2 -
 runtest/syscalls                            |   2 -
 testcases/kernel/syscalls/.gitignore        |   2 -
 testcases/kernel/syscalls/pwrite/pwrite02.c | 322 +++++++++-------------------
 testcases/kernel/syscalls/pwrite/pwrite03.c | 211 ------------------
 6 files changed, 101 insertions(+), 440 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/pwrite/pwrite03.c

diff --git a/runtest/ltplite b/runtest/ltplite
index ebe171e..f076c5a 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -595,12 +595,10 @@ ptrace05 ptrace05
 
 pwrite01 pwrite01
 pwrite02 pwrite02
-pwrite03 pwrite03
 pwrite04 pwrite04
 
 pwrite01_64 pwrite01_64
 pwrite02_64 pwrite02_64
-pwrite03_64 pwrite03_64
 pwrite04_64 pwrite04_64
 
 read01 read01
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index b4ad297..1ef5401 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -505,12 +505,10 @@ ptrace03 ptrace03
 
 pwrite01 pwrite01
 pwrite02 pwrite02
-pwrite03 pwrite03
 pwrite04 pwrite04
 
 pwrite01_64 pwrite01_64
 pwrite02_64 pwrite02_64
-pwrite03_64 pwrite03_64
 pwrite04_64 pwrite04_64
 
 read01 read01
diff --git a/runtest/syscalls b/runtest/syscalls
index fb3e59f..75017fb 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -787,12 +787,10 @@ ptrace05 ptrace05
 
 pwrite01 pwrite01
 pwrite02 pwrite02
-pwrite03 pwrite03
 pwrite04 pwrite04
 
 pwrite01_64 pwrite01_64
 pwrite02_64 pwrite02_64
-pwrite03_64 pwrite03_64
 pwrite04_64 pwrite04_64
 
 quotactl01 quotactl01
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index d5c7bac..bcbc055 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -648,8 +648,6 @@
 /pwrite/pwrite01_64
 /pwrite/pwrite02
 /pwrite/pwrite02_64
-/pwrite/pwrite03
-/pwrite/pwrite03_64
 /pwrite/pwrite04
 /pwrite/pwrite04_64
 /quotactl/quotactl01
diff --git a/testcases/kernel/syscalls/pwrite/pwrite02.c b/testcases/kernel/syscalls/pwrite/pwrite02.c
index ff1d732..c9fc840 100644
--- a/testcases/kernel/syscalls/pwrite/pwrite02.c
+++ b/testcases/kernel/syscalls/pwrite/pwrite02.c
@@ -18,52 +18,16 @@
  */
 
 /*
- * Test Name: pwrite02
- *
  * Test Description:
  *  Verify that,
- *   1) pwrite() fails when attempted to write to an unnamed pipe.
- *   2) pwrite() fails if the specified offset position was invalid.
- *
- * Expected Result:
- *  1) pwrite() should return -1 and set errno to ESPIPE.
- *  2) pwrite() should return -1 and set errno to EINVAL.
- *
- * Algorithm:
- *  Setup:
- *   Setup signal handling.
- *   Create a temporary directory.
- *   Pause for SIGUSR1 if option specified.
- *
- *  Test:
- *   Loop if the proper options are given.
- *   Execute system call
- *   Check return code, if system call failed (return=-1)
- *      if errno set == expected errno
- *              Issue sys call fails with expected return value and errno.
- *      Otherwise,
- *              Issue sys call fails with unexpected errno.
- *   Otherwise,
- *      Issue sys call returns unexpected value.
- *
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *   Delete the temporary directory(s)/file(s) created.
- *
- * Usage:  <for command-line>
- *  pwrite02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
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
+ *   1) pwrite() fails when attempted to write to an unnamed pipe,
+ *      returns ESPIPE.
+ *   2) pwrite() fails if the specified offset position was invalid,
+ *   	returns EINVAL.
+ *   3) pwrite() fails if fd is not a valid file descriptor,
+ *	returns EBADF.
+ *   4) pwrite() fails when attempted to write with buf outside
+ *      accessible address space, returns EFAULT.
  */
 
 #define _XOPEN_SOURCE 500
@@ -74,111 +38,60 @@
 
 #include "test.h"
 #include "usctest.h"
+#include "safe_macros.h"
 
 #define TEMPFILE	"pwrite_file"
-#define K1              1024
-#define NBUFS           4
+#define K1		1024
 
-char *TCID = "pwrite02";
-int TST_TOTAL = 2;
+TCID_DEFINE(pwrite02);
 
-char *write_buf[NBUFS];		/* buffer to hold data to be written */
-int pfd[2];			/* pair of file descriptors */
-int fd1;			/* file descriptor of temporary file */
+static char write_buf[K1];
 
-void setup(void);			/* Main setup function of test */
-void cleanup(void);			/* cleanup function for the test */
-int setup1(void);			/* setup function for test #1 */
-int setup2(void);			/* setup function for test #2 */
-int no_setup(void);
-void init_buffers(void);		/* function to initialize/allocate buffers */
+static void setup(void);
+static void cleanup(void);
 
-int exp_enos[] = { ESPIPE, EINVAL, EBADF, 0 };
+static int exp_enos[] = {
+	ESPIPE, EINVAL, EBADF,
+#if !defined(UCLINUX)
+	EFAULT,
+#endif
+0 };
 
-struct test_case_t {		/* test case struct. to hold ref. test cond's */
-	int fd;
-	size_t nb;
-	off_t offst;
-	char *desc;
-	int exp_errno;
-	int (*setupfunc) ();
-} Test_cases[] = {
-	{
-	1, K1, 0, "file descriptor is a PIPE or FIFO", ESPIPE, setup1}, {
-	2, K1, -1, "specified offset is -ve or invalid", EINVAL, setup2}, {
-	3, K1, 0, "file descriptor is bad", EBADF, no_setup}, {
-	0, 0, 0, NULL, 0, no_setup}
+static void test_espipe(void);
+static void test_einval(void);
+static void test_ebadf(void);
+
+#if !defined(UCLINUX)
+static void test_efault(void);
+#endif
+
+static void (*testfunc[])(void) = {
+	test_espipe, test_einval, test_ebadf,
+#if !defined(UCLINUX)
+	test_efault
+#endif
 };
 
+int TST_TOTAL = ARRAY_SIZE(testfunc);
+
 int main(int ac, char **av)
 {
-	int lc;
+	int i, lc;
 	char *msg;
-	int i;
-	int fildes;		/* file descriptor of test file */
-	size_t nbytes;		/* no. of bytes to be written */
-	off_t offset;		/* offset position in the specified file */
-	char *test_desc;	/* test specific error message */
 
 	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
 	setup();
 
-	TEST_EXP_ENOS(exp_enos);
-
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
 		tst_count = 0;
 
-		for (i = 0; Test_cases[i].desc != NULL; i++) {
-			fildes = Test_cases[i].fd;
-			test_desc = Test_cases[i].desc;
-			nbytes = Test_cases[i].nb;
-			offset = Test_cases[i].offst;
-
-			if (fildes == 1) {
-				fildes = pfd[1];
-			} else if (fildes == 2) {
-				fildes = fd1;
-			} else {
-				fildes = -1;
-			}
-
-			/*
-			 * Call pwrite() with the specified file descriptor,
-			 * no. of bytes to be written at specified offset.
-			 * and verify that call should fail with appropriate
-			 * errno. set.
-			 */
-			TEST(pwrite(fildes, write_buf[0], nbytes, offset));
-
-			/* Check for the return code of pwrite() */
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "pwrite() returned %ld, "
-					 "expected -1, errno:%d",
-					 TEST_RETURN, Test_cases[i].exp_errno);
-				continue;
-			}
-
-			TEST_ERROR_LOG(TEST_ERRNO);
-
-			/*
-			 * Verify whether expected errno is set.
-			 */
-			if (TEST_ERRNO == Test_cases[i].exp_errno) {
-				tst_resm(TPASS, "%s, errno:%d",
-					 test_desc, TEST_ERRNO);
-			} else {
-				tst_resm(TFAIL, "%s, unexpected"
-					 " errno:%d, expected:%d", test_desc,
-					 TEST_ERRNO, Test_cases[i].exp_errno);
-			}
-		}
+		for (i = 0; i < TST_TOTAL; i++)
+			(*testfunc[i])();
 	}
 
 	cleanup();
-
 	tst_exit();
 }
 
@@ -189,25 +102,19 @@ int main(int ac, char **av)
  * test case passes on a machine running RedHat 6.2 but it will fail
  * on a machine running RedHat 7.1.
  */
-void sighandler(int sig)
+static void sighandler(int sig)
 {
 	if (sig != SIGXFSZ) {
-		printf("wrong signal\n");
+		write(STDOUT_FILENO, "get wrong signal\n",
+		      sizeof("get wrong signal\n"));
 	} else {
-		printf("caught SIGXFSZ\n");
+		write(STDOUT_FILENO, "caught SIGXFSZ\n",
+		      sizeof("caught SIGXFSZ\n"));
 	}
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- *
- *  Initialize/allocate write buffer.
- *  Call individual setup function.
- */
-void setup(void)
+static void setup(void)
 {
-	int i;
-
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	/* see the comment in the sighandler() function */
@@ -216,117 +123,90 @@ void setup(void)
 		tst_brkm(TBROK, cleanup, "signal() failed");
 	}
 
+	TEST_EXP_ENOS(exp_enos);
+
 	TEST_PAUSE;
 
-	/* Allocate/Initialize the write buffer with known data */
-	init_buffers();
+	tst_tmpdir();
 
-	/* Call individual setup functions */
-	for (i = 0; Test_cases[i].desc != NULL; i++) {
-		Test_cases[i].setupfunc();
-	}
+	memset(write_buf, 'a', K1);
 }
 
-/*
- * no_setup() - This function simply returns.
- */
-int no_setup(void)
+static void print_test_result(int err, int exp_errno)
 {
-	return 0;
+	if (err == 0) {
+		tst_resm(TFAIL, "call succeeded unexpectedly");
+		return;
+	}
+
+	TEST_ERROR_LOG(err);
+
+	if (err == exp_errno) {
+		tst_resm(TPASS, "pwrite failed as expected: %d - %s",
+			 err, strerror(err));
+	} else {
+		tst_resm(TFAIL, "pwrite failed unexpectedly; expected: %d - %s"
+			 "return: %d - %s", exp_errno, strerror(exp_errno),
+			 err, strerror(err));
+	}
 }
 
-/*
- * setup1() - setup function for a test condition for which pwrite()
- *	      returns -ve value and sets errno to ESPIPE.
- *
- *  Create an unnamed pipe using pipe().
- *  return 0.
- */
-int setup1(void)
+static void test_espipe(void)
 {
-	/* Create an unnamed pipe */
-	if (pipe(pfd) < 0) {
-		tst_brkm(TBROK, cleanup, "pipe() failed, error:%d", errno);
-	}
+	int pipe_fds[2];
 
-	return 0;
+	SAFE_PIPE(cleanup, pipe_fds);
+
+	TEST(pwrite(pipe_fds[1], write_buf, K1, 0));
+
+	print_test_result(errno, ESPIPE);
+
+	SAFE_CLOSE(cleanup, pipe_fds[0]);
+	SAFE_CLOSE(cleanup, pipe_fds[1]);
 }
 
-/*
- * setup2 - setup function for a test condition for which pwrite()
- * 	    returns -ve value and sets errno to EINVAL.
- *
- *  Create a temporary directory and a file under it.
- *  return 0.
- */
-int setup2(void)
+static void test_einval(void)
 {
+	int fd;
 
-	tst_tmpdir();
+	fd = SAFE_OPEN(cleanup, TEMPFILE, O_RDWR | O_CREAT, 0666);
 
-	/* Creat a temporary file used for mapping */
-	if ((fd1 = open(TEMPFILE, O_RDWR | O_CREAT, 0666)) < 0) {
-		tst_brkm(TBROK, cleanup, "open() on %s Failed, errno=%d : %s",
-			 TEMPFILE, errno, strerror(errno));
-	}
+	/* the specified offset was invalid */
+	TEST(pwrite(fd, write_buf, K1, -1));
+
+	print_test_result(errno, EINVAL);
 
-	return 0;
+	SAFE_CLOSE(cleanup, fd);
 }
 
-/*
- * init_buffers() - allocate/Initialize write_buf array.
- *
- *  Allocate write buffer.
- *  Fill the write buffer with the following data like,
- *    write_buf[0] has 0's, write_buf[1] has 1's, write_buf[2] has 2's
- *    write_buf[3] has 3's.
- */
-void init_buffers(void)
+static void test_ebadf(void)
 {
-	int count;		/* counter variable for loop */
+	int fd = -1;
 
-	/* Allocate and Initialize write buffer with known data */
-	for (count = 0; count < NBUFS; count++) {
-		write_buf[count] = (char *)malloc(K1);
+	TEST(pwrite(fd, write_buf, K1, 0));
 
-		if (write_buf[count] == NULL) {
-			tst_brkm(TBROK, NULL,
-				 "malloc() failed on write buffer");
-		}
-		memset(write_buf[count], count, K1);
-	}
+	print_test_result(errno, EBADF);
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- *
- * Deallocate the memory allocated to write buffer.
- * Close the temporary file.
- * Remove the temporary directory created.
- */
-void cleanup(void)
+#if !defined(UCLINUX)
+static void test_efault(void)
 {
-	int count;		/* index for the loop */
+	int fd;
+	char *buf = sbrk(0);
 
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
-	TEST_CLEANUP;
+	fd = SAFE_OPEN(cleanup, TEMPFILE, O_RDWR | O_CREAT, 0666);
 
-	/* Free the memory allocated for the write buffer */
-	for (count = 0; count < NBUFS; count++) {
-		free(write_buf[count]);
-	}
+	TEST(pwrite(fd, buf, K1, 0));
 
-	/* Close the temporary file created in setup2 */
-	if (close(fd1) < 0) {
-		tst_brkm(TBROK, NULL,
-			 "close() on %s Failed, errno=%d : %s",
-			 TEMPFILE, errno, strerror(errno));
-	}
+	print_test_result(errno, EFAULT);
 
-	tst_rmdir();
+	SAFE_CLOSE(cleanup, fd);
+}
+#endif
 
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+
+	tst_rmdir();
 }
diff --git a/testcases/kernel/syscalls/pwrite/pwrite03.c b/testcases/kernel/syscalls/pwrite/pwrite03.c
deleted file mode 100644
index d4cbf1e..0000000
--- a/testcases/kernel/syscalls/pwrite/pwrite03.c
+++ /dev/null
@@ -1,211 +0,0 @@
-/*
- *   Copyright (C) Bull S.A. 2001
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
- * Test Name: pwrite03
- *
- * Test Description:
- *  Verify that,
- *      pwrite(2) fails when attempted to write with buf outside accessible
- *      address space.
- *
- * Expected Result:
- *      pwrite() should return -1 and set errno to EFAULT.
- *
- * Algorithm:
- *  Setup:
- *   Setup signal handling.
- *   Create a temporary directory/file.
- *
- *  Test:
- *   Loop if the proper options are given.
- *   Execute system call
- *   Check return code, if system call failed (return=-1)
- *      if errno set == expected errno
- *              Issue sys call fails with expected return value and errno.
- *      Otherwise,
- *              Issue sys call fails with unexpected errno.
- *   Otherwise,
- *      Issue sys call returns unexpected value.
- *
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *   Delete the temporary directory(s)/file(s) created.
- *
- * Usage:  <for command-line>
- *  pwrite03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	04/2002 Ported by Andr� Merlier
- *
- * RESTRICTIONS:
- *  None.
- */
-
-#define _XOPEN_SOURCE 500
-
-#include <errno.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <fcntl.h>
-
-#include "test.h"
-#include "usctest.h"
-
-#define TEMPFILE	"pwrite_file"
-#define NBUFS           1
-
-char *TCID = "pwrite03";
-int TST_TOTAL = 1;
-
-char *write_buf[NBUFS];		/* buffer to hold data to be written */
-int fd1;			/* file descriptor of temporary file */
-
-void setup();			/* Main setup function of test */
-void cleanup();			/* cleanup function for the test */
-void init_buffers();		/* function to initialize/allocate buffers */
-
-int exp_enos[] = { EFAULT, 0 };
-
-#if !defined(UCLINUX)
-
-int main(int ac, char **av)
-{
-	int lc;
-	char *msg;
-	size_t nbytes;		/* no. of bytes to be written */
-	off_t offset;		/* offset position in the specified file */
-	char *test_desc;	/* test specific error message */
-
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
-		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-
-	setup();
-
-	TEST_EXP_ENOS(exp_enos);
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		test_desc = "EFAULT";
-		nbytes = 1024;
-		offset = 1;
-		write_buf[0] = sbrk(0);
-
-		/*
-		 * Call pwrite() with the specified file descriptor,
-		 * no. of bytes to be written at specified offset.
-		 * and verify that call should fail with appropriate
-		 * errno. set.
-		 */
-		TEST(pwrite(fd1, write_buf[0], nbytes, offset));
-
-		/* Check for the return code of pwrite() */
-		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "pwrite() returned %ld, "
-				 "expected -1, errno:%d",
-				 TEST_RETURN, exp_enos[0]);
-		}
-
-		TEST_ERROR_LOG(TEST_ERRNO);
-
-		/*
-		 * Verify whether expected errno is set.
-		 */
-		if (TEST_ERRNO == exp_enos[0]) {
-			tst_resm(TPASS, "pwrite() fails with expected "
-				 "error EFAULT errno:%d", TEST_ERRNO);
-		} else {
-			tst_resm(TFAIL, "pread() fails, %s, unexpected "
-				 "errno:%d, expected:%d\n", test_desc,
-				 TEST_ERRNO, exp_enos[0]);
-		}
-
-	}
-
-	cleanup();
-	tst_exit();
-	tst_exit();
-
-}
-
-#else
-
-int main(void)
-{
-	tst_resm(TINFO, "test is not available on uClinux");
-	tst_exit();
-}
-
-#endif /* if !defined(UCLINUX) */
-
-/*
- * setup() - performs all ONE TIME setup for this test.
- *
- *  Initialize/allocate write buffer.
- */
-void setup(void)
-{
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	/* Creat a temporary file used for mapping */
-	if ((fd1 = open(TEMPFILE, O_RDWR | O_CREAT, 0777)) < 0) {
-		tst_brkm(TBROK, cleanup, "open() on %s Failed, errno=%d : %s",
-			 TEMPFILE, errno, strerror(errno));
-	}
-}
-
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- *
- * Close the temporary file.
- * Remove the temporary directory created.
- */
-void cleanup(void)
-{
-
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
-	TEST_CLEANUP;
-
-	/* Close the temporary file created in setup2 */
-	if (close(fd1) < 0) {
-		tst_brkm(TBROK, NULL,
-			 "close() on %s Failed, errno=%d : %s",
-			 TEMPFILE, errno, strerror(errno));
-	}
-
-	tst_rmdir();
-
-}
-- 
1.8.2.1


--------------080409050706080801020404
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
--------------080409050706080801020404
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------080409050706080801020404--

