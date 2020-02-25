From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 25 Feb 2020 13:19:14 +0100
Subject: [LTP] [PATCH] syscalls/pidfd_open: Continue with rest of the
 tests on failure
In-Reply-To: <54a3d6fcef8cfed89a1e4f0b56717f56aa502293.1582611994.git.viresh.kumar@linaro.org>
References: <54a3d6fcef8cfed89a1e4f0b56717f56aa502293.1582611994.git.viresh.kumar@linaro.org>
Message-ID: <20200225121914.GC5077@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

Agree here, also tst_brk(TFAIL, ...) is not working well at this point, see:

https://github.com/linux-test-project/ltp/issues/462

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  .../kernel/syscalls/pidfd_open/pidfd_open02.c    | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c
> index d73b5326b3b1..533270da3dbd 100644
> --- a/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c
> +++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c
> @@ -35,17 +35,15 @@ static void run(unsigned int n)
>  
>  	if (TST_RET != -1) {
>  		SAFE_CLOSE(TST_RET);
> -		tst_brk(TFAIL, "%s: pidfd_open succeeded unexpectedly (index: %d)",
> +		tst_res(TFAIL, "%s: pidfd_open succeeded unexpectedly (index: %d)",
>  			tc->name, n);
> -	}
> -
> -	if (tc->exp_errno != TST_ERR) {
> -		tst_brk(TFAIL | TTERRNO, "%s: pidfd_open() should fail with %s",
> +	} else if (tc->exp_errno != TST_ERR) {
> +		tst_res(TFAIL | TTERRNO, "%s: pidfd_open() should fail with %s",
>  			tc->name, tst_strerrno(tc->exp_errno));
> -	}

Can we please use return instead of the else if branches?

i.e.

	if (...) {
		tst_res(TFAIL, ...);
		return;
	}

> -	tst_res(TPASS | TTERRNO, "%s: pidfd_open() failed as expected",
> -		tc->name);
> +	 } else {
> +		 tst_res(TPASS | TTERRNO, "%s: pidfd_open() failed as expected",
> +			 tc->name);
> +	 }
>  }


-- 
Cyril Hrubis
chrubis@suse.cz
