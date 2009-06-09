Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1ME60m-0003xV-IT
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2009 18:25:28 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1ME60h-0007Xf-Vr
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2009 18:25:28 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n59IKa8V016611
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2009 14:20:36 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n59IPNJ0253906
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2009 14:25:23 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n59IPMAe005743
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2009 14:25:23 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A2CACC5.6080601@cn.fujitsu.com>
References: <4A2CABFB.3010207@cn.fujitsu.com> <4A2CACC5.6080601@cn.fujitsu.com>
Date: Tue, 09 Jun 2009 23:54:51 +0530
Message-Id: <1244571893.5497.20.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH 2/2] chmod05: fix the effective user when do
	cleanup
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
To: Wei Yongjun <yjwei@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Mon, 2009-06-08 at 14:16 +0800, Wei Yongjun wrote: 
> The TESTDIR is created by root user, but when we do cleanup, the effective
> user had been changed to nobody, so the cleanup will be failed when the
> TESTDIR is removed.
> 
>   chmod05     0  WARN  :  tst_rmdir(): rmobj(/tmp/chmOpEdLA) failed: \
>   remove(/tmp/chmOpEdLA) failed; errno=1: Operation not permitted
> 
> This patch fixed the problem by reset the effective user to root.
> 
> Signed-off-by: Wei Yongjun <yjwei@cn.fujitsu.com>

Thanks for fixing this as well.

Regards--
Subrata

> ---
>  testcases/kernel/syscalls/chmod/chmod05.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/chmod/chmod05.c b/testcases/kernel/syscalls/chmod/chmod05.c
> index c6f1225..252f14e 100644
> --- a/testcases/kernel/syscalls/chmod/chmod05.c
> +++ b/testcases/kernel/syscalls/chmod/chmod05.c
> @@ -266,6 +266,9 @@ void cleanup()
>  	 */
>  	TEST_CLEANUP;
> 
> +	setegid(0);
> +	seteuid(0);
> +
>  	/* Remove tmp dir and all files in it */
>  	tst_rmdir();
> 


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
