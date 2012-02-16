Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1Rxrzu-0001h4-U1
	for ltp-list@lists.sourceforge.net; Thu, 16 Feb 2012 03:27:06 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Rxrzq-0006xZ-Nj
	for ltp-list@lists.sourceforge.net; Thu, 16 Feb 2012 03:27:06 +0000
Message-ID: <4F3C7747.4090403@cn.fujitsu.com>
Date: Thu, 16 Feb 2012 11:25:59 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1329360067-14421-1-git-send-email-kai.kang@windriver.com>
In-Reply-To: <1329360067-14421-1-git-send-email-kai.kang@windriver.com>
Subject: Re: [LTP] [PATCH] aio_cancel/3-1: call aio_read before aio_cancel
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Kang Kai <kai.kang@windriver.com>
Cc: ltp-list@lists.sourceforge.net

On 02/16/2012 10:41 AM, Kang Kai wrote:

> The case calls aio_error() with an invalid aiocbp, but it should do
> some asynchronous I/O operations first, so call aio_read() and then
> test the aio_error().


NACK. If so, the error is from aio_read but not from aio_error.
This was discussed long time ago, please refer to the mail archive.

This test case is right, but this FAIL is not hard in POSIX,
so we changed the result from FAIL to UNRESOLVED now.

So, just let it UNRESOLVED. ;)

Thanks
-Wanlong Gao

> 
> Signed-off-by: Kang Kai <kai.kang@windriver.com>
> ---
>  .../conformance/interfaces/aio_error/3-1.c         |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.c
> index 8b6c2f5..6665da1 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.c
> @@ -68,6 +68,9 @@ int main()
>  	aiocb.aio_reqprio = -1;
>  	aiocb.aio_nbytes = BUF_SIZE;
>  
> +	/* Just do aio_read() or aio_write */
> +	aio_read(&aiocb);
> +
>  	ret = aio_error(&aiocb);
>  
>  	if (ret != EINVAL)
> @@ -80,4 +83,4 @@ int main()
>  	close(fd);
>  	printf ("Test PASSED\n");
>  	return PTS_PASS;
> -}
> \ No newline at end of file
> +}



------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
