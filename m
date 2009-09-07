Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mkcbp-0003bu-WC
	for ltp-list@lists.sourceforge.net; Mon, 07 Sep 2009 11:42:10 +0000
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mkcbj-0006nU-OX
	for ltp-list@lists.sourceforge.net; Mon, 07 Sep 2009 11:42:09 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n87BdohG032065
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Sep 2009 05:39:50 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n87BftiC213858
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Sep 2009 05:41:55 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n87Bft53019822
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Sep 2009 05:41:55 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A9E236B.6040606@cn.fujitsu.com>
References: <4A9E236B.6040606@cn.fujitsu.com>
Date: Mon, 07 Sep 2009 17:11:20 +0530
Message-Id: <1252323696.4922.31.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] mbind01: Fix the bug of mind case10
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

On Wed, 2009-09-02 at 15:48 +0800, Zhang Xiliang wrote: 
> I tested ltp mbind01 case and found the case10 failed.
> 
> In case10, the expect errno is EFAULT. 
> 
> In mbind manual, it says "EFAULT Part or all of the memory range specified by nodemask 
> and maxnode points outside your accessible address space. "
> 
> So the case should use invalid "nodemask" instead of invalid "p" to test.
> 
> Signed-off-by: Zhang Xiliang <zhangxiliang@cn.fujitsu.com>

Thanks.

Regards--
Subrata

> ---
>  testcases/kernel/syscalls/mbind/mbind01.c |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/mbind/mbind01.c b/testcases/kernel/syscalls/mbind/mbind01.c
> index 446fdaf..4afa71b 100644
> --- a/testcases/kernel/syscalls/mbind/mbind01.c
> +++ b/testcases/kernel/syscalls/mbind/mbind01.c
> @@ -238,8 +238,8 @@ static struct test_case tcase[] = {
>          },
>          { // case10
>                  .ttype          = INVALID_POINTER,
> -                .policy         = MPOL_DEFAULT,
> -                .from_node      = NONE,
> +                .policy         = MPOL_PREFERRED,
> +                .from_node      = SELF,
>                  .ret            = -1,
>                  .err            = EFAULT,
>          },
> @@ -263,6 +263,7 @@ static int do_test(struct test_case *tc) {
>          nodemask_t nodemask, getnodemask;
>          unsigned long maxnode = NUMA_NUM_NODES;
>          unsigned long len = MEM_LENGTH;
> +	unsigned long *invalid_nodemask;
> 
>          /* We assume that there is only one node(node0). */
>          nodemask_zero(&nodemask);
> @@ -279,13 +280,15 @@ static int do_test(struct test_case *tc) {
>                  tst_exit();
>          }
>          if(tc->ttype == INVALID_POINTER)
> -                p = (char*)0xc0000000;
> +		invalid_nodemask = (unsigned long *)0xc0000000;
>  /*
>           * Execute system call
>           */
>          errno = 0;
>          if (tc->from_node == NONE)
>                  TEST(sys_ret = syscall(__NR_mbind, p, len, tc->policy,NULL, 0, tc->flags));
> +	else if (tc->ttype == INVALID_POINTER)
> +		TEST(sys_ret = syscall(__NR_mbind, p, len, tc->policy, invalid_nodemask, maxnode, tc->flags));
>          else
>                  TEST(sys_ret = syscall(__NR_mbind, p, len, tc->policy,&nodemask, maxnode, tc->flags));
>          sys_errno = errno;
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
