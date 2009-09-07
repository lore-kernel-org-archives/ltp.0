Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MkYRh-0006G0-Vi
	for ltp-list@lists.sourceforge.net; Mon, 07 Sep 2009 07:15:25 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MkYRc-0001xW-Mr
	for ltp-list@lists.sourceforge.net; Mon, 07 Sep 2009 07:15:25 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8778qoe015949
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Sep 2009 03:08:52 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n877FFLZ254764
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Sep 2009 03:15:15 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n877FEBu024587
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Sep 2009 03:15:14 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4AA4A299.1020105@cn.fujitsu.com>
References: <4AA4A299.1020105@cn.fujitsu.com>
Date: Mon, 07 Sep 2009 12:45:09 +0530
Message-Id: <1252307709.4922.0.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] controller: fix the bug of missing
	compilation	for controller cases
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
To: Shan Wei <shanwei@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net, =?UTF-8?Q?=E7=BC=AA_=E5=8B=B0?= <miaox@cn.fujitsu.com>

On Mon, 2009-09-07 at 14:05 +0800, Shan Wei wrote:
> When doing "./configure && make", I found the controller cases couldn't be compiled.
> 
> Because the config.mk file included into testcases/kernel/Makefile lost the definition
> of LTP_CHECK_CGROUPSTATS_HEADER, so ltp never enters the controller directory to do "make".
> 
> And config.mk file is created by config.mk.in file in fact. In config.mk.in,
> LTP_CHECK_CGROUPSTATS_HEADER is lost, it leads to the wrong config.mk.
> Add LTP_CHECK_CGROUPSTATS_HEADER in config.mk.in to fix the problem.
> 
> 
> Signed-off-by: Miao Xie <miaox@cn.fujitsu.com>
> Signed-off-by: Shan Wei <shanwei@cn.fujitsu.com>

Thanks.

Regards--
Subrata

> ---
>  config.mk.in |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/config.mk.in b/config.mk.in
> index 0fcb80a..64e3847 100644
> --- a/config.mk.in
> +++ b/config.mk.in
> @@ -9,3 +9,5 @@ LDFLAGS = @LDFLAGS@
>  AIO_LIBS = @AIO_LIBS@
>  SELINUX_LIBS = @SELINUX_LIBS@
>  CRYPTO_LIB = @CRYPTO_LIB@
> +
> +LTP_CHECK_CGROUPSTATS_HEADER = @LTP_CHECK_CGROUPSTATS_HEADER@


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
