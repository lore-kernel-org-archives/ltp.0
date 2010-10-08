Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <biannm@cn.fujitsu.com>) id 1P47PD-0002VJ-5d
	for ltp-list@lists.sourceforge.net; Fri, 08 Oct 2010 07:30:15 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P47PA-0000gk-UA
	for ltp-list@lists.sourceforge.net; Fri, 08 Oct 2010 07:30:15 +0000
Message-ID: <4CAEC847.6050108@cn.fujitsu.com>
Date: Fri, 08 Oct 2010 15:29:11 +0800
From: Bian Naimeng <biannm@cn.fujitsu.com>
MIME-Version: 1.0
References: <000b01cb6062$9848f210$c8dad630$@co.jp>
In-Reply-To: <000b01cb6062$9848f210$c8dad630$@co.jp>
Subject: Re: [LTP] [PATCH] fix "aio_error" test
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net, =?UTF-8?B?55W25bqnIOWBpeW4gg==?= <toza@ryobi.co.jp>

> Hi,
> 
> 
> "conformance/interfaces/aio_error/3-1" failed with following message:
> ------------
> conformance/interfaces/aio_error/3-1: execution: FAILED: Output: 
> aio_error/3-1.c bad aio_read return value()
> ------------
> 
> This testset seems to be the error root test for "aio_error()".
> Therefore, "aio_error()" must be called after failure of "aio_write()", 
> I think.
> But, "exit()" is called when expected failure of "aio_write()" occurred:
> ------------(3-1.c)
>         if (aio_write(&aiocb) != 0)
>  {
>                 printf(TNAME " bad aio_read return value()\n");
>                 exit(PTS_FAIL);
>  }
> ------------
> 
> I think that "exit()" must be called when "aio_write()" succeeded.
> 

  Agree.

> And the message of unexpected movement of "aio_write()" is 
> "aio_read()"'s one.
> And the indent of this program "3-1.c" seems to include both space and tab.
> I want to revise them, too.
> 
 
  Another one should be fix like this.

	if (ret != EINVAL)
	{
-		printf(TNAME " errno is not EINVAL %s\n", strerror(errno));
+		printf(TNAME " errno is not EINVAL %s\n", strerror(ret));
		return PTS_FAIL;
	}

> 
> Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>
> ============
> ---
> a/testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.c	2010
> -09-22 22:31:24.000000000 +0900
> +++
> b/testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.c	2010
> -09-30 09:51:42.000000000 +0900
> @@ -36,42 +36,41 @@
>  
>  int main()
>  {
> -
> -        char tmpfname[256];
> +	char tmpfname[256];
>  #define BUF_SIZE 512
> -        char buf[BUF_SIZE];
> -        int fd;
> -        struct aiocb aiocb;
> +	char buf[BUF_SIZE];
> +	int fd;
> +	struct aiocb aiocb;
>  	int ret=0;
>  
>  	if (sysconf(_SC_ASYNCHRONOUS_IO) != 200112L)
>  		return PTS_UNSUPPORTED;
>  
> -        snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_error_3_1_%d",
> -                  getpid());
> -        unlink(tmpfname);
> -        fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL,
> -                  S_IRUSR | S_IWUSR);
> -        if (fd == -1)
> -        {
> -                printf(TNAME " Error at open(): %s\n",
> -                       strerror(errno));
> -                exit(PTS_UNRESOLVED);
> -        }
> +	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_error_3_1_%d",
> +			 getpid());
> +	unlink(tmpfname);
> +	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL,
> +			  S_IRUSR | S_IWUSR);
> +	if (fd == -1)
> +	{
> +		printf(TNAME " Error at open(): %s\n",
> +			   strerror(errno));
> +		exit(PTS_UNRESOLVED);
> +	}
>  
> -        unlink(tmpfname);
> +	unlink(tmpfname);
>  
>  	memset (&aiocb, 0, sizeof (struct aiocb));
>  
> -        aiocb.aio_fildes = fd;
> -        aiocb.aio_buf = buf;
> -        aiocb.aio_reqprio = -1;
> -        aiocb.aio_nbytes = BUF_SIZE;
> +	aiocb.aio_fildes = fd;
> +	aiocb.aio_buf = buf;
> +	aiocb.aio_reqprio = -1;
> +	aiocb.aio_nbytes = BUF_SIZE;
>  
> -        if (aio_write(&aiocb) != 0)
> +	if (aio_write(&aiocb) == 0)
>  	{
> -                printf(TNAME " bad aio_read return value()\n");
> -                exit(PTS_FAIL);
> +		printf(TNAME " bad aio_write return value()\n");
> +		exit(PTS_FAIL);
>  	}
>  
>  	while (aio_error (&aiocb) == EINPROGRESS);
> ============
> 
> 
> Regards--
> 
> -Tomonori Mitani
> 
> 
> ------------------------------------------------------------------------
> 
> ------------------------------------------------------------------------------
> Start uncovering the many advantages of virtual appliances
> and start using them to simplify application deployment and
> accelerate your shift to cloud computing.
> http://p.sf.net/sfu/novell-sfdev2dev
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
Regards
Bian Naimeng


------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
