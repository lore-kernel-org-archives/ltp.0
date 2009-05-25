Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1M8cno-0007KF-CE
	for ltp-list@lists.sourceforge.net; Mon, 25 May 2009 16:13:28 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M8cni-0006uC-BK
	for ltp-list@lists.sourceforge.net; Mon, 25 May 2009 16:13:23 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4PG8oll010435
	for <ltp-list@lists.sourceforge.net>; Mon, 25 May 2009 12:08:50 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4PGDLGU143114
	for <ltp-list@lists.sourceforge.net>; Mon, 25 May 2009 12:13:21 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4PGDKA8015613
	for <ltp-list@lists.sourceforge.net>; Mon, 25 May 2009 12:13:21 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A163E59.7030002@cn.fujitsu.com>
References: <4A0D13F2.8030804@cn.fujitsu.com>
	<20090515134519.GA21654@us.ibm.com>
	<1242647979.5161.12.camel@subratamodak.linux.ibm.com>
	<20090518150725.GA9790@us.ibm.com>  <4A163E59.7030002@cn.fujitsu.com>
Date: Mon, 25 May 2009 21:43:11 +0530
Message-Id: <1243267992.6752.18.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Synchronization between two processes
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
To: "Serge E. Hallyn" <serue@us.ibm.com>, Serge Hallyn <serue@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On Fri, 2009-05-22 at 13:55 +0800, Wei Yongjun wrote: 
> Serge E. Hallyn wrote:
> > Quoting Subrata Modak (subrata@linux.vnet.ibm.com):
> >   
> >> On Fri, 2009-05-15 at 08:45 -0500, Serge E. Hallyn wrote: 
> >>     
> >>> Quoting Gui Xiaohua (guixh@cn.fujitsu.com):
> >>>       
> >>>> The child-process wait SIGUSR1 which would be sended by parent-process,
> >>>> if the child-process execute sigtimedwait() after parent-process send 
> >>>> the signal, it would never receive the SIGUSR1 from parent-process.
> >>>> I cann't make sure the SIGUSR1 be sended after child-process execute 
> >>>> sigtimedwait() with 100 percent, and i try my best.
> >>>>         
> >>> Well, in theory I suppose this could happen, but you'd have to have
> >>> a pretty bad scheduler if the parent can do a strcmp(buf, "c:go")
> >>> between the pipe read and signal send, while the child goes straight
> >>> from pipe write to sigtimedwait.
> >>>
> >>> Have you seen this signal be missed?  If not, then I'd rather assume
> >>> things are reasonable.  If you have seen this happen, then why not
> >>> instead set up a SIGUSR1 handler in the child before doing the pipe
> >>> write, then just sleep for 3 seconds instead of doing sigtimedwait?
> >>>       
> >> Thanks Serge.
> >>     
> >
> > Or, if I'm being unreasonable, then at least have the parent only wait
> > for at most 1 second, and leave the child alone.  Every every ltp test
> > is going to hang for 5 seconds...
> >
> > But I prefer setting the signal handler ahead of time.
> >
> >   
> Sorry to relpy late.
> 
> As your last advice, i change the test case, and it work will.
> 
> [PATCH] fix sync problem between two processes of pidns12 test
> 
> The child-process wait SIGUSR1 which would be sended by parent-process,
> if the child-process execute sigtimedwait() after parent-process send
> the signal, it would never receive the SIGUSR1 from parent-process.
> 
> This patch rewrite child_signal_handler() to handle to SIGUSR1 and
> instead sigtimedwait() with sleep for 3 seconds.
> 
> Signed-off-by: Gui Xiaohua <guixh@cn.fujitsu.com>

Serge,

Your view on this new solution ?

Regards--
Subrata

> ---
>  testcases/kernel/containers/pidns/pidns12.c |   35 ++++++--------------------
>  1 files changed, 8 insertions(+), 27 deletions(-)
> 
> diff --git a/testcases/kernel/containers/pidns/pidns12.c b/testcases/kernel/containers/pidns/pidns12.c
> index f893021..9120e82 100644
> --- a/testcases/kernel/containers/pidns/pidns12.c
> +++ b/testcases/kernel/containers/pidns/pidns12.c
> @@ -72,8 +72,13 @@ void cleanup()
>   */
>  static void child_signal_handler(int sig, siginfo_t *si, void *unused)
>  {
> -	/* sigtimedwait() traps siginfo details, so this wont be called */
> -	tst_resm(TWARN, "cinit: control should have not reached here!");
> +	/* Recieved SIGUSR1. Check sender pid */
> +	if (si->si_pid == 0)
> +		tst_resm(TPASS, "cinit: signalling PID (from other namespace)"\
> +				" is 0 as expected");
> +	else
> +		tst_resm(TFAIL, "cinit: signalling PID (from other namespace)"\
> +				" is not 0, but %d.", si->si_pid);
>  }
> 
>  /*
> @@ -82,9 +87,6 @@ static void child_signal_handler(int sig, siginfo_t *si, void *unused)
>  int child_fn(void *arg)
>  {
>  	struct sigaction sa;
> -	sigset_t newset;
> -	siginfo_t info;
> -	struct timespec timeout;
>  	pid_t pid, ppid;
> 
>  	/* Set process id and parent pid */
> @@ -108,34 +110,13 @@ int child_fn(void *arg)
>  		cleanup();
>  	}
> 
> -	/* Set timeout for sigtimedwait */
> -	timeout.tv_sec = 3;
> -	timeout.tv_nsec = 0;
> -
> -	/* Set mask to wait for SIGUSR1 signal */
> -	sigemptyset(&newset);
> -	sigaddset(&newset, SIGUSR1);
> -
>  	/* Let parent to signal SIGUSR1 */
>  	if (write(pipefd[1], "c:go\0", 5) != 5) {
>  		tst_resm(TBROK, "cinit: pipe is broken to write");
>  		cleanup();
>  	}
> 
> -	/* Wait for SIGUSR1 */
> -	if (sigtimedwait(&newset, &info, &timeout) != SIGUSR1) {
> -		tst_resm(TBROK, "cinit: sigtimedwait() failed(%s).",
> -				strerror(errno));
> -		cleanup();
> -	}
> -
> -	/* Recieved SIGUSR1. Check sender pid */
> -	if (info.si_pid == 0)
> -		tst_resm(TPASS, "cinit: signalling PID (from other namespace)"\
> -				" is 0 as expected");
> -	else
> -		tst_resm(TFAIL, "cinit: signalling PID (from other namespace)"\
> -				" is not 0, but %d.", info.si_pid);
> +	sleep(3);
> 
>  	/* cleanup and exit */
>  	close(pipefd[1]);


------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
