Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1M8coS-0006Jb-Kt
	for ltp-list@lists.sourceforge.net; Mon, 25 May 2009 16:14:08 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M8coO-0002NW-UC
	for ltp-list@lists.sourceforge.net; Mon, 25 May 2009 16:14:08 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4PG7bEL025480
	for <ltp-list@lists.sourceforge.net>; Mon, 25 May 2009 10:07:37 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4PGE45Z234882
	for <ltp-list@lists.sourceforge.net>; Mon, 25 May 2009 10:14:04 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4PGE3CS014797
	for <ltp-list@lists.sourceforge.net>; Mon, 25 May 2009 10:14:04 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090525.195007.183038971.caiqian@cclom.cn>
References: <20090525.195007.183038971.caiqian@cclom.cn>
Date: Mon, 25 May 2009 21:43:55 +0530
Message-Id: <1243268037.6752.21.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Crash02: Deal with SIGSTOP and SIGSEGV v3
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
To: CAI Qian <caiqian@cclom.cn>
Cc: ltp-list@lists.sourceforge.net


On Mon, 2009-05-25 at 19:50 +0800, CAI Qian wrote: 
> Hi,
> 
> Version 3 also fixed compilation failures on IA-64, since there is no
> SYS_fork either. It use clone2() instead.
> 
> Version 2 fixed compilation failures on IA-64, because there is no
> SYS_vfork there. Instead, it uses clone() syscall for vfork(),
> 
> clone(child_stack=0, flags=CLONE_VM|CLONE_VFORK|SIGCHLD)
> 
> We have seen crash02 test can not finish due to the child process got
> SIGSTOP or SIGSEGV when calling random syscalls like this,
> 
> # ps aux
> ...
> 168      20121  0.0  0.0   3956   336 ?        Ds   15:10   0:00 ./crash02 -e -v 100
> 168      20122  0.0  0.0   3956   336 ?        T    15:10   0:00 ./crash02 -e -v 100
> 
> 
> crash02       X ffff81007fb127a0     0 21272  21271         21273       (L-TLB)
>  ffff81004c185d58 0000000000000046 ffff81007b494e08 0000000000000002
>  0000000000000002 0000000000000002 ffff81007c5dc860 ffff81007fb127a0
>  00000d8ebb800862 000000000000c315 ffff81007c5dca48 0000000300000001
> Call Trace:
>  [<ffffffff800235a7>] filp_close+0x5c/0x64
>  [<ffffffff8001595a>] do_exit+0x913/0x91f
>  [<ffffffff80048c18>] cpuset_exit+0x0/0x6c
>  [<ffffffff8002ad05>] get_signal_to_deliver+0x42c/0x45a
>  [<ffffffff8005a837>] do_notify_resume+0x9c/0x7af
>  [<ffffffff80096e2b>] specific_send_sig_info+0x44/0xac
>  [<ffffffff8009710e>] force_sig_info+0xae/0xb9
>  [<ffffffff80066eed>] do_page_fault+0x81e/0x830
>  [<ffffffff8005d6dc>] retint_signal+0x3d/0x79
> 
> crash02       X ffff810002376400     0 21273  21271               21272 (L-TLB)
>  ffff81004d201f18 0000000000000046 ffff81007b494e08 0000000000000046
>  0000000000000046 0000000000000002 ffff810078d3a040 ffffffff802eeae0
>  00000d8ebb803430 000000000001a60c ffff810078d3a228 0000000000000000
> Call Trace:
>  [<ffffffff8001595a>] do_exit+0x913/0x91f
>  [<ffffffff80048c18>] cpuset_exit+0x0/0x6c
>  [<ffffffff8005d28d>] tracesys+0xd5/0xe0
> 
> So we use WUNTRACED option. Also, we found out that if it picks up
> vfork(), it will generate SIGSEGV. I am not sure what else can generate
> the same, so only blacklist vfork() at the moment.
> 
> Signed-off-by: CAI Qian <caiqian@cclom.cn>

Thanks.

Regards--
Subrata

> 
> --- testcases/misc/crash/crash02.c.orig	2009-05-19 19:47:24.000000000 +0800
> +++ testcases/misc/crash/crash02.c	2009-05-22 15:57:56.000000000 +0800
> @@ -51,6 +51,8 @@
>  */
> 
> 
> +#define _GNU_SOURCE
> +#include <sys/syscall.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> @@ -241,7 +243,7 @@
>        my_signal (SIGALRM, monitor_fcn);
>        alarm (ntries*MAX_TRY_TIME);
> 
> -	  pid = wait (&status);
> +	  pid = waitpid (-1, &status, WUNTRACED);
>  	  if (pid <= 0)
>  	  {
>  		  perror ("wait");
> @@ -298,6 +300,7 @@
>  void again_handler (int sig);
>  void try_one_crash (int try_num);
>  void set_up_signals ();
> +int in_blacklist (int sysno);
> 
>  /* badboy "entry" point */
> 
> @@ -453,7 +456,10 @@
>  {
>    long int sysno, arg1, arg2, arg3, arg4, arg5, arg6, arg7;
> 
> -  sysno = rand()%sysno_max;
> +  do {
> +    sysno = rand()%sysno_max;
> +  } while (in_blacklist(sysno));
> +
>    arg1 = rand_long();
>    arg2 = rand_long();
>    arg3 = rand_long();
> @@ -472,4 +478,32 @@
>    }
>  }
> 
> +/* The following syscalls create new processes which may cause the test
> +   unable to finish. */
> +int
> +in_blacklist (int sysno)
> +{
> +  int i;
> +  const list[] =
> +    {
> +#ifdef __ia64__
> +      SYS_clone2,
> +#else
> +      /* No SYS_fork(vfork) on IA-64. Instead, it uses,
> +         clone(child_stack=0, flags=CLONE_VM|CLONE_VFORK|SIGCHLD)
> +         clone2() */
> +      SYS_vfork,
> +      SYS_fork,
> +#endif /* __ia64__ */
> +      SYS_clone,
> +      -1
> +    };
> +
> +  for (i = 0; list[i] != -1; i++)
> +    {
> +      if (sysno == list[i])
> +        return 1;
> +    }
> 
> +  return 0;
> +}
> 
> ------------------------------------------------------------------------------
> Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
> is a gathering of tech-side developers & brand creativity professionals. Meet
> the minds behind Google Creative Lab, Visual Complexity, Processing, & 
> iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
> Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


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
