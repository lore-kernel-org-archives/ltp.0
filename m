From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 22 Mar 2017 17:45:16 +0100
Subject: [LTP] [COMMITTED] [PATCH] mmstress: Cleanup && make use of
	tst_tmpdir
Message-ID: <20170322164516.20045-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Get rid of useless comments

* Simplify the code, so that alarm() sets only flag
  instead of exitting the test (so that we can cleanup
  the test temporary directory if -t parameter was passed)

* Make use of tst_tmpdir(), this fixes #87

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/mem/mtest05/mmstress.c | 494 +++++++++-----------------------
 1 file changed, 133 insertions(+), 361 deletions(-)

diff --git a/testcases/kernel/mem/mtest05/mmstress.c b/testcases/kernel/mem/mtest05/mmstress.c
index 0240a83..5f3897b 100644
--- a/testcases/kernel/mem/mtest05/mmstress.c
+++ b/testcases/kernel/mem/mtest05/mmstress.c
@@ -82,22 +82,22 @@
 /*                                                                            */
 /******************************************************************************/
 
-/* GLOBAL INCLUDE FILES                                                       */
-#include <stdio.h>		/* standard C input/output routines                     */
-#include <sys/types.h>		/* definitions for open()                               */
-#include <sys/stat.h>		/* definitions for open()                               */
-#include <fcntl.h>		/* definition of open()                                 */
-#include <unistd.h>		/* declaration of close()                               */
-#include <sys/mman.h>		/* declaration of mmap()                                */
-#include <sys/wait.h>		/* declaration for wait routine                         */
-#include <sys/time.h>		/* definitions for the interval timer                   */
-#include <pthread.h>		/* declaration of pthread functions                     */
-#include <signal.h>		/* definitions for signals - required for SIGALRM       */
-#include <errno.h>		/* definitions for errors                               */
-#include <stdlib.h>		/* declaration for malloc                               */
-#include <string.h>		/* declaration for memset                               */
-#include <sched.h>		/* declaration of sched_yield()                         */
+#include <stdio.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+#include <sys/time.h>
+#include <pthread.h>
+#include <signal.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sched.h>
 #include <stdint.h>
+#include <getopt.h>
 
 #include "test.h"
 
@@ -120,78 +120,34 @@
 #endif
 #define FAILED       (-1)	/* return status for all funcs indicating failure   */
 #define SUCCESS      0		/* return status for all routines indicating success */
-			  /* prints error if no argument passed               */
-#define OPT_MISSING(prog, opt) do {                        \
-            fprintf(stderr, "%s: option -%c ", prog, opt); \
-            fprintf(stderr, "requires an argument\n");    \
-                } while (0)
-
-			  /* exit thread macro                                */
-#define PTHREAD_EXIT(val)      do {              \
-            exit_val = val;                      \
-                pthread_exit((void *)exit_val); \
-                                  } while (0)
+
 #define MAXTEST      6		/* total number of testcase in this program          */
 #define BRKSZ        512*1024	/* program data space allocation value          */
 
-/* GLOBAL VARIABLES                                                           */
-typedef struct {		/* structure returned by map_and_thread()               */
-	int status;		/* status of the operation - FAILED or SUCCESS          */
-	caddr_t mapaddr;	/* address at which the file is mapped                  */
-} RETINFO_t;
-
-static volatile int wait_thread = 0;	/* used to wake up sleeping threads    */
-static volatile int thread_begin = 0;	/* used to coordinate threads          */
+static volatile int wait_thread;	/* used to wake up sleeping threads    */
+static volatile int thread_begin;	/* used to coordinate threads          */
 static int verbose_print = FALSE;	/* print more test information           */
 
 static int pages_num = NUMPAGES;	/* number of pages to use for tests     */
+static volatile int alarm_fired;
 
 char *TCID = "mmstress";
 int TST_TOTAL = 6;
 
-/******************************************************************************/
-/*                                                                            */
-/* Function:    sig_handler                                                   */
-/*                                                                            */
-/* Description: handle SIGALRM raised by set_timer(), SIGALRM is raised when  */
-/*              the timer expires. If any other signal is received exit the   */
-/*              test.                                                         */
-/*                                                                            */
-/* Input:       signal - signal number, intrested in SIGALRM!                 */
-/*                                                                            */
-/* Return:      exit -1 if unexpected signal is received                      */
-/*              exit 0 if SIGALRM is received                                 */
-/*                                                                            */
-/* Synopsis:    void signal_handler(int signal);                              */
-/*                                                                            */
-/******************************************************************************/
 static void sig_handler(int signal)
-{				/* signal number, set to handle SIGALRM               */
+{
 	if (signal != SIGALRM) {
 		fprintf(stderr,
 			"sig_handlder(): unexpected signal caught [%d]\n",
 			signal);
-		exit(-1);
-	} else
-		tst_resm(TPASS, "Test ended, success");
-	exit(0);
+		exit(TBROK);
+	}
+
+	alarm_fired = 1;
 }
 
-/******************************************************************************/
-/*                                                                            */
-/* Function:    usage                                                         */
-/*                                                                            */
-/* Description: prints the usage function.                                    */
-/*                                                                            */
-/* Input:       char *progname - name of this executable.                     */
-/*                                                                            */
-/* Return:      exit 1                                                        */
-/*                                                                            */
-/* Synopsis:    void usage(char *progname);                                   */
-/*                                                                            */
-/******************************************************************************/
 static void usage(char *progname)
-{				/* name of this program                       */
+{
 	fprintf(stderr, "usage:%s -h -n test -t time -v [-V]\n", progname);
 	fprintf(stderr, "\t-h displays all options\n");
 	fprintf(stderr, "\t-n test number, if no test number\n"
@@ -204,23 +160,10 @@ static void usage(char *progname)
 	exit(1);
 }
 
-/******************************************************************************/
-/*                                                                            */
-/* Function:    set_timer                                                     */
-/*                                                                            */
-/* Description: set up a timer to user specified number of hours. SIGALRM is  */
-/*              raised when the timer expires.                                */
-/*                                                                            */
-/* Input:       run_time - number of hours the test is intended to run.       */
-/*                                                                            */
-/* Return:      NONE                                                          */
-/*                                                                            */
-/* Synopsis:    void set_timer(int run_time);                                 */
-/*                                                                            */
-/******************************************************************************/
 static void set_timer(int run_time)
-{				/* period for which test is intended to run   */
-	struct itimerval timer;	/* timer structure, tv_sec is set to run_time */
+{
+	struct itimerval timer;
+
 	memset(&timer, 0, sizeof(struct itimerval));
 	timer.it_interval.tv_usec = 0;
 	timer.it_interval.tv_sec = 0;
@@ -244,27 +187,22 @@ static void set_timer(int run_time)
 /* Input:       void *args - argments passed to the exec routine by           */
 /*              pthread_create()                                              */
 /*                                                                            */
-/* Return:      NONE                                                          */
-/*                                                                            */
-/* Synopsis:    void *thread_fault(void *args);                               */
-/*                                                                            */
 /******************************************************************************/
 static void *thread_fault(void *args)
-{				/* pointer to the arguments passed to routine */
+{
 	long *local_args = args;	/* local pointer to list of arguments        */
 	/* local_args[THNUM]   - the thread number   */
 	/* local_args[MAPADDR] - map address         */
 	/* local_args[PAGESIZ] - page size           */
 	/* local_args[FLTIPE]  - fault type          */
 	int pgnum_ndx = 0;	/* index to the number of pages              */
-	caddr_t start_addr	/* start address of the page                 */
-	    = (caddr_t) (local_args[MAPADDR]
+	char *start_addr	/* start address of the page                 */
+	    = (void *) (local_args[MAPADDR]
 			 + (int)local_args[THNUM]
 			 * (pages_num / NUMTHREAD)
 			 * local_args[PAGESIZ]);
 	char read_from_addr = 0;	/* address to which read from page is done   */
 	char write_to_addr[] = { 'a' };	/* character to be writen to the page    */
-	uintptr_t exit_val = 0;	/* exit value of the pthread. 0 - success    */
 
     /*************************************************************/
 	/*   The way it was, args could be overwritten by subsequent uses
@@ -293,7 +231,7 @@ static void *thread_fault(void *args)
 				 start_addr);
 		fflush(NULL);
 	}
-	PTHREAD_EXIT(0);
+	pthread_exit(NULL);
 }
 
 /******************************************************************************/
@@ -302,16 +240,9 @@ static void *thread_fault(void *args)
 /*                                                                            */
 /* Description: remove temporary files that were created by the tests.        */
 /*                                                                            */
-/* Input:       char *filename - name of the file to be removed.              */
-/*                                                                            */
-/* Return:      FAILED  - on failure                                          */
-/*              SUCCESS - on success                                          */
-/*                                                                            */
-/* Synopsis:    int remove_files(char *filename);                             */
-/*                                                                            */
 /******************************************************************************/
 static int remove_files(char *filename, char *addr)
-{				/* name of the file that is to be removed     */
+{
 	if (addr)
 		if (munmap(addr, sysconf(_SC_PAGESIZE) * pages_num) < 0) {
 			perror("map_and_thread(): munmap()");
@@ -342,22 +273,12 @@ static int remove_files(char *filename, char *addr)
 /* Input:       char *tmpfile - name of temporary file that is created        */
 /*              int   fault_type - type of fault that is to be generated.     */
 /*                                                                            */
-/* Return:    RETINFO_t * - pointer to RETINFO_t structure                    */
-/*                                                                            */
-/* Synopsis:  RETINFO_t *map_and_thread(                                      */
-/*                        char  *tmpfile,                                     */
-/*                        void  *(*exec_func)(void *),                        */
-/*                        int    fault_type,                                  */
-/*                        int    num_thread,                                  */
-/*                        RETINFO_t *retinfo);                                */
-/*                                                                            */
 /******************************************************************************/
-RETINFO_t *map_and_thread(char *tmpfile,	/* name of temporary file to be created      */
-			  void *(*exec_func) (void *),	/* thread function to execute                */
-			  int fault_type,	/* type of fault to be generated             */
-			  int num_thread,	/* number of threads to create               */
-			  RETINFO_t * retinfo)
-{				/* return map address and oper status        */
+int map_and_thread(char *tmpfile,
+			  void *(*exec_func) (void *),
+			  int fault_type,
+			  int num_thread)
+{
 	int fd = 0;		/* file descriptor of the file created       */
 	int thrd_ndx = 0;	/* index to the number of threads created    */
 	int map_type = 0;	/* specifies the type of the mapped object   */
@@ -368,7 +289,7 @@ RETINFO_t *map_and_thread(char *tmpfile,	/* name of temporary file to be created
 	    = sysconf(_SC_PAGESIZE);
 	static pthread_t pthread_ids[NUMTHREAD];
 	/* contains ids of the threads created       */
-	caddr_t map_addr = NULL;	/* address where the file is mapped          */
+	void * map_addr = NULL;	/* address where the file is mapped          */
 
 	/* Create a file with permissions 0666, and open it with RDRW perms       */
 	/* if the name is not a NULL                                              */
@@ -381,8 +302,7 @@ RETINFO_t *map_and_thread(char *tmpfile,	/* name of temporary file to be created
 			perror("map_and_thread(): open()");
 			close(fd);
 			fflush(NULL);
-			retinfo->status = FAILED;
-			return retinfo;
+			return FAILED;
 		}
 
 		/* Write pagesize * pages_num bytes to the file */
@@ -394,8 +314,7 @@ RETINFO_t *map_and_thread(char *tmpfile,	/* name of temporary file to be created
 			fflush(NULL);
 			remove_files(tmpfile, NULL);
 			close(fd);
-			retinfo->status = FAILED;
-			return retinfo;
+			return FAILED;
 		}
 		map_type = (fault_type == COW_FAULT) ? MAP_PRIVATE : MAP_SHARED;
 
@@ -404,7 +323,7 @@ RETINFO_t *map_and_thread(char *tmpfile,	/* name of temporary file to be created
 		/* generated map the file with read protection else map with read -   */
 		/* write protection.                               */
 
-		if ((map_addr = (caddr_t) mmap(0, pagesize * pages_num,
+		if ((map_addr = (void *) mmap(0, pagesize * pages_num,
 					       ((fault_type == READ_FAULT) ?
 						PROT_READ : PROT_READ |
 						PROT_WRITE), map_type, fd, 0))
@@ -414,10 +333,8 @@ RETINFO_t *map_and_thread(char *tmpfile,	/* name of temporary file to be created
 			fflush(NULL);
 			remove_files(tmpfile, NULL);
 			close(fd);
-			retinfo->status = FAILED;
-			return retinfo;
+			return FAILED;
 		} else {
-			retinfo->mapaddr = map_addr;
 			if (verbose_print)
 				tst_resm(TINFO,
 					 "map_and_thread(): mmap success, address = %p",
@@ -460,8 +377,7 @@ RETINFO_t *map_and_thread(char *tmpfile,	/* name of temporary file to be created
 			fflush(NULL);
 			remove_files(tmpfile, map_addr);
 			close(fd);
-			retinfo->status = FAILED;
-			return retinfo;
+			return FAILED;
 		} else {
 	    /***************************************************/
 			/*   Yield until new thread is done with args.
@@ -485,8 +401,7 @@ RETINFO_t *map_and_thread(char *tmpfile,	/* name of temporary file to be created
 			fflush(NULL);
 			remove_files(tmpfile, map_addr);
 			close(fd);
-			retinfo->status = FAILED;
-			return retinfo;
+			return FAILED;
 		} else {
 			if ((long)th_status == 1) {
 				tst_resm(TINFO,
@@ -512,14 +427,12 @@ RETINFO_t *map_and_thread(char *tmpfile,	/* name of temporary file to be created
 	 */
 	if (remove_files(tmpfile, map_addr) == FAILED) {
 		free(empty_buf);
-		retinfo->status = FAILED;
-		return retinfo;
+		return FAILED;
 	}
 
 	free(empty_buf);
 	close(fd);
-	retinfo->status = SUCCESS;
-	return retinfo;
+	return SUCCESS;
 }
 
 /******************************************************************************/
@@ -530,23 +443,12 @@ RETINFO_t *map_and_thread(char *tmpfile,	/* name of temporary file to be created
 /* Description: map a file into memory, create threads and execute a thread   */
 /*              function that will cause read faults by simultaneously reading*/
 /*              from this memory space.                                       */
-/*                                                                            */
-/* Input:       NONE                                                          */
-/*                                                                            */
-/* Return:      int - status from map_and_thread()                            */
-/*                                                                            */
-/* Synopsis:    int test1();                                                  */
-/*                                                                            */
 /******************************************************************************/
-static int test1()
+static int test1(void)
 {
-	RETINFO_t retval;	/* contains info relating to test status          */
-
 	tst_resm(TINFO, "test1: Test case tests the race condition between "
 		 "simultaneous read faults in the same address space.");
-	map_and_thread("./tmp.file.1", thread_fault, READ_FAULT, NUMTHREAD,
-		       &retval);
-	return (retval.status);
+	return map_and_thread("./tmp.file.1", thread_fault, READ_FAULT, NUMTHREAD);
 }
 
 /******************************************************************************/
@@ -557,23 +459,12 @@ static int test1()
 /* Description: map a file into memory, create threads and execute a thread   */
 /*              function that will cause write faults by simultaneously       */
 /*              writing to this memory space.                                 */
-/*                                                                            */
-/* Input:       NONE                                                          */
-/*                                                                            */
-/* Return:      int - status from map_and_thread()                            */
-/*                                                                            */
-/* Synopsis:    int test2();                                                  */
-/*                                                                            */
 /******************************************************************************/
-static int test2()
+static int test2(void)
 {
-	RETINFO_t retval;	/* contains test stats information               */
-
 	tst_resm(TINFO, "test2: Test case tests the race condition between "
 		 "simultaneous write faults in the same address space.");
-	map_and_thread("./tmp.file.2", thread_fault, WRITE_FAULT, NUMTHREAD,
-		       &retval);
-	return (retval.status);
+	return map_and_thread("./tmp.file.2", thread_fault, WRITE_FAULT, NUMTHREAD);
 }
 
 /******************************************************************************/
@@ -585,22 +476,12 @@ static int test2()
 /*              function that will cause COW faults by simultaneously         */
 /*              writing to this memory space.                                 */
 /*                                                                            */
-/* Input:       NONE                                                          */
-/*                                                                            */
-/* Return:      int - status from map_and_thread()                            */
-/*                                                                            */
-/* Synopsis:    int test3();                                                  */
-/*                                                                            */
 /******************************************************************************/
-static int test3()
+static int test3(void)
 {
-	RETINFO_t retval;	/* contains test stats information                   */
-
 	tst_resm(TINFO, "test3: Test case tests the race condition between "
 		 "simultaneous COW faults in the same address space.");
-	map_and_thread("./tmp.file.3", thread_fault, COW_FAULT, NUMTHREAD,
-		       &retval);
-	return (retval.status);
+	return map_and_thread("./tmp.file.3", thread_fault, COW_FAULT, NUMTHREAD);
 }
 
 /******************************************************************************/
@@ -612,23 +493,13 @@ static int test3()
 /*              function that will cause READ faults by simultaneously        */
 /*              writing to this memory space.                                 */
 /*                                                                            */
-/* Input:       NONE                                                          */
-/*                                                                            */
-/* Return:      int - status from map_and_thread()                            */
-/*                                                                            */
-/* Synopsis:    int test4();                                                  */
-/*                                                                            */
 /******************************************************************************/
-static int test4()
+static int test4(void)
 {
-	RETINFO_t retval;	/* contains test status information                 */
-
 	tst_resm(TINFO, "test4: Test case tests the race condition between "
 		 "simultaneous READ faults in the same address space. "
 		 "The file mapped is /dev/zero");
-	map_and_thread("/dev/zero", thread_fault, COW_FAULT, NUMTHREAD,
-		       &retval);
-	return (retval.status);
+	return map_and_thread("/dev/zero", thread_fault, COW_FAULT, NUMTHREAD);
 }
 
 /******************************************************************************/
@@ -639,25 +510,19 @@ static int test4()
 /* Description: Initialize large data in the parent process, fork a child and */
 /*              and the parent waits for the child to complete execution.     */
 /*                                                                            */
-/* Input:       NONE                                                          */
-/*                                                                            */
-/* Return:      int - status from map_and_thread()                            */
-/*                                                                            */
-/* Synopsis:    int test5();                                                  */
-/*                                                                            */
 /******************************************************************************/
-static int test5()
+static int test5(void)
 {
-	int fork_ndx = 0;	/* index to the number of processes forked        */
-	pid_t pid = 0;		/* process id, returned by fork system call.      */
-	int wait_status = 0;	/* if status is not NULL store status information */
+	int fork_ndx = 0;
+	pid_t pid = 0;
+	int wait_status = 0;
 
 	tst_resm(TINFO, "test5: Test case tests the race condition between "
 		 "simultaneous fork - exit faults in the same address space.");
 
 	/* increment the  program's  data  space  by 200*1024 (BRKSZ) bytes       */
 
-	if (sbrk(BRKSZ) == (caddr_t) - 1) {
+	if (sbrk(BRKSZ) == (void *) - 1) {
 		perror("test5(): sbrk()");
 		fflush(NULL);
 		return FAILED;
@@ -676,7 +541,7 @@ static int test5()
 
 	} while (fork_ndx++ < NUMTHREAD);
 
-	if (sbrk(-BRKSZ) == (caddr_t) - 1) {
+	if (sbrk(-BRKSZ) == (void *) - 1) {
 		tst_resm(TINFO, "test5(): rollback sbrk failed");
 		fflush(NULL);
 		perror("test5(): sbrk()");
@@ -695,28 +560,20 @@ static int test5()
 /*              and the parent waits for the child to complete execution. The */
 /*              child program execs a dummy program.                          */
 /*                                                                            */
-/* Input:       NONE                                                          */
-/*                                                                            */
-/* Return:      int - status from map_and_thread()                            */
-/*                                                                            */
-/* Synopsis:    int test6();                                                  */
-/*                                                                            */
 /******************************************************************************/
-static int test6()
+static int test6(void)
 {
 	int res = SUCCESS;
-	int fork_ndx = 0;	/* index to the number of processes forked         */
-	pid_t pid = 0;		/* process id, returned by fork system call.       */
-	int wait_status;	/* if status is not NULL store status information  */
-	char *argv_init[2] =	/* parameter required for dummy function to execvp */
-	{ "arg1", NULL };
+	int fork_ndx = 0;
+	pid_t pid = 0;
+	int wait_status;
+	char *argv_init[2] = { "arg1", NULL };
 
 	tst_resm(TINFO, "test6: Test case tests the race condition between "
 		 "simultaneous fork -exec - exit faults in the same address space.");
 
 	/* increment the  program's  data  space  by 200*1024 (BRKSZ) bytes       */
-
-	if (sbrk(BRKSZ) == (caddr_t) - 1) {
+	if (sbrk(BRKSZ) == (void *) - 1) {
 		perror("test6(): sbrk()");
 		fflush(NULL);
 		return FAILED;
@@ -725,113 +582,80 @@ static int test6()
 	/* fork NUMTHREAD number of processes, assumption is on SMP each will get */
 	/* a separate CPU if NRCPUS = NUMTHREAD. The child execs a dummy program  */
 	/*  and parent waits for child to complete execution.                     */
-
 	do {
 		if (!(pid = fork())) {
 			if (execvp("mmstress_dummy", argv_init) == -1) {
 				if (execvp("./mmstress_dummy", argv_init) == -1) {
 					perror("test6(): execvp()");
 					fflush(NULL);
-		   /*************************************************/
-					/*   Dummy uses exit 0 so use something else for
-					 *   error exit.
-					 */
 					exit(99);
 				}
 			}
 		} else {
 			if (pid != -1)
 				wait(&wait_status);
-	    /*************************************************/
-			/*   Dummy uses exit 0.
-			 *   Capture exit of child and set res accordingly.
-			 *   It defaults to SUCCESS.  Only gets set if
-			 *   child fails.
-			 */
+
 			if (WEXITSTATUS(wait_status) != 0)
 				res = FAILED;
 		}
 
 	} while (fork_ndx++ < NUMTHREAD);
 
-	if (sbrk(-BRKSZ) == (caddr_t) - 1) {
+	if (sbrk(-BRKSZ) == (void *) - 1) {
 		tst_resm(TINFO, "test6(): rollback sbrk failed");
 		fflush(NULL);
 		perror("test6(): sbrk()");
 		fflush(NULL);
 		return FAILED;
 	}
-    /*************************************/
-	/*  This used to return SUCCESS, whether or not the
-	 *  test actually worked.
-	 */
+
 	return res;
 }
 
-/******************************************************************************/
-/*                                                                            */
-/* Function:    main                                                          */
-/*                                                                            */
-/* Desciption:  This is the main function of mmstress program. It processes   */
-/*              all command line options and flags and runs the tests.        */
-/*              If no specific tests are chosen, all tests will be run one    */
-/*              time by default.                                              */
-/*                                                                            */
-/* Input:       argc - number of command line parameters                      */
-/*              argv - pointer to the array of the command line parameters.   */
-/*                                                                            */
-/* Return:      EXIT_FAILURE - in case sigaction() fails                      */
-/*              rc - return code from the testcase                            */
-/*                   zero     - success                                       */
-/*                   non zero - failure                                       */
-/*                                                                            */
-/******************************************************************************/
-int main(int argc,		/* number of command line parameters                     */
-	 char **argv)
-{				/* pointer to the array of the command line parameters.  */
-	extern char *optarg;	/* getopt() function global variables               */
-	extern int optind;	/* index into argument                              */
-	extern int opterr;	/* optarg error detection                           */
-	extern int optopt;	/* stores bad option passed to the program          */
+static int (*(test_ptr)[]) () = {test1, test2, test3, test4, test5, test6};
+
+static void run_test(unsigned int i)
+{
+	int rc;
+
+	rc = test_ptr[i]();
+
+	if (rc == SUCCESS)
+		tst_resm(TPASS, "TEST %d Passed", i + 1);
+	else
+		tst_resm(TFAIL, "TEST %d Failed", i + 1);
 
+	if (alarm_fired)
+		tst_exit();
+}
+
+int main(int argc, char **argv)
+{
 	static char *version_info = "mmstress V1.00 04/17/2001";
-	/* version of this program                          */
-	int (*(test_ptr)[]) () = {
-	NULL, test1, test2, test3, test4, test5, test6};
-	/* pointer to the array of test names     */
-	int ch;			/* command line flag character            */
-	int test_num = 0;	/* test number that is to be run          */
-	int test_time = 0;	/* duration for which test is to be run   */
-	int sig_ndx = 0;	/* index into signal handler structure.   */
-	int run_once = TRUE;	/* test/tests are run once by default.    */
-	char *prog_name = argv[0];	/* name of this program                   */
-	int rc = 0;		/* return value from tests.  0 - success  */
-	int global_rc = 0;	/* return value from tests.  0 - success  */
-	int version_flag = FALSE;	/* printf the program version             */
-	struct sigaction sigptr;	/* set up signal, for interval timer      */
+	int ch, i;
+	int test_num = 0;
+	int test_time = 0;
+	int run_once = TRUE;
 
 	static struct signal_info {
-		int signum;	/* signal number that hasto be handled                */
-		char *signame;	/* name of the signal to be handled.                  */
-	} sig_info[] = { {
-	SIGHUP, "SIGHUP"}, {
-	SIGINT, "SIGINT"}, {
-	SIGQUIT, "SIGQUIT"}, {
-	SIGABRT, "SIGABRT"}, {
-	SIGBUS, "SIGBUS"}, {
-	SIGSEGV, "SIGSEGV"}, {
-	SIGALRM, "SIGALRM"}, {
-	SIGUSR1, "SIGUSR1"}, {
-	SIGUSR2, "SIGUSR2"}, {
-	SIGENDSIG, "ENDSIG"}
+		int signum;
+		char *signame;
+	} sig_info[] = {
+		{SIGHUP, "SIGHUP"},
+		{SIGINT, "SIGINT"},
+		{SIGQUIT, "SIGQUIT"},
+		{SIGABRT, "SIGABRT"},
+		{SIGBUS, "SIGBUS"},
+		{SIGSEGV, "SIGSEGV"},
+		{SIGALRM, "SIGALRM"},
+		{SIGUSR1, "SIGUSR1"},
+		{SIGUSR2, "SIGUSR2"},
+		{SIGENDSIG, "ENDSIG"}
 	};
 
 	setvbuf(stdout, NULL, _IONBF, 0);
 	setvbuf(stderr, NULL, _IONBF, 0);
 
-	optarg = NULL;
-	opterr = 0;
-
 	if (argc < 2)
 		tst_resm(TINFO, "run %s -h for all options", argv[0]);
 
@@ -841,111 +665,59 @@ int main(int argc,		/* number of command line parameters                     */
 			usage(argv[0]);
 			break;
 		case 'n':
-			if (optarg)
-				test_num = atoi(optarg);
-			else
-				OPT_MISSING(prog_name, optopt);
+			test_num = atoi(optarg);
 			break;
 		case 'p':
-			if (optarg)
-				pages_num = atoi(optarg);
-			else
-				OPT_MISSING(prog_name, optopt);
+			pages_num = atoi(optarg);
 			break;
 		case 't':
-			if (optarg) {
-				tst_resm(TINFO,
-					 "Test is scheduled to run for %d hours",
-					 test_time = atoi(optarg));
-				run_once = FALSE;
-			} else
-				OPT_MISSING(prog_name, optopt);
+			tst_resm(TINFO,
+				 "Test is scheduled to run for %d hours",
+				 test_time = atoi(optarg));
+			run_once = FALSE;
 			break;
 		case 'v':
 			verbose_print = TRUE;
 			break;
 		case 'V':
-			if (!version_flag) {
-				version_flag = TRUE;
-				tst_resm(TINFO, "%s: %s", prog_name,
-					 version_info);
-			}
+			tst_resm(TINFO, "%s: %s", argv[0], version_info);
 			break;
 		case '?':
-			if (argc < optind)
-				OPT_MISSING(prog_name, optopt);
-			else
-				fprintf(stderr,
-					"%s: unknown option - %c ignored\n",
-					prog_name, optopt);
+			fprintf(stderr,
+				"%s: unknown option - %c ignored\n",
+				argv[0], optopt);
 			break;
 		default:
-			fprintf(stderr, "%s: getopt() failed!!!\n", prog_name);
-			exit(2);
+			tst_brkm(TBROK, NULL, "%s: getopt() failed!!!\n",
+				 argv[0]);
 		}
 	}
 
-	/* duration for which the tests have to be run. test_time is converted to */
-	/* corresponding seconds and the tests are run as long as the current time */
-	/* is less than the required time and test are successul (ie rc = 0)      */
-
 	set_timer(test_time);
 
-	/* set up signals */
-	sigptr.sa_handler = (void (*)(int signal))sig_handler;
-	sigfillset(&sigptr.sa_mask);
-	sigptr.sa_flags = 0;
-	for (sig_ndx = 0; sig_info[sig_ndx].signum != -1; sig_ndx++) {
-		sigaddset(&sigptr.sa_mask, sig_info[sig_ndx].signum);
-
-		if (sigaction(sig_info[sig_ndx].signum, &sigptr,
-			      (struct sigaction *)NULL) == SIGENDSIG) {
-			perror("main(): sigaction()");
-			fprintf(stderr,
-				"could not set handler for SIGALRM, errno = %d\n",
-				errno);
-			exit(EXIT_FAILURE);
+	for (i = 0; sig_info[i].signum != -1; i++) {
+		if (signal(sig_info[i].signum, sig_handler) == SIG_ERR) {
+			tst_brkm(TBROK | TERRNO, NULL, "signal(%s) failed",
+				 sig_info[i].signame);
 		}
 	}
 
-    /*************************************************/
-	/*   The way this loop was, 5 of 6 tests could fail,
-	 *   and as long test test 6 passed, the test passed.
-	 *   The changes in this loop repair that problem.
-	 */
+	tst_tmpdir();
+
 	do {
 		if (!test_num) {
-			int test_ndx;	/* index into the array of tests               */
-
-			for (test_ndx = 1; test_ndx <= MAXTEST; test_ndx++) {
-				rc = test_ptr[test_ndx] ();
-				if (rc == SUCCESS) {
-					tst_resm(TPASS, "TEST %d Passed",
-						 test_ndx);
-				} else {
-					tst_resm(TFAIL, "TEST %d Failed",
-						 test_ndx);
-					global_rc = rc;
-				}
-			}
+			for (i = 0; i < MAXTEST; i++)
+				run_test(i);
 		} else {
-			global_rc = (test_num > MAXTEST) ?
-			    fprintf(stderr,
-				    "Invalid test number, must be in range [1 - %d]\n",
-				    MAXTEST) : test_ptr[test_num] ();
-		}
+			if (test_num >= MAXTEST) {
+				tst_brkm(TBROK, NULL, "Invalid test number %i",
+					 test_num);
+			}
 
-		if (global_rc != SUCCESS) {
-			tst_resm(TFAIL, "Test Failed");
-			exit(global_rc);
+			run_test(test_num);
 		}
+	} while (!run_once);
 
-	} while ((TRUE) && (!run_once));
-
-	if (global_rc != SUCCESS) {
-		tst_resm(TFAIL, "Test Failed");
-	} else {
-		tst_resm(TPASS, "Test Passed");
-	}
-	exit(global_rc);
+	tst_rmdir();
+	tst_exit();
 }
-- 
2.10.2

