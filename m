Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1UD4AC-0002q1-LI
	for ltp-list@lists.sourceforge.net; Wed, 06 Mar 2013 02:33:04 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UD4A9-0000bA-OC
	for ltp-list@lists.sourceforge.net; Wed, 06 Mar 2013 02:33:04 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r262WsRt004534
	for <ltp-list@lists.sourceforge.net>; Wed, 6 Mar 2013 10:32:54 +0800
Message-ID: <5136AA61.7030008@cn.fujitsu.com>
Date: Wed, 06 Mar 2013 10:30:57 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
References: <51346595.80103@cn.fujitsu.com>
In-Reply-To: <51346595.80103@cn.fujitsu.com>
Subject: [LTP] [PATCHv3]pthread_once/1-1.c : add error checks
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


Add error checks to:

  Make sure this case not slip into one situation that
  the first pthread_once fails, and the second successes,
  then the case passes with bypassing its assertion.

  Give more detailed and exact execute result.


Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
---
 .../conformance/interfaces/pthread_once/1-1.c           | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_once/1-1.c
b/testcases/open_posix_testsuite/conformance/interfaces/pthread_once/1-1.c
index 3a7c861..3392e6b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_once/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_once/1-1.c
@@ -26,7 +26,7 @@
 #include "posixtest.h"

 /* Keeps track of how many times the init function has been called. */
-int init_flag;
+static int init_flag;

 /* The init function that pthread_once calls */
 void *an_init_func()
@@ -37,16 +37,25 @@ void *an_init_func()

 int main()
 {
+	int ret;
+
 	pthread_once_t once_control = PTHREAD_ONCE_INIT;

 	init_flag = 0;

 	/* Call pthread_once, passing it the once_control */
-	pthread_once(&once_control, (void *)an_init_func);
-
+	ret = pthread_once(&once_control, (void *)an_init_func);
+	if (ret != 0) {
+		printf("pthread_once failed\n");
+		return PTS_UNRESOLVED;
+	}
 	/* Call pthread_once again. The init function should not be
 	 * called. */
-	pthread_once(&once_control, (void *)an_init_func);
+	ret = pthread_once(&once_control, (void *)an_init_func);
+	if (ret != 0) {
+		printf("pthread_once failed\n");
+		return PTS_UNRESOLVED;
+	}

 	if (init_flag != 1) {
 		printf("Test FAILED\n");
-- 
1.7.12

------------------------------------------------------------------------------
Symantec Endpoint Protection 12 positioned as A LEADER in The Forrester  
Wave(TM): Endpoint Security, Q1 2013 and "remains a good choice" in the  
endpoint security space. For insight on selecting the right partner to 
tackle endpoint security challenges, access the full report. 
http://p.sf.net/sfu/symantec-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
