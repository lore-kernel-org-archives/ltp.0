From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 Sep 2020 11:12:17 +0200
Subject: [LTP] [PATCH v2] clock_gettime04: multiply the timediff if test
 in VM
In-Reply-To: <20200915084406.8633-1-liwang@redhat.com>
References: <20200915084406.8633-1-liwang@redhat.com>
Message-ID: <20200915091217.GA6261@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Cyril Hrubis <chrubis@suse.cz>
> ---
>  .../kernel/syscalls/clock_gettime/clock_gettime04.c  | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
> index 2f484c43f..be872d9aa 100644
> --- a/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
> +++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
> @@ -22,6 +22,7 @@ clockid_t clks[] = {
>  };
>  
>  static gettime_t ptr_vdso_gettime, ptr_vdso_gettime64;
> +static long long DELTA = 5;

One minor nit, variables are supposed to be lowercase.

Other than that, Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

>  static inline int do_vdso_gettime(gettime_t vdso, clockid_t clk_id, void *ts)
>  {
> @@ -82,6 +83,11 @@ static struct test_variants {
>  
>  static void setup(void)
>  {
> +	if (tst_is_virt(VIRT_ANY)) {
> +		tst_res(TINFO, "Running in a virtual machine, multiply the DELTA by 10.");
> +		DELTA *= 10;
> +	}
> +
>  	find_clock_gettime_vdso(&ptr_vdso_gettime, &ptr_vdso_gettime64);
>  }
>  
> @@ -143,9 +149,9 @@ static void run(unsigned int i)
>  
>  			diff /= 1000000;
>  
> -			if (diff >= 5) {
> -				tst_res(TFAIL, "%s: Difference between successive readings greater than 5 ms (%d): %lld",
> -					tst_clock_name(clks[i]), j, diff);
> +			if (diff >= DELTA) {
> +				tst_res(TFAIL, "%s: Difference between successive readings greater than %lld ms (%d): %lld",
> +					tst_clock_name(clks[i]), DELTA, j, diff);
>  				return;
>  			}
>  		}
> -- 
> 2.21.3
> 

-- 
Cyril Hrubis
chrubis@suse.cz
