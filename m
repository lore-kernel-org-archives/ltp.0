From: Sandeep Patil <sspatil@google.com>
Date: Mon, 13 Nov 2017 18:11:15 -0800
Subject: [LTP] [PATCH v2 1/4] mm: mallocstress: use new library and safe
	macros
In-Reply-To: <20171114021118.103786-1-sspatil@google.com>
References: <20171114021118.103786-1-sspatil@google.com>
Message-ID: <20171114021118.103786-2-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Make necessary changes to the test to start using the new ltp library
api instead of being a standalong program.  Use appropriate SAFE_ macros
in the process to reduce the error check paths.

Signed-off-by: Sandeep Patil <sspatil@google.com>
---
v1->v2
------
- Refactored test to use new library as suggested by Jan and then use the appropriate
  safe macros that do not need cleanup functions


 testcases/kernel/mem/mtest07/mallocstress.c | 317 +++++++++-------------------
 1 file changed, 100 insertions(+), 217 deletions(-)

diff --git a/testcases/kernel/mem/mtest07/mallocstress.c b/testcases/kernel/mem/mtest07/mallocstress.c
index 9588fb495..0f495a6b3 100644
--- a/testcases/kernel/mem/mtest07/mallocstress.c
+++ b/testcases/kernel/mem/mtest07/mallocstress.c
@@ -73,36 +73,22 @@
 #include <sys/ipc.h>
 #include <sys/sem.h>
 
-#define MAXL    100		/* default number of loops to do malloc and free      */
-#define MAXT     60		/* default number of threads to create.               */
+#include "tst_test.h"
+#include "tst_safe_pthread.h"
 
-#ifdef DEBUG
-#define dprt(args)	printf args
-#else
-#define dprt(args)
-#endif
+/* Number of loops per-thread */
+#define NUM_LOOPS	100
 
-#define OPT_MISSING(prog, opt)   do{\
-			       fprintf(stderr, "%s: option -%c ", prog, opt); \
-                               fprintf(stderr, "requires an argument\n"); \
-                               usage(prog); \
-                                   } while (0)
-
-int num_loop = MAXL;		/* number of loops to perform                     */
-int semid;
+/* Number of threads to create */
+#define NUM_THREADS     60
 
 /* Define SPEW_SIGNALS to tickle thread_create bug (it fails if interrupted). */
 #define SPEW_SIGNALS
 
-/******************************************************************************/
-/*								 	      */
-/* Function:	my_yield						      */
-/*									      */
-/* Description:	Yield control to another thread.                              */
-/*              Generate a signal, too.                                       */
-/*									      */
-/******************************************************************************/
-static void my_yield()
+static pthread_t *thread_id;	/* Spawned thread */
+int semid;
+
+static void my_yield(void)
 {
 #ifdef SPEW_SIGNALS
 	/* usleep just happens to use signals in glibc at moment.
@@ -119,60 +105,32 @@ static void my_yield()
 #endif
 }
 
-/******************************************************************************/
-/*								 	      */
-/* Function:	usage							      */
-/*									      */
-/* Description:	Print the usage message.				      */
-/*									      */
-/* Input:	char *progname - name of this program                         */
-/*									      */
-/* Return:	exits with -1						      */
-/*									      */
-/******************************************************************************/
-static void usage(char *progname)
-{				/* name of this program                       */
-	fprintf(stderr,
-		"Usage: %s -d NUMDIR -f NUMFILES -h -t NUMTHRD\n"
-		"\t -h Help!\n"
-		"\t -l Number of loops:               Default: 1000\n"
-		"\t -t Number of threads to generate: Default: 30\n", progname);
-	exit(-1);
-}
-
-/******************************************************************************/
-/* Function:	allocate_free				                      */
-/*								              */
-/* Description:	This function does the allocation and free by calling malloc  */
-/*		and free fuctions. The size of the memory to be malloced is   */
-/*		determined by the caller of this function. The size can be    */
-/*		a number from the fibannoaci series, power of 2 or 3 or 5     */
-/*									      */
-/* Input:	int repeat - number of times the alloc/free is repeated.      */
-/*		int scheme  - 0 to 3; selects how fast memory size grows      */
-/*								              */
-/* Return:	1 on failure						      */
-/*		0 on success						      */
-/******************************************************************************/
-int allocate_free(int repeat,	/* number of times to repeat allocate/free    */
-		  int scheme)
-{				/* how fast to increase block size            */
+/*
+ * allocate_free() - Allocate and free test called per-thread
+ *
+ * @scheme: 0-3; selects how fast memory size grows
+ *
+ * This function does the allocation and free by calling malloc
+ * and free functions. The size of the memory to be malloced is
+ * determined by the caller of this function. The size can be
+ * a number from the fibannoaci series, power of 2 or 3 or 5
+ *
+ * Return:
+ *  0: success
+ *  1: failure
+ */
+int allocate_free(int scheme)
+{
 	int loop;
 	const int MAXPTRS = 50;	/* only 42 or so get used on 32 bit machine */
 
-	dprt(("pid[%d]: allocate_free: repeat %d, scheme %d\n", getpid(),
-	      repeat, scheme));
-
-	for (loop = 0; loop < repeat; loop++) {
-		size_t oldsize = 5;	/* remember size for fibannoci series     */
-		size_t size = sizeof(long);	/* size of next block in ptrs[]           */
-		long *ptrs[MAXPTRS];	/* the pointers allocated in this loop    */
-		int num_alloc;	/* number of elements in ptrs[] so far    */
+	for (loop = 0; loop < NUM_LOOPS; loop++) {
+		size_t oldsize = 5;
+		size_t size = sizeof(long);
+		long *ptrs[MAXPTRS];
+		int num_alloc;
 		int i;
 
-		dprt(("pid[%d]: allocate_free: loop %d of %d\n", getpid(), loop,
-		      repeat));
-
 		/* loop terminates in one of three ways:
 		 * 1. after MAXPTRS iterations
 		 * 2. if malloc fails
@@ -181,15 +139,11 @@ int allocate_free(int repeat,	/* number of times to repeat allocate/free    */
 		for (num_alloc = 0; num_alloc < MAXPTRS; num_alloc++) {
 			size_t newsize = 0;
 
-			dprt(("pid[%d]: loop %d/%d; num_alloc=%d; size=%u\n",
-			      getpid(), loop, repeat, num_alloc, size));
-
 			/* Malloc the next block */
 			ptrs[num_alloc] = malloc(size);
-			if (ptrs[num_alloc] == NULL) {
-				/* terminate loop if malloc couldn't give us the memory we asked for */
+			/* terminate loop if malloc fails */
+			if (!ptrs[num_alloc])
 				break;
-			}
 			ptrs[num_alloc][0] = num_alloc;
 
 			/* Increase size according to one of four schedules. */
@@ -219,10 +173,8 @@ int allocate_free(int repeat,	/* number of times to repeat allocate/free    */
 		}
 
 		for (i = 0; i < num_alloc; i++) {
-			dprt(("pid[%d]: freeing ptrs[i] %p\n", getpid(),
-			      ptrs[i]));
 			if (ptrs[i][0] != i) {
-				fprintf(stderr,
+				tst_res(TFAIL,
 					"pid[%d]: fail: bad sentinel value\n",
 					getpid());
 				return 1;
@@ -233,175 +185,106 @@ int allocate_free(int repeat,	/* number of times to repeat allocate/free    */
 
 		my_yield();
 	}
+
 	/* Success! */
 	return 0;
 }
 
-/******************************************************************************/
-/* Function:	alloc_mem				                      */
-/*								              */
-/* Description:	Decide how fast to increase block sizes, then call            */
-/*              allocate_free() to actually to the test.                      */
-/*								              */
-/* Input:	threadnum is the thread number, 0...N-1                       */
-/*              global num_loop is how many iterations to run                 */
-/*								              */
-/* Return:	pthread_exit -1	on failure				      */
-/*		pthread_exit  0 on success			              */
-/*								              */
-/******************************************************************************/
 void *alloc_mem(void *threadnum)
 {
 	struct sembuf sop[1];
+	int err;
+
+	/* waiting for other threads starting */
 	sop[0].sem_num = 0;
 	sop[0].sem_op = 0;
 	sop[0].sem_flg = 0;
-	/* waiting for other threads starting */
-	if (semop(semid, sop, 1) == -1) {
-		if (errno != EIDRM)
-			perror("semop");
+	TEST(semop(semid, sop, 1));
+	if (TEST_RETURN == -1 && TEST_ERRNO != EIDRM) {
+		tst_res(TBROK | TTERRNO,
+			"Thread [%d] failed to wait on semaphore",
+			(int)(uintptr_t)threadnum);
 		return (void *)-1;
 	}
 
 	/* thread N will use growth scheme N mod 4 */
-	int err = allocate_free(num_loop, ((uintptr_t) threadnum) % 4);
-	fprintf(stdout,
+	err = allocate_free(((uintptr_t)threadnum) % 4);
+	tst_res(TINFO,
 		"Thread [%d]: allocate_free() returned %d, %s.  Thread exiting.\n",
-		(int)(uintptr_t) threadnum, err,
+		(int)(uintptr_t)threadnum, err,
 		(err ? "failed" : "succeeded"));
 	return (void *)(uintptr_t) (err ? -1 : 0);
 }
 
-/******************************************************************************/
-/*								 	      */
-/* Function:	main							      */
-/*									      */
-/* Description:	This is the entry point to the program. This function will    */
-/*		parse the input arguments and set the values accordingly. If  */
-/*		no arguments (or desired) are provided default values are used*/
-/*		refer the usage function for the arguments that this program  */
-/*		takes. It also creates the threads which do most of the dirty */
-/*		work. If the threads exits with a value '0' the program exits */
-/*		with success '0' else it exits with failure '-1'.             */
-/*									      */
-/* Return:	-1 on failure						      */
-/*		 0 on success						      */
-/*									      */
-/******************************************************************************/
-int main(int argc,		/* number of input parameters                 */
-	 char **argv)
-{				/* pointer to the command line arguments.     */
-	int c;			/* command line options                       */
-	int num_thrd = MAXT;	/* number of threads to create                */
-	int thrd_ndx;		/* index into the array of thread ids         */
-	pthread_t *thrdid;	/* the threads                                */
-	extern int optopt;	/* options to the program                     */
+static void stress_malloc(unsigned int n)
+{
 	struct sembuf sop[1];
-	int ret = 0;
-
-	while ((c = getopt(argc, argv, "hl:t:")) != -1) {
-		switch (c) {
-		case 'h':
-			usage(argv[0]);
-			break;
-		case 'l':
-			if ((num_loop = atoi(optarg)) == 0)
-				OPT_MISSING(argv[0], optopt);
-			else if (num_loop < 1) {
-				fprintf(stdout,
-					"WARNING: bad argument. Using default\n");
-				num_loop = MAXL;
-			}
-			break;
-		case 't':
-			if ((num_thrd = atoi(optarg)) == 0)
-				OPT_MISSING(argv[0], optopt);
-			else if (num_thrd < 1) {
-				fprintf(stdout,
-					"WARNING: bad argument. Using default\n");
-				num_thrd = MAXT;
-			}
-			break;
-		default:
-			usage(argv[0]);
-			break;
+	int thread_index;
+
+	(void)n;
+	/* kick off all the waiting threads */
+	sop[0].sem_num = 0;
+	sop[0].sem_op = -1;
+	sop[0].sem_flg = 0;
+	TEST(semop(semid, sop, 1));
+	if (TEST_RETURN == -1)
+		tst_res(TBROK | TTERRNO, "Failed to wakeup all threads");
+
+	/* wait for all threads to finish */
+	for (thread_index = 0; thread_index < NUM_THREADS; thread_index++) {
+		void *status;
+
+		SAFE_PTHREAD_JOIN(thread_id[thread_index], &status);
+		if ((intptr_t)status != 0) {
+			tst_res(TFAIL, "thread [%d] - exited with errors\n",
+				thread_index);
 		}
 	}
 
-	dprt(("number of times to loop in the thread = %d\n", num_loop));
+	tst_res(TPASS, "malloc stress test finished successfully");
+}
 
-	thrdid = malloc(sizeof(pthread_t) * num_thrd);
-	if (thrdid == NULL) {
-		perror("main(): allocating space for thrdid[] malloc()");
-		return 1;
-	}
+static void setup(void)
+{
+	struct sembuf sop[1];
+	int thread_index;
+
+	thread_id = SAFE_MALLOC(sizeof(pthread_t) * NUM_THREADS);
 
 	semid = semget(IPC_PRIVATE, 1, IPC_CREAT | 0666);
-	if (semid < 0) {
-		perror("Semaphore creation failed  Reason:");
-	}
+	if (semid < 0)
+		tst_res(TBROK | TTERRNO, "Semaphore creation failed");
 
 	sop[0].sem_num = 0;
 	sop[0].sem_op = 1;
 	sop[0].sem_flg = 0;
-	if (semop(semid, sop, 1) == -1) {
-		perror("semop");
-		ret = -1;
-		goto out;
-	}
+	TEST(semop(semid, sop, 1));
+	if (TEST_RETURN == -1)
+		tst_res(TBROK | TTERRNO, "Failed to initialize semaphore");
 
-	for (thrd_ndx = 0; thrd_ndx < num_thrd; thrd_ndx++) {
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
+	for (thread_index = 0; thread_index < NUM_THREADS; thread_index++) {
+		SAFE_PTHREAD_CREATE(&thread_id[thread_index], NULL, alloc_mem,
+				    (void *)(uintptr_t)thread_index);
 	}
-	my_yield();
+}
 
-	sop[0].sem_op = -1;
-	if (semop(semid, sop, 1) == -1) {
-		perror("semop");
-		ret = -1;
-		goto out;
+static void cleanup(void)
+{
+	if (semid > 0) {
+		TEST(semctl(semid, 0, IPC_RMID));
+		if (TEST_RETURN == -1)
+			tst_res(TWARN, "Failed to destroy semaphore");
 	}
 
-	for (thrd_ndx = 0; thrd_ndx < num_thrd; thrd_ndx++) {
-		void *th_status;	/* exit status of LWP */
-		if (pthread_join(thrdid[thrd_ndx], &th_status) != 0) {
-			perror("main(): pthread_join()");
-			ret = -1;
-			goto out;
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
-		}
-		my_yield();
-	}
-	printf("main(): test passed.\n");
-out:
-	if (semctl(semid, 0, IPC_RMID) == -1) {
-		perror("semctl\n");
-		ret = -1;
+	if (thread_id) {
+		free(thread_id);
+		thread_id = NULL;
 	}
-	if (thrdid) {
-		free(thrdid);
-		thrdid = NULL;
-	}
-	exit(ret);
 }
+
+static struct tst_test test = {
+	.tcnt = 1,
+	.cleanup = cleanup,
+	.setup = setup,
+	.test = stress_malloc,
+};
-- 
2.15.0.448.gf294e3d99a-goog

