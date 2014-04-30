Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shuang.qiu@oracle.com>) id 1WfQnq-0001DD-6S
	for ltp-list@lists.sourceforge.net; Wed, 30 Apr 2014 09:27:46 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WfQno-0003N9-Dx
	for ltp-list@lists.sourceforge.net; Wed, 30 Apr 2014 09:27:46 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s3U9RbBb010795
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 30 Apr 2014 09:27:38 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s3U9RaZM009714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 30 Apr 2014 09:27:37 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s3U9Ra99023479
	for <ltp-list@lists.sourceforge.net>; Wed, 30 Apr 2014 09:27:36 GMT
From: shuang.qiu@oracle.com
Date: Wed, 30 Apr 2014 17:27:32 +0800
Message-Id: <1398850052-10808-1-git-send-email-shuang.qiu@oracle.com>
Subject: [LTP] [PATCH 2/2] syscalls/fstatfs02: Using temporary file
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
system call fstatfs().We may get unexpected result(i.e. erron38:Function
not implemented) if redirect stdout when running ltp.
Using ltp temporary file instead.

Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>
---
 testcases/kernel/syscalls/fstatfs/fstatfs02.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/syscalls/fstatfs/fstatfs02.c b/testcases/kernel/syscalls/fstatfs/fstatfs02.c
index b243af3..7d7416c 100644
--- a/testcases/kernel/syscalls/fstatfs/fstatfs02.c
+++ b/testcases/kernel/syscalls/fstatfs/fstatfs02.c
@@ -23,6 +23,7 @@
 
 #include <sys/vfs.h>
 #include <sys/types.h>
+#include <sys/fcntl.h>
 #include <sys/statfs.h>
 #include <errno.h>
 #include "test.h"
@@ -35,6 +36,8 @@ char *TCID = "fstatfs02";
 
 static int exp_enos[] = { EBADF, EFAULT, 0 };
 
+static char fname[255];
+static int fd;
 static struct statfs buf;
 
 static struct test_case_t {
@@ -48,6 +51,7 @@ static struct test_case_t {
 #ifndef UCLINUX
 	    /* Skip since uClinux does not implement memory protection */
 	    /* EFAULT - address for buf is invalid */
+	    /* Use the init "1" as fd may cause unexpected ENOSYS error,will assign a tmp file later */
 	{
 	1, (void *)-1, EFAULT}
 #endif
@@ -109,11 +113,22 @@ static void setup(void)
 	TEST_PAUSE;
 
 	tst_tmpdir();
+
+	sprintf(fname, "tfile_%d", getpid());
+	if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "open failed");
+
+#ifndef UCLINUX
+	TC[1].fd = fd;
+#endif
 }
 
 static void cleanup(void)
 {
 	TEST_CLEANUP;
 
+	if (close(fd) == -1)
+		tst_resm(TWARN | TERRNO, "close failed");
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
