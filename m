Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shuang.qiu@oracle.com>) id 1WfSCk-0007bb-7O
	for ltp-list@lists.sourceforge.net; Wed, 30 Apr 2014 10:57:34 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WfSCj-00043k-Bo
	for ltp-list@lists.sourceforge.net; Wed, 30 Apr 2014 10:57:34 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s3UAvR25010435
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 30 Apr 2014 10:57:27 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s3UAvQdJ020114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 30 Apr 2014 10:57:26 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s3UAvP8x002590
	for <ltp-list@lists.sourceforge.net>; Wed, 30 Apr 2014 10:57:25 GMT
From: shuang.qiu@oracle.com
Date: Wed, 30 Apr 2014 18:57:19 +0800
Message-Id: <1398855439-11869-1-git-send-email-shuang.qiu@oracle.com>
Subject: [LTP] [PATCH 2/2-updated] syscalls/fstatfs02: Using temporary file
	description to test the syscall
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

From: Shuang Qiu <shuang.qiu@oracle.com>

It does not make sense to use stdout as the file description to test the
system call fstatfs().We may get unexpected result(i.e.
errno=38:Function not implemented) if redirect stdout when running ltp.
Using ltp temporary file instead.

Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>
---
 testcases/kernel/syscalls/fstatfs/fstatfs02.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/syscalls/fstatfs/fstatfs02.c b/testcases/kernel/syscalls/fstatfs/fstatfs02.c
index b243af3..88376a1 100644
--- a/testcases/kernel/syscalls/fstatfs/fstatfs02.c
+++ b/testcases/kernel/syscalls/fstatfs/fstatfs02.c
@@ -23,6 +23,7 @@
 
 #include <sys/vfs.h>
 #include <sys/types.h>
+#include <sys/fcntl.h>
 #include <sys/statfs.h>
 #include <errno.h>
 #include "test.h"
@@ -35,6 +36,7 @@ char *TCID = "fstatfs02";
 
 static int exp_enos[] = { EBADF, EFAULT, 0 };
 
+static char fname[255];
 static struct statfs buf;
 
 static struct test_case_t {
@@ -48,6 +50,7 @@ static struct test_case_t {
 #ifndef UCLINUX
 	    /* Skip since uClinux does not implement memory protection */
 	    /* EFAULT - address for buf is invalid */
+	    /* Use the init "1" as fd may cause unexpected ENOSYS error,will assign a tmp file later */
 	{
 	1, (void *)-1, EFAULT}
 #endif
@@ -109,11 +112,22 @@ static void setup(void)
 	TEST_PAUSE;
 
 	tst_tmpdir();
+
+#ifndef UCLINUX
+	sprintf(fname, "tfile_%d", getpid());
+	if ((TC[1].fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "open failed");
+#endif
 }
 
 static void cleanup(void)
 {
 	TEST_CLEANUP;
 
+#ifndef UCLINUX
+	if (close(TC[1].fd) == -1)
+		tst_resm(TWARN | TERRNO, "close failed");
+#endif
+
 	tst_rmdir();
 }
-- 
1.7.7


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.  Get 
unparalleled scalability from the best Selenium testing platform available.
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
