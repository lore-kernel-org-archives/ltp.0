From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 16 Sep 2020 16:08:02 +0530
Subject: [LTP] [PATCH V2 17/17] futex: Move variants struct definition to
 common header
In-Reply-To: <cover.1600252542.git.viresh.kumar@linaro.org>
References: <cover.1600252542.git.viresh.kumar@linaro.org>
Message-ID: <aea25607851ab94a0cc69ea3d7213e47d1d6c94e.1600252542.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Use a single definition of the structure and move it to a common place.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../kernel/syscalls/futex/futex_cmp_requeue01.c    | 12 ++++--------
 .../kernel/syscalls/futex/futex_cmp_requeue02.c    |  9 +++------
 testcases/kernel/syscalls/futex/futex_wait01.c     | 10 +++-------
 testcases/kernel/syscalls/futex/futex_wait02.c     | 11 ++++-------
 testcases/kernel/syscalls/futex/futex_wait03.c     | 11 ++++-------
 testcases/kernel/syscalls/futex/futex_wait04.c     | 10 +++-------
 .../kernel/syscalls/futex/futex_wait_bitset01.c    | 11 +++--------
 testcases/kernel/syscalls/futex/futex_wake01.c     |  9 +++------
 testcases/kernel/syscalls/futex/futex_wake02.c     | 11 ++++-------
 testcases/kernel/syscalls/futex/futex_wake03.c     | 13 +++++--------
 testcases/kernel/syscalls/futex/futex_wake04.c     | 14 +++++---------
 testcases/kernel/syscalls/futex/futextest.h        |  7 +++++++
 12 files changed, 48 insertions(+), 80 deletions(-)

diff --git a/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c b/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
index 537641766357..13e67c758bed 100644
--- a/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
+++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
@@ -42,11 +42,7 @@ static struct tcase {
 	{1000, 300, 500},
 };
 
-static struct test_variants {
-	enum futex_fn_type fntype;
-	enum tst_ts_type tstype;
-	char *desc;
-} variants[] = {
+static struct futex_test_variants variants[] = {
 #if (__NR_futex != __LTP__NR_INVALID_SYSCALL)
 	{ .fntype = FUTEX_FN_FUTEX, .tstype = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
 #endif
@@ -58,7 +54,7 @@ static struct test_variants {
 
 static void do_child(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct futex_test_variants *tv = &variants[tst_variant];
 	struct tst_ts usec = tst_ts_from_ms(tv->tstype, max_sleep_ms);
 	int slept_for_ms = 0;
 	int pid = getpid();
@@ -87,7 +83,7 @@ static void do_child(void)
 
 static void verify_futex_cmp_requeue(unsigned int n)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct futex_test_variants *tv = &variants[tst_variant];
 	int num_requeues = 0, num_waits = 0, num_total = 0;
 	int i, status, spurious, woken_up;
 	struct tcase *tc = &tcases[n];
@@ -194,7 +190,7 @@ static void verify_futex_cmp_requeue(unsigned int n)
 
 static void setup(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct futex_test_variants *tv = &variants[tst_variant];
 
 	tst_res(TINFO, "Testing variant: %s", tv->desc);
 	futex_supported_by_kernel(tv->fntype);
diff --git a/testcases/kernel/syscalls/futex/futex_cmp_requeue02.c b/testcases/kernel/syscalls/futex/futex_cmp_requeue02.c
index dd8fafb3ee38..0514b0ba4e69 100644
--- a/testcases/kernel/syscalls/futex/futex_cmp_requeue02.c
+++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue02.c
@@ -32,10 +32,7 @@ static struct tcase {
 	{1, 1, FUTEX_INITIALIZER + 1, EAGAIN},
 };
 
-static struct test_variants {
-	enum futex_fn_type fntype;
-	char *desc;
-} variants[] = {
+static struct futex_test_variants variants[] = {
 #if (__NR_futex != __LTP__NR_INVALID_SYSCALL)
 	{ .fntype = FUTEX_FN_FUTEX, .desc = "syscall with old kernel spec"},
 #endif
@@ -47,7 +44,7 @@ static struct test_variants {
 
 static void verify_futex_cmp_requeue(unsigned int n)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct futex_test_variants *tv = &variants[tst_variant];
 	struct tcase *tc = &tcases[n];
 
 	TEST(futex_cmp_requeue(tv->fntype, &futexes[0], tc->exp_val,
@@ -69,7 +66,7 @@ static void verify_futex_cmp_requeue(unsigned int n)
 
 static void setup(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct futex_test_variants *tv = &variants[tst_variant];
 
 	tst_res(TINFO, "Testing variant: %s", tv->desc);
 	futex_supported_by_kernel(tv->fntype);
diff --git a/testcases/kernel/syscalls/futex/futex_wait01.c b/testcases/kernel/syscalls/futex/futex_wait01.c
index 09a95aa2ca0d..02a3fca3501f 100644
--- a/testcases/kernel/syscalls/futex/futex_wait01.c
+++ b/testcases/kernel/syscalls/futex/futex_wait01.c
@@ -29,11 +29,7 @@ static struct testcase testcases[] = {
 	{&futex, FUTEX_INITIALIZER+1, FUTEX_PRIVATE_FLAG, EWOULDBLOCK},
 };
 
-static struct test_variants {
-	enum futex_fn_type fntype;
-	enum tst_ts_type tstype;
-	char *desc;
-} variants[] = {
+static struct futex_test_variants variants[] = {
 #if (__NR_futex != __LTP__NR_INVALID_SYSCALL)
 	{ .fntype = FUTEX_FN_FUTEX, .tstype = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
 #endif
@@ -45,7 +41,7 @@ static struct test_variants {
 
 static void run(unsigned int n)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct futex_test_variants *tv = &variants[tst_variant];
 	struct testcase *tc = &testcases[n];
 	struct tst_ts to = tst_ts_from_ns(tv->tstype, 10000);
 	int res;
@@ -68,7 +64,7 @@ static void run(unsigned int n)
 
 static void setup(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct futex_test_variants *tv = &variants[tst_variant];
 
 	tst_res(TINFO, "Testing variant: %s", tv->desc);
 	futex_supported_by_kernel(tv->fntype);
diff --git a/testcases/kernel/syscalls/futex/futex_wait02.c b/testcases/kernel/syscalls/futex/futex_wait02.c
index 32bcfd1e744a..c83e6cce44b5 100644
--- a/testcases/kernel/syscalls/futex/futex_wait02.c
+++ b/testcases/kernel/syscalls/futex/futex_wait02.c
@@ -15,10 +15,7 @@
 
 static futex_t *futex;
 
-static struct test_variants {
-	enum futex_fn_type fntype;
-	char *desc;
-} variants[] = {
+static struct futex_test_variants variants[] = {
 #if (__NR_futex != __LTP__NR_INVALID_SYSCALL)
 	{ .fntype = FUTEX_FN_FUTEX, .desc = "syscall with old kernel spec"},
 #endif
@@ -30,7 +27,7 @@ static struct test_variants {
 
 static void do_child(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct futex_test_variants *tv = &variants[tst_variant];
 	int ret;
 
 	TST_PROCESS_STATE_WAIT(getppid(), 'S', 1000);
@@ -45,7 +42,7 @@ static void do_child(void)
 
 static void run(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct futex_test_variants *tv = &variants[tst_variant];
 	int res, pid;
 
 	pid = SAFE_FORK();
@@ -64,7 +61,7 @@ static void run(void)
 
 static void setup(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct futex_test_variants *tv = &variants[tst_variant];
 
 	tst_res(TINFO, "Testing variant: %s", tv->desc);
 	futex_supported_by_kernel(tv->fntype);
diff --git a/testcases/kernel/syscalls/futex/futex_wait03.c b/testcases/kernel/syscalls/futex/futex_wait03.c
index 3e3a7ce2373e..50eb61f7e49d 100644
--- a/testcases/kernel/syscalls/futex/futex_wait03.c
+++ b/testcases/kernel/syscalls/futex/futex_wait03.c
@@ -13,10 +13,7 @@
 
 static futex_t futex = FUTEX_INITIALIZER;
 
-static struct test_variants {
-	enum futex_fn_type fntype;
-	char *desc;
-} variants[] = {
+static struct futex_test_variants variants[] = {
 #if (__NR_futex != __LTP__NR_INVALID_SYSCALL)
 	{ .fntype = FUTEX_FN_FUTEX, .desc = "syscall with old kernel spec"},
 #endif
@@ -28,7 +25,7 @@ static struct test_variants {
 
 static void *threaded(void *arg)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct futex_test_variants *tv = &variants[tst_variant];
 	long ret, pid = (long)arg;
 
 	TST_PROCESS_STATE_WAIT(pid, 'S', 0);
@@ -42,7 +39,7 @@ static void *threaded(void *arg)
 
 static void run(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct futex_test_variants *tv = &variants[tst_variant];
 	long res, pid = getpid();
 	pthread_t t;
 
@@ -61,7 +58,7 @@ static void run(void)
 
 static void setup(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct futex_test_variants *tv = &variants[tst_variant];
 
 	tst_res(TINFO, "Testing variant: %s", tv->desc);
 	futex_supported_by_kernel(tv->fntype);
diff --git a/testcases/kernel/syscalls/futex/futex_wait04.c b/testcases/kernel/syscalls/futex/futex_wait04.c
index f2885c8b27d5..500b74ae1ef9 100644
--- a/testcases/kernel/syscalls/futex/futex_wait04.c
+++ b/testcases/kernel/syscalls/futex/futex_wait04.c
@@ -13,11 +13,7 @@
 
 #include "futextest.h"
 
-static struct test_variants {
-	enum futex_fn_type fntype;
-	enum tst_ts_type tstype;
-	char *desc;
-} variants[] = {
+static struct futex_test_variants variants[] = {
 #if (__NR_futex != __LTP__NR_INVALID_SYSCALL)
 	{ .fntype = FUTEX_FN_FUTEX, .tstype = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
 #endif
@@ -29,7 +25,7 @@ static struct test_variants {
 
 static void run(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct futex_test_variants *tv = &variants[tst_variant];
 	struct tst_ts to = tst_ts_from_ns(tv->tstype, 10000);
 	size_t pagesize = getpagesize();
 	void *buf;
@@ -49,7 +45,7 @@ static void run(void)
 
 static void setup(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct futex_test_variants *tv = &variants[tst_variant];
 
 	tst_res(TINFO, "Testing variant: %s", tv->desc);
 	futex_supported_by_kernel(tv->fntype);
diff --git a/testcases/kernel/syscalls/futex/futex_wait_bitset01.c b/testcases/kernel/syscalls/futex/futex_wait_bitset01.c
index 358a5cd4542c..6880df6a554e 100644
--- a/testcases/kernel/syscalls/futex/futex_wait_bitset01.c
+++ b/testcases/kernel/syscalls/futex/futex_wait_bitset01.c
@@ -21,12 +21,7 @@ static struct test_case_t {
 	{ CLOCK_REALTIME }
 };
 
-static struct test_variants {
-	enum futex_fn_type fntype;
-	enum tst_ts_type tstype;
-	int (*gettime)(clockid_t clk_id, void *ts);
-	char *desc;
-} variants[] = {
+static struct futex_test_variants variants[] = {
 #if (__NR_futex != __LTP__NR_INVALID_SYSCALL)
 	{ .fntype = FUTEX_FN_FUTEX, .tstype = TST_KERN_OLD_TIMESPEC, .gettime = sys_clock_gettime, .desc = "syscall with old kernel spec"},
 #endif
@@ -38,7 +33,7 @@ static struct test_variants {
 
 static void verify_futex_wait_bitset(long long wait_us, clock_t clk_id)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct futex_test_variants *tv = &variants[tst_variant];
 	struct tst_ts start, to, end;
 	futex_t futex = FUTEX_INITIALIZER;
 	u_int32_t bitset = 0xffffffff;
@@ -99,7 +94,7 @@ static void run(unsigned int n)
 
 static void setup(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct futex_test_variants *tv = &variants[tst_variant];
 
 	tst_res(TINFO, "Testing variant: %s", tv->desc);
 	futex_supported_by_kernel(tv->fntype);
diff --git a/testcases/kernel/syscalls/futex/futex_wake01.c b/testcases/kernel/syscalls/futex/futex_wake01.c
index a2f225a9cd1a..1dcf2f094e0c 100644
--- a/testcases/kernel/syscalls/futex/futex_wake01.c
+++ b/testcases/kernel/syscalls/futex/futex_wake01.c
@@ -27,10 +27,7 @@ static struct testcase testcases[] = {
 	{&futex, INT_MAX, FUTEX_PRIVATE_FLAG},
 };
 
-static struct test_variants {
-	enum futex_fn_type fntype;
-	char *desc;
-} variants[] = {
+static struct futex_test_variants variants[] = {
 #if (__NR_futex != __LTP__NR_INVALID_SYSCALL)
 	{ .fntype = FUTEX_FN_FUTEX, .desc = "syscall with old kernel spec"},
 #endif
@@ -42,7 +39,7 @@ static struct test_variants {
 
 static void run(unsigned int n)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct futex_test_variants *tv = &variants[tst_variant];
 	struct testcase *tc = &testcases[n];
 	int res;
 
@@ -57,7 +54,7 @@ static void run(unsigned int n)
 
 static void setup(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct futex_test_variants *tv = &variants[tst_variant];
 
 	tst_res(TINFO, "Testing variant: %s", tv->desc);
 	futex_supported_by_kernel(tv->fntype);
diff --git a/testcases/kernel/syscalls/futex/futex_wake02.c b/testcases/kernel/syscalls/futex/futex_wake02.c
index de80738bd73f..2eeec959d480 100644
--- a/testcases/kernel/syscalls/futex/futex_wake02.c
+++ b/testcases/kernel/syscalls/futex/futex_wake02.c
@@ -15,10 +15,7 @@ static futex_t futex = FUTEX_INITIALIZER;
 
 static volatile int threads_flags[55];
 
-static struct test_variants {
-	enum futex_fn_type fntype;
-	char *desc;
-} variants[] = {
+static struct futex_test_variants variants[] = {
 #if (__NR_futex != __LTP__NR_INVALID_SYSCALL)
 	{ .fntype = FUTEX_FN_FUTEX, .desc = "syscall with old kernel spec"},
 #endif
@@ -51,7 +48,7 @@ static void clear_threads_awake(void)
 
 static void *threaded(void *arg)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct futex_test_variants *tv = &variants[tst_variant];
 	long i = (long)arg;
 
 	futex_wait(tv->fntype, &futex, futex, NULL, FUTEX_PRIVATE_FLAG);
@@ -63,7 +60,7 @@ static void *threaded(void *arg)
 
 static void do_child(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct futex_test_variants *tv = &variants[tst_variant];
 	int i, j, awake;
 	pthread_t t[55];
 
@@ -132,7 +129,7 @@ static void run(void)
 
 static void setup(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct futex_test_variants *tv = &variants[tst_variant];
 
 	tst_res(TINFO, "Testing variant: %s", tv->desc);
 	futex_supported_by_kernel(tv->fntype);
diff --git a/testcases/kernel/syscalls/futex/futex_wake03.c b/testcases/kernel/syscalls/futex/futex_wake03.c
index 02b291e1a29e..a56ae92221f6 100644
--- a/testcases/kernel/syscalls/futex/futex_wake03.c
+++ b/testcases/kernel/syscalls/futex/futex_wake03.c
@@ -13,10 +13,7 @@
 
 static futex_t *futex;
 
-static struct test_variants {
-	enum futex_fn_type fntype;
-	char *desc;
-} variants[] = {
+static struct futex_test_variants variants[] = {
 #if (__NR_futex != __LTP__NR_INVALID_SYSCALL)
 	{ .fntype = FUTEX_FN_FUTEX, .desc = "syscall with old kernel spec"},
 #endif
@@ -28,7 +25,7 @@ static struct test_variants {
 
 static void do_child(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct futex_test_variants *tv = &variants[tst_variant];
 
 	futex_wait(tv->fntype, futex, *futex, NULL, 0);
 	exit(0);
@@ -36,7 +33,7 @@ static void do_child(void)
 
 static void do_wake(int nr_children)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct futex_test_variants *tv = &variants[tst_variant];
 	int res, i, cnt;
 
 	TEST(futex_wake(tv->fntype, futex, nr_children, 0));
@@ -67,7 +64,7 @@ static void do_wake(int nr_children)
 
 static void run(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct futex_test_variants *tv = &variants[tst_variant];
 	pid_t pids[55];
 	unsigned int i;
 
@@ -95,7 +92,7 @@ static void run(void)
 
 static void setup(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct futex_test_variants *tv = &variants[tst_variant];
 
 	tst_res(TINFO, "Testing variant: %s", tv->desc);
 	futex_supported_by_kernel(tv->fntype);
diff --git a/testcases/kernel/syscalls/futex/futex_wake04.c b/testcases/kernel/syscalls/futex/futex_wake04.c
index f6f571ac4bff..2260a3936d6e 100644
--- a/testcases/kernel/syscalls/futex/futex_wake04.c
+++ b/testcases/kernel/syscalls/futex/futex_wake04.c
@@ -36,11 +36,7 @@ static futex_t *futex1, *futex2;
 
 static struct tst_ts to;
 
-static struct test_variants {
-	enum futex_fn_type fntype;
-	enum tst_ts_type tstype;
-	char *desc;
-} variants[] = {
+static struct futex_test_variants variants[] = {
 #if (__NR_futex != __LTP__NR_INVALID_SYSCALL)
 	{ .fntype = FUTEX_FN_FUTEX, .tstype = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
 #endif
@@ -55,7 +51,7 @@ static void setup(void)
 	if (tst_hugepages == 0)
 		tst_brk(TCONF, "No enough hugepages for testing.");
 
-	struct test_variants *tv = &variants[tst_variant];
+	struct futex_test_variants *tv = &variants[tst_variant];
 
 	tst_res(TINFO, "Testing variant: %s", tv->desc);
 	futex_supported_by_kernel(tv->fntype);
@@ -65,7 +61,7 @@ static void setup(void)
 
 static void *wait_thread1(void *arg LTP_ATTRIBUTE_UNUSED)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct futex_test_variants *tv = &variants[tst_variant];
 
 	futex_wait(tv->fntype, futex1, *futex1, &to, 0);
 
@@ -74,7 +70,7 @@ static void *wait_thread1(void *arg LTP_ATTRIBUTE_UNUSED)
 
 static void *wait_thread2(void *arg LTP_ATTRIBUTE_UNUSED)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct futex_test_variants *tv = &variants[tst_variant];
 	int res;
 
 	errno = 0;
@@ -89,7 +85,7 @@ static void *wait_thread2(void *arg LTP_ATTRIBUTE_UNUSED)
 
 static void wakeup_thread2(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct futex_test_variants *tv = &variants[tst_variant];
 	void *addr;
 	int hpsz, pgsz;
 	pthread_t th1, th2;
diff --git a/testcases/kernel/syscalls/futex/futextest.h b/testcases/kernel/syscalls/futex/futextest.h
index c50876fa67d4..3f2f36fef4ea 100644
--- a/testcases/kernel/syscalls/futex/futextest.h
+++ b/testcases/kernel/syscalls/futex/futextest.h
@@ -67,6 +67,13 @@ enum futex_fn_type {
 	FUTEX_FN_FUTEX64,
 };
 
+struct futex_test_variants {
+	enum futex_fn_type fntype;
+	enum tst_ts_type tstype;
+	int (*gettime)(clockid_t clk_id, void *ts);
+	char *desc;
+};
+
 static inline void futex_supported_by_kernel(enum futex_fn_type fntype)
 {
 	if (fntype != FUTEX_FN_FUTEX64)
-- 
2.25.0.rc1.19.g042ed3e048af

