From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed,  2 Sep 2020 15:40:05 +0530
Subject: [LTP] [PATCH V10 2/2] syscalls/semtimedop: Add failure test for
 invalid timeout pointer
In-Reply-To: <551441b4bce2d9dfd1567ffcd536f50f14a049d0.1599041148.git.viresh.kumar@linaro.org>
References: <551441b4bce2d9dfd1567ffcd536f50f14a049d0.1599041148.git.viresh.kumar@linaro.org>
Message-ID: <5ed75cb65e0ac8c7c5ae7df7f851cb65fc970bf5.1599041148.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds test for invalid timeout pointer.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

---
V10:
- Fixed the crash after Li Wang pointed out the issue.
- Don't call tst_ts_get() on invalid timeout pointer.

 testcases/kernel/syscalls/ipc/semop/semop02.c | 41 ++++++++++++-------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/semop/semop02.c b/testcases/kernel/syscalls/ipc/semop/semop02.c
index 22fdb5cbef4c..18eea8cc0180 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop02.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop02.c
@@ -12,6 +12,7 @@
  * EAGAIN  - semop = -1 for zero semaphore and IPC_NOWAIT passed in flags
  * EAGAIN  - semop = 0 and timeout happens
  * EAGAIN  - semop = -1 and timeout happens
+ * EFAULT  - invalid timeout pointer
  *
  * Copyright (c) International Business Machines  Corp., 2001
  *	03/2001 - Written by Wayne Boyer
@@ -33,6 +34,7 @@ static int bad_sem_id = -1;
 static short sem_op_max, sem_op_1 = 1, sem_op_negative = -1, sem_op_zero = 0;
 static struct sembuf *faulty_buf;
 static struct tst_ts timeout;
+static struct tst_ts *valid_to = &timeout, *invalid_to;
 
 #define NSOPS	1
 #define	BIGOPS	1024
@@ -47,20 +49,22 @@ static struct test_case_t {
 	short sem_flg;
 	unsigned t_ops;
 	int arr_val;
+	struct tst_ts **to;
 	int error;
 } tc[] = {
-	{1, &valid_sem_id, NULL, &sem_op_1, 0, 0, 0, BIGOPS, 1, E2BIG},
-	{1, &noperm_sem_id, NULL, &sem_op_1, 0, 0, 0, NSOPS, 1, EACCES},
-	{1, &valid_sem_id, &faulty_buf, &sem_op_1, 0, 0, 0, NSOPS, 1, EFAULT},
-	{1, &valid_sem_id, NULL, &sem_op_1, 0, 0, 0, 0, 1, EINVAL},
-	{1, &bad_sem_id, NULL, &sem_op_1, 0, 0, 0, NSOPS, 1, EINVAL},
-	{1, &valid_sem_id, NULL, &sem_op_max, 0, 0, 0, 1, 1, ERANGE},
-	{1, &valid_sem_id, NULL, &sem_op_1, 0, -1, SEM_UNDO, 1, 1, EFBIG},
-	{1, &valid_sem_id, NULL, &sem_op_1, 0, PSEMS + 1, SEM_UNDO, 1, 1, EFBIG},
-	{1, &valid_sem_id, NULL, &sem_op_zero, 2, 2, IPC_NOWAIT, 1, 1, EAGAIN},
-	{1, &valid_sem_id, NULL, &sem_op_negative, 2, 2, IPC_NOWAIT, 1, 0, EAGAIN},
-	{0, &valid_sem_id, NULL, &sem_op_zero, 0, 0, SEM_UNDO, 1, 1, EAGAIN},
-	{0, &valid_sem_id, NULL, &sem_op_negative, 0, 0, SEM_UNDO, 1, 0, EAGAIN},
+	{1, &valid_sem_id, NULL, &sem_op_1, 0, 0, 0, BIGOPS, 1, &valid_to, E2BIG},
+	{1, &noperm_sem_id, NULL, &sem_op_1, 0, 0, 0, NSOPS, 1, &valid_to, EACCES},
+	{1, &valid_sem_id, &faulty_buf, &sem_op_1, 0, 0, 0, NSOPS, 1, &valid_to, EFAULT},
+	{1, &valid_sem_id, NULL, &sem_op_1, 0, 0, 0, 0, 1, &valid_to, EINVAL},
+	{1, &bad_sem_id, NULL, &sem_op_1, 0, 0, 0, NSOPS, 1, &valid_to, EINVAL},
+	{1, &valid_sem_id, NULL, &sem_op_max, 0, 0, 0, 1, 1, &valid_to, ERANGE},
+	{1, &valid_sem_id, NULL, &sem_op_1, 0, -1, SEM_UNDO, 1, 1, &valid_to, EFBIG},
+	{1, &valid_sem_id, NULL, &sem_op_1, 0, PSEMS + 1, SEM_UNDO, 1, 1, &valid_to, EFBIG},
+	{1, &valid_sem_id, NULL, &sem_op_zero, 2, 2, IPC_NOWAIT, 1, 1, &valid_to, EAGAIN},
+	{1, &valid_sem_id, NULL, &sem_op_negative, 2, 2, IPC_NOWAIT, 1, 0, &valid_to, EAGAIN},
+	{0, &valid_sem_id, NULL, &sem_op_zero, 0, 0, SEM_UNDO, 1, 1, &valid_to, EAGAIN},
+	{0, &valid_sem_id, NULL, &sem_op_negative, 0, 0, SEM_UNDO, 1, 0, &valid_to, EAGAIN},
+	{0, &valid_sem_id, NULL, &sem_op_zero, 0, 0, SEM_UNDO, 1, 1, &invalid_to, EFAULT},
 };
 
 static void setup(void)
@@ -70,6 +74,7 @@ static void setup(void)
 	key_t semkey;
 	union semun arr;
 	struct seminfo ipc_buf;
+	void *faulty_address;
 
 	tst_res(TINFO, "Testing variant: %s", tv->desc);
 	semop_supported_by_kernel(tv);
@@ -98,7 +103,9 @@ static void setup(void)
 		tst_brk(TBROK | TERRNO, "semctl() IPC_INFO failed");
 
 	sem_op_max = ipc_buf.semvmx;
-	faulty_buf = tst_get_bad_addr(NULL);
+	faulty_address = tst_get_bad_addr(NULL);
+	invalid_to = faulty_address;
+	faulty_buf = faulty_address;
 }
 
 static void run(unsigned int i)
@@ -111,6 +118,7 @@ static void run(unsigned int i)
 		.sem_num = tc[i].sem_num,
 	};
 	struct sembuf *ptr = &buf;
+	void *to;
 
 	if (!tc[i].all_variants && tv->semop == semop) {
 		tst_res(TCONF, "Test not supported for variant");
@@ -125,7 +133,12 @@ static void run(unsigned int i)
 	if (tc[i].buf)
 		ptr = *tc[i].buf;
 
-	TEST(call_semop(tv, *(tc[i].semid), ptr, tc[i].t_ops, tst_ts_get(&timeout)));
+	if (*tc[i].to == invalid_to)
+		to = invalid_to;
+	else
+		to = tst_ts_get(*tc[i].to);
+
+	TEST(call_semop(tv, *(tc[i].semid), ptr, tc[i].t_ops, to));
 
 	if (TST_RET != -1) {
 		tst_res(TFAIL | TTERRNO, "call succeeded unexpectedly");
-- 
2.25.0.rc1.19.g042ed3e048af

