Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MGHwo-0000dO-Do
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2009 19:34:26 +0000
Received: from [32.97.110.154] (helo=e36.co.us.ibm.com)
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MGHwn-0004Zc-Df
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2009 19:34:26 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5FJEPxx021927
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Jun 2009 13:14:25 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5FJFnxN259816
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Jun 2009 13:15:49 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5FJFnK8004719
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Jun 2009 13:15:49 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <f5a7b3810906120640u7a290abcrd8fa52c36d82f754@mail.gmail.com>
References: <f5a7b3810906120640u7a290abcrd8fa52c36d82f754@mail.gmail.com>
Date: Tue, 16 Jun 2009 00:45:30 +0530
Message-Id: <1245093330.4871.35.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [FIX PATCH] POSIX aio_write/8-2.c
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

On Fri, 2009-06-12 at 19:10 +0530, naresh kamboju wrote: 
> Hi,
> 
> I have noticed failures under
> testcases/open_posix_testsuite/conformance/interfaces/aio_write/8-2.c
> and fixed.
> Please find the patch below and as attachment.
> 
> Best regards
> Naresh Kamboju
> 
> Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >

Done.

Regards--
Subrata

> 
> 
> diff -Naurb a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/8-2.c
> b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/8-2.c
> --- a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/8-2.c	2009-06-12
> 18:10:32.000000000 +0530
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/8-2.c	2009-06-12
> 18:00:21.000000000 +0530
> @@ -42,6 +42,7 @@
>  	char buf[BUF_SIZE];
>  	int fd;
>  	struct aiocb aiocb;
> +	int ret=0;
> 
>  #if _POSIX_ASYNCHRONOUS_IO != 200112L
>  	exit(PTS_UNSUPPORTED);
> @@ -67,13 +68,21 @@
>  	aiocb.aio_buf = buf;
>  	aiocb.aio_nbytes = BUF_SIZE;
> 
> -	if (aio_write(&aiocb) != -1)
> +	/*
> +	 * EBADF is encountered at a later stage
> +	 * and should be collected by aio_error()
> +	 */
> +	
> +	if (aio_write(&aiocb) != 0)
>  	{
>  		printf(TNAME " bad aio_write return value()\n");
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
