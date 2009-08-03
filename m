Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MXxoh-00088h-HT
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 13:43:07 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MXxoX-0003B5-Or
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 13:43:07 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n73BGSmp017700
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Aug 2009 05:16:28 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n73BKAal228284
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Aug 2009 05:20:10 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n73BKAXC015745
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Aug 2009 05:20:10 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200907301305.n6UD5G7F023361@e32.co.us.ibm.com>
References: <200907301305.n6UD5G7F023361@e32.co.us.ibm.com>
Date: Mon, 03 Aug 2009 16:50:01 +0530
Message-Id: <1249298406.7460.25.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Make the test result codes a real bitfield again
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net, Jiri Palecek <jpalecek@web.de>

Mike,

You would need to see this.

Regards--
Subrata

On Thu, 2009-07-30 at 11:57 +0200, Jiri Palecek wrote: 
> Hello,
> 
> the commit "extend the test result to a bit field so we can extend the output further" from July 20th unfortunately changes the code, that was previously a bitfield, to a non-bitfield. This causes FAILED tests to return erroneously 0.
> 
> This patch changes the test result codes to be individual bits in the bitfield (effectively reverting  a small part of aforementioned patch).
> 
> Regards
>     Jiri Palecek
> 
> ---
>  include/test.h |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/test.h b/include/test.h
> index 5c325b3..4d9803a 100644
> --- a/include/test.h
> +++ b/include/test.h
> @@ -44,15 +44,15 @@
> 
>  #include "compiler.h"
> 
> -/* Use low 4 bits to encode test type */
> -#define TTYPE_MASK 0xf
> +/* Use low 6 bits to encode test type */
> +#define TTYPE_MASK 0x3f
>  #define TPASS      0    /* Test passed flag */
>  #define TFAIL      1    /* Test failed flag */
>  #define TBROK      2    /* Test broken flag */
> -#define TWARN      3    /* Test warning flag */
> -#define TRETR      4    /* Test retire flag */
> -#define TINFO      5    /* Test information flag */
> -#define TCONF      6    /* Test not appropriate for configuration flag */
> +#define TWARN      4    /* Test warning flag */
> +#define TRETR      8    /* Test retire flag */
> +#define TINFO      16   /* Test information flag */
> +#define TCONF      32   /* Test not appropriate for configuration flag */
>  #define TTYPE_RESULT(ttype) ((ttype) & TTYPE_MASK)
> 
>  #define TERRNO     0x100   /* Append errno information to output */


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
