Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1PJMoY-0003br-97
	for ltp-list@lists.sourceforge.net; Fri, 19 Nov 2010 08:59:26 +0000
Received: from out16.sjc.mx.trendmicro.com ([216.99.131.73])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PJMoW-0001L4-HJ
	for ltp-list@lists.sourceforge.net; Fri, 19 Nov 2010 08:59:26 +0000
From: "Mitani" <mitani@ryobi.co.jp>
References: <4CE61F95.0@cn.fujitsu.com>
In-Reply-To: <4CE61F95.0@cn.fujitsu.com>
Date: Fri, 19 Nov 2010 17:59:13 +0900
Message-ID: <000701cb87c8$09b09ed0$1d11dc70$@co.jp>
MIME-Version: 1.0
Content-Language: ja
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
To: 'Bian Naimeng' <biannm@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

> -----Original Message-----
> From: Bian Naimeng [mailto:biannm@cn.fujitsu.com]
> Sent: Friday, November 19, 2010 3:56 PM
> To: Garrett Cooper
> Cc: Mitani; ltp-list@lists.sourceforge.net
> Subject: [LTP][POSIX][PATCH]Instead sem_wait by fcntl for sigaction
> test.
> 
> Some days before, mitani-san reported some sigaction test failed at
> linux,
> http://sourceforge.net/mailarchive/message.php?msg_id=000001cb798d
> %241aaa0210%244ffe0630%24%40co.jp
> 
> As Garrett said, add Linux-isms is not advisably. So i want try to fix
> it by another method.
> 
> I have seen the assertions.xml, these tests want to test sigaction with
> SA_RESTART
> not sem_wait(it looks like there's a bug at older linux kernel), so
> i suggest to
> instead sem_wait by fcntl.
> 
> What about this one?  If you agree with me, i will post other patchs.
> 
> ------------------------------------------------------------------
> -------------------
> At older linux kernel(2.6.22 before), a signal handler always
> interrupts a
> blocked call to sem_wait, regardless of the use of the sigaction
> SA_RESTART flag. So instead it by fcntl.
> 
> Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>
> 
> ---
>  .../conformance/interfaces/sigaction/16-1.c        |  201
> ++++++++++----------
>  1 files changed, 103 insertions(+), 98 deletions(-)
> 
> diff --git
> a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/
> 16-1.c
> b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/
> 16-1.c
> index 706dbfc..752dcb9 100644
> ---
> a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/
> 16-1.c
> +++
> b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/
> 16-1.c
> @@ -21,14 +21,15 @@
>  * shall restart silently.
> 
>  * The steps are:
> -* -> create a child thread
> -* -> child registers a handler for SIGABRT with SA_RESTART, then waits
> for the semaphore
> -* -> parent kills the child with SIGABRT, then post the semaphore.
> +* -> acquired a file lock
> +* -> create a child process
> +* -> child registers a handler for SIGABRT with SA_RESTART, then
> blocked at fcntl
> +* -> parent kills the child with SIGABRT, then release the lock
> 
> -* The test fails if the sem_wait function returns EINTR
> +* The test fails if the fcntl function returns EINTR
> 
>  *Note:
> -This test uses sem_wait to check if EINTR is returned. As the function
> is not required to
> +This test uses fcntl to check if EINTR is returned. As the function
> is not required to
>  fail with EINTR, the test may return PASS and the feature not be
> correct (false positive).
>  Anyway, a false negative status cannot be returned.
> 
> @@ -51,9 +52,11 @@ Anyway, a false negative status cannot be returned.
>  #include <string.h>
>  #include <unistd.h>
> 
> -#include <semaphore.h>
>  #include <signal.h>
>  #include <errno.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> 
> 
> /*****************************************************************
> *************/
>  /***************************   Test framework
> *******************************/
> @@ -92,128 +95,130 @@ Anyway, a false negative status cannot be
> returned.
>  /***************************    Test case
> ***********************************/
> 
> /*****************************************************************
> *************/
> 
> -volatile sig_atomic_t caught = 0;
> -sem_t sem;
> -
>  /* Handler function */
>  void handler( int signo )
>  {
>  	printf( "Caught signal %d\n", signo );
> -	caught++;
> -}
> -
> -/* Thread function */
> -void * threaded ( void * arg )
> -{
> -	int ret = 0;
> -
> -	ret = sem_wait( &sem );
> -
> -	if ( ret != 0 )
> -	{
> -		if ( errno == EINTR )
> -		{
> -			FAILED( "The function returned EINTR while
> SA_RESTART is set" );
> -		}
> -		else
> -		{
> -			UNRESOLVED( errno, "sem_wait failed" );
> -		}
> -	}
> -
> -	return NULL;
>  }
> 
>  /* main function */
>  int main()
>  {
>  	int ret;
> -	pthread_t child;
> -
> +	pid_t pid;
> +	int lockfd;
> +	struct flock fl;
> +	char tmpfname[256];
> +	int status;
> 
> -	struct sigaction sa;
> +	snprintf(tmpfname, sizeof(tmpfname),
> "/tmp/sigaction_16_1_%d", getpid());
> +	unlink(tmpfname);
> 
>  	/* Initialize output */
>  	output_init();
> 
> -	/* Set the signal handler */
> -	sa.sa_flags = SA_RESTART;
> -	sa.sa_handler = handler;
> -	ret = sigemptyset( &sa.sa_mask );
> -
> -	if ( ret != 0 )
> -	{
> -		UNRESOLVED( ret, "Failed to empty signal set" );
> -	}
> -
> -	/* Install the signal handler for SIGNAL */
> -	ret = sigaction( SIGNAL, &sa, 0 );
> -
> -	if ( ret != 0 )
> -	{
> -		UNRESOLVED( ret, "Failed to set signal handler" );
> +	/*create a tmp file for test.*/
> +	lockfd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR |
> S_IWUSR);
> +	if (lockfd == -1) {
> +		printf("Error at create file: %s\n",
> strerror(errno));
> +		return PTS_UNRESOLVED;
>  	}
> -
> -	/* Initialize the semaphore */
> -	ret = sem_init( &sem, 0, 0 );
> -
> -	if ( ret != 0 )
> -	{
> -		UNRESOLVED( ret, "Failed to init a semaphore" );
> +	unlink(tmpfname);
> +
> +	/* lock the file first */
> +	memset(&fl, 0, sizeof(struct flock));
> +	fl.l_type = F_WRLCK;
> +	fl.l_whence = SEEK_SET;
> +	fl.l_start = 0;
> +	fl.l_len = 0;
> +	fl.l_pid = getpid();
> +	if (-1 == fcntl(lockfd, F_SETLKW, &fl)) {
> +		printf("Failed to acquire write lock: %s\n",
> strerror(errno));
> +		return PTS_UNRESOLVED;
>  	}
> 
> -	/* Create the child thread */
> -	ret = pthread_create( &child, NULL, threaded, NULL );
> -
> -	if ( ret != 0 )
> -	{
> -		UNRESOLVED( ret, "Failed to create a child thread" );
> -	}
> -
> -	/* Let the child thread enter the wait routine...
> -	  we use sched_yield as there is no certain way to test that
> the child
> -	  is waiting for the semaphore... */
> -	sched_yield();
> +	pid = fork();
> +	if (pid < 0) {
> +		printf("Failed to fork: %s\n", strerror(errno));
> +		return PTS_UNRESOLVED;
> +	} else if (pid == 0) {
> +		struct sigaction sa;
> +
> +		/* Set the signal handler */
> +		sa.sa_flags = SA_RESTART;
> +		sa.sa_flags = 0;
> +		sa.sa_handler = handler;
> +
> +		ret = sigemptyset(&sa.sa_mask);
> +		if(ret != 0) {
> +			printf("Failed to empty signal set: %s\n",
> +				strerror(errno));
> +			exit(PTS_UNRESOLVED);
> +		}
> 
> -	sched_yield();
> +		/* Install the signal handler for SIGNAL */
> +		ret = sigaction(SIGNAL, &sa, 0);
> +		if (ret != 0) {
> +			printf("Failed to set signal handler: %s\n",
> +				strerror(errno));
> +			exit(PTS_UNRESOLVED);
> +		}
> 
> -	sched_yield();
> +		/* block self */
> +		memset(&fl, 0, sizeof(struct flock));
> +		fl.l_type = F_WRLCK;
> +		fl.l_whence = SEEK_SET;
> +		fl.l_start = 0;
> +		fl.l_len = 0;
> +		fl.l_pid = getpid();
> +
> +		if (-1 == fcntl(lockfd, F_SETLKW, &fl)) {
> +			if (errno == EINTR) {
> +				printf("The function returned EINTR
> while "
> +				       "SA_RESTART is set\n");
> +			} else {
> +				printf("Failed with unexpected
> error: %s\n",
> +				       strerror(errno));
> +			}
> +			exit(PTS_FAIL);
> +		}
> 
> -	/* Ok, now kill the child */
> -	ret = pthread_kill( child, SIGNAL );
> +		fl.l_type = F_UNLCK;
> +		if (-1 == fcntl(lockfd, F_SETLKW, &fl)) {
> +			printf("Failed to remove lock: %s\n",
> strerror(errno));
> +			exit(PTS_UNRESOLVED);
> +		}
> 
> -	if ( ret != 0 )
> -	{
> -		UNRESOLVED( ret, "Failed to kill the child thread" );
> +		exit(PTS_PASS);
>  	}
> 
> -	/* wait that the child receives the signal */
> -	while ( !caught )
> -		sched_yield();
> +	/* make sure child has blocked at fcntl */
> +	sleep(2);
> 
> -	/* Now let the child run and terminate */
> -	ret = sem_post( &sem );
> +	kill(pid, SIGNAL);
> 
> -	if ( ret != 0 )
> -	{
> -		UNRESOLVED( errno, "Failed to post the semaphore" );
> -	}
> +	/* make sure fcntl has enough time to restart */
> +	sleep(2);
> 
> -	ret = pthread_join( child, NULL );
> -
> -	if ( ret != 0 )
> -	{
> -		UNRESOLVED( ret, "Failed to join the thread" );
> +	/* release lock to make sure child can acquire it */
> +	fl.l_type = F_UNLCK;
> +	if (fcntl(lockfd, F_SETLKW, &fl) == -1) {
> +		printf("Failed to remove lock: %s\n",
> strerror(errno));
> +		return PTS_UNRESOLVED;
>  	}
> 
> -	/* terminate */
> -	ret = sem_destroy( &sem );
> -
> -	if ( ret != 0 )
> -	{
> -		UNRESOLVED( ret, "Failed to destroy the semaphore" );
> +	ret = waitpid(pid, &status, 0);
> +	if (ret != pid) {
> +		printf("Failed to waitpid\n");
> +		return PTS_UNRESOLVED;
>  	}
> 
> +	if (WIFEXITED(status)) {
> +		if ((ret = WEXITSTATUS(status)) != PTS_PASS)
> +			return ret;
> +	} else {
> +		return PTS_UNRESOLVED;
> +	}
> 
>  	/* Test passed */
>  #if VERBOSE > 0
> @@ -222,5 +227,5 @@ int main()
> 
>  #endif
> 
> -	PASSED;
> +	return PTS_PASS;
>  }
> --
> 1.7.0.4
> 
> 
> 
> 
> 
> --
> Regards
> Bian Naimeng


I tried Bian's patch:
------------
[root@RHEL55-LTP-x86 sigaction]# make
conformance/interfaces/sigaction/16-1 compile PASSED
[root@RHEL55-LTP-x86 sigaction]# ./16-1.run-test
Caught signal 6
The function returned EINTR while SA_RESTART is set
[root@RHEL55-LTP-x86 sigaction]# echo $?
1
[root@RHEL55-LTP-x86 sigaction]#
------------

It failed, but "Caught signal 6" indicated.
It shows that a signal is pitched and was received.


Thank you--

-Tomonori Mitani



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
