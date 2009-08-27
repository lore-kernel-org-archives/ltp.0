Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mgc5Q-0004qe-Tr
	for Ltp-list@lists.sourceforge.net; Thu, 27 Aug 2009 10:20:08 +0000
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mgc5M-000888-P6
	for Ltp-list@lists.sourceforge.net; Thu, 27 Aug 2009 10:20:08 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7RAI9n9031318
	for <Ltp-list@lists.sourceforge.net>; Thu, 27 Aug 2009 04:18:09 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7RAJtM7174646
	for <Ltp-list@lists.sourceforge.net>; Thu, 27 Aug 2009 04:19:55 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7RAJtFS015292
	for <Ltp-list@lists.sourceforge.net>; Thu, 27 Aug 2009 04:19:55 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <alpine.LRH.2.00.0908261650540.29010@vixen.sonytel.be>
References: <alpine.LRH.2.00.0908261650540.29010@vixen.sonytel.be>
Date: Thu, 27 Aug 2009 15:49:31 +0530
Message-Id: <1251368371.4993.17.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Spelling fixes: initalization => initialization
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

On Wed, 2009-08-26 at 16:51 +0200, Geert Uytterhoeven wrote: 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Thanks Again.

Regards--
Subrata

> ---
>  testcases/network/nfsv4/locks/locktests.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/network/nfsv4/locks/locktests.c b/testcases/network/nfsv4/locks/locktests.c
> index 3268733..38b2e9d 100644
> --- a/testcases/network/nfsv4/locks/locktests.c
> +++ b/testcases/network/nfsv4/locks/locktests.c
> @@ -236,7 +236,7 @@ int initialise(int clnt){
>          perror("Master pipe creation error\n");
>          exit(1);
>      }
> -    printf("%s initalization\n",eType);
> +    printf("%s initialization\n",eType);
>      load();
>      initTest();
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
