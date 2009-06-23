Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MJ7ZT-0003yv-B7
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 15:06:03 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJ7ZS-0005pC-KA
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 15:06:03 +0000
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e7.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5NErWUH000981
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 10:53:32 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5NF5oIQ1736948
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 11:05:51 -0400
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5NF5kIq004348
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 09:05:47 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200906220126.n5M1QuQ2022362@e31.co.us.ibm.com>
References: <200906220126.n5M1QuQ2022362@e31.co.us.ibm.com>
Date: Tue, 23 Jun 2009 20:19:56 +0530
Message-Id: <1245768596.4860.79.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Use __i386__ instead of _i386__ in HTutils.c
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

On Wed, 2009-06-17 at 17:27 +0200, Jiri Palecek > wrote: 
> This is probably a typo, the macro defined on 386 systems is named __i386__, not _i386__
> 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

Thanks.

Regards--
Subrata

> ---
>  .../sched/hyperthreading/ht_affinity/HTutils.c     |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/kernel/sched/hyperthreading/ht_affinity/HTutils.c b/testcases/kernel/sched/hyperthreading/ht_affinity/HTutils.c
> index 5f37d1f..9d6e1c0 100644
> --- a/testcases/kernel/sched/hyperthreading/ht_affinity/HTutils.c
> +++ b/testcases/kernel/sched/hyperthreading/ht_affinity/HTutils.c
> @@ -60,7 +60,7 @@ int is_ht_kernel()
> 
>  inline void cpuid(int op, int *eax, int *ebx, int *ecx, int *edx)
>  {
> -#ifndef _i386__
> +#ifndef __i386__
>  	return;
>  #else
>  	__asm__("cpuid"


------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
