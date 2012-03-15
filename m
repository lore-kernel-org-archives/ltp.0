Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1S7zDU-0004j6-Ff
	for ltp-list@lists.sourceforge.net; Thu, 15 Mar 2012 01:10:56 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1S7zDT-0005qJ-0C
	for ltp-list@lists.sourceforge.net; Thu, 15 Mar 2012 01:10:56 +0000
Message-ID: <4F61415C.6090201@cn.fujitsu.com>
Date: Thu, 15 Mar 2012 09:09:48 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <4F60B0CC.606@redhat.com>
In-Reply-To: <4F60B0CC.606@redhat.com>
Subject: Re: [LTP] [PATCH] io_submit: uninitialized iocb may not return
	-EINVAL
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net, Jeffrey Burke <jburke@redhat.com>

Hi Jan,

> 
> Testcase 1.3 - EINVAL: uninitialized iocb
> is about submitting uninitialized iocb structure.
> 
> Test is expecting to get -EINVAL, but other values are also
> possible as uninitialized struct can contain any values.
> 
> For example following data fails with -EBADF:
> --- snip ---
> unsigned char bad_iocb[64] = {
>     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>     0x00, 0x00, 0x00, 0x00, 0x00, 0x05, 0x84, 0xa5,
>     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>     0x00, 0x00, 0x0f, 0xff, 0xe0, 0x10, 0x0c, 0x30,
>     0x00, 0x00, 0x0f, 0xff, 0xe0, 0x10, 0x0c, 0x40,
>     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
> memcpy(&iocb, bad_iocb, sizeof(iocb));
> iocbs[0] = &iocb;
> TEST(io_submit(ctx, 1, iocbs));
> check_result(-EINVAL, TEST_RETURN);
> --- snip ---
> 
> This patch accepts also few other errno codes as valid return value.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/kernel/syscalls/io_submit/io_submit01.c |   16 +++++++++++++++-
>  1 files changed, 15 insertions(+), 1 deletions(-)
> 
> 
> 
> 0001-io_submit-uninitialized-iocb-may-not-return-EINVAL.patch
> 
> 
> diff --git a/testcases/kernel/syscalls/io_submit/io_submit01.c b/testcases/kernel/syscalls/io_submit/io_submit01.c
> index da15aa0..3983fa4 100644
> --- a/testcases/kernel/syscalls/io_submit/io_submit01.c
> +++ b/testcases/kernel/syscalls/io_submit/io_submit01.c
> @@ -126,7 +126,21 @@ int main(int argc, char *argv[])
>  		/* 1.3 - EINVAL: uninitialized iocb */
>  		iocbs[0] = &iocb;
>  		TEST(io_submit(ctx, 1, iocbs));
> -		check_result(-EINVAL, TEST_RETURN);
> +		switch(TEST_RETURN) {
> +			case -EINVAL:
> +			case -EBADF:
> +			case -EFAULT:
> +			case -EPERM:


I don't think io_submit(2) can return -EPERM.

Do you think so?

Thanks,
Wanlong Gao

> +				tst_resm(TPASS, "expected failure - "
> +						"returned value = %ld : %s",
> +						TEST_RETURN, strerror(-1 * TEST_RETURN));
> +				break;
> +			default:
> +				tst_resm(TFAIL, "unexpected failure - "
> +						"returned value = %ld : %s, "
> +						"expected one of -EINVAL, -EBADF, -EFAULT, -EPERM",
> +						TEST_RETURN, strerror(-1 * TEST_RETURN));
> +		}
>  
>  		/* 2 - EFAULT: iocb points to invalid data */
>  		TEST(io_submit(ctx, 1, (struct iocb **)-1));
> 
> 



------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
