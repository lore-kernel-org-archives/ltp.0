From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon,  9 Oct 2017 12:18:23 +0200
Subject: [LTP] [PATCH 1/2] POSIX: Allow pthread_barrier_destroy() to block
In-Reply-To: <20171009101824.17251-1-rpalethorpe@suse.com>
References: <20171009101824.17251-1-rpalethorpe@suse.com>
Message-ID: <20171009101824.17251-2-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Newer glibc versions choose to block until a barrier's users have all
synchronised with it. This caused the test to hang forever, so a watchdog has
been introduced to complete the barrier after a timeout.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 .../interfaces/pthread_barrier_destroy/2-1.c       | 101 +++++++++++++--------
 1 file changed, 61 insertions(+), 40 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_destroy/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_destroy/2-1.c
index 7abb08ff8..a89b87f6e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_destroy/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_destroy/2-1.c
@@ -1,23 +1,25 @@
 /*
  * Copyright (c) 2002, Intel Corporation. All rights reserved.
+ * Copyright (c) 2017, Richard Palethorpe <rpalethorpe@suse.com>
  * This file is licensed under the GPL license.  For the full content
  * of this license, see the COPYING file at the top level of this
  * source tree.
  *
  * pthread_barrier_destroy()
  *
- * The pthread_barrier_destroy() function may fail if:
- * [EBUSY] The implementation has detected an attempt to destroy a barrier while it is in
- * use (for example, while being used in a pthread_barrier_wait() call) by another
- * thread.
+ * Attempt to destroy a barrier which has a waiter. The standard recommends
+ * that EBUSY is returned, but the required behaviour is undefined. At the
+ * time of writing, glibc blocks until there are no threads waiting on the
+ * barrier.
  *
- * Note: This case will always PASS
+ * Hypothetically, on some implementations, the child could segfault or
+ * 'barrier_wait() could return success or EINVAL when 'barrier_destroy() is
+ * called. It is difficult to determine whether 'barrier_wait() has returned
+ * due to 'barrier_destroy() or some other reason. So we just report what has
+ * happened. Obviously a segfault will cause the test to crash, which is
+ * highly undesirable behaviour regardless of whether it is POSIX compliant.
  *
- * Steps:
- * 1. Main initialize barrier with count 2
- * 2. Main create a child thread
- * 3. Child thread call pthread_barrier_wait(), should block
- * 4. Main call pthread_barrier_destroy(), while child is blocking on the barrier
+ * Also see pthread_cond_destroy 4-1.
  */
 
 #define _XOPEN_SOURCE 600
@@ -28,13 +30,15 @@
 #include <signal.h>
 #include <string.h>
 #include <errno.h>
+#include <sched.h>
 #include "posixtest.h"
 
 static pthread_barrier_t barrier;
-static int thread_state;
+static volatile int thread_state;
 #define NOT_CREATED_THREAD 1
 #define ENTERED_THREAD 2
 #define EXITING_THREAD 3
+#define WAIT_LOOP 0xFFFFFF
 
 static void *fn_chld(void *arg)
 {
@@ -42,73 +46,90 @@ static void *fn_chld(void *arg)
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
 
+	printf("child: barrier wait\n");
 	thread_state = ENTERED_THREAD;
+	rc = pthread_barrier_wait(&barrier);
+	if (rc == PTHREAD_BARRIER_SERIAL_THREAD)
+		printf("child: got PTHREAD_BARRIER_SERIAL_THREAD\n");
+	else if (rc != 0)
+		perror("child: pthread_barrier_wait");
+	else
+		printf("child: pthread_barrier_wait returned success");
 
-	/* Child should block here */
-	printf("child: barrier wait\n");
+	thread_state = EXITING_THREAD;
+	return arg;
+}
+
+static void *watchdog(void *arg)
+{
+	int rc = 0;
+
+	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
+
+	sleep(1);
+	printf("watchdog: It appears pthread_barrier_destroy() is blocking\n");
 	rc = pthread_barrier_wait(&barrier);
 	if (rc != 0 && rc != PTHREAD_BARRIER_SERIAL_THREAD) {
-		printf("Error: child: pthread_barrier_wait() get unexpected "
-		       "return code : %d\n", rc);
+		perror("watchdog: pthread_barrier_wait");
 		exit(PTS_UNRESOLVED);
-	} else if (rc == PTHREAD_BARRIER_SERIAL_THREAD) {
-		printf("child: get PTHREAD_BARRIER_SERIAL_THREAD\n");
 	}
 
-	thread_state = EXITING_THREAD;
-	pthread_exit(0);
-	return NULL;
+	return arg;
 }
 
 int main(void)
 {
 	int cnt = 0;
 	int rc;
-	pthread_t child_thread;
+	pthread_t child_thread, watchdog_thread;
 
 	printf("main: Initialize barrier with count = 2\n");
 	if (pthread_barrier_init(&barrier, NULL, 2) != 0) {
-		printf("main: Error at pthread_barrier_init()\n");
+		perror("main: pthread_barrier_init");
 		return PTS_UNRESOLVED;
 	}
 
 	printf("main: create child thread\n");
 	thread_state = NOT_CREATED_THREAD;
 	if (pthread_create(&child_thread, NULL, fn_chld, NULL) != 0) {
-		printf("main: Error at pthread_create()\n");
+		perror("main: pthread_create");
+		return PTS_UNRESOLVED;
+	}
+
+	printf("main: create watchdog thread\n");
+	if (pthread_create(&watchdog_thread, NULL, watchdog, NULL) != 0) {
+		perror("main: Error at pthread_create");
 		return PTS_UNRESOLVED;
 	}
 
-	/* Expect the child to block */
 	cnt = 0;
-	do {
-		sleep(1);
-	} while (thread_state != EXITING_THREAD && cnt++ < 2);
+	for (cnt = 0; thread_state < ENTERED_THREAD && cnt < WAIT_LOOP; cnt++)
+		sched_yield();
+	/* Yield once more to increase the probability that the child thread
+	 * will call pthread_barrier_wait() before this thread reaches
+	 * pthread_barrier_destroy().
+	 */
+	sched_yield();
 
 	if (thread_state == EXITING_THREAD) {
-		/* child thread did not block */
-		printf("Test FAILED: child thread did not block on "
-		       "pthread_barrier_wait()\n");
+		printf("Test FAILED: child thread did not block on pthread_barrier_wait()\n");
 		exit(PTS_FAIL);
-	} else if (thread_state != ENTERED_THREAD) {
-		printf("Unexpected thread state\n");
+	} else if (thread_state == NOT_CREATED_THREAD) {
+		printf("Child thread did not start (quick enough)\n");
 		exit(PTS_UNRESOLVED);
 	}
 
 	printf("main: destroy barrier while child is waiting\n");
-
 	rc = pthread_barrier_destroy(&barrier);
 
-	if (rc == EBUSY) {
-		printf("main: correctly got EBUSY\n");
-		printf("Test PASSED\n");
-	} else {
+	if (rc != EBUSY) {
 		printf("main: got return code: %d, %s\n", rc, strerror(rc));
-		printf
-		    ("Test PASSED: Note*: Expected EBUSY, but standard says 'may' fail.\n");
+		printf("Note: POSIX recommends returning EBUSY\n");
 	}
 
-	/* Cleanup (cancel thread in case it is still blocking */
+	printf("Test PASSED\n");
+
+	pthread_cancel(watchdog_thread);
 	pthread_cancel(child_thread);
 
 	return PTS_PASS;
-- 
2.14.2

