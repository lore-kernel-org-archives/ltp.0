Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shuang.qiu@oracle.com>) id 1WsosQ-0000wJ-Ij
	for ltp-list@lists.sourceforge.net; Fri, 06 Jun 2014 07:47:50 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WsosP-0003Yq-Qo
	for ltp-list@lists.sourceforge.net; Fri, 06 Jun 2014 07:47:50 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s567lhEK031737
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 6 Jun 2014 07:47:44 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s567lhPI001981
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Fri, 6 Jun 2014 07:47:43 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s567lhIW001974
	for <ltp-list@lists.sourceforge.net>; Fri, 6 Jun 2014 07:47:43 GMT
From: shuang.qiu@oracle.com
Date: Fri,  6 Jun 2014 15:47:38 +0800
Message-Id: <1402040858-5701-1-git-send-email-shuang.qiu@oracle.com>
Subject: [LTP] [PATCH] syscalls/fstatfs02: Using temporary file description
	to test the syscall
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

It is not expected to use stdout as the file description to test the
system call fstatfs().Using ltp temporary file instead.

Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>
---
 testcases/kernel/syscalls/fstatfs/fstatfs02.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/testcases/kernel/syscalls/fstatfs/fstatfs02.c b/testcases/kernel/syscalls/fstatfs/fstatfs02.c
index f851c97..9e00a67 100644
--- a/testcases/kernel/syscalls/fstatfs/fstatfs02.c
+++ b/testcases/kernel/syscalls/fstatfs/fstatfs02.c
@@ -27,6 +27,7 @@
 #include <errno.h>
 #include "test.h"
 #include "usctest.h"
+#include "safe_macros.h"
 
 static void setup(void);
 static void cleanup(void);
@@ -48,6 +49,7 @@ static struct test_case_t {
 #ifndef UCLINUX
 	    /* Skip since uClinux does not implement memory protection */
 	    /* EFAULT - address for buf is invalid */
+	    /* Using the init "1" as fd is not actually expected,will assign a tmp file later */
 	{
 	1, (void *)-1, EFAULT}
 #endif
@@ -107,11 +109,19 @@ static void setup(void)
 	TEST_PAUSE;
 
 	tst_tmpdir();
+#ifndef UCLINUX
+	TC[1].fd = SAFE_OPEN(cleanup, "tempfile", O_RDWR | O_CREAT, 0700);
+#endif
 }
 
 static void cleanup(void)
 {
 	TEST_CLEANUP;
 
+#ifndef UCLINUX
+	if (TC[1].fd > 0 && close(TC[1].fd))
+		tst_resm(TWARN | TERRNO, "Failed to close fd");
+#endif
+
 	tst_rmdir();
 }
-- 
1.7.9.5


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their 
applications. Written by three acclaimed leaders in the field, 
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
