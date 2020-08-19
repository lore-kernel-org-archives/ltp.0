From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 19 Aug 2020 17:57:46 +0530
Subject: [LTP] [PATCH V9 2/2] syscalls/semtimedop: Add failure test for
 invalid timeout pointer
In-Reply-To: <b0d7642a89808c93e059beda06d8519361784686.1597839878.git.viresh.kumar@linaro.org>
References: <b0d7642a89808c93e059beda06d8519361784686.1597839878.git.viresh.kumar@linaro.org>
Message-ID: <a9e6d98c722a92d1981fcc2b7ddeba547195c40e.1597839878.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds test for invalid timeout pointer.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

---
Cyril: This doesn't work as expected and results in the crash of the
executable. I am not sure what's going on here though.
---
 testcases/kernel/syscalls/ipc/semop/semop02.c | 34 +++++++++++--------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/semop/semop02.c b/testcases/kernel/syscalls/ipc/semop/semop02.c
index d0fed5321502..bf362d1edcc9 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop02.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop02.c
@@ -31,6 +31,7 @@ static int bad_sem_id = -1;
 static short sem_op_max, sem_op_1 = 1, sem_op_negative = -1, sem_op_zero = 0;
 static struct sembuf *faulty_buf;
 static struct tst_ts timeout;
+static struct tst_ts *valid_to = &timeout, *invalid_to;
 
 #define NSOPS	1
 #define	BIGOPS	1024
@@ -45,20 +46,22 @@ static struct test_case_t {
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
@@ -68,6 +71,7 @@ static void setup(void)
 	key_t semkey;
 	union semun arr;
 	struct seminfo ipc_buf;
+	void *faulty_address;
 
 	tst_res(TINFO, "Testing variant: %s", tv->desc);
 	semop_supported_by_kernel(tv);
@@ -96,7 +100,9 @@ static void setup(void)
 		tst_brk(TBROK | TERRNO, "semctl() IPC_INFO failed");
 
 	sem_op_max = ipc_buf.semvmx;
-	faulty_buf = tst_get_bad_addr(NULL);
+	faulty_address = tst_get_bad_addr(NULL);
+	invalid_to = faulty_address;
+	faulty_buf = faulty_address;
 }
 
 static void run(unsigned int i)
@@ -123,7 +129,7 @@ static void run(unsigned int i)
 	if (tc[i].buf)
 		ptr = *tc[i].buf;
 
-	TEST(call_semop(tv, *(tc[i].semid), ptr, tc[i].t_ops, &timeout));
+	TEST(call_semop(tv, *(tc[i].semid), ptr, tc[i].t_ops, *tc[i].to));
 
 	if (TST_RET != -1) {
 		tst_res(TFAIL | TTERRNO, "call succeeded unexpectedly");
-- 
2.25.0.rc1.19.g042ed3e048af

