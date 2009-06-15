Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MGHhJ-0004FE-Mz
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2009 19:18:25 +0000
Received: from [32.97.182.138] (helo=e8.ny.us.ibm.com)
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MGHhD-0001jM-SA
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2009 19:18:20 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5FJ5TSi014548
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Jun 2009 15:05:29 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5FJG9hl187374
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Jun 2009 15:16:09 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5FJG827003476
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Jun 2009 15:16:09 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <f5a7b3810906120620r2e8a8e63t60b1d5cbf961d557@mail.gmail.com>
References: <f5a7b3810906120620r2e8a8e63t60b1d5cbf961d557@mail.gmail.com>
Date: Tue, 16 Jun 2009 00:45:41 +0530
Message-Id: <1245093341.4871.38.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [FIX PATCH] POSIX aio_cancel/3-1.c
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
To: naresh kamboju <naresh.kernel@gmail.com>
Cc: ltp-list@lists.sourceforge.net, maxin john <maxinbjohn@gmail.com>, brinda_mn@yahoo.co.in, rohit.170309@gmail.com

On Fri, 2009-06-12 at 18:50 +0530, naresh kamboju wrote: 
> Hi,
> 
> I have noticed failures under
> ltp/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/3-1.c
> and fixed.
> Please find the patch below and as attachment.
> 
> Best regards
> Naresh Kamboju
> 
> Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >

Thanks.

Regards--
Subrata

> 
> diff -Naurb a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/3-1.c
> b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/3-1.c
> --- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/3-1.c	2005-06-03
> 22:00:17.000000000 +0530
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/3-1.c	2009-06-12
> 18:00:21.000000000 +0530
> @@ -128,6 +128,7 @@
>  		aiocb->aio_sigevent.sigev_notify = SIGEV_SIGNAL;
>  		aiocb->aio_sigevent.sigev_signo = SIGRTMIN+1;
>  		aiocb->aio_sigevent.sigev_value.sival_ptr = aiocb;
> +		aiocb->aio_reqprio = 0;
> 
>  		if (aio_write(aiocb) == -1)
>  		{


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
