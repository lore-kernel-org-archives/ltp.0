Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MhoM0-0001bk-54
	for ltp-list@lists.sourceforge.net; Sun, 30 Aug 2009 17:38:12 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MhoLq-0002Pp-I6
	for ltp-list@lists.sourceforge.net; Sun, 30 Aug 2009 17:38:07 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7UHYAZ7029543
	for <ltp-list@lists.sourceforge.net>; Sun, 30 Aug 2009 11:34:10 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7UHbuku262644
	for <ltp-list@lists.sourceforge.net>; Sun, 30 Aug 2009 11:37:56 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7UHbuVL032226
	for <ltp-list@lists.sourceforge.net>; Sun, 30 Aug 2009 11:37:56 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090828101522.12177.4630.sendpatchset@localhost.localdomain>
References: <20090828101440.12177.32012.sendpatchset@localhost.localdomain>
	<20090828101522.12177.4630.sendpatchset@localhost.localdomain>
Date: Sun, 30 Aug 2009 23:06:56 +0530
Message-Id: <1251653818.12120.24.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [Patch 6/8] Included new function to check feature	versus
	kernel version
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
To: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net, svaidy@linux.vnet.ibm.com, ego@in.ibm.com, arun@linux.vnet.ibm.com

On Fri, 2009-08-28 at 15:45 +0530, Poornima Nayak wrote: 
> Included new function to check feature versus kernel version
> 
> Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

Ok.

> 
> diff -uprN ltp_orig/testcases/kernel/power_management/check_kv_arch.c ltp/testcases/kernel/power_management/check_kv_arch.c
> --- ltp_orig/testcases/kernel/power_management/check_kv_arch.c	2009-08-28 10:54:59.000000000 +0530
> +++ ltp/testcases/kernel/power_management/check_kv_arch.c	2009-08-28 12:36:07.000000000 +0530
> @@ -23,6 +23,12 @@ int kernel_is_too_old(void) {
>  	return 0;
>  }
> 
> +int check_timer_migr_supp(void) {
> +	if (tst_kvercmp(2,6,31) < 0)
> +		return 1;
> +	return 0;
> +}
> +
>  /*
>   * yeah, to make the makefile coding easier, do_check returns
>   * 1 if unshare is not supported, 0 if it is
> @@ -35,7 +41,17 @@ int do_check(void) { return kernel_is_to
>  int do_check(void) { return 1; }
>  #endif
> 
> -int main() {
> -	return do_check();
> +int main(int argc, char *argv[]) {
> +	char feature[20];
> +	if (argc == 1) 
> +		return do_check();
> +	else
> +	{
> +		printf("argument is %s", argv[1]);
> +		if (strcmp(argv[1], "timer_migration")==0)
> +			if (check_timer_migr_supp() == 0)
> +				return 0;
> +			else
> +				return 1;
> +	} 
>  }
> -
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
