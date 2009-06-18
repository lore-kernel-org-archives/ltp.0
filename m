Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MHLTH-0001Pq-L9
	for ltp-list@lists.sourceforge.net; Thu, 18 Jun 2009 17:32:19 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MHLTG-0007Un-6A
	for ltp-list@lists.sourceforge.net; Thu, 18 Jun 2009 17:32:19 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5IHTAoE002206
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Jun 2009 11:29:10 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5IHWFKK215018
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Jun 2009 11:32:15 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5IHWFg8014158
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Jun 2009 11:32:15 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1245145538-25870-1-git-send-email-nobuhiro@andestech.com>
References: <1245145538-25870-1-git-send-email-nobuhiro@andestech.com>
Date: Thu, 18 Jun 2009 23:01:46 +0530
Message-Id: <1245346306.5041.38.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] mmapstress03: consider passed when
	returning	EINVAL	in the large mmap test.
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
To: nobuhiro <nobuhiro@andestech.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, 2009-06-16 at 17:45 +0800, nobuhiro wrote: 
> Some architectures may return EINVAL instead of ENOMEM.
> This should also be ok according to mmap manual:
> EINVAL We don't like addr, length, or offset (e.g., they are too large, or not aligned on a page boundary).
> 
> Signed-off-by: nobuhiro <nobuhiro@andestech.com>

Thanks.

Regards--
Subrata

> ---
>  testcases/kernel/mem/mmapstress/mmapstress03.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/mem/mmapstress/mmapstress03.c b/testcases/kernel/mem/mmapstress/mmapstress03.c
> index 8b41959..3ce5540 100644
> --- a/testcases/kernel/mem/mmapstress/mmapstress03.c
> +++ b/testcases/kernel/mem/mmapstress/mmapstress03.c
> @@ -166,8 +166,8 @@ main(int argc, char *argv[])
>  		ERROR("really large mmap didn't fail");
>                  anyfail();
>  	}
> -	if (errno != ENOMEM) {
> -		ERROR("really large mmap didn't set errno = ENOMEM");
> +	if (errno != ENOMEM && errno != EINVAL) {
> +		ERROR("really large mmap didn't set errno = ENOMEM nor EINVAL");
>                  anyfail();
>  	}
>  	(void)time(&t);


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
