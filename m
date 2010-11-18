Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PJ92n-0008QM-0I
	for ltp-list@lists.sourceforge.net; Thu, 18 Nov 2010 18:17:13 +0000
Date: Thu, 18 Nov 2010 19:29:01 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101118182901.GC19296@saboteur.suse.cz>
References: <4CDB5E53.6070604@cn.fujitsu.com> <4CDB6039.2050200@cn.fujitsu.com>
	<20101111145155.GB24599@saboteur.suse.cz>
	<4CDCA278.8080301@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4CDCA278.8080301@cn.fujitsu.com>
Subject: Re: [LTP] [POSIX][PATCH 1/2][v2]Use aio_error instead signal hander
 at aio_suspend/1-1
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
>  .../conformance/interfaces/aio_suspend/1-1.c       |   51 +++++++-------------
>  1 files changed, 17 insertions(+), 34 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/1-1.c
> index 7d33e62..8c85ca5 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/1-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/1-1.c
> @@ -44,19 +44,11 @@
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
> @@ -123,30 +115,19 @@ main ()
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
> @@ -155,7 +136,8 @@ main ()
>  	ret = lio_listio(LIO_NOWAIT, aiocbs, NUM_AIOCBS, &event);
>  
>  	if (ret) {
> -		printf(TNAME " Error at lio_listio() %d: %s\n", errno, strerror(errno));
> +		printf (TNAME " Error at lio_listio() %d: %s\n",
> +			errno, strerror(errno));

According to lkml coding style (that we are trying to use here), space
should be only between C keywords and (). Not betweeen library calls
like printf and so.

>  		for (i=0; i<NUM_AIOCBS; i++)
>  			free (aiocbs[i]);
>  		free (bufs);
> @@ -165,9 +147,10 @@ main ()
>  	}
>  
>  	/* Check selected request has not completed yet */
> -	if (received_selected) {
> -		printf (TNAME " Error : AIOCB %d already completed before suspend\n",
> -			WAIT_FOR_AIOCB);
> +	err = aio_error(aiocbs[WAIT_FOR_AIOCB]);
> +	if (err != EINPROGRESS) {
> +		printf (TNAME " Error : AIOCB %d should not have completed "
> +			"before suspend\n", WAIT_FOR_AIOCB);
>  		for (i=0; i<NUM_AIOCBS; i++)
>  			free (aiocbs[i]);
>  		free (bufs);
....
>		exit(PTS_FAIL);
>}

Another problem lies here. The test relies that aio operation in not
finished when we got here. And as some linux kernels fallbacks aio as
synchronous IO, when we got there, it's allready finished. So I think we
should change this PTS_FAIL to PTS_UNRESOLVED.

Garrett what you think?


> @@ -178,11 +161,9 @@ main ()
>  
>  	/* Suspend on selected request */
>  	ret = aio_suspend((const struct aiocb **)plist, 2, NULL);

Please remove useless cast to (const struct aiocb**)

> -
> -	/* Check selected request has completed */
> -	if (!received_selected) {
> -		printf (TNAME " Error : AIOCB %d should have completed after suspend\n",
> -			WAIT_FOR_AIOCB);
> +	if (ret) {
> +		printf (TNAME " Error at aio_suspend() %d: %s\n",
> +			errno, strerror (errno));
>  		for (i=0; i<NUM_AIOCBS; i++)
>  			free (aiocbs[i]);
>  		free (bufs);
> @@ -191,9 +172,11 @@ main ()
>  		exit (PTS_FAIL);
>  	}

Here again with the printf.
  
> -
> -	if (ret) {
> -		printf (TNAME " Error at aio_suspend() %d: %s\n", errno, strerror (errno));
> +	/* Check selected request has completed */
> +	err = aio_error(aiocbs[WAIT_FOR_AIOCB]);
> +	if (err) {
> +		printf (TNAME " Error : AIOCB %d should have completed after "
> +			"suspend\n", WAIT_FOR_AIOCB);
>  		for (i=0; i<NUM_AIOCBS; i++)
>  			free (aiocbs[i]);
>  		free (bufs);

And here.

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
