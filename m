Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1ME61O-0006dV-LL
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2009 18:26:06 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1ME61K-0006G4-5E
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2009 18:26:06 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n59ILE70017620
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2009 14:21:14 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n59IQ1Vs257050
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2009 14:26:01 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n59IQ1Kg013310
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2009 14:26:01 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200906081329.48616.jpalecek@web.de>
References: <200906081329.48616.jpalecek@web.de>
Date: Tue, 09 Jun 2009 23:55:14 +0530
Message-Id: <1244571916.5497.25.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Remove the signal-waiting logic
	from	create_sig_proc()
Reply-To: subrata@linux.vnet.ibm.com
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
To: Jiri Palecek <jpalecek@web.de>
Cc: ltp-list@lists.sourceforge.net

On Mon, 2009-06-08 at 13:29 +0200, Jiri Palecek wrote: 
> In create_sig_proc, the child process waits for the parent to wake it
>  with a signal. This doesn't actually solve anything, and the
>  implementation with pause() syscall is inherently racy (the race
>  results in a deadlock). This patch removes it; it doesn't make the
>  function race-free (it's possible the child will send the signal
>  before the parent had chance to run), but this is the best you can
>  get.
> 
> Regards
>     Jiri Palecek
> 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

Thanks.

Regards--
Subrata

> ---
>  testcases/kernel/syscalls/utils/common_j_h.c |   10 ----------
>  1 files changed, 0 insertions(+), 10 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/utils/common_j_h.c b/testcases/kernel/syscalls/utils/common_j_h.c
> index cda3198..d122ff9 100644
> --- a/testcases/kernel/syscalls/utils/common_j_h.c
> +++ b/testcases/kernel/syscalls/utils/common_j_h.c
> @@ -102,23 +102,14 @@ int cleanup_euid(uid_t old_uid)
>  /*
>   * Generate a child process which will send a signal
>   */
> -static void sighandler_for_sig_proc(int sig)
> -{
> -	if (sig == SIGUSR2)
> -		return;
> -	return;
> -}
> -
>  pid_t create_sig_proc(unsigned long usec, int sig)
>  {
>  	pid_t pid, cpid;
> 
> -	signal(SIGUSR2, sighandler_for_sig_proc);
>  	pid = getpid();
>  	cpid = fork();
>  	switch (cpid) {
>  	case 0:
> -		pause();
>  		usleep(usec);
>  		kill(pid, sig);
>  		_exit(0);
> @@ -127,7 +118,6 @@ pid_t create_sig_proc(unsigned long usec, int sig)
>  		EPRINTF("fork failed.\n");
>  		return cpid;
>  	default:
> -		kill(cpid, SIGUSR2);
>  		return cpid;
>  	}
>  }


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
