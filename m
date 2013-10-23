Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VYy9P-0005Wr-0s
	for ltp-list@lists.sourceforge.net; Wed, 23 Oct 2013 13:07:03 +0000
Date: Wed, 23 Oct 2013 15:06:46 +0200
From: chrubis@suse.cz
Message-ID: <20131023130646.GE24275@rei.Home>
References: <015d01cecfef$962c92c0$c285b840$@gyu.kim@lge.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <015d01cecfef$962c92c0$c285b840$@gyu.kim@lge.com>
Subject: Re: [LTP] [PATCH] getcontext01: check getcontext function in libc
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
>  .../kernel/syscalls/getcontext/getcontext01.c      |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/getcontext/getcontext01.c
> b/testcases/kernel/syscalls/getcontext/getcontext01.c
> index 03b2df9..860d208 100644
> --- a/testcases/kernel/syscalls/getcontext/getcontext01.c
> +++ b/testcases/kernel/syscalls/getcontext/getcontext01.c
> @@ -73,8 +73,12 @@ int main(int ac, char **av)
>  
>  		TEST(getcontext(&ptr));
>  
> -		if (TEST_RETURN == -1)
> -			tst_resm(TFAIL | TTERRNO, "getcontext failed");
> +		if (TEST_RETURN == -1) {
> +			if (errno == ENOSYS)
> +				tst_resm(TCONF, "getcontext is not
> implemented in the current libc");
> +			else
> +				tst_resm(TFAIL | TTERRNO, "getcontext
> failed");
> +		}
>  		else if (TEST_RETURN >= 0)
>  			tst_resm(TPASS, "getcontext passed");
>  

Can you please fix the over 80 chars lines?

In this case I would moved the inner part of the loop (from
TEST(getcontext(&ptr)) to a function called test() and shortened the
TCONF message to simple "getcontext is not implemented".

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
