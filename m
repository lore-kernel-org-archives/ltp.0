From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 29 Jul 2020 13:25:53 +0530
Subject: [LTP] [PATCH V8 5/5] syscalls/semtimedop: Add support for
 semtimedop and its time64 version
In-Reply-To: <fab6e65d02767b60594916da89cca34221989229.1596008484.git.viresh.kumar@linaro.org>
References: <fab6e65d02767b60594916da89cca34221989229.1596008484.git.viresh.kumar@linaro.org>
Message-ID: <c1ca12b5df0510279a8b2f0a93106b1ca153c4a7.1596008484.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds support for semtimedop() and its time64 variant to the
existing semop() syscall tests.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 testcases/kernel/syscalls/ipc/semop/semop.h   | 55 +++++++++++++++++++++++++++
 testcases/kernel/syscalls/ipc/semop/semop01.c | 14 ++++++-
 testcases/kernel/syscalls/ipc/semop/semop02.c | 15 +++++++-
 testcases/kernel/syscalls/ipc/semop/semop03.c | 16 +++++++-
 4 files changed, 97 insertions(+), 3 deletions(-)
 create mode 100644 testcases/kernel/syscalls/ipc/semop/semop.h

diff --git a/testcases/kernel/syscalls/ipc/semop/semop.h b/testcases/kernel/syscalls/ipc/semop/semop.h
new file mode 100644
index 000000000000..584d12c68e0d
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/semop/semop.h
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#ifndef SEMOP_VAR__
+#define SEMOP_VAR__
+
+#include <sys/sem.h>
+#include "tst_timer.h"
+
+static inline int sys_semtimedop(int semid, struct sembuf *sops, size_t nsops,
+		void *timeout)
+{
+	return tst_syscall(__NR_semtimedop, semid, sops, nsops, timeout);
+}
+
+static inline int sys_semtimedop_time64(int semid, struct sembuf *sops,
+					size_t nsops, void *timeout)
+{
+	return tst_syscall(__NR_semtimedop_time64, semid, sops, nsops, timeout);
+}
+
+struct test_variants {
+	int (*semop)(int semid, struct sembuf *sops, size_t nsops);
+	int (*semtimedop)(int semid, struct sembuf *sops, size_t nsops, void *timeout);
+	enum tst_ts_type type;
+	char *desc;
+} variants[] = {
+	{ .semop = semop, .type = TST_LIBC_TIMESPEC, .desc = "semop: vDSO or syscall"},
+
+#if (__NR_semtimedop != __LTP__NR_INVALID_SYSCALL)
+	{ .semtimedop = sys_semtimedop, .type = TST_KERN_OLD_TIMESPEC, .desc = "semtimedop: syscall with old kernel spec"},
+#endif
+
+#if (__NR_semtimedop_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .semtimedop = sys_semtimedop_time64, .type = TST_KERN_TIMESPEC, .desc = "semtimedop: syscall time64 with kernel spec"},
+#endif
+};
+
+static inline int call_semop(struct test_variants *tv, int semid,
+		struct sembuf *sops, size_t nsops, struct tst_ts *timeout)
+{
+	if (tv->semop)
+		return tv->semop(semid, sops, nsops);
+
+	return tv->semtimedop(semid, sops, nsops, tst_ts_get(timeout));
+}
+
+static inline void semop_supported_by_kernel(struct test_variants *tv)
+{
+       /* Check if the syscall is implemented on the platform */
+       TEST(call_semop(tv, 0, NULL, 0, NULL));
+       if (TST_RET == -1 && TST_ERR == ENOSYS)
+               tst_brk(TCONF, "Test not supported on kernel/platform");
+}
+
+#endif /* SEMOP_VAR__ */
diff --git a/testcases/kernel/syscalls/ipc/semop/semop01.c b/testcases/kernel/syscalls/ipc/semop/semop01.c
index 19607ee6d653..c3443da58af4 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop01.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop01.c
@@ -12,6 +12,7 @@
 #include "tst_test.h"
 #include "libnewipc.h"
 #include "lapi/semun.h"
+#include "semop.h"
 
 #define NSEMS	4		/* the number of primitive semaphores to test */
 
@@ -23,11 +24,17 @@ static struct sembuf sops[PSEMS];
 
 static void run(void)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	union semun arr = { .val = 0 };
+	struct tst_ts timeout;
 	int fail = 0;
 	int i;
 
-	TEST(semop(sem_id, sops, NSEMS));
+	timeout.type = tv->type;
+	tst_ts_set_sec(&timeout, 1);
+	tst_ts_set_nsec(&timeout, 10000);
+
+	TEST(call_semop(tv, sem_id, sops, NSEMS, &timeout));
 	if (TST_RET == -1) {
 		tst_res(TFAIL | TTERRNO, "semop() failed");
 	} else {
@@ -54,8 +61,12 @@ static void run(void)
 
 static void setup(void)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	int i;
 
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	semop_supported_by_kernel(tv);
+
 	get_arr.array = malloc(sizeof(unsigned short int) * PSEMS);
 	if (get_arr.array == NULL)
 		tst_brk(TBROK, "malloc failed");
@@ -86,6 +97,7 @@ static void cleanup(void)
 
 static struct tst_test test = {
 	.test_all = run,
+	.test_variants = ARRAY_SIZE(variants),
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
diff --git a/testcases/kernel/syscalls/ipc/semop/semop02.c b/testcases/kernel/syscalls/ipc/semop/semop02.c
index 7a49b2648b2b..1b9b768f5e63 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop02.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop02.c
@@ -14,6 +14,7 @@
 #include "tst_test.h"
 #include "libnewipc.h"
 #include "lapi/semun.h"
+#include "semop.h"
 
 static int sem_id_1 = -1;	/* a semaphore set with read & alter permissions */
 static int sem_id_2 = -1;	/* a semaphore set without read & alter permissions */
@@ -53,11 +54,15 @@ static struct test_case_t {
 
 static void setup(void)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	char nobody_uid[] = "nobody";
 	struct passwd *ltpuser;
 	key_t semkey2;
 	struct seminfo ipc_buf;
 
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	semop_supported_by_kernel(tv);
+
 	ltpuser = SAFE_GETPWNAM(nobody_uid);
 	SAFE_SETUID(ltpuser->pw_uid);
 
@@ -83,6 +88,13 @@ static void setup(void)
 
 static void run(unsigned int i)
 {
+	struct test_variants *tv = &variants[tst_variant];
+	struct tst_ts timeout;
+
+	timeout.type = tv->type;
+	tst_ts_set_sec(&timeout, 1);
+	tst_ts_set_nsec(&timeout, 10000);
+
 	if (*tc[i].buf != faulty_buf) {
 		arr.val = tc[i].arr_val;
 
@@ -94,7 +106,7 @@ static void run(unsigned int i)
 		s_buf[0].sem_num = tc[i].sem_num;
 	}
 
-	TEST(semop(*(tc[i].semid), *tc[i].buf, tc[i].t_ops));
+	TEST(call_semop(tv, *(tc[i].semid), *tc[i].buf, tc[i].t_ops, &timeout));
 
 	if (TST_RET != -1) {
 		tst_res(TFAIL | TTERRNO, "call succeeded unexpectedly");
@@ -127,6 +139,7 @@ static void cleanup(void)
 static struct tst_test test = {
 	.test = run,
 	.tcnt = ARRAY_SIZE(tc),
+	.test_variants = ARRAY_SIZE(variants),
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
diff --git a/testcases/kernel/syscalls/ipc/semop/semop03.c b/testcases/kernel/syscalls/ipc/semop/semop03.c
index df8ce7d16ee5..d0fea1ed1dd5 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop03.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop03.c
@@ -15,6 +15,7 @@
 #include "tst_test.h"
 #include "libnewipc.h"
 #include "lapi/semun.h"
+#include "semop.h"
 
 static key_t semkey;
 static int sem_id = -1;
@@ -64,7 +65,14 @@ static inline int process_state_wait2(pid_t pid, const char state)
 
 static void do_child(int i)
 {
-	TEST(semop(sem_id, &s_buf, 1));
+	struct test_variants *tv = &variants[tst_variant];
+	struct tst_ts timeout;
+
+	timeout.type = tv->type;
+	tst_ts_set_sec(&timeout, 1);
+	tst_ts_set_nsec(&timeout, 10000);
+
+	TEST(call_semop(tv, sem_id, &s_buf, 1, &timeout));
 	if (TST_RET != -1) {
 		tst_res(TFAIL, "call succeeded when error expected");
 		exit(-1);
@@ -86,6 +94,11 @@ static void sighandler(int sig)
 
 static void setup(void)
 {
+	struct test_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	semop_supported_by_kernel(tv);
+
 	SAFE_SIGNAL(SIGHUP, sighandler);
 	semkey = GETIPCKEY();
 
@@ -149,6 +162,7 @@ static void run(unsigned int i)
 static struct tst_test test = {
 	.test = run,
 	.tcnt = ARRAY_SIZE(tc),
+	.test_variants = ARRAY_SIZE(variants),
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
-- 
2.14.1

