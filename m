Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MkcbJ-0000kk-Uc
	for ltp-list@lists.sourceforge.net; Mon, 07 Sep 2009 11:41:37 +0000
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MkcbF-0006eo-Dl
	for ltp-list@lists.sourceforge.net; Mon, 07 Sep 2009 11:41:37 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n87BdLQi031448
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Sep 2009 05:39:21 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n87BfR98252212
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Sep 2009 05:41:27 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n87BfQvR007175
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Sep 2009 05:41:27 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A9E0655.4030703@cn.fujitsu.com>
References: <4A9E0655.4030703@cn.fujitsu.com>
Date: Mon, 07 Sep 2009 17:11:01 +0530
Message-Id: <1252323674.4922.30.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH 2/2] mbind01: Fix the bug of mind case06
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
To: Zhang Xiliang <zhangxiliang@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, 2009-09-02 at 13:44 +0800, Zhang Xiliang wrote: 
> I tested ltp mbind case and found the case06 failed.
> 
> In mbind manual, it says "If the nodemask and maxnode arguments specify the empty set, 
> then the memory is allocated on the node of the CPU that triggered the allocation."
> 
> In case06, when tc->policy is MPOL_PREFERRED and tc->from_node is NONE, the getnodemask 
> which is get by get_mempolicy() refer to the node of the CPU that triggered the allocation.
> But the nodemask is zero.(It is not used by mbind(), mbind() used "NULL".)
> 
> So in this case, the cmp_ok should only compare the policy.
> 
> Signed-off-by: Zhang Xiliang <zhangxiliang@cn.fujitsu.com>

Thanks.

> ---
>  testcases/kernel/syscalls/mbind/mbind01.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/mbind/mbind01.c b/testcases/kernel/syscalls/mbind/mbind01.c
> index 94c2dd0..446fdaf 100644
> --- a/testcases/kernel/syscalls/mbind/mbind01.c
> +++ b/testcases/kernel/syscalls/mbind/mbind01.c
> @@ -305,7 +305,10 @@ static int do_test(struct test_case *tc) {
>  // When policy equals MPOL_DEFAULT, then get_mempolicy not return node
>          if (tc->policy == MPOL_DEFAULT)
>  		nodemask_zero(&nodemask);
> -	cmp_ok = ((tc->policy == policy) && nodemask_equal(&nodemask,&getnodemask));
> +	if ((tc->policy == MPOL_PREFERRED) && (tc->from_node == NONE))
> +		cmp_ok = (tc->policy == policy);
> +	else
> +		cmp_ok = ((tc->policy == policy) && nodemask_equal(&nodemask,&getnodemask));
>          if (opt_debug) {
>  		nodemask_dump("nodemask Expect:", &nodemask);
>  		nodemask_dump("nodemask Result:", &getnodemask);
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
