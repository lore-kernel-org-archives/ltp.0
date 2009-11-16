Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1N9wig-0006cS-4a
	for ltp-list@lists.sourceforge.net; Mon, 16 Nov 2009 08:13:54 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N9wiY-0005r4-9d
	for ltp-list@lists.sourceforge.net; Mon, 16 Nov 2009 08:13:54 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e34.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nAG88aus025301
	for <ltp-list@lists.sourceforge.net>; Mon, 16 Nov 2009 01:08:36 -0700
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAG8Defd161392
	for <ltp-list@lists.sourceforge.net>; Mon, 16 Nov 2009 01:13:40 -0700
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nAG8FJOL029615
	for <ltp-list@lists.sourceforge.net>; Mon, 16 Nov 2009 01:15:19 -0700
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4AFD2579.6060107@cn.fujitsu.com>
References: <4AFD2579.6060107@cn.fujitsu.com>
Date: Mon, 16 Nov 2009 13:43:37 +0530
Message-Id: <1258359217.5677.32.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] mem/hugetlb: fix failure of hugemmap04
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
To: liubo <liubo2009@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Fri, 2009-11-13 at 17:23 +0800, liubo wrote: 
> Testcase hugemmap04 needs at least one hugepage to test,
> so there needs a judgement of "number of hugepages".
> 
> This patch fixed the problems.
> 
> Signed-off-by: Liu Bo <liubo2009@cn.fujitsu.com>

Thanks.

Regards--
Subrata

> 
> ---
>  testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
> index 050a071..e67e43c 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
> @@ -72,6 +72,7 @@
> 
>  #include "test.h"
>  #include "usctest.h"
> +#include "system_specific_hugepages_info.h"
> 
>  #define BUFFER_SIZE  256
> 
> @@ -124,6 +125,11 @@ main(int ac, char **av)
>  		tst_exit();
>  	}
> 
> +	/* Check number of hugepages */
> +	if (get_no_of_hugepages() <= 0 || hugepages_size() <= 0)
> +		tst_brkm(TBROK, cleanup, "Test cannot be continued owning to \
> +				sufficient availability of Hugepages on the system");
> +
>  	/* Perform global setup for test */
>  	setup();
> 


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
