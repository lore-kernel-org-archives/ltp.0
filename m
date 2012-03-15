Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1S86zi-00037f-Mr
	for ltp-list@lists.sourceforge.net; Thu, 15 Mar 2012 09:29:14 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1S86zc-0003LO-K4
	for ltp-list@lists.sourceforge.net; Thu, 15 Mar 2012 09:29:14 +0000
Message-ID: <4F61B620.8010300@cn.fujitsu.com>
Date: Thu, 15 Mar 2012 17:28:00 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <4F61B34B.6040100@redhat.com>
In-Reply-To: <4F61B34B.6040100@redhat.com>
Subject: Re: [LTP] [PATCH v2] io_submit: uninitialized iocb may not return
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

On 03/15/2012 05:15 PM, Jan Stancek wrote:

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


Thanks Jan, I will take this.

Acked-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

> ---
>  testcases/kernel/syscalls/io_submit/io_submit01.c |   15 ++++++++++++++-
>  1 files changed, 14 insertions(+), 1 deletions(-)
> 
> 
> 
> 
> ------------------------------------------------------------------------------
> This SF email is sponsosred by:
> Try Windows Azure free for 90 days Click Here 
> http://p.sf.net/sfu/sfd2d-msazure
> 
> 
> 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list



------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
