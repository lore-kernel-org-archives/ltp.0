Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yjwei@cn.fujitsu.com>) id 1MT3q2-0006cc-Ct
	for ltp-list@lists.sourceforge.net; Tue, 21 Jul 2009 01:08:14 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MT3pw-0008M4-RB
	for ltp-list@lists.sourceforge.net; Tue, 21 Jul 2009 01:08:14 +0000
Message-ID: <4A651499.4030605@cn.fujitsu.com>
Date: Tue, 21 Jul 2009 09:06:33 +0800
From: Wei Yongjun <yjwei@cn.fujitsu.com>
MIME-Version: 1.0
References: <8368651DACC1964480F951191B94A078EBA887@svexch01.mvista.com>
In-Reply-To: <8368651DACC1964480F951191B94A078EBA887@svexch01.mvista.com>
Subject: Re: [LTP] [PATCH] exit_group01, fix syscall number for exit_group
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
To: Henry Yei <hyei@mvista.com>
Cc: ltp-list@lists.sourceforge.net

Hi, Henry Yei

Henry Yei  wrote:
> This issue was found when running on an arm machine.
>
>
> Fix syscall number for exit_group
>   

I have posted the same some days ago, see
http://marc.info/?l=ltp-list&m=124798179211554&w=2.

But Garrett Cooper said we also add the relevant syscall number to the
architecture
specific .in file in testcases/kernel/include. If you have time, you can
do this. If you
would like to do this, please tell me. So we will not do dup wroks. Thanks.

Wei Yongjun

> <Signed-off-by: Henry Yei <hyei@mvista.com>
>
> ---
> ltp-full-20090531/testcases/kernel/syscalls/exit_group/exit_group01.c
> 2009-05-21 11:14:40.000000000 -0700
> +++
> ltp-full-20090531/testcases/kernel/syscalls/exit_group/exit_group01.c
> 2009-07-17 12:03:47.000000000 -0700
> @@ -136,7 +136,7 @@
>                       } else if (TEST_RETURN == 0){
>  	                 	tst_resm(TINFO, "In the child process");
>                             	sleep(5);
> -				TEST(syscall(252,4));
> +				TEST(syscall(__NR_exit_group,4));
>                       }else {
>  				tst_resm(TINFO,"in the parent process");
>  				TEST(w = wait(&status));
>
>   
> ------------------------------------------------------------------------
>
> ------------------------------------------------------------------------------
> Enter the BlackBerry Developer Challenge  
> This is your chance to win up to $100,000 in prizes! For a limited time, 
> vendors submitting new applications to BlackBerry App World(TM) will have
> the opportunity to enter the BlackBerry Developer Challenge. See full prize  
> details at: http://p.sf.net/sfu/Challenge
> ------------------------------------------------------------------------
>
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>   



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
