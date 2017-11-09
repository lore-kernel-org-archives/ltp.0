From: Sandeep Patil <sspatil@google.com>
Date: Wed,  8 Nov 2017 16:34:35 -0800
Subject: [LTP] [PATCH 3/6] mm: mallocstress: use futexes instead of SysV
	semaphores
In-Reply-To: <20171109003438.130802-1-sspatil@google.com>
References: <20171109003438.130802-1-sspatil@google.com>
Message-ID: <20171109003438.130802-4-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Start using TST_SAFE_CHECKPOINT_WAIT/WAKE macros that are based
on futexes instead of SysV semaphore. This allows the test to build
and run on an Android system.

Signed-off-by: Sandeep Patil <sspatil@google.com>
---
 testcases/kernel/mem/mtest07/mallocstress.c | 44 ++++-------------------------
 1 file changed, 5 insertions(+), 39 deletions(-)

diff --git a/testcases/kernel/mem/mtest07/mallocstress.c b/testcases/kernel/mem/mtest07/mallocstress.c
index 78d8ace8a..7e283af87 100644
--- a/testcases/kernel/mem/mtest07/mallocstress.c
+++ b/testcases/kernel/mem/mtest07/mallocstress.c
@@ -93,7 +93,6 @@
                                    } while (0)
 
 int num_loop = MAXL;		/* number of loops to perform                     */
-int semid;
 pthread_t *thrdid;		/* the threads */
 int ret;			/* program return value, used by main thread */
 
@@ -258,16 +257,8 @@ int allocate_free(int repeat,	/* number of times to repeat allocate/free    */
 /******************************************************************************/
 void *alloc_mem(void *threadnum)
 {
-	struct sembuf sop[1];
-	sop[0].sem_num = 0;
-	sop[0].sem_op = 0;
-	sop[0].sem_flg = 0;
 	/* waiting for other threads starting */
-	if (semop(semid, sop, 1) == -1) {
-		if (errno != EIDRM)
-			perror("semop");
-		return (void *)-1;
-	}
+	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
 
 	/* thread N will use growth scheme N mod 4 */
 	int err = allocate_free(num_loop, ((uintptr_t) threadnum) % 4);
@@ -281,13 +272,6 @@ void *alloc_mem(void *threadnum)
 /* only ever called from main thread */
 static void cleanup(void)
 {
-	if (semid > 0) {
-		if (semctl(semid, 0, IPC_RMID) == -1) {
-			perror("semctl\n");
-			ret = -1;
-		}
-	}
-
 	if (thrdid) {
 		free(thrdid);
 		thrdid = NULL;
@@ -351,22 +335,8 @@ int main(int argc,		/* number of input parameters                 */
 	dprt(("number of times to loop in the thread = %d\n", num_loop));
 
 	thrdid = SAFE_MALLOC(cleanup, sizeof(pthread_t) * num_thrd);
-
-	semid = semget(IPC_PRIVATE, 1, IPC_CREAT | 0666);
-	if (semid < 0) {
-		perror("Semaphore creation failed  Reason:");
-		ret = -1;
-		goto out;
-	}
-
-	sop[0].sem_num = 0;
-	sop[0].sem_op = 1;
-	sop[0].sem_flg = 0;
-	if (semop(semid, sop, 1) == -1) {
-		perror("semop");
-		ret = -1;
-		goto out;
-	}
+	tst_tmpdir();
+	TST_CHECKPOINT_INIT(cleanup);
 
 	for (thrd_ndx = 0; thrd_ndx < num_thrd; thrd_ndx++) {
 		SAFE_PTHREAD_CREATE(&thrdid[thrd_ndx], NULL, alloc_mem,
@@ -374,12 +344,8 @@ int main(int argc,		/* number of input parameters                 */
 	}
 	my_yield();
 
-	sop[0].sem_op = -1;
-	if (semop(semid, sop, 1) == -1) {
-		perror("semop");
-		ret = -1;
-		goto out;
-	}
+	/* Wake up all threads */
+	TST_SAFE_CHECKPOINT_WAKE2(cleanup, 0, num_thrd);
 
 	for (thrd_ndx = 0; thrd_ndx < num_thrd; thrd_ndx++) {
 		void *th_status;	/* exit status of LWP */
-- 
2.15.0.448.gf294e3d99a-goog

