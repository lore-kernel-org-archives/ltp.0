Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Ry6Gw-0003c7-EJ
	for ltp-list@lists.sourceforge.net; Thu, 16 Feb 2012 18:41:38 +0000
Date: Thu, 16 Feb 2012 19:41:32 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120216184132.GA6790@saboteur.suse.cz>
References: <1328521976-810-1-git-send-email-kai.kang@windriver.com>
	<1328521976-810-2-git-send-email-kai.kang@windriver.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1328521976-810-2-git-send-email-kai.kang@windriver.com>
Subject: Re: [LTP] [PATCH] mq_timedsend/5-1: make parent has chance to sleep
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
To: Kang Kai <kai.kang@windriver.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Child process sends the last signal before parent process enter the
> final sleep sometimes, so sleep in parent will not be interrupted then
> the case fails.
> Sleep 1 second before send the last signal in child to make sure parent
> enter the final sleep.
> 
> Signed-off-by: Kang Kai <kai.kang@windriver.com>
> ---
>  .../conformance/interfaces/mq_timedsend/5-1.c      |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/5-1.c
> index 96daf72..77fe2e0 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/5-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/5-1.c
> @@ -82,6 +82,9 @@ int main()
>  		sleep(1);  // give parent time to set up handler
>  		for (i=0; i<MAXMSG+1; i++) {
>          		mq_timedsend(gqueue, msgptr, strlen(msgptr), 1, &ts);
> +			/* make sure parent enter the final sleep */
> +			if (i == MAXMSG)
> +				sleep(1);
>  			/* send signal to parent each time message is sent */
>  			kill(getppid(), SIGABRT);
>  		}
> @@ -138,4 +141,4 @@ int main()
>  	}
>  
>  	return PTS_UNRESOLVED;
> -}
> \ No newline at end of file
> +}

Okay, I think I see the possible race condition between the mq_recieve()
in parent and the mq_timedsend() in the the child.

Commited, thanks (and sorry for the delay).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
