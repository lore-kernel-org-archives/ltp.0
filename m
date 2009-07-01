Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1MMeig-0007X7-6M
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 09:06:10 +0000
Received: from [32.97.110.153] (helo=e35.co.us.ibm.com)
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MM4QZ-0000x0-KE
	for ltp-list@lists.sourceforge.net; Wed, 01 Jul 2009 18:21:05 +0000
Date: Wed, 1 Jul 2009 13:20:05 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20090701182005.GC17998@us.ibm.com>
References: <20090701165923.GC3237@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20090701165923.GC3237@in.ibm.com>
Subject: Re: [LTP] [PATCH] Fix pidns14 test case
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
To: "M. Mohan Kumar" <mohan@in.ibm.com>
Cc: ltp-list@lists.sf.net, sukadev@linux.vnet.ibm.com, sachinp@in.ibm.com

Quoting M. Mohan Kumar (mohan@in.ibm.com):
> [PATCH] pidns14
> 
> Container-init may be immune to unhandled fatal signals (like SIGUSR1)
> even if they are from ancestor namespace. SIGKILL/SIGSTOP are the only
> reliable signals to a container-init from ancestor namespace. Make sure
> that container-init will not respond to signals other than
> SIGKILL/SIGSTOP

Hmm?  This may or may not be right...  but you start out by saying 'may be
immune to', then provide a patch making the testcase TFAIL if is not immune
to.  So at the very least anyone on a slightly older kernel will get TFAILs.

I don't think that immunity to SIGUSR1 from ancestor pidns is something we
want to guarantee, it's just what is happening.  The proper thing is to
not depend on either getting or not getting SIGUSR1, in my opinion.  Suka?

-serge

> Signed-off-by: M. Mohan Kumar <mohan@in.ibm.com>
> ---
>  testcases/kernel/containers/pidns/pidns14.c |   13 +++++++------
>  1 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/testcases/kernel/containers/pidns/pidns14.c b/testcases/kernel/containers/pidns/pidns14.c
> index e95bf95..41602cd 100644
> --- a/testcases/kernel/containers/pidns/pidns14.c
> +++ b/testcases/kernel/containers/pidns/pidns14.c
> @@ -67,9 +67,8 @@ int child_fn(void *ttype)
>  		tst_resm(TBROK, "pidns is not created.");
>  		cleanup();
>  	}
> -	pause();
> -	tst_resm(TFAIL, "Oops! Container init resumed after receiving SIGUSR1");
> -	return -1;
> +	sleep(10);
> +	return 0;
>  }
> 
>  /*
> @@ -111,9 +110,11 @@ int main(int argc, char *argv[])
>  	if (waitpid(cpid, &status, 0) < 0)
>  		tst_resm(TWARN, "waitpid() failed.");
> 
> -	if ((WIFSIGNALED(status)) && (WTERMSIG(status) == SIGUSR1))
> -		tst_resm(TPASS, "Container init is killed as expected, "
> -				" when the SIGUSR1 is passed from parent\n");
> +	if (WIFEXITED(status))
> +		tst_resm(TPASS, "Container init returned as expected\n");
> +	else if ((WIFSIGNALED(status)) && (WTERMSIG(status) == SIGUSR1))
> +		tst_resm(TFAIL, "Container init is killed when the SIGUSR1 "
> +		       		"is passed from parent\n");
>  	 else
>  		tst_resm(TFAIL, "After sending signal kill -USR1, "
>  				"returned unexpected error\n");
> -- 
> 1.6.0.2
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
