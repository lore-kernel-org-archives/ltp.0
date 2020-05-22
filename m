From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 22 May 2020 16:21:35 +0530
Subject: [LTP] [PATCH V4 15/17] syscalls/semtimedop: Add support for
 semtimedop and its time64 version
In-Reply-To: <cover.1590144577.git.viresh.kumar@linaro.org>
References: <cover.1590144577.git.viresh.kumar@linaro.org>
Message-ID: <57fb568295dcde19bdeea2b7cb89230c6f78dbbd.1590144577.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds support for semtimedop() and its time64 variant to the
existing semop() syscall tests.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 testcases/kernel/syscalls/ipc/semop/semop.h   | 55 +++++++++++++++++++
 testcases/kernel/syscalls/ipc/semop/semop01.c | 14 ++++-
 testcases/kernel/syscalls/ipc/semop/semop02.c | 15 ++++-
 testcases/kernel/syscalls/ipc/semop/semop03.c | 16 +++++-
 testcases/kernel/syscalls/ipc/semop/semop04.c | 16 +++++-
 testcases/kernel/syscalls/ipc/semop/semop05.c | 16 +++++-
 6 files changed, 127 insertions(+), 5 deletions(-)
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
index bcb45fa69320..7947183c837b 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop01.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop01.c
@@ -41,6 +41,7 @@
 #include "tst_test.h"
 #include "libnewipc.h"
 #include "lapi/semun.h"
+#include "semop.h"
 
 #define NSEMS	4		/* the number of primitive semaphores to test */
 
@@ -52,11 +53,17 @@ static struct sembuf sops[PSEMS];
 
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
@@ -92,8 +99,12 @@ static void run(void)
 
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
@@ -124,6 +135,7 @@ static void cleanup(void)
 
 static struct tst_test test = {
 	.test_all = run,
+	.test_variants = ARRAY_SIZE(variants),
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
diff --git a/testcases/kernel/syscalls/ipc/semop/semop02.c b/testcases/kernel/syscalls/ipc/semop/semop02.c
index f24d284776a4..4ffb9dd72c1c 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop02.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop02.c
@@ -20,6 +20,7 @@
 #include "tst_test.h"
 #include "libnewipc.h"
 #include "lapi/semun.h"
+#include "semop.h"
 
 static int sem_id_1 = -1;	/* a semaphore set with read & alter permissions */
 static int sem_id_2 = -1;	/* a semaphore set without read & alter permissions */
@@ -46,12 +47,16 @@ static struct test_case_t {
 
 static void setup(void)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	char nobody_uid[] = "nobody";
 	struct passwd *ltpuser;
 	key_t semkey2;
 	struct seminfo ipc_buf;
 	union semun arr;
 
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	semop_supported_by_kernel(tv);
+
 	ltpuser = SAFE_GETPWNAM(nobody_uid);
 	SAFE_SETUID(ltpuser->pw_uid);
 
@@ -84,7 +89,14 @@ static void setup(void)
 
 static void run(unsigned int i)
 {
-	TEST(semop(*(tc[i].semid), tc[i].t_sbuf, tc[i].t_ops));
+	struct test_variants *tv = &variants[tst_variant];
+	struct tst_ts timeout;
+
+	timeout.type = tv->type;
+	tst_ts_set_sec(&timeout, 1);
+	tst_ts_set_nsec(&timeout, 10000);
+
+	TEST(call_semop(tv, *(tc[i].semid), tc[i].t_sbuf, tc[i].t_ops, &timeout));
 
 	if (TST_RET != -1) {
 		tst_res(TFAIL | TTERRNO, "call succeeded unexpectedly");
@@ -117,6 +129,7 @@ static void cleanup(void)
 static struct tst_test test = {
 	.test = run,
 	.tcnt = ARRAY_SIZE(tc),
+	.test_variants = ARRAY_SIZE(variants),
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
diff --git a/testcases/kernel/syscalls/ipc/semop/semop03.c b/testcases/kernel/syscalls/ipc/semop/semop03.c
index 4f5f78eb6d8d..40a6b095c57d 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop03.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop03.c
@@ -38,6 +38,7 @@
 #include "tst_test.h"
 #include "libnewipc.h"
 #include "lapi/semun.h"
+#include "semop.h"
 
 static key_t semkey;
 static int sem_id = -1;
@@ -47,6 +48,13 @@ static int tc[] = { -1, PSEMS + 1 }; /* negative and too many "primitive" semas
 
 static void run(unsigned int i)
 {
+	struct test_variants *tv = &variants[tst_variant];
+	struct tst_ts timeout;
+
+	timeout.type = tv->type;
+	tst_ts_set_sec(&timeout, 1);
+	tst_ts_set_nsec(&timeout, 10000);
+
 	/* initialize two fields in the sembuf structure here */
 	s_buf.sem_op = 1;	/* add this value to struct sem.semval */
 	s_buf.sem_flg = SEM_UNDO;	/* undo when process exits */
@@ -61,7 +69,7 @@ static void run(unsigned int i)
 	 * use the TEST macro to make the call
 	 */
 
-	TEST(semop(sem_id, &s_buf, 1));
+	TEST(call_semop(tv, sem_id, &s_buf, 1, &timeout));
 
 	if (TST_RET != -1) {
 		tst_res(TFAIL | TTERRNO, "call succeeded unexpectedly");
@@ -80,6 +88,11 @@ static void run(unsigned int i)
 
 static void setup(void)
 {
+	struct test_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	semop_supported_by_kernel(tv);
+
 	/* get an IPC resource key */
 	semkey = GETIPCKEY();
 
@@ -102,6 +115,7 @@ static void cleanup(void)
 static struct tst_test test = {
 	.test = run,
 	.tcnt = ARRAY_SIZE(tc),
+	.test_variants = ARRAY_SIZE(variants),
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
diff --git a/testcases/kernel/syscalls/ipc/semop/semop04.c b/testcases/kernel/syscalls/ipc/semop/semop04.c
index 0faf00a3585f..5e4bfeb625e2 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop04.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop04.c
@@ -38,6 +38,7 @@
 #include "tst_test.h"
 #include "libnewipc.h"
 #include "lapi/semun.h"
+#include "semop.h"
 
 static int sem_id = -1;
 static int val; /* value for SETVAL */
@@ -62,6 +63,13 @@ static struct test_case_t {
 
 static void run(unsigned int i)
 {
+	struct test_variants *tv = &variants[tst_variant];
+	struct tst_ts timeout;
+
+	timeout.type = tv->type;
+	tst_ts_set_sec(&timeout, 1);
+	tst_ts_set_nsec(&timeout, 10000);
+
 	/* initialize the s_buf buffer */
 	s_buf.sem_op = tc[i].op;
 	s_buf.sem_flg = tc[i].flg;
@@ -72,7 +80,7 @@ static void run(unsigned int i)
 	if (semctl(sem_id, tc[i].num, SETVAL, tc[i].get_arr) == -1)
 		tst_brk(TBROK | TERRNO, "semctl() failed");
 
-	TEST(semop(sem_id, &s_buf, 1));
+	TEST(call_semop(tv, sem_id, &s_buf, 1, &timeout));
 	if (TST_RET != -1) {
 		tst_res(TFAIL, "call succeeded unexpectedly");
 		return;
@@ -86,6 +94,11 @@ static void run(unsigned int i)
 
 static void setup(void)
 {
+	struct test_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	semop_supported_by_kernel(tv);
+
 	val = 1;
 
 	/* get an IPC resource key */
@@ -114,6 +127,7 @@ static void cleanup(void)
 static struct tst_test test = {
 	.test = run,
 	.tcnt = ARRAY_SIZE(tc),
+	.test_variants = ARRAY_SIZE(variants),
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
diff --git a/testcases/kernel/syscalls/ipc/semop/semop05.c b/testcases/kernel/syscalls/ipc/semop/semop05.c
index 9e8e040b0b19..770646bc564c 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop05.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop05.c
@@ -52,6 +52,7 @@
 #include "tst_test.h"
 #include "libnewipc.h"
 #include "lapi/semun.h"
+#include "semop.h"
 
 static key_t semkey;
 static int sem_id = -1;
@@ -115,7 +116,14 @@ static inline int process_state_wait2(pid_t pid, const char state)
 
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
@@ -137,6 +145,11 @@ static void sighandler(int sig)
 
 static void setup(void)
 {
+	struct test_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	semop_supported_by_kernel(tv);
+
 	SAFE_SIGNAL(SIGHUP, sighandler);
 
 	/* get an IPC resource key */
@@ -238,6 +251,7 @@ static void do_child_uclinux(void)
 static struct tst_test test = {
 	.test = run,
 	.tcnt = ARRAY_SIZE(tc),
+	.test_variants = ARRAY_SIZE(variants),
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
-- 
2.25.0.rc1.19.g042ed3e048af

