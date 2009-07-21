Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1MTF4H-0002x8-Ob
	for ltp-list@lists.sourceforge.net; Tue, 21 Jul 2009 13:07:41 +0000
Received: from mail-fx0-f208.google.com ([209.85.220.208])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MTF4C-0002by-BF
	for ltp-list@lists.sourceforge.net; Tue, 21 Jul 2009 13:07:41 +0000
Received: by fxm4 with SMTP id 4so2714165fxm.10
	for <ltp-list@lists.sourceforge.net>;
	Tue, 21 Jul 2009 06:07:35 -0700 (PDT)
Message-ID: <4A65BD95.7070001@petalogix.com>
Date: Tue, 21 Jul 2009 15:07:33 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
References: <4A6527B6.7070602@cn.fujitsu.com>
In-Reply-To: <4A6527B6.7070602@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] Fix to set the signal handler of SIGINT in
	mq_timedreceive01
Reply-To: michal.simek@petalogix.com
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
To: Wei Yongjun <yjwei@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi,

Please fix coding style violation.
Use tab instead of spaces.
Subrata should reject this patch with bad coding style.
Can you please fix it?

Thanks,
Michal

> The test case mq_timedreceive01 does not register the signal
> handler of SIGINT, so the problam will be terminated by SIGINT
> from child process.
>
> This patch fixed the problem.
>
> Signed-off-by: Wei Yongjun <yjwei@cn.fujitsu.com>
>
> diff --git a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
> index dadc38d..beeb298 100644
> --- a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
> +++ b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
> @@ -106,6 +106,14 @@ extern void cleanup() {
>          tst_exit();
>  }
>  
> +/*
> + * sighandler()
> + */
> +void sighandler(int sig)
> +{
> +        return;
> +}
> +
>  /* Local  Functions */
>  /******************************************************************************/
>  /*                                                                            */
> @@ -126,6 +134,7 @@ extern void cleanup() {
>  /******************************************************************************/
>  void setup() {
>          /* Capture signals if any */
> +        signal(SIGINT, sighandler);
>          /* Create temporary directories */
>          TEST_PAUSE;
>          tst_tmpdir();
> @@ -432,17 +441,6 @@ EXIT:
>          return result;
>  }
>  
> -/*
> - * sighandler()
> - */
> -void sighandler(int sig)
> -{
> -        if (sig == SIGINT)
> -                return;
> -        // NOTREACHED
> -        return;
> -}
> -
>  
>  
>  /*
>
>
>
>
>
> ------------------------------------------------------------------------------
> Enter the BlackBerry Developer Challenge  
> This is your chance to win up to $100,000 in prizes! For a limited time, 
> vendors submitting new applications to BlackBerry App World(TM) will have
> the opportunity to enter the BlackBerry Developer Challenge. See full prize  
> details at: http://p.sf.net/sfu/Challenge
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>   


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663


------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
