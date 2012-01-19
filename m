Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RnsXQ-0008A2-Ap
	for ltp-list@lists.sourceforge.net; Thu, 19 Jan 2012 14:00:24 +0000
Date: Thu, 19 Jan 2012 15:12:30 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120119141230.GC10302@saboteur.suse.cz>
References: <1326966087-2009-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1326966087-2009-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 1/2] aio_suspend-8-1: cleanup coding style first
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net, vapier@gentoo.org

Hi!
> Cleanup coding style first.

Thanks for the cleanup.

> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> ---
>  .../conformance/interfaces/aio_suspend/8-1.c       |   97 ++++++++++----------
>  1 files changed, 48 insertions(+), 49 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/8-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/8-1.c
> index bd58c9f..b31ad78 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/8-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/8-1.c
> @@ -94,18 +94,18 @@ main ()
>  
>  	unlink(tmpfname);
>  
> -	bufs = (char *) malloc (NUM_AIOCBS*BUF_SIZE);
> +	bufs = (char *)malloc(NUM_AIOCBS * BUF_SIZE);

This cast is useless, please remove the (char *) too.

>  	if (bufs == NULL) {
> -		printf (TNAME " Error at malloc(): %s\n", strerror (errno));
> -		close (fd);
> +		printf(TNAME " Error at malloc(): %s\n", strerror(errno));
> +		close(fd);
>  		exit(PTS_UNRESOLVED);
>  	}
>  
> -	if (write (fd, bufs, NUM_AIOCBS*BUF_SIZE) != (NUM_AIOCBS*BUF_SIZE)) {
> +	if (write(fd, bufs, NUM_AIOCBS * BUF_SIZE) != (NUM_AIOCBS * BUF_SIZE)) {
>  		printf(TNAME " Error at write(): %s\n", strerror(errno));
> -		free (bufs);
> -		close (fd);
> +		free(bufs);
> +		close(fd);
>  		exit(PTS_UNRESOLVED);
>  	}
>  
> @@ -113,38 +113,37 @@ main ()
>  
>  	/* Queue up a bunch of aio reads */
>  	for (i = 0; i < NUM_AIOCBS; i++) {
> -
>  		aiocbs[i] = (struct aiocb*)malloc(sizeof(struct aiocb));
>  		memset(aiocbs[i], 0, sizeof(struct aiocb));

Here as well.

>  		aiocbs[i]->aio_fildes = fd;
>  		aiocbs[i]->aio_offset = i * BUF_SIZE;
> -		aiocbs[i]->aio_buf = &bufs[i*BUF_SIZE];
> +		aiocbs[i]->aio_buf = &bufs[i * BUF_SIZE];
>  		aiocbs[i]->aio_nbytes = BUF_SIZE;
>  		aiocbs[i]->aio_lio_opcode = LIO_READ;
>  
>  		/* Use SIRTMIN+1 for individual completions */
>  		aiocbs[i]->aio_sigevent.sigev_notify = SIGEV_SIGNAL;
> -		aiocbs[i]->aio_sigevent.sigev_signo = SIGRTMIN+1;
> +		aiocbs[i]->aio_sigevent.sigev_signo = SIGRTMIN + 1;
>  		aiocbs[i]->aio_sigevent.sigev_value.sival_int = i;
>  	}
>  
>  	/* Use SIGRTMIN+2 for list completion */
>  	event.sigev_notify = SIGEV_SIGNAL;
> -	event.sigev_signo = SIGRTMIN+2;
> +	event.sigev_signo = SIGRTMIN + 2;
>  	event.sigev_value.sival_ptr = NULL;
>  
>  	/* Setup handler for individual operation completion */
>  	action.sa_sigaction = sigrt1_handler;
>  	sigemptyset(&action.sa_mask);
> -	action.sa_flags = SA_SIGINFO|SA_RESTART;
> -	sigaction(SIGRTMIN+1, &action, NULL);
> +	action.sa_flags = SA_SIGINFO | SA_RESTART;
> +	sigaction(SIGRTMIN + 1, &action, NULL);
>  
>  	/* Setup handler for list completion */
>  	action.sa_sigaction = sigrt2_handler;
>  	sigemptyset(&action.sa_mask);
> -	action.sa_flags = SA_SIGINFO|SA_RESTART;
> -	sigaction(SIGRTMIN+2, &action, NULL);
> +	action.sa_flags = SA_SIGINFO | SA_RESTART;
> +	sigaction(SIGRTMIN + 2, &action, NULL);
>  
>  	/* Setup suspend list */
>  	plist[0] = NULL;
> @@ -155,57 +154,57 @@ main ()
>  
>  	if (ret) {
>  		printf(TNAME " Error at lio_listio() %d: %s\n", errno, strerror(errno));
> -		for (i=0; i<NUM_AIOCBS; i++)
> -			free (aiocbs[i]);
> -		free (bufs);
> -		free (aiocbs);
> -		close (fd);
> -		exit (PTS_UNRESOLVED);
> +		for (i = 0; i < NUM_AIOCBS; i++)
> +			free(aiocbs[i]);
> +		free(bufs);
> +		free(aiocbs);
> +		close(fd);
> +		exit(PTS_UNRESOLVED);
>  	}
>  
>  	/* Check selected request has not completed yet */
>  	if (received_selected) {
> -		printf (TNAME " Error : AIOCB %d already completed before suspend\n",
> +		printf(TNAME " Error : AIOCB %d already completed before suspend\n",
>  			WAIT_FOR_AIOCB);
> -		for (i=0; i<NUM_AIOCBS; i++)
> +		for (i = 0; i < NUM_AIOCBS; i++)
>  			free (aiocbs[i]);
> -		free (bufs);
> -		free (aiocbs);
> -		close (fd);
> -		exit (PTS_FAIL);
> +		free(bufs);
> +		free(aiocbs);
> +		close(fd);
> +		exit(PTS_FAIL);
>  	}
>  
>  	/* Suspend on selected request */
>  	ret = aio_suspend((const struct aiocb **)plist, 2, NULL);
>  
>  	if (ret) {
> -		printf (TNAME " Error at aio_suspend() %d: %s\n", errno, strerror (errno));
> +		printf(TNAME " Error at aio_suspend() %d: %s\n", errno, strerror(errno));
>  		for (i=0; i<NUM_AIOCBS; i++)
> -			free (aiocbs[i]);
> -		free (bufs);
> -		free (aiocbs);
> -		close (fd);
> -		exit (PTS_FAIL);
> +			free(aiocbs[i]);
> +		free(bufs);
> +		free(aiocbs);
> +		close(fd);
> +		exit(PTS_FAIL);
>  	}
>  
>  	/* Check selected request has completed */
> -	err = aio_error (aiocbs[WAIT_FOR_AIOCB]);
> -	ret = aio_return (aiocbs[WAIT_FOR_AIOCB]);
> +	err = aio_error(aiocbs[WAIT_FOR_AIOCB]);
> +	ret = aio_return(aiocbs[WAIT_FOR_AIOCB]);
>  
> -	if ((err != 0) && (ret !=  BUF_SIZE)) {
> -		printf (TNAME " Error : AIOCB %d should have completed after suspend\n",
> +	if ((err != 0) && (ret != BUF_SIZE)) {
> +		printf(TNAME " Error : AIOCB %d should have completed after suspend\n",
>  			WAIT_FOR_AIOCB);
> -		for (i=0; i<NUM_AIOCBS; i++)
> -			free (aiocbs[i]);
> -		free (bufs);
> -		free (aiocbs);
> -		close (fd);
> -		exit (PTS_FAIL);
> +		for (i = 0; i < NUM_AIOCBS; i++)
> +			free(aiocbs[i]);
> +		free(bufs);
> +		free(aiocbs);
> +		close(fd);
> +		exit(PTS_FAIL);
>  	}
>  
>  	/* Wait for list processing completion */
>  	while (!received_all)
> -		sleep (1);
> +		sleep(1);
>  
>  	/* Check return code and free things */
>  	for (i = 0; i < NUM_AIOCBS; i++) {
> @@ -220,18 +219,18 @@ main ()
>  			errors++;
>  		}
>  
> -		free (aiocbs[i]);
> +		free(aiocbs[i]);
>  	}
>  
> -	free (bufs);
> -	free (aiocbs);
> +	free(bufs);
> +	free(aiocbs);
>  
>  	close(fd);
>  
>  	if (errors != 0)
> -		exit (PTS_FAIL);
> +		exit(PTS_FAIL);
>  
> -	printf (TNAME " PASSED\n");
> +	printf(TNAME " PASSED\n");

I would like to unify these messages to "Test PASSED\n".

>  	return PTS_PASS;
> -}
> \ No newline at end of file
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
