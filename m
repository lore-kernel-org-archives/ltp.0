Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <takeuchi.akr@jp.panasonic.com>) id 1SAZZ6-0000TI-9I
	for ltp-list@lists.sourceforge.net; Thu, 22 Mar 2012 04:23:56 +0000
Received: from smtp.mei.co.jp ([133.183.100.20])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SAZZ3-00010Z-Ua
	for ltp-list@lists.sourceforge.net; Thu, 22 Mar 2012 04:23:56 +0000
Received: from mail-gw.jp.panasonic.com ([157.8.1.157])
	by smtp.mei.co.jp (8.12.11.20060614/3.7W/kc-maile13) with ESMTP id
	q2M4Nk8S009560 for <ltp-list@lists.sourceforge.net>;
	Thu, 22 Mar 2012 13:23:46 +0900 (JST)
Received: from epochmail.jp.panasonic.com ([157.8.1.130])
	by mail.jp.panasonic.com (8.11.6p2/3.7W/kc-maili12) with ESMTP id
	q2M4NkG09316
	for <ltp-list@lists.sourceforge.net>; Thu, 22 Mar 2012 13:23:46 +0900
Received: by epochmail.jp.panasonic.com (8.12.11.20060308/3.7W/lomi16) id
	q2M4NkAF002596
	for ltp-list@lists.sourceforge.net; Thu, 22 Mar 2012 13:23:46 +0900
Received: from [10.186.83.11]
	by lomi16.jp.panasonic.com (8.12.11.20060308/3.7W) with ESMTP id
	q2M4NjMc002575
	for <ltp-list@lists.sourceforge.net>; Thu, 22 Mar 2012 13:23:46 +0900
Date: Thu, 22 Mar 2012 13:23:54 +0900
From: Akira Takeuchi <takeuchi.akr@jp.panasonic.com>
Message-Id: <20120322132353.AB97.38390934@jp.panasonic.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] mq_timedreceive: 10-2.c: check timeout error rather
	than invalid parameter error
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

10-2.c now passes the invalid parameter to mq_timedreceive by specifying
a negative value to nanoseconds field, and checks whether EINVAL is not
returned when a message can be removed from the queue immediately.

However, this may not be a appropriate testing of mq_timedreceive.
POSIX spec of mq_timedreceive says:
    The validity of the abstime parameter need not be checked
    if a message can be removed from the message queue immediately.

This is open for interpretation of POSIX spec, and it was argued about in LKML.
    https://lkml.org/lkml/2012/3/14/589

The conclusion in LKML was that what POSIX spec says is "you don't *have*
to check validity". That is, it is allowed to check the validity.

On the other hand, actually, timeout error should not be returned when message
can be performed immediately.

Therefore, I modify the testcase to check timeout error rather than invalid
parameter error.

Signed-off-by: Akira Takeuchi <takeuchi.akr@jp.panasonic.com>
Signed-off-by: Kiyoshi Owada <owada.kiyoshi@jp.panasonic.com>
---
 .../conformance/interfaces/mq_timedreceive/10-2.c  |   20 +++++++++-----------
 1 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/10-2.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/10-2.c
index 49ee4f2..1cbb5b6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/10-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/10-2.c
@@ -8,12 +8,11 @@
 
 /*
  * If the message can be removed from the message queue immedietely,
- * the operation will never fail and the validity of abs_timeout
- * need not be checked.
+ * the operation will not fail even if abs_timeout is the past time.
  * Test Steps:
- * 1. Set the abs_timeout to be invalid, when there is message
+ * 1. Set the abs_timeout to be a past time, when there is message
  *    than can be removed from the message queue immediately.
- * 2. The validity of abs_timeout will not be checked.
+ * 2. Timeout error is not occured.
  */
 
 #include <stdio.h>
@@ -27,7 +26,7 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define TEST "10-1"
+#define TEST "10-2"
 #define FUNCTION "mq_timedreceive"
 #define ERROR_PREFIX "unexpected error: " FUNCTION " " TEST ": "
 
@@ -61,12 +60,11 @@ int main()
         }
 
 	sleep(1); /* wait for a while */
-	ts.tv_sec = time(NULL) -1; /* No wait */
-	ts.tv_nsec = -1; /* Invalid */
+	ts.tv_sec = time(NULL) -1; /* Past time */
+	ts.tv_nsec = 0;
         if (mq_timedreceive(mqdes, msgrv, BUFFER, &rvprio, &ts) == -1) {
-		if (errno == EINVAL)
-			printf("FAIL: the validity of abs_timeout "
-				"is checked\n");
+		if (errno == ETIMEDOUT)
+			printf("FAIL: mq_timedreceive returned timeout error\n");
 		else
 			perror("Unexpected error at mq_timedreceive");
 		failure = 1;
@@ -94,4 +92,4 @@ int main()
 
         printf("Test PASSED\n");
         return PTS_PASS;
-}
\ No newline at end of file
+}
-- 
1.7.4.1



------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
