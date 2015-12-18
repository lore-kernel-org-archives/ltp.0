From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 18 Dec 2015 17:35:31 +0300
Subject: [LTP] [PATCH 3/7] pi_test: move thread_tl() to the header
In-Reply-To: <1450449335-18223-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1450449335-18223-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1450449335-18223-4-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

thread_tl() in pitest-5 is a bit different, so
just rename it for simplicity.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../functional/threads/include/pitest.h            |   51 ++++++++++++++++++++
 .../functional/threads/pi_test/pitest-1.c          |   38 ++-------------
 .../functional/threads/pi_test/pitest-2.c          |   38 ++-------------
 .../functional/threads/pi_test/pitest-3.c          |   42 ++--------------
 .../functional/threads/pi_test/pitest-5.c          |    6 +-
 .../functional/threads/pi_test/pitest-6.c          |   38 ++-------------
 6 files changed, 74 insertions(+), 139 deletions(-)

diff --git a/testcases/open_posix_testsuite/functional/threads/include/pitest.h b/testcases/open_posix_testsuite/functional/threads/include/pitest.h
index 2bda342..a23693b 100644
--- a/testcases/open_posix_testsuite/functional/threads/include/pitest.h
+++ b/testcases/open_posix_testsuite/functional/threads/include/pitest.h
@@ -38,6 +38,12 @@ struct thread_param {
 	volatile unsigned progress;
 };
 
+/* Arguments to thread_tl */
+struct tl_param {
+	struct thread_param *tp;
+	pthread_mutex_t **mutexes; /* NULL-terminated */
+};
+
 static int cpus;
 static volatile int ts_stop;
 static volatile double base_time;
@@ -167,3 +173,48 @@ static void *thread_fn(void *param)
 		seconds_read() - base_time, tp->name);
 	return NULL;
 }
+
+static void *thread_tl(void *param)
+{
+	struct tl_param *tlp = param;
+	struct thread_param *tp = tlp->tp;
+	unsigned long mask = 1 << tp->cpu;
+	pthread_mutex_t **mutex;
+	int rc;
+
+#if __linux__
+	rc = sched_setaffinity((pid_t) 0, sizeof(mask), &mask);
+	if (rc < 0) {
+		EPRINTF
+		    ("UNRESOLVED: Thread %s index %d: Can't set affinity: %d %s",
+		     tp->name, tp->index, rc, strerror(rc));
+		exit(UNRESOLVED);
+	}
+#endif
+	test_set_priority(pthread_self(), tp->policy, tp->priority);
+
+
+	DPRINTF(stdout, "#EVENT %f Thread TL Started\n",
+		seconds_read() - base_time);
+
+	tp->progress = 0;
+
+	mutex = tlp->mutexes;
+	while (*mutex != NULL) {
+		pthread_mutex_lock(*mutex);
+		mutex++;
+	}
+
+	while (!tp->stop)
+		do_work(5, &tp->progress);
+
+	mutex = tlp->mutexes;
+	while (*mutex != NULL) {
+		pthread_mutex_unlock(*mutex);
+		mutex++;
+	}
+
+	DPRINTF(stdout, "#EVENT %f Thread TL Stopped\n",
+		seconds_read() - base_time);
+	return NULL;
+}
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-1.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-1.c
index 7ef46f6..adcfb0c 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-1.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-1.c
@@ -36,6 +36,7 @@
 #include "pitest.h"
 
 pthread_mutex_t mutex;
+pthread_mutex_t *mutexes[] = { &mutex, NULL };
 
 struct thread_param tp[] = {
 	{
@@ -49,37 +50,6 @@ struct thread_param tp[] = {
 	7, 0, 0, 3, SCHED_FIFO, "TF", 6, 0, 0, 0}
 };
 
-void *thread_tl(void *param)
-{
-	struct thread_param *tp = param;
-	unsigned long mask = 1 << tp->cpu;
-	int rc;
-
-#if __linux__
-	rc = sched_setaffinity((pid_t) 0, sizeof(mask), &mask);
-#endif
-	test_set_priority(pthread_self(), SCHED_FIFO, tp->priority);
-	if (rc < 0) {
-		EPRINTF
-		    ("UNRESOLVED: Thread %s index %d: Can't set affinity: %d %s",
-		     tp->name, tp->index, rc, strerror(rc));
-		exit(UNRESOLVED);
-	}
-
-	DPRINTF(stdout, "#EVENT %f Thread TL Started\n",
-		seconds_read() - base_time);
-	tp->progress = 0;
-	pthread_mutex_lock(&mutex);
-	while (!tp->stop) {
-		do_work(5, &tp->progress);
-	}
-	pthread_mutex_unlock(&mutex);
-
-	DPRINTF(stdout, "#EVENT %f Thread TL Stopped\n",
-		seconds_read() - base_time);
-	return NULL;
-}
-
 void *thread_sample(void *arg)
 {
 	char buffer[1024];
@@ -151,7 +121,7 @@ int main(int argc, char **argv)
 	pthread_mutexattr_t mutex_attr;
 	pthread_attr_t threadattr;
 	pthread_t threads[cpus - 1], threadsample, threadtp, threadtl, threadtb;
-
+	struct tl_param tlp;
 	int multiplier = 1;
 	int i;
 	int rc;
@@ -200,7 +170,9 @@ int main(int argc, char **argv)
 
 	/* Start TL thread */
 	DPRINTF(stderr, "Main Thread: start TL thread\n");
-	rc = pthread_create(&threadtl, &threadattr, thread_tl, &tp[0]);
+	tlp.tp = tp;
+	tlp.mutexes = mutexes;
+	rc = pthread_create(&threadtl, &threadattr, thread_tl, &tlp);
 	if (rc != 0) {
 		EPRINTF("UNRESOLVED: pthread_create: %d %s", rc, strerror(rc));
 		exit(UNRESOLVED);
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-2.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-2.c
index 066a7b8..bd3ae84 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-2.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-2.c
@@ -38,6 +38,7 @@
 #include "pitest.h"
 
 pthread_mutex_t mutex;
+pthread_mutex_t *mutexes[] = { &mutex, NULL };
 
 struct thread_param tp[] = {
 	{
@@ -52,37 +53,6 @@ struct thread_param tp[] = {
 	8, 0, 0, 3, SCHED_FIFO, "TF", 6, 0, 0, 0}
 };
 
-void *thread_tl(void *param)
-{
-	struct thread_param *tp = param;
-	unsigned long mask = 1 << tp->cpu;
-	int rc;
-
-#if __linux__
-	rc = sched_setaffinity((pid_t) 0, sizeof(mask), &mask);
-#endif
-	test_set_priority(pthread_self(), SCHED_FIFO, tp->priority);
-
-	DPRINTF(stdout, "#EVENT %f Thread TL Started\n",
-		seconds_read() - base_time);
-	DPRINTF(stderr, "Thread %s index %d: started\n", tp->name, tp->index);
-	if (rc < 0) {
-		EPRINTF
-		    ("UNRESOLVED: Thread %s index %d: Can't set affinity: %d %s",
-		     tp->name, tp->index, rc, strerror(rc));
-		exit(UNRESOLVED);
-	}
-	tp->progress = 0;
-	pthread_mutex_lock(&mutex);
-	while (!tp->stop) {
-		do_work(5, &tp->progress);
-	}
-	pthread_mutex_unlock(&mutex);
-	DPRINTF(stdout, "#EVENT %f Thread TL Stoped\n",
-		seconds_read() - base_time);
-	return NULL;
-}
-
 void *thread_sample(void *arg)
 {
 	char buffer[1024];
@@ -180,7 +150,7 @@ int main(int argc, char **argv)
 	pthread_attr_t threadattr;
 	pthread_t threads[cpus - 1];
 	pthread_t threadsample, threadtp, threadtl, threadtb1, threadtb2;
-
+	struct tl_param tlp;
 	time_t multiplier = 1;
 	int i;
 	int rc;
@@ -231,7 +201,9 @@ int main(int argc, char **argv)
 
 	/* Start TL thread */
 	DPRINTF(stderr, "Main Thread: Creating TL thread\n");
-	rc = pthread_create(&threadtl, &threadattr, thread_tl, &tp[0]);
+	tlp.tp = tp;
+	tlp.mutexes = mutexes;
+	rc = pthread_create(&threadtl, &threadattr, thread_tl, &tlp);
 	if (rc != 0) {
 		EPRINTF("UNRESOLVED: pthread_create: %d %s", rc, strerror(rc));
 		exit(UNRESOLVED);
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-3.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-3.c
index e37746c..4e42259 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-3.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-3.c
@@ -39,6 +39,7 @@
 
 pthread_mutex_t mutex1;
 pthread_mutex_t mutex2;
+pthread_mutex_t *mutexes[] = { &mutex1, &mutex2, NULL };
 
 struct thread_param tp[] = {
 	{
@@ -53,41 +54,6 @@ struct thread_param tp[] = {
 	7, 0, 0, 3, SCHED_FIFO, "TF", 6, 0, 0, 0}
 };
 
-void *thread_tl(void *param)
-{
-	struct thread_param *tp = param;
-	unsigned long mask = 1 << tp->cpu;
-	int rc;
-
-#if __linux__
-	rc = sched_setaffinity((pid_t) 0, sizeof(mask), &mask);
-	if (rc < 0) {
-		EPRINTF
-		    ("UNRESOLVED: Thread %s index %d: Can't set affinity: %d %s",
-		     tp->name, tp->index, rc, strerror(rc));
-		exit(UNRESOLVED);
-	}
-#endif
-
-	test_set_priority(pthread_self(), SCHED_FIFO, tp->priority);
-	DPRINTF(stdout, "#EVENT %f Thread TL Started\n",
-		seconds_read() - base_time);
-	DPRINTF(stderr, "Thread %s index %d: started\n", tp->name, tp->index);
-
-	tp->progress = 0;
-	pthread_mutex_lock(&mutex1);
-	pthread_mutex_lock(&mutex2);
-	while (!tp->stop) {
-		do_work(5, &tp->progress);
-	}
-
-	pthread_mutex_unlock(&mutex1);
-	pthread_mutex_unlock(&mutex2);
-	DPRINTF(stdout, "#EVENT %f Thread TL Stopped\n",
-		seconds_read() - base_time);
-	return NULL;
-}
-
 void *thread_sample(void *arg)
 {
 	char buffer[1024];
@@ -188,7 +154,7 @@ int main(int argc, char **argv)
 	pthread_attr_t threadattr;
 	pthread_t threads[cpus - 1];
 	pthread_t threadsample, threadtp, threadtl, threadtb1, threadtb2;
-
+	struct tl_param tlp;
 	time_t multiplier = 1;
 	int i;
 	int rc;
@@ -240,7 +206,9 @@ int main(int argc, char **argv)
 
 	/* Start TL thread */
 	DPRINTF(stderr, "Main Thread: Creating TL thread\n");
-	rc = pthread_create(&threadtl, &threadattr, thread_tl, &tp[0]);
+	tlp.tp = tp;
+	tlp.mutexes = mutexes;
+	rc = pthread_create(&threadtl, &threadattr, thread_tl, &tlp);
 	if (rc != 0) {
 		EPRINTF("UNRESOLVED: pthread_create: %d %s", rc, strerror(rc));
 		exit(UNRESOLVED);
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-5.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-5.c
index 6cc07b7..44c1772 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-5.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-5.c
@@ -51,13 +51,13 @@ struct thread_param tp[] = {
 	7, 0, 0, 3, SCHED_FIFO, "TF", 6, 0, 0, 0}
 };
 
-void *thread_tl(void *param)
+void *thread_tl5(void *param)
 {
 	struct thread_param *tp = param;
 	unsigned long mask = 1 << tp->cpu;
 	int rc;
 
-	test_set_priority(pthread_self(), SCHED_FIFO, tp->priority);
+	test_set_priority(pthread_self(), tp->policy, tp->priority);
 #if __linux__
 	rc = sched_setaffinity((pid_t) 0, sizeof(mask), &mask);
 	if (rc < 0) {
@@ -222,7 +222,7 @@ int main(int argc, char **argv)
 
 	/* Start TL thread */
 	DPRINTF(stderr, "Main Thread: Creating TL thread\n");
-	rc = pthread_create(&threadtl, &threadattr, thread_tl, &tp[0]);
+	rc = pthread_create(&threadtl, &threadattr, thread_tl5, &tp[0]);
 	if (rc != 0) {
 		EPRINTF("UNRESOLVED: pthread_create: %d %s", rc, strerror(rc));
 		exit(UNRESOLVED);
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-6.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-6.c
index c6c3046..e1a56b3 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-6.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-6.c
@@ -36,6 +36,7 @@
 #include "pitest.h"
 
 pthread_mutex_t mutex;
+pthread_mutex_t *mutexes[] = { &mutex, NULL };
 
 struct thread_param tp[] = {
 	{
@@ -49,37 +50,6 @@ struct thread_param tp[] = {
 	7, 0, 0, 3, SCHED_FIFO, "TF", 6, 0, 0, 0}
 };
 
-void *thread_tl(void *param)
-{
-	struct thread_param *tp = param;
-	unsigned long mask = 1 << tp->cpu;
-	int rc;
-
-#if __linux__
-	rc = sched_setaffinity((pid_t) 0, sizeof(mask), &mask);
-	if (rc < 0) {
-		EPRINTF
-		    ("UNRESOLVED: Thread %s index %d: Can't set affinity: %d %s",
-		     tp->name, tp->index, rc, strerror(rc));
-		exit(UNRESOLVED);
-	}
-#endif
-
-	test_set_priority(pthread_self(), SCHED_FIFO, tp->priority);
-
-	DPRINTF(stderr, "Thread %s index %d: started\n", tp->name, tp->index);
-	DPRINTF(stdout, "#EVENT %f Thread %s Started\n",
-		seconds_read() - base_time, tp->name);
-	tp->progress = 0;
-	pthread_mutex_lock(&mutex);
-	while (!tp->stop) {
-		do_work(5, &tp->progress);
-	}
-	pthread_mutex_unlock(&mutex);
-	DPRINTF(stdout, "#EVENT %f Thread %s Stopted\n",
-		seconds_read() - base_time, tp->name);
-	return NULL;
-}
 
 void *thread_sample(void *arg)
 {
@@ -152,7 +122,7 @@ int main(int argc, char **argv)
 	pthread_mutexattr_t mutex_attr;
 	pthread_attr_t threadattr;
 	pthread_t threads[cpus - 1], threadsample, threadtp, threadtl, threadtb;
-
+	struct tl_param tlp;
 	time_t multiplier = 1;
 	int i;
 	int rc;
@@ -201,7 +171,9 @@ int main(int argc, char **argv)
 
 	/* Start TL thread */
 	DPRINTF(stderr, "Main Thread: Creating TL thread\n");
-	rc = pthread_create(&threadtl, &threadattr, thread_tl, &tp[0]);
+	tlp.tp = tp;
+	tlp.mutexes = mutexes;
+	rc = pthread_create(&threadtl, &threadattr, thread_tl, &tlp);
 	if (rc != 0) {
 		EPRINTF("UNRESOLVED: pthread_create: %d %s", rc, strerror(rc));
 		exit(UNRESOLVED);
-- 
1.7.1

