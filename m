From: Sandeep Patil <sspatil@google.com>
Date: Mon, 13 Nov 2017 18:11:17 -0800
Subject: [LTP] [PATCH v2 3/4] mm: mallocstress: use futexes instead of SysV
	semaphores
In-Reply-To: <20171114021118.103786-1-sspatil@google.com>
References: <20171114021118.103786-1-sspatil@google.com>
Message-ID: <20171114021118.103786-4-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Start using TST_CHECKPOINT_WAIT/WAKE macros that are based on futexes
instead of SysV semaphore. This allows the test to build and run on an
Android system.

Signed-off-by: Sandeep Patil <sspatil@google.com>
---

v1->v2
------
 - use the correct SAFE_ macros (that don't require cleanup functions)

 testcases/kernel/mem/mtest07/mallocstress.c | 59 +++++++----------------------
 1 file changed, 14 insertions(+), 45 deletions(-)

diff --git a/testcases/kernel/mem/mtest07/mallocstress.c b/testcases/kernel/mem/mtest07/mallocstress.c
index 0f495a6b3..63df7c70e 100644
--- a/testcases/kernel/mem/mtest07/mallocstress.c
+++ b/testcases/kernel/mem/mtest07/mallocstress.c
@@ -192,20 +192,10 @@ int allocate_free(int scheme)
 
 void *alloc_mem(void *threadnum)
 {
-	struct sembuf sop[1];
 	int err;
 
 	/* waiting for other threads starting */
-	sop[0].sem_num = 0;
-	sop[0].sem_op = 0;
-	sop[0].sem_flg = 0;
-	TEST(semop(semid, sop, 1));
-	if (TEST_RETURN == -1 && TEST_ERRNO != EIDRM) {
-		tst_res(TBROK | TTERRNO,
-			"Thread [%d] failed to wait on semaphore",
-			(int)(uintptr_t)threadnum);
-		return (void *)-1;
-	}
+	TST_CHECKPOINT_WAIT(0);
 
 	/* thread N will use growth scheme N mod 4 */
 	err = allocate_free(((uintptr_t)threadnum) % 4);
@@ -216,19 +206,21 @@ void *alloc_mem(void *threadnum)
 	return (void *)(uintptr_t) (err ? -1 : 0);
 }
 
+static void cleanup(void)
+{
+	if (thread_id) {
+		free(thread_id);
+		thread_id = NULL;
+	}
+}
+
 static void stress_malloc(unsigned int n)
 {
-	struct sembuf sop[1];
 	int thread_index;
-
 	(void)n;
-	/* kick off all the waiting threads */
-	sop[0].sem_num = 0;
-	sop[0].sem_op = -1;
-	sop[0].sem_flg = 0;
-	TEST(semop(semid, sop, 1));
-	if (TEST_RETURN == -1)
-		tst_res(TBROK | TTERRNO, "Failed to wakeup all threads");
+
+	/* Wake up all threads */
+	TST_CHECKPOINT_WAKE2(0, NUM_THREADS);
 
 	/* wait for all threads to finish */
 	for (thread_index = 0; thread_index < NUM_THREADS; thread_index++) {
@@ -246,21 +238,11 @@ static void stress_malloc(unsigned int n)
 
 static void setup(void)
 {
-	struct sembuf sop[1];
 	int thread_index;
 
 	thread_id = SAFE_MALLOC(sizeof(pthread_t) * NUM_THREADS);
 
-	semid = semget(IPC_PRIVATE, 1, IPC_CREAT | 0666);
-	if (semid < 0)
-		tst_res(TBROK | TTERRNO, "Semaphore creation failed");
-
-	sop[0].sem_num = 0;
-	sop[0].sem_op = 1;
-	sop[0].sem_flg = 0;
-	TEST(semop(semid, sop, 1));
-	if (TEST_RETURN == -1)
-		tst_res(TBROK | TTERRNO, "Failed to initialize semaphore");
+	TST_CHECKPOINT_INIT();
 
 	for (thread_index = 0; thread_index < NUM_THREADS; thread_index++) {
 		SAFE_PTHREAD_CREATE(&thread_id[thread_index], NULL, alloc_mem,
@@ -268,22 +250,9 @@ static void setup(void)
 	}
 }
 
-static void cleanup(void)
-{
-	if (semid > 0) {
-		TEST(semctl(semid, 0, IPC_RMID));
-		if (TEST_RETURN == -1)
-			tst_res(TWARN, "Failed to destroy semaphore");
-	}
-
-	if (thread_id) {
-		free(thread_id);
-		thread_id = NULL;
-	}
-}
-
 static struct tst_test test = {
 	.tcnt = 1,
+	.needs_tmpdir = 1,
 	.cleanup = cleanup,
 	.setup = setup,
 	.test = stress_malloc,
-- 
2.15.0.448.gf294e3d99a-goog

