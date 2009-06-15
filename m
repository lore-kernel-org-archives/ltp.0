Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MGHfQ-0007zj-Nr
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2009 19:16:28 +0000
Received: from [32.97.182.142] (helo=e2.ny.us.ibm.com)
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MGHfM-00020n-Qs
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2009 19:16:28 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5FJAwD7023294
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Jun 2009 15:10:58 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5FJFY2V230094
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Jun 2009 15:15:34 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5FJFYqC016605
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Jun 2009 15:15:34 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <f5a7b3810906120634x5c9efc89uef1ef8f63f556247@mail.gmail.com>
References: <f5a7b3810906120634x5c9efc89uef1ef8f63f556247@mail.gmail.com>
Date: Tue, 16 Jun 2009 00:45:23 +0530
Message-Id: <1245093323.4871.33.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [FIX PATCH] POSIX aio_read/10-1.c
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

On Fri, 2009-06-12 at 19:04 +0530, naresh kamboju wrote: 
> Hi,
> 
> I have noticed failures under
> testcases/open_posix_testsuite/conformance/interfaces/aio_read/10-1.c
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
> diff -Naurb a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/10-1.c
> b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/10-1.c
> --- a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/10-1.c	2009-06-12
> 18:05:11.000000000 +0530
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/10-1.c	2009-06-12
> 18:00:21.000000000 +0530
> @@ -40,6 +40,7 @@
>  #define BUF_SIZE 111
>  	char buf[BUF_SIZE];
>  	struct aiocb aiocb;
> +	int ret=0;
> 
>  #if _POSIX_ASYNCHRONOUS_IO != 200112L
>  	exit(PTS_UNSUPPORTED);
> @@ -51,13 +52,21 @@
>  	aiocb.aio_buf = buf;
>  	aiocb.aio_nbytes = BUF_SIZE;
> 
> -	if (aio_read(&aiocb) != -1)
> +	/*
> +	 * EBADF is encountered at a later stage
> +	 * and should be collected by aio_error()
> +	 */
> +	
> +	if (aio_read(&aiocb) != 0)
>  	{
>  		printf(TNAME " bad aio_read return value()\n");
>  		exit(PTS_FAIL);
>  	}
> 
> -	if (errno != EBADF)
> +	while (aio_error(&aiocb) == EINPROGRESS);
> +	ret = aio_error(&aiocb);
> +	
> +	if (ret != EBADF)
>  	{
>  		printf(TNAME " errno is not EBADF %s\n", strerror(errno));
>  		exit(PTS_FAIL);


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
