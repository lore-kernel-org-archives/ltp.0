Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1VTocZ-0003UF-2m
	for ltp-list@lists.sourceforge.net; Wed, 09 Oct 2013 07:55:51 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VTocX-0007q0-P8
	for ltp-list@lists.sourceforge.net; Wed, 09 Oct 2013 07:55:51 +0000
Date: Wed, 9 Oct 2013 03:55:38 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1444343766.3683031.1381305338134.JavaMail.root@redhat.com>
In-Reply-To: <1380881832-7418-2-git-send-email-maxim.uvarov@linaro.com>
References: <1380881832-7418-1-git-send-email-maxim.uvarov@linaro.com>
	<1380881832-7418-2-git-send-email-maxim.uvarov@linaro.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] LTP cacheflush01 add arm variant
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
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: ltp-list@lists.sourceforge.net, Maxim Uvarov <maxim.uvarov@linaro.com>, linaro-networking@linaro.org



----- Original Message -----
> From: "Maxim Uvarov" <maxim.uvarov@linaro.org>
> To: ltp-list@lists.sourceforge.net
> Cc: linaro-networking@linaro.org, "Maxim Uvarov" <maxim.uvarov@linaro.com>
> Sent: Friday, 4 October, 2013 12:17:12 PM
> Subject: [LTP] [PATCH] LTP cacheflush01 add arm variant
> 
> Cache flush on arm provided via
> __ARM_NR_cacheflush(unsigned long start, unsigned long end, int flags)
> defined in ./arch/arm/kernel/traps.c.
> Flags are not used, providing 0 there.
> 
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.com>

Hi,

looks good to me. I was thinking about getting rid of that ifdef,
but I'm not sure it's worth the trouble for such trivial testcase.

Small nits (related to original code):
- no need for brackets for single statement
- it would be helpful to see the errno in case of failure:
  tst_resm(TFAIL | TTERRNO, "failed with unexpected errno");
- "malloc failed" flags should be TFAIL | TERRNO
- tst_tmpdir()/tst_rmdir() is not needed
- unnecessary comments can be removed

Regards,
Jan

> ---
>  .../kernel/syscalls/cacheflush/cacheflush01.c      |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/cacheflush/cacheflush01.c
> b/testcases/kernel/syscalls/cacheflush/cacheflush01.c
> index 9c02f0a..fae51b4 100644
> --- a/testcases/kernel/syscalls/cacheflush/cacheflush01.c
> +++ b/testcases/kernel/syscalls/cacheflush/cacheflush01.c
> @@ -137,6 +137,14 @@ int main(int ac, char **av)
>  	}
>  
>  	/* Invokes cacheflush() with proper parameters */
> +#if defined(__arm__)
> +	TEST(ltp_syscall(__ARM_NR_cacheflush, addr, addr + getpagesize(), 0));
> +	if (TEST_RETURN == 0) {
> +		tst_resm(TPASS, "passed with no errno");
> +	} else {
> +		tst_resm(TFAIL, "failed with unexpected errno");
> +	}
> +#else
>  	TEST(ltp_syscall(__NR_cacheflush, addr, getpagesize(), ICACHE));
>  	if (TEST_RETURN == 0) {
>  		tst_resm(TPASS, "passed with no errno");
> @@ -157,6 +165,7 @@ int main(int ac, char **av)
>  	} else {
>  		tst_resm(TFAIL, "failed with unexpected errno");
>  	}
> +#endif
>  
>  	cleanup();
>  	tst_exit();
> --
> 1.7.9.5
> 
> 
> ------------------------------------------------------------------------------
> October Webinars: Code for Performance
> Free Intel webinars can help you accelerate application performance.
> Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from
> the latest Intel processors and coprocessors. See abstracts and register >
> http://pubads.g.doubleclick.net/gampad/clk?id=60134791&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
