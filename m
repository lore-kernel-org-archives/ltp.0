Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MfsnE-000349-In
	for ltp-list@lists.sourceforge.net; Tue, 25 Aug 2009 09:58:20 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MfsnA-0000LS-7g
	for ltp-list@lists.sourceforge.net; Tue, 25 Aug 2009 09:58:20 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7P9qVWM018474
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Aug 2009 03:52:31 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7P9w5po226482
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Aug 2009 03:58:07 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7P9w4RR031839
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Aug 2009 03:58:05 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090824.120051.112612549.caiqian@cclom.cn>
References: <20090824.120051.112612549.caiqian@cclom.cn>
Date: Tue, 25 Aug 2009 15:28:03 +0530
Message-Id: <1251194283.5534.21.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH 1/3] Check unshare Function
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
To: CAI Qian <caiqian@cclom.cn>
Cc: ltp-list@lists.sourceforge.net

On Mon, 2009-08-24 at 12:00 +0800, CAI Qian wrote: 
> This patch set fixes several problems for unshare tests. The first one
> is to add a build-time checking for unshare function. The second one is
> to fix unshare01 test,
> 
> * deal with no unshare implementation in both glibc and kernel.
> * simplify logic.
> * fix coding style.
> 
> The final one is to fix unshare02 test,
> 
> * deal with no unshare implementation in both glibc and kernel.
> * fix an incorrect expected result and simplify logic.
> * fix coding style.
> 
> Signed-off-by: CAI Qian <caiqian@cclom.cn>

Thanks Cai.

Regards--
Subrata

> 
>  configure.ac      |    1 +
>  m4/ltp-unshare.m4 |    2 ++
>  2 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index aa7bef4..ca8adc5 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -18,6 +18,7 @@ sys/inotify.h \
>  LTP_CHECK_SYSCALL_EVENTFD
>  LTP_CHECK_SYSCALL_MODIFY_LDT
>  LTP_CHECK_SYSCALL_SIGNALFD
> +LTP_CHECK_SYSCALL_UNSHARE
>  LTP_CHECK_SELINUX
>  LTP_CHECK_CRYPTO
>  LTP_CHECK_TASKSTATS
> diff --git a/m4/ltp-unshare.m4 b/m4/ltp-unshare.m4
> new file mode 100644
> index 0000000..6476141
> --- /dev/null
> +++ b/m4/ltp-unshare.m4
> @@ -0,0 +1,2 @@
> +AC_DEFUN([LTP_CHECK_SYSCALL_UNSHARE],
> +AC_CHECK_FUNCS_ONCE(unshare))
> 
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with 
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
