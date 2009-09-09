Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MlRP7-0003GT-RO
	for ltp-list@lists.sourceforge.net; Wed, 09 Sep 2009 17:56:25 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MlROx-0002Br-Ln
	for ltp-list@lists.sourceforge.net; Wed, 09 Sep 2009 17:56:20 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n89HlV6J031950
	for <ltp-list@lists.sourceforge.net>; Wed, 9 Sep 2009 13:47:31 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n89Hu96i222970
	for <ltp-list@lists.sourceforge.net>; Wed, 9 Sep 2009 13:56:09 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n89Hr3U4025663
	for <ltp-list@lists.sourceforge.net>; Wed, 9 Sep 2009 13:53:03 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4AA76861.8080501@cn.fujitsu.com>
References: <4AA76861.8080501@cn.fujitsu.com>
Date: Wed, 09 Sep 2009 23:25:52 +0530
Message-Id: <1252518954.4836.6.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] cpuctl of controllers: fix the bug of while loop
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
To: liubo <liubo-fnst@cn.fujitsu.com>, Miao Xie <miaox@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, 2009-09-09 at 16:33 +0800, liubo wrote: 
> Here is the right patch.
> I'm sorry for my carelessness.
> 
> Signed-off-by: Miao Xie <miaox@cn.fujitsu.com>
> Signed-off-by: Liu Bo <liubo-fnst@cn.fujitsu.com>

Thanks.

Regards--
Subrata

> ---
> diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c b/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c
> index 00a25bc..1fb398a 100644
> --- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c
> +++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c
> @@ -82,7 +82,7 @@ extern void cleanup()
>  	kill(scriptpid, SIGUSR1);/* Inform the shell to do cleanup*/
>  	tst_exit();		/* Report exit status*/
>  }
> -int timer_expired = 0;
> +volatile int timer_expired = 0;
> 
>  int main(int argc, char *argv[])
>  {
> diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c b/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c
> index 1bfa187..56ddacc 100644
> --- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c
> +++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c
> @@ -79,7 +79,7 @@ cleanup()
>  	tst_exit();		/* Report exit status*/
>  }
> 
> -int timer_expired = 0;
> +volatile int timer_expired = 0;
> 
>  int main(int argc, char *argv[])
>  {
> diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c b/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c
> index e4ce3ad..4f3ddc1 100644
> --- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c
> +++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c
> @@ -79,7 +79,7 @@ cleanup()
>  	tst_exit();		  /* Report exit status*/
>  }
> 
> -int timer_expired = 0;
> +volatile int timer_expired = 0;
> 
>  int main(int argc, char *argv[])
>  {
> diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c b/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c
> index 15e2b5f..7f184c8 100644
> --- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c
> +++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c
> @@ -78,7 +78,7 @@ cleanup()
>  	tst_exit();		  /* Report exit status*/
>  }
> 
> -int timer_expired = 0;
> +volatile int timer_expired = 0;
> 
>  int main(int argc, char *argv[])
>  {
> diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test01.c b/testcases/kernel/controllers/cpuctl/cpuctl_test01.c
> index ab0a4c9..7d7cc48 100644
> --- a/testcases/kernel/controllers/cpuctl/cpuctl_test01.c
> +++ b/testcases/kernel/controllers/cpuctl/cpuctl_test01.c
> @@ -80,7 +80,7 @@ cleanup()
>  	kill (scriptpid, SIGUSR1);/* Inform the shell to do cleanup*/
>  	tst_exit ();		/* Report exit status*/
>  }
> -int timer_expired = 0;
> +volatile int timer_expired = 0;
> 
>  int main(int argc, char* argv[])
>  {
> diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test02.c b/testcases/kernel/controllers/cpuctl/cpuctl_test02.c
> index 801716d..153a293 100644
> --- a/testcases/kernel/controllers/cpuctl/cpuctl_test02.c
> +++ b/testcases/kernel/controllers/cpuctl/cpuctl_test02.c
> @@ -80,7 +80,7 @@ cleanup()
>  }
> 
>  int migrate_task ();
> -int timer_expired = 0;
> +volatile int timer_expired = 0;
> 
>  int main(int argc, char* argv[])
>  {
> diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test03.c b/testcases/kernel/controllers/cpuctl/cpuctl_test03.c
> index c4b9978..c21b69c 100644
> --- a/testcases/kernel/controllers/cpuctl/cpuctl_test03.c
> +++ b/testcases/kernel/controllers/cpuctl/cpuctl_test03.c
> @@ -79,7 +79,7 @@ cleanup()
>  	tst_exit ();		  /* Report exit status*/
>  }
> 
> -int timer_expired = 0;
> +volatile int timer_expired = 0;
> 
>  int main(int argc, char* argv[])
>  {
> diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test04.c b/testcases/kernel/controllers/cpuctl/cpuctl_test04.c
> index b0a2329..ed00b0d 100644
> --- a/testcases/kernel/controllers/cpuctl/cpuctl_test04.c
> +++ b/testcases/kernel/controllers/cpuctl/cpuctl_test04.c
> @@ -79,7 +79,7 @@ cleanup()
>  	tst_exit ();		  /* Report exit status*/
>  }
> 
> -int timer_expired = 0;
> +volatile int timer_expired = 0;
> 
>  int main(int argc, char* argv[])
>  {
> diff --git a/testcases/kernel/controllers/libcontrollers/libcontrollers.h b/testcases/kernel/controllers/libcontrollers/libcontrollers.h
> index 777ff67..e6ab6a0 100644
> --- a/testcases/kernel/controllers/libcontrollers/libcontrollers.h
> +++ b/testcases/kernel/controllers/libcontrollers/libcontrollers.h
> @@ -48,7 +48,8 @@ char fullpath[PATH_MAX];
>  char fullpath[1024]; /* Guess */
>  #endif
> 
> -int FLAG, timer_expired;
> +int FLAG;
> +volatile int timer_expired;
> 
>  int retval;
> 
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with 
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
