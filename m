Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PGYKQ-0005Id-QM
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 14:40:42 +0000
Date: Thu, 11 Nov 2010 15:51:55 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101111145155.GB24599@saboteur.suse.cz>
References: <4CDB5E53.6070604@cn.fujitsu.com> <4CDB6039.2050200@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4CDB6039.2050200@cn.fujitsu.com>
Subject: Re: [LTP] [POSIX][PATCH 1/2]Use aio_error instead signal hander at
 aio_suspend/1-1
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
>  .../conformance/interfaces/aio_suspend/1-1.c       |   49 +++++++------------
>  1 files changed, 18 insertions(+), 31 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/1-1.c
> index 7d33e62..63d986e 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/1-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/1-1.c
> @@ -44,18 +44,23 @@
>  #define BUF_SIZE	1024*1024
>  #define WAIT_FOR_AIOCB	6
>  
> -int received_selected	= 0;
>  int received_all	= 0;
>  
> -void
> -sigrt1_handler(int signum, siginfo_t *info, void *context)
> +int selected_request_status(struct aiocb *paiocb, int expect)
>  {
> -	if (info->si_value.sival_int == WAIT_FOR_AIOCB)
> -		received_selected = 1;
> +	int err = aio_error(paiocb);
> +
> +	if (err != expect) {
> +		printf (TNAME " Selected request expect %d[%s], not %d[%s]\n",
> +			expect, strerror(expect), err, strerror(err));
> +		return 0;
> +	}
> +
> +	return 1;
>  }
>  
>  void
> -sigrt2_handler(int signum, siginfo_t *info, void *context)
> +sigrt1_handler(int signum, siginfo_t *info, void *context)
>  {
>  	received_all = 1;
>  }
> @@ -123,37 +128,25 @@ main ()
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
>  	/* Use SIGRTMIN+2 for list completion */
>  	event.sigev_notify = SIGEV_SIGNAL;
> -	event.sigev_signo = SIGRTMIN+2;
> +	event.sigev_signo = SIGRTMIN+1;
>  	event.sigev_value.sival_ptr = NULL;

Fix comment here.

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
>  
>  	/* Submit request list */
>  	ret = lio_listio(LIO_NOWAIT, aiocbs, NUM_AIOCBS, &event);
> -

No need to remove newline here.

>  	if (ret) {
>  		printf(TNAME " Error at lio_listio() %d: %s\n", errno, strerror(errno));
>  		for (i=0; i<NUM_AIOCBS; i++)
> @@ -165,9 +158,7 @@ main ()
>  	}
>  
>  	/* Check selected request has not completed yet */
> -	if (received_selected) {
> -		printf (TNAME " Error : AIOCB %d already completed before suspend\n",
> -			WAIT_FOR_AIOCB);
> +	if (!selected_request_status(aiocbs[WAIT_FOR_AIOCB], EINPROGRESS)) {
>  		for (i=0; i<NUM_AIOCBS; i++)
>  			free (aiocbs[i]);
>  		free (bufs);

Any particular need to removing the printf() here?

> @@ -178,11 +169,8 @@ main ()
>  
>  	/* Suspend on selected request */
>  	ret = aio_suspend((const struct aiocb **)plist, 2, NULL);
> -
> -	/* Check selected request has completed */
> -	if (!received_selected) {
> -		printf (TNAME " Error : AIOCB %d should have completed after suspend\n",
> -			WAIT_FOR_AIOCB);
> +	if (ret) {
> +		printf (TNAME " Error at aio_suspend() %d: %s\n", errno, strerror (errno));
>  		for (i=0; i<NUM_AIOCBS; i++)
>  			free (aiocbs[i]);
>  		free (bufs);
> @@ -191,9 +179,8 @@ main ()
>  		exit (PTS_FAIL);
>  	}
>
> -
> -	if (ret) {
> -		printf (TNAME " Error at aio_suspend() %d: %s\n", errno, strerror (errno));
> +	/* Check selected request has completed */
> +	if (!selected_request_status(aiocbs[WAIT_FOR_AIOCB], 0)) {
>  		for (i=0; i<NUM_AIOCBS; i++)
>  			free (aiocbs[i]);
>  		free (bufs);

And here.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Centralized Desktop Delivery: Dell and VMware Reference Architecture
Simplifying enterprise desktop deployment and management using
Dell EqualLogic storage and VMware View: A highly scalable, end-to-end
client virtualization framework. Read more!
http://p.sf.net/sfu/dell-eql-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
