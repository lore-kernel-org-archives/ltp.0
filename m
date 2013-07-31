Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1V4Y75-0000Fd-Nf
	for ltp-list@lists.sourceforge.net; Wed, 31 Jul 2013 15:14:55 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V4Y74-0005Yj-EN
	for ltp-list@lists.sourceforge.net; Wed, 31 Jul 2013 15:14:55 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r6VFEmmE008603
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 31 Jul 2013 11:14:49 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 31 Jul 2013 16:30:09 +0200
Message-Id: <c6bfd2f062e27984837f94e4d333657fae5cd65e.1375280397.git.jstancek@redhat.com>
In-Reply-To: <1a46908a50835715045c5baeee559561fc97c601.1374746456.git.jstancek@redhat.com>
References: <1a46908a50835715045c5baeee559561fc97c601.1374746456.git.jstancek@redhat.com>
Subject: [LTP] [PATCH v3 2/2] open_posix_testsuite/../mq_timedsend/12-1: fix
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
Changes in v3:
  remove SAFE() macro
  convert pipes to mutex and condition

 .../conformance/interfaces/mq_timedsend/12-1.c     |  175 ++++++++++++--------
 1 files changed, 107 insertions(+), 68 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/12-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/12-1.c
index 29780d0..fdcb6ec 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/12-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/12-1.c
@@ -39,19 +39,23 @@
 #define MSGSTR "0123456789"
 #define BUFFER 40
 #define MAXMSG 10
+#define TIMEOUT 10		/* seconds mq_timedsend will block */
+#define SIGNAL_DELAY_MS 50	/* delay in ms between 2 signals */
+#define STATE_THREAD_READY 1
+#define STATE_DONE_SENDING 2
 
-#define INTHREAD 0
-#define INMAIN 1
+#define handle_error_en(en, msg) \
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
+static int state;
+pthread_mutex_t mutex;
+pthread_cond_t cond;
 
 /*
  * This handler is just used to catch the signal and stop sleep (so the
@@ -59,12 +63,46 @@ int errno_eintr;
  */
 void justreturn_handler(int signo)
 {
-	/* Indicate that the signal handler was called */
-	in_handler = 1;
-	return;
+	in_handler++;
 }
 
-void *a_thread_func()
+void set_state(int n)
+{
+	int ret;
+
+	ret = pthread_mutex_lock(&mutex);
+	if (ret != 0)
+		handle_error_en(ret, "set_state pthread_mutex_lock");
+
+	state = n;
+	ret = pthread_cond_signal(&cond);
+	if (ret != 0)
+		handle_error_en(ret, "set_state pthread_cond_signal");
+
+	ret = pthread_mutex_unlock(&mutex);
+	if (ret != 0)
+		handle_error_en(ret, "set_state pthread_mutex_unlock");
+}
+
+void wait_for_state(int n)
+{
+	int ret;
+
+	ret = pthread_mutex_lock(&mutex);
+	if (ret != 0)
+		handle_error_en(ret, "wait_for_state pthread_mutex_lock");
+
+	while (state != n) {
+		ret = pthread_cond_wait(&cond, &mutex);
+		if (ret != 0)
+			handle_error_en(ret, "pthread_cond_wait");
+	}
+	ret = pthread_mutex_unlock(&mutex);
+	if (ret != 0)
+		handle_error_en(ret, "wait_for_state pthread_mutex_unlock");
+}
+
+void *a_thread_func(void *arg)
 {
 	int i, ret;
 	struct sigaction act;
@@ -86,101 +124,102 @@ void *a_thread_func()
 	attr.mq_maxmsg = MAXMSG;
 	attr.mq_msgsize = BUFFER;
 	gqueue = mq_open(gqname, O_CREAT | O_RDWR, S_IRUSR | S_IWUSR, &attr);
-	if (gqueue == (mqd_t) - 1) {
-		perror("mq_open() did not return success");
-		pthread_exit((void *)PTS_UNRESOLVED);
-		return NULL;
-	}
+	if (gqueue == (mqd_t) -1)
+		handle_error_en(errno, "mq_open");
 
-	/* mq_timedsend will block for 10 seconds when it waits */
-	ts.tv_sec = time(NULL) + 10;
+	/* mq_timedsend will block for TIMEOUT seconds when it waits */
+	ts.tv_sec = time(NULL) + TIMEOUT;
 	ts.tv_nsec = 0;
 
 	/* Tell main it can go ahead and start sending SIGUSR1 signal */
-	sem = INMAIN;
+	set_state(STATE_THREAD_READY);
 
 	for (i = 0; i < MAXMSG + 1; i++) {
 		ret = mq_timedsend(gqueue, msgptr, strlen(msgptr), 1, &ts);
-		if (ret	!= -1)
+		if (ret != -1)
 			continue;
 
+		mq_timedsend_errno = errno;
 		if (errno == EINTR) {
-			if (mq_unlink(gqname) != 0) {
-				perror("mq_unlink() did not return success");
-				pthread_exit((void *)PTS_UNRESOLVED);
-				return NULL;
-			}
+			if (mq_unlink(gqname) != 0)
+				handle_error_en(errno, "mq_unlink");
 			printf("thread: mq_timedsend interrupted by signal"
 				" and correctly set errno to EINTR\n");
-			errno_eintr = 1;
+			wait_for_state(STATE_DONE_SENDING);
 			pthread_exit((void *)PTS_PASS);
-			return NULL;
 		} else {
 			printf("mq_timedsend not interrupted by signal or"
 				" set errno to incorrect code: %d\n", errno);
+			wait_for_state(STATE_DONE_SENDING);
 			pthread_exit((void *)PTS_FAIL);
-			return NULL;
 		}
 	}
 
-	/* Tell main that it the thread did not block like it should have */
-	sem = INTHREAD;
-
-	perror("Error: thread never blocked\n");
+	mq_timedsend_errno = 0;
+	printf("Error: mq_timedsend wasn't interrupted\n");
+	wait_for_state(STATE_DONE_SENDING);
 	pthread_exit((void *)PTS_FAIL);
-	return NULL;
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
+	ret = pthread_mutex_init(&mutex, NULL);
+	if (ret != 0)
+		handle_error_en(ret, "pthread_mutex_init");
 
-	if (pthread_create(&new_th, NULL, a_thread_func, NULL) != 0) {
-		perror("Error: in pthread_create\n");
-		return PTS_UNRESOLVED;
-	}
+	ret = pthread_cond_init(&cond, NULL);
+	if (ret != 0)
+		handle_error_en(ret, "pthread_cond_init");
 
-	/* Wait for thread to set up handler for SIGUSR1 */
-	while (sem == INTHREAD)
-		sleep(1);
+	ret = pthread_create(&new_th, NULL, a_thread_func, NULL);
+	if (ret != 0)
+		handle_error_en(ret, "pthread_create");
 
-	while ((i != 10) && (sem == INMAIN)) {
+	/* wait for thread to start */
+	wait_for_state(STATE_THREAD_READY);
+
+	while (i < TIMEOUT*1000 && mq_timedsend_errno < 0) {
 		/* signal thread while it's in mq_timedsend */
-		if (pthread_kill(new_th, SIGUSR1) != 0) {
-			perror("Error: in pthread_kill\n");
-			return PTS_UNRESOLVED;
-		}
-		i++;
+		ret = pthread_kill(new_th, SIGUSR1);
+		if (ret != 0)
+			handle_error_en(ret, "pthread_kill");
+		usleep(SIGNAL_DELAY_MS*1000);
+		i += SIGNAL_DELAY_MS;
 	}
 
-	if (pthread_join(new_th, NULL) != 0) {
-		perror("Error: in pthread_join()\n");
-		return PTS_UNRESOLVED;
-	}
+	/* signal thread we are done sending SIGUSR1 */
+	set_state(STATE_DONE_SENDING);
+
+	ret = pthread_join(new_th, NULL);
+	if (ret != 0)
+		handle_error_en(ret, "pthread_join");
 
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
 
+	ret = pthread_cond_destroy(&cond);
+	if (ret != 0)
+		handle_error_en(ret, "pthread_cond_destroy");
+
+	ret = pthread_mutex_destroy(&mutex);
+	if (ret != 0)
+		handle_error_en(ret, "pthread_mutex_destroy");
+
 	printf("Test PASSED\n");
 	return PTS_PASS;
 }
-- 
1.7.1

------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
