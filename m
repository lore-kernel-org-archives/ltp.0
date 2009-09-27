Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MryHu-0006qk-AZ
	for ltp-list@lists.sourceforge.net; Sun, 27 Sep 2009 18:15:58 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MryHq-00012Z-5g
	for ltp-list@lists.sourceforge.net; Sun, 27 Sep 2009 18:15:58 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8RI8wWg001738
	for <ltp-list@lists.sourceforge.net>; Sun, 27 Sep 2009 14:08:58 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8RIFm42225458
	for <ltp-list@lists.sourceforge.net>; Sun, 27 Sep 2009 14:15:48 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8RICVBR014971
	for <ltp-list@lists.sourceforge.net>; Sun, 27 Sep 2009 14:12:31 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200909241313.n8ODDB8b020776@e4.ny.us.ibm.com>
References: <200909241313.n8ODDB8b020776@e4.ny.us.ibm.com>
Date: Sun, 27 Sep 2009 23:45:17 +0530
Message-Id: <1254075319.10457.24.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Use SIG_ERR to indicate tst_sig's default	handler,
	to allow (and not clash with) SIG_DFL
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

On Wed, 2009-09-23 at 14:38 +0200, Jiri Palecek wrote: 
> Hello,
> 
>  SIG_DFL happens to be 0 as well as DEF_HANDLER - this means you
>  cannot use SIG_DFL as tst_sig argument, eg. if you want to reset the
>  signal handling in tests' children to normal.
> 
>  This patch changes DEF_HANDLER to be SIG_ERR, as this value cannot be normally used with tst_sig(), so they cannot clash.
> 
> Regards
>     Jiri Palecek
> 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

Thanks.

Regards--
Subrata

> ---
>  include/test.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/include/test.h b/include/test.h
> index 864b8de..f737575 100644
> --- a/include/test.h
> +++ b/include/test.h
> @@ -91,7 +91,7 @@
>  /* defines for unexpected signal setup routine (set_usig.c) */
>  #define FORK    1		/* SIGCLD is to be ignored */
>  #define NOFORK  0		/* SIGCLD is to be caught */
> -#define DEF_HANDLER 0	/* tells set_usig() to use default signal handler */
> +#define DEF_HANDLER SIG_ERR	/* tells set_usig() to use default signal handler */
> 
>  /*
>   * The following defines are used to control tst_res and t_result reporting.


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
