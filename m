Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1N2SyN-0008Ui-Mb
	for ltp-list@lists.sourceforge.net; Mon, 26 Oct 2009 17:03:11 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N2SyF-000841-Sf
	for ltp-list@lists.sourceforge.net; Mon, 26 Oct 2009 17:03:11 +0000
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9QGtTVo024463
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Oct 2009 12:55:29 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9QH2vcU027814
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Oct 2009 13:02:58 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n9QH2sNQ020025
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Oct 2009 13:02:54 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4ADE856B.4030509@cn.fujitsu.com>
References: <4ADE856B.4030509@cn.fujitsu.com>
Date: Mon, 26 Oct 2009 22:32:34 +0530
Message-Id: <1256576554.4929.56.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] mem/hugetlb: fix failure of hugemmap03
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
To: liubo <liubo2009@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, 2009-10-21 at 11:52 +0800, liubo wrote: 
> 1)    In mmap's manual,
> The starting address for the new mapping is specified in addr.
> 
> So, if mmap's argument "addr" is reachable, the mmap will
> creates a new mapping in the virtual address space of the
> call-ing process.
> The test hugemmap03 will test that a normal page cannot
>  be mapped into a high memory region. This infers that "addr"
> should be higher for 64-bit mode.
> 
> 
> 2)    The test use "-I2" option, and this not only causes TFAIL's
> loop, but also causes TPASS's loop.
> For TFAIL, loop is deserved, nor for TPASS.
> 
> This patch fixed these problems.
> 
> Signed-off-by: Liu Bo <liubo2009@cn.fujitsu.com>

Thanks.

Regards--
Subrata

> 
> ---
>  testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c
> index 892d24b..a07b9aa 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c
> @@ -55,7 +55,7 @@
>  #include "usctest.h"
> 
>  #define PAGE_SIZE      ((1UL) << 12) 	/* Normal page size */
> -#define HIGH_ADDR      (void *)(0x10000000000)
> +#define HIGH_ADDR      (void *)(0x1000000000000)
> 
>  char* TEMPFILE="mmapfile";
> 
> @@ -130,6 +130,7 @@ main(int ac, char **av)
>  			continue;
>  		} else {
>  			tst_resm(TPASS, "Normal mmap() into high region failed correctly");
> +			break;
>  		}
> 
>  		close(fildes);
> 
> 
> 
> 
> ------------------------------------------------------------------------------
> Come build with us! The BlackBerry(R) Developer Conference in SF, CA
> is the only developer event you need to attend this year. Jumpstart your
> developing skills, take BlackBerry mobile applications to market and stay 
> ahead of the curve. Join us from November 9 - 12, 2009. Register now!
> http://p.sf.net/sfu/devconference
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
