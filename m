Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1Sx7lC-0002j8-Lu
	for ltp-list@lists.sourceforge.net; Fri, 03 Aug 2012 02:37:06 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Sx7lB-0008PY-JF
	for ltp-list@lists.sourceforge.net; Fri, 03 Aug 2012 02:37:06 +0000
Message-ID: <501B3905.1030501@cn.fujitsu.com>
Date: Fri, 03 Aug 2012 10:35:49 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1343269349-24981-1-git-send-email-kai.kang@windriver.com>
In-Reply-To: <1343269349-24981-1-git-send-email-kai.kang@windriver.com>
Subject: Re: [LTP] [PATCH] aio_suspend/3-1: cancel the aio_write operations
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
Cc: ltp-list@lists.sourceforge.net, Zhenfeng.Zhao@windriver.com

On 07/26/2012 10:22 AM, Kang Kai wrote:
> After aio_suspend, call aio_cancel to cancel other aio_write operations
> then wait them to canceld or complete.
> 
> If don't do that, it fails with "Segmentation fault" on routerstation(mips)
> board randomly about in 1000 continuous test. The reason may be some
> aio_writes don't complete before close the file, that cause some resouse
> don't be released and finally cause segment fault.
> 
> Signed-off-by: Kang Kai <kai.kang@windriver.com>
> ---
>  .../conformance/interfaces/aio_suspend/3-1.c       |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/3-1.c
> index 15120e1..49d204a 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/3-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/3-1.c
> @@ -87,6 +87,21 @@ int main()
>  		exit(PTS_FAIL);
>  	}
>  
> +	if (aio_cancel(fd, NULL) == -1) {
> +		printf(TNAME " Error at aio_cancel(): %s\n", strerror(errno));
> +		exit(PTS_FAIL);
> +	}

Try to cancel the pending aio seems useless, how about waiting aios until completed?
Can you test like below?
	
	for (i = 0; i < NAIOCB; i++) {
		do {
			usleep(10000);
			ret = aio_error(&aiocb[i]);
		} while (ret == EINPROGRESS);
		if (ret < 0) {
			printf(TNAME " Error at aio_error() : %s\n", strerror(ret));
			exit(PTS_FAIL);
		}
	}

Thanks,
Wanlong Gao

> +
> +
> +	while (1) {
> +		for (i = 0; i < NAIOCB; ++i) {
> +			if (aio_error(&aiocb[i]) == EINPROGRESS)
> +				break;
> +		}
> +		if (i == NAIOCB)
> +			break;
> +	}
> +
>  	close(fd);
>  	printf("Test PASSED\n");
>  	return PTS_PASS;
> 


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
