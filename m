From: Jan Stancek <jstancek@redhat.com>
Date: Wed,  6 Dec 2017 15:05:02 +0100
Subject: [LTP] [PATCH v2 2/2] pthread_create-14-1: avoid threads sharing
	stack
In-Reply-To: <a79545c7338fa1e9df27b43dd37d5538360f20c5.1512568550.git.jstancek@redhat.com>
References: <a79545c7338fa1e9df27b43dd37d5538360f20c5.1512568550.git.jstancek@redhat.com>
Message-ID: <3e635415d2f7fd5e79ade01df9214e083a28bc6b.1512568550.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is a similar rewrite to:
  6a66e53788c7 "pthread_detach: avoid threads sharing stack"

Problem is that some threads from 'scenarii' array are using
alternate stacks. This is not a problem for joinable threads,
but for detached ones there is a risk of same stack being re-used
before first thread finished.

Smaller second problem is that thread sending SIGUSR signals
can do so very frequently which may halt progress of threaded()
function.

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

main loops for specified time, it spawns new child and waits for it
to finish. This will avoid using same stack by 2+ threads and there will
be no more than NSCENAR threads at a time.

main (procA)
     \
      test (procB)
      |\
      | send_sig (thread)
       \
        threaded (detached thread)

Patch also drops synchronization between signal sending and handling.
It only slows things down and increasing sleep in sendsig() guarantees
that progress will be made.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../conformance/interfaces/pthread_create/14-1.c   | 607 ++++++++-------------
 1 file changed, 235 insertions(+), 372 deletions(-)
 rewrite testcases/open_posix_testsuite/conformance/interfaces/pthread_create/14-1.c (77%)

Changes in v2:
- make sleep_time volatile
- drop extra check for sendsig_active in sendsig()
- drop sendsig_active
  making sendsig infinite loop thread, that's reaped by exit() in main_loop()
  this makes sensig simpler, and according to benchmarks on KVM guest
  with 4 CPUs, it has ~same performance
- handle fork() failures

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_create/14-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_create/14-1.c
dissimilarity index 77%
index 5c7486b41dc1..1916549cbe52 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_create/14-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_create/14-1.c
@@ -1,372 +1,235 @@
-/*
- * Copyright (c) 2004, Bull S.A..  All rights reserved.
- * Created by: Sebastien Decugis
-
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-
- * This sample test aims to check the following assertion:
- *
- * The function does not return EINTR
-
- * The steps are:
- * -> pthread_kill a thread which creates threads
- * -> check that EINTR is never returned
-
- */
-
- /* We are testing conformance to IEEE Std 1003.1, 2003 Edition */
-#define _POSIX_C_SOURCE 200112L
-
- /* Some routines are part of the XSI Extensions */
-#ifndef WITHOUT_XOPEN
-#define _XOPEN_SOURCE	600
-#endif
-/********************************************************************************************/
-/****************************** standard includes *****************************************/
-/********************************************************************************************/
-#include <pthread.h>
-#include <stdarg.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-
-#include <sched.h>
-#include <semaphore.h>
-#include <errno.h>
-#include <assert.h>
-#include <sys/wait.h>
-#include <time.h>
-#include <signal.h>
-
-/********************************************************************************************/
-/******************************   Test framework   *****************************************/
-/********************************************************************************************/
-#include "../testfrmw/testfrmw.h"
-#include "../testfrmw/testfrmw.c"
- /* This header is responsible for defining the following macros:
-  * UNRESOLVED(ret, descr);
-  *    where descr is a description of the error and ret is an int (error code for example)
-  * FAILED(descr);
-  *    where descr is a short text saying why the test has failed.
-  * PASSED();
-  *    No parameter.
-  *
-  * Both three macros shall terminate the calling process.
-  * The testcase shall not terminate in any other maneer.
-  *
-  * The other file defines the functions
-  * void output_init()
-  * void output(char * string, ...)
-  *
-  * Those may be used to output information.
-  */
-
-/********************************************************************************************/
-/********************************** Configuration ******************************************/
-/********************************************************************************************/
-#ifndef VERBOSE
-#define VERBOSE 1
-#endif
-
-#define WITH_SYNCHRO
-
-/********************************************************************************************/
-/***********************************    Test cases  *****************************************/
-/********************************************************************************************/
-
-#include "../testfrmw/threads_scenarii.c"
-
-/* This file will define the following objects:
- * scenarii: array of struct __scenario type.
- * NSCENAR : macro giving the total # of scenarii
- * scenar_init(): function to call before use the scenarii array.
- * scenar_fini(): function to call after end of use of the scenarii array.
- */
-
-/********************************************************************************************/
-/***********************************    Real Test   *****************************************/
-/********************************************************************************************/
-
-char do_it = 1;
-char woken = 0;
-unsigned long count_ope = 0;
-#ifdef WITH_SYNCHRO
-sem_t semsig1;
-sem_t semsig2;
-unsigned long count_sig = 0;
-#endif
-
-sigset_t usersigs;
-
-typedef struct {
-	int sig;
-#ifdef WITH_SYNCHRO
-	sem_t *sem;
-#endif
-} thestruct;
-
-/* the following function keeps on sending the signal to the process */
-void *sendsig(void *arg)
-{
-	thestruct *thearg = (thestruct *) arg;
-	int ret;
-	pid_t process;
-
-	process = getpid();
-
-	/* We block the signals SIGUSR1 and SIGUSR2 for this THREAD */
-	ret = pthread_sigmask(SIG_BLOCK, &usersigs, NULL);
-	if (ret != 0) {
-		UNRESOLVED(ret,
-			   "Unable to block SIGUSR1 and SIGUSR2 in signal thread");
-	}
-
-	while (do_it) {
-#ifdef WITH_SYNCHRO
-		if ((ret = sem_wait(thearg->sem))) {
-			UNRESOLVED(errno, "Sem_wait in sendsig");
-		}
-		count_sig++;
-#endif
-
-		ret = kill(process, thearg->sig);
-		if (ret != 0) {
-			UNRESOLVED(errno, "Kill in sendsig");
-		}
-
-	}
-
-	return NULL;
-}
-
-/* Next are the signal handlers. */
-/* This one is registered for signal SIGUSR1 */
-void sighdl1(int sig)
-{
-#ifdef WITH_SYNCHRO
-	if (sem_post(&semsig1)) {
-		UNRESOLVED(errno, "Sem_post in signal handler 1");
-	}
-#endif
-}
-
-/* This one is registered for signal SIGUSR2 */
-void sighdl2(int sig)
-{
-#ifdef WITH_SYNCHRO
-	if (sem_post(&semsig2)) {
-		UNRESOLVED(errno, "Sem_post in signal handler 2");
-	}
-#endif
-}
-
-/* Thread function -- almost does nothing */
-void *threaded(void *arg)
-{
-	int ret;
-
-	/* Signal we're done (especially in case of a detached thread) */
-	do {
-		ret = sem_post(&scenarii[sc].sem);
-	}
-	while ((ret == -1) && (errno == EINTR));
-	if (ret == -1) {
-		UNRESOLVED(errno, "Failed to wait for the semaphore");
-	}
-
-	/* return */
-	return arg;
-}
-
-/* Test function -- creates the threads and check that EINTR is never returned. */
-void *test(void *arg)
-{
-	int ret = 0;
-	pthread_t child;
-
-	/* We don't block the signals SIGUSR1 and SIGUSR2 for this THREAD */
-	ret = pthread_sigmask(SIG_UNBLOCK, &usersigs, NULL);
-	if (ret != 0) {
-		UNRESOLVED(ret,
-			   "Unable to unblock SIGUSR1 and SIGUSR2 in worker thread");
-	}
-
-	sc = 0;
-
-	while (do_it) {
-#if VERBOSE > 5
-		output("-----\n");
-		output("Starting test with scenario (%i): %s\n", sc,
-		       scenarii[sc].descr);
-#endif
-
-		count_ope++;
-
-		ret = pthread_create(&child, &scenarii[sc].ta, threaded, NULL);
-		if (ret == EINTR) {
-			FAILED("pthread_create returned EINTR");
-		}
-		switch (scenarii[sc].result) {
-		case 0:	/* Operation was expected to succeed */
-			if (ret != 0) {
-				UNRESOLVED(ret, "Failed to create this thread");
-			}
-			break;
-
-		case 1:	/* Operation was expected to fail */
-			if (ret == 0) {
-				UNRESOLVED(-1,
-					   "An error was expected but the thread creation succeeded");
-			}
-			break;
-
-		case 2:	/* We did not know the expected result */
-		default:
-#if VERBOSE > 5
-			if (ret == 0) {
-				output
-				    ("Thread has been created successfully for this scenario\n");
-			} else {
-				output
-				    ("Thread creation failed with the error: %s\n",
-				     strerror(ret));
-			}
-#endif
-			;
-		}
-		if (ret == 0) {	/* The new thread is running */
-			if (scenarii[sc].detached == 0) {
-				ret = pthread_join(child, NULL);
-				if (ret != 0) {
-					UNRESOLVED(ret,
-						   "Unable to join a thread");
-				}
-			} else {
-				/* Just wait for the thread to terminate */
-				do {
-					ret = sem_wait(&scenarii[sc].sem);
-				}
-				while ((ret == -1) && (errno == EINTR));
-				if (ret == -1) {
-					UNRESOLVED(errno,
-						   "Failed to wait for the semaphore");
-				}
-			}
-		}
-
-		/* Change thread attribute for the next loop */
-		sc++;
-		sc %= NSCENAR;
-	}
-	return NULL;
-}
-
-/* Main function */
-int main(void)
-{
-	int ret;
-	pthread_t th_work, th_sig1, th_sig2;
-	thestruct arg1, arg2;
-	struct sigaction sa;
-
-	/* Initialize output routine */
-	output_init();
-
-	/* Initialize thread attribute objects */
-	scenar_init();
-
-	/* We need to register the signal handlers for the PROCESS */
-	sigemptyset(&sa.sa_mask);
-	sa.sa_flags = 0;
-	sa.sa_handler = sighdl1;
-	if ((ret = sigaction(SIGUSR1, &sa, NULL))) {
-		UNRESOLVED(ret, "Unable to register signal handler1");
-	}
-	sa.sa_handler = sighdl2;
-	if ((ret = sigaction(SIGUSR2, &sa, NULL))) {
-		UNRESOLVED(ret, "Unable to register signal handler2");
-	}
-
-	/* We prepare a signal set which includes SIGUSR1 and SIGUSR2 */
-	sigemptyset(&usersigs);
-	ret = sigaddset(&usersigs, SIGUSR1);
-	ret |= sigaddset(&usersigs, SIGUSR2);
-	if (ret != 0) {
-		UNRESOLVED(ret, "Unable to add SIGUSR1 or 2 to a signal set");
-	}
-
-	/* We now block the signals SIGUSR1 and SIGUSR2 for this THREAD */
-	ret = pthread_sigmask(SIG_BLOCK, &usersigs, NULL);
-	if (ret != 0) {
-		UNRESOLVED(ret,
-			   "Unable to block SIGUSR1 and SIGUSR2 in main thread");
-	}
-#ifdef WITH_SYNCHRO
-	if (sem_init(&semsig1, 0, 1)) {
-		UNRESOLVED(errno, "Semsig1  init");
-	}
-	if (sem_init(&semsig2, 0, 1)) {
-		UNRESOLVED(errno, "Semsig2  init");
-	}
-#endif
-
-	if ((ret = pthread_create(&th_work, NULL, test, NULL))) {
-		UNRESOLVED(ret, "Worker thread creation failed");
-	}
-
-	arg1.sig = SIGUSR1;
-	arg2.sig = SIGUSR2;
-#ifdef WITH_SYNCHRO
-	arg1.sem = &semsig1;
-	arg2.sem = &semsig2;
-#endif
-
-	if ((ret = pthread_create(&th_sig1, NULL, sendsig, (void *)&arg1))) {
-		UNRESOLVED(ret, "Signal 1 sender thread creation failed");
-	}
-	if ((ret = pthread_create(&th_sig2, NULL, sendsig, (void *)&arg2))) {
-		UNRESOLVED(ret, "Signal 2 sender thread creation failed");
-	}
-
-	/* Let's wait for a while now */
-	sleep(1);
-
-	/* Now stop the threads and join them */
-	do {
-		do_it = 0;
-	}
-	while (do_it);
-
-	if ((ret = pthread_join(th_sig1, NULL))) {
-		UNRESOLVED(ret, "Signal 1 sender thread join failed");
-	}
-	if ((ret = pthread_join(th_sig2, NULL))) {
-		UNRESOLVED(ret, "Signal 2 sender thread join failed");
-	}
-
-	if ((ret = pthread_join(th_work, NULL))) {
-		UNRESOLVED(ret, "Worker thread join failed");
-	}
-
-	scenar_fini();
-
-#if VERBOSE > 0
-	output("Test executed successfully.\n");
-	output("  %d thread creations.\n", count_ope);
-#ifdef WITH_SYNCHRO
-	output("  %d signals were sent meanwhile.\n", count_sig);
-#endif
-#endif
-	PASSED;
-}
+/*
+ * Copyright (c) 2004, Bull S.A..  All rights reserved.
+ * Copyright (c) 2017, Linux Test Project
+ * Created by: Sebastien Decugis
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write the Free Software Foundation, Inc.,
+ *
+ * This sample test aims to check the following assertion:
+ * The function does not return EINTR
+ *
+ * The steps are:
+ * -> continuously send SIGUSR1 to a thread which runs pthread_create()
+ * -> check that EINTR is never returned
+ */
+
+/* We are testing conformance to IEEE Std 1003.1, 2003 Edition */
+#define _POSIX_C_SOURCE 200112L
+
+/* Some routines are part of the XSI Extensions */
+#ifndef WITHOUT_XOPEN
+#define _XOPEN_SOURCE	600
+#endif
+
+#include <stdio.h>
+#include <errno.h>
+#include <pthread.h>
+#include <semaphore.h>
+#include <signal.h>
+#include <sys/wait.h>
+#include <sys/time.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include "../testfrmw/testfrmw.h"
+#include "../testfrmw/testfrmw.c"
+#include "../testfrmw/threads_scenarii.c"
+#include "safe_helpers.h"
+
+#define RUN_TIME_USEC (2*1000*1000)
+#define SIGNALS_WITHOUT_DELAY 100
+
+/* total number of signals sent */
+static unsigned long count_sig;
+/* sleep [us] in between signals */
+static volatile unsigned long sleep_time;
+/* number of pthread_create scenarios tested */
+static unsigned long count_ope;
+
+static unsigned long current_time_usec(void)
+{
+	struct timeval now;
+
+	SAFE_FUNC(gettimeofday(&now, NULL));
+	return now.tv_sec * 1000000 + now.tv_usec;
+}
+
+/* the following function keeps sending signal to the process */
+static void *sendsig(void *arg)
+{
+	static sigset_t usersigs;
+
+	(void)arg;
+	pid_t process = getpid();
+
+	/* block the signal SIGUSR1 for this THREAD */
+	SAFE_FUNC(sigemptyset(&usersigs));
+	SAFE_FUNC(sigaddset(&usersigs, SIGUSR1));
+	SAFE_PFUNC(pthread_sigmask(SIG_BLOCK, &usersigs, NULL));
+
+	while (1) {
+		/*
+		 * Keep increasing sleeptime to make sure we progress
+		 * allow SIGNALS_WITHOUT_DELAY signals without any pause,
+		 * then start increasing sleep_time to make sure all threads
+		 * can progress.
+		 */
+		sleep_time++;
+		if (sleep_time / SIGNALS_WITHOUT_DELAY > 0)
+			usleep(sleep_time / SIGNALS_WITHOUT_DELAY);
+
+		count_sig++;
+		SAFE_FUNC(kill(process, SIGUSR1));
+	}
+	return NULL;
+}
+
+static void sighdl1(int sig)
+{
+	(void)sig;
+}
+
+static void *threaded(void *arg)
+{
+	int ret;
+
+	/* Signal we're done (especially in case of a detached thread) */
+	do {
+		ret = sem_post(&scenarii[sc].sem);
+	} while ((ret == -1) && (errno == EINTR));
+
+	if (ret == -1)
+		UNRESOLVED(errno, "Failed to wait for the semaphore");
+
+	return arg;
+}
+
+/* create threads and check that EINTR is never returned */
+static void test(void)
+{
+	int ret = 0;
+	pthread_t child;
+	pthread_t th_sig1;
+	struct sigaction sa;
+	pthread_attr_t attr;
+
+	sigemptyset(&sa.sa_mask);
+	sa.sa_flags = 0;
+	sa.sa_handler = sighdl1;
+	SAFE_FUNC(sigaction(SIGUSR1, &sa, NULL));
+
+	SAFE_PFUNC(pthread_attr_init(&attr));
+	SAFE_PFUNC(pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED));
+	SAFE_PFUNC(pthread_create(&th_sig1, &attr, sendsig, NULL));
+
+	for (sc = 0; sc < NSCENAR; sc++) {
+		/* reset sleep time for signal thread */
+		sleep_time = 0;
+
+		ret = pthread_create(&child, &scenarii[sc].ta, threaded, NULL);
+		if (ret == EINTR)
+			FAILED("pthread_create returned EINTR");
+
+		switch (scenarii[sc].result) {
+		case 0:	/* Operation was expected to succeed */
+			if (ret != 0)
+				UNRESOLVED(ret, "Failed to create this thread");
+			break;
+		case 1:	/* Operation was expected to fail */
+			if (ret == 0) {
+				UNRESOLVED(-1, "An error was expected but"
+					" the thread creation succeeded");
+			}
+			break;
+		case 2:	/* We did not know the expected result */
+		default:
+			break;
+		}
+
+		if (ret != 0)
+			continue;
+
+		/* The new thread is running */
+		/* Just wait for the thread to terminate */
+		do {
+			ret = sem_wait(&scenarii[sc].sem);
+		} while ((ret == -1) && (errno == EINTR));
+		if (ret == -1)
+			UNRESOLVED(errno, "Failed to wait for the semaphore");
+		if (scenarii[sc].detached == 0)
+			SAFE_PFUNC(pthread_join(child, NULL));
+	}
+}
+
+static void main_loop(void)
+{
+	int child_count = 0;
+	int ret;
+	int status;
+	int stat_pipe[2];
+	pid_t child;
+	unsigned long usec_start, usec;
+	unsigned long child_count_sig;
+
+	usec_start = current_time_usec();
+	do {
+		fflush(stdout);
+		SAFE_FUNC(pipe(stat_pipe));
+		child = SAFE_FUNC(fork());
+		if (child == 0) {
+			count_sig = 0;
+			close(stat_pipe[0]);
+			test();
+			SAFE_FUNC(write(stat_pipe[1], &count_sig,
+				sizeof(count_sig)));
+			close(stat_pipe[1]);
+			exit(0);
+		}
+		close(stat_pipe[1]);
+		SAFE_FUNC(read(stat_pipe[0], &child_count_sig,
+			sizeof(count_sig)));
+		close(stat_pipe[0]);
+		count_sig += child_count_sig;
+
+		ret = waitpid(child, &status, 0);
+		if (ret != child)
+			UNRESOLVED(errno, "Waitpid returned the wrong PID");
+		if (!WIFEXITED(status)) {
+			output("status: %d\n", status);
+			FAILED("Child exited abnormally");
+		}
+		if (WEXITSTATUS(status) != 0) {
+			output("exit status: %d\n", WEXITSTATUS(status));
+			FAILED("An error occurred in child");
+		}
+
+		child_count++;
+		count_ope += NSCENAR;
+		usec = current_time_usec();
+	} while ((usec - usec_start) < RUN_TIME_USEC);
+
+	output("Test spawned %d child processes.\n", child_count);
+	output("Test finished after %lu usec.\n", usec - usec_start);
+}
+
+int main(void)
+{
+	output_init();
+	scenar_init();
+	main_loop();
+	scenar_fini();
+
+	output("Test executed successfully.\n");
+	output("  %d thread creations.\n", count_ope);
+	output("  %d signals were sent meanwhile.\n", count_sig);
+	PASSED;
+}
-- 
1.8.3.1

