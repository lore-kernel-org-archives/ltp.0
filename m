From: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue, 24 Sep 2019 13:44:12 +0200
Subject: [LTP] [PATCH v2] shm_test: Fix parameter passing to threads
Message-ID: <20190924114412.61462-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

The arguments to all threads were passed using a pointer to the same memory.
So they all point to the same data, that is overriden by the main thread
to prepare it for the next thread.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 testcases/kernel/mem/mtest07/shm_test.c | 70 ++++++++++++-------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/testcases/kernel/mem/mtest07/shm_test.c b/testcases/kernel/mem/mtest07/shm_test.c
index de91b7427..852c51b43 100644
--- a/testcases/kernel/mem/mtest07/shm_test.c
+++ b/testcases/kernel/mem/mtest07/shm_test.c
@@ -81,8 +81,16 @@ void noprintf(char *string, ...)
 
 #define MAXT	30		/* default number of threads to create.               */
 #define MAXR	1000		/* default number of repatetions to execute           */
-#define WRITER  0		/* cause thread function to shmat and write           */
-#define READER  1		/* cause thread function to shmat and read            */
+
+struct child_args
+{
+	pthread_t threadid;
+	int num_reps;
+	int shmkey;
+	int map_size;
+	int isReader;
+};
+
 
 /******************************************************************************/
 /*								 	      */
@@ -166,28 +174,25 @@ static int rm_shared_mem(key_t shm_id,	/* id of shared memory segment to be remo
 /* Return:	exits with -1 on error, 0 on success                          */
 /*									      */
 /******************************************************************************/
-static void *shmat_rd_wr(void *args)
+static void *shmat_rd_wr(void *vargs)
 {				/* arguments to the thread function             */
 	int shmndx = 0;		/* index to the number of attach and detach   */
 	int index = 0;		/* index to the number of blocks touched      */
-	int reader = 0;		/* this thread is a reader thread if set to 1 */
 	key_t shm_id = 0;	/* shared memory id                           */
-	long *locargs =		/* local pointer to arguments                 */
-	    (long *)args;
+	struct child_args *args = (struct child_args *)vargs;
 	volatile int exit_val = 0;	/* exit value of the pthread                  */
 	char *read_from_mem;	/* ptr to touch each (4096) block in memory   */
 	char *write_to_mem;	/* ptr to touch each (4096) block in memory   */
 	char *shmat_addr;	/* address of the attached memory             */
 	char buff;		/* temporary buffer                           */
 
-	reader = (int)locargs[3];
-	while (shmndx++ < (int)locargs[0]) {
+	while (shmndx++ < args->num_reps) {
 		dprt("pid[%d]: shmat_rd_wr(): locargs[1] = %#x\n",
-		     getpid(), (int)locargs[1]);
+		     getpid(), args->shmkey);
 
 		/* get shared memory id */
 		if ((shm_id =
-		     shmget((int)locargs[1], (int)locargs[2], IPC_CREAT | 0666))
+		     shmget(args->shmkey, args->map_size, IPC_CREAT | 0666))
 		    == -1) {
 			dprt("pid[%d]: shmat_rd_wr(): shmget failed\n",
 			     getpid());
@@ -213,11 +218,11 @@ static void *shmat_rd_wr(void *args)
 			"pid[%d]: do_shmat_shmadt(): got shmat address = %#lx\n",
 			getpid(), (long)shmat_addr);
 
-		if (!reader) {
+		if (args->isReader) {
 			/* write character 'Y' to that memory area */
 			index = 0;
 			write_to_mem = shmat_addr;
-			while (index < (int)locargs[2]) {
+			while (index < args->num_reps) {
 				dprt("pid[%d]: do_shmat_shmatd(): write_to_mem = %#x\n", getpid(), write_to_mem);
 				*write_to_mem = 'Y';
 				index++;
@@ -228,7 +233,7 @@ static void *shmat_rd_wr(void *args)
 			/* read from the memory area */
 			index = 0;
 			read_from_mem = shmat_addr;
-			while (index < (int)locargs[2]) {
+			while (index < args->num_reps) {
 				buff = *read_from_mem;
 				index++;
 				read_from_mem++;
@@ -272,12 +277,11 @@ int main(int argc,		/* number of input parameters                 */
 	int c;			/* command line options                       */
 	int num_thrd = MAXT;	/* number of threads to create                */
 	int num_reps = MAXR;	/* number of repatitions the test is run      */
-	int thrd_ndx;		/* index into the array of thread ids         */
+	int i;
 	void *th_status;	/* exit status of LWP's                       */
 	int map_size;		/* size of the file mapped.                   */
 	int shmkey = 1969;	/* key used to generate shmid by shmget()     */
-	pthread_t thrdid[30];	/* maxinum of 30 threads allowed              */
-	long chld_args[4];	/* arguments to the thread function           */
+	struct child_args chld_args[30];	/* arguments to the thread function */
 	char *map_address = NULL;
 	/* address in memory of the mapped file       */
 	extern int optopt;	/* options to the program                     */
@@ -299,7 +303,7 @@ int main(int argc,		/* number of input parameters                 */
 		case 't':
 			if ((num_thrd = atoi(optarg)) == 0)
 				OPT_MISSING(argv[0], optopt);
-			else if (num_thrd < 0) {
+			else if (num_thrd < 0 || num_thrd > MAXT) {
 				fprintf(stdout,
 					"WARNING: bad argument. Using default\n");
 				num_thrd = MAXT;
@@ -311,31 +315,27 @@ int main(int argc,		/* number of input parameters                 */
 		}
 	}
 
-	chld_args[0] = num_reps;
-
-	for (thrd_ndx = 0; thrd_ndx < num_thrd; thrd_ndx += 2) {
+	for (i = 0; i < num_thrd; i += 2) {
 		srand(time(NULL) % 100);
-		map_size =
-		    (1 + (int)(1000.0 * rand() / (RAND_MAX + 1.0))) * 4096;
-
-		chld_args[1] = shmkey++;
-		chld_args[2] = map_size;
+		map_size = (1 + (int)(1000.0 * rand() / (RAND_MAX + 1.0))) * 4096;
 
 		dprt("main(): thrd_ndx = %d map_address = %#x map_size = %d\n",
-		     thrd_ndx, map_address, map_size);
-
-		chld_args[3] = WRITER;
+		     i, map_address, map_size);
 
+		chld_args[i].num_reps = num_reps;
+		chld_args[i].map_size = map_size;
+		chld_args[i].shmkey = shmkey++;
+		chld_args[i].isReader = 0;
 		if (pthread_create
-		    (&thrdid[thrd_ndx], NULL, shmat_rd_wr, chld_args)) {
+		    (&chld_args[i].threadid, NULL, shmat_rd_wr, &chld_args[i])) {
 			perror("shmat_rd_wr(): pthread_create()");
 			exit(-1);
 		}
 
-		chld_args[3] = READER;
-
+		chld_args[i + 1] = chld_args[i];
+		chld_args[i + 1].isReader = 1;
 		if (pthread_create
-		    (&thrdid[thrd_ndx + 1], NULL, shmat_rd_wr, chld_args)) {
+		    (&chld_args[i + 1].threadid, NULL, shmat_rd_wr, &chld_args[i + 1])) {
 			perror("shmat_rd_wr(): pthread_create()");
 			exit(-1);
 		}
@@ -343,8 +343,8 @@ int main(int argc,		/* number of input parameters                 */
 
 	sync();
 
-	for (thrd_ndx = 0; thrd_ndx < num_thrd; thrd_ndx++) {
-		if (pthread_join(thrdid[thrd_ndx], &th_status) != 0) {
+	for (i = 0; i < num_thrd; i++) {
+		if (pthread_join(chld_args[i].threadid, &th_status) != 0) {
 			perror("shmat_rd_wr(): pthread_join()");
 			exit(-1);
 		} else {
@@ -352,7 +352,7 @@ int main(int argc,		/* number of input parameters                 */
 			if (th_status == (void *)-1) {
 				fprintf(stderr,
 					"thread [%ld] - process exited with errors\n",
-					(long)thrdid[thrd_ndx]);
+					(long)chld_args[i].threadid);
 				exit(-1);
 			}
 		}
-- 
2.20.1

