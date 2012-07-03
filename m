Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1SlxN0-00039Q-38
	for ltp-list@lists.sourceforge.net; Tue, 03 Jul 2012 07:17:58 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SlxMv-00073T-Kl
	for ltp-list@lists.sourceforge.net; Tue, 03 Jul 2012 07:17:58 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id q637HkmH006263
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Jul 2012 15:17:47 +0800
Message-ID: <4FF29C81.9040600@cn.fujitsu.com>
Date: Tue, 03 Jul 2012 15:17:21 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH]pthread_cond_broadcast/1-2.c
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

Case pthread_cond_broadcast/1-2.c trys to create as many threads and 
processes as possible which will wait on a condition variable.

Unfortunately,if some thread or child process waits overtime(180s) 
since maybe memory is not enough or whatever, it will call FAILED() and 
exit without unlocking a global mutex.

Above-mentioned matter leads to a deadlock when parent process trys to
pthread_mutex_lock the global mutex,and obviously status FAILED cannot 
be reahed by parent process.

This patch fixes the deadlock problem.

Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
---
 .../interfaces/pthread_cond_broadcast/1-2.c        |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/1-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/1-2.c
index af826ba..f6ad9df 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/1-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/1-2.c
@@ -189,9 +189,13 @@ static void *child(void *arg)
 			timed, td->predicate, ret);
 		#endif
 	} while ((ret == 0) && (td->predicate == 0));
-	if (ret == ETIMEDOUT)
+	if (ret == ETIMEDOUT) {
+		ret = pthread_mutex_unlock(&td->mtx);
+		if (ret != 0)
+			UNRESOLVED(ret, "Failed to unlock the mutex.");
 		FAILED("Timeout occured. This means a cond signal was lost -- "
 		       "or parent died");
+	}
 	if (ret != 0)
 		UNRESOLVED(ret, "Failed to wait for the cond");
 
-- 1.7.7.2 

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
