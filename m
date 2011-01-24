Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <biannm@cn.fujitsu.com>) id 1PhIjq-00032P-Sv
	for ltp-list@lists.sourceforge.net; Mon, 24 Jan 2011 09:29:30 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PhIjp-00062m-6B
	for ltp-list@lists.sourceforge.net; Mon, 24 Jan 2011 09:29:30 +0000
Message-ID: <4D3D4644.90607@cn.fujitsu.com>
Date: Mon, 24 Jan 2011 17:28:36 +0800
From: Bian Naimeng <biannm@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [POSIX][PATCH]pthread_attr_t object should be initialized
 before using it
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

pthread_attr_t object should be initialized before using it.

Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>

---
 .../interfaces/pthread_attr_setstacksize/2-1.c     |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstacksize/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstacksize/2-1.c
index 92fb33a..bf2ebc2 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstacksize/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstacksize/2-1.c
@@ -41,14 +41,14 @@ void *thread_func()
 	size_t ssize;
 	int rc;
 
-	if ((rc = pthread_getattr_np(pthread_self(), &attr)) != 0) {
-		printf(ERROR_PREFIX "pthread_getattr_np: %s\n", strerror(rc));
-		exit(PTS_FAIL);
-	}
 	if ((rc = pthread_attr_init(&attr)) != 0) {
 		printf(ERROR_PREFIX "pthread_attr_init: %s\n", strerror(rc));
 		exit(PTS_FAIL);
 	}
+	if ((rc = pthread_getattr_np(pthread_self(), &attr)) != 0) {
+		printf(ERROR_PREFIX "pthread_getattr_np: %s\n", strerror(rc));
+		exit(PTS_FAIL);
+	}
 	if ((rc = pthread_attr_getstacksize(&attr, &ssize)) != 0) {
 		printf(ERROR_PREFIX "pthread_attr_getstacksize: %s\n",
 			strerror(rc));
@@ -127,4 +127,4 @@ int main()
 
 	printf("Test PASSED\n");
 	return PTS_PASS;
-}
\ No newline at end of file
+}
-- 
1.7.0.4



-- 
Regards
Bian Naimeng


------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
