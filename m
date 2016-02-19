From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 19 Feb 2016 11:03:35 +0100
Subject: [LTP] [PATCH 3/5] open_posix: condvar/schedule: remove useless
	waiting
In-Reply-To: <eb9862205b7122243cfba5ecae0a9293f7d95c21.1455875648.git.jstancek@redhat.com>
References: <eb9862205b7122243cfba5ecae0a9293f7d95c21.1455875648.git.jstancek@redhat.com>
Message-ID: <e33f0c95db65876824502f08c6e994dad29f4de8.1455875648.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If high prio thread wakes up, test is done, there's no point waiting
another 3 seconds for low prio thread to end its busy loop.

If test PASS-es, we save 3 seconds per test.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../functional/threads/condvar/pthread_cond_wait_1.c         | 12 ++++++------
 .../functional/threads/condvar/pthread_cond_wait_2.c         | 12 ++++++------
 .../open_posix_testsuite/functional/threads/schedule/1-1.c   | 10 +++++-----
 .../open_posix_testsuite/functional/threads/schedule/1-2.c   | 10 +++++-----
 4 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/testcases/open_posix_testsuite/functional/threads/condvar/pthread_cond_wait_1.c b/testcases/open_posix_testsuite/functional/threads/condvar/pthread_cond_wait_1.c
index 5b36fc24a3b8..dfbf44bdefd7 100644
--- a/testcases/open_posix_testsuite/functional/threads/condvar/pthread_cond_wait_1.c
+++ b/testcases/open_posix_testsuite/functional/threads/condvar/pthread_cond_wait_1.c
@@ -39,8 +39,8 @@ pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
 pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
 
 /* Flags that the threads use to indicate events */
-int woken_up = -1;
-int low_done = -1;
+static volatile int woken_up;
+static volatile int low_done;
 
 void signal_handler(int sig)
 {
@@ -85,7 +85,7 @@ void *hi_prio_thread(void *tmp)
 	/* This variable is unprotected because the scheduling removes
 	 * the contention
 	 */
-	if (low_done != 1)
+	if (!low_done)
 		woken_up = 1;
 
 	SAFE_PFUNC(pthread_mutex_unlock(&mutex));
@@ -109,7 +109,7 @@ void *low_prio_thread(void *tmp)
 	}
 
 	clock_gettime(CLOCK_REALTIME, &start_time);
-	while (1) {
+	while (!woken_up) {
 		clock_gettime(CLOCK_REALTIME, &current_time);
 		if (timediff(current_time, start_time) > RUNTIME)
 			break;
@@ -142,8 +142,8 @@ int main()
 	SAFE_PFUNC(pthread_join(high_id, NULL));
 	SAFE_PFUNC(pthread_join(low_id, NULL));
 
-	if (woken_up == -1) {
-		printf("Test FAILED: high priority was not woken up\\n");
+	if (!woken_up) {
+		printf("Test FAILED: high priority was not woken up\n");
 		exit(PTS_FAIL);
 	}
 
diff --git a/testcases/open_posix_testsuite/functional/threads/condvar/pthread_cond_wait_2.c b/testcases/open_posix_testsuite/functional/threads/condvar/pthread_cond_wait_2.c
index 7308bd6b98d1..c5670f8e26fd 100644
--- a/testcases/open_posix_testsuite/functional/threads/condvar/pthread_cond_wait_2.c
+++ b/testcases/open_posix_testsuite/functional/threads/condvar/pthread_cond_wait_2.c
@@ -39,8 +39,8 @@ pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
 pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
 
 /* Flags that the threads use to indicate events */
-int woken_up = -1;
-int low_done = -1;
+static volatile int woken_up;
+static volatile int low_done;
 
 void signal_handler(int sig)
 {
@@ -85,7 +85,7 @@ void *hi_prio_thread(void *tmp)
 	/* This variable is unprotected because the scheduling removes
 	 * the contention
 	 */
-	if (low_done != 1)
+	if (!low_done)
 		woken_up = 1;
 
 	SAFE_PFUNC(pthread_mutex_unlock(&mutex));
@@ -109,7 +109,7 @@ void *low_prio_thread(void *tmp)
 	}
 
 	clock_gettime(CLOCK_REALTIME, &start_time);
-	while (1) {
+	while (!woken_up) {
 		clock_gettime(CLOCK_REALTIME, &current_time);
 		if (timediff(current_time, start_time) > RUNTIME)
 			break;
@@ -142,8 +142,8 @@ int main()
 	SAFE_PFUNC(pthread_join(high_id, NULL));
 	SAFE_PFUNC(pthread_join(low_id, NULL));
 
-	if (woken_up == -1) {
-		printf("Test FAILED: high priority was not woken up\\n");
+	if (!woken_up) {
+		printf("Test FAILED: high priority was not woken up\n");
 		exit(PTS_FAIL);
 	}
 
diff --git a/testcases/open_posix_testsuite/functional/threads/schedule/1-1.c b/testcases/open_posix_testsuite/functional/threads/schedule/1-1.c
index f1bf37292b53..a6b634c7c59d 100644
--- a/testcases/open_posix_testsuite/functional/threads/schedule/1-1.c
+++ b/testcases/open_posix_testsuite/functional/threads/schedule/1-1.c
@@ -37,8 +37,8 @@
 #define RUNTIME 5
 
 pthread_barrier_t barrier;
-volatile int woken_up = -1;
-volatile int low_done = -1;
+static volatile int woken_up;
+static volatile int low_done;
 
 float timediff(struct timespec t2, struct timespec t1)
 {
@@ -91,7 +91,7 @@ void *hi_prio_thread(void *tmp)
 	/* This variable is unprotected because the scheduling removes
 	 * the contention
 	 */
-	if (low_done != 1)
+	if (!low_done)
 		woken_up = 1;
 
 	pthread_exit(NULL);
@@ -113,7 +113,7 @@ void *low_prio_thread(void *tmp)
 	}
 
 	clock_gettime(CLOCK_REALTIME, &start_timespec);
-	while (1) {
+	while (!woken_up) {
 		clock_gettime(CLOCK_REALTIME, &current_timespec);
 		if (timediff(current_timespec, start_timespec) > RUNTIME)
 			break;
@@ -149,7 +149,7 @@ int main()
 	SAFE_PFUNC(pthread_join(high_id, NULL));
 	SAFE_PFUNC(pthread_join(low_id, NULL));
 
-	if (woken_up == -1) {
+	if (!woken_up) {
 		printf("High priority was not woken up. Test FAILED\n");
 		exit(PTS_FAIL);
 	}
diff --git a/testcases/open_posix_testsuite/functional/threads/schedule/1-2.c b/testcases/open_posix_testsuite/functional/threads/schedule/1-2.c
index 3d3427b8ec4b..f7b0bd89e081 100644
--- a/testcases/open_posix_testsuite/functional/threads/schedule/1-2.c
+++ b/testcases/open_posix_testsuite/functional/threads/schedule/1-2.c
@@ -39,8 +39,8 @@ pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
 pthread_mutex_t cond_mutex = PTHREAD_MUTEX_INITIALIZER;
 pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
 
-volatile int woken_up = -1;
-volatile int low_done = -1;
+static volatile int woken_up;
+static volatile int low_done;
 
 float timediff(struct timespec t2, struct timespec t1)
 {
@@ -78,7 +78,7 @@ void *hi_prio_thread(void *tmp)
 	/* This variable is unprotected because the scheduling removes
 	 * the contention
 	 */
-	if (low_done != 1)
+	if (!low_done)
 		woken_up = 1;
 
 	SAFE_PFUNC(pthread_mutex_unlock(&mutex));
@@ -105,7 +105,7 @@ void *low_prio_thread(void *tmp)
 	}
 
 	clock_gettime(CLOCK_REALTIME, &start_time);
-	while (1) {
+	while (!woken_up) {
 		clock_gettime(CLOCK_REALTIME, &current_time);
 		if (timediff(current_time, start_time) > RUNTIME)
 			break;
@@ -168,7 +168,7 @@ int main()
 	SAFE_PFUNC(pthread_join(high_id, NULL));
 	SAFE_PFUNC(pthread_join(low_id, NULL));
 
-	if (woken_up == -1) {
+	if (!woken_up) {
 		printf("High priority was not woken up. Test FAILED.\n");
 		exit(PTS_FAIL);
 	}
-- 
1.8.3.1

