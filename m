Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <bamvor.zhangjian@huawei.com>) id 1YYSvt-0002Go-Ie
	for ltp-list@lists.sourceforge.net; Thu, 19 Mar 2015 05:23:49 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YYSvq-0001mj-KR
	for ltp-list@lists.sourceforge.net; Thu, 19 Mar 2015 05:23:49 +0000
Message-ID: <550A5D4B.5090009@huawei.com>
Date: Thu, 19 Mar 2015 13:23:23 +0800
From: Bamvor Jian Zhang <bamvor.zhangjian@huawei.com>
MIME-Version: 1.0
References: <1426675580-28835-1-git-send-email-bamvor.zhangjian@huawei.com>
In-Reply-To: <1426675580-28835-1-git-send-email-bamvor.zhangjian@huawei.com>
Subject: Re: [LTP] [RFC PATCH 0/3] bugfix for aarch64 ILP32
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
To: ltp-list@lists.sourceforge.net
Cc: Bintian <bintian.wang@huawei.com>, apinski@cavium.com

On 2015/3/18 18:46, Zhang Jian(Bamvor) wrote:
> Hi,
Hi, guys

These series patches should go libc-alpha[1], sorry for confuse.
Here is the right series my want to post[2].

regards

bamvor

[1] https://sourceware.org/ml/libc-alpha/2015-03/msg00586.html
[2] http://sourceforge.net/p/ltp/mailman/ltp-list/thread/1426742198-17967-1-git-send-email-bamvor.zhangjian%40huawei.com/#msg33613777

> This is bamvor from Huawei OS team. We test ILP32 support through
> LTP testcases for both little endian and big endian. There are some
> failures we thought they should be fixed in glibc level, so, here they are.
> 
> Hope these series of patch could help other people who is interested
> in ILP32 in aarch64. We will send another series in LTP mailing list about
> LTP relative patches.
> 
> These work is base on Andrew's ilp32 patch [ilp32 v3 patch]
> [ilp32_glibc_patch].
> 
> The test of build is based on the toolchain built by linaro ABE environment
> [linaro_abe].
> 
> [ilp32 v3 patch] (https://lkml.org/lkml/2014/9/3/704)
> [ilp32_glibc_patch] (https://sourceware.org/ml/libc-alpha/2014-10/msg00596.html)
> [linaro_abe] (https://wiki.linaro.org/ABE)
> 
> Yang Yingliang (3):
>   ARM64: ILP32: change register x1 to PTR_REG
>   ARM64: ILP32: use __fsword_t in generic/bits/statfs.h
>   ARM64: ILP32: change register x##R to PTR_REG (R)
> 
>  sysdeps/aarch64/sysdep.h                      |  2 +-
>  sysdeps/unix/sysv/linux/aarch64/sysdep.h      |  2 +-
>  sysdeps/unix/sysv/linux/generic/bits/statfs.h | 24 ++++++++++++------------
>  3 files changed, 14 insertions(+), 14 deletions(-)
> 



------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
