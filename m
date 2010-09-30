Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <biannm@cn.fujitsu.com>) id 1P19kc-00067a-Qe
	for ltp-list@lists.sourceforge.net; Thu, 30 Sep 2010 03:24:06 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P19ka-0000Rw-47
	for ltp-list@lists.sourceforge.net; Thu, 30 Sep 2010 03:24:06 +0000
Message-ID: <4CA4029D.1080304@cn.fujitsu.com>
Date: Thu, 30 Sep 2010 11:23:09 +0800
From: Bian Naimeng <biannm@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH][open_posix] Use default number of threads when it's
 not be specified
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
To: yanegomi@gmail.com
Cc: ltp-list@lists.sourceforge.net

Some stress test cases always fail, because run.sh script lose to give
parameter that specifies the number of threads.

So, fix the test program that use default number of threads when it's
not be specified

Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>

---
 .../stress/mqueues/multi_send_rev_1.c              |   13 +++++++++----
 .../stress/mqueues/multi_send_rev_2.c              |   12 ++++++++----
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/testcases/open_posix_testsuite/stress/mqueues/multi_send_rev_1.c b/testcases/open_posix_testsuite/stress/mqueues/multi_send_rev_1.c
index efa93a7..fe0a8d0 100644
--- a/testcases/open_posix_testsuite/stress/mqueues/multi_send_rev_1.c
+++ b/testcases/open_posix_testsuite/stress/mqueues/multi_send_rev_1.c
@@ -88,11 +88,16 @@ int main(int argc, char *argv[])
 	printf("_POSIX_MESSAGE_PASSING is not defined \n");
 	return PTS_UNRESOLVED;
 #endif */
-	if ( (2 != argc) || (( num = atoi(argv[1])) <= 0)) {
+
+	if ( (2 < argc) || (2 == argc && ( num = atoi(argv[1])) <= 0)) {
 		fprintf(stderr, "Usage: %s number_of_threads\n", argv[0]);
-                return PTS_FAIL;
-        }
-	if (num > Max_Threads) {
+		return PTS_FAIL;
+	}
+
+	if (2 > argc) {
+		printf("The num of threads does not be specified. Set to %d\n", Max_Threads);
+		num = Max_Threads;
+	} else if (num > Max_Threads) {
         	printf("The num of threads are too large.  Reset to %d\n", Max_Threads);
         	num = Max_Threads;
 	}
diff --git a/testcases/open_posix_testsuite/stress/mqueues/multi_send_rev_2.c b/testcases/open_posix_testsuite/stress/mqueues/multi_send_rev_2.c
index 75bc88b..eda4a9e 100644
--- a/testcases/open_posix_testsuite/stress/mqueues/multi_send_rev_2.c
+++ b/testcases/open_posix_testsuite/stress/mqueues/multi_send_rev_2.c
@@ -79,11 +79,15 @@ int main(int argc, char *argv[])
 	printf("_POSIX_MESSAGE_PASSING is not defined \n");
 	return PTS_UNRESOLVED;
 #endif */
-	if ( (2 != argc) || (( num = atoi(argv[1])) <= 0)) {
+	if ( (2 < argc) || (2 == argc && ( num = atoi(argv[1])) <= 0)) {
 		fprintf(stderr, "Usage: %s number_of_threads\n", argv[0]);
-                return PTS_FAIL;
-        }
-	if (num > Max_Threads) {
+		return PTS_FAIL;
+	}
+
+	if (2 > argc) {
+		printf("The num of threads does not be specified. Set to %d\n", Max_Threads);
+		num = Max_Threads;
+	} else if (num > Max_Threads) {
         	printf("The num of threads are too large.  Reset to %d\n", Max_Threads);
         	num = Max_Threads;
 	}
-- 
1.7.0.4



-- 
Regards
Bian Naimeng


------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
