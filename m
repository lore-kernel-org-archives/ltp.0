Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1QADJx-000637-Cx
	for ltp-list@lists.sourceforge.net; Thu, 14 Apr 2011 03:34:17 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1QADJw-0000lx-BH
	for ltp-list@lists.sourceforge.net; Thu, 14 Apr 2011 03:34:17 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p3E3YALP022368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 13 Apr 2011 23:34:10 -0400
From: Caspar Zhang <czhang@redhat.com>
Date: Thu, 14 Apr 2011 11:33:56 +0800
Message-Id: <3d2379f1357b2be2957c69ac408365c257e40a44.1302751818.git.czhang@redhat.com>
In-Reply-To: <20110413173333.GC3206@saboteur.suse.cz>
References: <20110413173333.GC3206@saboteur.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.1"
Subject: [LTP] [PATCH v3] [syscalls] io_submit: fix broken testcase
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
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


io_submit01 contains 4 negative testing: EINVAL, EFAULT, EINVAL+EFAULT
and EBADF. The first 3 testcases didn't initialize the content of 'ctx'
so that they contained invalid argument in the cases. This may cause
incorrect result on some architectures, like:

io_submit01    1  TPASS  :  expected failure - returned value = 22 : Invalid argument
io_submit01    2  TFAIL  :  unexpected returned value - -22 - expected -14
io_submit01    3  TPASS  :  expected failure - returned value = 22 : Invalid argument
io_submit01    4  TPASS  :  expected failure - returned value = 9 : Bad file descriptor

I fixed this issue by moving the initialization of ctx before the cases,
also added some additional negative + positive cases. Now tested on x86
and s390x system, the results seem good:

io_submit01    1  TPASS  :  expected failure - returned value = -22 : Invalid argument
io_submit01    2  TPASS  :  expected failure - returned value = -22 : Invalid argument
io_submit01    3  TPASS  :  expected failure - returned value = -22 : Invalid argument
io_submit01    4  TPASS  :  expected failure - returned value = -14 : Bad address
io_submit01    5  TPASS  :  expected failure - returned value = -22 : Invalid argument
io_submit01    6  TPASS  :  expected failure - returned value = -9 : Bad file descriptor
io_submit01    7  TPASS  :  expected success - returned value = 0
io_submit01    8  TPASS  :  expected success - returned value = 1

v2: use tempfile instead of read /etc/fstab directly
v3: add a function to check results

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 testcases/kernel/syscalls/io_submit/io_submit01.c |  189 +++++++++++----------
 1 files changed, 99 insertions(+), 90 deletions(-)


--------------1.7.1
Content-Type: text/x-patch;
	name="0001-syscalls-io_submit-fix-broken-testcase.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-syscalls-io_submit-fix-broken-testcase.patch"

diff --git a/testcases/kernel/syscalls/io_submit/io_submit01.c b/testcases/kernel/syscalls/io_submit/io_submit01.c
index 44580e6..82cb1a2 100644
--- a/testcases/kernel/syscalls/io_submit/io_submit01.c
+++ b/testcases/kernel/syscalls/io_submit/io_submit01.c
@@ -33,48 +33,71 @@ int TST_TOTAL = 3;
 #include <libaio.h>
 #include <errno.h>
 #include <string.h>
+#include <fcntl.h>
+
+#define TESTFILE	"testfile"
 
 static void cleanup(void)
 {
 	TEST_CLEANUP;
+
+	tst_rmdir();
 }
 
 static void setup(void)
 {
+	int fd;
+
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
+
+	tst_tmpdir();
+
+	fd = open(TESTFILE, O_CREAT|O_RDWR, 0755);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+	if (close(fd) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "close");
+}
+
+static void check_result(long exp, long act)
+{
+	if (exp >= 0)
+	{
+		if (act == exp)
+			tst_resm(TPASS, "expected success - "
+					"returned value = %ld", act);
+		else
+			tst_resm(TFAIL, "unexpected failure - "
+					"returned value = %ld : %s",
+					act, strerror(-1 * act));
+	} else {
+		if (act == exp)
+			tst_resm(TPASS, "expected failure - "
+					"returned value = %ld : %s",
+					act, strerror(-1 * act));
+		else if (act == 0)
+			tst_resm(TFAIL, "call succeeded unexpectedly");
+		else
+			tst_resm(TFAIL, "unexpected failure - "
+					"returned value = %ld : %s, "
+					"expected value = %ld : %s",
+					act, strerror(-1 * act),
+					exp, strerror(-1 * exp));
+	}
 }
 
-/*
-   DESCRIPTION
-   io_submit() queues nr I/O request blocks for processing in the AIO con-
-   text ctx_id.  iocbpp should be an array of nr AIO request blocks, which
-   will be submitted to context ctx_id.
-
-   RETURN VALUE
-   On  success,  io_submit()  returns the number of iocbs submitted (which
-   may be 0 if nr is zero); on failure,  it  returns  one  of  the  errors
-   listed under ERRORS.
-
-   ERRORS
-   EINVAL The aio_context specified by ctx_id is invalid.  nr is less than
-   0.  The iocb at *iocbpp[0] is not properly initialized,  or  the
-   operation  specified  is  invalid for the file descriptor in the
-   iocb.
- */
 int main(int argc, char *argv[])
 {
 	int lc;
 	char *msg;
 
-	long expected_return;
-
-	int rval;
+	int rval, fd;
 	char buf[256];
 	struct iocb iocb;
 	struct iocb *iocbs[1];
-	
+
 	io_context_t ctx;
 
 	memset(&ctx, 0, sizeof(ctx));
@@ -87,87 +110,73 @@ int main(int argc, char *argv[])
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		Tst_count = 0;
 
-		expected_return = -EINVAL;
+		/* 1 - EINVAL */
+		/* 1.1 - EINVAL: invalid ctx */
 		TEST(io_submit(ctx, 0, NULL));
-		if (TEST_RETURN == 0) {
-			tst_resm(TFAIL, "call succeeded unexpectedly");
-		} else if (TEST_RETURN == expected_return) {
-			tst_resm(TPASS, "expected failure - "
-				 "returned value = %ld : %s", (-1 * TEST_RETURN),
-				 strerror(-1 * TEST_RETURN));
-		} else {
-			tst_resm(TFAIL, "unexpected returned value - %ld - "
-				 "expected %ld", TEST_RETURN, expected_return);
-		}
+		check_result(-EINVAL, TEST_RETURN);
+
+		/* 1.2 - EINVAL: invalid nr */
+		rval = io_setup(1, &ctx);
+		if (rval != 0)
+			tst_brkm(TBROK, cleanup, "io_setup failed: %d", rval);
+		TEST(io_submit(ctx, -1, NULL));
+		check_result(-EINVAL, TEST_RETURN);
+
+		/* 1.3 - EINVAL: uninitialized iocb */
+		iocbs[0] = &iocb;
+		TEST(io_submit(ctx, 1, iocbs));
+		check_result(-EINVAL, TEST_RETURN);
+
+		/* 2 - EFAULT: iocb points to invalid data */
+		TEST(io_submit(ctx, 1, (struct iocb **)-1));
+		check_result(-EFAULT, TEST_RETURN);
 
 		/*
-		   EFAULT One of the data structures points to invalid data.
+		 * 3 - Special case EFAULT or EINVAL (indetermination)
+		 *
+		 * The errno depends on the per architecture implementation
+		 * of io_submit. On the architecture using compat_sys_io_submit
+		 * as its implementation, errno is set to -EINVAL.
 		 */
-		expected_return = -EFAULT;
-		TEST(io_submit(ctx, 1, (void *)-1));
-		if (TEST_RETURN == 0) {
+		TEST(io_submit(ctx, -1, (struct iocb **)-1));
+		if (TEST_RETURN == 0)
 			tst_resm(TFAIL, "call succeeded unexpectedly");
-		} else if (TEST_RETURN == expected_return) {
+		else if (TEST_RETURN == -EFAULT
+				|| TEST_RETURN == -EINVAL)
 			tst_resm(TPASS, "expected failure - "
-				 "returned value = %ld : %s", (-1 * TEST_RETURN),
-				 strerror(-1 * TEST_RETURN));
-		} else {
-			tst_resm(TFAIL, "unexpected returned value - %ld - "
-				 "expected %ld", TEST_RETURN, expected_return);
-		}
-
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
-		}
+					"returned value = %ld : %s",
+					TEST_RETURN, strerror(-1 * TEST_RETURN));
+		else
+			tst_resm(TFAIL, "unexpected failure - "
+					"returned value = %ld : %s, "
+					"expected = %d : %s or %d : %s",
+					TEST_RETURN, strerror(-1 * TEST_RETURN),
+					-EFAULT, strerror(EFAULT),
+					-EINVAL, strerror(EINVAL));
 
 		/*
-		   EBADF  The file descriptor specified in the first iocb is invalid.
+		 * 4 - EBADF: fd in iocb is invalid
 		 */
-		expected_return = -EBADF;
-		io_prep_pread(&iocb, -1, (void *)buf, sizeof(buf), 0);
+		io_prep_pread(&iocb, -1, buf, sizeof(buf), 0);
 		iocbs[0] = &iocb;
-		memset(&ctx, 0, sizeof(io_context_t));
-		rval = io_setup(1, &ctx);
-		if (rval != 0)
-			tst_brkm(TBROK, cleanup, "io_setup failed: %d", rval);
+		TEST(io_submit(ctx, 1, iocbs));
+		check_result(-EBADF, TEST_RETURN);
 
+		/* 5 - Positive test: nr == 0 */
+		TEST(io_submit(ctx, 0, NULL));
+		check_result(0, TEST_RETURN);
+
+		/* 6 - Positive test: valid fd */
+		fd = open(TESTFILE, O_RDONLY);
+		if (fd == -1)
+			tst_resm(TBROK|TERRNO, "open");
+		io_prep_pread(&iocb, fd, buf, sizeof(buf), 0);
+		iocbs[0] = &iocb;
 		TEST(io_submit(ctx, 1, iocbs));
-		if (TEST_RETURN == 0)
-			tst_resm(TFAIL, "call succeeded unexpectedly");
-		else if (TEST_RETURN == expected_return) {
-			tst_resm(TPASS, "expected failure - "
-				 "returned value = %ld : %s", (-1 * TEST_RETURN),
-				 strerror(-1 * TEST_RETURN));
-		} else {
-			tst_resm(TFAIL, "unexpected returned value - %ld - "
-				 "expected %ld", TEST_RETURN, expected_return);
-		}
+		check_result(1, TEST_RETURN);
+		if (close(fd) == -1)
+			tst_resm(TBROK|TERRNO, "close");
+
 	}
 	cleanup();
 

--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Benefiting from Server Virtualization: Beyond Initial Workload 
Consolidation -- Increasing the use of server virtualization is a top
priority.Virtualization can reduce costs, simplify management, and improve 
application availability and disaster protection. Learn more about boosting 
the value of server virtualization. http://p.sf.net/sfu/vmware-sfdev2dev
--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.1--



