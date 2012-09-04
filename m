Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1T8pGh-0003Ms-Aj
	for ltp-list@lists.sourceforge.net; Tue, 04 Sep 2012 09:17:59 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T8pGg-0002So-2R
	for ltp-list@lists.sourceforge.net; Tue, 04 Sep 2012 09:17:59 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q849HqA6019436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Sep 2012 05:17:52 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id q849HoNm005289
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Sep 2012 05:17:51 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Tue,  4 Sep 2012 11:17:42 +0200
Message-Id: <9261c230876e6a3ab96b3e927c6d4b32eea0b56e.1346750103.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.1"
Subject: [LTP] [PATCH] pthread_detach: avoid threads sharing stack
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------1.7.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


This testcase was observed to crash with segmentation fault:
http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg14692.html

Following issues have been found:
- When detached thread signals it's done, it's not really done yet
  and it is possible for scheduler to switch to test() thread and create
  another thread(s) that uses same altstack. sem_post/sem_wait
  is not reliable way to tell when detached thread is finished.
  test() thread can continue to spawn new threads and unprivileged user
  can run out of resources.
- Threads which fire SIGUSR signals can do so very frequently,
  so threaded() thread may not progress at all and it starts to
  progress only when signal threads are told to stop sending signals.

This patch modifies testcase in following way:

Before
-------
test() loops over all scenarios repeatedly and spawns new threaded()
as soon as previous one called sem_post.

main +
     |\
     | send_sig1 (thread)
     |\
     | send_sig2 (thread)
     \
       test (thread)
         \
          threaded (detached thread)

After
------
Only one thread is sending signals (SIGUSR1) with gradually increasing
sleep time to make sure threaded() can progress. test() loops over
scenarios just once.

main() loops for specified time, it spawns new child and waits for it
to finish. This will avoid using same stack by 2+ threads and there will be
no more than NSCENAR threads at a time.

main (procA)
             \
              do_child (procB) +
                               |\
                               | send_sig (thread)
                                \
                                 test (thread)
                                   \
                                    threaded (detached thread)

Modified version have been succesfully tested by reporter:
routerstation(mips), x86_64(ubuntu11.10 & redhat 5.3)
and x86(redhat 5.3) each 100+ times

and by me: 100+ times as root and unprivileged user on:
RHEL5.8 (i386, x86_64, ia64, ppc64, s390x)
RHEL6.0 (i386, x86_64, ppc64, s390x)
RHEL6.3 (i386, x86_64, ppc64, s390x)

Following glibc bug has been observed during testing on ppc64:
Bug 852445 - gcc_assert failure in _Unwind_SetSpColumn() on ppc64
https://bugzilla.redhat.com/show_bug.cgi?id=852445

This patch is currently not making any workarounds to avoid
hitting this issue, because so far it is known to happen only
rarely on ppc64 when unprivileged user runs the testcase.
If this issue becomes more significant, testcase can be modified
to skip scenarios with explicit scheduling if they are run by
unprivileged user.

Reported-by: Kang Kai <kai.kang@windriver.com>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../conformance/interfaces/pthread_detach/4-3.c    |  239 ++++++++++++--------
 1 files changed, 142 insertions(+), 97 deletions(-)


--------------1.7.1
Content-Type: text/x-patch;
	name="0001-pthread_detach-avoid-threads-sharing-stack.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-pthread_detach-avoid-threads-sharing-stack.patch"

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/4-3.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/4-3.c
index dfa6e19..6cc6105 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/4-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/4-3.c
@@ -31,23 +31,30 @@
 #define _XOPEN_SOURCE	600
 #endif
 
+#include <sys/time.h>
+#include <sys/wait.h>
+#include <assert.h>
+#include <errno.h>
 #include <pthread.h>
+#include <sched.h>
+#include <semaphore.h>
+#include <signal.h>
 #include <stdarg.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
-#include <sched.h>
-#include <semaphore.h>
-#include <errno.h>
-#include <assert.h>
-#include <sys/wait.h>
-#include <time.h>
-#include <signal.h>
 
 #include "../testfrmw/testfrmw.h"
 #include "../testfrmw/testfrmw.c"
 
+#define SAFE(op) \
+	do {\
+		if ((op) == -1) \
+			UNRESOLVED(errno, "unexpected failure"); \
+	} while (0)
+#define RUN_TIME_USEC (2*1000*1000)
+#define SIGNALS_WITHOUT_DELAY 100
 #ifndef VERBOSE
 #define VERBOSE 1
 #endif
@@ -56,15 +63,13 @@
 
 #include "../testfrmw/threads_scenarii.c"
 
-static char do_it1 = 1;
-static char do_it2 = 1;
-static unsigned long count_ope;
 #ifdef WITH_SYNCHRO
 static sem_t semsig1;
-static sem_t semsig2;
-static unsigned long count_sig;
 #endif
-
+static unsigned long count_sig;
+static volatile int do_it1 = 1;
+static unsigned long sleep_time;
+static unsigned long count_ope;
 static sigset_t usersigs;
 
 struct thestruct {
@@ -74,6 +79,13 @@ struct thestruct {
 #endif
 };
 
+unsigned long current_time_usec()
+{
+	struct timeval now;
+	SAFE(gettimeofday(&now, NULL));
+	return now.tv_sec * 1000000 + now.tv_usec;
+}
+
 /* the following function keeps on sending the signal to the process */
 static void *sendsig(void *arg)
 {
@@ -83,19 +95,29 @@ static void *sendsig(void *arg)
 
 	process = getpid();
 
-	/* We block the signals SIGUSR1 and SIGUSR2 for this THREAD */
+	/* We block the signal SIGUSR1 for this THREAD */
 	ret = pthread_sigmask(SIG_BLOCK, &usersigs, NULL);
 	if (ret != 0)
-		UNRESOLVED(ret, "Unable to block SIGUSR1 and SIGUSR2"
-			   " in signal thread");
+		UNRESOLVED(ret, "Unable to block SIGUSR1 in signal thread");
 
 	while (do_it1) {
 #ifdef WITH_SYNCHRO
 		ret = sem_wait(thearg->sem);
 		if (ret)
 			UNRESOLVED(errno, "Sem_wait in sendsig");
+		if (!do_it1)
+			break;
+
 		count_sig++;
 #endif
+		/* keep increasing sleeptime to make sure we progress
+		 * allow SIGNALS_WITHOUT_DELAY signals without any pause,
+		 * then start increasing sleep_time to make sure all threads
+		 * can progress */
+		sleep_time++;
+		if (sleep_time / SIGNALS_WITHOUT_DELAY > 0)
+			usleep(sleep_time / SIGNALS_WITHOUT_DELAY);
+
 		ret = kill(process, thearg->sig);
 		if (ret != 0)
 			UNRESOLVED(errno, "Kill in sendsig");
@@ -111,23 +133,14 @@ static void sighdl1(int sig)
 #endif
 }
 
-static void sighdl2(int sig)
-{
-#ifdef WITH_SYNCHRO
-	if (sem_post(&semsig2))
-		UNRESOLVED(errno, "Sem_post in signal handler 2");
-#endif
-}
-
 static void *threaded(void *arg)
 {
 	int ret;
 
-	/* We don't block the signals SIGUSR1 and SIGUSR2 for this THREAD */
+	/* We don't block the signal SIGUSR1 for this THREAD */
 	ret = pthread_sigmask(SIG_UNBLOCK, &usersigs, NULL);
 	if (ret != 0)
-		UNRESOLVED(ret, "Unable to unblock SIGUSR1 and SIGUSR2"
-			   " in worker thread");
+		UNRESOLVED(ret, "Unable to unblock SIGUSR1 in worker thread");
 
 	ret = pthread_detach(pthread_self());
 	if (ret == EINTR)
@@ -148,22 +161,24 @@ static void *test(void *arg)
 	int ret = 0;
 	pthread_t child;
 
-	/* We block the signals SIGUSR1 and SIGUSR2 for this THREAD */
+	/* We block the signal SIGUSR1 for this THREAD */
 	ret = pthread_sigmask(SIG_BLOCK, &usersigs, NULL);
 	if (ret != 0)
-		UNRESOLVED(ret, "Unable to block SIGUSR1 and SIGUSR2"
-			   " in signal thread");
-
-	sc = 0;
+		UNRESOLVED(ret, "Unable to block SIGUSR1 in signal thread");
 
-	while (do_it2) {
+	for (sc = 0; sc < NSCENAR; sc++) {
 #if VERBOSE > 5
 		output("-----\n");
 		output("Starting test with scenario (%i): %s\n",
-		       sc, scenarii[sc].descr);
+			sc, scenarii[sc].descr);
 #endif
+		/* reset sleep time for signal thread */
+		sleep_time = 0;
 
-		count_ope++;
+		/* thread which is already detached is not interesting
+		 * for this test, skip it */
+		if (scenarii[sc].detached == 1)
+			continue;
 
 		ret = pthread_create(&child, &scenarii[sc].ta, threaded, NULL);
 		switch (scenarii[sc].result) {
@@ -175,7 +190,7 @@ static void *test(void *arg)
 		case 1: /* Operation was expected to fail */
 			if (ret == 0)
 				UNRESOLVED(-1, "An error was expected but the"
-					   " thread creation succeeded");
+					" thread creation succeeded");
 			break;
 
 		case 2: /* We did not know the expected result */
@@ -183,12 +198,12 @@ static void *test(void *arg)
 #if VERBOSE > 5
 			if (ret == 0)
 				output("Thread has been created successfully"
-				       " for this scenario\n");
+					" for this scenario\n");
 			else
 				output("Thread creation failed with the error:"
-				       " %s\n", strerror(ret));
+					" %s\n", strerror(ret));
 #endif
-			;
+			break;
 		}
 		if (ret == 0) {
 			/* Just wait for the thread to terminate */
@@ -197,45 +212,30 @@ static void *test(void *arg)
 			} while ((ret == -1) && (errno == EINTR));
 			if (ret == -1)
 				UNRESOLVED(errno, "Failed to wait for the"
-					   " semaphore");
+					" semaphore");
 		}
-
-		/* Change thread attribute for the next loop */
-		sc++;
-		sc %= NSCENAR;
 	}
+
 	return NULL;
 }
 
-int main(int argc, char *argv[])
+void do_child()
 {
-	int ret;
-	pthread_t th_work, th_sig1, th_sig2;
-	struct thestruct arg1, arg2;
+	struct thestruct arg1;
+	pthread_t th_work, th_sig1;
 	struct sigaction sa;
+	int ret;
 
-	output_init();
-	scenar_init();
-
-	/* We prepare a signal set which includes SIGUSR1 and SIGUSR2 */
+	/* We prepare a signal set which includes SIGUSR1 */
 	sigemptyset(&usersigs);
 	ret = sigaddset(&usersigs, SIGUSR1);
-	ret |= sigaddset(&usersigs, SIGUSR2);
 	if (ret != 0)
 		UNRESOLVED(ret, "Unable to add SIGUSR1 or 2 to a signal set");
 
-	/* We now block the signals SIGUSR1 and SIGUSR2 for this THREAD */
+	/* We now block the signal SIGUSR1 for this THREAD */
 	ret = pthread_sigmask(SIG_BLOCK, &usersigs, NULL);
 	if (ret != 0)
-		UNRESOLVED(ret, "Unable to block SIGUSR1 and SIGUSR2"
-			   " in main thread");
-
-#ifdef WITH_SYNCHRO
-	if (sem_init(&semsig1, 0, 1))
-		UNRESOLVED(errno, "Semsig1  init");
-	if (sem_init(&semsig2, 0, 1))
-		UNRESOLVED(errno, "Semsig2  init");
-#endif
+		UNRESOLVED(ret, "Unable to block SIGUSR1 in main thread");
 
 	/* We need to register the signal handlers for the PROCESS */
 	sigemptyset(&sa.sa_mask);
@@ -245,61 +245,106 @@ int main(int argc, char *argv[])
 	ret = sigaction(SIGUSR1, &sa, NULL);
 	if (ret)
 		UNRESOLVED(ret, "Unable to register signal handler1");
-	sa.sa_handler = sighdl2;
-	ret = sigaction(SIGUSR2, &sa, NULL);
-	if (ret)
-		UNRESOLVED(ret, "Unable to register signal handler2");
-
-	ret = pthread_create(&th_work, NULL, test, NULL);
-	if (ret)
-		UNRESOLVED(ret, "Worker thread creation failed");
 
 	arg1.sig = SIGUSR1;
-	arg2.sig = SIGUSR2;
-
 #ifdef WITH_SYNCHRO
+	if (sem_init(&semsig1, 0, 1))
+		UNRESOLVED(errno, "Semsig1 init");
 	arg1.sem = &semsig1;
-	arg2.sem = &semsig2;
 #endif
 
-	ret = pthread_create(&th_sig1, NULL, sendsig, (void *)&arg1);
+	count_sig = 0;
+	ret = pthread_create(&th_sig1, NULL, sendsig, &arg1);
 	if (ret)
 		UNRESOLVED(ret, "Signal 1 sender thread creation failed");
-	ret = pthread_create(&th_sig2, NULL, sendsig, (void *)&arg2);
+
+	ret = pthread_create(&th_work, NULL, test, NULL);
 	if (ret)
-		UNRESOLVED(ret, "Signal 2 sender thread creation failed");
+		UNRESOLVED(ret, "Worker thread creation failed");
 
-	/* Let's wait for a while now */
-	sleep(1);
+	ret = pthread_join(th_work, NULL);
+	if (ret)
+		UNRESOLVED(ret, "Worker thread join failed");
 
-	/* Now stop the threads and join them */
-	do {
-		do_it1 = 0;
-	} while (do_it1);
+	/* to be extra safe unblock signals in this thread,
+	 * so signal thread won't get stuck on sem_wait */
+	ret = pthread_sigmask(SIG_UNBLOCK, &usersigs, NULL);
+	if (ret != 0)
+		UNRESOLVED(ret, "Failed to unblock signals");
+	do_it1 = 0;
+#ifdef WITH_SYNCHRO
+	/* if it's already stuck on sem_wait, up the semaphore */
+	if (sem_post(&semsig1))
+		UNRESOLVED(errno, "Sem_post in do_child");
+#endif
+	ret = pthread_join(th_sig1, NULL);
+	if (ret)
+		UNRESOLVED(ret, "Worker thread join failed");
+}
 
-	sleep(1);
+void main_loop()
+{
+	int child_count = 0;
+	int stat_pipe[2];
+	int ret;
+	int status;
+	pid_t child;
+	unsigned long usec_start, usec;
+	unsigned long child_count_sig;
 
+	usec_start = current_time_usec();
 	do {
-		do_it2 = 0;
-	} while (do_it2);
-
-	ret = pthread_join(th_sig1, NULL);
-	if (ret)
-		UNRESOLVED(ret, "Signal 1 sender thread join failed");
+		SAFE(pipe(stat_pipe));
+
+		child_count++;
+		count_ope += NSCENAR;
+		fflush(stdout);
+		child = fork();
+		if (child == 0) {
+			close(stat_pipe[0]);
+			do_child();
+			SAFE(write(stat_pipe[1], &count_sig,
+				sizeof(count_sig)));
+			close(stat_pipe[1]);
+			pthread_exit(0);
+			UNRESOLVED(0, "Should not be reached");
+			exit(0);
+		}
+		close(stat_pipe[1]);
+		SAFE(read(stat_pipe[0], &child_count_sig, sizeof(count_sig)));
+		close(stat_pipe[0]);
+		count_sig += child_count_sig;
+
+		ret = waitpid(child, &status, 0);
+		if (ret != child)
+			UNRESOLVED(errno, "Waitpid returned the wrong PID");
+
+		if (!WIFEXITED(status)) {
+			output("status: %d\n", status);
+			FAILED("Child exited abnormally");
+		}
 
-	ret = pthread_join(th_sig2, NULL);
-	if (ret)
-		UNRESOLVED(ret, "Signal 2 sender thread join failed");
+		if (WEXITSTATUS(status) != 0) {
+			output("exit status: %d\n", WEXITSTATUS(status));
+			FAILED("An error occured in child");
+		}
 
-	ret = pthread_join(th_work, NULL);
-	if (ret)
-		UNRESOLVED(ret, "Worker thread join failed");
+		usec = current_time_usec();
+	} while ((usec - usec_start) < RUN_TIME_USEC);
+	output("Test spawned %d child processes.\n", child_count);
+	output("Test finished after %lu usec.\n", usec - usec_start);
+}
 
+int main(int argc, char *argv[])
+{
+	output_init();
+	scenar_init();
+	main_loop();
 	scenar_fini();
 
 #if VERBOSE > 0
 	output("Test executed successfully.\n");
-	output("  %d thread detached.\n", count_ope);
+	output("  %d threads detached.\n", count_ope);
 #ifdef WITH_SYNCHRO
 	output("  %d signals were sent meanwhile.\n", count_sig);
 #endif

--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.1--



