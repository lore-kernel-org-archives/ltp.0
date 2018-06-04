From: Jan Stancek <jstancek@redhat.com>
Date: Mon,  4 Jun 2018 14:33:53 +0200
Subject: [LTP] [PATCH v2] pthread_cancel_3-1: rewrite
Message-ID: <e5881107e46cd94926441aee7e89d2b8b02b2665.1528114155.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This test sets priorities, measures time, tries to synchronize
threads with integers and sleeps for seconds. And there appears
to be race somewhere that makes it rarely fail.

The premise tested is that action triggered by pthread_cancel
runs asynchronously. This rewrite takes simpler approach:

Thread sleeps until it can observe variable set by parent
_after_ pthread_cancel() or after it hits specified timeout.
If timeout is hit, then presumably cleanup_func() didn't
run in parallel with main thread and test fails.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
Changes in v2, address 2 issues found by Li:
  - replace mutex with semaphore
  - check that cleanup_func has been called

 .../conformance/interfaces/pthread_cancel/3-1.c    | 249 ++++++++-------------
 1 file changed, 90 insertions(+), 159 deletions(-)
 rewrite testcases/open_posix_testsuite/conformance/interfaces/pthread_cancel/3-1.c (88%)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cancel/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cancel/3-1.c
dissimilarity index 88%
index 40469d6f3e5c..f8a795193835 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cancel/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cancel/3-1.c
@@ -1,159 +1,90 @@
-/*
- * Copyright (c) 2004, QUALCOMM Inc. All rights reserved.
- * Created by:  abisain REMOVE-THIS AT qualcomm DOT com
- * This file is licensed under the GPL license.  For the full content
- * of this license, see the COPYING file at the top level of this
- * source tree.
-
- * Test pthread_cancel
- * When the cancelation is acted on, the cancelation cleanup handlers for
- * 'thread' shall be called "asynchronously"
- *
- * STEPS:
- * 1. Change main thread to a real-time thread with a high priority
- * 1. Create a lower priority thread
- * 2. In the thread function, push a cleanup function onto the stack
- * 3. Cancel the thread from main and get timestamp, then block.
- * 4. The cleanup function should be automatically
- *    executed, else the test will fail.
- */
-
-#include <pthread.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <errno.h>
-#include <unistd.h>
-#include "posixtest.h"
-#include <time.h>
-
-#define TEST "3-1"
-#define FUNCTION "pthread_cancel"
-#define ERROR_PREFIX "unexpected error: " FUNCTION " " TEST ": "
-
-#define FIFOPOLICY SCHED_FIFO
-#define MAIN_PRIORITY 30
-#define TIMEOUT_IN_SECS 10
-
-/* Manual semaphore */
-int sem;
-
-/* Made global so that the cleanup function
- * can manipulate the value as well.
- */
-int cleanup_flag;
-struct timespec main_time, cleanup_time;
-
-/* A cleanup function that sets the cleanup_flag to 1, meaning that the
- * cleanup function was reached.
- */
-void a_cleanup_func()
-{
-	clock_gettime(CLOCK_REALTIME, &cleanup_time);
-	cleanup_flag = 1;
-	sem = 0;
-	return;
-}
-
-/* A thread function called at the creation of the thread. It will push
- * the cleanup function onto it's stack, then go into a continuous 'while'
- * loop, never reaching the cleanup_pop function.  So the only way the cleanup
- * function can be called is when the thread is canceled and all the cleanup
- * functions are supposed to be popped.
- */
-void *a_thread_func()
-{
-	int rc = 0;
-
-	/* To enable thread immediate cancelation, since the default
-	 * is PTHREAD_CANCEL_DEFERRED.
-	 */
-	rc = pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
-	if (rc != 0) {
-		printf(ERROR_PREFIX "pthread_setcanceltype\n");
-		exit(PTS_UNRESOLVED);
-	}
-	pthread_cleanup_push(a_cleanup_func, NULL);
-
-	sem = 1;
-	while (sem == 1)
-		sleep(1);
-	sleep(5);
-	sem = 0;
-
-	/* Should never be reached, but is required to be in the code
-	 * since pthread_cleanup_push is in the code.  Else a compile error
-	 * will result.
-	 */
-	pthread_cleanup_pop(0);
-	pthread_exit(0);
-	return NULL;
-}
-
-int main(void)
-{
-	pthread_t new_th;
-	int i;
-	double diff;
-	struct sched_param param;
-	int rc = 0;
-
-	/* Initializing the cleanup flag. */
-	cleanup_flag = 0;
-	sem = 0;
-	param.sched_priority = MAIN_PRIORITY;
-
-	/* Increase priority of main, so the new thread doesn't get to run */
-	rc = pthread_setschedparam(pthread_self(), FIFOPOLICY, &param);
-	if (rc != 0) {
-		printf(ERROR_PREFIX "pthread_setschedparam\n");
-		exit(PTS_UNRESOLVED);
-	}
-
-	/* Create a new thread. */
-	rc = pthread_create(&new_th, NULL, a_thread_func, NULL);
-	if (rc != 0) {
-		printf(ERROR_PREFIX "pthread_create\n");
-		return PTS_UNRESOLVED;
-	}
-
-	/* Make sure thread is created and executed before we cancel it. */
-	while (sem == 0)
-		sleep(1);
-
-	rc = pthread_cancel(new_th);
-	if (rc != 0) {
-		printf(ERROR_PREFIX "pthread_cancel\n");
-		exit(PTS_FAIL);
-	}
-
-	/* Get the time after canceling the thread */
-	clock_gettime(CLOCK_REALTIME, &main_time);
-	i = 0;
-	while (sem == 1) {
-		sleep(1);
-		if (i == TIMEOUT_IN_SECS) {
-			printf(ERROR_PREFIX "Cleanup handler was not called\n");
-			exit(PTS_FAIL);
-		}
-		i++;
-	}
-
-	/* If the cleanup function was not reached by calling the
-	 * pthread_cancel function, then the test fails.
-	 */
-	if (cleanup_flag != 1) {
-		printf(ERROR_PREFIX "Cleanup handler was not called\n");
-		exit(PTS_FAIL);
-	}
-
-	diff = cleanup_time.tv_sec - main_time.tv_sec;
-	diff +=
-	    (double)(cleanup_time.tv_nsec - main_time.tv_nsec) / 1000000000.0;
-	if (diff < 0) {
-		printf(ERROR_PREFIX
-		       "Cleanup function was called before main continued\n");
-		exit(PTS_FAIL);
-	}
-	printf("Test PASSED\n");
-	exit(PTS_PASS);
-}
+/*
+ * Copyright (c) 2018, Linux Test Project
+ * This file is licensed under the GPL license.  For the full content
+ * of this license, see the COPYING file@the top level of this
+ * source tree.
+ *
+ * Cancellation steps happen asynchronously with respect to
+ * the pthread_cancel(). The return status of pthread_cancel()
+ * merely informs the caller whether the cancellation request
+ * was successfully queued.
+ */
+
+#include <pthread.h>
+#include <semaphore.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <unistd.h>
+#include "posixtest.h"
+#include "safe_helpers.h"
+
+#define TIMEOUT_MS 5000
+#define SLEEP_MS 1
+
+static volatile int after_cancel;
+static volatile int thread_sleep_time;
+static sem_t sem;
+
+static void cleanup_func(void *unused)
+{
+	do {
+		usleep(SLEEP_MS*1000);
+		thread_sleep_time += SLEEP_MS;
+	} while (after_cancel == 0 && thread_sleep_time < TIMEOUT_MS);
+}
+
+static void *thread_func(void *unused)
+{
+	int waited_for_cancel_ms = 0;
+
+	SAFE_PFUNC(pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL));
+	pthread_cleanup_push(cleanup_func, NULL);
+
+	SAFE_FUNC(sem_post(&sem));
+	while (waited_for_cancel_ms < TIMEOUT_MS) {
+		usleep(SLEEP_MS*1000);
+		waited_for_cancel_ms += SLEEP_MS;
+	}
+
+	/* shouldn't be reached */
+	printf("Error: cancel never arrived\n");
+	pthread_cleanup_pop(0);
+	exit(PTS_FAIL);
+	return NULL;
+}
+
+int main(void)
+{
+	pthread_t th;
+
+	SAFE_FUNC(sem_init(&sem, 0, 0));
+	SAFE_PFUNC(pthread_create(&th, NULL, thread_func, NULL));
+
+	/* wait for thread to start */
+	SAFE_FUNC(sem_wait(&sem));
+	SAFE_PFUNC(pthread_cancel(th));
+
+	/*
+	 * if cancel action would run synchronously then
+	 * thread will sleep for too long, because it
+	 * would never see after_cancel == 1
+	 */
+	after_cancel = 1;
+
+	SAFE_PFUNC(pthread_join(th, NULL));
+
+	if (thread_sleep_time >= TIMEOUT_MS) {
+		printf("Error: cleanup_func hit timeout\n");
+		exit(PTS_FAIL);
+	}
+
+	if (thread_sleep_time == 0) {
+		printf("Error: cleanup_func never called\n");
+		exit(PTS_FAIL);
+	}
+
+	printf("Thread cancelled after %d ms.\n", thread_sleep_time);
+	printf("Test PASSED\n");
+	exit(PTS_PASS);
+}
-- 
1.8.3.1

