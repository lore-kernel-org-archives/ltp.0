Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1VlbYb-0002Rb-7z
	for ltp-list@lists.sourceforge.net; Wed, 27 Nov 2013 09:37:17 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VlbYa-0002uu-F2
	for ltp-list@lists.sourceforge.net; Wed, 27 Nov 2013 09:37:17 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rAR9b98V005734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 27 Nov 2013 09:37:10 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rAR9b84L015368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 27 Nov 2013 09:37:09 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rAR9b8DD027726
	for <ltp-list@lists.sourceforge.net>; Wed, 27 Nov 2013 09:37:08 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 27 Nov 2013 13:36:53 +0400
Message-Id: <1385545013-22647-2-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1385545013-22647-1-git-send-email-alexey.kodanev@oracle.com>
References: <1385545013-22647-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 2/2] lib/tst_res.c: make use of __sync_fetch_and_or to
	bitwise test exit value
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
Cc: vasily.isaenko@oracle.com, Alexey Kodanev <alexey.kodanev@oracle.com>

This is needed to insure that only one thread at a time may change
T_exitval variable.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 lib/tst_res.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/lib/tst_res.c b/lib/tst_res.c
index a24982e..910f273 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -101,6 +101,7 @@
 #include "test.h"
 #include "usctest.h"
 #include "ltp_priv.h"
+#include "config.h"
 
 long TEST_RETURN;
 int TEST_ERRNO;
@@ -238,7 +239,11 @@ void tst_res(int ttype, char *fname, char *arg_fmt, ...)
 	 * Save the test result type by ORing ttype into the current exit
 	 * value (used by tst_exit()).
 	 */
+#ifdef HAVE_SYNC_FETCH_AND_OR
+	__sync_fetch_and_or(&T_exitval, ttype_result);
+#else
 	T_exitval |= ttype_result;
+#endif
 
 	/*
 	 * Unless T_out has already been set by tst_environ(), make tst_res()
@@ -413,7 +418,11 @@ static void tst_print(char *tcid, int tnum, int ttype, char *tmesg)
 	 * also done here to catch internal warnings.  For internal warnings,
 	 * tst_print() is called directly with a case of TWARN.
 	 */
+#ifdef HAVE_SYNC_FETCH_AND_OR
+	__sync_fetch_and_or(&T_exitval, ttype_result);
+#else
 	T_exitval |= ttype_result;
+#endif
 
 	/*
 	 * If output mode is DISCARD, or if the output mode is NOPASS and this
-- 
1.7.1


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
