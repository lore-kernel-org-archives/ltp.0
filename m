Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WTRll-00070f-Ba
	for ltp-list@lists.sourceforge.net; Fri, 28 Mar 2014 08:04:05 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WTRlh-0004aF-NM
	for ltp-list@lists.sourceforge.net; Fri, 28 Mar 2014 08:04:05 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s2S83rBZ032720
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Mar 2014 16:03:53 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Fri, 28 Mar 2014 16:02:05 +0800
Message-Id: <1395993726-10999-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/2] pwrite/pwrite02.c: cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4897997989799429578=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============4897997989799429578==
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: quoted-printable

Merge pwrite02, pwrite03 into one pwrite02 test, which contains
ESPIPE, EINVAL, EBADF and EFAULT tests.

Remove useless comments and make use of SAFE=5FMACROS().

Delete some useless code and do some code re-arrangement.

printf() is not async-signal-safe, so use write(2) in signal handler direct=
ly.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 runtest/ltplite                             |   2 -
 runtest/stress.part3                        |   2 -
 runtest/syscalls                            |   2 -
 testcases/kernel/syscalls/.gitignore        |   2 -
 testcases/kernel/syscalls/pwrite/pwrite02.c | 322 +++++++++---------------=
----
 testcases/kernel/syscalls/pwrite/pwrite03.c | 211 ------------------
 6 files changed, 101 insertions(+), 440 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/pwrite/pwrite03.c

diff --git a/runtest/ltplite b/runtest/ltplite
index ebe171e..f076c5a 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -595,12 +595,10 @@ ptrace05 ptrace05
=20
 pwrite01 pwrite01
 pwrite02 pwrite02
-pwrite03 pwrite03
 pwrite04 pwrite04
=20
 pwrite01=5F64 pwrite01=5F64
 pwrite02=5F64 pwrite02=5F64
-pwrite03=5F64 pwrite03=5F64
 pwrite04=5F64 pwrite04=5F64
=20
 read01 read01
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index b21e44b..3a1fc81 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -505,12 +505,10 @@ ptrace03 ptrace03
=20
 pwrite01 pwrite01
 pwrite02 pwrite02
-pwrite03 pwrite03
 pwrite04 pwrite04
=20
 pwrite01=5F64 pwrite01=5F64
 pwrite02=5F64 pwrite02=5F64
-pwrite03=5F64 pwrite03=5F64
 pwrite04=5F64 pwrite04=5F64
=20
 read01 read01
diff --git a/runtest/syscalls b/runtest/syscalls
index fb3e59f..75017fb 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -787,12 +787,10 @@ ptrace05 ptrace05
=20
 pwrite01 pwrite01
 pwrite02 pwrite02
-pwrite03 pwrite03
 pwrite04 pwrite04
=20
 pwrite01=5F64 pwrite01=5F64
 pwrite02=5F64 pwrite02=5F64
-pwrite03=5F64 pwrite03=5F64
 pwrite04=5F64 pwrite04=5F64
=20
 quotactl01 quotactl01
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscal=
ls/.gitignore
index d5c7bac..bcbc055 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -648,8 +648,6 @@
 /pwrite/pwrite01=5F64
 /pwrite/pwrite02
 /pwrite/pwrite02=5F64
-/pwrite/pwrite03
-/pwrite/pwrite03=5F64
 /pwrite/pwrite04
 /pwrite/pwrite04=5F64
 /quotactl/quotactl01
diff --git a/testcases/kernel/syscalls/pwrite/pwrite02.c b/testcases/kernel=
/syscalls/pwrite/pwrite02.c
index 57dc7de..31f1b79 100644
--- a/testcases/kernel/syscalls/pwrite/pwrite02.c
+++ b/testcases/kernel/syscalls/pwrite/pwrite02.c
@@ -18,52 +18,16 @@
  */
=20
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
- *   Check return code, if system call failed (return=3D-1)
- *      if errno set =3D=3D expected errno
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
+ *      accessible address space.
  */
=20
 #define =5FXOPEN=5FSOURCE 500
@@ -74,111 +38,60 @@
=20
 #include "test.h"
 #include "usctest.h"
+#include "safe=5Fmacros.h"
=20
 #define TEMPFILE	"pwrite=5Ffile"
-#define K1              1024
-#define NBUFS           4
+#define K1		1024
=20
-char *TCID =3D "pwrite02";
-int TST=5FTOTAL =3D 2;
+TCID=5FDEFINE(pwrite02);
=20
-char *write=5Fbuf[NBUFS];		/* buffer to hold data to be written */
-int pfd[2];			/* pair of file descriptors */
-int fd1;			/* file descriptor of temporary file */
+static char write=5Fbuf[K1];
=20
-void setup();			/* Main setup function of test */
-void cleanup();			/* cleanup function for the test */
-int setup1();			/* setup function for test #1 */
-int setup2();			/* setup function for test #2 */
-int no=5Fsetup();
-void init=5Fbuffers();		/* function to initialize/allocate buffers */
+static void setup(void);
+static void cleanup(void);
=20
-int exp=5Fenos[] =3D { ESPIPE, EINVAL, EBADF, 0 };
+static int exp=5Fenos[] =3D {
+	ESPIPE, EINVAL, EBADF,
+#if !defined(UCLINUX)
+	EFAULT,
+#endif
+0 };
=20
-struct test=5Fcase=5Ft {		/* test case struct. to hold ref. test cond's */
-	int fd;
-	size=5Ft nb;
-	off=5Ft offst;
-	char *desc;
-	int exp=5Ferrno;
-	int (*setupfunc) ();
-} Test=5Fcases[] =3D {
-	{
-	1, K1, 0, "file descriptor is a PIPE or FIFO", ESPIPE, setup1}, {
-	2, K1, -1, "specified offset is -ve or invalid", EINVAL, setup2}, {
-	3, K1, 0, "file descriptor is bad", EBADF, no=5Fsetup}, {
-	0, 0, 0, NULL, 0, no=5Fsetup}
+static void test=5Fespipe(void);
+static void test=5Feinval(void);
+static void test=5Febadf(void);
+
+#if !defined(UCLINUX)
+static void test=5Fefault(void);
+#endif
+
+static void (*testfunc[])(void) =3D {
+	test=5Fespipe, test=5Feinval, test=5Febadf,
+#if !defined(UCLINUX)
+	test=5Fefault
+#endif
 };
=20
+int TST=5FTOTAL =3D ARRAY=5FSIZE(testfunc);
+
 int main(int ac, char **av)
 {
-	int lc;
+	int i, lc;
 	char *msg;
-	int i;
-	int fildes;		/* file descriptor of test file */
-	size=5Ft nbytes;		/* no. of bytes to be written */
-	off=5Ft offset;		/* offset position in the specified file */
-	char *test=5Fdesc;	/* test specific error message */
=20
 	if ((msg =3D parse=5Fopts(ac, av, NULL, NULL)) !=3D NULL)
 		tst=5Fbrkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
=20
 	setup();
=20
-	TEST=5FEXP=5FENOS(exp=5Fenos);
-
 	for (lc =3D 0; TEST=5FLOOPING(lc); lc++) {
-
 		tst=5Fcount =3D 0;
=20
-		for (i =3D 0; Test=5Fcases[i].desc !=3D NULL; i++) {
-			fildes =3D Test=5Fcases[i].fd;
-			test=5Fdesc =3D Test=5Fcases[i].desc;
-			nbytes =3D Test=5Fcases[i].nb;
-			offset =3D Test=5Fcases[i].offst;
-
-			if (fildes =3D=3D 1) {
-				fildes =3D pfd[1];
-			} else if (fildes =3D=3D 2) {
-				fildes =3D fd1;
-			} else {
-				fildes =3D -1;
-			}
-
-			/*
-			 * Call pwrite() with the specified file descriptor,
-			 * no. of bytes to be written at specified offset.
-			 * and verify that call should fail with appropriate
-			 * errno. set.
-			 */
-			TEST(pwrite(fildes, write=5Fbuf[0], nbytes, offset));
-
-			/* Check for the return code of pwrite() */
-			if (TEST=5FRETURN !=3D -1) {
-				tst=5Fresm(TFAIL, "pwrite() returned %ld, "
-					 "expected -1, errno:%d",
-					 TEST=5FRETURN, Test=5Fcases[i].exp=5Ferrno);
-				continue;
-			}
-
-			TEST=5FERROR=5FLOG(TEST=5FERRNO);
-
-			/*
-			 * Verify whether expected errno is set.
-			 */
-			if (TEST=5FERRNO =3D=3D Test=5Fcases[i].exp=5Ferrno) {
-				tst=5Fresm(TPASS, "%s, errno:%d",
-					 test=5Fdesc, TEST=5FERRNO);
-			} else {
-				tst=5Fresm(TFAIL, "%s, unexpected"
-					 " errno:%d, expected:%d", test=5Fdesc,
-					 TEST=5FERRNO, Test=5Fcases[i].exp=5Ferrno);
-			}
-		}
+		for (i =3D 0; i < TST=5FTOTAL; i++)
+			(*testfunc[i])();
 	}
=20
 	cleanup();
-
 	tst=5Fexit();
 }
=20
@@ -189,25 +102,19 @@ int main(int ac, char **av)
  * test case passes on a machine running RedHat 6.2 but it will fail
  * on a machine running RedHat 7.1.
  */
-void sighandler(sig)
+static void sighandler(int sig)
 {
 	if (sig !=3D SIGXFSZ) {
-		printf("wrong signal\n");
+		write(STDOUT=5FFILENO, "get wrong signal\n",
+		      sizeof("get wrong signal\n"));
 	} else {
-		printf("caught SIGXFSZ\n");
+		write(STDOUT=5FFILENO, "caught SIGXFSZ\n",
+		      sizeof("caught SIGXFSZ\n"));
 	}
 }
=20
-/*
- * setup() - performs all ONE TIME setup for this test.
- *
- *  Initialize/allocate write buffer.
- *  Call individual setup function.
- */
-void setup()
+static void setup(void)
 {
-	int i;
-
 	tst=5Fsig(NOFORK, DEF=5FHANDLER, cleanup);
=20
 	/* see the comment in the sighandler() function */
@@ -216,117 +123,90 @@ void setup()
 		tst=5Fbrkm(TBROK, cleanup, "signal() failed");
 	}
=20
+	TEST=5FEXP=5FENOS(exp=5Fenos);
+
 	TEST=5FPAUSE;
=20
-	/* Allocate/Initialize the write buffer with known data */
-	init=5Fbuffers();
+	tst=5Ftmpdir();
=20
-	/* Call individual setup functions */
-	for (i =3D 0; Test=5Fcases[i].desc !=3D NULL; i++) {
-		Test=5Fcases[i].setupfunc();
-	}
+	memset(write=5Fbuf, 'a', K1);
 }
=20
-/*
- * no=5Fsetup() - This function simply returns.
- */
-int no=5Fsetup()
+static void print=5Ftest=5Fresult(int err, int exp=5Ferrno)
 {
-	return 0;
+	if (err =3D=3D 0) {
+		tst=5Fresm(TFAIL, "call succeeded unexpectedly");
+		return;
+	}
+
+	TEST=5FERROR=5FLOG(err);
+
+	if (err =3D=3D exp=5Ferrno) {
+		tst=5Fresm(TPASS, "pwrite failed as expected: %d - %s",
+			 err, strerror(err));
+	} else {
+		tst=5Fresm(TFAIL, "pwrite failed unexpectedly; expected: %d - %s"
+			 "return: %d - %s", exp=5Ferrno, strerror(exp=5Ferrno),
+			 err, strerror(err));
+	}
 }
=20
-/*
- * setup1() - setup function for a test condition for which pwrite()
- *	      returns -ve value and sets errno to ESPIPE.
- *
- *  Create an unnamed pipe using pipe().
- *  return 0.
- */
-int setup1()
+static void test=5Fespipe(void)
 {
-	/* Create an unnamed pipe */
-	if (pipe(pfd) < 0) {
-		tst=5Fbrkm(TBROK, cleanup, "pipe() failed, error:%d", errno);
-	}
+	int pipe=5Ffds[2];
=20
-	return 0;
+	SAFE=5FPIPE(cleanup, pipe=5Ffds);
+
+	TEST(pwrite(pipe=5Ffds[1], write=5Fbuf, K1, 0));
+
+	print=5Ftest=5Fresult(errno, ESPIPE);
+
+	SAFE=5FCLOSE(cleanup, pipe=5Ffds[0]);
+	SAFE=5FCLOSE(cleanup, pipe=5Ffds[1]);
 }
=20
-/*
- * setup2 - setup function for a test condition for which pwrite()
- * 	    returns -ve value and sets errno to EINVAL.
- *
- *  Create a temporary directory and a file under it.
- *  return 0.
- */
-int setup2()
+static void test=5Feinval(void)
 {
+	int fd;
=20
-	tst=5Ftmpdir();
+	fd =3D SAFE=5FOPEN(cleanup, TEMPFILE, O=5FRDWR | O=5FCREAT, 0666);
=20
-	/* Creat a temporary file used for mapping */
-	if ((fd1 =3D open(TEMPFILE, O=5FRDWR | O=5FCREAT, 0666)) < 0) {
-		tst=5Fbrkm(TBROK, cleanup, "open() on %s Failed, errno=3D%d : %s",
-			 TEMPFILE, errno, strerror(errno));
-	}
+	/* the specified offset was invalid */
+	TEST(pwrite(fd, write=5Fbuf, K1, -1));
+
+	print=5Ftest=5Fresult(errno, EINVAL);
=20
-	return 0;
+	SAFE=5FCLOSE(cleanup, fd);
 }
=20
-/*
- * init=5Fbuffers() - allocate/Initialize write=5Fbuf array.
- *
- *  Allocate write buffer.
- *  Fill the write buffer with the following data like,
- *    write=5Fbuf[0] has 0's, write=5Fbuf[1] has 1's, write=5Fbuf[2] has 2=
's
- *    write=5Fbuf[3] has 3's.
- */
-void init=5Fbuffers()
+static void test=5Febadf(void)
 {
-	int count;		/* counter variable for loop */
+	int fd =3D -1;
=20
-	/* Allocate and Initialize write buffer with known data */
-	for (count =3D 0; count < NBUFS; count++) {
-		write=5Fbuf[count] =3D (char *)malloc(K1);
+	TEST(pwrite(fd, write=5Fbuf, K1, 0));
=20
-		if (write=5Fbuf[count] =3D=3D NULL) {
-			tst=5Fbrkm(TBROK, NULL,
-				 "malloc() failed on write buffer");
-		}
-		memset(write=5Fbuf[count], count, K1);
-	}
+	print=5Ftest=5Fresult(errno, EBADF);
 }
=20
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- *
- * Deallocate the memory allocated to write buffer.
- * Close the temporary file.
- * Remove the temporary directory created.
- */
-void cleanup()
+#if !defined(UCLINUX)
+static void test=5Fefault(void)
 {
-	int count;		/* index for the loop */
+	int fd;
+	char *buf =3D sbrk(0);
=20
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
-	TEST=5FCLEANUP;
+	fd =3D SAFE=5FOPEN(cleanup, TEMPFILE, O=5FRDWR | O=5FCREAT, 0666);
=20
-	/* Free the memory allocated for the write buffer */
-	for (count =3D 0; count < NBUFS; count++) {
-		free(write=5Fbuf[count]);
-	}
+	TEST(pwrite(fd, buf, K1, 0));
=20
-	/* Close the temporary file created in setup2 */
-	if (close(fd1) < 0) {
-		tst=5Fbrkm(TBROK, NULL,
-			 "close() on %s Failed, errno=3D%d : %s",
-			 TEMPFILE, errno, strerror(errno));
-	}
+	print=5Ftest=5Fresult(errno, EFAULT);
=20
-	tst=5Frmdir();
+	SAFE=5FCLOSE(cleanup, fd);
+}
+#endif
=20
+static void cleanup(void)
+{
+	TEST=5FCLEANUP;
+
+	tst=5Frmdir();
 }
diff --git a/testcases/kernel/syscalls/pwrite/pwrite03.c b/testcases/kernel=
/syscalls/pwrite/pwrite03.c
deleted file mode 100644
index fac8a9f..0000000
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
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1=
301 USA
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
- *   Check return code, if system call failed (return=3D-1)
- *      if errno set =3D=3D expected errno
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
- *	04/2002 Ported by Andr=E9 Merlier
- *
- * RESTRICTIONS:
- *  None.
- */
-
-#define =5FXOPEN=5FSOURCE 500
-
-#include <errno.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <fcntl.h>
-
-#include "test.h"
-#include "usctest.h"
-
-#define TEMPFILE	"pwrite=5Ffile"
-#define NBUFS           1
-
-char *TCID =3D "pwrite03";
-int TST=5FTOTAL =3D 1;
-
-char *write=5Fbuf[NBUFS];		/* buffer to hold data to be written */
-int fd1;			/* file descriptor of temporary file */
-
-void setup();			/* Main setup function of test */
-void cleanup();			/* cleanup function for the test */
-void init=5Fbuffers();		/* function to initialize/allocate buffers */
-
-int exp=5Fenos[] =3D { EFAULT, 0 };
-
-#if !defined(UCLINUX)
-
-int main(int ac, char **av)
-{
-	int lc;
-	char *msg;
-	size=5Ft nbytes;		/* no. of bytes to be written */
-	off=5Ft offset;		/* offset position in the specified file */
-	char *test=5Fdesc;	/* test specific error message */
-
-	if ((msg =3D parse=5Fopts(ac, av, NULL, NULL)) !=3D NULL)
-		tst=5Fbrkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-
-	setup();
-
-	TEST=5FEXP=5FENOS(exp=5Fenos);
-
-	for (lc =3D 0; TEST=5FLOOPING(lc); lc++) {
-
-		tst=5Fcount =3D 0;
-
-		test=5Fdesc =3D "EFAULT";
-		nbytes =3D 1024;
-		offset =3D 1;
-		write=5Fbuf[0] =3D sbrk(0);
-
-		/*
-		 * Call pwrite() with the specified file descriptor,
-		 * no. of bytes to be written at specified offset.
-		 * and verify that call should fail with appropriate
-		 * errno. set.
-		 */
-		TEST(pwrite(fd1, write=5Fbuf[0], nbytes, offset));
-
-		/* Check for the return code of pwrite() */
-		if (TEST=5FRETURN !=3D -1) {
-			tst=5Fresm(TFAIL, "pwrite() returned %ld, "
-				 "expected -1, errno:%d",
-				 TEST=5FRETURN, exp=5Fenos[0]);
-		}
-
-		TEST=5FERROR=5FLOG(TEST=5FERRNO);
-
-		/*
-		 * Verify whether expected errno is set.
-		 */
-		if (TEST=5FERRNO =3D=3D exp=5Fenos[0]) {
-			tst=5Fresm(TPASS, "pwrite() fails with expected "
-				 "error EFAULT errno:%d", TEST=5FERRNO);
-		} else {
-			tst=5Fresm(TFAIL, "pread() fails, %s, unexpected "
-				 "errno:%d, expected:%d\n", test=5Fdesc,
-				 TEST=5FERRNO, exp=5Fenos[0]);
-		}
-
-	}
-
-	cleanup();
-	tst=5Fexit();
-	tst=5Fexit();
-
-}
-
-#else
-
-int main()
-{
-	tst=5Fresm(TINFO, "test is not available on uClinux");
-	tst=5Fexit();
-}
-
-#endif /* if !defined(UCLINUX) */
-
-/*
- * setup() - performs all ONE TIME setup for this test.
- *
- *  Initialize/allocate write buffer.
- */
-void setup()
-{
-
-	tst=5Fsig(NOFORK, DEF=5FHANDLER, cleanup);
-
-	TEST=5FPAUSE;
-
-	tst=5Ftmpdir();
-
-	/* Creat a temporary file used for mapping */
-	if ((fd1 =3D open(TEMPFILE, O=5FRDWR | O=5FCREAT, 0777)) < 0) {
-		tst=5Fbrkm(TBROK, cleanup, "open() on %s Failed, errno=3D%d : %s",
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
-void cleanup()
-{
-
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
-	TEST=5FCLEANUP;
-
-	/* Close the temporary file created in setup2 */
-	if (close(fd1) < 0) {
-		tst=5Fbrkm(TBROK, NULL,
-			 "close() on %s Failed, errno=3D%d : %s",
-			 TEMPFILE, errno, strerror(errno));
-	}
-
-	tst=5Frmdir();
-
-}
--=20
1.8.2.1

=


--===============4897997989799429578==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============4897997989799429578==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4897997989799429578==--
