Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PJ98P-0002W4-NZ
	for ltp-list@lists.sourceforge.net; Thu, 18 Nov 2010 18:23:01 +0000
Date: Thu, 18 Nov 2010 19:34:51 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101118183451.GD19296@saboteur.suse.cz>
References: <4CDB5E53.6070604@cn.fujitsu.com> <4CDB609E.105@cn.fujitsu.com>
	<20101111150012.GC24599@saboteur.suse.cz>
	<4CDCA2D6.1020106@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4CDCA2D6.1020106@cn.fujitsu.com>
Subject: Re: [LTP] [POSIX][PATCH 2/2][V2]Use aio_error instead signal hander
 at aio_suspend/4-1
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
To: Bian Naimeng <biannm@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> aio_suspend may be interrupted by IO request's completion signal, so we
> should use aio_error instead signal hander to check whether this request
> has complete.
> 
> Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>
> 
> ---
>  .../conformance/interfaces/aio_suspend/4-1.c       |   62 ++++++--------------
>  1 files changed, 18 insertions(+), 44 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/4-1.c
> index 260c26a..bb90234 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/4-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/4-1.c
> @@ -41,19 +41,11 @@
>  #define BUF_SIZE	1024*1024
>  #define WAIT_FOR_AIOCB	6
>  
> -int received_selected	= 0;
>  int received_all	= 0;
>  
>  void
>  sigrt1_handler(int signum, siginfo_t *info, void *context)
>  {
> -	if (info->si_value.sival_int == WAIT_FOR_AIOCB)
> -		received_selected = 1;
> -}
> -
> -void
> -sigrt2_handler(int signum, siginfo_t *info, void *context)
> -{
>  	received_all = 1;
>  }
>  
> @@ -68,7 +60,7 @@ main ()
>  	char *bufs;
>  	struct sigaction action;
>  	struct sigevent event;
> -	struct timespec ts = {0, 10000000}; /* 10 ms */
> +	struct timespec ts = {0, 1000}; /* 1 us */
>  	int errors = 0;
>  	int ret;
>  	int err;
> @@ -121,30 +113,19 @@ main ()
>  		aiocbs[i]->aio_buf = &bufs[i*BUF_SIZE];
>  		aiocbs[i]->aio_nbytes = BUF_SIZE;
>  		aiocbs[i]->aio_lio_opcode = LIO_READ;
> -
> -		/* Use SIRTMIN+1 for individual completions */
> -		aiocbs[i]->aio_sigevent.sigev_notify = SIGEV_SIGNAL;
> -		aiocbs[i]->aio_sigevent.sigev_signo = SIGRTMIN+1;
> -		aiocbs[i]->aio_sigevent.sigev_value.sival_int = i;
>  	}
>  
> -	/* Use SIGRTMIN+2 for list completion */
> +	/* Use SIGRTMIN+1 for list completion */
>  	event.sigev_notify = SIGEV_SIGNAL;
> -	event.sigev_signo = SIGRTMIN+2;
> +	event.sigev_signo = SIGRTMIN+1;
>  	event.sigev_value.sival_ptr = NULL;
>  
> -	/* Setup handler for individual operation completion */
> +	/* Setup handler for list completion */
>  	action.sa_sigaction = sigrt1_handler;
>  	sigemptyset(&action.sa_mask);
>  	action.sa_flags = SA_SIGINFO|SA_RESTART;
>  	sigaction(SIGRTMIN+1, &action, NULL);
>  
> -	/* Setup handler for list completion */
> -	action.sa_sigaction = sigrt2_handler;
> -	sigemptyset(&action.sa_mask);
> -	action.sa_flags = SA_SIGINFO|SA_RESTART;
> -	sigaction(SIGRTMIN+2, &action, NULL);
> -
>  	/* Setup suspend list */
>  	plist[0] = NULL;
>  	plist[1] = aiocbs[WAIT_FOR_AIOCB];
> @@ -153,7 +134,8 @@ main ()
>  	ret = lio_listio(LIO_NOWAIT, aiocbs, NUM_AIOCBS, &event);
>  
>  	if (ret) {
> -		printf(TNAME " Error at lio_listio() %d: %s\n", errno, strerror(errno));
> +		printf (TNAME " Error at lio_listio() %d: %s\n",
> +			errno, strerror(errno));
>  		for (i=0; i<NUM_AIOCBS; i++)
>  			free (aiocbs[i]);
>  		free (bufs);

Once again, space here.

> @@ -163,9 +145,10 @@ main ()
>  	}
>  
>  	/* Check selected request has not completed yet */
> -	if (received_selected) {
> -		printf (TNAME " Error : AIOCB %d already completed before suspend\n",
> -			WAIT_FOR_AIOCB);
> +	err = aio_error(aiocbs[WAIT_FOR_AIOCB]);
> +	if (err !=  EINPROGRESS) {
> +		printf (TNAME " Error : AIOCB %d should not have completed "
> +			"before suspend\n", WAIT_FOR_AIOCB);
>  		for (i=0; i<NUM_AIOCBS; i++)
>  			free (aiocbs[i]);
>  		free (bufs);
...
>		exit(PTS_FAIL);
>	}

Spaces after printf and free.

And the same problem with relying on AIO operation not finished yet. So
I propose to change this PTS_FAIL to PTS_UNRESOLVED.

> @@ -177,21 +160,10 @@ main ()
>  	/* Suspend on selected request */
>  	ret = aio_suspend((const struct aiocb **)plist, 2, &ts);

Useless cast.

> -	/* Check selected request has not completed */
> -	if (received_selected) {
> -		printf (TNAME " Error : AIOCB %d should not have completed after timed out suspend\n",
> -			WAIT_FOR_AIOCB);
> -		for (i=0; i<NUM_AIOCBS; i++)
> -			free (aiocbs[i]);
> -		free (bufs);
> -		free (aiocbs);
> -		close (fd);
> -		exit (PTS_FAIL);
> -	}
> -
>  	/* timed out aio_suspend should return -1 and set errno to EAGAIN */
> -	if (ret != -1) {
> -		printf (TNAME " aio_suspend() should return -1\n");
> +	if (ret != -1 || errno != EAGAIN) {
> +		printf (TNAME " aio_suspend() should return -1 and set errno "
> +			"to EAGAIN: %d, %s\n", ret, strerror(errno));
>  		for (i=0; i<NUM_AIOCBS; i++)
>  			free (aiocbs[i]);
>  		free (bufs);
> @@ -200,9 +172,11 @@ main ()
>  		exit (PTS_FAIL);
>  	}

Spaces after free and exit.

> -	if (errno != EAGAIN) {
> -		printf (TNAME " aio_suspend() should set errno to EAGAIN: %d (%s)\n",
> -			errno, strerror (errno));
> +	/* Check selected request has not completed */
> +	err = aio_error(aiocbs[WAIT_FOR_AIOCB]);
> +	if (err !=  EINPROGRESS) {
> +		printf (TNAME " Error : AIOCB %d should not have completed "
> +			"after timed out suspend\n", WAIT_FOR_AIOCB);
>  		for (i=0; i<NUM_AIOCBS; i++)
>  			free (aiocbs[i]);
>  		free (bufs);

And here spaces after printf and free.

-- 
Cyril Hrubis
chrubis@suse.cz

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
