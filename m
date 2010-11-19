Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <biannm@cn.fujitsu.com>) id 1PJN1d-000856-Rj
	for ltp-list@lists.sourceforge.net; Fri, 19 Nov 2010 09:12:57 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PJN1a-0003Sn-Df
	for ltp-list@lists.sourceforge.net; Fri, 19 Nov 2010 09:12:57 +0000
Message-ID: <4CE63F9B.8070605@cn.fujitsu.com>
Date: Fri, 19 Nov 2010 17:12:59 +0800
From: Bian Naimeng <biannm@cn.fujitsu.com>
MIME-Version: 1.0
References: <4CE61F95.0@cn.fujitsu.com> <000701cb87c8$09b09ed0$1d11dc70$@co.jp>
In-Reply-To: <000701cb87c8$09b09ed0$1d11dc70$@co.jp>
Subject: Re: [LTP] [POSIX][PATCH]Instead sem_wait by fcntl for sigaction
	test.
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

>> -----Original Message-----
>> From: Bian Naimeng [mailto:biannm@cn.fujitsu.com]
>> Sent: Friday, November 19, 2010 3:56 PM
>> To: Garrett Cooper
>> Cc: Mitani; ltp-list@lists.sourceforge.net
>> Subject: [LTP][POSIX][PATCH]Instead sem_wait by fcntl for sigaction
>> test.
>>

... snip ...

>> +	if (pid < 0) {
>> +		printf("Failed to fork: %s\n", strerror(errno));
>> +		return PTS_UNRESOLVED;
>> +	} else if (pid == 0) {
>> +		struct sigaction sa;
>> +
>> +		/* Set the signal handler */
>> +		sa.sa_flags = SA_RESTART;
>> +		sa.sa_flags = 0;
>> +		sa.sa_handler = handler;
>> +
>> +		ret = sigemptyset(&sa.sa_mask);
>> +		if(ret != 0) {
>> +			printf("Failed to empty signal set: %s\n",
>> +				strerror(errno));
>> +			exit(PTS_UNRESOLVED);
>> +		}
>>
>> -	sched_yield();
>> +		/* Install the signal handler for SIGNAL */
>> +		ret = sigaction(SIGNAL, &sa, 0);
>> +		if (ret != 0) {
>> +			printf("Failed to set signal handler: %s\n",
>> +				strerror(errno));
>> +			exit(PTS_UNRESOLVED);
>> +		}

... snip ...

> 
> 
> I tried Bian's patch:
> ------------
> [root@RHEL55-LTP-x86 sigaction]# make
> conformance/interfaces/sigaction/16-1 compile PASSED
> [root@RHEL55-LTP-x86 sigaction]# ./16-1.run-test
> Caught signal 6
> The function returned EINTR while SA_RESTART is set
> [root@RHEL55-LTP-x86 sigaction]# echo $?
> 1
> [root@RHEL55-LTP-x86 sigaction]#
> ------------
> 
> It failed, but "Caught signal 6" indicated.
> It shows that a signal is pitched and was received.
> 

Sorry, i forgot to remove some debug code. please retry the new one.

----

At older linux kernel(2.6.22 before), a signal handler always interrupts a
blocked call to sem_wait, regardless of the use of the sigaction
SA_RESTART flag. So instead it by fcntl.

Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>


---
 .../conformance/interfaces/sigaction/16-1.c        |  200 ++++++++++----------
 1 files changed, 102 insertions(+), 98 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/16-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/16-1.c
index 706dbfc..07ab98a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/16-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/16-1.c
@@ -21,14 +21,15 @@
 * shall restart silently.
 
 * The steps are:
-* -> create a child thread 
-* -> child registers a handler for SIGABRT with SA_RESTART, then waits for the semaphore
-* -> parent kills the child with SIGABRT, then post the semaphore.
+* -> acquired a file lock
+* -> create a child process
+* -> child registers a handler for SIGABRT with SA_RESTART, then blocked at fcntl
+* -> parent kills the child with SIGABRT, then release the lock
 
-* The test fails if the sem_wait function returns EINTR
+* The test fails if the fcntl function returns EINTR
 
 *Note:
-This test uses sem_wait to check if EINTR is returned. As the function is not required to
+This test uses fcntl to check if EINTR is returned. As the function is not required to
 fail with EINTR, the test may return PASS and the feature not be correct (false positive).
 Anyway, a false negative status cannot be returned.
 
@@ -51,9 +52,11 @@ Anyway, a false negative status cannot be returned.
 #include <string.h>
 #include <unistd.h>
 
-#include <semaphore.h>
 #include <signal.h>
 #include <errno.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
 
 /******************************************************************************/
 /***************************   Test framework   *******************************/
@@ -92,128 +95,129 @@ Anyway, a false negative status cannot be returned.
 /***************************    Test case   ***********************************/
 /******************************************************************************/
 
-volatile sig_atomic_t caught = 0;
-sem_t sem;
-
 /* Handler function */
 void handler( int signo )
 {
 	printf( "Caught signal %d\n", signo );
-	caught++;
-}
-
-/* Thread function */
-void * threaded ( void * arg )
-{
-	int ret = 0;
-
-	ret = sem_wait( &sem );
-
-	if ( ret != 0 )
-	{
-		if ( errno == EINTR )
-		{
-			FAILED( "The function returned EINTR while SA_RESTART is set" );
-		}
-		else
-		{
-			UNRESOLVED( errno, "sem_wait failed" );
-		}
-	}
-
-	return NULL;
 }
 
 /* main function */
 int main()
 {
 	int ret;
-	pthread_t child;
-
+	pid_t pid;
+	int lockfd;
+	struct flock fl;
+	char tmpfname[256];
+	int status; 
 
-	struct sigaction sa;
+	snprintf(tmpfname, sizeof(tmpfname), "/tmp/sigaction_16_1_%d", getpid());
+	unlink(tmpfname);
 
 	/* Initialize output */
 	output_init();
 
-	/* Set the signal handler */
-	sa.sa_flags = SA_RESTART;
-	sa.sa_handler = handler;
-	ret = sigemptyset( &sa.sa_mask );
-
-	if ( ret != 0 )
-	{
-		UNRESOLVED( ret, "Failed to empty signal set" );
-	}
-
-	/* Install the signal handler for SIGNAL */
-	ret = sigaction( SIGNAL, &sa, 0 );
-
-	if ( ret != 0 )
-	{
-		UNRESOLVED( ret, "Failed to set signal handler" );
+	/*create a tmp file for test.*/
+	lockfd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
+	if (lockfd == -1) {
+		printf("Error at create file: %s\n", strerror(errno));
+		return PTS_UNRESOLVED;
 	}
-
-	/* Initialize the semaphore */
-	ret = sem_init( &sem, 0, 0 );
-
-	if ( ret != 0 )
-	{
-		UNRESOLVED( ret, "Failed to init a semaphore" );
+	unlink(tmpfname);
+
+	/* lock the file first */
+	memset(&fl, 0, sizeof(struct flock));
+	fl.l_type = F_WRLCK;
+	fl.l_whence = SEEK_SET;
+	fl.l_start = 0;
+	fl.l_len = 0;
+	fl.l_pid = getpid();
+	if (-1 == fcntl(lockfd, F_SETLKW, &fl)) {
+		printf("Failed to acquire write lock: %s\n", strerror(errno));
+		return PTS_UNRESOLVED;
 	}
 
-	/* Create the child thread */
-	ret = pthread_create( &child, NULL, threaded, NULL );
-
-	if ( ret != 0 )
-	{
-		UNRESOLVED( ret, "Failed to create a child thread" );
-	}
-
-	/* Let the child thread enter the wait routine...
-	  we use sched_yield as there is no certain way to test that the child
-	  is waiting for the semaphore... */
-	sched_yield();
+	pid = fork();
+	if (pid < 0) {
+		printf("Failed to fork: %s\n", strerror(errno));
+		return PTS_UNRESOLVED;
+	} else if (pid == 0) {
+		struct sigaction sa;
+
+		/* Set the signal handler */
+		sa.sa_flags = SA_RESTART;
+		sa.sa_handler = handler;
+
+		ret = sigemptyset(&sa.sa_mask);
+		if(ret != 0) {
+			printf("Failed to empty signal set: %s\n",
+				strerror(errno));
+			exit(PTS_UNRESOLVED);
+		}
 
-	sched_yield();
+		/* Install the signal handler for SIGNAL */
+		ret = sigaction(SIGNAL, &sa, 0);
+		if (ret != 0) {
+			printf("Failed to set signal handler: %s\n",
+				strerror(errno));
+			exit(PTS_UNRESOLVED);
+		}
 
-	sched_yield();
+		/* block self */
+		memset(&fl, 0, sizeof(struct flock));
+		fl.l_type = F_WRLCK;
+		fl.l_whence = SEEK_SET;
+		fl.l_start = 0;
+		fl.l_len = 0;
+		fl.l_pid = getpid();
+
+		if (-1 == fcntl(lockfd, F_SETLKW, &fl)) {
+			if (errno == EINTR) {
+				printf("The function returned EINTR while "
+				       "SA_RESTART is set\n");
+			} else {
+				printf("Failed with unexpected error: %s\n",
+				       strerror(errno));
+			}
+			exit(PTS_FAIL);
+		}
 
-	/* Ok, now kill the child */
-	ret = pthread_kill( child, SIGNAL );
+		fl.l_type = F_UNLCK;
+		if (-1 == fcntl(lockfd, F_SETLKW, &fl)) {
+			printf("Failed to remove lock: %s\n", strerror(errno));
+			exit(PTS_UNRESOLVED);
+		}
 
-	if ( ret != 0 )
-	{
-		UNRESOLVED( ret, "Failed to kill the child thread" );
+		exit(PTS_PASS);
 	}
 
-	/* wait that the child receives the signal */
-	while ( !caught )
-		sched_yield();
+	/* make sure child has blocked at fcntl */
+	sleep(2);
 
-	/* Now let the child run and terminate */
-	ret = sem_post( &sem );
+	kill(pid, SIGNAL);
 
-	if ( ret != 0 )
-	{
-		UNRESOLVED( errno, "Failed to post the semaphore" );
-	}
+	/* make sure fcntl has enough time to restart */
+	sleep(2);
 
-	ret = pthread_join( child, NULL );
-
-	if ( ret != 0 )
-	{
-		UNRESOLVED( ret, "Failed to join the thread" );
+	/* release lock to make sure child can acquire it */
+	fl.l_type = F_UNLCK;
+	if (fcntl(lockfd, F_SETLKW, &fl) == -1) {
+		printf("Failed to remove lock: %s\n", strerror(errno));
+		return PTS_UNRESOLVED;
 	}
 
-	/* terminate */
-	ret = sem_destroy( &sem );
-
-	if ( ret != 0 )
-	{
-		UNRESOLVED( ret, "Failed to destroy the semaphore" );
+	ret = waitpid(pid, &status, 0);
+	if (ret != pid) {
+		printf("Failed to waitpid\n");
+		return PTS_UNRESOLVED;
 	}
 
+	if (WIFEXITED(status)) {
+		if ((ret = WEXITSTATUS(status)) != PTS_PASS)
+			return ret;
+	} else {
+		return PTS_UNRESOLVED;
+	}
 
 	/* Test passed */
 #if VERBOSE > 0
@@ -222,5 +226,5 @@ int main()
 
 #endif
 
-	PASSED;
+	return PTS_PASS;
 }
-- 
1.7.0.4



-- 
Regards
Bian Naimeng


------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
