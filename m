Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MktHi-00074w-1b
	for ltp-list@lists.sourceforge.net; Tue, 08 Sep 2009 05:30:30 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MktHb-0003ci-Pw
	for ltp-list@lists.sourceforge.net; Tue, 08 Sep 2009 05:30:29 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4AA5C13E.8010100@cn.fujitsu.com>
References: <4AA5C13E.8010100@cn.fujitsu.com>
Date: Tue, 08 Sep 2009 11:00:05 +0530
Message-Id: <1252387807.9655.3.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [Ltp-cvs] [Fwd: [PATCH] cpuctl of controllers: fix
	the	bug of while loop]
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
Cc: ltp-list <ltp-list@lists.sf.net>

You have sent to the wrong mailing list. Please send a correct
patch(based on LTPROOT) to the following mailing list:

ltp-list <ltp-list@lists.sf.net>,

Regards--
Subrata

On Tue, 2009-09-08 at 10:28 +0800, liubo wrote:
> When runing the ltp tool,  I found a bug of while loop in some files of
> 
> cpuctl test.
> 
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
> 
> During the compilation of these files, gcc's O2 mechanism causes the
> variable "timer_expired" to be omitted, hence the loop ,
> "while(!timer_expired) f = sqrt (f*f)", cannot get right value.
> 
> Change the type of "timer_expired" from "int" to "volatile int" to fix
> this bug.
> 
> 
> Signed-off-by: Miao Xie<miaox@cn.fujitsu.com>
> Signed-off-by: Liu Bo<liubo-fnst@cn.fujitsu.com>
> ---
> diff --git a/cpuctl_def_task01.c b/cpuctl_def_task01.c
> index 00a25bc..1fb398a 100644
> --- a/cpuctl_def_task01.c
> +++ b/cpuctl_def_task01.c
> @@ -82,7 +82,7 @@ extern void cleanup()
>          kill(scriptpid, SIGUSR1);/* Inform the shell to do cleanup*/
>          tst_exit();             /* Report exit status*/
>   }
> -int timer_expired = 0;
> +volatile int timer_expired = 0;
> 
>   int main(int argc, char *argv[])
>   {
> diff --git a/cpuctl_def_task02.c b/cpuctl_def_task02.c
> index 1bfa187..56ddacc 100644
> --- a/cpuctl_def_task02.c
> +++ b/cpuctl_def_task02.c
> @@ -79,7 +79,7 @@ cleanup()
>          tst_exit();             /* Report exit status*/
>   }
> 
> -int timer_expired = 0;
> +volatile int timer_expired = 0;
> 
>   int main(int argc, char *argv[])
>   {
> diff --git a/cpuctl_def_task03.c b/cpuctl_def_task03.c
> index e4ce3ad..4f3ddc1 100644
> --- a/cpuctl_def_task03.c
> +++ b/cpuctl_def_task03.c
> @@ -79,7 +79,7 @@ cleanup()
>          tst_exit();               /* Report exit status*/
>   }
> 
> -int timer_expired = 0;
> +volatile int timer_expired = 0;
> 
>   int main(int argc, char *argv[])
>   {
> diff --git a/cpuctl_def_task04.c b/cpuctl_def_task04.c
> index 15e2b5f..7f184c8 100644
> --- a/cpuctl_def_task04.c
> +++ b/cpuctl_def_task04.c
> @@ -78,7 +78,7 @@ cleanup()
>          tst_exit();               /* Report exit status*/
>   }
> 
> -int timer_expired = 0;
> +volatile int timer_expired = 0;
> 
>   int main(int argc, char *argv[])
>   {
> diff --git a/cpuctl_test01.c b/cpuctl_test01.c
> index ab0a4c9..7d7cc48 100644
> --- a/cpuctl_test01.c
> +++ b/cpuctl_test01.c
> @@ -80,7 +80,7 @@ cleanup()
>          kill (scriptpid, SIGUSR1);/* Inform the shell to do cleanup*/
>          tst_exit ();            /* Report exit status*/
>   }
> -int timer_expired = 0;
> +volatile int timer_expired = 0;
> 
>   int main(int argc, char* argv[])
>   {
> diff --git a/cpuctl_test02.c b/cpuctl_test02.c
> index 801716d..153a293 100644
> --- a/cpuctl_test02.c
> +++ b/cpuctl_test02.c
> @@ -80,7 +80,7 @@ cleanup()
>   }
> 
>   int migrate_task ();
> -int timer_expired = 0;
> +volatile int timer_expired = 0;
> 
>   int main(int argc, char* argv[])
>   {
> diff --git a/cpuctl_test03.c b/cpuctl_test03.c
> index c4b9978..c21b69c 100644
> --- a/cpuctl_test03.c
> +++ b/cpuctl_test03.c
> @@ -79,7 +79,7 @@ cleanup()
>          tst_exit ();              /* Report exit status*/
>   }
> 
> -int timer_expired = 0;
> +volatile int timer_expired = 0;
> 
>   int main(int argc, char* argv[])
>   {
> diff --git a/cpuctl_test04.c b/cpuctl_test04.c
> index b0a2329..ed00b0d 100644
> --- a/cpuctl_test04.c
> +++ b/cpuctl_test04.c
> @@ -79,7 +79,7 @@ cleanup()
>          tst_exit ();              /* Report exit status*/
>   }
> 
> -int timer_expired = 0;
> +volatile int timer_expired = 0;
> 
>   int main(int argc, char* argv[])
>   {
> 
> 
> 
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with 
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________
> Ltp-cvs mailing list
> Ltp-cvs@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-cvs


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
