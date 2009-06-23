Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MJ7Xk-0000Fg-On
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 15:04:16 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJ7Xh-000317-MS
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 15:04:16 +0000
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5NErSlZ020250
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 10:53:28 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5NF47CV1683684
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 11:04:09 -0400
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5NF46mj007452
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 09:04:07 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200906220116.n5M1GnXX024497@e36.co.us.ibm.com>
References: <200906220116.n5M1GnXX024497@e36.co.us.ibm.com>
Date: Tue, 23 Jun 2009 20:19:43 +0530
Message-Id: <1245768583.4860.75.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Include "config.h" in the aio02 test to
	get	HAVE_LIBAIO_H
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

On Wed, 2009-06-17 at 15:18 +0200, Jiri Palecek > wrote: 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

Thanks.

Regards--
Subrata

> ---
>  testcases/kernel/io/aio/aio02/main.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/testcases/kernel/io/aio/aio02/main.c b/testcases/kernel/io/aio/aio02/main.c
> index 791b5e0..5dae3e8 100644
> --- a/testcases/kernel/io/aio/aio02/main.c
> +++ b/testcases/kernel/io/aio/aio02/main.c
> @@ -8,6 +8,7 @@
>  #include <sys/stat.h>
>  #include <unistd.h>
>  #include "test.h"
> +#include "config.h"
> 
>  #ifdef HAVE_LIBAIO_H
> 


------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
