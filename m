Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MYIpB-0002pj-B0
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 12:09:01 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MYIp4-0005te-O7
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 12:09:01 +0000
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n74C8Scq024208
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Aug 2009 08:08:28 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n74C8jJq2379944
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Aug 2009 08:08:46 -0400
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n74C8gDa007708
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Aug 2009 06:08:42 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <d80b0b476cd86f178e44984647a040bb7d458d75.1249304223.git.monstr@monstr.eu>
References: <1249305859-23722-1-git-send-email-michal.simek@petalogix.com>
	<0f2557dbada823cdbdf1080b36ca0cf41d29c58f.1249304223.git.monstr@monstr.eu>
	<b27f5b6149545ef2a1f3483d14d51d29f83aa7c6.1249304223.git.monstr@monstr.eu>
	<d80b0b476cd86f178e44984647a040bb7d458d75.1249304223.git.monstr@monstr.eu>
Date: Tue, 04 Aug 2009 17:38:17 +0530
Message-Id: <1249387702.15587.36.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH 3/4] fcntl24, 25,
	26: F_SETLEASE and F_WRLCK cannot work	on ramfs
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
To: michal.simek@petalogix.com
Cc: ltp-list@lists.sourceforge.net, monstr@monstr.eu

On Mon, 2009-08-03 at 15:24 +0200, michal.simek@petalogix.com wrote: 
> From: Michal Simek <monstr@monstr.eu>
> 
> The same reason as was in previous patch for tmpfs
> 
> Signed-off-by: Michal Simek <monstr@monstr.eu>

Ok.

Regards--
Subrata

> ---
>  testcases/kernel/syscalls/fcntl/fcntl24.c |    8 ++++++++
>  testcases/kernel/syscalls/fcntl/fcntl25.c |    8 ++++++++
>  testcases/kernel/syscalls/fcntl/fcntl26.c |    8 ++++++++
>  3 files changed, 24 insertions(+), 0 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fcntl/fcntl24.c b/testcases/kernel/syscalls/fcntl/fcntl24.c
> index 1a524bb..af0e814 100644
> --- a/testcases/kernel/syscalls/fcntl/fcntl24.c
> +++ b/testcases/kernel/syscalls/fcntl/fcntl24.c
> @@ -139,6 +139,14 @@ int main(int ac, char **av)
>  			 "Cannot do fcntl on a file located on an TMPFS filesystem");
>  	}
> 
> +	/*
> +	 * check if the current filesystem is ramfs
> +	 */
> +	if (tst_is_cwd_ramfs()) {
> +		tst_brkm(TCONF, cleanup,
> +			 "Cannot do fcntl on a file located on an RAMFS filesystem");
> +	}
> +
>  	/* set the expected errnos... */
>  	TEST_EXP_ENOS(exp_enos);
> 
> diff --git a/testcases/kernel/syscalls/fcntl/fcntl25.c b/testcases/kernel/syscalls/fcntl/fcntl25.c
> index 9957dc4..6e2adc6 100644
> --- a/testcases/kernel/syscalls/fcntl/fcntl25.c
> +++ b/testcases/kernel/syscalls/fcntl/fcntl25.c
> @@ -140,6 +140,14 @@ int main(int ac, char **av)
>  			 "Cannot do fcntl on a file located on an TMPFS filesystem");
>  	}
> 
> +	/*
> +	 * check if the current filesystem is ramfs
> +	 */
> +	if (tst_is_cwd_ramfs()) {
> +		tst_brkm(TCONF, cleanup,
> +			 "Cannot do fcntl on a file located on an RAMFS filesystem");
> +	}
> +
>  	/* set the expected errnos... */
>  	TEST_EXP_ENOS(exp_enos);
> 
> diff --git a/testcases/kernel/syscalls/fcntl/fcntl26.c b/testcases/kernel/syscalls/fcntl/fcntl26.c
> index 5c4f4e4..df22063 100644
> --- a/testcases/kernel/syscalls/fcntl/fcntl26.c
> +++ b/testcases/kernel/syscalls/fcntl/fcntl26.c
> @@ -140,6 +140,14 @@ int main(int ac, char **av)
>  			 "Cannot do fcntl on a file located on an TMPFS filesystem");
>  	}
> 
> +	/*
> +	 * check if the current filesystem is ramfs
> +	 */
> +	if (tst_is_cwd_ramfs()) {
> +		tst_brkm(TCONF, cleanup,
> +			 "Cannot do fcntl on a file located on an RAMFS filesystem");
> +	}
> +
>  	/* set the expected errnos... */
>  	TEST_EXP_ENOS(exp_enos);
> 


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
