Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1V9GIG-0003BK-Jo
	for ltp-list@lists.sourceforge.net; Tue, 13 Aug 2013 15:13:56 +0000
Date: Tue, 13 Aug 2013 17:13:57 +0200
From: chrubis@suse.cz
Message-ID: <20130813151357.GE29233@rei>
References: <c6bfd2f062e27984837f94e4d333657fae5cd65e.1375280397.git.jstancek@redhat.com>
	<364946f8001c14134ce7bf32fe8b5c6b5201bcfb.1376399706.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <364946f8001c14134ce7bf32fe8b5c6b5201bcfb.1376399706.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH v4 2/2] open_posix_testsuite/../mq_timedsend/12-1:
 fix race
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

>  /*
>   * This handler is just used to catch the signal and stop sleep (so the
> @@ -59,12 +59,10 @@ int errno_eintr;
>   */
>  void justreturn_handler(int signo)
>  {
> -	/* Indicate that the signal handler was called */
> -	in_handler = 1;
> -	return;
> +	in_handler++;
>  }
>  
> -void *a_thread_func()
> +void *a_thread_func(void *arg)
>  {
>  	int i, ret;
>  	struct sigaction act;
> @@ -86,101 +84,111 @@ void *a_thread_func()
>  	attr.mq_maxmsg = MAXMSG;
>  	attr.mq_msgsize = BUFFER;
>  	gqueue = mq_open(gqname, O_CREAT | O_RDWR, S_IRUSR | S_IWUSR, &attr);
> -	if (gqueue == (mqd_t) - 1) {
> -		perror("mq_open() did not return success");
> -		pthread_exit((void *)PTS_UNRESOLVED);
> -		return NULL;
> -	}
> +	if (gqueue == (mqd_t) -1)
> +		error_and_exit(errno, "mq_open");
>  
> -	/* mq_timedsend will block for 10 seconds when it waits */
> -	ts.tv_sec = time(NULL) + 10;
> +	/* mq_timedsend will block for TIMEOUT seconds when it waits */
> +	ts.tv_sec = time(NULL) + TIMEOUT;
>  	ts.tv_nsec = 0;
>  
> -	/* Tell main it can go ahead and start sending SIGUSR1 signal */
> -	sem = INMAIN;
> +	/* main can now start sending SIGUSR1 signal */
> +	ret = pthread_barrier_wait(&barrier);
> +	if (ret != 0 && ret != PTHREAD_BARRIER_SERIAL_THREAD)
> +		error_and_exit(ret, "pthread_barrier_wait start");
>  
>  	for (i = 0; i < MAXMSG + 1; i++) {
>  		ret = mq_timedsend(gqueue, msgptr, strlen(msgptr), 1, &ts);
> -		if (ret	!= -1)
> -			continue;
> -
> -		if (errno == EINTR) {
> -			if (mq_unlink(gqname) != 0) {
> -				perror("mq_unlink() did not return success");
> -				pthread_exit((void *)PTS_UNRESOLVED);
> -				return NULL;
> -			}
> -			printf("thread: mq_timedsend interrupted by signal"
> -				" and correctly set errno to EINTR\n");
> -			errno_eintr = 1;
> -			pthread_exit((void *)PTS_PASS);
> -			return NULL;
> -		} else {
> -			printf("mq_timedsend not interrupted by signal or"
> -				" set errno to incorrect code: %d\n", errno);
> -			pthread_exit((void *)PTS_FAIL);
> -			return NULL;
> +		if (ret == -1) {
> +			mq_timedsend_errno = errno;
> +			break;
>  		}
>  	}
>  
> -	/* Tell main that it the thread did not block like it should have */
> -	sem = INTHREAD;
> +	if (mq_unlink(gqname) != 0)
> +		error_and_exit(errno, "mq_unlink");
> +
> +	switch (mq_timedsend_errno) {
> +	case -1:
> +		mq_timedsend_errno = 0;
> +		printf("Error: mq_timedsend wasn't interrupted\n");
> +		break;
> +	case EINTR:
> +		printf("thread: mq_timedsend interrupted by signal"
> +			" and correctly set errno to EINTR\n");
> +		break;
> +	default:
> +		printf("mq_timedsend not interrupted by signal or"
> +			" set errno to incorrect code: %d\n",
> +			mq_timedsend_errno);
> +		break;
> +	}
> +
> +	/* wait until main stops sending signals */
> +	ret = pthread_barrier_wait(&barrier);
> +	if (ret != 0 && ret != PTHREAD_BARRIER_SERIAL_THREAD)
> +		error_and_exit(ret, "pthread_barrier_wait end");
>  
> -	perror("Error: thread never blocked\n");
> -	pthread_exit((void *)PTS_FAIL);
> -	return NULL;
> +	if (mq_timedsend_errno == EINTR)
> +		pthread_exit((void *)PTS_PASS);
> +	else
> +		pthread_exit((void *)PTS_FAIL);

Are these even used? The pthread_join() below has NULL parameter and the
mq_timedsend_errno is used directly.

The rests looks OK.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
