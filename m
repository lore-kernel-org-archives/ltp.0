From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 16 Sep 2020 16:07:52 +0530
Subject: [LTP] [PATCH V2 07/17] syscalls: semop: Reuse struct time64_variants
In-Reply-To: <cover.1600252542.git.viresh.kumar@linaro.org>
References: <cover.1600252542.git.viresh.kumar@linaro.org>
Message-ID: <e1520ee888771dfbb73a6c6dfdfb637e5ba75005.1600252542.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Lets reuse the common structure here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 testcases/kernel/syscalls/ipc/semop/semop.h   | 18 +++++++-----------
 testcases/kernel/syscalls/ipc/semop/semop01.c |  6 +++---
 testcases/kernel/syscalls/ipc/semop/semop02.c |  6 +++---
 testcases/kernel/syscalls/ipc/semop/semop03.c |  6 +++---
 4 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/semop/semop.h b/testcases/kernel/syscalls/ipc/semop/semop.h
index 1fac31818108..73ab9fbbc15c 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop.h
+++ b/testcases/kernel/syscalls/ipc/semop/semop.h
@@ -4,6 +4,7 @@
 #define SEMOP_VAR__
 
 #include <sys/sem.h>
+#include "time64_variants.h"
 #include "tst_timer.h"
 
 static inline int sys_semtimedop(int semid, struct sembuf *sops, size_t nsops,
@@ -18,24 +19,19 @@ static inline int sys_semtimedop_time64(int semid, struct sembuf *sops,
 	return tst_syscall(__NR_semtimedop_time64, semid, sops, nsops, timeout);
 }
 
-struct test_variants {
-	int (*semop)(int semid, struct sembuf *sops, size_t nsops);
-	int (*semtimedop)(int semid, struct sembuf *sops, size_t nsops, void *timeout);
-	enum tst_ts_type type;
-	char *desc;
-} variants[] = {
-	{ .semop = semop, .type = TST_LIBC_TIMESPEC, .desc = "semop: syscall"},
+static struct time64_variants variants[] = {
+	{ .semop = semop, .ts_type = TST_LIBC_TIMESPEC, .desc = "semop: syscall"},
 
 #if (__NR_semtimedop != __LTP__NR_INVALID_SYSCALL)
-	{ .semtimedop = sys_semtimedop, .type = TST_KERN_OLD_TIMESPEC, .desc = "semtimedop: syscall with old kernel spec"},
+	{ .semtimedop = sys_semtimedop, .ts_type = TST_KERN_OLD_TIMESPEC, .desc = "semtimedop: syscall with old kernel spec"},
 #endif
 
 #if (__NR_semtimedop_time64 != __LTP__NR_INVALID_SYSCALL)
-	{ .semtimedop = sys_semtimedop_time64, .type = TST_KERN_TIMESPEC, .desc = "semtimedop: syscall time64 with kernel spec"},
+	{ .semtimedop = sys_semtimedop_time64, .ts_type = TST_KERN_TIMESPEC, .desc = "semtimedop: syscall time64 with kernel spec"},
 #endif
 };
 
-static inline int call_semop(struct test_variants *tv, int semid,
+static inline int call_semop(struct time64_variants *tv, int semid,
 		struct sembuf *sops, size_t nsops, void *timeout)
 {
 	if (tv->semop)
@@ -44,7 +40,7 @@ static inline int call_semop(struct test_variants *tv, int semid,
 	return tv->semtimedop(semid, sops, nsops, timeout);
 }
 
-static inline void semop_supported_by_kernel(struct test_variants *tv)
+static inline void semop_supported_by_kernel(struct time64_variants *tv)
 {
        /* Check if the syscall is implemented on the platform */
        TEST(call_semop(tv, 0, NULL, 0, NULL));
diff --git a/testcases/kernel/syscalls/ipc/semop/semop01.c b/testcases/kernel/syscalls/ipc/semop/semop01.c
index add9d07f3ad4..b20eef45cf59 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop01.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop01.c
@@ -33,7 +33,7 @@ static struct test_case_t {
 
 static void run(unsigned int n)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 	union semun arr = { .val = 0 };
 	int fail = 0;
 	int i;
@@ -66,13 +66,13 @@ static void run(unsigned int n)
 
 static void setup(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 	int i;
 
 	tst_res(TINFO, "Testing variant: %s", tv->desc);
 	semop_supported_by_kernel(tv);
 
-	timeout.type = tv->type;
+	timeout.type = tv->ts_type;
 	tst_ts_set_sec(&timeout, 0);
 	tst_ts_set_nsec(&timeout, 10000);
 
diff --git a/testcases/kernel/syscalls/ipc/semop/semop02.c b/testcases/kernel/syscalls/ipc/semop/semop02.c
index 9d799e6437cd..2c3ec2c66686 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop02.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop02.c
@@ -69,7 +69,7 @@ static struct test_case_t {
 
 static void setup(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 	struct passwd *ltpuser;
 	key_t semkey;
 	union semun arr;
@@ -79,7 +79,7 @@ static void setup(void)
 	tst_res(TINFO, "Testing variant: %s", tv->desc);
 	semop_supported_by_kernel(tv);
 
-	timeout.type = tv->type;
+	timeout.type = tv->ts_type;
 	tst_ts_set_sec(&timeout, 0);
 	tst_ts_set_nsec(&timeout, 10000);
 
@@ -110,7 +110,7 @@ static void setup(void)
 
 static void run(unsigned int i)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 	union semun arr = {.val = tc[i].arr_val};
 	struct sembuf buf = {
 		.sem_op = *tc[i].sem_op,
diff --git a/testcases/kernel/syscalls/ipc/semop/semop03.c b/testcases/kernel/syscalls/ipc/semop/semop03.c
index 43d22a8ee1a7..89603f19d651 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop03.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop03.c
@@ -36,7 +36,7 @@ struct test_case_t {
 
 static void do_child(int i)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 	struct sembuf s_buf = {
 		.sem_op = tc[i].op,
 		.sem_flg = tc[i].flg,
@@ -65,12 +65,12 @@ static void sighandler(int sig)
 
 static void setup(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 
 	tst_res(TINFO, "Testing variant: %s", tv->desc);
 	semop_supported_by_kernel(tv);
 
-	timeout.type = tv->type;
+	timeout.type = tv->ts_type;
 	tst_ts_set_sec(&timeout, 0);
 	tst_ts_set_nsec(&timeout, 10000000);
 
-- 
2.25.0.rc1.19.g042ed3e048af

