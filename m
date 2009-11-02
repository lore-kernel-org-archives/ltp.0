Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1N4xRh-0004Ix-6S
	for ltp-list@lists.sourceforge.net; Mon, 02 Nov 2009 13:59:45 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N4xRb-0005gx-6V
	for ltp-list@lists.sourceforge.net; Mon, 02 Nov 2009 13:59:45 +0000
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nA29u0pG002083
	for <ltp-list@lists.sourceforge.net>; Mon, 2 Nov 2009 04:56:00 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nA2DxXZ6087594
	for <ltp-list@lists.sourceforge.net>; Mon, 2 Nov 2009 08:59:33 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nA29uTXC031917
	for <ltp-list@lists.sourceforge.net>; Mon, 2 Nov 2009 04:56:29 -0500
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200910301656.n9UGuui3018802@e1.ny.us.ibm.com>
References: <200910301656.n9UGuui3018802@e1.ny.us.ibm.com>
Date: Mon, 02 Nov 2009 19:29:24 +0530
Message-Id: <1257170364.4977.60.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Use a saner variant for computing the number
	of	groups in cpuctl tests
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
To: Jiri Palecek <jpalecek@web.de>
Cc: ltp-list@lists.sourceforge.net

Thanks.

Regards--
Subrata

On Wed, 2009-10-21 at 13:36 +0200, Jiri Palecek wrote: 
> Hello,
> 
> this patch changes the calculation of numer of groups in cpuctl test.
> 
> The new code doesn't need bc, and is more comprehensible IMHO
> 
> Regards
>     Jiri Palecek
> 
> ---
>  testcases/kernel/controllers/cpuctl/parameters.sh |   11 +----------
>  1 files changed, 1 insertions(+), 10 deletions(-)
> 
> diff --git a/testcases/kernel/controllers/cpuctl/parameters.sh b/testcases/kernel/controllers/cpuctl/parameters.sh
> index a23dbe5..502944e 100755
> --- a/testcases/kernel/controllers/cpuctl/parameters.sh
> +++ b/testcases/kernel/controllers/cpuctl/parameters.sh
> @@ -61,16 +61,7 @@ set_def_group() #default group spinning a task to create ideal scenario
> 
>  get_num_groups()        # Number of tasks should be >= number of cpu's (to check scheduling fairness)
>  {
> -        num_grps=$(echo "$NUM_CPUS * 1.5"|bc)   # temp variable num_grps
> -        int_part=`echo $num_grps | cut -d"." -f1`
> -        dec_part=`echo $num_grps | cut -d"." -f2`
> -
> -        if [ $dec_part -gt 0 ]
> -        then
> -                NUM_GROUPS=$(echo "$int_part + 1"|bc)
> -        else
> -                NUM_GROUPS=$int_part;
> -        fi
> +        NUM_GROUPS=$(( (NUM_CPUS*3 + 1)/2 ))
>  }
> 
>  	# Write the cleanup function


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
