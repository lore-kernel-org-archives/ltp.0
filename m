Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MnwGV-0003HM-MN
	for Ltp-list@lists.sourceforge.net; Wed, 16 Sep 2009 15:17:51 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MnwGP-0005TU-6o
	for Ltp-list@lists.sourceforge.net; Wed, 16 Sep 2009 15:17:51 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8GFDfIk001544
	for <Ltp-list@lists.sourceforge.net>; Wed, 16 Sep 2009 09:13:42 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8GFHa4t196272
	for <Ltp-list@lists.sourceforge.net>; Wed, 16 Sep 2009 09:17:36 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8GFHZtm031384
	for <Ltp-list@lists.sourceforge.net>; Wed, 16 Sep 2009 09:17:35 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <alpine.LRH.2.00.0909151729270.29761@vixen.sonytel.be>
References: <alpine.LRH.2.00.0909151729270.29761@vixen.sonytel.be>
Date: Wed, 16 Sep 2009 20:47:25 +0530
Message-Id: <1253114245.6343.34.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Numa-testcases: Return TCONF if NUMA is
	not	available
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

On Tue, 2009-09-15 at 17:29 +0200, Geert Uytterhoeven wrote: 
> Currently the test just fails if NUMA is not available.
> 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Thanks.

Regards--
Subrata

> ---
>  testcases/kernel/numa/numa01.sh |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/numa/numa01.sh b/testcases/kernel/numa/numa01.sh
> index 419d0b2..6cc0754 100644
> --- a/testcases/kernel/numa/numa01.sh
> +++ b/testcases/kernel/numa/numa01.sh
> @@ -239,9 +239,9 @@ init()
>  
>      if [ $max_node -eq 1 ]
>      then 
> -        tst_resm TWARN "non-NUMA aware kernel is running or your machine does not support numa policy or 
> +        tst_resm TCONF "non-NUMA aware kernel is running or your machine does not support numa policy or 
>                          your machine is not a NUMA machine"
> -    return 1
> +    exit 0
>      fi
>  
>      RC=0


------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
