Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1WFhCs-0007vx-7Y
	for ltp-list@lists.sourceforge.net; Tue, 18 Feb 2014 09:43:14 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WFhCq-0008GH-Cf
	for ltp-list@lists.sourceforge.net; Tue, 18 Feb 2014 09:43:14 +0000
Received: from zmail17.collab.prod.int.phx2.redhat.com
	(zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id s1I9h6tu008217
	for <ltp-list@lists.sourceforge.net>; Tue, 18 Feb 2014 04:43:06 -0500
Date: Tue, 18 Feb 2014 04:43:06 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <956250964.4933831.1392716586384.JavaMail.zimbra@redhat.com>
In-Reply-To: <1d493ab679dd89f48f100209f59cd268bfcceb0d.1389605779.git.jstancek@redhat.com>
References: <1d493ab679dd89f48f100209f59cd268bfcceb0d.1389605779.git.jstancek@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH/RFC] sigaltstack02: avoid using MINSIGSTKSZ
 defined by glibc
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



----- Original Message -----
> From: "Jan Stancek" <jstancek@redhat.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Monday, 13 January, 2014 10:39:51 AM
> Subject: [LTP] [PATCH/RFC] sigaltstack02: avoid using MINSIGSTKSZ defined by	glibc
> 
> The value of MINSIGSTKSZ defined by glibc can be different
> as the value defined by kernel. Recent change for ppc
> is now causing sigaltstack02 to fail:
> https://sourceware.org/ml/libc-alpha/2013-08/msg00093.html
> 
> Use value which is low enough for all kernel versions.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---

Any thoughts/ideas?

Regards,
Jan

>  .../kernel/syscalls/sigaltstack/sigaltstack02.c    |   11 +++++------
>  1 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/sigaltstack/sigaltstack02.c
> b/testcases/kernel/syscalls/sigaltstack/sigaltstack02.c
> index d83aa1f..98c7fd3 100644
> --- a/testcases/kernel/syscalls/sigaltstack/sigaltstack02.c
> +++ b/testcases/kernel/syscalls/sigaltstack/sigaltstack02.c
> @@ -99,13 +99,12 @@ struct test_case_t {		/* test case struct. to hold diff.
> test.conds */
>  } Test_cases[] = {
>  	{
>  	INVAL_FLAGS, SIGSTKSZ, "Invalid Flag value", EINVAL},
> -#ifdef __ia64__
> -	{
> -	0, (131027 - 1), "alternate stack is < MINSIGSTKSZ", ENOMEM},
> -#else
> +	/* use value low enough for all kernel versions
> +	 * avoid using MINSIGSTKSZ defined by glibc as it could be different
> +	 * from the one in kernel ABI
> +	 */
>  	{
> -	0, (MINSIGSTKSZ - 1), "alternate stack is < MINSIGSTKSZ", ENOMEM},
> -#endif
> +	0, (2048 - 1), "alternate stack is < MINSIGSTKSZ", ENOMEM},
>  	{
>  	0, 0, NULL, 0}
>  };
> --
> 1.7.1
> 
> 
> ------------------------------------------------------------------------------
> CenturyLink Cloud: The Leader in Enterprise Cloud Services.
> Learn Why More Businesses Are Choosing CenturyLink Cloud For
> Critical Workloads, Development Environments & Everything In Between.
> Get a Quote or Start a Free Trial Today.
> http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
