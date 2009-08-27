Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mgc52-00034P-HT
	for Ltp-list@lists.sourceforge.net; Thu, 27 Aug 2009 10:19:44 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mgc4y-000855-Lc
	for Ltp-list@lists.sourceforge.net; Thu, 27 Aug 2009 10:19:44 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7RAD3SH015284
	for <Ltp-list@lists.sourceforge.net>; Thu, 27 Aug 2009 06:13:03 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7RAJX6k228180
	for <Ltp-list@lists.sourceforge.net>; Thu, 27 Aug 2009 06:19:33 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7RAJXAq028493
	for <Ltp-list@lists.sourceforge.net>; Thu, 27 Aug 2009 06:19:33 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <alpine.LRH.2.00.0908261650390.28998@vixen.sonytel.be>
References: <alpine.LRH.2.00.0908261650390.28998@vixen.sonytel.be>
Date: Thu, 27 Aug 2009 15:49:08 +0530
Message-Id: <1251368348.4993.16.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Spelling fixes: excute => execute
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
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Linux Test Project <Ltp-list@lists.sourceforge.net>

On Wed, 2009-08-26 at 16:50 +0200, Geert Uytterhoeven wrote: 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Thanks.

Regards--
Subrata

> ---
>  .../sched/hyperthreading/ht_affinity/HTaffinity.c  |    2 +-
>  .../sched/hyperthreading/ht_enabled/HTenabled.c    |    2 +-
>  .../hyperthreading/ht_interrupt/HTinterrupt.c      |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/sched/hyperthreading/ht_affinity/HTaffinity.c b/testcases/kernel/sched/hyperthreading/ht_affinity/HTaffinity.c
> index ff96173..fa2d254 100644
> --- a/testcases/kernel/sched/hyperthreading/ht_affinity/HTaffinity.c
> +++ b/testcases/kernel/sched/hyperthreading/ht_affinity/HTaffinity.c
> @@ -234,7 +234,7 @@ int main(int argc, char *argv[])
>  {
>  
>  #ifndef __i386__
> -	tst_brkm(TCONF, NULL, "This test suite can only excute on i386 architecture.");
> +	tst_brkm(TCONF, NULL, "This test suite can only execute on i386 architecture.");
>  #else
>  	if (!check_ht_capability())
>  	{
> diff --git a/testcases/kernel/sched/hyperthreading/ht_enabled/HTenabled.c b/testcases/kernel/sched/hyperthreading/ht_enabled/HTenabled.c
> index 2cd2eb2..8cbb13c 100644
> --- a/testcases/kernel/sched/hyperthreading/ht_enabled/HTenabled.c
> +++ b/testcases/kernel/sched/hyperthreading/ht_enabled/HTenabled.c
> @@ -23,7 +23,7 @@ int main(int argc, char *argv[])
>  {
>  	int ret_val = 1;
>  #ifndef __i386__
> -	tst_brkm(TCONF, NULL, "This test suite can only excute on i386 architecture.");
> +	tst_brkm(TCONF, NULL, "This test suite can only execute on i386 architecture.");
>  #else
>  		ret_val = check_ht_capability();
>  #endif
> diff --git a/testcases/kernel/sched/hyperthreading/ht_interrupt/HTinterrupt.c b/testcases/kernel/sched/hyperthreading/ht_interrupt/HTinterrupt.c
> index 4207c6d..a09fffd 100644
> --- a/testcases/kernel/sched/hyperthreading/ht_interrupt/HTinterrupt.c
> +++ b/testcases/kernel/sched/hyperthreading/ht_interrupt/HTinterrupt.c
> @@ -112,7 +112,7 @@ int main(int argc, char *argv[])
>  	tst_resm(TINFO, "Begin: HyperThreading Interrupt");
>  
>  #ifndef __i386__
> -	tst_brkm(TCONF, NULL, "This test suite can only excute on i386 architecture.");
> +	tst_brkm(TCONF, NULL, "This test suite can only execute on i386 architecture.");
>  #else
>  	if (!check_ht_capability())
>  	{


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
