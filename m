Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1M9K2i-00089w-TR
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2009 14:23:44 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M9K2f-0005Xh-2s
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2009 14:23:44 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4REDK24007002
	for <ltp-list@lists.sourceforge.net>; Wed, 27 May 2009 10:13:20 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4RENe9B231294
	for <ltp-list@lists.sourceforge.net>; Wed, 27 May 2009 10:23:40 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4RENdLV013217
	for <ltp-list@lists.sourceforge.net>; Wed, 27 May 2009 10:23:39 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A1CB6C7.6070302@cn.fujitsu.com>
References: <4A1CB6C7.6070302@cn.fujitsu.com>
Date: Wed, 27 May 2009 19:53:35 +0530
Message-Id: <1243434215.10447.17.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] ltp: fix typo
	in	testcases/kernel/syscalls/chown/chown03.c
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

On Wed, 2009-05-27 at 11:43 +0800, Wei Yongjun wrote: 
> Fix typo in testcases/kernel/syscalls/chown/chown03.c,
> which use ltpuser->pw_uid in call to setegid() should
> be ltpuser->pw_gid.
> 
> Signed-off-by: Wei Yongjun <yjwei@cn.fujitsu.com>

Thanks.

Regards--
Subrata

> ---
>  testcases/kernel/syscalls/chown/chown03.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/chown/chown03.c b/testcases/kernel/syscalls/chown/chown03.c
> index fde107a..f27cb6f 100644
> --- a/testcases/kernel/syscalls/chown/chown03.c
> +++ b/testcases/kernel/syscalls/chown/chown03.c
> @@ -213,9 +213,9 @@ void setup()
>  	}
> 
>  	ltpuser = getpwnam(nobody_uid);
> -	if (setegid(ltpuser->pw_uid) == -1) {
> +	if (setegid(ltpuser->pw_gid) == -1) {
>  		tst_resm(TINFO, "setegid failed to "
> -			 "to set the effective uid to %d", ltpuser->pw_uid);
> +			 "to set the effective uid to %d", ltpuser->pw_gid);
>  		perror("setegid");
>  	}
>  	if (seteuid(ltpuser->pw_uid) == -1) {


------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
