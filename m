Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MGIAf-000758-II
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2009 19:48:45 +0000
Received: from [32.97.182.138] (helo=e8.ny.us.ibm.com)
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MGIAe-0007yR-6V
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2009 19:48:45 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5FJ4ouL013636
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Jun 2009 15:04:50 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5FJFTpE245528
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Jun 2009 15:15:29 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5FJFR3Y013878
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Jun 2009 15:15:28 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <f5a7b3810906120628g793d0bd6xea608e96690a70c7@mail.gmail.com>
References: <f5a7b3810906120628g793d0bd6xea608e96690a70c7@mail.gmail.com>
Date: Tue, 16 Jun 2009 00:45:19 +0530
Message-Id: <1245093319.4871.32.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [FIX PATCH] POSIX aio_error/3-1.c
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

On Fri, 2009-06-12 at 18:58 +0530, naresh kamboju wrote: 
> Hi,
> 
> I have noticed failures under
> testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.c
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
> diff -Naurb a/testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.c
> b/testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.c
> --- a/testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.c	2009-06-12
> 18:03:14.000000000 +0530
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.c	2009-06-12
> 18:00:21.000000000 +0530
> @@ -36,29 +36,55 @@
> 
>  int main()
>  {
> -	struct aiocb bad;
> -	int ret;
> +
> +        char tmpfname[256];
> +#define BUF_SIZE 512
> +        char buf[BUF_SIZE];
> +        int fd;
> +        struct aiocb aiocb;
> +	int ret=0;
> 
>  #if _POSIX_ASYNCHRONOUS_IO != 200112L
> -	return PTS_UNSUPPORTED;
> +        exit(PTS_UNSUPPORTED);
>  #endif
> 
> -	memset (&bad, 0, sizeof (struct aiocb));
> +        snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_error_3_1_%d",
> +                  getpid());
> +        unlink(tmpfname);
> +        fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL,
> +                  S_IRUSR | S_IWUSR);
> +        if (fd == -1)
> +        {
> +                printf(TNAME " Error at open(): %s\n",
> +                       strerror(errno));
> +                exit(PTS_UNRESOLVED);
> +        }
> +
> +        unlink(tmpfname);
> +
> +	memset (&aiocb, 0, sizeof (struct aiocb));
> 
> -	ret = aio_error(&bad);
> -	if (ret != -1)
> +        aiocb.aio_fildes = fd;
> +        aiocb.aio_buf = buf;
> +        aiocb.aio_reqprio = -1;
> +        aiocb.aio_nbytes = BUF_SIZE;
> +
> +        if (aio_write(&aiocb) != 0)
>  	{
> -		printf(TNAME " bad aio_error return value; %d\n", ret);
> -		return PTS_FAIL;
> +                printf(TNAME " bad aio_read return value()\n");
> +                exit(PTS_FAIL);
>  	}
> 
> -	if (errno != EINVAL)
> +	while (aio_error (&aiocb) == EINPROGRESS);
> +	ret = aio_error(&aiocb);
> +
> +	if (ret != EINVAL)
>  	{
>  		printf(TNAME " errno is not EINVAL %s\n", strerror(errno));
>  		return PTS_FAIL;
>  	}
> 
> -
> +	close(fd);
>  	printf ("Test PASSED\n");
>  	return PTS_PASS;
>  }


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
