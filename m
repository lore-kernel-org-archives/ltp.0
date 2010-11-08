Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <biannm@cn.fujitsu.com>) id 1PFLsU-00036I-G3
	for ltp-list@lists.sourceforge.net; Mon, 08 Nov 2010 07:10:54 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PFLsS-0005Jd-4u
	for ltp-list@lists.sourceforge.net; Mon, 08 Nov 2010 07:10:54 +0000
Message-ID: <4CD7A289.8020002@cn.fujitsu.com>
Date: Mon, 08 Nov 2010 15:11:05 +0800
From: Bian Naimeng <biannm@cn.fujitsu.com>
MIME-Version: 1.0
References: <4CCA1F3E.5000202@cn.fujitsu.com>
In-Reply-To: <4CCA1F3E.5000202@cn.fujitsu.com>
Subject: Re: [LTP] [POSIX][PATCH]A awaited IO request completion signal can
 case lio_listio return EINTR.
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
To: yanegomi@gmail.com
Cc: ltp-list@lists.sourceforge.net

Bian Naimeng wrote:
> Open posix documents point lio_listio may return EINTR caused by a awaited I/O requst
> completion signal. 
> 
> [EINTR]
>     A signal was delivered while waiting for all I/O requests to complete during an
>     LIO_WAIT operation. Note that, since each I/O operation invoked by lio_listio()
>     may possibly provoke a signal when it completes, this error return may be caused
>     by the completion of one (or more) of the very I/O operations being awaited.
>     Outstanding I/O requests are not canceled, and the application shall examine each
>     list element to determine whether the request was initiated, canceled, or completed.
> 
> So it's unnecessary to setup handler for IO operation completion, we just need check
> the aio_error and aio_return for each request, it has same effect on checking
> received_selected.
> 
> Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>
> 

  Hi Garrett,

    Would you like to pick up this patch?  Any reply is helpful to me, so please let me
  know what's your opinion if you are free. ^_^

  Best Regards
    Bian

> ---
>  .../conformance/interfaces/lio_listio/1-1.c        |   35 ++------------------
>  1 files changed, 3 insertions(+), 32 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/1-1.c
> index f19fcd3..5e4d16a 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/1-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/1-1.c
> @@ -38,18 +38,11 @@
>  #define NUM_AIOCBS	10
>  #define BUF_SIZE	1024*1024
>  
> -int received_selected	= 0;
>  int received_all	= 0;
>  
>  void
>  sigrt1_handler(int signum, siginfo_t *info, void *context)
>  {
> -	received_selected = info->si_value.sival_int;
> -}
> -
> -void
> -sigrt2_handler(int signum, siginfo_t *info, void *context)
> -{
>  	received_all = 1;
>  }
>  
> @@ -105,30 +98,19 @@ int main()
>  		aiocbs[i]->aio_buf = &bufs[i*BUF_SIZE];
>  		aiocbs[i]->aio_nbytes = BUF_SIZE;
>  		aiocbs[i]->aio_lio_opcode = LIO_WRITE;
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
>  	/* Submit request list */
>  	ret = lio_listio(LIO_WAIT, aiocbs, NUM_AIOCBS, &event);
>  
> @@ -142,17 +124,6 @@ int main()
>  		exit (PTS_FAIL);
>  	}
>  
> -	if (received_selected != NUM_AIOCBS-1)
> -	{
> -		printf(TNAME " lio_listio() did not wait\n");
> -		for (i=0; i<NUM_AIOCBS; i++)
> -			free (aiocbs[i]);
> -		free (bufs);
> -		free (aiocbs);
> -		close (fd);
> -		exit (PTS_FAIL);
> -	}
> -
>  	if (received_all != 0)
>  	{
>  		printf(TNAME " lio_listio() did not ignore the sig argument\n");

-- 
Regards
Bian Naimeng


------------------------------------------------------------------------------
The Next 800 Companies to Lead America's Growth: New Video Whitepaper
David G. Thomson, author of the best-selling book "Blueprint to a 
Billion" shares his insights and actions to help propel your 
business during the next growth cycle. Listen Now!
http://p.sf.net/sfu/SAP-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
