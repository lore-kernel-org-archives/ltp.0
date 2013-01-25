Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1TyjgP-0003yo-K5
	for ltp-list@lists.sourceforge.net; Fri, 25 Jan 2013 13:51:05 +0000
Received: from mail-pa0-f47.google.com ([209.85.220.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1TyjgM-0007Tl-Ca
	for ltp-list@lists.sourceforge.net; Fri, 25 Jan 2013 13:51:05 +0000
Received: by mail-pa0-f47.google.com with SMTP id fa10so273036pad.6
	for <ltp-list@lists.sourceforge.net>;
	Fri, 25 Jan 2013 05:50:56 -0800 (PST)
References: <04824307bb134b47b19291f8e3e100447919c496.1359115534.git.jstancek@redhat.com>
Mime-Version: 1.0 (1.0)
In-Reply-To: <04824307bb134b47b19291f8e3e100447919c496.1359115534.git.jstancek@redhat.com>
Message-Id: <8D6AD52C-0E10-494A-9581-47F2ADA55158@gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Date: Fri, 25 Jan 2013 05:50:54 -0800
Subject: Re: [LTP] [PATCH] aio_fsync/2-1.c: fix race at exit,
	check if write completed
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
To: Jan Stancek <jstancek@redhat.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Error code printing would be helpful...
Thanks,
-Garrett

Sent from my iPhone

On Jan 25, 2013, at 4:15 AM, Jan Stancek <jstancek@redhat.com> wrote:

> This is same issue as:
>  commit 4558bfae923a715ac78b5b3d3ecdfa16f9424808
>  Author: Jan Stancek <jstancek@redhat.com>
>  Date:   Wed Dec 5 12:49:47 2012 +0100
>      aio_read/7-1.c: fix race at exit
> 
> This patch waits for aio_fsync to complete, and after that
> checks that previously queued write is also completed.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
> .../conformance/interfaces/aio_fsync/2-1.c         |   24 ++++++++++++++++---
> 1 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/2-1.c
> index a534513..3a4c7fb 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/2-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/2-1.c
> @@ -27,7 +27,7 @@ int main(void)
> {
>    char tmpfname[256];
>    char buf[BUF_SIZE];
> -    int fd;
> +    int fd, ret;
>    struct aiocb aiocb_write;
>    struct aiocb aiocb_fsync;
> 
> @@ -63,9 +63,25 @@ int main(void)
>        exit(PTS_FAIL);
>    }
> 
> -    close(fd);
> +    /* wait for aio_fsync */
> +    do {
> +        usleep(10000);
> +        ret = aio_error(&aiocb_fsync);
> +    } while (ret == EINPROGRESS);
> 
> -    /* we didn't check if the operation is really performed */
> +    if (aio_return(&aiocb_fsync)) {
> +        printf(TNAME " Error at aio_return()\n");
> +        close(fd);
> +        return PTS_FAIL;
> +    }
> 
> -    return PTS_UNTESTED;
> +    /* check that aio_write is completed at this point */
> +    ret = aio_error(&aiocb_write);
> +    if (ret == EINPROGRESS) {
> +        printf(TNAME " aiocb_write error() : %s\n", strerror(ret));
> +        close(fd);
> +        return PTS_FAIL;
> +    }
> +    close(fd);
> +    return PTS_PASS;
> }
> -- 
> 1.7.1
> 
> 
> ------------------------------------------------------------------------------
> Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
> MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
> with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
> MVPs and experts. ON SALE this month only -- learn more at:
> http://p.sf.net/sfu/learnnow-d2d
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. ON SALE this month only -- learn more at:
http://p.sf.net/sfu/learnnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
