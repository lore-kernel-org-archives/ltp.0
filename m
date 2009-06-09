Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1ME60t-0003y3-47
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2009 18:25:35 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1ME60q-0002Hm-Uc
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2009 18:25:35 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e37.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n59IOqAR027395
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2009 12:24:52 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n59IPUN8196262
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2009 12:25:31 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n59IPUaV016579
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2009 12:25:30 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200906081321.24278.jpalecek@web.de>
References: <200906081321.24278.jpalecek@web.de>
Date: Tue, 09 Jun 2009 23:54:56 +0530
Message-Id: <1244571898.5497.21.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Include config.h in aio01, to get HAVE_LIBAIO_H
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

On Mon, 2009-06-08 at 13:21 +0200, Jiri Palecek wrote: 
> Hello,
> 
> this patch is necessary for aio01 test to actually test something.
> 
> Regards
>     Jiri Palecek
> 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

Thanks.

Regards--
Subrata

> 
> ---
>  testcases/kernel/io/aio/aio01/aio01.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/testcases/kernel/io/aio/aio01/aio01.c b/testcases/kernel/io/aio/aio01/aio01.c
> index 7a510ee..6a69edb 100644
> --- a/testcases/kernel/io/aio/aio01/aio01.c
> +++ b/testcases/kernel/io/aio/aio01/aio01.c
> @@ -49,6 +49,7 @@
> 
>  #include "test.h"
>  #include "usctest.h"
> +#include "config.h"
> 
>  char *TCID = "aio01";
>  int TST_TOTAL=6;


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
