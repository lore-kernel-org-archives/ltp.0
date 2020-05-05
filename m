From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue,  5 May 2020 14:42:02 +0530
Subject: [LTP] [PATCH 2/8] syscalls/futex: Add support for time64 tests
In-Reply-To: <7e037dacaeb0c7f3bfd73cd11d80f3e1567dc052.1588669892.git.viresh.kumar@linaro.org>
References: <7e037dacaeb0c7f3bfd73cd11d80f3e1567dc052.1588669892.git.viresh.kumar@linaro.org>
Message-ID: <379f4d58e86b5249f56ff58e1907dee69d67e451.1588669892.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds support for time64 tests to the existing futex() syscall
tests.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/tst_timer.h                           |  12 ++
 .../syscalls/futex/futex_cmp_requeue01.c      |  35 ++++-
 .../syscalls/futex/futex_cmp_requeue02.c      |  25 +++-
 testcases/kernel/syscalls/futex/futex_utils.h |  52 +++++--
 .../kernel/syscalls/futex/futex_wait01.c      |  60 +++++---
 .../kernel/syscalls/futex/futex_wait02.c      |  83 +++++------
 .../kernel/syscalls/futex/futex_wait03.c      |  70 ++++++----
 .../kernel/syscalls/futex/futex_wait04.c      |  64 ++++++---
 .../kernel/syscalls/futex/futex_wait05.c      |   2 +-
 .../syscalls/futex/futex_wait_bitset01.c      |  50 +++++--
 .../kernel/syscalls/futex/futex_wake01.c      |  52 ++++---
 .../kernel/syscalls/futex/futex_wake02.c      |  80 ++++++-----
 .../kernel/syscalls/futex/futex_wake03.c      |  92 ++++++------
 .../kernel/syscalls/futex/futex_wake04.c      | 132 ++++++++++--------
 testcases/kernel/syscalls/futex/futextest.h   | 111 +++++++++------
 15 files changed, 588 insertions(+), 332 deletions(-)

diff --git a/include/tst_timer.h b/include/tst_timer.h
index a726298b407d..b4280042c77f 100644
--- a/include/tst_timer.h
+++ b/include/tst_timer.h
@@ -243,6 +243,18 @@ static inline int sys_clock_nanosleep64(clockid_t clk_id, int flags,
 			   request, remain);
 }
 
+static inline int sys_futex(int *uaddr, int futex_op, int val, void *to,
+			    int *uaddr2, int val3)
+{
+	return tst_syscall(__NR_futex, uaddr, futex_op, val, to, uaddr2, val3);
+}
+
+static inline int sys_futex_time64(int *uaddr, int futex_op, int val, void *to,
+				   int *uaddr2, int val3)
+{
+	return tst_syscall(__NR_futex_time64, uaddr, futex_op, val, to, uaddr2, val3);
+}
+
 static inline int libc_sched_rr_get_interval(pid_t pid, void *ts)
 {
 	return sched_rr_get_interval(pid, ts);
diff --git a/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c b/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
index c50fade9f969..bc9d2a6bee37 100644
--- a/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
+++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
@@ -18,6 +18,7 @@
 #include "tst_timer_test.h"
 #include "tst_test.h"
 #include "futextest.h"
+#include "lapi/abisize.h"
 
 struct shared_data {
 	futex_t futexes[2];
@@ -42,14 +43,33 @@ static struct tcase {
 	{1000, 300, 500},
 };
 
+static struct test_variants {
+	enum futex_fn_type fntype;
+	enum tst_ts_type tstype;
+	char *desc;
+} variants[] = {
+#if defined(TST_ABI32)
+	{ .fntype = FUTEX_FN_FUTEX, .tstype = TST_KERN_OLD_TIMESPEC, .desc = "syscall with kernel spec32"},
+#endif
+
+#if defined(TST_ABI64)
+	{ .fntype = FUTEX_FN_FUTEX, .tstype = TST_KERN_TIMESPEC, .desc = "syscall with kernel spec64"},
+#endif
+
+#if (__NR_futex_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX64, .tstype = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec64"},
+#endif
+};
+
 static void do_child(void)
 {
+	struct test_variants *tv = &variants[tst_variant];
+	struct tst_ts usec = tst_ts_from_ms(tv->tstype, max_sleep_ms);
 	int slept_for_ms = 0;
-	struct timespec usec = tst_timespec_from_ms(max_sleep_ms);
 	int pid = getpid();
 	int ret = 0;
 
-	if (futex_wait(&sd->futexes[0], sd->futexes[0], &usec, 0) == -1) {
+	if (futex_wait(tv->fntype, &sd->futexes[0], sd->futexes[0], &usec, 0) == -1) {
 		if (errno == EAGAIN) {
 			/* spurious wakeup or signal */
 			tst_atomic_inc(&sd->spurious);
@@ -72,6 +92,7 @@ static void do_child(void)
 
 static void verify_futex_cmp_requeue(unsigned int n)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	int num_requeues = 0, num_waits = 0, num_total = 0;
 	int i, status, spurious, woken_up;
 	struct tcase *tc = &tcases[n];
@@ -104,8 +125,8 @@ static void verify_futex_cmp_requeue(unsigned int n)
 	 * specifies an upper limit on the number of waiters that are requeued.
 	 * Returns the total number of waiters that were woken up or requeued.
 	 */
-	TEST(futex_cmp_requeue(&sd->futexes[0], sd->futexes[0], &sd->futexes[1],
-		tc->set_wakes, tc->set_requeues, 0));
+	TEST(futex_cmp_requeue(tv->fntype, &sd->futexes[0], sd->futexes[0],
+			&sd->futexes[1], tc->set_wakes, tc->set_requeues, 0));
 
 	/* Fail if more than requested wakes + requeues were returned */
 	if (TST_RET > exp_ret) {
@@ -115,8 +136,8 @@ static void verify_futex_cmp_requeue(unsigned int n)
 		tst_res(TINFO, "futex_cmp_requeue() returned %ld", TST_RET);
 	}
 
-	num_requeues = futex_wake(&sd->futexes[1], tc->num_waiters, 0);
-	num_waits = futex_wake(&sd->futexes[0], tc->num_waiters, 0);
+	num_requeues = futex_wake(tv->fntype, &sd->futexes[1], tc->num_waiters, 0);
+	num_waits = futex_wake(tv->fntype, &sd->futexes[0], tc->num_waiters, 0);
 
 	tst_atomic_store(1, &sd->test_done);
 	for (i = 0; i < tc->num_waiters; i++) {
@@ -178,6 +199,7 @@ static void verify_futex_cmp_requeue(unsigned int n)
 
 static void setup(void)
 {
+	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
 	max_sleep_ms = tst_multiply_timeout(5000);
 
 	sd = SAFE_MMAP(NULL, sizeof(*sd), PROT_READ | PROT_WRITE,
@@ -198,5 +220,6 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_futex_cmp_requeue,
+	.test_variants = ARRAY_SIZE(variants),
 	.forks_child = 1,
 };
diff --git a/testcases/kernel/syscalls/futex/futex_cmp_requeue02.c b/testcases/kernel/syscalls/futex/futex_cmp_requeue02.c
index 228d8cff6ea0..5559b72a3a45 100644
--- a/testcases/kernel/syscalls/futex/futex_cmp_requeue02.c
+++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue02.c
@@ -18,6 +18,7 @@
 
 #include "tst_test.h"
 #include "futextest.h"
+#include "lapi/abisize.h"
 
 static futex_t *futexes;
 
@@ -32,12 +33,30 @@ static struct tcase {
 	{1, 1, FUTEX_INITIALIZER + 1, EAGAIN},
 };
 
+static struct test_variants {
+	enum futex_fn_type fntype;
+	char *desc;
+} variants[] = {
+#if defined(TST_ABI32)
+	{ .fntype = FUTEX_FN_FUTEX, .desc = "syscall with kernel spec32"},
+#endif
+
+#if defined(TST_ABI64)
+	{ .fntype = FUTEX_FN_FUTEX, .desc = "syscall with kernel spec64"},
+#endif
+
+#if (__NR_futex_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX64, .desc = "syscall time64 with kernel spec64"},
+#endif
+};
+
 static void verify_futex_cmp_requeue(unsigned int n)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	struct tcase *tc = &tcases[n];
 
-	TEST(futex_cmp_requeue(&futexes[0], tc->exp_val, &futexes[1],
-	     tc->set_wakes, tc->set_requeues, 0));
+	TEST(futex_cmp_requeue(tv->fntype, &futexes[0], tc->exp_val,
+			&futexes[1], tc->set_wakes, tc->set_requeues, 0));
 	if (TST_RET != -1) {
 		tst_res(TFAIL, "futex_cmp_requeue() succeeded unexpectedly");
 		return;
@@ -55,6 +74,7 @@ static void verify_futex_cmp_requeue(unsigned int n)
 
 static void setup(void)
 {
+	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
 	futexes = SAFE_MMAP(NULL, sizeof(futex_t) * 2, PROT_READ | PROT_WRITE,
 			    MAP_ANONYMOUS | MAP_SHARED, -1, 0);
 
@@ -73,6 +93,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test = verify_futex_cmp_requeue,
 	.tcnt = ARRAY_SIZE(tcases),
+	.test_variants = ARRAY_SIZE(variants),
 	.tags = (const struct tst_tag[]) {
 		{"CVE", "2018-6927"},
 		{"linux-git", "fbe0e839d1e2"},
diff --git a/testcases/kernel/syscalls/futex/futex_utils.h b/testcases/kernel/syscalls/futex/futex_utils.h
index 63b97c00b631..f77b9d6b3b8a 100644
--- a/testcases/kernel/syscalls/futex/futex_utils.h
+++ b/testcases/kernel/syscalls/futex/futex_utils.h
@@ -20,10 +20,13 @@
 #ifndef FUTEX_UTILS_H__
 #define FUTEX_UTILS_H__
 
+#include <stdio.h>
+#include <stdlib.h>
+
 /*
  * Wait for nr_threads to be sleeping
  */
-static int wait_for_threads(unsigned int nr_threads)
+static inline int wait_for_threads(unsigned int nr_threads)
 {
 	char thread_state, name[1024];
 	DIR *dir;
@@ -32,34 +35,63 @@ static int wait_for_threads(unsigned int nr_threads)
 
 	snprintf(name, sizeof(name), "/proc/%i/task/", getpid());
 
-	dir = SAFE_OPENDIR(NULL, name);
+	dir = SAFE_OPENDIR(name);
 
-	while ((dent = SAFE_READDIR(NULL, dir))) {
+	while ((dent = SAFE_READDIR(dir))) {
 		/* skip ".", ".." and the main thread */
 		if (atoi(dent->d_name) == getpid() || atoi(dent->d_name) == 0)
 			continue;
 
 		snprintf(name, sizeof(name), "/proc/%i/task/%s/stat",
-		         getpid(), dent->d_name);
+			 getpid(), dent->d_name);
 
-		SAFE_FILE_SCANF(NULL, name, "%*i %*s %c", &thread_state);
+		SAFE_FILE_SCANF(name, "%*i %*s %c", &thread_state);
 
 		if (thread_state != 'S') {
-			tst_resm(TINFO, "Thread %s not sleeping yet", dent->d_name);
-			SAFE_CLOSEDIR(NULL, dir);
+			tst_res(TINFO, "Thread %s not sleeping yet", dent->d_name);
+			SAFE_CLOSEDIR(dir);
 			return 1;
 		}
 		cnt++;
 	}
 
-	SAFE_CLOSEDIR(NULL, dir);
+	SAFE_CLOSEDIR(dir);
 
 	if (cnt != nr_threads) {
-		tst_resm(TINFO, "%u threads sleeping, expected %u",
-	                  cnt, nr_threads);
+		tst_res(TINFO, "%u threads sleeping, expected %u", cnt,
+			nr_threads);
 	}
 
 	return 0;
 }
 
+static inline int process_state_wait2(pid_t pid, const char state)
+{
+	char proc_path[128], cur_state;
+
+	snprintf(proc_path, sizeof(proc_path), "/proc/%i/stat", pid);
+
+	for (;;) {
+		FILE *f = fopen(proc_path, "r");
+		if (!f) {
+			tst_res(TFAIL, "Failed to open '%s': %s\n", proc_path,
+				strerror(errno));
+			return 1;
+		}
+
+		if (fscanf(f, "%*i %*s %c", &cur_state) != 1) {
+			fclose(f);
+			tst_res(TFAIL, "Failed to read '%s': %s\n", proc_path,
+				strerror(errno));
+			return 1;
+		}
+		fclose(f);
+
+		if (state == cur_state)
+			return 0;
+
+		usleep(10000);
+	}
+}
+
 #endif /* FUTEX_UTILS_H__ */
diff --git a/testcases/kernel/syscalls/futex/futex_wait01.c b/testcases/kernel/syscalls/futex/futex_wait01.c
index 51a540d9e315..e7a283b69f9d 100644
--- a/testcases/kernel/syscalls/futex/futex_wait01.c
+++ b/testcases/kernel/syscalls/futex/futex_wait01.c
@@ -28,10 +28,8 @@
 
 #include <errno.h>
 
-#include "test.h"
 #include "futextest.h"
-
-const char *TCID="futex_wait01";
+#include "lapi/abisize.h"
 
 struct testcase {
 	futex_t *f_addr;
@@ -41,7 +39,6 @@ struct testcase {
 };
 
 static futex_t futex = FUTEX_INITIALIZER;
-static struct timespec to = {.tv_sec = 0, .tv_nsec = 10000};
 
 static struct testcase testcases[] = {
 	{&futex, FUTEX_INITIALIZER, 0, ETIMEDOUT},
@@ -50,38 +47,59 @@ static struct testcase testcases[] = {
 	{&futex, FUTEX_INITIALIZER+1, FUTEX_PRIVATE_FLAG, EWOULDBLOCK},
 };
 
-const int TST_TOTAL=ARRAY_SIZE(testcases);
+static struct test_variants {
+	enum futex_fn_type fntype;
+	enum tst_ts_type tstype;
+	char *desc;
+} variants[] = {
+#if defined(TST_ABI32)
+	{ .fntype = FUTEX_FN_FUTEX, .tstype = TST_KERN_OLD_TIMESPEC, .desc = "syscall with kernel spec32"},
+#endif
+
+#if defined(TST_ABI64)
+	{ .fntype = FUTEX_FN_FUTEX, .tstype = TST_KERN_TIMESPEC, .desc = "syscall with kernel spec64"},
+#endif
+
+#if (__NR_futex_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX64, .tstype = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec64"},
+#endif
+};
 
-static void verify_futex_wait(struct testcase *tc)
+static void run(unsigned int n)
 {
+	struct test_variants *tv = &variants[tst_variant];
+	struct testcase *tc = &testcases[n];
+	static struct tst_ts to;
 	int res;
 
-	res = futex_wait(tc->f_addr, tc->f_val, &to, tc->opflags);
+	to.type = tv->tstype;
+	tst_ts_set_sec(&to, 0);
+	tst_ts_set_nsec(&to, 10000);
+
+	res = futex_wait(tv->fntype, tc->f_addr, tc->f_val, &to, tc->opflags);
 
 	if (res != -1) {
-		tst_resm(TFAIL, "futex_wait() returned %i, expected -1", res);
+		tst_res(TFAIL, "futex_wait() succeeded unexpectedly");
 		return;
 	}
 
 	if (errno != tc->exp_errno) {
-		tst_resm(TFAIL | TERRNO, "expected errno=%s",
+		tst_res(TFAIL | TTERRNO, "futex_wait() failed with incorrect error, expected errno=%s",
 		         tst_strerrno(tc->exp_errno));
 		return;
 	}
 
-	tst_resm(TPASS | TERRNO, "futex_wait()");
+	tst_res(TPASS | TERRNO, "futex_wait() passed");
 }
 
-int main(int argc, char *argv[])
+static void setup(void)
 {
-	int lc, i;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		for (i = 0; i < TST_TOTAL; i++)
-			verify_futex_wait(testcases + i);
-	}
-
-	tst_exit();
+	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(testcases),
+	.test_variants = ARRAY_SIZE(variants),
+};
diff --git a/testcases/kernel/syscalls/futex/futex_wait02.c b/testcases/kernel/syscalls/futex/futex_wait02.c
index 1ca1df457b4a..027d0e9a4eec 100644
--- a/testcases/kernel/syscalls/futex/futex_wait02.c
+++ b/testcases/kernel/syscalls/futex/futex_wait02.c
@@ -26,80 +26,85 @@
 #include <sys/wait.h>
 #include <errno.h>
 
-#include "test.h"
-#include "safe_macros.h"
 #include "futextest.h"
-
-const char *TCID="futex_wait02";
-const int TST_TOTAL=1;
+#include "futex_utils.h"
+#include "lapi/abisize.h"
 
 static futex_t *futex;
 
+static struct test_variants {
+	enum futex_fn_type fntype;
+	char *desc;
+} variants[] = {
+#if defined(TST_ABI32)
+	{ .fntype = FUTEX_FN_FUTEX, .desc = "syscall with kernel spec32"},
+#endif
+
+#if defined(TST_ABI64)
+	{ .fntype = FUTEX_FN_FUTEX, .desc = "syscall with kernel spec64"},
+#endif
+
+#if (__NR_futex_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX64, .desc = "syscall time64 with kernel spec64"},
+#endif
+};
+
 static void do_child(void)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	int ret;
 
-	tst_process_state_wait2(getppid(), 'S');
+	process_state_wait2(getppid(), 'S');
 
-	ret = futex_wake(futex, 1, 0);
+	ret = futex_wake(tv->fntype, futex, 1, 0);
 
 	if (ret != 1)
-		tst_brkm(TFAIL, NULL, "futex_wake() returned %i", ret);
+		tst_res(TFAIL | TTERRNO, "futex_wake() failed");
 
-	exit(TPASS);
+	exit(0);
 }
 
-static void verify_futex_wait(void)
+static void run(void)
 {
-	int res;
-	int pid;
+	struct test_variants *tv = &variants[tst_variant];
+	int res, pid;
 
-	pid = tst_fork();
+	pid = SAFE_FORK();
 
 	switch (pid) {
 	case 0:
 		do_child();
-	break;
-	case -1:
-		tst_brkm(TBROK | TERRNO, NULL, "fork() failed");
-	break;
 	default:
-	break;
+		break;
 	}
 
-	res = futex_wait(futex, *futex, NULL, 0);
-
+	res = futex_wait(tv->fntype, futex, *futex, NULL, 0);
 	if (res) {
-		tst_resm(TFAIL, "futex_wait() returned %i, errno %s",
-		         res, tst_strerrno(errno));
+		tst_res(TFAIL | TTERRNO, "futex_wait() failed");
+		return;
 	}
 
-	SAFE_WAIT(NULL, &res);
+	SAFE_WAIT(&res);
 
 	if (WIFEXITED(res) && WEXITSTATUS(res) == TPASS)
-		tst_resm(TPASS, "futex_wait() woken up");
+		tst_res(TPASS, "futex_wait() woken up");
 	else
-		tst_resm(TFAIL, "child failed");
+		tst_res(TFAIL, "child failed");
 }
 
 static void setup(void)
 {
-	futex = SAFE_MMAP(NULL, NULL, sizeof(*futex), PROT_READ | PROT_WRITE,
+	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
+
+	futex = SAFE_MMAP(NULL, sizeof(*futex), PROT_READ | PROT_WRITE,
 			  MAP_ANONYMOUS | MAP_SHARED, -1, 0);
 
 	*futex = FUTEX_INITIALIZER;
 }
 
-int main(int argc, char *argv[])
-{
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++)
-		verify_futex_wait();
-
-	tst_exit();
-}
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.test_variants = ARRAY_SIZE(variants),
+	.forks_child = 1,
+};
diff --git a/testcases/kernel/syscalls/futex/futex_wait03.c b/testcases/kernel/syscalls/futex/futex_wait03.c
index 9683e76503c0..d2105716c941 100644
--- a/testcases/kernel/syscalls/futex/futex_wait03.c
+++ b/testcases/kernel/syscalls/futex/futex_wait03.c
@@ -25,63 +25,79 @@
 #include <errno.h>
 #include <pthread.h>
 
-#include "test.h"
 #include "futextest.h"
-
-const char *TCID="futex_wait03";
-const int TST_TOTAL=1;
+#include "futex_utils.h"
+#include "lapi/abisize.h"
 
 static futex_t futex = FUTEX_INITIALIZER;
 
+static struct test_variants {
+	enum futex_fn_type fntype;
+	char *desc;
+} variants[] = {
+#if defined(TST_ABI32)
+	{ .fntype = FUTEX_FN_FUTEX, .desc = "syscall with kernel spec32"},
+#endif
+
+#if defined(TST_ABI64)
+	{ .fntype = FUTEX_FN_FUTEX, .desc = "syscall with kernel spec64"},
+#endif
+
+#if (__NR_futex_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX64, .desc = "syscall time64 with kernel spec64"},
+#endif
+};
+
 static void *threaded(void *arg LTP_ATTRIBUTE_UNUSED)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	long ret;
 
-	tst_process_state_wait2(getpid(), 'S');
+	process_state_wait2(getpid(), 'S');
 
-	ret = futex_wake(&futex, 1, FUTEX_PRIVATE_FLAG);
+	ret = futex_wake(tv->fntype, &futex, 1, FUTEX_PRIVATE_FLAG);
 
 	return (void*)ret;
 }
 
-static void verify_futex_wait(void)
+static void run(void)
 {
-	long ret;
-	int res;
+	struct test_variants *tv = &variants[tst_variant];
+	long ret, res;
 	pthread_t t;
 
 	res = pthread_create(&t, NULL, threaded, NULL);
 	if (res) {
-		tst_brkm(TBROK, NULL, "pthread_create(): %s",
-	                 tst_strerrno(res));
+		tst_res(TFAIL | TTERRNO, "pthread_create() failed");
+		return;
 	}
 
-	res = futex_wait(&futex, futex, NULL, FUTEX_PRIVATE_FLAG);
+	res = futex_wait(tv->fntype, &futex, futex, NULL, FUTEX_PRIVATE_FLAG);
 	if (res) {
-		tst_resm(TFAIL, "futex_wait() returned %i, errno %s",
-	                 res, tst_strerrno(errno));
+		tst_res(TFAIL | TTERRNO, "futex_wait() failed");
 		pthread_join(t, NULL);
 		return;
 	}
 
 	res = pthread_join(t, (void*)&ret);
-	if (res)
-		tst_brkm(TBROK, NULL, "pthread_join(): %s", tst_strerrno(res));
+	if (res) {
+		tst_res(TFAIL | TTERRNO, "pthread_join() failed");
+		return;
+	}
 
 	if (ret != 1)
-		tst_resm(TFAIL, "futex_wake() returned %li", ret);
+		tst_res(TFAIL, "futex_wake() returned %li", ret);
 	else
-		tst_resm(TPASS, "futex_wait() woken up");
+		tst_res(TPASS, "futex_wait() woken up");
 }
 
-int main(int argc, char *argv[])
+static void setup(void)
 {
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	for (lc = 0; TEST_LOOPING(lc); lc++)
-		verify_futex_wait();
-
-	tst_exit();
+	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.test_variants = ARRAY_SIZE(variants),
+};
diff --git a/testcases/kernel/syscalls/futex/futex_wait04.c b/testcases/kernel/syscalls/futex/futex_wait04.c
index b8360ff80914..57085c5dd9c0 100644
--- a/testcases/kernel/syscalls/futex/futex_wait04.c
+++ b/testcases/kernel/syscalls/futex/futex_wait04.c
@@ -26,40 +26,58 @@
 
 #include <errno.h>
 
-#include "test.h"
-#include "safe_macros.h"
 #include "futextest.h"
+#include "lapi/abisize.h"
 
-const char *TCID="futex_wait04";
-const int TST_TOTAL=1;
-static struct timespec to = {.tv_sec = 0, .tv_nsec = 10000};
+static struct test_variants {
+	enum futex_fn_type fntype;
+	enum tst_ts_type tstype;
+	char *desc;
+} variants[] = {
+#if defined(TST_ABI32)
+	{ .fntype = FUTEX_FN_FUTEX, .tstype = TST_KERN_OLD_TIMESPEC, .desc = "syscall with kernel spec32"},
+#endif
 
-static void verify_futex_wait(void)
+#if defined(TST_ABI64)
+	{ .fntype = FUTEX_FN_FUTEX, .tstype = TST_KERN_TIMESPEC, .desc = "syscall with kernel spec64"},
+#endif
+
+#if (__NR_futex_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX64, .tstype = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec64"},
+#endif
+};
+
+static void run(void)
 {
-	int res;
-	void *buf;
+	struct test_variants *tv = &variants[tst_variant];
+	static struct tst_ts to;
 	size_t pagesize = getpagesize();
-	buf = SAFE_MMAP(NULL, NULL, pagesize, PROT_READ|PROT_WRITE,
-                        MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
+	void *buf;
+	int res;
 
-	res = futex_wait(buf, 1, &to, 0);
+	buf = SAFE_MMAP(NULL, pagesize, PROT_READ|PROT_WRITE,
+			MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
 
+	to.type = tv->tstype;
+	tst_ts_set_sec(&to, 0);
+	tst_ts_set_nsec(&to, 10000);
+
+	res = futex_wait(tv->fntype, buf, 1, &to, 0);
 	if (res == -1 && errno == EWOULDBLOCK)
-		tst_resm(TPASS | TERRNO, "futex_wait() returned %i", res);
+		tst_res(TPASS | TERRNO, "futex_wait() returned %i", res);
 	else
-		tst_resm(TFAIL | TERRNO, "futex_wait() returned %i", res);
+		tst_res(TFAIL | TERRNO, "futex_wait() returned %i", res);
 
-	SAFE_MUNMAP(NULL, buf, pagesize);
+	SAFE_MUNMAP(buf, pagesize);
 }
 
-int main(int argc, char *argv[])
+static void setup(void)
 {
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	for (lc = 0; TEST_LOOPING(lc); lc++)
-		verify_futex_wait();
-
-	tst_exit();
+	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.test_variants = ARRAY_SIZE(variants),
+};
diff --git a/testcases/kernel/syscalls/futex/futex_wait05.c b/testcases/kernel/syscalls/futex/futex_wait05.c
index 2573ae177d5b..8fad5d858716 100644
--- a/testcases/kernel/syscalls/futex/futex_wait05.c
+++ b/testcases/kernel/syscalls/futex/futex_wait05.c
@@ -19,7 +19,7 @@ int sample_fn(int clk_id, long long usec)
 	futex_t futex = FUTEX_INITIALIZER;
 
 	tst_timer_start(clk_id);
-	TEST(futex_wait(&futex, futex, &to, 0));
+	TEST(syscall(SYS_futex, &futex, FUTEX_WAIT, futex, &to, NULL, 0));
 	tst_timer_stop();
 	tst_timer_sample();
 
diff --git a/testcases/kernel/syscalls/futex/futex_wait_bitset01.c b/testcases/kernel/syscalls/futex/futex_wait_bitset01.c
index b8546c3e640c..f3856697a964 100644
--- a/testcases/kernel/syscalls/futex/futex_wait_bitset01.c
+++ b/testcases/kernel/syscalls/futex/futex_wait_bitset01.c
@@ -12,6 +12,7 @@
 #include "tst_test.h"
 #include "tst_timer.h"
 #include "futextest.h"
+#include "lapi/abisize.h"
 
 #define THRESHOLD_US 100000
 #define DEFAULT_TIMEOUT_US 100010
@@ -23,22 +24,44 @@ static struct test_case_t {
 	{ CLOCK_REALTIME }
 };
 
+static struct test_variants {
+	enum futex_fn_type fntype;
+	enum tst_ts_type tstype;
+	int (*gettime)(clockid_t clk_id, void *ts);
+	char *desc;
+} variants[] = {
+#if defined(TST_ABI32)
+	{ .fntype = FUTEX_FN_FUTEX, .tstype = TST_KERN_OLD_TIMESPEC, .gettime = sys_clock_gettime, .desc = "syscall with kernel spec32"},
+#endif
+
+#if defined(TST_ABI64)
+	{ .fntype = FUTEX_FN_FUTEX, .tstype = TST_KERN_TIMESPEC, .gettime = sys_clock_gettime, .desc = "syscall with kernel spec64"},
+#endif
+
+#if (__NR_futex_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX64, .tstype = TST_KERN_TIMESPEC, .gettime = sys_clock_gettime64, .desc = "syscall time64 with kernel spec64"},
+#endif
+};
+
 static void verify_futex_wait_bitset(long long wait_us, clock_t clk_id)
 {
-	struct timespec start, to, end;
+	struct test_variants *tv = &variants[tst_variant];
+	struct tst_ts start, to, end;
 	futex_t futex = FUTEX_INITIALIZER;
 	u_int32_t bitset = 0xffffffff;
 	int flags = clk_id == CLOCK_REALTIME ? FUTEX_CLOCK_REALTIME : 0;
 
+	start.type = end.type = to.type = tv->tstype;
+
 	tst_res(TINFO, "testing futex_wait_bitset() timeout with %s",
 		clk_id == CLOCK_REALTIME ? "CLOCK_REALTIME" : "CLOCK_MONOTONIC");
 
-	clock_gettime(clk_id, &start);
-	to = tst_timespec_add_us(start, wait_us);
+	tv->gettime(clk_id, tst_ts_get(&start));
+	to = tst_ts_add_us(start, wait_us);
 
-	TEST(futex_wait_bitset(&futex, futex, &to, bitset, flags));
+	TEST(futex_wait_bitset(tv->fntype, &futex, futex, &to, bitset, flags));
 
-	clock_gettime(clk_id, &end);
+	tv->gettime(clk_id, tst_ts_get(&end));
 
 	if (TST_RET != -1) {
 		tst_res(TFAIL, "futex_wait_bitset() returned %li, expected -1",
@@ -58,22 +81,22 @@ static void verify_futex_wait_bitset(long long wait_us, clock_t clk_id)
 		return;
 	}
 
-	if (tst_timespec_lt(end, to)) {
+	if (tst_ts_lt(end, to)) {
 		tst_res(TFAIL,
 			"futex_wait_bitset() woken up prematurely %llius, expected %llius",
-			tst_timespec_diff_us(end, start), wait_us);
+			tst_ts_diff_us(end, start), wait_us);
 		return;
 	}
 
-	if (tst_timespec_diff_us(end, to) > THRESHOLD_US) {
+	if (tst_ts_diff_us(end, to) > THRESHOLD_US) {
 		tst_res(TFAIL,
 			"futex_wait_bitset() waited too long %llius, expected %llius",
-			tst_timespec_diff_us(end, start), wait_us);
+			tst_ts_diff_us(end, start), wait_us);
 		return;
 	}
 
 	tst_res(TPASS, "futex_wait_bitset() waited %llius, expected %llius",
-		tst_timespec_diff_us(end, start), wait_us);
+		tst_ts_diff_us(end, start), wait_us);
 }
 
 static void run(unsigned int n)
@@ -82,7 +105,14 @@ static void run(unsigned int n)
 	verify_futex_wait_bitset(DEFAULT_TIMEOUT_US, tcases[n].clk_id);
 }
 
+static void setup(void)
+{
+	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
+}
+
 static struct tst_test test = {
+	.setup = setup,
 	.test = run,
 	.tcnt = ARRAY_SIZE(tcases),
+	.test_variants = ARRAY_SIZE(variants),
 };
diff --git a/testcases/kernel/syscalls/futex/futex_wake01.c b/testcases/kernel/syscalls/futex/futex_wake01.c
index 42ea6f6e6a75..795f11ed8af1 100644
--- a/testcases/kernel/syscalls/futex/futex_wake01.c
+++ b/testcases/kernel/syscalls/futex/futex_wake01.c
@@ -23,10 +23,8 @@
 #include <errno.h>
 #include <limits.h>
 
-#include "test.h"
 #include "futextest.h"
-
-const char *TCID="futex_wake01";
+#include "lapi/abisize.h"
 
 struct testcase {
 	futex_t *f_addr;
@@ -46,32 +44,46 @@ static struct testcase testcases[] = {
 	{&futex, INT_MAX, FUTEX_PRIVATE_FLAG},
 };
 
-const int TST_TOTAL=ARRAY_SIZE(testcases);
+static struct test_variants {
+	enum futex_fn_type fntype;
+	char *desc;
+} variants[] = {
+#if defined(TST_ABI32)
+	{ .fntype = FUTEX_FN_FUTEX, .desc = "syscall with kernel spec32"},
+#endif
+
+#if defined(TST_ABI64)
+	{ .fntype = FUTEX_FN_FUTEX, .desc = "syscall with kernel spec64"},
+#endif
+
+#if (__NR_futex_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX64, .desc = "syscall time64 with kernel spec64"},
+#endif
+};
 
-static void verify_futex_wake(struct testcase *tc)
+static void run(unsigned int n)
 {
+	struct test_variants *tv = &variants[tst_variant];
+	struct testcase *tc = &testcases[n];
 	int res;
 
-	res = futex_wake(tc->f_addr, tc->nr_wake, tc->opflags);
-
+	res = futex_wake(tv->fntype, tc->f_addr, tc->nr_wake, tc->opflags);
 	if (res != 0) {
-		tst_resm(TFAIL, "futex_wake() returned %i, expected 0", res);
+		tst_res(TFAIL | TTERRNO, "futex_wake() failed");
 		return;
 	}
 
-	tst_resm(TPASS, "futex_wake() returned 0");
+	tst_res(TPASS, "futex_wake() passed");
 }
 
-int main(int argc, char *argv[])
+static void setup(void)
 {
-	int lc, i;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		for (i = 0; i < TST_TOTAL; i++)
-			verify_futex_wake(testcases + i);
-	}
-
-	tst_exit();
+	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(testcases),
+	.test_variants = ARRAY_SIZE(variants),
+};
diff --git a/testcases/kernel/syscalls/futex/futex_wake02.c b/testcases/kernel/syscalls/futex/futex_wake02.c
index 8a4c2d58e4b9..d1030529c082 100644
--- a/testcases/kernel/syscalls/futex/futex_wake02.c
+++ b/testcases/kernel/syscalls/futex/futex_wake02.c
@@ -22,19 +22,33 @@
 
 #include <errno.h>
 #include <pthread.h>
+#include <sys/types.h>
 
-#include "test.h"
-#include "safe_macros.h"
 #include "futextest.h"
 #include "futex_utils.h"
-
-const char *TCID="futex_wake02";
-const int TST_TOTAL=11;
+#include "lapi/abisize.h"
 
 static futex_t futex = FUTEX_INITIALIZER;
 
 static volatile int threads_flags[55];
 
+static struct test_variants {
+	enum futex_fn_type fntype;
+	char *desc;
+} variants[] = {
+#if defined(TST_ABI32)
+	{ .fntype = FUTEX_FN_FUTEX, .desc = "syscall with kernel spec32"},
+#endif
+
+#if defined(TST_ABI64)
+	{ .fntype = FUTEX_FN_FUTEX, .desc = "syscall with kernel spec64"},
+#endif
+
+#if (__NR_futex_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX64, .desc = "syscall time64 with kernel spec64"},
+#endif
+};
+
 static int threads_awake(void)
 {
 	int ret = 0;
@@ -58,9 +72,10 @@ static void clear_threads_awake(void)
 
 static void *threaded(void *arg)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	long i = (long)arg;
 
-	futex_wait(&futex, futex, NULL, FUTEX_PRIVATE_FLAG);
+	futex_wait(tv->fntype, &futex, futex, NULL, FUTEX_PRIVATE_FLAG);
 
 	threads_flags[i] = 1;
 
@@ -69,14 +84,15 @@ static void *threaded(void *arg)
 
 static void do_child(void)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	int res, i, j, awake;
 	pthread_t t[55];
 
 	for (i = 0; i < (int)ARRAY_SIZE(t); i++) {
 		res = pthread_create(&t[i], NULL, threaded, (void*)((long)i));
 		if (res) {
-			tst_brkm(TBROK, NULL, "pthread_create(): %s",
-			         tst_strerrno(res));
+			tst_res(TFAIL | TTERRNO, "pthread_create() failed");
+			return;
 		}
 	}
 
@@ -85,9 +101,9 @@ static void do_child(void)
 
 	for (i = 1; i <= 10; i++) {
 		clear_threads_awake();
-		res = futex_wake(&futex, i, FUTEX_PRIVATE_FLAG);
+		res = futex_wake(tv->fntype, &futex, i, FUTEX_PRIVATE_FLAG);
 		if (i != res) {
-			tst_resm(TFAIL,
+			tst_res(TFAIL | TTERRNO,
 			         "futex_wake() woken up %i threads, expected %i",
 			         res, i);
 		}
@@ -101,26 +117,26 @@ static void do_child(void)
 		}
 
 		if (awake == i) {
-			tst_resm(TPASS, "futex_wake() woken up %i threads", i);
+			tst_res(TPASS, "futex_wake() woken up %i threads", i);
 		} else {
-			tst_resm(TFAIL, "Woken up %i threads, expected %i",
-			         awake, i);
+			tst_res(TFAIL | TTERRNO, "Woken up %i threads, expected %i",
+				awake, i);
 		}
 	}
 
-	res = futex_wake(&futex, 1, FUTEX_PRIVATE_FLAG);
+	res = futex_wake(tv->fntype, &futex, 1, FUTEX_PRIVATE_FLAG);
 
 	if (res) {
-		tst_resm(TFAIL, "futex_wake() woken up %i, none were waiting",
-		         res);
+		tst_res(TFAIL | TTERRNO, "futex_wake() woken up %i, none were waiting",
+			res);
 	} else {
-		tst_resm(TPASS, "futex_wake() woken up 0 threads");
+		tst_res(TPASS, "futex_wake() woken up 0 threads");
 	}
 
 	for (i = 0; i < (int)ARRAY_SIZE(t); i++)
 		pthread_join(t[i], NULL);
 
-	tst_exit();
+	exit(0);
 }
 
 /*
@@ -135,30 +151,28 @@ static void do_child(void)
  * under /proc/$PID/tasks/, but the subsequent open() fails with ENOENT because
  * the thread was removed meanwhile.
  */
-static void verify_futex_wake(void)
+static void run(void)
 {
-	int pid;
+	int status, pid;
 
-	pid = tst_fork();
+	pid = SAFE_FORK();
 
 	switch (pid) {
 	case 0:
 		do_child();
-	case -1:
-		tst_brkm(TBROK | TERRNO, NULL, "fork() failed");
 	default:
-		tst_record_childstatus(NULL, pid);
+		SAFE_WAITPID(pid, &status, 0);
 	}
 }
 
-int main(int argc, char *argv[])
+static void setup(void)
 {
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	for (lc = 0; TEST_LOOPING(lc); lc++)
-		verify_futex_wake();
-
-	tst_exit();
+	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.test_variants = ARRAY_SIZE(variants),
+	.forks_child = 1,
+};
diff --git a/testcases/kernel/syscalls/futex/futex_wake03.c b/testcases/kernel/syscalls/futex/futex_wake03.c
index d6e5e5422db9..5af9093c0178 100644
--- a/testcases/kernel/syscalls/futex/futex_wake03.c
+++ b/testcases/kernel/syscalls/futex/futex_wake03.c
@@ -24,31 +24,48 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 
-#include "test.h"
-#include "safe_macros.h"
 #include "futextest.h"
-
-const char *TCID="futex_wake03";
-const int TST_TOTAL=11;
+#include "futex_utils.h"
+#include "lapi/abisize.h"
 
 static futex_t *futex;
 
+static struct test_variants {
+	enum futex_fn_type fntype;
+	char *desc;
+} variants[] = {
+#if defined(TST_ABI32)
+	{ .fntype = FUTEX_FN_FUTEX, .desc = "syscall with kernel spec32"},
+#endif
+
+#if defined(TST_ABI64)
+	{ .fntype = FUTEX_FN_FUTEX, .desc = "syscall with kernel spec64"},
+#endif
+
+#if (__NR_futex_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX64, .desc = "syscall time64 with kernel spec64"},
+#endif
+};
+
 static void do_child(void)
 {
-	futex_wait(futex, *futex, NULL, 0);
+	struct test_variants *tv = &variants[tst_variant];
+
+	futex_wait(tv->fntype, futex, *futex, NULL, 0);
 	exit(0);
 }
 
 static void do_wake(int nr_children)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	int res, i, cnt;
 
-	res = futex_wake(futex, nr_children, 0);
+	res = futex_wake(tv->fntype, futex, nr_children, 0);
 
 	if (res != nr_children) {
-		tst_resm(TFAIL,
-		         "futex_wake() woken up %i children, expected %i",
-		         res, nr_children);
+		tst_res(TFAIL | TTERRNO,
+		        "futex_wake() woken up %i children, expected %i",
+			res, nr_children);
 		return;
 	}
 
@@ -63,65 +80,60 @@ static void do_wake(int nr_children)
 	}
 
 	if (cnt != nr_children) {
-		tst_resm(TFAIL, "reaped only %i childs, expected %i",
-		         cnt, nr_children);
+		tst_res(TFAIL | TTERRNO, "reaped only %i childs, expected %i",
+		        cnt, nr_children);
 	} else {
-		tst_resm(TPASS, "futex_wake() woken up %i childs", cnt);
+		tst_res(TPASS, "futex_wake() woken up %i childs", cnt);
 	}
 }
 
-static void verify_futex_wake(void)
+static void run(void)
 {
-	int i, res;
+	struct test_variants *tv = &variants[tst_variant];
 	pid_t pids[55];
+	unsigned int i;
+	int res;
 
-	for (i = 0; i < (int)ARRAY_SIZE(pids); i++) {
-		pids[i] = tst_fork();
+	for (i = 0; i < ARRAY_SIZE(pids); i++) {
+		pids[i] = SAFE_FORK();
 
 		switch (pids[i]) {
-		case -1:
-			tst_brkm(TBROK | TERRNO, NULL, "fork()");
 		case 0:
 			do_child();
 		default:
-		break;
+			break;
 		}
 	}
 
-	for (i = 0; i < (int)ARRAY_SIZE(pids); i++)
-		tst_process_state_wait2(pids[i], 'S');
+	for (i = 0; i < ARRAY_SIZE(pids); i++)
+		process_state_wait2(pids[i], 'S');
 
 	for (i = 1; i <= 10; i++)
 		do_wake(i);
 
-	res = futex_wake(futex, 1, 0);
+	res = futex_wake(tv->fntype, futex, 1, 0);
 
 	if (res) {
-		tst_resm(TFAIL, "futex_wake() woken up %u, none were waiting",
-		         res);
+		tst_res(TFAIL | TTERRNO, "futex_wake() woken up %u, none were waiting",
+			res);
 	} else {
-		tst_resm(TPASS, "futex_wake() woken up 0 children");
+		tst_res(TPASS, "futex_wake() woken up 0 children");
 	}
 }
 
 static void setup(void)
 {
-	futex = SAFE_MMAP(NULL, NULL, sizeof(*futex), PROT_READ | PROT_WRITE,
+	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
+
+	futex = SAFE_MMAP(NULL, sizeof(*futex), PROT_READ | PROT_WRITE,
 			  MAP_ANONYMOUS | MAP_SHARED, -1, 0);
 
 	*futex = FUTEX_INITIALIZER;
 }
 
-int main(int argc, char *argv[])
-{
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++)
-		verify_futex_wake();
-
-	tst_exit();
-}
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.test_variants = ARRAY_SIZE(variants),
+	.forks_child = 1,
+};
diff --git a/testcases/kernel/syscalls/futex/futex_wake04.c b/testcases/kernel/syscalls/futex/futex_wake04.c
index f92bda53f6c7..f063c48c4449 100644
--- a/testcases/kernel/syscalls/futex/futex_wake04.c
+++ b/testcases/kernel/syscalls/futex/futex_wake04.c
@@ -42,53 +42,63 @@
 #include <sys/time.h>
 #include <string.h>
 
-#include "test.h"
-#include "safe_macros.h"
 #include "futextest.h"
 #include "futex_utils.h"
 #include "lapi/mmap.h"
+#include "lapi/abisize.h"
+#include "tst_safe_stdio.h"
 
 #define PATH_MEMINFO "/proc/meminfo"
 #define PATH_NR_HUGEPAGES "/proc/sys/vm/nr_hugepages"
 #define PATH_HUGEPAGES	"/sys/kernel/mm/hugepages/"
 
-const char *TCID = "futex_wake04";
-const int TST_TOTAL = 1;
-
 static futex_t *futex1, *futex2;
 
-static struct timespec to = {.tv_sec = 30, .tv_nsec = 0};
+static struct tst_ts to;
 
 static long orig_hugepages;
 
+static struct test_variants {
+	enum futex_fn_type fntype;
+	enum tst_ts_type tstype;
+	char *desc;
+} variants[] = {
+#if defined(TST_ABI32)
+	{ .fntype = FUTEX_FN_FUTEX, .tstype = TST_KERN_OLD_TIMESPEC, .desc = "syscall with kernel spec32"},
+#endif
+
+#if defined(TST_ABI64)
+	{ .fntype = FUTEX_FN_FUTEX, .tstype = TST_KERN_TIMESPEC, .desc = "syscall with kernel spec64"},
+#endif
+
+#if (__NR_futex_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX64, .tstype = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec64"},
+#endif
+};
+
 static void setup(void)
 {
-	tst_require_root();
+	struct test_variants *tv = &variants[tst_variant];
 
-	if ((tst_kvercmp(2, 6, 32)) < 0) {
-		tst_brkm(TCONF, NULL, "This test can only run on kernels "
-			"that are 2.6.32 or higher");
-	}
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
 
-	if (access(PATH_HUGEPAGES, F_OK))
-		tst_brkm(TCONF, NULL, "Huge page is not supported.");
+	to.type = tv->tstype;
+	tst_ts_set_sec(&to, 30);
+	tst_ts_set_nsec(&to, 0);
 
-	tst_tmpdir();
+	if (access(PATH_HUGEPAGES, F_OK))
+		tst_brk(TCONF, "Huge page is not supported.");
 
-	SAFE_FILE_SCANF(NULL, PATH_NR_HUGEPAGES, "%ld", &orig_hugepages);
+	SAFE_FILE_SCANF(PATH_NR_HUGEPAGES, "%ld", &orig_hugepages);
 
 	if (orig_hugepages <= 0)
-		SAFE_FILE_PRINTF(NULL, PATH_NR_HUGEPAGES, "%d", 1);
-
-	TEST_PAUSE;
+		SAFE_FILE_PRINTF(PATH_NR_HUGEPAGES, "%d", 1);
 }
 
 static void cleanup(void)
 {
 	if (orig_hugepages <= 0)
-		SAFE_FILE_PRINTF(NULL, PATH_NR_HUGEPAGES, "%ld", orig_hugepages);
-
-	tst_rmdir();
+		SAFE_FILE_PRINTF(PATH_NR_HUGEPAGES, "%ld", orig_hugepages);
 }
 
 static int read_hugepagesize(void)
@@ -97,60 +107,64 @@ static int read_hugepagesize(void)
 	char line[BUFSIZ], buf[BUFSIZ];
 	int val;
 
-	fp = SAFE_FOPEN(cleanup, PATH_MEMINFO, "r");
+	fp = SAFE_FOPEN(PATH_MEMINFO, "r");
 	while (fgets(line, BUFSIZ, fp) != NULL) {
 		if (sscanf(line, "%64s %d", buf, &val) == 2)
 			if (strcmp(buf, "Hugepagesize:") == 0) {
-				SAFE_FCLOSE(cleanup, fp);
+				SAFE_FCLOSE(fp);
 				return 1024 * val;
 			}
 	}
 
-	SAFE_FCLOSE(cleanup, fp);
-	tst_brkm(TBROK, NULL, "can't find \"%s\" in %s",
-			"Hugepagesize:", PATH_MEMINFO);
+	SAFE_FCLOSE(fp);
+	tst_res(TFAIL, "can't find \"%s\" in %s", "Hugepagesize:",
+		PATH_MEMINFO);
+	return 0;
 }
 
 static void *wait_thread1(void *arg LTP_ATTRIBUTE_UNUSED)
 {
-	futex_wait(futex1, *futex1, &to, 0);
+	struct test_variants *tv = &variants[tst_variant];
+
+	futex_wait(tv->fntype, futex1, *futex1, &to, 0);
 
 	return NULL;
 }
 
 static void *wait_thread2(void *arg LTP_ATTRIBUTE_UNUSED)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	int res;
 
-	res = futex_wait(futex2, *futex2, &to, 0);
+	res = futex_wait(tv->fntype, futex2, *futex2, &to, 0);
 	if (!res)
-		tst_resm(TPASS, "Hi hydra, thread2 awake!");
+		tst_res(TPASS, "Hi hydra, thread2 awake!");
 	else
-		tst_resm(TFAIL, "Bug: wait_thread2 did not wake after 30 secs.");
+		tst_res(TFAIL | TTERRNO, "Bug: wait_thread2 did not wake after 30 secs.");
 
 	return NULL;
 }
 
 static void wakeup_thread2(void)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	void *addr;
 	int hpsz, pgsz, res;
 	pthread_t th1, th2;
 
 	hpsz = read_hugepagesize();
-	tst_resm(TINFO, "Hugepagesize %i", hpsz);
+	tst_res(TINFO, "Hugepagesize %i", hpsz);
 
 	/*allocate some shared memory*/
 	addr = mmap(NULL, hpsz, PROT_WRITE | PROT_READ,
 	            MAP_SHARED | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
 
 	if (addr == MAP_FAILED) {
-		if (errno == ENOMEM) {
-			tst_brkm(TCONF, NULL,
-				 "Cannot allocate hugepage, memory too fragmented?");
-		}
+		if (errno == ENOMEM)
+			tst_res(TCONF, "Cannot allocate hugepage, memory too fragmented?");
 
-		tst_brkm(TBROK | TERRNO, NULL, "Cannot allocate hugepage");
+		tst_res(TFAIL | TERRNO, "Cannot allocate hugepage");
+		return;
 	}
 
 	pgsz = getpagesize();
@@ -165,45 +179,47 @@ static void wakeup_thread2(void)
 	/*thread1 block on futex1 first,then thread2 block on futex2*/
 	res = pthread_create(&th1, NULL, wait_thread1, NULL);
 	if (res) {
-		tst_brkm(TBROK, NULL, "pthread_create(): %s",
-				tst_strerrno(res));
+		tst_res(TFAIL | TTERRNO, "pthread_create() failed");
+		return;
 	}
 
 	res = pthread_create(&th2, NULL, wait_thread2, NULL);
 	if (res) {
-		tst_brkm(TBROK, NULL, "pthread_create(): %s",
-				tst_strerrno(res));
+		tst_res(TFAIL | TTERRNO, "pthread_create() failed");
+		return;
 	}
 
 	while (wait_for_threads(2))
 		usleep(1000);
 
-	futex_wake(futex2, 1, 0);
+	futex_wake(tv->fntype, futex2, 1, 0);
 
 	res = pthread_join(th2, NULL);
-	if (res)
-		tst_brkm(TBROK, NULL, "pthread_join(): %s", tst_strerrno(res));
+	if (res) {
+		tst_res(TFAIL | TTERRNO, "pthread_join() failed");
+		return;
+	}
 
-	futex_wake(futex1, 1, 0);
+	futex_wake(tv->fntype, futex1, 1, 0);
 
 	res = pthread_join(th1, NULL);
 	if (res)
-		tst_brkm(TBROK, NULL, "pthread_join(): %s", tst_strerrno(res));
+		tst_res(TFAIL | TTERRNO, "pthread_join() failed");
 
-	SAFE_MUNMAP(NULL, addr, hpsz);
+	SAFE_MUNMAP(addr, hpsz);
 }
 
-int main(int argc, char *argv[])
+static void run(void)
 {
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++)
-		wakeup_thread2();
-
-	cleanup();
-	tst_exit();
+	wakeup_thread2();
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.test_variants = ARRAY_SIZE(variants),
+	.needs_root = 1,
+	.min_kver = "2.6.32",
+	.needs_tmpdir = 1,
+};
diff --git a/testcases/kernel/syscalls/futex/futextest.h b/testcases/kernel/syscalls/futex/futextest.h
index 5754d36dae51..a9dcbbedd249 100644
--- a/testcases/kernel/syscalls/futex/futextest.h
+++ b/testcases/kernel/syscalls/futex/futextest.h
@@ -39,6 +39,7 @@
 #include <sys/types.h>
 #include <linux/futex.h>
 #include "lapi/futex.h"
+#include "tst_timer.h"
 
 #define FUTEX_INITIALIZER 0
 
@@ -82,18 +83,24 @@
 # define FUTEX_CLOCK_REALTIME 256
 #endif
 
+enum futex_fn_type {
+	FUTEX_FN_FUTEX,
+	FUTEX_FN_FUTEX64,
+};
+
 /**
- * futex() - SYS_futex syscall wrapper
+ * futex_syscall() - futex syscall wrapper
+ * @fntype:	Futex function type
  * @uaddr:	address of first futex
  * @op:		futex op code
  * @val:	typically expected value of uaddr, but varies by op
- * @timeout:	typically an absolute struct timespec (except where noted
+ * @timeout:	typically an absolute struct tst_ts (except where noted
  *		otherwise). Overloaded by some ops
  * @uaddr2:	address of second futex for some ops\
  * @val3:	varies by op
  * @opflags:	flags to be bitwise OR'd with op, such as FUTEX_PRIVATE_FLAG
  *
- * futex() is used by all the following futex op wrappers. It can also be
+ * futex_syscall() is used by all the following futex op wrappers. It can also be
  * used for misuse and abuse testing. Generally, the specific op wrappers
  * should be used instead. It is a macro instead of an static inline function as
  * some of the types over overloaded (timeout is used for nr_requeue for
@@ -102,17 +109,30 @@
  * These argument descriptions are the defaults for all
  * like-named arguments in the following wrappers except where noted below.
  */
-#define futex(uaddr, op, val, timeout, uaddr2, val3, opflags) \
-	syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, val3)
+static inline int futex_syscall(enum futex_fn_type fntype, futex_t *uaddr,
+				int futex_op, futex_t val, void *timeout,
+				futex_t *uaddr2, int val3, int opflags)
+{
+	int (*func)(int *uaddr, int futex_op, int val, void *to, int *uaddr2, int val3);
+
+	if (fntype == FUTEX_FN_FUTEX)
+		func = sys_futex;
+	else
+		func = sys_futex_time64;
+
+	return func((int *)uaddr, futex_op | opflags, val, timeout, (int *)uaddr2, val3);
+}
 
 /**
  * futex_wait() - block on uaddr with optional timeout
  * @timeout:	relative timeout
  */
 static inline int
-futex_wait(futex_t *uaddr, futex_t val, struct timespec *timeout, int opflags)
+futex_wait(enum futex_fn_type fntype, futex_t *uaddr, futex_t val,
+	   struct tst_ts *timeout, int opflags)
 {
-	return futex(uaddr, FUTEX_WAIT, val, timeout, NULL, 0, opflags);
+	return futex_syscall(fntype, uaddr, FUTEX_WAIT, val,
+			     tst_ts_get(timeout), NULL, 0, opflags);
 }
 
 /**
@@ -120,9 +140,10 @@ futex_wait(futex_t *uaddr, futex_t val, struct timespec *timeout, int opflags)
  * @nr_wake:	wake up to this many tasks
  */
 static inline int
-futex_wake(futex_t *uaddr, int nr_wake, int opflags)
+futex_wake(enum futex_fn_type fntype, futex_t *uaddr, int nr_wake, int opflags)
 {
-	return futex(uaddr, FUTEX_WAKE, nr_wake, NULL, NULL, 0, opflags);
+	return futex_syscall(fntype, uaddr, FUTEX_WAKE, nr_wake, NULL, NULL, 0,
+			     opflags);
 }
 
 /**
@@ -130,11 +151,11 @@ futex_wake(futex_t *uaddr, int nr_wake, int opflags)
  * @bitset:	bitset to be used with futex_wake_bitset
  */
 static inline int
-futex_wait_bitset(futex_t *uaddr, futex_t val, struct timespec *timeout,
-		  u_int32_t bitset, int opflags)
+futex_wait_bitset(enum futex_fn_type fntype, futex_t *uaddr, futex_t val,
+		  struct tst_ts *timeout, u_int32_t bitset, int opflags)
 {
-	return futex(uaddr, FUTEX_WAIT_BITSET, val, timeout, NULL, bitset,
-		     opflags);
+	return futex_syscall(fntype, uaddr, FUTEX_WAIT_BITSET, val,
+			     tst_ts_get(timeout), NULL, bitset, opflags);
 }
 
 /**
@@ -142,10 +163,11 @@ futex_wait_bitset(futex_t *uaddr, futex_t val, struct timespec *timeout,
  * @bitset:	bitset to compare with that used in futex_wait_bitset
  */
 static inline int
-futex_wake_bitset(futex_t *uaddr, int nr_wake, u_int32_t bitset, int opflags)
+futex_wake_bitset(enum futex_fn_type fntype, futex_t *uaddr, int nr_wake,
+		  u_int32_t bitset, int opflags)
 {
-	return futex(uaddr, FUTEX_WAKE_BITSET, nr_wake, NULL, NULL, bitset,
-		     opflags);
+	return futex_syscall(fntype, uaddr, FUTEX_WAKE_BITSET, nr_wake, NULL,
+			     NULL, bitset, opflags);
 }
 
 /**
@@ -153,30 +175,32 @@ futex_wake_bitset(futex_t *uaddr, int nr_wake, u_int32_t bitset, int opflags)
  * @detect:	whether (1) or not (0) to perform deadlock detection
  */
 static inline int
-futex_lock_pi(futex_t *uaddr, struct timespec *timeout, int detect,
-	      int opflags)
+futex_lock_pi(enum futex_fn_type fntype, futex_t *uaddr, struct tst_ts *timeout,
+	      int detect, int opflags)
 {
-	return futex(uaddr, FUTEX_LOCK_PI, detect, timeout, NULL, 0, opflags);
+	return futex_syscall(fntype, uaddr, FUTEX_LOCK_PI, detect,
+			     tst_ts_get(timeout), NULL, 0, opflags);
 }
 
 /**
  * futex_unlock_pi() - release uaddr as a PI mutex, waking the top waiter
  */
 static inline int
-futex_unlock_pi(futex_t *uaddr, int opflags)
+futex_unlock_pi(enum futex_fn_type fntype, futex_t *uaddr, int opflags)
 {
-	return futex(uaddr, FUTEX_UNLOCK_PI, 0, NULL, NULL, 0, opflags);
-}
+	return futex_syscall(fntype, uaddr, FUTEX_UNLOCK_PI, 0, NULL, NULL, 0,
+			     opflags); }
 
 /**
  * futex_wake_op() - FIXME: COME UP WITH A GOOD ONE LINE DESCRIPTION
  */
 static inline int
-futex_wake_op(futex_t *uaddr, futex_t *uaddr2, int nr_wake, int nr_wake2,
-	      int wake_op, int opflags)
+futex_wake_op(enum futex_fn_type fntype, futex_t *uaddr, futex_t *uaddr2,
+	      int nr_wake, int nr_wake2, int wake_op, int opflags)
 {
-	return futex(uaddr, FUTEX_WAKE_OP, nr_wake, nr_wake2, uaddr2, wake_op,
-		     opflags);
+	return futex_syscall(fntype, uaddr, FUTEX_WAKE_OP, nr_wake,
+			     (void *)((unsigned long)nr_wake2), uaddr2, wake_op,
+			     opflags);
 }
 
 /**
@@ -188,11 +212,12 @@ futex_wake_op(futex_t *uaddr, futex_t *uaddr2, int nr_wake, int nr_wake2,
  * favor of futex_cmp_requeue().
  */
 static inline int
-futex_requeue(futex_t *uaddr, futex_t *uaddr2, int nr_wake, int nr_requeue,
-	      int opflags)
+futex_requeue(enum futex_fn_type fntype, futex_t *uaddr, futex_t *uaddr2,
+	      int nr_wake, int nr_requeue, int opflags)
 {
-	return futex(uaddr, FUTEX_REQUEUE, nr_wake, nr_requeue, uaddr2, 0,
-		     opflags);
+	return futex_syscall(fntype, uaddr, FUTEX_REQUEUE, nr_wake,
+			     (void *)((unsigned long)nr_requeue), uaddr2, 0,
+			     opflags);
 }
 
 /**
@@ -201,11 +226,12 @@ futex_requeue(futex_t *uaddr, futex_t *uaddr2, int nr_wake, int nr_requeue,
  * @nr_requeue:	requeue up to this many tasks
  */
 static inline int
-futex_cmp_requeue(futex_t *uaddr, futex_t val, futex_t *uaddr2, int nr_wake,
-		  int nr_requeue, int opflags)
+futex_cmp_requeue(enum futex_fn_type fntype, futex_t *uaddr, futex_t val,
+		  futex_t *uaddr2, int nr_wake, int nr_requeue, int opflags)
 {
-	return futex(uaddr, FUTEX_CMP_REQUEUE, nr_wake, nr_requeue, uaddr2,
-		     val, opflags);
+	return futex_syscall(fntype, uaddr, FUTEX_CMP_REQUEUE, nr_wake,
+			     (void *)((unsigned long)nr_requeue), uaddr2, val,
+			     opflags);
 }
 
 /**
@@ -217,11 +243,11 @@ futex_cmp_requeue(futex_t *uaddr, futex_t val, futex_t *uaddr2, int nr_wake,
  * paired with futex_cmp_requeue_pi().
  */
 static inline int
-futex_wait_requeue_pi(futex_t *uaddr, futex_t val, futex_t *uaddr2,
-		      struct timespec *timeout, int opflags)
+futex_wait_requeue_pi(enum futex_fn_type fntype, futex_t *uaddr, futex_t val,
+		      futex_t *uaddr2, struct tst_ts *timeout, int opflags)
 {
-	return futex(uaddr, FUTEX_WAIT_REQUEUE_PI, val, timeout, uaddr2, 0,
-		     opflags);
+	return futex_syscall(fntype, uaddr, FUTEX_WAIT_REQUEUE_PI, val,
+			     tst_ts_get(timeout), uaddr2, 0, opflags);
 }
 
 /**
@@ -232,11 +258,12 @@ futex_wait_requeue_pi(futex_t *uaddr, futex_t val, futex_t *uaddr2,
  * @nr_requeue:	requeue up to this many tasks
  */
 static inline int
-futex_cmp_requeue_pi(futex_t *uaddr, futex_t val, futex_t *uaddr2, int nr_wake,
-		     int nr_requeue, int opflags)
+futex_cmp_requeue_pi(enum futex_fn_type fntype, futex_t *uaddr, futex_t val,
+		     futex_t *uaddr2, int nr_wake, int nr_requeue, int opflags)
 {
-	return futex(uaddr, FUTEX_CMP_REQUEUE_PI, nr_wake, nr_requeue, uaddr2, val,
-		     opflags);
+	return futex_syscall(fntype, uaddr, FUTEX_CMP_REQUEUE_PI, nr_wake,
+			     (void *)((unsigned long)nr_requeue), uaddr2, val,
+			     opflags);
 }
 
 /**
-- 
2.25.0.rc1.19.g042ed3e048af

