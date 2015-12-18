From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 18 Dec 2015 17:35:30 +0300
Subject: [LTP] [PATCH 2/7] pi_test: move thread_fn() to the header
In-Reply-To: <1450449335-18223-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1450449335-18223-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1450449335-18223-3-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

All the test cases, excluding pitest-4, have absolutely
identical copies of thread_fn(), so let's move it to the header.

thread_fn() in pitest-4 is a bit different, so on let's just
rename it for simplicity.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../functional/threads/include/pitest.h            |   41 ++++++++++++++++++++
 .../functional/threads/pi_test/pitest-1.c          |   40 -------------------
 .../functional/threads/pi_test/pitest-2.c          |   38 ------------------
 .../functional/threads/pi_test/pitest-3.c          |   41 --------------------
 .../functional/threads/pi_test/pitest-4.c          |   10 ++--
 .../functional/threads/pi_test/pitest-5.c          |   41 --------------------
 .../functional/threads/pi_test/pitest-6.c          |   40 -------------------
 7 files changed, 46 insertions(+), 205 deletions(-)

diff --git a/testcases/open_posix_testsuite/functional/threads/include/pitest.h b/testcases/open_posix_testsuite/functional/threads/include/pitest.h
index 89d2ca0..2bda342 100644
--- a/testcases/open_posix_testsuite/functional/threads/include/pitest.h
+++ b/testcases/open_posix_testsuite/functional/threads/include/pitest.h
@@ -126,3 +126,44 @@ static void do_work(unsigned granularity_top, volatile unsigned *progress)
 		(*progress)++;
 	}
 }
+
+static void *thread_fn(void *param)
+{
+	struct thread_param *tp = param;
+	struct timespec ts;
+	int rc;
+	unsigned long mask = 1 << tp->cpu;
+
+#if __linux__
+	rc = sched_setaffinity(0, sizeof(mask), &mask);
+	if (rc < 0) {
+		EPRINTF("UNRESOLVED: Thread %s index %d: Can't set affinity: "
+			"%d %s", tp->name, tp->index, rc, strerror(rc));
+		exit(UNRESOLVED);
+	}
+#endif
+	test_set_priority(pthread_self(), tp->policy, tp->priority);
+
+	DPRINTF(stdout, "#EVENT %f %s Thread Started\n",
+		seconds_read() - base_time, tp->name);
+
+	tp->progress = 0;
+	ts.tv_sec = 0;
+	ts.tv_nsec = tp->sleep_ms * 1000 * 1000;
+	while (!tp->stop) {
+		do_work(5, &tp->progress);
+		if (tp->sleep_ms == 0)
+			continue;
+		rc = nanosleep(&ts, NULL);
+		if (rc < 0) {
+			EPRINTF("UNRESOLVED: Thread %s %d: nanosleep returned "
+				"%d %s\n", tp->name, tp->index, rc,
+				strerror(rc));
+			exit(UNRESOLVED);
+		}
+	}
+
+	DPRINTF(stdout, "#EVENT %f %s Thread Stopped\n",
+		seconds_read() - base_time, tp->name);
+	return NULL;
+}
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-1.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-1.c
index 3db1134..7ef46f6 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-1.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-1.c
@@ -49,46 +49,6 @@ struct thread_param tp[] = {
 	7, 0, 0, 3, SCHED_FIFO, "TF", 6, 0, 0, 0}
 };
 
-void *thread_fn(void *param)
-{
-	struct thread_param *tp = param;
-	struct timespec ts;
-	int rc;
-	unsigned long mask = 1 << tp->cpu;
-
-#if __linux__
-	rc = sched_setaffinity(0, sizeof(mask), &mask);
-	if (rc < 0) {
-		EPRINTF("UNRESOLVED: Thread %s index %d: Can't set affinity: "
-			"%d %s", tp->name, tp->index, rc, strerror(rc));
-		exit(UNRESOLVED);
-	}
-#endif
-	test_set_priority(pthread_self(), SCHED_FIFO, tp->priority);
-
-	DPRINTF(stdout, "#EVENT %f %s Thread Started\n",
-		seconds_read() - base_time, tp->name);
-	tp->progress = 0;
-	ts.tv_sec = 0;
-	ts.tv_nsec = tp->sleep_ms * 1000 * 1000;
-	while (!tp->stop) {
-		do_work(5, &tp->progress);
-		if (tp->sleep_ms == 0)
-			continue;
-		rc = nanosleep(&ts, NULL);
-		if (rc < 0) {
-			EPRINTF("UNRESOLVED: Thread %s %d: nanosleep returned "
-				"%d %s \n", tp->name, tp->index, rc,
-				strerror(rc));
-			exit(UNRESOLVED);
-		}
-	}
-
-	DPRINTF(stdout, "#EVENT %f %s Thread Stopped\n",
-		seconds_read() - base_time, tp->name);
-	return NULL;
-}
-
 void *thread_tl(void *param)
 {
 	struct thread_param *tp = param;
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-2.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-2.c
index 0220af8..066a7b8 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-2.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-2.c
@@ -52,44 +52,6 @@ struct thread_param tp[] = {
 	8, 0, 0, 3, SCHED_FIFO, "TF", 6, 0, 0, 0}
 };
 
-void *thread_fn(void *param)
-{
-	struct thread_param *tp = param;
-	struct timespec ts;
-	int rc;
-	unsigned long mask = 1 << tp->cpu;
-
-#if __linux__
-	rc = sched_setaffinity(0, sizeof(mask), &mask);
-#endif
-	if (rc < 0) {
-		EPRINTF("UNRESOLVED: Thread %s index %d: Can't set affinity: "
-			"%d %s", tp->name, tp->index, rc, strerror(rc));
-		exit(UNRESOLVED);
-	}
-	test_set_priority(pthread_self(), SCHED_FIFO, tp->priority);
-	DPRINTF(stdout, "#EVENT %f Thread %s Started\n",
-		seconds_read() - base_time, tp->name);
-	DPRINTF(stderr, "Thread %s index %d: started \n", tp->name, tp->index);
-	tp->progress = 0;
-	ts.tv_sec = 0;
-	ts.tv_nsec = tp->sleep_ms * 1000 * 1000;
-	while (!tp->stop) {
-		do_work(5, &tp->progress);
-		if (tp->sleep_ms == 0)
-			continue;
-		rc = nanosleep(&ts, NULL);
-		if (rc < 0) {
-			EPRINTF("UNRESOLVED: Thread %s %d: nanosleep returned "
-				"%d %s", tp->name, tp->index, rc, strerror(rc));
-			exit(UNRESOLVED);
-		}
-	}
-	DPRINTF(stdout, "#EVENT %f Thread %s Stopped\n",
-		seconds_read() - base_time, tp->name);
-	return NULL;
-}
-
 void *thread_tl(void *param)
 {
 	struct thread_param *tp = param;
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-3.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-3.c
index b9d63ec..e37746c 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-3.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-3.c
@@ -53,47 +53,6 @@ struct thread_param tp[] = {
 	7, 0, 0, 3, SCHED_FIFO, "TF", 6, 0, 0, 0}
 };
 
-void *thread_fn(void *param)
-{
-	struct thread_param *tp = param;
-	struct timespec ts;
-	int rc;
-	unsigned long mask = 1 << tp->cpu;
-
-#if __linux__
-	rc = sched_setaffinity(0, sizeof(mask), &mask);
-	if (rc < 0) {
-		EPRINTF("UNRESOLVED: Thread %s index %d: Can't set affinity: "
-			"%d %s", tp->name, tp->index, rc, strerror(rc));
-		exit(UNRESOLVED);
-	}
-#endif
-	test_set_priority(pthread_self(), SCHED_FIFO, tp->priority);
-
-	DPRINTF(stdout, "#EVENT %f Thread %s Started\n",
-		seconds_read() - base_time, tp->name);
-	DPRINTF(stderr, "Thread %s index %d: started\n", tp->name, tp->index);
-
-	tp->progress = 0;
-	ts.tv_sec = 0;
-	ts.tv_nsec = tp->sleep_ms * 1000 * 1000;
-	while (!tp->stop) {
-		do_work(5, &tp->progress);
-		if (tp->sleep_ms == 0)
-			continue;
-		rc = nanosleep(&ts, NULL);
-		if (rc < 0) {
-			EPRINTF("UNRESOLVED: Thread %s %d: nanosleep returned "
-				"%d %s", tp->name, tp->index, rc, strerror(rc));
-			exit(UNRESOLVED);
-		}
-	}
-
-	DPRINTF(stdout, "#EVENT %f Thread %s Stopped\n",
-		seconds_read() - base_time, tp->name);
-	return NULL;
-}
-
 void *thread_tl(void *param)
 {
 	struct thread_param *tp = param;
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c
index 75a776b..84ad62c 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c
@@ -53,7 +53,7 @@ struct thread_param tp[] = {
 	7, 0, 0, 2, SCHED_FIFO, "TF", 6, 0, 0, 0}
 };
 
-void *thread_fn(void *param)
+void *thread_fn4(void *param)
 {
 	struct thread_param *tp = param;
 	struct timespec ts;
@@ -68,7 +68,7 @@ void *thread_fn(void *param)
 		exit(UNRESOLVED);
 	}
 #endif
-	test_set_priority(pthread_self(), SCHED_FIFO, tp->priority);
+	test_set_priority(pthread_self(), tp->policy, tp->priority);
 
 	DPRINTF(stdout, "#EVENT %f Thread %s Started\n",
 		seconds_read() - base_time, tp->name);
@@ -227,7 +227,7 @@ int main(int argc, char **argv)
 	/* Start the TF threads */
 	DPRINTF(stderr, "Main Thread: Creating %d TF threads\n", cpus - 1);
 	for (i = 0; i < cpus - 1; i++) {
-		rc = pthread_create(&threads[i], &threadattr, thread_fn,
+		rc = pthread_create(&threads[i], &threadattr, thread_fn4,
 				    &tp[i + 2]);
 		if (rc != 0) {
 			EPRINTF("UNRESOLVED: pthread_create: %d %s",
@@ -239,7 +239,7 @@ int main(int argc, char **argv)
 
 	/* Start TP thread */
 	DPRINTF(stderr, "Main Thread: Creating TP thread\n");
-	rc = pthread_create(&threadtp, &threadattr, thread_fn, &tp[1]);
+	rc = pthread_create(&threadtp, &threadattr, thread_fn4, &tp[1]);
 	if (rc != 0) {
 		EPRINTF("UNRESOLVED: pthread_create: %d %s", rc, strerror(rc));
 		exit(UNRESOLVED);
@@ -248,7 +248,7 @@ int main(int argc, char **argv)
 
 	/* Start TL thread */
 	DPRINTF(stderr, "Main Thread: Creating TL thread\n");
-	rc = pthread_create(&threadtl, &threadattr, thread_fn, &tp[0]);
+	rc = pthread_create(&threadtl, &threadattr, thread_fn4, &tp[0]);
 	if (rc != 0) {
 		EPRINTF("UNRESOLVED: pthread_create: %d %s", rc, strerror(rc));
 		exit(UNRESOLVED);
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-5.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-5.c
index b70c549..6cc07b7 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-5.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-5.c
@@ -51,47 +51,6 @@ struct thread_param tp[] = {
 	7, 0, 0, 3, SCHED_FIFO, "TF", 6, 0, 0, 0}
 };
 
-void *thread_fn(void *param)
-{
-	struct thread_param *tp = param;
-	struct timespec ts;
-	int rc;
-	unsigned long mask = 1 << tp->cpu;
-
-	test_set_priority(pthread_self(), SCHED_FIFO, tp->priority);
-#if __linux__
-	rc = sched_setaffinity(0, sizeof(mask), &mask);
-	if (rc < 0) {
-		EPRINTF("UNRESOLVED: Thread %s index %d: Can't set affinity: "
-			"%d %s", tp->name, tp->index, rc, strerror(rc));
-		exit(UNRESOLVED);
-	}
-#endif
-
-	DPRINTF(stdout, "#EVENT %f Thread %s started\n",
-		seconds_read() - base_time, tp->name);
-	DPRINTF(stderr, "Thread %s index %d: started\n", tp->name, tp->index);
-
-	tp->progress = 0;
-	ts.tv_sec = 0;
-	ts.tv_nsec = tp->sleep_ms * 1000 * 1000;
-	while (!tp->stop) {
-		do_work(5, &tp->progress);
-		if (tp->sleep_ms == 0)
-			continue;
-		rc = nanosleep(&ts, NULL);
-		if (rc < 0) {
-			EPRINTF("UNRESOLVED: Thread %s %d: nanosleep returned "
-				"%d %s", tp->name, tp->index, rc, strerror(rc));
-			exit(UNRESOLVED);
-		}
-	}
-
-	DPRINTF(stdout, "#EVENT %f Thread %s stopped\n",
-		seconds_read() - base_time, tp->name);
-	return NULL;
-}
-
 void *thread_tl(void *param)
 {
 	struct thread_param *tp = param;
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-6.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-6.c
index bd92613..c6c3046 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-6.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-6.c
@@ -49,46 +49,6 @@ struct thread_param tp[] = {
 	7, 0, 0, 3, SCHED_FIFO, "TF", 6, 0, 0, 0}
 };
 
-void *thread_fn(void *param)
-{
-	struct thread_param *tp = param;
-	struct timespec ts;
-	int rc;
-	unsigned long mask = 1 << tp->cpu;
-
-#if __linux__
-	rc = sched_setaffinity(0, sizeof(mask), &mask);
-	if (rc < 0) {
-		EPRINTF("UNRESOLVED: Thread %s index %d: Can't set affinity: "
-			"%d %s", tp->name, tp->index, rc, strerror(rc));
-		exit(UNRESOLVED);
-	}
-#endif
-	test_set_priority(pthread_self(), SCHED_FIFO, tp->priority);
-	DPRINTF(stderr, "Thread %s index %d: started\n", tp->name, tp->index);
-	DPRINTF(stdout, "#EVENT %f Thread %s Started\n",
-		seconds_read() - base_time, tp->name);
-
-	tp->progress = 0;
-	ts.tv_sec = 0;
-	ts.tv_nsec = tp->sleep_ms * 1000 * 1000;
-	while (!tp->stop) {
-		do_work(5, &tp->progress);
-		if (tp->sleep_ms == 0)
-			continue;
-		rc = nanosleep(&ts, NULL);
-		if (rc < 0) {
-			EPRINTF("UNRESOLVED: Thread %s %d: nanosleep returned "
-				"%d %s", tp->name, tp->index, rc, strerror(rc));
-			exit(UNRESOLVED);
-		}
-	}
-
-	DPRINTF(stdout, "#EVENT %f Thread %s Started\n",
-		seconds_read() - base_time, tp->name);
-	return NULL;
-}
-
 void *thread_tl(void *param)
 {
 	struct thread_param *tp = param;
-- 
1.7.1

