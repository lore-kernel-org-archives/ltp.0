Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MGHhN-0008C4-9W
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2009 19:18:29 +0000
Received: from [32.97.110.152] (helo=e34.co.us.ibm.com)
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MGHhM-00088x-Eg
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2009 19:18:29 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e34.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5FJEX83008416
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Jun 2009 13:14:33 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5FJHPkH171510
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Jun 2009 13:17:26 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5FJHOh6009874
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Jun 2009 13:17:25 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A308613.3020707@cn.fujitsu.com>
References: <4A308613.3020707@cn.fujitsu.com>
Date: Tue, 16 Jun 2009 00:46:37 +0530
Message-Id: <1245093397.4871.52.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] chown03: fix the effective user when do cleanup
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

On Thu, 2009-06-11 at 12:20 +0800, Wei Yongjun wrote: 
> The TESTDIR is created by root user, but when we do cleanup, the effective
> user had been changed to nobody, so the cleanup will be failed when the
> TESTDIR is removed.
> 
>   chown03     1  PASS  :  chown() on testfile succeeds, clears setuid/gid bits
>   chown03     0  WARN  :  tst_rmdir(): rmobj(/tmp/choYm1VHD) failed: \
>     remove(/tmp/choYm1VHD) failed; errno=1: Operation not permitted
> 
> This patch fixed the problem by reset the effective user to root.
> 
> Signed-off-by: Wei Yongjun <yjwei@cn.fujitsu.com>

Thanks.

Regards--
Subrata

> ---
>  testcases/kernel/syscalls/chown/chown03.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/chown/chown03.c b/testcases/kernel/syscalls/chown/chown03.c
> index f27cb6f..d2eecd1 100644
> --- a/testcases/kernel/syscalls/chown/chown03.c
> +++ b/testcases/kernel/syscalls/chown/chown03.c
> @@ -267,6 +267,9 @@ void cleanup()
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
