From: Sandeep Patil <sspatil@google.com>
Date: Wed,  8 Nov 2017 16:34:34 -0800
Subject: [LTP] [PATCH 2/6] mm: mallocstress: use safe macros wherever
	possible
In-Reply-To: <20171109003438.130802-1-sspatil@google.com>
References: <20171109003438.130802-1-sspatil@google.com>
Message-ID: <20171109003438.130802-3-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The test is currently doesn't use the test library at all and instead
is a standlone program. While the conversion is being done, there is no
reason why the program can't use SAFE_ macros. Make necessary changes
to the program for the same, reducing the error check paths a lot.

Signed-off-by: Sandeep Patil <sspatil@google.com>
---
 testcases/kernel/mem/mtest07/mallocstress.c | 75 ++++++++++++++---------------
 1 file changed, 35 insertions(+), 40 deletions(-)

diff --git a/testcases/kernel/mem/mtest07/mallocstress.c b/testcases/kernel/mem/mtest07/mallocstress.c
index 9588fb495..78d8ace8a 100644
--- a/testcases/kernel/mem/mtest07/mallocstress.c
+++ b/testcases/kernel/mem/mtest07/mallocstress.c
@@ -73,6 +73,10 @@
 #include <sys/ipc.h>
 #include <sys/sem.h>
 
+#include "test.h"
+#include "safe_macros.h"
+#include "tst_safe_pthread.h"
+
 #define MAXL    100		/* default number of loops to do malloc and free      */
 #define MAXT     60		/* default number of threads to create.               */
 
@@ -90,6 +94,8 @@
 
 int num_loop = MAXL;		/* number of loops to perform                     */
 int semid;
+pthread_t *thrdid;		/* the threads */
+int ret;			/* program return value, used by main thread */
 
 /* Define SPEW_SIGNALS to tickle thread_create bug (it fails if interrupted). */
 #define SPEW_SIGNALS
@@ -272,6 +278,22 @@ void *alloc_mem(void *threadnum)
 	return (void *)(uintptr_t) (err ? -1 : 0);
 }
 
+/* only ever called from main thread */
+static void cleanup(void)
+{
+	if (semid > 0) {
+		if (semctl(semid, 0, IPC_RMID) == -1) {
+			perror("semctl\n");
+			ret = -1;
+		}
+	}
+
+	if (thrdid) {
+		free(thrdid);
+		thrdid = NULL;
+	}
+}
+
 /******************************************************************************/
 /*								 	      */
 /* Function:	main							      */
@@ -294,10 +316,8 @@ int main(int argc,		/* number of input parameters                 */
 	int c;			/* command line options                       */
 	int num_thrd = MAXT;	/* number of threads to create                */
 	int thrd_ndx;		/* index into the array of thread ids         */
-	pthread_t *thrdid;	/* the threads                                */
 	extern int optopt;	/* options to the program                     */
 	struct sembuf sop[1];
-	int ret = 0;
 
 	while ((c = getopt(argc, argv, "hl:t:")) != -1) {
 		switch (c) {
@@ -330,15 +350,13 @@ int main(int argc,		/* number of input parameters                 */
 
 	dprt(("number of times to loop in the thread = %d\n", num_loop));
 
-	thrdid = malloc(sizeof(pthread_t) * num_thrd);
-	if (thrdid == NULL) {
-		perror("main(): allocating space for thrdid[] malloc()");
-		return 1;
-	}
+	thrdid = SAFE_MALLOC(cleanup, sizeof(pthread_t) * num_thrd);
 
 	semid = semget(IPC_PRIVATE, 1, IPC_CREAT | 0666);
 	if (semid < 0) {
 		perror("Semaphore creation failed  Reason:");
+		ret = -1;
+		goto out;
 	}
 
 	sop[0].sem_num = 0;
@@ -351,19 +369,8 @@ int main(int argc,		/* number of input parameters                 */
 	}
 
 	for (thrd_ndx = 0; thrd_ndx < num_thrd; thrd_ndx++) {
-		if (pthread_create(&thrdid[thrd_ndx], NULL, alloc_mem,
-				   (void *)(uintptr_t) thrd_ndx)) {
-			int err = errno;
-			if (err == EINTR) {
-				fprintf(stderr,
-					"main(): pthread_create failed with EINTR!\n");
-				ret = -1;
-				goto out;
-			}
-			perror("main(): pthread_create()");
-			ret = -11;
-			goto out;
-		}
+		SAFE_PTHREAD_CREATE(&thrdid[thrd_ndx], NULL, alloc_mem,
+				    (void *)(uintptr_t)thrd_ndx);
 	}
 	my_yield();
 
@@ -376,32 +383,20 @@ int main(int argc,		/* number of input parameters                 */
 
 	for (thrd_ndx = 0; thrd_ndx < num_thrd; thrd_ndx++) {
 		void *th_status;	/* exit status of LWP */
-		if (pthread_join(thrdid[thrd_ndx], &th_status) != 0) {
-			perror("main(): pthread_join()");
+		SAFE_PTHREAD_JOIN(thrdid[thrd_ndx], &th_status);
+		if ((intptr_t)th_status != 0) {
+			fprintf(stderr,
+				"%s: thread [%d] - exited with errors\n",
+				__func__, thrd_ndx);
 			ret = -1;
 			goto out;
-		} else {
-			if ((intptr_t) th_status != 0) {
-				fprintf(stderr,
-					"main(): thread [%d] - exited with errors\n",
-					thrd_ndx);
-				ret = -1;
-				goto out;
-			}
-			dprt(("main(): thread [%d]: exited without errors\n",
-			      thrd_ndx));
 		}
+		dprt(("%s: thread [%d]: exited without errors\n",
+		      __func__, thrd_ndx));
 		my_yield();
 	}
 	printf("main(): test passed.\n");
 out:
-	if (semctl(semid, 0, IPC_RMID) == -1) {
-		perror("semctl\n");
-		ret = -1;
-	}
-	if (thrdid) {
-		free(thrdid);
-		thrdid = NULL;
-	}
+	cleanup();
 	exit(ret);
 }
-- 
2.15.0.448.gf294e3d99a-goog

