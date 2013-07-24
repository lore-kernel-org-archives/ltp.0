Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1V1sjk-0000Vk-N8
	for ltp-list@lists.sourceforge.net; Wed, 24 Jul 2013 06:39:48 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V1sji-0001wI-Iv
	for ltp-list@lists.sourceforge.net; Wed, 24 Jul 2013 06:39:48 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r6O6deCs008666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 24 Jul 2013 02:39:40 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 24 Jul 2013 08:39:25 +0200
Message-Id: <99e7b2c3f61ddc7e6e89d28a0b15bc001e372b76.1374647501.git.jstancek@redhat.com>
In-Reply-To: <0575932595c58348fef5664c180a73b59b2515f4.1374647501.git.jstancek@redhat.com>
References: <0575932595c58348fef5664c180a73b59b2515f4.1374647501.git.jstancek@redhat.com>
Subject: [LTP] [PATCH 2/2] open_posix_testsuite/../mq_timedsend/12-1: fix
	race
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

Test can send SIGUSR1 signal after thread has already completed
and report failure from main() and success from a_thread_func():

  conformance/interfaces/mq_timedsend/12-1: execution: UNRESOLVED: Output:
  Error: in pthread_kill
  : Success
  thread: mq_timedsend interrupted by signal and correctly set errno to EINTR

Synchronize exit of a_thread_func(), so that thread can exit only
after loop sending SIGUSR1 completed.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../conformance/interfaces/mq_timedsend/12-1.c     |   94 +++++++++++---------
 1 files changed, 51 insertions(+), 43 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/12-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/12-1.c
index 29780d0..df53a72 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/12-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/12-1.c
@@ -39,19 +39,25 @@
 #define MSGSTR "0123456789"
 #define BUFFER 40
 #define MAXMSG 10
+#define TIMEOUT 10
 
-#define INTHREAD 0
-#define INMAIN 1
+#define SAFE(op) \
+	do {\
+		if ((op) == -1) {\
+			perror("unexpected failure"); \
+			exit(PTS_UNRESOLVED); \
+		} \
+	} while (0)
 
-/* manual semaphore */
-int sem;
+/* variable to indicate how many times signal handler was called */
+static volatile sig_atomic_t in_handler;
 
-/* flag to indicate signal handler was called */
-int in_handler;
+/* errno returned by mq_timedsend() */
+static volatile int mq_timedsend_errno = -1;
 
-/* flag to indicate that errno was set to eintr when mq_timedsend()
- * was interruped. */
-int errno_eintr;
+/* pipes to synchronize thread calling mq_timedsend */
+static int pipefd_start[2];
+static int pipefd_exit[2];
 
 /*
  * This handler is just used to catch the signal and stop sleep (so the
@@ -59,14 +65,12 @@ int errno_eintr;
  */
 void justreturn_handler(int signo)
 {
-	/* Indicate that the signal handler was called */
-	in_handler = 1;
-	return;
+	in_handler++;
 }
 
-void *a_thread_func()
+void *a_thread_func(void *arg)
 {
-	int i, ret;
+	int i, ret, dummy;
 	struct sigaction act;
 	char gqname[NAMESIZE];
 	mqd_t gqueue;
@@ -92,18 +96,19 @@ void *a_thread_func()
 		return NULL;
 	}
 
-	/* mq_timedsend will block for 10 seconds when it waits */
-	ts.tv_sec = time(NULL) + 10;
+	/* mq_timedsend will block for TIMEOUT seconds when it waits */
+	ts.tv_sec = time(NULL) + TIMEOUT;
 	ts.tv_nsec = 0;
 
 	/* Tell main it can go ahead and start sending SIGUSR1 signal */
-	sem = INMAIN;
+	SAFE(write(pipefd_start[1], "", 1));
 
 	for (i = 0; i < MAXMSG + 1; i++) {
 		ret = mq_timedsend(gqueue, msgptr, strlen(msgptr), 1, &ts);
 		if (ret	!= -1)
 			continue;
 
+		mq_timedsend_errno = errno;
 		if (errno == EINTR) {
 			if (mq_unlink(gqname) != 0) {
 				perror("mq_unlink() did not return success");
@@ -112,21 +117,24 @@ void *a_thread_func()
 			}
 			printf("thread: mq_timedsend interrupted by signal"
 				" and correctly set errno to EINTR\n");
-			errno_eintr = 1;
+			/* wait for main to stop sending SIGUSR1 */
+			SAFE(read(pipefd_exit[0], &dummy, 1));
 			pthread_exit((void *)PTS_PASS);
 			return NULL;
 		} else {
 			printf("mq_timedsend not interrupted by signal or"
 				" set errno to incorrect code: %d\n", errno);
+			/* wait for main to stop sending SIGUSR1 */
+			SAFE(read(pipefd_exit[0], &dummy, 1));
 			pthread_exit((void *)PTS_FAIL);
 			return NULL;
 		}
 	}
 
-	/* Tell main that it the thread did not block like it should have */
-	sem = INTHREAD;
-
-	perror("Error: thread never blocked\n");
+	mq_timedsend_errno = 0;
+	printf("Error: mq_timedsend wasn't interrupted\n");
+	/* wait for main to stop sending SIGUSR1 */
+	SAFE(read(pipefd_exit[0], &dummy, 1));
 	pthread_exit((void *)PTS_FAIL);
 	return NULL;
 }
@@ -134,13 +142,10 @@ void *a_thread_func()
 int main(void)
 {
 	pthread_t new_th;
-	int i;
+	int i = 0, ret, dummy;
 
-	/* Initialized values */
-	i = 0;
-	in_handler = 0;
-	errno_eintr = 0;
-	sem = INTHREAD;
+	SAFE(pipe(pipefd_start));
+	SAFE(pipe(pipefd_exit));
 
 	if (pthread_create(&new_th, NULL, a_thread_func, NULL) != 0) {
 		perror("Error: in pthread_create\n");
@@ -148,18 +153,22 @@ int main(void)
 	}
 
 	/* Wait for thread to set up handler for SIGUSR1 */
-	while (sem == INTHREAD)
-		sleep(1);
+	SAFE(read(pipefd_start[0], &dummy, 1));
 
-	while ((i != 10) && (sem == INMAIN)) {
+	while (i < TIMEOUT && mq_timedsend_errno < 0) {
 		/* signal thread while it's in mq_timedsend */
-		if (pthread_kill(new_th, SIGUSR1) != 0) {
-			perror("Error: in pthread_kill\n");
+		ret = pthread_kill(new_th, SIGUSR1);
+		if (ret	!= 0) {
+			printf("Error: in pthread_kill: %d\n", ret);
 			return PTS_UNRESOLVED;
 		}
 		i++;
+		sleep(1);
 	}
 
+	/* signal thread it's OK to exit now */
+	SAFE(write(pipefd_exit[1], "", 1));
+
 	if (pthread_join(new_th, NULL) != 0) {
 		perror("Error: in pthread_join()\n");
 		return PTS_UNRESOLVED;
@@ -167,18 +176,17 @@ int main(void)
 
 	/* Test to see if the thread blocked correctly in mq_timedsend,
 	 * and if it returned EINTR when it caught the signal */
-	if (errno_eintr != 1) {
-		if (sem == INTHREAD) {
-			printf("Test FAILED: mq_timedsend() never"
-				" blocked for any timeout period.\n");
-			return PTS_FAIL;
-		}
-
-		if (in_handler != 0) {
-			perror("Error: signal SIGUSR1 was never received and/or"
-				" the signal handler was never called.\n");
+	if (mq_timedsend_errno != EINTR) {
+		printf("Error: mq_timedsend was NOT interrupted\n");
+		printf(" signal handler was called %d times\n", in_handler);
+		printf(" SIGUSR1 signals sent: %d\n", i);
+		printf(" last mq_timedsend errno: %d %s\n",
+			mq_timedsend_errno, strerror(mq_timedsend_errno));
+		if (in_handler == 0) {
+			printf("Error: SIGUSR1 was never received\n");
 			return PTS_UNRESOLVED;
 		}
+		return PTS_FAIL;
 	}
 
 	printf("Test PASSED\n");
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
