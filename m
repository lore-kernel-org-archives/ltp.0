Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Rq5TR-00045h-Uf
	for ltp-list@lists.sourceforge.net; Wed, 25 Jan 2012 16:13:25 +0000
Date: Wed, 25 Jan 2012 17:26:02 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120125162602.GB28713@saboteur.suse.cz>
References: <20120119143855.GD10302@saboteur.suse.cz>
	<1327021862-26954-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1327021862-26954-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2 2/2] aio_suspend-8-1: use aio_error to check
 completion instead
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
> ---
>  .../conformance/interfaces/aio_suspend/8-1.c       |   39 +++-----------------
>  1 files changed, 6 insertions(+), 33 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/8-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/8-1.c
> index e39581f..4023a42 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/8-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/8-1.c
> @@ -51,13 +51,6 @@ int received_all	= 0;
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
> @@ -121,30 +114,19 @@ main ()
>  		aiocbs[i]->aio_buf = &bufs[i * BUF_SIZE];
>  		aiocbs[i]->aio_nbytes = BUF_SIZE;
>  		aiocbs[i]->aio_lio_opcode = LIO_READ;
> -
> -		/* Use SIRTMIN+1 for individual completions */
> -		aiocbs[i]->aio_sigevent.sigev_notify = SIGEV_SIGNAL;
> -		aiocbs[i]->aio_sigevent.sigev_signo = SIGRTMIN + 1;
> -		aiocbs[i]->aio_sigevent.sigev_value.sival_int = i;
>  	}
>  
> -	/* Use SIGRTMIN+2 for list completion */
> +	/* Use SIGRTMIN + 1 for list completion */
>  	event.sigev_notify = SIGEV_SIGNAL;
> -	event.sigev_signo = SIGRTMIN + 2;
> +	event.sigev_signo = SIGRTMIN + 1;
>  	event.sigev_value.sival_ptr = NULL;
>  
> -	/* Setup handler for individual operation completion */
> +	/* Setup handler for list completion */
>  	action.sa_sigaction = sigrt1_handler;
>  	sigemptyset(&action.sa_mask);
>  	action.sa_flags = SA_SIGINFO | SA_RESTART;
>  	sigaction(SIGRTMIN + 1, &action, NULL);
>  
> -	/* Setup handler for list completion */
> -	action.sa_sigaction = sigrt2_handler;
> -	sigemptyset(&action.sa_mask);
> -	action.sa_flags = SA_SIGINFO | SA_RESTART;
> -	sigaction(SIGRTMIN + 2, &action, NULL);
> -
>  	/* Setup suspend list */
>  	plist[0] = NULL;
>  	plist[1] = aiocbs[WAIT_FOR_AIOCB];
> @@ -162,21 +144,12 @@ main ()
>  		exit(PTS_UNRESOLVED);
>  	}
>  
> -	/* Check selected request has not completed yet */
> -	if (received_selected) {
> -		printf(TNAME " Error : AIOCB %d already completed before suspend\n",
> -			WAIT_FOR_AIOCB);
> -		for (i = 0; i < NUM_AIOCBS; i++)
> -			free (aiocbs[i]);
> -		free(bufs);
> -		free(aiocbs);
> -		close(fd);
> -		exit(PTS_FAIL);
> -	}
> +	do {
> +		ret = aio_error(aiocbs[WAIT_FOR_AIOCB]);
> +	} while (ret != EINPROGRESS);

I think that the original code was trying to assert that the operation
wasn't completed yet (in that case this would be infinite loop, or am I
mistaken?).
 
>  	/* Suspend on selected request */
>  	ret = aio_suspend((const struct aiocb **)plist, 2, NULL);
> -
>  	if (ret) {
>  		printf(TNAME " Error at aio_suspend() %d: %s\n", errno, strerror(errno));
>  		for (i=0; i<NUM_AIOCBS; i++)

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
