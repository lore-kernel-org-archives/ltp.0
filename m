Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shuang.qiu@oracle.com>) id 1WdGii-0000mB-DH
	for ltp-list@lists.sourceforge.net; Thu, 24 Apr 2014 10:17:32 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WdGig-0007lG-Ru
	for ltp-list@lists.sourceforge.net; Thu, 24 Apr 2014 10:17:31 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s3OAHNe3009792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 24 Apr 2014 10:17:25 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s3OAHNoc025905
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 24 Apr 2014 10:17:23 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s3OAHNsN025897
	for <ltp-list@lists.sourceforge.net>; Thu, 24 Apr 2014 10:17:23 GMT
From: shuang.qiu@oracle.com
Date: Thu, 24 Apr 2014 18:15:46 +0800
Message-Id: <1398334546-5820-1-git-send-email-shuang.qiu@oracle.com>
Subject: [LTP] [PATCH] syscalls/fstatfs:using temporary file description to
	test the system call
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
 testcases/kernel/syscalls/fstatfs/fstatfs02.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/syscalls/fstatfs/fstatfs02.c b/testcases/kernel/syscalls/fstatfs/fstatfs02.c
index cee234f..652624b 100644
--- a/testcases/kernel/syscalls/fstatfs/fstatfs02.c
+++ b/testcases/kernel/syscalls/fstatfs/fstatfs02.c
@@ -47,6 +47,7 @@
 
 #include <sys/vfs.h>
 #include <sys/types.h>
+#include <sys/fcntl.h>
 #include <sys/statfs.h>
 #include <errno.h>
 #include "test.h"
@@ -59,6 +60,8 @@ char *TCID = "fstatfs02";
 
 int exp_enos[] = { EBADF, EFAULT, 0 };
 
+char fname[255];
+int fd;
 struct statfs buf;
 
 struct test_case_t {
@@ -91,6 +94,10 @@ int main(int ac, char **av)
 
 	setup();
 
+#ifndef UCLINUX
+	TC[1].fd = fd;
+#endif
+
 	/* set up the expected errnos */
 	TEST_EXP_ENOS(exp_enos);
 
@@ -138,6 +145,10 @@ void setup(void)
 
 	/* make a temporary directory and cd to it */
 	tst_tmpdir();
+
+	sprintf(fname, "tfile_%d", getpid());
+	if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "open failed");
 }
 
 /*
@@ -152,6 +163,9 @@ void cleanup(void)
 	 */
 	TEST_CLEANUP;
 
+	if (close(fd) == -1)
+		tst_resm(TWARN | TERRNO, "close failed");
+
 	/* delete the test directory created in setup() */
 	tst_rmdir();
 
-- 
1.7.7


------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
