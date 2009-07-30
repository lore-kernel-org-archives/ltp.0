Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MWaNT-0006Ip-0r
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 18:29:19 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MWaNL-0005Oa-WB
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 18:29:19 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e39.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n6UIONdZ019022
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 12:24:23 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n6UISwlD097536
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 12:29:00 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6UISwNi032081
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 12:28:58 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A6530E2.80406@cn.fujitsu.com>
References: <4A6530E2.80406@cn.fujitsu.com>
Date: Thu, 30 Jul 2009 23:58:50 +0530
Message-Id: <1248978530.5788.56.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Fix the failure of get_mempolicy01 test case
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
To: Wei Yongjun <yjwei@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, 2009-07-21 at 11:07 +0800, Wei Yongjun wrote: 
> Test case get_mempolicy01 failure because of the the nodemask
> is not used when from_node is NONE type. If the from_node is
> NONE, nodemask_equal() is not need.
> 
> Signed-off-by: Wei Yongjun <yjwei@cn.fujitsu.com>

Thanks.

Regards--
Subrata

> 
> diff --git a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
> index 2201bf4..aa0b14b 100644
> --- a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
> +++ b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
> @@ -337,7 +337,7 @@ static int do_test(struct test_case *tc)
>          // When policy equals MPOL_DEFAULT, then get_mempolicy not return node
>          if (tc->policy == MPOL_DEFAULT)
>                  nodemask_zero(&nodemask);
> -        cmp_ok = tc->policy == policy && nodemask_equal(&nodemask,&getnodemask);
> +        cmp_ok = tc->policy == policy && (tc->from_node == NONE || nodemask_equal(&nodemask,&getnodemask));
>          if (opt_debug) {
>                  nodemask_dump("nodemask Expect:", &nodemask);
>                  nodemask_dump("nodemask Result:", &getnodemask);
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


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
