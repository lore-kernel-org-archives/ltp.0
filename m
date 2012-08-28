Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1T6Heu-000800-Pt
	for ltp-list@lists.sourceforge.net; Tue, 28 Aug 2012 09:00:28 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T6Heo-00021z-99
	for ltp-list@lists.sourceforge.net; Tue, 28 Aug 2012 09:00:28 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id q7S90FLM032323
	for <ltp-list@lists.sourceforge.net>; Tue, 28 Aug 2012 17:00:16 +0800
Message-ID: <503C8866.9000909@cn.fujitsu.com>
Date: Tue, 28 Aug 2012 16:59:18 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/2]sigpause/3-1.c Clean up
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
To: LTP list <ltp-list@lists.sourceforge.net>

Clean up sigpause/3-1.c.

Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
---
 .../conformance/interfaces/sigpause/3-1.c          |   34
++++++++++----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git
a/testcases/open_posix_testsuite/conformance/interfaces/sigpause/3-1.c
b/testcases/open_posix_testsuite/conformance/interfaces/sigpause/3-1.c
index 2fa7504..00024ed 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigpause/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigpause/3-1.c
@@ -32,7 +32,8 @@
 int result = 2;
 int sem = INMAIN;

-void handler() {
+void handler()
+{
 	printf("signal was called\n");
 	return;
 }
@@ -48,18 +49,20 @@ void *a_thread_func()
 	return_value = sigpause(SIGTOTEST);
 	if (return_value == -1) {
 		if (errno == EINTR) {
-			printf ("Test PASSED: sigpause returned -1 and set errno to EINTR\n");
+			printf("Test PASSED: sigpause returned -1 "
+					"and set errno to EINTR\n");
 			result = 0;
 		} else {
-			printf ("Test FAILED: sigpause did not set errno to EINTR\n");
+			printf("Test FAILED: sigpause did not "
+					"set errno to EINTR\n");
 			result = 1;
 		}
 	} else {
-		if (errno == EINTR) {
-			printf ("Test FAILED: sigpause did not return -1\n");
-		}
-		printf ("Test FAILED: sigpause did not set errno to EINTR\n");
-		printf ("Test FAILED: sigpause did not return -1\n");
+		if (errno == EINTR)
+			printf("Test FAILED: sigpause did not return -1\n");
+
+		printf("Test FAILED: sigpause did not set errno to EINTR\n");
+		printf("Test FAILED: sigpause did not return -1\n");
 		result = 1;

 	}
@@ -71,16 +74,14 @@ int main()
 {
 	pthread_t new_th;

-	if (pthread_create(&new_th, NULL, a_thread_func, NULL) != 0)
-	{
+	if (pthread_create(&new_th, NULL, a_thread_func, NULL) != 0) {
 		perror("Error creating thread\n");
 		return PTS_UNRESOLVED;
 	}

 	sleep(1);

-	if (pthread_kill(new_th, SIGTOTEST) != 0)
-	{
+	if (pthread_kill(new_th, SIGTOTEST) != 0) {
 		printf("Test UNRESOLVED: Couldn't send signal to thread\n");
 		return PTS_UNRESOLVED;
 	}
@@ -89,13 +90,12 @@ int main()
 	while (sem == INTHREAD)
 		sleep(1);

-	if (result == 2) {
+	if (result == 2)
 		return PTS_UNRESOLVED;
-	}
-	if (result == 1) {
+
+	if (result == 1)
 		return PTS_FAIL;
-	}

 	printf("Test PASSED\n");
 	return PTS_PASS;
-}
\ No newline at end of file
+}
-- 
1.7.10.2

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
