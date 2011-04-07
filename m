Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1Q7jgo-00061o-6g
	for ltp-list@lists.sourceforge.net; Thu, 07 Apr 2011 07:31:38 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Q7jgn-0006j4-4Y
	for ltp-list@lists.sourceforge.net; Thu, 07 Apr 2011 07:31:38 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p377VVf7007606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Apr 2011 03:31:31 -0400
Received: from caspar-gentoo.redhat.com (wlan-69-109.nay.redhat.com
	[10.66.69.109])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id p377VTt8020424
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Apr 2011 03:31:30 -0400
From: Caspar Zhang <czhang@redhat.com>
Date: Thu,  7 Apr 2011 15:31:28 +0800
Message-Id: <1302161488-12997-1-git-send-email-czhang@redhat.com>
In-Reply-To: <20110401144407.GA24854@saboteur.suse.cz>
References: <20110401144407.GA24854@saboteur.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.1"
Subject: [LTP] [PATCH v2] [syscalls] io_submit: fix broken testcase
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

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 testcases/kernel/syscalls/io_submit/io_submit01.c |  208 +++++++++++----------
 1 files changed, 109 insertions(+), 99 deletions(-)


--------------1.7.1
Content-Type: text/x-patch;
	name="0001-syscalls-io_submit-fix-broken-testcase.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-syscalls-io_submit-fix-broken-testcase.patch"

diff --git a/testcases/kernel/syscalls/io_submit/io_submit01.c b/testcases/kernel/syscalls/io_submit/io_submit01.c
index 44580e6..cd94649 100644
--- a/testcases/kernel/syscalls/io_submit/io_submit01.c
+++ b/testcases/kernel/syscalls/io_submit/io_submit01.c
@@ -27,54 +27,53 @@
 
 char *TCID = "io_submit01";
 
-int TST_TOTAL = 3;
+int TST_TOTAL = 8;
 
 #ifdef HAVE_LIBAIO_H
 #include <libaio.h>
 #include <errno.h>
 #include <string.h>
-
-static void cleanup(void)
-{
-	TEST_CLEANUP;
+#include <fcntl.h>
+
+#define TESTFILE	"testfile"
+#define NEG_RESULT(exp, act) {\
+	if (act == 0) {\
+			tst_resm(TFAIL, "call succeeded unexpectedly");\
+		} else if (act == exp) {\
+			tst_resm(TPASS, "expected failure - "\
+				"returned value = %ld : %s", \
+				act, strerror(-1 * act));\
+		} else {\
+			tst_resm(TFAIL, "unexpected failure - "\
+				"returned value = %ld : %s, "\
+				"expected value = %d : %s",\
+				act, strerror(-1 * act),\
+				exp, strerror(-1 * exp));\
+		} \
 }
-
-static void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+#define POS_RESULT(act) {\
+	if (act >= 0) {\
+		tst_resm(TPASS, "expected success - "\
+			"returned value = %ld", act);\
+	} else {\
+		tst_resm(TFAIL, "unexpected failure - "\
+			"returned value = %ld : %s",\
+			act, strerror(-1 * act));\
+	} \
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
+static void cleanup(void);
+static void setup(void);
+
 int main(int argc, char *argv[])
 {
 	int lc;
 	char *msg;
-
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
@@ -87,92 +86,103 @@ int main(int argc, char *argv[])
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
+		NEG_RESULT(-EINVAL, TEST_RETURN);
+
+		/* 1.2 - EINVAL: invalid nr */
+		rval = io_setup(1, &ctx);
+		if (rval != 0)
+			tst_brkm(TBROK, cleanup, "io_setup failed: %d", rval);
+		TEST(io_submit(ctx, -1, NULL));
+		NEG_RESULT(-EINVAL, TEST_RETURN);
+
+		/* 1.3 - EINVAL: uninitialized iocb */
+		iocbs[0] = &iocb;
+		TEST(io_submit(ctx, 1, iocbs));
+		NEG_RESULT(-EINVAL, TEST_RETURN);
+
+		/* 2 - EFAULT: iocb points to invalid data */
+		TEST(io_submit(ctx, 1, (struct iocb **)-1));
+		NEG_RESULT(-EFAULT, TEST_RETURN);
 
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
+		TEST(io_submit(ctx, -1, (struct iocb **)-1));
 		if (TEST_RETURN == 0) {
 			tst_resm(TFAIL, "call succeeded unexpectedly");
-		} else if (TEST_RETURN == expected_return) {
+		} else if (TEST_RETURN == -EFAULT
+			   || TEST_RETURN == -EINVAL) {
 			tst_resm(TPASS, "expected failure - "
-				 "returned value = %ld : %s", (-1 * TEST_RETURN),
-				 strerror(-1 * TEST_RETURN));
+				"returned value = %ld : %s",
+				TEST_RETURN, strerror(-1 * TEST_RETURN));
 		} else {
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
+			tst_resm(TFAIL, "unexpected failure - "
+				"returned value = %ld : %s, "
+				"expected = %d : %s or %d : %s",
+				TEST_RETURN, strerror(-1 * TEST_RETURN),
+				-EFAULT, strerror(EFAULT),
+				-EINVAL, strerror(EINVAL));
 		}
 
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
+		NEG_RESULT(-EBADF, TEST_RETURN);
+
+		/* 5 - Positive test: nr == 0 */
+		TEST(io_submit(ctx, 0, NULL));
+		POS_RESULT(TEST_RETURN);
 
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
+		POS_RESULT(TEST_RETURN);
+		if (close(fd) == -1)
+			tst_resm(TBROK|TERRNO, "close");
 	}
 	cleanup();
 
 	tst_exit();
 }
+
+static void setup(void)
+{
+	int fd;
+
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
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
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+
+	tst_rmdir();
+}
+
 #else
 int main(int argc, char *argv[])
 {

--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Xperia(TM) PLAY
It's a major breakthrough. An authentic gaming
smartphone on the nation's most reliable network.
And it wants your games.
http://p.sf.net/sfu/verizon-sfdev
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



