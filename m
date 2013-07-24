Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1V1sjj-0008Po-PX
	for ltp-list@lists.sourceforge.net; Wed, 24 Jul 2013 06:39:47 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V1sjh-00059l-IA
	for ltp-list@lists.sourceforge.net; Wed, 24 Jul 2013 06:39:47 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r6O6dd4X026868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 24 Jul 2013 02:39:39 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 24 Jul 2013 08:39:24 +0200
Message-Id: <0575932595c58348fef5664c180a73b59b2515f4.1374647501.git.jstancek@redhat.com>
Subject: [LTP] [PATCH 1/2] open_posix_testsuite/../mq_timedsend/12-1: fix
	long lines
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

Fix lines going over 80 characters.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../conformance/interfaces/mq_timedsend/12-1.c     |   77 ++++++++++----------
 1 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/12-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/12-1.c
index 1984063..29780d0 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/12-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/12-1.c
@@ -11,12 +11,12 @@
  *
  * Steps:
  * 1. Create a thread and set up a signal handler for SIGUSR1
- * 2. Thread indicates to main that it is ready to start calling mq_timedsend until it
- *    blocks for a timeout of 10 seconds.
- * 3. In main, send the thread the SIGUSR1 signal while mq_timedsend is blocking.
- * 4. Check to make sure that mq_timedsend blocked, and that it returned EINTR when it was
- *    interrupted by SIGUSR1.
- *
+ * 2. Thread indicates to main that it is ready to start calling mq_timedsend
+ *    until it blocks for a timeout of 10 seconds.
+ * 3. In main, send the thread the SIGUSR1 signal while mq_timedsend is
+ *    blocking.
+ * 4. Check to make sure that mq_timedsend blocked, and that it returned
+ *    EINTR when it was interrupted by SIGUSR1.
  */
 
 #include <stdio.h>
@@ -43,10 +43,15 @@
 #define INTHREAD 0
 #define INMAIN 1
 
-int sem;			/* manual semaphore */
-int in_handler;			/* flag to indicate signal handler was called */
-int errno_eintr;		/* flag to indicate that errno was set to eintr when mq_timedsend()
-				   was interruped. */
+/* manual semaphore */
+int sem;
+
+/* flag to indicate signal handler was called */
+int in_handler;
+
+/* flag to indicate that errno was set to eintr when mq_timedsend()
+ * was interruped. */
+int errno_eintr;
 
 /*
  * This handler is just used to catch the signal and stop sleep (so the
@@ -61,8 +66,7 @@ void justreturn_handler(int signo)
 
 void *a_thread_func()
 {
-
-	int i;
+	int i, ret;
 	struct sigaction act;
 	char gqname[NAMESIZE];
 	mqd_t gqueue;
@@ -96,26 +100,26 @@ void *a_thread_func()
 	sem = INMAIN;
 
 	for (i = 0; i < MAXMSG + 1; i++) {
-		if (mq_timedsend(gqueue, msgptr, strlen(msgptr), 1, &ts) == -1) {
-			if (errno == EINTR) {
-				if (mq_unlink(gqname) != 0) {
-					perror
-					    ("mq_unlink() did not return success");
-					pthread_exit((void *)PTS_UNRESOLVED);
-					return NULL;
-				}
-				printf
-				    ("thread: mq_timedsend interrupted by signal and correctly set errno to EINTR\n");
-				errno_eintr = 1;
-				pthread_exit((void *)PTS_PASS);
-				return NULL;
-			} else {
-				printf
-				    ("mq_timedsend not interrupted by signal or set errno to incorrect code: %d\n",
-				     errno);
-				pthread_exit((void *)PTS_FAIL);
+		ret = mq_timedsend(gqueue, msgptr, strlen(msgptr), 1, &ts);
+		if (ret	!= -1)
+			continue;
+
+		if (errno == EINTR) {
+			if (mq_unlink(gqname) != 0) {
+				perror("mq_unlink() did not return success");
+				pthread_exit((void *)PTS_UNRESOLVED);
 				return NULL;
 			}
+			printf("thread: mq_timedsend interrupted by signal"
+				" and correctly set errno to EINTR\n");
+			errno_eintr = 1;
+			pthread_exit((void *)PTS_PASS);
+			return NULL;
+		} else {
+			printf("mq_timedsend not interrupted by signal or"
+				" set errno to incorrect code: %d\n", errno);
+			pthread_exit((void *)PTS_FAIL);
+			return NULL;
 		}
 	}
 
@@ -161,23 +165,22 @@ int main(void)
 		return PTS_UNRESOLVED;
 	}
 
-	/* Test to see if the thread blocked correctly in mq_timedsend, and if it returned
-	 * EINTR when it caught the signal */
+	/* Test to see if the thread blocked correctly in mq_timedsend,
+	 * and if it returned EINTR when it caught the signal */
 	if (errno_eintr != 1) {
 		if (sem == INTHREAD) {
-			printf
-			    ("Test FAILED: mq_timedsend() never blocked for any timeout period.\n");
+			printf("Test FAILED: mq_timedsend() never"
+				" blocked for any timeout period.\n");
 			return PTS_FAIL;
 		}
 
 		if (in_handler != 0) {
-			perror
-			    ("Error: signal SIGUSR1 was never received, and/or the signal handler was never called.\n");
+			perror("Error: signal SIGUSR1 was never received and/or"
+				" the signal handler was never called.\n");
 			return PTS_UNRESOLVED;
 		}
 	}
 
 	printf("Test PASSED\n");
 	return PTS_PASS;
-
 }
-- 
1.7.1


------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
