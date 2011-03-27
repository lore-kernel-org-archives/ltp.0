Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1Q3qDU-0003Uy-8R
	for ltp-list@lists.sourceforge.net; Sun, 27 Mar 2011 13:41:16 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Q3qDT-000850-2K
	for ltp-list@lists.sourceforge.net; Sun, 27 Mar 2011 13:41:16 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p2RDf9XQ005119
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Sun, 27 Mar 2011 09:41:09 -0400
From: czhang@redhat.com
Date: Sun, 27 Mar 2011 21:41:01 +0800
Message-Id: <1301233261-25499-1-git-send-email-czhang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.4.1"
Subject: [LTP] [PATCH] [syscalls] io_submit: fix broken testcase
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
To: ltp-list@lists.sourceforge.net
Cc: emcnabb@redhat.com, Caspar Zhang <czhang@redhat.com>

From: Caspar Zhang <czhang@redhat.com>

This is a multi-part message in MIME format.
--------------1.7.4.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


io_submit01 contains 4 negative testing: EINVAL, EFAULT, EINVAL+EFAULT
and EBADF. The first 3 testcases didn't initialize the content of 'ctx'
so that they contained invalid argument in the cases. This may cause
incorrect result on some architectures, like:

io_submit01    1  TPASS  :  expected failure - returned value = 22 :
Invalid argument
io_submit01    2  TFAIL  :  unexpected returned value - -22 - expected
-14
io_submit01    3  TPASS  :  expected failure - returned value = 22 :
Invalid argument
io_submit01    4  TPASS  :  expected failure - returned value = 9 : Bad
file descriptor

I fixed this issue by moving the initialization of ctx before the cases,
also added some additional negative + positive cases. Now tested on x86
and s390x system, the results seem good:

io_submit01    1  TPASS  :  expected failure - returned value = 22 :
Invalid argument
io_submit01    2  TPASS  :  expected failure - returned value = 22 :
Invalid argument
io_submit01    3  TPASS  :  expected failure - returned value = 22 :
Invalid argument
io_submit01    4  TPASS  :  expected failure - returned value = 14 : Bad
address
io_submit01    5  TPASS  :  expected failure - returned value = 22 :
Invalid argument
io_submit01    6  TPASS  :  expected failure - returned value = 9 : Bad
file descriptor
io_submit01    7  TPASS  :  call succeeded expectedly
io_submit01    8  TPASS  :  call succeeded expectedly

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 testcases/kernel/syscalls/io_submit/io_submit01.c |  143 ++++++++++++++-------
 1 files changed, 98 insertions(+), 45 deletions(-)


--------------1.7.4.1
Content-Type: text/x-patch;
	name="0001-syscalls-io_submit-fix-broken-testcase.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-syscalls-io_submit-fix-broken-testcase.patch"

diff --git a/testcases/kernel/syscalls/io_submit/io_submit01.c b/testcases/kernel/syscalls/io_submit/io_submit01.c
index 44580e6..79c0ddc 100644
--- a/testcases/kernel/syscalls/io_submit/io_submit01.c
+++ b/testcases/kernel/syscalls/io_submit/io_submit01.c
@@ -33,6 +33,7 @@ int TST_TOTAL = 3;
 #include <libaio.h>
 #include <errno.h>
 #include <string.h>
+#include <fcntl.h>
 
 static void cleanup(void)
 {
@@ -56,12 +57,6 @@ static void setup(void)
    On  success,  io_submit()  returns the number of iocbs submitted (which
    may be 0 if nr is zero); on failure,  it  returns  one  of  the  errors
    listed under ERRORS.
-
-   ERRORS
-   EINVAL The aio_context specified by ctx_id is invalid.  nr is less than
-   0.  The iocb at *iocbpp[0] is not properly initialized,  or  the
-   operation  specified  is  invalid for the file descriptor in the
-   iocb.
  */
 int main(int argc, char *argv[])
 {
@@ -69,8 +64,10 @@ int main(int argc, char *argv[])
 	char *msg;
 
 	long expected_return;
+	long expected_fault = -EFAULT;
+	long expected_inval = -EINVAL;
 
-	int rval;
+	int rval, fd;
 	char buf[256];
 	struct iocb iocb;
 	struct iocb *iocbs[1];
@@ -86,7 +83,13 @@ int main(int argc, char *argv[])
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		Tst_count = 0;
-
+		
+		/*
+		 * EINVAL The aio_context specified by ctx_id is invalid. nr is less
+		 * than 0. The iocb at *iocbpp[0] is not properly initialized, or the
+		 * operation specified is invalid for the file descriptor in the iocb.
+		 */
+		/* EINVAL-1: invalid ctx */
 		expected_return = -EINVAL;
 		TEST(io_submit(ctx, 0, NULL));
 		if (TEST_RETURN == 0) {
@@ -100,8 +103,40 @@ int main(int argc, char *argv[])
 				 "expected %ld", TEST_RETURN, expected_return);
 		}
 
+		/* EINVAL-2: invalid nr */
+		expected_return = -EINVAL;
+		rval = io_setup(1, &ctx);
+		if (rval != 0)
+			tst_brkm(TBROK, cleanup, "io_setup failed: %d", rval);
+		TEST(io_submit(ctx, -1, NULL));
+		if (TEST_RETURN == 0) {
+			tst_resm(TFAIL, "call succeeded unexpectedly");
+		} else if (TEST_RETURN == expected_return) {
+			tst_resm(TPASS, "expected failure - "
+				 "returned value = %ld : %s", (-1 * TEST_RETURN),
+				 strerror(-1 * TEST_RETURN));
+		} else {
+			tst_resm(TFAIL, "unexpected returned value - %ld - "
+				 "expected %ld", TEST_RETURN, expected_return);
+		}
+
+		/* EINVAL-3: uninitialized iocb */
+		expected_return = -EINVAL;
+		iocbs[0] = &iocb;
+		TEST(io_submit(ctx, 1, iocbs));
+		if (TEST_RETURN == 0) {
+			tst_resm(TFAIL, "call succeeded unexpectedly");
+		} else if (TEST_RETURN == expected_return) {
+			tst_resm(TPASS, "expected failure - "
+				 "returned value = %ld : %s", (-1 * TEST_RETURN),
+				 strerror(-1 * TEST_RETURN));
+		} else {
+			tst_resm(TFAIL, "unexpected returned value - %ld - "
+				 "expected %ld", TEST_RETURN, expected_return);
+		}
+
 		/*
-		   EFAULT One of the data structures points to invalid data.
+		 * EFAULT: One of the data structures points to invalid data.
 		 */
 		expected_return = -EFAULT;
 		TEST(io_submit(ctx, 1, (void *)-1));
@@ -116,51 +151,42 @@ int main(int argc, char *argv[])
 				 "expected %ld", TEST_RETURN, expected_return);
 		}
 
-		/* Special case EFAULT or EINVAL (indetermination)
-
-		   The errno depends on the per architecture implementation
-		   of io_submit. On the architecture using compat_sys_io_submit
-		   as its implementation, errno is set to -EINVAL. */
-		{
-			long expected_fault = -EFAULT;
-			long expected_inval = -EINVAL;
-
-			TEST(io_submit(ctx, 0, (void *)-1));
-			if (TEST_RETURN == 0)
-				tst_resm(TFAIL, "call succeeded unexpectedly");
-			else if (TEST_RETURN == expected_fault
-				   || TEST_RETURN == expected_inval) {
-				tst_resm(TPASS, "expected failure - "
-					 "returned value = %ld : %s",
-					 (-1 * TEST_RETURN),
-					 strerror(-1 * TEST_RETURN));
-			} else {
-				tst_resm(TFAIL,
-					 "unexpected returned value - %ld - "
-					 "expected %ld(%s) or %ld(%s)",
-					 TEST_RETURN, expected_fault,
-					 strerror(-1 * expected_fault),
-					 expected_inval,
-					 strerror(-1 * expected_inval));
-			}
-
+		/* 
+		 * Special case EFAULT or EINVAL (indetermination)
+		 * 
+		 * The errno depends on the per architecture implementation
+		 * of io_submit. On the architecture using compat_sys_io_submit
+		 * as its implementation, errno is set to -EINVAL. 
+		 */
+		TEST(io_submit(ctx, -1, (void *)-1));
+		if (TEST_RETURN == 0) {
+			tst_resm(TFAIL, "call succeeded unexpectedly");
+		} else if (TEST_RETURN == expected_fault
+			   || TEST_RETURN == expected_inval) {
+			tst_resm(TPASS, "expected failure - "
+				 "returned value = %ld : %s",
+				 (-1 * TEST_RETURN),
+				 strerror(-1 * TEST_RETURN));
+		} else {
+			tst_resm(TFAIL,
+				 "unexpected returned value - %ld - "
+				 "expected %ld(%s) or %ld(%s)",
+				 TEST_RETURN, expected_fault,
+				 strerror(-1 * expected_fault),
+				 expected_inval,
+				 strerror(-1 * expected_inval));
 		}
 
 		/*
-		   EBADF  The file descriptor specified in the first iocb is invalid.
+		 * EBADF: The file descriptor specified in the first iocb is invalid.
 		 */
 		expected_return = -EBADF;
 		io_prep_pread(&iocb, -1, (void *)buf, sizeof(buf), 0);
 		iocbs[0] = &iocb;
-		memset(&ctx, 0, sizeof(io_context_t));
-		rval = io_setup(1, &ctx);
-		if (rval != 0)
-			tst_brkm(TBROK, cleanup, "io_setup failed: %d", rval);
-
 		TEST(io_submit(ctx, 1, iocbs));
-		if (TEST_RETURN == 0)
+		if (TEST_RETURN == 0) {
 			tst_resm(TFAIL, "call succeeded unexpectedly");
-		else if (TEST_RETURN == expected_return) {
+		} else if (TEST_RETURN == expected_return) {
 			tst_resm(TPASS, "expected failure - "
 				 "returned value = %ld : %s", (-1 * TEST_RETURN),
 				 strerror(-1 * TEST_RETURN));
@@ -168,6 +194,33 @@ int main(int argc, char *argv[])
 			tst_resm(TFAIL, "unexpected returned value - %ld - "
 				 "expected %ld", TEST_RETURN, expected_return);
 		}
+
+		/* positive test: nr == 0 */
+		TEST(io_submit(ctx, 0, NULL));
+		if (TEST_RETURN == 0) {
+			tst_resm(TPASS, "call succeeded expectedly");
+		} else {
+			tst_resm(TFAIL, "unexpected failure - "
+				 "returned value = %ld : %s", (-1 * TEST_RETURN),
+				 strerror(-1 * TEST_RETURN));
+		}
+
+		/* positive test: valid fd */
+		if ((fd = open("/etc/fstab", O_RDONLY)) == -1)
+			tst_resm(TBROK, "open /etc/fstab fail");
+		io_prep_pread(&iocb, fd, (void *)buf, sizeof(buf), 0);
+		iocbs[0] = &iocb;
+		TEST(io_submit(ctx, 1, iocbs));
+		if (TEST_RETURN == 1)
+			tst_resm(TPASS, "call succeeded expectedly");
+		else if (TEST_RETURN >= 0) {
+			tst_resm(TFAIL, "unexpected retval - "
+				 "returned value = %ld", TEST_RETURN);
+		} else {
+			tst_resm(TFAIL, "unexpected returned value - %ld - "
+				 "expected %ld", TEST_RETURN, expected_return);
+		}
+		close(fd);
 	}
 	cleanup();
 

--------------1.7.4.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enable your software for Intel(R) Active Management Technology to meet the
growing manageability and security demands of your customers. Businesses
are taking advantage of Intel(R) vPro (TM) technology - will your software 
be a part of the solution? Download the Intel(R) Manageability Checker 
today! http://p.sf.net/sfu/intel-dev2devmar
--------------1.7.4.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.4.1--



