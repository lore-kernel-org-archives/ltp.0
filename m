Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1V9ZFt-0007tz-9W
	for ltp-list@lists.sourceforge.net; Wed, 14 Aug 2013 11:28:45 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V9ZFr-00071h-AC
	for ltp-list@lists.sourceforge.net; Wed, 14 Aug 2013 11:28:45 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r7EBSb2a028961
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 14 Aug 2013 07:28:37 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 14 Aug 2013 13:28:33 +0200
Message-Id: <cfa1ee92801ae50856d8d7b000c5bb046724475e.1376479412.git.jstancek@redhat.com>
In-Reply-To: <364946f8001c14134ce7bf32fe8b5c6b5201bcfb.1376399706.git.jstancek@redhat.com>
References: <364946f8001c14134ce7bf32fe8b5c6b5201bcfb.1376399706.git.jstancek@redhat.com>
Subject: [LTP] [PATCH v5 2/2] open_posix_testsuite/../mq_timedsend/12-1: fix
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
Changes in v5:
- return value from pthread_exit is not used, always return NULL

 .../conformance/interfaces/mq_timedsend/12-1.c     |  162 ++++++++++----------
 1 files changed, 83 insertions(+), 79 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/12-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/12-1.c
index 29780d0..f99e2fb 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/12-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/12-1.c
@@ -39,19 +39,19 @@
 #define MSGSTR "0123456789"
 #define BUFFER 40
 #define MAXMSG 10
+#define TIMEOUT 10		/* seconds mq_timedsend will block */
+#define SIGNAL_DELAY_MS 50	/* delay in ms between 2 signals */
 
-#define INTHREAD 0
-#define INMAIN 1
+#define error_and_exit(en, msg) \
+	do { errno = en; perror(msg); exit(PTS_UNRESOLVED); } while (0)
 
-/* manual semaphore */
-int sem;
+/* variable to indicate how many times signal handler was called */
+static volatile sig_atomic_t in_handler;
 
-/* flag to indicate signal handler was called */
-int in_handler;
+/* errno returned by mq_timedsend() */
+static int mq_timedsend_errno = -1;
 
-/* flag to indicate that errno was set to eintr when mq_timedsend()
- * was interruped. */
-int errno_eintr;
+pthread_barrier_t barrier;
 
 /*
  * This handler is just used to catch the signal and stop sleep (so the
@@ -59,12 +59,10 @@ int errno_eintr;
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
 	int i, ret;
 	struct sigaction act;
@@ -86,101 +84,107 @@ void *a_thread_func()
 	attr.mq_maxmsg = MAXMSG;
 	attr.mq_msgsize = BUFFER;
 	gqueue = mq_open(gqname, O_CREAT | O_RDWR, S_IRUSR | S_IWUSR, &attr);
-	if (gqueue == (mqd_t) - 1) {
-		perror("mq_open() did not return success");
-		pthread_exit((void *)PTS_UNRESOLVED);
-		return NULL;
-	}
+	if (gqueue == (mqd_t) -1)
+		error_and_exit(errno, "mq_open");
 
-	/* mq_timedsend will block for 10 seconds when it waits */
-	ts.tv_sec = time(NULL) + 10;
+	/* mq_timedsend will block for TIMEOUT seconds when it waits */
+	ts.tv_sec = time(NULL) + TIMEOUT;
 	ts.tv_nsec = 0;
 
-	/* Tell main it can go ahead and start sending SIGUSR1 signal */
-	sem = INMAIN;
+	/* main can now start sending SIGUSR1 signal */
+	ret = pthread_barrier_wait(&barrier);
+	if (ret != 0 && ret != PTHREAD_BARRIER_SERIAL_THREAD)
+		error_and_exit(ret, "pthread_barrier_wait start");
 
 	for (i = 0; i < MAXMSG + 1; i++) {
 		ret = mq_timedsend(gqueue, msgptr, strlen(msgptr), 1, &ts);
-		if (ret	!= -1)
-			continue;
-
-		if (errno == EINTR) {
-			if (mq_unlink(gqname) != 0) {
-				perror("mq_unlink() did not return success");
-				pthread_exit((void *)PTS_UNRESOLVED);
-				return NULL;
-			}
-			printf("thread: mq_timedsend interrupted by signal"
-				" and correctly set errno to EINTR\n");
-			errno_eintr = 1;
-			pthread_exit((void *)PTS_PASS);
-			return NULL;
-		} else {
-			printf("mq_timedsend not interrupted by signal or"
-				" set errno to incorrect code: %d\n", errno);
-			pthread_exit((void *)PTS_FAIL);
-			return NULL;
+		if (ret == -1) {
+			mq_timedsend_errno = errno;
+			break;
 		}
 	}
 
-	/* Tell main that it the thread did not block like it should have */
-	sem = INTHREAD;
+	if (mq_unlink(gqname) != 0)
+		error_and_exit(errno, "mq_unlink");
+
+	switch (mq_timedsend_errno) {
+	case -1:
+		mq_timedsend_errno = 0;
+		printf("Error: mq_timedsend wasn't interrupted\n");
+		break;
+	case EINTR:
+		printf("thread: mq_timedsend interrupted by signal"
+			" and correctly set errno to EINTR\n");
+		break;
+	default:
+		printf("mq_timedsend not interrupted by signal or"
+			" set errno to incorrect code: %d\n",
+			mq_timedsend_errno);
+		break;
+	}
 
-	perror("Error: thread never blocked\n");
-	pthread_exit((void *)PTS_FAIL);
-	return NULL;
+	/* wait until main stops sending signals */
+	ret = pthread_barrier_wait(&barrier);
+	if (ret != 0 && ret != PTHREAD_BARRIER_SERIAL_THREAD)
+		error_and_exit(ret, "pthread_barrier_wait end");
+	pthread_exit(NULL);
 }
 
 int main(void)
 {
 	pthread_t new_th;
-	int i;
+	int i = 0, ret;
 
-	/* Initialized values */
-	i = 0;
-	in_handler = 0;
-	errno_eintr = 0;
-	sem = INTHREAD;
+	ret = pthread_barrier_init(&barrier, NULL, 2);
+	if (ret != 0)
+		error_and_exit(ret, "pthread_barrier_init");
 
-	if (pthread_create(&new_th, NULL, a_thread_func, NULL) != 0) {
-		perror("Error: in pthread_create\n");
-		return PTS_UNRESOLVED;
-	}
+	ret = pthread_create(&new_th, NULL, a_thread_func, NULL);
+	if (ret != 0)
+		error_and_exit(ret, "pthread_create");
 
-	/* Wait for thread to set up handler for SIGUSR1 */
-	while (sem == INTHREAD)
-		sleep(1);
+	/* wait for thread to start */
+	ret = pthread_barrier_wait(&barrier);
+	if (ret != 0 && ret != PTHREAD_BARRIER_SERIAL_THREAD)
+		error_and_exit(ret, "pthread_barrier_wait start");
 
-	while ((i != 10) && (sem == INMAIN)) {
+	while (i < TIMEOUT*1000 && mq_timedsend_errno < 0) {
 		/* signal thread while it's in mq_timedsend */
-		if (pthread_kill(new_th, SIGUSR1) != 0) {
-			perror("Error: in pthread_kill\n");
-			return PTS_UNRESOLVED;
-		}
-		i++;
+		ret = pthread_kill(new_th, SIGUSR1);
+		if (ret != 0)
+			error_and_exit(ret, "pthread_kill");
+		usleep(SIGNAL_DELAY_MS*1000);
+		i += SIGNAL_DELAY_MS;
 	}
 
-	if (pthread_join(new_th, NULL) != 0) {
-		perror("Error: in pthread_join()\n");
-		return PTS_UNRESOLVED;
-	}
+	/* thread can now safely exit */
+	ret = pthread_barrier_wait(&barrier);
+	if (ret != 0 && ret != PTHREAD_BARRIER_SERIAL_THREAD)
+		error_and_exit(ret, "pthread_barrier_wait end");
+
+	ret = pthread_join(new_th, NULL);
+	if (ret != 0)
+		error_and_exit(ret, "pthread_join");
 
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
 
+	ret = pthread_barrier_destroy(&barrier);
+	if (ret != 0)
+		error_and_exit(ret, "pthread_barrier_destroy");
+
 	printf("Test PASSED\n");
 	return PTS_PASS;
 }
-- 
1.7.1


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
