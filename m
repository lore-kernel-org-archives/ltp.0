From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 18 Dec 2015 17:35:35 +0300
Subject: [LTP] [PATCH 7/7] pi_test: use only available CPUs
In-Reply-To: <1450449335-18223-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1450449335-18223-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1450449335-18223-8-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The current code expects that cpu0..cpu7 are online and breaks
if the system has more CPUs and/or some of them are offline.

This patch removes these expectations. Now we determine the set
of available CPUs at runtime and bind each thread only to a CPU in
this set.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../functional/threads/include/pitest.h            |  176 +++++++++++++++++---
 .../functional/threads/pi_test/pitest-1.c          |   31 ++--
 .../functional/threads/pi_test/pitest-2.c          |   30 ++--
 .../functional/threads/pi_test/pitest-3.c          |   30 ++--
 .../functional/threads/pi_test/pitest-4.c          |   40 ++---
 .../functional/threads/pi_test/pitest-5.c          |   42 ++---
 .../functional/threads/pi_test/pitest-6.c          |   32 ++--
 7 files changed, 244 insertions(+), 137 deletions(-)

diff --git a/testcases/open_posix_testsuite/functional/threads/include/pitest.h b/testcases/open_posix_testsuite/functional/threads/include/pitest.h
index 8c719e5..0ad2c7f 100644
--- a/testcases/open_posix_testsuite/functional/threads/include/pitest.h
+++ b/testcases/open_posix_testsuite/functional/threads/include/pitest.h
@@ -25,6 +25,31 @@
 
 #define PROTOCOL                PTHREAD_PRIO_INHERIT
 
+#ifndef CPU_ALLOC
+#define CPU_ALLOC(ncpus) malloc(sizeof(cpu_set_t)); \
+if (ncpus > CPU_SETSIZE) { \
+	EPRINTF("UNRESOLVED: Your libc does not support masks with %ld cpus", \
+		ncpus); \
+	exit(UNRESOLVED); \
+}
+#endif
+
+#ifndef CPU_FREE
+#define CPU_FREE(ptr) free(ptr)
+#endif
+
+#ifndef CPU_ALLOC_SIZE
+#define CPU_ALLOC_SIZE(size) sizeof(cpu_set_t)
+#endif
+
+#ifndef CPU_ZERO_S
+#define CPU_ZERO_S(size, mask) CPU_ZERO(mask)
+#endif
+
+#ifndef CPU_SET_S
+#define CPU_SET_S(cpu, size, mask) CPU_SET(cpu, mask)
+#endif
+
 struct thread_param {
 	int index;
 	volatile int stop;
@@ -52,7 +77,6 @@ struct sample_param {
 	int priority;
 };
 
-static int cpus;
 static volatile int ts_stop;
 static volatile double base_time;
 
@@ -141,21 +165,141 @@ static void do_work(unsigned granularity_top, volatile unsigned *progress)
 	}
 }
 
+static void *test_calloc(size_t nmemb, size_t size)
+{
+	void *r;
+
+	r = calloc(nmemb, size);
+	if (r == NULL) {
+		EPRINTF("UNRESOLVED: calloc failed");
+		exit(UNRESOLVED);
+	}
+
+	return r;
+}
+
+static int first_available_cpu(int ncpus_max, size_t mask_size, cpu_set_t *mask)
+{
+	int i;
+
+	for (i = 0; i < ncpus_max; i++) {
+		if (CPU_ISSET_S(i, mask_size, mask))
+			return i;
+	}
+	return -1;
+}
+
+/*
+ * Allocates a new array of 'struct thread_param' with
+ * the number of TF entries increased to 'online CPUs - 1'.
+ * All non-TF entries are bind to the first available online CPU,
+ * each TF-entry is bind to its own online CPU.
+ */
+static void init_tparam(struct thread_param *tpbase, int len,
+		  struct thread_param **tpnew, int *newlen)
+{
+	struct thread_param *tp;
+	cpu_set_t *mask;
+	size_t mask_size;
+	int i, cpu, ncpus_max, ncpus_online;
+
+	ncpus_max = sysconf(_SC_NPROCESSORS_CONF);
+	ncpus_online = sysconf(_SC_NPROCESSORS_ONLN);
+
+	if (ncpus_online < 2) {
+		EPRINTF("UNRESOLVED: we need@least %d online CPUs, got %d",
+			2, ncpus_online);
+		exit(UNRESOLVED);
+	}
+
+	*newlen = len - 1 + (ncpus_online - 1);
+
+	mask_size = CPU_ALLOC_SIZE(ncpus_max);
+	mask = CPU_ALLOC(ncpus_max);
+	if (mask == NULL) {
+		EPRINTF("UNRESOLVED: failed to allocate a CPU mask");
+		exit(UNRESOLVED);
+	}
+
+	if (sched_getaffinity(0, mask_size, mask)) {
+		EPRINTF("UNRESOLVED: sched_getaffinity: %s", strerror(errno));
+		CPU_FREE(mask);
+		exit(UNRESOLVED);
+	}
+
+	/* This is the CPU where all non-TF threads will be running */
+	cpu = first_available_cpu(ncpus_max, mask_size, mask);
+	if (cpu == -1) {
+		EPRINTF("UNRESOLVED: first_available_cpu failed");
+		CPU_FREE(mask);
+		exit(UNRESOLVED);
+	}
+	CPU_CLR_S(cpu, mask_size, mask);
+
+	tp = calloc(*newlen, sizeof(struct thread_param));
+
+	for (i = 0; i < len - 1; i++) {
+		tp[i] = tpbase[i];
+		tp[i].cpu = cpu;
+	}
+	for (i = len - 1; i < *newlen; i++) {
+		tp[i] = tpbase[len - 1];
+
+		cpu = first_available_cpu(ncpus_max, mask_size, mask);
+		if (cpu == -1) {
+			EPRINTF("UNRESOLVED: first_available_cpu failed");
+			CPU_FREE(mask);
+			exit(UNRESOLVED);
+		}
+		tp[i].cpu = cpu;
+		CPU_CLR_S(cpu, mask_size, mask);
+	}
+
+	CPU_FREE(mask);
+
+	*tpnew = tp;
+}
+
+static void test_set_affinity(pid_t pid, int cpu)
+{
+	cpu_set_t *mask;
+	size_t mask_size;
+	int ncpus_max, ncpus_online;
+
+	ncpus_max = sysconf(_SC_NPROCESSORS_CONF);
+	ncpus_online = sysconf(_SC_NPROCESSORS_ONLN);
+
+	if (cpu >= ncpus_max) {
+		EPRINTF("UNRESOLVED: invalid CPU specified: %d", cpu);
+		exit(UNRESOLVED);
+	}
+
+	mask_size = CPU_ALLOC_SIZE(ncpus_max);
+	mask = CPU_ALLOC(ncpus_max);
+	if (mask == NULL) {
+		EPRINTF("UNRESOLVED: failed to allocate a CPU mask");
+		exit(UNRESOLVED);
+	}
+
+	CPU_ZERO_S(mask_size, mask);
+	CPU_SET_S(cpu, mask_size, mask);
+
+	if (sched_setaffinity(pid, mask_size, mask)) {
+		EPRINTF("UNRESOLVED: pid %d: sched_setaffinity failed: %s",
+			pid, strerror(errno));
+		CPU_FREE(mask);
+		exit(UNRESOLVED);
+	}
+	CPU_FREE(mask);
+}
+
 static void *thread_fn(void *param)
 {
 	struct thread_param *tp = param;
 	struct timespec ts;
 	int rc;
-	unsigned long mask = 1 << tp->cpu;
 
-#if __linux__
-	rc = sched_setaffinity(0, sizeof(mask), &mask);
-	if (rc < 0) {
-		EPRINTF("UNRESOLVED: Thread %s index %d: Can't set affinity: "
-			"%d %s", tp->name, tp->index, rc, strerror(rc));
-		exit(UNRESOLVED);
-	}
-#endif
+	test_set_affinity(0, tp->cpu);
 	test_set_priority(pthread_self(), tp->policy, tp->priority);
 
 	DPRINTF(stdout, "#EVENT %f %s Thread Started\n",
@@ -186,19 +330,9 @@ static void *thread_tl(void *param)
 {
 	struct tl_param *tlp = param;
 	struct thread_param *tp = tlp->tp;
-	unsigned long mask = 1 << tp->cpu;
 	pthread_mutex_t **mutex;
-	int rc;
 
-#if __linux__
-	rc = sched_setaffinity((pid_t) 0, sizeof(mask), &mask);
-	if (rc < 0) {
-		EPRINTF
-		    ("UNRESOLVED: Thread %s index %d: Can't set affinity: %d %s",
-		     tp->name, tp->index, rc, strerror(rc));
-		exit(UNRESOLVED);
-	}
-#endif
+	test_set_affinity(0, tp->cpu);
 	test_set_priority(pthread_self(), tp->policy, tp->priority);
 
 
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-1.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-1.c
index 3b4b360..2b8a372 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-1.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-1.c
@@ -38,17 +38,13 @@
 pthread_mutex_t mutex;
 pthread_mutex_t *mutexes[] = { &mutex, NULL };
 
-struct thread_param tp[] = {
+struct thread_param tpbase[] = {
 	{
 	0, 0, 0, 1, SCHED_FIFO, "TL", 0, 0, 0, 0}, {
 	1, 0, 50, 2, SCHED_FIFO, "TP", 0, 0, 0, 0}, {
-	2, 0, 0, 3, SCHED_FIFO, "TF", 1, 0, 0, 0}, {
-	3, 0, 0, 3, SCHED_FIFO, "TF", 2, 0, 0, 0}, {
-	4, 0, 0, 3, SCHED_FIFO, "TF", 3, 0, 0, 0}, {
-	5, 0, 0, 3, SCHED_FIFO, "TF", 4, 0, 0, 0}, {
-	6, 0, 0, 3, SCHED_FIFO, "TF", 5, 0, 0, 0}, {
-	7, 0, 0, 3, SCHED_FIFO, "TF", 6, 0, 0, 0}
+	2, 0, 0, 3, SCHED_FIFO, "TF", 1, 0, 0, 0},
 };
+struct thread_param *tp;
 
 void *thread_tb(void *arg)
 {
@@ -86,15 +82,19 @@ int main(void)
 {
 	pthread_mutexattr_t mutex_attr;
 	pthread_attr_t threadattr;
-	pthread_t threads[cpus - 1], threadsample, threadtp, threadtl, threadtb;
+	pthread_t *threads;
+	pthread_t threadsample, threadtp, threadtl, threadtb;
 	struct tl_param tlp;
 	struct sample_param sp;
 	int multiplier = 1;
-	int i;
-	int rc;
+	int i, rc, tplen;
 
 	test_set_priority(pthread_self(), SCHED_FIFO, 6);
-	cpus = sysconf(_SC_NPROCESSORS_ONLN);
+
+	init_tparam(tpbase, 3, &tp, &tplen);
+
+	threads = test_calloc(tplen - 2, sizeof(pthread_t));
+
 	base_time = seconds_read();
 
 	/* Initialize a mutex with PTHREAD_PRIO_INHERIT protocol */
@@ -107,7 +107,7 @@ int main(void)
 	/* Start the sample thread */
 	DPRINTF(stderr, "Main Thread: start sample thread \n");
 	sp.tp = tp;
-	sp.tplen = 2 + cpus - 1;
+	sp.tplen = tplen;
 	sp.period = 250;
 	sp.priority = 5;
 	rc = pthread_create(&threadsample, &threadattr, thread_sample, &sp);
@@ -117,8 +117,8 @@ int main(void)
 	}
 
 	/* Start the TF threads */
-	DPRINTF(stderr, "Main Thread: start %d TF thread\n", cpus - 1);
-	for (i = 0; i < cpus - 1; i++) {
+	DPRINTF(stderr, "Main Thread: start %d TF thread\n", tplen - 2);
+	for (i = 0; i < tplen - 2; i++) {
 		rc = pthread_create(&threads[i], &threadattr, thread_fn,
 				    &tp[i + 2]);
 		if (rc != 0) {
@@ -173,9 +173,8 @@ int main(void)
 
 	/* Stop TF threads */
 	DPRINTF(stderr, "Main Thread: stop TF threads\n");
-	for (i = 2; i < cpus - 1; i++) {
+	for (i = 2; i < tplen; i++)
 		tp[i].stop = 1;
-	}
 
 	/* Stop sampler */
 	ts_stop = 1;
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-2.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-2.c
index 76716f4..d4c9852 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-2.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-2.c
@@ -40,18 +40,14 @@
 pthread_mutex_t mutex;
 pthread_mutex_t *mutexes[] = { &mutex, NULL };
 
-struct thread_param tp[] = {
+struct thread_param tpbase[] = {
 	{
 	0, 0, 0, 1, SCHED_FIFO, "TL", 0, 0, 0, 0}, {
 	1, 0, 500, 2, SCHED_FIFO, "TP1", 0, 0, 0, 0}, {
 	2, 0, 500, 5, SCHED_FIFO, "TP2", 0, 0, 0, 0}, {
-	3, 0, 0, 3, SCHED_FIFO, "TF", 1, 0, 0, 0}, {
-	4, 0, 0, 3, SCHED_FIFO, "TF", 2, 0, 0, 0}, {
-	5, 0, 0, 3, SCHED_FIFO, "TF", 3, 0, 0, 0}, {
-	6, 0, 0, 3, SCHED_FIFO, "TF", 4, 0, 0, 0}, {
-	7, 0, 0, 3, SCHED_FIFO, "TF", 5, 0, 0, 0}, {
-	8, 0, 0, 3, SCHED_FIFO, "TF", 6, 0, 0, 0}
+	3, 0, 0, 3, SCHED_FIFO, "TF", 1, 0, 0, 0}
 };
+struct thread_param *tp;
 
 void *thread_tb1(void *arg)
 {
@@ -114,16 +110,19 @@ int main(void)
 {
 	pthread_mutexattr_t mutex_attr;
 	pthread_attr_t threadattr;
-	pthread_t threads[cpus - 1];
+	pthread_t *threads;
 	pthread_t threadsample, threadtp, threadtl, threadtb1, threadtb2;
 	struct tl_param tlp;
 	struct sample_param sp;
 	time_t multiplier = 1;
-	int i;
-	int rc;
+	int i, rc, tplen;
 
 	test_set_priority(pthread_self(), SCHED_FIFO, 8);
-	cpus = sysconf(_SC_NPROCESSORS_ONLN);
+
+	init_tparam(tpbase, 4, &tp, &tplen);
+
+	threads = test_calloc(tplen - 3, sizeof(pthread_t));
+
 	base_time = seconds_read();
 
 	/* Initialize a mutex with PTHREAD_PRIO_INHERIT protocol */
@@ -136,7 +135,7 @@ int main(void)
 	/* Start the sample thread */
 	DPRINTF(stderr, "Main Thread: Creating sample thread \n");
 	sp.tp = tp;
-	sp.tplen = 3 + cpus - 1;
+	sp.tplen = tplen;
 	sp.period = 300;
 	sp.priority = 7;
 	rc = pthread_create(&threadsample, &threadattr, thread_sample, &sp);
@@ -146,8 +145,8 @@ int main(void)
 	}
 
 	/* Start the TF threads */
-	DPRINTF(stderr, "Main Thread: Creating %d TF threads \n", cpus - 1);
-	for (i = 0; i < cpus - 1; i++) {
+	DPRINTF(stderr, "Main Thread: Creating %d TF threads\n", tplen - 3);
+	for (i = 0; i < tplen - 3; i++) {
 		rc = pthread_create(&threads[i], &threadattr, thread_fn,
 				    &tp[i + 3]);
 		if (rc != 0) {
@@ -210,9 +209,8 @@ int main(void)
 	sleep(base_time + multiplier * 120 - seconds_read());
 
 	/* Stop TF threads */
-	for (i = 2; i < cpus - 1; i++) {
+	for (i = 3; i < tplen; i++)
 		tp[i].stop = 1;
-	}
 
 	/* Stop sampler */
 	ts_stop = 1;
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-3.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-3.c
index 17cc43d..50912a5 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-3.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-3.c
@@ -41,18 +41,14 @@ pthread_mutex_t mutex1;
 pthread_mutex_t mutex2;
 pthread_mutex_t *mutexes[] = { &mutex1, &mutex2, NULL };
 
-struct thread_param tp[] = {
+struct thread_param tpbase[] = {
 	{
 	0, 0, 0, 1, SCHED_FIFO, "TL", 0, 0, 0, 0}, {
 	1, 0, 500, 2, SCHED_FIFO, "TP1", 0, 0, 0, 0}, {
 	1, 0, 500, 5, SCHED_FIFO, "TP2", 0, 0, 0, 0}, {
-	2, 0, 0, 3, SCHED_FIFO, "TF", 1, 0, 0, 0}, {
-	3, 0, 0, 3, SCHED_FIFO, "TF", 2, 0, 0, 0}, {
-	4, 0, 0, 3, SCHED_FIFO, "TF", 3, 0, 0, 0}, {
-	5, 0, 0, 3, SCHED_FIFO, "TF", 4, 0, 0, 0}, {
-	6, 0, 0, 3, SCHED_FIFO, "TF", 5, 0, 0, 0}, {
-	7, 0, 0, 3, SCHED_FIFO, "TF", 6, 0, 0, 0}
+	2, 0, 0, 3, SCHED_FIFO, "TF", 1, 0, 0, 0}
 };
+struct thread_param *tp;
 
 void *thread_tb1(void *arg)
 {
@@ -115,17 +111,20 @@ int main(void)
 {
 	pthread_mutexattr_t mutex_attr;
 	pthread_attr_t threadattr;
-	pthread_t threads[cpus - 1];
+	pthread_t *threads;
 	pthread_t threadsample, threadtp, threadtl, threadtb1, threadtb2;
 	struct tl_param tlp;
 	struct sample_param sp;
 	time_t multiplier = 1;
-	int i;
-	int rc;
+	int i, rc, tplen;
 
 	test_set_priority(pthread_self(), SCHED_FIFO, 8);
+
+	init_tparam(tpbase, 4, &tp, &tplen);
+
+	threads = test_calloc(tplen - 3, sizeof(pthread_t));
+
 	base_time = seconds_read();
-	cpus = sysconf(_SC_NPROCESSORS_ONLN);
 
 	/* Initialize mutex1, mutex2 with PTHREAD_PRIO_INHERIT protocol */
 	mutex_attr_init(&mutex_attr);
@@ -138,7 +137,7 @@ int main(void)
 	/* Start the sample thread */
 	DPRINTF(stderr, "Main Thread: Creating sample thread\n");
 	sp.tp = tp;
-	sp.tplen = 3 + cpus - 1;
+	sp.tplen = tplen;
 	sp.period = 300;
 	sp.priority = 7;
 	rc = pthread_create(&threadsample, &threadattr, thread_sample, &sp);
@@ -148,8 +147,8 @@ int main(void)
 	}
 
 	/* Start the TF threads */
-	DPRINTF(stderr, "Main Thread: Creating %d TF threads\n", cpus - 1);
-	for (i = 0; i < cpus - 1; i++) {
+	DPRINTF(stderr, "Main Thread: Creating %d TF threads\n", tplen - 3);
+	for (i = 0; i < tplen - 3; i++) {
 		rc = pthread_create(&threads[i], &threadattr, thread_fn,
 				    &tp[i + 3]);
 		if (rc != 0) {
@@ -212,9 +211,8 @@ int main(void)
 	sleep(base_time + multiplier * 120 - seconds_read());
 
 	/* Stop TF threads */
-	for (i = 2; i < cpus - 1; i++) {
+	for (i = 3; i < tplen; i++)
 		tp[i].stop = 1;
-	}
 
 	/* Stop sampler */
 	ts_stop = 1;
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c
index 84f9878..7669536 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c
@@ -41,33 +41,21 @@
 pthread_mutex_t mutex1;
 pthread_mutex_t mutex2;
 
-struct thread_param tp[] = {
+struct thread_param tpbase[] = {
 	{
 	0, 0, 0, 1, SCHED_FIFO, "TL", 0, 0, 0, 0}, {
 	1, 0, 100, 4, SCHED_FIFO, "TP", 0, 0, 0, 0}, {
-	2, 0, 0, 2, SCHED_FIFO, "TF", 1, 0, 0, 0}, {
-	3, 0, 0, 2, SCHED_FIFO, "TF", 2, 0, 0, 0}, {
-	4, 0, 0, 2, SCHED_FIFO, "TF", 3, 0, 0, 0}, {
-	5, 0, 0, 2, SCHED_FIFO, "TF", 4, 0, 0, 0}, {
-	6, 0, 0, 2, SCHED_FIFO, "TF", 5, 0, 0, 0}, {
-	7, 0, 0, 2, SCHED_FIFO, "TF", 6, 0, 0, 0}
+	2, 0, 0, 2, SCHED_FIFO, "TF", 1, 0, 0, 0}
 };
+struct thread_param *tp;
 
 void *thread_fn4(void *param)
 {
 	struct thread_param *tp = param;
 	struct timespec ts;
 	int rc;
-	unsigned long mask = 1 << tp->cpu;
 
-#if __linux__
-	rc = sched_setaffinity(0, sizeof(mask), &mask);
-	if (rc < 0) {
-		EPRINTF("UNRESOLVED: Thread %s index %d: Can't set affinity: "
-			"%d %s", tp->name, tp->index, rc, strerror(rc));
-		exit(UNRESOLVED);
-	}
-#endif
+	test_set_affinity(0, tp->cpu);
 	test_set_priority(pthread_self(), tp->policy, tp->priority);
 
 	DPRINTF(stdout, "#EVENT %f Thread %s Started\n",
@@ -163,16 +151,19 @@ int main(void)
 {
 	pthread_mutexattr_t mutex_attr;
 	pthread_attr_t threadattr;
-	pthread_t threads[cpus - 1];
+	pthread_t *threads;
 	pthread_t threadsample, threadtp, threadtl, threadtb1, threadtb2;
 	struct sample_param sp;
 	time_t multiplier = 1;
-	int i;
-	int rc;
+	int i, rc, tplen;
 
 	test_set_priority(pthread_self(), SCHED_FIFO, 8);
+
+	init_tparam(tpbase, 3, &tp, &tplen);
+
+	threads = test_calloc(tplen - 2, sizeof(pthread_t));
+
 	base_time = seconds_read();
-	cpus = sysconf(_SC_NPROCESSORS_ONLN);
 
 	/* Initialize mutex1, mutex2 with PTHREAD_PRIO_INHERIT protocol */
 	mutex_attr_init(&mutex_attr);
@@ -185,7 +176,7 @@ int main(void)
 	/* Start the sample thread */
 	DPRINTF(stderr, "Main Thread: Creating sample thread\n");
 	sp.tp = tp;
-	sp.tplen = 2 + cpus - 1;
+	sp.tplen = tplen;
 	sp.period = 300;
 	sp.priority = 6;
 	rc = pthread_create(&threadsample, &threadattr, thread_sample, &sp);
@@ -195,8 +186,8 @@ int main(void)
 	}
 
 	/* Start the TF threads */
-	DPRINTF(stderr, "Main Thread: Creating %d TF threads\n", cpus - 1);
-	for (i = 0; i < cpus - 1; i++) {
+	DPRINTF(stderr, "Main Thread: Creating %d TF threads\n", tplen - 2);
+	for (i = 0; i < tplen - 2; i++) {
 		rc = pthread_create(&threads[i], &threadattr, thread_fn4,
 				    &tp[i + 2]);
 		if (rc != 0) {
@@ -252,9 +243,8 @@ int main(void)
 	sleep(base_time + multiplier * 95 - seconds_read());
 
 	/* Stop TF threads */
-	for (i = 2; i < cpus - 1; i++) {
+	for (i = 2; i < tplen; i++)
 		tp[i].stop = 1;
-	}
 
 	/* Stop sampler */
 	ts_stop = 1;
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-5.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-5.c
index 3ba3a94..0320095 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-5.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-5.c
@@ -39,34 +39,21 @@
 pthread_mutex_t mutex;
 volatile int unlock_mutex = 0;
 
-struct thread_param tp[] = {
+struct thread_param tpbase[] = {
 	{
 	0, 0, 0, 1, SCHED_FIFO, "TL", 0, 0, 0, 0}, {
 	1, 0, 200, 2, SCHED_FIFO, "TP", 0, 0, 0, 0}, {
-	2, 0, 0, 3, SCHED_FIFO, "TF", 1, 0, 0, 0}, {
-	3, 0, 0, 3, SCHED_FIFO, "TF", 2, 0, 0, 0}, {
-	4, 0, 0, 3, SCHED_FIFO, "TF", 3, 0, 0, 0}, {
-	5, 0, 0, 3, SCHED_FIFO, "TF", 4, 0, 0, 0}, {
-	6, 0, 0, 3, SCHED_FIFO, "TF", 5, 0, 0, 0}, {
-	7, 0, 0, 3, SCHED_FIFO, "TF", 6, 0, 0, 0}
+	2, 0, 0, 3, SCHED_FIFO, "TF", 1, 0, 0, 0}
 };
+struct thread_param *tp;
 
 void *thread_tl5(void *param)
 {
 	struct thread_param *tp = param;
-	unsigned long mask = 1 << tp->cpu;
 	int rc;
 
 	test_set_priority(pthread_self(), tp->policy, tp->priority);
-#if __linux__
-	rc = sched_setaffinity((pid_t) 0, sizeof(mask), &mask);
-	if (rc < 0) {
-		EPRINTF
-		    ("UNRESOLVED: Thread %s index %d: Can't set affinity: %d %s",
-		     tp->name, tp->index, rc, strerror(rc));
-		exit(UNRESOLVED);
-	}
-#endif
+	test_set_affinity(0, tp->cpu);
 
 	DPRINTF(stdout, "#EVENT %f Thread TL started\n",
 		seconds_read() - base_time);
@@ -137,15 +124,19 @@ int main(void)
 {
 	pthread_mutexattr_t mutex_attr;
 	pthread_attr_t threadattr;
-	pthread_t threads[cpus - 1], threadsample, threadtp, threadtl, threadtb;
+	pthread_t *threads;
+	pthread_t threadsample, threadtp, threadtl, threadtb;
 	struct sample_param sp;
 	time_t multiplier = 1;
-	int i;
-	int rc;
+	int i, rc, tplen;
 
 	test_set_priority(pthread_self(), SCHED_FIFO, 6);
+
+	init_tparam(tpbase, 3, &tp, &tplen);
+
+	threads = test_calloc(tplen - 2, sizeof(pthread_t));
+
 	base_time = seconds_read();
-	cpus = sysconf(_SC_NPROCESSORS_ONLN);
 
 	/* Initialize a mutex with PTHREAD_PRIO_INHERIT protocol */
 	mutex_attr_init(&mutex_attr);
@@ -157,7 +148,7 @@ int main(void)
 	/* Start the sample thread */
 	DPRINTF(stderr, "Main Thread: Creating sample thread\n");
 	sp.tp = tp;
-	sp.tplen = 2 + cpus - 1;
+	sp.tplen = tplen;
 	sp.period = 300;
 	sp.priority = 5;
 	rc = pthread_create(&threadsample, &threadattr, thread_sample, &sp);
@@ -166,8 +157,8 @@ int main(void)
 		exit(UNRESOLVED);
 	}
 	/* Start the TF threads */
-	DPRINTF(stderr, "Main Thread: Creating %d TF threads\n", cpus - 1);
-	for (i = 0; i < cpus - 1; i++) {
+	DPRINTF(stderr, "Main Thread: Creating %d TF threads\n", tplen - 2);
+	for (i = 0; i < tplen - 2; i++) {
 		rc = pthread_create(&threads[i], &threadattr, thread_fn,
 				    &tp[i + 2]);
 		if (rc != 0) {
@@ -216,9 +207,8 @@ int main(void)
 	sleep(base_time + multiplier * 70 - seconds_read());
 
 	/* Stop TF threads */
-	for (i = 2; i < cpus - 1; i++) {
+	for (i = 2; i < tplen; i++)
 		tp[i].stop = 1;
-	}
 
 	/* Stop sampler */
 	ts_stop = 1;
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-6.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-6.c
index 46b36f7..bbb3010 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-6.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-6.c
@@ -38,17 +38,13 @@
 pthread_mutex_t mutex;
 pthread_mutex_t *mutexes[] = { &mutex, NULL };
 
-struct thread_param tp[] = {
+struct thread_param tpbase[] = {
 	{
 	0, 0, 0, 1, SCHED_FIFO, "TL", 0, 0, 0, 0}, {
 	1, 0, 200, 2, SCHED_FIFO, "TP", 0, 0, 0, 0}, {
-	2, 0, 0, 3, SCHED_FIFO, "TF", 1, 0, 0, 0}, {
-	3, 0, 0, 3, SCHED_FIFO, "TF", 2, 0, 0, 0}, {
-	4, 0, 0, 3, SCHED_FIFO, "TF", 3, 0, 0, 0}, {
-	5, 0, 0, 3, SCHED_FIFO, "TF", 4, 0, 0, 0}, {
-	6, 0, 0, 3, SCHED_FIFO, "TF", 5, 0, 0, 0}, {
-	7, 0, 0, 3, SCHED_FIFO, "TF", 6, 0, 0, 0}
+	2, 0, 0, 3, SCHED_FIFO, "TF", 1, 0, 0, 0}
 };
+struct thread_param *tp;
 
 void *thread_tb(void *arg)
 {
@@ -83,19 +79,22 @@ void *thread_tb(void *arg)
 
 int main(void)
 {
-	cpus = sysconf(_SC_NPROCESSORS_ONLN);
 	pthread_mutexattr_t mutex_attr;
 	pthread_attr_t threadattr;
-	pthread_t threads[cpus - 1], threadsample, threadtp, threadtl, threadtb;
+	pthread_t *threads;
+	pthread_t threadsample, threadtp, threadtl, threadtb;
 	struct tl_param tlp;
 	struct sample_param sp;
 	time_t multiplier = 1;
-	int i;
-	int rc;
+	int i, rc, tplen;
 
 	test_set_priority(pthread_self(), SCHED_FIFO, 6);
+
+	init_tparam(tpbase, 3, &tp, &tplen);
+
+	threads = test_calloc(tplen - 2, sizeof(pthread_t));
+
 	base_time = seconds_read();
-	cpus = sysconf(_SC_NPROCESSORS_ONLN);
 
 	/* Initialize a mutex with PTHREAD_PRIO_INHERIT protocol */
 	mutex_attr_init(&mutex_attr);
@@ -107,7 +106,7 @@ int main(void)
 	/* Start the sample thread */
 	DPRINTF(stderr, "Main Thread: Creating sample thread\n");
 	sp.tp = tp;
-	sp.tplen = 2 + cpus - 1;
+	sp.tplen = tplen;
 	sp.period = 250;
 	sp.priority = 5;
 	rc = pthread_create(&threadsample, &threadattr, thread_sample, &sp);
@@ -117,8 +116,8 @@ int main(void)
 	}
 
 	/* Start the TF threads */
-	DPRINTF(stderr, "Main Thread: Creating %d TF threads\n", cpus - 1);
-	for (i = 0; i < cpus - 1; i++) {
+	DPRINTF(stderr, "Main Thread: Creating %d TF threads\n", tplen - 2);
+	for (i = 0; i < tplen - 2; i++) {
 		rc = pthread_create(&threads[i], &threadattr, thread_fn,
 				    &tp[i + 2]);
 		if (rc != 0) {
@@ -175,9 +174,8 @@ int main(void)
 	sleep(base_time + multiplier * 80 - seconds_read());
 
 	/* Stop TF threads */
-	for (i = 2; i < cpus - 1; i++) {
+	for (i = 2; i < tplen; i++)
 		tp[i].stop = 1;
-	}
 
 	/* Stop sampler */
 	ts_stop = 1;
-- 
1.7.1

