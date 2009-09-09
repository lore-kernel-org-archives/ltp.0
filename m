Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MlH0w-0004Wl-0O
	for ltp-list@lists.sourceforge.net; Wed, 09 Sep 2009 06:50:46 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MlH0p-0006Ub-O5
	for ltp-list@lists.sourceforge.net; Wed, 09 Sep 2009 06:50:45 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n896mNfY027977
	for <ltp-list@lists.sourceforge.net>; Wed, 9 Sep 2009 02:48:23 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n896oTps237118
	for <ltp-list@lists.sourceforge.net>; Wed, 9 Sep 2009 02:50:29 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n896oTni028856
	for <ltp-list@lists.sourceforge.net>; Wed, 9 Sep 2009 02:50:29 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4AA62094.7060505@cn.fujitsu.com>
References: <4AA62094.7060505@cn.fujitsu.com>
Date: Wed, 09 Sep 2009 12:20:01 +0530
Message-Id: <1252479003.5006.12.camel@subratamodak.linux.ibm.com>
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
To: liubo <liubo-fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, 2009-09-08 at 17:15 +0800, liubo wrote: 
> When running the ltp tool by "./runltp -f controllers",
> I found "while" loop cannot stop in following files of
> cpuctl test.
> 
> File list:
> cpuctl_def_task01.c
> cpuctl_def_task02.c
> cpuctl_def_task03.c
> cpuctl_def_task04.c
> cpuctl_test01.c
> cpuctl_test02.c
> cpuctl_test03.c
> cpuctl_test04.c
> 
> Key code:
> timer_expired=0;
> while(!timer_expired)
> 	f=sqrt(f*f);
> 
> Reason:
> During the compilation of these files, gcc's O2 mechanism
>   causes the change of variable "timer_expired" to be omitted,
> hence the loop, "while(!timer_expired) f=sqrt(f*f);" cannot
> get out from itself.
> 
> Change the type of "timer_expired" from "int" to "volatile int"
> to fix this bug.
> 
> By the way, it is necessary to modify the file,
> ltp-full-xxxxxxxx/testcases/kernel/controllers/libcontrollers/
> libcontrollers.h for compilation.
> 
> 
> Signed-off-by: Miao Xie <miaox@cn.fujitsu.com>
> Signed-off-by: Liu Bo <liubo-fnst@cn.fujitsu.com>

This fails to apply. Needs to be re-created against the latest LTP
snapshots from CVS:

patching file testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c
Hunk #1 FAILED at 82.
1 out of 1 hunk FAILED -- saving rejects to file
testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c.rej
patching file testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c
Hunk #1 succeeded at 79 with fuzz 2.
patching file testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c
Hunk #1 succeeded at 79 with fuzz 2.
patching file testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c
Hunk #1 succeeded at 78 with fuzz 2.
patching file testcases/kernel/controllers/cpuctl/cpuctl_test01.c
Hunk #1 FAILED at 80.
1 out of 1 hunk FAILED -- saving rejects to file
testcases/kernel/controllers/cpuctl/cpuctl_test01.c.rej
patching file testcases/kernel/controllers/cpuctl/cpuctl_test02.c
Hunk #1 FAILED at 80.
1 out of 1 hunk FAILED -- saving rejects to file
testcases/kernel/controllers/cpuctl/cpuctl_test02.c.rej
patching file testcases/kernel/controllers/cpuctl/cpuctl_test03.c
Hunk #1 succeeded at 79 with fuzz 2.
patching file testcases/kernel/controllers/cpuctl/cpuctl_test04.c
Hunk #1 succeeded at 79 with fuzz 2.
patching file
testcases/kernel/controllers/libcontrollers/libcontrollers.h
Hunk #1 succeeded at 48 with fuzz 2.

Regards--
Subrata

> ---
> diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c 
> b/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c
> index 00a25bc..1fb398a 100644
> --- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c
> +++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c
> @@ -82,7 +82,7 @@ extern void cleanup()
>          kill(scriptpid, SIGUSR1);/* Inform the shell to do cleanup*/
>          tst_exit();             /* Report exit status*/
>   }
> -int timer_expired = 0;
> +volatile int timer_expired = 0;
> 
>   int main(int argc, char *argv[])
>   {
> diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c 
> b/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c
> index 1bfa187..56ddacc 100644
> --- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c
> +++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c
> @@ -79,7 +79,7 @@ cleanup()
>          tst_exit();             /* Report exit status*/
>   }
> 
> -int timer_expired = 0;
> +volatile int timer_expired = 0;
> 
>   int main(int argc, char *argv[])
>   {
> diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c 
> b/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c
> index e4ce3ad..4f3ddc1 100644
> --- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c
> +++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c
> @@ -79,7 +79,7 @@ cleanup()
>          tst_exit();               /* Report exit status*/
>   }
> 
> -int timer_expired = 0;
> +volatile int timer_expired = 0;
> 
>   int main(int argc, char *argv[])
>   {
> diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c 
> b/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c
> index 15e2b5f..7f184c8 100644
> --- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c
> +++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c
> @@ -78,7 +78,7 @@ cleanup()
>          tst_exit();               /* Report exit status*/
>   }
> 
> -int timer_expired = 0;
> +volatile int timer_expired = 0;
> 
>   int main(int argc, char *argv[])
>   {
> diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test01.c 
> b/testcases/kernel/controllers/cpuctl/cpuctl_test01.c
> index ab0a4c9..7d7cc48 100644
> --- a/testcases/kernel/controllers/cpuctl/cpuctl_test01.c
> +++ b/testcases/kernel/controllers/cpuctl/cpuctl_test01.c
> @@ -80,7 +80,7 @@ cleanup()
>          kill (scriptpid, SIGUSR1);/* Inform the shell to do cleanup*/
>          tst_exit ();            /* Report exit status*/
>   }
> -int timer_expired = 0;
> +volatile int timer_expired = 0;
> 
>   int main(int argc, char* argv[])
>   {
> diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test02.c 
> b/testcases/kernel/controllers/cpuctl/cpuctl_test02.c
> index 801716d..153a293 100644
> --- a/testcases/kernel/controllers/cpuctl/cpuctl_test02.c
> +++ b/testcases/kernel/controllers/cpuctl/cpuctl_test02.c
> @@ -80,7 +80,7 @@ cleanup()
>   }
> 
>   int migrate_task ();
> -int timer_expired = 0;
> +volatile int timer_expired = 0;
> 
>   int main(int argc, char* argv[])
>   {
> diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test03.c 
> b/testcases/kernel/controllers/cpuctl/cpuctl_test03.c
> index c4b9978..c21b69c 100644
> --- a/testcases/kernel/controllers/cpuctl/cpuctl_test03.c
> +++ b/testcases/kernel/controllers/cpuctl/cpuctl_test03.c
> @@ -79,7 +79,7 @@ cleanup()
>          tst_exit ();              /* Report exit status*/
>   }
> 
> -int timer_expired = 0;
> +volatile int timer_expired = 0;
> 
>   int main(int argc, char* argv[])
>   {
> diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test04.c 
> b/testcases/kernel/controllers/cpuctl/cpuctl_test04.c
> index b0a2329..ed00b0d 100644
> --- a/testcases/kernel/controllers/cpuctl/cpuctl_test04.c
> +++ b/testcases/kernel/controllers/cpuctl/cpuctl_test04.c
> @@ -79,7 +79,7 @@ cleanup()
>          tst_exit ();              /* Report exit status*/
>   }
> 
> -int timer_expired = 0;
> +volatile int timer_expired = 0;
> 
>   int main(int argc, char* argv[])
>   {
> diff --git 
> a/testcases/kernel/controllers/libcontrollers/libcontrollers.h 
> b/testcases/kernel/controllers/libcontrollers/libcontrollers.h
> index 777ff67..e6ab6a0 100644
> --- a/testcases/kernel/controllers/libcontrollers/libcontrollers.h
> +++ b/testcases/kernel/controllers/libcontrollers/libcontrollers.h
> @@ -48,7 +48,8 @@ char fullpath[PATH_MAX];
>   char fullpath[1024]; /* Guess */
>   #endif
> 
> -int FLAG, timer_expired;
> +int FLAG;
> +volatile int timer_expired;
> 
>   int retval;
> 
> 
> 
> 
> 
> 
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
