From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 18 Dec 2015 17:35:32 +0300
Subject: [LTP] [PATCH 4/7] pi_test: move thread_sample() to the header
In-Reply-To: <1450449335-18223-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1450449335-18223-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1450449335-18223-5-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../functional/threads/include/pitest.h            |   52 ++++++++++++++++++++
 .../functional/threads/pi_test/pitest-1.c          |   41 ++-------------
 .../functional/threads/pi_test/pitest-2.c          |   41 ++-------------
 .../functional/threads/pi_test/pitest-3.c          |   44 ++--------------
 .../functional/threads/pi_test/pitest-4.c          |   42 ++--------------
 .../functional/threads/pi_test/pitest-5.c          |   44 ++--------------
 .../functional/threads/pi_test/pitest-6.c          |   42 ++--------------
 7 files changed, 88 insertions(+), 218 deletions(-)

diff --git a/testcases/open_posix_testsuite/functional/threads/include/pitest.h b/testcases/open_posix_testsuite/functional/threads/include/pitest.h
index a23693b..41c8096 100644
--- a/testcases/open_posix_testsuite/functional/threads/include/pitest.h
+++ b/testcases/open_posix_testsuite/functional/threads/include/pitest.h
@@ -44,6 +44,14 @@ struct tl_param {
 	pthread_mutex_t **mutexes; /* NULL-terminated */
 };
 
+/* Arguments to thread_sample */
+struct sample_param {
+	struct thread_param *tp;
+	int tplen;
+	double period;
+	int priority;
+};
+
 static int cpus;
 static volatile int ts_stop;
 static volatile double base_time;
@@ -218,3 +226,47 @@ static void *thread_tl(void *param)
 		seconds_read() - base_time);
 	return NULL;
 }
+
+static void *thread_sample(void *arg)
+{
+	struct sample_param *sp = arg;
+	struct thread_param *tp = sp->tp;
+	char buffer[1024];
+	struct timespec ts;
+	double period = sp->period;
+	size_t size;
+	int i, j, rc;
+	int tplen = sp->tplen;
+	int priority = sp->priority;
+
+	test_set_priority(pthread_self(), SCHED_FIFO, priority);
+
+	DPRINTF(stderr, "Thread Sampler: started\n");
+	DPRINTF(stdout, "# COLUMNS %d Time ", 1 + tplen);
+	j = 0;
+	for (i = 0; i < tplen; i++) {
+		if (strcmp(tp[i].name, "TF") == 0) {
+			DPRINTF(stdout, "TF%d ", j++);
+		} else {
+			DPRINTF(stdout, "%s ", tp[i].name);
+		}
+	}
+	DPRINTF(stdout, "\n");
+
+	ts.tv_sec = 0;
+	ts.tv_nsec = period * 1000 * 1000;
+
+	while (!ts_stop) {
+		size = snprintf(buffer, 1023, "%f ", seconds_read() - base_time);
+		for (i = 0; i < tplen; i++)
+			size +=
+			    snprintf(buffer + size, 1023 - size, "%u ",
+				     tp[i].progress);
+		DPRINTF(stdout, "%s\n", buffer);
+		rc = nanosleep(&ts, NULL);
+		if (rc < 0)
+			EPRINTF("UNRESOLVED: Thread %s %d: nanosleep returned "
+				"%d %s", tp->name, tp->index, rc, strerror(rc));
+	}
+	return NULL;
+}
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-1.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-1.c
index adcfb0c..2c65ad9 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-1.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-1.c
@@ -50,40 +50,6 @@ struct thread_param tp[] = {
 	7, 0, 0, 3, SCHED_FIFO, "TF", 6, 0, 0, 0}
 };
 
-void *thread_sample(void *arg)
-{
-	char buffer[1024];
-	struct timespec ts;
-	double period = 250;
-	double newtime;
-	size_t size;
-	int i;
-	int rc;
-
-	test_set_priority(pthread_self(), SCHED_FIFO, 5);
-	DPRINTF(stderr, "Thread Sampler: started \n");
-	DPRINTF(stdout, "# COLUMNS %d Time TL TP ", 2 + cpus);
-	for (i = 0; i < (cpus - 1); i++)
-		DPRINTF(stdout, "TF%d ", i);
-	DPRINTF(stdout, "\n");
-	ts.tv_sec = 0;
-	ts.tv_nsec = period * 1000 * 1000;
-	while (!ts_stop) {
-		newtime = seconds_read();
-		size = snprintf(buffer, 1023, "%f ", newtime - base_time);
-		for (i = 0; i < cpus + 1; i++)
-			size +=
-			    snprintf(buffer + size, 1023 - size, "%u ",
-				     tp[i].progress);
-		DPRINTF(stdout, "%s \n", buffer);
-		rc = nanosleep(&ts, NULL);
-		if (rc < 0)
-			EPRINTF("UNRESOLVED: Thread %s %d: nanosleep returned "
-				"%d %s", tp->name, tp->index, rc, strerror(rc));
-	}
-	return NULL;
-}
-
 void *thread_tb(void *arg)
 {
 	struct timespec boost_time;
@@ -122,6 +88,7 @@ int main(int argc, char **argv)
 	pthread_attr_t threadattr;
 	pthread_t threads[cpus - 1], threadsample, threadtp, threadtl, threadtb;
 	struct tl_param tlp;
+	struct sample_param sp;
 	int multiplier = 1;
 	int i;
 	int rc;
@@ -139,7 +106,11 @@ int main(int argc, char **argv)
 
 	/* Start the sample thread */
 	DPRINTF(stderr, "Main Thread: start sample thread \n");
-	rc = pthread_create(&threadsample, &threadattr, thread_sample, NULL);
+	sp.tp = tp;
+	sp.tplen = 2 + cpus - 1;
+	sp.period = 250;
+	sp.priority = 5;
+	rc = pthread_create(&threadsample, &threadattr, thread_sample, &sp);
 	if (rc != 0) {
 		EPRINTF("UNRESOLVED: pthread_create: %d %s", rc, strerror(rc));
 		exit(UNRESOLVED);
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-2.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-2.c
index bd3ae84..e1bbe43 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-2.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-2.c
@@ -53,40 +53,6 @@ struct thread_param tp[] = {
 	8, 0, 0, 3, SCHED_FIFO, "TF", 6, 0, 0, 0}
 };
 
-void *thread_sample(void *arg)
-{
-	char buffer[1024];
-	struct timespec ts;
-	double period = 300;
-	double newtime;
-	size_t size;
-	int i;
-	int rc;
-
-	test_set_priority(pthread_self(), SCHED_FIFO, 7);
-	DPRINTF(stderr, "Thread Sampler: started \n");
-	DPRINTF(stdout, "# COLUMNS %d Time TL TP1 TP2 ", 3 + cpus);
-	for (i = 0; i < (cpus - 1); i++)
-		DPRINTF(stdout, "TF%d ", i);
-	DPRINTF(stdout, "\n");
-	ts.tv_sec = 0;
-	ts.tv_nsec = period * 1000 * 1000;
-	while (!ts_stop) {
-		newtime = seconds_read();
-		size = snprintf(buffer, 1023, "%f ", newtime - base_time);
-		for (i = 0; i < cpus + 2; i++)
-			size +=
-			    snprintf(buffer + size, 1023 - size, "%u ",
-				     tp[i].progress);
-		DPRINTF(stdout, "%s \n", buffer);
-		rc = nanosleep(&ts, NULL);
-		if (rc < 0)
-			EPRINTF("UNRESOLVED: Thread %s %d: nanosleep returned "
-				"%d %s", tp->name, tp->index, rc, strerror(rc));
-	}
-	return NULL;
-}
-
 void *thread_tb1(void *arg)
 {
 	struct timespec boost_time;
@@ -151,6 +117,7 @@ int main(int argc, char **argv)
 	pthread_t threads[cpus - 1];
 	pthread_t threadsample, threadtp, threadtl, threadtb1, threadtb2;
 	struct tl_param tlp;
+	struct sample_param sp;
 	time_t multiplier = 1;
 	int i;
 	int rc;
@@ -168,7 +135,11 @@ int main(int argc, char **argv)
 
 	/* Start the sample thread */
 	DPRINTF(stderr, "Main Thread: Creating sample thread \n");
-	rc = pthread_create(&threadsample, &threadattr, thread_sample, NULL);
+	sp.tp = tp;
+	sp.tplen = 3 + cpus - 1;
+	sp.period = 300;
+	sp.priority = 7;
+	rc = pthread_create(&threadsample, &threadattr, thread_sample, &sp);
 	if (rc != 0) {
 		EPRINTF("UNRESOLVED: pthread_create: %d %s", rc, strerror(rc));
 		exit(UNRESOLVED);
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-3.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-3.c
index 4e42259..809fbb8 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-3.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-3.c
@@ -54,43 +54,6 @@ struct thread_param tp[] = {
 	7, 0, 0, 3, SCHED_FIFO, "TF", 6, 0, 0, 0}
 };
 
-void *thread_sample(void *arg)
-{
-	char buffer[1024];
-	struct timespec ts;
-	double period = 300;
-	double newtime;
-	size_t size;
-	int i;
-	int rc;
-
-	test_set_priority(pthread_self(), SCHED_FIFO, 7);
-	DPRINTF(stderr, "Thread Sampler: started\n");
-
-	DPRINTF(stdout, "# COLUMNS %d Time TL TP1 TP2  ", 3 + cpus);
-
-	for (i = 0; i < (cpus - 1); i++)
-		DPRINTF(stdout, "TF%d ", i);
-	DPRINTF(stdout, "\n");
-
-	ts.tv_sec = 0;
-	ts.tv_nsec = period * 1000 * 1000;
-	while (!ts_stop) {
-		newtime = seconds_read();
-		size = snprintf(buffer, 1023, "%f ", newtime - base_time);
-		for (i = 0; i < cpus + 2; i++)
-			size +=
-			    snprintf(buffer + size, 1023 - size, "%u ",
-				     tp[i].progress);
-		DPRINTF(stdout, "%s\n", buffer);
-		rc = nanosleep(&ts, NULL);
-		if (rc < 0)
-			EPRINTF("UNRESOLVED: Thread %s %d: nanosleep returned "
-				"%d %s", tp->name, tp->index, rc, strerror(rc));
-	}
-	return NULL;
-}
-
 void *thread_tb1(void *arg)
 {
 	struct timespec boost_time;
@@ -155,6 +118,7 @@ int main(int argc, char **argv)
 	pthread_t threads[cpus - 1];
 	pthread_t threadsample, threadtp, threadtl, threadtb1, threadtb2;
 	struct tl_param tlp;
+	struct sample_param sp;
 	time_t multiplier = 1;
 	int i;
 	int rc;
@@ -173,7 +137,11 @@ int main(int argc, char **argv)
 
 	/* Start the sample thread */
 	DPRINTF(stderr, "Main Thread: Creating sample thread\n");
-	rc = pthread_create(&threadsample, &threadattr, thread_sample, NULL);
+	sp.tp = tp;
+	sp.tplen = 3 + cpus - 1;
+	sp.period = 300;
+	sp.priority = 7;
+	rc = pthread_create(&threadsample, &threadattr, thread_sample, &sp);
 	if (rc != 0) {
 		EPRINTF("UNRESOLVED: pthread_create: %d %s", rc, strerror(rc));
 		exit(UNRESOLVED);
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c
index 84ad62c..13c34ef 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c
@@ -98,40 +98,6 @@ void *thread_fn4(void *param)
 	return NULL;
 }
 
-void *thread_sample(void *arg)
-{
-	char buffer[1024];
-	struct timespec ts;
-	double period = 300;
-	double newtime;
-	size_t size;
-	int i;
-	int rc;
-
-	test_set_priority(pthread_self(), SCHED_FIFO, 6);
-	DPRINTF(stderr, "Thread Sampler: started\n");
-	DPRINTF(stdout, "# COLUMNS %d Time TL TP ", 2 + cpus);
-	for (i = 0; i < (cpus - 1); i++)
-		DPRINTF(stdout, "TF%d ", i);
-	DPRINTF(stdout, "\n");
-	ts.tv_sec = 0;
-	ts.tv_nsec = period * 1000 * 1000;
-	while (!ts_stop) {
-		newtime = seconds_read();
-		size = snprintf(buffer, 1023, "%f ", newtime - base_time);
-		for (i = 0; i < cpus + 1; i++)
-			size +=
-			    snprintf(buffer + size, 1023 - size, "%u ",
-				     tp[i].progress);
-		DPRINTF(stdout, "%s\n", buffer);
-		rc = nanosleep(&ts, NULL);
-		if (rc < 0)
-			EPRINTF("UNRESOLVED: Thread %s %d: nanosleep returned "
-				"%d %s", tp->name, tp->index, rc, strerror(rc));
-	}
-	return NULL;
-}
-
 void *thread_tb1(void *arg)
 {
 	struct timespec boost_time;
@@ -199,7 +165,7 @@ int main(int argc, char **argv)
 	pthread_attr_t threadattr;
 	pthread_t threads[cpus - 1];
 	pthread_t threadsample, threadtp, threadtl, threadtb1, threadtb2;
-
+	struct sample_param sp;
 	time_t multiplier = 1;
 	int i;
 	int rc;
@@ -218,7 +184,11 @@ int main(int argc, char **argv)
 
 	/* Start the sample thread */
 	DPRINTF(stderr, "Main Thread: Creating sample thread\n");
-	rc = pthread_create(&threadsample, &threadattr, thread_sample, NULL);
+	sp.tp = tp;
+	sp.tplen = 2 + cpus - 1;
+	sp.period = 300;
+	sp.priority = 6;
+	rc = pthread_create(&threadsample, &threadattr, thread_sample, &sp);
 	if (rc != 0) {
 		EPRINTF("UNRESOLVED: pthread_create: %d %s", rc, strerror(rc));
 		exit(UNRESOLVED);
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-5.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-5.c
index 44c1772..d180e1a 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-5.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-5.c
@@ -97,43 +97,6 @@ void *thread_tl5(void *param)
 	return NULL;
 }
 
-void *thread_sample(void *arg)
-{
-	char buffer[1024];
-	struct timespec ts;
-	double period = 300;
-	size_t size;
-	int i;
-	int rc;
-
-	test_set_priority(pthread_self(), SCHED_FIFO, 5);
-
-	DPRINTF(stderr, "Thread Sampler: started\n");
-	DPRINTF(stdout, "# COLUMNS %d Time TL TP ", 2 + cpus);
-
-	for (i = 0; i < (cpus - 1); i++)
-		DPRINTF(stdout, "TF%d ", i);
-	DPRINTF(stdout, "\n");
-
-	ts.tv_sec = 0;
-	ts.tv_nsec = period * 1000 * 1000;
-
-	while (!ts_stop) {
-		size =
-		    snprintf(buffer, 1023, "%f ", seconds_read() - base_time);
-		for (i = 0; i < cpus + 1; i++)
-			size +=
-			    snprintf(buffer + size, 1023 - size, "%u ",
-				     tp[i].progress);
-		DPRINTF(stdout, "%s\n", buffer);
-		rc = nanosleep(&ts, NULL);
-		if (rc < 0)
-			EPRINTF("UNRESOLVED: Thread %s %d: nanosleep returned "
-				"%d %s", tp->name, tp->index, rc, strerror(rc));
-	}
-	return NULL;
-}
-
 void *thread_tb(void *arg)
 {
 	int rc;
@@ -175,6 +138,7 @@ int main(int argc, char **argv)
 	pthread_mutexattr_t mutex_attr;
 	pthread_attr_t threadattr;
 	pthread_t threads[cpus - 1], threadsample, threadtp, threadtl, threadtb;
+	struct sample_param sp;
 	time_t multiplier = 1;
 	int i;
 	int rc;
@@ -192,7 +156,11 @@ int main(int argc, char **argv)
 
 	/* Start the sample thread */
 	DPRINTF(stderr, "Main Thread: Creating sample thread\n");
-	rc = pthread_create(&threadsample, &threadattr, thread_sample, NULL);
+	sp.tp = tp;
+	sp.tplen = 2 + cpus - 1;
+	sp.period = 300;
+	sp.priority = 5;
+	rc = pthread_create(&threadsample, &threadattr, thread_sample, &sp);
 	if (rc != 0) {
 		EPRINTF("UNRESOLVED: pthread_create: %d %s", rc, strerror(rc));
 		exit(UNRESOLVED);
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-6.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-6.c
index e1a56b3..1789a61 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-6.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-6.c
@@ -50,41 +50,6 @@ struct thread_param tp[] = {
 	7, 0, 0, 3, SCHED_FIFO, "TF", 6, 0, 0, 0}
 };
 
-
-void *thread_sample(void *arg)
-{
-	char buffer[1024];
-	struct timespec ts;
-	double period = 250;
-	size_t size;
-	int i;
-	int rc;
-
-	test_set_priority(pthread_self(), SCHED_FIFO, 5);
-	DPRINTF(stderr, "Thread Sampler: started\n");
-	DPRINTF(stdout, "# COLUMNS %d Time TP TL ", 2 + cpus);
-	for (i = 0; i < (cpus - 1); i++)
-		DPRINTF(stdout, "TF%d ", i);
-	DPRINTF(stdout, "\n");
-	ts.tv_sec = 0;
-	ts.tv_nsec = period * 1000 * 1000;
-
-	while (!ts_stop) {
-		size =
-		    snprintf(buffer, 1023, "%f ", seconds_read() - base_time);
-		for (i = 0; i < cpus + 1; i++)
-			size +=
-			    snprintf(buffer + size, 1023 - size, "%u ",
-				     tp[i].progress);
-		DPRINTF(stdout, "%s\n", buffer);
-		rc = nanosleep(&ts, NULL);
-		if (rc < 0)
-			EPRINTF("UNRESOLVED: Thread %s %d: nanosleep returned "
-				"%d %s", tp->name, tp->index, rc, strerror(rc));
-	}
-	return NULL;
-}
-
 void *thread_tb(void *arg)
 {
 	struct timespec boost_time;
@@ -123,6 +88,7 @@ int main(int argc, char **argv)
 	pthread_attr_t threadattr;
 	pthread_t threads[cpus - 1], threadsample, threadtp, threadtl, threadtb;
 	struct tl_param tlp;
+	struct sample_param sp;
 	time_t multiplier = 1;
 	int i;
 	int rc;
@@ -140,7 +106,11 @@ int main(int argc, char **argv)
 
 	/* Start the sample thread */
 	DPRINTF(stderr, "Main Thread: Creating sample thread\n");
-	rc = pthread_create(&threadsample, &threadattr, thread_sample, NULL);
+	sp.tp = tp;
+	sp.tplen = 2 + cpus - 1;
+	sp.period = 250;
+	sp.priority = 5;
+	rc = pthread_create(&threadsample, &threadattr, thread_sample, &sp);
 	if (rc != 0) {
 		EPRINTF("UNRESOLVED: pthread_create: %d %s", rc, strerror(rc));
 		exit(UNRESOLVED);
-- 
1.7.1

