Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VYyYS-0007N9-Kd
	for ltp-list@lists.sourceforge.net; Wed, 23 Oct 2013 13:32:56 +0000
Date: Wed, 23 Oct 2013 15:32:39 +0200
From: chrubis@suse.cz
Message-ID: <20131023133239.GG24275@rei.Home>
References: <015f01cecff3$2be084e0$83a18ea0$@gyu.kim@lge.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <015f01cecff3$2be084e0$83a18ea0$@gyu.kim@lge.com>
Subject: Re: [LTP] [PATCH v2] getcontext01: check getcontext function in libc
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
To: Honggyu Kim <hong.gyu.kim@lge.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> getcontext function is implemented depends on libc version and arch.
> Some libc version for specific arch does not implement getcontext yet.
> In that case, getcontext just sets errno to ENOSYS and returns -1.
> For example, getcontext is not implemented before libc-2.17 in ARM.
> Current test goes to TFAIL when lower version of libc is used in ARM.
> 
> This patch sets the test as TCONF if libc does not implement getcontext.
> If ENOSYS is not set, it goes to TFAIL as it was.
> 
> Signed-off-by: Honggyu Kim <hong.gyu.kim@lge.com>
> ---
>  .../kernel/syscalls/getcontext/getcontext01.c      |   27
> ++++++++++++--------
>  1 file changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/getcontext/getcontext01.c
> b/testcases/kernel/syscalls/getcontext/getcontext01.c
> index 03b2df9..34724ac 100644
> --- a/testcases/kernel/syscalls/getcontext/getcontext01.c
> +++ b/testcases/kernel/syscalls/getcontext/getcontext01.c
> @@ -54,12 +54,27 @@ int TST_TOTAL = 1;
>  
>  int exp_enos[] = { 0 };		/* must be a 0 terminated list */
>  
> +static void test_getcontext(void)
> +{
> +	ucontext_t ptr;
> +
> +	TEST(getcontext(&ptr));
> +
> +	if (TEST_RETURN == -1) {
> +		if (errno == ENOSYS)
> +			tst_resm(TCONF, "getcontext is not implemented in
> libc");

This line looks like it's line wrapped by your mail client (which
corrupts the patch). Try turning off line wrapping and/or add the patch
attached as a file.

> +		else
> +			tst_resm(TFAIL | TTERRNO, "getcontext failed");
> +	}
> +	else if (TEST_RETURN >= 0)
> +		tst_resm(TPASS, "getcontext passed");
> +}

The prefered style is to have the else on the same line as the closing
curly brace.

As LTP has adopted LKML coding style, you can use chechpatch.pl (which
is shipped in scripts dir with Linux kernel sources) to theck your
patches before submission.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
