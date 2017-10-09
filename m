From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon,  9 Oct 2017 12:18:24 +0200
Subject: [LTP] [PATCH 2/2] POSIX: Allow pthread_cond_destroy to block
In-Reply-To: <20171009101824.17251-1-rpalethorpe@suse.com>
References: <20171009101824.17251-1-rpalethorpe@suse.com>
Message-ID: <20171009101824.17251-3-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 .../pthread_cond_destroy/speculative/4-1.c         | 81 ++++++++++++----------
 1 file changed, 44 insertions(+), 37 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_destroy/speculative/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_destroy/speculative/4-1.c
index 9df7c1993..6c4464cf4 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_destroy/speculative/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_destroy/speculative/4-1.c
@@ -1,19 +1,17 @@
 /*
  * Copyright (c) 2004, QUALCOMM Inc. All rights reserved.
+ * Copyright (c) 2017, Richard Palethorpe <rpalethorpe@suse.com>
  * Created by:  abisain REMOVE-THIS AT qualcomm DOT com
  * This file is licensed under the GPL license.  For the full content
  * of this license, see the COPYING file at the top level of this
  * source tree.
-
- * Test that when  pthread_cond_destroy()
- *   is called on a cond that some thread is waiting, then it returns
- *   EBUSY
-
- * Steps:
- * 1. Create a condvar
- * 2. Create a thread and make it wait on the condvar
- * 3. Try to destroy the cond var in main
- * 4. Check that pthread_cond_destroy returns EBUSY
+ *
+ * Test that EBUSY is returned when pthread_cond_destroy() is called on a cond
+ * var that has waiters. POSIX only recommends this behaviour, the required
+ * behaviour is undefined.
+ *
+ * This test is very similar to pthread_barrier_destroy 2-1 which has more
+ * explanation attached.
  */
 
 #include <pthread.h>
@@ -21,68 +19,77 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <unistd.h>
+#include <string.h>
 #include "posixtest.h"
 
-#define TEST "4-1"
-#define FUNCTION "pthread_cond_destroy"
-#define ERROR_PREFIX "unexpected error: " FUNCTION " " TEST ": "
-
-/* cond used by the two threads */
 pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
-
-/* cond used by the two threads */
 pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
 
 void *thread(void *tmp)
 {
 	int rc = 0;
 
-	/* acquire the mutex */
+	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
+
 	rc = pthread_mutex_lock(&mutex);
 	if (rc != 0) {
-		printf(ERROR_PREFIX "pthread_mutex_lock\n");
+		perror("child: pthread_mutex_lock");
 		exit(PTS_UNRESOLVED);
 	}
 
-	/* Wait on the cond var. This will not return, as nobody signals */
 	rc = pthread_cond_wait(&cond, &mutex);
-	if (rc != 0) {
-		printf(ERROR_PREFIX "pthread_cond_wait\n");
-		exit(PTS_UNRESOLVED);
-	}
+	if (rc != 0)
+		perror("child: pthread_cond_wait");
 
 	rc = pthread_mutex_unlock(&mutex);
-	if (rc != 0) {
-		printf(ERROR_PREFIX "pthread_mutex_unlock\n");
+	if (rc != 0)
+		perror("child: pthread_mutex_unlock");
+
+	return tmp;
+}
+
+void *watchdog(void *arg)
+{
+	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
+
+	sleep(1);
+	printf("watchdog: pthread_cond_destroy() appears to be blocking\n");
+	if (pthread_cond_signal(&cond)) {
+		perror("watchdog: pthread_cond_signal()");
 		exit(PTS_UNRESOLVED);
 	}
-	return NULL;
+
+	return arg;
 }
 
 int main(void)
 {
-	pthread_t low_id;
+	pthread_t low_id, watchdog_thread;
 	int rc = 0;
 
-	/* Create a new thread with default attributes */
 	rc = pthread_create(&low_id, NULL, thread, NULL);
 	if (rc != 0) {
-		printf(ERROR_PREFIX "pthread_create\n");
+		perror("main: pthread_create");
 		exit(PTS_UNRESOLVED);
 	}
 
-	/* Let the other thread run */
-	sleep(2);
+	sleep(1);
+
+	rc = pthread_create(&watchdog_thread, NULL, watchdog, NULL);
+	if (rc != 0) {
+		perror("main: pthread_create");
+		exit(PTS_UNRESOLVED);
+	}
 
-	/* Try to destroy the cond var. This should return an error */
 	rc = pthread_cond_destroy(&cond);
 	if (rc != EBUSY) {
-		printf(ERROR_PREFIX "Test PASS: Expected %d(EBUSY) got %d, "
-		       "though the standard states 'may' fail\n", EBUSY, rc);
-
-		exit(PTS_PASS);
+		printf("The standard recommends returning %d, EBUSY, but got %d, %s\n",
+		       EBUSY, rc, strerror(rc));
 	}
 
+	pthread_cancel(watchdog_thread);
+	pthread_cancel(low_id);
+
 	printf("Test PASSED\n");
 	exit(PTS_PASS);
 }
-- 
2.14.2

