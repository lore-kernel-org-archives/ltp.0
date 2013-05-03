Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dave.kleikamp@oracle.com>) id 1UYFLE-0006Dn-Iz
	for ltp-list@lists.sourceforge.net; Fri, 03 May 2013 12:44:00 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UYFLD-00023O-8r
	for ltp-list@lists.sourceforge.net; Fri, 03 May 2013 12:44:00 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r43ChpWO022125
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 3 May 2013 12:43:52 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by ucsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r43Choc9029696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Fri, 3 May 2013 12:43:52 GMT
Received: from abhmt113.oracle.com (abhmt113.oracle.com [141.146.116.65])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r43Chow8022942
	for <ltp-list@lists.sourceforge.net>; Fri, 3 May 2013 12:43:50 GMT
Message-ID: <5183B105.8030106@oracle.com>
Date: Fri, 03 May 2013 07:43:49 -0500
From: Dave Kleikamp <dave.kleikamp@oracle.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] Fix retval parameter to pthread_join()
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

The retval parameter to pthread_join() is a pointer to a pointer. There
are several instances where a pointer to int is being passed instead.
This can result in a bus error on sparc64 when the pointer is not
aligned on a 64-bit boundary. Of course, it's a potential problem on
any 64-bit platform.

Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
---
 testcases/kernel/io/ltp-aiodio/aio-stress.c                    |  3 +--
 testcases/kernel/io/stress_cd/stress_cd.c                      |  9 +++++----
 testcases/kernel/mem/mtest05/mmstress.c                        |  4 ++--
 testcases/kernel/mem/mtest06/mmap1.c                           |  8 ++++----
 testcases/kernel/mem/mtest06/mmap3.c                           |  9 +++++----
 testcases/kernel/mem/mtest06/shmat1.c                          | 10 +++++-----
 testcases/kernel/mem/mtest07/shm_test.c                        |  6 +++---
 testcases/network/nfs/nfsstress/make_tree.c                    |  6 +++---
 .../conformance/interfaces/pthread_cond_timedwait/4-1.c        |  6 +++---
 9 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/aio-stress.c b/testcases/kernel/io/ltp-aiodio/aio-stress.c
index 710ef3d..0b7148c 100644
--- a/testcases/kernel/io/ltp-aiodio/aio-stress.c
+++ b/testcases/kernel/io/ltp-aiodio/aio-stress.c
@@ -1233,7 +1233,6 @@ typedef void *(*start_routine) (void *);
 int run_workers(struct thread_info *t, int num_threads)
 {
 	int ret;
-	int thread_ret;
 	int i;
 
 	for (i = 0; i < num_threads; i++) {
@@ -1246,7 +1245,7 @@ int run_workers(struct thread_info *t, int num_threads)
 		}
 	}
 	for (i = 0; i < num_threads; i++) {
-		ret = pthread_join(t[i].tid, (void *)&thread_ret);
+		ret = pthread_join(t[i].tid, NULL);
 		if (ret) {
 			perror("pthread_join");
 			exit(1);
diff --git a/testcases/kernel/io/stress_cd/stress_cd.c b/testcases/kernel/io/stress_cd/stress_cd.c
index 1048b62..3e1e697 100644
--- a/testcases/kernel/io/stress_cd/stress_cd.c
+++ b/testcases/kernel/io/stress_cd/stress_cd.c
@@ -143,15 +143,16 @@ int main(int argc, char **argv)
 		sys_error("pthread_attr_destroy failed", __LINE__);
 
 	for (i = 0; i < num_threads; i++) {
-		int exit_value;
+		void *exit_value;
 		printf("\tThread [main]: waiting for thread: %d\n", i + 1);
 		/*if (pthread_join ((pthread_t*) array [i], (void **) &exit_value)) */
-		if (pthread_join((pthread_t) array[i], (void **)&exit_value))
+		if (pthread_join(array[i], &exit_value))
 			sys_error("pthread_join failed", __LINE__);
 
 		if (debug)
-			printf("\tThread [%d]: return %d\n", i + 1, exit_value);
-		rc += exit_value;
+			printf("\tThread [%d]: return %ld\n", i + 1,
+			       (long)exit_value);
+		rc += (long)exit_value;
 	}
 	free(array);
 	free(arg);
diff --git a/testcases/kernel/mem/mtest05/mmstress.c b/testcases/kernel/mem/mtest05/mmstress.c
index f845290..52dae70 100644
--- a/testcases/kernel/mem/mtest05/mmstress.c
+++ b/testcases/kernel/mem/mtest05/mmstress.c
@@ -361,7 +361,7 @@ RETINFO_t *map_and_thread(char *tmpfile,	/* name of temporary file to be created
 	int fd = 0;		/* file descriptor of the file created       */
 	int thrd_ndx = 0;	/* index to the number of threads created    */
 	int map_type = 0;	/* specifies the type of the mapped object   */
-	int *th_status = 0;	/* status of the thread when it is finished  */
+	int **th_status;	/* status of the thread when it is finished  */
 	long th_args[5];	/* argument list passed to  thread_fault()   */
 	char *empty_buf = NULL;	/* empty buffer used to fill temp file       */
 	long pagesize		/* contains page size at runtime             */
@@ -489,7 +489,7 @@ RETINFO_t *map_and_thread(char *tmpfile,	/* name of temporary file to be created
 			retinfo->status = FAILED;
 			return retinfo;
 		} else {
-			if ((int)*th_status == 1) {
+			if ((long)*th_status == 1) {
 				tst_resm(TINFO,
 					 "thread [%ld] - process exited with errors",
 					 (long)pthread_ids[thrd_ndx]);
diff --git a/testcases/kernel/mem/mtest06/mmap1.c b/testcases/kernel/mem/mtest06/mmap1.c
index 61d5369..7c80bb4 100644
--- a/testcases/kernel/mem/mtest06/mmap1.c
+++ b/testcases/kernel/mem/mtest06/mmap1.c
@@ -285,7 +285,7 @@ int main(int argc, char **argv)
 	int num_iter;
 	double exec_time;
 	int fd;
-	int status[2];
+	void *status;
 	pthread_t thid[2];
 	long chld_args[3];
 	extern char *optarg;
@@ -387,15 +387,15 @@ int main(int argc, char **argv)
 		tst_resm(TINFO, "created reading thread[%lu]", thid[1]);
 
 		for (i = 0; i < 2; i++) {
-			if ((ret = pthread_join(thid[i], (void *)&status[i])))
+			if ((ret = pthread_join(thid[i], &status)))
 				tst_brkm(TBROK, NULL,
 					 "main(): pthread_join(): %s",
 					 strerror(ret));
 
-			if (status[i])
+			if (status)
 				tst_brkm(TFAIL, NULL,
 					 "thread [%lu] - process exited "
-					 "with %d", thid[i], status[i]);
+					 "with %ld", thid[i], (long)status);
 		}
 
 		close(fd);
diff --git a/testcases/kernel/mem/mtest06/mmap3.c b/testcases/kernel/mem/mtest06/mmap3.c
index ec4de47..e758314 100644
--- a/testcases/kernel/mem/mtest06/mmap3.c
+++ b/testcases/kernel/mem/mtest06/mmap3.c
@@ -264,7 +264,7 @@ int main(int argc,		/* number of input parameters.                        */
 	int num_thrd;		/* number of threads to create                */
 	int thrd_ndx;		/* index into the array of threads.           */
 	float exec_time;	/* period for which the test is executed      */
-	int status;		/* exit status for light weight process       */
+	void *status;		/* exit status for light weight process       */
 	int sig_ndx;		/* index into signal handler structure.       */
 	pthread_t thid[1000];	/* pids of process that will map/write/unmap  */
 	long chld_args[3];	/* arguments to funcs execed by child process */
@@ -362,14 +362,15 @@ int main(int argc,		/* number of input parameters.                        */
 
 		/* wait for the children to terminate */
 		for (thrd_ndx = 0; thrd_ndx < num_thrd; thrd_ndx++) {
-			if (pthread_join(thid[thrd_ndx], (void *)&status)) {
+			if (pthread_join(thid[thrd_ndx], &status)) {
 				perror("main(): pthread_create()");
 				exit(-1);
 			} else {
 				if (status) {
 					fprintf(stderr,
-						"thread [%d] - process exited with errors %d\n",
-						WEXITSTATUS(status), status);
+						"thread [%d] - process exited with errors %ld\n",
+						WEXITSTATUS((long)status),
+						(long)status);
 					exit(-1);
 				}
 			}
diff --git a/testcases/kernel/mem/mtest06/shmat1.c b/testcases/kernel/mem/mtest06/shmat1.c
index ddaa49e..db37eca 100644
--- a/testcases/kernel/mem/mtest06/shmat1.c
+++ b/testcases/kernel/mem/mtest06/shmat1.c
@@ -392,7 +392,7 @@ int main(int argc,		/* number of input parameters.                        */
 	int num_iter;		/* number of iteration to perform             */
 	int thrd_ndx;		/* index into the array of threads.           */
 	double exec_time;	/* period for which the test is executed      */
-	int status[1];		/* exit status for light weight process       */
+	void *status;		/* exit status for light weight process       */
 	int sig_ndx;		/* index into signal handler structure.       */
 	pthread_t thid[1000];	/* pids of process that will map/write/unmap  */
 	long chld_args[3];	/* arguments to funcs execed by child process */
@@ -497,14 +497,14 @@ int main(int argc,		/* number of input parameters.                        */
 
 		/* wait for the children to terminate */
 		for (thrd_ndx = 0; thrd_ndx < 3; thrd_ndx++) {
-			if (pthread_join(thid[thrd_ndx], (void *)status)) {
+			if (pthread_join(thid[thrd_ndx], &status)) {
 				perror("main(): pthread_create()");
 				exit(-1);
 			}
-			if (*status == -1) {
+			if (status == (void *)-1) {
 				fprintf(stderr,
-					"thread [%#lx] - process exited with errors %d\n",
-					thid[thrd_ndx], *status);
+					"thread [%#lx] - process exited with errors %ld\n",
+					thid[thrd_ndx], (long)status);
 				exit(-1);
 			}
 		}
diff --git a/testcases/kernel/mem/mtest07/shm_test.c b/testcases/kernel/mem/mtest07/shm_test.c
index 2f2c9f1..9ef84a0 100644
--- a/testcases/kernel/mem/mtest07/shm_test.c
+++ b/testcases/kernel/mem/mtest07/shm_test.c
@@ -273,7 +273,7 @@ int main(int argc,		/* number of input parameters                 */
 	int num_thrd = MAXT;	/* number of threads to create                */
 	int num_reps = MAXR;	/* number of repatitions the test is run      */
 	int thrd_ndx;		/* index into the array of thread ids         */
-	int th_status;		/* exit status of LWP's                       */
+	void * th_status;	/* exit status of LWP's                       */
 	int map_size;		/* size of the file mapped.                   */
 	int shmkey = 1969;	/* key used to generate shmid by shmget()     */
 	pthread_t thrdid[30];	/* maxinum of 30 threads allowed              */
@@ -344,12 +344,12 @@ int main(int argc,		/* number of input parameters                 */
 	sync();
 
 	for (thrd_ndx = 0; thrd_ndx < num_thrd; thrd_ndx++) {
-		if (pthread_join(thrdid[thrd_ndx], (void *)&th_status) != 0) {
+		if (pthread_join(thrdid[thrd_ndx], &th_status) != 0) {
 			perror("shmat_rd_wr(): pthread_join()");
 			exit(-1);
 		} else {
 			dprt("WE ARE HERE %d\n", __LINE__);
-			if (th_status == -1) {
+			if (th_status == (void *)-1) {
 				fprintf(stderr,
 					"thread [%ld] - process exited with errors\n",
 					(long)thrdid[thrd_ndx]);
diff --git a/testcases/network/nfs/nfsstress/make_tree.c b/testcases/network/nfs/nfsstress/make_tree.c
index 7df0b8d..7b18da3 100644
--- a/testcases/network/nfs/nfsstress/make_tree.c
+++ b/testcases/network/nfs/nfsstress/make_tree.c
@@ -721,7 +721,7 @@ int main(int argc,		/* number of input parameters                 */
 	int num_dirs = MAXD;	/* number of subdirectories to create         */
 	int num_files = MAXF;	/* number of files in each subdirectory      */
 	int thrd_ndx;		/* index into the array of thread ids         */
-	int th_status[1];	/* exit status of LWP's                       */
+	void *th_status;	/* exit status of LWP's                       */
 	pthread_t thrdid[30];	/* maxinum of 30 threads allowed              */
 	long chld_args[3];	/* arguments to the thread function           */
 	extern int optopt;	/* options to the program                     */
@@ -778,12 +778,12 @@ int main(int argc,		/* number of input parameters                 */
 	sync();
 
 	for (thrd_ndx = 0; thrd_ndx < num_thrd; thrd_ndx++) {
-		if (pthread_join(thrdid[thrd_ndx], (void **)&th_status) != 0) {
+		if (pthread_join(thrdid[thrd_ndx], &th_status) != 0) {
 			perror("crte_mk_rm(): pthread_join()");
 			exit(-1);
 		} else {
 			dprt("WE ARE HERE %d\n", __LINE__);
-			if (*th_status == -1) {
+			if (th_status == (void *)-1) {
 				fprintf(stderr,
 					"thread [%ld] - process exited with errors\n",
 					thrdid[thrd_ndx]);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_timedwait/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_timedwait/4-1.c
index 43cdf3f..6e0724e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_timedwait/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_timedwait/4-1.c
@@ -67,7 +67,7 @@ void *t1_func(void *arg)
 int main(void)
 {
 	pthread_t thread1;
-	int th_ret;
+	void *th_ret;
 
 	if (pthread_mutex_init(&td.mutex, NULL) != 0) {
 		fprintf(stderr, "Fail to initialize mutex\n");
@@ -85,6 +85,6 @@ int main(void)
 
 	fprintf(stderr, "Main: no condition is going to be met\n");
 
-	pthread_join(thread1, (void *)&th_ret);
-	return th_ret;
+	pthread_join(thread1, &th_ret);
+	return (long)th_ret;
 }
-- 
1.8.2.2


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite
It's a free troubleshooting tool designed for production
Get down to code-level detail for bottlenecks, with <2% overhead.
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
