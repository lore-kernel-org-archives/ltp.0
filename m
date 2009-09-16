Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MnwGM-0003Fk-LO
	for Ltp-list@lists.sourceforge.net; Wed, 16 Sep 2009 15:17:42 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MnwGE-0005Ro-RY
	for Ltp-list@lists.sourceforge.net; Wed, 16 Sep 2009 15:17:42 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8GFGfYU008867
	for <Ltp-list@lists.sourceforge.net>; Wed, 16 Sep 2009 11:16:41 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8GFHQjc181306
	for <Ltp-list@lists.sourceforge.net>; Wed, 16 Sep 2009 11:17:26 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8GFHQlw017249
	for <Ltp-list@lists.sourceforge.net>; Wed, 16 Sep 2009 11:17:26 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <alpine.LRH.2.00.0909151728510.29741@vixen.sonytel.be>
References: <alpine.LRH.2.00.0909151728510.29741@vixen.sonytel.be>
Date: Wed, 16 Sep 2009 20:47:18 +0530
Message-Id: <1253114238.6343.32.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] quotactl01: Replace hardcoded 258
	by	__NR_set_tid_address
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
> The call signature seems to match the set_tid_address() syscall.
> Also remove the comment about calling quotactl, as it's obviously bogus.
> 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Thanks.

Regards--
Subrata

> ---
>  testcases/kernel/syscalls/quotactl/quotactl01.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
> index fe8df33..f410948 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl01.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
> @@ -152,7 +152,7 @@ int main(int ac, char **av) {
>          			tst_resm(TPASS, "quotactl call succeeded");
>                          }
>                  }
> -	             TEST(result = syscall(258, &newtid));     //call quotactl()
> +	             TEST(result = syscall(__NR_set_tid_address, &newtid));
>                       if(TEST_RETURN == getpid()) {
>                          cleanup();
>                       }


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
